Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865884;
	b=fGYeJvNHmw0OvWJbx69VH5JYEig10svaa0DWl/8FGw/7WPhfr3Fie5gOS6prAB6HGIK8
	 VP1NZd3mwTHPI7/RDIRUwvUkrHuqQZK5tQWFH4rO+v+Q4Guml9TpqNzUBUX0lEhsmprsa
	 1EsSHsEqCa22nXO+1O/pQYbUi2zkgS52dEk6KvFLgn/YGJiHJRXqlTqruX2vMFWqhQrT9
	 vL2A79oxbBOzSufzuaHt8w2wY2fh/IqnOYR8Uqlfbg/Dk5jfO14ksWvvIaKJwgMew+pvZ
	 63mwfq9TZFihSKkz+lcR0ZiJ+t5Lv01HBR7RozffMEycsxvKin4K6r5f2pphoV5NMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865884;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=m8VN5kWU/WaBMAF5CI5sVJMqK67u4Zu7I276d8R9Qow=;
	b=1MgtCCXZWmfL0MKW9xiSIY8bcQvSKIKzJ2fCmijpkjRocF4eKko7z3XKktuVOWRBIxoF
	 6U31rUU6s6E/DijXgC+CYHDk4MffqwPWoiwhgSO+u5GEm+LVoIrRYZt0DvBxp99nT8g+a
	 V4Q/t1yWt1HlHw3YXNQ38iArSS8aP5marzfUJQX7dRKTrGcwg9puHIdnJ8O8D/PQpRPej
	 /lAFhsnGTTDcJFcA/nMlg9AKdZRLzR8gIi+ElClFphNH+v8Q0tcKv1FwWlmXyAJXLuTzK
	 BNZtaFgYArhs1WMhHQ4+M7PWLSstHivkBHvy09rC4kl8893I4hDD3xnwy33GhYuVWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=pCRu8Q5N;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 923AD606A31B;
	Thu,  5 Nov 2026 08:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=pCRu8Q5N
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf iostat: Do not compute interval deltas a second time
Date: Thu, 5 Nov 2026 16:04:29 +0800
Message-ID: <20261105080429.2472-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc5.internal.baidu.com (172.31.3.15) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793865878;
	bh=m8VN5kWU/WaBMAF5CI5sVJMqK67u4Zu7I276d8R9Qow=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=pCRu8Q5NrOetd5uevTI0+YZ3YwjAmtzr5wNjyD2na1ozfaA62mCn4o2yoXDjwYL5j
	 WN1o16xwNfh0IwNpB357XeFE68I29iEHs/3JVK5Lz5Gm3T8PxGnHfOear+1lFUc42v
	 U/lVsfz9eCoMkZZYgSMqgHy535zXK1ubc49l4qnU+61FzFjNuujJq+TudluW3Lie6X
	 idld1sL2XXt1MzlYhHDLIXRMcTnjxbkbzxN782xe3/o7ndv0WMrkQ+XmhXzhFSr3RM
	 gz7QdZsOBwLedQmK4FUnBjRdzIbHN9DMlwdKVgIu04YngF/GBQ+NIBmDAKsz9J81xC
	 FMDtR9NlBOmdg==

From: Li RongQing <lirongqing@baidu.com>

process_counter_values() now computes deltas directly in evsel->counts
for global aggregation too. It saves the current cumulative raw count in
prev_raw_counts before iostat prints the interval.

Subtracting prev_raw_counts again can therefore underflow the count.
Worse, replacing the saved raw count with the interval delta corrupts
the baseline used to calculate the next interval.

Use the already computed delta and leave prev_raw_counts untouched.

Fixes: f976bc6b6bfc ("perf stat: Aggregate events using evsel->stats->aggr")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/iostat.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 0cf0f93..fac6b4a 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -434,20 +434,12 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 			 struct perf_stat_output_ctx *out)
 {
 	double iostat_value = 0;
-	u64 prev_count_val = 0;
 	const char *iostat_metric = iostat_metric_by_idx(evsel->core.idx);
 	u8 die = ((struct iio_root_port *)evsel->priv)->die;
 	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
 
 	if (count && count->run && count->ena) {
-		if (evsel->prev_raw_counts && !out->force_header) {
-			struct perf_counts_values *prev_count =
-				perf_counts(evsel->prev_raw_counts, die, 0);
-
-			prev_count_val = prev_count->val;
-			prev_count->val = count->val;
-		}
-		iostat_value = (count->val - prev_count_val) /
+		iostat_value = count->val /
 			       ((double) count->run / count->ena);
 	}
 	out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.0f", iostat_metric,
-- 
2.9.4

