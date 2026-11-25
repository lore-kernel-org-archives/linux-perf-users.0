Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567896;
	b=4L54iWYOIJI0NYCHjdhrc9rGHB4z+JrZcdHTP+XKAsvlC+rmYfL4A08MUP/nELjPZ7aa
	 vdmnvEvvL2Ibgtt/KsqaLE7m+Yh9QVEfvGmhXhBZXUinX+vCX8JCSb+6wK17axUTJ3P3M
	 M1nXUVaMYyd6zn/5uKfFKPqoU6UJpY+gc/r6mPNJ5kcZ59/ulEbCkoiMH+IaJ9kPjl8T6
	 8Pc/D5/Cg/+g2htH6JbAWlx5hQvMp/16dHta6jHqNfdqFi8uG8els3YxLU+NHy3TagclL
	 uZN+4lJyyNftqti/nPDQIUlnKs7R2J2mBiBzpr2X6l76VO2jg7H1wjbl1ukpdDEPU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KDtWFQ1q0UEvySt+h1bvsMcMVBiQ9DnzI5ILdoKuc08=;
	b=tO5K6S/d6zjVyB/3/k0IO1pTWkx/WMcONzpXQ6Riz8Vyuot7ZgKZBnxpYnuYZ8mQWSqT
	 hF1h1O7Oli6Enl6XhQrRRRgHNOckobtr422uy8wHAUXUAbC+nFRfDSnvJqg6vbO1wWG5Q
	 XTqB4CEDj1TFdLQubW6upozBMyCHsCcZUv0Ikpt9nj9G2mPNYD87avzZGxxay4e4RFXdX
	 CdtgDWPuNzflVlbCV8tSJ7m6utJvP06FWMRwSW5tlYy2KR3LAP79PW91tbc4SYACXpmXX
	 s+zrKv2J2NLQEtr6D4ZBi9UFkgRKypsALGXfrf/BuuPIIPqzhxQ5YIJfP/nG3r9jVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YZveO649;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443C60A2614
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D443C60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YZveO649
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5670822eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567895; x=1796172695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDtWFQ1q0UEvySt+h1bvsMcMVBiQ9DnzI5ILdoKuc08=;
        b=YZveO649Rof8FPLG3vQia5PljE+TdVi4/r18kV6gm9nsGxHTmIW2IakL3b3FLglRHs
         MF7zXN+ex8329VUIhlV3qOsDLP0anHCKrVKGOuckVH7N206qyP5e1KuuBErp7DXNAozg
         ePWt9nD2Qj7ib0TXS9JjuloOY+UMUVP6WVafTbJknN0D5otFw1YWXy9ae+WWZETAvKh+
         O6G6pSWz4YfLjAt3cbrUc5N0kCPDyJic4PYjtStsuX8sILVTogZyyWFr808Ys4o20RPV
         +CkvH76/GgKdKQAaWJrx3AbcTRFtXz4KUpmedC2zrFDe6f9Aw2nYKZ4DF/IKJ5oDTyE0
         wNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567895; x=1796172695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDtWFQ1q0UEvySt+h1bvsMcMVBiQ9DnzI5ILdoKuc08=;
        b=moH35ckd273u83eC2Kskb6EpE4lvZsNQRmiVYKDqT6twQY/Aqa848YEzB7wOfY+c9U
         L2OSa7ucfCEIbFPd4xcottpqACA7gNOazVE0ZYujl9XxgGTK5cmJpkV1n13uyXL6dp1R
         AR6OVDXsAOY+rMmURdPqf6gpgUM+6Nj0er4AakqUmTE7+eIp9P93IhkLkLjZGlDL1gxP
         hqqPCo8NuVWqq0c8pgErQ67xOP81pdgNOHcUbUkwyPUsFI9j2wfYDhDEIKfZv0VWkD+Q
         A13w94BATK6YHKW6IfsERNbyP0lx27VbHlvvgE3KaeEz0eMRihKL8Hq2uSTEfi0UMPx4
         rO7A==
X-Forwarded-Encrypted: i=1; AL+hErHkMIO7b3Cpuy0y0QLXyRQveqXeKH+3vSHoiXp10po4c0OgiX5nQEc82lTi+XyDZMG3ERpDUZZD8iWPdrDAO6yw@vger.kernel.org
X-Gm-Message-State: APuU4Z/tUpsqjoLptyDLZM2gqscK3kSI+BQ+twsZIdzUhmHfiVEG8YUD
	DcxcaRfuZHnaUN07YeiASjz7VWxntFht5mVJPHQ+zD8BDLVwwQCVqQrnHXjthPDtp3grJV9XIp3
	hLks2R69qdg==
X-Received: from dyhd10.prod.google.com ([2002:a05:7300:828a:b0:386:95bc:ec27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:140b:b0:386:ca0e:430a
 with SMTP id 5a478bee46e88-386ca0e44c5mr1999211eec.24.1795567894549; Tue, 24
 Nov 2026 16:51:34 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:56 -0800
In-Reply-To: <20261125005108.1020003-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125005108.1020003-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-8-irogers@google.com>
Subject: [PATCH v4 07/19] perf inject: Set ordered_events and
 ordering_requires_timestamps for --aslr
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 0ce6cf53db5b ("perf inject: Set ordering_requires_timestamps
before creating session") initialized ordered_events and
ordering_requires_timestamps on inject.tool before creating delegate
tools and the session, but omitted inject.aslr. Also set
ordering_requires_timestamps on aslr->tool.tool alongside ordered_events
in aslr_tool__init() so --aslr orders MMAP and sample events by
timestamp consistently.

Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/aslr.c      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3f3108fd3981..b887a4398f96 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2810,7 +2810,7 @@ int cmd_inject(int argc, const char **argv)
 
 	data.path = inject.input_name;
 
-	ordered_events = inject.jit_mode || inject.sched_stat ||
+	ordered_events = inject.jit_mode || inject.sched_stat || inject.aslr ||
 		inject.itrace_synth_opts.vm_time_correlation ||
 		inject.itrace_synth_opts.set ||
 		inject.guest_session.perf_data_file ||
@@ -2861,7 +2861,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
-	if (inject.jit_mode ||
+	if (inject.jit_mode || inject.aslr ||
 	    inject.itrace_synth_opts.vm_time_correlation ||
 	    inject.itrace_synth_opts.set ||
 	    inject.guest_session.perf_data_file ||
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index f9ecb6d3f5fb..03d6fe064559 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -1275,6 +1275,7 @@ static int aslr_tool__init(struct aslr_tool *aslr, struct perf_tool *delegate)
 {
 	delegate_tool__init(&aslr->tool, delegate);
 	aslr->tool.tool.ordered_events = true;
+	aslr->tool.tool.ordering_requires_timestamps = true;
 
 	if (machines__init(&aslr->machines, /*session=*/NULL))
 		return -ENOMEM;
-- 
2.56.1.831.g720f3f5937-goog

