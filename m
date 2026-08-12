Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48BD1F4CB3;
	Wed, 12 Aug 2026 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493340; cv=none; b=XglYis5lQJt19jlZNpfYsBl4RNOzGV7yfCND5t9Psc6WTN60eKECsvpMZOFZF2wgIPbBOzATd0Tz+2qLFGmlWxtjvUbcFEKjOFfVT7o5iqVhOkZnlYwCkanMOJtLOy7T3LCGj1Qpr3gpwtEGJm3BKWIMmLxJaxlPSmVIrnuTfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493340; c=relaxed/simple;
	bh=02LXLtOohRtNzDLZC8jHZ4zJXKCY2Mr/fq8f6DK+7Bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zv0XtxdftHwXaUKrMRqvvr+SY76H63iUtzmhhKVvGCCQRRgXwDrnP1gIeJATGKB0t5YkkBwtsiUsA24WDizLUmPHhCcWRCEa5dNK2XiRRtbQux9b6nLdDN6HX1iFCRYMPyK1Kk5uGj3VwP1Nj5Gf2Q7VeZ8043TdH+7aCqzwH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1pQ4w6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1pQ4w6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FC1F00A3A;
	Wed, 12 Aug 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493339;
	bh=OMUGuca1IXTejWpojw+yltOhbTqG7NWSohLYzyaOFX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1pQ4w6quPP74tX2lPUkmAzFb1zbiIgzFbB6AfQSwQJ96CVrrl6KgpCSWQ3pgocAz
	 +oQUQ4yBTvuj98yTuoBOOwFegX6vO2lVIhgTaa9HeZARRs5/Sz/dKwneG5INAVbxQC
	 nsYR7RzMOZOSd4chT+zCxi28mflZ0ocOOTFcP9Llyvw1FFM2jXlK8BDLJAbXJ42INx
	 v6vq+I8Y0wB/oANj9KeUy+fe13CJl3HuuC4b+8ghK0tvtwmnOARDqniViVU3ME2lE5
	 08lvRXFIodVmj3ddyHzcR0mSbeq9ZDOYl0wKSjvYOak5XYe7huYn/fCP+NwNYFlY6R
	 3Me1S45JEkQJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/bpf: Fix data race in __perf_event_overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260811235331.10044-1-kartikey406@gmail.com>
References: <20260811235331.10044-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:08:58 +0000
Message-Id: <20260812000859.654FC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless TOCTOU race in perf_event_alloc() causes NULL pointer der=
eference or Use-After-Free during BPF program inheritance.
- [Medium] Incomplete fix for data races and missing memory barriers in BPF=
 attach/detach paths.
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race drops valid perf even=
ts during concurrent BPF detach.
--

--- Patch [1]: [PATCH] perf/bpf: Fix data race in __perf_event_overflow ---
commit f63a2be5ceb79a2a8bb0263ba6723f7bf4ae763d
Author: Deepanshu Kartikey <kartikey406@gmail.com>

perf/bpf: Fix data race in __perf_event_overflow

This patch addresses a data race where __perf_event_overflow() concurrently
reads event->prog without lock protection while perf_event_detach_bpf_prog()
writes it to NULL. It fixes the race by introducing READ_ONCE() and
WRITE_ONCE() in the respective read and write paths.

Reported-by: syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D651d2774bd1d8395595f
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through over=
flow machinery")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -10766,7 +10767,8 @@ static int __perf_event_overflow(struct perf_even=
t *event,
>  	if (event->attr.aux_pause)
>  		perf_event_aux_pause(event->aux_event, true);
> =20
> -	if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> +	prog =3D READ_ONCE(event->prog);
> +	if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
>  	    !bpf_overflow_handler(event, data, regs))
>  		goto out;

[Severity: Medium]
This isn't a bug introduced by this patch, but does the independent second
read in bpf_overflow_handler() create a time-of-check to time-of-use race?

If a concurrent detach sets event->prog to NULL between the READ_ONCE() here
in __perf_event_overflow() and the second READ_ONCE() inside
bpf_overflow_handler():

bpf_overflow_handler() {
    prog =3D READ_ONCE(event->prog);
    if (prog) {
        ...
    }
    return 0;
}

Wouldn't bpf_overflow_handler() evaluate prog as NULL and return 0? The
caller __perf_event_overflow() evaluates !0 as true and executes goto out,
which unconditionally drops the perf sample.

Should the already-validated prog pointer be passed directly to
bpf_overflow_handler()?


> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_event *=
event)
> =20
>  put:
>  	prog =3D event->prog;
> -	event->prog =3D NULL;
> +	WRITE_ONCE(event->prog, NULL);
> =20
>  unlock:

[Severity: Medium]
This is a pre-existing issue, but does this incomplete fix leave other data
races in the attach and detach paths?

Other functions like perf_event_set_bpf_handler(),
perf_event_free_bpf_handler(), and perf_event_attach_bpf_prog() still
perform plain writes to event->prog without WRITE_ONCE().

Additionally, does this need release and acquire semantics? If the writes to
event->prog and event->bpf_cookie in the attach paths are reordered by the
CPU, could the NMI handler read a valid event->prog but a stale or
uninitialized event->bpf_cookie?

[Severity: High]
This is also a pre-existing issue, but does the lockless access in
perf_event_alloc() create a use-after-free or NULL pointer dereference
during BPF program inheritance?

During fork, perf_event_alloc() inherits the BPF program:

perf_event_alloc() {
    ...
    if (parent_event->prog) {
        struct bpf_prog *prog =3D parent_event->prog;
        bpf_prog_inc(prog);
        ...
    }
}

Since this accesses parent_event->prog locklessly, can a concurrent
bpf_perf_link_release() clear the pointer? If the compiler reloads the
pointer after the check, bpf_prog_inc() would dereference NULL.

Even if it is optimized to a single read, perf_event_alloc() is not inside
an RCU read-side critical section. Could a concurrent detach finish its RCU
grace period and free the BPF program, causing bpf_prog_inc() to write to
freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811235331.1004=
4-1-kartikey406@gmail.com?part=3D1
