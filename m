Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623D1A8F61
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418330; cv=none; b=H+ebPne/LQ4NNr4oWKABzLOh+6HUG3+fGVIQ5M+bQeW0m/mE/PMQajGY+hIAxCtw2d2LnDbjokiOH2fo2Xg/ChcJcGjgkLhfqkrjVF/DtSFwwVNs4MEZQSSP/XFfLlM/iM0BtloYYmh3oBZdeOGw+1MEWCSiarqKRvZ6p3R8B8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418330; c=relaxed/simple;
	bh=0Y90UpeRddGcL/GuV2IPPrbwvCxXyZo+M26OHvjNetQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuKy/5SPow+SZf0eYThjCtPrLrj8ktqge+EmTHQiPiE++efEpW6ntOTCxC53HiQTCbapXaBaHobm5s6jQUMw4xen10jshkGC0Fnt3N0UM1WMS+BT6gT8cnf/kutNpAJCp2tunfVLQ9FaqHOPa1Unuu54ksc69RPPkCMxE1w7TOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzBbpF13; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzBbpF13"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264c9d0295so69685ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742418329; x=1743023129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aiHsknK07Ap8N0YMfr/K6tkBl2ZdIpkxUFWWllAWMQ=;
        b=SzBbpF13x2etVdX53neSMGj/IpXx9BYQ5ZlVcTf40HwdDmdSqnzsMgoA0SutWy3Ych
         BVxRuDbieum+0Sl1ELU7XywNiR2yEUP2Ui1cCOpB8ICoT+kTgI9j1VEdjbUWkPi9MwWL
         XumShNGrFem09UqnE1N15NoLfGGupaCTKSW39nZ4VbVqjWdqRT4RCkTOHaOI2GIlNfEO
         UPLFx+0Ig4KLNz6XHbSvHmRwfQxQHLvedA4U+eST/1PhKmRZSq7TIwsI+IbNkLd228Ng
         J6oUO5CBtDfYXOnfHJrH0JQmG6JjdX7qDRXBu2/cRq05pr7a9lM1YfTDqw628RRM3FgW
         zj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418329; x=1743023129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aiHsknK07Ap8N0YMfr/K6tkBl2ZdIpkxUFWWllAWMQ=;
        b=TfcUlOAMuwTC+YyG1LczLT667HEyJNG9kg+nMqvSanAl8NfRMvPpbJjG07sOntDKvC
         1JfH7+eYQihrbmK0/Q4tRW46O9CRxSWn1aKYcBKnYLymcnIGHfdxUYjOJ1FaKk7iGUaW
         vQz1F2hcaJfRC8XEG8Od6Xxg1Rsa2iJX3WApIBLiaRvGIE5or7n4EDtInmFr8fiqQ1Iq
         WDmD3EueM22aY5rfdUhkR8XfK/t2yuod6FSd+b8RXqPslkhYaHh1BMaRY4kq6r1RikKT
         hvKJ9rj7s2QLZgtBQuZj9BGc43dpCJjVQP4KXf6PoBsBsQB2ktvix/cnwlHok6bUG7Vx
         yTaw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Hj0oXmh40cDmThJqTAa5W9ebBabZdmtU0CSOZikarrB1NMxLQ50fj0oSDP/F+6yQys73FZd1/NuvQNVNeOO+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4KehMyiuTUsfGzjbSi5OSKgQx3bofHkHHCtgicz46Rd/P0A3
	yIck5BCIQ/IrqGQNDvvR/zljax3Bnbm1yZFU9WeOLmd6qYBl0vDe93GmdO0KIsYdtiEvO+aTCjX
	dPKBEMTDaDpGon6HBWlr9BFNo2p8J3exmggSa
X-Gm-Gg: ASbGncuuAPSGxUL6Yw/5WQE3M9n8VH+mav9zq2X7geMwkvHNVgMKVbR4SrbfzdKCguD
	RbURp4kjH1p1OL3kI79AJo7cY5nOV4FwKkaHURai8gzl07whUjBM1oGoJMe+JA0daNNzIYATCwW
	+QL9Jt8dNWNwdKpaA+QGEM1MKmOp5afpW6Y2ZM/Nw4d9+Qo1fiGeT5o+F6VhDj/Vzn
X-Google-Smtp-Source: AGHT+IEHZSiwElx23CUv6PflPL4g+aly+BttVlBHLXVDnTzZSMm1Bw6zoUU8z5BxhlRrdQ/P0iBogBiV0E1qpkH/JS4=
X-Received: by 2002:a17:902:d492:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-2265f996dc8mr726305ad.24.1742418328428; Wed, 19 Mar 2025
 14:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319110454.3230687-1-leo.yan@arm.com> <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
 <20250319133055.GA3249206@e132581.arm.com> <CAP-5=fUp492RATRhc-OmikK7knO+PUWAt6Z-60Cax0QOJPrFgg@mail.gmail.com>
 <20250319182806.GC3249206@e132581.arm.com>
In-Reply-To: <20250319182806.GC3249206@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Mar 2025 14:05:17 -0700
X-Gm-Features: AQ5f1Jo8OEDFXBorjUe12DqGagKA7SIiBF6bkWuYcKQyMkbFGl3Q2qaXOxU9kbk
Message-ID: <CAP-5=fVkCaX9DRokAEqDq-3Bvr8txM7oBmw63R+O2ibg2AzDuQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:28=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Mar 19, 2025 at 08:26:10AM -0700, Ian Rogers wrote:
>
> [...]
>
> > > > Adding options that allow people to add more non standard code does=
n't feel
> > > > very portable or in the spirit of doing it the right way. Maybe the=
re's an
> > > > argument that it guards against future mistakes, but it's not menti=
oned in
> > > > the commit message.
> > >
> > > I think Linux perf shares the same understanding with "we do expect
> > > initializers that always initialize the whole variable fully" (quote
> > > in [1]).  Furthermore, the reply mentioned:
> > >
> > >  The exact same problem happens with "{ 0 }" as happens with "{ }".
> > >  The bug is literally that some versions of clang seem to implement
> > >  BOTH of these as "initialize the first member of the union", which
> > >  then means that if the first member isn't the largest member, the
> > >  rest of the union is entirely undefined.
> > >
> > > So I think it is reasonable to imposes a compiler option to make
> > > compiler's behavouir consistent.
> >
> > We have encountered this problem, here is a fix for a case:
> > https://lore.kernel.org/r/20241119230033.115369-1-irogers@google.com
> > It would be nice if rather than -fzero-init-padding-bits=3Dunions there
> > were some kind of warning flag we could enable, or worse use a tool
> > like clang-tidy to identify these problems. In the linked change the
> > problem was identified with -fsanitize=3Dundefined but IIRC perf didn't
> > quit with a sanitizer warning message, just things broke and needed
> > fixing.
>
> I searched the GCC online doc [2], I found below options but none of
> them is used for such kind of warning:
>
>   -Wmissing-braces
>   -Wuninitialized
>   -Wmissing-field-initializers
>
> For the "-Wmissing-field-initializers" option, it says "In C this
> option does not warn about the universal zero initializer =E2=80=98{ 0 }=
=E2=80=99".
>
> Linux kernel has added the "-fzero-init-padding-bits=3Dall" option in
> the commit:
>
>   dce4aab8441d kbuild: Use -fzero-init-padding-bits=3Dall
>
> Maybe we can do the same thing for perf?  This could help developers
> and maintainers avoid endlessly struggling with potential bugs caused
> by "{0}".

It looks like clang may be just changing the default to zero
initialize everything:
https://github.com/llvm/llvm-project/pull/110051/files
https://github.com/llvm/llvm-project/pull/97121

Thanks,
Ian



> Thanks,
> Leo
>
> [1] https://www.spinics.net/lists/netdev/msg1007244.html
> [2] https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
