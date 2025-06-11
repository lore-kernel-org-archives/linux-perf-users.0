Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED541DD0C7
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657734; cv=none; b=iXgm4Zz0bP8jPmnCE0nnSShBz7D1D1TS1aL/J6iURTNcAN+h2cdlzzXKDGcSWrsv6zklCaV5rdEjJGgXHCSAf4aofggeaB4hGTWoopUpF9e7DUlrjfe5Jtn01yudfy3MkVL+XUkM5WN9O5JHm50BliM5WtzQI8EFXnGQcDSJrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657734; c=relaxed/simple;
	bh=BjW6AZGk7CZomAEyWECRkQDZi3WC4X5fktZTMbvlAbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uimMiBPKoJBmKcn4tZo9RPe5fW0dP2z73wvBnwuuaQBWKrQs1f8QVK9goVKdr9xHDhZ1JrQkdK+RM8IVrzfV6YcfEsVqMgpg1qFyNFXWvleODN5hcZPzGAbRhbTd3KckJeSOTd2qnxEZP/yQYrD5M/bOChO49iY97fXFnOsNV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8d6RpuP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8d6RpuP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742c03c0272so42294b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657732; x=1750262532; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EK8se2wo8pULW/UeVmGZwrfi1Azdb8cvXZbahmZy3Ao=;
        b=S8d6RpuP/t4EkF3ofxTjrjYMA1rfwGEF1OPziTKt1n/bKXx1UhGG07yxBgAPUOgplt
         wGW6FOxHRXwuWqIes6/THhU0+TnCbzWz0Bt669z6VkXyl1d3Wnfi/0OhL0xicdkUYOeZ
         BZ+Rv7K9NPPJF2bWi5icY2VJZwKzWceGO07u/NW9KRZ8zjzImDqAECfdmLHY+MZtqoxu
         u225NBDqtqqm/sVNUIYSzTy/rKvG3DF5S5PE3ZmB8prIl4KPSRTcr1wXVBRtfnyIZgbT
         HfJQAFX2SQaNW97MulGohIloacFbBtsPLc1fkxkQtbDoSq83VeC8vkpukwtGVO78mJtO
         PItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657732; x=1750262532;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EK8se2wo8pULW/UeVmGZwrfi1Azdb8cvXZbahmZy3Ao=;
        b=N/kE5Av1bpL+WAbee61Mgf9wXa7Yc+TJBZveg7Lv1pxm22RDxqLSLMYfWcPw0L7ooc
         PAafpfT9REUzp+V6CVG95DTpILp5CffFsvC4LolAkUdbZGul55/+q0LCg59oXoM4fZiC
         qP3i0T23b3P3HfQLPWKFq+XjtgeT9Qp5MSR+NMYrCOeXlyYmmFwXpC4EBWBE5Wz+r3iu
         zqQRO/NDqs9GkgHGsMYuCmqyx/GssLZtACdfmxSw6A5fLvrEIFA3JxpaK/66SSN6f6zZ
         xr7aXD4lCKmiD8jvP95WsPU1RMzR+EDWVToGuXJWe57mW5F6eGyYCCkgufvRC+68JutS
         gCmw==
X-Forwarded-Encrypted: i=1; AJvYcCXqnOB2FXfgrTc+co8fO0Q65w6vvreHzVqv30tTd+lZ8nhura2ynQ5b6RzT2O2GTt9TVgmez4cHtZmp50k8DRT6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UATzJCei2QzFOMEJtGjtttz2MAcltZ+goXzsG76FsZ4Bmgti
	npIFh/v1L8Rn6fcJfEt6nn1SrI7r5hpoMq7XludL1z44rKPACcICKL9yO8zieMiKH0nJUKQH8gb
	H+ZIjYDMjoA==
X-Google-Smtp-Source: AGHT+IFRsv9gZ6KybjWGxsIgbP56ZktGajyQTN9FBoe6EdAqxdXrc/PpNdCE6rAY28U/h1LpaHPiw2J+TSpK
X-Received: from pfbil9.prod.google.com ([2002:a05:6a00:8d49:b0:746:301b:10ca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22cf:b0:736:6d4d:ffa6
 with SMTP id d2e1a72fcca58-7486cdf4d82mr4897830b3a.15.1749657731710; Wed, 11
 Jun 2025 09:02:11 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:52 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-2-irogers@google.com>
Subject: [PATCH v2 01/15] perf hwmon_pmu: Avoid shortening hwmon PMU name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long names like ucsi_source_psy_USBC000:001 when prefixed with hwmon_
exceed the buffer size and the last digit is lost. This causes
confusion with similar names like ucsi_source_psy_USBC000:002. Extend
the buffer size to avoid this.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index c25e7296f1c1..75683c543994 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -344,7 +344,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 
 struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
 {
-	char buf[32];
+	char buf[64];
 	struct hwmon_pmu *hwm;
 	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
 
-- 
2.50.0.rc0.642.g800a2b2222-goog

