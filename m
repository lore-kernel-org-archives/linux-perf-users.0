Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC99171E5D
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899110; cv=none; b=hgOLIVSy4OtGsU3AvMKE2MSzWln/4pCV54fdXEQDh0h68WCajOZZusMAAPzEJ0G++T4jHBQl8bDncwPHizDO9vEKmEn7TBudwZJuVaNQ5UruT3GYY9s23PD/zSKXliPINVZCB6YTCQzSFDL6xoya8HyZwZO35Y8ATUQS+9wa2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899110; c=relaxed/simple;
	bh=9gQbx9PVOtwwdM2FQSvCyLZ9hdzBL0eG6sqa/SeEvwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s65dYRrLn8VI0i72zSxHD4Ks1RewHfmCQQrtgp6hy8CDdk0rFAsGs1GU/7k49Ezu/CmNe5UDHFeLg2UsRID0H4N+2+qkphIMPFxaaO36wE+xyFb07hRKXzbwvoPu+1e+fQuw4jCB+NN1CGuOp3H5pcSSGxv9IOl9GtJMo8PxbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxPbqRmQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxPbqRmQ"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fee2bfd28so28921cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721899108; x=1722503908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYDHLNnuc8Y2NToRz2EAjh9Q/9V6lnmzBLQ95BO4iro=;
        b=kxPbqRmQIbouIZaYclfNv1SbKT1LrpddX8kzoVb4/6Bayvw3pUQsoGG7fgIZBCpA0W
         5r0h9GO/Ix5qUFT9+F/AGEATjLb+CccnaXZQ2xaLmzIgwVSRoV9uTz9VTSvCcOhI8g6C
         N2c9LwDAD2XxJ9jAhTF9NPtKx4sov6ZkSGSrJ8dgGnEMXljP0XiSFIgdCYuv3t17UwKy
         /AZVGSRV/IQcKa85hgd9bGsZJHijDZ5RCtzuZp+jiQWfE5APOdqtDjb8Uip6WskC8wje
         iCmJjpevojSTZvKJp8WduUTH55M1vd8hw1zClkepUvWBulNGngPexqxJIsw3ZaN4i4l2
         0DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721899108; x=1722503908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYDHLNnuc8Y2NToRz2EAjh9Q/9V6lnmzBLQ95BO4iro=;
        b=GANFtU6iXK+qWaORo+ZK/KypBeRGlCfOtDApdqMHsKt9ZOCOYGYfAKTeo7YRLF7aFq
         PzsIrmEQRHtj38ZLBSAEmOYvk6COpo/kCBXx4XcK8Jsa3r0TA3lwdh9aA4nlZXO5ZOHi
         kFigsuCZjwXCUcgNhWK+vwbCRv8GNZyyl9j8EFTC09yyekYAFtLeGGY4GD4MzHyfxZV7
         v5aNg+5hUIDwkPdOLQO28wyEoGVl1E7hM7gcNDdtYokgxl0xiKVDRNkDrx8hux8qppJ4
         WX3s+0HFYi4GleWz/b2dcqgHldc0nnLevnXm5FZaHRZdbePnrc8+VyM+Mm+sRZ1kazJV
         VmFg==
X-Gm-Message-State: AOJu0YxHZqj7SEVFwg4AjowZfQzG9AivIVBM5SJDvwvYVD8wsI4VNiIW
	Epr1tVHza7XLJP36etFJZ/3mKNgAHpCM7wWiHwXAtAw+tycb81wU/JqnXMSRPIM4H+guq0DnECi
	HuJs8WReRxMeBE1ExK8stW0FlC7N4jEV+naXS8s2lx8EQ2O7NwfppzNo=
X-Google-Smtp-Source: AGHT+IFjYUe+ep9DWmhZ3cNTS2tGeM5KP96UHMlMbJwaFBwg0xNyW0GvQSNJWceJnSq6Jl1jehyGtC9+yvWp+4nAqZY=
X-Received: by 2002:a05:622a:1b8d:b0:447:f3ae:383b with SMTP id
 d75a77b69052e-44fe56918d4mr2586301cf.19.1721899107721; Thu, 25 Jul 2024
 02:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724190137.3810429-1-ak@linux.intel.com> <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>
 <ZqF2xhZuchmnq3Bc@tassilo> <CAP-5=fXh4P64Un9CMnoA-RrYGg9LNUw+zwkY9qAYyJdKa9WTEw@mail.gmail.com>
 <ZqH-lAF_ztetHZIH@tassilo>
In-Reply-To: <ZqH-lAF_ztetHZIH@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jul 2024 02:18:15 -0700
Message-ID: <CAP-5=fW7n3Zn_-FZBcorvAg1cgk+rPb700uV=0r+QUyoeH4sSg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] Create source symlink in perf object dir
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:28=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> > > On some reflection your changes went into the wrong direction
> > > because it ignored the (useful) single group property. Aggregation
> > > on time really needs to be in perf report not here.
> >
> > Still don't understand this. You are sampling, that's why you use the
> > period, how can both samples happen at the same time? Why can't
>
> It's leader sampling ({}:S) , so only one event samples and the others
> in the group get collected/reset at the time the sample happens.
> So all the events in the group measure the same time interval.

No, here is your test:

+       perf record -e '{cycles,instructions}' -o "${perfdatafile}"
perf test -w noploop
+       perf script -i "${perfdatafile}" -F +metric  > $scriptoutput

notice that you aren't using :S. You are grouping the events which has
no meaning other than for multiplexing, which for 2 events you won't
be doing unless something else is doing a lot of things with all the
other counters. Your code is trying to spot multiple samples across
multiple evsels, squirrel values away (the period, not counts) in
counts and possibly dump metrics. The samples may come from any CPU or
thread and so your IPC numbers could be instructions on CPU0 and
cycles on CPU1. If you see repeated instruction or cycles samples then
only the value of the last one holds and so the IPC number is somehow
interwoven with the period. Like I say the whole things reads as a
nonsense. If you were putting the counts into the correct CPU then
it'd make more sense. If you accumulated the counts instead of just
overwriting, then it'd make more sense. If you used
sample_read_group__for_each to read the counts from the group read by
leader sampling, as my patch does, then perhaps what you are trying to
do would make sense.

What you've done matches the apparently broken thing that was there
before, and you seem to think this carries great value, so I don't
have a problem with adding it back rather than a segv. It is just to
me the whole approach looks completely and utterly broken.

Thanks,
Ian

> Think of it as a much faster and more efficient (but also more limited)
> way to do perf stat -I ..., driven by the leader event.
>
> > something sample twice in the period where 1 thing samples? You assign
> > to the counter not accumulate in it, but the whole gnum would be
> > broken in that case. Why can't samples be interleaved? What I did was
>
> There's only one sample -- the leader -- each time.
>
> -Andi
