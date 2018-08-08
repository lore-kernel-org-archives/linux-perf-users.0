From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Date: Wed, 8 Aug 2018 13:14:51 -0300
Message-ID: <20180808161451.GD9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
 <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808160843.GC9543@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Aug 08, 2018 at 01:08:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> No need for __packed.
 
> I'm removing that to avoid having this failling in compilers that have
> such a warning, since we default to Werror.
 
> Holler if there is something I'missing :-)

BTW:

  15    68.32 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16   105.45 debian:experimental           : Ok   gcc (Debian 8.2.0-1) 8.2.0
  17    39.76 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  18    18.40 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  19    18.30 debian:experimental-x-mips64  : FAIL mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20    20.58 debian:experimental-x-mipsel  : FAIL mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21    38.90 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22    39.14 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23    38.65 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24    41.29 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25    40.03 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26    17.49 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27    94.44 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28   104.96 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29   107.23 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30   120.34 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180502 (Red Hat 8.1.1-1)

Lets see, different warning, much newer GCC version (8.1.0), and additional
errors in that file, I'll remove the __packed and see whats left, see at the
end, out of curiosity, for  (ARCompact ISA Linux uClibc toolchain 2017.09-rc2),
older compiler (7.1.1) but same warnings/errors:

  18    18.40 debian:experimental-x-mips    : FAIL mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0

  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
In file included from util/s390-cpumsf.c:161:
util/s390-cpumsf-kernel.h:16:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
util/s390-cpumsf-kernel.h:25:15: error: packed attribute causes inefficient alignment for 'CL' [-Werror=attributes]
  unsigned int CL:2;     /* 32-33 Configuration Level  */
               ^~
util/s390-cpumsf-kernel.h:28:21: error: packed attribute causes inefficient alignment for 'ia' [-Werror=attributes]
  unsigned long long ia;     /* Instruction Address   */
                     ^~
util/s390-cpumsf-kernel.h:29:21: error: packed attribute causes inefficient alignment for 'gpp' [-Werror=attributes]
  unsigned long long gpp;     /* Guest Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:30:21: error: packed attribute causes inefficient alignment for 'hpp' [-Werror=attributes]
  unsigned long long hpp;     /* Host Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:34:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
In file included from util/cpumap.h:10,
                 from util/s390-cpumsf.c:150:
util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:233:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_make_event':
util/s390-cpumsf.c:421:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:421:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
  ^~~~~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_samples':
util/s390-cpumsf.c:501:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'off_t' {aka 'long long int'} [-Werror=format=]
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:501:3: note: in expansion of macro 'pr_err'
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_run_decoder':
util/s390-cpumsf.c:610:12: error: format '%ld' expects argument of type 'long int', but argument 6 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~
util/s390-cpumsf.c:610:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
  26    17.49 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
-----------------------------------------------------------------------------------

  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
In file included from util/s390-cpumsf.c:161:0:
util/s390-cpumsf-kernel.h:16:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
util/s390-cpumsf-kernel.h:25:15: error: packed attribute causes inefficient alignment for 'CL' [-Werror=attributes]
  unsigned int CL:2;     /* 32-33 Configuration Level  */
               ^~
util/s390-cpumsf-kernel.h:28:21: error: packed attribute causes inefficient alignment for 'ia' [-Werror=attributes]
  unsigned long long ia;     /* Instruction Address   */
                     ^~
util/s390-cpumsf-kernel.h:29:21: error: packed attribute causes inefficient alignment for 'gpp' [-Werror=attributes]
  unsigned long long gpp;     /* Guest Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:30:21: error: packed attribute causes inefficient alignment for 'hpp' [-Werror=attributes]
  unsigned long long hpp;     /* Host Program Parameter   */
                     ^~~
util/s390-cpumsf-kernel.h:34:15: error: packed attribute causes inefficient alignment for 'def' [-Werror=attributes]
  unsigned int def:16;     /* 0-15  Data Entry Format   */
               ^~~
In file included from util/cpumap.h:10:0,
                 from util/s390-cpumsf.c:150:
util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
          ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
          ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:233:3: note: in expansion of macro 'pr_err'
   pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_make_event':
util/s390-cpumsf.c:421:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
            ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:421:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
  ^~~~~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_samples':
util/s390-cpumsf.c:501:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'off_t {aka long long int}' [-Werror=format=]
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
          ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
util/s390-cpumsf.c:501:3: note: in expansion of macro 'pr_err'
   pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
   ^~~~~~
util/s390-cpumsf.c: In function 's390_cpumsf_run_decoder':
util/s390-cpumsf.c:610:12: error: format '%ld' expects argument of type 'long int', but argument 6 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~
util/s390-cpumsf.c:610:12: error: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
            ^
/git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
 #define pr_fmt(fmt) fmt
                     ^~~
/git/linux/tools/perf/util/debug.h:35:29: note: in expansion of macro 'pr_debugN'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                             ^~~~~~~~~
/git/linux/tools/perf/util/debug.h:35:42: note: in expansion of macro 'pr_fmt'
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~
util/s390-cpumsf.c:610:2: note: in expansion of macro 'pr_debug4'
  pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
  ^~~~~~~~~
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.s390-cpumsf.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/s390-cpumsf.o' failed
make[4]: *** [/tmp/build/perf/util/s390-cpumsf.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD       /tmp/build/perf/util/intel-pt-decoder/libperf-in.o
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[3]: *** [util] Error 2
Makefile.perf:633: recipe for target '/tmp/build/perf/libperf-in.o' failed
make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
Makefile.perf:205: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory '/git/linux/tools/perf'
[root@seventh ~]# 
