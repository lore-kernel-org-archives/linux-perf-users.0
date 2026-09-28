Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10072376BF7
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618422; cv=none; b=HabsOYkWa0lB4BDsnz8lwkY29kVcoaTCk/yqDRefrHAahp9kflKMAjdMxd7Ot8KrGv5kCk4ygNaYDtJQ9Uz3DACacLTFxMMunEjplFUuBK1rjey2arhldDsdtTX7tXk6IKxGezY3XuFnSBEd9v56SXja1jWNwf0aP1OiF1olNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618422; c=relaxed/simple;
	bh=TwHE1+VhsQ5XKY1Hj9MwzvPvMbeY1bMfMsA8vbZSujM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpMyx0wrhR4e1Wxb/wRaGej3i17IYj3jLH00Aa7p8VJQDDXWLvG3ZwXNN2uhPJ1UjADU5daP/NR7pynGUZo1LzOwg42/37D/aIx0p6AppuFZB9hS9J0XTZhW19hxS+WJgVx+YL3lFzUWbTiP8IxMluWf9QINIX1MsHmf/GiUzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgaeOdFn; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgaeOdFn"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso5187077eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618420; x=1791223220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DieX0Rgvybq5PC5vgoqcCI00d3tmhTbfpgMnkn38za0=;
        b=NgaeOdFnfWAFGb35R+u+I8q0S3V1rEKc9TVgH18RvBDkA6MhqKhRnCIz0nMNLxHXdK
         VCsjlt+5+Qd3pbAu851+Nre95Rr1b/5XcfoBcXR45kaxwjay9AhqtFJRV7o39vuPi+fm
         V+eXKLfg+jKB/HKA27OngtLOllsS7GIwL4XzCfNOb98IDsanzunuItxEjMryY3PIGYUD
         Z0vljWIeIRMeb5bUAKibqJGHY9H/5Z97ffnnFYaFOZLF2NWpHEuoBY3e7M6JG3Kf/T2B
         eRl4UIjrl0+J4++ylgOV4XcGG/0FSuwyePoWrFIrBYAz9IL/zv/D2z+F7YoVNfz96OFn
         u1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618420; x=1791223220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DieX0Rgvybq5PC5vgoqcCI00d3tmhTbfpgMnkn38za0=;
        b=RKQc8Ja0ffvk+ClAW/pVDX487+u3A8UmuyFPhXvUqB9J5juoqba83R9ebNqTgAOpSQ
         +hWBLd28b8WNDkDWhzTsQAauiMZjGDvnPcHh7LxvXPoXh4ryJBc6T5Ep1iG20+n3BdfZ
         w+qPG4h1wHC0XFLnrzFGh924KWUHojdfr2jtavWoEfZPjhZLMr3PaEkpe3BGoxIV+Oc7
         IvFdWQ3xgmpSUj8DvpoyJiCtB3dC0S5UY40r1RcU/GTlRW9+Xrfombf5KY1a3a4ohu6r
         iTzTBbqcjjp++/646xX7OfzbuqpMPLDZfs+8YZmk9BQfs4XJg2D8kXLrMh1g9OuqM9BO
         twJg==
X-Forwarded-Encrypted: i=1; AKwUvBzINIa2bgsm9H2ndznTdzxN9l16BIz7ONBrav5BJUuhR9pd/+ggiqvMSJj4JYs1H7ECXh2NdwhlE5knPaa0tcy8@vger.kernel.org
X-Gm-Message-State: AFq9FYLg7I3kdfde0K9o6Pk7snvNY5uh3KXRuzx4rUvj9LBiVpD/rIt0
	bhge0W+/VWKt+fNoAkpb3tWX0tBZ7Oa2aD/5MbkuSKZ+1aDJ46HJ4De5
X-Gm-Gg: AYBFou0C0D3YpNIy7ezgTvgs8m2tpActFeOsq7HmVlnKz5w81PQg+uu3aqnyML0ubzN
	SUU2OAT0uUxVt5INe2PXKc9Lv234SxdeP3iiaTc5ZpHi6B5+8+x/lHn+AtWepo53AVI3oYrc7Cl
	V14B67elkKWo7piJ6gNK30rvHsbdO6gS0tchO5qb/RaqMSzocKD128MPh6654tgVD1rddppkmD4
	YPKxxflHFI3IZkEatGI5ISfal7ajUgIEmEuVIslgRWwj5ODALA4R/N4bmy1zFSXePIIXs/QmFti
	xKmeMUhEVet1jAEYJCxGRgTQ0Rm6f3fqHbOYlzBxm7M9UW9ivpVJXp4TBUtn2JLC5Lb2jzKA0G5
	0G1G3Noz/0g+asKchcRoLyVZkKCHYoHIEUUgI5PJCGdEjImsnBduI2trrlUVmLG495scB7hSctI
	Yw3KHJqjsHwZJ5OXv6Vu7juwguDouoNFfrX65wwni18bIEdpyAE58AL8ZlMsbG3jsD5/GeWaJ3z
	vZ3Okm8rw==
X-Received: by 2002:a05:7300:6810:b0:334:2bee:348e with SMTP id 5a478bee46e88-3427236f2bbmr10854353eec.22.1790618419897;
        Mon, 28 Sep 2026 11:00:19 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm29808542eec.17.2026.09.28.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:00:19 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] perf/core: Require kernel access for text poke events
Date: Mon, 28 Sep 2026 10:59:35 -0700
Message-Id: <99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1790573390.git.zcliangcn@gmail.com>
References: <cover.1790573390.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82..b4e6e8ae3be7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13953,7 +13953,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
-- 
2.34.1
