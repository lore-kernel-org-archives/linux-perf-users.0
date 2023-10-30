Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018BD529
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBuA4MPI"
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD04D9
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 12:05:02 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5845213c583so2814632eaf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698692702; x=1699297502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPq41GL4yH6DVVO3wMu/zZLhUfAE1z9hLgfWVkoLlNs=;
        b=SBuA4MPIC+VmsWdMbFrHFWFYvQG2YSpgukSbcdnjxa1s9GgWLURxhYThIqePSGVv9j
         dglNiKyOxHRMgJmMLWe3JmRu00SwZjhhk0j+GsGt3oSFfZqiKI01JxfSTWK96BuQaOEW
         +FkpU1NNbPSoXGM9WYqvWsGc86hZlv/S7w21ofiryV/ia3ZMSI43RlHq5Dk3APoJF2om
         Z5F1e+yOq/IotfqxMGIl2sI+y8bozTLSZeuKWELcJl6uXkGoPORbWIgMWI0Xy6idCCRS
         ReXfqylqGm1BlvkhlDwNb15Kxes3lHu4WHAHND4wIidxJqqc82kUW3rmKSYTJapRP1Zu
         1xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692702; x=1699297502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPq41GL4yH6DVVO3wMu/zZLhUfAE1z9hLgfWVkoLlNs=;
        b=AuUoVWB9hvMnExcKf+qfaHx2pb7S/GlsLzmgL4/7MYhBuXl7fFNsbwzGuw15slarAk
         fxNoPj5+AcGpg2QlBxrZ7YaXga8MT44og0CKJhrfN/dN2MZCT7g8zbVBBMe4ew45ZQuv
         sVth87fIRdxRmZ2rQV4qWDLvwu7byRrLQ9TEo5/E4JB6Cy6hXxhE4Y1yxg1yAztDof1h
         0vWt9oNQquYJjuHeAW+68PShv8HoXJvfABzZNxWLKncSTrHFrvVX6nvQ3LiUdlVtQA/2
         vSMzIE3pPPD81aQ1WudSpMJUEubGjur4jvfKKv6ztCAEfuvItGN0I7GDcMJUGaR6j3bI
         ktcQ==
X-Gm-Message-State: AOJu0YyVvjSK67o77h3kcft347KII3sjhY/7aoZyy+4575xn4kVDzpc+
	0FoJ4mhnOCiVqn8ST+6BMj9n2HYqzqHg5mCxAeyQ6g==
X-Google-Smtp-Source: AGHT+IFsF7GqdgYXY2P2iN82D2guup+g5HfwABWPWMbalVAfnCysMxt6anEr2vTjqBXJrvNRJCNdKiING312ShE+3CE=
X-Received: by 2002:a05:6358:c381:b0:168:d12b:a166 with SMTP id
 fl1-20020a056358c38100b00168d12ba166mr10044450rwb.17.1698692701743; Mon, 30
 Oct 2023 12:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com>
In-Reply-To: <20230916040915.1075620-1-irogers@google.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Mon, 30 Oct 2023 12:04:25 -0700
Message-ID: <CAL715WLq+wMGC26ESviAwSFGCpCYbf8knRFo=6Lbwgk8qwB8xA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To: gregkh@linuxfoundation.org
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>, 
	Stephane Eranian <eranian@google.com>, stable@vger.linux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Dummy events are created with an attribute where the period and freq
> are zero. evsel__config will then see the uninitialized values and
> initialize them in evsel__default_freq_period. As fequency mode is
> used by default the dummy event would be set to use frequency
> mode. However, this has no effect on the dummy event but does cause
> unnecessary timers/interrupts. Avoid this overhead by setting the
> period to 1 for dummy events.
>
> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 and
> period=3D1. This isn't necessary after this change and so the setting is
> removed.
>
> From Stephane:
>
> The dummy event is not counting anything. It is used to collect mmap
> records and avoid a race condition during the synthesize mmap phase of
> perf record. As such, it should not cause any overhead during active
> profiling. Yet, it did. Because of a bug the dummy event was
> programmed as a sampling event in frequency mode. Events in that mode
> incur more kernel overheads because on timer tick, the kernel has to
> look at the number of samples for each event and potentially adjust
> the sampling period to achieve the desired frequency. The dummy event
> was therefore adding a frequency event to task and ctx contexts we may
> otherwise not have any, e.g., perf record -a -e
> cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> non-zero, then the kernel will loop over ALL the events of the context
> looking for frequency mode ones. In doing, so it locks the context,
> and enable/disable the PMU of each hw event. If all the events of the
> context are in period mode, the kernel will have to traverse the list for
> nothing incurring overhead. The overhead is multiplied by a very large
> factor when this happens in a guest kernel. There is no need for the
> dummy event to be in frequency mode, it does not count anything and
> therefore should not cause extra overhead for no reason.
>
> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy const=
ructor")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evlist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 25c3ebe2c2f5..e36da58522ef 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlis=
t *evlist)
>                 .type   =3D PERF_TYPE_SOFTWARE,
>                 .config =3D PERF_COUNT_SW_DUMMY,
>                 .size   =3D sizeof(attr), /* to capture ABI version */
> +               /* Avoid frequency mode for dummy events to avoid associa=
ted timers. */
> +               .freq =3D 0,
> +               .sample_period =3D 1,
>         };
>
>         return evsel__new_idx(&attr, evlist->core.nr_entries);
> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *ev=
list, bool system_wide)
>         evsel->core.attr.exclude_kernel =3D 1;
>         evsel->core.attr.exclude_guest =3D 1;
>         evsel->core.attr.exclude_hv =3D 1;
> -       evsel->core.attr.freq =3D 0;
> -       evsel->core.attr.sample_period =3D 1;
>         evsel->core.system_wide =3D system_wide;
>         evsel->no_aux_samples =3D true;
>         evsel->name =3D strdup("dummy:u");
> --
> 2.42.0.459.ge4e396fd5e-goog
>

Hi Greg,

This patch is a critical performance fix for perf and vPMU. Can you
help us dispatch the commit to all stable kernel versions?

Appreciate your help. Thanks.
-Mingwei
