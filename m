Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00816F837
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720835; cv=none; b=ounj35HMICJXqoqfuh0PPBxMTu6QafSkoYN5R1VoTfLHwmcnascebLqMZ1CDIHBODTNc+WIpTIELa79VBWv1CHQu5HRlnLWCY+t+Tl5n/QijeiJvmzeGYATDpTtY+Z89ODpzTr/PvbzPjzn61eH+KuhStZq+bcNHX4atFyB0DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720835; c=relaxed/simple;
	bh=R2cr19QUh/0PZGh9ohFFVIVNT0Cp0G9UBlrYuAQOwdI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lKJ3cXQ2Itz23nbldRgVDkVlWv6hfjKd/Pv7/ECmJwS/szVcT741Tqovkr7kTztN8xqLT0qXhfSPPxcNIjwJjXq09HVhvOvXjvQV6gO2ctdRRGVtTOLkEngjJtkqgkLdkHtPq6dKv3UdYAbIf8ht1njIS1lhH3USwNhjSThEaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cm8dn/NR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cm8dn/NR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654c14abdcfso21745857b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720833; x=1721325633; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byfF1KS0n4MzwFOMTsFSRoLAA/Zhxt2Mi8AKEzVn+O0=;
        b=Cm8dn/NRLfNcWn4wNBR7Izz67H3ZSekQlx3m89/DoRO84qqxByOiSluP4J7AAxskxp
         axpjKoCy1kvqBALMtEaX9TY7XALWqa/bLQ32yBerEaOsdDDrZlucZrnFYG3sBYXYSJSR
         vcMBgpcROEtxbQH4MugC74QZCEC2B1mSidJNRe7djNvjj9KJFXyHSo2mw5+mO3J+PT7r
         OZ/W1iEhuBSEBCKwfVq7B3bQrGY6b8cCQMEmYoXR65o3WK6sxwZx58Fv+hum+pCrElWR
         MeJNgcbzAm8oZrkoVOOxy3xZv14TTpCCo7meVQMHIZSfk5Lml71/HvorvPuKqOsW/w/Y
         XILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720833; x=1721325633;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byfF1KS0n4MzwFOMTsFSRoLAA/Zhxt2Mi8AKEzVn+O0=;
        b=nf8+w6Hg0d0uk4Xvec5KWzRpvcU1n30gopv2KEclejoD7zOGJjc1KaGHPTPCbk25Yq
         8eIeTS4xbREv0Gihp4Sjixj/1nk1JcG9iMjPl+HWSsglvH1oBuHE1bau5zOD+pKK/72b
         7fIN138w8HQ5FKRdlpwleEvvWYvbBi4yTb+Q2ra/wpyCI0WJVcJ9nlj4N97eLK5LDKuY
         ndZEUOxy1augLgOaF42k3FErYtEiofrMouOaHF9SihntnSty3z9mVi6CS5d4PfzJk22Q
         xr6J2MPSPsVTHwx7Cg4zAtfBHcTTe8EPK6KwiiXgHxargx/iif9R+2OhSWvemQXVswqc
         e6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVrxzJnib9I0guc502fFax6fTMS1W2ObaVjiEjBzJirsZC2GquT0AZ7msTkgf/5vDEnnCLr+b9SsJNbC4DMUaZ2sJAeBmA+ABjhzgEFFwCc7Q==
X-Gm-Message-State: AOJu0YwWQPQJdL/fqEIkNYQwS/w2Oe4u3qeUU/4OxHFX8JPrN7LyJ8jM
	QhvgByU9cjHxub0imYzugDakc914adwY5IwR/0OwlhL8fqeMZWZmPvzq9mw/l0ZVbMhlXi7uqgi
	lBrx7IQ==
X-Google-Smtp-Source: AGHT+IHr46EqKsmYnSPwqHtEtQqAbJbduJBfkql3qcbWmp+qi69+FUgSATsZrC/sYGw83ur4i+SBO0yT6dWE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1389:b0:e02:f35c:d398 with SMTP
 id 3f1490d57ef6-e058a707db8mr1062276.0.1720720833194; Thu, 11 Jul 2024
 11:00:33 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:49 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 09/28] perf kvm: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a3b903cf4311..692267b1b7e8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1603,19 +1603,17 @@ static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
-	struct perf_tool eops = {
-		.sample			= process_sample_event,
-		.comm			= perf_event__process_comm,
-		.namespaces		= perf_event__process_namespaces,
-		.ordered_events		= true,
-	};
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = kvm->force,
 	};
 
-	kvm->tool = eops;
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
+	kvm->tool.sample	= process_sample_event;
+	kvm->tool.comm		= perf_event__process_comm;
+	kvm->tool.namespaces	= perf_event__process_namespaces;
+
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
@@ -1919,14 +1917,13 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 
 
 	/* event handling */
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
 	kvm->tool.sample = process_sample_event;
 	kvm->tool.comm   = perf_event__process_comm;
 	kvm->tool.exit   = perf_event__process_exit;
 	kvm->tool.fork   = perf_event__process_fork;
 	kvm->tool.lost   = process_lost_event;
 	kvm->tool.namespaces  = perf_event__process_namespaces;
-	kvm->tool.ordered_events = true;
-	perf_tool__fill_defaults(&kvm->tool);
 
 	/* set defaults */
 	kvm->display_time = 1;
-- 
2.45.2.993.g49e7a77208-goog

