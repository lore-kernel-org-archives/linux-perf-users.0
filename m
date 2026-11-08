Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163619;
	b=oUC/jJHjMk7RVMOF+83qtxhThM3J9aFzwY4shJyFUtYlkZJ19SZPLBlXEePRtdggB7SE
	 wbZLJmDicAQH1Q8EbMwO9WBBHTeMtb30HuzeWrMNUBgig8l8zgGhHgzDuCr+DumvLX6PI
	 J0Qv/Gr3cUs0e6wlnUXeEw4fZxBB0GXKt+zEeNXZNGQvXreMdDa1EFsZZerm8vkZJDzCg
	 W7+rzRoe45Xut5Ox3gDF19XRZd5Amqx1Ac9PUvXnAQ3YxuLWajhe1xVYjID1dYctFmZgH
	 vtybhSy18MrU1YH7qEg2hsC729qQ8OFOFrY6EASnuNnKM3Se5qn24seNdyMq/TDvjzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KLhGHJD0w6qogzd6hlhJL13wlPNhn8Vr3qPOak0i+BQ=;
	b=J5TKnH1J9YE5V5BpUyt60YqA7lEezAaSmbhhpky+m0+z2SjYl+fFT2TLK7QMUeHU3Lk9
	 yEKRiVYAey7FjDv4hCznTLclm2SyTcZZn/+hjG+Wm4JABRf1Xr3JA/YqMz8CSHitMrN7j
	 DOJ5B9XVov8ipppvlT24qrXVfJagVksppkQEYLhgE4mizxWrwuacfW0e5mEcV92r8FgQ2
	 YB2n8cBKB2kwgIVGGND+AYnINh8OqoPsKqBrefY4ampPz9qhVT0efd2eQq7mn9xTpfD8K
	 uoKDRroHGShZmmHaGciqcPXC3Ft1epxu/QFwc/aOgfUbSwHKcb+HBs79wQsyY20Fvow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwwakEJ3;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5C606A320
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 18:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zwwakEJ3
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3704d30b84fso256924eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Nov 2026 10:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794163618; x=1794768418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KLhGHJD0w6qogzd6hlhJL13wlPNhn8Vr3qPOak0i+BQ=;
        b=zwwakEJ3ORwCSEoOOvKxzaCPPcXZpNTTTJ8On71fhGEVimwf1IDpmnBNmpJoGsWSfp
         HuR6bNMRhUT5ng/KjEXoi7RmHX7ikWEGWB5FHs77R4Z1O5rL1VYSIbgC+9lVEENVvV3b
         DUGf1ODIqgxhBQe+sIpm/FR0TbrC1AUcO0KR3JEbNrUjo9tNBwwSlbPpG/MXtynHqVYg
         hJ8H34JmaJE6pdCs05qNL+UAoY+RIcXmEBlfJRC/hsqro4Dwc0iRxuQRKoLAO0sQ49FH
         Ov8Yhoj7zkXIULPuEN8/0PXthmuQ0HptsYZvD/FobPWC9fXXiJlKkj23l8cWPx+1gsZ0
         O53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794163618; x=1794768418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLhGHJD0w6qogzd6hlhJL13wlPNhn8Vr3qPOak0i+BQ=;
        b=QA25iB8Mp5lTiGqAgQ/wRmJs9harkqCw2I4XGjuwoBhP+pjZsFnwGojroIfAlEdKIQ
         9wLt732Ndpeo+UAa3MpvYa3KdLC0jDAZhrzpjVukc8LSsi0KQ+lf+7EbPyNmSWnzNmuw
         8zft2s5Goc56L7bzjkVNtT2Lvawt4pu13y8TTgggwaDGyKmaS0j51axYX8RXGvYNoVQF
         i/gJR7c0gLOypvCE3Va/rLhu7TIR+E8++kKlNtd8gVWGhiQ7Z5n74EN8zezCvZSeWXv/
         6ApDBqB1YqZWzLd3VIE7Nszw7ZsW7qnSW4PxxjpOnQxTF+0EA0kVpA8+1UkLK6fXnrsM
         nJfw==
X-Gm-Message-State: APuU4Z+OWxWGYTE/B35wOJ2iINl8fNPs/3vcG5t5aoSK8ew+QKxYBEtq
	tjaVnK8ElNhpYVQv6/GTQfOhpn4DBxfRQ0OieEz4Bw3NCs17qRQtK/IkRPaIFkT/
X-Gm-Gg: AYBFou1knxCiPoUESdF+R/TW0rXgDbKzS6nwfLAzEmUuAFNlxTgwXaZ1LMX3y02rGST
	hNH0HEPlTpVxyYiSM/cA8MWWf1Yp4JzGy1rT7jR7CjdIS3PsVgdcZPygK/EQoO9UQXVJx3hHvpU
	2V1WLEKRDSzKTTLB2tb0f/Bf6o/3J8M01jir54XXrs+u4FtkilRkAn7PWasZ88H+4AazQJZqqI3
	37YUt53/kpnapfriaG1R3aYfqZ+KlDUibb/i1DJeNQW16bvURx7/06BamkxZFraJD7kiOV4Sh4b
	uj5hy3nCLaVooz1yG1GashLf2J12aSoLdOM5k+q2/eFt2Sg3axc3E0Rjx7kE01BS1M2fMSvWuFd
	vtgmVdLfCRQlMNZscKlBWj7j/2TWJTbg9kDesiiOY4QW8qdquTmIXRIk4Onkk1OH75JC59Ssdo5
	4q4dIUDeER2qr+NtPqM6OTAQDxnegGtXKGDZeP6Olcj6mutZ/GKKlVk0m0XWKY2K1nrkWK2b9bT
	e3/PY2krQeGQ7k08v5scYtj0B7cxO7rbtJQjP9QSbj+w3Y7pcmB8e2GXoZan7WBwIFRZ9Q0bpB/
	JO1Z1YC71JciJUUsjyPYHkKEudIEitpepMsogSuYlA==
X-Received: by 2002:a05:693c:87dc:10b0:36a:15cb:30bf with SMTP id 5a478bee46e88-3725d1a5eabmr4318401eec.13.1794163617977;
        Sun, 08 Nov 2026 10:46:57 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db733sm6348252eec.23.2026.11.08.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:46:57 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
	John Garry <john.garry@linux.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf vendor events arm64: Fix typos in event descriptions
Date: Sun,  8 Nov 2026 18:46:54 +0000
Message-ID: <20261108184654.3811267-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Six entries in common-and-microarch.json spell Statistical as "Statisical"
(the SAMPLE_FEED_* events), and one entry in the Fujitsu a64fx table, the
L2HWPF_STREAM_PF event, spells prefetcher as "prefecher" in both its
BriefDescription and its PublicDescription.

The SAMPLE_FEED_* events are inherited through ArchStdEvent by the
neoverse-n3, neoverse-v3 and t410 tables, so the misspelling reaches those
three generated tables.  The a64fx pair appears once, because the long
description is dropped when it equals the brief one.

Spell the words correctly.  Event names, codes and expressions are
unchanged.

Written with Hermes Agent, an LLM assistant.  Running jevents.py for arm64
before and after this change removes 12 occurrences of "Statisical" and the
one "prefecher" from the generated string table; perf was not rebuilt.

Fixes: 994256a79867 ("perf vendor events arm64: Add N3 events/metrics")
Fixes: 5497b23e870c ("perf vendor events arm64: Add Fujitsu A64FX pmu event")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../pmu-events/arch/arm64/common-and-microarch.json  | 12 ++++++------
 .../pmu-events/arch/arm64/fujitsu/a64fx/other.json   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 144325d87be4..c61d6c0ceb4f 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -1340,32 +1340,32 @@
     {
         "EventCode": "0x812A",
         "EventName": "SAMPLE_FEED_BR",
-        "BriefDescription": "Statisical Profiling sample taken, branch"
+        "BriefDescription": "Statistical Profiling sample taken, branch"
     },
     {
         "EventCode": "0x812B",
         "EventName": "SAMPLE_FEED_LD",
-        "BriefDescription": "Statisical Profiling sample taken, load"
+        "BriefDescription": "Statistical Profiling sample taken, load"
     },
     {
         "EventCode": "0x812C",
         "EventName": "SAMPLE_FEED_ST",
-        "BriefDescription": "Statisical Profiling sample taken, store"
+        "BriefDescription": "Statistical Profiling sample taken, store"
     },
     {
         "EventCode": "0x812D",
         "EventName": "SAMPLE_FEED_OP",
-        "BriefDescription": "Statisical Profiling sample taken, matching operation type"
+        "BriefDescription": "Statistical Profiling sample taken, matching operation type"
     },
     {
         "EventCode": "0x812E",
         "EventName": "SAMPLE_FEED_EVENT",
-        "BriefDescription": "Statisical Profiling sample taken, matching events"
+        "BriefDescription": "Statistical Profiling sample taken, matching events"
     },
     {
         "EventCode": "0x812F",
         "EventName": "SAMPLE_FEED_LAT",
-        "BriefDescription": "Statisical Profiling sample taken, exceeding minimum latency"
+        "BriefDescription": "Statistical Profiling sample taken, exceeding minimum latency"
     },
     {
         "EventCode": "0x8130",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
index 10c823ac26cc..6fa2936e427d 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
@@ -162,10 +162,10 @@
     "BriefDescription": "This event counts non-allocation type prefetch injection requests to L1D cache generated by hardware prefetcher."
   },
   {
-    "PublicDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher.",
+    "PublicDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefetcher.",
     "EventCode": "0x233",
     "EventName": "L2HWPF_STREAM_PF",
-    "BriefDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher."
+    "BriefDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefetcher."
   },
   {
     "PublicDescription": "This event counts allocation type prefetch injection requests to L2 cache generated by hardware prefetcher.",

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.53.0

