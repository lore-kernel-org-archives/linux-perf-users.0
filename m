Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4B30AD1C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803499; cv=pass; b=dIyXI4Ro9IzLd1v/kAPJ0l0oDZLYwniJY1nBfkUN8162oJYk1XPyy367IF3CgO3NtKj0xYdiXFkIUYppw3Ss5baACAk49141DJwL79LacR11EJLR4JGGozaCMxbtLFLSabqRPq763JubTfHOH9YIiWGaAgmZOOpnaP0m5yFxZNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803499; c=relaxed/simple;
	bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbT6tm8plqxgN0wBnLT4Q/0ZIFF/B64VQ8Jvvuhs9S4ZAwSavGzN4u4veU+FrZEjN695ONMubm1QX35sY/EM5peLFMBOVJXCbtRPKtUj35u83G48wVFim1VZOWuG2nRMkGeN4YNosscUJAwOpDsRLwjgisvsqSW8Mq6Xn/QUiBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae/z5pIP; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae/z5pIP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso2185826a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 12:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769803498; cv=none;
        d=google.com; s=arc-20240605;
        b=Daz3fNkMhkaI+jHqrv4sLQX2D7fb1kEq8AVHWOPLHTsLFFdEJLiSFwrvd9wN//FOoo
         sdyix/nzvt6ZMlGZHn+y70HufbGmouuUaMCLt1C7a0s5sd8+KKuNrl8A3v4YFQa1z31K
         WyyyeAvfHfLLtlaDR4gx99zA+sb+gvaPObPQ9EtIpFogN4nr7vZsd6LGGyrU92XGfz5c
         HgFBYuP3v6RUYBrZyM2PN0k5M01UwSAAAsEP1c9dTv/Bgc1dCjt6CXrox1hrw59NPinb
         pLP5ixUUUGjHwH3e/8Un/B6OWCIC/YCCnxFYDeHjllmzHN+QxzSJkX2/5ta+0s5E7uvp
         QQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
        fh=o8GAJ/stMJaJjfr73lbyU7g6G7sHjOSqxV/6n/NsQMQ=;
        b=lwvdfjnZ/ZV3HKck6SqJ4DiQivBNI8fG5pt5XJxBO2P+VPsmBT8+1wOoUF4T+hm5n5
         pDnSUPKOz2mW+sCG773cYpAqa5aOnt/HJDU6TSoW9AG5U0chGmhYEUZZlwlKwm/K2y8o
         7OdihPgxwYLbFmciBjuERHMCKe9+tZPS2dX3h9l5E0MoiICNXUusOEP3Spnnou05OZDa
         I3FJXbtnT8UROHFpF/OoS+/qaA15aDZ70RFmKwqo6NIxxXJuUz7NmO6DGWclJrmK80mz
         8Q828YBcn/7yOhvuzP7t+7ArC4eNIRcor3veYAEc1rLRl9k0daQrDz56mKHI/kqhP0Cz
         qHJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769803498; x=1770408298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
        b=Ae/z5pIP8sEBMWpbOlwKHH+5+N5k/NNnDlBqvP6ETtUWkt9EDy9ht4MsSeVU06H/0O
         4V6JkS4El4UvLaRK22Eeir1bamXb2qs4i6a3SreZlOelJezCpReBokkKdVWxLr/bcEV1
         RLKIgRpGc7o5ltcFV4aN9U0V/E1PHleEtBug1chB25yXLV7Tl1ZbTTBlbqVj2iza2fFG
         AOaQQG8jVWSus7xfFfPlJ39aIpItYJcRwAgjBxlQ0IHnOqHFDAUdvCc9u1mtQi5rGtnG
         NHP5/gZjvKtLN8Lo1DhJ463DAmF+wlQqmlgkOnMcdBg1npQ33+FA1bw0ZzcVrmcASgCC
         wWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803498; x=1770408298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oGoBRgPPoitzO+sWNnImbteEFTL97pD/pkLJ6YZ87Q8=;
        b=IgQNuDAfpNzIWZ6/km9wjCbKQzZqeGrqauTbLvu95z07niENpym4h77Dq0LLs1Fl10
         JGe/9tjCqrLoaH9P/MjyYDEGjRr+KS5IHY989AlgVI/3mHXU1Q77yShdlFXlZaxTafRN
         6nqdlkO8Ddk68j4FbRf6vh3u339mgveAZA3sxET2RUy6gRu/kQBIDUFoC84fxLjAYm9e
         l5zpsYT83m0ulHmiIuBIz+BpYevqpZqQzh5oZ3iaGAOXf3RRBB9I/75aAMvefZbICY16
         2cLmm0Br0nM1CQzXIj8qBc73O9yOZ62aWII+XJps8inovX2l/pTy83VBGOvA7w46QwIF
         uzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOwdYmw6CC3OFN9soNqh1rSqpde+4N68snjI1R2VOKmB6pAdYe4GdLu+VGPoybn9LAAZ0s+YGtJC8W+KguVGAn@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxE0YK2ak2zaJ4xI9P7l3PhSIdELfW/r6N5XYHi4JYUORPfSs
	GfGCO8mFj7xXJ4Hz9ul6GTOhnTXLoRf0HtvrOw0KGm4U7a+T2n2pAS2qH8v5soGVpKzKliD9hIf
	Gz71M8H2qP7jG93wAj38vLGRERQDh6DQ=
X-Gm-Gg: AZuq6aKL75rInORahT284K3fWtYngws3YRu3DKqGXvTk43+xHsJBrG6T+JoWV4cYyY+
	rWmsoNQSNFnrDq3DEsxR0w7CZaw/2sqyrH5bDnUcN/CUmjgBHOTdxXalD+UVeSy4A6nkfeirx95
	3Er4ilkH5NYJ+LGKAQKl3dsEBItLVFcnWXgoYpC3EGjyj6yPKcNtzdKPE8fZTsbdua+4HyYe37P
	J+3roRYdblHF3/3Vqltyu+0ZVFO3tzX/AM/55tO+25PjDJG2IEMNMOScWwkE3kA5vIFNEukELfw
	yGVD9XilFyY=
X-Received: by 2002:a17:90b:35d2:b0:352:dbcc:d74c with SMTP id
 98e67ed59e1d1-3543c504f9bmr3899719a91.15.1769803497900; Fri, 30 Jan 2026
 12:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
 <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com> <20260130113150.GB166857@noisy.programming.kicks-ass.net>
In-Reply-To: <20260130113150.GB166857@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:04:45 -0800
X-Gm-Features: AZwV_QgnGlAMMCWYO2hOpTAbHl4pZuXMosvtjB3dgI88kFwaBbShTBvig50tbQ4
Message-ID: <CAEf4BzZNOqxhkjuePzeG=ivqBSHXnWzPLPPHJdoC91c+u-WjAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:31=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jan 28, 2026 at 11:12:09AM -0800, Andrii Nakryiko wrote:
> > On Wed, Jan 28, 2026 at 1:10=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Mon, Jan 26, 2026 at 03:43:30PM +0800, Tao Chen wrote:
> > > > From BPF stack map, we want to ensure that the callchain buffer
> > > > will not be overwritten by other preemptive tasks and we also aim
> > > > to reduce the preempt disable interval, Based on the suggestions fr=
om Peter
> > > > and Andrrii, export new API __get_perf_callchain and the usage scen=
arios
> > > > are as follows from BPF side:
> > > >
> > > > preempt_disable()
> > > > entry =3D get_callchain_entry()
> > > > preempt_enable()
> > > > __get_perf_callchain(entry)
> > > > put_callchain_entry(entry)
> > >
> > > That makes no sense, this means any other task on that CPU is getting
> > > screwed over.
> >
> > Yes, unfortunately, but unless we dynamically allocate new entry each
> > time and/or keep per-current entry cached there isn't much choice we
> > have here, no?
> >
> > Maybe that's what we have to do, honestly, because
> > get_perf_callchain() usage we have right now from sleepable BPF isn't
> > great no matter with or without changes in this patch set.
>
> All of the perf stuff is based on the fact that if we do it from IRQ/NMI
> context, we can certainly do it with preemption disabled.
>
> Bending the interface this way is just horrible.

Sure, but I'm just trying to help mitigate the issue at hand (way too
long preemption disabled region). I agree that we should do something
better in terms of perf_callchain_entry retrieval and reuse, but maybe
one thing at a time?

>
> > > Why are you worried about the preempt_disable() here? If this were an
> > > interrupt context we'd still do that unwind -- but then with IRQs
> > > disabled.
> >
> > Because __bpf_get_stack() from kernel/bpf/stackmap.c can be called
> > from sleepable/faultable context and also we can do a rather expensive
> > build ID resolution (either in sleepable or not, which only changes if
> > build ID parsing logic waits for file backed pages to be paged in or
> > not).
>
> <rant>
> So stack_map_get_build_id_offset() is a piece of crap -- and I've always
> said it was. And I hate that any of that ever got merged -- its the
> pinnacle of bad engineering and simply refusing to do the right thing in
> the interest of hack now, fix never :/
> </rant>

<hug><nod></hug>

>
> Anyway, as you well know, we now *do* have lockless vma lookups and
> should be able to do this buildid thing much saner.

Yes, probably, and I am aware of a mmap_lock use inside
stack_map_get_build_id_offset() being problematic, we'll need to fix
this as well. One step at a time.

>
> Also, there appears to be no buildid caching what so ever, surely that
> would help some.

Jiri Olsa proposed caching build id per file or per inode some time
back, there was vehement opposition to it. And doing some locked
global resizable hash that might need to be used from NMI sounds
horrible, tbh. So we have what we have today.

>
> (and I'm not sure I've ever understood why the buildid crap needs to be
> in this path in any case)

Yeah, perhaps, I haven't dealt with stack_map_get_build_id_offset()
much, so will need to go a bit deeper and analyze. As I said we have
mmap_lock problem there, so we need to address that. I'll think if/how
we can improve this.

Do I understand correctly that you'd rather just not touch all this
for now and we should just drop this patch set?
