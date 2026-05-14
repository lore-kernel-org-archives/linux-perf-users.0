Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390839B94B
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751153; cv=none; b=Rn7m1Ht09PFwZOAC3909PwZ4iiz9UdPjEZL3OW1QDVy5Et8+dBPE8umYA309x5z6Z9w0FtH2ZoY+WAzF+meW2jy/JR6K8EGER/awSuvNFtM1AWl3c/f0LJ2VFBlEuWPvDCAWDnwDf3TqZqEG+wEg2nzmtHLHln3nDXt4fwhqDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751153; c=relaxed/simple;
	bh=g4qN1qiOL6eoyFGTvuGJsgsnQ0jH3lElMo1cnFmnA00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bs18LKxQ5SIqvrfNagxSJE/YCWSdtKo46oku2niXToGMkGiuH8ovycT9ysErdOZjMm+V4XJczEWrDsy5Rj1erTKxe5SRVpCe7XV77AlRrT5rzD7/PO8dbLybQQTMAHPnnEIlaX1Z26zWN8zAlyvB5LPwfcWzLLy7UBykxmy7liA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kyeKNy93; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyeKNy93"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so5671383f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751150; x=1779355950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIhsStlSAZdSG6VxaddFdlwdDOVd+4VLWmlrEpic5HY=;
        b=kyeKNy93HloOQAPUGi9QaNC2baV/8JPS/4t4SDA+KiqJq22SN9hkNsMn7iD82X4bju
         tRyWrySNJja+xn1gSHqp9d6h1qjzUWX4SoPlieA3NUK0nWrWz+7OjOliJYD6QPLb4hP2
         wAful7H5dmDbH0Vo5ZZOirp5CmTrTpg8CNh7PGPaBwhpUQKNLn6t9VQE4571Hgv2yXo0
         WAD8RRy/qeDn2WtyaVrOmi73UKCkiA6EEore2iX/3j553e7b9ByT8Yq3SLDAoYc5b16N
         +nD8PEPaxN8cwoEXU/ZRLk3QF2aBenGIBst04QBZrxItlno6nT6IU3Z3xtir93EtjnJU
         f7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751150; x=1779355950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIhsStlSAZdSG6VxaddFdlwdDOVd+4VLWmlrEpic5HY=;
        b=NbgncB/T9VdXMP6qBUYfJjwnMmEGJmslZsxbB4ljsFD1WO1PJxwnokDdc8Sy/izSfG
         kryTMfjszAMvyxATyMRMzFJdDYVK4bpIHi4PGb5h/nUX0Zbcn1JxbJcmV8gdp/qQnNpk
         z+pTkj8w5IbJeC83DJL4s0NaEBkccXsPzqjXPrz0SElzbm9yT3qLWAW09RWbwWT0Xj+G
         YYVD255XWAeiA5F6LAqYAjQFxxrl682XvBw4Ngb4JNjsXuA+YcuY9oBzD+pKt3rWHvyJ
         XWuEiCW4yvvjFGk9qgfWUCN0uEYZz1eeAXkCMmb/JLz0bO1RsK1QVhP8H4HLDsi86kdv
         TAaA==
X-Forwarded-Encrypted: i=1; AFNElJ91QgpyeabDWyHO0jTf/44F04nycY1i0OSZV/jN9ANnX1+qwQlR4cFbd/NWp0rWQWqmWGP+onktogXaGOsVxA72@vger.kernel.org
X-Gm-Message-State: AOJu0YzquNsUxMpJB/ESr1VIdQccLAGMNycOCA9TXRhbdafeQzlyZOLM
	RH3C+f5Ez3u7p0U9e87z3vO4pBeS+wGb5kyZslKFzNW1FDDhCV07vRK7AOpFF2v/z48=
X-Gm-Gg: Acq92OEsaYGGrrtQ7/D//W8url9Q0ORr6qh6K2X8zebo7XkLPMPKT4/3uVcFKr0Wlkh
	ECE9uOgqTw2ZRJaepAcNcbcTGNeoXW5RkY0SYfTgX9T7q9OLO6WYMLXaHXbo35UzM964txy3mee
	40PY/w1+D0tBCNiONkA0PICy8XjaKi67SRSvmhbKPxVh3JGYRrp/1d87FHALE8114DHxKSbp3IN
	6Y6VHvjbSf76ZcsNMfp4bRXfHv1jIuBM9mDHxa8+ks+2UGiu2J0j7qjfKOrrr6YXlCoF4LZDIQh
	Ey2aFEWM6a+xHQxW1EIfR+DdQCUCLgu+JldrwFzcXJA1GAD3qUJavzUGkKnyz0rgq4qzM7mUnDk
	7whK35v0/R9XWFxjTK79ez6yOx1OaeSsD59kD4ATySO5l7LFvBbhBFHBFOjGQTSrv3CRzRc/Civ
	mubCCjUpp8FqQnC/zMwjjM6PZP/z8NH/bT
X-Received: by 2002:a05:6000:2401:b0:43f:e721:76b8 with SMTP id ffacd0b85a97d-45c7a7dc644mr10324893f8f.37.1778751150103;
        Thu, 14 May 2026 02:32:30 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/6] tools/build: Allow versioning of all LLVM tools
Date: Thu, 14 May 2026 10:32:07 +0100
Message-Id: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJeWBWoC/x3MSwqAMAwA0atI1gasWgWvIi7ammrEHykUQby71
 eUs3twQSJgCdNkNQpEDH3sKlWfgZrNPhDymhrIom0IrhYvZKOBJ4nFd44aR5DNYV8YqZ7V17Qh
 Jn0Ker//cD8/zAm21c3VpAAAA
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, leo.yan@arm.com
X-Mailer: b4 0.14.0

I ran into the build issue mentioned in the first commit, because using
an option like LLVM=-15 is a documented way to build [1], but only
some of the LLVM tools defined in tools/ support this.

After fixing that, a lot of other tidyups fell out. I didn't go too far,
for example some selftests include tools/testing/selftests/lib.mk which
reimplements some of the LLVM_SUFFIX stuff, but other selftests include
tools/scripts/Makefile.include and I stopped before touching the former.
Some other non build scripts hard code toolchains and I didn't touch
those either, this change is only focused on things that already
include Makefile.include.

[1]: Documentation/kbuild/llvm.rst

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (6):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      tools/build: Indent if else blocks
      selftests: Remove unused LLD variable
      tools/build: Allow versioning LLVM readelf
      tools/build: selftests: Allow versioning LLVM lld
      tools/build: selftests: Remove some duplicate toolchain definitions

 tools/bpf/resolve_btfids/Makefile    |  3 --
 tools/lib/api/Makefile               |  4 --
 tools/lib/bpf/Makefile               |  8 ++--
 tools/lib/subcmd/Makefile            |  4 --
 tools/lib/symbol/Makefile            |  4 --
 tools/perf/Makefile.perf             |  7 ----
 tools/scripts/Makefile.include       | 77 ++++++++++++++++++++----------------
 tools/testing/selftests/bpf/Makefile |  9 ++---
 tools/testing/selftests/hid/Makefile |  7 ----
 9 files changed, 50 insertions(+), 73 deletions(-)
---
base-commit: 09d355618f7ccc27ffc7fc668b2e232872962079
change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d

Best regards,
-- 
James Clark <james.clark@linaro.org>

