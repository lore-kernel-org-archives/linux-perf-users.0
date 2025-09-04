Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F355661;
	Thu,  4 Sep 2025 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945309; cv=none; b=OqMctaPBe7fXqPFg9POzBVsj+4RQ6ezNPKMdPq7H+R7JIxi7wy0NVquo99Be0IBu1Ps/NLW4jwnn4oj/2yX76MzZPocfV0+hPkfLnd5r6CWHnhWCxMJjsOqoS+fTNLF536ctLdU1JtcMVwJ+X2g+lxHq9bktzbq2QOLeJhkvwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945309; c=relaxed/simple;
	bh=Uvje703zsinmBVFdkez0uo0N7a2443VJU1IkzFzJUas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCRgrFd24Vth3c1LLcU08NbfYmQE1LelbKqUG9TopbACZmlUYyR1E2iy4JkZc9YFav1AWPhwseoOjKxCvEq2KNGw9WC4xkA+kQEBy6h8KE01jWdQt3l3gNMeAD1FIKHrnR+2ckhzajZ6o+FcjH9m0haCz+wgUyiA4gfOPedIrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ2CdSuv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ2CdSuv"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77238a3101fso344151b3a.0;
        Wed, 03 Sep 2025 17:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945307; x=1757550107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHlaBgzUa1Qmmhf3CcsWTtBaw+HbaoWGOhuV0heFh9I=;
        b=YQ2CdSuvAaIUIbBgevctV6VvR8ZeKRhpOBpsYkKGIJG2hlvc/RXFT2joz2aaEVR1+1
         rUfieZR1uaQ4Zzkuijdp99tfgdeG0swcY+m/rrrVMxZCTJFGDPxeUFuR6k1MINyktJg6
         r2V0pkZsYPi0stxq8S5jn55kjoy+CwZaoAKBlmnkISJL9REnxk1+tdSBErMF1OSmW3+f
         4o/AGcb+b9CG5GgNWAu8IKLei5p5+l7i4GWx3qJ8JQv+jdxrQ9XobetjPdhxoqPsw4Fj
         neWNAS50h8mzOG/pgZh1PRd7+qZSIUrecOWGdMKeW9keixWvgfN1qAboabCfV0Prr7o3
         kB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945307; x=1757550107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHlaBgzUa1Qmmhf3CcsWTtBaw+HbaoWGOhuV0heFh9I=;
        b=IkWmvsZp/RTcMYmdHWwaFnHEU0sXL4YUoJdoiwfFa/ZRkfxqAuu3CtIf6VDHzUlg77
         qyWDHXZgsiotu9z9RRqa+uItbxl0BGY+2j1PQ3lMO1pyYCqQvXPr1BlhzVIVvnvSUdxF
         EB82h6Roh+yASY/jmBmevQCR419ZQZxOSuE8VzXjhy3KqvDH6r2e28yw6YZbstm/R5Cv
         A87ZJgktmr+oKGPDlU8HUxkZouXydIQ1jiFsDg4Pjb9dU8IPjC7mg8o33o6XnaswSbJs
         zHsCa0Fmvdo41wTlF84rOP4Eq7TAAWpqV9vE9LvHlQ6NIsSp0xT/ySUcXLKGk2f1461g
         /N+A==
X-Forwarded-Encrypted: i=1; AJvYcCUfHx5PH0UOTn2nwLahxtvFBV9VBX0NYtW0oOZl87JVyxbNE/shvrjbIptFXkD6KlMFaUBULK0hLWNJmN+4503T@vger.kernel.org, AJvYcCWOkNGbbsnsvrzqDzjVfJa48JFbio3R2rKwwyoOVhE7o1cAFpCKwaFQfWc1JtpkjA8LFeMPrdINnKEzZtmTJox7iAFw@vger.kernel.org
X-Gm-Message-State: AOJu0YwzT1re3PApYTQAlIO09Qz2qGZZpQxzNkJ/sJDdRRH9HyM/DaT/
	sIhlPYc9WrY23YFjzGpvevlXQWOEkEhH1dp+EeIsGth4yf1DhNc3Jyiu
X-Gm-Gg: ASbGncuInoMhZgbgwJYCgjnmml3k5fYAKVIWI8Ugi10kn4nkpa6k0viI0YC7XspiK50
	f3fWJ97JpgzVI8z4B/brRNbNSI2bzL+LX3Sxyr9p6TXI1Q/f1leNLOJj5HueztMztFLQXwWhL+R
	kMSxoeQoJKW6LXYzXOFIm9XQ2xwoyABUEg1+uGLwhtcBZavgJ5CSwcBtfQYxF3nBAoEWBDxRDUS
	rW9JzkJl982U4kutmvn0kmRyasfQItbRsMRyfBHIZxrQVIFoGMAdUMuBTd6aEyHiRQ6s3Sq0y6v
	NOvkm7ucF0F9Z4DNicxhaEWOqhxD+81lQJq1bUFarCA6xg9lMcWUEQiXxgZdLsGd7Oa2izoyTYm
	OmJTQmqoTc/GaGpqWVtdP8P2AfQpSpFuMravsEk+bxU14zMmaBDax
X-Google-Smtp-Source: AGHT+IE2Rm0qq4WLXUHC72wTGZQAf9KHWheCu6SFRXozAz2xgm8zzpEZ+y20XdO59dgoeGrCi7nsVQ==
X-Received: by 2002:a05:6a00:9285:b0:772:5836:741 with SMTP id d2e1a72fcca58-772583608e0mr15901990b3a.11.1756945307314;
        Wed, 03 Sep 2025 17:21:47 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:21:46 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 00/18] mm/ksw: Introduce real-time Kernel Stack Watch debugging tool
Date: Thu,  4 Sep 2025 08:20:57 +0800
Message-ID: <20250904002126.1514566-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces **KStackWatch**, a lightweight kernel debugging tool
for detecting kernel stack corruption in real time.

The motivation comes from scenarios where corruption occurs silently in one function
but manifests later as a crash in another. Using KASAN may not reproduce the issue due
to its heavy overhead. with no direct call trace linking the two. Such bugs are often
extremely hard to debug with existing tools.
I demonstrate this scenario in **test2 (silent corruption test)**.

KStackWatch works by combining a hardware breakpoint with kprobe and fprobe.
It can watch a stack canary or a selected local variable and detects the moment the
corruption actually occurs. This allows developers to pinpoint the real source rather
than only observing the final crash.

Key features include:

  - Lightweight overhead with minimal impact on bug reproducibility
  - Real-time detection of stack corruption
  - Simple configuration through `/proc/kstackwatch`
  - Support for recursive depth filter

To validate the approach, the patch includes a test module and a test script.

---
V2 incorporates feedback and builds on the previously proposed RFC [1] and V1 [2].
The changes are as follows:
V2:
  * Make hardware breakpoint and stack operations architecture-independent.
V1:
Core Implementation

  *   Replaced kretprobe with fprobe for function exit hooking, as suggested
      by Masami Hiramatsu
  *   Introduced per-task depth logic to track recursion across scheduling
  *   Removed the use of workqueue for a more efficient corruption check
  *   Reordered patches for better logical flow
  *   Simplified and improved commit messages throughout the series
  *   Removed initial archcheck which should be improved later


Testing and Architecture

  *   Replaced the multiple-thread test with silent corruption test
  *   Split self-tests into a separate patch to improve clarity.

Maintenance
  *   Added a new entry for KStackWatch to the MAINTAINERS file.

[1] https://lore.kernel.org/lkml/20250818122720.434981-1-wangjinchao600@gmail.com/
[2] https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/
---

The series is structured as follows:

Jinchao Wang (18):
  mm/ksw: add build system support
  mm/ksw: add ksw_config struct and parser
  mm/ksw: add /proc/kstackwatch interface
  mm/ksw: add HWBP pre-allocation support
  x86/hw_breakpoint: introduce arch_reinstall_hw_breakpoint() for atomic
    context
  perf/hw_breakpoint: add arch-independent hw_breakpoint_modify_local()
  mm/ksw: add atomic watch on/off operations
  mm/ksw: add stack probe support
  mm/ksw: implement stack canary and local var resolution logic
  mm/ksw: add per-task recursion depth tracking
  mm/ksw: coordinate watch and stack for full functionality
  mm/ksw: add self-debug functions for kstackwatch watch
  mm/ksw: add test module
  mm/ksw: add stack overflow test
  mm/ksw: add simplified silent corruption test
  mm/ksw: add recursive corruption test
  tools/kstackwatch: add interactive test script for KStackWatch
  MAINTAINERS: add entry for KStackWatch (Kernel Stack Watch)

 MAINTAINERS                           |   6 +
 arch/x86/include/asm/hw_breakpoint.h  |   1 +
 arch/x86/kernel/hw_breakpoint.c       |  50 +++++
 include/linux/hw_breakpoint.h         |   1 +
 kernel/events/hw_breakpoint.c         |  18 ++
 mm/Kconfig.debug                      |  20 ++
 mm/Makefile                           |   1 +
 mm/kstackwatch/Makefile               |   8 +
 mm/kstackwatch/kernel.c               | 260 +++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h          |  53 +++++
 mm/kstackwatch/kstackwatch_test.c     | 261 +++++++++++++++++++++++
 mm/kstackwatch/stack.c                | 286 ++++++++++++++++++++++++++
 mm/kstackwatch/watch.c                | 175 ++++++++++++++++
 tools/kstackwatch/kstackwatch_test.sh | 118 +++++++++++
 14 files changed, 1258 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/kstackwatch_test.c
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

-- 
2.43.0

