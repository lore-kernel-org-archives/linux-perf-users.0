Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9894D8C6
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721860297; cv=none; b=YIobwM0A+dqO/KT37OmdkcxNbHpHmvRFCu4hNTWxYLbFOzjYsXcAfg0/TlZXVlBQ11/+bk86JMAclXOb8L4Zo6VBJ4mzJDzep5JcDsgEGj7hyFml7z1IuHGB24UQDOYE5+efgurNnf6LqXFEZ5uH92dVyVW5D5UfQs21Rcrn9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721860297; c=relaxed/simple;
	bh=p7HFi5aTCxpPOWH/rgC440Asd+WpsjgyXCvYUuSGsKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZrXFABgB4UpjNrdm+Frs+ydnhza82BQM6/3f1r3Fy+8ejCtzWzcBnvCzzFO0Mcy1Dn3zlfDabQAHaxcSbZYY5OZPOzysCFHWkB9ZQ3dZTQX72O1oAuG1HxRQdMvTgIvxt8ns/yoASq7fwZDeubH1UiTUetmqeXKJxXkE4zEvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K0nkmr3+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0nkmr3+"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fdc70e695so153481cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721860295; x=1722465095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7HFi5aTCxpPOWH/rgC440Asd+WpsjgyXCvYUuSGsKQ=;
        b=K0nkmr3+wLoPy8oJc9sGotzaV/KyEe8bkMgaOy2MzCCdtw3zVjdAfLxAuekXM0baYm
         8ZEDWUrvQaZk5EEXNfm11hGpDuVFt5gNXq+WZG6EvfRqqi9ZbU8cHJbecx984XHmen1Y
         e21Pt03bOTMjQsvNT/W01MVZaCJ3rqXiR6rQHVQP+5sFgYk4qLQEcEyX9hPd35LdGgWo
         dtJJcZFIxN2dj6gMaHBKmvqCoFpX5sqdRi7g+IjS54NKNHmIsCo7bC3ozkUjB3Hu6cLm
         s3YCv8JxzAOy9SdyDVQDxq8l2r/E5S0gRNVKfONgq6mkz9sAa+T/ELUqCiJRtxP4TdM0
         en0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721860295; x=1722465095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7HFi5aTCxpPOWH/rgC440Asd+WpsjgyXCvYUuSGsKQ=;
        b=vX+a4Ds9s+Yj0lyUCpT0xrceZQtFDYbPMyQnz5zTs5RM58Trc/iAUFMXMn3AJApbrW
         hq5vw6xrFBkfJ2neWdbIL3Cu5VA/UNxr4ZjOADcx6EQQPukhyQwjINbqiOJQyI57bNcS
         tChxaXghE2lg9798pwx99YliM+LKy4hS/c8c2INT9WEq/lLIoktCgqLaochPPOTaIjvQ
         NDRnKdFgWRJXAReYhBAhB/0JBQI1t71jcwE0+oCc1aMwl9+YEJ1Sv/GnUPDfifvMMzab
         g2QLjusIVQMy/n20ELdXnXHyZb/dgb4qpWSToz5L1xERk6JHOiYH6un8ICTk3l828wGW
         fhCg==
X-Gm-Message-State: AOJu0YzftWVUketCROf2p9LhBKO+QT2hwRY2QxX5x+7q4ibMNU5WGbPs
	5/8IJW9/07WoBBdL/kTXno9UO9dJR+crMiYJ9ma2pELLbectOP506RW8Wg+E5d6z7WuNLYNO2MR
	K5UwQ5FpU+BvS+XF6nyJsu40DrUoZ0uE7XyINbl+D08PdN+5XrwH/aks=
X-Google-Smtp-Source: AGHT+IF+Pb4+CfRCPj/uIfqQHUHPZ3amOp4R7lqsxXVvyyGfj8dYG9g+59+ljmryVadxEuzGepSHVriaFvUSUCfG7A4=
X-Received: by 2002:a05:622a:1313:b0:447:d97f:9765 with SMTP id
 d75a77b69052e-44fe532260fmr1443211cf.16.1721860295026; Wed, 24 Jul 2024
 15:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724190137.3810429-1-ak@linux.intel.com> <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>
 <ZqF2xhZuchmnq3Bc@tassilo>
In-Reply-To: <ZqF2xhZuchmnq3Bc@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jul 2024 15:31:23 -0700
Message-ID: <CAP-5=fXh4P64Un9CMnoA-RrYGg9LNUw+zwkY9qAYyJdKa9WTEw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] Create source symlink in perf object dir
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 2:49=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > For patch 3/4 the aggregation logic doesn't look to work well with the
> > patches I sent:
> > https://lore.kernel.org/lkml/20240720074552.1915993-1-irogers@google.co=
m/
> > I'm not a fan of it, but I don't really understand the aggregation
> > metric logic here - periods of different samples from potentially
>
> It's a single contiguous group, so it is by definition only from one CPU.
>
> > different CPUs being combined as if they are counts, zeroing of the
> > counts.. I'm not going to rebase my changes on these, and if later
>
> On some reflection your changes went into the wrong direction
> because it ignored the (useful) single group property. Aggregation
> on time really needs to be in perf report not here.

Still don't understand this. You are sampling, that's why you use the
period, how can both samples happen at the same time? Why can't
something sample twice in the period where 1 thing samples? You assign
to the counter not accumulate in it, but the whole gnum would be
broken in that case. Why can't samples be interleaved? What I did was
read the samples with leader samples, which is clearly a correct way
to read counts at a moment in time and compute an accurate metric. But
hey, stuff everything in whatever is aggregated at index 0 and claim
success. Fingers crossed it doesn't break with the metric display
code. It pretty much seems to me that what you have done is unusable,
but it replicates the previous unusable thing so great.

> > code removes the hard coded metrics for json metrics then this code
> > will break at which point it is reasonable I think to disable the
> > test.
>
> I don't think it's up to you to unilaterally deprecate features.

Agreed. At the same time if the code never worked except to give some
kind of broken number - this is all your test is adding.

> But that's a good point, the json metrics got broken too :-( It worked
> in the original version. You really were a wrecking ball here with
> all these regressions on stuff you don't use, Ian.

Uh, when I started working on metrics Jiri had switched the double
values to ints and broken every metric and nobody noticed. Any idea
I've broken metrics is false except for the hard coded metrics where
aside from trivial IPC the metrics were wrong by the TMA definitions.
The hard coded metrics were also broken in areas like interval,
replay, .. as counts were duplicated for no benefit. We now have 100s
of functional metrics, support on hybrid, .. but if that's bringing a
wrecking ball then so be it. I've wanted to remove the hard coded
metrics as I get constant user complaints that they fire inaccurately
(ungrouped events), for no reason (if the events hit then the metric
fires) and break the json metric output (expect output from 1 metric
but get x).

Thanks,
Ian

> I guess that needs to be fixed too, but that can be a separate patch.
>
> -Andi
>
