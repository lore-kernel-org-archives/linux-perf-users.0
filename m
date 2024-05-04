Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBC6BB5D
	for <linux-perf-users@vger.kernel.org>; Sat,  4 May 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858690; cv=none; b=Y3evm1lu+1E/6PmqYWDcwqtG8s5+HvWLIJshlTFQKHc1XuK6A3gynB89l1DorulIxPJ1WgUKMOLBO9aUBYQtDpWbcMsMT5f3Ddh+Yx4D/9Um6VtpWnBdV+tpN9sdwld1q9i5X3VjZ/oexXKNMFSoqSOeXTQFZaZ4kqqVQFOYvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858690; c=relaxed/simple;
	bh=jwPQPE0LaUnBq10rb63Q5qQmTUg0UxtBnAXGrxMj57Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RuSHQUriZr1KIuUbgK+NIUF1ZlEWLKzxrAiwRdblE1+Pwb++JCmzqrsw0PDsAEOMS3kGqtmWfgAOSiWpkybDwlssW0Q7S03ffPmGe0RBOPavy7Cmmann8Er2Xzg+K4TjWZJdyXptLb64WLr9AilqwYoMcbRiKfAW1wPoAllCPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAUyOz6M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAUyOz6M"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso19386377b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 04 May 2024 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714858686; x=1715463486; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rB3YhgzfwXwrL9B2CMfp1D4aEZDjDbBiJNoR565UiE8=;
        b=dAUyOz6MdBTBsd+2X3z8xDoDINEvNN73Y+KkQzIA4AAAz8XqelFf/iTBMXv63tQtyW
         5eF6gpUbyZ0Xqmn+Q0Bbkvk39jsJ/GauM/ilH7cbtiejSx+PhUKna1CLvRkJcKKBUrPx
         n7ODAmSc0iLTTj3FqwjezPguXneghOb58QcKDmrOe20cJAFIYySwc3/BbNHO9oXHY7OZ
         j1RXhk5qJg55E+drmx7cLVIn2sNSfldGoXwAv1X9aeJ+H34SrirUJClh1F4PVmeCuQcg
         snU8oCKMjApumW0ZZ+pUt5tgAnCjp1pT8LWVM+BFT+nfXjlW/0837dRzZvHpPnyHj85g
         ZaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858686; x=1715463486;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB3YhgzfwXwrL9B2CMfp1D4aEZDjDbBiJNoR565UiE8=;
        b=pxPqd5xafoX/U7TyZ0FILCS95RKZMqolk2k/vake3D9hIuIk8GgmbAwWgjHMV37nTv
         uFmMYqF5B0OSSY63DShixFfYUBRvClbpzPUQzTUTUpe7xmBlkgu5NFIGainaeMmePwwN
         ZMaHOyHhIaTs2t52sN2VzYBB+1zPF+AZq36QWjYrA6mNvnYLjmpGzA6+1dHNyZapdKZ7
         r9t5tSP1wojoXXRd87lorrU6FzQqbzPwLUnS26MPxdSbRAgO/XQWIWN+H0+s53OEqhyh
         ln6FbCLkZDhQJgTcYvKWd82mUi4JCPhxtl8Pv+8AQhPAlRetJEnI+5Nitjpo2FCU+GuX
         aaqg==
X-Forwarded-Encrypted: i=1; AJvYcCUCxS9rBeI4RRIzSpoojopj52hA+U/+A0kPBKN4j+Tig8NlkSzKXVz+Oh4Vk1wXZVX0KZuiPIhLngfEwB7sevEyrKSn3wTQzoHtnn8Gp4piHg==
X-Gm-Message-State: AOJu0Yw7btiN3IFbCfhc2Ju3scTdd0ZDUT0s7WNuCRE484B+SnAh1SCx
	HU1xHUehLK7U4rYIG/4hZM/H1k1fpoWoPbrgJVc9KTiCadnw00CIfMhHZlzSUbY9bosfpVQCfOb
	2DF9WHg==
X-Google-Smtp-Source: AGHT+IF03zHilytjeysTzsY6wyb+AMpYb7yNvY7XzWmDT62USyKMxuJ1J6m2IwbM10cVzmUTDiv584riniF6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:d233:ffdd with SMTP
 id w7-20020a056902100700b00dc6d233ffddmr2150280ybt.0.1714858686641; Sat, 04
 May 2024 14:38:06 -0700 (PDT)
Date: Sat,  4 May 2024 14:37:56 -0700
Message-Id: <20240504213803.218974-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 0/7] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

7 more patches from:
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
memory usage is at least reduced by half.

As fixing the memory usage necessitates changing operations like find,
modify these operations so that they increment the reference count to
avoid races like a find in dsos and a remove. Similarly tighten up
lock usage so that operations working on dsos state hold the
appropriate lock. Note, since this series is partially applied in the
perf-tools-next tree currently some memory leaks have been introduced.

v5. Rebase, adding use of accessors to dso as necessary. Previous
    versions were all rebases or dropping merged patches.

v6. Rebase, move dsos__purge NULL assignment to dso->dsos to above
    dso__put to avoid a warning reported by Arnaldo. This was part of
    patch 5 in the v5 series.

Ian Rogers (7):
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/builtin-annotate.c                 |   6 +-
 tools/perf/builtin-buildid-cache.c            |   2 +-
 tools/perf/builtin-buildid-list.c             |  18 +-
 tools/perf/builtin-inject.c                   |  71 ++-
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-mem.c                      |   4 +-
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
 tools/perf/util/annotate-data.c               |  18 +-
 tools/perf/util/annotate.c                    |  17 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    |  38 +-
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/disasm.c                      |  40 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 429 ++++++++-------
 tools/perf/util/dso.h                         | 500 ++++++++++++++++--
 tools/perf/util/dsos.c                        | 286 +++++-----
 tools/perf/util/dsos.h                        |  18 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     |  50 +-
 tools/perf/util/map.c                         |  78 +--
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/print_insn.c                  |   2 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 +--
 tools/perf/util/symbol-elf.c                  | 145 +++--
 tools/perf/util/symbol-minimal.c              |   4 +-
 tools/perf/util/symbol.c                      | 186 +++----
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |   8 +-
 58 files changed, 1410 insertions(+), 933 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

