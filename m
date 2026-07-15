Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CA334C3C
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150354; cv=pass; b=pSdD8lc51cHEgGz5RlsMhodVAf6HSFgnQAUXpDDRCjmE4X/H3KvOJorVF37ApwSrIACe1laQo0mfR7OtV89uvY3gkLsFUjZARh/Vt9uwqJMQP0PoHGlVA5LMJlDnMqKFHflNcYslpmpkeaGOwiDwb3u+IvEwjcvWgtfLRrUb2KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150354; c=relaxed/simple;
	bh=EF1Sc6K6+drbuWOOHBTyg6cZc4GycEy5imPM8AjTVRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgrhxsA6VcUgjUqqrwJZcRhfT/4LwHtiNBz9z3kKh3AtpgCaDPDZkETUXIFWUH7R8CviuspaYWNJd84syjjoDRkdhGiQ0kiJoIMS4ulBZ6gRZG2Xl0VuLslmSsYhMKKfhiN4Xfpnw4ogvmA7xMd5+BaVD+0oiWraxuP8i8O5Tzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEH1vBiK; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEH1vBiK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso36427535ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784150352; cv=none;
        d=google.com; s=arc-20260327;
        b=SPz2zcFFlkA4R4FLJD8kQQeIQoUcUH9Sfe20LEP85i+brEwzHhZ1FDP7+DJT5R6vzH
         VNnScvwPELmZteL96hjXdUSbUQC61DUVNrAKsz984aRj5sLFetZslvJwhIdaFzQxT48K
         FPiNApyhy/Np3087IFRsM6l12xk+nz+TlElR3udX1efzOGNl786aC+GKaqK6jJxjKroB
         FX/ZodV+OCSBFwBmSnzMswiSpgYCJAfvHSYrSrrq+MVRk4yV7Y53zVlZBStkfgnQq1S6
         XA7WSMhPWd3KhMw08PR48dpxu8WmrZ6H7E261QkWhc01dMZ4Z8UcJDlUz0fprXgMfoEB
         ZszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8IlBkzmFdZhw6OngR5ve6sSZYr9K6DwN02oW1ZMOoc=;
        fh=iK1KvQJxPKsK7h29x50eczBkkvCz8F7JPGq68BNO5sw=;
        b=lM7hGh62KJZavWdqTL7vhWqTGLTqw9vf7BovnSD94gBhK+twu0o/E2HUyhf7IWmQAO
         GOCybMd8ZGpX5x/V80pdri9dnEPeNPiVwR3AhtUDCbu9/Lv3W9yTj5pVq+L8oTaf00+Z
         CoQE+BBC0WHgQ22Aq9LfJzPYeS8SzWjuwjWfR1+1EiVwBQi70pJ8C/MH/coIt5LySoju
         V/EeiT/cWKQONFBKYXWLG6oonMZ4rrIKR8ee+gCEPflTXAoSabsUqfIfjRJvLHye8qWW
         TfaFxl21z0xGl6p5lDVRROHriD8FIodQ+kbq4WQWnTiGsT8ctPyJTu/P1w7RqmuKWMAt
         Bncw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784150352; x=1784755152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/8IlBkzmFdZhw6OngR5ve6sSZYr9K6DwN02oW1ZMOoc=;
        b=XEH1vBiKzlg5i/kzW7V/fl0IA86C9PNVrBy/2lna2dS+gNBoMDPw1V9nAL72J89mWO
         g5PB9NESlOFpv+sN1mLNNm0phL6OGA5EfR8Dv8sKMWSQwM8ADFq+FXkDkdq9aljBagdP
         +fsWpk88XqSB1RzwHd0Zy/wfRyfxf6ny1P7dhAD7ifi+ii3YST0qbrOUBvCp+hZaSzyI
         E6aXhRd6CDwMWQ9H2PjC/7O0wiQ1aHI/iBlQ8JEvZiEz3suGNLVHLkKKJZYUo8cjj0x3
         OG/d0EQ/Ghx3UXn7/83vHg6yxT3ZyKDl8a+wLptpNLZQLsvJw2IHffTnW9tXhI/VH+yu
         hrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784150352; x=1784755152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8IlBkzmFdZhw6OngR5ve6sSZYr9K6DwN02oW1ZMOoc=;
        b=QrVzP5wejFb2bHSV7CuQqYVW2ONUBGBRfcsidEgzrqkpnmumWEdvA3Ojx5v4LyxHcr
         Dao8jF07+cA6HgXX2ff9n22Z3FL0yZyTXTU+wpg2GN238Lx51pMGIQ8nLX/0gaK4YvFL
         qwEh3XTIsC57rcR5zeWZZJh0hP4bb0FJdxZ9VRtkMiJxTmoxfjdof3X1seTQn2luaHLV
         lk/0B1+mrX5fT366a288J9GMlMI68AI4TENEY3Dp4OeO0SDHpWZ2/rx/5QwL974MoXka
         iFVqYUQmsMH55fJVHM+rrLC43FLdj48F6FE12DB+0FTEyfEEytN0k0GIqFd4v9bdNP9X
         psjw==
X-Forwarded-Encrypted: i=1; AHgh+RoNn3SuoWk+ZE8xrAve/a14mWrN+C6j/5CjxgLUhAH0lHli4jEYbjF4pTOxhbQR4anfG7l/OeMbypqQUv60r14k@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIqBgxBn3usQaqhQhg0dkaU45S4+Q+sJ37MHhkgs28Q3Lfc3z
	wwcL4CHfZUK3EsFToQY0MLNoD5wddph6QSzoM4cgI84pFK4k+KAJ5wzXlPdKOWttBPSenf7evRB
	yuAEjkuj8IeMb+qVomq+a8Xa+nsMMK/kg8mifuPss
X-Gm-Gg: AfdE7cmUK1bXE6fxUA+4cwrj6Hthwph/bAiEFJUreK090HL4EMpsh5ZVJdsStsjon33
	YbeBVedT49pNtzd9+hU4922iJSPL6AyZGdn3bR6BSjYFNHt+3qsRHN7BoD2JshEfsIfuf6MwG7z
	rT1Yz9J4dVFL3zGzrCQRCnJ8w2r7mqHWH8MYJvXAhtZL7SnOxCb0GBmBr0gvR8cBuGri87RsjNe
	1O/5mRqc2nQHidyADKZuEAlu9HmeUjGHX2NOXupcJGIK8PWkV60fAo9nBZn8HAos31324ma0LWt
	W/gGWXrth2bX8V0=
X-Received: by 2002:a17:903:8c8:b0:2cc:10c1:352e with SMTP id
 d9443c01a7336-2cf17b5d91cmr8143155ad.21.1784150351468; Wed, 15 Jul 2026
 14:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com> <20260714204044.1952031-10-ctshao@google.com>
 <CAP-5=fVc6tw3hfnvB7n_UZ3B5JF7vBpm7cnE8516t5HVUWwFNQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVc6tw3hfnvB7n_UZ3B5JF7vBpm7cnE8516t5HVUWwFNQ@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 15 Jul 2026 14:18:34 -0700
X-Gm-Features: AUfX_mz8fLUEdmVoMcKCE0Ss2DDzWa2xM39a1qlHvZJnCu7vZGaDf1vTWt8FNg8
Message-ID: <CAJpZYjVgfOb9RP32wqZ0p63=0GKOfKgLKHEuT7GUHLoOhcyutg@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] perf vendor events intel: Add novalake v1.00 events
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:29=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Jul 14, 2026 at 1:40=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> [snip]
> > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pm=
u-events/arch/x86/mapfile.csv
> > index a15cd3280993..7bbb8b237b35 100644
> > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > @@ -39,6 +39,7 @@ GenuineIntel-6-8[CD],v1.19,tigerlake,core
> >  GenuineIntel-6-2C,v5,westmereep-dp,core
> >  GenuineIntel-6-25,v4,westmereep-sp,core
> >  GenuineIntel-6-2F,v4,westmereex,core
> > +GenuineIntel-18-[13],v1.00,novalake,core
>
> I think we should avoid editing the mapfile.csv and just use what
> comes out of create_perf_json.py:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> To avoid the strings differing we can modify get_cpuid_str:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/arch/x86/util/header.c#n70
> so that "%s-%u-%X-%X$" is "%s-%u-%02X-%X$" (the values are vendor,
> family, model and stepping with the stepping being optional).
> This ensures the model number is always 2 characters wide, zero-padded
> if necessary. I don't believe this impacts any other x86 cpuid
> strings.
>
> Thanks,
> Ian

For the fix please check:
lore.kernel.org/20260715211144.3144895-1-ctshao@google.com
Note that the "%02X" model formatting is restricted to GenuineIntel
CPUs. It will break AMD Zen 1 matching because the regex is:
AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core

Zero-padding single-digit model 0x01 to "01" causes [0-9A-F] to match
only the leading '0', failing the full string match check and falling
through to misidentify as Zen 2 (AuthenticAMD-23-[[:xdigit:]]+).

Thanks,
CT

>
> >  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
> >  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> >  AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
>
> > +        "Unit": "cpu_atom"
> > +    }
> > +]
> > --
> > 2.55.0.141.g00534a21ce-goog
> >
