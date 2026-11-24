Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795551308;
	b=hzWTcv/9G3liHTh8xhU+NT1lZ3gJHQyz6W6Oikg4uaO5oZ8xkugUwzWawKJykUMj24R0
	 owwM1h3Jl9dwmWDPUH7V8EeNbn1IYNbbQ6GHnbhlqaKcSCFqGyZdBWVqIRgc/ZHLd6sV+
	 OzO47A0V4oab9JaM1UF4+WOK72L5S6oWE/KWtx6NEklGP0b5OJSMqqGGA/aM7csKay0B2
	 mz1PswEv6WwK9luP9UfVe0/XVSjv5J+e9XxLHESWgscC9eFS3z29pxZjpKu2VwXlF6NlQ
	 Q/loP81qYbzg1KECJmIX4whHuxy0bgcTJ3Wbuu/6dceO+7YHLBnKoUz4Fy0InMugX5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
	b=p0JaVAY7OkcM7PtXyPWutwJD+J7Axhl5JugUdKm0gbTAM53eRAj352qA9FeV2vQYZ6Zw
	 ghO+Y921Ume5cepdfq6Dbjr9bPS3OppwMRs7khOsVK6LCW17DHCPqBCmbTZJ5YMylFHJA
	 sIq355ocnpXcSKQVrMhJjeMDbFIPelZyMqc2uE0quuFOoW1VqHj+ZeVjCtO9wDp2YNwxw
	 nUSGtGXjyUpHVkXDBKvASPn5eApQUDACnIceIiBuJDsJNL17FcF+9JWqhcMPzi2fikD3M
	 VjgEi+M6NMTRJy+TUvVkJ14w80K5+QydsaxG1FaZ227hbBH7J+wW0TI9s4xNEpIioWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y2eb5/LZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08866606A330
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 20:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08866606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2eb5/LZ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so40125995e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 12:15:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795551305; cv=none;
        d=google.com; s=arc-20260327;
        b=jaaLnGtUUOohTB33xbbBm29WHrX+UZHt9ZJTyKNcnOgHov92c8VqlG4VQxWyXcEaTs
         rzbp/qNe3FRbHRTrwcyI1ltjunVCF40eQ4u5saqbdDPP29ZkdG4l2avlQmzwK5Oxwwui
         bzFY+euV/dZSRrNPIBF0xABaDmA+LdZn9Mr4N+4H/mJnzb40CeQou2eTrBI1BbexDY/8
         D2xSBAPLmMHsBJX3WG1uKgPbkMiDLM9/Ovynf+0vWdMrbI2QlwXqqmVjhVVzch3Uuomi
         Q4AsmgvCfeQn2F+26T8p3GHiAlib4BRO7Ve22OB1DNZ4qRykiWwcZNqFgBsxPScb12zU
         hqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
        fh=7I4Q0lL55w+VgcQbaRgvu9NnVNIer9PwGUNFXd4yrOo=;
        b=JQUzibaRsJpkSpia2O9aDrLRovsRfEidd2wncTjWLvp8I+sCkG3Yfx/D+zD6qkd6oI
         aKozkr1bP1u1NC4j6gZSPOfwyjBleLn9Uqo5b3eddbszBY8U8XWlobBWPZrduPFS2ANZ
         REsETvtzvaFvDCVdhGU2O7wg+WemmJjT4qxGumD8wfAKC+sY6GWk1ifd0v3aMAM0MZ7V
         HVkbiMunwBXc4ZxCTHH3UmiUmokJ/HQq7EnVwMSTwQ4w29rBumBIauoxWqWxpu5b/6U7
         wxrwQJMIWYV53EEHNf1csGqa+BZkR2t3gN1/V5+gVQRBWktIcQ269KP3sNGDekAmu9Ax
         kUdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795551305; x=1796156105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
        b=y2eb5/LZeksmRnb/4Tc2gs3zEYVlgZK6T9qGufOag8Bei+G6Y7t18dJrdfcsvGlTj2
         6lA8CxMUbCuClMKZB5cGfk34by0jLI0jlg1ITdQuWWaeI9HqWFJM2e6Rfg0ZTvX5bQNz
         sjLTVmYDhHX7FjEy3iFjcH6ocEmZ8837BGVvoM9kmHUGDUOl2mRex509wcp+CrZiqNzJ
         4wL56UkWq4ohRa//hvlDtRSTqz1NEniqS2+TrZGYFdakFMsHHsAml5jN5QhVCS+IlyRL
         AZQCCkyozn8O5IF7E3DA218PR/ku9M+5dQeD6rmVKcdzTqGqk2hVspiW/CAq14t162hF
         fBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551305; x=1796156105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi553oKEuwJxtkzT1XB/uqe+x5Rc2UJPrmYbDOw3Bd8=;
        b=B5tCYd3+CaXqX7pQExkcd4djNPo/O0awUVvXCEMzX0o1IBfnQGMBDxyT5yJIo6WZbJ
         YgtISxJo0pV87zaPwmPSwddo1zsi5UexMgyCjAIPDth+dk7YCY36wJ7xjApsK20gYdjM
         4VJ+1jR+lvJ8B2WW701nPFcuBfAAhptc+jRrijqKY3dXItV5LguI98U0vDabmKpDD67I
         nuVCiRVIDzzVpinKg+0Min1ZEZjTruuQwH23zrXh2gOLxPasWgtYRfP91WJvE18Qe9qn
         62a1OHjTLRb/SNAf/NLvD6ARO6gTKX0d2D9BwsOMoFsmWvpiSSKctHx1H9Ffc0++QStg
         Vv9g==
X-Forwarded-Encrypted: i=1; AL+hErHBFLoQ9zQeZ8srL1qMmXQanKwMut/IyQJVJ+FBjqpjfZyX0/+BlU28XrnGWy0vKRwT8akf+610//uTuo71Qeqj@vger.kernel.org
X-Gm-Message-State: APuU4Z+6gIrflMAnZiw+OAqHVHOjoLQsWtE2PYcJlYNhhu1RJSws3QLn
	CS9obOKGOjwe4aOiojckd+l1ZguBIS4G9c4xiXwl/P/GyEGHtlJ9+sjRXYDxotAveYtXGSfQa7b
	IJzwrvffrvBSsDfvwopmztOZ4nI3QBmg=
X-Gm-Gg: AZFdTZePbSsRl1Zzmx81DSqcu16OBWwhtCCWjqoR7pDyCE2cRAsDmwGZVUPP+Ws0Ysm
	JPQyYEq2lwDAcXG4tC+2VSGdIrGs2a5QFUJ4JdRC6QKPA4BIqBL1sR6o4n9fEv3Vi1Q2doAeOFC
	Irm5XKk6BAI9e/vj4d7XztRSUtV/6JmhndwrRWNZtrL40I0eJrruojBax+4OE/rGEERfHCRkPxF
	5XW8ce+NpNKu/ZfYJdRXLIif6MxJt9nBoBjLI82ia4+CA2i27t5tPiVMSt541UCLxnHvkfAQq3p
	3EwubjaEh/aX/hYQ+MhK2nn7m+VDjIBdP65LDghNz46SfXJUiIDglXwuLuFbGvISvbihjnx9zuv
	nAUz2AR+35GyQueXrw+9Igb1EiJrL7x73y0N1e/NOEjqpi94OLDAC1yhPmFAhZcedo7bFYqNGve
	fpe9BRwADfJPkAIOG/Fw==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id
 5b1f17b1804b1-4bb88922972mr332691925e9.34.1795551305115; Tue, 24 Nov 2026
 12:15:05 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
 <awRRgnRmeMDUvUWz@redhat.com> <awR4plQC_oIvoc2R@redhat.com>
In-Reply-To: <awR4plQC_oIvoc2R@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 12:14:53 -0800
X-Gm-Features: Aa3M54of-GC7sd-E-HO4C2skMXhoQ64d9-dKg68squRz4l7HKi30ussUDXcU57o
Message-ID: <CAEf4BzanZC0Zwf2FDVUjv7JxDvL3dQ3MKvJ=_Wz5k1aADD4y+g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return instances
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keenan Dong <keenanat2000@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Keke Ming <ming.jvle@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:32=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 11/23, Oleg Nesterov wrote:
> >
> > Andrii, can you take a look? I never understood this code in details,
> > and today I forgot everything...
> >
> > On 04/08, Keenan Dong wrote:
> > >
> > > ri_pool_push() returns a return_instance to the per-task pool for
> > > later reuse. The pool reset clears cons_cnt, but it leaves
> > > extra_consumers behind.
> >
> > So at first glance this doesn't look right no matter what...
> >
> > > A reused return_instance can later grow a fresh extra_consumers
> > > array and then reach the cleanup path with a stale pointer from its
> > > previous lifetime, leading to a double free of the recycled object.
> >
> > Can you add more details to explain the possible double free?
> > This is not immediately obvious, at least not to me.
>
> May be this has something to do with dup_utask() -> dup_return_instance()=
 ?
>
> If cons_cnt =3D 0 but ri->extra_consumers !=3D NULL, then
> dup_return_instance() -> kmemdup() will copy old->extra_consumers, but
> but kmemdup(old->extra_consumers) won't be called?
>

I think all we need this just this:

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c47b1ee266d5..f265527e6897 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2118,6 +2118,9 @@ static struct return_instance
*dup_return_instance(struct return_instance *old)
                        kfree(ri);
                        return NULL;
                }
+       } else {
+               /* old->extra_consumers can be a leftover buffer from
ri reuse */
+               ri->extra_consumers =3D NULL;
        }

        return ri;

cc'ing Keke Ming who was going to send this as a stand-alone fix
earlier this summer.


> Damn this code is too complex for me ;) Anyway, I think the changelog
> should say more.
>
> Oleg.
>
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_re=
gs *regs)
> > >
> > >  static void ri_pool_push(struct uprobe_task *utask, struct return_in=
stance *ri)
> > >  {
> > > +   kfree(ri->extra_consumers);
> > > +   ri->extra_consumers =3D NULL;
> > >     ri->cons_cnt =3D 0;
> > >     ri->next =3D utask->ri_pool;
> > >     utask->ri_pool =3D ri;
> > > --
> > > 2.43.0
> > >
>
