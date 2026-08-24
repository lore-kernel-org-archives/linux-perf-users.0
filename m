Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885863E6DCF
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553479; cv=none; b=NZkRi0iBDgVytmljZnoDWwA5xEMjaTFjZk0u3OJ/c18iEvJ8JbGm8ur5O/K+0Dz/KnwaxyPxiqXfKzFCVrMLrI/KyT09akdUZPmrQbLSgGwEvoDLGWb70wl7rgUPvO37v51BJ4lT7ZyCfSfLfpfnP6ivi9Syl3qCE0bBhY9MoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553479; c=relaxed/simple;
	bh=GCSxuvvpW+AQjsFTxOzF7FRcEmqzSou5HDDAmwaKbZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hbTZuue22OT5H9JoOfjYWdvUZwqBaYINpBaBcwKe6rys9waYVfV/zVKaEH58Yl8qj205HZD4gZtZ5t4kII+vnx7iipjUKK01CZI4bbQWdUGnS1ng8v/Z/bWN7Co8YoWT4/A+gXqvpvFVnTWCs84A1PhfU2DzGFdTbrqjslxeXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuW+Kx8b; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuW+Kx8b"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so674288a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553477; x=1788158277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqe/SWEf592noLHVSYIELu6Va0G8zwq5y0ATE8PMvvk=;
        b=BuW+Kx8bnejd1maNNO4bpTSLVuxzCngRFuZrl2fA+AbByNKc8MIK54apID8BnZZeYl
         XjgsG70AS+9DqUSpwKevNz9Ydz3BN3fwS8xYaYZHBUHvw2oLnq9WgKVVkhaseX26dOTB
         JTTq7g1yJwi6VtXNMtEq592LSKC7V9GsZOWBcqlAYVUymUuDQ3hx2ERX27w2rO4ZRdWI
         BejN1BqWPlkg5I0QbpywxwDUzDxy4BrlhBb/2fAIbwnUYjbzfLikuOp+7H3Ze8tGZR7B
         D6QLXar0rh4MphOUIUpkIOzFL1eSLZ9NCGSy55E3CkJiH17XAfr4cp2hMZNeBA1c8eIK
         pXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553477; x=1788158277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqe/SWEf592noLHVSYIELu6Va0G8zwq5y0ATE8PMvvk=;
        b=hgxuUvW/Hys8wpEkIeLQSsmZm515/dYHDmn7kTuNJVLOtHZ21FMEhGF3f3eXE1bDsu
         EWKvmTDXjzUHhKlHVuGEiudpk+68pX4V4u20yjZs6kZeeiSTq8EZRll8L8WijFjtB8Pt
         HlUOO3zDdlsXxda2dK1TIpz0pQOAq1Sic3+cfalQEbkJvYnQM82n51TsLDRbDEzOk2/V
         uDQdtikyZVeWsvE4FrDbQRawViVR2BQAm4ceSQWYHpM6Wj7ipoLFEtXm2WtHPmpDnvUb
         vxw4Bwm6Uw6xcCVNpAjYT+2daFpgXrX3AlsqilywnYnl/qhqk4ATMtHJtVQNMWScrF10
         rFzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLKOl2w6OsvhbtmeLJzT54g1l2/sMrQzK0rlWnNbK29gpmWvdVCA0+2OFAPH+My2bGuNrw9v4vY7lim3CM5rV4@vger.kernel.org
X-Gm-Message-State: AFuF++lQ+agOdRQ0xHpXZsgA/2uZt/pV76cjE1xfUjgD6Vx1YQoOlQWb
	yjGdhaCiz0HbLD29V52koIerI32ub6NT6E/7xrxv9WDY6LHrqLBysfMIjRe8wVw2rgfk8cCMlV3
	SJWmgMq6Vtw==
X-Received: from dlbov5.prod.google.com ([2002:a05:7022:1185:b0:13d:1fe2:b775])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b89:b0:38e:67e1:15b
 with SMTP id 98e67ed59e1d1-395deeae6e3mr27928401a91.6.1787553473990; Sun, 23
 Aug 2026 23:37:53 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:37 -0700
In-Reply-To: <20260813132519.4099508-1-andi@firstfloor.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-1-irogers@google.com>
Subject: [PATCH v1 0/7] perf ui: Implement hybrid event merging for
 heterogeneous systems
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This series implements hybrid event merging internally inside the perf TUI 
and explicitly configures support for --hybrid-merge for both `perf top` 
and `perf report`. Introduce a `--hybrid-merge` command line flag (with a 
dynamic `'M'` hotkey mapped natively inside the `hists` browser) that 
collapses hybrid events visually together natively during histogram 
generation and sorts by the total. Add columns for each event.

Ian Rogers (7):
  perf evlist: Implement evlist__can_merge_hybrid using
    first_wildcard_match
  perf ui hist: Add support for aggregated total_period and merging
    entries cleanly
  perf ui browsers: Implement interactive 'M' keystroke to toggle hybrid
    event merging
  perf tools: Expose opt-in --hybrid-merge
  perf Documentation: Add tip for hybrid event merging
  perf ui hist: Format group headers iteratively based on proportional
    visual allocations
  perf test: Expand top tests for --hybrid-merge

 tools/perf/Documentation/perf-report.txt |   5 +
 tools/perf/Documentation/perf-top.txt    |   5 +
 tools/perf/Documentation/tips.txt        |   1 +
 tools/perf/builtin-report.c              |   6 +
 tools/perf/builtin-top.c                 |   9 +-
 tools/perf/tests/shell/top.sh            |  65 +++++--
 tools/perf/ui/browsers/hists.c           |  48 +++++-
 tools/perf/ui/hist.c                     | 135 +++++++++++++--
 tools/perf/util/evlist.c                 | 209 +++++++++++++++++++++++
 tools/perf/util/evlist.h                 |   2 +
 tools/perf/util/evsel.c                  |  14 ++
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/hist.h                   |  14 +-
 tools/perf/util/symbol.c                 |   1 +
 tools/perf/util/symbol_conf.h            |   1 +
 15 files changed, 482 insertions(+), 35 deletions(-)

-- 
2.55.0.766.g2966f0265a-goog
