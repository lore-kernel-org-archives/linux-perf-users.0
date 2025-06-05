Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2F255F3B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120622; cv=none; b=A3pvdz7nroYNEP3ACRm3DhvPbfHeGjzsxCHodXI2t4SnG+a20LzFAhqTtn9oB0QwzjheuIUJn2cHsnrFCZs95zG2Ta1Da7eR+7TJJZXd7bfWQ2HP061Gmetsti1Abv1WtCanDi8enZCIqXW6xd/XbfDwCp8aQbbcjXUt7Lncd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120622; c=relaxed/simple;
	bh=MMFbkI7zMPzBdRBdPQfb7pTJMjgrsMrJkf8SuH2PcGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkMo8EBNKEh9Kh5xPX9x0xfwtA6gXN71jLU8COXf4HGOQ5mWvTDMbL7KV8sYH1G0i1zYaJn9GqqoWCNUsPje6woc5bhJtofAP5+Az44xDgsvqs0Vv6yhG9oiQTED1Amxj/RdhG2mj+gHDYY94zFVbZpOKKEC/MHOBFgZFTjQ6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5Yneaw9; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5Yneaw9"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so5242135e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120618; x=1749725418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYtpnIAkK3WcCc9sKEGdtsuC5KifjqgSXfNa01d683g=;
        b=s5Yneaw9KHvOhvd1NjYXiRndEXnRicPmtfIvSUpJbU4CCeD8zAHMw05ghUhtLD+CN9
         04gMz20XVIlaXkPYZ6p6u/AFHBvE83BFdOmbcqUrZGCsksipl/+FssurC3dVPFIH2n/7
         5AwcwzvmEQwUH9MjBGot+IjCqn+ovnNFszmQ5f17cijwjM2N+cEuIDD6TshMxKVX4JYl
         gqsAkETajdXLmeBDTn/ahpqkei0SopherOOmOj37Gg8H2XO53TW69UoalfV4asZbQ1p/
         bZyDiXQC2cTwyMrj402S5bLSVBYAhHj29o2DKqQToy1j/YsxvvQTiMavQytnkwUv7mbx
         pvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120618; x=1749725418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYtpnIAkK3WcCc9sKEGdtsuC5KifjqgSXfNa01d683g=;
        b=Mv6icX04PIFySC93TSJkhUHlgk1FO3yjb9YP/Q+E9/+VrEMp4d0YDbsA+DhY5cEDn2
         JM5ywT8LJR8ITUOFyxUq7JLObzBhWPDImKbPL+ZBmvlPjBcbIcJZEczEVrJ30bLU406A
         3jGXoLcwHulpQHdrPPdwp5m+WfSPiHtqzeEASNXEitRdStd4dSvUz/AqKRcqaK/Xgmn2
         Z4ovvjId6v6qRWIM2Dmi+ApMwVWaiz5Rq12lE3s9RPPhSgaDcl1+ZkfAKjNZUzQnKNFq
         KVj+I5wdECmZDbXQWvalOscgcEO+3qtkNtPbZ0zpLp5TE1URwTsVzn0uPmzxN9bYAwOG
         2/HA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kNRt2YYHZNrfA0tLEaLEcnmVbBj3LU6j0SC99Uzvmy/4gmPVZswiYcej3PbFNkYMPffNBv5B7qsQoUfqLml1@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV0BP4NTR/XPWHNHY8RYNOpGTHKi2oNLmk6ZZm+7r2O4NT7NB
	J3lQWFDwm8hkgPEy6fqR53To6C/ITo7sstgDrVZZqBQiQeSVcJaKzabpN8THeSKYmYY=
X-Gm-Gg: ASbGncvwjJ83HfhgnwHMIXlU4OI3xZA9LT2pGQYCLBSNh8vwnJvlM90e1EfVeSN5WG/
	cGEtAg1cH0rVeIgkaEU6KO6Lte7EjNLZuKpcnoKnD3x4NLqbxusdkrmH+cpXKldBXopMSokJdhq
	aEn1SC1McB8v2/gK7/N2DwcClRBPSqZCgxlieabyjlto7i1xZmTQtortflpfgTTMDbryMmvDulW
	jwTc+prpqrIBrUc3mV4mViA4bMvxKKsUmLytydTxJduq/JUXRJrx72+dww5liTg+yEbh+ojanxJ
	leWQo1A++ZSN53QSo39V7PhJD6H6nZcMtvxt1Y3vIRgGXewXGr3enAFLOEbc
X-Google-Smtp-Source: AGHT+IF209QtdWKQIFSgWNU834ITMWh9f6gxkjT2rjm5O4GQe4Nyl3IJTR6vikF94ywt0/mEA5L8wg==
X-Received: by 2002:a05:600c:548d:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-451f0b20d15mr54093555e9.27.1749120617749;
        Thu, 05 Jun 2025 03:50:17 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20629965e9.23.2025.06.05.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:50:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Jun 2025 11:49:08 +0100
Subject: [PATCH v3 10/10] perf docs: arm-spe: Document new SPE filtering
 features
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-james-perf-feat_spe_eft-v3-10-71b0c9f98093@linaro.org>
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
so document them. Also document existing 'event_filter' bits that were
missing from the doc and the fact that latency values are stored in the
weight field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
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

