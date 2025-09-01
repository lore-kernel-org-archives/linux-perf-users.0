Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD51DE4F1
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756702104; cv=none; b=VypHRMng0xE1wrWqQRme2mPm6JxUoAIkOnU+doWWAz2qo+06FDBp5IxYU0B9Idhunnelmo9rRsdYWn2uGh0ZgCbOMMyuEHPuvN+NL4c/UG+MCbUL8orzHQ+FH5LXgnZVE57LhOn1roPe99K7sFZ1M9YaLqt6CPAwwnSrJpNSojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756702104; c=relaxed/simple;
	bh=Ejc4+7iVLBfIxb688IRQFK/gGqFypFduC5exOq4cvps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3ivSbDPNz64jbAbuC129/MG2BGlgCbqGEm5aYeq9pDwf5gomQeRZqXzM5JK60/HZJIxxK23zdq0gsZP1YAdjn9IFjTf+xX6C97RRdUjQpzphB9H5sn0ihjWVrvBK34chYp4STVKXGnh20xeFcNjuGUOb+QvpR3D4TK2su21qxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krMcKNxq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krMcKNxq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336cee72f40so12074791fa.2
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Aug 2025 21:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756702101; x=1757306901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ItfuYm2JQE614/6hjW72JToirycttAJPocJVdLgsVk=;
        b=krMcKNxqDW8ZxWUTSP2iGYfwfx5IZZNLTmpOVPI/4gXTKUlfx24BUOUEtfUxHGqTPz
         eVxagcXBvbkfJb2VPzXblvBvkRnDeCx6KULJ0py/3XaQ76rEy+k3ucqz+/q2pA1H3Un3
         1DkC6QJG9xyIq2mtJiccoCe7na3Cr+3SjnvNqIbcbyPDr4mlmDvyzVbgS0abCSEOlm43
         +zuuo0yWbQxNH60RfBZW+hXesd3HDD1fW+ukWI4sLdvp4cuIays3QbsdODQtspH7CpG+
         wj5t6XQrZDkLW9LbvNOgJ08vlml6XkqkpJ0RK71zgFHtU9TunFWtuyjSIBJWUGav0b/M
         pj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756702101; x=1757306901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ItfuYm2JQE614/6hjW72JToirycttAJPocJVdLgsVk=;
        b=KwXfbTcXuU4wiz6BjTQZJY6XVf7S6DhVTMtJIJ30HZuiAy7z43SgIVocpz4QSg+ej1
         wPea0rxvzZ3NwPHW3FnNNzIc1Slx+3lNo+x1+uKOd6j6phgQV04+iGxVeCu5jQor8unO
         Kakljr4aBPE6V4FvvSqDBI9Vl8whPgjMllgEQBOPFI+ZfG9iWYTnJeD+xkEkvaLYXVTe
         qC2FsbxDLsdwWU9WFJiNI+FZHavEMHmG7kJmy7Zg7yvN48zMmLoekNPKekvy+G6kfCb6
         pZM2Nfa56x9hStKrd95t5wqMKqSWcVR9mbrCspM8XNKTCnON28PO5jyDb/48ZOnGuqc4
         riDA==
X-Forwarded-Encrypted: i=1; AJvYcCVM5n++8k9Mu3Bzx3c4NnNt+op3pZsYm+HR6nib6h296LsMgP+tEPqTzi7BYsjf8vtFKZqzrLlrHBAcSRVBUy87@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4VSvQz+Cof5y7jZ7+2wbJj2sSWYpgWOlY0alBEf5MT3LMChm
	kSvjLE7Kmw2NelHFdaQW18Et1hApQsiWcmoKl++IhwtqFjBcLNGMd4plx8bR2danWJTJJHFkxdU
	aH894KwKFTtTbqi/8FHYMFut68TjyhrkrbvYwTu9B
X-Gm-Gg: ASbGncvzGv9hkEHK/4YsKA0UKPpxABnzkwzo2iHhOj0ldZpPBeFHuiklsUK6EmmlHaW
	SCE0v1xeOSVNd+uLxFRBPwJUL2UOoY46wtERuJRzDvdLj4WRDOxgrMaXD3VRBpGU0MJ9y16l++Y
	5NM6a5adSmaOwTM4yN25qa7B6U36SW7nlcGp+86CViGX5j3IMh7/+75wOyhWrzuVz/gMvcKbjZq
	3b6MdRMtO+7q1i3uZJYj/b6gtqdTgS9VkyEoCrrevb7IU4=
X-Google-Smtp-Source: AGHT+IFdVUm+IoSF5Ct2TjYReBuRJ5hJNZUnNPK52+RP3kfFx6ElqS+ay4cBA+GA6UXZvTAib3EGqIhBO4FaPoqfj/o=
X-Received: by 2002:a05:651c:1119:b0:336:bb9c:d392 with SMTP id
 38308e7fff4ca-336ca90366fmr12113891fa.9.1756702100852; Sun, 31 Aug 2025
 21:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKYEpf7xp3NnkBWm@x1> <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
 <aKv_FjtkPIR86inu@google.com> <CACT4Y+ZxqgqAGoSgUaVKk6_=h1dO7iV8qrVHDOrmbBS3VW8-=g@mail.gmail.com>
 <aLIixyZOYD3ZE1gh@google.com>
In-Reply-To: <aLIixyZOYD3ZE1gh@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 1 Sep 2025 06:48:07 +0200
X-Gm-Features: Ac12FXya7MQwBjrNruhkQ3vsTZRyqYy763Za_j014hNowF001C1ZrX2GHvqM1kw
Message-ID: <CACT4Y+aeSN3LuejBEmcse7MLnanvv6L02=SKNd_yBkm72iAO1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 23:59, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Aug 29, 2025 at 07:59:19AM +0200, Dmitry Vyukov wrote:
> > On Mon, 25 Aug 2025 at 08:13, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Aug 20, 2025 at 06:14:08PM -0700, Dmitry Vyukov wrote:
> > > > On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > >
> > > > > This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
> > > > >
> > > > > Not combining entries in 'perf top', so we're getting multiple lines for
> > > > > the same symbol, with the same address.
> > > > >
> > > > > To test it, simply run 'perf top', then do /acpi to see just symbols
> > > > > starting with acpi_ and notice that there are various lines with the
> > > > > same symbol, press V to see the address and its the same.
> > > >
> > > > With this revert, does it show 1 entry but with a wrong percent?
> > > > I am not sure why there are 2 entries for the same symbol, but if we
> > > > merge them, we can sum of percents. Is it the right thing to do?
> > >
> > > I don't think it'd have a wrong percent.  The hists maintain stats for
> > > filtered entries separately.
> >
> > I still don't fully follow.
> >
> > If we merge a filtered entry into non-filtered entry (with the
> > revert), now we attribute what was filtered out to the non-filtered
> > entry, and the non-filtered entry has wrong overhead, no?
>
> Oh, my bad.  I thought we track both periods in the hist_entry, but it
> seems it's only in the hists for total.
>
> >
> > If we merge the other way around: non-filtered entry into filtered
> > entry, then we won't show it at all.
> >
> > > Based on the position of filtered entries in the RB tree, I think it
> > > might not merge correct samples together and create multiple entries
> > > with the same info.
> >
> > The second thing I don't understand: without this revert we don't
> > merge filtered and non-filtered entries, top shows duplicate entries,
> > does it mean it shows filtered out entries? This also looks wrong...
>
> I checked those duplicated entries all non-filtered (filtered = 0).
> I suspect an entry can miss existing one (to be merged) when it sees
> unrelated filtered entries in the middle of RB tree traversal.

Does it mean that the sorting and merging predicates somehow end up
being different, while the assumption is that they should be the same?

Will it help if filtered field is checked as the last condition,
rather than the first? Then I assume unrelated entries should still be
compared as they were before.

> > > Filtering by unused sort keys would be undefined.  We probably want to
> > > warn users instead.
> >
> > Do you mean that the filtered=1 is set incorrectly in this case?
> > Do you mean that with this revert 2 bugs just compensate each other by
> > luck: we wrongly set filtered=1, and then wrongly merge them together,
> > so it all works out in the end?
>
> I mean you should not allow users to use filters not listed in the sort
> keys.  For example, `perf report -s comm --tid=123` would return error.
> They can use `perf report -s tid` or `perf report -s comm,tid -H`.

Is it the root cause of the reported duplicate entries, or is it a
separate issue?
Arnaldo said to use just 'perf top' w/o any flags, so I am not sure if
this is related or not.
