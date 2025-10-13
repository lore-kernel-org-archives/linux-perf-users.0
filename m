Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6D2D29CF
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386940; cv=none; b=TLyNOJ0WIfQDzKUNX6kDGjeMsI5ADHzQtMINVDXUmZNvUBiRwt+VFG3gA5fEcF5hELare308x6jgNo3MolqomqSIim3O6/Iumxz/r2fNJ4n2QQNluP8sFslGsKlzRr8HbT/xsse6Z30RwbJNWNzhxB0yHycrNJbtzmaG293ce+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386940; c=relaxed/simple;
	bh=QsRpjtxk2YXgccJYdtelO5toq1Nqn+nzOxGvRT5A95M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSlX/4WF7ntLfnZZp1syP3MrilWVBOJPqICyoMl7pvi6JBb3roziTs8LO1UNZB1g4n5lGNqeidLp0VIlYHbPV+YKqx3ZEJueT4prBax87NKT5OJ5U+IIo/0ltYQ677G1eBnRd1ufhTn/TNUyWrP6t0Q75dhho6A7f2MI+tA92NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpoZEkWh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpoZEkWh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2731ff54949so439605ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760386939; x=1760991739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Enw/IlR5eMQv4LQS+pl4o9NnaHsXnvsQKnh6s2+WY=;
        b=bpoZEkWho8EtoIO9qKnp5Wwot09odDn8cwSmnPwHU+o0nlCxB3uz36PTxvyHFP9JjS
         ws03L6G7xwk46yVm8zxUf6nWGNxxJK5qc19nfIxUgvWw3nNx60yA51r1evFheSRx5eK/
         HYWbRkfaEqpPGnjNBQmzw9SrFKEBiznozUqzsiEgxDVXmGfW2VhG6K258snWMijOcmQw
         qjZEpUXmThc2OQV2d+mYMU/f7CRhAnA6mlTGLyRSrBUoYjq4DntVoRvg2PuUHj2aRCg8
         BCyhZrk+RehB6NvVtuihxDJCfGmvlXgnIjZ69i41CKeNRuSiOaMwbrZDIDeEiMfeiu3V
         MaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760386939; x=1760991739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Enw/IlR5eMQv4LQS+pl4o9NnaHsXnvsQKnh6s2+WY=;
        b=Dj8kzgNiPSJi6dHk/8Ayxsn4gqBR2yxKzfLPKOk8nSVacWOlz9/vfg40rErPzdBKg6
         1g1rXKS/QIhi2UWFnsiGV8/8iCD12mmn1SZJvOq+NsaW8oui+j9jJhNMJgAY2BxVe2BW
         LKMbxvy00+ISic5q81+o3OhIugEiT2oucR+gaXdQB1bDgXZJ0p+N0PHL0pzqFLlCBOwh
         TKKPLr4VK7KxIA36UXbb9ZLR078m14nGgZKElz54JZ/WxJMOeLFyLaTKLYOUGHG/ishx
         ZSzjVorRZetKJj55NF2X/xJykiE36T02J1Kwmp2o8YO0mToRVf+KQ/cisRKhqbQo/Cmb
         rgGA==
X-Forwarded-Encrypted: i=1; AJvYcCUebMcSbUu3AYW9WzAaIkedWYPB2J43d5TabnfLEMSmP6AHCFuAzNx+XirrwhcWaLmSI4CipeUsVKzpYxifFhiC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FckYL7x23xV4kFm32BwYN3TIcTGoV99mB90h7LFuSXQgEw+I
	hz32y82kStpLVB1sI9JHwBKbMbe9sUsEFClsrYxyBan4Zkj0IziMKOnZagmhe7Nu6MO9KOgTpPW
	0DLHPq5JVO3E2xTqZymLfEkRiOcqp0sAcu2/u1VdM
X-Gm-Gg: ASbGncvTMVMPldUKgsnlzezxRZUx+70HtofeoGlj2dPH8LHdgPwRlugvCRI1wkILvEH
	1AHmrlIWRCW6Hvc1c4nqXrZY7uuA5L1eKxZ3UNF1tXhoEo2aPgWrpsPN8TcPoffFHKTYYh/zKy6
	8/If+olIbokhkvrq2AD06BP/LhynTO3kmvzR6V4ARfZT1iUe0BRDrWPoV6PEZD0hKzJ/4p1R4+m
	Qt95FgAxY9ghYuGY/CVakmJ1CgWrFdc/Nt2+ew+MPelz4C/Gf3b4NoVjiogMWM=
X-Google-Smtp-Source: AGHT+IEcZpYJHLBQVZvSE9eDp+BP/AU+k2QtgRMfms7sX9GbqQpVlBoMtWNS3BifRo0w2321VonVZDRt04ljb/qAWIc=
X-Received: by 2002:a17:903:46cf:b0:24c:f4b1:baaf with SMTP id
 d9443c01a7336-290275dda1amr23526695ad.1.1760386938289; Mon, 13 Oct 2025
 13:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com> <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
In-Reply-To: <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Oct 2025 13:22:07 -0700
X-Gm-Features: AS18NWB0RfdS9UW4TaImosUPS3vluR73cPOKuBmKWhASCVpwckLvVIRIEkRT4Pg
Message-ID: <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:45=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gmail=
.com> wrote:
> > > >
> > > > Hello Namhyung,
> > > >
> > > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c=
 has
> > > > > max entries of 512.  Usually syscall numbers are smaller than thi=
s but
> > > > > x86 has x32 ABI where syscalls start from 512.
> > > > >
> > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the=
 middle
> > > > > of the loop when it accesses those keys.  As the loop iteration i=
s not
> > > > > ordered by syscall numbers anymore, the failure can affect non-x3=
2
> > > > > syscalls.
> > > > >
> > > > > Let's increase the map size to 1024 so that it can handle those A=
BIs
> > > > > too.  While most systems won't need this, increasing the size wil=
l be
> > > > > safer for potential future changes.
> > >
> > > Do we need to worry about MIPS where syscalls can be offset by 1000s?
> > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app=
.fastmail.com/
> >
> > Argh..
> >
> > > We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> >
> > Right, it'd complicate things but I think it's doable.
>
> Should we merge the x32 fix while waiting for the hash fix?

Just a reminder that this is still not resolved.

Thanks,
Ian
