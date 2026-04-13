Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB91279334
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043408; cv=none; b=gwyTYwREIDVtU0FGyPMYiKp/FQB2rp0rv24hPCqKexCmZuSWsYQYPv43IdhRxfnbIndxm3GNRChlPCmT3A7IBpposLR9GGdZUfnY37z6S9MaGakYtBIr34sgAuXtlW0KyWyQN0KmLCa5651dz7r5Ctcq7KkS7tZbdZuPLArlqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043408; c=relaxed/simple;
	bh=har6PWz44n64Z/nOCmGTv6uCWfmF5LTdLFTZJWF2aH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EopJ+zOpsmtwfSkEW7mHnorG72o7eBT388aHq4PCZG7pjm2Uj82eQhFoW5BJD79y3ewudGaVpb84E+EgRvInlfhyfgusmhMaTpX9bI0NbIzqkXTyZgvcyZJrSacyPGJPE6i4C1dy3ErnyIOT968YaxL5GDqCjz/6pZTnP6OuW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3kMXnze; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3kMXnze"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso6994668a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043407; x=1776648207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua2zhmG8fqK0z5FCerxKbCIotrtAFCVPNoRET7C/8tc=;
        b=l3kMXnze0Q+fq2bbT6yf4G6edCeRpYoE8AzKTvNKozBoWC8HolLXVszwaB2+9OQNct
         7AniNcNfgDnuY+FUnzwwF4AqkncsVhcPupVpaLL0HyaWyc13hATcgyjy8ebKLudI2BLE
         SEY8e3nr8+kwjox3avMndIIp+VeoVSu26ccI56fCCWKkzX7snMz08KavVQi0ggiflYTo
         04TyHDFy18SKCvvnc9JmPVypQqaLV4C6bntn6vpPQZbly8FVW0tkJLVtclQPyc8YUJ9y
         YijK1YfcHsDMSO+a3wMcGGVQS74gap4B83Ei0QQG5T5lPUc4CJ7oE6X27iVG3/OB2Hp4
         BMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043407; x=1776648207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua2zhmG8fqK0z5FCerxKbCIotrtAFCVPNoRET7C/8tc=;
        b=BMmvvOuCT+VwucgwHjtFVgeEqVfr43+94rqSdK0hFFrks1T1tnTKtxJ14qxKTs6e1d
         cgoZzdAsNFmuU6PgcLajnpHE+XzRyKTpnygviULb5TuRj+w41/mHNfk6IigXIK2v+UAq
         eP5QpNo81Ksije88RGQY6ZweBDb6QdBT6mqU6Rcvp00DqSpVuhfKtcK8CG4k2kQpVd4T
         B33yfndYvQxCAdyGxkXZhTIr8rrPV0fzl9UmdR9k/Oy4ZI7a5+wdcZBRD/r5KI42afjV
         +eYEbULsYuBoebB5SU9HjZnY+qsDUZXvnHs9NLp8xE590zrPkErGEpcFYTntR+qbQoMW
         0dRA==
X-Forwarded-Encrypted: i=1; AFNElJ/35WhZokqoriRCVJYflq/4B+27la1k1AnX47GaofCgvZenjIFPulmydnUaV2WruzrRAMzTCGTkYHuRi3eMNeBe@vger.kernel.org
X-Gm-Message-State: AOJu0YybHEz0kSxp1RZAV4abW3apBAVqs8yrtCQdOYhKktfRJgmLunK/
	0MqbZDJgRkYa+cJJwMpwJNTRP2QvQ2vFG8w1M0Q+byOIRw9a18+xfu0Bdt9tcbXVuRz4n8/zCeI
	TZ1QoSbeW3g==
X-Received: from pjug23.prod.google.com ([2002:a17:90a:ce97:b0:35c:1a37:ace])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:118f:b0:35e:5aa5:ae38
 with SMTP id 98e67ed59e1d1-35e5aa5b2ecmr2427534a91.9.1776043406502; Sun, 12
 Apr 2026 18:23:26 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:19 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-26-irogers@google.com>
Subject: [PATCH v11 25/33] perf timechart: Fix memory leaks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Fix missing free from cat_backtrace, which requires copies of the
backtrace being made in functions that save it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1d24d8738519..64f69bd67c6b 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -299,7 +299,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace;
+	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -433,7 +433,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace;
+	we->backtrace = backtrace ? strdup(backtrace) : NULL;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -489,9 +489,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 	}
 }
 
-static const char *cat_backtrace(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine)
+static char *cat_backtrace(union perf_event *event,
+			   struct perf_sample *sample,
+			   struct machine *machine)
 {
 	struct addr_location al;
 	unsigned int i;
@@ -544,8 +544,10 @@ static const char *cat_backtrace(union perf_event *event,
 				 * It seems the callchain is corrupted.
 				 * Discard all.
 				 */
-				zfree(&p);
-				goto exit;
+				addr_location__exit(&al);
+				fclose(f);
+				free(p);
+				return NULL;
 			}
 			continue;
 		}
@@ -577,6 +579,7 @@ static int process_sample_event(const struct perf_tool *tool,
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
+	int ret = 0;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
@@ -587,11 +590,13 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
+		char *backtrace = cat_backtrace(event, sample, machine);
 
-		return f(tchart, sample, cat_backtrace(event, sample, machine));
+		ret = f(tchart, sample, backtrace);
+		free(backtrace);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.53.0.1213.gd9a14994de-goog

