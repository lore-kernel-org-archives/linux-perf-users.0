Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C95185B5F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502023; cv=none; b=pXPjpFZcuptgl+WB09rKdTCcnUsFfKVTpA39gVOBL+L6G5thaVuxQgLEOyrYNEf8VCpQuqGoZEpAbtWxmZxsEevHDqpOMVNapV8rW74oShABS+zcrmPiACO+phGyeqb1kMjFO3p1JN5LdC6jMU4/C8rNwGSncv4WIv7+VfQNMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502023; c=relaxed/simple;
	bh=OQpRQcQVxXe+edvh1YblQ5RBIrqz+IWlCtlibqXhqc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMnw6nKb+oM12B32UQ7DUuzZIOXc/lBDrZzgQWkls2eLRot79asaBAgtxp2q1/c9qs8wICiIzmt8zJvpeQpZG+NetPfYw+9GHkNYZxFkvXkjdc9si0Db2f1EfE9n0z6EdBHJF/NhEIP0fgGMi15jhoM6kRl17/ryLVGm4tXayQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=huqWsyP9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huqWsyP9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f6287649eso4616097f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502020; x=1741106820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkQxvp4D/2a6lNDlzyRZd3Y+3HL8xskDBwPpQvdRzfg=;
        b=huqWsyP9vB74LJBeMdyj3qB9n2xBVztXjvQkKwEENhBNhhHe3wCkjzhKEDGI0H1mq6
         3Ml6lc65+iKEuGgw3Idu5e+7nbR3+kgpMDeT0Qsm4USmsbGNM0sgBRuWpMaMevTpKHrG
         bWjXKw67mwnAdfZX6ThTAFlf2W//wSIHC3WyVXuCkj4M9FQTQ2lnqt0F96v5HPkVTgWO
         Hma3He5Lyk36dWu2mVhvO+gjqdBTCi8WcRr5giR6aIhinkFhFl4OWxRddg9OwPAzdmxw
         Z/HY2F+iDhrJT3NL0HfrNvs0IwF3qrVkdy8tHQ6JPAv/f3dmGv9M/HnbgY3bez/ixReG
         4ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502020; x=1741106820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkQxvp4D/2a6lNDlzyRZd3Y+3HL8xskDBwPpQvdRzfg=;
        b=fur9N/BHZ7SwPtkB+9MoIj1VIEmKTB6Nb2b/C+idTWTdbr0vbvlyAvyylEqtuGy7bz
         dLz2p+sn59rU89ak0L6coNKIn5QqNR4ZXlm/WLtCJNuTbsfRjT1jgIkfN9Oj9UDVqDKv
         tRDZO5IH+gnf8FmpuiENKoyoS+YyTqgytzCAQk7BjYVsqY7TmNLT/nCNJ6PoUZl+uINL
         2vZ/mLiLDfp/urbqnUrfsaxPgs9E73P6yAGHW3WzldzwfFWyA7nfR2gNKSC/tFITwMCr
         FtYtR69pPV2oGKNh51euuTxvE32JtimLvbnW1zNwjAL91/gQzrlY5ZzMPaXBh34m437a
         kyGQ==
X-Gm-Message-State: AOJu0YwKWHjjlAipYgIrWqa4XPqKZUKOMCaWXmB3o+RmvW7lg+p1Kw6N
	mPiCauZoI5Pr86NRrsi2RKbF3nLCqb7xUQ7uMzyHFgGGI1ZkLkMyPts7SdQM6o5e796+DCpZwKg
	NYQ4=
X-Gm-Gg: ASbGncuhOhkMqKRTKe8gFPRmXpWFP1ubWj7p8dgMv1kIlOsx0SHAwZLxUbEsyEXdowi
	CN4LZ/RVnpbvs55hW+YncUk1vMvnSXL4uegCMWlVCErqbOl8QLg8HKrSxk6FlrTXJf+QR4+dPZK
	PYmSVxAaC3nOcapQmZLANrHqenf8JqFpH1EV1xrvet2xGytbtut4Guw3p//iwVoKVsG5c8nfO7T
	XZSFQLSnro4Hvlrx81W2nLwdRdt8kDfUD6GsJh77F9LOc5gZBssz1MzprZqJ8D8ECfEGIaemqOc
	au4dZW5vsbmOQunfDTPUY3A06g==
X-Google-Smtp-Source: AGHT+IEx1hi4grLoN/YpVbZi7IffgGHtsWzKhP67uDqANfNBhSA1o6apjbKViGQ/G3u3hWJGv+0kHA==
X-Received: by 2002:a05:6000:18ae:b0:38d:e070:6cf5 with SMTP id ffacd0b85a97d-38f708553e2mr16068784f8f.51.1740502019748;
        Tue, 25 Feb 2025 08:46:59 -0800 (PST)
Received: from pop-os.lan ([145.224.90.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab154754esm32072415e9.21.2025.02.25.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:46:59 -0800 (PST)
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
Subject: [PATCH 0/3] perf pmu: Dynamically allocate tool PMU
Date: Tue, 25 Feb 2025 16:46:27 +0000
Message-Id: <20250225164639.522741-1-james.clark@linaro.org>
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

