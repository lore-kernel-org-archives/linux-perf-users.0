Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497337FF5E
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726820; cv=none; b=RgbwRC1rBihsoTzWCbdtru5qz0efRwITj6IiL36Kx1Y1L89D9mvSKPh0zQjhiYcEYBeskUqkGXZCniYPdVyJKLRdbWhsHTK3yDFm6YYYqSushpXHSvojIsWy25Ih7hTlShboKe1QawrxXYsum61ysl0dk2cTDbF9tNHDp5uj88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726820; c=relaxed/simple;
	bh=Y10Fph4pdfNxOP5t337Na9hfCvLzUcUVEvKOyIWjflQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dlObjpRIcXrKP+agk7W+kJzy0ltxuidqPb2/7086mY+c3v91zJ1JZfriWWg+prLs4/cn8WH++Mbjg+vZB/6wQNeear/sOtinEEpBWdSz9u03B/48c7NK6HRW6eqsLUT2DfrhaOwbD/Zix5oFLHHhu8JPNFN7z3QPaefOz7EF6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDa7VS55; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDa7VS55"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1276e71652fso6014277c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726818; x=1774331618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fE/iA9PqT2lIWRDdVjJZGdaDhbB9bCZetVtUGjHjBm8=;
        b=PDa7VS55ARfMseo23YmyKqNq8gu8r3jy0V/BJ8iQGa5uScMgm374Kx7IYd85TrcS54
         YKj48JAi3fejjQgJV3ROXk0NykyMKfEhC113T42UyCJpGQiI1pnzFVaSt8TyiiQNVa1A
         L0Wi6wmy3+Ixjud7e/BoyTS4c/HJGq0IzAv008VLLfxUaf3qaQHa+xetwZWTfHH1gBNE
         Pc5BPYZyeU4E5HA96EqEhOz7GcqlZH3MmPb77PDUtjpHDmo5pLCzpNLcur5SD8wmrtMG
         7O3cUem3/3n5h1wmf7oRgliYyKs/MtYfcXOMSmjl9P1OBNFV+zlzteRj7UzdTgHaaBQR
         OrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726818; x=1774331618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fE/iA9PqT2lIWRDdVjJZGdaDhbB9bCZetVtUGjHjBm8=;
        b=AXdpubBz7blME34NlEglps1cllKKkcXfbySqVHeO9v8eZJCHGWn+HuhLmCzykklEXE
         cVLeSn4LdFAKlMubnxyaxAipDE1kRhmVPrIDhfLPlyv2P8qD3E2wTGoeT5RwOnoNlgXJ
         f90eSxKtslnhbiuBvKK4Lc8Ex7adXFZ4mvzeoz7u+YENQBvjXZMa38+rlvpaqi07YNRj
         RZtNQT8Drj0hCp+ZzCdeURQojlKfXii6KFFGi5eqLziiYrGNThE+z2IbSpe57VgUr+pC
         PV7XhTzQwU2sYdw69kgaFjeNCRZ8PN/PLSZTxhFeuSPqOIFwLxIVrWiEI3zShliTU4AR
         jR7w==
X-Forwarded-Encrypted: i=1; AJvYcCUhq+hMcMzWGG4n34VSDOBy92ddncrftaWDW8h4ixFeAOP3mQCX+dgIzWsW8+eaxiH/7wg06WMGnPikW7mV6tWj@vger.kernel.org
X-Gm-Message-State: AOJu0YyYptFtN6Oit9GRdEsrPTa1vRjQvc9frFyhakSWq0dbnAhmJBZc
	ND8yqO5eb2ZUoHkRPv0IhhkJ72ywpqLC3/0xktfm1FTX/FpVHO25XrbHx3jzF0qT9WvXvp6u2Ow
	Nh/eRE10lpw==
X-Received: from dycqu6.prod.google.com ([2002:a05:7300:df06:b0:2bd:fbeb:5cfb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:698b:b0:127:3b16:bf4f
 with SMTP id a92af1059eb24-128f3e1706cmr6497255c88.40.1773726818203; Mon, 16
 Mar 2026 22:53:38 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:29 -0700
In-Reply-To: <20260317030601.567422-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-1-irogers@google.com>
Subject: [PATCH v5 0/5] perf evsel fallback changes
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Discussion with Thomas Richter in:
https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
showed that the evsel__fallback wasn't working for s390. These patches
avoid the problematic frame pointer callchain on s390 and fix
evsel__fallback from a range of problems when falling back to a
software event. I simulated failures when developing the patches but
they are untested other than that.

v5: Fix the value for the top option to match that of record. Tidy the
    callchain parsing option callbacks. Based on AI review feedback:
https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google.com

v4: Changing the callchain parameter at configuration time means other
    options aren't set the same as they would for `--call-graph
    dwarf`, for example the stack size. Switch to setting the
    callchain option on s390 to parameter parse time. For '-g' use
    '--call-graph dwarf' for s390. Other --call-graph options are
    parsed as normal, but a warning is generated when setting
    `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
    when there is only 1 event in the evlist.
https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com/

v3: Incorporate feedback about event and callchain behavior for s390:
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.com/

v2: try exclude_callchain_user for s390 rather than fully disabling
    the callchain. Fix a missed clearing of is_pmu_core if the
    software event fallback.
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/

Ian Rogers (5):
  perf evsel: Improve falling back from cycles
  perf target: Constify simple check functions
  perf evsel: Constify option arguments to config functions
  perf callchain: Refactor callchain option parsing
  perf evlist: Improve default event for s390

 tools/perf/builtin-record.c      | 64 ++++++-----------------------
 tools/perf/builtin-top.c         | 17 ++++----
 tools/perf/builtin-trace.c       |  9 +++-
 tools/perf/tests/event_update.c  |  4 +-
 tools/perf/tests/expand-cgroup.c |  4 +-
 tools/perf/tests/perf-record.c   |  7 +++-
 tools/perf/tests/topology.c      |  4 +-
 tools/perf/util/callchain.c      | 39 ++++++++++++++++++
 tools/perf/util/callchain.h      | 12 ++----
 tools/perf/util/evlist.c         | 32 ++++++++++-----
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 70 +++++++++++++++++++++-----------
 tools/perf/util/evsel.h          | 10 +++--
 tools/perf/util/target.h         | 12 +++---
 14 files changed, 165 insertions(+), 121 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

