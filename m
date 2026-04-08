Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B353603EA;
	Wed,  8 Apr 2026 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627586; cv=none; b=eZyyDAOKEwt0FCO91Yb05RChh7g3DTYrSuTZgF9cFfVPEI+P5NImzS/LHBliuDWlBa98afqlj2vg9cIftHr8k1pFldjrxjO34gu9Ze3fjX5MvR32b35/Ir0JuXTTsWLGDMaJODyN8VPzviZsAluVB0Uj/YzCtFMhBgWl6Yo6nBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627586; c=relaxed/simple;
	bh=CFzv1HCEp1/lqDNqrl5R5DwDt1jCg5Vz17yZ9+oOsHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaUw93oUzI9GeAzRKP6LtWQIAsz5mWOgSstc8pPLUbe5A8gif9ZqkcRiOX69kAl+zuHNJ5tP3c0hYiqIqo7VjSJiRyWOWmpB9R1kLB8A+IPuzt5pmIDgLhkWsm8gAJo7VoCsCv41sSWpsSypaXa305LpVSsNJoUtjGsnk5SyoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMZ4IQWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMZ4IQWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F502C19424;
	Wed,  8 Apr 2026 05:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775627586;
	bh=CFzv1HCEp1/lqDNqrl5R5DwDt1jCg5Vz17yZ9+oOsHg=;
	h=From:To:Cc:Subject:Date:From;
	b=cMZ4IQWYD6sUmPtuR11meKJjlwf+lmSdhWQBeUeG8QaYKpbExgmM8yekG2SH+9V0o
	 CvdyBCCTLaBKUjs3pXDn/rPyOa0oSogRlJ7GT+TE+HFiLHCDjTvS4iAZeeh594+Lt3
	 Yh2gmnXEOg3AMht+j3UUqyxenHwl8wiw6SKkFaXuvoBdnmZMxv7R5lwVwkrbdIX8uF
	 LdHsMMWdGtJoMB1cO+nYsyz32xOu090EPYRdPb+pnSh6GioNsCFTkxhwCuPaC9j3yS
	 fs1cBcoPalq7WRcST6So8lWRAODoLul2qXTg/qH4g8jm88/fyy9CtGOYurQ63M1cRW
	 1TwgaH34AHoRw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf build: Update error message for BUILD_NONDISTRO=1
Date: Tue,  7 Apr 2026 22:52:58 -0700
Message-ID: <20260408055259.374744-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should say binutils-dev(el) instead of plain binutils package as it's
mostly installed already and can confuse people like me. :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e6686641761fd0bf..ad5401eb720e9e78 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -923,7 +923,7 @@ ifdef BUILD_NONDISTRO
   $(call feature_check,libbfd-liberty-z)
 
   ifneq ($(feature-libbfd-threadsafe), 1)
-    $(error binutils 2.42 or later is required for non-distro builds)
+    $(error binutils-dev(el) 2.42 or later is required for non-distro builds)
   endif
 
   # we may be on a system that requires -liberty and (maybe) -lz
-- 
2.53.0

