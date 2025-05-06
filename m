Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8727E7C3
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531770; cv=none; b=unD3fgUuEtFppsbxIPBYE6dDaPFv4KzpjDijHxxMinXRxGtsUymEZUDfipwxTZb2IQzV/7gNs3FXqRuB0fy8FtyWnFjBf8q4vuELntrdSqT833y6fb7uyKBvtdZc52dMHi9jJZaPaH2o4bVj/IQbj3xQAi1HY8v36qHikWMeabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531770; c=relaxed/simple;
	bh=3sMCtIotqVivKM8/Ownc6QdZfz5Z6QLgO4uRyf0+zJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1cExTa55JuHqurS36ct6AxF4W5ZaPjBT8s+zsvJHiZovOTmoaSFgXRgDyC9I95jeaWAszgJ5EWdEoCyZMtB1oUR23SN3ZMSpfOH1oS81w6vn25/HW380JkQ8apzQ86VV+o2D+gQ0RNiVoAGHJ8z/i7Zj1Q+Wjex1mHQ9xL5EvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NF/UOpOR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NF/UOpOR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3423392f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531766; x=1747136566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkqHrlk5rXmqQcmnUyYZSiZOvHTWZlNV/KJqAn/HjmE=;
        b=NF/UOpOR9/Y1yHivouHxWA1bycM4PJz1GMQW4ZMbBMjkQptY+WJUuyPp6DrscHkgjK
         lus9ZUr2ptqsPJ5IOh1cJCxZ4NLQCLonGHLtPjHeBxATzD1BpO29sRrCWIzaDJi17mAq
         U8tURzjpS5cYL0vD4HMYoDKAMBJDF3gv/nK9YMexY4T6luEhtPiSlsanKv4dWy36iPeC
         Jq5XgalsE021B/B6c77gDMolKuroDOunGAWVNmsK6H2s23PiXRrRiG4Bb894bJl8vxL4
         Z3i4xSAF+EunxHg8YoVyf+sAkmCjl4TusSlRE0ISqiqZtOr8IwtvBv/qeBrhHv9e+r8C
         kuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531766; x=1747136566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkqHrlk5rXmqQcmnUyYZSiZOvHTWZlNV/KJqAn/HjmE=;
        b=ox9764H2Q+23ozdK/vxVt9Q4K89nhTIPR8EAy8OpCnxtjwZP0YcUQ3EYaRZZvtg50r
         2z6Imk/9kGhQRoPOA/XfpaseMw8mayzZ5EWhe+AlYpwnhGOSl9IQ+X2K5J+iGoAWBjZG
         neWSk9qFBSxd3ZxXcWVZ0rdXiI7YJq8HHtDpNyiNu/nNhcKmbCGhanpTR0H7c3IqAzpm
         6sqpG7NCMxp+GhMzcg/7Gcuar7SAApBuKBKRhO1m2nMAiPQ4aQ0Y3rGACz7pISjhBwQZ
         BkrsmzYIrYRGq6gNDLOZ3Sh34AWTdWOZ8gg2gg3Yh5jagIKl4vWjat/yCWky43zM6XhI
         +QPg==
X-Forwarded-Encrypted: i=1; AJvYcCVy5NqInHd1SJ93aFwLqwpAPnaqGa5iEAQRpSg3w2PrfgItbg1sT86ceB6xw6AjPrhuLuGpLPhswTTfykWigeeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEPvPDkEtZPcrhAbtTREMG1zWxZvQZJke2NGzfz8WDsMeA3ec
	vSFXBXGsDwDz2H+4EBN99sDX6EUSYgemKaFiGFDZScqV0dubZ+hm8W30GoxXvXo=
X-Gm-Gg: ASbGncsoUTxunMML3G5EpTwxeWJ+yIBAjKSLhmzw2hQrHLKShHxuki6Gr0lCqTQj4Od
	IXmWN8qIR84rxO+/cA4ggaNl5u2s/ghdKZKisHePw1elxCIC7lVf9ZAwsCzpnRmxNAS2BzAyXP4
	V4dI2sDC/pKM2vqhDTk5Pbe934UStE6wjPbCy713gwyUXEM/w+bddrwM5jM5ST6bKFcu/1WvM1d
	PXD0A7BUlKgcc8V0bE0VA9SUL9rEzuGxMVaXkgaOwAg2RH+NOXKsUP6iT0zWtiyjVqpBR9rBulr
	P+X4E8ztVc5HhdNHx72CpTIOfRw57dZ5bJ7zYnQS8ASg8UY=
X-Google-Smtp-Source: AGHT+IGUvZmO1ysjfj2110bUiJ8J7jVXWaXvMQnsa2Hz+uClfkGhq0fClzub1N37FV3ldFVqBc7yhA==
X-Received: by 2002:a05:6000:2287:b0:391:3f4f:a169 with SMTP id ffacd0b85a97d-3a0ac0ec06fmr2094137f8f.32.1746531765765;
        Tue, 06 May 2025 04:42:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 May 2025 12:41:42 +0100
Subject: [PATCH 10/10] perf docs: arm-spe: Document new SPE filtering
 features
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-james-perf-feat_spe_eft-v1-10-dd480e8e4851@linaro.org>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
In-Reply-To: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14.0

FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
so document them. Also document existing 'event_filter' bits that were
missing from the doc and the fact that latency values are stored in the
weight field.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 86 ++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..a90da9f36d93 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -141,27 +141,60 @@ Config parameters
 These are placed between the // in the event and comma separated. For example '-e
 arm_spe/load_filter=1,min_latency=10/'
 
-  branch_filter=1     - collect branches only (PMSFCR.B)
-  event_filter=<mask> - filter on specific events (PMSEVFR) - see bitfield description below
+  event_filter=<mask> - logical AND filter on specific events (PMSEVFR) - see bitfield description below
+  inv_event_filter=<mask> - logical AND to filter out specific events (PMSNEVFR, FEAT_SPEv1p2) - see bitfield description below
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
+Only some events can be filtered on using 'event_filter' bits. The overall
+filter is the logical AND of these bits, for example if bits 3 and 5 are set
+only samples that have both L1D cache refill and TLB walk are recorded. When
+FEAT_SPEv1p2 is implemented 'inv_event_filter' can also be used to filter on
+events that do _not_ have the target bit set. Filter bits for both event_filter
+and inv_event_filter are:
 
-  bit 1     - instruction retired (i.e. omit speculative instructions)
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
+  bit 16    - FEAT_TME transactions
+  bit 17    - Partial or empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 18    - Empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 19    - L2D access (FEAT_SPEv1p4)
+  bit 20    - L2D miss (FEAT_SPEv1p4)
+  bit 21    - Cache data modified (FEAT_SPEv1p4)
+  bit 22    - Recently fetched (FEAT_SPEv1p4)
+  bit 23    - Data snooped (FEAT_SPEv1p4)
+  bit 24    - Streaming SVE mode event when FEAT_SPE_SME is implemented, or
+              IMPLEMENTATION DEFINED event 24 (when implemented)
+  bit 25    - SMCU or external coprocessor operation event when FEAT_SPE_SME is implemented, or
+              IMPLEMENTATION DEFINED event 25 (when implemented)
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
 
@@ -171,6 +204,29 @@ or just mispredicted branches:
 
   perf record -e arm_spe/event_filter=0x80/ -- ./mybench
 
+When set, the following filters can be used to select samples that match any of
+the operation types (OR filtering). If only one is set then only samples of that
+type are collected:
+
+  branch_filter=1     - Collect branches (PMSFCR.B)
+  load_filter=1       - Collect loads (PMSFCR.LD)
+  store_filter=1      - Collect stores (PMSFCR.ST)
+
+When extended filtering is supported (FEAT_SPE_EFT), operation type filters can
+be changed to AND and also new filters are added. For example samples could be
+selected if they are store AND SIMD by setting
+'store_filter=1,simd_filter=1,store_filter_mask=1,simd_filter_mask=1'. The new
+filters are as follows:
+
+  branch_filter_mask=1  - Change branch filter behavior from OR to AND (PMSFCR.Bm)
+  load_filter_mask=1    - Change load filter behavior from OR to AND (PMSFCR.LDm)
+  store_filter_mask=1   - Change store filter behavior from OR to AND (PMSFCR.STm)
+  simd_filter_mask=1    - Change SIMD filter behavior from OR to AND (PMSFCR.SIMDm)
+  float_filter_mask=1   - Change floating point filter behavior from OR to AND (PMSFCR.FPm)
+
+  simd_filter=1         - Collect SIMD loads, stores and operations (PMSFCR.SIMD)
+  float_filter=1        - Collect floating point loads, stores and operations (PMSFCR.FP)
+
 Viewing the data
 ~~~~~~~~~~~~~~~~~
 
@@ -204,6 +260,10 @@ Memory access details are also stored on the samples and this can be viewed with
 
   perf report --mem-mode
 
+The latency value from the SPE sample is stored in the 'weight' field of the
+Perf samples and can be displayed in Perf script and report outputs by enabling
+its display from the command line.
+
 Common errors
 ~~~~~~~~~~~~~
 
@@ -247,6 +307,16 @@ to minimize output. Then run perf stat:
   perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
   perf stat -e SAMPLE_FEED_LD
 
+Data source filtering
+~~~~~~~~~~~~~~~~~~~~~
+
+When FEAT_SPE_FDS is present, 'data_src_filter' can be used as a mask to filter
+a subset (0 - 63) of possible data source IDs. The full range of data sources is
+0 - 65 535 although these are unlikely to be used in practice. Data sources are
+IMPDEF so refer to the TRM for the mappings. Each bit N of the filter maps to
+data source N. The filter is an OR of all the bits, so for example setting bits
+0 and 3 filters on packets from data sources 0 OR 3.
+
 SEE ALSO
 --------
 

-- 
2.34.1

