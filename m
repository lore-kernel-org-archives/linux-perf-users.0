Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028655;
	b=W4XrVzKHAG045+VYm0ncdC7XmdhgXyus360e1zUtsMk4cUvEwtDL9WE+FWMFFlCGAZS+
	 k/W/qz26+1dgh8KRSuivOV8xbq/A6G1BvBnrOA3x96bMd1KwER+VuuJdQSAZZtxeHmrYZ
	 6tryfnsgSkmQtvwrUal847SJZYUqgZNWWyg5ismVwYpS4gtKySFAugAkA7+C2Uur8aM2q
	 3wAVPSXz/XDQ/KpB1pIo4a5wvKfTfJkVY1kvBOlFiDJvI232oiuTU9qUi4+mCVI1KEme1
	 5f37h57Bapp2YGLKjOg/eO+SZS2BkFuQGZ2ltF+perplYKNpKJCp/qLoK6Ss5XWoIAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vCTgyycIflOX8DIFUkseDn+OY9DjAvHPkZI6oEwJhxA=;
	b=I1rmyKQsoUjrAR6l39k3g2a3BiCMtEocXh8PJx1qMdeSJ0xakD2JdrUmdB0Zv6Ns7LR0
	 K/Htt81lrB8InNhV9qx9ehLBvMasdAISrAMUXJOH49K/wO7X5zBpBf6pQch1PHoEqZr94
	 2ZmReLBCR+/PC41Du1Kcqp2S8WqSZ3CC6fl1GTLRh801D+hymHSRPsurXnxvrhLkza1MD
	 epgPj5sJjSqTKKT5UdmmJzZqRohld4Fs+0fmWuRWD7joW3IsGOkSbWed1ndJF+vQN0atj
	 HNJ7z6aCNNa7VE0VPgiKHDSDGJgHiJT0zq4ELKvIKgoNMPHwClwbFf4ZTKAFgNFDXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqY4XhIY;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A964606A330
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 05:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A964606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqY4XhIY
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eb18f4da15so4000915ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 21:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794028654; x=1794633454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vCTgyycIflOX8DIFUkseDn+OY9DjAvHPkZI6oEwJhxA=;
        b=eqY4XhIYPBdLTeXVUr3lAIezwHA3rSnC5XoR/WMDyE7lVYc28tjb2e5k9SFBD+8nwY
         mPs42hvwm8pAqkcPYvr8P5Pgei6sf0XcB9HGchj8qwdmfLsuUlIiLwbalO19r8G01F64
         9ic5E0jNVCGMWlzo4ezbYsoOn6mJ8usyqR/3HTrxnA6Wg0w7PqULkcq9u5Zh3D0KEU6Q
         /7eAZcsXC42CHYTM3bVvZbb4qHJHlwMFEmRvuj5xQ6wF+62VgBnj1mdBoEx3RsenN8Ku
         zo47ziPsSAqGkj9GqQbsB8HB7zTFd4uLKFlCHoTI27WldHNyahN8RGVdYksXUCrEbQoZ
         19wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794028654; x=1794633454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vCTgyycIflOX8DIFUkseDn+OY9DjAvHPkZI6oEwJhxA=;
        b=iT4VLsxUddcWptRRVRrWv8bvkgMkTqCjbN52NOlnrY3v60FVbYheF47CZhgbqfLH4s
         DZXo97qBnuvw5+9sinDEZFvYGiRO8XC0WB615H9CmXRJmXNLtke3eAezWLWAawPpL3Td
         W34zZTwfPfNaRk0yJmV6TbbJbyRmhL4OvbaGqs+jCNjmalIWPOeaPj1shx11apN9gMpH
         4+UIIenyKgRHXLW5C4UdDxESyJgZPTRe/9JhA7QT2fpQ8YXbbNC/OD2i4q1pjXWczgEH
         nCUSpJWVVYjUgTq9Iq22jQ6EoUw3IxBBgJeyo/3xIuuGWixzpTBLPDhvy0AecOozEAFS
         U0ZQ==
X-Gm-Message-State: APuU4Z+Jph4BalgAyJ6kF2DZwLDnPe/M6OkUG0GBywnFObUy/anag6Ss
	5YvbLL66CC5WmlNL/MEACDL77LyCGmnwGduleRKkRe82iumLul5jRenRUUuF08tN
X-Gm-Gg: AYBFou1JVRFnpg9myf31nTihVg3R3n4gditEuoaWkcXGnZvZaqxgdzn7uZG2y2RxuU8
	MSpDbmljJOQuAEXChkpI1kZdeZwP6T/scC7gLs15R40rewPVdq08UDkg7dBg/VQOPvb6g4pemBA
	JrEP9RE2T1H4QfR1hkz8XUqP6Ov+n/4vrIutHIyn7P1rLRJa+mMH46B9akH5PZ7lSIVPRywcjHU
	fci1QM3l8TsNMUH7f76NHE8r5YD2xKhfTzv7XGImp3a6jEhGYAjehaVEW3j91WR9rNHJC7HXQs9
	GoBLVKwYPnfMP8aFYRbwnuWbdWRyeiUZMHQKGW2bfPqCbGtKB4jqfWo5bct+rVJjTFm1Bvae+bB
	VcimEJbL/hTAYQPQXm9gMLwy8Am7EhFtSnQZ+LfTr+32GB4Y/zxCVScP00DACAqH4LWmg2oizY/
	Nh4koyOxjlQPgHE+TG974wWrxq4Wc9iixZwxuz+v58t9OtheZJcW51huSNK6P98VxHGmjl/PsNB
	HDEa3iD9Z3BPVDJ7LWMJgkvRzrZU8oSRPLUP7e/CtyGzlMMuZdo28ZK95dKMnHeK4ZBAdYQZaYD
	/DMK7LZ13y9Ecwxlmu9X9Q==
X-Received: by 2002:a17:90b:3c86:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3b0db7074c1mr4345247a91.37.1794028654209;
        Fri, 06 Nov 2026 21:17:34 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103435561sm1133772a91.3.2026.11.06.21.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:17:33 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	John Garry <john.garry@linux.dev>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf vendor events arm64: AmpereOne/AmpereOneX: Fix typos
Date: Sat,  7 Nov 2026 05:17:30 +0000
Message-ID: <20261107051730.1880691-1-takano32@gmail.com>
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

Three distinct words are misspelled in eight description fields in the
AmpereOne and AmpereOneX PMU tables: "Preditable" in BPU_BTB_UPDATE
(AmpereOneX only), "satisified" in LD_FROM_ST_FWD, and "misprediciton"
in the branch_mispredict metric.  jevents.py copies the strings into the
generated tables, so perf list prints them and a grep for the correct
spelling misses the entries.

Fix both fields where an entry has them; the metrics entries carry only a
brief description.  No event code, metric expression or reported value
changes, and the generated tables are not tracked, so the diff is JSON
only.  ISTALL - the other codespell hit here - is the ETM stall-control
bit name, left alone.

Written with Hermes Agent, an LLM assistant.  Running jevents.py on this
change produces none of the three words; perf was not rebuilt, so the
perf list output was not checked.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../arch/arm64/ampere/ampereone/core-imp-def.json         | 4 ++--
 .../pmu-events/arch/arm64/ampere/ampereone/metrics.json   | 2 +-
 .../arch/arm64/ampere/ampereonex/core-imp-def.json        | 8 ++++----
 .../pmu-events/arch/arm64/ampere/ampereonex/metrics.json  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
index 879ff21e0b17..5a82a7717060 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
@@ -450,10 +450,10 @@
         "BriefDescription": "OFB full cycles"
     },
     {
-        "PublicDescription": "Load satisified from store forwarded data",
+        "PublicDescription": "Load satisfied from store forwarded data",
         "EventCode": "0xD605",
         "EventName": "LD_FROM_ST_FWD",
-        "BriefDescription": "Load satisified from store forwarded data"
+        "BriefDescription": "Load satisfied from store forwarded data"
     },
     {
         "PublicDescription": "L1 prefetcher, load prefetch requests generated",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index 324104438e78..76cdf38b1e58 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -260,7 +260,7 @@
     {
         "MetricName": "branch_mispredict",
         "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_misspeculation_fraction",
-        "BriefDescription": "Fraction of slots lost due to branch misprediciton",
+        "BriefDescription": "Fraction of slots lost due to branch misprediction",
         "MetricGroup": "TopdownL2",
         "ScaleUnit": "1percent of slots"
     },
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
index eb5a2208d260..558b13fd7d0d 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
@@ -84,10 +84,10 @@
         "BriefDescription": "Predictable branch speculatively executed, unpredicted, that mispredict"
     },
     {
-        "PublicDescription": "Preditable branch update the BTB region buffer entry",
+        "PublicDescription": "Predictable branch update the BTB region buffer entry",
         "EventCode": "0x11c",
         "EventName": "BPU_BTB_UPDATE",
-        "BriefDescription": "Preditable branch update the BTB region buffer entry"
+        "BriefDescription": "Predictable branch update the BTB region buffer entry"
     },
     {
         "PublicDescription": "Count predict pipe stalls due to speculative return address predictor full",
@@ -438,10 +438,10 @@
         "BriefDescription": "Fill buffer full"
     },
     {
-        "PublicDescription": "Load satisified from store forwarded data",
+        "PublicDescription": "Load satisfied from store forwarded data",
         "EventCode": "0xD605",
         "EventName": "LD_FROM_ST_FWD",
-        "BriefDescription": "Load satisified from store forwarded data"
+        "BriefDescription": "Load satisfied from store forwarded data"
     },
     {
         "PublicDescription": "Store retirement pipe stall",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index a29aadc9b2e3..a0dc917b9462 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -260,7 +260,7 @@
     {
         "MetricName": "branch_mispredict",
         "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_misspeculation_fraction",
-        "BriefDescription": "Fraction of slots lost due to branch misprediciton",
+        "BriefDescription": "Fraction of slots lost due to branch misprediction",
         "MetricGroup": "TopdownL2",
         "ScaleUnit": "1percent of slots"
     },

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.53.0

