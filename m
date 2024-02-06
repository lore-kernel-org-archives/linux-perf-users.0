Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8F745C5
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190406; cv=none; b=Czh2cBsZbo9ILFFPyYsn5To8Z3uDyMh7xKnr3/v/MDUhLp/lp7cxwq7ssxgJHCNsgSZyuU7TosGrf1ncoBbJjd7gft+AuRNW4a6Lq25pqyHjHAu/UeZ3Cly2OqNdBK0KrV0qyIBFTJvY22zgMR/QRcjb2iFc+OukTRkjoZIHw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190406; c=relaxed/simple;
	bh=37JfY9goEyfL1tils/65Mm1whb5ed6z34kDU6IWdu7c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YC0GFrcY/taUylSDMrYmKiuXFkWAap4+XhiD69U1oChOcjg+8+7q0JR+1ERaBlZadevWIWQsr5F/0EI6zFzgXuyrO14CcYFWWOZHUufudF0lSAcmlJhav4Lmn2cRTVY1LkyRX0E0nagOxvnpSBrom1VbqhVo4Rx7c+2zJSB1zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGJOeYPg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGJOeYPg"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047f0741e2so865287b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Feb 2024 19:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190404; x=1707795204; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuTvsdW4nPk5F0JAYEhrkK8gf2WJ2UoBgHHj4XMAB70=;
        b=hGJOeYPgTCyBI/7HrtPjmLniUplSTtlj9eWkegtnOjNlPn29YBrnwyiQ+5t9mxHfkL
         nmd63aS18V5hB3uGCE4VtS29IFMgcyVvVS6Ygme389FAli+PtUiWmKRyCRnQcMT05zlY
         NzT5k7MognKEE/uw0meK6jv4nPlzkHsGm5DYLOjY8GBFWK6LLC72vYcrK9RpgNPEWg5L
         UOswa2uBDs97pmUjsVqtAMjnwKi+8PPFtEbX8sv1e3nPkEDYj8NhB+JOLwLmeMct+LSg
         8XXeztLF6daJ55ex7I8PePBgpHVdpfmtCqu6OTBJSmlWrGL8bIBgKdiNzdWCDSTkYXxe
         FVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190404; x=1707795204;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuTvsdW4nPk5F0JAYEhrkK8gf2WJ2UoBgHHj4XMAB70=;
        b=Xcmk+bfRXnm+0T/SIRQ6Mqh/GeZ6aZnzrQvYNURB9Io3BMQHjvqEz6Unsez0s08DsV
         4iutj86ecZBvhHpZsCQe5G9JzUNEjM6OJOY1UVIy19899tQgZOjzUWOytZwTO2UcDqkT
         pbVoFj580YaaSJzxqliiMWw4OkI0T0hDqATONePOakqyLebdhgprJ5MHI3mNKc+wT/H1
         M+s8Lo58JGzJcjpnfHrXpIXfrQ8DZFcfF28++JxEkHhWVkSXXLLZwr/z0+ox7iXeRyOt
         rNrj/eWhMcsReH1l0Dzjf8V7wDiMqtvBv1r1mGVVEKsNNAB8CAKxqWRIwhV+TzVBqjj8
         viKw==
X-Gm-Message-State: AOJu0YxVmeBhdCqInxN8/ALG6SYIDhjzYGhuPzrXp7WpZFyTG+xxf4AU
	+tg44Yoy8lMqT4H08a8Oe6NfNY56kD8Vpy3w9YpDe3rzuVGYLiqnxRdUq6iI13n0aj2cKBLux1a
	feMULYg==
X-Google-Smtp-Source: AGHT+IHWG4Pm31Chn2HrVGdfYVjuO9iSdtbPqq26e1uGOzUQ85BvKCXVDXh/eDhIrtBGVkqLv94H0oTjHw4O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:690c:10c:b0:5e8:bea4:4d3b with SMTP id
 bd12-20020a05690c010c00b005e8bea44d3bmr75549ywb.6.1707190403843; Mon, 05 Feb
 2024 19:33:23 -0800 (PST)
Date: Mon,  5 Feb 2024 19:33:14 -0800
Message-Id: <20240206033320.2657716-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 0/6] maps memory improvements and fixes
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
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

First 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/

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
 tools/perf/util/unwind-libunwind-local.c |    2 +-
 tools/perf/util/unwind-libunwind.c       |    7 +-
 17 files changed, 899 insertions(+), 573 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog

