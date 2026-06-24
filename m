Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261023E51C8;
	Wed, 24 Jun 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334736; cv=none; b=eEQo2K1AyFF2Z633aZudatXavpznOvU1EZXCqAL6IXWDvY+tYpJjtUMfPt0WFL8fQrf+PaB4DLwcEdxdQK+mCyAcGy8qvBRehHUPX8KC5wLDewqiPQVqhpSGgJ02gRk4Pro7sTTUfZ78DLWXJ4dT0G/kmfQayVeXnH6665K9vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334736; c=relaxed/simple;
	bh=vW5vgJzW6VbffrsI52ciV4/HMmoKPgFAe4Xrg0n52So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyx2+aav8n224sPjeSVPEj2JT8NfaNaK7D3hBW52vfQGGGEIKliAJgWR0ZJuz8Uz3NQlNjrJoUBhgDCDkAT760TtPwGBMezMyKELyVEprBIwoY4tYeCoH4UALDMM57fBGt/7pomfQ6qzg2DrudrptLGUCsPCw6oaX6Yo27lscxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzskP6DB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzskP6DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82AD1F00A3E;
	Wed, 24 Jun 2026 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334735;
	bh=N839jw9SWgaUYVf04ONJUhtRVXvDxViEyzZcCUzWVz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzskP6DB0Myj+3qO6Jlgp0U7h6BHDmxWpnupUCvOX5/pt6H/AbjWok+5FznoLWvP+
	 XyJYln7AiPn3mdLdbF0xKioFecxFBkSLuYn5OEjRtEtUIqBmRb2kbwB19/U+UtOyHN
	 lrn0M7wGZC2m5W64Q5Tid09ZsmcPUpEsCz4dpYFj74EO+gmgb6ykkfTUYXxTnZ6I1U
	 uT0U/JNI5K2v6RjLZ8iKauOtnMzI31ueZawHT6TGQunw9PRW3cGTFDn/IWBEGvOnK3
	 SlkTsCjyId2i3i2ijgfoqaZUbf2f6lXTo/MUmwrMbEKux0i+X8Phug/lff+zTTWK26
	 mUTWXkvA2Ga2A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 4/8] perf timechart: Remove unnecessary copy of backtrace
Date: Wed, 24 Jun 2026 13:58:30 -0700
Message-ID: <20260624205852.3864874-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern of strdup() and free() is found, and I think it just can
use the original backtrace directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 4efac73a714c5e5f..04dbb944a42720b4 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -300,7 +300,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
+	sample->backtrace = backtrace;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -429,12 +429,14 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 	struct per_pid *p;
 	struct wake_event *we = zalloc(sizeof(*we));
 
-	if (!we)
+	if (!we) {
+		free((char *)backtrace);
 		return;
+	}
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace ? strdup(backtrace) : NULL;
+	we->backtrace = backtrace;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -461,20 +463,28 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 			 const char *backtrace)
 {
 	struct per_pid *p = NULL, *prev_p;
+	bool backtrace_used = false;
 
 	prev_p = find_create_pid(tchart, prev_pid);
 
 	p = find_create_pid(tchart, next_pid);
 
-	if (prev_p->current && prev_p->current->state != TYPE_NONE)
+	if (prev_p->current && prev_p->current->state != TYPE_NONE) {
 		pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
 			       prev_p->current->state_since, timestamp,
 			       backtrace);
+		backtrace_used = true;
+	}
 	if (p && p->current) {
-		if (p->current->state != TYPE_NONE)
+		if (p->current->state != TYPE_NONE) {
+			if (backtrace && backtrace_used)
+				backtrace = strdup(backtrace);
+
 			pid_put_sample(tchart, next_pid, p->current->state, cpu,
 				       p->current->state_since, timestamp,
 				       backtrace);
+			backtrace_used = true;
+		}
 
 		p->current->state_since = timestamp;
 		p->current->state = TYPE_RUNNING;
@@ -488,6 +498,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 		if (prev_state == 0)
 			prev_p->current->state = TYPE_WAITING;
 	}
+
+	if (!backtrace_used)
+		free((char *)backtrace);
 }
 
 /*
@@ -655,7 +668,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
-	free((char *)backtrace);
 	return 0;
 }
 
@@ -678,7 +690,6 @@ process_sample_sched_switch(struct timechart *tchart,
 	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
-	free((char *)backtrace);
 	return 0;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

