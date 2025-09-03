Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CC23D2A3
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912548; cv=none; b=HCuIpXlpPLkLGnRkSWXDqvRKlq+KA/hJJN0NNFWchai/CAx2Q5W2Sy20qllp0uPWpCLXIMQqjUo1danchBYrDOCWFRz0cSpBULJI+we1VGqrhmLRCgjSwyQwIpvhLde94V1Alzg+Lr4U8UItgRzZ2oB5vzfZdv94UvhrqU6pxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912548; c=relaxed/simple;
	bh=ifVcf96DgqG0NA809UwmItaf7+rgJl4P3Yh//OMkxKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rd+Y/Lcj9mhYUhEcqPSIWZEwIYu2aDiLsywWtJ5vNGCHWxiJ3YnX8VDM2LKcoYrtgfHcPiBhedtNGWZn7veLuQqqke5kmNmoNhcwym6uvJadMAbUKXmM5exdr3cCK4byAiSeQy9+gVuCcyPsFJMIQ1/c/dQyUHFU5eMC0b74GDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQmoy9Ke; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQmoy9Ke"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso44348f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756912544; x=1757517344; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0G2pXnWEohSUeTnmA6oR72H6xhskrL3wwthjDu2SlnQ=;
        b=TQmoy9KevsG4far8+RXbcrr49szXEKJxrEk7Pl4mmx+cY3e6AXLXHY/tlfboJeOH4J
         woClHJMehJ+hzIl1CTOPuzlsfQH6hJRjhClD+m+JbjWm1Iu9TtlStUW4JIWIDmnMSSo5
         Hvy9R//xcRIkAWCnASdqLRVyULk8QDhlqTqJrg14vCXxBNu/z6tOe8CHxKSelp/xmGxJ
         HkSkJy2kqGCJW9QS+TcCjgL81U4QObFypQVsb0CzPrIuAXROyrzRfyTZZF5uCupo/8uq
         WwfRSdzCDx1kamF1xjtmyXIuYuwI0jTbIVWDxJPjwlnphmXV817rQxelYXA1aj3Y+fCO
         PHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912544; x=1757517344;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G2pXnWEohSUeTnmA6oR72H6xhskrL3wwthjDu2SlnQ=;
        b=Iu1B9/ZiG6grG7hcC0aMqGMP2YuU1xHBywAHwsbgdFr7Bs80VhteK27Dg3Nr8wtVek
         bFehRD2D4f7ZVs0XCHmY7ZeI3b7msU5tMqjaAxDYau9uQEj7M6nhmJTj+Vzj5RcOL8K/
         LDAzO+KIs99H9dYrNTOtuc1GKa1Ekwcr4/Eg91BayH9eq3ailG2x+vOSWsK9mgmIDpax
         KNZT5LX1v7vtma7oqr9sfCLFO+FOMn/6M3t+MS2zXoyZjcCW1XxYppPEjN6VczAH+sqe
         OrBgmEIh3IwQjTmF1itBeGqZmeHgwKIBPzpr9yeRA+QoIZeOuPdiDWHsNYLtSPQTMZYr
         XaQg==
X-Gm-Message-State: AOJu0YxtpHRQ4Tc2sXmLNwhcWluVqwd1vANOlYrzUEB+8tn7YkVKL8qP
	KhW/XyqigRByEeHm5DVaMwCR5pAn4kAE03/GDqjPbxlD9nAc8023joVmXY2Y3KL9RYM=
X-Gm-Gg: ASbGncvbdPSBSdVMzdIpJCNlIBnWmVB5zvEjCFKGKwlhD1JbGAM+MVjb9Wqz5pilXOb
	AynaReWOTC+PoJ6j+sOV89giwyHWZqyh9ingJaPK/Gi4qLC8h9fqiU1TSiKn4Jd6DPIk2stfEnt
	IDn0qutlelBtaHfNSfScStg+G0SR6O2Hvmf5Gtm9CLy1wEVChFI1jsA4pPPmnTauTBAXgCnWCdK
	LupcCiOj3IHqNM2iElY1a7yiR2Ecc9llgdXmWTN7oBQdJPQxeTScwJ6ChbSKVYasEQmo2i7VVau
	sEKgQfshogA4UhXzzgFlAx6mg0bEO08HffQ1kr4uouYCDo+t7LHco3ag48GLMXtuQSfqbcQJSPq
	LusRhksqMF3Jsj0TL4q7PNyyopfzzeyTWVHe6VA8HHA==
X-Google-Smtp-Source: AGHT+IGQhVGmTIGL8a09lUU9PnK+bUupkLG3N/awXg9MaNVqeSNYnHK4+blhn+mLhEMARgV1ijTb0Q==
X-Received: by 2002:a05:6000:26d1:b0:3c9:9ec0:2055 with SMTP id ffacd0b85a97d-3d1dfb114f1mr14146638f8f.39.1756912544494;
        Wed, 03 Sep 2025 08:15:44 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm22090097f8f.52.2025.09.03.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:43 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf tools: read_build_id() blocking argument fixes
Date: Wed, 03 Sep 2025 16:15:25 +0100
Message-Id: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1buGgC/x2MwQqDQAwFf0VyNpCuWmh/pXhY3bc2pbWSRSmI/
 97gcYZhdiowRaF7tZNh06Lf2eFSVzQ+4zyBNTlTkNDJTRp+xQ8KL7DMhph4WPWdPOKsPxbkax5
 GSNsE8sVicH3uH/1x/AGFgkNrbgAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The function now takes an argument for O_NONBLOCK. The first fix seems
straightforward. The second one is _probably_ fine, but I can't really
see any easy way to fix it because libbfd handles all its own IO. Maybe
we need to compile in both versions of read_build_id() and only call the
libbfd one on regular files? Or maybe in that specific use case it
doesn't care, the commit message for adding libbfd there mentioned Wine
PE binaries.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf tests: Fix "PE file support" test build
      perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build

 tools/perf/tests/pe-file-parsing.c | 4 ++--
 tools/perf/util/symbol-elf.c       | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
change-id: 20250903-james-perf-read-build-id-fix-0ef6fbce0432

Best regards,
-- 
James Clark <james.clark@linaro.org>

