Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93743CB2FC;
	Tue,  2 Jun 2026 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444655; cv=none; b=aHeLNRTWwE2vnFGcH78eTi9zVJlKA78YZohN9dEerEU/WBc0THEt/+6Zog/X5iFU8QlvV7hU6rR5gdQLKWxRVnj0ukEOq4pnih/syxYDk3Amez1VcTIpHlG0+mQTjTLDLP29LUnO/rXD+CDwzBvPzTm8+BF1qPjRoXrzvNL80No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444655; c=relaxed/simple;
	bh=KZwkJkZjsY/11Do1faVM/vH/2MqM0m1kOtXth5gvPCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKe45FtumBCeSxwREVRU+bEwUNMsVrWmGs3YxcSvYU9WIzgU91TLQDWb45fyQyjP9Fdh+xUYYaW+tyd0oZxVySxYWg64JnpahnUsfBiq4GjOYR1qv+6jmvR2ekIZ5CDcJiGKD3BE8ZkPI2sY9YxS1tjYJXVW0AoCaWBqm+FfA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUqLZjk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUqLZjk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306011F00898;
	Tue,  2 Jun 2026 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444654;
	bh=10fYTi30u0rj6y2S/wsCfMswDglZ5K7K2lvEl1gVHVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUqLZjk/t5PHeMK9ABQBiCLy0lXUcOiZv0utIWHQt2UU93BFI5xApc8ns4qLlqVY9
	 Ku+xV9uwQv6XqYyfnmsbBZJUfJxG1QBx68sJkaN9i7ntxQTjmnF2otlMtIwAlkSXRE
	 UVeJOYNMVXZklNZqwNnLoCqilhXs/fR8utYI/PJJVjwEvQRxsWD2WD+k5sOBrkEH0D
	 OTx82co0PVzs4krlg/9cukLAXQxo4C2M8N6eL/VapSYhW5E1m8rLLIWBNcjo60MO/a
	 7qr8intDkkbMereyP9TJnwo+9NevUlT/T2s5XFEui+LdLKrs1dY32AxmDR08F/eH9m
	 TZQVfq4shNHdQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 3/8] perf sched: Include file offset in event skip messages
Date: Tue,  2 Jun 2026 20:57:02 -0300
Message-ID: <20260602235709.1541603-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
References: <20260602235709.1541603-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add the perf.data file offset to the CPU out-of-bounds and
machine__resolve failure messages emitted when samples are skipped in
process_sched_switch_event(), process_sched_runtime_event(), and
timehist_sched_change_event().  Also switch event type from raw integer
to perf_event__name() string for readability.

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 812a1b0d56d6e5f3..9ec8e049e19b0038 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1792,8 +1792,10 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 	u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
 	    next_pid = perf_sample__intval(sample, "next_pid");
 
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (this_cpu < 0 || this_cpu >= MAX_CPUS) {
-		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", this_cpu);
+		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
+			   sample->file_offset, this_cpu);
 		return 0;
 	}
 
@@ -1819,8 +1821,10 @@ static int process_sched_runtime_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
-		pr_warning("Out-of-bound sample CPU %u. Skipping sample\n", sample->cpu);
+		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %u, skipping sample\n",
+			   sample->file_offset, sample->cpu);
 		return 0;
 	}
 
@@ -2786,15 +2790,18 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	int rc = 0;
 	const char state = perf_sample__taskstate(sample, "prev_state");
 
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
-		pr_warning("Out-of-bound sample CPU %d. Skipping sample\n", sample->cpu);
+		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
+			   sample->file_offset, sample->cpu);
 		return 0;
 	}
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_err("problem processing %d event. skipping it\n",
-		       event->header.type);
+		pr_err("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it\n",
+		       perf_event__name(event->header.type), event->header.type,
+		       sample->file_offset);
 		rc = -1;
 		goto out;
 	}
-- 
2.54.0

