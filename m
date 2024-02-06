Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7111CD1B
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262843; cv=none; b=Ga6jYe0+r9bnBF8cfEWy19/Wbey454PrYlnmYwel5QeKDL09osmpLWHQS8QhU+h9AoL3PX08Dhlx6dJf1Xd+q1A/wO+1Xcd0gF/1NNxpWHqAt/qzKuGUk9BV8LqQ/AJQaT2Ad+r1iKFt7nEk3yAC6JFh4jp9pIRgaBa0D0dVl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262843; c=relaxed/simple;
	bh=SMfV3zP9TAVxc9qHJ5pF8CYvegtpia1rL9pv1jbHIgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USLiqegJPTfTlDRf1PxKfbA3UEKlBI88v8Mt4BUPtRknQqp4/6CZnRIWM5Hy9EqC7Rsqi8lAwVwjbfP0iSMI4hWuOXO2TTMlj98nBK/7296NTczhUrKrUVf9MlDRYppyrxDd15puQR1FqxCrN1uL+Uf/aJv6SV1mIgF/+4vPbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGbk96Ew; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGbk96Ew"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d5ce88b51cso90935ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Feb 2024 15:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707262841; x=1707867641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMZl2B6r90pWxe6d/UAGhzRXMHrchHR7+niCYeN7Fhg=;
        b=TGbk96Ewq1REq9s2z/x5LddL5yHfbjQmeDEawV+AMUxdZx6zdXgPF+EmoSXDlF2nLR
         YHnEvdafzHcNEbgdQGDpHyqyyNYmxmCjMZktu5MV6/+bb8AiP1hI3ZI7NVnniIzYiTVE
         miZBP3zSyzstobqL6S7Y3u1zT0Sw3GOvbP4ezDTiTr6Uxq9iQuoz+j67s4B4UniNcHSc
         Sm+dFigggiGJeAKowvLoU4lRCs6AqjwqR4lTS+V8qZzeJwFgHuGHYPPdCeFegMMJcvIb
         gCa8d3wQFS/MkyPXD4/2T/qAr9a33XjGzyjIRSbwxmEiLY/5a15+zG6ZGcA9Kn0gRgYP
         iUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262841; x=1707867641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMZl2B6r90pWxe6d/UAGhzRXMHrchHR7+niCYeN7Fhg=;
        b=JDseZgxvCBtYkoukB360awjCq71Eenpar9m3LYXq04py/S8YFxmJHYr0hLkg+L3tNj
         5UJJr/vPR/WTmNL8GlTuqSYK5/3iuovjM81P3WviEr5yOZ3g96TwPASI9Mu6wBeqpkY+
         h49ykg30pvsixbr/ZhqoJJUKhhmZWtZmSYz6d0udhmz1zVK7uKqrcjKNigTwXo5vMA1/
         YFzboNNN4kE6h1fWokuEd8sh6WS2GTi89wiwnN/u6AJwQwKMZ3T3DK7l3zb5ixbPsMct
         oO8aeJUEZcs52muu2zn3Uo1/hpIfdSXOcRnQxlAcaR72iV0erP3d/zQNOF4nbrh2ehqV
         fgQQ==
X-Gm-Message-State: AOJu0YwuhNab+6JeQhb4Qo9ki8csXjmnuDTKA2wHoYWBZuenm3rXTNId
	cwOARGy1RJ0yil0jbywIEQ0MXOi/ZpPzELnw4fXGzgT+TkM/rhJtNewvvOqRlPRHJ9WOH6Pjxrm
	Rk59HPuG5ChAqNPxAamlXz9DeUTpVja2PpMyJ
X-Google-Smtp-Source: AGHT+IHk0GZQ2blDgfVf+w1vAv7QhoskH4BtElhsBkxqHLSk2Tcp1LsvWXMaotUCkZJtfW8YHpS5xDLHn+e73DW4hrM=
X-Received: by 2002:a17:902:dac6:b0:1d8:d6bf:145b with SMTP id
 q6-20020a170902dac600b001d8d6bf145bmr46775plx.15.1707262840823; Tue, 06 Feb
 2024 15:40:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-15-namhyung@kernel.org>
 <CAP-5=fUWaKW7d6_YkET0o26=fjBwX6PPJ1gXQ9wndQM_Oi2O3A@mail.gmail.com> <CAM9d7cgF_PYm2fG1Vgu25u1hVZUK0wmFBqY7DHW2eVpRV=iERA@mail.gmail.com>
In-Reply-To: <CAM9d7cgF_PYm2fG1Vgu25u1hVZUK0wmFBqY7DHW2eVpRV=iERA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 15:40:29 -0800
Message-ID: <CAP-5=fV7fWHM53roUJOU+0vAYQJAbhdE1EkgzHLv7jPgeLc2HQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf annotate-data: Add stack canary type
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Feb 2, 2024 at 7:21=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > When the stack protector is enabled, compiler would generate code to
> > > check stack overflow with a special value called 'stack carary' at
> > > runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.
> > >
> > > While there's a definition of fixed_percpu_data in asm/processor.h,
> > > it seems that the header is not included everywhere and many places
> > > it cannot find the type info.  As it's in the well-known location (at
> > > %gs:40), let's add a pseudo stack canary type to handle it specially.
> >
> > I wonder if cases like this can be handled by debug info rather than
> > special cases in the tool. Special cases are fine too, but are
> > potentially less portable.
>
> Agreed, but I couldn't find anything special in DWARF.

The fs and gs selectors are commonly used for thread local storage, so
could something like DW_OP_form_tls_address be used?
https://dwarfstd.org/issues/110803.1.html

Thanks,
Ian

> Thanks,
> Namhyung
