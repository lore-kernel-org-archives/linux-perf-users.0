Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0179FB
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+QWvo22"
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B612A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 21:13:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so7751a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207192; x=1698811992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eCeunVYQFz26TpeFcqj1dGeFr6YLbG2VvecTD6jcmQ=;
        b=N+QWvo228ZvKaUY7aUTagS/joWSnX3nR4Lnl+b2bUZjbxw53o8GqZs7EF9QlQImPNR
         279qpHnDFitIBcbksEUuWcBTkIiRlYHhf4HMHREJ2fioh1TY/+HVpdJ5HjENlcKMxPAZ
         sZPPZCVIfGui0oDxGedbTG5sAvAMX0FUf75wCD+CS4deeRwUWBz49vxZaxiQ/ONdqh/b
         Gdrh1jBJnBUs/S5Y9b9ZH3iCE26i7stKkrur0YQ9YTEto4cMF2V9DFO9psEdc7XXzbPa
         l0v1xzq1dRDNPsng4cXgRWsUxLvlyeANEa9Hv5T0CkAAEDMl0dRPasHHaMo/D7GeKN36
         gJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207192; x=1698811992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eCeunVYQFz26TpeFcqj1dGeFr6YLbG2VvecTD6jcmQ=;
        b=gXVGflf5H7pO5r1NUy0TaUJJdwnxlx/xRPSRNaBqiPFn6iJ/ZTL40PX/atk6RMpzo9
         5kqSWHwMM7uKOsMts8wXa2vIcJhD51ew/goOQ8qFUhkVJiTysjfdKoMmfhlYAGkaYkd0
         Yl6gfYgstA3wSuOagh4xk2QUvt9Eq42qP3yTT1dYeH0FIxF6XDhoPWLQnNv5B2JBVxHA
         DSWRwfyJJU8f1FmqTMz+zMIetEFePVquCB4i2OrCeqHVaeZPzrRr8ujzwfWa+TfBV+oM
         kdcL6jBTRyu9vhAcz9OojQ/My51p9EReLNd8+0c5jypk+PA/OOTJvzcPNNx6e7itDuy2
         krpQ==
X-Gm-Message-State: AOJu0Yxx7LLiT07fJIufob4jNjZi0nhd4PSi9xkpb2ii+hufdje/I/wc
	hCwsxwer89JGDlTfwbAd2M1YHasHsrBvXNIIB4sqtg==
X-Google-Smtp-Source: AGHT+IGjjh+fWxeo4anfiFOMoaIWtpzw8oF8s8j4lmUc5+wM2iAzeJuvaIXSZNFqXw05ErIllSGqBJYUzHc6H7jFB+k=
X-Received: by 2002:a50:d706:0:b0:53e:7ad7:6d47 with SMTP id
 t6-20020a50d706000000b0053e7ad76d47mr29754edi.5.1698207192107; Tue, 24 Oct
 2023 21:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020204741.1869520-1-namhyung@kernel.org>
In-Reply-To: <20231020204741.1869520-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 21:13:00 -0700
Message-ID: <CAP-5=fWd440mN-tuL-h-9HkeDNcWK8V0jOqBZjXwFb7dhuaWjg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf lock contention: Clear lock addr after use
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It checks the current lock to calculated the delta of contention time.
> The address is saved in the tstamp map which is allocated at begining of
> contention and released at end of contention.
>
> But it's possible for bpf_map_delete_elem() to fail.  In that case, the
> element in the tstamp map kept for the current lock and it makes the
> next contention for the same lock tracked incorrectly.  Specificially
> the next contention begin will see the existing element for the task and
> it'd just return.  Then the next contention end will see the element and
> calculate the time using the timestamp for the previous begin.
>
> This can result in a large value for two small contentions happened from
> time to time.  Let's clear the lock address so that it can be updated
> next time even if the bpf_map_delete_elem() failed.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 4900a5dfb4a4..b11179452e19 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -389,6 +389,7 @@ int contention_end(u64 *ctx)
>
>         duration =3D bpf_ktime_get_ns() - pelem->timestamp;
>         if ((__s64)duration < 0) {
> +               pelem->lock =3D 0;
>                 bpf_map_delete_elem(&tstamp, &pid);
>                 __sync_fetch_and_add(&time_fail, 1);
>                 return 0;
> @@ -422,6 +423,7 @@ int contention_end(u64 *ctx)
>         data =3D bpf_map_lookup_elem(&lock_stat, &key);
>         if (!data) {
>                 if (data_map_full) {
> +                       pelem->lock =3D 0;
>                         bpf_map_delete_elem(&tstamp, &pid);
>                         __sync_fetch_and_add(&data_fail, 1);
>                         return 0;
> @@ -445,6 +447,7 @@ int contention_end(u64 *ctx)
>                                 data_map_full =3D 1;
>                         __sync_fetch_and_add(&data_fail, 1);
>                 }
> +               pelem->lock =3D 0;
>                 bpf_map_delete_elem(&tstamp, &pid);
>                 return 0;
>         }
> @@ -458,6 +461,7 @@ int contention_end(u64 *ctx)
>         if (data->min_time > duration)
>                 data->min_time =3D duration;
>
> +       pelem->lock =3D 0;
>         bpf_map_delete_elem(&tstamp, &pid);
>         return 0;
>  }
> --
> 2.42.0.655.g421f12c284-goog
>
