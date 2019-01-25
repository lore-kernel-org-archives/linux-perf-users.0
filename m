From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Date: Fri, 25 Jan 2019 14:57:30 +0100
Message-ID: <20190125135730.GE12077@kernel.org>
References: <20190124005229.16146-1-tonyj@suse.de>
 <20190125123119.GD12077@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125123119.GD12077@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jan 25, 2019 at 01:31:19PM +0100, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones escreveu:
> > Seeteena posted, earlier this week, some patches to add Python3 support
> > to scripts/python/*.py.  Unfortunately there were some issues with these
> > patches (such as: https://lkml.org/lkml/2019/1/17/351)
> > 
> > Since I already had a tested set of patches in openSUSE:Factory and 
> > SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
> > should post my patches not involving scripts/python/*.py and Seeteena 
> > will later resubmit the patches for scripts/python/*.py incorporating 
> > my review feedback under a joint signed-off-by.
> > 
> > It should be noted that the use of "from __future__ import print_function" 
> > (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
> > tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
> > been backported to prior versions.  I am not sure if it's worth detecting 
> > <2.6 at build time or whether it's sufficiently old as to be a non-issue?
> > 
> > The shebang changes were driven mostly by our build process as it scans
> > all files within an rpm and the shebangs would result in a rpm requires
> > on the python2 binary when BuildRequires was python3-devel. I think they 
> > make sense to apply upstream but understand totally if it's prefered we 
> > keep them local.
> > 
> > These changes have been tested with PYTHON=python2 (v2.7) and 
> > PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
> > test #18 "'import perf' in python" is failing on my system without these 
> > changes. I'll look at it further but didn't want to hold up Seeteena's 
> > resubmit.
> 
> So it fails on AmazonLinux 1, that has python 2.6, please check if this
> is something we can workaround, if its difficult, I'll just use
> NO_PYTHON=1 there to disable it.
> 
>   CC       /tmp/build/perf/util/parse-branch-options.o
> util/scripting-engines/trace-event-python.c: In function 'python_start_script':
> util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
>   PyImport_AppendInittab("perf_trace_context", initfunc);
>   ^
> In file included from /usr/include/python2.6/Python.h:130:0,
>                  from util/scripting-engines/trace-event-python.c:22:
> /usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
>  PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
>                  ^
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
> make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1

I did a quick hack to init an auto variable with that const string and
then pass it, is passing everything so far:

$ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : Ok   gcc (Alpine 8.2.0) 8.2.0
   7 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9 android-ndk:r12b-arm          : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  10 android-ndk:r15c-arm          : Ok   gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
  11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  14 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 8.2.1 20180502
  15 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.2.0-13) 8.2.0
  19 debian:experimental-x-arm64   : Ok   gcc (Debian 8.2.0-13) 8.2.0
  20 debian:experimental-x-mips    : Ok   gcc (Debian 8.2.0-13) 8.2.0
  21 debian:experimental-x-mips64  : Ok   gcc (Debian 8.2.0-13) 8.2.0
  22 debian:experimental-x-mipsel  : Ok   gcc (Debian 8.2.0-13) 8.2.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26: fedora:24
