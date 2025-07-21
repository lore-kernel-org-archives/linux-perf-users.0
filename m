Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E872D948A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103129; cv=none; b=TbuHx4EFhuLWbQXA2nI6wd/wQKZs3/YXypK+wTsxuqdCTd5JEm5Voyvuc0BqbClx1Zyyw1EK0E9WnGI7fP1l1Q+KKAdlXGBfybv4uoKescmQgidBot8Cis8qXB6+FmaseTTe4xd0rUUTOhyWP4Whhypm9/V1Rjr4U3cdVtCow1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103129; c=relaxed/simple;
	bh=aRUWGynzXd2I0iPJ8E252lMe7rGfIx7dGynoHirUSWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYyY/9vEbmHV6xcAui6f3tkwORp+ay66gJHJAuMYZYTWGve6muuuAmyaUnCFp828Ue+1Zb1TQm3dtiNS1A3FfL529z3v+bLxH+m/xyVKp7yk5chcuCxYw7KlHD/YffKH/IkapjHakOCYKFrK2UJIHassz4MoBa1coiI90Lfywns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlXATXpj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlXATXpj"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54700a463so2408677f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103126; x=1753707926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJMmlptoopG7uLnpNHx3BFeWdRFU3hEImM+p7yUrZvk=;
        b=ZlXATXpj8cv2N2JOljaVFdsZZZX4/EsoydpSkAoJe8/1kVG0ahyVfrwaQnRxIyLU5S
         NIYhZqzgofY2hVSHcBDk2Na1EoC97wGyxFWEQG9GZ9XPjNyO1GUv8YhAHe/j2dWI1SCk
         jGCUYeLz7AxGLNiuW5tMtCi5f03iQJNu4ZAOTBE3ao4h+1VE7l/dSefne5S++ufftstA
         gJTyzZ5tzvKzdW9v154gC4ERfH4TJZXpqdPn0+I3gk1FdbC80krGePc/d60QYQQWVGkA
         fVU3JVR0101CJNVLuKbM3ExWcSYTOvIQf/+itJzAWBbfVBFnCuDcmDbVXjZajk26Pw1C
         ZjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103126; x=1753707926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJMmlptoopG7uLnpNHx3BFeWdRFU3hEImM+p7yUrZvk=;
        b=Alu07UwTQUUuaVPMoGdWUOomLcynMtXId2yqzFxvCc4AF123BWzKRtVBGIMAxkctK9
         NxdB9T9vaxma+UjcdHqgWKX9k3hb7OHM8YIOF0cRjkadeJBHHckIwqkZ+isHYofWzXyI
         3AHf63zI9hpvXzIIAS0IuVJDUf/OCVUizaA/t1GhKGI+0X06XGn6ZKRfUzX+31GVR7DJ
         K246Ez6JUwDXA7XncJUCLqnXgUe1Wga15w76TcMkkV/6uk2+3OqxzQyt9ZB3TEm0afen
         +gJ6Fqt3yyZFtij6+HSab8ya4/J39aUmFTb+ROrHDTEn7uJy6ASyl4c7PW/O4QE+v4ZC
         C/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEn4V6i9DQiWdj/oSrI/q07nk+8Q4MF2/qOnqiYtMuSPT8CSS7T2q/j4M7rEsOYxCjsauI2dKKtkAoSIztTw2r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QpHy6iUVc/uJCLknlRzeOwg+t5PPPblD03qxvoNbpG+Ov7bH
	YWeQDypAErFSwX2r++C/8OfNPIHhexcfWg7VZ5biWiVTQYyKO8wpNQprKOmvmtbXUok=
X-Gm-Gg: ASbGncugNh0lxAIF0m8kTOSjLAnz/3AAWVbo9JGe6K2gzOTaCmyztdTTSNkRQXsMgWG
	Al0p5V5zoJHi/BCBfVmAD+Hy7hwD4DiV1wF++XCe2KUfF4hNzk0K5KUA30d0PGZm06abZqTl2g/
	87dhO+0gRm6oviYREXrNfytCCXvD0qHEYhz9eUnLxEvD/8b8nr1ZZOioF5bUkuIeLo+0Ue1zzx6
	YrQwNU7tqHXmJdjF51quRLF09hAnoMPGlrg0I5QfqBre9JdBtABQImTGLhwJq1/wI7dzt1pRK8/
	1VEEDuMnd+8Ya6Oe4TPijEgnlPGI4PE112Db4aUBCGfyjKRJbl1sCxYqy6gaQDgE+CeANiQ0YCZ
	3hnOx8Trj7gKcJmcboWc4kr3oDgI03OU=
X-Google-Smtp-Source: AGHT+IEQRxB7CE+HdieDcueXWljG81gay0nli7hyPKWhyc70neAo7UklcQhq3PGP9NmaS8BVDvp06g==
X-Received: by 2002:a5d:64c4:0:b0:3a4:e231:8632 with SMTP id ffacd0b85a97d-3b613abe2c2mr14295215f8f.12.1753103126134;
        Mon, 21 Jul 2025 06:05:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:06 +0100
Subject: [PATCH v5 12/12] perf docs: arm-spe: Document new SPE filtering
 features
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-12-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
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
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
so document them. Also document existing 'event_filter' bits that were
missing from the doc and the fact that latency values are stored in the
weight field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 104 +++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..c7d1032ff219 100644
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
 
@@ -247,6 +314,25 @@ to minimize output. Then run perf stat:
   perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
   perf stat -e SAMPLE_FEED_LD
 
+Data source filtering
+~~~~~~~~~~~~~~~~~~~~~
+
+When FEAT_SPE_FDS is present, 'inv_data_src_filter' can be used as a mask to
+filter on a subset (0 - 63) of possible data source IDs. The full range of data
+sources is 0 - 65535 although these are unlikely to be used in practice. Data
+sources are IMPDEF so refer to the TRM for the mappings. Each bit N of the
+filter maps to data source N. The filter is an OR of all the bits, and the value
+provided inv_data_src_filter is inverted before writing to PMSDSFR_EL1 so that
+set bits exclude that data source and cleared bits include that data source.
+Therefore the default value of 0 is equivalent to no filtering (all data sources
+included).
+
+For example, to include only data sources 0 and 3, clear bits 0 and 3
+(0xFFFFFFFFFFFFFFF6)
+
+When 'inv_data_src_filter' is set to 0xFFFFFFFFFFFFFFFF, any samples with any
+data source set are excluded.
+
 SEE ALSO
 --------
 

-- 
2.34.1

