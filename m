Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9C2566F7
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211551; cv=none; b=srpoUXGvY6PwHvQ7G3crO8ylollaFlEVy/VzfrjumXPq7KxVqxf33xftv66PFm8AwkL13vW8AHYpJ/x4nEnscoc8aTd8Y4zRzqBN4+hO3nzbRz8KuKrORisYGM2EqA4602FUco4pGRPNgDklGJDlhYiRhNpOfa1OOHa+4gRkoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211551; c=relaxed/simple;
	bh=V8w670mAfywvY80iWDaOWwhJjVFhg9fLqTvGMmPdjbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DIfXKJlaRh19Fe+tqTzhSnUCboiVVC8Um3wRDd5fLLoOlVcImwOfzMkVnsg2P4ew2AHpEObGzU/PcKhyTUAocB2KP+9EME/YXialEUmuAZJynappdUgCHKdzczi9TJzHyjaCpXw9DlqxRO+ZITO2MopcW2l2y3ZvcfmiopqjZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUkpnlOC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUkpnlOC"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d146357fb2so3605ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739211549; x=1739816349; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sMdT0NOuuWVhnkOu/gKigGyptSOEeKnR8OjvwL+j48=;
        b=TUkpnlOCXGVuvuoMq+xSSbxlOLj+BAVItajon2L+WgeWFX0nGWvHA/OSXaH6KBiRjp
         +ga2hP4VvMjVf9EmQ84XEN6Ti7pGQWEnmr09r+6gxRQ37kb3wTA8k7d3Gk28aNogpQMf
         wfDI5m5LrCcyDmYRn2PHjkCTrGN7nRemWKNRy5Ycf9dkPgPvyEg67EwmH8YcEKgfUHRX
         51OpaL8JamSkuj7sLjMtqVxFpwjzZ5ydzYE0oJDqqjB7+ZVKV5BDQFR7yRSjqFKF6d0P
         bMvy//uS1xrbmagfVukwJwEWHIDsq7iybUwEHaP+KJjoW0C3+LTZ6H/EhWYD0eO+UV+g
         c7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211549; x=1739816349;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sMdT0NOuuWVhnkOu/gKigGyptSOEeKnR8OjvwL+j48=;
        b=jDcw9HarN8TxmHGiXGtFYA/CKRFOIJPrykeiQoZP0R7kjKErgTZP1IKKYQ3krdQ09+
         KLQ+NLOm8TKQC3FLTaUU4mkVE5ZtEz7ml9P035M6Xm51wgdiGvl/li22ZOlT+KVY7YFc
         vGPNe9JP9OTBiupGfmoO9sfdUjQbwwiKAGh1OC1pKwWODkIrzlODat35vwTHJm4D88XN
         AzGUuzLN1xsVGow/U5hoaSei1h6fCh5K5qKVX96goe/kGQjEESUTmzaVTznOWDuvfz8t
         NxtNVuJ132o98xisxDzKgjgc5z3m0o3unPBLGX/iLffufK9rsyDjxytENDnzK0dS6iIT
         MhCg==
X-Forwarded-Encrypted: i=1; AJvYcCV+C+qqSajYnVz19c9RzDc3xYIhwY6VgYZUrk0d1zfKalJF8AgybmAxZHLp9Gx/yB0klcYfekcGS9L4VdYDSLWO@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKm2iYyRgviLc43CE8Lbwml00ctDGjLxNm/0gmDHW90YtMs+a
	k8GsPylAuWDUiHbuyT2ovodYY8FJymngy1ig/bsS4UkAmJU0t1usJ3zJoBiXp/MQsczYsv9idmX
	8LG+FVck+WWpj1HXeptu+OynaINhLpp+1S4Mm
X-Gm-Gg: ASbGncuVaeVH9k1T14wnh6kN8rjs/kfawHGgswzN/qybF+ZFdHHgcCsu/DOjojhcYyL
	iGmBrw0SJdX81qYWLDKv/rv93PNvIKesO8eUrJTAcjNLpgJJyNAdU88feCht29BoUl2cjjPO41Y
	Brco728SzXETJ0iohZl81aAvvI
X-Google-Smtp-Source: AGHT+IGpznAZrivBH2hdCHpBdnGOPhKQMLngzUuWqC/ahVWQ75hTN9Z1ZqfesgkfM3nc+Y6zu4kxmzfq8A8Bo9zOwGo=
X-Received: by 2002:a05:6e02:16c5:b0:3d0:5855:85a3 with SMTP id
 e9e14a558f8ab-3d14cc6576bmr6788495ab.8.1739211548863; Mon, 10 Feb 2025
 10:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com>
In-Reply-To: <20250111190143.1029906-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 10:18:56 -0800
X-Gm-Features: AWEUYZnoUb57cYIMl1CkEykd9ZMpycyCdZOdhHQMfLU_3xnpe08EqINt_HHw754
Message-ID: <CAP-5=fUcj9JFtfoTtZFcQJZ_oRA-hLKAzOerSM0rT7at=sRUTg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 11:01=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. Add a
> helper for commands that support UID filtering and wire up. Remove the
> non-BPF UID filtering support.
>
> Ian Rogers (10):
>   perf bench evlist-open-close: Reduce scope of 2 variables
>   perf parse-events filter: Use evsel__find_pmu
>   perf target: Separate parse_uid into its own function
>   perf parse-events: Add parse_uid_filter helper
>   perf record: Switch user option to use BPF filter
>   perf top: Switch user option to use BPF filter
>   perf trace: Switch user option to use BPF filter
>   perf bench evlist-open-close: Switch user option to use BPF filter
>   perf target: Remove uid from target
>   perf thread_map: Remove uid options
>
>  tools/perf/bench/evlist-open-close.c        | 76 ++++++++++++---------
>  tools/perf/builtin-ftrace.c                 |  1 -
>  tools/perf/builtin-kvm.c                    |  2 -
>  tools/perf/builtin-record.c                 | 26 +++----
>  tools/perf/builtin-stat.c                   |  4 +-
>  tools/perf/builtin-top.c                    | 22 +++---
>  tools/perf/builtin-trace.c                  | 25 ++++---
>  tools/perf/tests/backward-ring-buffer.c     |  1 -
>  tools/perf/tests/event-times.c              |  8 +--
>  tools/perf/tests/keep-tracking.c            |  2 +-
>  tools/perf/tests/mmap-basic.c               |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
>  tools/perf/tests/openat-syscall.c           |  2 +-
>  tools/perf/tests/perf-record.c              |  1 -
>  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
>  tools/perf/tests/switch-tracking.c          |  2 +-
>  tools/perf/tests/task-exit.c                |  1 -
>  tools/perf/tests/thread-map.c               |  2 +-
>  tools/perf/util/bpf-filter.c                |  2 +-
>  tools/perf/util/evlist.c                    |  3 +-
>  tools/perf/util/parse-events.c              | 25 ++++---
>  tools/perf/util/parse-events.h              |  1 +
>  tools/perf/util/python.c                    | 10 +--
>  tools/perf/util/target.c                    | 54 ++-------------
>  tools/perf/util/target.h                    | 15 +---
>  tools/perf/util/thread_map.c                | 32 +--------
>  tools/perf/util/thread_map.h                |  6 +-
>  tools/perf/util/top.c                       |  4 +-
>  tools/perf/util/top.h                       |  1 +
>  30 files changed, 135 insertions(+), 200 deletions(-)

Ping. Always nice to see code being removed and the BPF based uid
filtering functionality is superior.

Thanks,
Ian
