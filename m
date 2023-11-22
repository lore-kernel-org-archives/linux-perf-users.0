Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HouF/DEy"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65D98
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 13:05:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50aa698b384so947e87.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 13:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700687099; x=1701291899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2jqk8ZZKdRDbc3BQVJ9lVOH5K8+1AoAZfLB2fRwvko=;
        b=HouF/DEy7jzeZRQlA+HUdpPSnYx+13pFNlRMs+PYhpj+m7I5JMtwIppO9HEbaAmrbI
         o7ssFB2MlTDKTf2z4WjjCOlir3Mdlq4y6XjQK11sHPndKN1FBjzgHeNvXFDpformQ5G1
         j8qo6f8jpfhNPQwKBXrx4gXcNRPErMwjFQFIQUqqfQlQq+9i92QG3wn6Mb/Sgxyufo1E
         PaqwZTo95OoRZTeIuWwhTKl4NK4eLWzXIBOqRmirMUMx0w7HhFaRAag+g2NFwxAlUnnR
         AFghiTLu4Uih0GI8a+mn+pFSHYwZpDxa8goxzVr6u+qcjiRxNQL7D2KST8M1vPzUDSOm
         DXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687099; x=1701291899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2jqk8ZZKdRDbc3BQVJ9lVOH5K8+1AoAZfLB2fRwvko=;
        b=A+zde/P+uw7i40LmmlWBJHMYnMVAM9/I66Dq5iDRAXlzgFgDnNn5VlcZ3hlOEdMnt1
         lofhA8Xge4LNpgU6Nxy13qXUUUA/YlmX0mAQ19PcDyWuA8oG9qdL/45XTV2qtZduJwIA
         Xz/lA3GmMUkboIJBiqBDeB+y8rBWyNVAeO8317u/6MvBt6b55ikpIWivD/CzBSGC9tX7
         qhFVlLPR918QpgI/+TRtXZbhlHbl2MHc6dQwCj61a6Y/lgMTd8j1EJJTldJrX3EqUOde
         gajB92jBM2e/0xer8W/yiRiMNQ2dEylk0WCtZMAH6IKi+TfUhuU/U96z2PIlbQZVhgBH
         6THQ==
X-Gm-Message-State: AOJu0YzPafMfDDei9D6hLQvtzOf0CV7mX+u8aIfS213UBDWW6LsjObRH
	x8hQ5e+1gUWRRnc9cQWiuJ/UC7XJMbe9+Z2D15I4/BunG7dA1td8IPr6doHd
X-Google-Smtp-Source: AGHT+IH0dHoJOO5uWqTax2k4iislxo0vcCnNZxju1uY1Pt2U4rHXy/nGXxByUyqo1VkjsKzIY7Be4oQiLAfF3pnXjDw=
X-Received: by 2002:a19:7003:0:b0:509:48d1:698b with SMTP id
 h3-20020a197003000000b0050948d1698bmr157693lfc.4.1700687099140; Wed, 22 Nov
 2023 13:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
In-Reply-To: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Nov 2023 13:04:47 -0800
Message-ID: <CAP-5=fXjNrE9ts5mdL0UxC=dp=Qd0d3pJsRi=VsgozM6BCWa3A@mail.gmail.com>
Subject: Re: Perf support in CPython
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 3:50=E2=80=AFPM Pablo Galindo Salgado
<pablogsal@gmail.com> wrote:
>
> Hi,
>
> I am Pablo Galindo Salgado from the CPython core development team. In
> the past release of CPython (Python 3.12) I have added support
> for including Python function calls in the output of perf by
> leveraging the jit-interface support by writing to /tmp/perf-%d.map.
> The support
> works by compiling assembly trampolines at runtime that just call the
> Python bytecode evaluation loop and assigning function names to the
> trampolines by writing in /tmp/perf-%d.map. This has worked really
> well when CPython is compiled with frame pointers but unfortunately
> CPython also suffers from 5% to 10% slow down when frame pointers are
> used. Unfortunately, perf cannot unwind through the jitted trampolines
> without frame pointers currently.

There was an analysis of the CPython frame pointer regression here:
https://pagure.io/fesco/issue/2817#comment-826636
but with GCC some of it was stemming from sloppy code generation, not
using a shorter [ESP + ..] address rather than always [EBP + ..].

I was ranting at LPC last week about people not wanting frame pointers
so I'll try to write a blog, but some pertinent points:

- we're only talking x86 here and we should try to avoid overfitting
to one particular architecture.

- x86 with APX extensions (ETA 2025) is getting 16 new registers.

- frame pointers don't need to cost a register: you can put the frame
pointer in thread-local storage and then "push (fs|gs):[offset]"
replaces the "push rbp", you place the new frame pointer in the TLS
and at exit you reverse the push. To make the stack unwinder support
this we just need a thread-local storage convention which (imo) is way
less painful than say supporting page faults, to map in debug
information, during stack unwinding.

- when function call overhead is significant it is evidence that your
inlining is broken. With FDO, AutoFDO, LTO, etc. there are many tools
to tackle this. A constant problem is that the x86-64 ABI lacks
callee-save registers meaning that if you do use the registers at your
disposal you can end up with a function call looking like a context
switch in terms of spilling out and then needing to refill registers.
Setting up FDO and LTO is necessary to eliminate not just function
call overhead from establishing a frame but also the more significant
costs due to a lack of callee-save registers. APX is adding fast
push/pop instructions to try to alleviate this, but we're overdue for
a new x86-64 ABI.

Making jitdump better is good, but I'm not motivated by frame pointers
being a problem. Fixing jitdump won't fix BPF, etc.

Thanks,
Ian
