Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA74908BE
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849091; cv=pass; b=OAE8+kLLXVKaXfuqds3JoQZHSWGSX0YbczU8q1ghNEzsaT+ZzReDtLMLLtx86oh5Ox69ididnPrhYP2QSk+AEvjypk8KdnKSIIWbvhoGZ5dYvquZv7ZKkXdqpwc2LbdoUOB7q57M04RnT9nC2mrRXTe/cDgFwyAkrfBrS8gLymU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849091; c=relaxed/simple;
	bh=v7IQgN97nNU6kWAssSMaVVvwbCRHdAYIf+fc+BRypo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4l2v9Zd7xyrRW4wdoa/q0XSudFib6qBI4/3K9RQ8exQJcvB8dMWPhRf63yoRSA4AXNbjhroaeZwC2eO7OHqvpvzK/oAkOEWeoswVFkABk74jEk7yNMyCnVRllWHztXT1wMyl5PezdgWfCqyvqhMowqYL33nLcxMd+tPteL0aOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nphfjp3y; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nphfjp3y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso155083b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 09:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787849088; cv=none;
        d=google.com; s=arc-20260327;
        b=YwcacMNdU0MQZLQyCaMsw1nwRXfueUF9WiXkYV2+EkdduMdvpisusiymM1QQUONbPa
         yST9JALzBsdNWmYYKq5f3ZVwgLEHkI1LVh8t3l23wNd4YnHEsZdt28o3q1h//u58coFB
         nnvh7koDlcpim2sRs37cnjf/lQWyhhrdP7JRlR05jYYB+/JTuMTQBhUHN1nfnpqVYfp6
         HAloY2iDU3jKrnranF5HZqXPCEoYUkEaIbwCtayj9bkzBdwIED22SDZ5nRQ1WATiL2gQ
         rAqzR84eKvaKcMltl5A6SaELcaLbAJDhApkRAE8BEuDa8A8j2QL4XAtStgHMGwlvKJEO
         QFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v7IQgN97nNU6kWAssSMaVVvwbCRHdAYIf+fc+BRypo4=;
        fh=DNqn4NSsp89BfCofPJ2ebowZqsTARwqRIQTtWMRFGy8=;
        b=NhR/NKKRw7ttOJB7FyrtjgoYBpPHBQdDR8CwNW8DXYMuTUTjVy+iuc7HeyzZ8WiQfr
         emUhICaRoAXoa9/ot0kZvceMWZsadlLc8suqZag17SMH3RJieRsNhwChtdh9nWvig/45
         bZQTJt6DUZHXHlO8uKpd54OGssayVz9oYH0vxK/PBsETfqIJO6PR7GrZ4NvD3vKuPo+1
         5fqoKO9imsbhIySselZg46QbwltwtGxSvHGYPJz0tbtQO0W/eTzHGThx7NodSuVs4CGT
         FoLokB6zl3f+KohcWoL45s36fB8nFzp8w0k7gIRvQ4T6T0yl8lrqn+VlTDo5VXzuoM8f
         nx3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849088; x=1788453888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v7IQgN97nNU6kWAssSMaVVvwbCRHdAYIf+fc+BRypo4=;
        b=Nphfjp3ye4B8Xe7Ggq3mS3z8FVe6NelfabzfvszHK2g635RLdkxksOs73geL6Bms9h
         41ir4mPhcvKps2p3EllMQBKuIoUhBgNB350VEc3/TmSl/Vw/TAk2yERkbgg4TKB03LRm
         iQqk2d7BNCjVSseA253lgsbnqFWmTzrbZXdEQUYhzowEGanay7N33PpGLsLsWo1CdoT6
         hOKjZlm6IFpLn9b7TpbRwjgKtCdE2cdJZ4YTFyZ9x14hCNBaC5CI0su4yypNFX+ucbbJ
         DbZPPaefdJC29H4D6tVzXy0KqtMSzae+dtMqov/Rp7wZVVzyQCTQCT70dqidkPI/9fQz
         NqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849088; x=1788453888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7IQgN97nNU6kWAssSMaVVvwbCRHdAYIf+fc+BRypo4=;
        b=hCWfVhW7bT2rXDQ6F+3b20FbbPsr0yffrw5GqSHyG1EdMA7VkaOf6GEESAiZLQhe0n
         Cl1cP3Y9XwDSEWWkHPJP7zN8QjL1jF52TkP/o70oTb6fxVwEXC8lwtzl6Lb4rlnlijO2
         MHZUOl651I5QynjuQjdoEhJNhoBY3bQgGmegW0ScqCXyY4fQasYyLqyS1jDX/SFX10oM
         4bwni9lYWorTcvzS3d6o0a3cOvS/j7rTq9UF+cxq6RO2D43yxrHf2yL/9808U+RKTHpo
         NFYKZow7t3jpk5NMP8d+oGhpEY1kF4v/k+tRteA+hthpy0+zUE8LxT1ff9MxnXF/HsV8
         wzyg==
X-Forwarded-Encrypted: i=1; AHgh+RplLvkxeuaFbJleFTFju1JxIDbE/Nvu1s0SJStzHr93To65BrPOOwJxiYdRwfKLGONZap6vJYes6qp0xitgYUse@vger.kernel.org
X-Gm-Message-State: AFuF++kiabg1YKgJ1myN2D2Rvn7PauxyN4lJQJE8nPnjQgszv93x3Pcc
	ETOZ//h+p9sjNGHPIEbKSCT5glOJgahKjUdnZ9Rl4OR0KqOWoiu9+mb1UiqlHH1dGebaKKzlGPL
	3ZFiKvmv5mJmBe57SRDsqCRAnyHmSkig=
X-Gm-Gg: AR+sD11FHmb5Ls4SC6ePqzhpyBiM+j0XHdcplN8MLkUtaAQdCtU8X6kRIm8JjdTNDpg
	MC3wRHWQeGI3PY9W87lamCR5mAJ5q6TnpL1f/dDdQb+0fpP5iGE2o3flCv1r9MSWCeLy81LdFdZ
	rBe2liJbYZv7crhxuUIsks6SnZG0QftHjpgxj0ZDHZi6GtptYLv9nNkizo7ZBzEzJkabUM6YFnT
	D7NsEv9ABx3CREwYy2/0JxuRZYzSo0BJq8lAgSJkz00L++Lw8/vND3UU2UB0873mSA3byU+MbhL
	aIseZ25iDAKUlVMiSR9WB3sQ9iYEjukkPLCr/nQ1+vY5+0z/SaRNBwyiJh2yp1EUQH6rZihbzYt
	P3vLrSn5wnBJpo2UFpHpWf6fkiMEjF9sx9EZ5
X-Received: by 2002:a05:6a00:194b:b0:848:63c9:ee39 with SMTP id
 d2e1a72fcca58-8562a7d9953mr954998b3a.12.1787849088008; Thu, 27 Aug 2026
 09:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com> <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com> <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
 <ao2KDQuBMNtONu0K@redhat.com> <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
 <CAEf4BzZGQ50=B4S2NBZnqWN29YBgthMX8LsYGLq5rOsdGzpS3w@mail.gmail.com> <ao7Sr0zqFoiKgaRM@redhat.com>
In-Reply-To: <ao7Sr0zqFoiKgaRM@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 09:44:35 -0700
X-Gm-Features: AcwNN1VwKE6dNPobT74Ama0YIkZp7TzSNXhg7LUnXQN4SlYoNfZY0TE8WRNlOWY
Message-ID: <CAEf4BzYXCpm3wok2AOn5hErvoFSRGax5seRgr6j1LdFscDfA6w@mail.gmail.com>
Subject: Re: SIGILL and uretprobes, WAS: [PATCH] uprobes: Free utask on
 dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:49=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/25, Andrii Nakryiko wrote:
> >
> > On Tue, Aug 25, 2026 at 9:38=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 5:27=E2=80=AFAM Oleg Nesterov <oleg@redhat.co=
m> wrote:
> > > >
> > > > On 08/24, Andrii Nakryiko wrote:
> > > > >
> > > > > On Mon, Aug 24, 2026 at 8:57=E2=80=AFAM Oleg Nesterov <oleg@redha=
t.com> wrote:
> > > > > >
> > > > > > force_exit_sig(SIGILL) can't be ignored too. But I am fine eith=
er way.
> > > > >
> > > > > Current SIGILL sending is already pretty bad behavior that bites =
us
> > > > > periodically, instead of doubling down on killing the user space
> > > > > process because something about installing uprobe goes wrong, let=
's
> > > > > think about a bit less destructive way to do this. Mark uprobe fo=
r a
> > > > > particular process as defunct or "detaching it", or something alo=
ng
> > > > > those lines. But not just kill innocent processes.
> > > >
> > > > Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and
> > >
> > > The problem is that this is actually not a bug but a very real and
> > > expected behavior with user-space using fibers or coroutines. Any
> > > suggestions how we can make this less violent, as it's actually quite
> > > dangerous and kills production applications when someone (unknowingly=
)
> > > tries to uretprobe trace them...
> > >
> >
> > IIUC, this SIGILL and coroutines/fibers issue is due to
> > uprobe_handle_trampoline not finding utrask->return_instances, because
> > a bit earlier we threw out pending uretprobes due to
> > arch_uretprobe_is_alive() returned false due to that `regs->sp <=3D
> > ret->stack` check (for x86-64).
>
> Well, unless I am totally confused this is another thing...
>
> Yes, arch_uretprobe_is_alive() sucks, it assumes the single stack.
>
> And I do not know how to fix this problem... uprobe_handle_trampoline()
> must fix regs->ip correctly somehow, otherwise it is pointless to contunu=
e.
>

Argh, I completely forgot about regs->ip fix up, sorry.

> Note also that the current instruction_pointer_set(ri->orig_ret_vaddr)
> can be wrong if the probed task switches its stack.
>
> And we have the same problems with sigaltstack().
>
> ATM, I don't see any solution, and I don't really understand what do
> you propose...
>

Well, conceptually, I'd like us to try to find correct return_instance
instead of assuming the last one in the list is the one we want.
Whether that's technically sound, is a good question, I haven't done a
very thorough home work on this, sorry.

But we do have all pending return instances, and they record original
stack pointer, maybe we can do something with that? On user function
return, stack pointer should match what we had when we installed
return_instance, isn't that right? So in normal/happy case we'll do
what we do today, but if we find our that return_instance is "not
valid", we keep searching across all pending return instances. That's
going to be slower for sure, but at least it a) won't kill the app and
b) will be immensely useful.

> Oleg.
>
