# Parameters
# DEBIAN_EXCLUDE_DIRS - a list of subdirectories to exclude from subprojects.
#                       This can be used to exclude specific KDE modules from
#                       the build.

# Shut up cmake about empty subdirectories
cmake_policy(SET CMP0014 OLD)

# Override add_subdirectory() built-in function
function(add_subdirectory subdir)
	# Do not add directory if it's in the DEBIAN_EXCLUDE_DIRS list
	set(add_this_dir 1)
	foreach (dir ${DEBIAN_EXCLUDE_DIRS})
		if (${dir} STREQUAL ${subdir})
			set(add_this_dir 0)
			break()
		endif(${dir} STREQUAL ${subdir})
	endforeach (dir ${DEBIAN_EXCLUDE_DIRS})
	if (add_this_dir)
		_add_subdirectory(${subdir})
	else (add_this_dir)
		# Get directory name
		file(RELATIVE_PATH parent_dir ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
		message(STATUS "${PROJECT_NAME}: excluding directory ${parent_dir}/${subdir}")
	endif (add_this_dir)
endfunction(add_subdirectory)

# Include system FindKDE4.cmake
include("${CMAKE_ROOT}/Modules/FindKDE4.cmake")
