Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818450;
	b=MuamRkukEKCcMmTZB2OqfmabCfyR/oDooe2bLhXo/M8PXlcqO0stApW/Z+n3YPuSNoa1
	 cMt8VVioqsHSov0LigCQqoiAA8+G6suDgqOJIkj+uUTSerrXAulH3Dj5s26m++xISODL3
	 sPDNvrINkVIma39s1B44aDUAfc2Ydq9NhnpbEv4FbVKsszlJHAFlFS2Njz6ZOJrS9fjVx
	 OGvNUlOtyMgqoxZ2XAJaoce3aM1t/lPJ1a1TUEL5hFkO7THC8NA5cEmmt+l2TnsY0N6py
	 gqG11Waoq/110s9udoGfX4EmQRX9Nm+YTAQNrDnw8yTUyPlYBP3r+StXGjAqnYT2CBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=r4BO+0EzPkh7K0U5uHSGQe2VU6WFhDSfKkeqTxLg22Y=;
	b=0qQO3yulaWpT4/YHOy5uSNgQnNe6CifwDQKkisbbAVGDrhoOcX0Z1jOOEaUeW/vGgOTj
	 ae0D3s1BceumzUCRB6XPJj2bFXbGS2J68YR9ZbQz3KXezSMCSR/dQDiNI+wjgWuCJDkci
	 gwQwzu9WstHaB21kQxosp0xjf5IlLMCIgXj+/CVQCexYN7rok6YsjZRrdbCk/OUh9lecT
	 JDhSDy7buVYvApcmBFbjLTHoPaqxqVtSPloJr31oC9bbhP82rUak2t7fxoAywMcH19FpH
	 PyhBX0EohIy81LliWxng3sIWnjdz/HV8vLwFVB/gxcsqUcaxJJQd5mLdNZYxwelcPCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWGnd6t+;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E176083614
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E176083614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWGnd6t+
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab37e44643so8880827b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818449; x=1794423249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4BO+0EzPkh7K0U5uHSGQe2VU6WFhDSfKkeqTxLg22Y=;
        b=IWGnd6t+iVhKyiAppghWZB1VuHD30eaGbuQPbXJOkbk15QAGMBwP9SZHqMp1vZxGjC
         Wk5PT6B+LiukOdMmyxSldUrMdQGRdIkv3hAni6T1l7JlXbsKeNA5kxZoWrugjADm7HMr
         RbfNwe3DhLlcSQpmVXH1vQwyVPzUMdfsaL45wg7MzQGFjFnhCk14b26SzKSLQT4VfuXS
         qZ2OOWq8FftKY18EBb/yWmb/1LqaiFyumzF/Z7f10WoVhz6wKKiTVQBkc7gqw3+oeRdQ
         5JUc66hC8lxtMejCAs85GQGUeb1fJK15M0RXAyc0+nJyaBjWKXHPSDg9oCQ0g3B4hS68
         Jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818449; x=1794423249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4BO+0EzPkh7K0U5uHSGQe2VU6WFhDSfKkeqTxLg22Y=;
        b=IGbd7779qFrgvpwirs+1w3dC0A4BLrlI/0xJCpywdHu5xXpQNhuzCB8kv8dz8qTfY6
         YZB06ql4eJUB96HuxQnmcNgv2qHy/I5ecpd6yycwb0z4SizdWRwFbtZZ3LDNAB9jP2b6
         N2sptGYS9lL4j6lTHxQf+WfDFAe6O+KkXTSbH53DA5wkZyX2Hu+1oON0O0EU56lPxyQO
         XnJ/xdpquXg8L2AY7+Ve5GpqXX4v3IpVA5dl4MoyuXIB+k9Sgzndsi+o4jBc5JCVzGZJ
         Uhpu5t8/QvK5YwfmyY03BgZm4ffQSUO813KpjXXC81k0UsyreIA8Pigsp6rUXDpd9m3B
         /O6A==
X-Forwarded-Encrypted: i=1; AKwUvBxD2Oc2JCCOdCsANNYvxH5nGG0Zo1IuI3VNgnRUCIeKGRS+8JJ+lGRXu2WaxemjtqVAqhLaSdnJZIbuKliu8k+D@vger.kernel.org
X-Gm-Message-State: APuU4Z+xI+EO6BT6lWpVhT4dRgMtPqS6/0ip4WqrKLYYpJL5g9aDl5yY
	suWWKUAWWwBP4hxdWMy43ryE/KOTQGySUkFeyDmsr9jCHdGkU+KjyIsH
X-Gm-Gg: AYBFou3slwRK3a/++//T/npbG2zJG5+fZpRhrBXMEEylqUoQ4q7Q1bxn7y/U8Yk+S68
	QVsZQvlCRkJKnzKIr1DXdZD7pIB5dFfKtStybF6qXxXPwv5h5VBknoZzctpSeyNUSt7n2UiMnvM
	xqoeKHLCGFW8tCps2exKUQ0RjRk9dw7piU2loU9gQBK69xoBKnUuFm/spezjTsexzzQaI0ck9O5
	B4ECvFmuw/rKfSOIK2jNxRQLWIyP2FOApP9LS4nPtv+kbOvIVCmXtXbXnDsepxxMMcwF2ylyEU9
	+nwm30LiEcueGqgTArTC3V+nUOpPVDZqaf0RdAx/snedSE9aR8LzSzU5+YZx8GSisOI1yoSFqxP
	A2feHSfUeF5hEjJbFUxUZxfskWdFIzfRGiEBA7VmszLaNoa2gYPlBqX/iSncv7Ws5TradUApi9h
	mecOF+IOQBgPiDJqH3wB7KSz1W4z8ISaqDfg2S8i07I21njEHPZEOIKWGGHsbc4HLOIXEv7oorZ
	R+kchdRDTuiaE9RdthQfFMkuaei8y8cv3lmb33Ri/O5NZFetikLzDVhIpLGuAsWiJkN/PqBBBYF
	rqB3BTJI6ADBsIh93h5amIqaRdxhKYNz5ewBPGaQx2rv11AE40oEg221PupC+Ng+O2zkQdopiOm
	CAIzwJlwKVw==
X-Received: by 2002:a05:690c:386:b0:8a9:d5f2:f5a6 with SMTP id 00721157ae682-8b2b675505dmr89556097b3.67.1793818448812;
        Wed, 04 Nov 2026 10:54:08 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309b9f50csm24367767b3.38.2026.11.04.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:54:07 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:53:58 -0500
Subject: [PATCH v4 3/3] perf alpha: Add perf mem support
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-perf-alpha-profileme-v4-3-1771ea02950e@gmail.com>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
In-Reply-To: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3965; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=0IeeS9SsfB54T5WtkW3dlFw63jBXywse/saigUal3p0=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe17sI+KTmH2NK6FLpMLM9q9LsdfxenIdd/6flNZzVl
 if50+M7PrIwiHExzBRTZIlbr8gyq23HUp/T0r9g5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 IEPHKB4ip8egkVlcXJpapJtWUOSQl1+SWJKZn1esl1+QmleQXqCXlplWkpGRX1ScCjRCLy+1xNT
 V0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0pyBi1MA5pofqQz/c1geBdp8vX
 yjJ6XVfMe+23zubQve5zYnrzyl927NxiM8jAz/C6fyLrxZrL1aK3Tzg4k5u6+9/VwcdGRldrDLQ
 hatRRJ1TAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha kernel series "alpha/perf: add ProfileMe sampling" reports the
data source of ProfileMe samples of loads and stores: whether they hit or
missed the DTB, and whether they were loads, stores or prefetches.

Give the Alpha core PMU a mem-ldst event, cpu/cycles,profileme/, as AMD
does with IBS Op. cycles:p is not used, as precise events sample only
retired instructions, and a load or store that misses the DTB is aborted
and refetched. The profileme format bit only exists on the EV67 and
later, which have ProfileMe.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/Documentation/perf-mem.txt   |  3 +++
 tools/perf/arch/alpha/Build             |  2 +-
 tools/perf/arch/alpha/util/Build        |  2 ++
 tools/perf/arch/alpha/util/mem-events.c | 17 +++++++++++++++++
 tools/perf/arch/alpha/util/mem-events.h |  7 +++++++
 tools/perf/arch/alpha/util/pmu.c        | 11 +++++++++++
 6 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index fe51c5e3333d..cb439940ce90 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -34,6 +34,9 @@ be sampled.
 
 On AMD this use IBS Op PMU to sample load-store operations.
 
+On Alpha this uses ProfileMe, on the EV67 and later, to sample all
+instructions. Loads and stores report whether they hit or missed the DTB.
+
 COMMON OPTIONS
 --------------
 -f::
diff --git a/tools/perf/arch/alpha/Build b/tools/perf/arch/alpha/Build
index 1bb8bf6d7fd4..e63eabc2c8f4 100644
--- a/tools/perf/arch/alpha/Build
+++ b/tools/perf/arch/alpha/Build
@@ -1 +1 @@
-# empty
+perf-util-y += util/
diff --git a/tools/perf/arch/alpha/util/Build b/tools/perf/arch/alpha/util/Build
new file mode 100644
index 000000000000..8d924b229470
--- /dev/null
+++ b/tools/perf/arch/alpha/util/Build
@@ -0,0 +1,2 @@
+perf-util-y += mem-events.o
+perf-util-y += pmu.o
diff --git a/tools/perf/arch/alpha/util/mem-events.c b/tools/perf/arch/alpha/util/mem-events.c
new file mode 100644
index 000000000000..d3cbca1993b4
--- /dev/null
+++ b/tools/perf/arch/alpha/util/mem-events.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
+#include "mem-events.h"
+
+#define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
+
+/*
+ * ProfileMe samples loads and stores alike, and reports DTB hits and misses
+ * in the data source. A precise event would sample only retired
+ * instructions, which leaves out the DTB misses, so set the profileme bit.
+ */
+struct perf_mem_event perf_mem_events_alpha[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,			NULL,		false,	0),
+	E(NULL,		NULL,			NULL,		false,	0),
+	E("mem-ldst",	"%s/cycles,profileme/",	"cycles",	false,	0),
+};
diff --git a/tools/perf/arch/alpha/util/mem-events.h b/tools/perf/arch/alpha/util/mem-events.h
new file mode 100644
index 000000000000..311448cf1218
--- /dev/null
+++ b/tools/perf/arch/alpha/util/mem-events.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ALPHA_MEM_EVENTS_H
+#define _ALPHA_MEM_EVENTS_H
+
+extern struct perf_mem_event perf_mem_events_alpha[PERF_MEM_EVENTS__MAX];
+
+#endif /* _ALPHA_MEM_EVENTS_H */
diff --git a/tools/perf/arch/alpha/util/pmu.c b/tools/perf/arch/alpha/util/pmu.c
new file mode 100644
index 000000000000..d19dfc979b08
--- /dev/null
+++ b/tools/perf/arch/alpha/util/pmu.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../../../util/pmu.h"
+#include "mem-events.h"
+
+void perf_pmu__arch_init(struct perf_pmu *pmu)
+{
+	/* ProfileMe is only on the EV67 and later. */
+	if (pmu->is_core && perf_pmu__has_format(pmu, "profileme"))
+		pmu->mem_events = perf_mem_events_alpha;
+}

-- 
2.55.0

