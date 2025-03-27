Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73780233734
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104203; cv=none; b=T+kAY7WDnE703mx4D5bQKhBsQLZompyzN2hJePqkxJXDiwH3V777XZcAJi4vl9uk9TiP6qhOLbt53dRJZqouUJ4VuAOXMoUbZE4LL9Lw9sykpQe4JfK9zsexz5RArXXsdz1rErUR5DdoVnXXEUOHXjdxBlfU/DHekELo48uV7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104203; c=relaxed/simple;
	bh=xlYuw0WqXBjwDLdQp7xWvSer8dY7O6gPMvcB2OEu6us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPOBfzdb3vDebabzO2/SUYApTf0PtE/xAiT+fa2Vcd8EDi5+zlmAyD9gpbNyXAZTufWAYRvYNL5EfYzbGCIEGWNJekx7POSqlUDxkP6wfEbOvkh8JrxRrbLD0eL5r542jLW6oVsyNXBU1RPEz7iFe6BVhsOMGCqB4Nc3d8G2HDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a9idOOEr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a9idOOEr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3015001f862so1664190a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104200; x=1743709000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KssINcBHG6V5nsmKK6p0ubimcU1BXEQtWDJ9ECnykV0=;
        b=a9idOOEr3p8IcGzZW59E+WzhZdg+eU0FPNRbhQvmAVuLjRw4fnMav+K6Y6ysvZZm1T
         mvxRAcqQDky+erslleQ8Rwo03torKasm/mpaH0nfDJnOqU/GTs+injOFy1N8BOHOzn2x
         2AFKF1G/jx6GOCn22PPv9Pqr1ZHf/cP19TDuITsoUS1AwgWY7TDA+xklfhY8MVQSMz4I
         6+CgTH1LH2bFgWJQhiZqXFTmvPp29rrrO540O981em010TQSkM+q9BSwHYl3Ysk6716Q
         tiTugNKgS3MvOq9MY6y/p811kGMzhcqHs60S6U7nh8OM25JC07Ep13kTsrjimSJ3fEYf
         sUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104200; x=1743709000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KssINcBHG6V5nsmKK6p0ubimcU1BXEQtWDJ9ECnykV0=;
        b=g9T1exkf2B/o/LqXcwlYamS/LK2efNgWyT/h3NXYU74jIOBul8SEx5gJi8uWmRzZLB
         IjLWAZrcRDp91oJYJYysPo2o+smrucPf+Lt4+XZjBjWueS8TTGM7LG4NIaVChR3ED8KS
         vk1Z2SfXYNTleU3FP0rxCnpYV9uxu1nouIw0tCSAyKbw6DKwmfS79DuNoy7831Taubhb
         WYbOCdigUqMawTEoQJ5XzXx/TFFE1fCRw7ZtJ5bzOjkYZw1DIbij9DnSd8lX7GAt3bjd
         oyb02eF1mCG5HiVG06c43v/w3dfl9eZ+ekPBRPEgpd40zb+5lNOfVoRglYUI/IcFQkRp
         1bLw==
X-Forwarded-Encrypted: i=1; AJvYcCWflecySoqIVTAp7YwBS9eUMQ1AYtR2f+dvjC1favAjZdHy3oTU/WexoyYZq6xMPU/sghEY/iosC8Tf7SY7ULvZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxTTV4hQyawvwcsWOL+jDHCjYkHkp12rs68AJ0eR8a+9P9akrUi
	GSo88+nN1YoqE/ZuvUfyqqDFGM6IAZ1ncc51EU0HSMkr/gpW41uuyfyY9snyNwU=
X-Gm-Gg: ASbGncuEGrE2zT3DOs76NjqHmiTOD7jmIn7qmQvafNabhhu3AKwRArod0MJhC+Eddtc
	t9e7xSOw2mTopdzKRByg8L7SAe1R83Ya7TdLuFdhtQYhsFEEnon/RYq6cd6DoO91if+ltKR1XKV
	7J0GJcdojVrNwyDBl4OsL/WxvlVJqR2mUst3G7y0DCHK4qcsls04dhOBtVbgRdhtV0HrXOeW9sR
	zSpnsFsCim3z04vhOIDos+TbKDRR44Ags8rkLNKB+c++8bhASqvrukMrDGI0vdV+DpC9/4Tea6Y
	ckHvaIUtxoy2hvANd/LZ3co6c3Vzg1asIV/U0+Ky/G3CzIgiGd/jF1ErmA==
X-Google-Smtp-Source: AGHT+IE2krN6Iazwz2/u7kYznnPmcB0AT0QBtnSPpGlLXmbNzMbs0M2bltPDrqZDoRjoQ9cuAJeaHg==
X-Received: by 2002:a17:90b:278c:b0:2fe:b77a:2eab with SMTP id 98e67ed59e1d1-303a8e7653bmr6347831a91.32.1743104199626;
        Thu, 27 Mar 2025 12:36:39 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:39 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:58 -0700
Subject: [PATCH v5 17/21] RISC-V: perf: Add legacy event encodings via
 sysfs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-17-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Define sysfs details for the legacy events so that any tool can
parse these to understand the minimum set of legacy events
supported by the platform. The sysfs entry will describe both event
encoding and corresponding counter map so that an perf event can be
programmed accordingly.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 92ff42aca44b..8a079949e3a4 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -129,7 +129,20 @@ static struct attribute_group riscv_cdeleg_pmu_format_group = {
 	.attrs = riscv_cdeleg_pmu_formats_attr,
 };
 
+#define RVPMU_EVENT_ATTR_RESOLVE(m) #m
+#define RVPMU_EVENT_CMASK_ATTR(_name, _var, config, mask) \
+	PMU_EVENT_ATTR_STRING(_name, rvpmu_event_attr_##_var, \
+			      "event=" RVPMU_EVENT_ATTR_RESOLVE(config) \
+			      ",counterid_mask=" RVPMU_EVENT_ATTR_RESOLVE(mask) "\n")
+
+#define RVPMU_EVENT_ATTR_PTR(name) (&rvpmu_event_attr_##name.attr.attr)
+
+static struct attribute_group riscv_cdeleg_pmu_event_group __ro_after_init = {
+	.name = "events",
+};
+
 static const struct attribute_group *riscv_cdeleg_pmu_attr_groups[] = {
+	&riscv_cdeleg_pmu_event_group,
 	&riscv_cdeleg_pmu_format_group,
 	NULL,
 };
@@ -369,11 +382,14 @@ struct riscv_vendor_pmu_events {
 	const struct riscv_pmu_event *hw_event_map;
 	const struct riscv_pmu_event (*cache_event_map)[PERF_COUNT_HW_CACHE_OP_MAX]
 						       [PERF_COUNT_HW_CACHE_RESULT_MAX];
+	struct attribute **attrs_events;
 };
 
-#define RISCV_VENDOR_PMU_EVENTS(_vendorid, _archid, _implid, _hw_event_map, _cache_event_map) \
+#define RISCV_VENDOR_PMU_EVENTS(_vendorid, _archid, _implid, _hw_event_map, \
+				_cache_event_map, _attrs) \
 	{ .vendorid = _vendorid, .archid = _archid, .implid = _implid, \
-	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map },
+	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map, \
+	  .attrs_events = _attrs },
 
 static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
 };
@@ -395,6 +411,8 @@ static void rvpmu_vendor_register_events(void)
 		    pmu_vendor_events_table[i].archid == arch_id) {
 			current_pmu_hw_event_map = pmu_vendor_events_table[i].hw_event_map;
 			current_pmu_cache_event_map = pmu_vendor_events_table[i].cache_event_map;
+			riscv_cdeleg_pmu_event_group.attrs =
+							pmu_vendor_events_table[i].attrs_events;
 			break;
 		}
 	}

-- 
2.43.0

