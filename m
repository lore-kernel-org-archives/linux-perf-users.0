Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4935CB8F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363062; cv=pass; b=num8JljM6NiEbdOwvpdzeQyU4QN78KUUMuPFKN/7ivZOqHIF44J4sX04CYR/KsySIDF7L7hWBePEYYU4/5djT/BpXgDw6rXdwydNi8+Td2AR1sIVPe8a8ItCAkgblB7kg4uaZFOKhWo4OVZmG41lz+9A3fNejbr1dz2ht2P0qv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363062; c=relaxed/simple;
	bh=699+EuYTfOGm09dvRxxzgvX6V6xefV/3IhbRev+YX0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzkZMmxQzcsIlDjBJxSw7QrsY6UYc09U96vqHeN/2Cs035f8IlYATLkwI8Ad/nzcSRpZsKP5rgp/y5ow0RvZUhudCp695XLXa7+OnIv2BCBQ482GecbPOTExbPlr5OqQ0aFg1MJ94hiTReej2MF59YY2cLnR1wwh0di4jgDtat0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHfCHBvJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYzkGDbu; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHfCHBvJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYzkGDbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774363060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trF5Za80nJGnhx1ggqQpts4LYsbB6nDZANXGP/W9Tmw=;
	b=bHfCHBvJyQs9wQS3Epj08McQmGZHkTB16STulCCj3hOMWStlPhqeN1o4h5RvwGEusKkcBJ
	egkE5/Kg2xBUZtvsjUinlt6CvMBYXh97pSSjkUmSZwOGDFkDyIzQV8NlVY/EKIWo/O9cuo
	oZR4u1R2Sfkr7O6a7tQph/EDcB9hvCA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NeWZZkXOPTeHMT9M8KOYlQ-1; Tue, 24 Mar 2026 10:37:39 -0400
X-MC-Unique: NeWZZkXOPTeHMT9M8KOYlQ-1
X-Mimecast-MFC-AGG-ID: NeWZZkXOPTeHMT9M8KOYlQ_1774363057
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b979930aafeso415710066b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 07:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363057; cv=none;
        d=google.com; s=arc-20240605;
        b=FJwAJG6pVE1kSFHsUo77tUpDoRZIuyCgqFVqIqqHaOCdxK9lfnNHk8MagAsWdCOrYu
         0+9+AXUn5HzCFh5d/gmiNgHdBeVCuzW0Yleysxf3A/dbLJyQ7IKspirh8Lyg51OXkwsY
         TdtLxeUmP15/oc21doYJDh3EkdQO+3Wh3fnC/MJWX4AAVICExNOPJGY0uo+35DEdj1ie
         CDWZbMHrKQngt/kwTnMK0gtl4fmTHBviVpHPc3uAqsV1gxbG5+SeMOfkBBifx/ELTX+x
         PHHhKBv7o6PlX6ISZxBiDwy72vW65BQqE1bgyZ/lrF65TBOd9QaeJ+DC0LpB2LG9S4Z6
         M4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=trF5Za80nJGnhx1ggqQpts4LYsbB6nDZANXGP/W9Tmw=;
        fh=JAsUODtlBm2GcM3OmK/Src+tu2n3GPX7UJ3AGcKYp3Y=;
        b=ljT/tQOvPknqF9Qp6KlU4H7RFc2KFuMO9ED4+zrNy6BYoDekA5JZzt1865pPJ0rFEw
         wj618vaIowlcYxTk/L3TQzwRgfzztzyjMtK2dx6h2yG/95FqcWYQMS4B0Y1Umt4CRpbP
         HNChBG+yUK+Qw9zLRUjrjzCTjqyUCT9TXanfeJuszYaIDOKlcDNmhkWS1NzMaHrUfMty
         L62azMKYtB0pbwCkfBVGPLVqQcSAMGF4yD9PNd52zAcoS4Q2Nn/lMuJhftsyNaVhrAPR
         Jokf0Wrjb6MZapJHNGAHsfCWCl4dz/EtNpmlFK5n9LGDiYlUBthWt/OCgW+dPdzvm/Kg
         g6yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774363057; x=1774967857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trF5Za80nJGnhx1ggqQpts4LYsbB6nDZANXGP/W9Tmw=;
        b=DYzkGDbux/GieAUaua2p6BUvWLNK1+sn1f6gGbAMquILQJ8v6tVfkFd0cTQIFtOEyp
         CGvHHCAKlk2e5jJZgxGChlgT99tFkQLSt0KvZLHcvh8qVRmeQ4WQB3VCLv3URlxTBI+0
         Rn5C/7OSX7YrNkcyLbnR4wdy6ruvg9u+X9mH47FlqfDrzdm7unsgmJSSpvwAlncX1Wat
         rT43rqEfH98+spBMo04v/jXcO2H/oTPf7BRc2dziTxk7Y3yUnz2r55FeFSj1uvc1oqnq
         3oWACBqaINIIFYeVDHkPJw0rDnAeiNW0p1Q6HgunYAkDCDPFiFPHcyQX8EtPqQeTHYX8
         um3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363057; x=1774967857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=trF5Za80nJGnhx1ggqQpts4LYsbB6nDZANXGP/W9Tmw=;
        b=fZ8llz9/RYRMd/b8FqEGxuhesBvp3nAHKUyXTv8uBIFtD7dXXTHvnXzAD9WbKLgr+r
         2apVT5RAE0zOgyfZlAP2uijTH9wAN3JKVZfIvwNviikD19kwgg0YJ6C39h7nX4gNL65W
         gvpLfNbZubNv2lIcorI5q76Ds1G2eJHedQJeEaR3HMq+z9I2tQQ+W3dzgk6n0kscp5YL
         M0KpdVamep+nL6Nj3dhF43+/+xsD/Jxo4bgEA+H603Dq6K7/3oOeoi8ARpqBpLjfzHJN
         8iyCyPxA4lv9vWgXv4GwjX37XfhGTHaqfHeIRl8ZoXstliqd/E1gls7NesZPoq9ipfGq
         up8w==
X-Forwarded-Encrypted: i=1; AJvYcCW8JbRsymR3vERw33aqUCiK9sIQqCeMXuJOCwaEjj4BuVwXmWYIihmBMvgw8Covb/M+U2HwnBM5UjDRdFYZwmEr@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJd7QMJIYDfJim9sY2d/1ukXdi7rIF5pF+4xoPqcsJ7htZtYS
	UEsw4KO7hKbvMX+tXUJneZE2vVLAInt25Bzor313+dXfXVaoxaw3um8KvdTdJt1ap5dHHWCF6FK
	bL9gDwQF1G5EdBg4I8Uqezg5z4jeeA+/0ezjdh8s57hVhEFPKIdlPeanCNUboiKWb2aNXs/6Uw/
	SB6umQOc5Acvq36e4WH6Hpn2SlhIfsHLoG12GzU4Yo7AcrsA==
X-Gm-Gg: ATEYQzztG9VlD0mQWkjl+jwkS+17jCuRQrdEaVFVoB5E3iTQHmCRBdhwqeH8wuOaHF+
	sXk7DvSm3W/nPdRqmt+AUJGkXWItfEHA4wA6tuzoqo/HT5G7E8I4z2dcS4Mrq+/D9rFFao3YdFN
	rGAnHpqlTxBxbe/+Z6h8bg3eaXYx0/ILgH8bofZ5EpcCThNR0sOBC8z3zODYwfeP9lVutReR6Ca
	Q201A==
X-Received: by 2002:a17:907:a0d5:b0:b97:a4bf:d184 with SMTP id a640c23a62f3a-b982f21d39fmr1127228766b.1.1774363056676;
        Tue, 24 Mar 2026 07:37:36 -0700 (PDT)
X-Received: by 2002:a17:907:a0d5:b0:b97:a4bf:d184 with SMTP id
 a640c23a62f3a-b982f21d39fmr1127225666b.1.1774363056116; Tue, 24 Mar 2026
 07:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
 <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com> <CAP4=nvTKpEm9BAsR6+SE_qES_zDzYrY2atpNwCGjpwq-g+8oHQ@mail.gmail.com>
In-Reply-To: <CAP4=nvTKpEm9BAsR6+SE_qES_zDzYrY2atpNwCGjpwq-g+8oHQ@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 24 Mar 2026 15:37:23 +0100
X-Gm-Features: AaiRm528YmqufVfzflCbFXRp_BZEkBFumbc6jhPk-OsU1m9G19dp5RLFmh0vY18
Message-ID: <CAP4=nvQDpfh5J6OF7U63UD46BsvKPSQS+_FxHuFPbnCsC-sDQw@mail.gmail.com>
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

po 23. 3. 2026 v 15:26 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> na=
psal:
> > --no-irq clashes with auto-negation of --irq
> >
> >  File: src/cli.c:1042
> >  Cause: libsubcmd auto-generates --no-X negations for every option.
> > --no-irq (histogram boolean) collides with the auto-negation of --irq
> > (stop threshold). The first match wins, so --irq was matched first and
> > its negation intercepted the call.
> >  Fix: Moved HIST_OPT_NO_IRQ before RTLA_OPT_STOP('i', "irq", ...) in
> > the options array so the explicit --no-irq boolean is found first.
> >
> ...
> Reshuffling the RTLA option array could work, too, but is
> unintuitive from the developer's point of view, and will also force
> histogram options to be before threshold options in the help message,
> which is not what I wanted.
>

Actually, it doesn't. Just as defining --irq implicitly defines
--no-irq, defining --no-irq implicitly defines --irq, so the long
option --irq stops working when putting HIST_OPT_NO_IRQ before
RTLA_OPT_STOP('i', "irq", "irq latency").

So the only solution appears to be to add a flag to libsubcmd that can
disable this behavior (auto-parsing the counterpart of --opt/--no-opt)
in a new patch in v2. Since this patchset already has a change to
libsubcmd and CC to linux-perf-users, that should work.

Tomas

