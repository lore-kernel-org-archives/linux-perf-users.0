Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC91FC101
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275991; cv=pass; b=USXNJeqjP2PlmnANXPaaTnneFkW1dWZYlsvuM78UYWZV+vst3FpBiRu33ck2XyUSy3q2VhMgG3FKaiom0xdgCxWlM8eOhMPxCA6z4XeSkx7b9TqsJR7wj4hGytOpDFapVNrqs/q9aLW18MJHabnHnB433LxWMKHVmIMIuKZisOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275991; c=relaxed/simple;
	bh=nlQk3Fo7l4wjv+7Ly6liOeonvctxsE9EFpAX/SSjx+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+ui4ucG0mxyL/cSFkT0cES1cIvpE6zU3hfI/0+P/RwXiU+Xxo4GIYkXAViKgrGJGZg3n47ErRxcGljxFX60AGGijcxNdFpQaGpb7HItV+1yte38XIxjdtfEQXENYW9dX4Z0WnQ2XOIzIdw9tMFuFEJQ2arNVqaTEziJTFDv52k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipvEiHc9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtNwODxr; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipvEiHc9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtNwODxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774275988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPrayZ5bCR8SUVZWUxn9+RJQ5ap97Cb8RO+ppSHaOTs=;
	b=ipvEiHc9uUJaCcIGLlyaqgAIjPICl5NCS1fXy0ROrBWYWiFjt0a6VsAYC+F760Bsu2vjvc
	g/GVrDMLZpRJ3eyPASfHScJtJNwLXFycMK0IcUTBYRLTSPE2X0lxtn2jAMsXuQYNy+Eq4B
	DxheqmuK5TfAaKZW2JjZduUxAQ6NB6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-2MXfnvl_N2aGSeIkUfNCUQ-1; Mon, 23 Mar 2026 10:26:27 -0400
X-MC-Unique: 2MXfnvl_N2aGSeIkUfNCUQ-1
X-Mimecast-MFC-AGG-ID: 2MXfnvl_N2aGSeIkUfNCUQ_1774275986
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9399d68111so349537866b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 07:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774275986; cv=none;
        d=google.com; s=arc-20240605;
        b=CVbVBaUBOavWhA5CMkgivugUbCsAAJ9njjMX09Fb199NOzGUQwaFR0v95U9ag3EsVO
         8TZHGEussiu4y6g8fsckqvdfIU3UMjkcGjebCgq8Bd8NbgmGH9IV5lpG4LeBnCpR0eIB
         WJQCcxyL3NBRfQtQSNkNYdg1xSn/dBo06RtFRVLl5NlZLR2M2fQJ8GPvXglREJt1cwDx
         StFy95mD6AQFb2/lg9BPkMm+vQ/YOBq9QPLpXkG5B50LX6gATWJFX1PC4+Co5neD5JD7
         j/Nw7DxhVLQGD2P9JMPfahCVvkuEu/iKmZI4DEl1FMHWSyzlrfPVjbux6dVsE+51vXWJ
         U9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hPrayZ5bCR8SUVZWUxn9+RJQ5ap97Cb8RO+ppSHaOTs=;
        fh=T1jubNAbGf3Mnb6ZgXsSpRKEHVY8FbL9Bd8pwouMZtE=;
        b=HGwfDUPqaO4efsaym19hm1AENO35BeNKfVZmxPDsJpnsX0YG1RewPMYyuR7PR1ofP8
         DN/4mWZN2Yv4rt1e6ERscrThACXn1fj/09nCk2aoMTCth4k0oE+b5hXpOEMO9amytOJa
         TUqOpI7pnPwLo/BCKsi2LPfwhe7Qf+s5Xe9UPRmuHBNwKreKa7RQ7j/KiFMeMC9cw6tJ
         FrG8PtcFOzy8januzltXaJsucCZc85d8xlHNn3qm7iPJ9NVTARq6gSYO0xm9KKjc6Ybw
         3K5ADpCDLHTtMDagBenOi1YIJKL6Jri0TyUIjzaBZcvHq7Xoe1G9nLQdPZyL5sXYfmeG
         eF7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774275986; x=1774880786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPrayZ5bCR8SUVZWUxn9+RJQ5ap97Cb8RO+ppSHaOTs=;
        b=YtNwODxrSwinF8HULG36Y1XrQyPniDk/w3zZ4dqlDhPhsutydcVNc4vb8wUAWOB0mJ
         NfdtUzZVhlfPuGDsF+Lekmr4yKqGmZMlmZ+d6mM73+OM0IVMuGmQKiSF4kxxoQkDjfLS
         kbl2z61Q7Jft1/nnympc/lW9Xq4ta/lO/o5NT4vQ/x63nRNylDkmOz+c6cZ3vkahhwnb
         BAtmVLpmDffU/R92wK8MrrTdLGpqa5b+JJXyPCl9ZRwsL0gYjrHXdKVU2SHJ84+Y03Q2
         aTeKDhYSYpVv1LwWUGPtdi7Qu/mmV9xvtlTv9cw6JbsRJSsMxZPD5rvDqVaCCz99ZMvD
         ZWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275986; x=1774880786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPrayZ5bCR8SUVZWUxn9+RJQ5ap97Cb8RO+ppSHaOTs=;
        b=OxvuvrVl15nxgBGhfHccCH0/wpFK2zizAyE6t0rAbR0Ga4LXTS5OL5RkbtYlByPOkq
         4pwybbiv23YEMkOT++P+hotZoxDkWqSz346t9i9FKem/TAsu/1038tuMPlw6YeVWaVhi
         4fT/TpHf9g7qYw35PyNtmGP2uNtmhIgT7VUyAMwv2gR/qQ2h7ttcM1kAtudAXR6ZWJID
         KemH3xcqgQcYh1/XOsIB0/+J0rkLgq9E0qm8v6lzsmoDBjSUUhR0te+uSG4XdJ5SXiXs
         CKvORRwEJGU/ahK3fs17RcjgQKLTBvpsyudV0Zc4pl5S3y0VFJRxgiHbhbaudnq0c49t
         hBZg==
X-Forwarded-Encrypted: i=1; AJvYcCWNtbajqvJsQgm+HDbBjdwQHKtuMFPqIlFKFPMWNKU/tMImBAbNZ9/f/05JJ98ni70l1BDUXVJt2y3McX/5ntck@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2pQV+bh01FxCITpOdZ7YqJFqGXelauNF4ZrzNv9okAHHx7wdF
	xmpSdsCBxRH8YhaU8HyWNOuKyIOwUnYU3wZ0jSHdTAyvjFi8T2YcocFkaiXoGdPQvFeQh6T3O7q
	MhD+/jCn8/GK+AwzlWeNGV7MRnDgV1eQSkFJVvp8GfrXsViJ+Rry4yGp+FWOjcy8x8yj4CtcasJ
	zQ6gR8Jv8jeiNmHsBkUjzRHsdb9mTLdKfCZ/66UYRps1ztIw==
X-Gm-Gg: ATEYQzx0z0bCQJjD28K9UxYuhZ5hDA1foZdPlm38A9meg4mbkPtZevLZ90Xyq0NkkjQ
	OmXMU9VIr/Z0F4UCsiktnaH85kel6lVAh7a0iGpPfpDuhnWscbWCeNEAPkC7idVjdH1WNbg4sjM
	HGMV0VoMElsKAvxcajT3UgxfYCyVEsoE1jCn1On552AO88TaSR5jrU5rYbC1N1fjZhBVL1bGJPl
	8RSGw==
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id a640c23a62f3a-b9832c15bb8mr887145166b.8.1774275986262;
        Mon, 23 Mar 2026 07:26:26 -0700 (PDT)
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id
 a640c23a62f3a-b9832c15bb8mr887141766b.8.1774275985672; Mon, 23 Mar 2026
 07:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
 <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com>
In-Reply-To: <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 23 Mar 2026 15:26:14 +0100
X-Gm-Features: AQROBzAJEfs0pMyWRv-uz3ieDQzIldlm_q3-K_uSMJ3o7b1hAvMc5Kkkyx7-4Zs
Message-ID: <CAP4=nvTKpEm9BAsR6+SE_qES_zDzYrY2atpNwCGjpwq-g+8oHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 21. 3. 2026 v 17:08 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> On Fri, 20 Mar 2026 at 17:07, Tomas Glozar <tglozar@redhat.com> wrote:
> >> +#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
> > +       "display data in nanoseconds", \
> > +       opt_nano_cb)
>
> -n/--nano requires value incorrectly
>

Yes, this is a mistake.

>  File: src/cli.c:463
>  Cause: TIMERLAT_OPT_NANO used OPT_CALLBACK which expects an argument,
> but -n is a flag.
>  Fix: Changed to OPT_CALLBACK_NOOPT:
>
> > +               HIST_OPT_NO_IRQ,
> --no-irq clashes with auto-negation of --irq
>
>  File: src/cli.c:1042
>  Cause: libsubcmd auto-generates --no-X negations for every option.
> --no-irq (histogram boolean) collides with the auto-negation of --irq
> (stop threshold). The first match wins, so --irq was matched first and
> its negation intercepted the call.
>  Fix: Moved HIST_OPT_NO_IRQ before RTLA_OPT_STOP('i', "irq", ...) in
> the options array so the explicit --no-irq boolean is found first.
>

Thank you for reporting that, I had no idea libsubcmd does this, I
haven't seen it documented anywhere, and I never used it in either
perf or bpftool.

It is a very strange thing to do for non-boolean options in my
opinion. If I understand the intention correctly, the option is
intended to unset another option specified before it, i.e. this:

$ ./rtla timerlat hist --event=3Dtimer --no-event

is supposed to behave the same as:

$ ./rtla timerlat hist

But it doesn't work:

$ ./rtla timerlat hist --event=3Dtimer --no-event

Usage: rtla timerlat hist [<options>]

perf fails even harder on this:

$ ./perf version
perf version 7.0.rc2.g61637af4f771
$ ./perf record --event=3Dcycles --no-event
Segmentation fault (core dumped)

I'm thinking about modifying libsubcmd so this can be at least
disabled (not sure if the behavior is even intended in the non-boolean
case). Reshuffling the RTLA option array could work, too, but is
unintuitive from the developer's point of view, and will also force
histogram options to be before threshold options in the help message,
which is not what I wanted.

Tomas

