Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB23D9DA5
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248864; cv=none; b=UKcSB0d+MxhaMSctv0osSo9OKGjzUGnl1E9SkQLIWnoMf5SXmdkre3iEi8zuYqHt57njb4vybWpuFEGNMMAq1bS0FKs3+BjPSZrLwRT48p7qnGt88iX4pz45CN4bjX+6LmX0IfpkoJKvI6MloFAonYaBpZMwxa7ZNGYvw/Qa1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248864; c=relaxed/simple;
	bh=/7Otdj/WgbXIh6suCTdVqM2xyOka8p1nEa55b4snr9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9imrolGMu+TkGsjzA3arJPs94DN/pNA63r+RWm9EGuaPlfa4c/gFDdVUOCDPxZNuPsWHfomscgdaOarxZygcYB5mqSRumrjhjqTuTi6JfzfNdx81ayXwKfv4xlTBi11T2pvC7Sh/uPI0rIi1Nt6aZXv7zaYSE56jYqRx3ZIGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLr0+9TX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLr0+9TX"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce0a9e558so1545550b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248859; x=1775853659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7q5/FlfPtZ6fBz0id1vXEKUDGTL26BmbGuI50JUYOeM=;
        b=bLr0+9TXzkQ+8CKouRo4b92QFruLsO5zKB1wgK1wQO+2GyVWNGFk8GPKJCuRSrhJh9
         loj2qjB4mC4u1aI29te3wsQA3xITEQ8jKlKnr3MX3tsHjPmXrPsOk/TbhgVW8J6JTQVa
         Qx2Am681XoVerKfvZKDYdya18Kgvi6VtHsJzH54CQ60hcAurY5ToyedXXyMhZ++67jv7
         qXmr6p7Y/gFkLcO9tu1DIxLfrXHP5ldIPxqCC7IACrc7yP6eiSVaL+hnJHt7BPUKcb5s
         RE69U/x6CeiP1YXokINCNkgkgX4MempYEoyrilcVE+6Tzy7QBTpjsndLpMkvUVng5bmW
         QVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248859; x=1775853659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q5/FlfPtZ6fBz0id1vXEKUDGTL26BmbGuI50JUYOeM=;
        b=NiCckYAPSfcYMuwFru4Jw2fTTKuguXLeNnG6cK0i1URSV5Kl6VqsU3OtXidyahguu5
         gEL/F7wkYlcIlOrGpksm8IanwqtkNvDYmUVDOaI7levlHVcViiEURcnxh/yjI3KjHvI+
         F+yj5GbO5bnERhCcjsjqEZt4767oJjiGainsIFh6RxvuhLodt5je9+JytUuWvUDnbgN5
         lQQSmTeDVkmI83vjrZzI3LNZNl2FHFO9j7LVZvBJC5yJ2eW9p3It6jGh4zIEKHU+THm/
         cwTXoUEatOZSI+fE+XcVnGC0hecLcuQnfgUnyDfBCRUpbgH3oeYZBxuJ4WplXZwYVVLV
         M/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYPDAQJ7u79/CbciR4dhGSK8s2cHGh+44zRiPUPKZwtHJyWC51E+aREcjC/hORc4fLaXKU8AjkjcQqtttxFdag@vger.kernel.org
X-Gm-Message-State: AOJu0YySdsPVJVlRQXOhFrKdfkqscp9jn27MyWZMnOV/33CFBxfvWdxU
	VTp2I3zhnYGoycpBvZ0nq26JhD2vIJr9wXYGSwHp06ln40TMH2/qWaL3zI2SLc56rZNpr8Dl9bh
	rH0oPBDmfZQ==
X-Received: from pfbef11.prod.google.com ([2002:a05:6a00:2c8b:b0:82c:e41e:8959])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3010:b0:82c:e76b:c68c
 with SMTP id d2e1a72fcca58-82d0d73f532mr3648419b3a.0.1775248858842; Fri, 03
 Apr 2026 13:40:58 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:07 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-16-irogers@google.com>
Subject: [PATCH v5 15/25] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel so read it rather than pass it. Update
call site.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 041f5dc92ea8..894e57aa50cd 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -233,11 +233,11 @@ static bool has_annotation(struct perf_annotate *ann)
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
 
@@ -299,7 +299,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.53.0.1213.gd9a14994de-goog

