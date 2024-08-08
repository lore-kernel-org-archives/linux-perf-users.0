Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2A25634;
	Thu,  8 Aug 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107170; cv=none; b=koVneDs5wb+INry8b2YPOJqTxN1bIH4pYdlYIX+MZlWzEMNlECIYeXfncLtraNrBlr5T5OcaHGwW5pEk1F/8raINHHfLXRrxL55pktSHiV4m4Ku76ZMIE4anh5OEl/Z6A4JBjkaMRkZmNH2Yoc7XPRS3z+IKaTc6GF3D/2p84G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107170; c=relaxed/simple;
	bh=Ra4epme1jAe/erc+9e5P3JvBq3gYrMs0WfTl5RAVLrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzuuJo5VzZq5ex80x7cHjD9kps1XI+p5KirbfBVrKxBe4QtvF1Dv+UGgXkJSu9ZFpJZwOKN0+K24hNkyv5p8LcANn+f2zqML3PnYg/TgvoNJGyRFuJ/vDh4GKOf99He7zPjgzy/huM68fGW2p/A2SS+sI8x6Sefuwil8wEavM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcuBZJEI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcuBZJEI"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e03caab48a2so569812276.1;
        Thu, 08 Aug 2024 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723107168; x=1723711968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBg/Au3qg2CHGTw5le1CtPxeFyIcB+bjmgWMlL8HTr0=;
        b=WcuBZJEIHagDm4ZYqdwD5XeJl95nB0y1ZeO00D0Lhfz7Y8xNm50Kg125xZuIMdYBxx
         aDpdMispGpwZtMc++UEFS0g1i45m2aKEvOD3/bsOiN7IPM1NKWiR5d+P49IObFtxO/Br
         Zdt5T/ISqo8Ew2hJmaTjXS7jRLLtfI7rvi3m+teS748DzzPsAafhX99QZhd+fZ7Ijq4s
         mKAV0vbmdv07aKRxPxz5cEceXcJQc+8sSQcaBmRnXEgjuPF9XI2yQX2/EFR8axEHC92a
         jKCqlakiovZQ72ZxWchr/7YmkoAKw1k/DCvroMlZDH9XtaoOuyhHrqZ3Tjm3BvLh0Wae
         H9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723107168; x=1723711968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBg/Au3qg2CHGTw5le1CtPxeFyIcB+bjmgWMlL8HTr0=;
        b=fSneogJaMekc2KJpNn+ANV+himkCzL+eL9dq+ksIWfYjmvJh5fuNfaxICcLj08KQ79
         h3Q1KqkIfAh4URhV/6vJd1OcQqybJ5NIRc19EPrHSwjLCEgJ1fMjkt3UXzR7AdEwhe9w
         R17qhdHKxuf9BJbPDKWckQLS/PNP6W6Lf+WjXSNGDZpCySEek4fFfcKx3u4aEGBB7ChB
         S/bqZfiI8z4mGKQP2YZ0fHPTBJ8UI5Yo1dRWF4yAA72dt44SAdrI2pBwfoeIWe4XTyye
         RZtgm3I3eQrUhlbB6sfzJytOSKYCNLNeCetIhrXDLUfk48yZSLM9rkAlm2JWPHjJbX33
         wWzg==
X-Forwarded-Encrypted: i=1; AJvYcCVxbKecJvNtzQ3f7nUOBw2cmB9Z9sMIXunDlsm6jngJnabRQdC5eCZzrcJbCVxJXpB40nhXZM8jIw9hNi/uHuDDWmHURn+aBfp+ado8zligZGh+w3Ivngdztn1mbCGSqmrK7O74hMk6P1XK1popfw==
X-Gm-Message-State: AOJu0YyahRZ4CjcWhf+iK0PGiPiGr2PgiRDj4dGI2Jl0xSrKPdILBkKL
	y0ua7RToGHnhIP9RKgL/Gxvqs3WudmqXZwIfUTuUxM1dNyUvUKX9BSFocoydneivg+vLlH+fYr1
	zMG9cCvuBpiYB0bhDgf5AXmoy1lw=
X-Google-Smtp-Source: AGHT+IHMfLK7EJFmWCoTNyef6zk7o6apft4qpnGo/Gs6KdfIV9cmlrU1Ep3k2CydXeeIp1SZcHMNIjxc3qfwrJIo9DA=
X-Received: by 2002:a05:6902:1782:b0:e0b:e167:b7da with SMTP id
 3f1490d57ef6-e0e9f582bffmr639094276.0.1723107167976; Thu, 08 Aug 2024
 01:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-4-howardchu95@gmail.com> <ZrQCfQOzWpfr6SNT@google.com>
In-Reply-To: <ZrQCfQOzWpfr6SNT@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 8 Aug 2024 16:52:36 +0800
Message-ID: <CAH0uvojkpSsPWPPkuB8Nypkp9YQTOCDF1risCzDAoC=TOAAUnw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] perf record --off-cpu: Parse offcpu-time event
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Aug 07, 2024 at 11:38:37PM +0800, Howard Chu wrote:
> > Parse offcpu-time event using parse_event, in off_cpu_start(), write
> > evlist fds got from evlist__open() to perf_event_array BPF map.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/bpf_off_cpu.c | 55 ++++++++++++++++++++---------------
> >  tools/perf/util/evsel.c       |  2 +-
> >  2 files changed, 32 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 1e0e454bfb5e..fae0bb8aaa13 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -13,6 +13,7 @@
> >  #include "util/cgroup.h"
> >  #include "util/strlist.h"
> >  #include <bpf/bpf.h>
> > +#include <internal/xyarray.h>
> >
> >  #include "bpf_skel/off_cpu.skel.h"
> >
> > @@ -38,39 +39,24 @@ union off_cpu_data {
> >
> >  static int off_cpu_config(struct evlist *evlist)
> >  {
> > -     struct evsel *evsel;
> > -     struct perf_event_attr attr =3D {
> > -             .type   =3D PERF_TYPE_SOFTWARE,
> > -             .config =3D PERF_COUNT_SW_BPF_OUTPUT,
> > -             .size   =3D sizeof(attr), /* to capture ABI version */
> > -     };
> > -     char *evname =3D strdup(OFFCPU_EVENT);
> > +     char off_cpu_event[64];
> >
> > -     if (evname =3D=3D NULL)
> > -             return -ENOMEM;
> > -
> > -     evsel =3D evsel__new(&attr);
> > -     if (!evsel) {
> > -             free(evname);
> > -             return -ENOMEM;
> > +     /* after parsing off-cpu event, we'll specify its sample_type in =
evsel__config() */
> > +     scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-in=
herit=3D1,name=3D%s/", OFFCPU_EVENT);
> > +     if (parse_event(evlist, off_cpu_event)) {
> > +             pr_err("Failed to open off-cpu event\n");
> > +             return -1;
> >       }
> >
> > -     evsel->core.attr.freq =3D 1;
> > -     evsel->core.attr.sample_period =3D 1;
> > -     /* off-cpu analysis depends on stack trace */
> > -     evsel->core.attr.sample_type =3D PERF_SAMPLE_CALLCHAIN;
> > -
> > -     evlist__add(evlist, evsel);
> > -
> > -     free(evsel->name);
> > -     evsel->name =3D evname;
> > -
> >       return 0;
> >  }
> >
> >  static void off_cpu_start(void *arg)
> >  {
> >       struct evlist *evlist =3D arg;
> > +     struct evsel *evsel;
> > +     struct perf_cpu pcpu;
> > +     int i, err;
> >
> >       /* update task filter for the given workload */
> >       if (!skel->bss->has_cpu && !skel->bss->has_task &&
> > @@ -86,6 +72,27 @@ static void off_cpu_start(void *arg)
> >               bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
> >       }
> >
> > +     /* sample id and fds in BPF's perf_event_array can only be set af=
ter record__open() */
> > +     evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> > +     if (evsel =3D=3D NULL) {
> > +             pr_err("%s evsel not found\n", OFFCPU_EVENT);
> > +             return;
> > +     }
> > +
> > +     if (evsel->core.id)
> > +             skel->bss->sample_id =3D evsel->core.id[0];
> > +
> > +     perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> > +             err =3D bpf_map__update_elem(skel->maps.offcpu_output,
> > +                                        &pcpu.cpu, sizeof(__u32),
> > +                                        xyarray__entry(evsel->core.fd,=
 pcpu.cpu, 0),
> > +                                        sizeof(__u32), BPF_ANY);
> > +             if (err) {
> > +                     pr_err("Failed to update perf event map for direc=
t off-cpu dumping\n");
> > +                     return;
> > +             }
> > +     }
> > +
> >       skel->bss->enabled =3D 1;
> >  }
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index b961467133cf..ccd3bda02b5d 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1379,7 +1379,7 @@ void evsel__config(struct evsel *evsel, struct re=
cord_opts *opts,
> >               evsel__reset_sample_bit(evsel, BRANCH_STACK);
> >
> >       if (evsel__is_offcpu_event(evsel))
> > -             evsel->core.attr.sample_type &=3D OFFCPU_SAMPLE_TYPES;
> > +             evsel->core.attr.sample_type =3D OFFCPU_SAMPLE_TYPES;
>
> I don't think we need this.  It should check what you requested.
> IOW you don't need to put cgroup info when user didn't ask.

I misunderstood the purpose of this check, so I'll leave it as it was.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
> >
> >       arch__post_evsel_config(evsel, attr);
> >  }
> > --
> > 2.45.2
> >
