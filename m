Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC933471E;
	Fri, 22 Aug 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874796; cv=none; b=ggwy8Kv09aYsl0Hz55K8V1NRfVCHMAC3tF/VUoThGL7lbWn6BPRQK1DEQ9Zid9d/AOyq7/rfTR2gHgKPDhkUem5eMpo0IQV7tRnezhv2fpSntRbJqlSOOIbWg2AdjqJ424a2dUd4pmzJFkeVittxz7/pLay0vE0tzUnWrYo/oR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874796; c=relaxed/simple;
	bh=/xCek3fDaugS9j14gmmxhpU2Pg36DmMgVepdkfNgU9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpW0irjR0GZ01T8bD8gtoh9ASV2d9bzV6sfXpnHmnr8Hb2QR0gSbUf4W8RsY1fJf8ovNiuJ57ReV0rRauTaP0E27zLZQNZzdzr14yWt7sgOY1Jz3KwI2asiBIKAH53DdAsSEWHU58zLYeAi6FhoT0hLrP23Sk9DwK4CR0x5aYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-770351ba0beso18459b3a.1;
        Fri, 22 Aug 2025 07:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755874794; x=1756479594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEvn+Gbfb0UDIIFxIedzzNWMkkwAYLkahWLt3v36TAg=;
        b=e6JT3PdJziEpew6zRgCOVLW6f7JmFQyQ4TfZcPtyEcwl2LSyWYTppWttHwiuJkQmls
         jYrOL4XLgdtdT6gAIkNicUelh4QMoRk4r9eXe11wA8F0/oqqiUo48Ey3IphtmJEaAnoY
         SV/+2gemVjo+SDIHChTsnGeXc/x7mY7CxhAUi0YipTxzYakiMrbb/XzUjVwwQdGjgF6U
         AAoCrX7T94F7IsPHzR2huM6JaMigjD2cevl0x5bGbG/9oQgVV73HWBth727KXW1IEvvB
         +Tr5OWt7+tCU1BnDyGP0A6V2JEbSRvcDjYwfbcbC2SNgQrVpYmpbUzjBmdy8wHQCXMvE
         8cog==
X-Forwarded-Encrypted: i=1; AJvYcCVn6ycQVJ8LXvaV0nY2H6HOVh7P/HkiwFHirlchqYhYxT05ybNeiSVlpl9vTL7W4Mhi7MoYvE3OcakaCq4=@vger.kernel.org, AJvYcCXHioK/JIgc9O0b05cUZT+ESVbeAD8jwt2R67vk8nKxZpTF9MT4V1q7xgR7kc8eZ/r18vv+feLdejcbSxF5qfy8uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4tTmUhBXKWDbPyhM3Ro2Z0dnCtFoYN1GzrRl93Fmyw2JgrBO
	V2x7VvRJ87CvDVkHlptMyCePm269Cpml8KwAGQJZ1W6eLAMV82lxKd+b
X-Gm-Gg: ASbGncuTMQO3R+YDJVZyVqPOpCczI9571+p7IjKE/xe5Tkw1UEocOMvYr3gK7Oy5Vt3
	LShpreu968C0vxrA0suvSVMDwaLaE3xXR7+R22YvLutPHHxO8nHMtLFvX4Qmp23//9JxHtJnrHi
	DVOrgP4aC+jg8T9BnkbVyua7+24l0We3xuEqxW3enSUUnRhbfadESA39QBuPcBp/oUbbL6r8/uJ
	5ZXFNtIFn0doEImu+OrBoKsN77wRUBpAz/3DyOb/DyhreF4doXDymW1Btc+YhZiRAgkx7WQoJ5j
	HlJ9SrsGk3GXCJfwnhK8mhqxq3tbHts0OlH8OCYebl6a50KkPASQ+T5rv379H/S7i7m1ZVoJqjh
	ytK8dpOlEE0KHv4cVb3dcV+2x9HIWnpiH2apB7Nll45rl+1nGMfCmPPX6Jopvc3duo29GVHh2dg
	Zm
X-Google-Smtp-Source: AGHT+IEdY6GYMUDXUE6DhIkIlb1bJoH8Ip1ND56GcMjAbMwyaSQzX1SxHfEzJmSA3OVl515mt8xfPQ==
X-Received: by 2002:a05:6a00:391f:b0:730:87b2:e848 with SMTP id d2e1a72fcca58-7702fb0043emr2208518b3a.5.1755874793688;
        Fri, 22 Aug 2025 07:59:53 -0700 (PDT)
Received: from Mac ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb477dsm184978b3a.17.2025.08.22.07.59.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 07:59:53 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v2] perf: arm64: Sync ESR_ELx_EC_* macros in arm64_exception_types.h with esr.h
Date: Fri, 22 Aug 2025 23:58:56 +0900
Message-ID: <20250822145855.53071-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.1
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

In v2, ESR_ELx_EC_OTHER and ESR_ELx_EC_GCS, which were missing in v1, were
included.

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 .../perf/arch/arm64/util/arm64_exception_types.h  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/arch/arm64/util/arm64_exception_types.h
index 27c981ebe401..bf827f19ace0 100644
--- a/tools/perf/arch/arm64/util/arm64_exception_types.h
+++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
@@ -31,9 +31,10 @@
 #define ESR_ELx_EC_FP_ASIMD	(0x07)
 #define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
 #define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
-/* Unallocated EC: 0x0A - 0x0B */
+#define ESR_ELx_EC_OTHER	(0x0A)
+/* Unallocated EC: 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
-/* Unallocated EC: 0x0d */
+#define ESR_ELx_EC_BTI		(0x0D)
 #define ESR_ELx_EC_ILL		(0x0E)
 /* Unallocated EC: 0x0F - 0x10 */
 #define ESR_ELx_EC_SVC32	(0x11)
@@ -46,7 +47,10 @@
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
@@ -55,11 +59,12 @@
 #define ESR_ELx_EC_DABT_LOW	(0x24)
 #define ESR_ELx_EC_DABT_CUR	(0x25)
 #define ESR_ELx_EC_SP_ALIGN	(0x26)
-/* Unallocated EC: 0x27 */
+#define ESR_ELx_EC_MOPS		(0x27)
 #define ESR_ELx_EC_FP_EXC32	(0x28)
 /* Unallocated EC: 0x29 - 0x2B */
 #define ESR_ELx_EC_FP_EXC64	(0x2C)
-/* Unallocated EC: 0x2D - 0x2E */
+#define ESR_ELx_EC_GCS		(0x2D)
+/* Unallocated EC: 0x2E */
 #define ESR_ELx_EC_SERROR	(0x2F)
 #define ESR_ELx_EC_BREAKPT_LOW	(0x30)
 #define ESR_ELx_EC_BREAKPT_CUR	(0x31)
-- 
2.50.1

