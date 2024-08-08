Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71586140369
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141523; cv=none; b=ewrHEDQ8AYUbH2moz0fcosNQIpo1maoIsAnO5jSEqa7Fdbc5YmU9u8Yv93X7ZE+oZp1U6PxHOwHULM1JXjOehdegEAFn3t/YKDVycPV7UukuhGrwjUnDij76oQPxT1Nr/33vzswE+m50JbT2bg5nJz2Fo6O0LF8aGMthW/df9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141523; c=relaxed/simple;
	bh=7VRSY2ymBXVOoiRb8UqXuWipnl3YLdgTpqpbVaaOZ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RhjrJvJV8P5WHboA6feB6N8w3DB7SMElEANNEiLtfFNvr7xJIJTKVuHJfLPz0s9TPsNsWh9Vm5CPZwaKwFvjSjN2CTlGyslIwZ2dFHf/ttwrr5vcWTk0vD/HfVYiEKC9S2IOQA7+6wluCD/9+fU+PauiQyGrzhcXZme+FwEaLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9SFiQmO; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9SFiQmO"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39b6493b7dfso10495ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Aug 2024 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723141521; x=1723746321; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VRSY2ymBXVOoiRb8UqXuWipnl3YLdgTpqpbVaaOZ24=;
        b=y9SFiQmOJbE5Dneb2A4Vf3VNorXekHOdH7lq9zkXbhR9Mtl0pmwRyuUdK624fOSVEs
         GDXMzAV73cEpjYPmv+oLGbUWae1LRgNTTip/rKPIOvGzRoOa2aX4FSagO2yrUS4VB8v/
         wyr9678FKFQMpNcqSDsHvI5oklxLiOmyoT7ZZmL621pL8PJlEUdTrn5v6dr3AD60znrD
         eaQZpO4HbZm9vUfgQVOaJLnLDwwVIg4hEJhg91WDmY5afEvxiPM5FvrNzaguvU/ZRSqC
         0Y/i+4bA7QiOvdt7yfX/syoEGpWpezgpnXUQnKTeWBpeaWrSAgeoSBAk10dCPHEBNYeF
         dDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141521; x=1723746321;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VRSY2ymBXVOoiRb8UqXuWipnl3YLdgTpqpbVaaOZ24=;
        b=TmM33TkaAta3WwRYAnKgmmTR+6t9YVITk1kqzZ+Sj8ZHiKQief9H+rXf9cFiUbzKgC
         azLTT7fFFag5rL5anBX1cXYjXcQ+PqM6Nw2tVse3HLU0c8JJSCatcdgGEgyuXt8tZBo7
         lnsx8ubjEb1A+pAeqZ5Rm36NzHNu1ki9EnrI67yAnoSVbo39AIZC9dKUWjGsl+g00W6Q
         zD8bgb9UePLR/XfZaUD+52/eXNYyI0GwodhaVX12k7bSKijU1grgjCJwESCIyrAJCysm
         BIJmiF7dPVAHRtNzeb0pJFsA8QMeIx1pmD0nro0IKoD2FMxrt/NP6pAK2PhbJczC4WjN
         PaPg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9Z/HIT+THOeYpXdg3+SwdaEOvD11oz/cx8yqcNeZQBxVu0Rta0cfdEhMZz1UPCG1PimfZ7l61NOshrboNrMabbxRA9AOLiX9wyJHdjnqAQ==
X-Gm-Message-State: AOJu0YzyDSkEtvslod8fKA3CFKyfOKM6PivYTbP3oJPESuLgK2hrvb5O
	1w9D2o8npchEeytJr0rnB5c5upzlw8fbsMVeuP/csPKNbz5a+Cw1gwKA8RdnZdiuLmtObbIVpOO
	MlUmhz9vCRJ8+kCagVj9HJuK5LTCIBscpEcv8
X-Google-Smtp-Source: AGHT+IHBMLvsg8UtSpRZlzilWpDV+FsaMxgZo2WbzXM7Yeoe/Iqg4K7SBE4tfQ8cpOuF/9ETmYfMcZKhj+Nqv1Bl2po=
X-Received: by 2002:a05:6e02:1d08:b0:377:bde:8f1d with SMTP id
 e9e14a558f8ab-39b66ec83edmr301165ab.2.1723141521119; Thu, 08 Aug 2024
 11:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
 <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
 <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>
 <ZnRP4hJLcRpZzs4x@x1> <CAP-5=fVtutBamCT9VJNJv+nXB1VMBZ3V9ed-mAMtWNaVbygvHA@mail.gmail.com>
 <CAH0uvogumw30VSAjX_RmmxABLsvD_FhEUeUo4nNE6vwBNSni1w@mail.gmail.com>
 <CAP-5=fVNC-bBvkg851705msG+jA_Qu8HNPPX1evqDD6TM7ZrVA@mail.gmail.com>
 <CAP-5=fUSMDhooNetywiLfcYEHMPeyPaGHuBhJHUb34zM8DqtQA@mail.gmail.com>
 <CAP-5=fUbJcxO=h65bqZ2nx8UTPHsapOVsfcCaY=+q4yO9YBY-A@mail.gmail.com> <CAP-5=fVazh93ZRqyubCC1MEE-thDKoamO-L_d0-LZjNyYmD0vw@mail.gmail.com>
In-Reply-To: <CAP-5=fVazh93ZRqyubCC1MEE-thDKoamO-L_d0-LZjNyYmD0vw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Aug 2024 11:25:09 -0700
Message-ID: <CAP-5=fU4fwZdWNXbCKjs5+T4G2NnfibyhXFfif130vKZwyYcBg@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

A reminder there is the regular office hours tomorrow:

Linux perf tool office hours
Friday, August 9 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian

On Thu, Aug 1, 2024 at 1:15=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Hi,
>
> A reminder that there are office hours tomorrow and we're a few weeks
> away from the end of Google Summer-of-Code [1].
>
> Linux perf tool office hours
> Friday, August 2 =C2=B7 8:00 =E2=80=93 9:00am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/tif-efem-uiq
> Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
> More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256
>
> Looking forward to seeing you.
> Thanks,
> Ian
>
> [1] https://developers.google.com/open-source/gsoc/timeline
