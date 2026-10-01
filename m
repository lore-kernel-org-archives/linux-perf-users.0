Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674453264EF
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822072; cv=none; b=ObZ7gmhQNl/TV8vPmu4X9S8OF5Nk7GE04Ys+TpJo1izwknUbwxz2NbbXj8+iPSwsPSZUo/yPd+8yqD/dSYSvgqtJNaj+vkXS3AUsSOAf/BKfyXcYharsUU/bdq9+9RWo+39hne2vy7GFUe+1SVEWqhj0UMcpdQKmmxIJGdT+8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822072; c=relaxed/simple;
	bh=tJLSBp+kNBBrje5fIBKYtbV2LB4PHDOtdNFnpagtoI8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=RdWJ7yT/BqvoOLq/99spnSfnjHC9mZAV+CyzmDpF7ecZne/MyscTznqfwbYhUra06gSTKKbbRn0xjUID/WGIgEr7axNVURHfwEo1fhnQ3UOl2jIrWfuhsOZocCC/WbZfrMPuGewp+9sOOvXD4+uzHWC0BVaGseYRo2hP6/jLsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYSo1Hek; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYSo1Hek"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so8271891eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790822069; x=1791426869; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZsT3C+uRh/Y1Rc7z9nbR/I76xB1e1WP5VpKrJhiPQsc=;
        b=OYSo1Hek0SlakenuXgpd+v3gZ0WRYrxDx7jKpUPtqCV2Ksm0c8yVDDMaYBlanyFqT1
         RQkcs+/Z7LQcrwAhP4udFwAWCkVjOIY+Psq2O00BH5fMQ0y+6lowUDqQ9McPRKozlVrs
         8Dce8crseO5ecigumwy54N98kUjXSdx/D9vCn8BWkIRrvnrc+zRQBkYd8V2lCOQk2lLF
         KZplq4oMxnXP1fTakVCkhlLK94j/oFBGbIqnjzB/R8gZg2PUEGGnjslvz3MU3DHYQxmE
         Y+UwCCcPbuIVQ8TbzFY6EYTdJwcjcSKSYYqJKyWgM/ljWsnDCBY3BpO4/LwHyNE8MIb7
         f9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790822069; x=1791426869;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsT3C+uRh/Y1Rc7z9nbR/I76xB1e1WP5VpKrJhiPQsc=;
        b=nYypHwXYfvL+ILDV5xX/MyYAQYfbedGA6e05czMbPBrevzWcbiEue3Ri/E/8t8dnf+
         veM9CLeZOb8NeglHkDuj+CLF94IhS+RJygP2Dbn4jAf3ifYg5hTtjskjJ2fV6mN8yHM/
         4LEiT87h7Ck/qpl7WYaXBPOt+3OsJMGLiQV/9E677mh6q12bvOQRsWAWXpq7yXVzIlc9
         KSUFVrhh7JzB08iH2rA+zV1YhXUVz/C9TL5/p7Npju5955YDQ6oQdC66nxGQSi3OEJX9
         YDN4l8iLk7Aey+jtk4Jc9mWCtkKcNsAfFmj/RTCLEP+FrkPe+cVNZ+jptXT697dJNtNr
         CvDA==
X-Forwarded-Encrypted: i=1; AKwUvByPPBZmhLUx4Y86ECxT/oN9O+/l/3hOLgjHByI81SbpY8d0Ot0bCQ3sIFY3R2OXtsMHLSFYjfCvnOD/uCl2prH6@vger.kernel.org
X-Gm-Message-State: AFuF++lY5DYGMtPDZ3d66Hsw/P+w3EwNGTHWOwsAfrNERCcJobbrRTlj
	Yg++AhavUcPGs3T8up+m7ojyqvFKLPEGOzklA1piK9418VbxARYqHbjzMwsVi2wiSbImx3LXyAJ
	snpWxJ0J8Jw==
X-Received: from dlbui24.prod.google.com ([2002:a05:7022:3d18:b0:148:9dc:8414])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c971:b0:14c:1f57:3ea9
 with SMTP id a92af1059eb24-14d32ec4886mr4253224c88.26.1790822068732; Wed, 30
 Sep 2026 19:34:28 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:34:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001023423.1225713-1-irogers@google.com>
Subject: [PATCH 0/4] perf build: Linter parallelism and clean/install
 dependency fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series includes a small Python test cleanup alongside build system
improvements for linter parallelism and clean/install target
dependencies:

1. Update tools/perf/tests/shell/lib/attr.py to use argparse instead of
   the deprecated optparse module, avoiding a pylint deprecated-module
   warning.

2. Building on Leo Yan's recent change to run pylint checks on
   standalone scripts and tests in parallel with linking perf, move the
   remaining shellcheck, mypy, and pylint rules (in tools/perf/Build,
   tools/perf/tests/Build, tools/perf/util/Build, and
   tools/perf/pmu-events/Build) into top-level phony targets in
   Makefile.perf so they no longer serialize archive creation, jevents
   generation, or final linking, nor wait on $(LANG_BINDINGS).

3. Clear GTK4 via 'override GTK4 :=' in Makefile.config when the gtk4
   feature check fails instead of setting the unused 'NO_GTK4 := 1'
   variable left over from commit 4751bddd3f98 ("perf tools: Make GTK2
   support opt-in").

4. Fix missing dependencies and target ordering for clean and install
   targets across Makefile, Makefile.perf, and
   Documentation/build-docdep.perl.

Ian Rogers (4):
  perf test: Update attr.py to use argparse
  perf build: Run shellcheck, mypy, and remaining pylint checks in
    parallel
  perf build: Clear GTK4 instead of setting unused NO_GTK4 when gtk4 is
    missing
  perf build: Fix clean and install target dependencies

 tools/perf/Build                           |  8 ++-
 tools/perf/Documentation/build-docdep.perl |  2 +-
 tools/perf/Makefile                        |  9 ++-
 tools/perf/Makefile.config                 |  2 +-
 tools/perf/Makefile.perf                   | 75 ++++++++++++++++++----
 tools/perf/pmu-events/Build                | 66 ++++++++++---------
 tools/perf/tests/Build                     |  8 ++-
 tools/perf/tests/shell/lib/attr.py         | 37 ++++-------
 tools/perf/util/Build                      |  8 ++-
 9 files changed, 138 insertions(+), 77 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

