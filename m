Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851D13D291
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724716398; cv=none; b=MhhMH5NeqfEIhRXlUMfSUNTu3wk5fEUYCzAp977n+x54Ii6uPnzGWlQ+YFD38XnGBMDFscq1J361J5sDiR0GQ6roJhPj7blvvLMxNrMWzS5BJIpRJX1LilgMakQgVmw6raGPhb31PaAagYfhxJ91I6Ji/r+gz1FIad6WpS0Chyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724716398; c=relaxed/simple;
	bh=gfvHugkBbV/sSEbPcr9P3g/ufuvgcgigP7r8eCXiXd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5/dN+XZLoYFjR9pTezDVjL4+5jgZhSx6Uv6qvHChGKy13GPD1RG//iZC4Zu811B9oS0BbHAVEIrKUDGV4BaDqMy22O66wBW1PKlZ7SnZ2PxMJtB+TKTX7J5uK1IAaoMMnGP2/BmANJZJpQe88FyxgXjHh4dyKKl2yUdgk8Tj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37HkrmzI; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37HkrmzI"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso41875ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 16:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724716396; x=1725321196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfvHugkBbV/sSEbPcr9P3g/ufuvgcgigP7r8eCXiXd0=;
        b=37HkrmzI0rAAbrXX8bksT61XerBPCtCWgSw1eR9UCJJqoS5lpMjsUnQYUUP14mKz7k
         L/+Bk43zl/LTIG4jkQsMCmaYXxB7vy3O/YA2JLh735tzbZpK4Uf9yf/0v9zj+uR8lcjG
         Z0lbQJ31bYa8wT9LHVZsRMQQOJ5ZM9hNxHupbRPNRAAWtkoYF1gEEBt8WSgrlTrjO8l1
         gGBEn+6+nF8mqokNoY4Yqn1oHEU+bhCSHx8aIwDXktN8qZbm5BJ+qCicBPsbuX2Pxkph
         ysJfTNHvWV7To6WFarJWHjzMoBSaCdKWfcdLWUd11RKGluc/syLY8lFUd2kLLMzmiZWd
         4V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724716396; x=1725321196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfvHugkBbV/sSEbPcr9P3g/ufuvgcgigP7r8eCXiXd0=;
        b=SRRiANeOkemiJeqvBo5AnFHTCj03jDdHQyfrsHr5rkXWTp1Oj3MMoc8+/7TA8WKCDl
         JflWCzxMNOMT3DhHjcoS3eUPIslfQQFJxp4YG1Acz2VfrBM/9QKx9+KPRygWVwwNEJ7X
         HuU5Rh8iymIEkrTyluWihZ0lqvNnXyV4ngP0/wp8fZZgnUYr7wXK74ItDRJX/xHSgsWM
         6Hejo5cV9EIDsHQ1mCkXTAbp4DGbKidUE8s64+iscypa0ZseX3lXtHhDMtScUdMsq+G8
         CGJ0hNNvIb8fYtu6DK5ALkkTG6G2oFDTzgZmxp7ZPKYVeCgLxOs7VgMhftIq6wT+W/sL
         w89w==
X-Forwarded-Encrypted: i=1; AJvYcCVWL243bxtC2ZGt3RYUhbg7dwV+cd7f2rGY8RDcFmXc9CYCHsxp9tHpBqyjzd7HnSSDtBk1uBCH3P4mJ3SG0Upr@vger.kernel.org
X-Gm-Message-State: AOJu0YytwjaM7zctWq2BFJu1q3c6wsJkTqQOMbNgLxxtYs023YlPUgCj
	3LwtGYB4H5Pixw6AMK0EtyGOG2CufZu67hBeM1OrTXlJ7EzXJboevANKlo4wiiwOri+mb4iEcjy
	LE/ct6lYMD43cI61AFImBCmLJUXGKntlx28jE9RvbDj6EW0p9UL+B
X-Google-Smtp-Source: AGHT+IGXtO3D10Uezf3WuYt0RVII2+j/KXfLazJLjbXs+ApM0V9QEMs2qZuqXBWdWC8zxibHnJ6RBxyuRpNdMTukOl0=
X-Received: by 2002:a05:6e02:1c43:b0:377:1653:a1da with SMTP id
 e9e14a558f8ab-39e65ef32f7mr573245ab.19.1724716395620; Mon, 26 Aug 2024
 16:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813213651.1057362-1-ak@linux.intel.com> <Zstiry-K_v51oDC4@tassilo>
 <ZsyR4eQr8X-q2X28@x1> <CAP-5=fWKiN8jJ2rehG+0fw_REyYZxC3562KLBG1g9jHCyXMRvQ@mail.gmail.com>
 <Zs0RE60KpHyZlj8g@x1>
In-Reply-To: <Zs0RE60KpHyZlj8g@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Aug 2024 16:53:01 -0700
Message-ID: <CAP-5=fUZwoDrGaEh7Us1aDM+W3aj1zb3D5VEH39qDfCjQGvePQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024, 4:34=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kernel=
.org> wrote:
>
> On Mon, Aug 26, 2024 at 08:27:43AM -0700, Ian Rogers wrote:
> > On Mon, Aug 26, 2024 at 7:32=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Sun, Aug 25, 2024 at 09:58:23AM -0700, Andi Kleen wrote:
> > > > Arnaldo,
> > >
> > > > can you please apply the patchkit? This fixes a regression.
> > >
> > > First one was applied, was letting the others to be out there for a
> > > while, I thought there were concerns about it, but I see Namhyung's A=
ck,
> > > so applied.
> >
> > Can we not apply this? See comments on the thread. Basically we're
>
> And what about the reported segfault?

It is better addressed by:
https://lore.kernel.org/lkml/20240720074552.1915993-1-irogers@google.com/

One option though is to just remove this formatter. It is possible to
change my patch to add the thread map support. I think also we should
change perf script to not inject leader sample events similar to what
was done for perf inject. This may break scripts, the scripts may
already have been broken by the event injection. The change to perf
script actively increases tech debt and aside from comments I see no
difference in this series from the first that I objected to and set
about trying to show how to fix the problem more properly.

Thanks,
Ian
