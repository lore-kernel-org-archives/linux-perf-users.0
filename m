Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53B31C576
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627764; cv=none; b=IenS0GyK6YCEZ4OJk8x/fWpmJ/H7L6VtrYTHwJGL2Odzzv+u1pOpWXaScCWt0nHNNlp10RC2UCgdieiC3dKn1O0tNOuNr7rhm07IEnGgCxDBdRwg+pT5kv/UPvAo1BnznfF9v84MDVoo7nnV4dlbuewovpUXaiIavdaKuOlu+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627764; c=relaxed/simple;
	bh=gbFw65gKDB9Q7CSGbuP34AO5oPVulM2chbHXMkIGkC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r0iZgdRWJEQEtRXm0L36+jkQu1UzjyCE4uIvMXDnIAsywivi/wb5Du/xsFQeCaKOfl4c1JD0hsTGFsV3HibEzUrcBieOzTjFR2ZPZgzlb4NPXcq4/9Fv8k4zqu5ZGxc/57M/T6HU8PaUJEaRkpzYuUVNGtFU31bZN8wxYH2NAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1bGZTB9; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1bGZTB9"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b21d136010so4465044eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627761; x=1769232561; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OS8+jcXChzbawXYGLy5k5VOyetH1gbj+eqgOcCR0OU=;
        b=H1bGZTB9/sYMy7T9/JjX2ZVtV5ZK1u2ryhz88RYKQUHOZRtrLax2Y9p87nXXaXHr9Q
         4p8mChrMEdd3RMgx+A80yNCgZtEmGM3Ss6TffX/ltIqUnLhXU3/FWI1daTRwIdQop/v2
         lQaw1Oge1f+2n/yAXFG4xep/0YB0IlqiaAOyZ3IJFqoIshZAf+OHbQG1FmKqUrhCtABD
         3es8irDPceXBV92FBnF3XWbc8hivatbsjzV2vqFOPh+ec8N4PJcKM1arMtU2I1sbCGDt
         p4bAbsdX0Bm3nFpWuUr+cb2LnhwmO+sfQgqyPKinzB43TujVWsq92IW/Kw6gdf3j4xOs
         nenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627761; x=1769232561;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OS8+jcXChzbawXYGLy5k5VOyetH1gbj+eqgOcCR0OU=;
        b=CtXiD9RVk+nADW98xX1QwKmqlfx9LHFcTfphnsOr5nJ6u3G3pPMNdyqNPOAmy+CuHx
         IKE6Z9sHWdnDMvWYuZhINQRP+Lch8AHFpK2ew5wVc+tPD5HeO8Lz8kQtMgHGEYEO4+0e
         ufvocEx6sdfuZQ2nMoF1WOV1MPeynxA2MoQeqvxkDZvscQQ8XOUH3CLmORbF90nvq3ke
         lBmhDZBs40QH0Uy0pAVx23cScjOHlIkGe2ib3DyeTCqsm1AibOfbJdRsajkAWSqgmXlo
         ujP2ptPlLuGl89t5KvubvOjOYg3mwDVNI6xa49uxEPPXDvB4ZHe9dZPXUm2H2vBd8JFn
         o60g==
X-Forwarded-Encrypted: i=1; AJvYcCWln0YbVul9/jFUmjzIjqSOK8TzD67RvFSBZjRkcaS4kNouz3qKY/UEviHUyoh3MpsSY9xcSPPWlwfJtVmUdtYq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Z+ODIyjdYDXayoncTMbB+Dj9NQNc8aTOCiLKjC0rvE2J1aKl
	LxVCAHW3POYW+tvtAMQiAik8+ilzQr8CUq2RWL+7k1dyoAZOaXy2IrO02VRhA4C+Dl/qGVJIsTX
	Oht7QQUqUbw==
X-Received: from dlbrh14.prod.google.com ([2002:a05:7022:f30e:b0:11a:44f1:daa3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc04:b0:2ae:5b71:d226
 with SMTP id 5a478bee46e88-2b6b3ed9044mr3890490eec.3.1768627760880; Fri, 16
 Jan 2026 21:29:20 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:27 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-2-irogers@google.com>
Subject: [PATCH v1 01/23] perf symbol-elf: Fix leak of ELF files with GNU debugdata
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

The processing of DSO_BINARY_TYPE__GNU_DEBUGDATA in symsrc__init
happens with an open ELF file but the error path only closes the
associate fd. Fix the goto so that the ELF file is also ended and
memory released.

Fixes: b10f74308e13 ("perf symbol: Support .gnu_debugdata for symbols")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b8fea12997a0..76912c62b6a0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1173,7 +1173,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		Elf *embedded = read_gnu_debugdata(dso, elf, name, &new_fd);
 
 		if (!embedded)
-			goto out_close;
+			goto out_elf_end;
 
 		elf_end(elf);
 		close(fd);
-- 
2.52.0.457.g6b5491de43-goog

