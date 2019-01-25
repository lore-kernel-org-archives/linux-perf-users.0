From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/29] perf script python: Remove explicit shebang from setup.py
Date: Sat, 26 Jan 2019 00:18:34 +0100
Message-ID: <20190125231843.2895-21-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Makefile.perf invokes setup.py via an explicit invocation of python
(PYTHON_WORD) so there is therefore no need for an explicit shebang.

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer only to v2 and so may not exist on the system (if PYTHON=python3).

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190124005229.16146-4-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
