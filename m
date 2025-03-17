Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CC24BD02
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226186; cv=none; b=WUYVbj0B+CmRQF0/n261PGa90njqswGvsP9XcRtkVCxa0byrF1sjlYa+L6bfeBSchjImE/4cpgHUOt8NXuHb9+Izb/57axgWNDlGZs2wdUrpxFiAJsmGWxgBIGtgsHAcYCj58zkd8l0LEaqapyuEIA/fuDgPa8X8UyxV7nDjr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226186; c=relaxed/simple;
	bh=DVNy0mGfrLWmMLfG96C/e3PV0BWGxFYi9QD95q0Moac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDuVvMD9fGYdovj3u12gX60ZPYDXIDv9ki8QgXH+At4I6qpTWLWdYtFfg6Pkonw3l5um0wnGZF32ltcXpMttGC+T3NjEyFrk+E1cwFk82w+D5a0NCOYhp0/TT3IguJg+3AMxz115q0tBLTDdLsIaqYyWky2jCIMd80a6QMBw/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7iwklv/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7iwklv/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso21195ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742226185; x=1742830985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVNy0mGfrLWmMLfG96C/e3PV0BWGxFYi9QD95q0Moac=;
        b=t7iwklv/f+kyoNcGMJe7wjst6JEY52GB0+C+UCoS686z2CQcDjYj7zHLKmTWY0rYK4
         /DH03ueJE2b6RNF6akAxOjes9FwZcBwoqBdIzOptfBmlLaEJNXG38bzFQcQFneayJ/OT
         hpe5kaA+0EXcsk/+ktBnkQRuvwGQv1hrvoidBP/mMVi3AhXaoELmLi3EJJVO6y99NnwU
         /UJQiDP539PNLg3Aw15h9z89l/XAbbPMsOwsKsNdQcbwSuK3ssn1pKuSMWcUjlcwOK2u
         ukq6wADTRev4mxcqY+3mtWI2Dcb7STYc8/0tnV9ykf2UtW4BCLxjXoUnI5LEffouxTs8
         sEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226185; x=1742830985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVNy0mGfrLWmMLfG96C/e3PV0BWGxFYi9QD95q0Moac=;
        b=ecTgZt6IaDRTEF6SlgU6LQsoK5c3MCnFgpS/KOc8kGGEcrCqDDsMxJLWrWM4Mep6fi
         /9d4twMZ9m0AxZAStvNOyXaeX/2222ZUbQJubKu99kWOESHZNhzyP6QRkw0tgaWuYskF
         eFpnYwFy6MnFvh6iHekB1rNC6+gkKbV3o31LiQT3raXDhYHW97bu7FUucT8DoCQ+cbkJ
         lctiMeB0GFPWHtZyi4x7KVB1i2iroZ1bh6JaLgossKr4NiNu8hZll+Jn44y3eG0tUwas
         RCHZVrIJw6tPjsSjXPkyfd07CgoukSupsVyDJT5laaYrLDhge1Fa6SflpEaBSEBxhLA8
         r0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUcESodFQPZCTI7O+u8BxGXcuqmOgxRq63BwVOJ4ImZ1Sdvs5SLdq2aBKnZlsznaOS0zwcQRVW2xweWXbcPGgCF@vger.kernel.org
X-Gm-Message-State: AOJu0YwutJxqrRhFa7B+DMQNARQqy4fswMaxl0lu6Eo/HmJzMC/kRVvA
	7HFkhk1dn/b3lYEFl/aPyHeH91NmBr/4KBDEN//XESQ6uvqrlE5hnul8HFBSAPaJYna53vgnJl6
	xF+WHXcyQRPUFn/F/hhlWTaaDrKcxHIoTQvAE
X-Gm-Gg: ASbGncu5oORA4T2zuVfqNdJBeKn8R5nHD9QxBkDxATELVfLPhYaAYRDNsajA0M/KZBr
	OzzP8DA7WnrcBU32FADPZv3jxy1KM8rN8wPsI9Ao8796j00PobTbHIyl9D1KkSH4nRd2kepvies
	h+96m7nEmJgQnPW1mHsC6NHqKXKmRD3pY/5rY2l0TMl/ujTkjjWniIdfitH5aBSSOOvQ==
X-Google-Smtp-Source: AGHT+IHpSeYx6aY2+0dZ1l/rPLNoofBXCsF5QSC+l9QPf+nZIcLzU7jjaGVFsYZoKfMU3S4nM4vf5vZnj+n0cc7PG0w=
X-Received: by 2002:a17:902:d2cf:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-225f586fe3emr3863375ad.7.1742226184466; Mon, 17 Mar 2025
 08:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
 <Z32EFouwz3IHw8h0@x1>
In-Reply-To: <Z32EFouwz3IHw8h0@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:42:53 -0700
X-Gm-Features: AQ5f1Jrf_NPH7lzzNyHvt0BDDRHgeAY6q6IW07sFrM7dZmGLUZkeIjnXd3VDTVg
Message-ID: <CAP-5=fW+HDfNcpTkjPwSLezP-XTj9hkPLrwia_JryCr8+Ro0qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:44=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Nov 06, 2024 at 12:30:06AM +0000, Chun-Tse Shao wrote:
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add config which would be useful.
> > Testing cycles:
>
> I applied the first patch in the series, that already helps, Peter, what
> about this one for the kernel?

Peter, did you have any input on this? I think this is simple value
add with no real downside. I kind of wish the patch did more than just
dumping type and config in fdinfo, but getting those two is a big
start.

Thanks,
Ian
