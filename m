Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2133A70E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021058; cv=pass; b=osD/+ptn4P1ePk5hPHFs+j0bJh3CMiNHsCwkQ98cZbAcy06Fv3WNtyAxgdToDhhvcRKksLq01C7wgYiuTrX8ySLQf1zn3Fb0vUVFySdYdm4RSoY3lg43Fps76B0eNmFNXaCGczk3VgerMWgi3MqNIEcNXlSczZMPCpyUdvJJ8Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021058; c=relaxed/simple;
	bh=CVjuEuHSLywoYm8ktC2XUjlEu4BXrRrqkVlYspboNPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck9k8Gdtniv8lVhHlLU5ooqURawoWPKwnxy37sZtIMJLCKglyB+EoN14ysiDBkHBPrI4xZ2EovFwOLGXiVx1OpYnh0LQrfVC41G+yE5msEii30+x42e3AmxQU6jWyXhyD65dot31gYkq8CE2NpMr1U+8qNCcyqcQXkapNxnGn8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1vjwDJT; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1vjwDJT"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233508c721so615c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 10:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769021055; cv=none;
        d=google.com; s=arc-20240605;
        b=Ozn2lxcrR3qgX2lYVf8Y0wsIqZEZ2VvISZV1TWtBY92onKRyuQFxkwPkz/O8FL73hf
         ijxMrC13w++bjwrt7s1yhL2TbYBPg8O5cifLqCBpDUlvd4UkLGL41UYYMcZ+ycTdV85p
         j1d319Xrh17+vMSQ4JIxhv4g1lHIwwF8BGpXGawoMFBag6iNcsU4hwMqSrZXxcaUSltg
         DbVmjC2Y1QR5eP6aHWxLVUuW4qNOjH19qfBjLYt0OyGtfDDikoeGhIepm68py2N6iOG0
         d4NI/8+CE4xiDG/XvSApf4OXBCC7wWpjuvMg3KW4VekbpCSiuCWpHKMNS/4JGZjValBH
         YWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WStOVyyFjhChsUv0LNo5JD92dWIEpqSVCPoNOyeUym4=;
        fh=9SRocAa5Bvgp2kqsOpY2oR682M3ifu4a7AjZ+CxGmfg=;
        b=dPceTEBGevwqnfmLKmi0zDgrzOvYFv3HzNCjiFkvNuYF7ZIlyPy42Ly0z1/mJ6q+/q
         Wdjpqd60qN/+DFw4IVQYrYlJcoLOwPBq3Kxofxhsl2Bm/iPDCSRiLZkHSBXdw+uBbE+z
         WZVj8hrzSbC9ldqfL05F06ViXaNhWhS4X3XJwEf7ktvKdWCRA7T/H+XaMZuiHaclKd8c
         5+DLfBQ7d9OnL+jX0V+J4PF892qhRFIUUFCRgKJWBK8ajQcLpDhTLsNv9SRAQAqQSQTX
         iwpXzXhdOjsVTghwe9bXyoh32O34wGWfBz3q0FGTlYr3qTjamZKcRk1GEoE4CM0+L0lB
         Tu0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769021055; x=1769625855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WStOVyyFjhChsUv0LNo5JD92dWIEpqSVCPoNOyeUym4=;
        b=y1vjwDJTVkLFA4YVNRBLQlNojwerDyJuiuulj18amlqCOGc2q8n0g94+cVMdTJtBfD
         ubdOWwQDL8a57vR9/+EwGeoq2d6gxELU5Dqa+rzQDktA+7qyOTfoP4VrRRUC7hPPCgYG
         5S5vi+gf0bbXVN5gmXT4tZfb+Iu03wNQX7ZHy6oxHz2pC56ajkI2fyWmTEvT711WJZy4
         v+kNXt1EUVn1mqOM0rbQE6Qx1STl+QycmqOEpwsYq+ZfCb4gcRVwT5awRCfQTEoATiuG
         vMjPmtaB4kEuohLuhk99bS9X4UTffRkud74Z4gEdC9GOykTbru/U9BwQWW8Qn74K14+C
         LYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021055; x=1769625855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WStOVyyFjhChsUv0LNo5JD92dWIEpqSVCPoNOyeUym4=;
        b=UvE8FSk2d91eExDClzcbgMT0Cuql+Xy3zaErR1oBrbD/oBTAjxheVhmrKg4yHWfXaf
         UDA/pE9un1UZFuPV+ufklkci3Q2mXJu9aWXdvXQwgI8NUBIFiips+odglB8leZnrE5Z+
         dRFRsF5HQOTVmLvi2nMwuZ0+JzAIVLKEOEPwpPZe69WZADkaGGYBXYoVPNxD6wupAvDl
         5ZCo6pGwvUUx6Tzmc/slDuCle/pCxKDS+n0iYsYSNj2MA5EnRz+ycbw7PenapsVZi/IV
         CITsI9D1k0M5WBFM2+e0IjwPBU4nRWYd2PlZ9xVjsyhMNUwRnD/J6lR+Qpmmy3FZ/dC5
         uXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV6KbDslELMbZHRqr51giCaWXgFNIDgykF2OOewNNYUC4Te1wXXMyewmIsAw84kbmJH/6TGrcuoj5nTQyDTVCT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrn9CzCjSyzbsjPgtbcBmk77g27EGe1QKH76vqrfcuW+rXZ92B
	LF5SfwrS9+HFMtUS7l/LfGMtQNruOjK6QLenwyOq5pqH4yp4PZVb6wuMFpBfnbfaOBHqU7FOGrh
	TYbxNSuZjN6x4GvW4Mq8XiSWGOG5p5ey3+11cL1E+
X-Gm-Gg: AZuq6aKwZX9ojyjEgP0tWK3ruazU/uFvJR7FvVXCdYVjilc4CHN1p42QQpqm7ZcFQ2V
	xAiqrCHwDoLsgBwmrbR3iMA+k0W7fnhYhkaCRzUAFAgD2NW21SUT3dfPiKG13B7Gmj1fq4bD1LW
	CUNfOYhqML/e8/9dh41lHS83HA+sDY0gJeAJoTiGk8yAHAgnphRh+k9kKQt6TK7MprX5AXp2aee
	z1lwJx+nhO/qL7rkfyMURKHw6MnitPzddoONHIrTfdhRqIaGrLpq0NshheFLCQbAaYz7AJ4svDL
	u8DsaXh5YArxnBesYN21RVbeSA==
X-Received: by 2002:a05:7022:2204:b0:120:5719:624d with SMTP id
 a92af1059eb24-12476fccc38mr8310c88.20.1769021053332; Wed, 21 Jan 2026
 10:44:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120220900.366451-1-acme@kernel.org> <20260120220900.366451-4-acme@kernel.org>
 <20260121112536.27fd5d11@pumpkin> <aXEdti4OdFN1eeuT@x1>
In-Reply-To: <aXEdti4OdFN1eeuT@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 10:44:01 -0800
X-Gm-Features: AZwV_QhekHdY5j49E_4MOb9GCsx_1AV5IRyR6bilBnrPE66mSc8GVh7BOABuvxc
Message-ID: <CAP-5=fV+uJpppt3XLDqCdxmxCn3mGE9MoCbKgLJRuiLQ_745xA@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf list: Don't write to const memory
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:40=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jan 21, 2026 at 11:25:36AM +0000, David Laight wrote:
> > On Tue, 20 Jan 2026 19:08:59 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > Something now detected on fedora 44, where strchr() returns const if =
it
> > > is passed a const pointer:
> > >
> > >   util/print-events.c: In function 'print_sdt_events':
> > >   util/print-events.c:89:29: error: initialization discards 'const' q=
ualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
> > >      89 |                 char *bid =3D strchr(sdt_name->s, '@');
> > >         |                             ^~~~~~
> > >
> > > Fix it by using strnchr() if strchr finds the separator instead of
> > > temporarily scrubbing it with '\0'.
> > >
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/print-events.c | 13 +++++--------
> > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-e=
vents.c
> > > index 8f3ed83853a9e468..898cf426509790cd 100644
> > > --- a/tools/perf/util/print-events.c
> > > +++ b/tools/perf/util/print-events.c
> > > @@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callback=
s *print_cb, void *print_state)
> > >             } else {
> > >                     next_sdt_name =3D strlist__next(sdt_name);
> > >                     if (next_sdt_name) {
> > > -                           char *bid2 =3D strchr(next_sdt_name->s, '=
@');
> > > -
> > > -                           if (bid2)
> > > -                                   *bid2 =3D '\0';
> > > -                           if (strcmp(sdt_name->s, next_sdt_name->s)=
 =3D=3D 0)
> > > -                                   show_detail =3D true;
> > > -                           if (bid2)
> > > -                                   *bid2 =3D '@';
> > > +                           const char *bid2 =3D strchr(next_sdt_name=
->s, '@');
> > > +
> > > +                           show_detail =3D bid2 ?
> > > +                                           strncmp(sdt_name->s, next=
_sdt_name->s, bid2 - next_sdt_name->s) =3D=3D 0 :
> > > +                                           strcmp(sdt_name->s, next_=
sdt_name->s) =3D=3D 0;
> >
> > You could use:
> >       show_detail =3D strncmp(sdt_name->s, next_sdt_name->s, strcspn(sd=
t_name->s, "@"));
> > strcspn() will be slower, but it is succinct.
>
> That works.
>
> > I'm sure there is a function like strchr() that returns a pointer to th=
e '\0'
> > when the character isn't found - but I can't remember what it is called=
 :-(
>
> strchrnull()
>
> And this also works and I'll use it:
>
>                                 const char *bid2 =3D strchrnul(next_sdt_n=
ame->s, '@');
>
>                                 show_detail =3D strncmp(sdt_name->s, next=
_sdt_name->s, bid2 - next_sdt_name->s) =3D=3D 0;
>
> This way the patch ends up as below, thanks for the suggestion!
>
> Ian, I think I can keep your Reviewed-by, ok?

Yup.

Thanks,
Ian

> Cheers,
>
> - Arnaldo
>
> From 02b160f200a2224e8ecf490cf2e316b1a994509a Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Tue, 20 Jan 2026 18:16:09 -0300
> Subject: [PATCH 1/1] perf list: Don't write to const memory
>
> Something now detected on fedora 44, where strchr() returns const if it
> is passed a const pointer:
>
>   util/print-events.c: In function 'print_sdt_events':
>   util/print-events.c:89:29: error: initialization discards 'const' quali=
fier from pointer target type [-Werror=3Ddiscarded-qualifiers]
>      89 |                 char *bid =3D strchr(sdt_name->s, '@');
>         |                             ^~~~~~
>
> Fix it by using strncnmp() + strchrnul() instead of temporarily
> scrubbing it with '\0'.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Link: https://lore.kernel.org/r/20260121112536.27fd5d11@pumpkin
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/print-events.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 4bbcdbf05b843302..cb27e2898aa0558f 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -97,14 +97,9 @@ void print_sdt_events(const struct print_callbacks *pr=
int_cb, void *print_state)
>                 } else {
>                         next_sdt_name =3D strlist__next(sdt_name);
>                         if (next_sdt_name) {
> -                               char *bid2 =3D strchr(next_sdt_name->s, '=
@');
> -
> -                               if (bid2)
> -                                       *bid2 =3D '\0';
> -                               if (strcmp(sdt_name->s, next_sdt_name->s)=
 =3D=3D 0)
> -                                       show_detail =3D true;
> -                               if (bid2)
> -                                       *bid2 =3D '@';
> +                               const char *bid2 =3D strchrnul(next_sdt_n=
ame->s, '@');
> +
> +                               show_detail =3D strncmp(sdt_name->s, next=
_sdt_name->s, bid2 - next_sdt_name->s) =3D=3D 0;
>                         }
>                 }
>                 last_sdt_name =3D sdt_name->s;
> --
> 2.52.0
>
