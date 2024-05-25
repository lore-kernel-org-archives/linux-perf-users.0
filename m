Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2E10F2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 May 2024 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716610827; cv=none; b=qeG9dSfF+mUuOackYHZQikWVVHrHMQ/zl9YjycNFnmBk0Q+TheTHAwcDtQQOt7MNIbLCHNJ+CUZERvykLf/9T6s+vaRr0BMfmZrfN3tp7OCbF0/K5xfncsoOyzEXtBusXssNNkx+hz26yQacSHjSxJksZsQzjVBdEw0uCeVl9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716610827; c=relaxed/simple;
	bh=yUTpSxbNH6db5FAa1/hdQT3OaPurqyv2ctC1i45QKag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQJWt42SqG9rSj8CFSIoEmRS/SzJP3dBSquEjHT+dOQekh3IDwj+b5gFbb3RQlPhkQvt/RFyLPC1NXc95LK030m8PabrVXKgivRKassO9s4IHCvOco0UmyPhpntgutJpeHKbN8vfbM/juA/qqC+soqElvd5UvZvpiSQVgmHF8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y9NZ57qE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y9NZ57qE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5785c1e7448so1279434a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716610823; x=1717215623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LLJmGwspiHr/isf1p7f95VagjPipkZ0Pc2JPelvy7/Y=;
        b=Y9NZ57qEiyjbpuvWkTdJN6kEB/+gqZAqJ+txnoDTseu0WmgmNYanX6/OWCZolfxMQa
         U4KLGMVQWgH1CTtoDSyoBm0DNGrfudbQF7IQ29T8nVD7Z6oxkwrX+XvkRn2xmOuiHXIK
         JMMhO6xwCJ4nfOLwiMW6p/R9ivYmQdzjmiN6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716610823; x=1717215623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLJmGwspiHr/isf1p7f95VagjPipkZ0Pc2JPelvy7/Y=;
        b=aAKzPOy0QeNWXo7olsKnlgxd+q/TZLB6Y3WfBTFutay5OTOEH4gof+GC3fF4jT4R3k
         NtIWTMxl8gakv/kNtUn/Ar0GuNafoC3NAxDB6J9nXGrx+5mcgJ2zk71JIcwD5WjkrKcf
         9FswCtOU1dqOcsLGiO2uyo7RDYSe7gdJd32OlSkNuE09PYGqjX5FFK5TVOBC6BYPQb6Y
         znMAX4ynO5BvUmKgrRKTFe28L9y23CitTEmJ5sUPQSr5Nq/dQRPz1m1ALGgd/YZhU+IA
         tRzSA4OzaBpBA/k2onxmBwjnT5v5k1YL8K55HmjvTIvM8vpGzrrttQboQxyUhuQQt3fu
         8dJw==
X-Forwarded-Encrypted: i=1; AJvYcCUX1GLgeZra2z0m11NWgyCE9KfEK+CPTu8+kd0O7fbuN9ASyI8zM8G6q2TIUv79mSJEqwLz8W0FDGFVZMocoLTAJEg0Va9w3ixrE2jR2gCX9g==
X-Gm-Message-State: AOJu0YwCiIEFjR0mT3ns0nQPz38ldXungwCmaY48K6yzh6wVHay2ebOO
	PKkp2Dyd1tt+JHBl4vHOt6sZdzGOWDTY3jwRCVVK4aPc0RBGpkuq/+T7pFyJvqyYoo4B5x93zYh
	dxrKFag==
X-Google-Smtp-Source: AGHT+IFfQuJlPpMLDThlZnVgQAq5w4zkWI2K2Baq0wgYno+LzMsBxcEg/gc832MKLaTx0yFD+w5JwQ==
X-Received: by 2002:a50:f605:0:b0:578:5d83:baf1 with SMTP id 4fb4d7f45d1cf-5785d83bfc2mr1785734a12.2.1716610823382;
        Fri, 24 May 2024 21:20:23 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524ba262sm2689280a12.87.2024.05.24.21.20.22
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 21:20:22 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso141407366b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 21:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMOGASyJZru97RV1lnMsL9MwNxqp6OTi/MB8mPiOsf9Hp6IuZ89kE/6GsOnhSmaO3EfqCweMjjbKZ/FI3LOTf7TPrVrlCiSG7voWpwijdfOA==
X-Received: by 2002:a17:906:28ce:b0:a52:6fcb:564a with SMTP id
 a640c23a62f3a-a62641a8d45mr253718866b.9.1716610821954; Fri, 24 May 2024
 21:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
In-Reply-To: <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 21:20:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
Message-ID: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 20:48, Ian Rogers <irogers@google.com> wrote:
>
> Thanks for the report. TL;DR try putting the PMU name with the event
> name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
> armv8_pmuv3_0 is the name of the PMU from /sys/devices.

What? No.

If that is the new rule, then I'm just going to revert. I'm not going
to use some random different PMU names across architectures when all I
want is just "cycles".

In fact, the "cycles:pp" is a complete red herring. Just doing a simple

 $ perf record sleep 1

with no explicit expression at all, results in that same

  Error:
  cycles:P: PMU Hardware doesn't support sampling/overflow-interrupts.
Try 'perf stat'

because perf *ITSELF* uses the sane format by default.

So ABSOLUTELY NO. We're not changing the rules to "You have to know
some idiotic per-architecture JSON magic".

I don't want any excuses like this. No "You are holding it wrong".
This is a BUG. Treat it as such.

And yes, "perf record -vv" shows that it apparently picked some insane
arm_dsu_0 event. Which just shows that trying to parse the JSON rules
instead of just having sane defaults is clearly not working.

So here's the deal: I will revert your commit tomorrow unless you show
that you are taking it seriously and have a sane fix.

Because no, "You are holding it wrong" is not the answer. Never was,
never will be. Things used to work, they don't work any more. That
shit is not acceptable.

                   Linus
