Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4B3A8E4
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753586; cv=none; b=V4eXr99S++iNsZKSEgOUtwWg5KEGQ/INRlt23VQ8j1G//FWZFtzxNHoP3dEtiYeO3urnCE5siUsRffCpxov2+QuVnR3ql5mlH6CGWzKI+w6Gxb7L6+mPnqiIh6ug/iBeaWPsTNG1q1N9NKnix/BexYQsnHfqnI1urYfsUtqQoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753586; c=relaxed/simple;
	bh=woN60CSEL3yeZlojsxHPL/F4PGAMhm9ZAr4vWsJq9ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5mSBTivqoXX+oZapAVo1yzQDx7QDYzEL28E+dQBUsH9O7MzFQFnl1EL+JEkb/FwiDtfhv8FGde37PAMhPzk/qGXueN2FFaACOWISAkCS9XeSkRYYnXNaQc65/5gz3ExhWnj8H/UTeHIYMyouySTEM0IbybnadbufzcPi9KmW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9UiGmk4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9UiGmk4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee5f3123d8so619765ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 23:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715753580; x=1716358380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woN60CSEL3yeZlojsxHPL/F4PGAMhm9ZAr4vWsJq9ps=;
        b=o9UiGmk4ISrfSjbdalt/Iwt10Qxoa4I8SON+IKktbherpbLXduxREpylBHGNin5Pt8
         VDSaSFdC52nvVwN6JQdbb+yBh41uP/hsUVhjG/7X/MZuUi1JvkH3LYylv3tFkfv/NKxS
         3Sii7puJyH/iAFlP5nSkyo6zQuZbEIG1gl35c052iHY7G8bp254Nr6id2r1i0zNWhvQw
         Opysr+4nlCaEaOPH9QsRXg4iP0e5LZgVyCT5KGxmiewwZyMigRX/pfAg7RBG06WDF3Us
         rfjP+tbHvFETS31dzvu8jB2sZuEODEiSYguvwGdhUNmbOMYwVGoN5oHYX+SFDiVqQdAg
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715753580; x=1716358380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woN60CSEL3yeZlojsxHPL/F4PGAMhm9ZAr4vWsJq9ps=;
        b=QqDsx1uccMSCymeyHzqPrzy6SnnhYCcJuAoQ1xItJrSyQzjBt4s4ogI2O22lnDrahl
         FvQ/dg/tSDMd01DnW8h5wu8Xx1da8Y2jbBj8/2ppizH6d3jCCXT0B9m7EvnmeTMk+/09
         Ou832Fxlej0RLV4GWFBlT4WuuSjtFSbKumgexB6RXDrKQ5BnaspiJqvV0nHiBr69Fk/M
         v7ovxQOYyk/aKPkbIUTgo/xMigJWxeqU7XRBght1FTterQZSPKuZwO9dul5IFS3xvUKS
         kMBhv8dPEr8kLAX9PaLM5WkWKFxITwEoQo9is+4fsxZRDbU5Cl19h+XtBLQfPkeh186I
         1big==
X-Gm-Message-State: AOJu0YyFrPiRLOKZ4W8uhgSwqYxYHesuSI8qPIHZ9CNt4dp7IoYTAg8z
	kR0GOCydVOKOABBzoe8li6VN36MkoxRVbv1GJ9taGc8X2/KM2S5qEHV2WaLZuy3HM18A75Wc1E9
	XWJHnhfW9dq8f8eCZo1BP+RcIAl9wB9IIEZ9EU9T6gxZw7OGQfA==
X-Google-Smtp-Source: AGHT+IE6WgvdtrIzadUR1fBM7ss6zcYUqFUKgUsUMyhyhovQXFeRtUBP/WuQg/k502boTL3AC+85GEu64ZgUgVZ46aw=
X-Received: by 2002:a17:903:1111:b0:1e2:1955:1b1c with SMTP id
 d9443c01a7336-1f060c3099dmr8390945ad.27.1715753580084; Tue, 14 May 2024
 23:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fW2-pbOek68wjrEB+G=kzDmo3oPYuFj7iheouTMiaz5rQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW2-pbOek68wjrEB+G=kzDmo3oPYuFj7iheouTMiaz5rQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 May 2024 23:12:29 -0700
Message-ID: <CAP-5=fV5BxH_VMLbumA76Z4jguMmkc9SgduUfWat3ssf_hTy6A@mail.gmail.com>
Subject: Re: GSoC 2024 contributor news - restarting office hours
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: chu howard <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:00=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Dear all,
>
> We were really excited and grateful for all of the Google
> Summer-of-Code (GSoC) applicants received this year. It was the most
> applicants for GSoC and the most we've ever received for Linux perf
> tools as part of the Linux foundation. Given the number of applicants,
> organizers held proposals to a high bar and we're sorry for all those
> who applied but failed to get a spot - we tried to argue for more
> spots. You are of course welcome to contribute to Linux perf outside
> of GSoC and everyone is here to help with that. Thank you for the
> contributions you've already made!
>
> We are excited to say that Howard Chu's proposal on perf trace and BTF
> for GSoC was accepted. The GSoC program officially starts on May 27th
> and now is a community bonding period [1].
>
> In the past to allow an open interaction with everyone in the project
> we've held weekly office hours/syncs with GSoC contributors. The
> office hours have often had wider discussions on perf event topics. It
> is difficult to pick a time/date for the office hours so if people
> have thoughts on organization then we'd love to know. Perhaps we can
> alternate time slots, or have more than one. I previously did a google
> forms survey and a timezone convenient to Europe was selected, but
> then we had very little attendance from people in that timezone.
> Somewhat selfishly this time I'd like a time slot that is convenient
> to the mentors and Howard.

Reminder that we're just under 2 weeks away from GSoC coding starting
so we need to make a decision on a day/time to hold office hours - or
multiple times if needs be.

Thanks,
Ian

> Thanks,
> Ian
>
> [1] https://developers.google.com/open-source/gsoc/timeline
