Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434B1F3B82
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634061; cv=none; b=ViGc3M7w3bQJWXxRdwnDy20Bl5dv/n8P4qpEsY3pOz1Ddlc5A69n+yJqpZfcRAWp1U/v10ReLNGfiir3AUBq9u68GQT9QakhnyqHsWjO33EclEOTw4cqbTGwTOXTdsc7hYTUKGOO4LIjtamAwcKqGjZuqv4wFAPSN7774xEKDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634061; c=relaxed/simple;
	bh=Ru4BtfRe0+B+AhvIy0A0rpVg8flFQ1mMl/i+zMrdb/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YSqRuHEE2vmIorfQKfUbDWxChT/isbjki/qPo/5RyZfcdosbo70bNzAlxqxZ/3jjm6z9Ypi4gg01VmrGjn0DEixVXD8DAu7KR2exxz3edhwcylG8Sxc6EaZYQ1GsaAjZDzOlvw6NLrRrmt6Xd3bH28KQC45BUEVBqUuO0KeAxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WT2SO4lc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WT2SO4lc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22403329f9eso2500985ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743634059; x=1744238859; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0XfgBiQEup7soca2GQu1jS4gphlsvFj7U02mWvvqnM=;
        b=WT2SO4lcHB6k+VZwe6iVDjeOWSodvqU11puDNM0ZrFDQLQnsBSOQkE0vcya/ndsRd2
         l7C0rY8DYaQnmwCS5faQ8t2iayqkJ0ZsmoNwBJKKsvecFX50yyISdgJfIKja5932CuHc
         B+s03DDiFv73AFvU3X1p92m50uHez0jnpwTgetJTS/bANI8/8EGlVTR3wNss8X5PB8EH
         2A2uFI/HVp6BzLxHahWp3RFL8Obk/XZs+Bngx95EiTNIVEnrhUcvc0xDCqlL9T7xUFXd
         UuilacOebv/jn99Od9QFbO9aQG4mJsEG0LgY6nf9PEw6suuXU7xhTTEzcXuVaMj5M9eh
         +i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743634059; x=1744238859;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0XfgBiQEup7soca2GQu1jS4gphlsvFj7U02mWvvqnM=;
        b=Q4hooOt+tZkvu6082De7xIKs6bpaP0+dA/NL0YJ0ERC7k02N3U+I0feMMNSEPxd+33
         aXVUjEY55OjucZfaFn/a+z7WxvwgmENwktlkTIMiKGQAzNRHmx8ts+v2VoZk001Y1MRo
         M/813uCQ1uKEXd5KOlqzLIbATvJUt7+3aIzZMb6lvKz6tWuglmc0DKYzSIcfzRqYnu+n
         bSDxk185IhTbBY0hHp5mEk7dO57H2bMXk9hs7T0KB/w2SB1NBWat4Avv3aCQ9ntKdJ5P
         3lIQYn8pfkupVhMmAeCi7nMClH2FOZUs85gF2cxSehpkrvBpBtXKhdwgovcZBr3WIXGn
         3FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsmnUYi9ZqTyZKI0/S/snFjoUWngW/2cu6Q7g9eV/+2rytQLEIOp7FSg7WDJmKB5mT8g9HsZHYvY5p9R1S6WhY@vger.kernel.org
X-Gm-Message-State: AOJu0Yybh57DZSGfBboDWERgTzUwlxWGJdXFpK+GQTOAvAejDfyG68Sj
	PRpZzMce9SKl6YCKVK+oruzRiZ6W0nLAirFy+jJTPaHiXsH74vXvcse3/q6mJP4rtDTBgXlnuy+
	ZwBiVNA==
X-Google-Smtp-Source: AGHT+IF0Vjt6VVHETz8kshE5LncADXihIg29Va9KdRuVYgUjgV6CB7EP15IrICdtzLpP1VDf5PAxLTAA4v5y
X-Received: from plpm12.prod.google.com ([2002:a17:903:3dec:b0:220:dc21:7a39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c7:b0:224:1ec0:8a16
 with SMTP id d9443c01a7336-2292f9622b5mr265565235ad.21.1743634059263; Wed, 02
 Apr 2025 15:47:39 -0700 (PDT)
Date: Wed,  2 Apr 2025 15:47:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402224722.88740-1-irogers@google.com>
Subject: [PATCH v7 0/2] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

At the RISC-V summit the topic of avoiding event data being in the
RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
events being the priority when no PMU is provided so that legacy
events maybe supported via json. Originally Mark Rutland also
expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
M? processors, but James Clark more recently tested this and believes
the driver issues there may not have existed or have been resolved. In
any case, it is inconsistent that with a PMU event names avoid legacy
encodings, but when wildcarding PMUs (ie without a PMU with the event
name) the legacy encodings have priority.

The situation is further inconsistent as legacy events are case
sensitive, so on Intel that provides a sysfs instructions event, the
instructions event without a PMU and lowercase is legacy while with
uppercase letters it matches with sysfs which is case insensitive. Are
there legacy events with upper case letters? Yes there are, the cache
ones mix case freely:

L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node

meaning LLC that means L2 (which is wrong) both match as part of a
legacy cache name but llc and l2 would only match sysfs/json
events. The whole thing just points at the ridiculous nature of legacy
events and why we'd want them to be preffered I don't know. Why should
case of a letter or having a PMU prefix impact the encoding in the
perf_event_attr?

The patch doing this work was reverted in a v6.10 release candidate
as, even though the patch was posted for weeks and had been on
linux-next for weeks without issue, Linus was in the habit of using
explicit legacy events with unsupported precision options on his
Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
where ARM decided to call the events bus_cycles and cycles, the latter
being also a legacy event name. ARM haven't renamed the cycles event
to a more consistent cpu_cycles and avoided the problem. With these
changes the problematic event will now be skipped, a large warning
produced, and perf record will continue for the other PMU events. This
solution was proposed by Arnaldo.

v7: Expand cover letter, fix a missed core_ok check in the v6
    rebase. Note, as with v6 there is an alternate series that
    prioritizes legacy events but that is silly and I'd prefer we
    didn't do it.

v6: Rebase of v5 (dropping already merged patches):
    https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.com/
    that unusually had an RFC posted for it:
    https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
    Note, this patch conflicts/contradicts:
    https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
    that I posted so that we could either consistently prioritize
    sysfs/json (these patches) or legacy events (the other
    patches). That lack of event printing and encoding inconsistency
    is most prominent in the encoding of events like "instructions"
    which on hybrid are reported as "cpu_core/instructions/" but
    "instructions" before these patches gets a legacy encoding while
    "cpu_core/instructions/" gets a sysfs/json encoding. These patches
    make "instructions" always get a sysfs/json encoding while the
    alternate patches make it always get a legacy encoding.

v5: Follow Namhyung's suggestion and ignore the case where command
    line dummy events fail to open alongside other events that all
    fail to open. Note, the Tested-by tags are left on the series as
    v4 and v5 were changing an error case that doesn't occur in
    testing but was manually tested by myself.

v4: Rework the no events opening change from v3 to make it handle
    multiple dummy events. Sadly an evlist isn't empty if it just
    contains dummy events as the dummy event may be used with "perf
    record -e dummy .." as a way to determine whether permission
    issues exist. Other software events like cpu-clock would suffice
    for this, but the using dummy genie has left the bottle.

    Another problem is that we appear to have an excessive number of
    dummy events added, for example, we can likely avoid a dummy event
    and add sideband data to the original event. For auxtrace more
    dummy events may be opened too. Anyway, this has led to the
    approach taken in patch 3 where the number of dummy parsed events
    is computed. If the number of removed/failing-to-open non-dummy
    events matches the number of non-dummy events then we want to
    fail, but only if there are no parsed dummy events or if there was
    one then it must have opened. The math here is hard to read, but
    passes my manual testing.

v3: Make no events opening for perf record a failure as suggested by
    James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
    rebase.

v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (2):
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 47 ++++++++++++++++++---
 tools/perf/util/parse-events.c | 27 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 4 files changed, 140 insertions(+), 70 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog

