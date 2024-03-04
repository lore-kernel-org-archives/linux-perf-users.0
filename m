Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF177869C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Mar 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577342; cv=none; b=ee8LlArMYHzSkrB+8cIQ0/Zjnp5dMlpnz1a6dm/XD4iYHovvi7UogScLJ0IW5aZHvK5f+01J11GHBCNhQot22u/j67FRsV0IrZAOO9T44hMj8nxHFlq4qmVVaYXx1DlHyWkXD7Jyiruu0T7dR/HwwfAKlmdG5HjlsQujTvsg57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577342; c=relaxed/simple;
	bh=S4+82v7NCUmx8L1BcqndfWBKShMGurzfWQfIbtHPqWc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gRl5uaLGB66w0LabLiumWMFi9D/IijAOd8Q8FXN5slADuQxsUdH3VMP+nNlFyqdxDkvhjng12gCNZnYbuPBPBiGqAdGSJmzklQVUft9glQ5sL8v19kEM7CIxVW0EXvt+fftAQc0Q+UwoC0SD4b4QN+IUDYICpXok3UfbhB09niI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpOZWbLk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpOZWbLk"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60987370f06so35233717b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Mar 2024 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577340; x=1710182140; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+rWtSs3jdL0xhYMk5BJV6yhidzq0eLnQijD18nf6WGU=;
        b=OpOZWbLkl/QoNFQn6jSkkCFQECqPRzVJ0NKlpNUXndOHyvhPsEJ/p/wFRUv6zXUBPm
         lxCywgZYlSJjK/XOOh25gJmS3tBM6pNxWen9avlcWvcHbhUXSEh3bmg9tt+TJ/k5KtmB
         P9mmc86ya3tH757ucT8kg8aiZStiCsBXx4Hcy+D28tvjrvdvFiDEWsgYesvusM9SNsC/
         PK0PTDGIyScnLx+idwttoeG5EAUMJ6E0eAp6ajD+FWdsHxs+3ifKCEJwQxLpcV4qCSHY
         CUd05qENdc9k189x0zXUdNOmvk5B6AhaQhYiPkqQmimPIcSq7FRqBQygBVl/9PYHI3ol
         MlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577340; x=1710182140;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rWtSs3jdL0xhYMk5BJV6yhidzq0eLnQijD18nf6WGU=;
        b=dON13kYEw5W+9gPK+bojBZipy9AzwWosgttpH5AugkAwH2v3CrKJ8pAVJxm4ilnxF2
         7wwKP5L0QGjjYSNBw9C2MIRsZIhskiqTv8lQk2OJu7RSutEDC9POKWGJWRT8lPigP1XF
         DhM5VDh9Kcx7jGCO52jTF0Z6kot1WD6N0ebvYHDw13ZQy/rdvcCncVFK0FGJO82/UvsM
         1bhZAXPZqV4VJPKzac/29ZqtPGhsrMpWv9EmD9YGDLsq4NK2a0VDxwH6Sg7DnDYAi554
         u74eJyj+ILb8XWmskdqO9xquVbwtaqF4SCzqs5mNGMlVg93prF4XSamHOnKIyF/lOsD9
         zRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+jGMfGrKBc+Xu/+xTO82RdgglDbRTbI/GNkBZmNAbAwQ08cE78RXS6OalUmflL5zPfCgRVx9ugtzRtmH6KRuCMEECzOqgSuZvPV1tZIOZUw==
X-Gm-Message-State: AOJu0Yzgsy4z+2y4RrLd1ivxxxHY6C2jmWv4H1bmxU+rovVtcx0kQ77l
	Wkptrp05R7dG9kF6qGA/7XHtJmR9A+x/fUQMz+V4+hN9qY/l51id3NsyP1QWaxr3P6cX1QJWyGR
	AGFaZPQ==
X-Google-Smtp-Source: AGHT+IEslYK1dnDUg1cvmhd/6YrW3WS69cu518MAmARCTu8evukYXj05PTb1nBGKV/fsRDQ2hZp9MocbD/SJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:690c:886:b0:609:343e:db43 with SMTP id
 cd6-20020a05690c088600b00609343edb43mr2078524ywb.5.1709577340166; Mon, 04 Mar
 2024 10:35:40 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:11 -0800
Message-Id: <20240304183525.3222581-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/13] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

13 more patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
a near half year old adventure in trying to lower perf's dynamic
memory use. Bits like the memory overhead of opendir are on the
sidelines for now, too much fighting over how
distributions/C-libraries present getdents. These changes are more
good old fashioned replace an rb-tree with a sorted array and add
reference count tracking.

The changes migrate dsos code, the collection of dso structs, more
into the dsos.c/dsos.h files. As with maps and threads, this is done
so the internals can be changed - replacing a linked list (for fast
iteration) and an rb-tree (for fast finds) with a lazily sorted
array. The complexity of operations remain roughly the same, although
iterating an array is likely faster than iterating a linked list, the
memory usage is at least reduce by half.

As fixing the memory usage necessitates changing operations like find,
modify these operations so that they increment the reference count to
avoid races like a find in dsos and a remove. Similarly tighten up
lock usage so that operations working on dsos state hold the
appropriate lock.

Here are some questions (with answers) that I am expecting from reviewers:

 - Why not refactor dso with accessors first and then do the other things?

My ambition with this change was to lower memory overhead not to
particularly clean up and fix dso. Fixing the memory overhead, by
refactoring and changing the internals, showed that locking discipline
and reference counting discipline was lacking. The later changes try
to fix these as a service to the community while I am changing the
code and to also ensure that code is correct (more correct than it was
wrt locking and reference counting than before the patches).

Reordering the patches to do the refactoring first will be a giant
pain. It will merge conflict with every other patch in the series and
is basically a request to reimplement everything from square 1. The
only thing I'd have in my favor would be how the code should look at
the end of the series, and reordering patches doesn't change the
eventual outcome of applying the patches. Note also, were I to send
the memory saving patches and then a week later send the API clean up
and reference counting fix patches the patches would be merged in the
order they are here. I've done my best, I know you may consider that
I'm adding to your reviewing overhead but I've also got to think about
the overhead to me.

 - Please break apart this change...

The first changes are moving things, but when a broken API is spotted
like the missing get on dsos__find I put it in a change to move the
function and to add the missed get. Could this be two changes? Yes, it
could. Does moving code materially change the behavior of the tool?
No. I've done it in one patch to minimize churn and to some extent for
my sanity. Such changes are less than 100 lines of code and all
independently tested.

 - The logic in dso around short, long name and id with sorting is weird

Yes, I've tried to make it less weird while retaining the existing
behavior. It would be easy to make a series of patches just cleaning
it up but I came here to save memory not change the dso API.

 - Move the fixes in the 12th patch earlier.

This is possible but then impossible to test with reference count
checking. This does mean there are broken reference counts before the
patch is applied, but this is generally already the case. Yes, some
hypothetical person may decide to fork midway through this patch
series and my order would mean they wouldn't have a fix. I've done my
best while working within the bounds of my time and trying to avoid
churn.

Ian Rogers (13):
  perf dso: Reorder variables to save space in struct dso
  perf dsos: Attempt to better abstract dsos internals
  perf dsos: Tidy reference counting and locking
  perf dsos: Add dsos__for_each_dso
  perf dso: Move dso functions out of dsos
  perf dsos: Switch more loops to dsos__for_each_dso
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/builtin-annotate.c                 |   8 +-
 tools/perf/builtin-buildid-cache.c            |   2 +-
 tools/perf/builtin-buildid-list.c             |  18 +-
 tools/perf/builtin-inject.c                   |  96 +--
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |   8 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/tests/code-reading.c               |   8 +-
 tools/perf/tests/dso-data.c                   |  67 ++-
 tools/perf/tests/hists_common.c               |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/symbols.c                    |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   6 +-
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   8 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate-data.c               |   6 +-
 tools/perf/util/annotate.c                    |  45 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    | 136 ++---
 tools/perf/util/build-id.h                    |   2 -
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 469 +++++++++------
 tools/perf/util/dso.h                         | 549 +++++++++++++++---
 tools/perf/util/dsos.c                        | 529 +++++++++++------
 tools/perf/util/dsos.h                        |  40 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     | 192 ++----
 tools/perf/util/machine.h                     |   2 +
 tools/perf/util/map.c                         |  74 ++-
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/session.c                     |  21 +
 tools/perf/util/session.h                     |   2 +
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 ++-
 tools/perf/util/symbol-elf.c                  | 145 +++--
 tools/perf/util/symbol.c                      | 186 +++---
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |  56 +-
 60 files changed, 1799 insertions(+), 1208 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

