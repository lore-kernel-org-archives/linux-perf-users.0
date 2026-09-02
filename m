Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56D4A8A28
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365033; cv=pass; b=BZawftiO+gVnMMb2kw3cm/YW+rxtzB7dBVKIZx4zQSWE/W/SKuaQFbxPbe3UBpCkpRjH7TczI9nM++hCkVftFkmu2BqVWlVuoyMuXjdlXCS6UcSi2DlqzxqzfKQEICfJcp9iojHdr00KdajBVUkETUBWkjTZxF7ctPP4vAM/P5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365033; c=relaxed/simple;
	bh=hP3Rbc9A/szlDhIA2crwL7/Nlzwhm4zZR6DaH4CXedc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ohvTgNhlbzvbqD+qb6s1n1JaFWfwtnh1L1xoBVptG3kWsYVRdP2ftAkN//9m3uaj9cAx1Lz5Dip2Zm8NNW0dh05vWfyzA7esDygXgZl4RvEIayB7EeV3iw5Gj52rwMG3tZUF0vUS1c6qUil+9i77QdMt/Qf7j49caYV1pU8Se8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/wXk1KV; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/wXk1KV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so48075ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Sep 2026 09:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788365031; cv=none;
        d=google.com; s=arc-20260327;
        b=nYPkYrhgi9jOrpAbyUOg9bFiBia9nBKdJ26AEa0eG+tr+mli7hrSxLEO7aj2gdAVwB
         O53Kot/e9PneDO+/De0npAH5Z7XKlpHohnT+gFNbho7Aq1gqR+v23Qb5W4pc8XO1dT4z
         +9Q5BMG0AklxurAHpMGVARNKc0RGP7ZNAJwI8ljsCygOgOM2fx6PoGacUCXcO6t00jh/
         xAE5xbfYgSf0PPlfYNAxf2AweJsD0rKE454irdxn+Rf5w0o8Jd3Og46QZGFAzW5AtNL6
         rHQE9trdG5GsCrk1OZEsOYXjCIILeplEc8DV4FgO5QR9k+I6nXZ9czJKLe2LmwIbpCVR
         e4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZluoUS2vjyaOMM8gOfaUrBEQ/SHomd9tt6NGpimDwlc=;
        fh=gIcXGLotfzO2ZmnEhSjFNq+ft2UaQ90WGwRr7ybmEa4=;
        b=fTvC1wMtLUIYxORKjPyifaF53eJg8IIL3rXJbo87FhB2WaL+4ER3PpmcTsTSVF2OSG
         8u0lVdbt3RPQjADDupOjpNcQqVWWM1EabKq8YggnfKqcObZKJuB7gOBLr55OnPXQq8CN
         8uW8FDooqEhlpdHBkbFqnFrCFACZfQX6wQGekgyFiXB2dneNrgIBICmjGm8QS0ITG+T5
         Or2qWGkr2O7VZksqrVeDJOnRrZC6k0gK2Oqqu2yT9RrWyLk3MiEk7E4Ft2dUAQlC/otv
         3Z7C3PdLUzuekVY7BMQJjfawINS4DtfTZnspsfB1DS73VNxJgIK9qn2N7ZKLbNci3cE2
         x/Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788365031; x=1788969831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZluoUS2vjyaOMM8gOfaUrBEQ/SHomd9tt6NGpimDwlc=;
        b=Z/wXk1KVjcG6lJ5rH+zcetih/O5uV0h4rqjNYC9jyGvLZ444pox07Wzw89MZgU5iD3
         ArWGCP3MzKb8jxV86kNUrk25tjsGtFFJevt8oX/HilMITgEDoJCsSzw0AB6CtTAy8oBf
         XhThJcVQfAFTtIOYdl9TEtkuqq1kwRFKm60Vc4opM6xBIJxp0usxmcF3hB8esrrsc0Tl
         IG+WL1SBkCtTfYPE/2ieUUGtdyMqEa9QBjctyXeGoxkQXo3xHELxP9Dl6ZndJUt8nv66
         8EtX7PW6iq/o5tbJM8guuSqhk6hJMlRTbu2kMvvCEPn7tQYswQcunZC0XHfzEzKUMIM+
         hYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365031; x=1788969831;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZluoUS2vjyaOMM8gOfaUrBEQ/SHomd9tt6NGpimDwlc=;
        b=IkVyb+YYByN6Sj1/NBHzSbr2J+TAefL9qZBwq9n1rp2EqhMznW5vmzZPNuFKyuU+ur
         YmZzlRACN1uo/8dMEcWK1aCw7Lnr9IpaZ4kOVK6WkHGthNETUbO22pahZzLpD8qPsJT8
         a5eip0o1N7pQvTKLoS1VLCTIlqptTlsGux8HbNQ+uT/PmXFN0XaKMx6WYBGclaewhXi/
         v9nNSHV4tar/Rj98t4nOvBD6vkj6diMr3CwGOIuwVSMiHBYa0XW7a71Evc0Fcw588VOM
         ZXbthhmLUdLyAzEo7AulzJGQ/BCVK2CzyFeAAdAgzKwe3jwQebafsvbPgyURM+knTFQ7
         X2nw==
X-Gm-Message-State: AFuF++nTtdKCqrvSeu2THVmQVtiNDHC+NDEx19V1w+CsFwkToaXKDkxM
	yBfd40/7XHrJVRjCBek7cnoYyazqra3o2od2W5XoeU5zjQG1Dx30wT/+QxC1KyaAfkGYZkntdlE
	XTiUDe3ggEFiMS1A5rPIcjutFYnFFjG19//QfLkVxh06Y7BWdFCBP45N7
X-Gm-Gg: AYBFou3QYHdjPEJMvZMW0LgzqFyR6hYDqU5ss5yIdSrM6hX+sQxA35Odt+NsLYm0d4M
	zFV/8Yy34bFxH6pRFMtgrLoL55Onhrr7vQSmnrs9D0k2t4vxdedi6/pA2wFZ5zL6UUimCjHadjv
	g1ICFr5BjjqvAi2cw7PxNj5x1QxXywb16u7PLiQukmNETLqVMVMipcUc5DsbF3SAw3guzXfpy7B
	vez0UargEjCHm68LImyL8ZgpXf9e4LO6QnfqTjgaykFbfD6GlF9cI4Ea13mq1otg9frap4ONaqD
	AqqFwk/mcSv0YKMsiq6g2FNfzH7L+kTspEoyfrhIRckHTsCjSjZJezi6SRFfK6zQJDiPXP8+R1Y
	=
X-Received: by 2002:a17:903:1ae8:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2daf6609b59mr2318445ad.6.1788365029785; Wed, 02 Sep 2026
 09:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902154858.2078885-1-irogers@google.com> <20260902154858.2078885-6-irogers@google.com>
 <20260902155855.85D701F00A3D@smtp.kernel.org>
In-Reply-To: <20260902155855.85D701F00A3D@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Sep 2026 09:03:38 -0700
X-Gm-Features: AcwNN1XASuTfXqfx3vprcI3UupoHMy6r7yPduy7Y_asOGs8_3GrW8PvEny7d1xo
Message-ID: <CAP-5=fVfHRbNwRXakANbC6rnO_apBgeJgj7fA4gc_aJq_5yNxg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] perf tool: Add fallback stubs for missing dependencies
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:58=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Feature fallback stubs are generated in the C source file inst=
ead of providing dummy inline stubs in the header file.
> --
>
> commit f19b5b661c978968c83e8af505c2279ba5f83167
> Author: Ian Rogers <irogers@google.com>
>
> perf tool: Add fallback stubs for missing dependencies
>
> This commit adds fallback stubs directly in perf.c for commands that have
> optional library dependencies, such as libtraceevent and libelf. This ens=
ures
> a unified warning is shown when users try to run these commands, rather t=
han
> silently omitting them from the commands array.
>
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index 65bdfd71f6262..6c5baa285b13f 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> [ ... ]
> > @@ -53,6 +54,38 @@ static void __noreturn usage(const char *err)
> >  static int use_pager =3D -1;
> >  static FILE *debug_fp =3D NULL;
> >
> > +
> > +#ifndef HAVE_LIBTRACEEVENT
> > +#define DECLARE_LIBTRACEEVENT_STUB(_cmd) \
> > +     int cmd_##_cmd(int argc __always_unused, const char **argv __alwa=
ys_unused) \
> > +     { \
> > +             fprintf(stderr, \
> > +                     "'" #_cmd "' command not available: missing libtr=
aceevent " \
> > +                     "devel package at build time.\n"); \
> > +             return -1; \
> > +     }
>
> [Severity: Medium]
> Does defining these fallback stubs directly in the C source file violate =
the
> subsystem guidelines for optional features?
>
> The perf subsystem guide expects that header files provide compatible dum=
my
> inline stubs when a feature define is absent, rather than generating them=
 via
> macros directly in the C source file.

I saw this feedback on the internal Sashiko review, but I believed
this change was legitimate. To put the fallback stubs into the
affected file would mean not using the Build file config options and
having a large #ifdef in each of the builtin files. This looked uglier
than the change here, and the change here mirrors the previous #ifdef
usage. This change also minimizes the scope of the necessary changes.
I'm not sure it makes sense to update the subsystem guidance based on
this feedback.

Thanks,
Ian

> > +
> > +DECLARE_LIBTRACEEVENT_STUB(timechart)
> > +DECLARE_LIBTRACEEVENT_STUB(sched)
> > +DECLARE_LIBTRACEEVENT_STUB(kmem)
> > +DECLARE_LIBTRACEEVENT_STUB(lock)
> > +DECLARE_LIBTRACEEVENT_STUB(trace)
> > +DECLARE_LIBTRACEEVENT_STUB(kwork)
> > +#endif
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.20=
78885-1-irogers@google.com?part=3D5
