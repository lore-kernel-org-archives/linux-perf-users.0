Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019413;
	b=LtbUyfA1pKH4aY2Nni8pls6a1+JMBjEjqewK3xqGJrNw/r/C0e3wdVAh5UdzV/NacYUC
	 lZiNK8xyUtr9ylylyE4Nst8mhgQ9beSrcKHY9NpMYs3coFouABZZ6ESmrCCwig6PDXLBJ
	 bH7TFyPIthcOcH9OifUw4jQc0iYkQ63WMPpQs0Gy88Q5wzntm8blcDcNCgaRcBQRAZSX+
	 h8BqY1eSVweOkAhPSxt/1Bb9htxhSI1LTjJzHQYEUawaLtqvSmJ2TQCthmr950PoXP+hV
	 wM0XRxVhg9VJhOXcN7EvHZpjl1IHnpGUWtYe0+tHQMhropTn39YGs+FwescSWnXlMsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=LgJ8rjvYkBYBkoWffggbcRDgyGHjF5UUVD3pCXNPiIQ=;
	b=MjlMME2TBWJq0Hexe60HnO6mgQRz695GJpUXnVXQiFlnFMiDu0K9XR0LqDVe8JRiNGOY
	 HZ4TbBu5ei3GUJqY6YrKxcSzt0bb4B3uiuq6Z7QsZABhQJOoNtyy101XdJGhQc8+hXjve
	 +m4g55vAmImHmrq43dgozrr86EEdZOl0xmTuLHG0Jn5cGmt3xGoOxWwC7/Sb3Hs4urFBp
	 NNqGWSKGr6oJJ8OEx9HvjkbyDWvA3h1kPveXBXc/VsZJYNtj7SEecuViHCvKPOP1arjhd
	 ouS4OY0QMJo8yVPS3bWkfuudN0XSxRur2xaK8XW/kqurfX0beOUoCA1aUhCsLbvNOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BdeqszRS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6460A3813
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C6460A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BdeqszRS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so17060155e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019403; x=1795624203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LgJ8rjvYkBYBkoWffggbcRDgyGHjF5UUVD3pCXNPiIQ=;
        b=BdeqszRShmCK0txb/ELiC1f2A7wfrUI2zNrEUN9wmIZFXeSbc8EeThC+a1wp0S3+dL
         hqWpMjW44BNToD3H5cN4bp850wUcNIjp3vyFkyAwwxD6BSP2NXL1gAuSfrMY46wydGVG
         XmO4j3yoG03BNWNXn+PS1NPlY5zNkkW7XBqrWpI7pZuY2ffBjdoYYyNU/LqGOGrpjVRq
         rYUqfsRmjlLy7Jz53IqvRwUhBflce10b5E9Vnqkr9MNcmsxeY4U3aTkOEpNNpvNWpdO2
         +mNPO0OqFJ4jlpkxtqrHICvIlogDin/Gk+Zz1ers9CmjTpPNj7NrT9TAi4f4iaz/6x+R
         iP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019403; x=1795624203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgJ8rjvYkBYBkoWffggbcRDgyGHjF5UUVD3pCXNPiIQ=;
        b=Gh88JPMykM/LD3rp6fnDch/qkynpEsmWGRuFgh5Dv6IFCuNHcgWdIVTZbCfqddtLMP
         QBdoVgTBECwojvBQnhjuNNoQMIxdIgCAnSj6U1MNI13nQddfXVXjQ0oJlDjqvQ6W1Wof
         JefJGAGp1OSaEq3Kx0RMjQkU4pCUuvzGcLuEDnl4o748d/YzA8rjAe+QVwmHctvFPxa/
         CvtUHK6cdFHXEvCcMFVm4t6r6J+2BoK60em4+wfhZ4lzWSITe7Vxrp/9W7VtK8+42Jgj
         C7T3K5CHtuRlsXtnRSd0IgefT4HVuDEEcpZdYSleElkgQhgunNI2Q9gJo7fIxQbb9pJf
         aTug==
X-Gm-Message-State: APuU4Z/g5InI5I8IkTFZHYC1m/Ktk6f1R8F/EMI9dsS/+Q8xm+ctR8ZJ
	egb7bFKZoK5hQauCNk8tS6Mc6cbA2stl01gnzw1TMfqudygzZyj1G9pc25tovt+TIB8=
X-Gm-Gg: AYBFou3wIYv2ItA3daLh+UAI3XAL3cQHymnyKx5qwTnQGRN4PDvYhkVLyq+/rv42kKQ
	rC8NM1VfTHFxaLnlg4KwGzhSwtUMEPqYYhCYDtTUA4gQsjwehvfaEDeBOhaOgYRlhn2CGSd83fE
	my2eNcA4fA5N6PMAeUj1GBkTZL8948MaxmL+ONU6f3a0THgLFsoOjCxvFqGc3bSJPe1ICZjrU+h
	Tgt0tghbmkfFz3tObD8SQeiP81Tq+5VBH2oN6uA67W/2j8mFgBlMVRoumPPRx+g8VbfVvGvI6d6
	p/VPcIqKsndVIZ/pudwsvLmTxjYHdADajLofaw90XIuLw/Ke8WIK1YdAWYQtlOsfpRSbZvfv8Se
	Okz6cS7DYKUAP/E1XsHLyL74kUsOIQJElqIBMeIzNJRtjX1qdr3XbP/dTU/dN7Rqpyr+MdZ3PC7
	cCMwiDGcNUuaC9ajbOR4i1K5xh+1/IcC6hePXzcb2DAzNFtuEyxqlwTAKoz1WvwhLmAI3bI8pxl
	GY1qG/G4V2AKzGq/PIw5G81pmFd/7Saeu+wY7eVPP1DD2ICX2DyOyv7wuZdHcFRhH11lSPnBHwN
	1xHmMy9Ye5yE4/id3g==
X-Received: by 2002:a05:600c:8b71:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4bb7da2ba0emr55386575e9.29.1795019403309;
        Wed, 18 Nov 2026 08:30:03 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:02 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:36 +0000
Subject: [PATCH 14/34] perf cs-etm: Always enable Perf event timestamps
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
Message-Id: <20261118-james-coresight-jit-v1-14-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

We still need MMAP timestamps in per-thread mode for overlapping mmaps,
so always enable them. Also update the comment above to reflect the fact
that Coresight timestamps are on by default, -T just gives more frequent
ones.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5a64c17cf254..28aaaabf36bc 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -456,6 +456,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 */
 	evsel__set_sample_bit(cs_etm_evsel, CPU);
 
+	/* Need the time of AUX events */
+	evsel__set_sample_bit(cs_etm_evsel, TIME);
+
 	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		/*
 		 * Timestamps are required to interleave samples from different
@@ -479,9 +482,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	}
 
 	/*
-	 * When the option '--timestamp' or '-T' is enabled, the PERF_SAMPLE_TIME
-	 * bit is set for all events.  In this case, always enable Arm CoreSight
-	 * timestamp tracing.
+	 * When the Perf option '--timestamp' or '-T' is enabled, expect that
+	 * the user also wants more frequent Coresight timestamps than only
+	 * context packet ones.
 	 */
 	if (opts->sample_time_set)
 		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", DEFAULT_TS);
@@ -495,9 +498,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	evsel->core.attr.freq = 0;
 	evsel->core.attr.sample_period = 1;
 
-	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
-		evsel__set_sample_bit(evsel, TIME);
+	/* Need the time of mmap and sched events etc */
+	evsel__set_sample_bit(evsel, TIME);
 
 	err = cs_etm_validate_config(cs_etm_pmu, cs_etm_evsel);
 out:

-- 
2.43.0

