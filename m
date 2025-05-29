Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D44290D8C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518408; cv=none; b=Qtap8i41NxzM/kIXotG2n7qGuVkNCp8jBOM9CqZDMMnKJ+Y8jjMvnsDdHMXhC7/BXmcQPSIU+cKBiiriObSxHhWeOaPh4zgdlF0apxKsQIWxUeAodm4BfqQ6U7pDb1qNuHG3LhKmwHX037hT9ozET66EeH8XLRzXHUrHNCENIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518408; c=relaxed/simple;
	bh=E1yjj826OV2i042EqOElXmFPrF8pEcz4phQ8lctqMVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwMo3CmHOtv8etGyPiXt+Z4yRWMhEr7LmFosMdlBDe4MQIF3bxN345W21PpuoOFvtnWkhBU+0zXAWhY7GGEl/EM4Kgfr2EK0wht16vsJVBHBTkmrnLGEF6BzwZVc2OynaMkESKDzztz/KwJEkX0Dcvve/nSWwFexSU/OvaX/fDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fc/RZXSL; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc/RZXSL"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-450d37d4699so1640865e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748518404; x=1749123204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxG8SPa3uepeFqsoLKl29LMbTYOpGZ70IvRiGVenFk8=;
        b=fc/RZXSL81pqAVuRokshOxMxcYWZPGbMkL3muIio9Dvd6yqD3m5YvT8YjprFDKmJCI
         oD9+co81lsqxx7AkJiZOZuvn42vzDjtB5XDbebiIkjCZBpXGyVrn3e1J4hoSzEXd7CV6
         xfkZMPoNdkbtUxSRvq5BH7vbqOJhK2fTCoprUFj6HOg++WTFA8KVT7OcQE3Me7S0ma08
         ivpTRaWhP0ImFUQ/bydvrGAONHsoCt8fgduU4mGHggP3vw5hxwm+VX/HUrN/s18qPQoy
         z80cJw8lY50SFe1i5pNgjhwONJ4C4m5HBEwFiJoo0FUoJjz/eY9HsWne2zJJeQgus3/+
         25Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518404; x=1749123204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxG8SPa3uepeFqsoLKl29LMbTYOpGZ70IvRiGVenFk8=;
        b=VxBYegdr1wAQl3osTnHZw5Ow+dEJfF9j/QupXrhjRb1mPrVrSP4bN7+oJRCCTDoIXr
         sbm0G0qAz+fk85pw6gNEQy3AMKyhEwqv6j44WvuB3koGiMd1As+NIxZYzmpCxnv9kkju
         88rfdfM+a0ZRcNDNKwCdF4F6guIp5UEijJek56GNmyVnuQU190qKFBq0p28fmIWLAuqG
         3Ofd6KhWvFBvXx/oqZnwl0hamqxxaDxxEasMKrvLKcR0Bbb4ywc/RWVEW6/xGmQLoDAJ
         DvbsR1pmiv1Sp69y7McW/2fANdof0JtO5M4E7VvYxzEoRJPkfjzAryQeFB4Pire+1Foz
         KUsg==
X-Forwarded-Encrypted: i=1; AJvYcCVN3opcoqNy1CR41rgauXGVKnY8g/iyoVe1fxDF+lcApOtTfa3gAQVPCiAIKC1uauhSPnt+IBuIs2cFxTncvmhO@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYPu1V2y6JAYrfp9pU11qPQ9zOFVhYgpBecm24iuI2R3OMMkx
	od1t4p9qDgf6mrrGHIpn22oONhdyHTz6uF7IwG1IgwS/yw9mm5jgiAwVy9Qm3DfukpT1lAeIyKF
	k39tWJCBId7Ny
X-Gm-Gg: ASbGncvVWjR8jq3WSK3S8lHMQPtexQiLM21eckyJsIlLWt/sacv8eQeNPp5buxCHeKt
	WWEk6BRSWedKRTbaOmsxuOnf95Rg046BoTko/UItrBQoDtpcUnR1PQUf3XI02tL1RTKYI0WzrMB
	qR8zfNfqAl4BKwYSIy67SwI4CbGO+W5uGlUlb060N8B/AyR3V94H7w9dypOyIKK+deXEUwQRq9e
	8cjXSHL2zxYUinQLHhEflDtDMhdGXpqwer8bMgjtrPcfvr+qXN5VLLSX8E1olNA8jxMdwWWb1q+
	pp2UwZeQKVrlIMGrqBRKIeBANOKm4Cz0qtuo6aHpJkAXriR7dmk6mdLkUP+D
X-Google-Smtp-Source: AGHT+IFa3tbBIinQlu5QLSXdztzNSxtKZbpAOFxf4JVhGWyoTyRCcEYjmPGyAmzQyVI8/KRfEZZhCw==
X-Received: by 2002:a05:600c:6749:b0:44b:eb56:1d48 with SMTP id 5b1f17b1804b1-45072545a0fmr59959615e9.4.1748518404390;
        Thu, 29 May 2025 04:33:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc3785bsm17443945e9.40.2025.05.29.04.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:33:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 29 May 2025 12:30:32 +0100
Subject: [PATCH v2 11/11] perf docs: arm-spe: Document new SPE filtering
 features
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-james-perf-feat_spe_eft-v2-11-a01a9baad06a@linaro.org>
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
so document them. Also document existing 'event_filter' bits that were
missing from the doc and the fact that latency values are stored in the
weight field.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 97 ++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..4092b53b58d2 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -141,27 +141,65 @@ Config parameters
 These are placed between the // in the event and comma separated. For example '-e
 arm_spe/load_filter=1,min_latency=10/'
 
-  branch_filter=1     - collect branches only (PMSFCR.B)
-  event_filter=<mask> - filter on specific events (PMSEVFR) - see bitfield description below
+  event_filter=<mask> - logical AND filter on specific events (PMSEVFR) - see bitfield description below
+  inv_event_filter=<mask> - logical OR to filter out specific events (PMSNEVFR, FEAT_SPEv1p2) - see bitfield description below
   jitter=1            - use jitter to avoid resonance when sampling (PMSIRR.RND)
-  load_filter=1       - collect loads only (PMSFCR.LD)
   min_latency=<n>     - collect only samples with this latency or higher* (PMSLATFR)
   pa_enable=1         - collect physical address (as well as VA) of loads/stores (PMSCR.PA) - requires privilege
   pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
-  store_filter=1      - collect stores only (PMSFCR.ST)
   ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
   discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
+  data_src_filter=<mask> - mask to filter from 0-63 possible data sources (PMSDSFR, FEAT_SPE_FDS) - See 'Data source filtering'
 
 +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
 than only the execution latency.
 
-Only some events can be filtered on; these include:
-
-  bit 1     - instruction retired (i.e. omit speculative instructions)
+Only some events can be filtered on using 'event_filter' bits. The overall
+filter is the logical AND of these bits, for example if bits 3 and 5 are set
+only samples that have both 'L1D cache refill' AND 'TLB walk' are recorded. When
+FEAT_SPEv1p2 is implemented 'inv_event_filter' can also be used to exclude
+events that have any (OR) of the filter's bits set. For example setting bits 3
+and 5 in 'inv_event_filter' will exclude any events that are either L1D cache
+refill OR TLB walk. If the same bit is set in both filters it's UNPREDICTABLE
+whether the sample is included or excluded. Filter bits for both event_filter
+and inv_event_filter are:
+
+  bit 1     - Instruction retired (i.e. omit speculative instructions)
+  bit 2     - L1D access (FEAT_SPEv1p4)
   bit 3     - L1D refill
+  bit 4     - TLB access (FEAT_SPEv1p4)
   bit 5     - TLB refill
-  bit 7     - mispredict
-  bit 11    - misaligned access
+  bit 6     - Not taken event (FEAT_SPEv1p2)
+  bit 7     - Mispredict
+  bit 8     - Last level cache access (FEAT_SPEv1p4)
+  bit 9     - Last level cache miss (FEAT_SPEv1p4)
+  bit 10    - Remote access (FEAT_SPEv1p4)
+  bit 11    - Misaligned access (FEAT_SPEv1p1)
+  bit 12-15 - IMPLEMENTATION DEFINED events (when implemented)
+  bit 16    - Transaction (FEAT_TME)
+  bit 17    - Partial or empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 18    - Empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 19    - L2D access (FEAT_SPEv1p4)
+  bit 20    - L2D miss (FEAT_SPEv1p4)
+  bit 21    - Cache data modified (FEAT_SPEv1p4)
+  bit 22    - Recently fetched (FEAT_SPEv1p4)
+  bit 23    - Data snooped (FEAT_SPEv1p4)
+  bit 24    - Streaming SVE mode event (when FEAT_SPE_SME is implemented), or
+              IMPLEMENTATION DEFINED event 24 (when implemented, only versions
+              less than FEAT_SPEv1p4)
+  bit 25    - SMCU or external coprocessor operation event when FEAT_SPE_SME is
+              implemented, or IMPLEMENTATION DEFINED event 25 (when implemented,
+              only versions less than FEAT_SPEv1p4)
+  bit 26-31 - IMPLEMENTATION DEFINED events (only versions less than FEAT_SPEv1p4)
+  bit 48-63 - IMPLEMENTATION DEFINED events (when implemented)
+
+For IMPLEMENTATION DEFINED bits, refer to the CPU TRM if these bits are
+implemented.
+
+The driver will reject events if requested filter bits require unimplemented SPE
+versions, but will not reject filter bits for unimplemented IMPDEF bits or when
+their related feature is not present (e.g. SME). For example, if FEAT_SPEv1p2 is
+not implemented, filtering on "Not taken event" (bit 6) will be rejected.
 
 So to sample just retired instructions:
 
@@ -171,6 +209,31 @@ or just mispredicted branches:
 
   perf record -e arm_spe/event_filter=0x80/ -- ./mybench
 
+When set, the following filters can be used to select samples that match any of
+the operation types (OR filtering). If only one is set then only samples of that
+type are collected:
+
+  branch_filter=1     - Collect branches (PMSFCR.B)
+  load_filter=1       - Collect loads (PMSFCR.LD)
+  store_filter=1      - Collect stores (PMSFCR.ST)
+
+When extended filtering is supported (FEAT_SPE_EFT), SIMD and float
+pointer operations can also be selected:
+
+  simd_filter=1         - Collect SIMD loads, stores and operations (PMSFCR.SIMD)
+  float_filter=1        - Collect floating point loads, stores and operations (PMSFCR.FP)
+
+When extended filtering is supported (FEAT_SPE_EFT), operation type filters can
+be changed to AND using _mask fields. For example samples could be selected if
+they are store AND SIMD by setting 'store_filter=1,simd_filter=1,
+store_filter_mask=1,simd_filter_mask=1'. The new masks are as follows:
+
+  branch_filter_mask=1  - Change branch filter behavior from OR to AND (PMSFCR.Bm)
+  load_filter_mask=1    - Change load filter behavior from OR to AND (PMSFCR.LDm)
+  store_filter_mask=1   - Change store filter behavior from OR to AND (PMSFCR.STm)
+  simd_filter_mask=1    - Change SIMD filter behavior from OR to AND (PMSFCR.SIMDm)
+  float_filter_mask=1   - Change floating point filter behavior from OR to AND (PMSFCR.FPm)
+
 Viewing the data
 ~~~~~~~~~~~~~~~~~
 
@@ -204,6 +267,10 @@ Memory access details are also stored on the samples and this can be viewed with
 
   perf report --mem-mode
 
+The latency value from the SPE sample is stored in the 'weight' field of the
+Perf samples and can be displayed in Perf script and report outputs by enabling
+its display from the command line.
+
 Common errors
 ~~~~~~~~~~~~~
 
@@ -247,6 +314,18 @@ to minimize output. Then run perf stat:
   perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
   perf stat -e SAMPLE_FEED_LD
 
+Data source filtering
+~~~~~~~~~~~~~~~~~~~~~
+
+When FEAT_SPE_FDS is present, 'data_src_filter' can be used as a mask to filter
+on a subset (0 - 63) of possible data source IDs. The full range of data sources
+is 0 - 65535 although these are unlikely to be used in practice. Data sources
+are IMPDEF so refer to the TRM for the mappings. Each bit N of the filter maps
+to data source N. The filter is an OR of all the bits, so for example setting
+bits 0 and 3 includes only packets from data sources 0 OR 3. When
+'data_src_filter' is set to 0 data source filtering is disabled and all data
+sources are included.
+
 SEE ALSO
 --------
 

-- 
2.34.1

