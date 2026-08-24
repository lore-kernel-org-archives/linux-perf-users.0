Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6131A6808
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570551; cv=pass; b=ee1XTHnR2tHMd3/tOEYoUF3fpUH3Q/ia5t5qrZOe3CiyVuVEZHRvUbhOPNozdt5CblTxin/YqustTBKctNI0uCwhLX3davObfLfKrZ4krYXYLiSXLspvWj4fLiGLoZplsUx4PLhb7WUpzb09tO+S6VdQzQAdnIM0jSqWLF1gfLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570551; c=relaxed/simple;
	bh=/0my3t+lF/CL2tBi99WPrBzsGUD/BsCNVNf5PeYgNTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt2WOMiscE9EegeEilkgtJezwmnqPAl0H47Fll1tWUGHga+rPP5+lh+qHWm5uxkZqdPQOaT55H7vQ3fFMyKvWEXEtYWoj9EQIuzaIVIYpeffndSzy1Nh69cC2rN0OKclzoBXr1xOCsb0hlHSeQn1DSEb1GSb2S9g2wc6dlsa2R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLz4Rr4y; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLz4Rr4y"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836cbcd0a48so42443097b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 04:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787570549; cv=none;
        d=google.com; s=arc-20260327;
        b=nXZguCD6kcAw+/1uCDOE4ac1F1D1VbXV/jn/NFPbRA4WljcEa/5sMStz0pf8qqTP3E
         fKdqsgmxhcND+cQTHocZ4YOH3VUy5H1P9Ls/zWzMRGxOUS5zFIWa9C+gC3Lr1UNLW9aX
         H56/WTlNcfUen84pQ9avQZnYb8aw1SGWCfqQVarRNVxt4olGc6LPeDrqH4Vqkeoc2wAw
         Rs92ELzAQLamZsijrhq7N7IIU+8kbUdU80veRdeXNszcZmlOVwOPlD50DafaMuatLS2S
         P+H/poiO9N7mtfLQi22sRR26roeIDz4422Vq0CY+4rYSjTW07B4ZC3BjR25KhkmNkZ39
         bH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7Hu8aS2tMxi0HUTc73kwEzJzh8H0U/IURM0mZn2fi4=;
        fh=j6f0qW2dUhyR5MP1hdrj0rDfZboGVt1eES1F2u1J3NE=;
        b=MZH/8ibJDk7oMhNFccD4zND2YvO/qG7WePF7wGk292ZdDriyZDYLzyHRmVF9NmNFv9
         ppr9uzPPMlOPXy0yH58vRC9yGVUnfGrC72iMCj/MvQmanYRxZZw8k5V+Y8olzW7Bt2Iu
         Hhps8I4e2GsWg0zy7iaDt4jrPaCuJaxcSVDP4ScTb/HtxmjcWLK5Xf9k6EP9QCaOcvs9
         JWvTFyMcvUA47Ao55Ni8KA6IFJV4AhAR7EwbYZe0DBGXORy2e0FeJnaSVvU61pGh9fl5
         +r9JayR89fj4sAjYsQ0oUi3s6ijpEAg248GcQEfFWgtWWHQQUrP8hcXrXii0lUR4Qyzp
         JuRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570549; x=1788175349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7Hu8aS2tMxi0HUTc73kwEzJzh8H0U/IURM0mZn2fi4=;
        b=LLz4Rr4ylmw/d3dg0PhTA61l2aP/C5xNLIlCTjk6Ky23FerKnk/4bTUnqe9RrApKha
         uBg6y07mFcJu190HnVGZ+9U6obHsawSgxu6Ql6Cf75RU/swkpow6U4k6oVt/W0b4NJRB
         zaEt75vLV0m8Vwzu82HLkcLkoxsyWKwCDTl6DLhzRZ8W5lfwX6VkTxwF+qtujXJ1jX9R
         nRFFGN6PjMppL8aR+g/Fh2fPiDUslbHIjodCsPXlMmzNhRn0Qwoj1cAqfphF2U4HuikG
         zULG+zhlIVSBeZFM9F52mQHtVtFpmuoNncMqJ+ajg6og3w2ferP5NGIHlozdL5pXx40w
         nVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570549; x=1788175349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7Hu8aS2tMxi0HUTc73kwEzJzh8H0U/IURM0mZn2fi4=;
        b=A/MKtVSvGz834Q+9Ii8MOFoS5RYL1pKyaEW+DZ+j7v4Z6ESi8qufWQEZpDV2d5yKmm
         2V8JPCcTtuu9jfp9dhPt+RtMKwkuEnli/5cjVsxptwScbZeW7vPOT/iHGJh6AD48OsLi
         tsG6SYVIxhBi4PjuLmnSuCyvSMT523SnffVv74SM1j47J9e7iaRhxyHeV0eEAq5Xeo1J
         BPUKvBzTNfAunqtyOpoEQ7Tjo9Ls1hq4JwyKLF/69p8jjWOrq9khMinpdb1s/+A2M2Wk
         1hRyiRBuLWJxRCZ1o7Jz+xR+etmXx3PSgxEtG97OjqeGcuuNLy77+quIpCRWqs0KT5u5
         ZXYA==
X-Forwarded-Encrypted: i=1; AHgh+RqY/Nqz2NXjEHzArb3+cFtezdBtTTMbJuPyTHjWVNG7dBP8E4+vo454jHUOw+cp5+C0hASPr2fO+UTlze3uhavS@vger.kernel.org
X-Gm-Message-State: AFuF++kKsCNSYrZzcc2Zd6NGDMs30+KRd1HwffxywMZVbtBJNmogXa0O
	O4iaAZHfHDM5+8KsOly8uugi5tcE0UQXNoTIQssKPo0ywiFtRfY5huxglF4Gp24dGs1kQg+dFfP
	fWlCIc506US0wopMo7/KWk5d8f0wDnYA=
X-Gm-Gg: AR+sD11D56TBJgzvCy6MZQHACO6XKt9pQ/KHFi7wQ9hN9LJDR765BwBWv5Jt3OKFSqW
	0Jwm/N2K4uY3YmWkjc+FlyMV0d6gN0FuDi82F1wTHHaGU+J1xfs0iSjRRnUVaDu+TCSi6yacOl/
	ggy6I5epHKWYYRa2TqZtFfIYbr5Z4L20rJaqvrBC93+2Cv7Cg9qNRXV22ZemkJIHYGC3FxLngsE
	Fb2hNBfjVwegNrG7jVgCtLmN6bru/7qZKkgMLqgKWEPVhHmj7OvKoMOdG5VHjVuIiYvRPryzOcI
	FQDnZqv8YczQ7hWGXlnswXs6ijRpMu9vkGCL/c2m58s/zcM=
X-Received: by 2002:a05:690c:c423:b0:80c:76fd:f732 with SMTP id
 00721157ae682-849f6a957a9mr78206597b3.26.1787570549300; Mon, 24 Aug 2026
 04:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com> <aotM6tRUHI9Bo7gW@redhat.com>
In-Reply-To: <aotM6tRUHI9Bo7gW@redhat.com>
From: Keke Ming <ming.jvle@gmail.com>
Date: Mon, 24 Aug 2026 19:22:17 +0800
X-Gm-Features: AcwNN1X5o6OEgGW73-QMaSvUJll9Em5qhnHqT0sH4wBhQMCp_avkxk205HuEKP0
Message-ID: <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 08/24, Oleg Nesterov wrote:

> Hmm. It is not that I think "it is not enough", I think this is pointless
> whatever we do.

Well, I didn't mean to insist on the cleanup, I also think it may
be redundant. If the child is bound to exit, manually calling
uprobe_free_utask(t) in dup_utask() is pointless, as the normal
exit path will handle it.

> Yes, this is what I meant. But this is only the first step to cleanup
> this logic. I'll try to write another email tomorrow.

Of course, I'm all ears.

Here is my current understanding. One thing I am not sure about
is the signal semantics. If the copied uprobe state is incomplete,
the child should not return to user mode with that state.

Option A:

```
if (dup_utask(t, utask)) {
  uprobe_warn(t, "dup ret instances");
  goto kill_child;
}
...
if (!area) {
  // whether we also need to kill it is open to further discussion.
  uprobe_warn(t, "dup xol area");
  goto kill_child;
}
...
kill_child:
  // I was thinking about SIGKILL here because it cannot be ignored
  // Of course, you can correct me
  send_sig(SIGKILL, t, 1);
```

Option B:

> Note that uprobe_copy_process() warns but returns "void", too late
> to abort copy_process().

Looking at copy_process(), uprobe_copy_process() is currently called
after the "No more failure paths" point and after the child has already
been made visible through the task list and pid links.

Would the longer term fix be to move the uprobe state copy earlier,
before the "No more failure paths" point, and then add the needed
bad_fork cleanup for  p->utask?

Keke.

On Mon, Aug 24, 2026 at 3:41=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/24, Keke Ming wrote:
> >
> > > Note that uprobe_copy_process() warns but returns "void", too late
> > > to abort copy_process().
> >
> > You are right that freeing the partial utask is not enough.
>
> Hmm. It is not that I think "it is not enough", I think this is pointless
> whatever we do. Please see below.
>
> But you know what? I am afraid I am totally confused again, this happens
> more and more often. So please correct me.
>
> > Would it make sense to keep the cleanup
>
> But again, why do you think it makes any sense to keep the cleanup
> you propose?
>
> > and additionally send
> > SIGKILL to the new child when the  uprobe state copy fails?
>
> Or SIGILL like the rest of uprobes.c does...
>
> Yes, this is what I meant. But this is only the first step to cleanup
> this logic. I'll try to write another email tomorrow.
>
> Lets suppose we change uprobe_copy_process() to kill the child. Then
> why do we need to call uprobe_free_utask() in dup_utask() or do anything
> else in copy_process() paths?
>
> The child won't return to userspace, it will exit and call uprobe_free_ut=
ask()
> itself.
>
> > Also, should the existing "dup xol area" failure path be handled
> > the same way?
>
> Yes sure. But perhaps needs another discussion.
>
> Oleg.
>
