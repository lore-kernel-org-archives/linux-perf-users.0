From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 4/6] perf script python: remove explicit shebang from tests/attr.c
Date: Wed, 23 Jan 2019 16:52:27 -0800
Message-ID: <20190124005229.16146-5-tonyj@suse.de>
References: <20190124005229.16146-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124005229.16146-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

tests/attr.c invokes attr.py via an explicit invocation of Python ($PYTHON)
so there is therefore no need for an explicit shebang.

Also most distros follow pep-0394 which recommends that /usr/bin/python
refer only to v2 and so may not exist on the system (if PYTHON=python3).

Signed-off-By: Tony Jones <tonyj@suse.de>
Cc:  Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/tests/attr.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 44090a9a19f3..3e07eee33b10 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python
 # SPDX-License-Identifier: GPL-2.0
 
 import os
-- 
2.20.1
