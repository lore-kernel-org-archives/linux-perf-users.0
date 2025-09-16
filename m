Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E72370590
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037859; cv=none; b=ihXzoVOFRgHHlyZudy6bbHHBrF/QeoQTklXwZZqSOSuEw/aqQ9C7vwpeORnOVrB/Jn0lzW6kQJfO6DvOBGHGsgF7uuZoVuhgYezYq0h1vll5qtwRqYeCZxzA9MOdgDlZRaNW/DF29Liyj0beG6LzQ8WPLKs4TkNKJYXHlAOcKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037859; c=relaxed/simple;
	bh=XlfGJ0myBd1CUShqRIzs6Qf3uvtdbW25i4uOaLilOdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWndp+pzn+G1ZvPmKi8iPMx/lEWLF18e63qvMGVpqsKA9nknGOa0iwaJBjgLir011dsiHVqzhTLccgwbNw2MVeFdr/9wWNRxQ/1O0HvnON1Mr/lABjRjLceB6A8L6MTBm4KltvN31zJdBTRyjs4pvP1dnSrrcCGt5bSlVqvGdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dq/TiEgJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dq/TiEgJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-267f0fe72a1so3472605ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758037857; x=1758642657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlfGJ0myBd1CUShqRIzs6Qf3uvtdbW25i4uOaLilOdg=;
        b=Dq/TiEgJ7A0qXZGRJEywvvEeYQ8pKnUhoVr/YUQleYo0V/k8+T4Eb8K1p/z33KOgMo
         pY+ZXDa3BGQDlgkcXJnQX0cMMRm+eL5g1Jt4kDg8t+iQ0CZRHwnVL0Gh9q0yMrMnopUc
         iWKoCiFYH/tU0F6LTGoivBJ8mh5Zo4DGs2zEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037857; x=1758642657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlfGJ0myBd1CUShqRIzs6Qf3uvtdbW25i4uOaLilOdg=;
        b=H+cbf+Gszfw+mpKAgwBBvtsZ9Cl3HMeP3n2/2mbwgw1FazZj/7vtn+DKPBlaZLGBca
         39GFZHBW1NJAQ/e6MRNRWEaWMqWIZ7lQb3a6bextmMAbvEFI7CsC2uQ9xyfNdhDx34hF
         afqOPYM4KRgFH/KwkKqBVf9b9qtu+hbQtpa/yzYxLLX1ylUe7X8BlV8l0x5dq0Z8Rwca
         GsrNwwLrYJdoBq7jQrC/vP1CMMZbjPHMyfyE5+TJYZdJ5H5OURipQ3v/x9xzCjUPbPda
         KULTbCp9RrZ1Kz2eLsfNuIyCg0onILrzg+xYW/Xd8di2uPl+WhS5pvyKJjzMeNjbivt+
         fo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsXBoliLSSU5FUW/WeibYZms/EeABMtKwUrwYJzrUbuBVZbnEVKVzOLsNkDre/KhmoOeli9OcNS/J+/kcoR2hR@vger.kernel.org
X-Gm-Message-State: AOJu0YzctDgLuMN7UEnGhFMclN5yAanI91rhHC4FazJ4GtsRARGqktmE
	edPMtt97PwWSEbyliAW9utKdYZ59nGNzXknzMpH8ExA0whWfh4IRhRLkuoQZtb2Cicn8qHujRAT
	Yerw=
X-Gm-Gg: ASbGncvHTN0SZ7uMKHJSF8/UMgRPv1kEm11+iMMb1QehZ9BhRnJVPBfr7Z/em0/MajU
	r8sXMjSJzsfWDbcUyVULWwFezWDbQ8dEj+MTgCA1O1YxMnJWlWawcxzpQ5oIeBO783YPLPq4/IV
	iAKVeEoSPIa/zI000NSWkwyZfRvcAid8zktFdaGL183gf7auzlL1iKnr8aM6nIa6vnb7nQH47sb
	hPkkSeHtjzKyi0NFzeahCsrZN1VoVHFup66QE4nNC3Qq87cPgps5ahq2koCw50CNNZAWxlZFCdm
	1PukWaipnFiLRhxqfUq9FegeS5AEynaBMJz6gWOr+IMhAxCOK/UKtXTOnFwewkW1O44k62gOrD/
	RC9PkHyqGRt0Ka/H4dvBQTO+iuEyu6oygzruxlxUXRsgkzNSvzJ10+NLgJJBXy1ZD1A==
X-Google-Smtp-Source: AGHT+IEiPcX40TmGDWjB1RIHebL9xQmdWkfUG6g6KsM1kkuJBN1NBc3hL1aemWZ5BClug4Wcsn+8hA==
X-Received: by 2002:a17:902:f792:b0:25c:392c:33be with SMTP id d9443c01a7336-25d27132985mr210507705ad.59.1758037857645;
        Tue, 16 Sep 2025 08:50:57 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267d46eab05sm22025875ad.20.2025.09.16.08.50.57
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:50:57 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso3455180a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 08:50:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXp4BdIlOfPQ7mM0VZl91fvgLeWZ8wBfD3bUmOxPbsddZIFJTfBrf94fDjz0b0P9XlFm3KCwKMSIR17keHvIR0t@vger.kernel.org
X-Received: by 2002:a17:903:2ec6:b0:25c:982e:2b22 with SMTP id
 d9443c01a7336-25d27134267mr159143535ad.61.1758037856437; Tue, 16 Sep 2025
 08:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck> <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
 <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com> <20250916074217.GF3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250916074217.GF3245006@noisy.programming.kicks-ass.net>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 16 Sep 2025 08:50:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com>
X-Gm-Features: AS18NWAxT21ffANYOVAuTiBZ-JCuPw16bE4J4Dn2ocVjGgCvD3aQkxhG7dvBAPs
Message-ID: <CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org, 
	masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	wangjinchao600@gmail.com, yury.norov@gmail.com, thorsten.blum@linux.dev, 
	x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 16, 2025 at 12:42=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> > > Yeah, this. I've run into this case waaay too many times to think it
> > > reasonable to remove the perf/NMI based lockup detector.
> >
> > I am a bit curious how this comes to be in cases where you've seen it.
> > What causes all CPUs to be stuck looping all with interrupts disabled
> > (but still able to execute NMIs)? Certainly one can come up with a
> > synthetic way to make that happen, but I would imagine it to be
> > exceedingly rare in real life. Maybe all CPUs are deadlocked waiting
> > on spinlocks or something? There shouldn't be a lot of other reasons
> > that all CPUs should be stuck indefinitely with interrupts disabled...
>
> The simplest one I often run into is rq->lock getting stuck and then all
> the other CPUs piling up on that in various ways.
>
> Getting stop_machine() stuck is also a fun one.
>
> I mean, it really isn't that hard. If, as a full time kernel dev, you
> don't get into this situation at least a few time a year, you're just
> not doing your job right ;-)

Wow, so I either suck at my job or I'm not a full time kernel dev? Ouch.


> > If that's what's happening, (just spitballing) I wonder if hooking
> > into the slowpath of spinlocks to look for lockups would help? Maybe
> > every 10000 failures to acquire the spinlock we check for a lockup?
> > Obviously you could still come up with synthetic ways to make a
> > non-caught watchdog, but hopefully in those types of cases we can at
> > least reset the device with a hardware watchdog?
>
> Now, why would I want to make the spinlock code worse if I have a
> perfectly functional NMI watchdog?

There's cost and tradeoffs everywhere. Using the perf-backed NMI
watchdog has real downsides in terms of resource and power costs.
Certainly touching the spinlock code would also have costs involved
but, at least to this poor kernel engineer it doesn't seem like a
forgone conclusion that one set of costs is better than the other.


> > Overall the issue is that it's really awkward to have both types of
> > lockup detectors, especially since you've got to pick at compile time.
>
> Well, then go fix that. Surely this isn't rocket science.

Looks like Jinchao has already sent a proposal for that.


> > The perf lockup detector has a pile of things that make it pretty
> > awkward and it seems like people have been toward the buddy detector
> > because of this...
>
> There's nothing awkward about the perf one, except that it takes one
> counter, and some people are just greedy and want all of them. At the
> same time, there are people posting patches that use the PMU for
> page-promotion like things, so these same greedy people are going to
> hate on that too.

The weird cpufreq stuff that the perf detector needs to handle is
awkward too. I suppose that plus the eating up of the perf counter
(which gets awkward when you try to virtualize) is not exactly a pile.
I think I was also remembering that people were trying to transition
away from the perf detector for power saving reasons to save the extra
wakeups/interrupts, but I guess that's not something *awkward* but
just a plain-old normal downside...


-Doug
