Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE051F2378;
	Fri, 31 Jan 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349102; cv=none; b=ntNQg/PViEAfE1XElJwkRQeqS+iSmXnBOSqPA6KDNf7YnghSkqqN2cXd5VWkN3BJ5qsIsRyw/pl872EXEW5QmsCOTfQIe1TOQ5NHN4w5hAQVMqSFc8GHwS4lBApUgnE90KuE0fMbw0L4mHr7kffwpBrE/mwbTj7bLQuQbPBKe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349102; c=relaxed/simple;
	bh=cQsC6tDl5EQr2iuL6pyC4jq/l/V08Im/xS6qGQAz6kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pibyhd499EU8JsJkc5N97+4ddvoL6b43I9FFQLXvhOZxaRN59Z8+DG7r5i5wAwHK/cIDqz3/4jm6XyTxcoPpHHAi3r2qTUFxftkkLZen43RiElMFFMKe4e1H2qKLIDoXklSDFT3RUZ4m6xjuUH4YlWoAOTIsZZ+IvnDRca059nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPi6Mhyv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPi6Mhyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D32BC4CED3;
	Fri, 31 Jan 2025 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738349101;
	bh=cQsC6tDl5EQr2iuL6pyC4jq/l/V08Im/xS6qGQAz6kw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IPi6Mhyv4NH0h4lAdw6pt05foXsn454u6RrjOOLwMBUPzBLm97mmoOpTImwTvyxHH
	 gEAsh+dkp4mK7szoOtGETrQ0ho7pZu9qzvfyhLQtyXelCKGsV9asyCBD5BYdsTwKmn
	 fQdKoYE9DJI2XgpZoeRF70XKIDVR93FMlYfjhGT4M29iO8aO7w0/hoPG3wltDiHgcX
	 +kqVKCWF5gi/EEXtJV6w4qowqCmBetWIf/dkmmenzDA8AFQFn5m5S05qsgJp8o0NwE
	 swV+85z9V5SVXKo9GNZBT+fRKq+zSwarctpwpXb/qWb33bDQ34noQuTsOz3OK6kZXQ
	 qLbTkSJrqsbFA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc149e14fcso4224004a12.2;
        Fri, 31 Jan 2025 10:45:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ1NDlo3pO1vcYmJvvR0CMVFmZ8iEkW3qchMRXWX6zXznlJQUDbK3xqf1xb6iy5rYn4GsN5O85l4GmQLU=@vger.kernel.org, AJvYcCW/DsdsjjZxT3xtcmnr2Vq/FYjAZWrvmbYn5JLNJshsrD2hB9jtKdSxECmMhdSE/TC/l7KzG0r8tEmvPfvlrCQNzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7v/VgT4/KPJd+0KJtGR05ratYamQqAln9BuxRXHRSDwSDTAxD
	c0SsR84nX6m9wSZWHKA0W4dGcdI1qnv185Md4e5DUpCQyM8JVhuhMKUAjcVV5eUuyFehdLeZTtf
	Po44aYMuZ1en5LOk3ZdTvMKQbxw==
X-Google-Smtp-Source: AGHT+IFHF8MfBt9NpoLVUs6BNYyid6J7PvublAYTpghRTlfvjimuwnxup2PdE3Y6lfcYsRdhtBtZRLY2su2c8B2OK/Q=
X-Received: by 2002:a05:6402:a001:b0:5dc:88dd:38aa with SMTP id
 4fb4d7f45d1cf-5dc88dd39aemr1762094a12.8.1738349099936; Fri, 31 Jan 2025
 10:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106120156.227273-1-mark.barnett@arm.com> <20250106120156.227273-2-mark.barnett@arm.com>
In-Reply-To: <20250106120156.227273-2-mark.barnett@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 31 Jan 2025 12:44:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++8-yadgbyTvNZkhML-j73UP6VS+qiaD3gQB=rc=w08w@mail.gmail.com>
X-Gm-Features: AWEUYZmBnZzun44g7IbcJejw8mJzjjTZvTzP9yBPr9jEvMFNoL0zPdGjRLwkLYo
Message-ID: <CAL_Jsq++8-yadgbyTvNZkhML-j73UP6VS+qiaD3gQB=rc=w08w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] perf: Allow periodic events to alternate between
 two sample periods
To: mark.barnett@arm.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com, 
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org, 
	james.clark@arm.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 6:12=E2=80=AFAM <mark.barnett@arm.com> wrote:
>
> From: Ben Gainey <ben.gainey@arm.com>
>
> This change modifies perf_event_attr to add a second, alternative
> sample period field, and modifies the core perf overflow handling
> such that when specified an event will alternate between two sample
> periods.
>
> Currently, perf does not provide a  mechanism for decoupling the period
> over which counters are counted from the period between samples. This is
> problematic for building a tool to measure per-function metrics derived
> from a sampled counter group. Ideally such a tool wants a very small
> sample window in order to correctly attribute the metrics to a given
> function, but prefers a larger sample period that provides representative
> coverage without excessive probe effect, triggering throttling, or
> generating excessive amounts of data.
>
> By alternating between a long and short sample_period and subsequently
> discarding the long samples, tools may decouple the period between
> samples that the tool cares about from the window of time over which
> interesting counts are collected.
>
> It is expected that typically tools would use this feature with the
> cycles or instructions events as an approximation for time, but no
> restrictions are applied to which events this can be applied to.
>
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> Signed-off-by: Mark Barnett <mark.barnett@arm.com>
> ---
>  include/linux/perf_event.h      |  5 +++++
>  include/uapi/linux/perf_event.h |  3 +++
>  kernel/events/core.c            | 37 ++++++++++++++++++++++++++++++++-
>  3 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index cb99ec8c9e96..cbb332f4e19c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -276,6 +276,11 @@ struct hw_perf_event {
>          */
>         u64                             freq_time_stamp;
>         u64                             freq_count_stamp;
> +
> +       /*
> +        * Indicates that the alternative sample period is used
> +        */
> +       bool                            using_alt_sample_period;

8 bytes more for a single bit of data. I think we can avoid it. More below.

>  #endif
>  };
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index 0524d541d4e3..499a8673df8e 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -379,6 +379,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6    120     /* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7    128     /* add: sig_data */
>  #define PERF_ATTR_SIZE_VER8    136     /* add: config3 */
> +#define PERF_ATTR_SIZE_VER9    144     /* add: alt_sample_period */
>
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -531,6 +532,8 @@ struct perf_event_attr {
>         __u64   sig_data;
>
>         __u64   config3; /* extension of config2 */
> +
> +       __u64   alt_sample_period;
>  };
>
>  /*
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..7e339d12363a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4178,6 +4178,8 @@ static void perf_adjust_period(struct perf_event *e=
vent, u64 nsec, u64 count, bo
>         s64 period, sample_period;
>         s64 delta;
>
> +       WARN_ON_ONCE(hwc->using_alt_sample_period);
> +
>         period =3D perf_calculate_period(event, nsec, count);
>
>         delta =3D (s64)(period - hwc->sample_period);
> @@ -9850,6 +9852,7 @@ static int __perf_event_overflow(struct perf_event =
*event,
>                                  int throttle, struct perf_sample_data *d=
ata,
>                                  struct pt_regs *regs)
>  {
> +       struct hw_perf_event *hwc =3D &event->hw;
>         int events =3D atomic_read(&event->event_limit);
>         int ret =3D 0;
>
> @@ -9869,6 +9872,18 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>             !bpf_overflow_handler(event, data, regs))
>                 goto out;
>
> +       /*
> +        * Swap the sample period to the alternative period
> +        */
> +       if (event->attr.alt_sample_period) {
> +               bool using_alt =3D hwc->using_alt_sample_period;
> +               u64 sample_period =3D (using_alt ? event->attr.sample_per=
iod
> +                                              : event->attr.alt_sample_p=
eriod);
> +
> +               hwc->sample_period =3D sample_period;
> +               hwc->using_alt_sample_period =3D !using_alt;
> +       }

Wouldn't something like this avoid the need for using_alt_sample_period:

if (event->attr.alt_sample_period) {
  if (hwc->sample_period =3D=3D event->attr.sample_period)
    hwc->sample_period =3D event->attr.alt_sample_period;
  else
    hwc->sample_period =3D event->attr.sample_period;
}

Rob
