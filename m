From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH] perf: fix documentation of the Flags section in perf.data
Date: Mon, 18 Feb 2019 15:18:46 +0100
Message-ID: <20190218141846.2995-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190217232246.GB26460@krava>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217232246.GB26460@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

According to the current documentation the flags section is placed after
the file header itself but the code assumes to find the flags section
after the data section. This change updates the documentation to that
assumption.
---
 tools/perf/Documentation/perf.data-file-format.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f9a3924830b..593ef49b273c 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,11 +43,10 @@ struct perf_file_section {
 
 Flags section:
 
-The header is followed by different optional headers, described by the bits set
-in flags. Only headers for which the bit is set are included. Each header
-consists of a perf_file_section located after the initial header.
-The respective perf_file_section points to the data of the additional
-header and defines its size.
+For each of the optional features a perf_file_section it placed after the data
+section if the feature bit is set in the perf_header flags bitset. The
+respective perf_file_section points to the data of the additional header and
+defines its size.
 
 Some headers consist of strings, which are defined like this:
 
-- 
2.19.2
