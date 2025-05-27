Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF52F5E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378376; cv=none; b=Oh7QB1ZlqU5EHTDW+8AuThtzn0/prZZRsukuCYLgf6nqVYHHWABmUvm51r520b+hmS7wC4hSrAyGzD80a+AHjWtBBLNYNBPKCl4Lnx/mb3S4HLsRf9HUVpedrmA199wg+f2D1MSwL1oANwElg3MaZc1UmCAot3PdReSERIA7nEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378376; c=relaxed/simple;
	bh=9K1qlOPi3Awpjhz2tRNBvB20u2JUlbfEpuK12EzVwtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FoJdzBrM3TaZgnRnF4As0J3xddSBvradvzjl7nq9Og4iTfOM9D8WwlXr7gzi2ati4MByOO7xutjGrEaM6/AQq1KqK6fqBQUv4Zbo5xE7fjW9Nd/+oo6IzeKrrtfI6Ycz0qgahRnl58PJEVJJ/OrITWxBHPAhVZITfApvGrRm6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOxnQWeC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOxnQWeC"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso15095ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748378374; x=1748983174; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxGFDwqRyg2W5WWt9JDFqQi7bJLxV0e0m6+5lkNnCUY=;
        b=tOxnQWeCCmb/9bEsZUP05MnZMLeNYM9Ok2N+QAhTxHPVviQN50ATJ5Lt5WaUEpty9H
         Gv/ZI5ZNjGLf/N4LPswky3ykKoRzrONV7p0TjjUtaUwu/9q6ZVKsoI5MVpLVSjIHeCDO
         6yNRW1SaTmPiGPM5KbQKl1YhV42CAsbDcsUHZykc6YNsubZFJWjXS6F0AcpZeNFWm3aC
         XA6ZZ/63S56zvb17aeTQar2+53Azl5ChBoW0lcHcT2zbG8Tewcm/1ksoUg6qUmMzrr6c
         N02lGG5J4rincUKY3VsMldjuAwoAKeX4y9L0nbltGwQDGmNyCcExYs/4yAp/wIKFEpZC
         +8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378374; x=1748983174;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxGFDwqRyg2W5WWt9JDFqQi7bJLxV0e0m6+5lkNnCUY=;
        b=BAwv+qcRoUMvEgehipqw6tLAFMps2vYZXB3I3C4cAiZ8qb2DD9iYkWWU97TmoBKnpn
         HH/Wsg1Shxz60tCWseqwYwBMJHZ8oxbdPzFoeUuseFys8pjf8+GAI5CTv33ZsxgEnRk0
         j69j5Ycw5AYAIunLmzewBRqlZzM4UESYKO8rK7qJDUGIVyNFXj7iT0XY3RA0PhCD9DEX
         MeYUIEKwZMreIaTmEcrBrgxkba23IRz+t3J2uAzpqPS4VCdJj2taJjZ5Zj9Q/xV2pufl
         4W0BNGO+Y/M/I4KYg65vq0HpsBqKUpW+IBGXRc1u+RNq25pSZ3rLISWK38ySPzpI2DiD
         dn9w==
X-Forwarded-Encrypted: i=1; AJvYcCWrkLthpHnxyBg+DK82edfN/fxqmfwwDloFqkfeh8AW3fuBxD5v3fSrYWFGiAYJ8Qh3IPC6gwgKqHMwNz7wDlI6@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJ29OUkHslbstQ+N7ofjmaCFfTw9LyWF0UyxTYlab2YJkAzqg
	BxTrQBu9ldONB3rdT0N4Efn7v65oXMPmIafeHg0T1fTRnysfpVF4IOLWu7/DcnMq7XOBF1l0kfr
	Grb8XzmfmnnOrL0/W5UugW54+EjDlNXSwcaygUgeq
X-Gm-Gg: ASbGncsmBwnvM20bIJRgIJcUQd38aSUm086AA9Yo4UTWtDW7UYzr7MlsAxx31peUzXk
	uOQ5V/KW0CkA9hn59uLH4dhIBwZgJ41GpbvciPfy7IGCYjeY0Uz8t3sJPPZemR2RibbTizd1V0n
	8KSLMilOU/LdWPscs87cnzE9lIyKGbp3QDHnZmVNvBbIabWJ/eueFpoNma32i4R5XhAeRMgG3W
X-Google-Smtp-Source: AGHT+IG2icH2Y/FDLmWBOJMI54v0jKh22yxG1sb2LsUiO/EZg2xwKxpSIbO/FXeBFPngtSOnKjNsvL6ErGsQKy9C7Zo=
X-Received: by 2002:a05:6e02:1a8d:b0:3da:7c33:5099 with SMTP id
 e9e14a558f8ab-3dd89c5208dmr132745ab.13.1748378373491; Tue, 27 May 2025
 13:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:39:21 -0700
X-Gm-Features: AX0GCFu0vMV0uYp2KCfFVMxr8EIjrtS4vYgJCyG4a9k0iDeW-4w_Y8OZKcn1IOE
Message-ID: <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. The
> /proc scanning also misses processes starting after the perf
> command. Add a helper for commands that support UID filtering and wire
> up. Remove the non-BPF UID filtering support given it doesn't work.
>
> v3: Add lengthier commit messages as requested by Arnaldo. Rebase on
>     tmp.perf-tools-next.
>
> v2: Add a perf record uid test (Namhyung) and force setting
>     system-wide for perf trace and perf record (Namhyung). Ensure the
>     uid filter isn't set on tracepoint evsels.
>
> v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers@google.=
com/

Ping. Thanks,
Ian

> Ian Rogers (10):
>   perf parse-events filter: Use evsel__find_pmu
>   perf target: Separate parse_uid into its own function
>   perf parse-events: Add parse_uid_filter helper
>   perf record: Switch user option to use BPF filter
>   perf tests record: Add basic uid filtering test
>   perf top: Switch user option to use BPF filter
>   perf trace: Switch user option to use BPF filter
>   perf bench evlist-open-close: Switch user option to use BPF filter
>   perf target: Remove uid from target
>   perf thread_map: Remove uid options
>
>  tools/perf/bench/evlist-open-close.c        | 36 ++++++++------
>  tools/perf/builtin-ftrace.c                 |  1 -
>  tools/perf/builtin-kvm.c                    |  2 -
>  tools/perf/builtin-record.c                 | 27 ++++++-----
>  tools/perf/builtin-stat.c                   |  4 +-
>  tools/perf/builtin-top.c                    | 22 +++++----
>  tools/perf/builtin-trace.c                  | 27 +++++++----
>  tools/perf/tests/backward-ring-buffer.c     |  1 -
>  tools/perf/tests/event-times.c              |  8 ++-
>  tools/perf/tests/keep-tracking.c            |  2 +-
>  tools/perf/tests/mmap-basic.c               |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c  |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c |  1 -
>  tools/perf/tests/openat-syscall.c           |  2 +-
>  tools/perf/tests/perf-record.c              |  1 -
>  tools/perf/tests/perf-time-to-tsc.c         |  2 +-
>  tools/perf/tests/shell/record.sh            | 26 ++++++++++
>  tools/perf/tests/switch-tracking.c          |  2 +-
>  tools/perf/tests/task-exit.c                |  1 -
>  tools/perf/tests/thread-map.c               |  2 +-
>  tools/perf/util/bpf-filter.c                |  2 +-
>  tools/perf/util/evlist.c                    |  3 +-
>  tools/perf/util/parse-events.c              | 33 ++++++++-----
>  tools/perf/util/parse-events.h              |  1 +
>  tools/perf/util/python.c                    | 10 ++--
>  tools/perf/util/target.c                    | 54 +++------------------
>  tools/perf/util/target.h                    | 15 ++----
>  tools/perf/util/thread_map.c                | 32 ++----------
>  tools/perf/util/thread_map.h                |  6 +--
>  tools/perf/util/top.c                       |  4 +-
>  tools/perf/util/top.h                       |  1 +
>  31 files changed, 150 insertions(+), 182 deletions(-)
>
> --
> 2.49.0.850.g28803427d3-goog
>
