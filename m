Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CF1E522;
	Thu, 14 Aug 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184584; cv=none; b=tW/mZ0gGxbBJoh/7i3Nils1HRcI5BzKxEVdvizsXMCQ3SxRxAwwUtzIVTzwtHVFR5RZ7GKRDjcs9HG7AHvoJbW1KGZjtvZLL21gyGzKGfa4pwOFAVOp+/kR5TJArvAJsXjQ9vwjnCUKF/VijHHhNrbohkleXgi17NVs2pqNJv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184584; c=relaxed/simple;
	bh=xFaNBPd5xmGmmkpljvnBrEghjgv4yqpYGJ8MNUf++Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHvLwO0MtuHloH6FxlH+ZSbsCackA6qtkjUQnnEeIsSoExk4t9KrU51fqzhflstpearJ5lRMRMDGAiWqSwjsjAFHqP/SRecv8WGNfi9/228iuib6oVXFE/KN0IiHNwRTDYhixw9fE0OAnv8uV6VXBqu+dA+SBkBZ/03GFK5e0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581cd020so1535315ad.2;
        Thu, 14 Aug 2025 08:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184582; x=1755789382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eb4Pwt+4DlcYTmjaI/seSD+b8VboyEm5UlMbHZ6SHow=;
        b=Y9EXp/ffkL4dcHQzvHjKb7o2VFha0qs5gVojloYfxkQGq9pb/U081k3vLfo2dpui1x
         B6nDlYTsPadCiG4gB20CXq+35yqoPDy9+jhO3M80uDtueBH7IO9z0ewSvU/bDAZLrbDR
         xdvXbRuZ5PrJEbSEWe0qJy3OWgrkov0gkMdMysGJaQnPYVNYduXEm9qBJlf3qLFYwiXM
         bD7stxpaGgPD6ygz4ZHZ+pV0E5PKrQUzpIX8TqgS28vLQBBAgiw/blZQxpwKYKEtz9jX
         O8NuO37vBviugxLF2RcC3QNRgnwy6XK+p0Xu56yonCwA3wD0SY/pPPRcRsd4ItHuBUqT
         PPiw==
X-Forwarded-Encrypted: i=1; AJvYcCVTXaFhki9zHQ2LmpXYfKMCgv0DnWiUT1oAC6sX6qbSRklWlHne4DwxHz/LOUSnj7hkZZaah9JAX3s1xZ8=@vger.kernel.org, AJvYcCXatLONKHW7qE/ng/bTQL4TcZRxLOjJSnxhZZ+lEYvUg5JKLF2QrE+NF7y+t/tKbbuwORGdYUvtScEtNrPJXiILag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCJytXbluPEOKT7elT5F2Y72zFJQrSAQeZ/EcBe4RCOKg+hz7
	SR6XGZWu5+yTrXxA8sqdAmEVP99MjvluEDoct0LlOUIEB/4ugjYgAsr7
X-Gm-Gg: ASbGncs89YWxLD5Lgq2nKXKpldbC8lbumxEUbPg5+XEltBNW6ztViMgIOQyLZ3zt4mO
	YQUMJbNwWKnEZqsjOa6YuCrUdSWn7e3ojaGTHNljaaFEqRAtsien7UGNLFxv7d/iFOEC5bBa+6B
	F1IJV11u4wlujgZ3UwFEgWsRNwA8choYjKbKqhmFmw3BpqYUp8bcCk84OoKjqhLX2AUDMoRZlVV
	PxUJhGJ9IR8ZMCUfzoO5U83bi+VnqcwyAxbYBBIBjtlLckfc5/3hZ52k68zkYgUK/w/guCm765N
	HU0RGQ/t30WQZO07pMuBScDbmeb0AAlgfyp91IYzS00lIIpkhh4Yu6a6BYoDM6d/jEoYBgmnFd0
	P3rR7bRwn9EtQ
X-Google-Smtp-Source: AGHT+IFYf6c65S+ueeahtRG3nAVnc+xop3PDlfgKrPzWTagW5Fh/Eu2n1Xz11DqEF3h51G44eb5chg==
X-Received: by 2002:a17:903:1c5:b0:240:8fd6:f798 with SMTP id d9443c01a7336-2445851909amr23360095ad.4.1755184581749;
        Thu, 14 Aug 2025 08:16:21 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2430040122bsm72357495ad.59.2025.08.14.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:16:21 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	"Arnaldo Carvalho de Melo" <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] perf: arm64: Sync ESR_ELx_EC_* macros in arm64_exception_types.h with esr.h
Date: Thu, 14 Aug 2025 15:14:53 +0000
Message-ID: <20250814151452.618765-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update perf util arm64_exception_types.h to match the exception class
macros defined in tools/arch/arm64/include/asm/esr.h. This ensures
consistency between perf tooling and the kernel header definitions for
ESR_ELx_EC_* values.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 tools/perf/arch/arm64/util/arm64_exception_types.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/arch/arm64/util/arm64_exception_types.h
index 27c981ebe401..29931bf19062 100644
--- a/tools/perf/arch/arm64/util/arm64_exception_types.h
+++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
@@ -33,7 +33,7 @@
 #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
 /* Unallocated EC: 0x0A - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
-/* Unallocated EC: 0x0d */
+#define ESR_ELx_EC_BTI		(0x0D)
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
@@ -46,7 +46,10 @@
 #define ESR_ELx_EC_SYS64	(0x18)
 #define ESR_ELx_EC_SVE		(0x19)
 #define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
-/* Unallocated EC: 0x1b - 0x1E */
+/* Unallocated EC: 0x1B */
+#define ESR_ELx_EC_FPAC		(0x1C)	/* EL1 and above */
+#define ESR_ELx_EC_SME		(0x1D)
+/* Unallocated EC: 0x1E */
 #define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
 #define ESR_ELx_EC_IABT_LOW	(0x20)
 #define ESR_ELx_EC_IABT_CUR	(0x21)
@@ -55,7 +58,7 @@
 #define ESR_ELx_EC_DABT_LOW	(0x24)
 #define ESR_ELx_EC_DABT_CUR	(0x25)
 #define ESR_ELx_EC_SP_ALIGN	(0x26)
-/* Unallocated EC: 0x27 */
+#define ESR_ELx_EC_MOPS		(0x27)
 #define ESR_ELx_EC_FP_EXC32	(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
 #define ESR_ELx_EC_FP_EXC64	(0x2C)
-- 
2.50.0

