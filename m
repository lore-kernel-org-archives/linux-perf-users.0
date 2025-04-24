Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2D184F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475590; cv=none; b=M5Q9VT94FUwFgvC6qRKx9xdl6mPE+TZ3sQodvFHcAEVUi4O2ucpCZXMoRAY/OlaPLvF/N9yWQPX737R8hltR7HEtDET12IxhI4/NpgoQgU7Zal8a0ABKOtQxwjB5VPaPDmDROxq0Xz1di8j1V+QNPfb3MD4j1KV20N8Fu+iMoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475590; c=relaxed/simple;
	bh=uKM6b8hRCbdGIXJ+G3E7aphwQX16oUYjbw/riWxMSl8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=WlXCp1hvmKEZ+fqjb70CJM5cPuN1qlXoylf5uO4Oie/nXVJuBShrCrX5VOJDDgU9dAPHTzPDYPQa7G57oS1ASLTD3J0juIDzOH9c+tXP9GDCBS+Rne8UA6FgZ/gebLa/iS06PLDlMr4Jm7E2myJ+N0MQhJpLotCkcO81VPNz33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD6NvCFE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD6NvCFE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72f3b4c0305so697146b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 23:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745475588; x=1746080388; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9S8SNMhpasxMLVFHseAVldD3PxPQ7S0bH+GLSZ6X/b4=;
        b=lD6NvCFEtURvKPah3GVfAoqBAchxjDw1ksHT9C2soO2SX8dYyClH7w5ZT9T2OaUIpa
         mYkEgWFPWy6MTqG2r1W3ZcqvCq2CrZCFLPHuCnDzlrXuWHelSyKN1xAUsjT0Nh/zhA7d
         TOFbI7YRKizab9XobH1hj0V8mgwlGWYTgK34aYjLcvtyaoRPWkGea6zBXo6KERcUpIIt
         OSjlKpKaUfoBYxpRgaee0OEnmICSbWh0fu3jK2yc2Txl9hR/Bt/A35Zoe4BYqGwIZZE2
         yhoIOVnREw4qStrmZcVN1SeBuRRK5P4z5BHnyvEcrUKXipzyHhtud88/dWZHmBISkJm/
         1Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475588; x=1746080388;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9S8SNMhpasxMLVFHseAVldD3PxPQ7S0bH+GLSZ6X/b4=;
        b=htYFT7LhegARONrM//hxbaITDPN2EtsmzZe0TK5ai4O/KvnaBth/Ra70ZYHqD5PANH
         ElxtdNGT+KxnUlP8iSBetucNmsNUYM5nKvGXfDQRQgckyd+VUanY0OFyec2goHZpwPIt
         EV1OQkI9zzEG6nygSZYhMNQ1qF/slXLlQpd8Tr6ufr4cnFgII6KmF/QPvozXIBQSga9T
         zKjjwAc9CsVAL40l9pKiPJjq/80TgN9HkcReoaWUxMleGkNZaPd7XVs1RXkeoeK3m7V0
         u2tXdr1pHuTHo2c2aiHowCK6kIhZSNBPyo2hTlpMX1fVse6Js0C07EgVneZuUFF4YM6F
         H+3A==
X-Forwarded-Encrypted: i=1; AJvYcCWCoEKwcnXiiuHbfryc9k2EQ2lsiWejc2cTOTYYIaaAuShiqFly+LqW3BP0fYsVt0oMSK+wD2zFoZatI/lfJMCi@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuhHEOKkJbGnhd3Of2G7by/M2vkyebge9y1G2G3MI8m8t22Dp
	YAqqwEvLxQpi9bBbLHSS/lOleYeTorYK5cUORoQk08+UqioMwAlQu9MKrI7SdEX5s53f6bR+RU8
	anpmLgw==
X-Google-Smtp-Source: AGHT+IFWUAHIIuHEw9jie99vFA3LR2NLYFGOPTprvrz3yVe0D0uOAGvA3gDCPdLxh3JhDAlAja5k/UG5TkOu
X-Received: from pgbdl2.prod.google.com ([2002:a05:6a02:d02:b0:b0e:c90f:8078])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a41:b0:1f5:7873:3052
 with SMTP id adf61e73a8af0-20444e9b546mr1684984637.11.1745475588199; Wed, 23
 Apr 2025 23:19:48 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:19:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424061943.1321025-1-irogers@google.com>
Subject: [PATCH v1 0/5] perf: Default use of build IDs and improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Build ID mmap2 events have been available since Linux v5.12 and avoid
post-processing the perf.data file to inject build IDs for DSOs
referenced by samples. Enable these by default as discussed in:
https://lore.kernel.org/linux-perf-users/CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com/

The dso_id is used to indentify a DSO that may change by being
overwritten. The inode generation isn't present in /proc/pid/maps and
so was already only optionally filled in. With build ID mmap events
the other major, minor and inode varialbes aren't filled in. Change
the dso_id implementation to make optional values explicit, rather
than injecting a dso_id we want to improve it during find operations,
add the buildid to the dso_id for sorting and so that matching fails
when build IDs vary between DSOs.

Other minor bits of build_id clean up.

Ian Rogers (5):
  perf build-id: Reduce size of "size" variable
  perf build-id: Truncate to avoid overflowing the build_id data
  perf build-id: Change sprintf functions to snprintf
  perf dso: Move build_id to dso_id
  perf record: Make --buildid-mmap the default

 tools/perf/builtin-buildid-cache.c            |  12 +-
 tools/perf/builtin-buildid-list.c             |   6 +-
 tools/perf/builtin-inject.c                   |  32 ++---
 tools/perf/builtin-record.c                   |  35 ++++--
 tools/perf/builtin-report.c                   |  11 +-
 tools/perf/include/perf/perf_dlfilter.h       |   2 +-
 tools/perf/tests/symbols.c                    |   4 +-
 tools/perf/util/build-id.c                    |  40 +++----
 tools/perf/util/build-id.h                    |   8 +-
 tools/perf/util/disasm.c                      |   2 +-
 tools/perf/util/dso.c                         | 111 ++++++++++--------
 tools/perf/util/dso.h                         |  75 ++++++------
 tools/perf/util/dsos.c                        |  20 ++--
 tools/perf/util/event.c                       |   2 +-
 tools/perf/util/header.c                      |   2 +-
 tools/perf/util/machine.c                     |  28 ++---
 tools/perf/util/map.c                         |  15 ++-
 tools/perf/util/map.h                         |   5 +-
 tools/perf/util/probe-file.c                  |   4 +-
 .../scripting-engines/trace-event-python.c    |   7 +-
 tools/perf/util/sort.c                        |  27 +++--
 tools/perf/util/symbol.c                      |   2 +-
 tools/perf/util/symbol_conf.h                 |   2 +-
 tools/perf/util/synthetic-events.c            |  42 ++++---
 24 files changed, 271 insertions(+), 223 deletions(-)

-- 
2.49.0.805.g082f7c87e0-goog

