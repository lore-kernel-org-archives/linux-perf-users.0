Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVFewOoY"
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A87A3
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 22:39:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-285699ebabcso559016a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701326356; x=1701931156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZOG6QhYSjAo2zw8BnDMBufdX2aNPPAp6VVfW0kMVz0=;
        b=ZVFewOoYK/kZVIVQUa88AsvQZQwk87ECqLefV/zcpKP83iEBLxJMNSbU+oqTzQkqIz
         IVHMpuDrY/rz4ONyLDDfKR6dITwRCw6UDi8t+siJ9Tnacl2pCS+7NmS/sN7J256xiuUp
         UMF7gRIZ/2yJ6K1J0MrRKg47n7iaRKuNd7tw1r0IQWVmnO8IsDAmThFaixPZwnZ10mKT
         94iORHvHR9XqDbdK1k0upneJerD1TdKdhbDdj7z9F7IpHN+azEBc3oU656TKxUcDSnJn
         3ujQz913hGpszeqvFzkcL7oGfONdqBQ+lgtj6N6F6D066/pI0sVkHrQLOL5Z1HS5cKgw
         obfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701326356; x=1701931156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZOG6QhYSjAo2zw8BnDMBufdX2aNPPAp6VVfW0kMVz0=;
        b=uVoYkr51uRE3I5XX6dAVmqtX9K5i9y6CAXxR2+AHxlOa2XV4QfpjzMKOg5UZ7yq1Le
         loR94SzbNnFipwFrpSzMZsBNAfasPWvAbdO2IFjY92sH+WDi/l1TPjdcigI5K6EsE8FG
         wQuONLt+/I1XNGgnCqZFyE9ansG8uGfuosSHpgJC7mxuSG9CchSRHP5zKVhrbAVhX1h7
         WPhYBLThYftC8uz6q0y1mrusvHvi17YZoXU0FXq1pVcTVIHxkF8Km0g7XbyfPjxsU2+0
         WOJSnrkbYb/Js7djc9yi22PYXd5MeLRsSUwCr7UCXJNYbDfUa293V71QJPQTRArKFd5c
         6szQ==
X-Gm-Message-State: AOJu0Yx3Y1Rik4opOMDRPBjWJajR/2hH5YomA6d1DmK8O8pETvnf+10X
	idpOHTUxFsNiRnzRXdiH7hTHEAfTgE6HOYjmjqw=
X-Google-Smtp-Source: AGHT+IG7LygpYdzW7wyZGhiKvkgaUtkXk/qLuxK7DZi3J9qfZAM7ApmGHsz+wWBCnJojqxR0pETyyitNqMVBZhYj8e0=
X-Received: by 2002:a17:90a:e38c:b0:280:72b:397d with SMTP id
 b12-20020a17090ae38c00b00280072b397dmr33667878pjz.20.1701326356331; Wed, 29
 Nov 2023 22:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <CAP-5=fXjNrE9ts5mdL0UxC=dp=Qd0d3pJsRi=VsgozM6BCWa3A@mail.gmail.com>
In-Reply-To: <CAP-5=fXjNrE9ts5mdL0UxC=dp=Qd0d3pJsRi=VsgozM6BCWa3A@mail.gmail.com>
From: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 29 Nov 2023 22:39:05 -0800
Message-ID: <CAM9d7cjQaNS1QCdE6yGtUFJEVA9UNJA=5rNwp6TJPZ_1geW_1A@mail.gmail.com>
Subject: Re: Perf support in CPython
To: Ian Rogers <irogers@google.com>
Cc: Pablo Galindo Salgado <pablogsal@gmail.com>, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 1:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Nov 20, 2023 at 3:50=E2=80=AFPM Pablo Galindo Salgado
> <pablogsal@gmail.com> wrote:
> >
> > Hi,
> >
> > I am Pablo Galindo Salgado from the CPython core development team. In
> > the past release of CPython (Python 3.12) I have added support
> > for including Python function calls in the output of perf by
> > leveraging the jit-interface support by writing to /tmp/perf-%d.map.
> > The support
> > works by compiling assembly trampolines at runtime that just call the
> > Python bytecode evaluation loop and assigning function names to the
> > trampolines by writing in /tmp/perf-%d.map. This has worked really
> > well when CPython is compiled with frame pointers but unfortunately
> > CPython also suffers from 5% to 10% slow down when frame pointers are
> > used. Unfortunately, perf cannot unwind through the jitted trampolines
> > without frame pointers currently.
>
> There was an analysis of the CPython frame pointer regression here:
> https://pagure.io/fesco/issue/2817#comment-826636
> but with GCC some of it was stemming from sloppy code generation, not
> using a shorter [ESP + ..] address rather than always [EBP + ..].

So I went through the thread and felt like compilers could be
improved with frame pointers.  But changing compilers would
take long time so I think we need a workaround in the meantime.

>
> I was ranting at LPC last week about people not wanting frame pointers
> so I'll try to write a blog, but some pertinent points:
>
> - we're only talking x86 here and we should try to avoid overfitting
> to one particular architecture.
>
> - x86 with APX extensions (ETA 2025) is getting 16 new registers.
>
> - frame pointers don't need to cost a register: you can put the frame
> pointer in thread-local storage and then "push (fs|gs):[offset]"
> replaces the "push rbp", you place the new frame pointer in the TLS
> and at exit you reverse the push. To make the stack unwinder support
> this we just need a thread-local storage convention which (imo) is way
> less painful than say supporting page faults, to map in debug
> information, during stack unwinding.
>
> - when function call overhead is significant it is evidence that your
> inlining is broken. With FDO, AutoFDO, LTO, etc. there are many tools
> to tackle this. A constant problem is that the x86-64 ABI lacks
> callee-save registers meaning that if you do use the registers at your
> disposal you can end up with a function call looking like a context
> switch in terms of spilling out and then needing to refill registers.
> Setting up FDO and LTO is necessary to eliminate not just function
> call overhead from establishing a frame but also the more significant
> costs due to a lack of callee-save registers. APX is adding fast
> push/pop instructions to try to alleviate this, but we're overdue for
> a new x86-64 ABI.
>
> Making jitdump better is good, but I'm not motivated by frame pointers
> being a problem. Fixing jitdump won't fix BPF, etc.

I'd be happy if new hardwares or compilers would bring the frame
pointers back.  But I'm also open to find some alternatives like
shadow stack, SFrame or jitdump before that.

Thanks,
Namhyung
