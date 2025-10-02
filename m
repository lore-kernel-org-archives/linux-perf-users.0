Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96D299947
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438300; cv=none; b=DQ/xH50Bh+2bgpru7CFZhqdM/oA/y103gQTNnwMgUpz5rdqNCcs0SNdNCvWC6DvwjdInCDiDJEV+Mp52fCqT2G19rn23rRa/gx6su75VAv+VK+IRgXNe/+NuFRxqiC2j3MCYyEnGDVku6kJ/TlLTmtDuBvDUOE76HWtf8EJHmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438300; c=relaxed/simple;
	bh=ypXYPlYFCvozZqIuyC9dj4joh++U/ltIN4PHfwfhO5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1IJfx/T94nEatTi/1omonFv7BCb8+/yI7B9PIqdsnbKKjNnoR4w+t7mEAS7MILi+wrl60kK8GnNqH2Y9w/8TlCRgbn4BbHC0wdP6OMKMt5JSnmgTtBjAzB5LDjGRTLkpgTsG8vvPjCmYWL7TFTdHMN5hZQbivWyFEtQOuMrnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fxlyeC2d; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxlyeC2d"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so1399925b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759438296; x=1760043096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzfulOt3RuNjCZqZotlbZaUDHr7ww1cs1ieFRe/EaTg=;
        b=fxlyeC2d6DnWSDM2AiOyAKyM66hM3iYqd8jvfNeQ0uKrZ49QW9Q18KMHWCTwWBlY1U
         9nvzoYj8/bOIVcmKXu0D2HUkIt2eiqSjMsAH3nmykHzfkMtl0dQellh76L9ouNn35PDo
         ngXLlJjx/Hr5I3Ij+Qurj5WHuWjhULRXMUfTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438296; x=1760043096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzfulOt3RuNjCZqZotlbZaUDHr7ww1cs1ieFRe/EaTg=;
        b=OT4vxCIxiZPnaGeMK4AOVEHfhWsv2wlnkVPCKrpar6+i4Sg+Ld2pZ0NsjMxpwOFzap
         fl/0izDq2lXY47Ek+KzY6BnLCrfEEV7hIE2k9PRCJ/cVN8Z88pSCvOvumfTY0HGKwLE/
         iLItwaKFn5/oKjG0kr4zgxt8lLjQtx/2nww1VNf+J+Fk/PdOYiToHOkd8e7lvbO6Y3L+
         ca1PBFyE/sHEqNN3K3CWyathkD+luVFaZu64MJPAWuOD9XcW8F6fG8sAxa3OzLr23qrO
         tNRb19aSJwqXSo9hsg7y2f1bbhvN0WhDonImw3/c++sdSPUEozcOuLR9XrpdJl+QJ7U7
         3BNg==
X-Forwarded-Encrypted: i=1; AJvYcCWCpVTM1VlY3QkmCgw90kNRfcGADxWfCDj/z6gYS5pfyKP/wEQdVSlGiBVpHZ19boSGPqJKwKBEgLhflwuBaEWG@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAOIx14nKkNmTivSB7WyjUG+SBf6hY0k45HT/x9QUb+bJnVXi
	y5aZ9SCPtj9mrQZEoqDz91R2BAEHz6vVa1fmiYt1Cer6z0kQ+KjlsMMuEhGp8KOi1QSFoWQp4CT
	MJ0Y=
X-Gm-Gg: ASbGncvhfvMOyFvGY3F+eOZTlvrfNvYYdjOX4vfMKRpeU0j8uknc49E/SFSY6JwGm5A
	QlH+duMsL38FcJsQocsTqiQJ5BxM9zDBvyapdXIz1ZNs/MFm5jxcVktCyuD0Xkaio2bC+H63ZTe
	Hp0vD/sUer1kabqU6uGx60PC50fmBEo53iEbwpnspeMWPAuSnhE/u9MEtzPzvM7M8D1jZoVXXyb
	OdG1Vx+5EpPcddXIWsPlXmbEUO8LlCEMXVME+aF6bbVi6n+1qmdXDlEcBYLZEjYEdgAJrvPSk+o
	1OwjXNbsrYUF/ejaX10Fyuhl6p5Et5WYeK1oXJ3EZI4Nwez5Z3U9cxUPLIvfgnLQ95zp5x0VGoN
	/qW4lg2w511+cM900dYq0Jv8g9oArSDE+bwETK8QIldj4Mbaw0VIctG3N06/FckYe6nEs85Omup
	jTNMwrp/ZDjZ8eSA==
X-Google-Smtp-Source: AGHT+IF2zU+o4nkpLA1xvYeHPzeDoufPNnsiWG5QW6FM+eowlH/DkVOA9244Q6/XUbrqknjYsQ28Xg==
X-Received: by 2002:a17:90b:4c51:b0:32e:7340:a7f7 with SMTP id 98e67ed59e1d1-339c2765ff5mr706397a91.2.1759438296226;
        Thu, 02 Oct 2025 13:51:36 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a4e211bbsm3436003a91.0.2025.10.02.13.51.34
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 13:51:34 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e074dso15546025ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 13:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrrvgyxRLSQIXDehp2n6NCPvraV4irzAQV4btk6cq4tqbaXP+ZWryCd+5lHBsifY8fSuXY9ghFYlnjQlm4I8ZT@vger.kernel.org
X-Received: by 2002:a17:902:f609:b0:25f:fe5f:c927 with SMTP id
 d9443c01a7336-28e9a61a7a1mr6113515ad.31.1759438293518; Thu, 02 Oct 2025
 13:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
 <20250925084806.89715-2-cuiyunhui@bytedance.com> <CAD=FV=VZLYqPQCOEhbH4QtndeG5e1-0wey24fgYNTeFiqd8qJg@mail.gmail.com>
 <CAEEQ3wnwNdTgt6ByHCzM43fhZMLSxwXvYx-AGBpsktraXqif2Q@mail.gmail.com>
 <CAD=FV=X6Xv_WYPMXKtOWLJX7skCoQmia3JbQej_u38qxqAbqDg@mail.gmail.com>
 <CAEEQ3wn0UckgNTJCPCNDtHW8DwWAJR1PXURvH57yfHATYqs7Gw@mail.gmail.com>
 <CAD=FV=XoUw6HWoFLMcgyHhYm7oeTOXCAyvBdpOghggmdvYzp6Q@mail.gmail.com>
 <CAEEQ3w==Ekffs4+Z55AXMV52f+8ht1pWm3JexXCSiB7T6rzppA@mail.gmail.com> <CAEEQ3wkUai4-noA6CQDsOs=Hn3bSB5cdV9tZJZR8_g+o9e-Mpg@mail.gmail.com>
In-Reply-To: <CAEEQ3wkUai4-noA6CQDsOs=Hn3bSB5cdV9tZJZR8_g+o9e-Mpg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 Oct 2025 13:51:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uw=TLx1KPKCdBcJ4BP8+hOcCA+7QLrmfGHCb9uw9u3Pg@mail.gmail.com>
X-Gm-Features: AS18NWAzBOpu8L_1YZexH_YKnsyYsn8PoONF8LzYzDqMVfF7ir8YT7oKetO1D5Y
Message-ID: <CAD=FV=Uw=TLx1KPKCdBcJ4BP8+hOcCA+7QLrmfGHCb9uw9u3Pg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] watchdog: move arm64 watchdog_hld
 into common code
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	ziqianlu@bytedance.com, akpm@linux-foundation.org, alex@ghiti.fr, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	catalin.marinas@arm.com, johannes@sipsolutions.net, lihuafei1@huawei.com, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, mingo@kernel.org, 
	nicolas.schier@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	suzuki.poulose@arm.com, thorsten.blum@linux.dev, wangjinchao600@gmail.com, 
	will@kernel.org, yangyicong@hisilicon.com, zhanjie9@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2025 at 12:11=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> > > > > > > > +static int __init init_watchdog_freq_notifier(void)
> > > > > > > > +{
> > > > > > > > +       return cpufreq_register_notifier(&watchdog_freq_not=
ifier,
> > > > > > > > +                                        CPUFREQ_POLICY_NOT=
IFIER);
> > > > > > >
> > > > > > > I think you need to do something to prevent this from happeni=
ng on any
> > > > > > > platforms that override hw_nmi_get_sample_period(), right? Th=
ese
> > > > > > > cpufreq notifiers will be useless in that case...
> > > > > >
> > > > > > I understand this is not a problem. watchdog_perf uses
> > > > > > PERF_COUNT_HW_CPU_CYCLES, which means it is inherently limited =
by the
> > > > > > CPU's main frequency. After we make such a change, a larger val=
ue may
> > > > > > be used as the period, so the NMI period will become longer, bu=
t this
> > > > > > value will not change after the system starts.
> > > > >
> > > > > I'm not sure I follow. On x86, hw_nmi_get_sample_period() is:
> > > > >
> > > > > u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > > > {
> > > > >   return (u64)(cpu_khz) * 1000 * watchdog_thresh;
> > > > > }
> > > >
> > > > I have added the maintainers for arch/x86.
> > > >
> > > > 1. cpu_khz can be understood as returning the base operating freque=
ncy
> > > > of a CPU, such as 2.3GHz. In practice, the CPU's core frequency may
> > > > downclock to 800MHz under low load and overclock to 4.4GHz under hi=
gh
> > > > load.
> > > >
> > > > 2. Because the event provided to the PMU has the
> > > > PERF_COUNT_HW_CPU_CYCLES attribute, and the counter's value is base=
d
> > > > on 2.3GHz, the execution cycle of watchdog_overflow_callback() is n=
ot
> > > > fixed; it varies with the CPU's core frequency. When the CPU runs a=
t a
> > > > frequency higher than 2.3GHz, the NMI cycle will shorten; otherwise=
,
> > > > it will lengthen.
> > > >
> > > > 3. After our modification, if the architecture is not integrated wi=
th
> > > > cpufreq, it returns 0 and will not update the cycle. If integrated
> > > > with cpufreq, it returns the maximum frequency supported by the CPU=
,
> > > > so the NMI cycle is only slightly lengthened, with no impact on the
> > > > actual hardlockup detection function.
> > > >
> > > > 4. I have also conducted tests:
> > > > stress-ng --cpu 1 --taskset 1 --cpu-load 80
> > > > echo 800000 > scaling_max_freq
> > > > turbostat shows that Bzy_MHz and TSC_MHz are 800 and 2300 respectiv=
ely.
> > > > And the NMI cycle became approximately 30 seconds:
> > > > [ 2309.442743] NMI watchdog: ------ watchdog overflow callback, cpu=
 =3D 1
> > > > [ 2341.526032] NMI watchdog: ------ watchdog overflow callback, cpu=
 =3D 1
> > >
> > > Whether or not having x86 and powerpc start looking at cpufreq is an
> > > improvement, certainly it is a change in behavior, right? If we're
> > > really changing the behavior here then the commit subject and commit
> > > message need to mention this. Right now this is billed as a simple
> > > rename...
> > >
> > > I don't personally have lots of experience with x86 cpufreq but I do
> > > know it doesn't work quite the same as how it does on arm. It would
> > > definitely be good to get someone on x86 / powerpc to make sure that
> > > they are happy with this. ...or you just keep making it work the way
> > > it did before and then you don't have to worry about getting any
> > > buy-in from x86 / powerpc folks. Up to you, I guess.
> >
> > Well, I fully agree with your suggestion. What I can think of for now
> > is wrapping the newly added content with #if defined(CONFIG_ARM64) ||
> > defined(CONFIG_RISCV).
>
> I=E2=80=99ve also thought of an alternative approach: add a generic
> WATCHDOG_PERF_ADJUST_PERIOD to /lib/Kconfig.debug, then have the
> Kconfig files for arch/arm64 and riscv select
> WATCHDOG_PERF_ADJUST_PERIOD. What=E2=80=99s your take on this?
>
> Do you have a more elegant approach to

Yes, this feels right to me. I was going to suggest this in response
to your other message and then I saw this followup. :-)

-Doug
