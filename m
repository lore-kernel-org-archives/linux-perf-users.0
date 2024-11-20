Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F4168DA
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732071046; cv=none; b=ioG6EnFHfOXumX5bwVykrXak21IPbKoM0lYXYsRm0r+QuTz7In77+xJYk+SWOPnUyLp9pvfzQtce3Wcf/E+yiboz9yZOjS/NavgL6ScePoUmE7iu67NqBlPwMdMzM7Qoo/rpeDr4JAzJ2vMDruWlZm3ScGhoTpTCJngHvsnprns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732071046; c=relaxed/simple;
	bh=HhL58asZBCYQ8e6p9JxkXcJCG4vk5kxYvAnYuFsEkBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0EggdYQJus9S0rgUGOdL5gBHD7zsTwC9OMNWItgZC+UjBielAeSYsN0AUjDz+0iSv1WAa7BiHMxn7ptuCiv4XUve1hYg5rZN5A6gVAgiLa6e3NPtvC2AKSR9d/qvCRPKM6cFRvdlZTZP/nIPUA7QWjWdc+sZHFafaO9Q04fRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2/cIGtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2/cIGtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732071042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk2oaGMW0hYVJcObO/W7STbzlIkiLz8r0ThO3lWl3mg=;
	b=Z2/cIGtJEpLetE4cwlG+xqmU80xLAWuV5SB+wJcaqZSUj/aKUwLVkkscnzjQlJ8bU9YFrH
	aUnUlsvvbtnFy4JTYWhGnXU8Qv1EWL7LcGM5NkjUJBYTB7yB1+OQsqj5D3aiyF7Pw04hQT
	D+hZzz/222/YkYJhisM9RpGT1NiOsjc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-tGEyIp9UMXmw_7oRmbJkrA-1; Tue, 19 Nov 2024 21:50:41 -0500
X-MC-Unique: tGEyIp9UMXmw_7oRmbJkrA-1
X-Mimecast-MFC-AGG-ID: tGEyIp9UMXmw_7oRmbJkrA
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e7a207b659so4665584b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 18:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732071041; x=1732675841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk2oaGMW0hYVJcObO/W7STbzlIkiLz8r0ThO3lWl3mg=;
        b=R3d9vP+fLZAlhZscf1uz2gSf3jodZ2/TJSLtqMniogX9Dr9qPvqMFhyNIkhKDzT4jx
         cJkNURM6IrWxMX44krzBH6VRZAH6Twy1RVvydp7QfH4jd1sd2rppf32DptYaADqwNUN8
         STAKnJ/V4gYiw6O1Z80UkJXkQE8H7R1l0I2ig52c11VS0eJoCBx2pzyM2h2FZiQvWLfQ
         t5vZUj0W31x8siK2E02Sf+sWjEQHuu6H0qn6hXGRyqAPsxpFmAOclimuphdF6EDri+ff
         KLZI2PIJOsveGdPrlkX9ZxilBugcaX/6trHiuJ5XHH42cXsXAH9kJIdI4ES6X+ZsvbWj
         h1hg==
X-Forwarded-Encrypted: i=1; AJvYcCWiMEajcBvNk/XmyGja5dBDqNs5QcaNesL+eK1kVduuRqR3ueh7G1t6bf4hIT3IOmYVSAoCMGIOFta8Z7snjt7i@vger.kernel.org
X-Gm-Message-State: AOJu0YzXREzwVeuJUSOSMpPQLTOk/Gebp0X3xIhOeNiB40i07K5T2Fy0
	i/X8TrF1jOZlTleLz3hVt4Z7h+e4a8hMG4EWIQJ3zzjPnbGsHqbFwCfNEP3v1lnD4rWK5V7u85O
	QRy2i6FooHvYq5pnKn7otHtBaPjBM52/xHVGBTc7VnPPq3vOXZ5Zp/hDUUHAhwKE+YYNaPzr4OV
	MiVcXW9cXQ/kP8R5IW3DrYnncCpT7x8zIG5hy2e9h7oA==
X-Received: by 2002:a05:6808:14d6:b0:3e7:acf6:e611 with SMTP id 5614622812f47-3e7eb7a08b8mr871631b6e.25.1732071040827;
        Tue, 19 Nov 2024 18:50:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb5jAEHepeykB6e1K2zdP9SRlk6ofK5AF7DUbQ1YBJugvsvXdruwTJ2otZgSA6Cdi7qFDuxlBooFJtA4t3BiA=
X-Received: by 2002:a05:6808:14d6:b0:3e7:acf6:e611 with SMTP id
 5614622812f47-3e7eb7a08b8mr871620b6e.25.1732071040590; Tue, 19 Nov 2024
 18:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
 <e37d7c6b-91c7-4fd7-831b-98f0dca5d46c@linux.intel.com> <CAATMXfkt28rjB03xFEcYzvhWsgtCe9Fp6eaFgDMEJq3c8_2hAQ@mail.gmail.com>
 <d3fffe92-8e64-423d-8ab7-075dfaa8a0dd@linux.intel.com> <Zzvg41ngE0oQeWx4@google.com>
 <bb5bbfe2-453f-4681-81bf-e3eb59e7a58d@linux.intel.com>
In-Reply-To: <bb5bbfe2-453f-4681-81bf-e3eb59e7a58d@linux.intel.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Wed, 20 Nov 2024 10:50:28 +0800
Message-ID: <CAATMXfmZZmrqUAV5cVLX3WUN2YntddNM=e59QP=f4fGGdNrj_g@mail.gmail.com>
Subject: Re: Intel Arrowlake and hwcache events
To: "Liang, Kan" <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>, alexander.shishkin@linux.intel.com, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 9:26=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-11-18 7:50 p.m., Namhyung Kim wrote:
> > Hello,
> >
> > On Fri, Nov 15, 2024 at 08:36:55AM -0500, Liang, Kan wrote:
> >>
> >>
> >> On 2024-11-15 12:43 a.m., Qiao Zhao wrote:
> >>> On Thu, Nov 14, 2024 at 10:33=E2=80=AFPM Liang, Kan <kan.liang@linux.=
intel.com>
> >>> wrote:
> >>>
> >>>>
> >>>>
> >>>> On 2024-11-14 4:54 a.m., Michael Petlan wrote:
> >>>>> Hello!
> >>>>>
> >>>>> Qiao Zhao (CC'd) has found out that there are no hwcache events ava=
ilable
> >>>>> on an Arrowlake system he was testing perf on.
> >>>>
> >>>> There are several variants for Arrowlake.
> >>>> #define INTEL_ARROWLAKE_H               IFM(6, 0xC5)
> >>>> #define INTEL_ARROWLAKE                 IFM(6, 0xC6)
> >>>> #define INTEL_ARROWLAKE_U               IFM(6, 0xB5)
> >>>>
> >>>> The INTEL_ARROWLAKE should be supported in 6.10 and later.
> >>>> The INTEL_ARROWLAKE_H was just merged and should be available in the
> >>>> upcoming 6.13-rc.
> >>>>
> >>>> https://lore.kernel.org/lkml/20240808140210.1666783-1-dapeng1.mi@lin=
ux.intel.com/
> >>>>
> >>>> The patch to support INTEL_ARROWLAKE_U hasn't been posted yet.
> >>>>
> >>>> Which system were you testing?
> >>>>
> >>>
> >>> Hi Kan, thank you for explaining this. I checked my testing history, =
and I
> >>> happened to use Arrow Lake-U for testing.
> >>
> >> Thanks for the confirmation.
> >> I will find a machine and post a patch to fix it ASAP.
> >>
> >> Thanks,
> >> Kan
> >>
> >>> # lscpu
> >>> Architecture:             x86_64
> >>>   CPU op-mode(s):         32-bit, 64-bit
> >>>   Address sizes:          46 bits physical, 48 bits virtual
> >>>   Byte Order:             Little Endian
> >>> CPU(s):                   14
> >>>   On-line CPU(s) list:    0-13
> >>> Vendor ID:                GenuineIntel
> >>>   BIOS Vendor ID:         Intel(R) Corporation
> >>>   Model name:             Genuine Intel(R) 0000
> >>>     BIOS Model name:      Genuine Intel(R) 0000
> >>>     CPU family:           6
> >>>     Model:                197
> >
> >   $ python -c 'print(hex(197))'
> >   0xc5
> >
> > Isn't it ArrowLake-H ?
>
> Good catch. :)
>
> For ARL-H, it should be ready with the upcoming 6.13-rc.

Good to know that. Thank you!
Maybe the machine name is displayed incorrectly in our system. I will
discuss this with our IT.

- Qiao

>
> Thanks,
> Kan
> >
> > Thanks,
> > Namhyung
> >
> >
> >>>     Thread(s) per core:   1
> >>>     Core(s) per socket:   14
> >>>     Socket(s):            1
> >>>     Stepping:             2
> >>>
> >>>
> >>>>
> >>>>> We have found out that it
> >>>>> does not work even on 6.12.0-rc6+. Are there still drivers that hav=
en't
> >>>>> been merged yet?
> >>>>>
> >>>>> Happens that nothing matches in this loop:
> >>>>
> >>>> The HW cache events are usually model specific events. You cannot se=
e it
> >>>> unless there is specific support.
> >>>>
> >>>> You may also get more clues via dmesg | grep PMU.
> >>>> If you see "generic architected perfmon", it means the specific supp=
ort
> >>>> isn't ready in the kernel.
> >>>>
> >>>
> >>> Understand! Thank you Ken.
> >>>
> >>> - Qiao
> >>>
> >>>
> >>>>
> >>>> Thanks,
> >>>> Kan
> >>>>>
> >>>>> int print_hwcache_events(const struct print_callbacks *print_cb, vo=
id
> >>>> *print_state)
> >>>>> [...]
> >>>>> 305           for (int type =3D 0; type < PERF_COUNT_HW_CACHE_MAX; =
type++)
> >>>> {
> >>>>> 306           for (int op =3D 0; op < PERF_COUNT_HW_CACHE_OP_MAX; o=
p++) {
> >>>>> 307                   /* skip invalid cache type */
> >>>>> 308                   if (!evsel__is_cache_op_valid(type, op))
> >>>>> 309                                   continue;
> >>>>> 310
> >>>>> 311                   for (int res =3D 0; res <
> >>>> PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
> >>>>> 312                   char name[64];
> >>>>> 313                           char alias_name[128];
> >>>>> 314                           __u64 config;
> >>>>> 315                           int ret;
> >>>>> 316
> >>>>> 317                           __evsel__hw_cache_type_op_res_name(ty=
pe,
> >>>> op, res,
> >>>>> 318
> >>>>                              name, sizeof(name));
> >>>>> 319
> >>>>> 320                           ret =3D
> >>>> parse_events__decode_legacy_cache(name, pmu->type,
> >>>>> 321
> >>>>                              &config);
> >>>>> 322                           if (ret ||
> >>>> !is_event_supported(PERF_TYPE_HW_CACHE, config))
> >>>>> 323                                   continue;
> >>>>>
> >>>>> Thanks,
> >>>>> Michael
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>
> >>
> >
>

