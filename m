Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129451AF6B6
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898054; cv=none; b=Ha2/uCUAxWmfFYCMjl6QyhG6R1ZYaEoijE/8onNBFl10VT1P+TuVLD2yzlUTEfXjj7HI6VBS7IOtpZHKmnv1gwEEosOwnSUgdTTsuT2Uca8Xet/YqS9eb8q3X2kSncWVcnH1btLM7IbiP4tG3iXp1stq743LIXodzHM8r3DW/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898054; c=relaxed/simple;
	bh=4SnAKO/oBe4Pbp/3Xvxn/prOOFeAbFdWZXIrWtZhNGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhDcR+sFeyMegFT0uektcSq0fgNxRE6RpLT4MoDrLYLR45FB0X2Yio2303vtPq8M54fWttEjZDPxJYzbfhhlhvWA4G08oF9fBFa9XAv0GNHjKUFZ//XZ+3O8Fpyb4fB886/scXawQVf7TqFDemn2ZJFSaEdIyxULCEBxn2jYIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQFtx9e2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQFtx9e2"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-63bd10df78dso9563207b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718898052; x=1719502852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SnAKO/oBe4Pbp/3Xvxn/prOOFeAbFdWZXIrWtZhNGE=;
        b=kQFtx9e2WETu9K/raeYIVGkHUvV6WilHOnY2CgOYz7AGG235BYJ+RZUcbEJksXxRfs
         0p4Uyx/L1Opk/X+K/14m6JpCyozWEu1s2TF4spDUd2BICHXM6lnm2VEgu3ZYCyOhCwqo
         Voe98XTphIl2hbATFcTffemkWc5oes5VpuFYtrKn0O8JmiFR/aHF4w58t3ce0/lMN1wt
         qWWleL+rSbKRlt2HwlRcS0E4JNwurdnIghisToQMPI52/Ygk8AElITxeVXFW6X4xLbBk
         zZY+eXliGlb9mevaXXT1RFXoqAmEaLyR5IlKjMgu4dRhZVafmMWfnp9XBO0eUrAVRjO4
         6wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898052; x=1719502852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SnAKO/oBe4Pbp/3Xvxn/prOOFeAbFdWZXIrWtZhNGE=;
        b=baSUSxt9je1iOvft2QoCpOW++9/zCaf7CrlAiyqLfmeGbHkUiZpk3k/XGNBzlLVwvn
         FaSWcAI/h9qZ/HVEIqTQ85+uev5sGit1PRo7Lxcrsz86gXXNsAj4XVH0+H1SNx+1fRn6
         mThkLZhq68CqG4+9IYMyIRX2gmFIcC7768Ge0+M+6E5A/HKW47Pp77FkTCmoE5zGdsty
         avhurd9uyFt1SRpycvUpFD+rHX7NnZFJudcx7lHsR/YphCi22XqBTSZFG3EcPqsVYBDd
         U47sWN54iy++3uCPb1vO1K3cG+uQPlU6M58lHbqhP5qhYc1HjCnFWrEhlbSYND6h4WH9
         8nTg==
X-Gm-Message-State: AOJu0YzRzLI0/0IYLMOO4ZYipJCrCwUblNqmDE14x5EhMZp165I5oU12
	KnzArDDppxNg0oiVvyHYhSiUufCQyX2dfmeLn3ugDyUHg/G+I8Eq2UdNRSpUpL1nz8Vt1NtL83W
	DfjZr5DtmGW2d6JXrkimzEdcQk1s=
X-Google-Smtp-Source: AGHT+IHm/j4D4D+7wIiGow3ilkMwfCV2W2nOQqIQzgmrYVCQ41waRzKm5L0TJm4Gv9y+ogfMqohKnZgCRD0Q7eWqJTg=
X-Received: by 2002:a81:be16:0:b0:627:88fc:61c5 with SMTP id
 00721157ae682-63a8e0e2c42mr55243297b3.14.1718898051978; Thu, 20 Jun 2024
 08:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com> <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
In-Reply-To: <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Jun 2024 23:40:44 +0800
Message-ID: <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Ian is busy so I'll do the announcement.

4th week of Google Summer-of-Code. Office hours this week are the same
as last week:

Linux perf tool office hours
Friday, June 21 =C2=B7 8:00 =E2=80=93 9:00am

To join the office hours, use the link below:

Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Howard

On Thu, Jun 13, 2024 at 9:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> 3rd week of Google Summer-of-Code. Office hours this week are the same
> as last week:
>
> Linux perf tool office hours
> Friday, June 14 =C2=B7 8:00 =E2=80=93 9:00am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/tif-efem-uiq
> Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
> More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256
>
> Thanks,
> Ian
