From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 3/6] perf script python: remove explicit shebang from setup.py
Date: Wed, 23 Jan 2019 16:52:26 -0800
Message-ID: <20190124005229.16146-4-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Makefile.perf invokes setup.py via an explicit invocation of python
(PYTHON_WORD) so there is therefore no need for an explicit shebang.

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer only to v2 and so may not exist on the system (if PYTHON=python3).

Signed-off-By: Tony Jones <tonyj@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 64d1f36dee99..d3ffc18424b5 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python
-
 from os import getenv
 from subprocess import Popen, PIPE
 from re import sub
-- 
2.20.1
