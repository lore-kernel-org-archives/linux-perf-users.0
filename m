Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A630224AFA
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127961; cv=none; b=CiQfRSiHGPdZ1SHyZ1bkPIc2SiEr0fAkByZOwUeULAXahQdgrg+8EqE2+HwivaASTA2PyodZnikJlTaAuqU+v262h8sTZayb6lmbM0JLpRAY/leeNS4ZpCi8YUKnXyVdDVBeQG3hXBjMN/6vAPDniRwjyDUnhA01YznwdlwIYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127961; c=relaxed/simple;
	bh=QWpq9riX/z5vABZSqFL2iQ5ORl/fWBZU5VsGZXFuyZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+wmYRRXah2xnUt18YOzTheg+056pwdUwnmcZWSQeLvItQBXpgfWlBAOwPD4MHK1cSyugecFP7UoFzbKgO0hSCxPoF4z5dcHhU5CXuYXpFUdLqiuQuDXYw5GtwwIfX/UgThSHdxEROCSgQBzr6Hsksh0xf+dmMfD66bTQv312BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b=SdF0qibm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b="SdF0qibm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d95017a68so3120563a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 17:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20251104.gappssmtp.com; s=20251104; t=1776127959; x=1776732759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QCQwPo5vrqxa+fHlqgB+lkktJCKNc/eQZ81js5sS64=;
        b=SdF0qibmsEObSxOuUUtK6N/2Q+HbeGZLGvWwnnVRWZutpGKCY5UooHOT8LDdsgDbYW
         MuM4B3j7NUsGUb4GqF7jOG42vpvVlYQ+i3/6r8rmJz18MU5Q1Ug4eL9FTNBIY3MN70Vw
         GMwsDeTaeJw0BRyoj/1HbAIRYb0WUDkOSjVoCXeDq0dOWbcC4H1zpJc5ytURwX0y3nJX
         6KQCef+JCR4cCKxw1ElFIXDbH8B8+OCPsyQRltzC3CwhLqtN4InJCsCYZCrdUFzG+ysN
         AbI1TzMmEmqErZpQAXxq6l9J0bOsfr8+sAUppcmS2Yun0O5YCVjN0G+FX2xjqVAOrNJr
         ROYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776127959; x=1776732759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QCQwPo5vrqxa+fHlqgB+lkktJCKNc/eQZ81js5sS64=;
        b=QvZVjjfC73RkXJuSLVmYyNIfYZnoCO6MsodWrAoeSb+AnY38GT2+cjYZd9t99d1CZa
         14SimdOjnCu/xwQok8xjcXPRXNwhx3RbCrDKVbSf1B+i+xawcqvt77YWGSLp3kIclVM9
         x9O2bVplriBmJEVCOgMIpr2Wt5gNTLZvVzkQL+pttoH8vxNlOYMj4cRgzsbOmEkVHqQ4
         PCUYMIR04irkXiozwb30m1hCctPzjt3iJa4jETDm5dr5OUkbv99bF55uVZvYciCYPvJT
         LYkBEfEIfGXBvZuNWZ3ksdvMg95MRdLhDiLOisZRsdAvXKXJplA8N01EHUcyjmntopNr
         rpVA==
X-Forwarded-Encrypted: i=1; AFNElJ/fJhwxfw+VXuE7YXvkyR/gkLakBExQY5oRy63SPtDkYZJz7WoDRweWXrg+8/TmEYGN5+lxkjd1cvfs1iCOyq2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmvo0ld8a2YJVkVyWvt1j62V3he40j5QbCyYKfEytPSwJZWNC
	br0P1vKZl4DCyijrf980hGULNVK22K1isv/lCojNWXniRvwg+vKEzeBr15nePeiuBK4=
X-Gm-Gg: AeBDietPGdVZntaqqPGMtfyL8y/9r95mPp8uxfo2eveioWmWScK7SbNaVlQQ/h9e53O
	ZoRIfGj33jkF0J/M6Owrq8LGfjAYOSlohrBxleD2eqGxCJqwV20ENy3CncvuwQoff+ZW9/TbpXG
	IBOpqP9hXtFjkmWzn7Wn9R1MugtRZysyXWEJdUb2+B+NP+HW3EvtnLPozMVNx0dJ1qYFepHUZ5x
	rLzW3OGaaqwFSLPMjqd5GzRO/YcdZLU6e1gGkNJ2BKxx1A5fcEVg28y0CgdzjeC9H99hioiLPtm
	T0vqCSB1xQ/Hp2szgCyHIUpky6duGCBGzE6mdM+6czeryrv0/7dBfD7gS+R/+MHZedwk7AOtoec
	+Nr7MnQYNgeuvxVTPtS3F3v4dUDKxSP9z6SF0JDtNZ6rGiKyn6esQdcdy7MnXzDKZ3Ez6ReyRAC
	+JYsIZIfjHCg4=
X-Received: by 2002:a17:90b:2dc8:b0:35c:a8f:5c5f with SMTP id 98e67ed59e1d1-35e427708acmr16148191a91.8.1776127958859;
        Mon, 13 Apr 2026 17:52:38 -0700 (PDT)
Received: from gpc ([2400:8902:e002:dea1:c507:1213:2c85:ae99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e41bba7bfsm5906431a91.0.2026.04.13.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 17:52:38 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	WANG Rui <r@hev.cc>
Subject: [PATCH] perf loongarch: Fix build failure with CONFIG_LIBDW_DWARF_UNWIND
Date: Tue, 14 Apr 2026 08:51:52 +0800
Message-ID: <20260414005152.10550-1-r@hev.cc>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building perf for LoongArch fails when CONFIG_LIBDW_DWARF_UNWIND is
enabled because unwind-libdw.o is still referenced in
arch/loongarch/util/Build.

Fixes: e62fae9d9e8 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
Signed-off-by: WANG Rui <r@hev.cc>
---
 tools/perf/arch/loongarch/util/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 3ad73d0289f3..8d91e78d31c9 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-- 
2.53.0

