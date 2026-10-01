Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30796423786
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833289; cv=none; b=b14f+0PGcXFmkF8L53cq9zPnhlVyv6T3MyO1Q+d0eDmAEkbDIGpxeN6QAZp0vVitS0euBfwz5/1OrrGgtKFx09k7NcgCBPpMYOx7sMEWD8Ug/Jmzjvc/dcDHeqlsSgaAo5h9uKD90D8609WPT6J+X4I65ApVSlqvJWct3Qo0GHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833289; c=relaxed/simple;
	bh=WjVNvpnW39Z9FSSf9jIfV74czDToG+2Ow/s4nWQO0w0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DywYJE4tOZ76b9rK38PU+gkigelYIpKWRBUW31iplrViSW4KEKXPiPPDpjdLmYa0LbSQtAYvWtkh3KGWBn+GugzsyANe+UBHtUiydKfSe93GPHh8r7mruK21i2JDpU7JhRcqwMMUvYqb5Ky2tpya/m2dnzICz2ZRU0hK9R8rvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BH8BJJHK; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BH8BJJHK"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so8593051eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790833286; x=1791438086; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyQ27rFL4XdC03AH/K2HB/r6yvJwFctKIKLZb0YVYgo=;
        b=BH8BJJHKewDFsjAUM181971gji6iWNOEWZXsHIVAq99KYLO6+S4rI0a7cs72Wq+FFK
         WGd5aNB5gj98AwDxBGfzv/233Tjh66s3yc7nYiyg/LH9JwPQiuuiDh/aXIZ7gJHb9qEe
         zxGkNDdDrq3SqyhQuEuWm/9KwAUp+WsbpwK05NKi+qKwG1cnESnuqHmRJUaxTSCw/w8/
         MwYAgNT1oxvbKJ66T3FdFy7qDtVzeRVKp0bp4rz7528zS/c4gVJQCd8Vr3BOBLOYCgjz
         Ll9l57cInAyp2TXAckKRP62AkovRD06FlJYaaLhCF8etSBF2DtJGT95KXLOVuSACMmp6
         hXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833286; x=1791438086;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyQ27rFL4XdC03AH/K2HB/r6yvJwFctKIKLZb0YVYgo=;
        b=hCHPPw/d+GLCvkFbu49V8Qq62MN3FzEhq9RnimbI9p1NmEjn2HfoeGz1Guw0EU0h6R
         R8KJ+ewDBTsfKY+0UXUROXhN4/mNuwL6mOk/YDNmMEGdzshcWNsCXztGa4Nmr5+fe7CO
         +aH6jIeEttHDtizjRZSfLEXdWcWJLRdCTYlQP4VE/eww2k0KrKtUjASRcgw0/Yfa890Q
         m5eV7P+4hU9f1qAVoYl5SJdO4SioNauaFzVWrjSoiijcu3ppxnCxoSf438gxEfMm/YTb
         CDxueh0Vyts5e7Cra09dGDLNxvE8ApvquZwdb3EV/ducWGlAumohtVNwkb0Bas31grs0
         uVOw==
X-Forwarded-Encrypted: i=1; AKwUvBx9JjpVGYOYSlXy1T9Qb26Aa87DwFUBEnZPqwPTdUv7+Qb+DtrHMa3zjeK22iwa9cqVEq3yRU1/8hpYdwkZbfJ+@vger.kernel.org
X-Gm-Message-State: AFuF++kEsE9/EtFspGLf4lFNlUUz0Mffyr99X4WgLh3TkFglUaHN/IP1
	MVKAshRFeszg46Yar1lpQn6oIFH5BkBSonTBTsa6ucEACAbh87gZQQhLZkKQgRuRHbapaYNvG8z
	Dxtn9QLTXwQ==
X-Received: from dlbqs3.prod.google.com ([2002:a05:7023:d03:b0:144:e316:2636])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3a04:b0:14e:6b46:6494
 with SMTP id a92af1059eb24-14e6b4667c2mr554777c88.4.1790833285583; Wed, 30
 Sep 2026 22:41:25 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:41:16 -0700
In-Reply-To: <20261001023423.1225713-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001023423.1225713-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001054120.1570943-1-irogers@google.com>
Subject: [PATCH v2 0/4] perf build: Linter parallelism and clean/install
 dependency fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, leo.yan@arm.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

v2: In patch 4, exclude 'install-build-deps' from 'install_goals' in
    tools/perf/Makefile so it is not ordered after 'all', and explicitly
    order non-'clean' targets after 'install-build-deps' when present.

Ian Rogers (4):
  perf test: Update attr.py to use argparse
  perf build: Run shellcheck, mypy, and remaining pylint checks in
    parallel
  perf build: Clear GTK4 instead of setting unused NO_GTK4 when gtk4 is
    missing
  perf build: Fix clean and install target dependencies

 tools/perf/Build                           |  8 ++-
 tools/perf/Documentation/build-docdep.perl |  2 +-
 tools/perf/Makefile                        | 16 ++++-
 tools/perf/Makefile.config                 |  2 +-
 tools/perf/Makefile.perf                   | 75 ++++++++++++++++++----
 tools/perf/pmu-events/Build                | 66 ++++++++++---------
 tools/perf/tests/Build                     |  8 ++-
 tools/perf/tests/shell/lib/attr.py         | 37 ++++-------
 tools/perf/util/Build                      |  8 ++-
 9 files changed, 145 insertions(+), 77 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

