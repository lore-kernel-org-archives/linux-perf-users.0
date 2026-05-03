Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD917A586
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768558; cv=none; b=kUqxTQ7ME6hx1qE1aoU59meojUNBj6ezDSdCKFrIp54H837qXRyZqkdV6CXkbC1zOV2SI0gc2UzRmT/BugjQXgNiOkumKwfCXuAhgaec2VfXqFBF/8Z57mNdgila5itqZu7aZP82MW9/TuKtJPM1/LQNb+op0vaLuVaB6UNDpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768558; c=relaxed/simple;
	bh=B6e/8lzag3KzqaiC7GT7z4a7HEGPmZOmsDn8H6Ini3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SbA81EVPDbzFX5pBVRvbRAbRExJgVGin/7w4GrmSSvaVP+v0vLuj61yunwuUJey3R4DU+uQv88Md8XuHnCy10H1mOLy0Xuh0sMxcJbsxiRVB2iLRsAAq6tG4UQjezWUvFcXKT14Rbr5yQPA+yIo8LVQX+4ZKuJIpH+k7PYadIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta9VcYbM; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta9VcYbM"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db37213daso1726386c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777768557; x=1778373357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vt204hYM3o4ygDaCmNEs8mUBPZRuNEjzBJxT5Rc+5L4=;
        b=Ta9VcYbMsm4Ol21EvrlmBq6/OPSJ80QQF2Zvz0zsywgnPfDczxru1dKhibFwKbaiWb
         wxgPME8LUlHDP6wEZu7jRXHd43NG9IBgsSvjFs9su82zxlu+xbZGwUWz2qRqnD9pm2VR
         ehpMHHKPeRyDy8eNLR/fwzERyNkgWBxt3i4AkZvgmvgX8W7ZDJcr54JAkzJDziExU5eg
         UJmlOMn+FCJPxUsXXPy83hsN+0LmV8L/qqsw48DfovjbEw85vx5UrYrOM9dr0ClGzaqf
         bOjoc7E5YRcodFlnQJ512WqMt3RPpSFSXGdMp7EWv3oYjzrH2X06pMsZdt5Q4SGLIlbI
         NL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768557; x=1778373357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vt204hYM3o4ygDaCmNEs8mUBPZRuNEjzBJxT5Rc+5L4=;
        b=nhHsgrQdEzefAFZ5bTJg+tQViuKMq4/e9zk9cOGA7u/EFS7BqBUunPUVDryMc6UD1B
         es2+papQzUiPUnHIX3EPfGTSJW8mcAW12jnUMg7EJaxaxfpkWj1Cx+jyxrmGRCQVgwlg
         90AqF8u5Lg8c/A4wzBrP+Nc2+3QqKFJ//jmd3mwb1BBUgngnK5RmN42Y+cNmHAZRfPzE
         Ay7ldLJxwnX3N12lDWYznac/6nSaqIH2IAz4iP/zpDO4j3KaLI5lVtT2J6t3OSP6qxJG
         dNB8DuPzVObmzW5X/gaCacJ3q3sI/RXeZxjqj1XwkcQX18uzVs6kf+pbojY7GiKgN59S
         YkWA==
X-Forwarded-Encrypted: i=1; AFNElJ/RzwhbtfEGV3qsBeuYR6gMOYQReW6jpvdBTryIXiu74HDCwvw7KaCPGbBK3hhhECzFmyB6wkCVX4zuzLOWzHkG@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWa7GQDArz/oiXRv+rc5Lq9qXuGlNa+BbHAM+bOLrNwPG/2k4
	4zECmqDJF4zNpc9dmM2mU/R67ArfUfmpewtV+Oq8FNaHn3DdG0FEzfTG+4ixdd2hh/4pFkHC0kj
	qO8sGbOtZMA==
X-Received: from dll26.prod.google.com ([2002:a05:7022:21a:b0:12d:f46c:8f9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:913:b0:12c:5e48:4c01
 with SMTP id a92af1059eb24-12dfd7a0cfamr2238258c88.1.1777768556396; Sat, 02
 May 2026 17:35:56 -0700 (PDT)
Date: Sat,  2 May 2026 17:35:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503003552.1063540-1-irogers@google.com>
Subject: [PATCH v3 0/6] perf DWARF: Fix libdw API contract violations and crashes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series addresses a number of issues related to improper or
incomplete error handling when interacting with the `libdw` and
`libdwfl` APIs in the `perf` DWARF processing code.
                                                                                                 
The first patch fixes a real segmentation fault observed in `perf
kmem` (via `dwarf_child` and `dwarf_diename`) caused by
`dwarf_getfuncs` returning `-1` on error, which was not caught by the
previous `if (!dwarf_getfuncs(...))` check. This allowed uninitialized
stack memory to be returned and later dereferenced.
  
Following this discovery, a comprehensive audit of `libdw` API usage
was performed across `tools/perf/`. The remaining patches proactively
fix 28 additional instances of ignored return values or unchecked
pointers that could lead to similar uninitialized memory propagation,
crashes (e.g., via `strdup(NULL)` or `strcmp(NULL)`), or silent logic
failures.

v3:
Minor formatting fixes.

v2:
https://lore.kernel.org/lkml/20260502155656.478642-1-irogers@google.com/

v1:
https://lore.kernel.org/linux-perf-users/20260502064839.282422-1-irogers@google.com/

Ian Rogers (6):
  perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
  perf dwarf-aux: Fix libdw API contract violations
  perf libdw: Fix libdw API contract violations
  perf probe-finder: Fix libdw API contract violations
  perf annotate-data: Fix libdw API contract violations
  perf debuginfo: Fix libdw API contract violations

 tools/perf/util/annotate-data.c | 17 ++++---
 tools/perf/util/debuginfo.c     |  5 +-
 tools/perf/util/dwarf-aux.c     | 37 ++++++++------
 tools/perf/util/libdw.c         | 24 +++++++---
 tools/perf/util/probe-finder.c  | 85 ++++++++++++++++++++++-----------
 5 files changed, 109 insertions(+), 59 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

