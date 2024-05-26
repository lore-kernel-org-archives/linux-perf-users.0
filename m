Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F4225CF
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742423; cv=none; b=AFz9PjsQ0Z/4U4FaXr26l9Gee5DqiBJyZOt8moNLbbKAH++CMmpVftyTsEMFebIGfX0ARX72U2zCQk4lOotQa4mY4K0IrYxpuGOdHLDRrQKbO5j1Qs6/8Nzmiz7quKOxVW6WSD1/rYns5iO/aXErl9UhUIskGRTMxPcP5VLkiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742423; c=relaxed/simple;
	bh=/BKmWWBDfRlEDj7KIrCUITVqOvPtb4QcBiN5AA/liTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6co9MlNvKa3j/qOg6ukssjQMXI1VbhcCbdFgjsu6bH6XYTTY3RyfOd5sLxoxfqsKxEdD99HH1YEPKL8Ci/yx70gErFO6R36VohpM2aAmqENZGpvjXGtLpzdjHM4TKsPTYxXt12B2dbjetGNBwNXJrz3W+UJ91Ejjoc1eKC4cqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RP8A/YVM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RP8A/YVM"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so92536061fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716742419; x=1717347219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KPz8fd987dNAatsylOyQp1D2cGtvz2jm5uP1CPuYGQ=;
        b=RP8A/YVMxPxYCMdO3sc5oQNejfyAG3TAmozX8fQOCZkdzKLPWzjQYMahI+UztVc5xk
         73yViex6GDlCsLjEWgIs0gwkD5X8JKh/DaO2VQ0Rv9Jysn/MJFKEErbLJBvtjuFbtO6A
         oLYyV1Cnhvt9EF7zsNq0ehfZyLblPJxE/6DEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716742419; x=1717347219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KPz8fd987dNAatsylOyQp1D2cGtvz2jm5uP1CPuYGQ=;
        b=OheNI7dyzm64cbwifxw/ouM6SZTIPRO9zRfiZSyEdGCopd15dbgdG2DsE6PO39c9Uz
         DprgIFb95kqiH8dzbjoiDa7gVGpYM2hO7F1rOr6iGahvOD5PWubTz8Vofu6fOT1bxRch
         8QjdfjgVmyCeLXbpZzAEq204pFhIxyh4k+OiiFOShbLXbVZr/mQYpc7rfSqp5nl9glFy
         W384WRLwSVuz3RCU8ekHGDV7qEDsKVRtWdeixNlcHQigDFri96RALCJmzVDiu7tgELkz
         /ELuolwez99XHQZ1efnxtvlNnVCTzxIrjzkl8oQmehu91FThJrR1n08Uu200vwDxC9WZ
         RqVA==
X-Forwarded-Encrypted: i=1; AJvYcCVADUeWydeVdlDxPvbW1yMmh0Qy+7+bN95EM7lX8vU6loWmcpwqhwKi0UjV2RTjQk5vwRY7SrMcRSrhkFtAGzna50tLa4IecWCEmgTvpT+fjg==
X-Gm-Message-State: AOJu0YwXH6ViGmJFJiuUMIDX2+dWWXj5bo+sPhLiuamPE7USJz+NTrrp
	p5snHUN/zvUQnvdjIv2qwiP91/zl0TXmwKR6opNu0lBVy1ka6bNfgYGVQA0A997iUwelzDz3WWl
	xBAVH6w==
X-Google-Smtp-Source: AGHT+IFeUcaaTnlSBYWFPV2r1+dgbY3FDlyaKkgl98avWurN0HXDjzAsy49SraQCfDqV5fNLgA1Vuw==
X-Received: by 2002:a2e:7e10:0:b0:2e6:a7c3:775a with SMTP id 38308e7fff4ca-2e95b277c07mr39972031fa.52.1716742419562;
        Sun, 26 May 2024 09:53:39 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c6c72ed3sm1506258a12.87.2024.05.26.09.53.37
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 09:53:37 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6266fff501so285497866b.1
        for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 09:53:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV430q5dnUKTxG244NMGFN8kMTz9J9rvMDu2Shnc1/L055hERTA8/Pi+dGDyN0osiNcK+pwhvEBpMak/jWwwAwd3oZ5Gkjt4OSdzKTp96WZ1g==
X-Received: by 2002:a17:907:928c:b0:a59:fca5:ccaa with SMTP id
 a640c23a62f3a-a62641a3160mr583334366b.13.1716742417393; Sun, 26 May 2024
 09:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
 <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
 <CAHk-=wjZ2JoyBNFnR-TUc7P8sBL2ZvR0W1fCjcK2R2w7137wfQ@mail.gmail.com> <CAP-5=fXwv0Ec4_wEG2m1X73cpFvEWs2b5GdNnMw7OY7fP6V1tw@mail.gmail.com>
In-Reply-To: <CAP-5=fXwv0Ec4_wEG2m1X73cpFvEWs2b5GdNnMw7OY7fP6V1tw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 09:53:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0OtULpNxk3_vKgmQnMqfOkJ2+_Gx+79hC=bBP=AT1RQ@mail.gmail.com>
Message-ID: <CAHk-=wg0OtULpNxk3_vKgmQnMqfOkJ2+_Gx+79hC=bBP=AT1RQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 09:50, Ian Rogers <irogers@google.com> wrote:
>
> If you think what you are asking perf with no pmu for a cycles event, is it unreasonable it gives you every cycles event for event PMU?

But that's not what it gave me. At all. All it gave me was NO
PROFILING AT ALL and a useless error message.

You're trying to change the goal-posts here and keep bringing up
irrelevant things that didn't actually happen.

I have a revert in the pull request from Arnaldo, and the revert is happening.

                Linus
