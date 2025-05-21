Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF12134AC
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868052; cv=none; b=ZoNyAomEza6AaudWaKEX3QnCE3njLmOUgA1YTdauZl2BON3LxdE2p6RVXw8aczaHJBECoM9m17C90d3TDKdFSbKXM5YaxvDSaNNYKx9tTU1c7KCfx/19SrZja2T65LgI78bfSXUExLYSqzJBrEcKfV91kP+BcgihulUJbbf8H/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868052; c=relaxed/simple;
	bh=QAggP+lM/j8Yzi2qMtUyogpJwyHr1XRiUmUWlJAfYEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Ns8NIiFCCWYQul2ajornoLYM9qIFFiDbWk6+3jwYigMytN3FKHdWUoMK4NUEBTPSbCySmxG++ujIzmzwnCvGDBDtFqVPV3ShSOHo95YsHlVQwda3Ywcxi9RnM4+Hm6DvHGnV5jIXOJbhznULZ8PnMObtCaQFKM429n1zzuhjK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gcwl7eQ+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gcwl7eQ+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74299055c3dso10043444b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747868050; x=1748472850; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e5xiyzjaDsO3It6y2mmvth2hLq6HIh9F/ymtgdkp/7U=;
        b=Gcwl7eQ+/HoLQU70ZlZ/T0YR/dHm8iCeMinI0s9iOAn4x6RYyPtdKih5TD0ClVFssE
         efUVrLXg4GOr76nYcgqW77MgabBYfhJSjyZuqB+uc8cWdVjOkbRShPbyFYZnPWbDe+b3
         NXWyNDUbHXUoNRjgdMDYE9hI+qlJgMsfoePYx0jfeXEEDPCrzBAXf36Mb4f6JsbgwsG0
         rwSz/uJOP3VYxkwXQn1uZSpyExlRUQXEfo3qiMfR9xX8c5fVdrx9NuKgFv1+PLABNlZn
         /YlkMcR7hHxj+2op+cWPSbqBkQWjhZRfEHP/nC4rXjKm2udBRVXJemoPN3U4lhjYfaL8
         WrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747868050; x=1748472850;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5xiyzjaDsO3It6y2mmvth2hLq6HIh9F/ymtgdkp/7U=;
        b=Hq37r6LLVNqOLhubYSVKqPhmz2U/Wb+zvl/EnkXJfpwe0T4czqTE4xxZiC/9vOTbS9
         wGK8qE8MsFAhKpeSDod+h83Z1s1mRWTLAGR3kWOby7dhvDfi9VwBh7ABVYXZCDDNorQk
         PVJDyQ85QQActUftdnF6TpHyHgB9+PiLPzxr9IVjeI4XvdkWH2psv97mFhTWzvhV3uzA
         vY3aFg3elYS/VeSWt7h+zSjGiKvM6en2K5+GzfMCr0tbsfSEOA7Mru9RGEp0rkc4fs60
         rIJ9yVvYncJh0B0w4GtVOn1YeqWCi9qKZqPG/iF09QpBj6BnyprDeFgzWAX5NZdU2Vj4
         lPmw==
X-Forwarded-Encrypted: i=1; AJvYcCVtlE5FlQ9Y2rZN9UO+HBsBwgPZfVbWMolAgNOEgDz/t/9bXY7/7NSFzkwU/NLTQzg+p4eLMxL5xGIhVcNws3YJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwRi/cyOAGFI+Z4MFWaM/gg70PQuFdf2FOuID2xOl2+oBrk8gYw
	fIsJ6wfp59rjlh2mdOriszPdpbUOV9PZuSWBqTU2EdIWNvgeRXGkFdCZy5pABvvhh4gxw3iqrr3
	Wza+KkA==
X-Google-Smtp-Source: AGHT+IFFAeeYwZo8g7rnKGgMqq9ef4KSzj7XjVvtF1mrE7Ad+JDdHJD4QWr288U1fWDVQWnorSbC+q7HAbM=
X-Received: from pfux21.prod.google.com ([2002:a05:6a00:bd5:b0:740:b53a:e67f])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a14:b0:740:67ce:1d8b
 with SMTP id d2e1a72fcca58-742a97b7a1bmr31736812b3a.7.1747868050314; Wed, 21
 May 2025 15:54:10 -0700 (PDT)
Date: Wed, 21 May 2025 15:53:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Message-ID: <20250521225307.743726-1-yuzhuo@google.com>
Subject: [PATCH v1 0/4] perf: Remove libcrypto dependency
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yuzhuo Jing <yuzhuo@google.com>, 
	Yang Jihong <yangjihong@bytedance.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently, genelf.c is the only file in the perf tool that depends on
libcrypto (e.g. openssl), which only uses it to calculate a SHA1/MD5
Build ID.  This patch series pulls in the SHA1 implementation from the
kernel tree, and removes the libcrypto dependency from perf.  This also
switches the default Build ID calculation method from MD5 to the more
commonly used SHA1.

Yuzhuo Jing (4):
  perf utils: Add support functions for sha1 utils
  perf tools: Add sha1 utils
  perf genelf: Remove libcrypto dependency and use sha1 utils
  tools: Remove libcrypto dependency

 tools/build/Makefile.feature            |   2 -
 tools/build/feature/Makefile            |   4 -
 tools/build/feature/test-all.c          |   5 -
 tools/build/feature/test-libcrypto.c    |  25 -----
 tools/include/linux/bitops.h            |  10 ++
 tools/include/linux/compiler.h          |  17 ++++
 tools/include/linux/string.h            |  22 +++++
 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  13 ---
 tools/perf/Makefile.perf                |   3 -
 tools/perf/builtin-check.c              |   1 -
 tools/perf/tests/make                   |   4 +-
 tools/perf/util/Build                   |   2 +
 tools/perf/util/genelf.c                |  72 ++------------
 tools/perf/util/sha1.c                  | 122 ++++++++++++++++++++++++
 tools/perf/util/sha1.h                  |  41 ++++++++
 tools/perf/util/sha1_base.h             | 103 ++++++++++++++++++++
 tools/perf/util/sha1_generic.c          |  49 ++++++++++
 18 files changed, 373 insertions(+), 123 deletions(-)
 delete mode 100644 tools/build/feature/test-libcrypto.c
 create mode 100644 tools/perf/util/sha1.c
 create mode 100644 tools/perf/util/sha1.h
 create mode 100644 tools/perf/util/sha1_base.h
 create mode 100644 tools/perf/util/sha1_generic.c

-- 
2.49.0.1164.gab81da1b16-goog

