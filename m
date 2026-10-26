Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055393;
	b=Gb+KCf81rBIc4z3S9+0gwUsVGBeMzXU2IZXrTuNq+obc59v1QTQrB8RENjPfcaD6TUEt
	 7M0W7G/maA8pDUeaZC0c7s6MJWV1Hw8mnH+425W7hC3cTGg/2VRXhO41QigIuyFNsnLN3
	 kB0BmfutN4+mQUwkyzQhJI09x8FBOGnmH4FJjom/zXQVcKCUZNPleJvTa26lfkBin6HBJ
	 TWdtd12mSyqZPNNSKLCuOQqWdI36Vvci7RWJIQ+HtfONmnq0qLNODlWT4mSqd7qzRBCpx
	 Th5QqnAGa3lGzdL8bQxAuG8CUsX8MHdIBBMCbdfcgZ1GBUOHpb/DjYubpL8ff1yMa3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
	b=mivb/4gnq+Q3g15ImAvo4SvbLSsTq4Edp8MNjqSAJDHr0lYQR9KdW0TolR2/qBDNoeK2
	 RhHAVyJ1+0HPLWDhA9WtPTw51mc780tsOkt3WW37sozDG/juL0ngI+u6M5wSr3ajX/qVu
	 HcK5xFAZ6eGGw6KciCOfTEcyKr6gp7Q5rf3yqYrAeSOoIr4TdN/CHyOh6kNGda75WYx6V
	 vyMblMAS9vn2gICQChHVDnq0lBN4cz7o5zAJRwfqVLk9NY1p35VTyg1EwPI2WPERooxMA
	 SVAsWJFigNFZzWvCFb3zfsmrfRkKs9HUvXY5H2/e6dqVBIxZGJBHYhwWvRQvWUqySYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC44606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AC44606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c418e215671so458894866b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 15:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055391; cv=none;
        d=google.com; s=arc-20260327;
        b=CCo0TCCdmjujiWzNvwR4WZUTspZAVxvkAFZHN3srxKsQUJNqtUZv3HWXnfEdyd2xRS
         IDVaFlRLDVTT/gjyBYOIIOEZwO+FdN2NFSmLeBFyD9eoknDyg7ErAo/Oe8s/rqzDnDDU
         fOS3v9cV3gJypvSGzsc6au/zusTVyxVA7MsTJr6v9mcC5BHBoPg97+kyhCFR4nat2eqG
         sOxxXVlcGEF5kN9VKtaf7ChIm5/fTlJHcd7fKE7qu7zaW1WbfDwlXwVfxykLVeJR9xIz
         4MVromCmoe7HvEjcbEppWPAywb6j1w3wMdLXtzxrcBc1FjUOySr5cauu3p8NT8z6Swbq
         tBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        fh=7lrkSNPsr+TkLNZcbk+C+dg/8/oufYEUtuxrcauUl9w=;
        b=TBp1KLMEHJpCJ/3B+VJnwAuHjpSe5w5h+LIZ9Xl9tHN6Aqno8x7laQE0oQ2T/T2eEP
         z81+N/dBpbFIbs5XYMn4imPMK/IKPPkkLy2wDr2BFYOzzCcrmRt7tVeCQIdXL+djcj/9
         IY6PXWIQlw6747y/Bh076F2rW1yUWKVzvWpPP6TVFYcBRb7X+qH6ktc0B2XdS5yMJChF
         rXhBRmCu4hgpsIPGdYMJ/IlzPWLhwqQBqxXXhxYGbu42aZNTEr7ddR0AdmKMJJV0FxH0
         SRn1WgF9dqwXiCcVtMNYLyio/z+ekh+/lLRtwyOfHk7NZO/x674oZA3D362hImIGy858
         AGhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793055391; x=1793660191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=s8grGiR3jmOk9ry50/nEnZjaxWjWOPyppi2m4MHQTMfb5el8k0obk5/UMSWfPsQmIM
         HPtLzsEa12OcSsVXiRmiCNw+UUDDo1UYyS6DiU9bwXoKmoGF82ns9DjJzrfs9pJWdjkT
         dIxIeAf/R+LNQl/XTj1bdocyLOLlTkNfh75pW2KuZcZpn6JGMaXwZms8i83nnm2msMhG
         qxuIapSALuC5I4z0EKwNizZvGG6PaVYwrsYFc03clQ+zaffY9Yi7+Rd9DeVq8TqQMsPo
         mOa9KjkQgAnBHYiQJzjduIMO8ab1In9zxpTDESz20wql691IHa3z4eYMgIiR+VfFmdpS
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055391; x=1793660191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=Yv6TswwB6TxCcrMOPXd3Va1NOv/zuqPtvjZCP760mWL8395cbfMlduEai6B1/tGsFZ
         zlyS82nWYviURlZxSkuR7qG2CWByIAsjrIcVLXhoBApNCi7h+6hBUjl6CQjRiZj3I/ek
         VYpSeF8YxTVyyAzmZspQ8pVLKEZC0cQkKUlQlE92Q5UejC2FGIk1gWh3dREzZBZ2DHjn
         q+47pzsc3aNj9f9/MhwutWTMIwTj2ic1+WdRku4/yKkvqOU9iDM/lK3MyGFpSIUvhcGq
         RQ2CrE+ZTn89qTNa26XnKacjlWgktLgqfAQiaBvnXcChOG8vHLMcEDGgHhq5CyQQZ4PV
         vhCQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1tIcxK80iR2e7wWd2GR5D8Ad5lsLcPaPXy7ytMNxI1AJtb8lUq1MpWEVgA1ODqIhivMaFjI8k5ws3x9jovFCA@vger.kernel.org
X-Gm-Message-State: AFq9FYIy2lR1G0ld9qx6NYpgwSsdJAO0v9nGRIdPP1iNZ5UV/f3Vp336
	On3tKMdYjPtYfjuqgjdlTGBu0MquCW4vzmOjL24REKaf9L/Ih+Ty4S5y75fOe91HH3bLNfY1Re7
	NZMwxcxbHSmGdjDh2gJ6Bcq+uHCxfpVRAnrxa00DM
X-Gm-Gg: AYBFou3RQTcSQQk4ne6ND+wpfoVKrTwdDyQpSvaD04C+sVu3leP9q0N1GlcUQsFbNGB
	apzmMMIoL1ZZVceVujTJKJ9+xjIqVQjhqkHIzs7DrBIh8nAiZv8h8vhBh9CbEDVBpa3EoFcOV7y
	01CKuXbLw/ylko0RjUD+E+avYC6Cq3bq7zo8fezr3TLQQtfe/NNunS+Flgrblg8yytz4t1/ZNQH
	nTrO69Sg4ydhAbrdyMH4wUlN/2W7y5cg7PooKPv+did4RyvAVpf6advBV/yl+5i7TI84KQV9+e6
	2z4R4QE90+e3lcckhbc/08FsdHmm76BqrJSqDHhApgPnBoC7+aXU8Z8Y7Ls9eX/owNuApuJQeEx
	pjm8mmXso6rFciX1uZp2yRCFjQCuZXxrtAnm1zZHinwA3ZZgG6N3zxh9sTkOfV4XfNL8Tv1kZzB
	LQ3Wl0HUEPEWbb5hWrGfHFNsgvcoK2nXrDMfDhzYkVjtHSgIoKtU/ExfIjzBht7Hiwl6AEpjdjF
	tEKzvxE
X-Received: by 2002:a17:906:9c8a:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c46bde874d7mr911731866b.38.1793055390933; Mon, 26 Oct 2026
 15:56:30 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-5-jthoughton@google.com> <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
In-Reply-To: <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:55:53 -0700
X-Gm-Features: AclHuK_4pEIR4EnpfJkK690R4CHqdS4wt-7zneGKcf5MW03i114xuH5q5kcZiJk
Message-ID: <CADrL8HXeYRC8w7F7e_6ZXK6MHd6FRepN_zD632j0JPjNUDrLZw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack without
 an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > stacktrace: Don't unwind the user stack without an mm
>
> TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
> 7e8e6816c649, which dropped the !current->mm check, looks like the real
> culprit rather than 214d8ca6ee85.
>
> > stacktrace: Don't unwind the user stack without an mm
> >
> > stack_trace_save_user() only refuses to unwind the user stack of tasks
> > with PF_KTHREAD set. That doesn't cover all tasks without an mm:
> >  - A user task that has already gone through exit_mm(), e.g. when an
> >    event fires from exit_files(), exit_task_work() or the final context
> >    switch in do_exit().
> >  - PID 1 before it execs init, and usermode helper children before they
> >    exec, which are created with user_mode_thread() and don't have
> >    PF_KTHREAD set. E.g. booting with trace_options=3Duserstacktrace and
> >    an event enabled with trace_event=3D unwinds PID 1's "user stack"
> >    during initcalls.
> > With the ftrace userstacktrace option enabled, the architecture
> > unwinders then read the user stack without an mm. That access does not
> > reliably fail: the user half of the address space belongs to whatever
> > mm happens to be lazily loaded, if any, so the unwinder may read
> > another task's memory.
> > Use is_user_task() instead, which also checks current->mm, as perf
> > already does for the same reason since commit 76ed27608f7d ("perf:
> > sched: Fix perf crash with new is_user_task() helper"). This also stops
> > unwinding the user stack of PF_USER_WORKER threads, which never run in
> > user space, matching perf.
> > Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Is the Fixes: tag pointing at the right commit?
>
> When 214d8ca6ee85 added the ARCH_STACKWALK version of
> stack_trace_save_user(), it guarded the unwind with:
>
>         /* Trace user stack if not a kernel thread */
>         if (!current->mm)
>                 return 0;
>
> That check already covers both cases described above (a task past exit_mm=
(),
> and PID 1 or usermode helpers before exec, which have mm =3D=3D NULL).
>
> The check was replaced by commit 7e8e6816c649 ("stacktrace: Use PF_KTHREA=
D to
> check for kernel threads"), which switched it to:
>
>         if (current->flags & PF_KTHREAD)
>                 return 0;
>
> That dropped the no-mm protection, which looks like what this patch resto=
res
> via is_user_task().
>
> Should this be:
>
>   Fixes: 7e8e6816c649 ("stacktrace: Use PF_KTHREAD to check for kernel th=
reads")

Thank you, yes that appears to be correct. Updated in v2.
