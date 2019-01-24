From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 5/6] perf script python: remove explicit shebang from Python scripts
Date: Wed, 23 Jan 2019 16:52:28 -0800
Message-ID: <20190124005229.16146-6-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

The scripts in scripts/python are intended to be run from 'perf script' and
the Python version used is dictated by how perf was built (PYTHON=).

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer to Python2 and so may not exist on the system (if PYTHON=python3).

- Remove the explicit shebang
- Install the scripts as mode 644

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf                         | 4 ++--
 tools/perf/scripts/python/exported-sql-viewer.py | 1 -
 tools/perf/scripts/python/sched-migration.py     | 2 --
 tools/perf/scripts/python/stat-cpi.py            | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0ee6795d82cc..09df1c8a4ec9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -863,8 +863,8 @@ ifndef NO_LIBPYTHON
 	$(call QUIET_INSTALL, python-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'; \
-		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/python/*.py -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
+		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
+		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
 		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'
 endif
 	$(call QUIET_INSTALL, perf_completion-script) \
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index f278ce5ebab7..c3091401df91 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python2
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index 3473e7f66081..3984bf51f3c5 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python
-#
 # Cpu task migration overview toy
 #
 # Copyright (C) 2010 Frederic Weisbecker <fweisbec@gmail.com>
diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
index 8410672efb8b..a81ad8835a74 100644
--- a/tools/perf/scripts/python/stat-cpi.py
+++ b/tools/perf/scripts/python/stat-cpi.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 
 data    = {}
-- 
2.20.1
