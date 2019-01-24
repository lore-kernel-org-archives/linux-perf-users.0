From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 0/6] Fix issues with Python3 scripting
Date: Wed, 23 Jan 2019 16:52:23 -0800
Message-ID: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>
List-Id: linux-perf-users.vger.kernel.org

Seeteena posted, earlier this week, some patches to add Python3 support
to scripts/python/*.py.  Unfortunately there were some issues with these
patches (such as: https://lkml.org/lkml/2019/1/17/351)

Since I already had a tested set of patches in openSUSE:Factory and 
SLE15-SP1 and was about to submit them, Seeteena and I that agreed I 
should post my patches not involving scripts/python/*.py and Seeteena 
will later resubmit the patches for scripts/python/*.py incorporating 
my review feedback under a joint signed-off-by.

It should be noted that the use of "from __future__ import print_function" 
(see: https://lkml.org/lkml/2019/1/16/641) and "except as" (see change to:
tests/attr.py) implies Python2 >= 2.6 as the necessary support has not 
been backported to prior versions.  I am not sure if it's worth detecting 
<2.6 at build time or whether it's sufficiently old as to be a non-issue?

The shebang changes were driven mostly by our build process as it scans
all files within an rpm and the shebangs would result in a rpm requires
on the python2 binary when BuildRequires was python3-devel. I think they 
make sense to apply upstream but understand totally if it's prefered we 
keep them local.

These changes have been tested with PYTHON=python2 (v2.7) and 
PYTHON=python3 (v3.6) on latest openSUSE Tumbleweed.  I did notice that 
test #18 "'import perf' in python" is failing on my system without these 
changes. I'll look at it further but didn't want to hold up Seeteena's 
resubmit.

Tony Jones (6):
  perf script python: Add trace_context extension module to sys,modules
  perf script python: Use PyBytes for attr in trace-event-python
  perf script python: remove explicit shebang from setup.py
  perf script python: remove explicit shebang from tests/attr.c
  perf script python: remove explicit shebang from Python scripts
  perf script python: add Python3 support to tests/attr.py

 tools/perf/Makefile.perf                      |  4 +--
 .../scripts/python/exported-sql-viewer.py     |  1 -
 tools/perf/scripts/python/sched-migration.py  |  2 --
 tools/perf/scripts/python/stat-cpi.py         |  1 -
 tools/perf/tests/attr.py                      | 33 +++++++++++--------
 .../scripting-engines/trace-event-python.c    |  9 ++---
 tools/perf/util/setup.py                      |  2 --
 7 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.1
