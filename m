Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6334217F3B
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945086; cv=none; b=aqdBw3ofpBdtmh9fax+wlbMknOENAOG5JgNkQUagG0BmURPJzkIPSJyEgyJd3xsckkOGiduIaB+q5Bw2EBOmNUZQypO2C6lM1t50aciXOpMPD6ulMLNiyuQZvTylkoJgNVVkdnasTb2kbP/lvKH7HzDl3ZEz5a/P2uakWl3i+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945086; c=relaxed/simple;
	bh=f+Yk5CtSNdB/1Lmu/zKBb9xb884EAaFAdkWSJ9+l47A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Psf2ckEbMXqJOeX8cJN6VAebko5SS5KfO07VHavdDPsEmZyB8t016Ba/e7L/2p6rI4U7jVIXaQvdsrxOFg1kAWzEqsDvMvZ1LJiDCguyDFP2FGsWIaRPlL8mcWKzueHmsEeokhRTicyuCUkWh8NptG82EXpZ1YBkJgKF2xOLLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Deg58Wpx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Deg58Wpx"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fc60660dso4833475276.0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729945084; x=1730549884; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBcJl01TtjB1sQ+coZ3yEQeNcjr8kffC1BqiKyM+Ja4=;
        b=Deg58WpxuUdeldjva0WZ2Qi6mnOYfCjCqMrOeEpyh4hGln4wyn2LlpVI0xVdGVaHw0
         HoKTCa0oORN1xR0yB890uag0h7AKpP5q+BUCuJ7SQkT9tAlGbeG56QDvkoNM6tpaK+dx
         mye8VYen+7tyQ/s61zeTIYrcfDVGt8oto+/l4W5Wf+QaQDBvAJ5DjDWUe14rmY9AeXSW
         hGM+ILPhaxBZVFWu3sci7epCegS0ff6JnpbKxu4IpxpL5IxP7rsM21TP7D4K5c11MJ+R
         onUCyzRLlNxQbKKmmBLCT2nnUa3inTLSSV0slXgMGJamqO1Qcv1VVIhSaDtK2Xm00+X/
         ojww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945084; x=1730549884;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBcJl01TtjB1sQ+coZ3yEQeNcjr8kffC1BqiKyM+Ja4=;
        b=DGIXFeOuzL9az46hYwX4p+/ILFgLriUzOitWbbKuX6acYAhsZNkb9JNJ3nA6aiaGEq
         42lwNgbothF19rRPcQ5eN/qKNKCfI+QML3yoAu8l29ybRxfjLUkdlWz70Zix21iqE8KP
         JpF6ix0jSCE4xWON89TxfcG/7AHcrlD7nu4lFS+FT84F1znY44xiepCqUms8efK1rKzc
         DJzZ7+UocMG4NuLAy4GIpzwm4C9m3jbAZWL14tDwgQmm2zowwIWnta+7cO25cOXlVBgF
         6YB+3HOFv+Ked6lsrMgZyHDVbPrA8+Di9AkU1TQzLXCPLeZpgCgfwm6yO3Q35r5lfc3l
         1oDA==
X-Forwarded-Encrypted: i=1; AJvYcCUWNO2YBL6OZSiXCAhtDeFcAhDuUuoWRFhTH8bBEpAcHNHWsOOTTmxzRP60k1JSZyf5fb6bNkKvvC30LcKXNXZq@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZigQyzDUoCfQBjdV1kUs8qk9X7qcU6OVMbVbT5jzy9UEZLl2
	76XydI7qnqxHA77b74FyRhhHyB7/mWiUCiG5d7zfOvwLyUpLIQC7SHgWGgPv93iFFBOfwO6JaNJ
	AnYCL1w==
X-Google-Smtp-Source: AGHT+IE9zYMgTwSHLGYlj300YfFrmvke8frEqe5oUqwbyU39/+jljEJ0ran0v7PIwH2GumKW+rj4eS6UlTFR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a25:a207:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e3087b792abmr5358276.5.1729945083545; Sat, 26 Oct 2024 05:18:03
 -0700 (PDT)
Date: Sat, 26 Oct 2024 05:17:54 -0700
Message-Id: <20241026121758.143259-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
To: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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

Two minor changes have been added to help with the error message and
to work around issues occurring with "perf stat metrics (shadow stat)
test".

The patches have only been tested on my x86 non-hybrid laptop.

Ian Rogers (4):
  perf evsel: Add pmu_name helper
  perf stat: Fix find_stat for mixed legacy/non-legacy events
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 22 +++++++---
 tools/perf/util/evsel.c        | 10 +++++
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 tools/perf/util/pmus.c         | 20 +++++++--
 tools/perf/util/stat-shadow.c  |  3 +-
 8 files changed, 145 insertions(+), 73 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog

