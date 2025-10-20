Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A34283682
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976572; cv=none; b=b8Jlbuup2rjlIdA/VLwz6vQteM8U/iwZeftz7JGlu9/en5+ldLKXvPLK2CLMb+T7nT+24lLXrpsirNyYGejfwCQDrReQy4dsLuL+A2OVmWA4FiQsx6rkgXfDP4CstJ0b7BvHgf9rBv6JtlkLP4CW+mutgtXkamF9ve++9htZpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976572; c=relaxed/simple;
	bh=LkrZxVVmxt7Zv+cWgIEvpDWUjv7+Vq2hu0hGJRjI3E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrbUSH6ln6mAnW8chPvMFSrDblVrv3/DwyVsCZ9qGrOVxrIwB7kynjEoRa5e/TExEDSmY3u9kq6IF8cg581D1P8R47TP5PFysFLNoDTv7i2FPEfD2OwfFGQ0U4FEHczik8t/8pTlPoxVOmDj2dYIgXBvJAScK8Zwv3s8uVfFYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMRuB82V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMRuB82V"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711b95226dso32954705e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976567; x=1761581367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM8V0Y39AnbN5rtI/orFUUqj5THckFp7lYpw6XeoCjQ=;
        b=KMRuB82V/XwtPfJfy8/GlKtNkp/DNmctHxtlHEu8OTHhUQRACzBZdFhZYcjjKsxO5y
         VQ7E0pcSwa88QY4nJdj/0cr+dbv2MhWQwW/KbqFr44I9xQcQ+2sfSaB19AFTKQHzeOqo
         fBE5Wx19r7QNqDht+Mfnabg3Q5fT+bWV+WNfLDiZHjdMG2nhc6Lv68OMY41Grx0bOEU1
         LepiCUq8LzbmcHz9ImlJjP8Lqxx+s0hSFR2If2t7unsbRuLaBREhGS6b7CuCRJtEbFn+
         ABQd+yzUek8MB3WhNgzHhbPnS4bGgbsZ+2eQybSNWQuFvclcIMm9CSui0eghSG0xkmMd
         wBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976567; x=1761581367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM8V0Y39AnbN5rtI/orFUUqj5THckFp7lYpw6XeoCjQ=;
        b=LMsqPylf4wpVsMOYbLkbGtkCkXw0sDXtzeKKebdG3ZOzTjdfWGbP26lcrcQbKdDH4W
         f7co4QRMzVH/8LWxvbNMhyLhzaDqiXcvsUaWQO8TQJNnGfa7ul1qUscbuxsnzeBcdlFz
         jEQKxbafshsY1hdXVS7Z5wzFfdXhahdoEtQGeKRl9ef1QXIoqWOILXf+6JGrs9yE7Ovn
         RxbaH4TJngEZEuqdvUuBAe4WzUph/Z9FuVnkbcqL/05bvW/FTEXBsGcppAw1gdjQGFgb
         7xKD/gruTfnj/RtTiodQcTJvE16snV9uYGUKTTwGp3mOCkInkyvJyP3BsqF5ItGtvHPk
         +fqw==
X-Gm-Message-State: AOJu0YzMUrkxliyqRLHYr6E7lPBlGTZi9mtJKIEqcffW+qGARkSUGnUm
	0dPI0tLijG6LECQ1yCGZw5ZkJtcD6EVCOcMAuE5gMywF/zhX4fndj5sgxhaymI17c6E=
X-Gm-Gg: ASbGnctqYRVzVoaMnvltRPjhfKc+6vhxu1cmWY/MT4yzquaufRGB7lLz9zoprDVfBL3
	PKwpxxBIiwibUfV6gKLfq+SoBsfEcN52X0yjkepigVX3Wxcf/oCwNJCDh84kgfKi0gUD+o4k4uF
	RSObcV/IwEEYB6r9dnMfnduLk3KDc4YfszveKx7d7Cz/iCjvy7qITeKV9MHIJmazPKKCNjITNes
	mIr3dfl8puxvOSiMKqqQDanlI5wTJSsfqzbYMFZRm6+lnb/ZetRAltkpavMoZLOlwKyTiixkoYV
	mLhJNVs4A3injqvYzFwPRWpahXbr553A/yvIOqFrlt+q1kL1La4ZAc/fxCs36giW6jXVqVui2FN
	DjNX6bE+QlW0NHJ1RlvZQdtCT1GiTveicbCKAH1AsyKE8dHL1W0uYRDbBg6B1lZyBqMteQ7Bca4
	0s2PhtMHI3sQ==
X-Google-Smtp-Source: AGHT+IF62e2tX5PllApKh94/7Rof0abCrqTbWMCHv8Gr7E8oqq+KykVHh9fjnntjvKQ/S4PE7Vdbtw==
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id 5b1f17b1804b1-4711c487d74mr64363465e9.9.1760976567544;
        Mon, 20 Oct 2025 09:09:27 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm16408067f8f.28.2025.10.20.09.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:09:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 20 Oct 2025 17:08:26 +0100
Subject: [PATCH 1/3] perf jevents: Fix build when there are other json
 files in the tree
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-james-perf-fix-json-find-v1-1-627b938ccf0d@linaro.org>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The unquoted glob *.json will expand to a real file if, for example,
there is any file in the Perf source ending in .json. This can happen
when using tools like Bear and clangd which generate a
compile_commands.json file. With the glob already expanded by the shell,
the find command will fail to wildcard any real json events files.

Fix it by wrapping the star in quotes so it's passed to find rather than
the shell.

This fixes the following build error (most of the diff output omitted):

  $ make V=1 -C tools/perf O=/tmp/perf_build_with_json

  TEST    /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log
  ...
   /* offset=121053 */ "node-access\000legacy cache\000Local memory read accesses\000legacy-cache-config=6\000\00010\000\000\000\000\000"
   /* offset=121135 */ "node-misses\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
   /* offset=121221 */ "node-miss\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
  ...
  -       {
                  .event_table = { 0, 0 },
                  .metric_table = { 0, 0 },
          },
  make[3]: *** [pmu-events/Build:54: /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log] Error 1

Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/pmu-events/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 4ebf37c14978..ee8ba74f82de 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,6 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
-JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
+JSON		=  $(shell find pmu-events/arch -name '*.json' -o -name '*.csv')
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')

-- 
2.34.1

