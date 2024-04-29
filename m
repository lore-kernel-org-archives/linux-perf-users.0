Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC413AA27
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416386; cv=none; b=rUcxHv4kcLt7hAW1kUOB86NLqQ9fTVRU0luSTqCXQTDFib9nBFsI2mtCEUlqphiBU3pvGA4ZjJEFZ0ToHMq7tk83gXx7/Qf4FlqctF+uq0OuwZZYcLjL5l8v8d4I94yv6uGAK4pInZxmFmGpYp9Ls4qttEk9mjz2ORyjkRwbUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416386; c=relaxed/simple;
	bh=6uTTt0xsMfuVzjMKqkCH0gjwhFQ2avhuuVM4OafhzkE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=m4dJyMoWL3HqQjvWc71CuhmmGXQV4/bb4dCHIId3AkoaC5QsoYjbT5cNyaVS25x1K2jy1actwHf8x5oRAvL4c9dCUi0YqXxZCn/SmDpzzphIhs21h9YQ41H9/44hagQk7861/VyMzlJTTZdqfingnY+KKmR7BedXbi4bJyPF/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtcLxt/l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtcLxt/l"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so7849686276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714416384; x=1715021184; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oSCw02zU0xlj3oJMiPK9ug/zZBXgwAdEBami/HcNOOo=;
        b=AtcLxt/l6jGuxgHNeS9Q9UH71zxzDm9U2mkRwP0lCSRQKtllRY5U/Ie5k0RNQRUUgX
         F5Fu7M7jn11J3kmNuwywItaNQnnnvA/5CTMiHGXTkGNfpkPOsgLs43vOlUKNnREqeazz
         6NWmcb4JnM4J8cVHMsoHQ/7dxDGWw3P90x5Mi2IylwwhL7H4CxNI1a/H1PdSwUJcxt3b
         1gvWebJehVolFWdZjfjYzZQz37i+XId+IlLhKS5fbLOQ+HHmvQx3Un1efbUd9j2yzKXq
         0fKBAjKQ5r+wg1QP/FHeqmp69wHOacc9ih6RnXOZuu/S1SD8xtaaqZKp7msfaEAeFeN2
         XPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416384; x=1715021184;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSCw02zU0xlj3oJMiPK9ug/zZBXgwAdEBami/HcNOOo=;
        b=MhZu+NDsFQdQmmuZ9A+OStQdSJAs4OGYH0L7PT7OxYgXt6A0eRNYH0W6x+izflYzFS
         aQIYMOyYt1VRTyLZTLUsUc8GjHgITUGjaVMbmvubVRMFixOJ2mB3o2UDezlv5Dsl4iJl
         RVegu+Kq5du6Vc2HCtJb4k2XxHYP275EQ4hIWGY1ftLGqLd/lSpFBXdefGxrCT/PC4zH
         JktgIWpj+KGBT2OASg9HMLm+5VVk35gvoVuJ5d3h/nLCY9IIX/iw7TCYSe8rYihNdtnr
         JwH7DoPzgef4kse0Cdty5TuR1Bf234QlKWV7VFO05qZnZIcfixt3zSComqDl1LdVV4Td
         BwDg==
X-Forwarded-Encrypted: i=1; AJvYcCUtDzZQR+zupp+WXY6hyVhRLyXxNzA79Ct6Yt2bsLumfTS/I6Xs+P/jHxWFiLY6+K+5/6MLdhV9+QWueydIQXvgWR9SJYoxrOuGDo+t2JbEQQ==
X-Gm-Message-State: AOJu0Yznpm0Ep/jknVSUvG1Mo8wehvERkU4ZpkmxfjmeBYo2HhPYXSv1
	XtdxfJajWCRHdzzN0oaCVGQm1Iy1NEJLeD0p/j/R33TlV6DworR5ki7CJzkuqIBwRUhs4EiwUZz
	yQ5sxkQ==
X-Google-Smtp-Source: AGHT+IF2ls8b53sMctq/5AaFnsXtJj7VlNZ8T3m834/TelYpiBHscXYdmmhDWFaVxirycZengZqeommiCf5l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1106:b0:dcc:8be2:7cb0 with SMTP
 id o6-20020a056902110600b00dcc8be27cb0mr1236562ybu.0.1714416384297; Mon, 29
 Apr 2024 11:46:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:07 -0700
Message-Id: <20240429184614.1224041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v5 0/7] dso/dsos memory savings and clean up
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
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
 tools/perf/util/annotate-data.c               |  16 +-
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
 58 files changed, 1409 insertions(+), 932 deletions(-)

-- 
2.44.0.769.g3c40516874-goog

