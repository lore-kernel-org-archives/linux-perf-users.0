From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/13] perf annotate: Document --show-total-period option
Date: Mon, 21 Aug 2017 16:25:47 -0300
Message-ID: <20170821192549.17251-12-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

When the --show-total-period option was introduced we forgot to add an
entry in the man page, fix it.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Fixes: 0c4a5bcea460 ("perf annotate: Display total number of samples with --show-total-period")
Link: http://lkml.kernel.org/r/1503046013-5555-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 2a5975c91cbd..c635eab6af54 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -92,6 +92,8 @@ OPTIONS
 --asm-raw::
 	Show raw instruction encoding of assembly instructions.
 
+--show-total-period:: Show a column with the sum of periods.
+
 --source::
 	Interleave source code with assembly code. Enabled by default,
 	disable with --no-source.
-- 
2.13.5
