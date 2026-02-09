Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6138F220
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658880; cv=none; b=Ke6sN7S2OlE7R6kWNW4ABu/d6mBf/myo0EoZZ0lRoYY8ZGV7Fm/+HusUh/8bdWBTEcoWJHleqyb1DKzIFiClIewnjYcOgC/LiI+Hg4SV73vutytAx2sd1EL12ysT8d7XPkLC1lqLdTJ1RFtBu2f9he0wRLYGC14v8lOU6kz4eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658880; c=relaxed/simple;
	bh=MzCMUvXhmBryqIwMYn7rRj8P3JAKVugjSx7E9EUBNEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qgcgZoY1DTlwYD3QG8O6FC+iAluUv5OzFgOFPw0qh/MmOzFfEUYJaei6LLplfuOKuMyg5GR6synDt+Fs3CifSh0D+/JSS9LhesiobKQoEY8P1RXVdeCz27GxK6xF66yGQZbiMEFO1mAP2pYGBJ4GaOWHhvGRUcBZKcx2PwgGm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrGdh+KO; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrGdh+KO"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124627fc58dso7500571c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658879; x=1771263679; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NKgpa+d3dNYoS1EWG0BNepes/WG+gnWoeIPZ97YIX4=;
        b=VrGdh+KO6rSccmXUxRIQn+rntpMdhkrCZCEgQ1o9NFaMMvj94CpkW6uZgTTS6EZgOA
         3wKcQnFKrEMk3LBnmh7WxznevzyNc1fsvDkQip03XDrthK4bwo/RGrwvCn4U0IcQ7/04
         uWgE/6Xz+7bJjLvwwh9RjjvYbTY7tMkUsS/9QHSBeYdtEvLT2U75DFJgteEQLviUl2oh
         eRDREGKMEP1lC7wr0fDiT7AsnnmDrRG2OmSWwj9Ot6njlRlGrWleyo+f9Ube6soxkwqa
         trqrVigr+zxAkYFumc4o9zpGJ0DYYdJGVGgCa7DEJmskUHBwteVDDLmV8vd47kp05FHr
         8/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658879; x=1771263679;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NKgpa+d3dNYoS1EWG0BNepes/WG+gnWoeIPZ97YIX4=;
        b=fLwGo71530H3DnBorV344YOIJWVHEepccZZUQOXbe6AuYYTgkXuQd06PSIy0D4QXRf
         4rBHCzqvnlISpN4RD9s/WBWN1mtnUUnDiiPQCBPqq0YXLbf5BDPzVAe0JGdS5LaWN3+d
         AyeZ+PF3Lu0MNv1YjgCwzAQbc9GZJc/RpVJcKUqisi1AZRseRDWBpgRyfivktwnSBjs/
         fxfOlaNdlWP7BON59+E8uCVF88HVoXWex5XxPzZE//OtHoxuFN/D54dEzrggQ9vCuwXW
         hLXDEtkQO/rk0tY7LIpkfzvsunAGVo5fCxMTkcr3rCRi7l4MeFWCCUbami1Q/BqkM8f6
         EHLw==
X-Forwarded-Encrypted: i=1; AJvYcCUPMC+TH67/n1DhT+bcp/oRDlkt/x5+qZPpLbnki/Byl7i0YybMAq7UQV4/uMb2cTVbnvdPpbsTP3n5w7HJZKS/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wp6wRDOwkM6dVvsnE0nWPuQqt47qwk9AKMYgzo7MWLLwjxci
	XWtJoIUHTlOeU4z5b1fof10CfALb2WhaXDAKIbzJnYWBn5QeUDmXHP2Fifu8bp5KgFOmsEApY57
	SMbS/u+A1+w==
X-Received: from dlbou24.prod.google.com ([2002:a05:7022:1118:b0:11d:cde5:d78e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:419c:b0:119:e56b:98bf
 with SMTP id a92af1059eb24-12704059fc5mr5538242c88.38.1770658879285; Mon, 09
 Feb 2026 09:41:19 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:24 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-18-irogers@google.com>
Subject: [PATCH v1 17/25] perf kmem: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 19b12209fc08..ea2437971e8b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -171,7 +171,7 @@ static int insert_caller_stat(unsigned long call_site,
 	return 0;
 }
 
-static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_alloc_event(struct perf_sample *sample)
 {
 	unsigned long ptr = perf_sample__intval(sample, "ptr"),
 		      call_site = perf_sample__intval(sample, "call_site");
@@ -198,7 +198,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 	 * If the tracepoint contains the field "node" the tool stats the
 	 * cross allocation.
 	 */
-	if (evsel__field(evsel, "node")) {
+	if (evsel__field(sample->evsel, "node")) {
 		int node1, node2;
 
 		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
@@ -243,7 +243,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 	return NULL;
 }
 
-static int evsel__process_free_event(struct evsel *evsel __maybe_unused, struct perf_sample *sample)
+static int evsel__process_free_event(struct perf_sample *sample)
 {
 	unsigned long ptr = perf_sample__intval(sample, "ptr");
 	struct alloc_stat *s_alloc, *s_caller;
@@ -751,8 +751,7 @@ static char *compact_gfp_string(unsigned long gfp_flags)
 	return NULL;
 }
 
-static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
-			   unsigned int gfp_flags)
+static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 {
 	struct tep_record record = {
 		.cpu = sample->cpu,
@@ -773,7 +772,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	}
 
 	trace_seq_init(&seq);
-	tp_format = evsel__tp_format(evsel);
+	tp_format = evsel__tp_format(sample->evsel);
 	if (tp_format)
 		tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_PRINT_INFO);
 
@@ -805,7 +804,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	return 0;
 }
 
-static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_page_alloc_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -836,7 +835,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -877,8 +876,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -955,8 +953,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -981,7 +978,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.239.g8d8fc8a987-goog

