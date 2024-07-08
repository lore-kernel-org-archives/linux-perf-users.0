Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69613212D
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jul 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451322; cv=none; b=Oq7y5ZHOJhA4W7nDVe9W/Z7bxber01gnn7w5mVhLnPXGVrg3RxcXJn7uXUr3b7y5LfyDCrOzrz27BHF8E2JNQWw019VxCg5KiXDUNAZwLRbCLohQpnl/38qWqayuyfwm4eWR3NplkhUR5asjX9YfkbP+Lg+S7p85uRhX826QnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451322; c=relaxed/simple;
	bh=ec9DRnZ6AXHntMvIKjk9tqd+ROrj/W7AUqVrHVmtpL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBK1A8p+xFat6dQstt8Gut/PNwmKB9PNHM6bfyFBLMfxwcm6M08/CjuKB7IQw47146pD5l8/YoKzl5tJ76HAXxSXnNFPmcLiB3gRvh/Q1l6uSnf/r1lBvgkcuxZCmz1PyIM3LZdFs61SK7VxOD5VG8FmleoummLLkT1yUc9sR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H56G5tDh; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H56G5tDh"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375fc24a746so640745ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jul 2024 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720451319; x=1721056119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlR/ZxnAxJSn5Q8IXWJoT32s9sznE6MlqMAy3EMPwdA=;
        b=H56G5tDhpCtPKYKT6xt30hn6La8ke4fdfznTvuPUF/yPm9UyESnhif+XtPuHnsEQIL
         m/k0QlZugnpBJZlGsKwUrLzVUdKzzqWwZu7BasCctz7PttgSsOOzPALwdJL/pEvYVfxR
         VAxrPYxeBQTf4jeQgGw7SnJ29c6VWDu+hwwvtytofA/S4d3xIIQjN8rUMhkn0aHkhiNX
         g45hnDQDTOX7hj6SP2LjQ6xAmwrUVcxo/2ArN06/kgd8iZJnrbE0/A/Jm18AwP5AjMba
         k1tij0H5wCJhW/Iu7lx0q9Kao9BuhWK/54nUrqxvmMQkNx4wvSVoHXi528s+x4acbocg
         nurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451319; x=1721056119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlR/ZxnAxJSn5Q8IXWJoT32s9sznE6MlqMAy3EMPwdA=;
        b=RrpBeCG7JZDeIHPW0TK0cNQBZtsTnu7e6eXz0D7W5GoLGdGF2+bOjLcdrnAwQpypur
         GYNpdAWiDSELw7jUFVI98G+JtlXk7+6/vEs26LtkCYKFohPylBTCSJP7EdslKQQXbFp9
         LZwWZzoKaHE392D/ROysZy7KUT9vOgViYaqt9Sp57MydkeJ73N7XcAuRqICYkDR7KceB
         2KKKMtE4dqe6Y1FkAZzEWYi2CpjaqaCzc9iOHxL4tJHwq8b0lyPguy9m/5vuL4zAf8Kk
         +owjrQdFbJofG6KP/cSRhQrnPfbwU/FO7DxvJfrVZvS1aP9J1dvQTu3w9BQVxVepnGb/
         Qa/A==
X-Forwarded-Encrypted: i=1; AJvYcCV+EQKL/qbUULM8AQAeYBqo0/33fk0SIWwH+1HC5Bpdr0At+OjFtE9D7b+7ApbiXLHFYImMz7Kqrhh/OQbsrS4k7Dd9EmKI2yTVRJztCh4eDQ==
X-Gm-Message-State: AOJu0YzWYCGInx2RuyQzP9Ei5/CCzJn4wSxqccDJScGUtMEPBx2NF4Tx
	mmhRGn6PZegmNI8xoPvnXkhKoE1JbOdOuZY1F8/rXvX7XeqoMZFAEXpByUg5g6jLcHjB3KuQ4Dp
	wTKSLLfPICUs1I8v85i+hbTk0UuWhffKL8rJB
X-Google-Smtp-Source: AGHT+IEzzZTS/j4gIIRy4epGbvww/dDzSNB0viSxystMhI0SyTqP23bqtsSRmtrJSmUZwz6t499tlZ7K6BFAoZ9q/6E=
X-Received: by 2002:a92:c24e:0:b0:375:d859:59cf with SMTP id
 e9e14a558f8ab-3834ebc274emr9943265ab.14.1720451318710; Mon, 08 Jul 2024
 08:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com> <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jul 2024 08:08:26 -0700
Message-ID: <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
Subject: Re: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics
 events when sorting events
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:40=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> when running below perf command, we say error is reported.
>
> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1
>
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x400 (slots)
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x8000 (topdown-retiring)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   freq                             1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> sys_perf_event_open failed, error -22
>
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for=
 event (topdown-retiring).
>
> The reason of error is that the events are regrouped and
> topdown-retiring event is moved to closely after the slots event and
> topdown-retiring event needs to do the sampling, but Intel PMU driver
> doesn't support to sample topdown metrics events.
>
> For topdown metrics events, it just requires to be in a group which has
> slots event as leader. It doesn't require topdown metrics event must be
> closely after slots event. Thus it's a overkill to move topdown metrics
> event closely after slots event in events regrouping and furtherly cause
> the above issue.
>
> Thus delete the code that moving topdown metrics events to fix the
> issue.

I think this is wrong. The topdown events may not be in a group, such
cases can come from metrics due to grouping constraints, and so they
must be sorted together so that they may be gathered into a group to
avoid the perf event opens failing for ungrouped topdown events. I'm
not understanding what these patches are trying to do, if you want to
prioritize the event for leader sampling why not modify it to compare
first?

Thanks,
Ian

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index 332e8907f43e..6046981d61cf 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const st=
ruct evsel *rhs)
>                         return -1;
>                 if (arch_is_topdown_slots(rhs))
>                         return 1;
> -               /* Followed by topdown events. */
> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metr=
ics(rhs))
> -                       return -1;
> -               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metr=
ics(rhs))
> -                       return 1;
>         }
>
>         /* Default ordering by insertion index. */
> --
> 2.40.1
>
