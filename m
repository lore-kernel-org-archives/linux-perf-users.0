Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7DC3803F2
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053553; cv=none; b=qA3neT5Vfh0j5bNosFBZbkOBX1Qhlg2jFJNcHapUmtoaAwnTqhhIp2V6iqIsvKKu89vGaelYQ0eL0Rlizn0MxXT41DDqrPFb3LFWbS8jayncWgZCqoZ0MC9zhIOFTt1auq9Xm12IZ/0F2gQBQKKxdhX2UDjLrsiP7aXR25YhXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053553; c=relaxed/simple;
	bh=s03PR3NdhraoAct+z3ztP2wak5yT9JPVUBwMWmour+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OYSYOnDsIKWLjTl2nBvWeTVHU/FBSqwrV836DqH63Ev+oIy+we44p4NAe2b9l7Nq84UxU5MPNKzi9kPcGi0alYmHU+ETF2Gz8Q0qJjFeek3NRwPxiG3QZrQnU7yuu6Y8jV1HefTV9ru5boV+LXZcjIZ4WmLiea4Rr00cnlehVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqGeG9sK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqGeG9sK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so6110960c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053544; x=1776658344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=tqGeG9sK2GvH87YIb05voYZDOXD+wRw1ddrLiI+KjH5OHm/djOEGu0yXZo9FYXzVXS
         U8X7PFu+LlxqnvTIqmCgKq6abgulBFpkGViDzhQsHpKtA6qRGbMLpaQudz/lO27HDrsO
         OFcI+7WXmDaXij9tojBWkeGFEpzBV/yWc1cje+U5Dl+E4rFAhLWJuQHof4IXsq7jl0aT
         J5419VUiXrgj20lFaD0jfpDrL+tvH/coHrNN2SNWV8YJ8STdZW2yGv3ymc/g3WUv8nw9
         6rAMeSv8ckrOpvTeFZ/7cbX7YsAW+HKZwk9+a77ytql9BrYUPj6cuUpSeAh7s4NLkacp
         BvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053544; x=1776658344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnOzocw/zY+37IjMdz6jX9+0KodIGkyYOBbLG+SMCCM=;
        b=JeaidbUxtE8CdDcz0v85WKAHm9W2Pza5XK+dUR1CRDG61+DYYswm9T72q6Y/cEvnum
         DVBZPd24YopIulWFBWmbaAtlgiLpM+X5GSiigpJt+RrjKKL7KRtqRTTteSDSGVDWROfh
         xpQxrQC1OVKZG6Nms9pqEk02uWFgAXm3NoxGrQQFHyIyjCw5gMepD2cJz4qlIdNJx3YD
         AMgEbZt+RjWJbb1Ug/C1kyJmXqvpSt6M+8zbKP8qBFeUyW787qVrvpdrT5lJ0Sx2Z0LY
         yT/EAVd+w9fU57BAkH/VmsKFHLmlWNLU+6mfn2UqD4igmWPTCydBoJpfrYo7uMY20YIe
         WIDg==
X-Forwarded-Encrypted: i=1; AJvYcCX3SozR7YwxSg9QhrWfx4uS0VpmBOtPH8UdonD9dUBvlidENV1/hDj2cnjQW/Fak6fuPDR1kLh1xRzDs9ZNbD3X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32pMy2CvGtmJCr2e59rk5AJeRFa5Ed2f3JAKZbVMxlxiwq0HV
	Fc8CvW03gwDvZCPyzeIk+z2IF7bNdZMYMQKghHYwSSGBGjFFPUL8xoDxibKQx9WhRzgWwiVEwQx
	0lfv9wZNyDg==
X-Received: from dydb8.prod.google.com ([2002:a05:7300:80c8:b0:2cb:b540:9519])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6183:b0:11d:c22e:a131
 with SMTP id a92af1059eb24-12c34e37b04mr6494827c88.3.1776053544066; Sun, 12
 Apr 2026 21:12:24 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:22 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-13-irogers@google.com>
Subject: [PATCH v12 12/33] perf annotate: Don't pass evsel to add_sample
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

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f8be9ead43b..719b36d4eed5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -232,11 +232,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -298,7 +298,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.1213.gd9a14994de-goog

