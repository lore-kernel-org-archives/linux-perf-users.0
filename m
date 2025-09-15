Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E379EA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901396; cv=none; b=T55HsBE3bKciJ6jjlYwD4qVrU5/y8NPW4Eb5eTsv+lGDrpsKSp7VFfstUrd2lzVREY7QLwqsW0I9XbiPV/GbRh3kewRZ7Yv9NXFHGb15tBMFbTcv/2AViUUr8bcoEYiGNrEQO1/Fp4LuWJddFXBMCFG7jRxK3NAltQSw/whOSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901396; c=relaxed/simple;
	bh=BO6IHIraaA33AzZrGgraDPlur/2l0PmDTVZQ4KAkd3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwuXi9T3xjejX/AX3oct8GPrcohbIHO5Mmt7sEiegwWzooCdu6p7KTgQjx5/yeiJIyd9G4kincID3Eagqf1SVqef+dWVb+UL0YOoToq+YclueBnC33kD5kZOr/0UTDEqq/rci+5gxDpFIJKLgehL6taMotj4LUpiCAtpZ/tjTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JSOcR8as; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JSOcR8as"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cceb3be82so2699562fac.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757901394; x=1758506194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO6IHIraaA33AzZrGgraDPlur/2l0PmDTVZQ4KAkd3I=;
        b=JSOcR8asj5Z4lgS4n77AvunVh1nL3SbPghj/tTThQs6WfeAKoWV8qRReERbryqBrfw
         3LUHnpcI/XjrzvhQPmIn7QlgPricd2S8bho33evk5lDyoT6Is1j9/0D9v+UlwpNIR8J2
         h6wgfwain2iAocB+7F6SXupex3Q3Uerx8BKv3+olT7ha79OM53nX2y0jjCFkFAoC+iuW
         baW7fad5LPVItGuuZ2DWrCJtFO/9TKzYb+VBFWwyp6qDg9SsjmG7Estin0Nqls2GeGU8
         XB1x81iH0oNRwy2m0Spm6TdcU60Eg9FULxUKKNwlLfRMZaPcIrGfLFP8If7zdQUfJdoG
         17gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757901394; x=1758506194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO6IHIraaA33AzZrGgraDPlur/2l0PmDTVZQ4KAkd3I=;
        b=r0MCufwVnJuD/zOx2mxdrH643Hn5zvZymWn7L8Bk1Axx7b918XfZBIoZOiTFmnFqEV
         wL3eOPDA61V05u38yt3vw5emmaRt5wZLAkHfUqhne/mcB0OdpEd7fi1DqOFjONJNT3YG
         wdcEJh22BR5X5OJ2/OeBlUctPZEin5za/VoU4qNA7TjlOUTx7qllkEIVsqAzRwancGSN
         VEtRx9xw7bji/lV2LGSVlwNZZhU3kEQFRf1E2uKGJ3+/wUTkEm4WP20XrEp0JE8LMmDH
         thq3vaDkthcQMkFxHPAYNipZpSUYwk2xyRUW827GdcuO+XuZjlq+cFEE3Nd0xDdwCQQa
         KaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/F3x52754cLA05OjZhLPlr4wmBBochjCxrSmtQF0fC7sUyieqXwLlQEYUU6bXMFFIpKx4EVT25e+/sI39kFmz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkiv6N6GRDs8uGA1TCBdl5O5+owAzxxnzmi7bu5hBk4psZ4nUC
	k/vXGRuqyIUfMA/6fEkBWDzXPXP5t/LOWa7EERZGaF/qRKPFOobff88gJm41fs4Gjuxpx2ZdkS0
	TLdDxzT4FQZweoQmOK0O4ZFL6XLqWG1EYJSsWbyU0mg==
X-Gm-Gg: ASbGncuGZkc41cN1zn4cgJeOBLMM9BmMzz2xt7vVEHbVN6XI5ok8bCGs/p3TaPaO+2k
	OXDg42WLwrv0to0K+deVGwG+KkG54qvYyygEGPrDDQAStEM068Gyp7P2vNbDXvjYkX2oL+yXGzB
	YCbuFxzh6GcQVqo4BSYloD+N/BPz6JYDOHW5eOEh9DPryXmIQibbfyL9fgKlecaUpyK6fwNSIit
	BfiwJQDqgNZ2bdN
X-Google-Smtp-Source: AGHT+IEzxKXkgKqnV741v0vWC49ZtgXVeKwHXnAtJZiM2Qjz2M2QceURl7ZTg3slF5Ghl+7/2KbprcKdhFECr+rtPe4=
X-Received: by 2002:a05:6871:4149:b0:31d:8c7b:401d with SMTP id
 586e51a60fabf-32e56dc007dmr4929305fac.46.1757901393993; Sun, 14 Sep 2025
 18:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
 <20250827100959.83023-2-cuiyunhui@bytedance.com> <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
 <CAEEQ3wmBvevbkP8XmwR0_q_1QWQsie5g0UUxTFm6ovS1m41pEQ@mail.gmail.com>
 <CAD=FV=UzUCPtwuQRFR0SkAkh63MbzMefxNYmiOBxCemL3P_+EQ@mail.gmail.com>
 <CAEEQ3wmLOjZxVh_vBhmctH-u_ZSxnyg0GiN-_e_4v8_pfxcbSw@mail.gmail.com>
 <CAD=FV=XaSP2A7Dufrxt1DUUznF9Yk-qdBY3wbE03x4_L8HJLSQ@mail.gmail.com> <CAP-5=fWkcxvZ0z9FJztbN4EhU+BNEJTNxe2a6_+11EcYhjZQaQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWkcxvZ0z9FJztbN4EhU+BNEJTNxe2a6_+11EcYhjZQaQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 15 Sep 2025 09:56:22 +0800
X-Gm-Features: AS18NWB5q8BMOMaL4qJUD7HTlg6i3YBaukDHZMMVfaFmVYmSZ3j_z8EethM99sE
Message-ID: <CAEEQ3wn2FfgzKq-vwt5m=Xy5NThrGkZaY4=U45QmN4JzJG8Rng@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Ian Rogers <irogers@google.com>
Cc: Doug Anderson <dianders@chromium.org>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, atish.patra@linux.dev, 
	anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	catalin.marinas@arm.com, masahiroy@kernel.org, suzuki.poulose@arm.com, 
	maz@kernel.org, zhanjie9@hisilicon.com, yangyicong@hisilicon.com, 
	mingo@kernel.org, lihuafei1@huawei.com, akpm@linux-foundation.org, 
	jpoimboe@kernel.org, rppt@kernel.org, kees@kernel.org, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 8, 2025 at 7:15=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Sep 5, 2025 at 4:57=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Wed, Sep 3, 2025 at 4:56=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.=
com> wrote:
> > > I=E2=80=99ve read your linked content, which details the pros and con=
s of perf
> > > watchdog and buddy watchdog.
> > > I think everyone will agree on choosing one as the default.
> > > It seems there=E2=80=99s no kernel/watchdog entry in MAINTAINERS=E2=
=80=94what=E2=80=99s next
> > > for these two approaches?
> >
> > I guess to start, someone (you?) should send some patches to the list.
> > Maybe one patch to make buddy the default and one to change the
> > description of the "perf" lockup detector say that its usage is
> > discouraged, that it might be removed, that people should use the
> > "buddy" detector instead, and that if there's a reason someone needs
> > the "perf" detector instead of the buddy one then they should make
> > some loud noises.
> >
> > You'd want to CC folks who were involved in recent watchdog changes
> > and make sure to CC Andrew (akpm). If folks react positive and Andrew
> > agrees then he'll likely land the the patches and we'll have made
> > forward progress. :-)
>
> +1

Okay, I intend to directly send a patch that removes
HARDLOCKUP_DETECTOR_PERF, and then we can discuss on that patch.

>
> There are also things like /proc/sys/kernel/nmi_watchdog being used to
> enable/disable the hard lookup detector. If we could move that to a
> unique file so that perf is less confused in places like:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/util/util.c#n70
> ie. perf shouldn't warn about the NMI watchdog being enabled and
> taking a perf event when it doesn't.

Okay, let's first take a look at the status of the discussion on the
patch for removing HARDLOCKUP_DETECTOR_PERF, and then we'll modify
this part.

>
> Thanks,
> Ian

Thanks,
Yunhui
