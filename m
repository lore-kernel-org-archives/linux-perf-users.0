Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7C2E3365
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217519; cv=none; b=XyDr22pAiwsiZ91hH9EjNrv858sK+Pg6PPMtP/o+imrs4/CfTwM/Ad9ZargascIq/X/2l0Qj/Saix2UjWKActlIg2omDERjHUmbnxx0dDsOzZ1FktAIynQdXZZL+/IKkA5ItYjsq2cWOer97TWJmfuQErII/9vR0ft2QDAEOBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217519; c=relaxed/simple;
	bh=0GEbMyPOtVsokW/l5zTMZR1AaB0W8W5ALDvWT2Tbv28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMMZ9qm5Ecc+XGOs5YrHYOmYyFqMOWYslGMut5qP0Ly3yZCh5a8WJ9sBq/sQ3+pjMHXhm4vkgoejNAsy3JI2cfIiv8tEVmnukSj7j0A2CPkC+8Fk7qzEo9PsWGMbNj2lLGSSBbjefCm57B+aMkFgEwKQG1UmVLLn14bLg1MePyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDA844yX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDA844yX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so57885ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741217517; x=1741822317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS4eOCroqcSNVo6vbNjzV2E7z6zkZN+lNR6J8O9YLLI=;
        b=UDA844yX+X2hf58e0uY0d0TQAvq1PAa+5ZeR3CidWKWi/awk9x8LU3jec5k/4kZpEm
         uDVUpHJZd8p4Nydv3o+FwfunKWV12huwWBEC/s8kEDEzYPwEZc6r3i9xibf67jeJHw+A
         XqdyMdJrBBp17D6+2P0EJz9iQTnn793oWgtmK09wCrLFr+7xBACvoUfiwzm4v8CEbIw+
         8uT8EC2mDzjpJuNLTvUzIA3Dsuq33Il96yhTACmlonGwXrtx20Ppx4olBC5BgAP16GCq
         v4W8j6PjgO4COjgIOzf4BBVzjauFecP3pbjqUHvqPHM01vt145WffswepUHlVgU33lBW
         YpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217517; x=1741822317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS4eOCroqcSNVo6vbNjzV2E7z6zkZN+lNR6J8O9YLLI=;
        b=Zx3S5BRa/tHhxVqFTSPnxsTQXDv1ZgNE54IZi88+DIjlD2mRwt11ygwjwqWA8YdjWL
         6raDrSOQ1bOYV4+RKkddQor0I6FupR/gBJ4ATs/PKcW6x+yzjn4inYxrNlDQobwBSG9j
         QRblHp0wfaeGBLx1EyRzg9GyOcVlg6LaUkAzPj8WgSxKPXyIK52rkTJdsFMWVBEc+1Ay
         NfhjlQkoUw/SMjJDbD2YSrFLMXqHv08QgAIRqa2uDnLCVvblpLenTpUFjZ5onHyzIxMh
         6Ab1Ci/p8gA8xpz184k4yqi953CTifJ5r1DF8WJ1iT+BdpeJQExEIFIiSdnz+aUlbyzG
         Dqaw==
X-Forwarded-Encrypted: i=1; AJvYcCVABAhG4+Eo+5wPnaJiZRJCCLVhnxHaviIvYRrsAz2lBZFdyZiNinG3bn0FBgNsOeyZUUSLRk8tBjiHqRGG1xqA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IegjJsyXjy5yM9Hr8gm++wMtMnEilPij5eu5HZsWWDshJUZP
	m2qlk6Hmy2sKLgxtq8EbBWu+DIYPbCl23C1qgnzk7IVRD6iI0+3rZnIGa7Pe9d6Pn4VWAJuyhK3
	tKBrGwHzisOih4YShO5ZLk4UFR2uqtE3KDycD
X-Gm-Gg: ASbGnculiwc3zCsgIgbXaJn0BR7GcOIrdOZinptJb1x23y/DqJraHI3JcTFeP/qZsai
	yc/7g2mwE/qMZfoG7yp/Xtg0daEaCrgHEvOzhzxNlHMOqVS2xJ6MksSBWDFDYXkgaMVJQFRsXUq
	eZ8KfRbuTgJAnOopduhG3hkrMSTV/AMqT/ZumrjushpZHo2pxtOuqeg3c=
X-Google-Smtp-Source: AGHT+IGMu4z+TFE/fk01mAtZBmhUr8P+YxVgaurtmcQJOAZxHiDEngj2vXuYUsWZrxe63kaf7K2IzCPDT7KIDV3mK0Y=
X-Received: by 2002:a17:902:f60e:b0:21f:465d:c588 with SMTP id
 d9443c01a7336-2240aad16a1mr1071975ad.14.1741217516977; Wed, 05 Mar 2025
 15:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303173807.1765098-1-namhyung@kernel.org> <CAP-5=fX5CYk__B=QuP8nUXUMxq765v-1ee+apxiGurOrxp87dw@mail.gmail.com>
In-Reply-To: <CAP-5=fX5CYk__B=QuP8nUXUMxq765v-1ee+apxiGurOrxp87dw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 15:31:45 -0800
X-Gm-Features: AQ5f1Jr7WblgNS2Jx-9XWsMobu0wTTs65J3vLsPpH9CoFs3MaspO6hz4yEHNRPg
Message-ID: <CAP-5=fV+bJ2Hpnmuq8L1HSS1KaHstySrBtnGFMW3YWmj17yCjg@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf annotate: Add --code-with-type option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:27=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Mar 3, 2025 at 9:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hello,
> >
> > There are roughly two modes in the perf annotate.  One is normal code
> > anootation and the other is data type annotation.  I'm proposing a new
>
> nit: s/anootation/annotation/
>
> > way to combine the code and data annotation together.
> >
> > With this option, "# data-type: <name> [offset (field)]" part will be
> > adeded when it found a data type for the given instruction.  This is
>
> nit: s/adeded/added/
>
> > for every instruction in the function regardless whether it has a
> > sample or not.
> >
> > This will be useful to understand function level data access patterns.
> > Currently it only works with --stdio, but I can add it to TUI later.
> >
> > Here's an example output.
>
> At some point I think we might as well have our own disassembler. The
> annotations remind me of the relocation and other annotation output of
> objdump.
>
> >   $ perf annotate --code-with-type --stdio
> >   ...
> >  Percent |      Source code & Disassembly of elf for cpu/mem-loads,ldla=
t=3D30/P (4 samples, percent: local period)
> >   ---------------------------------------------------------------------=
-------------------------------------------
> >            : 0                0xffffffff81bb7060 <__schedule>:
> >       0.00 :   ffffffff81bb7060:        pushq   %rbp              # dat=
a-type: (stack operation)
> >       0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
> >       0.00 :   ffffffff81bb7064:        pushq   %r15              # dat=
a-type: (stack operation)
> >       0.00 :   ffffffff81bb7066:        pushq   %r14              # dat=
a-type: (stack operation)
> >       0.00 :   ffffffff81bb7068:        pushq   %r13              # dat=
a-type: (stack operation)
> >       0.00 :   ffffffff81bb706a:        pushq   %r12              # dat=
a-type: (stack operation)
> >       0.00 :   ffffffff81bb706c:        pushq   %rbx              # dat=
a-type: (stack operation)
>
> data-type: looks a bit weird here. I wonder if the
> .cfi_offset/.cfi_restore could  make this information richer, maybe:
>        0.00 :   ffffffff81bb7060:        pushq   %rbp              #
> *(frame-16) =3D caller rbp
>        0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
>        0.00 :   ffffffff81bb7064:        pushq   %r15              #
> *(frame-24) =3D caller r15
>
> >       0.00 :   ffffffff81bb706d:        movq    $0x33180, %rbx
> >       0.00 :   ffffffff81bb7074:        movq    %rbx, %r12
> >       0.00 :   ffffffff81bb7077:        subq    $0x38, %rsp
> >       0.00 :   ffffffff81bb707b:        movl    %edi, -0x5c(%rbp)      =
   # data-type: unsigned int +0
> >       0.00 :   ffffffff81bb707e:        movq    %gs:0x28, %rax         =
   # data-type: (stack canary)
> >       0.00 :   ffffffff81bb7087:        movq    %rax, -0x30(%rbp)      =
   # data-type: (stack canary)
> >       0.00 :   ffffffff81bb708b:        xorl    %eax, %eax
> >       0.00 :   ffffffff81bb708d:        movq    $0x0, -0x58(%rbp)      =
   # data-type: struct rq_flags +0 (flags)
> >       0.00 :   ffffffff81bb7095:        movq    $0x0, -0x50(%rbp)      =
   # data-type: struct rq_flags +0x8 (clock_update_flags)
> >       0.00 :   ffffffff81bb709d:        callq   0xffffffff81baa100 <deb=
ug_smp_processor_id>               # data-type: (stack operation)
> >       0.00 :   ffffffff81bb70a2:        cltq
> >       0.00 :   ffffffff81bb70a4:        addq    -0x7dcf0500(,%rax,8), %=
r12                # data-type: long unsigned int[] +0
> >       0.00 :   ffffffff81bb70ac:        movq    0x960(%r12), %r13      =
   # data-type: struct rq +0x960 (curr)
> >       0.00 :   ffffffff81bb70b4:        movq    0x20(%r13), %rax       =
   # data-type: struct task_struct +0x20 (stack)
> >       0.00 :   ffffffff81bb70b8:        cmpq    $0x57ac6e9d, (%rax)
> >       0.00 :   ffffffff81bb70bf:        jne     0xffffffff81bb7bca <__s=
chedule+0xb6a>
> >       0.00 :   ffffffff81bb70c5:        movl    %gs:0x7e47b87c(%rip), %=
eax  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x=
8 (preempt_count)
>
> The variable name in the struct is really nice, it is a shame the same
> information gets repeated a few times on the line.

Outside of the typos in the cover letter, the rest of the patches lgtm.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >       0.00 :   ffffffff81bb70cc:        andl    $0x7fffffff, %eax
> >       0.00 :   ffffffff81bb70d1:        cmpl    $0x1, %eax
> >       0.00 :   ffffffff81bb70d4:        jne     0xffffffff81bb79de <__s=
chedule+0x97e>
> >       0.00 :   ffffffff81bb70da:        nopl    (%rax,%rax)
> >       0.00 :   ffffffff81bb70df:        cmpl    $0x2, 0xe86b3a(%rip)  #=
 0xffffffff82a3dc20 <prof_on>              # data-type: int +0
> >       0.00 :   ffffffff81bb70e6:        movq    0x8(%rbp), %rsi
> >       0.00 :   ffffffff81bb70ea:        je      0xffffffff81bb7a0b <__s=
chedule+0x9ab>
> >       0.00 :   ffffffff81bb70f0:        nopl    (%rax,%rax)
> >       0.00 :   ffffffff81bb70f5:        nop
> >       ...
> >
> > The code is also available at 'perf/annotate-code-data-v1' branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (7):
> >   perf annotate-data: Add annotated_data_type__get_member_name()
> >   perf annotate: Remove unused len parameter from
> >     annotation_line__print()
> >   perf annotate: Pass annotation_options to annotation_line__print()
> >   perf annotate: Pass hist_entry to annotate functions
> >   perf annotate: Factor out __hist_entry__get_data_type()
> >   perf annotate: Implement code + data type annotation
> >   perf annotate: Add --code-with-type option.
> >
> >  tools/perf/Documentation/perf-annotate.txt |   4 +
> >  tools/perf/builtin-annotate.c              |  19 +-
> >  tools/perf/builtin-top.c                   |   2 +-
> >  tools/perf/util/annotate-data.c            |  34 +++
> >  tools/perf/util/annotate-data.h            |   3 +
> >  tools/perf/util/annotate.c                 | 267 +++++++++++++--------
> >  tools/perf/util/annotate.h                 |   8 +-
> >  tools/perf/util/sort.c                     |  39 +--
> >  8 files changed, 236 insertions(+), 140 deletions(-)
> >
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
