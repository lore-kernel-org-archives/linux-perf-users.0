From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/8] perf record: Fix documentation for a inexistent option '-l'
Date: Thu, 19 Oct 2017 14:45:12 -0300
Message-ID: <20171019174515.7407-6-acme@kernel.org>
References: <20171019174515.7407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171019174515.7407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

'perf record' had a '-l' option that meant "scale counter values" a very
long time ago, but it currently belongs to 'perf stat' as '-c'.  So
remove it. I found this problem in the below case.

    $ perf record -e cycles -l sleep 3
      Error: unknown switch `l

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1507907412-19813-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e397453e5a46..63526f4416ea 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -8,8 +8,8 @@ perf-record - Run a command and record its profile into perf.data
 SYNOPSIS
 --------
 [verse]
-'perf record' [-e <EVENT> | --event=EVENT] [-l] [-a] <command>
-'perf record' [-e <EVENT> | --event=EVENT] [-l] [-a] -- <command> [<options>]
+'perf record' [-e <EVENT> | --event=EVENT] [-a] <command>
+'perf record' [-e <EVENT> | --event=EVENT] [-a] -- <command> [<options>]
 
 DESCRIPTION
 -----------
-- 
2.13.6
