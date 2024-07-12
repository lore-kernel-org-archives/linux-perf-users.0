Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713916EBEE
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779769; cv=none; b=JKocxd4MhknQrTJJxuf+s8n2EQOfmNO37Ziw4Glw7XjCtm9rK+Wu4/OPttGlHYSGTrVEgXub4u9knD+6hTYsjw1Y8qJBQggzrNK2u5nCc8tCRGHwCNoyd+cyghzCcXrfdEjSGwivUsVpIp5pwvnIy8/ETPE0u0R/3Vt++o8Cw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779769; c=relaxed/simple;
	bh=poODv9RcudTQN+sJKIl7ULkys/ISBKMP07Fg5QudCtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqwZgpEI3yV0PlrZuGBqCDoZMQAjb9b833zaI7pNEMlmw2LEne9+bi84I8oUZfD+08HbfzLDj005Gu+YBlYKMVO7n8+/hCUoMhiTxAJXs+pnSepat/rXULHMmE1fNpKRyqRSls7r+5ran5ETBRs9UH5AyoInOozSxjzHqcSSRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3jsYZYp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3jsYZYp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so12285145e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779766; x=1721384566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+cqckU3PK/4oZg7w+6ZlVXIz08ibsuhvPsyHiAGTJU=;
        b=X3jsYZYpeKhmKoQ8yf+idJU1QVBss56pMgfcn7BwnIuouyONAoUnj+Yb4XjBX2BeDr
         iV4YDKGkjx/2ImrxSVqRnK7UhLchyRxpRpcZi/cwUmGPl2a5q0Z+DWwjTnYrchIiSZZq
         ORgEACAyKYF7VXJ/KIPEoInbSkZNiULXuRzyqbgb2oD64zr5Q6KV9TjY11DAhsh2L/kJ
         LpyV2K8akoW0Ig9n0+edyz40puGjIDbrpR2pf2xPxEq1w1s+oNM1JEh1faU928kTqhg/
         UTIRu/nnIDHmuEWCNCeeJPEwNeXWRDhbmM9V87V1IIIAQqasBf37KYfAlr6T0vFWWaqk
         UCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779766; x=1721384566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+cqckU3PK/4oZg7w+6ZlVXIz08ibsuhvPsyHiAGTJU=;
        b=mHVLPjYf2irGAs7kxQ/67rftj4QB01f55spAyfhbR2t0eiVhuG5l9SzM4e9K9Bn2Ef
         +546MFPN8foN8vJBNNhsJUkH2VEk3YSZaPQWzPrrk4MNSLY8iyAB4qOwKxLN4Xhsn2V3
         S4gYoGhMbKUlTJnmLF08xPVtb5QLmBQXYN/WBpR8spC2hX+Ye4FSrYEZuS3bSK61TVS1
         lux+gYFaXS2hvYZ6H6bRL+RIQh2E+2Q7x9pRlxC/74srdBrqriVQESJfse4qvTHq2PSm
         WEY0ulnSFKBZreniVync/vQr23b5NYHRkUa/vQNvm7ICCINey7yoODeqE5pl3TNO4t0B
         xcCw==
X-Forwarded-Encrypted: i=1; AJvYcCXQj9MdF/FSs4A8/EeBdWWWOKCyT8TD3jVXkf9wrYs43zBzC4y/KA/DrmpPA9nve5oF8mcRnKMJ+rs9GCMWD5Qr3lDlLGj+Zw0Nxg/IeqrYkQ==
X-Gm-Message-State: AOJu0Yxo7HnzP2rxKTy0/HAFzitoWNwTWv9YfXgaAn6f1eDb8xZH1Dxy
	VxxcQ26YkVBIxjpCAMpzduBCmwi/1NbkEehIKHFnswXRzUB08u6e29nbZBm9pJo=
X-Google-Smtp-Source: AGHT+IE+VB3WvOca9zdDx6Lys780musKRQG8QOG3x0Z34w+FsYxwd3eo3DXVQhPIsbF9WOcbW4gGhg==
X-Received: by 2002:a5d:588d:0:b0:367:f2ea:13e4 with SMTP id ffacd0b85a97d-367f2ea15eamr3674929f8f.32.1720779766060;
        Fri, 12 Jul 2024 03:22:46 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 08/17] perf: cs-etm: Add runtime version check for OpenCSD
Date: Fri, 12 Jul 2024 11:20:17 +0100
Message-Id: <20240712102029.3697965-9-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

OpenCSD is dynamically linked so although there is a build time check,
at runtime the user might still have the wrong version. To avoid hard
to debug errors, add a runtime version check.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/build/feature/test-libopencsd.c               |  4 ++--
 tools/perf/Makefile.config                          |  2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c     | 13 +++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h     |  1 +
 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h | 13 +++++++++++++
 tools/perf/util/cs-etm.c                            |  3 +++
 6 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 4cfcef9da3e4..d092a0c662f4 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <opencsd/c_api/opencsd_c_api.h>
+#include "cs-etm-decoder/cs-etm-min-version.h"
 
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 1.2.1 is required"
+#error "OpenCSD minimum version (OCSD_MIN_VER) not met."
 #endif
 
 int main(void)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..2d21be42820e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -141,7 +141,7 @@ endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
 endif
-FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
+FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS) -I$(src-perf)/util
 FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
 
 # for linking with debug library, run like:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b78ef0262135..5e1b4503aab1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -16,6 +16,7 @@
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
+#include "cs-etm-min-version.h"
 #include "debug.h"
 #include "intlist.h"
 
@@ -835,3 +836,15 @@ const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
 {
 	return decoder->decoder_name;
 }
+
+int cs_etm_decoder__check_ver(void)
+{
+	if (ocsd_get_version() < OCSD_MIN_VER) {
+		pr_err("OpenCSD >= %d.%d.%d is required\n", OCSD_MIN_MAJOR,
+							    OCSD_MIN_MINOR,
+							    OCSD_MIN_PATCH);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 12c782fa6db2..2ec426ee16dc 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -107,5 +107,6 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
 const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder);
+int cs_etm_decoder__check_ver(void);
 
 #endif /* INCLUDE__CS_ETM_DECODER_H__ */
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
new file mode 100644
index 000000000000..c69597e9d0af
--- /dev/null
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef INCLUDE__CS_ETM_MIN_VERSION_H__
+#define INCLUDE__CS_ETM_MIN_VERSION_H__
+
+#define OCSD_MIN_MAJOR 1
+#define OCSD_MIN_MINOR 2
+#define OCSD_MIN_PATCH 1
+
+#define OCSD_MIN_VER ((OCSD_MIN_MAJOR << 16) | \
+		      (OCSD_MIN_MINOR << 8) |  \
+		      (OCSD_MIN_PATCH))
+
+#endif /* INCLUDE__CS_ETM_MIN_VERSION_H__ */
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 49fadf46f42b..2385d5ed5ea5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3369,6 +3369,9 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
+	if (cs_etm_decoder__check_ver())
+		return -EINVAL;
+
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
-- 
2.34.1

