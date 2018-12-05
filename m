From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf, tools: Support srccode output
Date: Wed, 5 Dec 2018 19:15:49 -0300
Message-ID: <20181205221549.GC13522@kernel.org>
References: <20181204001848.24769-1-andi@firstfloor.org>
 <20181205122838.GH2950@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205122838.GH2950@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Dec 05, 2018 at 01:28:38PM +0100, Jiri Olsa escreveu:
> On Mon, Dec 03, 2018 at 04:18:48PM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > When looking at PT or brstackinsn traces with perf script
> > it can be very useful to see the source code. This adds a simple
> > facility to print them with perf script, if the information
> > is available through dwarf
> > 
> > % perf record ...
> > % perf script -F insn,ip,sym,srccode
> > ...
> > 
> >           4004c6 main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004c6 main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004cd main
> > 5               for (i = 0; i < 10000000; i++)
> >            4004b3 main
> > 6                       v++;
> > 
> > % perf record -b ...
> > % perf script -F insn,ip,sym,srccode,brstackinsn
> > 
> > ...
> >        main+22:
> >         0000000000400543        insn: e8 ca ff ff ff            # PRED
> > |18                     f1();
> >         f1:
> >         0000000000400512        insn: 55
> > |10       {
> >         0000000000400513        insn: 48 89 e5
> >         0000000000400516        insn: b8 00 00 00 00
> > |11             f2();
> >         000000000040051b        insn: e8 d6 ff ff ff            # PRED
> >         f2:
> >         00000000004004f6        insn: 55
> > |5        {
> >         00000000004004f7        insn: 48 89 e5
> >         00000000004004fa        insn: 8b 05 2c 0b 20 00
> > |6              c = a / b;
> >         0000000000400500        insn: 8b 0d 2a 0b 20 00
> >         0000000000400506        insn: 99
> >         0000000000400507        insn: f7 f9
> >         0000000000400509        insn: 89 05 29 0b 20 00
> >         000000000040050f        insn: 90
> > |7        }
> >         0000000000400510        insn: 5d
> >         0000000000400511        insn: c3                        # PRED
> >         f1+14:
> >         0000000000400520        insn: b8 00 00 00 00
> > |12             f2();
> >         0000000000400525        insn: e8 cc ff ff ff            # PRED
> >         f2:
> >         00000000004004f6        insn: 55
> > |5        {
> >         00000000004004f7        insn: 48 89 e5
> >         00000000004004fa        insn: 8b 05 2c 0b 20 00
> > |6              c = a / b;
> > 
> > Not supported for callchains currently, would need some
> > layout changes there.
> 
> nice, works nicely, especialy with --xed
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Trying to fix this:

alpine:3.4
Downloading http://x.x.x.x/perf/perf-4.20.0-rc3.tar.xz...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1426k  100 1426k    0     0   232M      0 --:--:-- --:--:-- --:--:--  232M
8932875925270caf72895c32013a678e9c19aa0d
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-alpine-linux-musl/5.3.0/lto-wrapper
Target: x86_64-alpine-linux-musl
Configured with: /home/buildozer/aports/main/gcc/src/gcc-5.3.0/configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --target=x86_64-alpine-linux-musl --with-pkgversion='Alpine 5.3.0' --enable-checking=release --disable-fixed-point --disable-libstdcxx-pch --disable-multilib --disable-nls --disable-werror --disable-symvers --enable-__cxa_atexit --enable-esp --enable-cloog-backend --enable-languages=c,c++,objc,java,fortran,ada --disable-libssp --disable-libmudflap --disable-libsanitizer --enable-shared --enable-threads --enable-tls --with-system-zlib
Thread model: posix
gcc version 5.3.0 (Alpine 5.3.0)
  CC       /tmp/build/perf/util/srccode.o
In file included from util/srccode.c:19:0:
/usr/include/sys/fcntl.h:1:2: error: #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h> [-Werror=cpp]
 #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
  ^
  CC       /tmp/build/perf/util/data.o
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/util/.srccode.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/srccode.o' failed
make[4]: *** [/tmp/build/perf/util/srccode.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/tests/attr.o
