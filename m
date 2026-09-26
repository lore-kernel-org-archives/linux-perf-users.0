Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105728DB55
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434850; cv=pass; b=PIgvpLPmwdNqnfDsuBaHYA/TuenwmL4044pQaUT08ppkdZAz+FpyExN8hgdtq+JmAfivjLeThIXou25RcF7YAm0HVoxZw2iHwWk55zsN6VnYomqJqvHHe9wrABojCOFUjpRfBdrY3b9k0w33byIba5MYAn4oP5Uigd0cXc5ZcBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434850; c=relaxed/simple;
	bh=WcChuP8zECI76Iw3XflDTiyK2lFLU/dlTf29J9ptEG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciUO4TkbTPEpq1dmE8OmC/VmPk6gWztsONljH3H4lcDiM18H1sZB6ekRSVhSIW+uYn6Twk3CZzNwFWJWzNH4BamDFFas8o4isskrlLjz8Skv4I22FKrNJXowxM3DZfI6VXUdRROIOLxrsf2+mPBbs9reaCvpCpcX9jPn49OyiU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UROQfMRW; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UROQfMRW"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53113d72966so139071cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 08:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790434847; cv=none;
        d=google.com; s=arc-20260327;
        b=EhMEmSAggPOQrunlxMMg4XQWCzk8ZLf+82rw4CFfmZeK0G3V27FvXhj67LawHjiUWg
         3YKDIzb76o14khCI9uGtQS3js5P50iO+Ot4cFAyvkTn7WovuVbKuNwp7yCsla8HbmLVI
         uN2qD2Oks628uyZRMf1Wzz2o5UCDK7invaOm21Fja3Hiih5saOFPFdSL+3jEYWkmzIRx
         ztzWZVyYQa0F5ANjuVuga2WQoU8+gYe7+n8fRL631JWqfHzvJZnYQWlt0BYvLX4TNBuB
         J+bxfO96470CYmOb9A8QQmLWUzKVWBlzuO5qEsir0TRzXmMz+8Iy2sfb/rugPXDTJdyg
         43xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7omjQrgiEST9G5fbhENtlmFqLvje2Cjzmaoqjo4fyAc=;
        fh=FHHsZnt0qDC1RfNGHeYXB1Tnnn2PZuZHpj6vJtuFK4k=;
        b=OVajE7JjHn4wrV3xIBFcLMyMW1J2xq4SSYrG5P+K9ehqi8MbIiWYOFsu2IpcJMosAH
         0a8OIAm+YGaTOnjzAKOaudmJu1grfS2WwWEdZVd3KkxACyI+6+I7xbbCMhOuLZOeSBjZ
         54Pyl7lHo1UzRKM7rmo2HSfyH1n++h6er5RDcOKy0ZHMZ/wOytGDMDMZfZN+IT7rsCbc
         VQ5gPuzTN8gCl2kcE/Khs6PznMGJvQ/0smoqyKP0Bf7jCUz2PnCuoBvM4qrT08KneBAQ
         yq8XHkHpIBCBncelTRgYy3duaEJO9qqpL/lyu2YM4BUeUK3u8Zd9V68Ug4X0YE/WAkr0
         wvVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790434847; x=1791039647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7omjQrgiEST9G5fbhENtlmFqLvje2Cjzmaoqjo4fyAc=;
        b=UROQfMRWqA0t9OiFmL5CdBA2e1svuLAS83e2R3VdRizSjKCSssVODD7GG9k4daWKEb
         lQnw8YCSusfVLR2aTnqTR0HTB/nCDFbLbKZGHjELWvG4G/QA0lGReuHNHHnb2MlZdWZ1
         bgOZ3YtzbwknITxA1pmWrVKK/BZc81atj5xrsSWMLuCg/hdAdhbkObsKrgJJ6T5nqxqV
         VuhgE/rZR92vvgleCUdGUP2I4aRX4KpxXeeJhYiA8kscEf7qWFf50a/PYBWtikb1YvXb
         cRyEFF0B3dkAXUOVAFs1TW/4tl6lNR0FXYgxt5cp8or7ye8byPaQgo/DhnpCRmCrJ1AF
         VjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790434847; x=1791039647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7omjQrgiEST9G5fbhENtlmFqLvje2Cjzmaoqjo4fyAc=;
        b=bCYTFr2aqltGgSyCsv92D+wc2BP2moRiqonSsoI3DSkYsxMLfJRad+pI95+daEbM4Y
         B5QUH2YAUfbKJHVaPrtdQJ1TWnV3Bl6xAyn8K3f7SxOFnrQWy1JomoxMzCEqac5cFPMt
         fUlNNZYjPOteYfjCZ+jAm0sv0S4lu1fOz4ig/2uSCb7Aju6Gfb+dX30p26w9ew4iUtVM
         EB0khb9lEzvwdR6ksS3iOLUcIzG9y/vpuSUV9Fg7EwGABMDwdwpS5CW0PlYCDyfJ1TtP
         7Gy6GnvcYa7yiOuGaoHO1cve5EFGh0G5D3ISBaDOa8+xx9hnE4lf+AOZV/X2HnFqOOgT
         ocUA==
X-Forwarded-Encrypted: i=1; AKwUvBw+uJjjtYF0X78iRSFhqFhAK6zi+mb0eiImz5J55/4fy3MSX/nW9RYUFpzkGeoDvEh7pWHJql2ypj4pMbn6ONPc@vger.kernel.org
X-Gm-Message-State: AFuF++ny66j/jVhCQ1zOuzgZMkhqnzrIa1GoKmgZR/i5WYoy4z7+Eybf
	Yal0p6tt6ibpQCC3tgVK32wyrxX2SwJWopx0vRgrxP0tbRBcOjmRHz4h7gci0hyygGo45KyLqYj
	wojEzZTdBf4T8MZaykhOhW1tcFX5BuUN0ZP0RqjA0
X-Gm-Gg: AYBFou007M2UenHgDuZOY8jbWSnGuCwje8II+/3+0oF2Zbimg1g26rmL1QHfsJdkk+a
	ihyK1dZ40U/z4vT5+8D4vfo71QaDOjU4Rn3ot1W1nmTLMoR+wIvlpAv2yY1lIi7IOU7fIyGuqBa
	/fkH3bUkC7J1sWy5ei8HhKuj6jArQOfpLOqHox3MB94Soi1wmci8DI8Jjw/RR8SjdVF23LUprOe
	xi4dsrLipgyydwGq5nTiu7r4dlmCKtOqEs0QK96uCq/STMenrV5kymArDX+jc7pnxVU1ebGsNrX
	zhfP3dX81s3fudO8hRNDJB83DJ84qSsW5p48M1KWXt2iaCx0i6Afiso=
X-Received: by 2002:a05:622a:591b:b0:531:d8:e437 with SMTP id
 d75a77b69052e-533226c6e02mr9634981cf.7.1790434846848; Sat, 26 Sep 2026
 08:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arb9OMEQ8HCcw-9O@x2> <CAP-5=fX6+M8fKmSTzCy5HufEQf422h0vavTTb_RX3HYRYo8nfw@mail.gmail.com>
 <ard5fVHYXTckW18b@localhost>
In-Reply-To: <ard5fVHYXTckW18b@localhost>
From: Ian Rogers <irogers@google.com>
Date: Sat, 26 Sep 2026 08:00:35 -0700
X-Gm-Features: AclHuK-nKR67wIr4IISEYL33hwR1aMvxLcP3bhDyKubV-Fl5ndnsamKjz3JFq70
Message-ID: <CAP-5=fVn0gmD1EVkqEcqGfqnPtbHMFAmYXNs00RMUB_k5nNUYA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Bump the minimum Python version to 3.9
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 12:51=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Fri, Sep 25, 2026 at 05:22:58PM -0700, Ian Rogers wrote:
> > On Fri, Sep 25, 2026 at 4:01=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > > perf's build only refused interpreters older than 3.6, the check adde=
d
> > > when jevents.py started using f-strings, and jevents.py carried a
> > > removesuffix() shim to stay usable on them.
>
> > > Suggested-by: Ian Rogers <irogers@google.com>
> > > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Assisted-by: LLM
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>    I addressed a sashiko comment avoir the python binding in v2, does
> your reviewed-by stands for v2 as well? Mauro?

Mine, yes. Thanks,
Ian

> Cheers,
>
> - Arnaldo
