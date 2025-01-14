Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D2228360
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895532; cv=none; b=SHw+CRmSx+kN6DUiUWih26Z6Gi330KMI6fFJk7e5Xmrf0rYbxNKPt4EJ298qBWFICfB3U33b5vwU5Zl8W20ogtZMHZbr1XcGB4kYa0bf7B8437zhfGsSMO0X6yUo09G+tp6/6+aiWhmQnmINLpcfbkr6pkG2Z8QmN7hy07afFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895532; c=relaxed/simple;
	bh=KX+c6OZLcoeS98RkAUKLotKTlJrHqY7en1pLAwLRhK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDYmodA8qpVIiagGazWkLk3h/cuzSgZ7rOv946a4Mmz5p+ahmNcBNP6zOVtoLGOk8cxdMB7oh3slo1b2Yz6Z/SP9uyXfvyGs/SwSK5hgSI8hNn2MkfyiWdoZzmcbYA75IFdVAnCywY1IfFyFMQkMT7jKcVszMZ6SQ5jsPxq+HeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mRpHszRX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mRpHszRX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso108020525ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895530; x=1737500330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qntZYbhhaPOyc0opQ/xzbCXT2UPDrjgDrjtXnzGv1Lc=;
        b=mRpHszRX6ik/dBvFnqOgfexdZuIsP3u9Y4NIjN1p5e8ujRPU59C/lNHIgHqxrP+eA+
         jIU9a7ITmY46zrhBLYlYqhYKWYD/pjktFnLHFjpx3GGDK+vuLsAvOIUdyUIQNQtmKDqb
         IiAZDKi6gZiemqdf+cOk8DB8Fyl53wov3wkzwECVnIJPsrSfllEdV0XIKeLNcO52B/hn
         T/gV1o6ElybcHx9U1KWDpbPkUoxLora92bCoC3mfalgFqGCx0UFLbIETkmtjF7KO7+UF
         bG9084XOX1dAJwElF/ZBhg5guNP5em/sgu5tnnhGRaAS41ldsh6zD3v3DdkLX9d4C8KG
         SWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895530; x=1737500330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qntZYbhhaPOyc0opQ/xzbCXT2UPDrjgDrjtXnzGv1Lc=;
        b=v/1tqhp2Wrul+sNHyNgTsKujWQtp6bXtozSGP5We/TvhiGYQHxjoM7876pgibcfDI8
         nIulr1De1eNF9a7cT3X9808B9u8tzoQH3RdR4z5fqrqKuW+yC1ynqc80VHjg08eyOMIQ
         DcNjfT+Ws5pNO5DMiw77XzjXtYIlIGns0/4jvasnWpHKAbXAdcUdtYQ7+Lferp9B9Glv
         dXp7MsoZkW83kdOQsRT2ZIWOPsvCsDeYXEDnCYlmJJAkaFBKKnyYTv7Ll89rGbG9/JtS
         0EiMApAutFPsImZUSqZtH2UIqnrj3fwS6AoNSq5Gr9kgTIOv+XzWjpK3N7UQvT+KHFcQ
         KiQg==
X-Forwarded-Encrypted: i=1; AJvYcCWnLTl1XdIoFnoHOGYFMre+Xx7vIEQALDSCviKdkGj4qUixDEPjwcgHgxvOm+m3FiPpK/BKWe5SjNoRixz7Gm0E@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP4XfFYn/SyFSEfciCqqE7P7rrvO9uJEAH/qrlKem4/wiKlPh
	vmpRYFOrMiKs5LTeRmGFM//nMI4FvIcBt2HZI0F/XocqK+xpWsc3AZX31BJsOFo=
X-Gm-Gg: ASbGnctqrlNXGFbReJ0WQcSSzxlc+b7BJq0PsQTEjdJcQu5B/lxflOHmB4F5VfX0IYH
	3VHiqZaLb+ba3lj1ONxaaeYlCf9A3YNf+UOlCD9iVEtCc4ZNHewU3SLiP9jng4Wf+t8blFRxAR6
	Em1fLDW+obL4SM4nKuDA+6M1vcOgCGTiwaopGOwia+v1tzpHs3NPxNXZGoEHMkpGbS7ckseeO6m
	phZk3BL5XA3kKRSDH/bvyHzpGtyxRv4cjucml+jaWEP/hjBU5+fBmZy5vNmkU8H1wWW9g==
X-Google-Smtp-Source: AGHT+IGvBxZa4fPYf8i5v/l3b33jLbUOvTwVMUDT5oDU8+c/I1Eb7QvrJXcdFBnuK94wX8xRhTTgmw==
X-Received: by 2002:a17:902:ecc5:b0:216:45eb:5e4d with SMTP id d9443c01a7336-21a83f4b29dmr369677175ad.6.1736895529901;
        Tue, 14 Jan 2025 14:58:49 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:49 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:43 -0800
Subject: [PATCH v2 18/21] RISC-V: perf: Add Qemu virt machine events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-18-8ba74cdb851b@rivosinc.com>
References: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
In-Reply-To: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Qemu virt machine supports a very minimal set of legacy perf events.
Add them to the vendor table so that users can use them when
counter delegation is enabled.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/vendorid_list.h |  4 ++++
 drivers/perf/riscv_pmu_dev.c           | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 2f2bb0c84f9a..ef22b03552bc 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -9,4 +9,8 @@
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
+#define QEMU_VIRT_VENDOR_ID		0x000
+#define QEMU_VIRT_IMPL_ID		0x000
+#define QEMU_VIRT_ARCH_ID		0x000
+
 #endif
diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 8c5598253af0..d28d60abaaf2 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -26,6 +26,7 @@
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
 #include <asm/vendor_extensions.h>
+#include <asm/vendorid_list.h>
 #include <asm/vendor_extensions/andes.h>
 #include <asm/hwcap.h>
 #include <asm/csr_ind.h>
@@ -384,7 +385,42 @@ struct riscv_vendor_pmu_events {
 	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map, \
 	  .attrs_events = _attrs },
 
+/* QEMU virt PMU events */
+static const struct riscv_pmu_event qemu_virt_hw_event_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= {0x01, 0xFFFFFFF8},
+	[PERF_COUNT_HW_INSTRUCTIONS]		= {0x02, 0xFFFFFFF8}
+};
+
+static const struct riscv_pmu_event qemu_virt_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
+						[PERF_COUNT_HW_CACHE_OP_MAX]
+						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10019, 0xFFFFFFF8},
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= {0x1001B, 0xFFFFFFF8},
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10021, 0xFFFFFFF8},
+};
+
+RVPMU_EVENT_CMASK_ATTR(cycles, cycles, 0x01, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(dTLB-store-misses, dTLB_store_miss, 0x1001B, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(iTLB-load-misses, iTLB_load_miss, 0x10021, 0xFFFFFFF8);
+
+static struct attribute *qemu_virt_event_group[] = {
+	RVPMU_EVENT_ATTR_PTR(cycles),
+	RVPMU_EVENT_ATTR_PTR(instructions),
+	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
+	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
+	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
+	NULL,
+};
+
 static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
+	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VIRT_IMPL_ID,
+				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
+				qemu_virt_event_group)
 };
 
 const struct riscv_pmu_event *current_pmu_hw_event_map;

-- 
2.34.1

