Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70371189BBB
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665183; cv=none; b=oCN4j42uqBMVlIyvr2ODRShE5s6VTHeoo5uWX2JDdjPgSYCgqkNb74EgrHohof27IJu8Y4j3vHUSqgPwW5RuadLQFeG6we0E3JfZKQfdJHmbBaAYlYx57cLsoTjjoDbKoxoB6bEkBrtwpNJcr5vQH6fVmKaVtolgo8NFIrpqv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665183; c=relaxed/simple;
	bh=/dQvIwB7C6GOBY9sPOH493ERq7mD9MX2ud8ZZgiIyE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hla3omhrS/QBDvisgkJ0neyuh4FxcOHQazKs0ApekBdYkZLH1S8nnK601yawnNEG1ukScD/aGUhXlPwB3IG57dD7zefIspt2+3vwLBSZrCypb7Z+DEX9Ur9IB12O302LedFOl+Lgei+shE6tBHeH5qFigoJDwocVFpfQHEgwgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WG1QDtUk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WG1QDtUk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dbb24ee34dso60808827b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726665180; x=1727269980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDbiwY+9v6W/l/Dp0yY8ts7e186+P1Z8FGGOzgOdKCw=;
        b=WG1QDtUkB6p4UhQd7AuKU9GhpRzr1yr6FxgBrEbdtF7QT1p6JA6zquNsv8HPWiet7p
         mH2MgFvQ7tl29NvkVo2OUMMd7vxiQ1W34Zw40nnOpkdu4QOUavauGhtsS0BghSb8U85D
         ITeRePyFjC/IDt6gumZKecDlm8rSh/ZSX7syo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665180; x=1727269980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDbiwY+9v6W/l/Dp0yY8ts7e186+P1Z8FGGOzgOdKCw=;
        b=hfcWGanUuVpV6jBUBPGxbap8RczN8wPP1w2xuEcz+05YvgrBIhg7Zxi2VJXZqt2psn
         rmySeUSWqnxe5JmGyzwNUBW4Dg/wK+0KgahiF7/R9EqOXbUM1FDb3z5yViChq0739Goe
         UmnsIdvL9zvgIw+E6GNGfMIx3gYs7HDHQ72oTRMk3qIJtHCm6a9sy4WWAG4ZxayosOXP
         4RJbKPLilJlPxVksgGp3Id09sEyUd6Uwdw3/QnNYYR5aEuHz8ojFF5ZKAA1Q3JE3r7db
         NP/jwqOMiKmvFY7PK40DUsnS/0PP2Z8oXkvndcQp+OXuUQqN2YEzKYIjNIqWiNs0U6x9
         mDBg==
X-Forwarded-Encrypted: i=1; AJvYcCXP1FNAWgLDuuU4qTDwx/P00Qto5M7pPZW+N72NPzl64HTFEyRBKapVEmpUxQNI4WlZNtkc4p0aOAxjXmkfDh7u@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgucuH8ajpB15qzuoHFiH3nBblHXAGGN+5GWPN9fVlKGuWEyK
	5SDn7aPIFozHgJkg35xQyBBKmJK5NsdsGe/3wyfgNRPk8gUF5//u+PGuzgcA62eZmj/qujNOB78
	ZC/1Lzun23wVJkUET/wUwJziG7gkoeEjZzm9YlA==
X-Google-Smtp-Source: AGHT+IG9ydQ0Munqm74igbyRIPkxfC8xFAKxQRSKZIGBKbfOv3i8qSAysIoEaKK5iD5Z7skFQQQFI71KH6ffNGSkZb8=
X-Received: by 2002:a05:690c:3811:b0:6db:dede:ec63 with SMTP id
 00721157ae682-6dbdedef10emr148891457b3.28.1726665180443; Wed, 18 Sep 2024
 06:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com>
In-Reply-To: <ZurLc9qEjBH9MkvK@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 15:12:49 +0200
Message-ID: <CAADWXX_mJr=hDkOWne831Fcm+wRxRnh9VvD2AMJJ5fStodyAgw@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:45=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>  arch/x86/events/core.c                                |  63 ++++++++++++=
+++++++
>  arch/x86/events/intel/bts.c                           |   3 -
[...]
>  kernel/events/core.c                                  | 586 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++----------------------------------=
---------------
>  kernel/events/uprobes.c                               | 505 ++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
-----------------------------------------------------------------

You seem to be cutting-and-pasting your diffstats from a *very* wide
terminal window, resulting in a very messy diffstat result.

Please either pipe the git request-pull output to some tool (I suggest
just piping to 'xsel' or similar that does the 'cut' part for you, but
anything works - you can just do "| cat" to make the stdout not be the
terminal).

Or just use "--stat=3D80" to set the output width to a fixed sane thing,
instead of that insane 250+ character window width that it seems you
are using and that causes those overlong diffstat lines and makes it
all hard to read.

               Linus
