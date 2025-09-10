Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BD31D39F;
	Wed, 10 Sep 2025 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481850; cv=none; b=WniLmIzIL2h3Q60HZd5wIaTnoMqa991vdKKcBFdMisJYFdF5yFnRZ6riZx64Lv9NelP9onFT/bQj+NDqcHiIeAISROOVjWox+KnGSIQ2OPTEmisDlAJd7u2NDOzgABWUjgGYVwfzlVbqyhT8EeLiyv/JGJrAvKtQ0on3czg6Q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481850; c=relaxed/simple;
	bh=4VptlxtALKSeGPwHcSWmQZXyu6v8EKXiviUiiXDOKR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAV3mB/8618dcLyb8yn9PAJHa9pXiA8EHGJq15gep0cMJON2FFurl1quBJlYuOyGgsKAvD3Gy2+7J779YKh3YU/EGSjFh0uTF7pBUZXqNeBjaopZXoRsiF7ka6xQkyTFv+igbumJQCvJpKeVUXfX/BqyLVUAhCafgH26uOF2wtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5UxE4Gy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5UxE4Gy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24456ce0b96so2978885ad.0;
        Tue, 09 Sep 2025 22:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481848; x=1758086648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cftv6dbe1p8dhP2DYhCN2AZkHpit5y+1p22q3P/B8ik=;
        b=B5UxE4GyWupM/uLm+2bPC+ptu6QY3wVNIjP+WQLDzpvcFam/8IxYNsYBz1z7Z9KE8I
         nUw3zsD2+jSb58iOLUfzXF+toUjATWuHAgGLRNA3bp5/RGOvAMDxFrwrNauc3rnVYzyK
         lb6KwNCPm6Ifm43Qh9iHSzi29GOqGMjHm76APcm7cHJIJqJa0vfzp4gcN9HGFkG8YtZT
         cMeefU1FsWiGKqo5qn7C3l1d1z9gudzAIhFUjLGt7txhisYJf/tSKTCtHnBRVgIoPN4p
         GHIrlrkUiNSKkVmbFTYF2nfdfUeoKlPW0i4lMptTPU5kNSlqvf7PizM/KpwqIwQlxGnI
         tSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481848; x=1758086648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cftv6dbe1p8dhP2DYhCN2AZkHpit5y+1p22q3P/B8ik=;
        b=DXQHSdHTNCDLU8cIzj4lUdBfAfoXAkwE/xF6Rc9oy0xA6AuMdVNcY8XplHbW77ORR8
         wcM8wKb/pyIVnUPDqrzpVBOS0+N/8fUZpLBuBkhTfW4H3uuM6ULYtZ8G0TJsiLRZbeRH
         Gx8Hty9akQUPNXoXUFme9LyXr+vMWLL02Gv0LKwoynjzRhOCsNCiQsVxES9WlVX8xvVZ
         RoLfr1JyvkooHTiSYUNrCfSqaTI/XFehVuvlUvy3MBAa8cmqUmys0ke7yX3Q/N/bd2SS
         eaVG+5EsGIQq0fMIjJT9eGW6LSwH8azff949AH0r0GHYF2UvlGZGZrY3vWKMaSlWRAnt
         +NkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKsMa9QSVsginvbBMRGyeWKsEUVQT6TO1rTG2ypMO4PZckNBQ2tYof/y4HMLl4b8jaaFYE00PWYFpLMPtG+uH+28OY@vger.kernel.org, AJvYcCUnEfQov6bq2rp/mlfeI4NrWKO0r4idRvPMiiLPPQ0edAJR2mZbeWYlXOhVksJoyy33ZIOLgEc9HYh4pfYiOjav@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQ1ng1tsH9NjBXc4RQUYT7K0m3gGr9spuPj56xoCnWly8qnF3
	Nug98hyZj+Bpkea0z6SGzUcGeYBbcd+1l/XA9hcaYzQG3mZpo7I3D1M6DnblUma2QRFkhQ==
X-Gm-Gg: ASbGncuNDpeMpLBjOFK+D3O6zbvfX5r8kzeSX1v7glCMjC3Vp7eP9n7TDSaeDqQqj1P
	XI37oLEm3AhRJBCihvsCbxn7dqsUilJoM77E1kSbqHmnaIxOSLC29gAUhDVTbxd8ShWgBeyhPzM
	ATHpuKzpPqJE884a/Ndla2038wp9xqv9xBTSpkKhFD5SR4JauDDJg+ZDNRZW5KTK347jxIQcDlc
	Q4Z7Tb5nTAB1yObJd2LpK0jyRiENHMVlSfWxkivg15+3qwd1aNgoYUcPFVuayhtAqvCOpfG0tR7
	LhfvbXkk8cQpAKj3pBGNIkvKVqM9qyMv8etmvpJtwJmJCFvK2jPdBkz4J623iajjgHycwgpk1f9
	aj7RgWpZQj24HaaMFRglDC/Py6axTe0n5Rw==
X-Google-Smtp-Source: AGHT+IFuloiwaEGV/DNI2axiJL2dsg2gHw5eX6v8DVF0szm1gYxcXDzTuZF1jNHa7zPM4+MQqK3LqQ==
X-Received: by 2002:a17:903:986:b0:240:417d:8166 with SMTP id d9443c01a7336-251788fd271mr178360345ad.19.1757481848399;
        Tue, 09 Sep 2025 22:24:08 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:24:07 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch debugging tool
Date: Wed, 10 Sep 2025 13:23:09 +0800
Message-ID: <20250910052335.1151048-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Changelog

V3:
  Main changes:
    * Use modify_wide_hw_breakpoint_local() (from Masami)
    * Add atomic flag to restrict /proc/kstackwatch to a single opener
    * Protect stack probe with an atomic PID flag
    * Handle CPU hotplug for watchpoints
    * Add preempt_disable/enable in ksw_watch_on_local_cpu()
    * Introduce const struct ksw_config *ksw_get_config(void) and use it
    * Switch to global watch_attr, remove struct watch_info
    * Validate local_var_len in parser()
    * Handle case when canary is not found
    * Use dump_stack() instead of show_regs() to allow module build

  Cleanups:
    * Reduce logging and comments
    * Format logs with KBUILD_MODNAME
    * Remove unused headers

  Documentation:
    * Add new document

V2:
  https://lore.kernel.org/all/20250904002126.1514566-1-wangjinchao600@gmail.com/
  * Make hardware breakpoint and stack operations architecture-independent.

V1:
  https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/
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

RFC:
  https://lore.kernel.org/lkml/20250818122720.434981-1-wangjinchao600@gmail.com/
---

The series is structured as follows:

Jinchao Wang (18):
  x86/hw_breakpoint: introduce arch_reinstall_hw_breakpoint() for atomic
    context
  mm/ksw: add build system support
  mm/ksw: add ksw_config struct and parser
  mm/ksw: add /proc/kstackwatch interface
  mm/ksw: add HWBP pre-allocation
  mm/ksw: add atomic watch on/off operations
  mm/ksw: support CPU hotplug
  mm/ksw: add probe management helpers
  mm/ksw: resolve stack watch addr and len
  mm/ksw: add recursive depth tracking
  mm/ksw: manage start/stop of stack watching
  mm/ksw: add self-debug helpers
  mm/ksw: add test module
  mm/ksw: add stack overflow test
  mm/ksw: add silent corruption test case
  mm/ksw: add recursive stack corruption test
  tools/ksw: add test script
  docs: add KStackWatch document

Masami Hiramatsu (Google) (1):
  HWBP: Add modify_wide_hw_breakpoint_local() API

 Documentation/dev-tools/kstackwatch.rst |  94 ++++++++
 MAINTAINERS                             |   7 +
 arch/Kconfig                            |  10 +
 arch/x86/Kconfig                        |   1 +
 arch/x86/include/asm/hw_breakpoint.h    |   1 +
 arch/x86/kernel/hw_breakpoint.c         |  50 +++++
 include/linux/hw_breakpoint.h           |   6 +
 kernel/events/hw_breakpoint.c           |  36 ++++
 mm/Kconfig.debug                        |  21 ++
 mm/Makefile                             |   1 +
 mm/kstackwatch/Makefile                 |   8 +
 mm/kstackwatch/kernel.c                 | 239 ++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h            |  53 +++++
 mm/kstackwatch/stack.c                  | 276 ++++++++++++++++++++++++
 mm/kstackwatch/test.c                   | 259 ++++++++++++++++++++++
 mm/kstackwatch/watch.c                  | 205 ++++++++++++++++++
 tools/kstackwatch/kstackwatch_test.sh   |  40 ++++
 17 files changed, 1307 insertions(+)
 create mode 100644 Documentation/dev-tools/kstackwatch.rst
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/test.c
 create mode 100644 mm/kstackwatch/watch.c
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

-- 
2.43.0

