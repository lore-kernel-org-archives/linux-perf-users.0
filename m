Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE785399017
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625052; cv=none; b=hwQrUs3si9pMjCQfOGfsST8HVN1Q7tLeQ1TuuZg8NpQSLyuEz3LasuTFvDas9qDz5ZUFIWyjGP000PP9LqYqetIluosLdR3HLGqyHkN2IEDMMeEeE1+koHCG3PCtnGfCLEawtL4coLEnrnpEb+Bboblx5h39f+9GXyv4E19F6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625052; c=relaxed/simple;
	bh=W2AKY9xg86kB0nijLLJJvvMK8B7FG20hJJLSa/AJU8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aDcU9vsM/zVRVqMuc21an+Tyrj4poFluN+BN81WFNdH9Sl2XX+1AHrPljoNxRtUhS2YBw1nHMFFzFyW1t5amc1Qbildjwy+xTzKZOjeiSzHsZ+m/PEspw8XQOjjGh56XtuZH5FeW6McyGv7mSgpTU29iiWxm6Cysblg1QnrBfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JY63o6Ei; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JY63o6Ei"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so4705587eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625050; x=1779229850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvGtwbXruuMwEdTQ18UP5dDlwFxR0L456s3G1VXIRIo=;
        b=JY63o6EiQY4ouMohnx0mD6YHJUC7LNDcx3Bzs4gAGcqpbWbUWHJyiCtjHTF55vi/ST
         Xit72M5UGtEunTq8kU/tJE7dDbgd/XiBXlWAnMSU0Dg71blvbHX+F4AP1uyHN2TZhOwQ
         aIRh+eixBgmsBWh5bhNWnh54oB7RmsA/B+n+RlhjYSCaUQRWd1Ws3NjZ9No7aOI6pNLj
         jvQTOmqxeQQG+RZS/XQxoogLPmjOKcQ2B7nf3dqTLNXHmb62FbgVkYKJbmjvO1RwBpIc
         blDZJ5oWPTvt7sQ3M57fcCW0fW/k1LNZ8PVd5UtCTzSfp6u75Am0Y8ISlf3d/k5DXv9C
         iEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625050; x=1779229850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvGtwbXruuMwEdTQ18UP5dDlwFxR0L456s3G1VXIRIo=;
        b=FRqsEWetCj1u3/L2jlBtwMJXFqX5WMXS5sMoHSZorE/2HSxWJoILoeTG6BE4c9vfhn
         k2JDukIso0Ywmfmr1y0Haasb+XPp2P7XtXUAW/+C9HeYeFBe1gn2JLZrFyfR/uUm/Xys
         1bjNzt6Vol+6hqO9AyR+TQxsBc9FrT9SFqvXWnQOacAeCK1htZhkLlIMXx7NdvOTEW3T
         Vc5wgqm5a4q0Lbj1AN4g0pwCyAJS46cV8ETt9ueD4EFWXsN5UNJfrwzDhHgEShBQVN0k
         cxxWyxYlItWm43cfcXQE4T1SfNYO6hNBlUQGDoVKiWiBc7peKzLNFQJt9dx4q35da50A
         URDA==
X-Forwarded-Encrypted: i=1; AFNElJ99vBET7x4ydNjbZm5GtzNvhpuPn92e9WpmGLFopXTrT69hJ+vog+txc+p6yalfCUILyDaY2kP8IzU8sT9lZ6Qk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lcJAc61ETyRA6wfWqK0oUQqA7C5T3Lj30xc1CdYJLdDUVfh0
	3FiSRNRszV7rxyrhGCa35dcNMtCiC1Z9mIMVU8RGt6SqhRid99OfBRrN05YdUmqgZqOteYbY1YG
	ehfXvYQQiZg==
X-Received: from dyaf27-n1.prod.google.com ([2002:a05:693c:839b:10b0:2f9:af7:5050])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b16:b0:2ed:e14:7f5c
 with SMTP id 5a478bee46e88-3011a36df36mr531795eec.32.1778625049628; Tue, 12
 May 2026 15:30:49 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:42 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-14-irogers@google.com>
Subject: [PATCH v13 13/32] perf kmem: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 2cdc56bc2616..68a39f56204d 100644
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
@@ -835,7 +834,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 		return 0;
 	}
 
-	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
+	if (parse_gfp_flags(sample, gfp_flags) < 0)
 		return -1;
 
 	callsite = find_callsite(sample);
@@ -876,8 +875,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	return 0;
 }
 
-static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
-					  struct perf_sample *sample)
+static int evsel__process_page_free_event(struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = perf_sample__intval(sample, "order");
@@ -954,8 +952,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
 	return false;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -973,14 +970,15 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
-	if (perf_kmem__skip_sample(sample))
+	if (perf_kmem__skip_sample(sample)) {
 		return 0;
+	}
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__tid(thread));
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.54.0.563.g4f69b47b94-goog

