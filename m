Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF7327BF4
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627778; cv=none; b=FAAq6isG3EFiN2jk8BJAfJIEyew9sCaJMaYVSAsqhCaFm9IZZbVLbseIeZeP3jktCY31hoo6ZyEzPwso2KTHT0DdZIYE0WOWabXAs+tAuTsd+5crEyk0R785RxrjzlkjujY/FM/QX8C7Tc+VB2pLbpEdS3yjKnFc2Mn8lJpYAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627778; c=relaxed/simple;
	bh=MGf9/co0ByLS5RAptUdqGlKafVazCJHcso+1xccCN4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CVda8FBXrjLTWDgz1dGvwxdMRl1RcF8/TOzk/gFFFko4PIm/2uLJFBAPYrbWag4tikCWMNaTloZaYs0IiUUsMtNd90kaSoPen2RlGcg5ze+QV5fcX/d9eqyoX1ZB1er0zO7qqUgiwvEJiRenoQThrf7P1TehzcaKwODxDBIlZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4X8FJQxr; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4X8FJQxr"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b6a8b32fa9so10173170eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627776; x=1769232576; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TCvh4Vl2F2EFt/f91KAA0cLNnhh1VtUSP6qDYdHXzE=;
        b=4X8FJQxrbBns0sfNzAJvxisb2QMVjihCq0Y9IV6ARbP3+Y3L2S9NeIoYbrlE10GUdG
         2pY8L8723Ih+Eg9H7cHUocrF3Sq8LNOzH11z+M700SN7p9h/oTpaxMQQcN47COvkF2HB
         OM8RRFQ87PFC1dW4beF4EY0/vmQeYrvif1Wf5TS3eK8uDwVaHP2BAeUByrZoE4bSBmHF
         eZTO7UUazxhTyZ13q7HGQ8YqBFdJ5WJm9vQiVETaE+DJu83ZhutT78Q4QvZEAq0PhPPW
         pIKLnvJ48OiwBpxbV9SDgFu3BEjrcOIeC4JarlqLMCl2l/goaOoRGc0rX41Ddmzuw0wN
         FH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627776; x=1769232576;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TCvh4Vl2F2EFt/f91KAA0cLNnhh1VtUSP6qDYdHXzE=;
        b=pA2swJXPFOpaTd7YCTcQgQAFJcUFPpT/18az+8wu+8grzAjZ1370Mqms/nHSCPY9jL
         qHf7gwKUPexRFY+tE3c6710rhhCtAweVW4TQgulaMdCrKeJf5wFfTLhL94B3zYswUaYx
         WJ4e6VGq+SmV62LeZR9+d1KjBmxT3lDlyBeIYDBORS0eBFLCp67u4iZjNLqtuQnv+Xiz
         QlbaBbvlNYK8aETP3lQV6xVGbFUQpx+UpPrUKEuoOPSJmvJQ0Nh6PVcyC/7HjQEkWhmy
         pSg/o0AiUeyHi1x+/5vEd9DRxloUBFqhMowXYjTjVXwdKaFo7nLRMTwN5rxwLFmC1Rry
         tKgA==
X-Forwarded-Encrypted: i=1; AJvYcCXuATeceX+nB+hfuJ7K+u/xhYukjGxw1+EjPeaRNYajSyd5BDjZuK+6rKrHrVTCoP8bG4uE0E/g34vRmaHpcXW7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nrxowFqaIAO5hg4f+ytsUMkFNaQJWRQK3O2ocGTogmhb/INa
	+SDv2i5HLZsvyzauQ/pOqSTCMNvKQX2QuzAJhq5ndHKVffcjQBheXFCaGiuhri3tNyhKnZM5k9l
	OBSnOEYgHLQ==
X-Received: from dybut9.prod.google.com ([2002:a05:7301:e0c9:b0:2b6:c085:52ca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:50c:b0:2b0:4c56:be16
 with SMTP id 5a478bee46e88-2b6b41016d0mr4300841eec.29.1768627775839; Fri, 16
 Jan 2026 21:29:35 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:35 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-10-irogers@google.com>
Subject: [PATCH v1 09/23] perf dwarf-regs: Add util/dwarf-regs-arch for
 consistency with perf-regs
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

perf_regs.h has cross architecture functions for operating with the
differing perf register constants. dwarf-regs.h is similar but for
cross architecture dwarf notions of registers. For consistency move
the arch parts of dwarf-regs out of util and into its own directory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                                      | 4 +---
 tools/perf/util/dwarf-regs-arch/Build                      | 3 +++
 tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-csky.c    | 0
 tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-powerpc.c | 0
 tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-x86.c     | 0
 5 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arch/Build
 rename tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-csky.c (100%)
 rename tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-powerpc.c (100%)
 rename tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-x86.c (100%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5efec73be474..3cb1edd263cf 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -219,9 +219,7 @@ endif
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-arch/
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 perf-util-$(CONFIG_LIBDW) += libdw.o
diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
new file mode 100644
index 000000000000..98bec0032606
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -0,0 +1,3 @@
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
diff --git a/tools/perf/util/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
similarity index 100%
rename from tools/perf/util/dwarf-regs-csky.c
rename to tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
diff --git a/tools/perf/util/dwarf-regs-powerpc.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
similarity index 100%
rename from tools/perf/util/dwarf-regs-powerpc.c
rename to tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
diff --git a/tools/perf/util/dwarf-regs-x86.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
similarity index 100%
rename from tools/perf/util/dwarf-regs-x86.c
rename to tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
-- 
2.52.0.457.g6b5491de43-goog

