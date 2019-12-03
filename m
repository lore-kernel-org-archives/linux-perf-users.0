From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/23] perf kvm: Clarify the 'perf kvm' -i and -o command line options
Date: Tue,  3 Dec 2019 10:56:04 -0300
Message-ID: <20191203135606.24902-22-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Steve Dickson <steved@redhat.com>, William Cohen <wcohen@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'perf kvm' subcommand has options that it in turn passes to other
perf subcommands such as 'report' and 'record', particularly -i and -o
end up setting the same variable that will then be used for 'record's -o
and report '-i', which ends up being confusing, leading some to think
that both -i and -o can be used with 'report'.

Improve the man page to state that -i is used with the post-processing
subcommands while -o is used just with 'record' and that to save the
output of 'report' one should simply redirect its output to a file.

Noticed while reading the https://www.linux-kvm.org/page/Perf_events
page.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steve Dickson <steved@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-tclbttvmgtm525fvmh85f7d9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kvm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 6a5bb2b17039..cf95baef7b61 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -68,10 +68,11 @@ OPTIONS
 -------
 -i::
 --input=<path>::
-        Input file name.
+        Input file name, for the 'report', 'diff' and 'buildid-list' subcommands.
 -o::
 --output=<path>::
-        Output file name.
+        Output file name, for the 'record' subcommand. Doesn't work with 'report',
+        just redirect the output to a file when using 'report'.
 --host::
         Collect host side performance profile.
 --guest::
-- 
2.21.0
