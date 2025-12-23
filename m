Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4A257459
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509251; cv=none; b=uPkBJjjhPapavLNWYhgRH2QtaciIhd5xe9UfiqISMDiFntUfWzzwDwaq9DSNZCuVnMsQPxxWo0wnPgtFGWZYE8o4kD4sQVun2Pva7UaGKL5fV37Sy4NcqNl2rHVvhZAsiylHgl1n08AWvlF7Aj5mCioXf1LVLkqNGAeYk4KsSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509251; c=relaxed/simple;
	bh=dTWw788i/aIQDj88gI6b3lkRd/WwANGU3kgKkaq9+sU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eIZTKL41VS9n29D675eybPV8pNVlpn8v4NPpmSBb0f5Car5Z0qB2juJgAZH7YtZd7so41t6N8/rfdZYvG0ed5iXKx/FdvBiYewuy6uXT0IXN03XDMnzFLRblY/EQaOgciZM6nbhZpJG91KKHKwEncGUXcmExdsJF5DXPpO8OISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYnCITiX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYnCITiX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso2205103f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509247; x=1767114047; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AMZ134fdqucwFPxdABRgu2JKtvYXYYhxBIYWyA0mN0=;
        b=HYnCITiXpeCQEThCcY3XsNdsKWlQwhv9yqOzjxrZf8YbvnmIBGV+iBoS21AroanS8J
         jX+m4+lAIAj8tHVrn2i59nKDJOXSQ84/e1IlifiFw3dHkPVmOf8OJQhza6SR09cYaMRX
         4eP0uluF6qEQLGsijhhKzw6kWgs55Bmnv7NTKVp7ciVzJTnRc0bSk0VjKweU3gNz+1Tq
         cDmci+S8YM2GuouLIZ5zRu0dL8c7DSCOFlngnj5ekVA6eTv2LnuWz5uLXoqDUXaQ+0tv
         ogoPASY7eO6bk3O2Kwi5ckzGglE0PITw/Sh6eE86I0iOylCOpw2vwmLvr6vZ3LFF247P
         7p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509247; x=1767114047;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AMZ134fdqucwFPxdABRgu2JKtvYXYYhxBIYWyA0mN0=;
        b=VsZQ5LIPIRgZ03rwOJ3XEUjEp8v66hNBGNaACkOkaXp1CIMTa4IGxk944rBfN/FKEe
         2k3+6XpIp2otAjwvZh1gWFShkTpcCqrgUTuYQyEp4eT08+V3DABJeMQE0+AHYLc1MJXS
         cxD45acOp2JvzmKqSZcQVy5HIhljL1y2sq08fppK5rmh9e6vmXta8g+4aeN+zUhz7P4n
         cc1WL9XwfYuOE8a+n16/p2FqneMz5HdTwhiqmkRLVV2N8czVrGFJs/FgFuyMZWb3P0F3
         2dfhG/zULnx0UfigjJ/AXq08N7dyi+G0duRwcjf1Q6jnvXGtjN03EZ1Z74unAQmj+SJE
         Q5aw==
X-Gm-Message-State: AOJu0Yws8fhZIlZq2ThA9KVF1+SPf9Fe5gweuP4s8sqEk7VNCXcyM8nw
	hXQNoXYdPi6Ugt8kMgPhwbxii1MnTvfOjkfxWlmW2Enh5oFEP5knlflkxfSDLUkaaBQKsHgj7om
	x4IxhQpE=
X-Gm-Gg: AY/fxX4gOAKq/4x0oDq+Ej9LGv4s0ez4yhRbdCqeMdxwHfOQ8GumQ6NlLmJzK+atAst
	8gQzbzKYbib7Ud+Zzbs6zqJmmYP5vNMEw5B8jU8o+GbhdOMX8ySxZRX27NRrSlzE8dtHpHcqPHc
	ih1vFr1Ywueai/cD4jePKaHvOcWXwYkL8M8RDnZvVPuV2WvmE58eWiQQJl2NXWyTEDEOlLo79a2
	nLBWxWjbHnfR4NO8dvmSA1+mOuX4TMqQW66DsjZ66IC7fDIcFoxymyj1s0QPQzvV8uFt3yu2hem
	Q+aIg5IBmeB5TnPPukg3UTonyNLQImrVu3+9xFhd0N9NZZksEqwQkninYMPGSrm+pSvGczZuUFG
	NQWLLjoqZG1ruS0+PFwU8Miyia4gIuCLs+/P2qk7x2/qH3Rfc+ModNNEMCWOsI1jay/wxDP1L6h
	Xwxsn/BiHj7d9OrfFiEChS
X-Google-Smtp-Source: AGHT+IF7/O/FFIayLKZhY9ZSqUb3Qa2CbWoPZO1if/TAVGsvjrw64xIReXR1i4g5vjHNjk3QtbjX2Q==
X-Received: by 2002:a05:6000:186f:b0:430:f879:a0ed with SMTP id ffacd0b85a97d-4324e4bf603mr17523279f8f.13.1766509246553;
        Tue, 23 Dec 2025 09:00:46 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/5] perf build: nondistro build tidyups
Date: Tue, 23 Dec 2025 17:00:23 +0000
Message-Id: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfKSmkC/x3MywrCMBBG4Vcps+5AMuJCX6V0kU7+mFF7ISkil
 L67weW3OOegimKodO8OKvhYtXVp8H1HmsPyAFtsJnFy9SIXfoYZld82TSlyQthZM/TFcBrdLYp
 6eGr1VpDs+z8P43n+AFknJcZpAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Alexei Starovoitov <ast@kernel.org>, Andres Freund <andres@anarazel.de>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Nick Terrell <terrelln@fb.com>, 
 Song Liu <song@kernel.org>, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Quentin Monnet <qmo@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.14.0

nondistro builds now require a specific version of libbfd, so this adds
an error when doing an explicit BUILD_NONDISTRO build and some other
related tidyups.

I'm not sure if the intention is to skip build-tests if something is
missing, but I see it was done for libbpf versions, so I added the same
for libbfd. This is the main thing that I hit, that build-test all of a
sudden stopped working for me.

The first commit is also a cherry pick of an old commit that seemed to
have been accidentally reverted in the unrelated change linked in the
trailers.

---
James Clark (4):
      perf build: Do all non-distro feature checks in one go
      perf build: Remove unused libbfd-buildid feature test
      perf build: Feature test for libbfd thread safety API
      perf build: Skip nondistro build test if libbfd is old

Roberto Sassu (1):
      perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting

 tools/build/Makefile.feature                 |  2 +-
 tools/build/feature/Makefile                 |  4 +--
 tools/build/feature/test-libbfd-buildid.c    |  8 -----
 tools/build/feature/test-libbfd-threadsafe.c | 18 ++++++++++
 tools/perf/Makefile.config                   | 54 ++++++++++------------------
 tools/perf/tests/make                        |  5 +++
 6 files changed, 45 insertions(+), 46 deletions(-)
---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20251223-james-libbfd-feat-check-e0cd09d2c1e1

Best regards,
-- 
James Clark <james.clark@linaro.org>

