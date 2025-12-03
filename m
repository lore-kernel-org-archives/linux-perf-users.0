Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E226560B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798562; cv=none; b=mbK3iELlYFuL71IFIQiJq1/cPkibSjMxvJinERMlyhtA9PgxL0QwWRVYyPy3iyd6Fk5cPbxjeJ1DcbgOTj0Rz7tZcphPGwiiap0SSexjnstNYNWd8RP2m822/NDzhWjv1rtOJCyE7mT8kPrSsoGP9An+SSzgJvRMspb9f2kqbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798562; c=relaxed/simple;
	bh=nfg41T1tfTYNZbsHBGbseBMH87T0QQgtgvZExoknAt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqESpaeM0QuBZ8ydDMHxf7bEr+4ve47TsknojewtrbURGCIiYUDZtr9uPpa5w64uZJyrnZrlFc5wEAUc0apLpAv72QSNbr2E2aAoG6HBG5rxdMNWyUjObKc2Q6r+0Xs6FYfclIWTHoz1bOLaXEazNVpPm8UOunhcr5Z/KBGWPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMiFDaU8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMiFDaU8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295c64cb951so56515ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798560; x=1765403360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2w7JOmTQwdkMhZfit1/JaxKTkte3Ol1QXq7EnPXVnI=;
        b=pMiFDaU8+RpD9NE0RhC1W6ZJHnKFDMN4OTTXnYuYU5Pd3baKHG7kO+1Zom+EqMwIjW
         RHa1creYhEKuO2cQHAdtUWzAIYpXrryPH7TnU90txHmn/sveaOJwsGA0tcmJk2gDyOxw
         QWqfXMJHNrt/p/PHy3DTLjyhdOvgOfzL4e9b1BMPdJC/8lx0UYWLNzULaO+EaFZh/q+e
         4G9u7cY8RKn1XE/qSAtNM30GWVdREhL+DWw94XbHxKbcwODmkc+EkXKLh5LfW8wKefch
         Ch+2BK3GK+MzrDUXtBwk7TZ8ZaCC5nVQwageAozl/uwwqX7DYZg8p9J+pqSe+bgHJL59
         9XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798560; x=1765403360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2w7JOmTQwdkMhZfit1/JaxKTkte3Ol1QXq7EnPXVnI=;
        b=Yf7g+WC1Qd/h2pB85mcm1/PC28tlTPy1YXVIpT8YyFZtGe3Nu8RQeMAZUpFer7SAQW
         mPEvEh2PtPwewTaumqjbuXiepn6nlc63Yp0bvh7+LRlkEiLO62ojIHymi0cgs4swcd0a
         eEo4hWDGmcLV4oUBLr/+T5bPyw48QbhCsf6r/+otYzqebmA4qagqhDViea+HSM6b3kGw
         ktCAeCo1N3Z0X2JAPrXFYhDmDz6xu26M0f6RPjOLuqLvcNl8gspyJPe70PV+z/GWqNRE
         rut7ffujZCPeN0HPOPWBqVDbpR0bR/8CcQbRxThnK0m7qnozkO81Wxkt3OzOfuj7PtMT
         cUsw==
X-Forwarded-Encrypted: i=1; AJvYcCW2kZ8Fq2x5otPk6QsygSeko0U/4k9JfHYOq6KlnkWQIjAiiOye5WysikaQwTxel5u+jfqEnhQINQGA2IWlmzdT@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5XDT6TVUS9DaVD23LjTNB2LOZ784D1RfZbeyjIvy0zJ52q/x
	RawjpppO0si/gOm2iVAHPsVaL8mSER0k/FJ8zFJgXa2iKN/96csd58WNHzdMaKVympiWW/95LZw
	oiqqAOMnVcMc5R0x+7PAAZtS5gCdxECkIk1zxMC39
X-Gm-Gg: ASbGnctbQdQFMENPc0cVOFTXABKzZ/xnKs4nbvdWfaoC69T9DDbDC1jTlcszfh3iZ5E
	BL47hDTRpEQtWtY+KMUF9hS2OcS5gSk0mfATvpEiDAZ5mvnMRKvdBeRpABPEdfjH0bStfU7VjLF
	g1lF/Vh0s/YEWVDyc0xz7oxkYx306mIdbpOwLrp9cEdj/UezSEi5wq88PDBFFpalIC2way38EFp
	TInyp3LnlLw+fg7SY466bttnBobbDxD20m6MoSdQz70MOxHw/XPiVeZlBARCyGHuJh5u+PQ
X-Google-Smtp-Source: AGHT+IHqoglbwiaORG58Hj4/3KXPFdZlIkY5Pr06qBcCgMVAEx/6AXRUynbEpXjWX1Bg6Nwf/ZZ9V2+TFmvOQZQCcQc=
X-Received: by 2002:a17:902:f689:b0:299:c368:6b1e with SMTP id
 d9443c01a7336-29dacc20e8amr50985ad.17.1764798560239; Wed, 03 Dec 2025
 13:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201230904.290733-1-irogers@google.com> <aS5tRnf801Sm3z8P@gmail.com>
 <aS5t5hCk0vde4QvY@gmail.com> <aS5u7BkXnA2Q19-8@gmail.com> <aS5wjmbAM9ka3M2g@gmail.com>
In-Reply-To: <aS5wjmbAM9ka3M2g@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 13:49:09 -0800
X-Gm-Features: AWmQ_bmkSGcNC4O_kWRb025MQYOYdwLNDBqX-7c62eAzoWY6HLvs1D1uP2qrt3k
Message-ID: <CAP-5=fXz1GG8oDzZ6kXTDX6KWDChgm+sZO+oo9HgqU4whed5nQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf stat: Allow no events to open if this is a
 "--null" run
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 8:52=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > With all 4 patches applied to v6.18 'perf stat --null'
> > works fine:
> >
> >   Tested-by: Ingo Molnar <mingo@kernel.org>
>
> BTW., there's a long-standing perf-stat --repeat bug
> where signals don't seem to get properly propagated.
>
> The following command takes 10 seconds to run, as
> expected:
>
>   starship:~/tip> perf stat --null --repeat 10 sleep 1
>
>    Performance counter stats for 'sleep 1' (10 runs):
>
>            1.0026669 +- 0.0000503 seconds time elapsed  ( +-  0.01% )
>
> But if I try to interrupt the test:
>
>   starship:~/tip> perf stat --null --repeat 10 sleep 1
>   ^Csleep: Interrupt
>   ^Csleep: Interrupt
>
>    Performance counter stats for 'sleep 1' (10 runs):
>
>               0.9250 +- 0.0543 seconds time elapsed  ( +-  5.87% )
>
>
> The Ctrl-C only propagates to the <command>, interrupts
> it (as can be seen from the shortened total runtime
> that is less than 10 seconds), and otherwise results in
> both an incorrect measurement and a misleading output
> of the partial results.
>
> Furthermore, the test runs to full completion - which
> can be annoying if you happen to use high --repeat
> counts like I sometimes do. I have to Ctrl-Z and
> killall -9 perf to kill such instances.

I've added a patch that hopefully fixes this in the v2 patch series:
https://lore.kernel.org/lkml/20251203214706.112174-8-irogers@google.com/

Thanks,
Ian

> Thanks,
>
>         Ingo
