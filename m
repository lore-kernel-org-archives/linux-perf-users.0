Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8F2E40B
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805167; cv=pass; b=a3gx58OZp509cQdwz9VYdd6hDpdAspLgUxETju04+KvZgpHDC5CJ8iz8GFaH1kQs/6X567sQSDu4NcF4sCy2ZvEru/RqxAxHaim6k1FcOBVhplQjTXgve5uxbFf0ncWAzCpPXg5aqPA+09c7pSndPUhLsel3qw80PtS5vLMDVkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805167; c=relaxed/simple;
	bh=fyjn8T2fK3Y1QyHDpsxZwhGYVrBaYACnbn3w6xSn/NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJMOZTHzOK+FEhNrIClc+hpL9v+5HPuvuCNIXMEnpEy0DdEcbRkoll4lFAs3e6bIarIt8dkeU+4ljjTidncHGZmtpI7EjMaYz/KhR/1O5YD6/NNMFeEX3lkVmmv45c4P/3ltijUG62w8IJ+fjidc0zgSG0DMdyPRDwT3/0pDGeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StPTqJc7; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StPTqJc7"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1025922a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 12:32:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769805162; cv=none;
        d=google.com; s=arc-20240605;
        b=VfsTy4rYMlVEZ6LfAHmSIxUVliDesx+oxyjM2NygE1FFW3uDZvXX5kecA5orCDaMNQ
         3Bei32vmM3Jl99+MtIl011vEhAS55z0TTg/oYtotaErWKd22Zta+INyiQxoH05bXKXOw
         DHKpSiE1pjNy54xzXa99l+28Tx0UVSROaXYyEiacQJmgSctMVslKg5R8XiVuCbkqa+Td
         y4hB/i8xg9Ph9OuLylv/OFdqNPWvE7AhsJRXjTPTKoJSJ+ypm7aBfIelugna3GZdIgPD
         cFwA/1QSy4EavlqnvOWPWD9BvPmTM80VvnQm+Pwy+ocDsL8QhYeRvHZN1sg6QjFbdUbI
         rUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4p+gASIzn5rW2H2oCIdf7dVgnctkRAm3XiVfcDdGFQ=;
        fh=vOQAvUgyi+GJAxhi4D3DSqCSgC5c+xGy0dgUDE1X56U=;
        b=VGGplxrLOWBJFD6zVtd6f5wZN99z4f5ZNrj0NE9F7TIg3zq0pCa2f2TZVCiVgd/c3n
         yMa2YWAQuCE+yQbXBrmiq8JpBUKi3sDLuZrvXKz0qPyLPGkmv7GwrSKxBLcGz3FSgAXx
         B3k/C2fUz3sruyjvWmtf3BfDBoaYv082fbBvjtItsLertcCt9FbcB8YLPFG7I7to/X/G
         9CSN+pNU+gBerQ51GZRknCqI89iVJ/ph42YzDRh8FMSW5/W7yFxjyejuvx8Cwv49a6hV
         GSP7kQduPdsqfnbR/zQC6Fy0mV0Ecn67f14VIJDvElgsBfNIV6pWN2r/dG/GiwaKpwVZ
         Eurw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769805162; x=1770409962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4p+gASIzn5rW2H2oCIdf7dVgnctkRAm3XiVfcDdGFQ=;
        b=StPTqJc7IrEenQs62xmFSy9cGIeabwUkAPEQy+Y8bGupSGSHByTnH+JqgkhfxUTxuc
         Ih2dQhl4ZdzyAx2cTJq2W+u/0coMHaqc8a5sc6xdopO6iSxkjAHWBx1oQEG6h5PlBBOX
         tEo73RwpgQI1mmp/3ShzojxG0zkZ7MyJ2FOXcBicDxt6baQdqwiRQ9c0Y9eJZuKDezf6
         T93RXYlV3n4UOlsFXgrvSDenKelKubXj5rGFZrzcadeDR+gv/2FOG0WbaqgurIvhuxLK
         sq3IO5VixXIqPCBYb0YWx5PsFlTPvKebZ8RomO9n6pXGEXfjudAAWUkSSE0NauQHFrAX
         d0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769805162; x=1770409962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4p+gASIzn5rW2H2oCIdf7dVgnctkRAm3XiVfcDdGFQ=;
        b=FFEBlQdBBWxpjdJZ3mcjQVEDIYNIGTv+QgP6111iIrzXD/cGdXW79PDumzLLxwgewi
         2MS0lzxX0GfBjVvrS+cMdwkh/acUijFJOMneolJgN/aII4+hS46VOlRRNZgSSU+chMJ8
         JkheEg5qz/ppkTNy3SN5CcguOoQF61NP5visAso2/zi54qKh/4KHfPxPrTf/2m0c7DUh
         Pn87OUIIU6N1eTkVMufWRovTZzQ4o6av5VEfUGIK9efPPAgN40AfHht8iKNOjDELmofR
         7so4gfL/B0GzPL+PfWS6l2g+aH74PAOM8XiWVKcjfi3e4d2Jcg1hPbY5vTBliw7ZT54E
         Kz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVvWSHP5IycIsHZ1P5EZSinbs7pi74i8qv+CqMzuG7nZFI+MSSLLI/yKOc7XqxZtAk8ttTpmMeiOoC8PnTIPIZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/1jGZVPsNDY/ZsRCL5jD0mZmN6BZtj3aIpHEOvCY6CBCwJFp
	s2k4ucWTVNbAUpukeobHBLDQlZT1pkItlHVI2iSpTSoxy3bkn1IEMPXHiQCl+Nhw3FOa2Dyoyfh
	cIev/5s2GUcrLLKbg5nQN3WwjUic6isc=
X-Gm-Gg: AZuq6aKSI5XuQYk+Ho/QfDy14lxtrgf8XZcNc2Ej30rUNivbOdMc4G0QXxnv4kD/A5r
	Cj3X1KBohkKhjdj0yEz8uqHO0zrl8JldS/Oj4Dzj/5wx+r0YluPbxfNKQoTGCCJv9KcFGmzfjF3
	gu/9oV1lD1j93kxJexbUxY8hmy5MwZJtXMhXVBh8GtBxkyUxI1cwfdU/J5/jADqJCFQF1mBdbAc
	EVy9gWFctIfw1S4YV9nvQH5mU52iRK2L25CpTYJTlIPI2t847T90NVKZjRXfUplkI3eOLQ+sbBM
	BkLpGHb1VaA=
X-Received: by 2002:a17:90b:53c5:b0:34c:3cbc:db8e with SMTP id
 98e67ed59e1d1-3543b3d0262mr3832492a91.25.1769805162196; Fri, 30 Jan 2026
 12:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127023618.1469937-1-zeri@umich.edu> <20260130102300.GA171111@noisy.programming.kicks-ass.net>
In-Reply-To: <20260130102300.GA171111@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:32:29 -0800
X-Gm-Features: AZwV_QidrVTjqLumikxCKlaD6XVlqLqIqwQyz0r7VB3D0P9YN6jXJY3NyntkSs4
Message-ID: <CAEf4BzahX2oRRU7a9n8NsM-b+MMMjbDKpOEXe_zpR8XQ9=9H=A@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Henry Zhang <henryzhangjcle@gmail.com>, mingo@redhat.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Henry Zhang <zeri@umich.edu>, 
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 2:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 09:36:18PM -0500, Henry Zhang wrote:
> > KCSAN reported a data race where perf_event_set_bpf_handler() writes
> > event->prog while __perf_event_overflow() reads it concurrently from
> > interrupt context:
> >
> > BUG: KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_p=
rog
> >
> > write to 0xffff88811b219168 of 8 bytes by task 13065 on cpu 0:
> >  perf_event_set_bpf_handler kernel/events/core.c:10352 [inline]
> >  __perf_event_set_bpf_prog+0x418/0x470 kernel/events/core.c:11303
> > ...
> >
> > read to 0xffff88811b219168 of 8 bytes by interrupt on cpu 1:
> >  __perf_event_overflow+0x252/0x920 kernel/events/core.c:10410
> > ...
> >
> > Annotate event->prog access with WRITE_ONCE/READ_ONCE.
> >
> > Reported-by: syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2a077cb788749964cf68
> > Signed-off-by: Henry Zhang <zeri@umich.edu>
> > ---
> >  kernel/events/core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index a0fa488bce84..1f3ed9e87507 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(st=
ruct perf_event *event,
> >               return -EPROTO;
> >       }
> >
> > -     event->prog =3D prog;
> > +     WRITE_ONCE(event->prog, prog);
> >       event->bpf_cookie =3D bpf_cookie;
>
> What about that cookie thing? The consumer seems to be a bpf function
> (bpf_get_attach_cookie_pe) which can equally run concurrently, no?
>
> Also, there seems to be a coherency issue here, if prog runs, it expects
> cookie to be present and all that.
>
> Would that not suggest something like:
>
>         WRITE_ONCE(event->bpf_cookie, bpf_cookie);
>         smp_store_release(&event->prog, prog);

yeah, once we set event->prog, we can theoretically have that BPF
program triggered before we set event->bpf_cookie.

But this setup thing is one-time and can be expensive...

>
> >       return 0;
> >  }
> > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
> >       if (event->attr.aux_pause)
> >               perf_event_aux_pause(event->aux_event, true);
> >
> > -     if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EV=
ENT &&
> > +     struct bpf_prog *prog =3D READ_ONCE(event->prog);
>
> smp_load_acquire(&event->prog);

while this is very frequent. So shouldn't we try to avoid unnecessary
overhead here? Maybe just use more expensive memory barriers in
perf_event_set_bpf_handler() to ensure that bpf_cookie will always be
set before event->prog can be seen by any CPU?

>
> > +
> > +     if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> >           !bpf_overflow_handler(event, data, regs))
> >               goto out;
> >
>
> Hmm?
