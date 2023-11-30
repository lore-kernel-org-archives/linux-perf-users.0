Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5c7IBhi"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9519B2
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:17:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so634a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701379031; x=1701983831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3MbgsZEUk5R5s0EKqpV4dwdlm+mRMfy5peLAtznfUs=;
        b=I5c7IBhitMBRTpbHGh8ooN1LlWaLm8Z8/q7p8zxreyEi/enOvJhGmgc/PSV9XnTT0K
         HPbSifIxAAltv63eZRejjRXVBaBNnep3PoNJ9fl43Rofj0JMtqH3d/trxczUZfENgy7T
         nGAN0VkD9xWCW4j1/0qrPbDcME8gWvlBVBY6Wn+8aBr46T6AiOWlOhH0HHPSNKO4Ky2X
         8jfCvrMtrePUdkIZwqEQ1WvTgdLPC2yyAI3CyXsJS0ARtil+CdEnMP2YXT6gdo7p/5Rh
         eVwoPiI4ULWc0QyUy/OuEk3AQ8Q3pLyjMdzkzs2GnJ5gOlksrYA0rJzxztg8nwOEiXnJ
         KkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379031; x=1701983831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3MbgsZEUk5R5s0EKqpV4dwdlm+mRMfy5peLAtznfUs=;
        b=bgsXoQd8DWAWW4bkqy8n5kgl6GUQ3Nfw+GJz7dzW74CAyLc9SGcGOmj8P1u0wlIjE7
         oWjJxJRAiywwRTIVg6P/DNyLOHUncLiLyJpf/rYKZMgK+zYfen9YD+9BWADy0thvwTyA
         FK8nW9N0EHHUKOxLUyGFX7Ka0Dv7bukIPlWrz/Zuoa1MhQ7FY5HcKf3VuIFR8SoRPC3a
         /iMujTAwMOgZ8SEcXp5WgUH9Axyh0d0/4TbwXmzDs8llMHq9NdKlgpSw10KHi+t/UGfk
         3/aQUq9jQ07rhC9/NmxqFmIc548yWA4+uXlP9a784F1CVjzK88kLIdViqPMWk1EKfU+M
         Bkkw==
X-Gm-Message-State: AOJu0YyWwJ+6N0aDCf6DpFKL3XXW1CkHa9AmX4jMlnXZpVrB9k2/ZMdo
	buW89nSprNJMrGUxL3b67mJu0gQVRA+BdOZ4BQeFEHGbpq9EB6hCIPBQ801d
X-Google-Smtp-Source: AGHT+IF2vLLX/EMk3Fl8t/hyQrqSv4NBjs87z3JEY46Z1YubuEIQQeVA8W5t2K8L214Q7h26l8k5BYlgsJuZBpVSb4M=
X-Received: by 2002:a50:c31b:0:b0:54c:44c7:4d4 with SMTP id
 a27-20020a50c31b000000b0054c44c704d4mr29491edb.2.1701379030934; Thu, 30 Nov
 2023 13:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <896b5786-8ed7-af6c-2c64-a24bb06a0d89@arm.com> <CAFjbc8FXJwJShr88XUybWFQa1HC6rYdq7cpc3XPCuPKjOUoz2g@mail.gmail.com>
In-Reply-To: <CAFjbc8FXJwJShr88XUybWFQa1HC6rYdq7cpc3XPCuPKjOUoz2g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Nov 2023 13:16:59 -0800
Message-ID: <CAP-5=fWZORMTvqjz5SrH_6sJZ=7APf7VpeL7HZkmQvUH4j88Ng@mail.gmail.com>
Subject: Re: Perf support in CPython
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 4:42=E2=80=AFAM Pablo Galindo Salgado
<pablogsal@gmail.com> wrote:
>
> > Do you really want to use full Dwarf mode? You have to save the entire
> > stack space on every sample for that to work, so it seems a bit slow.
> > But maybe it's not an issue for lower sampling frequencies. If the
> > application has a huge stack it's not really scalable.
> > Is that just so you have a mode that works out of the box without any
> > recompilation of Python? But not necessarily the best way to do it?
>
> I do not *want* to do it as we already have a fully working version
> when frame pointers are included
> using the perf maps version. But the problem is that users cannot
> generally leverage this as most
> Python redistributors do not compile with frame pointers, and this
> renders the integration useless
> for most people.
>
> So indeed, as you mention dwarf unwinding is a suboptimal way but it
> will provide a way
> for most users to get the integration working for them and people that
> really care about the
> most performant way can compile Python with frame pointers. The
> problem is that most
> Python users do not compile Python themselves and this is a huge
> barrier for them.
>
> That's why we want to *also* have DWARF unwinding working, even if it
> is suboptimal.

Won't fixing GCC/LLVM be the best approach? Change the RBP offsets to
RSP relative ones if shorter, perhaps around this code:
https://github.com/gcc-mirror/gcc/blob/master/gcc/emit-rtl.cc#L882
https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86Frame=
Lowering.cpp#L2547

Nobody really expects 1 register to be worth 10% performance, so
fixing a performance elephant (which by definition should be easy to
see) in the compiler will win for everybody and give a solution that
works with BPF, etc.

Thanks,
Ian
