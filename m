Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696E15B971
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636525; cv=none; b=Dkwakg+X+mQ/7e4TJb2lmrsF4xWRN8J+4pBqMO5834PPayUNubLWCPARgzMK/GujdqW7CB/TXqHGucoFdC58Zvs6cOQYbe5soqr40tkXy+G+Tryoadbz+0OlQ5Ejso64u9bulJJAZChR40jnlrjiD2uK4IUX4qz6Z16g3WxeGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636525; c=relaxed/simple;
	bh=2G5+QIi39QvRpz+Uxbs2p5hm+8aY7ikDDaUf8vmT/q8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=BLsK6172/BzgK5JcsMiY4BD/IvvvqHNBJby65SXWZvqLbKtsjXZgvyikn210ZsNPppz74gOXK2WFYooYg28qUu5o729pl5iCj8ZsB8kWiF4OPIEAjfCnr+/Ooe2JUpiFNAG4CH1Rcs34+cSF/nCWEWioaM7nBSCnSGGll09GSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmBv7bXO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmBv7bXO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223477ba158so122844755ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741636523; x=1742241323; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPtTVgbo1Gc22cvvBNU7TODq9XtOwM1eBGa+Md6htLk=;
        b=WmBv7bXOJjkaulsuIWb4CFijIu2iCbHdxF9txj3+XCXlmahB6Nonu5+VoxHlgyYpq+
         jvNjiOA69Wf64f9sAPk2G5feHhp708seBmSwZDsK8+Gz2izQUUeC5ZND5Kyq8FSFFoWU
         0PCmA0Zj+LMYGavc39kpFUBi49cXBUpZWprL31X3Hou9y+elK29wsK9VYLLp5QStdv+D
         6dUPimHXmXfoG71l/gUyk7juEvRO1K9R4htOUGZdLTzcb4zgIsL6J+vULf3oJf/ktbYB
         AQ+XsBeUabqTeNpRz800/rU92ufWhqumi60rjO1MMfMJ/JbDO7rMtz2I6wxrnMKsQVCY
         //1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636523; x=1742241323;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPtTVgbo1Gc22cvvBNU7TODq9XtOwM1eBGa+Md6htLk=;
        b=Uujjh/QjzqKdcy/SDQSKWcKUTVvueqJAngLTJ/ZPUK4u99ZykRAsZXtNOicFKv5hUB
         x+9hZS+/q8JUWRolBFdixS4423xwJanF3fYLPTGCuqbcb40Jus6fNwkfaa9BuPlZKOYQ
         aoBAxVWsqWHTmJ1pt/9DS7dsoD9i313pw3w3lRogY/p9jEg/m1VUzxlcKwrIKKIcQCr7
         nev0qnEx+ypDHZO0CYc/CrQUdpkws6iYpmHtzXoJEto+kCUVB6leDWa0otjk3ygFYfEP
         BrB57CHPwLMociUSRv/B8QjGM+6ERXoVlfCf7scs+QGAz7c8vNyvw/Pygg9S9mu6lmSs
         jVJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgFLCVFYhiI7wa4SNAVXYENYRpMAoir0+izSmNL1viULeaygArpvoHw6FUOXtTZtm65AolBD5JO4RmJ3ScVqlm@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQXwdannJynFVDCDgf4585SkH/I3RYlt9qkOxWVB7oB9b7sYU
	89c2Pu32fRY6spOTpVgOmbeDTcQwNBP2VrtFeo/8GorxtyR0dznQjV4u2skvw88e53yF7jW0tbW
	GyT42yA==
X-Google-Smtp-Source: AGHT+IEJmSQJflyxaKBwX1PYSk5UMMFRR580oxmfwEtt0gz7FirWb1HSugRKiUxFzQFc5A8V/VvGjc2oIPkN
X-Received: from plbkf4.prod.google.com ([2002:a17:903:5c4:b0:223:3f96:a293])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b63:b0:220:e5be:29c8
 with SMTP id d9443c01a7336-22428bdee3cmr252515855ad.32.1741636523539; Mon, 10
 Mar 2025 12:55:23 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:55:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310195518.2012571-1-irogers@google.com>
Subject: [PATCH v1 0/2] Consistently prioritize legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Legacy events were historically the priority over sysfs/json
events. This behavior was changed in commit a24d9d9dc096 ("perf
parse-events: Make legacy events lower priority than sysfs/JSON") to
fix issues on ARM Apple-M CPUs. Sysfs/json being the priority makes
most sense, was preferred by RISC-V and gives abilities impossible
with legacy events. Making this encoding consistent is proving
impossible with endless bike shedding, people saying they see
something as a fix then when that fix is provided continuing to
object, etc. Given that in the RFC [1] legacy events are seen as being
preferrable let's just follow up on that and make their use
consistent.

If it isn't clear, I think this is the wrong decision and landing [2]
should be the priority. When I try to have this conversation it just
gets ignored and I want consistency more than my preferred
prioritization.

[1] https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
[2] https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/

Ian Rogers (2):
  perf parse-events: Make legacy events always have priority over
    sysfs/json
  Revert "perf evsel: Add alternate_hw_config and use in evsel__match"

 tools/perf/builtin-diff.c       |  6 +--
 tools/perf/tests/parse-events.c | 13 ++----
 tools/perf/util/evsel.c         | 21 ---------
 tools/perf/util/evsel.h         | 19 +++++++-
 tools/perf/util/parse-events.c  | 81 ++++++++++++---------------------
 tools/perf/util/parse-events.h  |  8 +---
 tools/perf/util/parse-events.y  |  2 +-
 tools/perf/util/pmu.c           |  6 +--
 tools/perf/util/pmu.h           |  2 +-
 9 files changed, 57 insertions(+), 101 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog

