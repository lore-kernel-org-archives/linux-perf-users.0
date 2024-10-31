Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB917B418;
	Thu, 31 Oct 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409791; cv=none; b=kUf+7VGacH7cUtpxGa01b+w6/en3rPcRTHcZnFawzG1b11MZSMdVL0R4mpL85N8ua6y0giWaNVUfSHB4YQR1f5gR7dD4AT5Y2uiiHRO1wUgkEUGqWgdAPtyeTo54+lbIE4U/nfQjbBGx5FjjVjfSJwqBFvDYy8WD00h8NKIVpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409791; c=relaxed/simple;
	bh=lDLRQ2RKm4s+kztC/GnZKMATAd+Dg3OJRtpOpmRHRgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWuO3Cs0pLlwABJq61aj9Taod+6Krquo+jEbnqZbYxfCrbTZl4tabkebYA+JqAoggrXAg0GSTonU3AVIeNboGUs0FgT58atsdEupR9OQ5TEI6mGXWNFncOFw9JIaUriXeMvHRXjRdbSb5BjRMHQnERLyD9VtPnGhOA4BjHA7jxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxgXt3s9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxgXt3s9"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so146117866b.1;
        Thu, 31 Oct 2024 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730409784; x=1731014584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+9Qw9e1QR2LXEJ6JMRkgMjT/9zHfqyYgH28V/YADV0=;
        b=GxgXt3s9p1wqcTVNNsHbfpct8767w+oRWoKwstNrBhWJOlGaqSbFs9SIWjXXHifUak
         qb+7ZwU/R5UuQhMnOWMhBamcBORB2npGULhZ1+fhBOlfXVv2gtE3xM6M2pg3ugO3o/3s
         c0GVLLjNieqQZ7yHHuu8yyUilgW/mXH/1kZhfCNmZgiFIphyrUYlju6n/UMFOyj8Y6fK
         FQO2I/HxflBtgXMK54xIRKz62cN4AvR/m/aJ35FKCFZT9VC28UsMsMFHvVvnsgnXy91C
         8GOQUT68NjrltZTCz35EbDz+CD0vTaE6frGNvZii5Mr5P6/2zU1tWWN9RqjO41AFoW5n
         5m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409784; x=1731014584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+9Qw9e1QR2LXEJ6JMRkgMjT/9zHfqyYgH28V/YADV0=;
        b=VitAPIQ2CEzh6EjO7s++wel96ILcEHuWCADTLC2U8hcSuynuoJ8BDlTXlVPisiXhEr
         yBV4bRDEpl9zRx8eMqeM/EOCOq++uWHuxBSn6ZWTd7O9+xka+MzWqt5COysU2JmuXP1o
         TKr+NGskWcLosCwaoLrOHJBSyBlU040Hf4RGIy1/dGu2Ma+acaZOWPiTAhleqFGETynm
         hlsf7NN8vdcr6KBMOJnvN+bEIzfjaAL+EH1MYQeI9aXQkMz29crZYI90ncVxD6QavXVt
         FW9dnvKveg58a/OuQywHwV+9+mScm7m2oUrZ1W1gZvz/1LWb3o87Q7FSCIF6NAZzU5kn
         3ivg==
X-Forwarded-Encrypted: i=1; AJvYcCUXNy7qBOY2+EqLRs/WddI/twsxUqLYXncOz/AW80J6sNxTya0jrmujIzWekIbTPFXYMWHB40CNIr3jXbeQ21+9OQ==@vger.kernel.org, AJvYcCVUHBrlhniqcUHEyjZolkexz1gutYfnMB3CRuHSfbbl1eFFGOUMw6NbwY2Dfb4DhCkA7TtMb9UFuvc0Mxy+cqj+jw==@vger.kernel.org, AJvYcCWEHwaDdaZXssfr4naAwcXsV21SUoEyHM+5Srkp1wVwuHhnoIV3LHuxOpI00o1uxJYFH9WyjFwhCkyrAAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4t2/kJf9BYRr0CpH1HH2cUvMN8sy45D01MdE94wgZewA8Ngw
	tDnWb4IO6MaciRI9JEU8ShS7dzP1U9JHcY7SrIFrjQINN1UGt1J3fiuC2JDgVChEJ0VhWKl87Vs
	Nkxop+to+/bIqRqcvioSloroW5lY=
X-Google-Smtp-Source: AGHT+IHZF4RwQ8heZR6jMz2nJ3IMxQNUgkIyDFAJbk8D8K+vEgB//66W+9SZV3kGCvsUZ1VSuw/6sIicwJLTe/k8icE=
X-Received: by 2002:a17:907:7208:b0:a9a:15fb:727a with SMTP id
 a640c23a62f3a-a9e508ac2dcmr446319966b.13.1730409783652; Thu, 31 Oct 2024
 14:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com> <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net>
In-Reply-To: <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 31 Oct 2024 14:22:48 -0700
Message-ID: <CAEf4BzYd5OT9COBS4va435jqMzkjvvAHbe55AR6giv8pitUvAg@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 11:10=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Oct 29, 2024 at 04:32:46PM -0700, Andrii Nakryiko wrote:
> > >  struct audit_context;
> > > @@ -1592,6 +1593,10 @@ struct task_struct {
> > >         struct user_event_mm            *user_event_mm;
> > >  #endif
> > >
> > > +#ifdef CONFIG_UNWIND_USER
> > > +       struct unwind_task_info         unwind_task_info;
> >
> > this is quite a lot of memory to pay on each task, a lot of which a)
> > might not have sframe
>
> Frame pointers are also supported.
>
> > and b) might not need stack unwinding during their lifetime.
>
> Right, I'm not super happy about that.
>
> > It can be a pointer and allocated in copy_process(), no?
> > Though ideally this should be initialized lazily, if possible.
>
> Problem is, the unwinder doesn't know in advance which tasks will be
> unwound.
>
> Its first clue is unwind_user_register(), would it make sense for the
> caller to clarify whether all tasks need to be unwound or only a
> specific subset?
>
> Its second clue is unwind_user_deferred(), which is called for the task
> itself.  But by then it's too late because it needs to access the
> per-task data from (potentially) irq context so it can't do a lazy
> allocation.
>
> I'm definitely open to ideas...

The laziest thing would be to perform GFP_ATOMIC allocation, and if
that fails, oops, too bad, no stack trace for you (but, generally
speaking, no big deal). Advantages are clear, though, right? Single
pointer in task_struct, which most of the time will be NULL, so no
unnecessary overheads.

>
> > > +       if (!info->entries) {
> > > +               info->entries =3D kmalloc(UNWIND_MAX_ENTRIES * sizeof=
(long),
> > > +                                       GFP_KERNEL);
> > > +               if (!info->entries)
> > > +                       return;
> >
> > uhm... can we notify callbacks that stack capture failed? otherwise
> > we'd need some extra timeouts and other complications if we are
> > *waiting* for this callback to be called
>
> Hm, do you actually plan to wait for the callback?
>
> I assume this is BPF, can you give some high-level detail about how it
> will use these interfaces?

So I have a presentation about integrating async stack trace capture
into BPF at last LSF/MM/BPF, LWN.net has an article ([0]), which you
might want to skim through, not sure if that will be helpful.

But very briefly, the way I see it, we'll have a workflow similar to
the following:

1. BPF program will call some new API to request stack trace capture:
bpf_get_stack_async(...)
  - it will pass a reference to BPF ringbuf into which captured stack
trace should go
  - this API will return unique ID (similar to your cookie, but I'll
need a unique cookie for each call to bpf_get_stack_async() call, even
if all of them capture the same stack trace; so what Mathie is
proposing with coalescing all requests and triggering one callback
isn't very convenient in this case, but we can probably work around
that in BPF-specific way)
2. bpf_get_stack_async() calls unwind_user_deferred() and it expects
one of two outcomes:
  - either successful capture, at which point we'll submit data into
BPF ringbuf with that unique ID for user to correlate whatever data
was captured synchronously and stack trace that arrived later
  - OR we failed to get a stack trace, and we'll still put a small
piece of information for user to know that stack trace is never
coming.

It's the last point that's important to make usability so much
simpler, avoiding unnecessary custom timeouts and stuff like that.
Regardless whether stack trace capture is success or not, user is
guaranteed to get a "notification" about the outcome.

Hope this helps.

But basically, if I I called unwind_user_deferred(), I expect to get
some callback, guaranteed, with the result or failure. The only thing
that's not guaranteed (and which makes timeouts bad) is *when* this
will happen. Because stack trace capture can be arbitrarily delayed
and stuff. That's fine, but that also shows why timeout is tricky and
necessarily fragile.


  [0] https://lwn.net/Articles/978736/

>
> --
> Josh
