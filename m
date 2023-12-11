Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMM3Ccst"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2854E3
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 13:25:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50d11bd3144so923e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702329933; x=1702934733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5yenaQ1ff/Vs/GAtNYvSgpQQRs4dIvKBnG50jts6ek=;
        b=aMM3CcstV6MBlzz95Zqj1o6hp6gmqDYLzm1accsfakElEdJxAhc88A9laPwbYgD/Jo
         R/AtK5pU20csmPjvUwtvvGeXpesTlyra21xDuH1AiGKe88QOlb9AdhiCMHtkMggMZh//
         sivJvhDaqwppZvGc7BtNxX43hn7LnGegng23NR4ntQOQa9ICObwIJhmBrXw1/6+5fvuM
         icFiMEGIkzkb1ogylepaIxtgWwCXGq1tJebzsjYxcnIlq6mGoAoPKAgy057c4Dux5K2i
         LBTJ7ZqrxhRGKWl6MQL+N209+745hacrQ5Tka1GKmJU+Rjwiq/Pfm3eZJqspUIfQSh87
         n85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329933; x=1702934733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5yenaQ1ff/Vs/GAtNYvSgpQQRs4dIvKBnG50jts6ek=;
        b=nTvpeqm7W+Lk9pS7KZNzUOwaaDd18EjsjRKzDdf1hgE46sDqkWIet/8LOS7K2NE7dQ
         x6TUXcglX69KFhKg2aQzry6+AzuVKzuvYY/H+fNZWXw5+iAJaoFfd/6knLE4l0benwVU
         nnkCkdJ9U6gnaq77samwLtx2kR35QPpdZdf2JyEAldtDzC17Q6UlQeho7f0jwXN6Bch+
         fmo/dB2Uf5Co6rH1649Mgsc4nBNEpwqNGT/hh8U+aCgqQPTdoc50rRay84sVxHft6EdG
         JvW0kYslwJotjMdZXzIwM1bfIr7EspCYud/gHAze9/tED/Yz1g56FtXgMXPKhO0e2E4E
         xnYw==
X-Gm-Message-State: AOJu0YybMfr9JIM/Dqoc7g+RvW5ZPhBX3dQQkrfCnSPAuU7q8tkvaGdW
	NOuLVBqYy1GX3BMhB2muBMjn1no9gdvHAjRNBCCxHA==
X-Google-Smtp-Source: AGHT+IFYrVG60A2sb1bXVaM+XTQlBKO8d1MrNroldDRxY4aQAZsWQRnta7tn8E25Qimvi8SEbwvzVApnV5UhwsUPDUo=
X-Received: by 2002:a05:6512:292:b0:50b:fe63:f06 with SMTP id
 j18-20020a056512029200b0050bfe630f06mr179410lfp.4.1702329932664; Mon, 11 Dec
 2023 13:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXNnDrGKXbEELMXV@kernel.org> <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
 <ZXd64qLLDTEJjSmb@kernel.org>
In-Reply-To: <ZXd64qLLDTEJjSmb@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Dec 2023 13:25:21 -0800
Message-ID: <CAP-5=fUTbDKKkWW8P59B7fSorkWMhw5d0FayXYS2LzqDhmSqrw@mail.gmail.com>
Subject: Re: 'perf top' broken on intel hybrid systems
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 1:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 08, 2023 at 02:39:37PM -0500, Liang, Kan escreveu:
> > On 2023-12-08 1:57 p.m., Arnaldo Carvalho de Melo wrote:
> > >     So I finally got a recent Intel hybrid system:
> > > root@fedora:~# grep -m1 "model name" /proc/cpuinfo
> > > model name  : Intel(R) Core(TM) i7-14700K
> > > root@fedora:~#
> > >     Most things work, but:
>
> > > root@fedora:~# perf top
>
> > > Error:
> > > The cycles:P event is not supported.
> > > root@fedora:~#
> > >
> > > root@fedora:~# perf top -e cycles:p
> > > Error:
> > > The cycles:p event is not supported.
> > > root@fedora:~# perf top -e cycles:pp
> > > Error:
> > > The cycles:pp event is not supported.
> > > ^[[Aroot@fedora:~# perf top -e cycles:ppp
> > > Error:
> > > The cycles:ppp event is not supported.
> > > root@fedora:~#
> > > root@fedora:~# perf top -e cycles
> > > Error:
> > > The cycles event is not supported.
> > > root@fedora:~#
>
> > The error is because the perf top always tries to open an event on the
> > user_requested_cpus, which are all CPUs by default.
>
> But what is wrong with that for the default event, CPU cycles?
>
> It should work for all CPUs, its the most basic event, right?
>
> We should have a rough idea where CPU (no matter which CPUs) cycles are
> being used.

Generally we wouldn't want to aggregate cycles events on two differing
PMUs as the CPUs for them likely behave quite differently. Most of the
cycle event opening is now done by parsing "cycles:P" which will give
two evsels, one for each core PMU. You're right that the correct PMU
can be determined for the legacy events without an extended type if
the CPU isn't the -1 any CPU value. We'd need special parsing to make
this work in the context of perf top, which doesn't seem desirable. I
think we should support wild card PMUs and fix the CPU maps like we do
in perf stat and perf record.

Thanks,
Ian
