Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338A145FFF;
	Fri,  5 Jul 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170614; cv=none; b=pgU8o88j1wtQ40C/vEnc/8N/tnQlK2jJgw54YfAFuj/R8fJyzO9n445E0bOQvxEh1NA2B71NbqNe6jF4UBLUyp0nqgut29aFgKe7zLsfsmxk41YruSTqs3Iui7ifB2bGymmmd7IE7VdSEKwLmvoNMtWhbNjyx+vzXrn8NJvHsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170614; c=relaxed/simple;
	bh=yvWnOud31vMnL+yTpzImfuL4uRHqnLCe9HNtiuwZ1sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VffPDTjLAoa6trE0aSg2esgcYBnw/wWvkkFwAkUMGDSyB4Tdlxf2gYGuKfpAbBPx9ZxNog90lzDNYV9SYhlhuHrvJA2sGtJdh6zKfBc+4KhY+ktZ1ywf/TWdNgxE9ub1vle8a3r2N6ncs2VuMHCkVGNn+7WkNSp5qNQfSmWnUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRutSGIS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRutSGIS"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03a9f7c6a6so1535047276.3;
        Fri, 05 Jul 2024 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720170612; x=1720775412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbTjYoqT6FWGIQEqL+1/VmCoqw7h+aX+VZ3OMKuTKbE=;
        b=TRutSGIS2xUL36whrPwuLK0Lxq2mW73dh+5ykcq504Gu9hFjVTeNrpbzjhF9ZAR9Qw
         dKuF5A+Fie++FzxVT/xIx2pveZtzxN8XOcrnpuGuFxWlovark/4hrT3d6UxYvL0wlYEs
         kM9yl3azA0zkp9k2AXfM9iefUw5UCtBCsqdTi5k2332U++I6PtQY3HPRv88+hj5xXo85
         7/KNTSYuIuVLQJ4q9PKO+hL3FHFeETX9Ugl1FJlm6s0HKeJdGhtosagU5QEH9XJNeUu1
         cv1VqTXlYT3zu14PT8bOqLw7+YfnJxjzM049KK112ONUL+jUs1gp/hUVTJ9Mt0P87bXk
         diFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170612; x=1720775412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbTjYoqT6FWGIQEqL+1/VmCoqw7h+aX+VZ3OMKuTKbE=;
        b=p1lGJbiTq+n7NZVbSSJs2WDMbNOxCJJy+q3ztzL7MGI/OEwAq5KVRGgcRgrToyv0KZ
         bgQWsX+hqEQp1b1eIc6tyVhQ90YoqJnoBlDjqX5X3qw+ZS6+VCx0pl54TV8U0f1cRlg7
         HqkC5obnMtRPzGlGPezU9UDG5suCDO4ZfcHtzsvIAG4tF33zonc3DTxjqLvFLgGOr2e8
         hOvpdakFoJoBuKfeZ/JDMdGaZSWGd0RsOiX17dLbgC990OWT+9xf/61Ddyv/Qr1XkZfp
         ljtRz4brwKjh7a1BFwoGOaDpurl990Wbl5jszWSuYr4JBlwRXGIS4dw71zFCx8OxB54Y
         t0bA==
X-Forwarded-Encrypted: i=1; AJvYcCUxCi3vqtP0B7gVl4gqt8fkrEA4OvKfUiIc7+ko5g9JlGsAcgJpPjrR448pFtr3SduKJCaKEXPZSq53G5x6PIjdJEz2zCEJJLMmFopXF7LmDOH7dDvPeRv1h6vfXMf5KPJKdi9+2wXl5xm/xA2JqA==
X-Gm-Message-State: AOJu0Yxo8XjW2qypJ6uV2FEADlDv8ZIyKjw0jpLh9UKuVAZYNKkfrOId
	BhN+1scWbTPWevs5n7ILFBry6En7nDxxyLw1V5zLQ9U7294Eqbm6a3AfMX0VqbRYt4hDCbVaqrh
	aGcIaPCBr+nGRDbNClzw8ADElZ3k=
X-Google-Smtp-Source: AGHT+IF10SX9Is8KfqoXRmKr52l6S+2MkCurZKQwZ6hQKrSUSUMvfFOa7ZVx/lpBAlCdINxFF6x1IOf1Xk3/u/P+F4U=
X-Received: by 2002:a25:dc54:0:b0:dca:c369:fac2 with SMTP id
 3f1490d57ef6-e03c1976135mr4174021276.3.1720170611618; Fri, 05 Jul 2024
 02:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704124354.904540-1-howardchu95@gmail.com> <Zob9c18uzVA__jPi@x1>
In-Reply-To: <Zob9c18uzVA__jPi@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 5 Jul 2024 17:10:02 +0800
Message-ID: <CAH0uvoi5d4A9KaC9KHN8v2SRV+ttHnjVPhunoK0Nvnvq5yTo-g@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] perf trace: Augment enum arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

Thanks for the review and improvements.

On Fri, Jul 5, 2024 at 3:52=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Thu, Jul 04, 2024 at 08:43:46PM +0800, Howard Chu wrote:
> > Changes in v4:
> >
> > - Fix landlock workload's build error.
>
> Can you please take a look at what is at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf_trace=
-btf_enum

I think it looks good. I don't know the side effects of a fixed
landlock_add_rule syscall number but I'm sure you've taken all
circumstances into consideration.

>
> ?
>
> I have it building on my set of containers, so far:
>
> perfbuilder@number:~$ export BUILD_TARBALL=3Dhttp://192.168.86.42/perf/pe=
rf-6.10.0-rc3.tar.xz
> perfbuilder@number:~$ time dm
>    1    97.75 almalinux:8                   : Ok   gcc (GCC) 8.5.0 202105=
14 (Red Hat 8.5.0-22) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8.1=
0.0+3757+fc27b834) flex 2.6.1
>    2    99.92 almalinux:9                   : Ok   gcc (GCC) 11.4.1 20231=
218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0=
.6-5.el9) flex 2.6.4
>    3   116.11 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git=
20211027) 10.3.1 20211027 , Alpine clang version 12.0.1 flex 2.6.4
>    4   115.06 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git=
20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
>    5    97.46 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git=
20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
>    6: alpine:3.18
>
> And that is what I'm planning to have merged into perf-tools-next, for
> 6.12, as soon as the next merge window closes.

:)

>
> Tomorrow I'll not be able to participate on the perf-tools Office hours,
> I=C2=B4ll be starting a two week long vacation, I'll be able to reply to =
some
> messages occasionally and if needed do any GSoC procedure step.

Got it, Enjoy.

Thanks,
Howard
>
> Best regards,
>
> - Arnaldo
>
> > Changes in v3:
> >
> > - Add trace__btf_scnprintf() helper function
> > - Remove is_enum memeber in struct syscall_arg_fmt, replace it with
> > btf_is_enum()
> > - Add syscall_arg_fmt__cache_btf_enum() to cache btf_type only
> > - Resolve NO_LIBBPF=3D1 build error
> > - Skip BTF augmentation test if landlock_add_rule syscall and LIBBPF ar=
e not
> > available
> > - Rename landlock.c workload, add a comment to landlock.c workload
> > - Change the way of skipping 'enum ' prefix
> > - Add type_name member to struct syscall_arg
> >
> > Changes in v2:
> >
> > - Add trace_btf_enum regression test, and landlock workload
> >
> > v1:
> >
> > In this patch, BTF is used to turn enum value to the corresponding
> > enum variable name. There is only one system call that uses enum value
> > as its argument, that is `landlock_add_rule()`.
> >
> > Enum arguments of non-syscall tracepoints can also be augmented, for
> > instance timer:hrtimer_start and timer:hrtimer_init's 'mode' argument.
> >
> >
> >
> > Arnaldo Carvalho de Melo (2):
> >   perf trace: Introduce trace__btf_scnprintf()
> >   perf trace: Remove arg_fmt->is_enum, we can get that from the BTF typ=
e
> >
> > Howard Chu (6):
> >   perf trace: Fix iteration of syscall ids in syscalltbl->entries
> >   perf trace: BTF-based enum pretty printing for syscall args
> >   perf trace: Augment non-syscall tracepoints with enum arguments with
> >     BTF
> >   perf trace: Filter enum arguments with enum names
> >   perf test: Add landlock workload
> >   perf test trace_btf_enum: Add regression test for the BTF augmentatio=
n
> >     of enums in 'perf trace'
> >
> >  tools/perf/builtin-trace.c               | 229 ++++++++++++++++++++---
> >  tools/perf/tests/builtin-test.c          |   1 +
> >  tools/perf/tests/shell/trace_btf_enum.sh |  61 ++++++
> >  tools/perf/tests/tests.h                 |   1 +
> >  tools/perf/tests/workloads/Build         |   2 +
> >  tools/perf/tests/workloads/landlock.c    |  38 ++++
> >  tools/perf/trace/beauty/beauty.h         |   1 +
> >  tools/perf/util/syscalltbl.c             |   7 +
> >  tools/perf/util/syscalltbl.h             |   1 +
> >  9 files changed, 317 insertions(+), 24 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
> >  create mode 100644 tools/perf/tests/workloads/landlock.c
> >
> > --
> > 2.45.2
