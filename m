Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E892C21F9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978308; cv=none; b=iVbvHquXDrQlwuE5LLdO5Ai5pL4vEQuT4yUsYoeHDhHjgXVNVKcJX1+C29XbOvtO16DGCeqPawUWXqAe1SnzgKyimkFXUBU92kndBEr2rF3LZjLBkzyhoYcBdmRirqUuuO/GdjIqKnsRKODQyU75M6umggzPyiiEDPaYGGaeHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978308; c=relaxed/simple;
	bh=6V83vs4OseDoEXnLYFKKGe/T8zwblMyzD8l0D242nuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwhAgstehyQoCARqUPaSPiSScR3QhOt7e6+N1MxJJe31PfgIWx2qm6TQJAMqEme3q8INRX4ePdYTQmGEjCI+A+/jXL+CzgVF8INWarwUyvyGnx33LyKljidRAdiAmkujiX+vMviOBUDFKyWtADY7mCkEzIoy7aZLdBCUG5VOE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meqyGDYK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meqyGDYK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295c64cb951so71015ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 15:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764978304; x=1765583104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ILcWfjKMNoJXlJfaJJTc4wTAkRHb0gA7IkzfFdqmbw=;
        b=meqyGDYKMp6Gj5oOhjj55SnSQpx3ma17ZEtEX1zE5nExF4SInwEkkviqJS6pp1UW4n
         eBassTDqayU5NP4TjU7thFZVelrAN62AhWJo9X/+V9CyQRXRzqYu6NwJC11vy35FSR1P
         o0xuMnepu43LiwXRulk7zYartLlbS/+emmrd27H2czTQKFqnI9QjOe4aaWWHktXUHWtM
         VxhtB609w82yW1GMlFHMitDMAPdDtyfppm7FY8egUX2ChUHccatU3a2l7hGqwibCN12p
         V3MQ3TFL1MfWyNhlN5NOMJD4jVwH5YuexmSpI2FEBWklbzT/DmS8AvOnnlNUu6giTESD
         QqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978304; x=1765583104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ILcWfjKMNoJXlJfaJJTc4wTAkRHb0gA7IkzfFdqmbw=;
        b=NoRXR/QPLfjia5rsY/MEwGp0LKUzWHjmadiVGl9ghufNl3y2JjUpE5i5n1fSzihNsS
         wJ/SagDbtVbUqXYMFo3rwARzC7itcAJ4Mg7dBhSdW6ashWfrg4lgKtenALgKc3BNlqz8
         u5HKcPvIhdUQuzHoqrO2z/1fLZqn18beIfOcSPeEuATN+JT6edGeUEzt3PJQQiR4Br0o
         IgJ3IAkaPz6TjC/xrrXrp+spAyaIbZbbinTvyz50KgDVv3pp96qpQ/wC4Fqb+g+FNQLn
         9/gTVc5RkzaDJHPzS+B6QHUlufsQ1OsQbDjDFLIxiXFUPKoirq80so7dCNufOGtxRFfq
         UJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWfJnEYCiJHxL8n6bSOvpW73DyegwDxqE9HIEFHzPWdlN5S1of7fUo/Uc0gw0hK2TaBzxTbLmX7QrDTzERfZmy@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1Du59jdsC/mS3k4xNg4VbTcCUI7kbxKSFikUruF+gUNvjhk0
	mjF1Ma12gN0vmVBcIKZRhNHDsotP0VJ1ZPk6IrXBdhfsLBE5IjzEvh9L3+gf1S66KoftKS1TKZp
	yI3AAicUU8qLYAXociOBsny+gLigIOxwOSjGhrZ99
X-Gm-Gg: ASbGncsl4CONVTGDi+h0YUjp7eRAVmiTAgdNF/ulrMAySl66e3O80hGJBFVFBgvgbPA
	4uVy50mz+Hy5FhhUZSCCjTK36XROhva/YgTm342LnQd0s+Zz7KamNzMw9Soq8CVL7uxShLcCcMm
	AIkoeCebgiBLhyhvUKf5XrLxImYlDjpyGc4dsaaZKi4lIpir6VWTnrPYPbjyocakvG9rdNjwIzF
	7/VXQxbD9Fh0Sz/dpSwa9E06Sty+roP9GaDLWWk6S98nig24fvXni6rHU7t7muIGu4ZMpwmDsNf
	eiPR8yfQkwIMDwksKAjCv47xaYtMAkHtJxWX
X-Google-Smtp-Source: AGHT+IHA3hb+JCPrGLO6DaRLNQUw3ZTc5tYi2kLfK+9EXzOY4YJY1xKCr0mPguNT3r5HpoFEBrOxBOhINUdITUHb/5s=
X-Received: by 2002:a17:902:f683:b0:29a:7af:b3c9 with SMTP id
 d9443c01a7336-29df4a39f43mr1051545ad.16.1764978303308; Fri, 05 Dec 2025
 15:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
 <20251118110309.GP3245006@noisy.programming.kicks-ass.net>
 <20251118110417.GI4068168@noisy.programming.kicks-ass.net>
 <baf8aceb-5caa-4c3b-80f0-43a4a1449a23@linux.intel.com> <20251118112406.GH4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251118112406.GH4067720@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Dec 2025 15:44:52 -0800
X-Gm-Features: AWmQ_bki9q2cVar7Km8bYLU3UKepdSiTSHOF9CypaH1gp1AO-vcr1Ka_1ISAY8A
Message-ID: <CAP-5=fWg9gNW5OZV=JD7dcpf-FBtKXLCR_0Caz8a=SxbvNQ-HQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
To: Peter Zijlstra <peterz@infradead.org>, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Nov 18, 2025 at 07:22:24PM +0800, Mi, Dapeng wrote:
> >
> > On 11/18/2025 7:04 PM, Peter Zijlstra wrote:
> > > On Tue, Nov 18, 2025 at 12:03:09PM +0100, Peter Zijlstra wrote:
> > >> Also, the few comments we do have already note that ->del() must do
> > >> ->stop(EF_UPDATE).

Hi Peter,

I was trying to do a quick sanity check that other callers of stop
were passing in EF_UPDATE. I wondered if the case of
perf_event_throttle_group with leader sampling has an issue? The
throttle should only happen on an event or group leader that is in
sampling mode, but the group members could be non-sampling with leader
sampling. Sorry for the noise if I'm wrong on this. Fwiw, the other
uses either pass in EF_UPDATE or I think for  __perf_event_aux_pause
and  __perf_event_overflow the problem isn't relevant.

Thanks,
Ian
