Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661D2135A1;
	Tue, 18 Mar 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339473; cv=none; b=OmRLH7zfwJoaZuFfAunjBbUkewrUhFNOICKLESCttH29uFmdm66K8TyZJqLlllDADlHRWe/nZzt4LKsQYab2oQnBj1QPmNGeGH/nSwELW8hQVXjIuZZt6GBg5oIjcoW/jgRqdsvZi38QNznXWvIHJ1wZr0FJTG5AX1u+HMxY3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339473; c=relaxed/simple;
	bh=NyAalbJEbKhy5MsQuyLH2cdfBezH+SpSG28q0T+YO10=;
	h=Subject:References:To:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=egv6ifuLneeXwD+GZePpX6EZsoxlhXp3ZuT6ngPSVn/folyxIVbrQMtGOE04z+9Naxklkbxl6xPuCe9CG96+yqA+Z+uvxoLarwBarQ8qRNX9sIVj5h3kPdmJdpeghmaAMOcUjxY1h0U/b3AV5T8LpnFrBdJ9X3wX4b7NBUxAIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 633CEC902;
	Wed, 19 Mar 2025 00:11:01 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 592ED601853A3;
	Wed, 19 Mar 2025 00:10:59 +0100 (CET)
Subject: [PATCH RESEND] perf build: filter all combinations of -flto for
 libperl
References: <fa1c3b38-6a23-af22-0e5e-280fa523d06a@applied-asynchrony.com>
To: linux-perf-users@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Guilherme Amadio <amadio@gentoo.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
X-Forwarded-Message-Id: <fa1c3b38-6a23-af22-0e5e-280fa523d06a@applied-asynchrony.com>
Message-ID: <c5640c73-944d-5de1-a0bf-7e6769c1542f@applied-asynchrony.com>
Date: Wed, 19 Mar 2025 00:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fa1c3b38-6a23-af22-0e5e-280fa523d06a@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

[Not a peep of feedback - if I'm doing something wrong here please let me know;
  the patch fixes a real bug someone reported in Gentoo.]

When enabling the libperl feature the build uses perl's build flags
(ccopts) but filters out various flags, e.g. for LTO.
While this is conceptually correct, it is insufficient in practice,
since only "-flto=auto" is filtered out. When perl itself is built with
"-flto" this can cause parts of perf being built with LTO and others
without, giving exciting build errors like e.g.:

   ../tools/perf/pmu-events/pmu-events.c:72851:(.text+0xb79): undefined
   reference to `strcmp_cpuid_str' collect2: error: ld returned 1 exit status

Fix this by filtering all matching flag values of -flto{=n,auto,..}.

Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
  tools/perf/Makefile.config | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a148ca9ef..4f5a40ab8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -820,7 +820,7 @@ else
    PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
    PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
    PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
-  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
+  PERL_EMBED_CCOPTS := $(filter-out -flto% -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
    PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
    FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
  
-- 
2.48.1

