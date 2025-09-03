Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF0225765
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912551; cv=none; b=FVZS1HfpW9//M2s/aCsv3m53tD00wNuZq1ifCIE6u3w7751seZrkjdWWfGbt8MS2VB3XQu7OkRPXoGW8MtpczyJFXaJpwoNCg6cvqbkJtvQlrUV37RiNGv/Yvk50NcFaJeimmg+0sst4gbnfL78J7eo+U+4RnethKI7qaVcy8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912551; c=relaxed/simple;
	bh=l5JR3+UPUEJ2ClCwj8ex+lrVpnlr8I65tG5mWXGoWUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFDXaxEsf85HJCHm5BxmnMJji9irLbl/Gt2GS1FuQmx8JVC35zag64F3Y6QyrJlkmXOjqltzn/94HVhmypIXqh1NKZf9OfWD3iAaoHhEZIiKu9SKSVeKKbTPIgVLzkyjCzqR72lQVjVLJ56IhG4LeinQrXY4HZJvxVfgQsT50DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GA1sAcT3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GA1sAcT3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so6560515e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756912547; x=1757517347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMR5sXuAMQlcJIniIrDARobJ0FFiLjcpiPVUSqhd9zk=;
        b=GA1sAcT3ccTSs2srYyACOmN28J7qbl1PHVLGf5113S5hPo3R8/WgzMjHTylDPyiwMR
         rXfTB2/8D/BILYR2lmdC6QjBTH8eIGuQUvgXknfsMDL9fPXnqaBZtEfqMP6gAvcZmQSD
         Q45srAuWBQ58+9i0LLLRlXy3M6McU96jtu32VAEHmHeEvId0UsG0QNC1Xcap+v0S5FvF
         DckdgkdZ8Iv0dAjpiio2SHoOsGUCeAinyoNoImuvRJs9E9aqPRanWOTAD1wIVmKH08Qf
         mWUZED9dbwXbrk481LjVZXs+gkJpZdYxbDiv1BTFQeHS5b3FBG+swqkWHE6/IGna9PPe
         ICEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912547; x=1757517347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMR5sXuAMQlcJIniIrDARobJ0FFiLjcpiPVUSqhd9zk=;
        b=INrClHM1gdNNX76jV+S4ksTErSzJlc0xpPQAI7SBX5CNOdFCN9u7dVa82XP8sddK/x
         UU4lB5In0OhmemGqRgH3ljsweIJxdvawPBn5Y9nGja0T8ZKN0cm/24O39fh4/je/CNhY
         HnLWvdNTOBPk7Ek4wpSdiQd39AWrCZSy2cDJSfWeuGoENZpIuvA/xP2WCvLBydQoCiaK
         pHpOi1xYgZ+plt0xhY3xatjboVTIxhJ18J+HzYf3ANMQ8W/LxCIGr1wJQ10vVB1+YiTb
         69Ul+ZdC7aJxDmxUDiV/HlsXSxNlxxmsJ8yXwAI68w6QgPjUXUTvYF63wY9UKBVcHN/2
         318w==
X-Gm-Message-State: AOJu0Yx2QqGwV9nTo/equdgneg/y+kHbN38wBZjMUPU64JfMvZHzk53J
	7sbZ9w0tAoJtGqkjf9hWNPIl9Kp848zzwnt87mOQY6/VeawYttqSML3XFHalqSSMBbU=
X-Gm-Gg: ASbGncs8VWDOX3xtyYgMRXLNX4VT/LLS+NURwTJdX4uQTF8vlEVEPAEH97qb+1NTr0Z
	4p+tkEqMXAhP6Sh77TJA6DSwBxmkX82cfalExx+leW6NBjZFGGIM4D5p2EBB7OsxAu4ii++UYhe
	Jq+J8y4XiMMANZj4f2SPJNUfPkkc/whn5DsJq38YiYwKax2QFODGztF4Iak3zgE4ksCclTnJ86O
	yiRTb/W4NWhhs5UihQEPynIJruJEhOlwpVUpDkHPQ/pPNSI+n0XIeDcn2YBMJ5TLo120OIuGi8m
	wZ3b/rY6ZjChY92CgM0KMxFXJcK5tQwNLVkMKxOVsOzSf6d7vSGlL/TJKZUl+QEHoHVv696CXPm
	O1rLo+81gGzvDn1KfErFJrDKcQgSO31Ovl6iRDDRy+Q==
X-Google-Smtp-Source: AGHT+IGqmlvtcSgBojPlbYZQhWtD2pJ/2FpKNNBsSoYyGicnvhdImai5K6SAb/1Au4J2gguwRAbk9g==
X-Received: by 2002:a05:600c:648a:b0:45c:b523:5a09 with SMTP id 5b1f17b1804b1-45cb5235bfbmr28123975e9.16.1756912546581;
        Wed, 03 Sep 2025 08:15:46 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm22090097f8f.52.2025.09.03.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Sep 2025 16:15:27 +0100
Subject: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

read_build_id() now has a blocking argument, but libbfd uses fopen()
internally which doesn't support O_NONBLOCK. Fix the build by adding the
argument and ignoring it:

  util/symbol-elf.c:964:8: error: too many arguments to function ‘read_build_id’
    964 |  err = read_build_id(filename, bid, block);

Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/symbol-elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 033c79231a54..e0d6ff7d0acf 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 
 #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
 
-static int read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid,
+			 bool block __maybe_unused)
 {
 	size_t size = sizeof(bid->data);
 	int err = -1;

-- 
2.34.1

