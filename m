Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DE913AD2F
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Aug 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877104; cv=none; b=fHBerZyyaFn5dQFTs1Tds0v7N9B4ViDFI4L/kPY8UA1bvLREfow9iBtqtsascu4WRYAKvzDcFTvKFthc+2XXvMRyBLTeh/boYIOCiCxiwwuFfxlvriNKBqyrZDKaQdsn+sI5n2Ogf4ccGedo+f1uB7WRBE9bjryJ7A7bjzzEDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877104; c=relaxed/simple;
	bh=IXtYMnjmCYqhMrj3iJHdd0cKXN0eMB8Ry1wJ89qWj+s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nVHFDidMKbk1TtIkpNAAAHT1lqogFEG0pUBJnGJV5YcCleLeSCZcJ0SHPHJHLfVAd30T6RjUWRVbNxL7zyAJdRwaCF47aTnXv/Kphdmrjx37IQwvSz+pdGE06KU6oCkGyMe+7Aytxh38KAIT7LhxWdmfjDSRAo9Hlr+thXFaz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umDg3VAt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umDg3VAt"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b38bd44424so18457327b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877101; x=1724481901; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zc9lwqz+vCaLRPDoCDBvoTod7icBUTaf+QytbMzdm/8=;
        b=umDg3VAtkAnCBsobjwTxZWS020fAhCNfCBG9UCwyPAAJxe6CcJNRwLnUZ2U8mIrwud
         4GeLDIeoB0GnOA5unxmqJC+njw1Jk//8pysRepJQUr/sOPtJI+1UdA4B3hdK1ExD/1Hn
         W3w52R5JA3plUCqVhLZDI5ayzkJJpzkhWWPNS6mE+mVQFHGsKgS0amJSe66WJXuxtxjP
         K4ZARkKacUiRlKz3LVkPALCzeUwm7Zq4S6sqMEP8vBiCH8fi54kP6c5Y6il1H9MC15sJ
         TjdwITHRc4ItrC1taRB0KOay8oyGEE51h5bXNwsaUMwBPg/bo4yFck60zxfuG2ek5MVf
         V8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877101; x=1724481901;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zc9lwqz+vCaLRPDoCDBvoTod7icBUTaf+QytbMzdm/8=;
        b=WfmDMnrj6aDPnGfIxa6Elz/SqRHhc8QZzAPGALbx4Of0x+ns8YQ8nzrQ59jTEg6gmN
         jHAXeiAq7tK5Jnl8QXu1tssJVR/KXf5fE5H7u4sLx2ILxgECEgoLsWDu5he+S2Pytt9t
         yJtFUss61+T98FYiDOrq/RFeNvrWu4VMMMXPkOC5Kg6GguWml0/OuVBXTXMZTJaheEJG
         9M7LYA2ijjGa2f8fb9cj7b5RjT/GJvI7IA3o/fVMPWU84o4iCqJjJjRFX0pil6zFziV/
         BCcsK9GcMJJtYK7Nw+q+nEffbJHrKjYRYVZwTah8yXYG4+TdnTcW7rfDVny3RVGloaZQ
         OCfA==
X-Forwarded-Encrypted: i=1; AJvYcCU2/maG/5C9YLJ0v1jlyiTEyxHgxmMw24YNJMzd7xYPV0YH26feF4vAouNK+3cXvQ6NeNNA5+kuFaDU0e7klG253udTOSx9IUjj+fjApb9UXA==
X-Gm-Message-State: AOJu0Yyj3YgHtGHalv0F5+Mn4fDnI4WsLnXFHaQdUqu3CjsAUv9/cwxV
	jq1TgUi+688Iiyr/GX1v75PB2AiohezkB6TAlesIdXXlGheXUCzgyB6XxCSSrBjNeMqBBJ8JZ1e
	afJ1r/w==
X-Google-Smtp-Source: AGHT+IF0c1kHTtNmQ8YqUbSlWr/peUPSf0ASeWsg/qwjWVL1kXV/hrLuK2p710o4R6Tgm39wZjOo9zaLtAtS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a05:690c:34c8:b0:6aa:4e26:e600 with SMTP
 id 00721157ae682-6b1bc20a43bmr1216967b3.6.1723877101409; Fri, 16 Aug 2024
 23:45:01 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:29 -0700
Message-Id: <20240817064442.2152089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 00/13] perf inject improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix the existing build id injection by adding sample IDs on to the
synthesized events. This correctly orders the events and addresses
issues such as a profiled executable being replaced during its
execution.

Add a new --mmap2-buildid-all option that rewrites all mmap events as
mmap2 events containing build IDs. This removes the need for build_id
events.

Add a new -B option that like --mmap2-buildid-all synthesizes mmap2
with build id events. With -B the behavior is to do it lazily, so only
when a sample references the particular map. With system wide
profiling that synthesizes mmap events for all running processes the
perf.data file savings can be greater than 50%.

Reduce the memory footprint of perf inject by avoiding creating
symbols in the callchain, the symbols aren't used during perf inject
and necessitate the loading of dsos.

Ian Rogers (13):
  perf synthetic-events: Avoid unnecessary memset
  perf map: API clean up
  perf jit: Constify filename argument
  perf dso: Constify dso_id
  perf evsel: Constify evsel__id_hdr_size argument
  perf test: Expand pipe/inject test
  perf inject: Combine build_ids and build_id_all into enum
  perf inject: Combine different mmap and mmap2 functions
  perf inject: Combine mmap and mmap2 handling
  perf inject: Fix build ID injection
  perf inject: Add new mmap2-buildid-all option
  perf inject: Lazy build-id mmap2 event insertion
  perf callchain: Allow symbols to be optional when resolving a
    callchain

 tools/perf/builtin-inject.c         | 532 ++++++++++++++++++----------
 tools/perf/builtin-top.c            |   2 +-
 tools/perf/tests/shell/pipe_test.sh | 103 ++++--
 tools/perf/tests/vmlinux-kallsyms.c |   4 +-
 tools/perf/util/build-id.c          |   6 +-
 tools/perf/util/callchain.c         |   8 +-
 tools/perf/util/callchain.h         |   2 +-
 tools/perf/util/dso.c               |   4 +-
 tools/perf/util/dso.h               |   4 +-
 tools/perf/util/dsos.c              |  12 +-
 tools/perf/util/dsos.h              |   2 +-
 tools/perf/util/evsel.c             |   2 +-
 tools/perf/util/evsel.h             |   2 +-
 tools/perf/util/jit.h               |   3 +-
 tools/perf/util/jitdump.c           |   6 +-
 tools/perf/util/machine.c           |  95 ++---
 tools/perf/util/machine.h           |  36 +-
 tools/perf/util/map.c               |  25 +-
 tools/perf/util/map.h               |  22 +-
 tools/perf/util/synthetic-events.c  | 103 +++++-
 tools/perf/util/synthetic-events.h  |  21 +-
 21 files changed, 682 insertions(+), 312 deletions(-)

-- 
2.46.0.184.g6999bdac58-goog

