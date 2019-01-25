From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 0/6] Fix issues with Python3 scripting
Date: Fri, 25 Jan 2019 13:31:19 +0100
Message-ID: <20190125123119.GD12077@kernel.org>
References: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Jan 23, 2019 at 04:52:23PM -0800, Tony Jones escreveu:
> Seeteena posted, earlier this week, some patches to add Python3 support
> to scripts/python/*.py.  Unfortunately there were some issues with these
> patches (such as: https://lkml.org/lkml/2019/1/17/351)
> 
> Since I already had a tested set of patches in openSUSE:Factory and 
> SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
> should post my patches not involving scripts/python/*.py and Seeteena 
> will later resubmit the patches for scripts/python/*.py incorporating 
> my review feedback under a joint signed-off-by.
> 
> It should be noted that the use of "from __future__ import print_function" 
> (see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
> tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
> been backported to prior versions.  I am not sure if it's worth detecting 
> <2.6 at build time or whether it's sufficiently old as to be a non-issue?
> 
> The shebang changes were driven mostly by our build process as it scans
> all files within an rpm and the shebangs would result in a rpm requires
> on the python2 binary when BuildRequires was python3-devel. I think they 
> make sense to apply upstream but understand totally if it's prefered we 
> keep them local.
> 
> These changes have been tested with PYTHON=python2 (v2.7) and 
> PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
> test #18 "'import perf' in python" is failing on my system without these 
> changes. I'll look at it further but didn't want to hold up Seeteena's 
> resubmit.

So it fails on AmazonLinux 1, that has python 2.6, please check if this
is something we can workaround, if its difficult, I'll just use
NO_PYTHON=1 there to disable it.

  CC       /tmp/build/perf/util/parse-branch-options.o
util/scripting-engines/trace-event-python.c: In function 'python_start_script':
util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
  PyImport_AppendInittab("perf_trace_context", initfunc);
  ^
In file included from /usr/include/python2.6/Python.h:130:0,
                 from util/scripting-engines/trace-event-python.c:22:
/usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
 PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
                 ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1
