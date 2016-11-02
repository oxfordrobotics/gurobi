if(BUILD_TESTING)
  find_package(Threads MODULE REQUIRED)

  add_library(gurobi SHARED IMPORTED)
  set_target_properties(gurobi PROPERTIES
    IMPORTED_LOCATION "${GUROBI_BINARY_LIBRARY_DIR}/lib${GUROBI_LIBRARY}.so"
    INTERFACE_INCLUDE_DIRECTORIES "${GUROBI_PLATFORM_DIR}/include"
    INTERFACE_LINK_LIBRARIES "${LIBM_LIBRARY};Threads::Threads"
  )

  add_executable(callback_c
    "${GUROBI_PLATFORM_DIR}/examples/c/callback_c.c"
  )
  target_link_libraries(callback_c gurobi)
  add_test(NAME callback_c
    COMMAND callback_c "${GUROBI_PLATFORM_DIR}/examples/data/p0033.mps"
  )

  add_executable(dense_c "${GUROBI_PLATFORM_DIR}/examples/c/dense_c.c")
  target_link_libraries(dense_c gurobi)
  add_test(NAME dense_c COMMAND dense_c)

  add_executable(diet_c "${GUROBI_PLATFORM_DIR}/examples/c/diet_c.c")
  target_link_libraries(diet_c gurobi)
  add_test(NAME diet_c COMMAND diet_c)

  add_executable(facility_c "${GUROBI_PLATFORM_DIR}/examples/c/facility_c.c")
  target_link_libraries(facility_c gurobi)
  add_test(NAME facility_c COMMAND facility_c)

  add_executable(feasopt_c "${GUROBI_PLATFORM_DIR}/examples/c/feasopt_c.c")
  target_link_libraries(feasopt_c gurobi)
  add_test(NAME feasopt_c
    COMMAND feasopt_c "${GUROBI_PLATFORM_DIR}/examples/data/klein1.mps"
  )

  add_executable(fixanddive_c
    "${GUROBI_PLATFORM_DIR}/examples/c/fixanddive_c.c"
  )
  target_link_libraries(fixanddive_c gurobi)
  add_test(NAME fixanddive_c COMMAND fixanddive_c
    "${GUROBI_PLATFORM_DIR}/examples/data/stein9.mps"
  )

  add_executable(lp_c "${GUROBI_PLATFORM_DIR}/examples/c/lp_c.c")
  target_link_libraries(lp_c gurobi)
  add_test(NAME lp_c
    COMMAND lp_c "${GUROBI_PLATFORM_DIR}/examples/data/klein1.mps"
  )

  add_executable(lpmethod_c "${GUROBI_PLATFORM_DIR}/examples/c/lpmethod_c.c")
  target_link_libraries(lpmethod_c gurobi)
  add_test(NAME lpmethod_c
    COMMAND lpmethod_c "${GUROBI_PLATFORM_DIR}/examples/data/afiro.mps"
  )

  add_executable(lpmod_c "${GUROBI_PLATFORM_DIR}/examples/c/lpmod_c.c")
  target_link_libraries(lpmod_c gurobi)
  add_test(NAME lpmod_c COMMAND lpmod_c
    "${GUROBI_PLATFORM_DIR}/examples/data/afiro.mps"
  )

  add_executable(mip1_c "${GUROBI_PLATFORM_DIR}/examples/c/mip1_c.c")
  target_link_libraries(mip1_c gurobi)
  add_test(NAME mip1_c COMMAND mip1_c)

  add_executable(mip2_c "${GUROBI_PLATFORM_DIR}/examples/c/mip2_c.c")
  target_link_libraries(mip2_c gurobi)
  add_test(NAME mip2_c
    COMMAND mip2_c "${GUROBI_PLATFORM_DIR}/examples/data/stein9.mps"
  )

  add_executable(params_c "${GUROBI_PLATFORM_DIR}/examples/c/params_c.c")
  target_link_libraries(params_c gurobi)
  add_test(NAME params_c
    COMMAND params_c "${GUROBI_PLATFORM_DIR}/examples/data/misc07.mps"
  )

  add_executable(piecewise_c "${GUROBI_PLATFORM_DIR}/examples/c/piecewise_c.c")
  target_link_libraries(piecewise_c gurobi)
  add_test(NAME piecewise_c COMMAND piecewise_c)

  add_executable(qcp_c "${GUROBI_PLATFORM_DIR}/examples/c/qcp_c.c")
  target_link_libraries(qcp_c gurobi)
  add_test(NAME qcp_c COMMAND qcp_c)

  add_executable(qp_c "${GUROBI_PLATFORM_DIR}/examples/c/qp_c.c")
  target_link_libraries(qp_c gurobi)
  add_test(NAME qp_c COMMAND qp_c)

  add_executable(sensitivity_c
    "${GUROBI_PLATFORM_DIR}/examples/c/sensitivity_c.c"
  )
  target_link_libraries(sensitivity_c gurobi)
  add_test(NAME sensitivity_c
    COMMAND sensitivity_c "${GUROBI_PLATFORM_DIR}/examples/data/p0033.lp"
  )

  add_executable(sos_c "${GUROBI_PLATFORM_DIR}/examples/c/sos_c.c")
  target_link_libraries(sos_c gurobi)
  add_test(NAME sos_c COMMAND sos_c)

  add_executable(sudoku_c "${GUROBI_PLATFORM_DIR}/examples/c/sudoku_c.c")
  target_link_libraries(sudoku_c gurobi)
  add_test(NAME sudoku_c
    COMMAND sudoku_c "${GUROBI_PLATFORM_DIR}/examples/data/sudoku1"
  )

  add_executable(tsp_c "${GUROBI_PLATFORM_DIR}/examples/c/tsp_c.c")
  target_link_libraries(tsp_c gurobi)
  add_test(NAME tsp_c COMMAND tsp_c 50)

  add_executable(tune_c "${GUROBI_PLATFORM_DIR}/examples/c/tune_c.c")
  target_link_libraries(tune_c gurobi)
  add_test(NAME tune_c
    COMMAND tune_c "${GUROBI_PLATFORM_DIR}/examples/data/p0033.mps"
  )

  add_executable(workforce1_c
    "${GUROBI_PLATFORM_DIR}/examples/c/workforce1_c.c"
  )
  target_link_libraries(workforce1_c gurobi)
  add_test(NAME workforce1_c COMMAND workforce1_c)

  add_executable(workforce2_c
    "${GUROBI_PLATFORM_DIR}/examples/c/workforce2_c.c"
  )
  target_link_libraries(workforce2_c gurobi)
  add_test(NAME workforce2_c COMMAND workforce2_c)

  add_executable(workforce3_c
    "${GUROBI_PLATFORM_DIR}/examples/c/workforce3_c.c"
  )
  target_link_libraries(workforce3_c gurobi)
  add_test(NAME workforce3_c COMMAND workforce3_c)

  add_executable(workforce4_c
    "${GUROBI_PLATFORM_DIR}/examples/c/workforce4_c.c"
  )
  target_link_libraries(workforce4_c gurobi)
  add_test(NAME workforce4_c COMMAND workforce4_c)

  if(WITH_CPP)
    add_library(gurobi_c++ STATIC IMPORTED)
    set_target_properties(gurobi_c++ PROPERTIES
      IMPORTED_LOCATION
        "${GUROBI_BINARY_LIBRARY_DIR}/lib${GUROBI_CPP_LIBRARY}.a"
      INTERFACE_INCLUDE_DIRECTORIES "${GUROBI_PLATFORM_DIR}/include"
      INTERFACE_LINK_LIBRARIES gurobi
    )

    if(GUROBI_PLATFORM STREQUAL mac64)
      set_target_properties(gurobi_c++ PROPERTIES
        INTERFACE_COMPILE_OPTIONS ${GUROBI_CPP_LINK_FLAG}
        INTERFACE_LINK_LIBRARIES "gurobi;${GUROBI_CPP_LINK_FLAG}"
    )
    endif()

    add_executable(callback_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/callback_c++.cpp"
    )
    target_link_libraries(callback_c++ gurobi_c++)
    add_test(NAME callback_c++
      COMMAND callback_c++ "${GUROBI_PLATFORM_DIR}/examples/data/p0033.mps"
    )

    add_executable(dense_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/dense_c++.cpp"
    )
    target_link_libraries(dense_c++ gurobi_c++)
    add_test(NAME dense_c++ COMMAND dense_c++)

    add_executable(diet_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/diet_c++.cpp")
    target_link_libraries(diet_c++ gurobi_c++)
    add_test(NAME diet_c++ COMMAND diet_c++)

    add_executable(facility_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/facility_c++.cpp"
    )
    target_link_libraries(facility_c++ gurobi_c++)
    add_test(NAME facility_c++ COMMAND facility_c++)

    add_executable(feasopt_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/feasopt_c++.cpp"
    )
    target_link_libraries(feasopt_c++ gurobi_c++)
    add_test(NAME feasopt_c++
      COMMAND feasopt_c++ "${GUROBI_PLATFORM_DIR}/examples/data/klein1.mps"
    )

    add_executable(fixanddive_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/fixanddive_c++.cpp"
    )
    target_link_libraries(fixanddive_c++ gurobi_c++)
    add_test(NAME fixanddive_c++
      COMMAND fixanddive_c++ "${GUROBI_PLATFORM_DIR}/examples/data/stein9.mps"
    )

    add_executable(lp_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/lp_c++.cpp")
    target_link_libraries(lp_c++ gurobi_c++)
    add_test(NAME lp_c++ COMMAND lp_c++)

    add_executable(lpmethod_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/lpmethod_c++.cpp"
    )
    target_link_libraries(lpmethod_c++ gurobi_c++)
    add_test(NAME lpmethod_c++ COMMAND lpmethod_c++
      "${GUROBI_PLATFORM_DIR}/examples/data/afiro.mps"
    )

    add_executable(lpmod_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/lpmod_c++.cpp"
    )
    target_link_libraries(lpmod_c++ gurobi_c++)
    add_test(NAME lpmod_c++
      COMMAND lpmod_c++ "${GUROBI_PLATFORM_DIR}/examples/data/afiro.mps"
    )

    add_executable(mip1_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/mip1_c++.cpp")
    target_link_libraries(mip1_c++ gurobi_c++)
    add_test(NAME mip1_c++ COMMAND mip1_c++)

    add_executable(mip2_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/mip2_c++.cpp")
    target_link_libraries(mip2_c++ gurobi_c++)
    add_test(NAME mip2_c++
      COMMAND mip2_c++ "${GUROBI_PLATFORM_DIR}/examples/data/stein9.mps"
    )

    add_executable(params_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/params_c++.cpp"
    )
    target_link_libraries(params_c++ gurobi_c++)
    add_test(NAME params_c++
      COMMAND params_c++ "${GUROBI_PLATFORM_DIR}/examples/data/misc07.mps"
    )

    add_executable(piecewise_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/piecewise_c++.cpp"
    )
    target_link_libraries(piecewise_c++ gurobi_c++)
    add_test(NAME piecewise_c++ COMMAND piecewise_c++)

    add_executable(qcp_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/qcp_c++.cpp")
    target_link_libraries(qcp_c++ gurobi_c++)
    add_test(NAME qcp_c++ COMMAND qcp_c++)

    add_executable(qp_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/qp_c++.cpp")
    target_link_libraries(qp_c++ gurobi_c++)
    add_test(NAME qp_c++ COMMAND qp_c++)

    add_executable(sensitivity_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/sensitivity_c++.cpp"
    )
    target_link_libraries(sensitivity_c++ gurobi_c++)
    add_test(NAME sensitivity_c++
      COMMAND sensitivity_c++ "${GUROBI_PLATFORM_DIR}/examples/data/p0033.lp"
    )

    add_executable(sos_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/sos_c++.cpp")
    target_link_libraries(sos_c++ gurobi_c++)
    add_test(NAME sos_c++ COMMAND sos_c++)

    add_executable(sudoku_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/sudoku_c++.cpp"
    )
    target_link_libraries(sudoku_c++ gurobi_c++)
    add_test(NAME sudoku_c++
      COMMAND sudoku_c++ "${GUROBI_PLATFORM_DIR}/examples/data/sudoku1"
    )

    add_executable(tsp_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/tsp_c++.cpp")
    target_link_libraries(tsp_c++ gurobi_c++)
    add_test(NAME tsp_c++ COMMAND tsp_c++ 50)

    add_executable(tune_c++ "${GUROBI_PLATFORM_DIR}/examples/c++/tune_c++.cpp")
    target_link_libraries(tune_c++ gurobi_c++)
    add_test(NAME tune_c++
      COMMAND tune_c++ "${GUROBI_PLATFORM_DIR}/examples/data/p0033.mps"
    )

    add_executable(workforce1_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/workforce1_c++.cpp"
    )
    target_link_libraries(workforce1_c++ gurobi_c++)
    add_test(NAME workforce1_c++ COMMAND workforce1_c++)

    add_executable(workforce2_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/workforce2_c++.cpp"
    )
    target_link_libraries(workforce2_c++ gurobi_c++)
    add_test(NAME workforce2_c++ COMMAND workforce2_c++)

    add_executable(workforce3_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/workforce3_c++.cpp"
    )
    target_link_libraries(workforce3_c++ gurobi_c++)
    add_test(NAME workforce3_c++ COMMAND workforce3_c++)

    add_executable(workforce4_c++
      "${GUROBI_PLATFORM_DIR}/examples/c++/workforce4_c++.cpp"
    )
    target_link_libraries(workforce4_c++ gurobi_c++)
    add_test(NAME workforce4_c++ COMMAND workforce4_c++)
  endif()

  if(Java_FOUND)
    add_custom_command(OUTPUT Callback.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Callback.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Callback.java"
    )
    add_custom_target(callback_java ALL DEPENDS Callback.class)
    add_test(NAME callback_java
      COMMAND "${Java_JAVA_EXECUTABLE}" Callback "${GUROBI_PLATFORM_DIR}/examples/data/p0033.mps"
    )

    add_custom_command(OUTPUT Dense.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Dense.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Dense.java"
    )
    add_custom_target(dense_java ALL DEPENDS Dense.class)
    add_test(NAME dense_java COMMAND "${Java_JAVA_EXECUTABLE}" Dense)

    add_custom_command(OUTPUT Diet.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Diet.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Diet.java"
    )
    add_custom_target(diet_java ALL DEPENDS Diet.class)
    add_test(NAME diet_java COMMAND "${Java_JAVA_EXECUTABLE}" Diet)

    add_custom_command(OUTPUT Facility.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Facility.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Facility.java"
    )
    add_custom_target(facility_java ALL DEPENDS Facility.class)
    add_test(NAME facility_java COMMAND "${Java_JAVA_EXECUTABLE}" Facility)

    add_custom_command(OUTPUT Feasopt.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Feasopt.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Feasopt.java"
    )
    add_custom_target(feasopt_java ALL DEPENDS Feasopt.class)
    add_test(NAME feasopt_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Feasopt "${GUROBI_PLATFORM_DIR}/examples/data/klein1.mps"
    )

    add_custom_command(
    OUTPUT Fixanddive.class Fixanddive\$1FractionalCompare.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Fixanddive.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Fixanddive.java"
    )
    add_custom_target(fixanddive_java ALL DEPENDS Fixanddive.class)
    add_test(NAME fixanddive_java COMMAND "${Java_JAVA_EXECUTABLE}" Fixanddive)

    add_custom_command(OUTPUT Lp.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Lp.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Lp.java"
    )
    add_custom_target(lp_java ALL DEPENDS Lp.class)
    add_test(NAME lp_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Lp "${GUROBI_PLATFORM_DIR}/examples/data/klein1.mps"
    )

    add_custom_command(OUTPUT Lpmethod.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Lpmethod.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Lpmethod.java"
    )
    add_custom_target(lpmethod_java ALL DEPENDS Lpmethod.class)
    add_test(NAME lpmethod_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Lpmethod "${GUROBI_PLATFORM_DIR}/examples/data/afiro.mps"
    )

    add_custom_command(OUTPUT Lpmod.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Lpmod.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Lpmod.java"
    )
    add_custom_target(lpmod_java ALL DEPENDS Lpmod.class)
    add_test(NAME lpmod_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Lpmod "${GUROBI_PLATFORM_DIR}/examples/data/afiro.mps"
    )

    add_custom_command(OUTPUT Mip1.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Mip1.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Mip1.java"
    )
    add_custom_target(mip1_java ALL DEPENDS Mip1.class)
    add_test(NAME mip1_java COMMAND "${Java_JAVA_EXECUTABLE}" Mip1)

    add_custom_command(OUTPUT Mip2.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Mip2.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Mip2.java"
    )
    add_custom_target(mip2_java ALL DEPENDS Mip2.class)
    add_test(NAME mip2_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Mip2 "${GUROBI_PLATFORM_DIR}/examples/data/stein9.mps"
    )

    add_custom_command(OUTPUT Params.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Params.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Params.java"
    )
    add_custom_target(params_java ALL DEPENDS Params.class)
    add_test(NAME params_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Params "${GUROBI_PLATFORM_DIR}/examples/data/misc07.mps"
    )

    add_custom_command(OUTPUT Piecewise.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Piecewise.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Piecewise.java"
    )
    add_custom_target(piecewise_java ALL DEPENDS Piecewise.class)
    add_test(NAME piecewise_java COMMAND "${Java_JAVA_EXECUTABLE}" Piecewise)

    add_custom_command(OUTPUT Qcp.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Qcp.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Qcp.java"
    )
    add_custom_target(qcp_java ALL DEPENDS Qcp.class)
    add_test(NAME qcp_java COMMAND "${Java_JAVA_EXECUTABLE}" Qcp)

    add_custom_command(OUTPUT Qp.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Qp.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Qp.java"
    )
    add_custom_target(qp_java ALL DEPENDS Qp.class)
    add_test(NAME qp_java COMMAND "${Java_JAVA_EXECUTABLE}" Qp)

    add_custom_command(OUTPUT Sensitivity.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Sensitivity.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Sensitivity.java"
    )
    add_custom_target(sensitivity_java ALL DEPENDS Sensitivity.class)
    add_test(NAME sensitivity_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Sensitivity "${GUROBI_PLATFORM_DIR}/examples/data/p0033.lp"
    )

    add_custom_command(OUTPUT Sos.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Sos.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Sos.java"
    )
    add_custom_target(sos_java ALL DEPENDS Sos.class)
    add_test(NAME sos_java COMMAND "${Java_JAVA_EXECUTABLE}" Sos)

    add_custom_command(OUTPUT Sudoku.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Sudoku.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Sudoku.java"
    )
    add_custom_target(sudoku_java ALL DEPENDS Sudoku.class)
    add_test(NAME sudoku_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Sudoku "${GUROBI_PLATFORM_DIR}/examples/data/sudoku1"
    )

    add_custom_command(OUTPUT Tsp.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Tsp.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Tsp.java"
    )
    add_custom_target(tsp_java ALL DEPENDS Tsp.class)
    add_test(NAME tsp_java COMMAND "${Java_JAVA_EXECUTABLE}" Tsp 50)

    add_custom_command(OUTPUT Tune.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Tune.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Tune.java"
    )
    add_custom_target(tune_java ALL DEPENDS Tune.class)
    add_test(NAME tune_java
      COMMAND
        "${Java_JAVA_EXECUTABLE}" Tune "${GUROBI_PLATFORM_DIR}/examples/data/p0033.mps"
    )

    add_custom_command(OUTPUT Workforce1.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Workforce1.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Workforce1.java"
    )
    add_custom_target(workforce1_java ALL DEPENDS Workforce1.class)
    add_test(NAME workforce1_java COMMAND "${Java_JAVA_EXECUTABLE}" Workforce1)

    add_custom_command(OUTPUT Workforce2.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Workforce2.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Workforce2.java"
    )
    add_custom_target(workforce2_java ALL DEPENDS Workforce2.class)
    add_test(NAME workforce2_java COMMAND "${Java_JAVA_EXECUTABLE}" Workforce2)

    add_custom_command(OUTPUT Workforce3.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Workforce3.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Workforce3.java"
    )
    add_custom_target(workforce3_java ALL DEPENDS Workforce3.class)
    add_test(NAME workforce3_java COMMAND "${Java_JAVA_EXECUTABLE}" Workforce3)

    add_custom_command(OUTPUT Workforce4.class
      COMMAND
        "${Java_JAVAC_EXECUTABLE}" -d "${CMAKE_CURRENT_BINARY_DIR}" -classpath "${GUROBI_BINARY_LIBRARY_DIR}/gurobi.jar" "${GUROBI_PLATFORM_DIR}/examples/java/Workforce4.java"
      DEPENDS "${GUROBI_PLATFORM_DIR}/examples/java/Workforce4.java"
    )
    add_custom_target(workforce4_java ALL DEPENDS Workforce4.class)
    add_test(NAME workforce4_java COMMAND "${Java_JAVA_EXECUTABLE}" Workforce4)
  endif()

  if(Matlab_FOUND)
    matlab_add_unit_test(NAME addpath_gurobi
      CUSTOM_TEST_COMMAND "try,addpath_gurobi;catch ex,disp(getReport(ex,'extended')),exit(1);end;exit"
      TIMEOUT -1
      ADDITIONAL_PATH "${CMAKE_CURRENT_BINARY_DIR}"
      MATLAB_ADDITIONAL_STARTUP_OPTIONS -nojvm
    )
  endif()
endif()
