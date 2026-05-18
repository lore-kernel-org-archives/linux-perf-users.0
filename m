Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA2378D87
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071628; cv=pass; b=guHYETEccXjOn3NeqpKOLkCVabaHsEaHs06ignKKHaa78x95maFqfowyGLnfj2Mkjsy2rAjkroY51V/9EDVIXnBmTlc2ANAJlr37cBUBETOBj/MNd59E+YuEryGuKOf9jWvxgFksGyr8a4qlOLN8XruTl5GF/t3z/gKc6ddDxLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071628; c=relaxed/simple;
	bh=GRfJM5PQjpTrzvgSOa0uhL71TgDCLDRCggiOFgtBxWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YS6kIcGY4Je30ADxUD2z9/i4DjRUZU/SpxeRaAaR3z7izWUvqPwSYbPrBdo4fsldfbc0Ve/W1zPDVf6LMQJw8vasd0/yPtt81F5sCjn/X3NXxR2Ln6jgBY+h90fQHI805AUMrSYOxLXvjPj/kO3PN0L3xn+IR6smxuDOF5eseX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuiqvcsO; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuiqvcsO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso775ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 19:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779071625; cv=none;
        d=google.com; s=arc-20240605;
        b=Fyu4haybqIF/0if6pQyjGR7bCLYUalOpUXO+sWd2d0fTtQzlQtfAADjEUBO/dgqRK6
         ew0EqojZeggGBvejkntGyoUq/Jv4QGO4jPr/2q6BvHmQ7Vo+sAVQZQt6mOcVrDJ7DWxz
         5sFwTGKZ59mmpm7GkyPOZb1cQr0zeWyrGizFbGvlhCdOorvgTCbug7WpagX+bMqDZIOc
         2stYbjgeAM8ofNHpnfxCVGMVoxIKy8TEJcg1oLmDyqhL1CuuBL9YSypOKTOlyw6IBnum
         0pb+Ch8rHYKSLSaCZQUS5qGjFYYlTGxZZxi67Io9mTdBLMoFr56+e3W3WqzC0O3u/YJS
         4nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfwKCx1/f4e0pdku/kXDPetDvANMNpQiE7tYMYwLs8s=;
        fh=+2o6kzYcHYK2vYBzWDQn7xIvvHE3097OV+zSjeko0nU=;
        b=Gy5zut3ZRh00QWkdp8bjwO5fN4lC4Bg+BWCCxzcGH8E+ci8GRsvDNOLO6/Mr3i1D8s
         tI+maBoNKiLkfNIZBU/oPQb2bMe6Px/kX4BcW/qqY7uPcgbHbRNAshslfQzroRaRBrKD
         LvLaHBHCMesJq+G5BD3wHv5jnsWfekGgbycUgRulZnkCHwr+Y/i095KWCMmt7sc5ZjTy
         zuC31fnCOZ8/2itQfOrNy+F8vodE85tLC/qEicOKzITWD9GlMrhLLlmMtg0ZQuj1OmDg
         23Nc//F0wZunIvg3SvtjuWMHrv6jB1UYXK2mSEDUXrI6nGNccUxh2x4xQ2hsrYiv3m0o
         P59A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779071625; x=1779676425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfwKCx1/f4e0pdku/kXDPetDvANMNpQiE7tYMYwLs8s=;
        b=iuiqvcsOySnoE4a6JG2ZkDlg9tRf0cPkXtPQtUMYjFuwIqVT8PlGB76raidfx1Wryx
         wgKxxIRANER+GfU7GnydKpH+MKwjnT3hPfdjUKO9igwdcumi8cuTgQUjMdpzBsPFgiAD
         hiYvMwn+2f435+Ti9aLluOZ0PzBgUonNN6y1/2HF1x1YoQMCHVR4Zb9lqQYh88jrH09T
         Y92ccir33wmPVQnqzOhMSfMxgn66nf/SHDqz4rMfAq72tUKUZQJQJNA2AhiRHsUO0Pgs
         mzisjqON//QGRbRafE87ZmPRjB19JK4g65wUFwWbuykGYzWcKtAoQXJaRT86iTsn87k6
         ExVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071625; x=1779676425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfwKCx1/f4e0pdku/kXDPetDvANMNpQiE7tYMYwLs8s=;
        b=MtEyX9WOk0jzQgcnATIuezBloO/0F6CQWp70fji3+mfVO7xjqvUMQQNqWNzJEgNPLG
         zuAisGNpvCbFAmGVyOydhCPy2gGMsXfg+M67oLSYMX1pY8rvPcKEHzVEC/fMNmJAZF5X
         V0dbVKBmNC+ckluqHFJkJ9/v0Qtf6VKnayOOJOIRb4Cv/m/xH7+VhkFstjoogqXJCJxT
         VUHQ31HXNndBa0OV8etVMn4ZhPBM1buH5aJmK12jfylHNIZjyY7vpTqCOBvXwWHL18kE
         Isjv1zmcgRfmzyI9SFxVu7BMw82zkFMOmnvRMXJuM48hja9EDPlH0USaSo9U4yMm4vd7
         Esfg==
X-Forwarded-Encrypted: i=1; AFNElJ9KVDlj+q4TvOYD5qjS1YSuRW4vP/A6Vpq0Hyj7u9LYwV5+IM9KyeZmEnVtILtnDY1rcLqgvixwdUGWq9iaU3uo@vger.kernel.org
X-Gm-Message-State: AOJu0YwPX0gQXwT7aKX6/FrhRiO7W+EhRG2HxZ90oPWbnTXlTOAAU3lV
	UDz9IWTj3zRlt9Tbn5gyeY+OBu3LaNKmPrPfctQ5jLaESv0mJ4OlyQ+lQHEtZp3kHzGfeZczHGB
	RJB6iCqlurhFwXK1WJ69sZl0t5VQ8aklwXeY/vo7A
X-Gm-Gg: Acq92OFFL01lJ0ogdK+l7DHRPsc4gkQ9bKry326UXbE51jwsd40VG5u6yRVEkrmpwF8
	uvWcFlpOkf1ZjwthhUKBut0nvKwux04N0o96z0GXeKj7xecPjLAMH0itI0JC8AB90bChVxkbLKM
	4u5qj2CmGixVV+nXGga07w1iIRMPkPFbka1pwX+OpvWnByH5Hsxv7lgsfxG679pS3eaIpeys7Xm
	abfy6WzlXnZ6Q0AaYeF6L6SH91DiWrD1NgiVBPV2XY5bwTTwaaE9Of2Hih23lkPBifapuf8eB4Q
	iJSffBQSedKVWbDM7HA=
X-Received: by 2002:a17:902:c950:b0:2b2:70ba:305c with SMTP id
 d9443c01a7336-2bdb03a2cf7mr1481185ad.8.1779071624450; Sun, 17 May 2026
 19:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com> <20260515173852.1378571-12-irogers@google.com>
 <agd2-MgXgs---InR@google.com> <CAP-5=fXSLgN6hXtQattTp9gqxBkO1gi97EWRF45_0ZKQcK0Z+A@mail.gmail.com>
 <agpi522tGtMWwvld@z2>
In-Reply-To: <agpi522tGtMWwvld@z2>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 May 2026 19:33:32 -0700
X-Gm-Features: AVHnY4IFZjnockrPWbcy8Dn3abkT6Rc1-0dHFVIPM7KmDbOMaVeLkTDBICdVaI4
Message-ID: <CAP-5=fXJhx6enPranMaTsDcbf86bJMx7kvHeRGSFkA_+8mRB6g@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com, 
	adrian.hunter@intel.com, alex@ghiti.fr, alexandre.chartre@oracle.com, 
	andrii@kernel.org, ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, 
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com, 
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com, 
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 5:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 15, 2026 at 04:05:40PM -0700, Ian Rogers wrote:
> > On Fri, May 15, 2026 at 12:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Fri, May 15, 2026 at 10:38:48AM -0700, Ian Rogers wrote:
> > > > Currently, jevents.py parses hundreds of JSON event and metric file=
s
> > > > sequentially across all CPU architectures during Kbuild startup, ta=
king
> > > > ~3.3 seconds of pure single-core execution time.
> > >
> > > I'm curious about this.  Does it really need to parse all architectur=
es?
> > > Oh... is it for perf stat record/report?
> >
> > So it is controlled by JEVENTS_ARCH and JEVENTS_MODEL:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n24
> > The default for JEVENTS_ARCH is SRCARCH (e.g. x86) while JEVENTS_MODEL
> > defaults to "all". We have a build test for JEVENTS_ARCH is "all":
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/tests/make?h=3Dperf-tools-next#n74
> > So saying "all CPU architectures" is a bit over the top, but not
> > wholly inaccurate.
>
> Ok, so it's all x86 models.  I think it's ok to have "all" for build
> tests.
>
> >
> > Fwiw, I created a script to convert CPUIDs into models:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/models.py?h=3Dperf-tools-next
> > which maybe could be used to reduce the perf binary size by building
> > only the native CPU's JSON. It is a useful script for debugging :-)
>
> Sounds like it should be used by default to pick the current model.

Having a build of perf tied to a particular model like Skylake,
doesn't seem very good for distributions. I think the default should
try to match what we hope the distributions will do, so an x86 binary
should run on all x86 models.

Thanks,
Ian

> Thanks,
> Namhyung
>
