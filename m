Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A784D03
	for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583966; cv=none; b=jWQo80+ywitT+Sd8KHZTRboXOfcwmgxnlDqwu4ouuhzc7Gn4MSLJcMKjmHudG5e3fZaS9z7zBXzlUQekGyNwco9nXxrUeWb6u5p0GbtpLHI9960angSvLIK4ObARMZ17gj1+Yl5LLEJkPAB8q4RwfxbmtLqzDUW3Lf+jCaAK0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583966; c=relaxed/simple;
	bh=gCgxAKw5lQYNU12HmtYzfHgtWOefJwUEBWIEDW28LCc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=qV9RWwL1Gm6qb9yUAutpkHoQ3oqBqqN/IAzs/jedt3vLLoNfsdfmjfY10/NBFwHJaCMoU80PTVnvxooD7+WrfkTDa0G/YYYLH4x9BLyTLZEgVm5GYz++wvuehQnUHBjtapkVewWo/xCZfzsG2yVXxt8METVaiCyTUUqdfklTxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAD9ktp2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAD9ktp2"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a0827391aso12357147b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716583964; x=1717188764; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xB50v1xJEh4tZDBD3Dhd7HLyGrQgpvbCGS3Q7EGX/w0=;
        b=IAD9ktp2pieAZMNUGmOtQX3oXWD5IaYbozVDgCDR4L2qY31pg3y7mj8OKm0UWlQiNF
         uAJU9qpd42U9x+rPC+uqRQVtCPi9SZ40lBwCzTdut6hLlsacYTk4RXNb1e+w4MyyXCcs
         BH24q8Xr51jbo7gv97WSI5n6QNus/U4yz1MFnDksAEPQZh8tHwKQ7oFJlboyHbKL0or4
         1Cv03DzzjwuRmTZ2KYReD8CVxxEuq6i7jRtOtTeot/uvxbaFq3n3xcBsjJK4pzNng4wo
         ppdWnB3Z52lxOJz89n++LZDR+h5qklOU3gHYPCIoUWDcyUIsl9DS7yQGgfbuV7hr2Vis
         bd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716583964; x=1717188764;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB50v1xJEh4tZDBD3Dhd7HLyGrQgpvbCGS3Q7EGX/w0=;
        b=w1q73Dvh+t2Vcs/xvFqeYSBAfJEARh49Xb3ZaFnPOJd4Kus1UpldGMkEJqdS6Zsz+1
         dmCzT/TmF2H4qVhehNl1lLr2R7SKhiucbk2wpE/3I2UQfBUjOQNdz3PANYJgxKfd54Yu
         txqGM0eHTOALDG4rS9eJHiXvVwlVDMGDxU88VcKLfikxDXnmcRJl0lI1Setx9jBT3v/T
         yFvMRWFiA+Vit8JX2v72oxaMQY7Ge5C0UOc2w0R71qCdJo+PtI3tUTxlxZ66N6W3w8Je
         OOx0iu2G7uza40UrzxY9cXP0Oo2gKdZ/AhBRBLlCYrp99EInjJ6s6XzGr1PQf5ieVyqV
         /RWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5t8IKAiUFWrYpAoxJXb6+eBvx7mED/UjxawNRSmfHrHUF7MU32P4ZGnzPEhsPpCCfxRNQctcDYNrTlHluXbHxLOM2YWikP6iO0T/Q+BO5ww==
X-Gm-Message-State: AOJu0YyTYozBIwPIjxhF1t4ptpkHGzHCesX9m9OnVXPT+oZVF3/7WGol
	7sVpUqE1mOmZHI11ngLyeixcHFy3SL7+7RMVVOL+kYwhCzPqQicBoxkZnB627P07fJi5TwsFPvs
	EodCb/w==
X-Google-Smtp-Source: AGHT+IEAyhX5lsFIRyG3c890XY9BUv/ot0WWIvwVB5kr3LpZpWAHUbdUSqtGYIOLdsbz8z3ovR5rl4gVgJvi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b0b5:95af:a29:375e])
 (user=irogers job=sendgmr) by 2002:a05:690c:6a06:b0:627:de4d:81b8 with SMTP
 id 00721157ae682-62a08f75ed8mr7726067b3.7.1716583964450; Fri, 24 May 2024
 13:52:44 -0700 (PDT)
Date: Fri, 24 May 2024 13:52:24 -0700
Message-Id: <20240524205227.244375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v3 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

v3. Move PERF_SAMPLE_xx asserts to sample_filter.bpf.c to avoid
    conflicting definitions between vmlinux.h and perf_event.h as
    reported by Namhyung.
v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
    using a shift as requested by Namhyung.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 33 +++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 +++++++++---------
 tools/perf/util/bpf-filter.y                 |  7 +-
 tools/perf/util/bpf_skel/sample-filter.h     | 40 ++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 73 +++++++++++++++-----
 9 files changed, 169 insertions(+), 70 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog

