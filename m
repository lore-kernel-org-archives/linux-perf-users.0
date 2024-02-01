Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18903CF40
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Feb 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761376; cv=none; b=JuEQDmHe2h8mi+XfJ08nDCquO7e3TlcBaujslLgiIwon5Mdq1S3CuigEN1b92BzTDl42AqW8/Ug0uM2on+Qg6SXBXY9xd6esaNp2V01gxBqRhpbZjNpjYA9zrPwk/UPFT4AGp/T6DVgYWh7XFOYFOh3OvIzIQ66MpEdBkhV/J6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761376; c=relaxed/simple;
	bh=sM6e4GJOdVtgwSVAwsLzIbgUpUVCVxBjp1/mDPrXzxA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DDTU32Z59sEeFKTmDWbDMUJTnPYsNvueQHN1a7A30JEHFK3Ee0XD1j990qyUUQjVSpx4OYD9ffobzwE+qxQ52V+g9tFSKc7hyyGMQ2gEZvkY/yLYKsKqGF9uuxaeMijSQ5YUtYZZGTp4Xo/QS3QWxqK9L2+rSm4bVjrcwki/CnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJ5BXYP0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJ5BXYP0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-603cbb4f06dso10333707b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 20:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761374; x=1707366174; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JXSUMX5bbfgnckmTRSZnaB9bhkcugUHtNJBG9b4Oo4=;
        b=QJ5BXYP0VM7KLbvbyyPr8hcLsap4dW0LPX3aPVHFjUg1pnNcniUzXW75tV7XzDssKH
         kpP31oxRoTfg7N8lYODWE3A5gE2tp1euUyAKTryMN0c030H87na9wA4cuaQGHsZrcon9
         USKhntQtmATztQsPhLsfFmQi7FEFVeOerKTFcnPgvAHkehtvZn2cbGdLVbpAHjFqMcSw
         wUI7YIrIxOJl/E+qcFFIBxGHVlH8bAm2wfM2/EkgC/uDcd1hjtw1FuYHN97ocH65I9va
         B9f4J48EKYWlK4NoYf3swTX8FGFWNe8eHHIXgtCa9pnwl1qG9OB3pz+YPITGrq0IcLu8
         TRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761374; x=1707366174;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JXSUMX5bbfgnckmTRSZnaB9bhkcugUHtNJBG9b4Oo4=;
        b=ehaQS2V02fnHhssmT/xr66GGJct1GH7F2Ei3uvGFAM/vReWcbPqfClmHRsnQ+m9O3d
         0NXGRenGVdWJ70YdwFo3OaIfJRfNzvsMhQd6Y9Yic1Mytwx784wRtFXOHvzhBBWZ5fgw
         LgthPeq4SF5ALHf+Z2b28C3qhi32HmV/w4L3dnSutoKWRyejZIm6QB26V41b7f+Xh0Wl
         pEALFd8l+AXZoYyFNFYKN9eg65+SRXus6nSA0GVnILHN7wsELqhZBpftdw1EUcxbEApV
         32fxS4xx7ljF84cU/MyCWFPk6dXA11cEj+KfiRMrNPpjfrNSTg06cDR4JcRz4pEkn2zW
         ZxAA==
X-Gm-Message-State: AOJu0Yy8C2vQFG/3ZyVgCMRrcXEpL3XzAxqJSeF8LW7mYwXoVlD56x6B
	W+Dn+QOjR0FTN8qm4Aq7c83BCRvEGzOBHtS9hvAOxQmxIKQFFA+jcTYRrdIvJPTjiWTEWWaux3G
	2VRxKog==
X-Google-Smtp-Source: AGHT+IFTJVPGgTJjz0vfAK3znBckhM+C3f96ATL1D3c1AModrSqCIkbFIqSfHTHrXRFHdRJrEfI2dhkZAVZt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a81:9a92:0:b0:5ff:a41c:1d19 with SMTP id
 r140-20020a819a92000000b005ffa41c1d19mr780347ywg.9.1706761373658; Wed, 31 Jan
 2024 20:22:53 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:30 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Potential corner cases could cause a cpumap to be allocated with size
0, but an empty cpumap should be represented as NULL. Add a path in
perf_cpu_map__alloc to ensure this.

Suggested-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101@arm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ba49552952c5..cae799ad44e1 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	RC_STRUCT(perf_cpu_map) *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	RC_STRUCT(perf_cpu_map) *cpus;
 	struct perf_cpu_map *result;
 
+	if (nr_cpus == 0)
+		return NULL;
+
+	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-- 
2.43.0.429.g432eaa2c6b-goog

