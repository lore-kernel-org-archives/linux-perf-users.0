Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0A210C2F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101388; cv=none; b=VPhDKCmxx119ibPA817x/dwxnb9Zu4JX9limNYe3wKKsfmHLdvu0W7ZWeAKFu9jX2tw42mD4e96piKb7exA2N0ylT85AppUqrfLPM7PpB3zgiqGSxqlBVxnkib3/NaaCGiCJbXAADINh5bdKO85Qdo6mcuriWECFXQbOrdLVrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101388; c=relaxed/simple;
	bh=piauFAL/qW2FNLvKfXgzjcf/6G9VYkHCq89jP3STshc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=digiqL/Vzu+UZ2CNxl+OPL6AP50/RQSMEaO2ZaHLYx5ZhJh7edDrgZa/DZ7jW46S+cBuOMCO95Dd5avU7gUcGX8eZPkXEZyB0tvm/3VpyHM7CKNK/6g9f06yMvmElZ5z30FIDIhrKidna4Qkdxn00DXX+DGIeHoIskaGmBdNRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOUDqxWh; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOUDqxWh"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so17345ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101385; x=1729706185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZijI/f3RHan18jQfzeXNmjahkgCAozvnPv6RJUliFKg=;
        b=JOUDqxWhdZ72ooDYXUg4IpLEHRhC0U5G+WW/2d4et5VlmcJV65D7xq+7ONJ+EV863K
         M/ysnqZAVruyv+2d/SsejBCuMpguZR7XEdDplfXZzFzvJWAVIfsNx7ruMz+/dimiOQf5
         6BSapNBgfptgYcDcx0JlAeiPEPNf045t4mLgDbqrUAc/UxJRzBqOHJwXEfowpQFdw5oO
         0LXpBnki9YwUen2aUDvfJnm6ZaiZlpisq4Ylub7ePloJfZ+mP5ByFTmGX+0Bk1hQc8rD
         laapH9pj26RX+9CddN5VA+60a++aaDH2u4n7MSW9HwxukTLx7/YsQaUUXLUXjI3Yy4QA
         HU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101385; x=1729706185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZijI/f3RHan18jQfzeXNmjahkgCAozvnPv6RJUliFKg=;
        b=Kgr1giSUGvV2D549pAfxK4dvlzWXGbPSu39aRLT8xbMPjae8cmXIqWHmkMaMYIdHxr
         CglXUo2tFvfE4XGEMwb8cGMdmaaZM2UW2kYQOpAMGncmwLAphhcb/8j6zZAHiXQEY3wl
         evPs26tBV+g9SZeUY2EBxpNHYWWxlDtaNha3+7vsmPhUyXyj9txaJA3izL+JBkqK8aTq
         B2r5BmPuMRiAbbciw3q592mH195LFWMjFA3/lPozHzxUvYroJlBQQuQUnGlHmgYO0OLx
         XVk5rB2wRb4eOxidRUaYUMKmLTnsPz70p32LTv5c0ZLCFSguC1cq30Voqaf+N6sJAb8I
         mtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUivG6INtRH+RQd6VVI+vwiWHjz6HWfLqSeumMQJVALY7VGvSdj6mCWndQhqsvqNZJlQHGk2e9/55t9qtORxVHn@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFbVPtnj6alazDSC4cYwLaACF403k4yikFIqwJr0p4fHZqbrK
	rGtawZp1p+RkMQSYxIG8Ty7JU0mcMAfp0hLJsOQChADobPQtk51ry5hBW6xkOPjvVhq/hcNFChC
	xittW0gdwL1a0g+QNypvLYoUFWMIt9zTwXgmj
X-Google-Smtp-Source: AGHT+IG3d3tvhrFAWZmvm6eZDB5BE5kdFEC84mhB0nqm5YwsNGaW3l6BSf93ej6LnvgrMgJ2VTyeGaOSg9hkkMF3Kfw=
X-Received: by 2002:a05:6e02:156a:b0:3a0:91e7:67dc with SMTP id
 e9e14a558f8ab-3a3e58ef153mr160695ab.4.1729101385452; Wed, 16 Oct 2024
 10:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 10:56:14 -0700
Message-ID: <CAP-5=fX+cW3az37t43GAAvWuMj_FevcArA1-Pij4024Qi9z3oQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf x86/topdown: Make topdown metrics comparators be symmetric
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 1:04=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> The commit "3b5edc0421e2 (perf x86/topdown: Don't move topdown metric
>  events in group)" modifies topdown metrics comparator to move topdown
> metrics events which are not in same group with previous event. But it
> just modifies the 2nd comparator and causes the comparators become
> asymmetric.
>
> Thus modify the 1st topdown metrics comparator and make the two
> comparators be symmetric, and refine the comments as well.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evlist.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index 438e4639fa89..447a734e591c 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -52,7 +52,7 @@ int arch_evlist__cmp(const struct evsel *lhs, const str=
uct evsel *rhs)
>          *          3,015,058      cycles
>          *    <not supported>      topdown-retiring
>          *
> -        * if slots event and topdown metrics events are in two groups, t=
he group which
> +        * If slots event and topdown metrics events are in two groups, t=
he group which
>          * has topdown metrics events must contain only the topdown metri=
cs event,
>          * otherwise topdown metrics event can't be regrouped correctly a=
s well, e.g.
>          *
> @@ -69,13 +69,16 @@ int arch_evlist__cmp(const struct evsel *lhs, const s=
truct evsel *rhs)
>                         return -1;
>                 if (arch_is_topdown_slots(rhs))
>                         return 1;
> -               /* Followed by topdown events. */
> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metr=
ics(rhs))
> -                       return -1;
> +
>                 /*
> -                * Move topdown events forward only when topdown events
> -                * are not in same group with previous event.
> +                * Move topdown metrics events forward only when topdown =
metrics
> +                * events are not in same group with previous slots event=
. If
> +                * topdown metrics events are already in same group with =
slots
> +                * event, do nothing.
>                  */
> +               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metr=
ics(rhs) &&
> +                   lhs->core.leader !=3D rhs->core.leader)
> +                       return -1;
>                 if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metr=
ics(rhs) &&
>                     lhs->core.leader !=3D rhs->core.leader)
>                         return 1;
>
> base-commit: 57fb40d40f9543213ffadb04d07cfb2ba46edc26
> --
> 2.40.1
>
