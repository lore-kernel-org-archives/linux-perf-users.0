Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123183;
	b=nv6G90V+Kzrts8L/zFtrHdC0PltJ/5HmfMjIb8t67d4B6qPcK1yh8Nr6mctQRk0Sd//e
	 BBS7hKDF5c4QWglTAmaYrGBiW3dNnnRhnBHZvggzjIgUBDzz3AsYGkLLGujV1TdNtKeuH
	 P8I2ZDMy/tiUefLqlwpurJygBc94wfHmyKzfakkyYBWY8gnN95z5+wx03KpDZQBSq9WCc
	 6+TlinX5GZ5Y6tMjxc8XFRPsXhNDM16q6hzz286gbk+a2vEhRShjMrxUqDwFqeavZAnFN
	 V7spD6GZcprICU7bmYVu9Xtk3NTAZ9ZryFU5BdUK/fs21nFl7yxbtTj3H1XgE06YpyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
	b=vcxIPWsxres2epzNH+YgKbItTPwI3UAKP7QVc7tTvHjJ2yYNqVyqgW8awUaRYR3DRIge
	 Bx4wZyk644VeJfwc5jxAnhlHYq2Q9Nke1P5BZQ8kKdEwqGMGLyh9ftl5NWEf0jPhAYOn9
	 kol6LAkb0vvu+tjt1gXQxP4SmHLqk7UQem/NpZH315MqC4uQ5KF2t6FplSCH+JZBktEjq
	 1x2qrQhYa5fVWJFBqESzxoN/KGByQi+OBLAL8GZU8lpvmdF08sN1SDytHUpYatYH5sER0
	 PRqau7WNslPBjNbo88QoF7yYmlLF8JKev/2SyM+zPHgX5fI633X5ud+Fudvd1JDzrXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=evKXogKr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D0606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 386D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=evKXogKr
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c418e215671so12442066b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123180; cv=none;
        d=google.com; s=arc-20260327;
        b=nG+uqXz9BHT6oKQNfqabTGNMa7CKte0UR+sHIcJHzq/cTysRBrdjjsCRJXqjbWsssx
         hPGhKwkg/eximzVd1bkETG2IxEpA1Etn195+SeU9o1XYW1BNy/cNhmMtrfBxkv0lEMNL
         uiAcLuuIpwp1Zljk+JlItFjTeyr/oYFrXUJTO1+KTqg21P8//1+t5vvD2+iToiUUxbl4
         AZSgwvAlcSY7QmHy0J4mRddVpW74ALECKEmH1Lj3TfaRFWBDO/YIKt0kxD34Rguc4Ejf
         xZSWHm10//PA0nZ0JX3MggicWwJ7M1ap7ZgS6OwRFojjhGlHFwPySt6/sx5IsGU4hIIR
         3eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        fh=/98MT54P9E97/zE89uwXiXSY+xcTio+g6fJPGXlc3TU=;
        b=c2BCyT1nTI3qoOXZZQqOD8U9jgg935nmGQcj+GIfa6n/O02d333wC+W3NPhAKk1HOA
         cHW1gLcTb4dInts2JPMjd8Htzs3qXETkZbzWE+HI95lq1S/cc/pBKMU9K4SHzRsxrQRn
         jTaumgtuZ02KLE/UOLo/zrV5zkOJjVJgT/ytYAESxIvVvJOvDScUcg9dIzaiPpN+FAv8
         NcukhumPI3UMzqx6jfDSi3squvNrSTALWYAzUfBSyioyYMmeALOjgdYNwIKIFyBAWGKh
         bZRL8z1tWFG8KLdZd2sEaw3Y+FT1GLw3fEQaTTamy1PU9pt4b8GNPWBss2mAgSqopeoe
         vGNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793123180; x=1793727980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=evKXogKrv4QLmHYqCokY6eoxjCFUmFkxFngkD+J5pd+U8PqGflJnjYXElfwUyBFmzF
         qV4wiic+wqbW2dbP2pY/QKOyX8Swo34I5YK8mrIPfmquTi4YHY3KtxS9Y4oCL4EYN8+b
         gZgC3px2HQD2ClUQ58JAFPuTSuRNsxHfG7Ksla9B2okECXJvEvGeRLEkfL0w1iLCQuRf
         XY+TtQ6+OqXyzAWBWKoLnCli9E1dJ9okU3IZtHsHGFSJ7oI+uUVEKLZVuggzNHkBO8bv
         MIwH/ZO2fAiLc7nxHKiQCb/8R1CLEajO8mjY8W0wf+4Jx9ahNvsdYjka3DkvChZTYg8P
         y67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123180; x=1793727980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJVDlsrsrfYz550OKB/3hdZdazvfDU9t83gGSE4oBec=;
        b=T/3mc8uzO8DwpWuMKwh+zKqiaukgeRpqvK0YX7aQwqJ2wHygsAhokF1faY0TncDHYy
         IWSMilp600UbBfGlgYXZM+k/s/xrYKJ0dO9nQ44wibGYcYiqQ/EPiB7eSUzbZS+QaabX
         8mZVlPhmRC2VGDRyQ0GxgXnd1xdRQxJquPTMR44uh3oSNGO+75OIlAjRigJmHqEm+ulL
         dcYRnBiMwjwy8QJDmqdOcXtY6EnxG0ZVXdfgLOFsnzAJCTXzDJ4M8Vbmj8Jjv0b7kTa+
         IkLkb9QHS8QL9qmPArwbyOY3N5yq1ofd3lI4EAKbTt4wCuhPcnb+lNBPFTrciDG6E1CW
         NTCg==
X-Forwarded-Encrypted: i=1; AKwUvBzbS3SLygZlY4QSrnazXx4oMQ6CIURkTruu6EwgKJ8/EK8ybm8oJhdXONQ3hAJsT3r2+0P4Iu9KnPiag7RsH8HU@vger.kernel.org
X-Gm-Message-State: AFq9FYJMEdKMTrb0OHLon3A6Ed0B8/uuUtga1usJ7ow1Wpq+MHuo4U6x
	/TXc9DWs+OSbt+PcGjsEKQVFPcyZNPi2vhScHAOqI1Aq+mOuIlhsHBSKbQ/9dQaBa/ifo17vjX2
	Oq+F7EGkuVVz+VgA8LvPIBcJqefnIMaco0/Uyi1Sg
X-Gm-Gg: AYBFou2rzQmcsh/nNax2sSJPjVDTJYGNOKKMRa/uUend9lw1bXd0fioz7S5ribuXOSg
	OvKQP8taezopuVemfQ5/uEIlkS7i2ssY6rQv8Z9F8XXv0paVhLlLdTJJRIeLT+AYKIk6RJ8pa/H
	q9708jNeVPMtcZ6/4idepZ20cEOWpdCT3KmGH71DUPsSZJe3dJ3iZsItk1Rb73lon5vbjSAeZdG
	i8rIGQNczg4Sam3R594ll8ex3IMmadPJA8apzuFaZTRG0uLgc3J/OumEdH1w/ka39FdK5gBRpex
	JEG61J6MkIyP9aIhZ3lIhSZDO+W80A01L75WyMTmo4tTGSbzPQp6hH2/2HEFk6F7nlHPJ05YDit
	l7BcVWAoEXOeYM9PXhVta7wuEF8DhpwxulbjIyn16NER75usOAqecMB9wu6pVg0HezvUADDnAFH
	XvVuYHgTvCYYqS0w/45c9YiPG2arut2KTTQjDUsJcwIzCbb/VMY+O4rlzoLdh4keU3WboQ1dGSh
	P63PSsz3CDaT9VTnTQI25HvZ7qKrVl4xg==
X-Received: by 2002:a17:907:7b9e:b0:c41:b94c:4538 with SMTP id
 a640c23a62f3a-c46bdec03f8mr1197886866b.47.1793123179946; Tue, 27 Oct 2026
 10:46:19 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-6-jthoughton@google.com> <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261027110948.GI2668564@noisy.programming.kicks-ass.net>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:45:43 -0700
X-Gm-Features: AclHuK-GDZyG6m8BFpUMWxfSIBXFJlvlZbCjTm5c1oLpEFzow0OEe9cdwDWWw7s
Message-ID: <CADrL8HXtBxf=qixBZV5-iz1sqfZAqSrMR4ZsJTFXS0N84G+nkw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/10] perf/core: Don't unwind the user stack without
 an mm
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:09=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 26, 2026 at 09:52:21PM +0000, James Houghton wrote:
> > get_perf_callchain() only checks is_user_task(current) when the regs it
> > is given aren't user mode regs. However, BPF's bpf_get_task_stack() (an=
d
> > bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called =
on
> > the current task, which are user mode regs for a user task, even if tha=
t
> > task has already gone through exit_mm(), e.g. when called from a progra=
m
> > attached to exit_files() or to the dying task's final sched_switch.
> >
> > perf_callchain_user() then unwinds the user stack without an mm. That
> > access does not reliably fail: the user half of the address space
> > belongs to whatever mm happens to be lazily loaded, if any, so the
> > unwinder may read another task's memory. This affects e.g. arm64,
> > riscv, loongarch and csky, whose perf_callchain_user() doesn't check
> > current->mm itself. perf events themselves are not affected, as
> > perf_callchain() already clears the user callchain request when
> > current is not a user task with an mm.
> >
> > Check is_user_task(current) regardless of the regs' mode.
> >
> > Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  kernel/events/callchain.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index 9d24b6e0c91f..a451ca2a5573 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -245,11 +245,15 @@ get_perf_callchain(struct pt_regs *regs, bool ker=
nel, bool user,
> >       }
> >
> >       if (user && !crosstask) {
> > -             if (!user_mode(regs)) {
> > -                     if (!is_user_task(current))
> > -                             goto exit_put;
> > +             /*
> > +              * Even if @regs are user mode regs, e.g. task_pt_regs(cu=
rrent)
> > +              * passed in by bpf_get_task_stack(), current may already=
 have
> > +              * gone through exit_mm().
> > +              */
> > +             if (!is_user_task(current))
> > +                     goto exit_put;
> > +             if (!user_mode(regs))
> >                       regs =3D task_pt_regs(current);
> > -             }
> >
> >               if (defer_cookie) {
> >                       /*
>
> We have perf_event_exit_task() before exit_mm().
>
> Still, it doesn't hurt to be cautious. So no real objection, but perhaps
> adjust the Changelog?

Right, perf events can't get here, since perf_event_exit_task() runs
before exit_mm() (and CPU-wide events go through perf_callchain()'s
is_user_task() check).

The case this fixes is BPF: bpf_get_task_stack() calls
get_perf_callchain() directly with task_pt_regs(current), so a program
attached to e.g. exit_files() or the task's final sched_switch would
unwind the user stack without an mm.

I've added this paragraph to the start of the changelog to make it a
little clearer that the perf event case isn't the interesting one:

  get_perf_callchain() only checks is_user_task(current) when the regs it
  is given aren't user mode regs. That's fine for perf events: a task's
  own events are torn down by perf_event_exit_task() before exit_mm(), and
  samples from CPU-wide events go through perf_callchain(), which already
  skips the user callchain if current isn't a user task with an mm.

Are you happy with that?

Thanks for the feedback. :)
