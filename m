Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7E25B669
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087314; cv=none; b=ti2jLK9nq1VXQ9CQQK+eG52Q5xWfAhQMwlra+Avol0k6ceyyEkxzUKL3bqsA7AWSrA0h8CKb9CER284/EZCwvMFAa9dGV5KcKlKt60EfJCUCsAjyJrjUUsfs77LDmvAw02k0ILCFDAmZgNzadTVi28qCoLMA+8Twv/8VCUm1jTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087314; c=relaxed/simple;
	bh=q7bppKnh9hkPE3BVcGm8BpWNBC/vEE24Ea5etqZ9gAc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KHKUNT6ZVqSglafXje7SO4JH4/lMTRSa/emfwphCYlRByQj5cnR0hQwxn4XK1P8QSEBJTDL1J0emGb+Q+vyyF7EJPsAr6al720MguCbPM3HtVmArTZ+I2naFRLANtOR9E317DGj8I22Bqilur7/UxrNgXrBKzlhE2xFkBcvfwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWfATtUY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWfATtUY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e816139b8so37426375ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747087312; x=1747692112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLNkpfd9QG+r6EhpWQHxYHkkitesHQCxe3zmaQDF/oA=;
        b=eWfATtUY/2C4M1M9Yi9IE3tIqWViz8R/T2bRbXHxSfAb9avvb80TABYULD8QyVbOMx
         LQybMqvLnRUxr7hTnLVyecw+7QY1CeB+zFabMt9Nyp8ncsZzd9L4NGK9x5uO61TIaucB
         tp1GDxLkmO21JUlWqEzmLkp1fqVbCmwaZNoO8EUuU/dUaBaPXyCuwxR7wQKiaXWvmDaA
         meoukSISXlQ/h8ivJ9M+hV7rI7orDGc7iVdxbeavivG0jGIGQrZM3QT9bvsm0PGr1zlT
         Yxhsl8IMlHEThoxBwTbJOAnKXsLjBCgqoY0Qb/4XA5bkQ1IBROwZ8UYKxBPZh/MR3WAT
         ugHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087312; x=1747692112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLNkpfd9QG+r6EhpWQHxYHkkitesHQCxe3zmaQDF/oA=;
        b=UDZEYUFzeJx4VG1yumvCXO7NkxLZBt+u0KoRoyiRsIvc+wUt3ADFJ/2orxsrJW6dL/
         ZNETPdNhYQMPmIilyRHSDCG20S/gSLHREQH6Yq1k8Kutt6grmdfcxg7RtNDLZS9uuZnA
         Xrb/89q7x1G0+GIubFfF8+m9g9iYKbyj3fuZW1wKBRy9PRrlKTODtGdZd3UJiqg1WuP4
         Cfg5XgROofONTi1xaIWBvYQYQfr7UbspSf741yUeGG44lYdgqMTrSHXD6rsMiICZCXu0
         ozgxrQvbrTjc71pIm6oZ4cR8ROebbK/WPbF/hrA1NML6ur4hclSeO+DKO8lDKy9koyBi
         Lbmg==
X-Forwarded-Encrypted: i=1; AJvYcCVU92ldM0mTBN9D5n0H2KyZUGEteMPPnftAduid5v7ufCkyUHQ9RbCCJ0PcySmoPHpQmuIhMHM05FXKFJttdmbA@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4m+49dX/vpxRsHCKlESDX0dT6sVbgsZ3eQgh6WHlGvqX8+dk
	9/B5oWJFVXQda3TI+AGActdtPZe/KPtdxp9OY/T8eobOGHeYqsq6Y/MglTAK7VxDp/SJ7RE5v/I
	ImQ==
X-Google-Smtp-Source: AGHT+IG/ZZSSGmPsNVQexMKzcuPHKss7RKMQUaah9mPyMa0UDduJclcU1JqFNkLQVSLLfiQ77yxe88oiVbM=
X-Received: from plgm14.prod.google.com ([2002:a17:902:f64e:b0:224:efa:ef21])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:224:1935:fb91
 with SMTP id d9443c01a7336-22fc8c861a7mr217194555ad.27.1747087311803; Mon, 12
 May 2025 15:01:51 -0700 (PDT)
Date: Mon, 12 May 2025 14:50:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512215929.2098240-1-ctshao@google.com>
Subject: [PATCH v3 0/3] Fix incorrect counts when count the same uncore event
 multiple times
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, weilin.wang@intel.com, yeoreum.yun@arm.com, 
	linux@treblig.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's take a look an example, the machine is SKX with 6 IMC devices.

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127430      6,901,503,174      uncore_imc_0/clockticks/
       1.001127430      3,940,896,301      uncore_imc_0/clockticks/
       2.002649722        988,376,876      uncore_imc_0/clockticks/
       2.002649722        988,376,141      uncore_imc_0/clockticks/
       3.004071319      1,000,292,675      uncore_imc_0/clockticks/
       3.004071319      1,000,294,160      uncore_imc_0/clockticks/

1) The events name should not be uniquified.
2) The initial count for the first `clockticks` is doubled.
3) Subsequent count only report for the first IMC device.

The first patch fixes 1) and 3), and the second patch fixes 2).

After these fix:

  perf stat -e clockticks,clockticks -I 1000
  #           time             counts unit events
       1.001127586      4,126,938,857      clockticks
       1.001127586      4,121,564,277      clockticks
       2.001686014      3,953,806,350      clockticks
       2.001686014      3,953,809,541      clockticks
       3.003121403      4,137,750,252      clockticks
       3.003121403      4,137,749,048      clockticks

I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
looks good.

Ian tested `hybrid-merge` and `hwmon`, all looks good as well.

Chun-Tse Shao (1):
  perf test: Add stat uniquifying test

Ian Rogers (2):
  perf evlist: Make uniquifying counter names consistent
  perf parse-events: Use wildcard processing to set an event to merge
    into

 tools/perf/builtin-record.c                   |   7 +-
 tools/perf/builtin-top.c                      |   7 +-
 .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
 tools/perf/util/evlist.c                      |  66 +++++---
 tools/perf/util/evlist.h                      |   3 +-
 tools/perf/util/evsel.c                       | 119 ++++++++++++-
 tools/perf/util/evsel.h                       |  11 +-
 tools/perf/util/parse-events.c                |  90 +++++++---
 tools/perf/util/stat-display.c                | 160 ++----------------
 tools/perf/util/stat.c                        |  40 +----
 10 files changed, 332 insertions(+), 240 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh

--
v3: Rebase with tmp.perf-tools-next. Since most of the conflicts are from
lore.kernel.org/20250403194337.40202-5-irogers@google.com, tested v3
patches with:

  perf stat -A -C 0,4-5,8 -e "instructions/cpu=0/,l1d-misses/cpu=4,cpu=5/,inst_retired.any/cpu=8/,cycles" -a sleep 0.1

   Performance counter stats for 'system wide':

  CPU0              682,860      instructions/cpu=0/              #    0.27  insn per cycle
  CPU4               53,774      l1d-misses
  CPU5               18,725      l1d-misses
  CPU8              608,698      inst_retired.any/cpu=8/
  CPU0            2,574,325      cycles
  CPU4            4,267,115      cycles
  CPU5            1,741,536      cycles
  CPU8            1,969,547      cycles

         0.102746958 seconds time elapsed

v2: lore.kernel.org/20250327225651.642965-1-ctshao@google.com
  - Fixes for `hwmon` and `--hybrid-merge`.
  - Add a test for event uniquifying.

v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com

2.49.0.1045.g170613ef41-goog

