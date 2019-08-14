From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/28] perf config: Document the PERF_CONFIG environment variable
Date: Wed, 14 Aug 2019 15:40:26 -0300
Message-ID: <20190814184051.3125-4-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Taeung Song <treeze.taeung@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There was a provision for setting this variable, but not the
getenv("PERF_CONFIG") call to set it, as this was fixed in the previous
cset, document that it can be used to ask for using an alternative
.perfconfig file or to disable reading whatever file exists in the
system or home directory, i.e. using:

  export PERF_CONFIG=/dev/null

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Link: https://lkml.kernel.org/n/tip-0u4o967hsk7j0o50zp9ctn89@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index e4aa268d2e38..c599623a1f3d 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -40,6 +40,10 @@ The '$HOME/.perfconfig' file is used to store a per-user configuration.
 The file '$(sysconfdir)/perfconfig' can be used to
 store a system-wide default configuration.
 
+One an disable reading config files by setting the PERF_CONFIG environment
+variable to /dev/null, or provide an alternate config file by setting that
+variable.
+
 When reading or writing, the values are read from the system and user
 configuration files by default, and options '--system' and '--user'
 can be used to tell the command to read from or write to only that location.
-- 
2.21.0
