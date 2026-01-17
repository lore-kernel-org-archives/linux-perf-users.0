Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA832B988
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627782; cv=none; b=VSNa+NWyWLogscprzC6T9uAbIEeV6gVaKhXGgg1Wr7pwieDLnc/2BfpteR6BXp8Mjq66sknJdhE+Z1GMwdXAhgw0SCsG9xzl9N/ZPe9bXg3cmAo72P99Y+K2tEsrfqN2/CiC/rWYNSk2JdvAwHC/XsQkqfLmAuklacODxclS/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627782; c=relaxed/simple;
	bh=iRDRnUQwVJu5Bqid8SR9afHsHWUbRSRMziCdqch7Y6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ijoJRttepc+3W9H2yRK7lz1jJLvDOGcUoKwX73gWz3CUZXFV4sXmSp1kJIsOQ/occdJ/v0oxoui+FgpL65xH+t5Xvm93tMCWp6S4LBB5cN6gzzjYHwJydTdzVPrsJ+ujwxsdIoJsA01O1Y2JCtotzwjeR49M3sNW0HeGjsDJqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEgFMXMJ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEgFMXMJ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12338749ea9so3470567c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627778; x=1769232578; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1r7j6oxFgC0ngZMI9Q8295mOsi/2CMN4d5P2svdjAjA=;
        b=EEgFMXMJxPu6MHpW2utjDUY3OqLzCWVdiv0rmX1iEkmjNS5STVw6h2I92iIxv8qQdO
         Gh6SHj4BiA63LMqMRSv4vu2ZgExzyMtQyiSt1D7KKt41z04Fmr/bajlqDi7kPNaSWluc
         6WywTRkk6J6kmHTH0yzN6oEzyBhqwCwW8jI1KEefAjDN+OwRcQB8bWKqFzEC6LmALwdi
         gxkqf6Ii7k3mWpz05PFqHjuVG55MISb+EfSRtGHLqtYBWNrsSHrmE1wmilIKM5iblexl
         ud9DFMLEj9OUTdZkMk1PhzTJwfwGn3CVjo7M6A197ZGEv/Q/7U9zZGEfDs1bufbnu99O
         JaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627778; x=1769232578;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1r7j6oxFgC0ngZMI9Q8295mOsi/2CMN4d5P2svdjAjA=;
        b=v8h8EFnwAbtgJ72Nxeoy8LHkEwoWdNh9/PMGlkeixt2jrk5mqmZKHFRZ2NrchpYKhf
         oEWQB+T9ZiM+e5iq9eZ48ATbN19W92Ws/N4HeqdgJ0dALzdrFM5su6WFoj5OYbri7Fki
         YrNjDOavJFRxb6UVGUqsdIHOyTM2+wYZci4xiXgU5AESXMthjRdZs9xz33nWrTlRw1H8
         uAA8TYUACL7Otn/lnuOAjJTKDynYdJ+PbCKytj4dd//S4abFykuXRjbR0jyfV3LaSCHi
         XsFNTiYQ4oW+DmgHW0o87EfeBhnI6XzllUgcyeFHCSZgelgM2KAPTxDzGdJ0AZPIgOQo
         7IyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtnUJZYgfM3ufeOyMHAWxdUGiM6Y84gtnNXBilnRDnU+RlsY9LCUnGRpzeLV1GcNuUuP9imvAY4StI9O2SB4Eg@vger.kernel.org
X-Gm-Message-State: AOJu0YyZBqai+dbLkBSAx/sVUbfUaTl5L7e3fIjF0wd0XYcD1sDgIm7K
	Ov1TdAAYs0wQPlhirSo3gqMdHZHYdbkXCZFAT0uRt9SyKYri0O0UeBv2U/vWFc1ySqrBez5wB79
	r/DrAgmVsUA==
X-Received: from dlbto2.prod.google.com ([2002:a05:7022:3b02:b0:119:9f33:34ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670b:b0:11d:fc64:9562
 with SMTP id a92af1059eb24-1244b30826dmr3833057c88.1.1768627777697; Fri, 16
 Jan 2026 21:29:37 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:36 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-11-irogers@google.com>
Subject: [PATCH v1 10/23] perf dwarf-regs: Remove get_arch_regnum
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Except in dwarf-regs the function is never called. The weak function
has no strong arch implementations. Remove so that the fall-through
case applies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         | 12 ------------
 tools/perf/util/include/dwarf-regs.h |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 28a1cfdf26d4..b2f37299147e 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -71,13 +71,6 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	return NULL;
 }
 
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
-__weak int get_arch_regnum(const char *name __maybe_unused)
-{
-	return -ENOTSUP;
-}
-#endif
-
 /* Return DWARF register number from architecture register name */
 int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
 {
@@ -98,11 +91,6 @@ int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags
 		machine = EM_HOST;
 	}
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
-	case EM_HOST:
-		reg = get_arch_regnum(regname);
-		break;
-#endif
 	case EM_X86_64:
 		fallthrough;
 	case EM_386:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 6f1b9f6b2466..015d1ade645f 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -101,10 +101,6 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 
 int get_x86_regnum(const char *name);
 
-#if !defined(__x86_64__) && !defined(__i386__)
-int get_arch_regnum(const char *name);
-#endif
-
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
  * name: architecture register name
-- 
2.52.0.457.g6b5491de43-goog

