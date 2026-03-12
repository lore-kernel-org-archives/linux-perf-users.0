Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFA38238F
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330896; cv=pass; b=BurtIRqLe3lKHgKxdbL03HhyyfChG2bM9NoTLgB50X88ErkYS8kSfKx0pUzyRafbkXnh43iTMynniyS0KIdt9eJ0VbA3JVdJ/Z5R4yvMYKJrcgrpv4XExnE+r77rRpKfVwKSrCyb+jz4HviBBaJIh6tyr1MHmviLakfyQGpi90Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330896; c=relaxed/simple;
	bh=ZS+/ItMjmQy14ENZqWve/PidZqa0ImY+HlFy6RCiPB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+5gluUKyEDUleb4f9ojh2txUL82mEfv1Vm3HBGDWc2+KfFwgyHNVg52l+1U9Wl6rTKNLQaO1kg9zQn0XtS4mBw1Y6iz0dCzQYWoEg6gnRm31DyOrIWJW6obY5YvYOVZ/virqMTojWeczqaOrpapcQHXqp7MUNUYYdKgdM68N30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UY5Yaoes; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UY5Yaoes"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aea4ebb048so102845ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 08:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330895; cv=none;
        d=google.com; s=arc-20240605;
        b=BNmFGdcj0MZPrLHEyJzbKF3aMlmCGT7Vw725Nsx0nWNyAlzZrEWL4xohjkrDx34fKz
         cgMxYDbBwXmpHXNFmaCFF7QYY9tr6Kd9dSbaOh4yZoivEES+2CgA7LJvQEHb/JaVnKrq
         P+jqW/qXHR4qKoOxxTEjwe+FiGhVOIK6C6xKYHL4gqInHM100WGOHCEkObcmkdvNiK0H
         zwJA0d6MpgT9QBjtyqsOUVAtDh8qHlvoqBkiTyUBjEUIf0jFjDWe8lGpwBVMx2/Mefl7
         +C5xaQgtIwi+ORoKuYgBV664Qmceyp6oIpcbwWE5ubmK3ORL2ALRDTtaD8tmu+uC3Enh
         WfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BE3iXs2Z05/7FfoFDbanKcpxzLhlbH+XfqAIeLpZL/0=;
        fh=EalgVXrr5sxl9YdXDzXZcKNnxEuXcNO2Dl9zmDX0GCI=;
        b=MfO8HbY2G+ZpY1V15tukMLIw/qbcTiVCbFiC8kRZjhvkF3z2izSlh2w+qp+vGBDWKe
         7twqKQDyKnRQJ+xOhD8Thd0AuuDxIwj0D6ZOjCga1+K3yAczN5xuEb4raquA+2RsP3Jd
         hslMr0HI5AwH92hUT3/g6JWEqikQDtVkIM+vztfXc3ngfgtC7J9vU3T0bcDoD/NpxCKv
         eAcdUIYm60Mx3vFo+o9p5Xyy0wmu+hGvwCKWPr6qL4UAvduZz7ighyCUeqj00PkrFrtK
         7yovnObteIa5XRIWxYzFyr9SiAaBx2dG+Q3VY9B6bTOnJEicilddKNOcnKXB7oBqptpZ
         Zatw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773330895; x=1773935695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE3iXs2Z05/7FfoFDbanKcpxzLhlbH+XfqAIeLpZL/0=;
        b=UY5YaoesNhP8sgvAkKYeEyR+97Apbz1rEQU5vAf+Oh6ngu8q1ojSJB/CXOhl2nYJRB
         IIT7hcEqsDkPOBhdWr1fcAPlG7HRBRiRSaS8LjOSajLkSFaVTvTta6YNs+foy6VFm7we
         cc5lPX+8nXVmqUI7JPNLCm51eQ1PI7ineVYRoc//XCUwPaLytfBDQognu9COQSLXbgKz
         9m+0aV3myWVFpS7hiYHdoxgkLC3/aoj84VqeLbIxu0mfJACB9WJqZ161i5goZ8kFf4E4
         6UoZ3pUm5uCOJT0T44k6VF15JuCahmnmxu9vSt0D6A6D7/lEqjlcaiWprIUC0LuDn7en
         e6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330895; x=1773935695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BE3iXs2Z05/7FfoFDbanKcpxzLhlbH+XfqAIeLpZL/0=;
        b=a986PI3wlxeSIIhrY4Zz3oFXF184ongr4pyMJaSTJjzf79IwjEPTP6yyoPb08mgwYf
         Q6XBLImnWFIFD6fph9CitBGkQ9UEdnfrP/sVh2oDE1D844eH7QmON9ojWSAHaNSltq5M
         4zywK8JLsqqZlmYo7yrf3vCo4eIT5/grjTYxMLcA+HvixQ8q/VQDsj7UsZXEVGSampXh
         /B8jd3e0SjppcR7EfsjG9f8Iw06mxc2XgwcG0Mjnh2ZrTjkTL1gqJeFaEnZ0q9hNBPo/
         UA8KAhUMpeK1RQ5Xo6c+iC4DxIY43LMREpZr9vyD7lleLR0exD8AAqK5GCTIwLe0LQdV
         E2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV99PW9ek/bX0EzurcmbFj9CDb+8LYOzlL0UEiSaKSScpsiIQ/+OBl3QP8ZpdMccPstbQBr6DAk9INV6PWx4r1m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5h1k4F/bKAGvmQcbFpKASKjbv6moZpdnXyrEGv8NoDUWDgwd/
	J9QsxghpMq1+Nc7Fcc6i9pogUl1xAYYiD4dET6Uttnc4g9OB5YAK2DTtBB4kRHHJRYhZgxs1L0E
	rXep9EXOGBHERCUU/tWJ5kbpC+4kj9hESTZ593Yi9
X-Gm-Gg: ATEYQzyoJ4SdEAvpbcSC89mh3jxjttbh8yj1VW8ocYwQQua8bt38oKihcKx+NVoBmb+
	nB95GESfSioTEqAHo50pvwAsDXyz1Jxv4QPf7FUvP76WlcV6CNMW3Rv/euSEyhSXDdkxW1Os4Mw
	vLQUABY7irzyNDWOmX6UdkOIP683RrKEQ4rNam4WruRxS+7x6nsUaVl23gSJBkD9j9wUXJgJ+Ef
	24Rq2a+npNqjZtKaCsgyPm+Gq2VX6P7I6rS1Amujc8+aOg/1aw+kQYQbETyiD5qSpi4ANmXf72z
	oQxpSuqfCmVAjixgL4QMtmzkwBIc8iyhVo5T
X-Received: by 2002:a17:902:bf08:b0:2ae:c566:bd99 with SMTP id
 d9443c01a7336-2aec566cbf7mr758665ad.22.1773330894106; Thu, 12 Mar 2026
 08:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com> <20260312061628.1593105-1-irogers@google.com>
 <20260312061628.1593105-3-irogers@google.com> <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
In-Reply-To: <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 08:54:43 -0700
X-Gm-Features: AaiRm52XnLLGRVsSOtUv5kOWGcQRyED6TdG_wWyxIGXeGQjR4wuDdkjk1jeva2M
Message-ID: <CAP-5=fXoAZ2fheQZ-kZe+JKoV=SbH=vS4mpFcVtS7OKsL5PTXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf evsel: Don't configure framepointer
 callchains on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 5:45=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/12/26 07:16, Ian Rogers wrote:
> > Frame pointer callchains are not supported on s390. Ignore the option
> > and print a warning.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Only disable user callchains as AI is telling me native "kernel"
> >     callchains are supported on s390.
> > ---
> >  tools/perf/util/evsel.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index bd14d9bbc91f..fa21b48cba86 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evs=
el *evsel, struct record_opts *o
> >               attr->exclude_callchain_user =3D 1;
> >       }
> >
> > +     if (EM_HOST =3D=3D EM_S390 && (evsel->core.attr.sample_type & PER=
F_SAMPLE_CALLCHAIN) &&
> > +         !evsel->core.attr.exclude_callchain_user) {
> > +             pr_warning("Excluding user callchains that are not suppor=
ted on s390. Try '--call-graph dwarf'\n");
> > +             evsel->core.attr.exclude_callchain_user =3D 1;
> > +     }
> > +
> >       if (param->defer && !attr->exclude_callchain_user)
> >               attr->defer_callchain =3D 1;
> >  }
>
> Ian, thanks very much.
> Your patch set helps a lot. However there is a small nit (which is mandat=
ory). Please add these lines
>
>   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_CALLCHAIN;
>   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_REGS_USER;
>   evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_STACK_USER;

So these lines are dropping callchain from the sample_type which means
the kernel stack won't be sampled. AI was telling me this worked, but
I'm guess it was wrong. I think rather than this it is just cleaner
never to set the bits in the perf_event_attr, more like what v1 of the
patch did:
https://lore.kernel.org/lkml/20260312031928.1494864-3-irogers@google.com/

> to the new if(EM_HOST =3D=3D ...) above.
> The s390 CPU Measurement sampling device driver does not check on the att=
r.core.exclude_callchain_user
> member, but on the sample_type bit mask. It returns -EOPNOTSUPP when this=
 bit PERF_SAMPLE_CALLCHAIN
> is set. This solves the invocation with command line flag -g as in
>  # ./perf record -v -e cycles  -g  -- perf test -w noploop
>  ...
>  perf record: Captured and wrote 0.183 MB perf.data ]

Right because the callchain was removed from all the samples. We can't
fix old kernels (other than by using fix tags); is there a possibility
of adding the exclude_callchain_user to the s390 perf driver for the
sake of kernel callchains? It seems better than providing no
callchain.

> Also I discovered that the fallback when using --call-graph dwarf command=
 line flag still fails:
>  # ./perf record -v -e cycles  --call-graph dwarf -- perf test -w noploop
>  ...
>  Warning:
>  Trying to fall back to excluding guest samples
>  Error:
>  Failure to open event 'cycles:H' on PMU 'cpum_cf' which will be removed.
>  cycles:H: PMU Hardware doesn't support sampling overflow-interrupts. Try=
 'perf stat'
>  Error:
>  Failure to open any events for recording.
>
> The reason is in __evsel__config_callchain() which calls evsel__set_sampl=
e_bit(evsel, CALLCHAIN)
> and sets the PERF_SAMPLE_CALLCHAIN bit in evsel->core.attr.sample_type. I=
t also sets the
> member attr->exclude_callchain_user =3D 1 and sets bits REGS_USER and _ST=
ACK_USER.
> All three bits are not supported by s390.

I'm confused by this and your previous testing that showed the
`--call-graph dwarf` worked. You need the sampled registers for dwarf
unwinding to provide initial register values for the unwinder.

> I have modified your 2nd patch and appended it.
>
> I find all these bits in sample_type and the attr.exclude_XXX stuff very =
confusing. If there
> is a more consistant way of checking these feature, please let me know.

Ok, let me check it out.

> Thanks again for looking into this.

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
