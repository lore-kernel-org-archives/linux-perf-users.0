Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793766353;
	b=XdZPvyhjiMdzNpRs5geIYdW3eJ5OQtDZugzeD7mPe4oaB+oqYDFWukHGKizpkQLe3AWw
	 PJEYmj7cn1cDEtEYaSwJF5N8ptQAu7+dwbPK3ccul0HThliuQ7BhI375LRk0HoMaPt810
	 P31WCNaLaK0fupJiCExg6fcqWNKs6tuLyLqYxxzfcilcZkOLEXmopS/3pgGWv1z3Z/Lmn
	 IkVvGzsHdaC5QLdaN1L7YyJ9XHkLAmxY5cakZek+gnj5y4XUL4K/99z54THU40EZpOFn0
	 sSQPWI7jMrBtzd5cglcZ97XBkjsoXyy8zISuoJPvjXhdSmYpf3IxrAo/IY4rhPyIAqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
	b=2bqQt9WRYbWTs5HbVuDZ+VEeyGchbPeHTrQOT6FGSZ8eiaglEpyre4YnratI+vhoOM9O
	 f1QLEl1/7u1Z7ARxk+RhmSVyfj3HFf1fPTE6rs49iowSWrlQy6EICZEI2GBegKOGv72+n
	 z/+9Z2gDsfmU3lRkyH8j1jDrUI0SACDwB7ICTwYKwltjI06WBX8BtrFlfSKwublmW3vPf
	 Cbe89NdW5e8FtCC/QikYhSeeU9S++/IVoxgAGoe4AyiT+JPfFzsWKjRW6R0tVxW9AF1rf
	 TYrNTQXH75P185PkF/dUPEI86uTwzANG5BH1L9Rz/p1h5Zr+jvyUHYqDtWM/48nN91Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyYT572y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDB606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEBDB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyYT572y
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-54492d8a988so157981cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 20:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793766352; cv=none;
        d=google.com; s=arc-20260327;
        b=aS2a68M68xU5LrlxwxapNWthMWAB9u0lpmExdsHYR7NXy/DYL6x6UBN7hHjgaI8k8o
         mNuedb8IO4EdIOXqhgNlKotM9bme4cunYUn7lAAOUIezuccp5S+kP7la6tjrFG3a/WWd
         BAOq6DkckXSMEORsCGSpTtPIkJBo0O12VgirjaFuZ5VahrR7GD4/+Jqn+UPKQdh2EeLt
         a24BQQWjXE9VDmYT6NSRlrqO25gV9y/LzykB2jTZmwfv6NF+dFsegWdSKhVB/Q8GafJO
         DJ0LwFOlHsYAtSJLS2BgyKpsxCTTHj55I21dnyavEhnNCXgrlM3EXtdHHYCraAFEzieP
         Ehxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
        fh=DrvvoY1TMtiLwxhzFzOHHKtuaSafbVTTTcFvu54kRbM=;
        b=XbDl0Swkta90fc5/TjnXTv5eR3sddhxQzAbxcuXh2qaaBeY5nDfWgwUB3XhizVu461
         PzcjMds2T7SbAvPBXdVx+oCzHMHfTfBldRaMQG1HmEqlaw1LaprahTArNZAhfBCaHyYf
         BIFf194Qh6JPWS77PZG36KlLfAFpdQSDLrLxJQv57xhgXBxs4ICaK0uKlDU/IivxhddL
         eeq09ijCzGYxwbZ84QpieP1WoEZOQSKEvLeaz+MNdVM+hUcFZvS6qv4vxyzc4idxGbji
         m32KAYXfFwVHjmqq5GAlhfXkbYqphMpnt+e1xLUx9kQWhTWMLjv4OsAmoA6ZPC4Erlc7
         nNyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766352; x=1794371152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
        b=NyYT572yiCVIxymQGlv8tJ8fyVMUD3PVocJ6lfrX4j8vOyaLRwp6ezM7AtutnQ5A48
         hxgPz+g03r9zNaKsaHFm9hk7uhQ10cylnqorPbqKqVF8S+Gh8mV+k7e3UsbQ/qUu2nA9
         JBntU9ZWNevKZc2kadM2uc2ncX1/skAobHBkl3+wpcogG90TI8IdSEzQd2/Pvxq55GgS
         KshO1YHSY5sDidi4IuafZGGq9r2QUggt238+3Db5fAIE1Q/XFi4sDMnUZamTlJ1BWmxG
         NtHoUlj7nMyrOmyCpmgdYly4pFykaWjGbaIIXPfsC+0M1LFLEoEo9ksc5/ThKG6YXPNb
         Bt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766352; x=1794371152;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WI3bB1tWOsWyGOl/zi8tRudvpoSVF4MVl+STRxzjras=;
        b=vMSh1M79vdnsxfhoYxyjciibPuiqOwZZRKwcVmJI8z7RysE1eDrp2hpi2BljVJ5H3R
         Qq6BnHDa7lDIFvMBF5fBwpVgIUu2gmQSUPD4AQbaB8dF3I5kMwowgpsrk/axpzgYNkSi
         /LkCL8AqglQcnbLsGZuzlnBjabLSFZowXFl1rMxoBweVJ2f7e5kGP1M2Sr6+sO88m6pQ
         RKRAf0ew/7X+QY7VgtVDQdOXejQudRcK+4jjNxhoKxZAsG9x9ePPGBMk75sMJJbGpFel
         Dr+B8jCiyhjPSNcVcgKv1H4efKrREgLKYDssgOub93dNT+/j6G8emketEPeHrs+6Dq08
         8ovA==
X-Forwarded-Encrypted: i=1; AKwUvBwdDEgX7NK2ScG2W4Tr43yVql5AYaR/MjbkL4se78BVQdvmi+lLsiNUn4L688G5/Lf+4HFFcr/WFQtLUCfrj7Wj@vger.kernel.org
X-Gm-Message-State: APuU4Z8NoLFg7qJw+k0zp6c9zs0i2cQ/DSejclD3psDsg9EHH46WkMJE
	CIYpeXud+WJgYupwd8R/AZcPKLaYzaCiy/M82R41MbCfSYgjv5v8L6dftNnkW090plMHSiboNf/
	05L0W+n83BmBal1kr8ZyuQRlxTzycP/RYvGSPnsKw
X-Gm-Gg: AYBFou1cv7g5t/5Mv5kZxI2ACHXlRn6ijkHu16Lz0hgB2vmv3feGoX3Oo73llltPo2y
	jwWaj4FK5y78S8/pbBuQFx3NhZnmOuJEA1BVHaK3hywREK1LYiz+CCQ85vKTOOZu3ulMUDs8D2I
	GnyTg4B5C+ELV90P6So+FaHWBPGcRTsiYeaKaOgbPlfAqa1b9e47pBsT5bM0AIItwD2pFTsvzDX
	FAT5yvfN9ZG2YJAavXOsDTR04k9FqtyhViKBz++WUJMWTjpEoTOZAs+T4F/W3Fp4pDNNd/uiS8o
	BPR69hPzNvJXdyMnXgFp2LCK0IW0SkykdvA9RE7zzh4gGru+RdET5J6n0hdGujRf1VFcFx4VODT
	5bXBstYM/sGDclMT8UKFNeGtCX5a2AlDv+7G7Fw==
X-Received: by 2002:a05:622b:d1:10b0:54b:648d:9ab5 with SMTP id
 d75a77b69052e-54b648d9cb2mr5349011cf.11.1793766351090; Tue, 03 Nov 2026
 20:25:51 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025215508.1237480-1-irogers@google.com> <20261025215508.1237480-2-irogers@google.com>
In-Reply-To: <20261025215508.1237480-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Nov 2026 20:25:39 -0800
X-Gm-Features: AclHuK-QZgMOvOFTv8qxkeUkqYgKRZ2Q1nM_6KHU_FH0WEU6VrqodwNE_FTWN88
Message-ID: <CAP-5=fW6gwOZpoVWSdDyi-kHHADHdy3g7oKREgCGn3SCO2Pb1A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf/core: Clamp deferred callchain entry count to
 fit u16 header.size
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 2:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In perf_callchain_deferred_output(), if trace->nr is large enough that
> sizeof(deferred_event->event) + trace->nr * sizeof(u64) + id_header_size
> exceeds U16_MAX, header.size wraps while the output loop still writes
> all trace->nr entries into the ring buffer. Clamp nr per event (accountin=
g
> for event->id_header_size when sample_id_all is enabled) so the record
> never overflows u16 header.size.
>
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. +Steve and Masami

Thanks,
Ian

> ---
>  kernel/events/core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b43883a42566..37824ca7fe97 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10385,8 +10385,6 @@ struct perf_callchain_deferred_event {
>         struct {
>                 struct perf_event_header        header;
>                 u64                             cookie;
> -               u64                             nr;
> -               u64                             ips[];
>         } event;
>  };
>
> @@ -10395,12 +10393,19 @@ static void perf_callchain_deferred_output(stru=
ct perf_event *event, void *data)
>         struct perf_callchain_deferred_event *deferred_event =3D data;
>         struct perf_output_handle handle;
>         struct perf_sample_data sample;
> +       u64 nr =3D deferred_event->trace->nr;
> +       u16 size, id_size, max_payload;
>         int ret;
> -       u16 size =3D sizeof(deferred_event->event) + (deferred_event->tra=
ce->nr * sizeof(u64));
>
>         if (!event->attr.defer_output)
>                 return;
>
> +       id_size =3D event->attr.sample_id_all ? event->id_header_size : 0=
;
> +       max_payload =3D round_down(U16_MAX - sizeof(deferred_event->event=
) -
> +                                sizeof(u64) - id_size, sizeof(u64));
> +       nr =3D min_t(u64, nr, max_payload / sizeof(u64));
> +       size =3D sizeof(deferred_event->event) + sizeof(u64) + nr * sizeo=
f(u64);
> +
>         /* XXX do we really need sample_id_all for this ??? */
>         perf_event_header__init(&deferred_event->event.header, &sample,
>                                 PERF_RECORD_CALLCHAIN_DEFERRED,
> @@ -10414,8 +10419,10 @@ static void perf_callchain_deferred_output(struc=
t perf_event *event, void *data)
>                 return;
>
>         perf_output_put(&handle, deferred_event->event);
> -       for (int i =3D 0; i < deferred_event->trace->nr; i++) {
> +       perf_output_put(&handle, nr);
> +       for (u64 i =3D 0; i < nr; i++) {
>                 u64 entry =3D deferred_event->trace->entries[i];
> +
>                 perf_output_put(&handle, entry);
>         }
>         perf_event__output_id_sample(event, &handle, &sample);
> @@ -10430,7 +10437,6 @@ static void perf_unwind_deferred_callback(struct =
unwind_work *work,
>                 .trace =3D trace,
>                 .event =3D {
>                         .cookie =3D cookie,
> -                       .nr =3D trace->nr,
>                 },
>         };
>
> --
> 2.56.0.307.g5fe7bd680c-goog
>
