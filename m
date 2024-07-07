Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C02BD1E
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jul 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371251; cv=none; b=SJAEAs7y6JKiQRAs5zn/iGn9LNVHS2Jg6jIdY0ABjtY9/7//494UWSgu9Fjev+Ng61WVaLeic9kafyrt88RULaMcwhwwu8cUtpMLisnW1b6dCylqNrEACYtt59pyIgf/+npI6HqpgNfUp2AYmBi0qRu/dNOwBtPb+lV00L2BkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371251; c=relaxed/simple;
	bh=Nmnlr1AaFrHKliZyWC/0gvC36+5q51zcvRnozYxWZ1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOZBCzAdQ42ZSij0UqKnxJGRlxe0vEnQv5lpXIx0vJJxnPI/TAHEZ2vHPWZCJmeuVWzQQ1CMnhmtDPIuJj8vzYx7+cT/mFRfU8LGE075Z0dsbLkioRvuUclyXf+2cpZIdOENK2XufBiPC8ob8duBBSF7j3Y4UFTs640Bh+KyYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c668fa81b5so728615eaf.2
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 09:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720371249; x=1720976049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTxP1yKHDt3zB0WDOTKJVzRyyKEvhFHmKYsQqyxWrNw=;
        b=Iuf0oFmQTHxf7TVIQflWr0ttJXs2uyHYLLyBQRBLaORDz155RAx1znYkIGMptBWEoa
         DG+aehK0l2iFQByD8DBQk95/31w0HxjBZ64u+VkST3ghejxfuu+BEZbCxTvyk7u6V7fz
         nFqTgotZ4C4hKgodhtAI0rW6lUtYq9HPFhWZxfD7Kw0Lg3ZVlmUO72Szz1pqorZnN/pX
         zfOtij905UH9y9xhtqUi70UfJvYFYVL137oFsRgHPi3Kj5fcI/NqnnVNozbPmGWn+9u7
         vFwdCVlvMil4ZwGfXCpkJyQYAnieffAry3hd7x384a3AmHtR886aJnIYu2RgVsEiChDY
         ry6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWFkPRPTc38QPjxIAIQsBklS+S2P5uJfPm0IHZ5a8VnFuKFm5zrBLAWwV+SAKa72ohOkxxMOQ2jFdynO839EhXPXRO0kqqhhpoh29vkI3QNw==
X-Gm-Message-State: AOJu0YzOyhjBTRxscKKGj+ey0OeYl+dyX52G3zW/kQJXqnianPHI7Put
	pO1qUtZrA1ftGk6eAiT3OyiLPp6g5PCLy/lYzbLMd/XDFemMFHXHP3Qo84GevHqRY63CMnvPCz7
	LIcsFt5sycdlurw/S3ARy1Kw4jz2oMzbE
X-Google-Smtp-Source: AGHT+IHM4wId8AVcCr9J3xHfeU+bSoeUsaBrjUbOo2mtrEsH6yv9H5qs2zIi9Oltfq+KHSUsSpSdJxZx5kgEwwzv20Q=
X-Received: by 2002:a05:6358:949d:b0:1a6:a69b:b171 with SMTP id
 e5c5f4694b2df-1aa98c1f854mr1015361455d.15.1720371249160; Sun, 07 Jul 2024
 09:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
 <CA+JHD90fGLdbxno37FwVQLrtAiiZ=PZ7Wp5+1Du7SWBxTd3UJw@mail.gmail.com>
In-Reply-To: <CA+JHD90fGLdbxno37FwVQLrtAiiZ=PZ7Wp5+1Du7SWBxTd3UJw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 7 Jul 2024 09:53:56 -0700
Message-ID: <CAM9d7ch=vN093Hmde8C4wOGOny+CoEX8frJLXEbhkuKEXy_mVA@mail.gmail.com>
Subject: Re: Performance of 'perf'
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jul 7, 2024 at 7:33=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On Sat, Jul 6, 2024, 4:55 PM Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>>
>> So I tend to try to do things like this:
>>
>>     perf record -a -e cpu-cycles:ppk make -j199 > ../makes
>>
>> where that 'make' is basically a full allmodconfig build.
>
>
> I'm starting a two weeks vacation, on a trip with family, I'm CCing perfs=
 co-maintainer, Namhyung and the reviewers, hopefully they'll be able to he=
lp.
>
> But while I was writing this I thought it was that  build id thing, but t=
here's a recent problem that Matt Fleming reported just as why preparing my=
 bags... Can you try this:
>
> https://lore.kernel.org/lkml/172012303630.184013.1986960651509995819.b4-t=
y@kernel.org/T/

Yeah, I think it should fix the problem.  It's in the perf-tools-next
for now, but I'll add it (and a fix for DSO too) to perf-tools and
send a PR if it's ok to you.

Thanks,
Namhyung
