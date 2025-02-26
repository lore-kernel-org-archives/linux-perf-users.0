Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A3258CED
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566486; cv=none; b=WM4PT7wy6zaZ2H3ys8ixXBVsDbowQamugT7PaAz+ohZ4UgucGADbcgvXwz4SIO8vY4WwKdn5QVdUO1oVCdQchPZhHauuM0mNjpv4d5m3lxgDtwbChr5fwrVp9HnCMVdaLZAeGFXvglrD+eJBqZNwcdcOqK7xJVOYQS1YWLXb43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566486; c=relaxed/simple;
	bh=XRXy6RSItxNq6QnKOnKdXg5Yk8DodK9KEgrENi0WQ2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lmse00uwdeoolwAYuJjJmFwJXe02PALVu50MPX5sHdxRBRnBg+KOpDAIJpB4awbPfNa8ESaFj3lenM26AMM5C9pey1CX9SAm5Y7Fm5o9dwTzLLSmLTbjFfWLBigmLRED2VTzNnmljDym20FCCLvmsJwtlAeAjB8mci3seH/3U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AejhHYXM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AejhHYXM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so58089235e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566483; x=1741171283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Io4l6/kfa0Abr7c2gr2/O0xUhpbW7CfkwJb9n48BOE0=;
        b=AejhHYXM1X2OqFulETr1+E5mdC+oPAllJ4ttBkAK18cSs7YRVg61z1TMVs6y3nTL1p
         ufoSUADTlOTl7rxVN/a5+42rq3iuHgFzWP1n0PhxkOlnY9Dsp4iEY+Jqse2uEpQtwLQc
         +VZuQtM8AF7iWB6IQMVSISmojak2X8LoYvvN5lx7jDoqto1GeMdJa4dEfr5EHAf8WCcj
         BkovwLHZjCcxU5BxDtoWDcWhGPF506QkIABbWGtNM5dtSZUEgY57B3bSRNxFxc2C4nZ7
         w5gYssY1jGopo79D4t1nrq01/Jo9Yn2/t3SPQUadKQa5h7K7+lIeSwq7fcqOB3y+9EgY
         JcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566483; x=1741171283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io4l6/kfa0Abr7c2gr2/O0xUhpbW7CfkwJb9n48BOE0=;
        b=lu9Pez05SM2UP6GRdamXyYE3nTa8TDpxAB62q0oqRIPY3QgqKIWkFhByAjwLdUufMK
         gMlVYdrgJcJhISxcRQf0K7oXjnhVUCFQvfosM8l7fbAg+Bzce7gOY6yseOIwlJ8x42Dv
         eFJgN3+MYHhoiiAuI1YzYHLEPy3BoIZTGx+1h1w2H7brfCEr251diqbSUuYMKOs49ycO
         xInP2awnj00v1P0/6I4ftxpSFeTwRiGuyDJZEol35ne6/hjLiI2KAexVwLfzZ3w5gd2K
         O/QcMYTIMKpmTL02RNaUKFNfSe8W5BouX/FwcxDerYKj/5R87f0AEgQqiDV5vPcljfku
         9rhw==
X-Gm-Message-State: AOJu0YyKMgL/NFx6Uo41LSiUL2EMt6dVf4PsBJwscxKEQCAWjGWTXMjD
	gTR8QQB/4eYja05StYIKvxInP7GC+SOiffeHCG8bPfQipyej9r0wyw8P/nLtqDWQvBtuua92Fkv
	15+o=
X-Gm-Gg: ASbGncuJbj6tmWvTsbsvjq9qxSwuGP9PFhxcZu7OqTQ7VmXmyJIJzURNVNrzNQjCYO0
	Z6X1+pkcg3I9AzRRzdD0BWxekrLNf/TfclGt/X4mFkGYczzZt0qOAcA8jB+f+pQh7WQc90F1Wq4
	vgbgKgKuAywx3XSD1+lqTN0su6GXpuuNULyOTASFj90sN/RkM2wdTviOmelZHFPBhJxzW3Wgfrx
	NkSUU2BCFnCy6HNfmz0Ikhdvjm61Jlzf1XUxOxMXhEaKcoDotZfLn4iKuvuvO4roQiH6XVodefw
	0X2zkJrgc7sYdny2rNPDSZcLbDE=
X-Google-Smtp-Source: AGHT+IGM/5sKGlj2yIGkYDThiqtYqRuGy0u3oCOTR3Uv1tGaYGxuD0FRM9XnnIUJokzK6qFNma0+pg==
X-Received: by 2002:a05:600c:19d4:b0:439:34dd:c3cc with SMTP id 5b1f17b1804b1-43ab90169c6mr20461805e9.22.1740566483568;
        Wed, 26 Feb 2025 02:41:23 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm5080832f8f.26.2025.02.26.02.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] perf pmu: Dynamically allocate tool PMU
Date: Wed, 26 Feb 2025 10:40:59 +0000
Message-Id: <20250226104111.564443-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few minor fixes that I came across when poking around with the Perf
list behavior on hybrid Arm.

Changes since v1:
  * Rename perf_pmus__new_tool_pmu() -> tool_pmu__new()

James Clark (3):
  perf pmu: Dynamically allocate tool PMU
  perf pmu: Don't double count common sysfs and json events
  perf list: Document -v option deduplication feature

 tools/perf/Documentation/perf-list.txt |  2 +-
 tools/perf/builtin-list.c              |  2 +-
 tools/perf/util/pmu.c                  |  7 ++++---
 tools/perf/util/pmu.h                  |  5 +++++
 tools/perf/util/pmus.c                 |  2 +-
 tools/perf/util/tool_pmu.c             | 23 +++++++++++------------
 tools/perf/util/tool_pmu.h             |  2 +-
 7 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.34.1

