Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301D1DFD0
	for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437819; cv=none; b=lyqHKb8K7sSSBrslFr1dhPkTqYVI/jm+aiSsft+XDJmgTCdPdFs5R4ihA59WtdfN9BvJdVT8uNvO+2PNKlUlmIzTFvgX8KM9UJilWV1Qa7+mO+iU0CTZKKdl0cvTTCk8D3oNrB7Tfm407Mg14A/MBOkaSKxGyg+qLZcEtRnwJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437819; c=relaxed/simple;
	bh=HbAQf7KFbsjMBDaWztrsnT4Z/1vTXUjYeF8VX5y4Yz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgOjJEydWcUOWpEhnEp7qzVxc7KQH7r7NBpIJ8qKgNbyMv8BCyzHAYygsIpTcDdXW1/wpisE6HDahanovVQ4RlkeUJXBpswaU/YH/f3YqOq/5ooF3HOxv/ZEJw5i6uGTztIsBcbujY3sLpGO8nsXxOL25tzPcDjfYC5t7medks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3BTS6Cf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3BTS6Cf"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43dfe020675so313291cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 May 2024 21:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716437816; x=1717042616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbAQf7KFbsjMBDaWztrsnT4Z/1vTXUjYeF8VX5y4Yz8=;
        b=G3BTS6Cfpj8PkyS8L2fivfoCSKuiVVkkE1vetta/Ow4C+JdDG2IVb03Ya8d2c87Lfp
         CGgPaoKvSox14SBcTZEofkBoF/gTqUmvqOLOyagsrSZoeUgaQ5ryW8EVbEMT8YlVkk9X
         s4XLvlDnwoe/bUYVzefME+KkDBCIbuc0Tr3DxgEjld3tA+aKEdDU/fOdfdtN0yICr8Nd
         gq2qbj4xJBVi7ZJ2gSc/yM23yrmW/qh4htNY82+EMUhLyIAgsqW9IIO5YhlbOWv756fd
         K/H0OeAYIqMVMt9YK7/Bsj5QBWUf3DkGonL38i2GjRL/o9Gh1icUfKqp9Xxa5COuA/ho
         5koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437816; x=1717042616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbAQf7KFbsjMBDaWztrsnT4Z/1vTXUjYeF8VX5y4Yz8=;
        b=wcof6eybtP09Dti7sfF7ZUk4NJ2p+CQeBQxKCIqoEK0wvY/0aX0GheXl34oVqbaMKB
         jJECBT55CAY6TLGFy1+xHPTpeFL5+yJ2mKe0kBoUkcXEQ6xpDcVm6Q0nrewmRLVPQANi
         xaYlQrUBH0X29rvVO6JyxVPl66NmNpFe0CSLFYn/WxljysUcnu2ilZ74MlGg9eRoOBLY
         dtAjFImNuPlwLtQudb2x5XNzHzzOHsfQAAkHsW0PBDIpOOr7CMibVx8kVPgKenVxOhRo
         QYdkfyucwIBFRIr1a6B5V7Atqui3c+ZpTKMZc/K/N9ad/nTsAQqZizOKyK+J0X3CVa8g
         RelA==
X-Gm-Message-State: AOJu0Yzw00bV7U7ABllbUdxQw7cH+zKIO1WBdPT7zHiIykU0A/gYtxfI
	5Qfvx2schked3GlELEGA1YM951Yn7A6HIWh2tRmmo7VkPwhfaUTEaySXkU3Lk+F7M451HQHtKkm
	D3ZT8AxnGzx7CzqrpKjYP07BFmgBz08nKSPBHVlWBrdb0OwVgiVi9
X-Google-Smtp-Source: AGHT+IEJ7sl61UqFuNkmoJyv4eRWA2t0c+KjkDh5gCTkneOOjn6c90elafdioiaZAdBvgEokKJMoVK1c/6QWVLd5y+E=
X-Received: by 2002:a05:622a:2593:b0:43e:143f:d184 with SMTP id
 d75a77b69052e-43fa74c24e8mr1987201cf.20.1716437816409; Wed, 22 May 2024
 21:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW2-pbOek68wjrEB+G=kzDmo3oPYuFj7iheouTMiaz5rQ@mail.gmail.com>
 <CAP-5=fV5BxH_VMLbumA76Z4jguMmkc9SgduUfWat3ssf_hTy6A@mail.gmail.com>
In-Reply-To: <CAP-5=fV5BxH_VMLbumA76Z4jguMmkc9SgduUfWat3ssf_hTy6A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 May 2024 21:16:43 -0700
Message-ID: <CAP-5=fXE5VsAy2FcKzHROoegJCTmSxkqWuXiib0qCg0vKFDG0w@mail.gmail.com>
Subject: Re: GSoC 2024 contributor news - restarting office hours
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: chu howard <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:12=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, May 2, 2024 at 9:00=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Dear all,
> >
> > We were really excited and grateful for all of the Google
> > Summer-of-Code (GSoC) applicants received this year. It was the most
> > applicants for GSoC and the most we've ever received for Linux perf
> > tools as part of the Linux foundation. Given the number of applicants,
> > organizers held proposals to a high bar and we're sorry for all those
> > who applied but failed to get a spot - we tried to argue for more
> > spots. You are of course welcome to contribute to Linux perf outside
> > of GSoC and everyone is here to help with that. Thank you for the
> > contributions you've already made!
> >
> > We are excited to say that Howard Chu's proposal on perf trace and BTF
> > for GSoC was accepted. The GSoC program officially starts on May 27th
> > and now is a community bonding period [1].
> >
> > In the past to allow an open interaction with everyone in the project
> > we've held weekly office hours/syncs with GSoC contributors. The
> > office hours have often had wider discussions on perf event topics. It
> > is difficult to pick a time/date for the office hours so if people
> > have thoughts on organization then we'd love to know. Perhaps we can
> > alternate time slots, or have more than one. I previously did a google
> > forms survey and a timezone convenient to Europe was selected, but
> > then we had very little attendance from people in that timezone.
> > Somewhat selfishly this time I'd like a time slot that is convenient
> > to the mentors and Howard.
>
> Reminder that we're just under 2 weeks away from GSoC coding starting
> so we need to make a decision on a day/time to hold office hours - or
> multiple times if needs be.

We're under a week away now. Would 8am (PST GMT-7), 12pm noon (GMT-3),
11pm (GMT+8) on Wednesdays work for people?

Thanks,
Ian

>
> > Thanks,
> > Ian
> >
> > [1] https://developers.google.com/open-source/gsoc/timeline
