Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462524EF6E;
	Tue, 11 Mar 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714925; cv=none; b=LLOPYeECJWj2L9VCRV0pYy17hjYto/aerxMULwI8cABdPp/rfYH7RqJvACy6XAr6oSphXLFxFAY4PUkW2EGbcN7sMN+GqSBXysJTiTTpBOEd314hneOJNCrB6yHizFXGe7lbcrdPabt1oUiZmOUDbDQfz1WjDPaHsbxqqPSa9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714925; c=relaxed/simple;
	bh=hJlpa7qzIxdqn3x3F/DyyzikAdq8ql0x6CY4+XW6PdA=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=l4wmOx4noV+LJ5ugMuKJeAvRv8xyF0QFZ0PDlYW8fPJFPeUf8cHt14xctDTHsBdZT59kOFXf0RwfswH6v4r3laS01P/5Dfo5XyFmN1BrbPiblc+XzrKcXj1P6myul/JGB5en6t8EemV5NumFeBCkt1QVTd1/xc4yM6f8eitaDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 7603112560D;
	Tue, 11 Mar 2025 18:33:10 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id CE0F960187F25;
	Tue, 11 Mar 2025 18:33:09 +0100 (CET)
To: linux-perf-users@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Guilherme Amadio <amadio@gentoo.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] perf build: filter all combinations of -flto for libbperl
Organization: Applied Asynchrony, Inc.
Message-ID: <fa1c3b38-6a23-af22-0e5e-280fa523d06a@applied-asynchrony.com>
Date: Tue, 11 Mar 2025 18:33:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

When building the libperl feature the build uses perl's build flags
(ccopts) but filters out various flags, e.g. for LTO.
While this is conceptually correct, it is insufficient in practice,
since only "-flto=auto" is filterd out. When perl itself is built with
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
