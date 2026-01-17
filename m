Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803E32E730
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627799; cv=none; b=EWNO3JZIBasqLOi2JRBXhTOsEgxLhXCMnHUT0+ZZ4dbmfjcrJYJwY3yP8DVp9Eg7pFofQf8Jbnbn2vQBnoQmrZ/h0yDrMMegmETuXvR0RChifWkwy5Bd05vubnMpRgMUmT8rw1td27oY08Med4Y23n49sCc732vBU1Y68SeVupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627799; c=relaxed/simple;
	bh=oeQCQhV1gWsBVZPKnHSQl0QIL9uhx6kX5TUrLYHHuBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KbZWKjZpCyYpEbExn3r8giYTknhuX/g636o9s/9JHnFKY2Jt17uvEDnXl5yHwytiX2etEk5TEErJwrU31+SdA92VegWX/GE09wHQB/IUOt27bEwxe6pE0f/2GAS7kHjKYbi2iReFk7S3ebpWGhI5KKgkgcvMB6ssDezCIrgdJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tekPvgTg; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tekPvgTg"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b6a8b32fa9so10173956eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627796; x=1769232596; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3ySt36B4ISR8ZRmDcInO2UVT50pnmB1ju9RDICGsEs=;
        b=tekPvgTgXYkZNJGh3YVCZXdAuCO6htTzV4N2l5yaHOAh7y0mi6MFKEPFtrf34qy+Qx
         gdl1Rf3NYMS+NhMaCXL++asdWHlTAUvdV9PJK9Tc/Tq2OkQ3XDO2iyXExYxppXLw6YZS
         j5PtKBPkZu9lM3JvZ3uzyxi2nzfUJRmiDKTS1MboSF3AsSrwDS5s/BEaSx+t5vWsdamu
         H3yJR7dqfURxb5q4TB+bsn62PF95qEv1gELC962RMz4qMyvwBGaZZUZNzFkhpAdj1Thb
         4HTgoZMS5J+4C3/H4hYNbGdZaEoV+fDKGKRMk4HRGbV3I/6giCAgcjRcPkac5RlKGIcJ
         4+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627796; x=1769232596;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3ySt36B4ISR8ZRmDcInO2UVT50pnmB1ju9RDICGsEs=;
        b=w/24ud5tVUfjaE9Vi6+T6Z/bo/ByJOUt+FcpWa15eTtNfVP6YVfHrTDT42H28AxmIK
         39fvJMH22DK6QBoGcq/k76uj3sTbUtB2VEv1pg/sGm76wXE/A+w+YsPe6Avil5MuSKJ1
         2h51tAipIPUJmW9esNFBdZ2vyi8Kd7bWS15AHOUjXAb1otc0pjqmF5CmMejD9hi2tdda
         IwafMH/48vLya9MDR92GLgB+zGO7g/j66iHnivrUAY9ZXIaUSz26KH6i3TVOy5ruRTYu
         UacCs1TO3zw081QuQFbzgLaLH6bHXvKTV6H0gSiYxFXt2o/sPFSLXA6gkIIpUrnZzdaD
         PyXg==
X-Forwarded-Encrypted: i=1; AJvYcCV0x58GxXei1DBmbW+ME/nwqujwWNT/fxD9fAIZyBlVp70SSRW3T5nREVFKjhO99Gi4jsU1lBH67cNB6fLFsQfm@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcW8zGOjCfrCaniMGLVso3HLpKAcoWiYJf2J7VCfO1gMQ5dBI
	snZh7XhN2OUDMsWEBIM02ZBoOAGCOpJw7pVMO6oU0BV+qxuf+BGIkdHZaCmEnW3XLtpTyLP/Vki
	2W3ZvcZhtgw==
X-Received: from dycnp4.prod.google.com ([2002:a05:7301:1484:b0:2af:dc89:507f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e8a2:b0:2ae:5d5b:4ed0
 with SMTP id 5a478bee46e88-2b6b40d9dadmr4094787eec.21.1768627796102; Fri, 16
 Jan 2026 21:29:56 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:46 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-21-irogers@google.com>
Subject: [PATCH v1 20/23] perf dwarf-regs: Add MIPS perf to dwarf register
 number mapping functions
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

Despite an unused function declaration, there was no unwind-libdw for
MIPS but there is a perf_regs.h and a libdw implementation. Fill in
the pieces so hopefully MIPS unwinding with libdw works.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs-arch/Build             |  1 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c | 14 ++++++++++++++
 tools/perf/util/dwarf-regs.c                      |  5 +++++
 tools/perf/util/include/dwarf-regs.h              |  1 +
 tools/perf/util/unwind-libdw.h                    |  2 --
 5 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c

diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
index 10c2af3d933a..ceb68ae86fd8 100644
--- a/tools/perf/util/dwarf-regs-arch/Build
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -2,6 +2,7 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm64.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-loongarch.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-mips.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-riscv.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-s390.o
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c
new file mode 100644
index 000000000000..3bb916b45c66
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <dwarf-regs.h>
+#include "../../../arch/mips/include/uapi/asm/perf_regs.h"
+
+int __get_dwarf_regnum_for_perf_regnum_mips(int perf_regnum)
+{
+	if (perf_regnum == PERF_REG_MIPS_PC)
+		return 37;
+	if (perf_regnum < 0 || perf_regnum >= PERF_REG_MIPS_MAX)
+		return -ENOENT;
+
+	return perf_regnum;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index f86f76547592..797f455eba0d 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -179,6 +179,8 @@ static int get_libdw_frame_nregs(unsigned int machine, unsigned int flags __mayb
 		return 103;
 	case EM_LOONGARCH:
 		return 74;
+	case EM_MIPS:
+		return 71;
 	default:
 		return 0;
 	}
@@ -218,6 +220,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_LOONGARCH:
 		reg = __get_dwarf_regnum_for_perf_regnum_loongarch(perf_regnum);
 		break;
+	case EM_MIPS:
+		reg = __get_dwarf_regnum_for_perf_regnum_mips(perf_regnum);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 		return -ENOENT;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index b95cf2d7b5b3..46a764cf322f 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -113,6 +113,7 @@ int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_riscv(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum);
+int __get_dwarf_regnum_for_perf_regnum_mips(int perf_regnum);
 
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index 20d63d881dff..9c5b5fcaaae8 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -9,8 +9,6 @@ struct machine;
 struct perf_sample;
 struct thread;
 
-bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
-
 struct unwind_info {
 	Dwfl			*dwfl;
 	struct perf_sample      *sample;
-- 
2.52.0.457.g6b5491de43-goog

