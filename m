Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E531355C
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502395; cv=pass; b=q41jTckRu68zWBXgfYDrjpE5+68ogP/nlcElRqsa/EKGdzCPZQXjdW+hSoYe1Mk9M172yVPND6woG1u4eJV2YFCSUblmSY/Xjm8DJdLSQumqN4YlDWctySEFOYBx4L/jhbt33YC2qCOxjuwrsFD8rgxIMdKmX2qEwWaXJ3L+tX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502395; c=relaxed/simple;
	bh=BDQNW8ZvNX/V2i20uKVZ4uTLX1c7zmnxZH47HzRTh40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag0i6TrbN1Un5qRsr6Y9WEBTq6SliBF1RvY96J/iRxzqIcZqTpg0dFlpgRrZVm17mKJqs4veSVZUKJPKVZ7PWkiPYgfmH9Ri1/GVxBCpTA37+qNikNDVHiNrGtDssLzFwczfPkCfGQw0N+uuEi3Imqd9I9gQDJpj6XOPNe7yaak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrLmQFqC; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrLmQFqC"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836cde02992so32568327b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 09:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787502392; cv=none;
        d=google.com; s=arc-20260327;
        b=Wh3NNul00nBAw1HqAjiIYcldOM5WKrSdfOweWoyRjGcMqQwNInUdKOWQ600TOYqxEx
         m+D2a8+hg7Z2vD8R1IC+hrq3Qe/X5itZw4u5fNBcnU+t2ZHqGFf/s9HM8jqSc0LxAj99
         +CaD8EWrLhDj6ryuMK8hwQe5asBRtUS13uMnZ+3Px+om3PK6XGXaOGhqiMMOs5wVk0mC
         bYI08oo+XOfszup/wSTGWxD6TugElRNE3AnlTeSyXHiKCTi+UMKf0Sg9gJ7/U4TBG0pP
         Mt+qbnQ1YgB8klBpPn7LfWPKts9LBDOiqRJIjB49AMbhBhpBFbF8bLgdEx5i6ATL+co0
         cSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcJ4FwObJh92pRAMkcd67ABCe2E0B68MVr2alyMTC4I=;
        fh=3SJbdFIFUDlHeOw592FP0XuX+N5w6Px7aRhTdSBQDpY=;
        b=J8Sa1KblVRxdueRvhcoXk2ZSrs/6upU7cCFVwGtNFEYpH7F//X6WrkM5/m5qXa6XDd
         o5DRn+PU2tszsDegakqGqZ6a0rxY9sG+sG3ZunG3xGyH2QSfopLap30FIuFXH6R5psk/
         okJhX5+zAoX4o5JghMWLaNHQjKqmYhPFYmWcZKg2jUUMblSMI1RccmDPeBmykmyGEFOL
         UQTL9M6wuYROTG51fL1MD2iBscEe4UQcG0A/e5b0Bf4A6xHjAG8OCyyCYz0V8DLCVMc0
         e57jI9ajWNhLObKeS4/xoBM8XHIGL7QI667NgBsMd/pYNa7BRh3dgOEfWc4YL3FujJrR
         TvFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787502392; x=1788107192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcJ4FwObJh92pRAMkcd67ABCe2E0B68MVr2alyMTC4I=;
        b=QrLmQFqCL0ewWZ+m3afsYDif0Tx+uC1fkpr/BN2+bko3Vpde0jUujoMsK7ZJnrrbVm
         L2h2nhSqjw6bjv67wAQm/59WDtZfy6FjhfTxgTU/n3rDFBolog/SRcv6K55dtjzvvZuQ
         HlmY1I9C0lFYR2OH4WMMVHxa51MOii3xlyBL4jTk4ay+Q2Pb9iCu7jTCoAyurV2cWw/8
         aNP4IRkEJ48q/ae47evKoWqgBQ9YJP58e8FkQBnFJp//GxRzs+oxQ2Z6AsTCcmPlA/BR
         3jUxsqCgdBdjiucGJJ3AfcBnmA7UTAkkHN56LzFH8BRZzcHYcAVxs3OOK6XLDnm2s7qU
         p6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787502392; x=1788107192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcJ4FwObJh92pRAMkcd67ABCe2E0B68MVr2alyMTC4I=;
        b=srOUDNZDe9Mlt592WQeAmM2uuiV9TceIR7oZnpkqP2hZbCIuqwfpdQvIMgC3JC2ul+
         KjcYLXyU0qcQZUaQsAFWXLPxCS3mnLA144lGG34+t8nUhqQEn/7ulA86YnQBJjDmbLXl
         UKrtPXEMdpCIqDwDoutQWBtdb0Z5pAgwbBCqGUgw0/8NAy9VEdP6MUXzM00Z3+T5aF9A
         0IgYeFQbPs6f6AKHinG+893GYWXePCdD8HEpTE+8eEjOY7gpTvMj6h4YurFkJJ8ybr0H
         vkJdr82PiYopcRFLarv8vOuKBqoyj/e+PIM4o/m71zxQw26geHcqmTTGHsW2hM/tAOCd
         F0Rw==
X-Forwarded-Encrypted: i=1; AHgh+Ro55bspcY8nuocf/JWRqTC8SvD++e4xOxvn5O4izhJpUt03moSDLUBYUWex9aicoQ0mrQ6rfsIuUGg/hNeuVHWK@vger.kernel.org
X-Gm-Message-State: AFuF++mBxNdyAqxn4j9KX4sZ3gz6nTlZktQs3bgboP6R2JJ5GTmf02w/
	xmcz5uNHcHp6FDNQ3X2sbGLoq0vdso77FgTeuzl61W+mGooIkJ/U4QeFy+1E6vAAeuwys0mietP
	hXT5ZlqKFR4ISqqE3aakO4QBeZyML9lA=
X-Gm-Gg: AR+sD137g3ErRLgNm3kV6vcaQuTHmpTocDF8mSEzVPZXxZXkx9Y5Fi/G1NyU+Ge5Qh3
	pacAyonsOp3kKT72UFKwVMBpL6yqWZIhxjGmaWS2GojjHlm4McdestSVIaAooWNuj+3f+sOjqUq
	1Qg5bnLso8BrT/ATyXxEpunhe4rjRNwvQth41WsqW7Fp5N5JdbEAYvIyuPHZTLLs0EO0ltNMXEy
	/zqC6Zk9/8rKiXVmipknLFM43uP8e00BZg+3gvHEGnSiLOfDp7nlWR7+AMdshaI61soOOAAySQ5
	t7qRnP8H/w3TftpmwTLV9k8mDg59sHqDW6vsKHk148Fi4w==
X-Received: by 2002:a05:690c:9989:b0:81e:c436:c530 with SMTP id
 00721157ae682-849f3dc401dmr83521097b3.14.1787502392507; Sun, 23 Aug 2026
 09:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
In-Reply-To: <aosT4H14zcowzU_7@redhat.com>
From: Keke Ming <ming.jvle@gmail.com>
Date: Mon, 24 Aug 2026 00:26:20 +0800
X-Gm-Features: AcwNN1VxhhHuJWSyjEp_qM83LgCzGJOv75Nr_zBbmcXDfn0tfuYCz0EE7A_cDJU
Message-ID: <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

> Note that uprobe_copy_process() warns but returns "void", too late
> to abort copy_process().

You are right that freeing the partial utask is not enough. The child
may still be unsafe to run after uprobe_copy_process() fails.

Would it make sense to keep the cleanup and additionally send
SIGKILL to the new child when the  uprobe state copy fails?

Also, should the existing "dup xol area" failure path be handled
the same way? At this point dup_utask() has already succeeded,
so the child has inherited the uprobe task state. However, we fail
to get the xol_area needed for the later setup, so the child's
uprobe state may still be incomplete.

Keke.

On Sun, Aug 23, 2026 at 11:38=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> (Add Andrii and Jiri)
>
> On 08/22, Keke Ming wrote:
> >
> > dup_utask() installs the new uprobe_task in t->utask before copying
> > return_instances. If dup_return_instance() fails, the partially copied
> > utask is left attached to the child task.
>
> Yes,
>
> > Free the partially copied utask before returning -ENOMEM.
>
> But why?
>
> Note that uprobe_copy_process() warns but returns "void", too late
> to abort copy_process().
>
> Perhaps we should change uprobe_copy_process() to kill the new child
> on failure, it will likely crash anyway.
>
> But I don't think this patch can make the things any better.
>
> Oleg.
>
> > Signed-off-by: Keke Ming <ming.jvle@gmail.com>
> > ---
> >  kernel/events/uprobes.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index b25531331902..0c8a664a0fe5 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, stru=
ct uprobe_task *o_utask)
> >       p =3D &n_utask->return_instances;
> >       for (o =3D o_utask->return_instances; o; o =3D o->next) {
> >               n =3D dup_return_instance(o);
> > -             if (!n)
> > +             if (!n) {
> > +                     uprobe_free_utask(t);
> >                       return -ENOMEM;
> > +             }
> >
> >               /* if uprobe is non-NULL, we'll have an extra refcount fo=
r uprobe */
> >               uprobe =3D hprobe_expire(&o->hprobe, true);
> > --
> > 2.43.0
> >
>
