Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7C1CF95
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Feb 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345428; cv=none; b=UTNbzeFWyoEf/U1/J/MeX1y0jUlOuCDSkz+4o/kfc873dQPwe87XCusMowy4ylS0oryruHxHleg5Fk6ElcZZD0aRscUrv2c2gqBdrQAfT34ikQOxKNpHLqcgE0sWHDcc6zDp6vDUrRM6f7MmTwrAlXyMD9TX/aJ1gud79Z/nShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345428; c=relaxed/simple;
	bh=uX8pdD7kgNmp3FcaYgB4JuQsO65wbuBOo0Jq84KiksI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=T8XZZpKi04IakyOIYCJgw9YBwdTBu4CcosvX3ao3gDrQdGbr5LGVwHId+uurBVn/mSR4a4WdGhf8lxQDCnaZVAyb2ilq8YzAwMfgIn6zc+2mPwiMMrgfrHnUMu+aNGKhGKkeUJjObT5pguJ2fZfXR4flwOyvDTCketpq2Y/0o1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBn7k4/S; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBn7k4/S"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso467947276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Feb 2024 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707345426; x=1707950226; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=se0rekKJl3bXKyYQ+330Vid9nql6VhcMY37MwG9XWnU=;
        b=lBn7k4/SEp7ZBAmR3gDoW01C2TIZzAWDqphEzjkDIw55Y4obQmHgzk6lwZMLhw+Eif
         Idz1CCUHX4lOqQznj+on+sbC5A1jyH7xvMIaTSuq8XuYk6htHv8RQsvdkH8njN/9rGdg
         ojQd6WY9S+Zq/GGTBKPbyfMsnALas0BRhZwFQjHUQ849OQiDLlxR9dcEWcNXK73o9Pax
         5zjjmr0rSfuzXHZqP/WHO08LRZSi+KnvaEaA4i27jp4CdyeU9bELYkMZMmcsrpyuaAg1
         ga06nAA/+FalYmG0LpS/TnyxoE7LiiHlhRyseP4mQo/5B3kpSuhfTdr8Khm2FdzlzK3z
         UsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707345426; x=1707950226;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se0rekKJl3bXKyYQ+330Vid9nql6VhcMY37MwG9XWnU=;
        b=jo6tD871A5hiHRFBn2MXAFBz0GTrnj6CC0qcRtuzxt0WNLW/w4E6tioQRdZKO80A16
         6koHhB4buKEfVYo5ZvWtyuVEr4sRoNERocxxcJL073Uvh6H6gREUADIvCk2mEwfyGfyT
         XHojpt0IIXmvavjGKeWKF4vHJZMXeBGn1bCP4Gtj1SW48h4r/AT9/ayNf1KDaNsEDyyh
         Skz9SwwFAXNOXsupBuQNqG7XEril8pGI2GpYjYn/DrszXtab8iIXWD/yyUWw02dNSXCC
         uDYh+oCMwYrpq2zY6lxNOdnCPGNUpY29APaTuZeBORHcg0zS1Sssglyvig5aTVbk5kl1
         dpow==
X-Forwarded-Encrypted: i=1; AJvYcCXcvuONZNAnKSsn8bHxuyFVz5TYZOQO6kSDJBb9lrXPfaIvYfJCddEc26+dEiGUO/9Pskjgo9pJXS47HHPoAOHqm8szAtLsG5wrSmQSetAorg==
X-Gm-Message-State: AOJu0YyU3mp6VTZHR8vhrg9n3JnHFQL76LC5+AafUzBsliCUSIsnGdbU
	tZpxhMpdg6HbO1TmJsVmOqYqsbMUNnwdW4LsNcMs0fHghpmnbpXtUMB8mzuqO/taVwvyAnMU66t
	/LzXlGw==
X-Google-Smtp-Source: AGHT+IGWEV5E5tASumWBsL1U/hheOnbEMBRqmuhd+pBwBg2dxoYWoirfO+n7XQa/OMufOcX1lVec/Wv8Gsr1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b420:757c:5706:d53b])
 (user=irogers job=sendgmr) by 2002:a05:6902:150b:b0:dbd:b4e8:1565 with SMTP
 id q11-20020a056902150b00b00dbdb4e81565mr214522ybu.4.1707345425771; Wed, 07
 Feb 2024 14:37:05 -0800 (PST)
Date: Wed,  7 Feb 2024 14:36:33 -0800
Message-Id: <20240207223639.3139601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 0/6] maps memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

First 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/

v2. Fix NO_LIBUNWIND=1 build issue.

Ian Rogers (6):
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps

 tools/perf/arch/x86/tests/dwarf-unwind.c |    1 +
 tools/perf/tests/maps.c                  |    3 +
 tools/perf/tests/thread-maps-share.c     |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c      |   10 +-
 tools/perf/util/bpf-event.c              |    1 +
 tools/perf/util/callchain.c              |    2 +-
 tools/perf/util/event.c                  |    4 +-
 tools/perf/util/machine.c                |   34 +-
 tools/perf/util/map.c                    |    1 +
 tools/perf/util/maps.c                   | 1296 ++++++++++++++--------
 tools/perf/util/maps.h                   |   65 +-
 tools/perf/util/probe-event.c            |    1 +
 tools/perf/util/symbol-elf.c             |    4 +-
 tools/perf/util/symbol.c                 |   31 +-
 tools/perf/util/thread.c                 |    2 +-
 tools/perf/util/unwind-libdw.c           |    2 +-
 tools/perf/util/unwind-libunwind-local.c |    2 +-
 tools/perf/util/unwind-libunwind.c       |    7 +-
 18 files changed, 900 insertions(+), 574 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog

