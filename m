Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24B3A1C2
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739789; cv=none; b=SzBgTiaNxPC5CFgruRmC0V6Hj15H/iBpDemxFVp2uTLdovLEXW7M2ZNTUoXU+T5lAOMbGYAG04Ejs5nhRHgE0QD+riwZTvW6iKQpVXVXYBJToj+9r8NzboyvEfG51opSV7NBSedkis0okcl3iaAsNpe5SH2FaZHQFOMDNjgBI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739789; c=relaxed/simple;
	bh=6+8ttMZH+a1iPHq99hGjUHdtQF7PaS1+G02SVxU80DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JRWHcRs2qrIHN5rxPmFhfYYCEKTFmmXnj3GpoQtklieJi7Jf/GLXt2CXRFMsh/izmCSHaHWvLpgnDuCktUxnViGkc54ObUW/61t0oIOvonm4qLGOVMWkHKHWG27fsPmKzkLtTUCZ3gMlMdGBAVBYH5aiCY4SBjLCN1gH0CypAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ti5dhSzs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ti5dhSzs"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d89f0ab02bso13535ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706739787; x=1707344587; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLZjnnQr1hSsjDpZ3P3+76TqgNoCqvXQ4Y9R9TvsEfc=;
        b=Ti5dhSzsmScIcVuDKx/VlZ4+KbmyKophgSBwGylHVrEdh5qC65W1iUJ/ywfPfmxq2P
         tAg2dxoIaloo4VVT4fYLoyMUnXG0Vc1GQO+7WI4e8wIVGUuDwdCnL9bP7+o/dQC8ys1J
         ZNyWzcHZ+sCRVQRQLCeNZQH5wy+ksd+6NPMI6UZ+2WcZydov/uqh+PeLIHCjdJsLxlpH
         2dQD8ogbOdRDDyNece6ag0dnAT+XpaQxye2OUgOlLIDRApuA1k6nwmJLcPOo8J48NpHF
         pLyF0RARpYECAGkPCC4mjTC61vcL1A2RxO2Marzy5Fr0uCCu71xd1e/DSCKG2+DmtOhH
         MpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706739787; x=1707344587;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLZjnnQr1hSsjDpZ3P3+76TqgNoCqvXQ4Y9R9TvsEfc=;
        b=Dxf7h5BXTJOgMeJJyx2Wws5GgCfkDykTS8TtnM9SNhXHa49L80V8OD0XyA5Pgl7rcv
         gshuYBZLBdGwPzsbYMojXpfguvOw0uYQ71jggoGlzo1u+i9n2fx1gnLktFrU3PwN4ele
         wNnZX7NMVOGkkMUXoEQOed+r4h4M7Xgsc2RpODTGlbmbicrYMlKzn77oGciCSLXfQHOw
         9OZEwVAOH405tgBSNvFf/viA30MtrQ6gFKcrAbHtpXDJi8hSbudgozjU2nQ3/VxrNg7D
         4PJKMVoQiQjKIJplHQ9a0bpg1w4N7dW7fKpsGFpWAlb7fclwYf5hBhm4nG4YSpDIcCGV
         WUaw==
X-Gm-Message-State: AOJu0Yw5UPBg5X9R6PBIPtnZwaDhG7ZRM0Ukz4a5AxYOFI8In9BaFvD6
	sctaCAcBNIyRuNEpjPB5UuSuOFxAUbsWAFD47sI3J+tVkSErDqT5LTPCflbDYKf4GzGp7blAjKe
	dtMQ3GPKtn0ioBeTnNtK59E9shCIkFUmePffG
X-Google-Smtp-Source: AGHT+IESkS6TrhOS6lYf62UWcE3qIGRmQGUnqsw+Dky0H/SLbbYVBJ8sL7NPCGG71xw7pMkaike3pJgrfm6D4Wo3seA=
X-Received: by 2002:a17:902:ecc5:b0:1d5:7463:523a with SMTP id
 a5-20020a170902ecc500b001d57463523amr32635plh.5.1706739787124; Wed, 31 Jan
 2024 14:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103050635.391888-1-irogers@google.com>
In-Reply-To: <20240103050635.391888-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 14:22:55 -0800
Message-ID: <CAP-5=fVnWKiHNLXbNgseabcVHXp9PkukmOGSD9SFnUQCYhk8Og@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] maps/threads/dsos memory improvements and fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 9:06=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Modify the implementation of maps to not use an rbtree as the
> container for maps, instead use a sorted array. Improve locking and
> reference counting issues.
>
> Similar to maps separate out and reimplement threads to use a hashmap
> for lower memory consumption and faster look up. The fixes a
> regression in memory usage where reference count checking switched to
> using non-invasive tree nodes.  Reduce its default size by 32 times
> and improve locking discipline. Also, fix regressions where tids had
> become unordered to make `perf report --tasks` and
> `perf trace --summary` output easier to read.
>
> Better encapsulate the dsos abstraction. Remove the linked list and
> rbtree used for faster iteration and log(n) lookup to a sorted array
> for similar performance but half the memory usage per dso. Improve
> reference counting and locking discipline, adding reference count
> checking to dso.
>
> v7:
>  - rebase to latest perf-tools-next where 22 patches were applied by Arna=
ldo.
>  - resolve merge conflicts, in particular with fc044c53b99f ("perf
>    annotate-data: Add dso->data_types tree") that required more dso
>    accessor functions.

Ping. No review comments:
https://lore.kernel.org/lkml/20240103050635.391888-1-irogers@google.com/

This may start to conflict with Adrian's work:
https://lore.kernel.org/lkml/20240131192416.16387-1-adrian.hunter@intel.com=
/
but should just need minor get/put cleanup.

Thanks,
Ian


> v6 series is here:
> https://lore.kernel.org/lkml/20231207011722.1220634-1-irogers@google.com/
>
> Ian Rogers (25):
>   perf maps: Switch from rbtree to lazily sorted array for addresses
>   perf maps: Get map before returning in maps__find
>   perf maps: Get map before returning in maps__find_by_name
>   perf maps: Get map before returning in maps__find_next_entry
>   perf maps: Hide maps internals
>   perf maps: Locking tidy up of nr_maps
>   perf dso: Reorder variables to save space in struct dso
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8
>   perf dsos: Attempt to better abstract dsos internals
>   perf dsos: Tidy reference counting and locking
>   perf dsos: Add dsos__for_each_dso
>   perf dso: Move dso functions out of dsos
>   perf dsos: Switch more loops to dsos__for_each_dso
>   perf dsos: Switch backing storage to array from rbtree/list
>   perf dsos: Remove __dsos__addnew
>   perf dsos: Remove __dsos__findnew_link_by_longname_id
>   perf dsos: Switch hand code to bsearch
>   perf dso: Add reference count checking and accessor functions
>   perf dso: Reference counting related fixes
>   perf dso: Use container_of to avoid a pointer in dso_data
>
>  tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
>  tools/perf/builtin-annotate.c                 |    8 +-
>  tools/perf/builtin-buildid-cache.c            |    2 +-
>  tools/perf/builtin-buildid-list.c             |   18 +-
>  tools/perf/builtin-inject.c                   |   96 +-
>  tools/perf/builtin-kallsyms.c                 |    2 +-
>  tools/perf/builtin-mem.c                      |    4 +-
>  tools/perf/builtin-record.c                   |    2 +-
>  tools/perf/builtin-report.c                   |  209 +--
>  tools/perf/builtin-script.c                   |    8 +-
>  tools/perf/builtin-top.c                      |    4 +-
>  tools/perf/builtin-trace.c                    |   43 +-
>  tools/perf/tests/code-reading.c               |    8 +-
>  tools/perf/tests/dso-data.c                   |   67 +-
>  tools/perf/tests/hists_common.c               |    6 +-
>  tools/perf/tests/hists_cumulate.c             |    4 +-
>  tools/perf/tests/hists_output.c               |    2 +-
>  tools/perf/tests/maps.c                       |    7 +-
>  tools/perf/tests/symbols.c                    |    2 +-
>  tools/perf/tests/thread-maps-share.c          |    8 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |   16 +-
>  tools/perf/ui/browsers/annotate.c             |    6 +-
>  tools/perf/ui/browsers/hists.c                |    8 +-
>  tools/perf/ui/browsers/map.c                  |    4 +-
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/annotate-data.c               |    6 +-
>  tools/perf/util/annotate.c                    |   45 +-
>  tools/perf/util/auxtrace.c                    |    2 +-
>  tools/perf/util/block-info.c                  |    2 +-
>  tools/perf/util/bpf-event.c                   |    9 +-
>  tools/perf/util/bpf_lock_contention.c         |    8 +-
>  tools/perf/util/build-id.c                    |  136 +-
>  tools/perf/util/build-id.h                    |    2 -
>  tools/perf/util/callchain.c                   |    4 +-
>  tools/perf/util/data-convert-json.c           |    2 +-
>  tools/perf/util/db-export.c                   |    6 +-
>  tools/perf/util/dlfilter.c                    |   12 +-
>  tools/perf/util/dso.c                         |  469 +++---
>  tools/perf/util/dso.h                         |  549 +++++--
>  tools/perf/util/dsos.c                        |  529 ++++---
>  tools/perf/util/dsos.h                        |   40 +-
>  tools/perf/util/event.c                       |   12 +-
>  tools/perf/util/header.c                      |    8 +-
>  tools/perf/util/hist.c                        |    4 +-
>  tools/perf/util/intel-pt.c                    |   22 +-
>  tools/perf/util/machine.c                     |  570 +++-----
>  tools/perf/util/machine.h                     |   32 +-
>  tools/perf/util/map.c                         |   73 +-
>  tools/perf/util/maps.c                        | 1280 +++++++++++------
>  tools/perf/util/maps.h                        |   65 +-
>  tools/perf/util/probe-event.c                 |   26 +-
>  tools/perf/util/rb_resort.h                   |    5 -
>  .../util/scripting-engines/trace-event-perl.c |    6 +-
>  .../scripting-engines/trace-event-python.c    |   21 +-
>  tools/perf/util/session.c                     |   21 +
>  tools/perf/util/session.h                     |    2 +
>  tools/perf/util/sort.c                        |   19 +-
>  tools/perf/util/srcline.c                     |   65 +-
>  tools/perf/util/symbol-elf.c                  |  132 +-
>  tools/perf/util/symbol.c                      |  217 +--
>  tools/perf/util/symbol_fprintf.c              |    4 +-
>  tools/perf/util/synthetic-events.c            |   24 +-
>  tools/perf/util/thread.c                      |    8 +-
>  tools/perf/util/thread.h                      |    6 -
>  tools/perf/util/threads.c                     |  186 +++
>  tools/perf/util/threads.h                     |   35 +
>  tools/perf/util/unwind-libunwind-local.c      |   20 +-
>  tools/perf/util/unwind-libunwind.c            |    9 +-
>  tools/perf/util/vdso.c                        |   56 +-
>  69 files changed, 3127 insertions(+), 2158 deletions(-)
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h
>
> --
> 2.43.0.472.g3155946c3a-goog
>
