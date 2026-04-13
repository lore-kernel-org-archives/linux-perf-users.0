Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1F3806A9
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053580; cv=none; b=EKPSovInDXVfA1VBau176ZdcDHWloNwb3NYXio4mgh83OrHbNs1hfJNVpnbafS6TpmS8ZIAmy+O8uiXZNevPzhavzjHqZHCAytuncl5WAeRpGB/P8wdP9pqyzbUuFnAtx/OkGm8p05Duv4gynAM/p5ZX2d4VHFLeWU7WF7QJF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053580; c=relaxed/simple;
	bh=har6PWz44n64Z/nOCmGTv6uCWfmF5LTdLFTZJWF2aH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s2welHqUdtpAN/2vjPAZ4bzU3tScbZgl1t6+HxkGAjhj3f3QaX+eiKKoe5t9MJn2fAFbjLPfq6OTVRTUT900/0BwYv0nC/mjcpjeavE5H7BT5jR8qOyU680C9HMooKlEt6QyoM+pkmaX4IY2wABgDD0aYRD512SkBq+yftSqlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI5r8pAb; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI5r8pAb"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2cc75e79b97so14279225eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053574; x=1776658374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua2zhmG8fqK0z5FCerxKbCIotrtAFCVPNoRET7C/8tc=;
        b=FI5r8pAbkTHPtwavkzl91ibuV4WpfEKEwAVCCgwg44+D7FIjcfffgWBs2VXWR6Djb6
         IX1uIUYWpXIEzZ655zTEpYLZbgSVRCfI3wVXacVVtw9HvsNDw6Kr0FHNNKLV91xdgCYd
         V1HOy6DLZBogxJ6/SBDA+jzgZyrWQfFV9fhYBKHXo/IrgTSKNWDnaIgmt09n7sNHfM7N
         bGSOjBx7Tty+c7gcgw9T8kHsPAzZySFwX6fjloaIRu9C3Ob/ZphSsXhyWmeDSfZRlpe7
         WwdmHzsMFOme600plcVYlHBEv9A0drQiVZecpdv5SbAuN36xyPOvJMvr2JKRtqOWKYhT
         Qxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053574; x=1776658374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua2zhmG8fqK0z5FCerxKbCIotrtAFCVPNoRET7C/8tc=;
        b=Striwd8MC81IGc0Ig1W/Xx7w6kWhYiZ7QpQHl0HSmshVC2Od49R6snlNJYrcV7feLQ
         aoRurSM+6CiSU3qSaT/02eQVw3gB0xcGINeNXDkXGys+3tUeXz/dwk96ZwzLei/S8KBm
         7RfUOE0PPGp1uS2KDKqcDUzEPHLKfGhagOhfoVvgZU6Lc1AocRwtuATvltY/ra+bNuwv
         8eYx0yp5JGsJg5YlvpSei0tnyWPpO6OHAVPyP/zO6BNgScv23lRNfHl2VD7Z1/FIZSjp
         DAWSLKDOKMloVn9HdjpzBDo70z/pBnZb1fZMzEtxWD2iB1MgECGiQSY4hutz9/xLRN2E
         mzfw==
X-Forwarded-Encrypted: i=1; AFNElJ9iIwoOs2PkIENgWEY2QAjkmh0TigqCspS7SYOVaieG+1gZcCr1uCjZABCp2tXFigiTHlWvyjw4WuguPT1bp1xU@vger.kernel.org
X-Gm-Message-State: AOJu0YywbVP91bDAvpeR9U6sp+Zt7EXd10lx3tdmHrAdy/imUDoTtfpj
	l1wGQBm+X9cFdYaFd1mow/zIo1lhXAJk8h8s+TH9QvIcWYELuVIDhB0KKaDekBylZbV62susSfO
	XW5Pc1WvqEg==
X-Received: from dyt12.prod.google.com ([2002:a05:693c:808c:b0:2d7:37d5:85cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d70e:b0:2cb:de38:c76d
 with SMTP id 5a478bee46e88-2d58a39c931mr6594989eec.30.1776053573784; Sun, 12
 Apr 2026 21:12:53 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:35 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-26-irogers@google.com>
Subject: [PATCH v12 25/33] perf timechart: Fix memory leaks
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

