From: David Ahern <daahern@cisco.com>
Subject: [PATCH 3/5] perf record: add time-of-day option
Date: Sun, 20 Mar 2011 12:54:35 -0600
Message-ID: <1300647277-8431-4-git-send-email-daahern@cisco.com>
References: <1300647277-8431-1-git-send-email-daahern@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300647277-8431-1-git-send-email-daahern@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de, David Ahern <daahern@cisco.com>
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: David Ahern <daahern@cisco.com>
---
 tools/perf/Documentation/perf-record.txt |    4 ++++
 tools/perf/builtin-record.c              |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 5a520f8..b56b5c7 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -116,6 +116,10 @@ OPTIONS
 	Sample timestamps. Use it with 'perf report -D' to see the timestamps,
 	for instance.
 
+--tod::
+	Collect data for time-of-day strings when printing events. This option
+	adds the realtime attribute to samples.
+
 -n::
 --no-samples::
 	Don't sample.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6febcc1..df15256 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,7 @@ static bool			nodelay				=  false;
 static bool			raw_samples			=  false;
 static bool			sample_id_all_avail		=   true;
 static bool			system_wide			=  false;
+static bool			want_tod			=  false;
 static pid_t			target_pid			=     -1;
 static pid_t			target_tid			=     -1;
 static pid_t			child_pid			=     -1;
@@ -214,6 +215,9 @@ static void config_attr(struct perf_evsel *evsel, struct perf_evlist *evlist)
 		attr->sample_type	|= PERF_SAMPLE_CPU;
 	}
 
+	if (want_tod)
+		attr->sample_type |= PERF_SAMPLE_REALTIME;
+
 	if (nodelay) {
 		attr->watermark = 0;
 		attr->wakeup_events = 1;
@@ -764,6 +768,7 @@ const struct option record_options[] = {
 	OPT_BOOLEAN('d', "data", &sample_address,
 		    "Sample addresses"),
 	OPT_BOOLEAN('T', "timestamp", &sample_time, "Sample timestamps"),
+	OPT_BOOLEAN(0, "tod", &want_tod, "Collect data for Time-of-day strings."),
 	OPT_BOOLEAN('n', "no-samples", &no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN('N', "no-buildid-cache", &no_buildid_cache,
-- 
1.7.4
