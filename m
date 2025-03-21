Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5D1E98ED;
	Fri, 21 Mar 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545302; cv=none; b=fX5YLeCG8Nj29vj3D9Rr40f4gwYmAYWcewNcKomcBsXlo2PaDQ4mTiPIBBJ4WsmmxnISbDAra1+GSjoYr2EtiVS5tx584bhdnP1KLHPt3JP7XONpwbqfsUkQYa1mY7i/YSTrSK6gyMa99mZSkWeTPB5OJ4A6/hEyWienbHkcDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545302; c=relaxed/simple;
	bh=9cor238+ev5CH9KBLqifaFnVrdxvygrcxfuimxP/sRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kd2Rug86VhgzEiXkSUC/6nO+g2mfUPIEqJJAVnkXVWreL1KawtN1yZDyJL0rlZThFtZIkz04gx+osgRNjwDqIeNn+WQaQD8Meaz62hnIjKOtY/qjiiwZnyXPgPhxWza1Uo1ZopZt9A+o8ASCBz/Og8q/FYDklc1IOVaz2iGkgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with UTF8SMTPSA id 5B1EC158D;
	Fri, 21 Mar 2025 09:21:31 +0100 (CET)
Received: from localhost (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with UTF8SMTP id 32FA360187F25;
	Fri, 21 Mar 2025 09:21:31 +0100 (CET)
From: =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH v2] perf build: filter all combinations of -flto for libperl
Date: Fri, 21 Mar 2025 09:20:39 +0100
Message-ID: <20250321082038.27901-2-holger@applied-asynchrony.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
2.49.0

