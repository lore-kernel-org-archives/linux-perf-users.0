Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F712BF1C
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036989; cv=none; b=ss49B/0oiIPBPBjPIc3lO4TtVDXegVhch5MZZbJzrpEolHO9Eq/z09swtHAos2XKR27Dfsymkdb7FYDygcfF72txqbexSeDy6SwLmhIkQ4mz75rc42o4SDgK2YuQqC4jA4quCMTZ6PvS1Kq6vsJ6zXl7s9BpVY2Uh0INwS/V1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036989; c=relaxed/simple;
	bh=nB1k5uaFBqYaBOpNNY+26UH1wVO5501tHpsS/EBiFYQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gMMa1/MxNR5e9ppDmCroNDvUD3BFL7ZH7s+LIheTNeNZ2pcGn5/qFKYyB7Zx9L2ejw6/7qwP0qyN1tTwY1B9BIeYs137soKN2fcX0YZA+Hg84S5Hxwgx/fjTMOueey/rPCjkGKJj682NxaxohWuAROsYDt/vs+qnMu8Gjsn1ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5/3wQnM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5/3wQnM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so1691537276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711036987; x=1711641787; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTRt1HiPuKsc9DFIQ0MUxj2NIV+5m7aSyK2vQDOvUXE=;
        b=p5/3wQnM3cqV4w8xndCAPuTFpxQw1lwaQ47lv1lUULB9H6T7p5cYS5ww5UhUZ6q8+p
         IIsH8CxvvCrJKd94DCyGnZPyGG63IdpvEF6qnliEsWEvdD7UlRPYipz+8fGcI55+dQhx
         Sgdokqtcu7kVS13PCur9/nDmazc5cNZ7yRvNapsy7ibjs94CAhP51LrmBCkGDGMaCzdn
         QSpwsH86JMaeFSFi5XDHcIKqAP0RdTT7nb9BaylswtIck4TA5Sskx/zDWSmDtsRWcCSS
         VmBsKpOHveLJNY97kWEG6R/rl0NuDoaKzja71DgsZazo9DXq4NKXlSa7ItODvZ6Bbebf
         ZA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036987; x=1711641787;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTRt1HiPuKsc9DFIQ0MUxj2NIV+5m7aSyK2vQDOvUXE=;
        b=r6qVk0QUHinFo6CHJzdWT6j6zYG1d+ZwGy8r+FgDlOC2Kv20c9fTrA4cQThvfxrpJu
         RdUie43fy6OnTOXzNY1pp/s6JAKERx6iWoxWORecyUcVCbbHkicrCHQcxj/NP8yVS/S4
         l3lrtgyVMA5F94BM2s66zcHWlm8Az9EGTvWHj+vmqyVt8n4aRofXDHPu8oVOW68waxWv
         qEIZUDykjxH4FqGJhDuG6EWo2yVwuyKwpI4Smy0gtU+lZ2LFjkZaZP2IV6SDjPBMdiG/
         2wy3xsx25vTvSzSJ38vuED9zrL/Bl1f76mmHmnev7PNBylFZkGelAg6XM1vrpEvbfLXu
         s7xg==
X-Forwarded-Encrypted: i=1; AJvYcCXUDmFUWlZrbe09PPIHHGaXma3vF3P1AJrU/OE/s7CyMQhGbhDX+EDEj3lHyff2da+NGogF4t/5NycrTX+kotYmNdnOUxElr2JpBq4n53zuFQ==
X-Gm-Message-State: AOJu0YwjafhDBfMObX8BKpxzy8nG/gmBvduP8yPvhts0cFebJBRGvkbG
	imPGI54ZFiiS8k8KXiWf66hajPirnzZwvb1XnLg/7pO+ulQ+44MDjVZt+SrMlNd+116I3oKO6aM
	n4TIPKQ==
X-Google-Smtp-Source: AGHT+IG0+ZDqllFR0+pj15UK/R+4X9/CrYVOdT9x1taLSZGE+fXa9uTPhVWCY3Nso8QPBTPsQKxFF72pAyVr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:dc9:5ef8:2b2d with SMTP
 id w14-20020a056902100e00b00dc95ef82b2dmr5504757ybt.4.1711036986806; Thu, 21
 Mar 2024 09:03:06 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:02:47 -0700
Message-Id: <20240321160300.1635121-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v2 00/13] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Paran Lee <p4ranlee@gmail.com>, 
	Li Dong <lidong@vivo.com>, elfring@users.sourceforge.net, 
	Andi Kleen <ak@linux.intel.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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

v2. Rebases on top of tmp.perf-tools-next resolving merge conflicts.

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
 tools/perf/util/annotate-data.c               |  14 +-
 tools/perf/util/annotate.c                    |  47 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    | 136 ++---
 tools/perf/util/build-id.h                    |   2 -
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 472 +++++++++------
 tools/perf/util/dso.h                         | 554 +++++++++++++++---
 tools/perf/util/dsos.c                        | 529 +++++++++++------
 tools/perf/util/dsos.h                        |  40 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     | 192 ++----
 tools/perf/util/machine.h                     |   2 +
 tools/perf/util/map.c                         |  82 ++-
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/session.c                     |  21 +
 tools/perf/util/session.h                     |   2 +
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 +-
 tools/perf/util/symbol-elf.c                  | 145 +++--
 tools/perf/util/symbol-minimal.c              |   4 +-
 tools/perf/util/symbol.c                      | 186 +++---
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |  56 +-
 61 files changed, 1817 insertions(+), 1220 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog

