Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC20202C55
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217235; cv=none; b=FOh1nxxkF3M8rkTkdaK560GwATfRVLp/bvsidGl3jCydLHfsZDgDzICndOvop1viWqytXLGhfSmCZ5XXstsnY6Yu6DhAbDSSCN+ztXPzWtnZhNxuD7prIC/dHsFJ8v9NEtuSI43y0E0fttZmXy1PemRbT4bANOzTpZaqrOSVPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217235; c=relaxed/simple;
	bh=kQ4hezEE5TmAsqk2WAkK9xJajndCWQ5kOHlA8k+VDEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dak453UgPlgA6dW6tOPeP4LD7n2ppWcMVA7qyRSZI/Tm/Um5E5VOCJ1oPIUuXjM7LwSCtm3H31ln8sQNyYeefnQZMg650nleoQu3iSm2T03ZJgKODEr0LjDXBx0i8j+is145wApcj1ZSegY07227PX44D9Nmxhg8OW529dYnxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJCQM3Cu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJCQM3Cu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223a0da61easo63995ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741217233; x=1741822033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b78GvVu0xnWmLt5AL+u6OyUDxJQRRkmBPD2yBcWIHCQ=;
        b=aJCQM3Cul8Vit37NXiDwsaGK4g+hiizmUqNFsRGbR5soATwz2zx6mB5AuGcFkJ3l+E
         Op9tEUzDZ5DKXBuqzMEsE2kodi44pkMDBOreCHdu8BCbnl/331b5pzO31BhpkOAUozVa
         GACQn6vw/ZPBIbbk2NM5yy3n+nH4cL+72e2VUoFGTRA8sau7ElZdtteiq2aROJVHnkLg
         4vic7DbQ3qvCKgZcCVVtxw7iicXWMbOfDPs9KT/y8D5Q5NIVxcyGzqNT2qFR45jtsiM1
         xVSibz0IC6eFd9bMZ2+MxoCgEJVypp+A/JG6WWVT3AzyfhZIcCNWXyxuNai4psG+xmDr
         9ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217233; x=1741822033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b78GvVu0xnWmLt5AL+u6OyUDxJQRRkmBPD2yBcWIHCQ=;
        b=odrEtaiOjiVLrHO5LvneLgJ9VG7Z8o7o896uqtMatSfk0gqArwf3PrvrDs3KixR7lN
         /PcZT8zuzD4XCjT/lAQtPsDNVv6X2VvFCR31yHm/h/5zxBNClB1jTweE410lxddkK8TK
         oOFvCblmeSyUd2nn31JqamXy1HTz/3u9r4JwvARLtnBmm3HeKY6oPHlvsVtJZ+N4LmXM
         PPKzfoMdD3tOK1E9GBaBhTIks9jAwPYMaKOISOB2gDge6pgQNsdNvPq6WJbVm6ZdvlUi
         DyVoibA92urCDj3Rxkr7XsQs5luQhwkvsLo+WzS8deGNpl4bTYTYfpJ/mfbfmUS751NV
         qJDw==
X-Forwarded-Encrypted: i=1; AJvYcCVYyRXTd8V6S5+6Tkee1E9yJtKpRBs8W6RI53C/PWpZT14D8qbPnKFS2OKloCux0+A7t4nCliaIhGeJSbU0NVp6@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcBYfbUZJIjgLvsKcIgtyUjZYfIaVhZhT/nb1jtP/u4kuZleZ
	FKoaMsR/JYt5oKp+ZKs5EvZStEGpr5wkzbiE5VikuBe0gO6DIFEd6iliQnm1zwwxnFqmgPUPBFV
	oHpu+neJPiQtCRxIuSirUmnc5w8kDxZLdxkaK
X-Gm-Gg: ASbGncvkiMtcg4kQNvyUADjihlHhzTK+sxZOzmL7T0u8+P4woHhNBW+qPgG7qj3tv+V
	D0Hy3l6RetIft4HLe+ldUQmYLtuy1riLbz7UHKkQGwjGdnrujJbvfVwgWV/iqs6zKILz1KDvwf1
	3mCaXVe6vOHjlCzXbiqlmsyj0g8DU4qomapInYhlbE6uuYQOTDzgbTS9o=
X-Google-Smtp-Source: AGHT+IG8+qBUF66j4mvD54ub1vH2+W8LJGgI3MhpKV5V/6Im8HW7QSvd8RmanFmCncVmiSzxslxDSfFOcNRK8sP7sTc=
X-Received: by 2002:a17:902:dad0:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-2240ab17780mr985015ad.22.1741217233070; Wed, 05 Mar 2025
 15:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303173807.1765098-1-namhyung@kernel.org>
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 15:27:02 -0800
X-Gm-Features: AQ5f1JoNnrdbH7QlMsVMLKh1Na0Oad3qbsV_KKA7XclbkzZq4q2jW4wlZ-HBeDM
Message-ID: <CAP-5=fX5CYk__B=QuP8nUXUMxq765v-1ee+apxiGurOrxp87dw@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf annotate: Add --code-with-type option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> There are roughly two modes in the perf annotate.  One is normal code
> anootation and the other is data type annotation.  I'm proposing a new

nit: s/anootation/annotation/

> way to combine the code and data annotation together.
>
> With this option, "# data-type: <name> [offset (field)]" part will be
> adeded when it found a data type for the given instruction.  This is

nit: s/adeded/added/

> for every instruction in the function regardless whether it has a
> sample or not.
>
> This will be useful to understand function level data access patterns.
> Currently it only works with --stdio, but I can add it to TUI later.
>
> Here's an example output.

At some point I think we might as well have our own disassembler. The
annotations remind me of the relocation and other annotation output of
objdump.

>   $ perf annotate --code-with-type --stdio
>   ...
>  Percent |      Source code & Disassembly of elf for cpu/mem-loads,ldlat=
=3D30/P (4 samples, percent: local period)
>   -----------------------------------------------------------------------=
-----------------------------------------
>            : 0                0xffffffff81bb7060 <__schedule>:
>       0.00 :   ffffffff81bb7060:        pushq   %rbp              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
>       0.00 :   ffffffff81bb7064:        pushq   %r15              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb7066:        pushq   %r14              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb7068:        pushq   %r13              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb706a:        pushq   %r12              # data-=
type: (stack operation)
>       0.00 :   ffffffff81bb706c:        pushq   %rbx              # data-=
type: (stack operation)

data-type: looks a bit weird here. I wonder if the
.cfi_offset/.cfi_restore could  make this information richer, maybe:
       0.00 :   ffffffff81bb7060:        pushq   %rbp              #
*(frame-16) =3D caller rbp
       0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
       0.00 :   ffffffff81bb7064:        pushq   %r15              #
*(frame-24) =3D caller r15

>       0.00 :   ffffffff81bb706d:        movq    $0x33180, %rbx
>       0.00 :   ffffffff81bb7074:        movq    %rbx, %r12
>       0.00 :   ffffffff81bb7077:        subq    $0x38, %rsp
>       0.00 :   ffffffff81bb707b:        movl    %edi, -0x5c(%rbp)        =
 # data-type: unsigned int +0
>       0.00 :   ffffffff81bb707e:        movq    %gs:0x28, %rax           =
 # data-type: (stack canary)
>       0.00 :   ffffffff81bb7087:        movq    %rax, -0x30(%rbp)        =
 # data-type: (stack canary)
>       0.00 :   ffffffff81bb708b:        xorl    %eax, %eax
>       0.00 :   ffffffff81bb708d:        movq    $0x0, -0x58(%rbp)        =
 # data-type: struct rq_flags +0 (flags)
>       0.00 :   ffffffff81bb7095:        movq    $0x0, -0x50(%rbp)        =
 # data-type: struct rq_flags +0x8 (clock_update_flags)
>       0.00 :   ffffffff81bb709d:        callq   0xffffffff81baa100 <debug=
_smp_processor_id>               # data-type: (stack operation)
>       0.00 :   ffffffff81bb70a2:        cltq
>       0.00 :   ffffffff81bb70a4:        addq    -0x7dcf0500(,%rax,8), %r1=
2                # data-type: long unsigned int[] +0
>       0.00 :   ffffffff81bb70ac:        movq    0x960(%r12), %r13        =
 # data-type: struct rq +0x960 (curr)
>       0.00 :   ffffffff81bb70b4:        movq    0x20(%r13), %rax         =
 # data-type: struct task_struct +0x20 (stack)
>       0.00 :   ffffffff81bb70b8:        cmpq    $0x57ac6e9d, (%rax)
>       0.00 :   ffffffff81bb70bf:        jne     0xffffffff81bb7bca <__sch=
edule+0xb6a>
>       0.00 :   ffffffff81bb70c5:        movl    %gs:0x7e47b87c(%rip), %ea=
x  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x8 =
(preempt_count)

The variable name in the struct is really nice, it is a shame the same
information gets repeated a few times on the line.

Thanks,
Ian

>       0.00 :   ffffffff81bb70cc:        andl    $0x7fffffff, %eax
>       0.00 :   ffffffff81bb70d1:        cmpl    $0x1, %eax
>       0.00 :   ffffffff81bb70d4:        jne     0xffffffff81bb79de <__sch=
edule+0x97e>
>       0.00 :   ffffffff81bb70da:        nopl    (%rax,%rax)
>       0.00 :   ffffffff81bb70df:        cmpl    $0x2, 0xe86b3a(%rip)  # 0=
xffffffff82a3dc20 <prof_on>              # data-type: int +0
>       0.00 :   ffffffff81bb70e6:        movq    0x8(%rbp), %rsi
>       0.00 :   ffffffff81bb70ea:        je      0xffffffff81bb7a0b <__sch=
edule+0x9ab>
>       0.00 :   ffffffff81bb70f0:        nopl    (%rax,%rax)
>       0.00 :   ffffffff81bb70f5:        nop
>       ...
>
> The code is also available at 'perf/annotate-code-data-v1' branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (7):
>   perf annotate-data: Add annotated_data_type__get_member_name()
>   perf annotate: Remove unused len parameter from
>     annotation_line__print()
>   perf annotate: Pass annotation_options to annotation_line__print()
>   perf annotate: Pass hist_entry to annotate functions
>   perf annotate: Factor out __hist_entry__get_data_type()
>   perf annotate: Implement code + data type annotation
>   perf annotate: Add --code-with-type option.
>
>  tools/perf/Documentation/perf-annotate.txt |   4 +
>  tools/perf/builtin-annotate.c              |  19 +-
>  tools/perf/builtin-top.c                   |   2 +-
>  tools/perf/util/annotate-data.c            |  34 +++
>  tools/perf/util/annotate-data.h            |   3 +
>  tools/perf/util/annotate.c                 | 267 +++++++++++++--------
>  tools/perf/util/annotate.h                 |   8 +-
>  tools/perf/util/sort.c                     |  39 +--
>  8 files changed, 236 insertions(+), 140 deletions(-)
>
> --
> 2.48.1.711.g2feabab25a-goog
>
