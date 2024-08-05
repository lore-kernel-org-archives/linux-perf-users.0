Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7AD16D9DC
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887084; cv=none; b=tuIXKnIVchMhG4e4zeXQV7MuJfXpRERGARmJ4gQRbvm1ZHg9X7o9k1AFNyY9VihfrDmuJ2M83Wzc9SzETJrljcnH6TXrvsSD8a8IbiBLXlu6nhSB+PTV3oQUDiFbIi2DRMKjMnkNlpYGB8zxh7sG7CkpkimuFTCUQW9/ymKtmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887084; c=relaxed/simple;
	bh=47x+zuJibezmnOmJ+88o3fpNTUvPozFiKDvbszlNEEc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VWLA46XUQOc+L2HG+IDsxbU5giznrQeVhhhjlZJyxo0grGJonxryBWsSNNJ80yvjovsehleBjBrG0lPLHB1GvpoXL5FOd22SxyeUbpcJagQkHKFWh68IN/fS/YSnjMMIzUNawxxxZZczcg1hRcCLC6nTtGaxvekFIsOCF5HWHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwhMx3X9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwhMx3X9"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bb206570aso12019679276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887081; x=1723491881; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGlP+W+E1rzo+Hc23sUegbyHJcwAQCTmYUNWikKKi2I=;
        b=MwhMx3X9BHKv+b6DHrgOMx/dsmbHtZUtrrN5x9iHNpqfYh3iZwgpog2bj4HzFnjUSH
         +gqv+fUxI/x6xCoPcdJMp4w0XFjnEvws6JtvRNIfPwEdqW73+kVCtEgySd+mFyfbSUF9
         rsTw7W85xBR2MGTNcVi161DGRjuWayE0xXuBas0bykoemCYvC/Qf6voWJ5WUJJX7BQVR
         rUxlF383Xs9YAx6xbuQr8QQUtHeV6QsdWrSeA3OeZCJUvE/1rjoogVJF+lTQ3rDIOFrw
         rlb6yddSFE0O+CwMoGKgHmsIttS3WvmOlejpbOsfwmciFybuBlDf2lcyMCMiWdpfAKZP
         +X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887081; x=1723491881;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGlP+W+E1rzo+Hc23sUegbyHJcwAQCTmYUNWikKKi2I=;
        b=gJAsJbl9cawqQ6chTXAwu5cNM+W15nyO4v17DAGSaAoK0pur0cEzSW4aagJ3RFUKRQ
         YXig4C6LYpnpP16owL2HaS8Cq2vTsbHcfnXYwr8mmbNZ4V6I38NvSrgKFRXgKrfHewv4
         gxW9noazoe1mSGQ8JDYKbcFDzXWsYVShEOiWqhwvvm8aKo1+4ZJzZnIBTSwkiOUAQWNJ
         yLkDCfAa5EfGutcNi1tvEzYLOaBbwTyb9+IQ82+3ROc7fafmjE/XkcDuJhxjgFktytB1
         u2fGcCLA9g3voeTmWJfQIBX5cqQkjXzX8KHAYOqFRkr9FsCW6t+g9BEErWhlRK/PtJ8u
         n2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJqUqE4d89utAKMBj4WJ3OclmkROH2gno0HLVsX5a36mxbDCjelk5bsDRwsGwMe5GDUtpTd3NjPebqNCIwc1daC9q7odbVTL4kqDeZ0cYssA==
X-Gm-Message-State: AOJu0YwyFjTW12aunlZiS/E6cSSkqOJzYYkBybuDCVhh8Bt2hjaNPU1k
	UUhTPwecYBsQwj83IWJ2aagh7rWEUQak9tqJVV6I4J7sFG9DbZDH7w9LQemt31UZofCxu6tKuEp
	C2z/oJA==
X-Google-Smtp-Source: AGHT+IE+AeucgMIyAO3Z0FES/ae0JgHq8LbXGHTnVeU3bAh9HD4a6vZXuMVuSJRiYYFv5skWk5Mgq+Gnxr3N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:6902:705:b0:e0e:3f14:c29d with SMTP id
 3f1490d57ef6-e0e3f14cae8mr166124276.4.1722887081584; Mon, 05 Aug 2024
 12:44:41 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:24 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 5/5] perf jevents.py: Ensure event names aren't duplicated
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

Duplicate event names break invariants in perf list. Assert that an
event name isn't duplicated so that broken json won't build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fcf0158438b5..1d96b2204e52 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -503,8 +503,11 @@ def print_pending_events() -> None:
 
   first = True
   last_pmu = None
+  last_name = None
   pmus = set()
   for event in sorted(_pending_events, key=event_cmp_key):
+    if last_pmu and last_pmu == event.pmu:
+      assert event.name != last_name, f"Duplicate event: {last_pmu}/{last_name}/ in {_pending_events_tblname}"
     if event.pmu != last_pmu:
       if not first:
         _args.output_file.write('};\n')
@@ -516,6 +519,7 @@ def print_pending_events() -> None:
       pmus.add((event.pmu, pmu_name))
 
     _args.output_file.write(event.to_c_string(metric=False))
+    last_name = event.name
   _pending_events = []
 
   _args.output_file.write(f"""
-- 
2.46.0.rc2.264.g509ed76dc8-goog

