Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962532FE05B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333449; cv=none; b=cT5Vt02bfb0NBDXZmzh4TvS+JfEagWCU6LrO6SDRXzYVqMW4XY5ECWRD3vS4QM1FOnwIzZVM/lbqSdvV3yG2lKhNu5JcXTE8HtD2Fg0T4jKt77BoZSWcy9tibJ4sXjDr/pPkdet3SbWQd+GSwTUg9mYOYYfYkg5suo2Xu5kCnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333449; c=relaxed/simple;
	bh=raNLMpkl+S5CZKwgmk04jznUUUHrI3AfobHlmwQcWqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEqiRwtVWz5JmYwPd/XWlmzzNe4ET1owzKJ7E1XQyzMjkQGRI0MpqUBSBWDLepDCU52OkxUT3B6I5PZejCv1MxOlGkJ+o1D6grUpWSvbXp6yv8WQ6Oy0gNL+GggfI8Bn8Ur5x2XaknSURgSWH14D4sV9Kpod7k017zHfO575khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWUXWoc/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWUXWoc/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so1128061f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333445; x=1757938245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqo1+7mglImJW3/ESP2sAU0K/vghCbEUc7ur867asyY=;
        b=VWUXWoc/iOIswXuFQ/jUGWkzn9QTQDuJXTvwFpkb6CDeBeCVZj/0gnUp6nNtVUs8Hc
         FDTUM6W72x7X3FUfbDa/q/kn6vjt4tSw0KdtDjKgJTyiimgOwNGrlLA8HEOt/JIWyvJ0
         wo5jEx5DQd37QQCYqP3Z+Mok2nb5Y/QfUnp+/6wqMIVAaAInGGSu50iH4zGK0adw2Z5+
         kdbzWM8MbnmBLIZrLbqOnMmEWSfEJxNGrOQ6EQBfVkS5U5wqqoscg+iuGQGh2gwlAYPc
         6NQx6DCamPSw5h3OGn3+ccYPqLAr4dq2ciw6XvTpYhyWT3iZBuEGRwVcXzWpdHziCNHZ
         AKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333445; x=1757938245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqo1+7mglImJW3/ESP2sAU0K/vghCbEUc7ur867asyY=;
        b=V10ANiz6LjO6vtyzpuT5ar0H5RExPUfZvOonRHghv4vHhO4Jno0kivoGalNDkvcaL6
         uDZwSuXQmJc6UGMJntQh+PKyFhqHPy4ekTqwVN9o1H04pV7nl40m1dbiZT5zFdVSFZqP
         4RzkZFGMlDHxFqkjoNFZ/7Gvd01GYbs3pIUK0arRjozO9NKILR4/jj62XB+VAz89poLI
         61pO4rRlz5OPCmx8uwptegqqDiEZb4SBeyLkVzAiBmw39BgWaQhzMloQ2zDsMn+/EDCM
         tO8f1zIkmZ2RNYHgwoMMn9n3InM4UBqTHIIJNNfZsOUHY3ZwNzw0VYk3MojS2lceodwI
         YAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUibfVZTF/25hiFffZkZuTp0mSe4eTiON5YbNSQoCQTIIC5Uj+P+4LL/9VOvnqvOTYYFPtPwMqWnFbDJZfKtQ9T@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4GTDtSrG5Y09qhbI75ocq2BSP38YSvnwTHvgueLP6L2/EjfH
	/Aysdhd26cAr9SmGoazdFh3jkYwjmXxO5qiAa50SDsjDhjFqiLOneLawlktBRgZcudE=
X-Gm-Gg: ASbGncsEGimWxmnm1VSN/j8PT+hfMyRMj1ckWjABoObmCZ0k4OptqeyDU352VvpkNvV
	onIJ2kHJeYUVigLO0e8XkWMXL6ugdDgpJW5AC9LshNwd5d2eGuBHpHgoK1uDYyQJYOhpNpuWZ+h
	rE9JqV5H6wYBJrb9n2Sv5VPXQUKMuyeQiUfbSG71VHqodBnw27t8Vox+gnfqmZ1w5cegtCKA86W
	PDDfEfZDh2u7beCNGiFvFUJUPyJz9ejGd2HO2Y0XYLgioIhy4ICP8fHYiepMH48bzaVlUyMQZxv
	v2JNGPMwFUbd9dOrOKioceN46OrZtDaUTgmn9sjX9fZP65Uunp7rXtnGt8rHedvL0PC7BvAbhOK
	ypHlL6W1qNk99qS7vcxSdYbnj3W/BzcM=
X-Google-Smtp-Source: AGHT+IGBWxzyRFeeGevfk44/JfpKxel/pd+hKUi5ugftmEIb0KfQdxCQwGM4PG30BiUOferaK3FuAg==
X-Received: by 2002:a5d:5848:0:b0:3e2:5d59:4868 with SMTP id ffacd0b85a97d-3e643e07d6amr5074970f8f.46.1757333444701;
        Mon, 08 Sep 2025 05:10:44 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm41397825f8f.50.2025.09.08.05.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:10:43 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Sep 2025 13:10:21 +0100
Subject: [PATCH 4/4] perf docs: Update SPE doc to include default
 instructions group
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-james-perf-spe-period-v1-4-7ccd805af461@linaro.org>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
In-Reply-To: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, George Wort <George.Wort@arm.com>, 
 Graham Woodward <Graham.Woodward@arm.com>, Ben Gainey <Ben.Gainey@arm.com>, 
 Michael Williams <Michael.Williams@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The instructions group is now generated by default so update the doc to
reflect this. Also explain the period/downsampling mechanism in more
detail.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..cda8dd47fc4d 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -191,14 +191,20 @@ groups:
   36 branch
   0 remote-access
   900 memory
+  1800 instructions
 
 The arm_spe// and dummy:u events are implementation details and are expected to be empty.
 
-To get a full list of unique samples that are not sorted into groups, set the itrace option to
-generate 'instruction' samples. The period option is also taken into account, so set it to 1
-instruction unless you want to further downsample the already sampled SPE data:
+The instructions group contains the full list of unique samples that are not
+sorted into other groups. To generate only this group use --itrace=i1i.
 
-  perf report --itrace=i1i
+1i (1 instruction interval) signifies no further downsampling. Rather than an
+instruction interval, this generates a sample every n SPE samples. For example
+to generate the default set of events for every 100 SPE samples:
+
+  perf report --itrace==bxofmtMai100i
+
+Other period types, for example nanoseconds (ns) are not currently supported.
 
 Memory access details are also stored on the samples and this can be viewed with:
 

-- 
2.34.1

