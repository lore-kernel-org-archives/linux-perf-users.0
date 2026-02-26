Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8DF426D1A
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123591; cv=pass; b=JEK62Rk7Pu5NsrRsmaC10DbaN/NLANpk74R4XvWf+SJLICBgjEiOX7S3K6MnIhxfcR9lvJ21mMZpGWVI20KdICl0m+ky4TL6NJeHwb1kokXEhIxnQJO6DQXdvhQ4v5v3FHeLnBfBxX+o/kLLYibJ+yd2GJn6A0K4h/p+lF2PzG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123591; c=relaxed/simple;
	bh=Z1ADsqRBJYgdXWCBe8IuzmDXA1dfoLSGLbSR29HjFFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNuPlJIS/BmHYG3CgS0meO42MoT4ydWPf0IEud59DJjCJQPk42QmQWZIWYAhW2p36cWVKs3dYntCIO87DsE1G10M86mERLQtWt4/zOFXEBW+jHeyfmL33wlf4nGiAh814W1nJRZi154x+DGhNvqrZ6+dlS5L/uACXmnFDGhfaag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=em5q20Rq; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="em5q20Rq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a964077671so112085ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 08:33:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123589; cv=none;
        d=google.com; s=arc-20240605;
        b=EhCZu5Vba3naN2RVjGNdgjFs6HL8F+4NSPA8G7YiQU93QOAMKVxhYdYlVNyZgwuKIV
         dSsdfsItF0ifOxOoJFBeWwcQnMy4wx3TIF+Q2SAn0EqCfHSj1MT+Eiz6oTaYQ6ErsrPt
         luB0VJIMOmJF9oYQzpmu/xf5I+APCYr3yfkk4jO3Qx5Wqw6PIOvP5x1KPlk0/ACe1v9b
         3qhcuUK/0Dlsny4DX062VqJRMGgtFSGyXjeJw4cXR6EGXvU0/ok/QTfWFJZovVp4jmgB
         wqUXsJ9jsqse++6iAi8NXZ450FmuvNE/t+soYS2kjlAVqbaOz0Vk51eEaDlRDYnEHeYT
         TSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQPesiSAmEj+IvmnlXg8xocNI2cGxXP/e83wpJmbP4Y=;
        fh=tsJ6UNFJwg78R2TtTyLZGOnmtFGIit1lGnK5jGbGlf8=;
        b=Nsoi9bBJa/ZoqJg2+HHVFwtWoaH9ba3SpN2CSB0QXrjwbQS1/M+BJhwrKjel6hxFMe
         DZlhlIzYerV5ZHbT5KkL2rfGVgnK6M4pzsbGE/VNL9LBudql0pOWQE9dNH7BRYDgrMLZ
         0SQHkzEDRIRb/yhNf0yVI4Nk109e6hfSnxKpryePCb44GOkteE0tLlC6d7Cz/Xva6E/N
         wWfVnveI1LOSXhhUQNBIePJgKrN6G6Ax93jK2DsDaVCAWtHuTpRNjc1sYzKMq+s+i40p
         kwV4Eh4TpG8Ew1wAZhB+jQRWQcEQeoT+/5TNVTFgIeAlFGn8bb3SBuiNXjyiLiAhThgo
         3azQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772123589; x=1772728389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQPesiSAmEj+IvmnlXg8xocNI2cGxXP/e83wpJmbP4Y=;
        b=em5q20RqyNqoNm5A/xF6VGbSKG6aIN5uOfttXo8Yc1xWXkS6p5MptHnhk8wFvohQ9P
         oowC1hlioja5Oy3G/UdbSlfbisvEWgIrL0sI1vQpi28nlb91G2lm8WH+Zq3FFvcGsILP
         AKBWpMY32qZVP3A/i/BMkC491aKuzVPNRwlctV3p0P+r+uNuuEYomnviAm1e34SPrx5u
         3nYGtYO1d8RGDuOY+GEgRKrliXQb4mn1xZmIxBprlWr2FLG7FU5XHrGV5Reow+C0WVn8
         L+bZmhHgDl1s1uIzXQ7KGnPqvobxofVWlzWsDFOTaXJ0i8/HLCs3pzTqOvxYcEGKO4zU
         XAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123589; x=1772728389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQPesiSAmEj+IvmnlXg8xocNI2cGxXP/e83wpJmbP4Y=;
        b=dx9orI4ossEHqcHWL0TFXIrPGY7oW+V0i+Y1QNfbVQIfhNASacKqp7tfrxPuz9hBqv
         ZtRjUvvnz37YohULHhJ6DL2fevNQPccuvF6KLT/NQ6Js4pZwaAJdXBQhRuloR5XjfqF5
         dFIP7BUjfHRbkts4wJHjSoqWAchDoDgBV8vZNBTVZ6L2IhFH/CKFe+Uljvt9PuZSP+zQ
         n7B+6UhxJIKwV1irUB1xKOsJBn2zd30cOj5X57IlCWq1tLXGqJdqsXizA6HAaiDAccvY
         oBo6AMcXCfhN2cH9NsdEh6b8jZquk8daSpi3mIzOllaFsLYJA/7QB8lSgVOdsje190Vb
         RKOA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoDsFcbLDfz0tBRzK5XarOWop0F/e/6JU8N6c8CJIFwGL1+l0pU0EmT9Ba2hkPoTMoRFI0im0SHLZnuOEKFjS@vger.kernel.org
X-Gm-Message-State: AOJu0YwvoAIh5hCapTPbh0pP44hKy64Wk0WTKrNrv6fUhDtg2kaWAfPy
	vhnN8hMzPDCGhv53EBWiyBMYRJK2VAeax8r3DzuT/GWNmQSZxtuKdXDsxPI6e/6qpNO9N+VKv0u
	Dzs5UKX6ZJ3psPc7B2Io3l0oQ4UfkfBxXvSEKWR1c
X-Gm-Gg: ATEYQzxa7WIAxmQzhHmvqIU/4c9Zy0WlPJX82zJvnjAULqPQXsvjZGAuYn+vwoOkzvU
	CLxTK3GB1917Iwje9jy1oRXUWs+BCBbD0MJgOzqr5k0XXm/1Uj2AepB8joh0GG0D2WvieZRBWfE
	WozeJSkNa7yOPU93+3h3V0ZsqJPOsSKmX21gYHEc2Oneha+jAOKcaKAEzYUEWOS7fqt+0E5S9cl
	q3UfnK5TcjtTW7MuGOoohJQbfeufxI2AMw71iqxGd8ZwqIldFe2pfRwjfWgooSxa7ZJXArQDFgS
	UEPoUiWLJ8Egl49deDrn+2uScmXCRvJlgzkvbhOSBxTT3hA=
X-Received: by 2002:a17:903:15ce:b0:2a3:cd98:f07 with SMTP id
 d9443c01a7336-2adfefd95b6mr2307335ad.3.1772123588783; Thu, 26 Feb 2026
 08:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226122208.162765-1-wangguangju@hygon.cn> <CAH0uvoiTgRvYtm4H36JCkj6EDem1MJKuWFFWs_PEuB=2BtUkzA@mail.gmail.com>
In-Reply-To: <CAH0uvoiTgRvYtm4H36JCkj6EDem1MJKuWFFWs_PEuB=2BtUkzA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Feb 2026 08:32:56 -0800
X-Gm-Features: AaiRm53n_AXQDlmUmMDyG7-YS08pjZU02NPVRiDcjg80GV-aZezQrl2-6e9K2-I
Message-ID: <CAP-5=fXfbayxMG97uosBt+TpGGn5bRP7D09JQ2OdB9NfA0Zjrw@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
To: Howard Chu <howardchu95@gmail.com>
Cc: wangguangju@hygon.cn, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 7:50=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hi wangguangju,
>
> On Thu, Feb 26, 2026 at 4:23=E2=80=AFAM <wangguangju@hygon.cn> wrote:
> >
> > From: wangguangju <wangguangju@hygon.cn>
> >
> > The alloc_syscall_stats() function always returns an error pointer
> > (ERR_PTR) on failure.
> >
> > So replace NULL check with IS_ERR() check after calling
> > delete_syscall_stats() function.
>
> Thanks, syscall_stats is never NULL after alloc_syscall_stats(), and
> it seems like perf now frees the hashmap using the error pointer,
> pretty dangerous.
>
> >
> > Signed-off-by: wangguangju <wangguangju@hygon.cn>
>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

We've been burnt by IS_ERR many times, I think in user land we should
declare it an anti-pattern and switch to using NULL and errno.
Alternatively we could wrap functions that return an error pointer by
returning some kind of struct, so the error state is checked. I
reached out to other kernel developers; they agree but the problem in
the kernel is too large to fix. In perf 90% of the problems originate
from hashmap. Alternatively, a sparse/Coccinelle build bot or
build-test that can flag the issue would be good.

Thanks,
Ian

> Thanks,
> Howard
>
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 311d9da9896a..295b272c6c29 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1573,7 +1573,7 @@ static void delete_syscall_stats(struct hashmap *=
syscall_stats)
> >         struct hashmap_entry *pos;
> >         size_t bkt;
> >
> > -       if (syscall_stats =3D=3D NULL)
> > +       if (IS_ERR(syscall_stats))
> >                 return;
> >
> >         hashmap__for_each_entry(syscall_stats, pos, bkt)
> > --
> > 2.43.0
> >
> >
> >
