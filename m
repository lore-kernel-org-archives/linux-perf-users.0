Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FDB1F8661
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040418; cv=none; b=tjHHEI42Smvz3D7AbU5iiaROWCdnZxQMTGJNbkXx6/PqNLtyTpwNdw8NJ1TlqSUams58N6oUIjydaUzNll98Qv2MKKjNjs4R9vPsVp3QMa5JmSi2OaBS3v5H+xhsubF9qges+NXlliMJR6A2IDw7fLVpU/JlsQBmYpQFRlSrADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040418; c=relaxed/simple;
	bh=09lWzd/6dCgnZxyO1zDKn3zFDr4WFTaCMF6mVse96Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+ZVnexqLQoLOix7Quz1cbMrCLIm0zk/AQGbYjalzLTEt/CqBznSuLIiun64h4sGle7mUkvoXqWwPnBUhRYIoJLX9emRphLyjLDj2cxSI9nuw73NOZAITg2B2J9bIgAjUP3LwAkTGEfstvngdFAhEcxFtY3Pinr1aGNVCHwW0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WXFezE8B; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WXFezE8B"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso6875045a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040415; x=1738645215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwSJXYJYJ2QsfeksDYzOVoprLyqehfXihnOY7v/vL40=;
        b=WXFezE8BDMAqFakkSspMdsynQ9P0lD1Xaq++3GkLoFdYay0kdncsoiDFgPaSpJGsDN
         9KiV3sIfNmbLBGnoIrTYZ1LY8uWTDMJBTVNE3z+3d4HfeTJ5DJk6Hp6DrMiOTDhO5iv6
         4yzXYWX62XIdsubjELstgH7j2wR3JAkAv94gl0lUk2H9RtU+GE5UsOwAyYPeXJ/CGXsu
         45Ijs371f3Tiy9ssP+er9vBJF+KsMwdsAv2JSBfrEXw6ANmiRdqeYIQLlhEqVvLi8Qeq
         5cZYgJIStI6KHDX538hbRyNqUO1S08/Xk1vtC5Cs7Zx09xCy8jh+MY1v/s044MhoHEZS
         aoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040415; x=1738645215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwSJXYJYJ2QsfeksDYzOVoprLyqehfXihnOY7v/vL40=;
        b=J5gtDQ/pJimZash6Qxw9UIeiDM8tka8LbEyAH12xO0bQ/pnuY7HsKN92opEL9VJm/y
         MRhSDRDH8fi/fDTlRRmWUNb5sR9TigSST2qSfcXzET1V85ZgSOpZNEwMTrO+qxeXM8S1
         G2WrYPIBh24q9kkT1rwEC+96oDmJYlirbw8Cd/1kh/Fk8YHYs1A6nU3AvHpnHiDLySu2
         Zg1doqlQ/laSjkTYO5vAZ7seZrKobI/P11/zhFIehqUz3utsUE1BPAkeL0uisFbC8rzN
         iuxW1ZRoOnOEadTW1x3/8MDsY9QWOwXhcAJR4WMk7tWGnt4SR/NGWlYWUhpG2V7BSWVS
         4PtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVaWFRRrusy8d37kiN2RS3jGhWdx11TolO1UXFCsMZsMWxMRRmoqN8VsJcZHdkh+c+nxbMxgCkGH1YgBv2N1D@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YK+GnF50thcKptTZJnWhAv8XHo2irY23yM8SIGWW6UJY8Tca
	7sRrGFjvbu658hBh8bgOi2Axp7+PlmgE4G13zL3Q9CWrtJv1tk67ZavRVpXu7Cg=
X-Gm-Gg: ASbGncsGyeqGOd8nXON+J0OWNFspmjMOBs6zRiQNSM1YKVPKmeFr7WawDs/Bv/lj4vX
	GdtX4vfjx0K7aBaJGr2+uHR9oFAKoHHLZxmy3RGNefHkckzF/gL8mOvLPFQbf/QR5/bQ0Lwi1en
	hoiJZIN8UfVKtXE1GbRPv+NpBsKfKZrFD+5utuD66BOuN/X2QYaqHeNiLP2rXAHqv1IU7yQFdAh
	ULHj4Okgm5A41s8yM2uizhdVW5xrbKz0Xm6SLdNdQ0dQ+HxkYJ0x5nvIZ5z8KmTEmejVHgsmh0i
	ybgHMpbdLHQZN/d0eZUydkHw9oOZ
X-Google-Smtp-Source: AGHT+IEKLNFZOaVvDJ2grs7h9hb4mxjnaquPb5u1sc5MAJh5NiIGfsglFThj6u7Oc3KeiatM4ZLmwA==
X-Received: by 2002:a17:90b:2d48:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f782d4f152mr64397362a91.24.1738040415260;
        Mon, 27 Jan 2025 21:00:15 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:15 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:57 -0800
Subject: [PATCH v3 16/21] RISC-V: perf: Use config2/vendor table for event
 to counter mapping
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-16-64894d7e16d5@rivosinc.com>
References: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
In-Reply-To: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
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
X-Mailer: b4 0.15-dev-13183

The counter restriction specified in the json file is passed to
the drivers via config2 paarameter in perf attributes. This allows
any platform vendor to define their custom mapping between event and
hpmcounters without any rules defined in the ISA.

For legacy events, the platform vendor may define the mapping in
the driver in the vendor event table.
The fixed cycle and instruction counters are fixed (0 and 2
respectively) by the ISA and maps to the legacy events. The platform
vendor must specify this in the driver if intended to be used while
profiling. Otherwise, they can just specify the alternate hpmcounters
that may monitor and/or sample the cycle/instruction counts.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c   | 78 ++++++++++++++++++++++++++++++++++--------
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 52d927576c9b..ab84f83df5e1 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -76,6 +76,7 @@ static ssize_t __maybe_unused rvpmu_format_show(struct device *dev, struct devic
 	RVPMU_ATTR_ENTRY(_name, rvpmu_format_show, (char *)_config)
 
 PMU_FORMAT_ATTR(firmware, "config:62-63");
+PMU_FORMAT_ATTR(counterid_mask, "config2:0-31");
 
 static bool sbi_v2_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
@@ -112,6 +113,7 @@ static const struct attribute_group *riscv_sbi_pmu_attr_groups[] = {
 static struct attribute *riscv_cdeleg_pmu_formats_attr[] = {
 	RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_CDELEG_PMU_FORMAT_ATTR),
 	&format_attr_firmware.attr,
+	&format_attr_counterid_mask.attr,
 	NULL,
 };
 
@@ -1383,24 +1385,76 @@ static int rvpmu_deleg_find_ctrs(void)
 	return num_hw_ctr;
 }
 
+/* The json file must correctly specify counter 0 or counter 2 is available
+ * in the counter lists for cycle/instret events. Otherwise, the drivers have
+ * no way to figure out if a fixed counter must be used and pick a programmable
+ * counter if available.
+ */
 static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct perf_event *event)
 {
-	return -EINVAL;
+	struct hw_perf_event *hwc = &event->hw;
+	bool guest_events = event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVENTS;
+
+	if (guest_events) {
+		if (hwc->event_base == SBI_PMU_HW_CPU_CYCLES)
+			return 0;
+		if (hwc->event_base == SBI_PMU_HW_INSTRUCTIONS)
+			return 2;
+		else
+			return -EINVAL;
+	}
+
+	if (!event->attr.config2)
+		return -EINVAL;
+
+	if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK)
+		return 0; /* CY counter */
+	else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK)
+		return 2; /* IR counter */
+	else
+		return -EINVAL;
 }
 
 static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct perf_event *event)
 {
-	unsigned long hw_ctr_mask = 0;
+	u32 hw_ctr_mask = 0, temp_mask = 0;
+	u32 type = event->attr.type;
+	u64 config = event->attr.config;
+	int ret;
 
-	/*
-	 * TODO: Treat every hpmcounter can monitor every event for now.
-	 * The event to counter mapping should come from the json file.
-	 * The mapping should also tell if sampling is supported or not.
-	 */
+	/* Select only available hpmcounters */
+	hw_ctr_mask = cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		temp_mask = current_pmu_hw_event_map[config].counter_mask;
+		break;
+	case PERF_TYPE_HW_CACHE:
+		ret = cdeleg_pmu_event_find_cache(config, NULL, &temp_mask);
+		if (ret)
+			return ret;
+		break;
+	case PERF_TYPE_RAW:
+		/*
+		 * Mask off the counters that can't monitor this event (specified via json)
+		 * The counter mask for this event is set in config2 via the property 'Counter'
+		 * in the json file or manual configuration of config2. If the config2 is not set,
+		 * it is assumed all the available hpmcounters can monitor this event.
+		 * Note: This assumption may fail for virtualization use case where they hypervisor
+		 * (e.g. KVM) virtualizes the counter. Any event to counter mapping provided by the
+		 * guest is meaningless from a hypervisor perspective. Thus, the hypervisor doesn't
+		 * set config2 when creating kernel counter and relies default host mapping.
+		 */
+		if (event->attr.config2)
+			temp_mask = event->attr.config2;
+		break;
+	default:
+		break;
+	}
+
+	if (temp_mask)
+		hw_ctr_mask &= temp_mask;
 
-	/* Select only hpmcounters */
-	hw_ctr_mask = cmask & (~0x7);
-	hw_ctr_mask &= ~(cpuc->used_hw_ctrs[0]);
 	return __ffs(hw_ctr_mask);
 }
 
@@ -1429,10 +1483,6 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
 	u64 priv_filter;
 	int idx;
 
-	/*
-	 * TODO: We should not rely on SBI Perf encoding to check if the event
-	 * is a fixed one or not.
-	 */
 	if (!is_sampling_event(event)) {
 		idx = get_deleg_fixed_hw_idx(cpuc, event);
 		if (idx == 0 || idx == 2) {
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 9e2758c32e8b..e58f83811988 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -30,6 +30,8 @@
 #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
 
 #define RISCV_PMU_DELEG_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_CYCLE_FIXED_CTR_MASK 0x01
+#define RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK 0x04
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define CACHE_OP_UNSUPPORTED		0xFFFF

-- 
2.34.1

