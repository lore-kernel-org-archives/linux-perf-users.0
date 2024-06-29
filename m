Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8C43155
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Jun 2024 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636870; cv=none; b=PtZ7sE3Y3NZTMBaLDbcYp6jYGnQJMY6lcPM7VtT+2gL6bQHJJ/q0GkHQgJ2m5poSnGG8nO5OcoO+jzF0f5NDAf/NgOUZh0XL1DqDzyvJSfz44FyKSBoiTDA42zdNVpyg1Amg3vmN3zVbzxah9AsVPtIjdGYBTpCz9czD6nyBzDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636870; c=relaxed/simple;
	bh=d+IjtHFeEb8npFCJ/NtiuIpVzuhLm20iCj0wlduMmkk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D/ev+Z1QjCELFEFTeo2B4QaPsqPa0LPwi7TMtjtz0AJpznGXH2ON2j9zsyBfN03315IO0pq/FERnbh97UkbmPoVp7Q9F3h83wKCmQrcN/rWxpexnNfRN3BIw4SMweTjpM/wXV5+SofKMiq0s5u1z1cVWgE0ElIKfBgh03mTR6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTB+JR1F; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTB+JR1F"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f3c5f5bf7so21124607b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636868; x=1720241668; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpdjN8s5wB9rzl2Ip7o2ZK0FxU3Lu7ldCcmvQXtJM2M=;
        b=cTB+JR1FKT05C1tIeKWyEBJnmyfgYTDgj5yebawysQFBMld1/YNuFfwPb6MS+uJAtg
         Q5MbRUNoaomFDmlRyPsWfe8U/ez9JRK5iz/W2q1mtPKpkBZ/w7xC1LitAq3MoVHnF8bj
         5Z8+WIzivPb66zQS1hi2RWW3vvnzZb6ly0vaM+Et/HZFP1yym6rSGyGKTAgFIxcdt7Mu
         eg7sNH+fQDE7lkUGByJNOdT0SLSxxjwtfGpYvlBa5h29eS+DPQ2V8Qd33mhGg66pkJZz
         56QyytK5f6TpjQORtI6rgtJ7MkBenw6hbK/uyL66Z0LmIMo0P8NRYLci6cECFGGHZ6nu
         lBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636868; x=1720241668;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpdjN8s5wB9rzl2Ip7o2ZK0FxU3Lu7ldCcmvQXtJM2M=;
        b=DqTHrTHG4Rww16IJDDiSV7x50W9IJ2W1VD7QGlABWitP7KyQz0oxraCFtxeuINcc6c
         v4n7jhw3XaucrHXx0XvUbPQwnxxh3mFLiNdq5Z8d1p3ZdStaOBlqwWt0oFbhNvu0hOet
         ECFMBucbrn3bemFqB/l63OLj+FvaIgjyM9gQwjjIWNPlw66OaXOQlrqY1ktulfOwv6UE
         cry9BsqA4xzB94QWrjYL0vmzpBnJKSYM5KM8uoXe91Q5WoG/W+GgKtUOAeS+1kdAvrS7
         VLKK1RIzu0jOHAZ/iQcaeogPfaiAjmXakKfZuUr0a7TyDOLOv44rhcbm6+Zdv8qQY1yd
         MKmw==
X-Forwarded-Encrypted: i=1; AJvYcCX6bPiBVrMEDZGO8ewKHq51FXBCbl2/MxKf+0b3o8FE5IwYj/McVrnFEbEAy/EGUKkwEfb0HyrmN0wIl96nMFheVmCp5Jenmo2kJq2SzCzH4A==
X-Gm-Message-State: AOJu0YxqoB5MXErsTGTC0ahjho85VOWLYqx6WOz8/kNcsBDVM9F4tAVu
	hKPhwLoYaKD9rAo6D8dngSt+EBo+JDgB6jDGyRLYyJGqypQMTSm4UT1QIFL0Ak2Yx4a2KEEaEw3
	9Ak5FUw==
X-Google-Smtp-Source: AGHT+IGOKM+g4XrnJTUAvGw3TmUrRS3o4+KVzhyYtt6vHOujwVUTKi9JPoVkhRp1pYVkidwItBHibGKxyLKg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a0d:ea54:0:b0:62a:4932:68de with SMTP id
 00721157ae682-64c7360704dmr34117b3.8.1719636868301; Fri, 28 Jun 2024 21:54:28
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:31 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 09/28] perf kvm: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog

