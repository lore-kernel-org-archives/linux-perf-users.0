Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B30BA50;
	Fri,  7 Mar 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306014; cv=none; b=TwQcdkB0XebeywLBh8x2YsuVKCimQpef9QCXLXxuJ02MFmJxsLGMRkkRyO+ONfwwCX6OV6wZoaqSsP1Pig0B6YcNRBBoepd8le2UP0imuOuRcsMCNsSZ4GrTXf9bFk7Jgj6djbm0uAJkCQgw51vY797rn//XGvuD++722+2+O00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306014; c=relaxed/simple;
	bh=e1OYjs7RuKiT13xcqlqse+WB2O3U3s3HF4AuTvizTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKI3nmzcUOJHBK36XGHIJBSt4iIotn0dGOT4fuP80LuIMEQdB23H2ocV/IBkMZuzU04Z32a5zObUCnjye1y7r88X9MwApmBDGYp0x0PS5nrscHyQ+93O4I7QP3lidbj9pljp8vtj+BVAIaOrZp41HU+9pPS2BGgUXB7oYWk/PlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1H8XzWR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1H8XzWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D43C4CEE0;
	Fri,  7 Mar 2025 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741306014;
	bh=e1OYjs7RuKiT13xcqlqse+WB2O3U3s3HF4AuTvizTzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1H8XzWR2G46dJ9EJaxEY5l7Mz7tMeb1vg0UPOpSF4ZjxZKhRvyQ1NSMz9HpZ5EKa
	 rKnIBkELTWkQ7mpGTg8HaHHZ0s7RuRn6CoDwf8Y6rbuJWk929dLUS1GyFRYXqPCmf5
	 IrEo5Gx1Ohi/4q6qukrH1g4jCCFqjiaLEWGUzt/dFlVMsGqiBm6dPXi1F3ToMjSoWa
	 Wy8zib0VjN+lgKYc2Df82/ML/akP/NcjJrWEJex3LLFtNuaw/QQSTqRs1+ARzsUw6p
	 9mSysQI9WLVo/bHJoSbKSGbT80m5IzhcJ3O0wcySE6wGsL8xfaivM07qRlmydpz6fH
	 BwiOTe6v7C40Q==
Date: Thu, 6 Mar 2025 16:06:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCHSET 0/7] perf annotate: Add --code-with-type option
Message-ID: <Z8o4m5s-O4NUhz79@google.com>
References: <20250303173807.1765098-1-namhyung@kernel.org>
 <CAP-5=fX5CYk__B=QuP8nUXUMxq765v-1ee+apxiGurOrxp87dw@mail.gmail.com>
 <CAP-5=fV+bJ2Hpnmuq8L1HSS1KaHstySrBtnGFMW3YWmj17yCjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV+bJ2Hpnmuq8L1HSS1KaHstySrBtnGFMW3YWmj17yCjg@mail.gmail.com>

On Wed, Mar 05, 2025 at 03:31:45PM -0800, Ian Rogers wrote:
> On Wed, Mar 5, 2025 at 3:27 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Mar 3, 2025 at 9:38 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > There are roughly two modes in the perf annotate.  One is normal code
> > > anootation and the other is data type annotation.  I'm proposing a new
> >
> > nit: s/anootation/annotation/

Oops.

> >
> > > way to combine the code and data annotation together.
> > >
> > > With this option, "# data-type: <name> [offset (field)]" part will be
> > > adeded when it found a data type for the given instruction.  This is
> >
> > nit: s/adeded/added/

Thanks for pointing this out.

> >
> > > for every instruction in the function regardless whether it has a
> > > sample or not.
> > >
> > > This will be useful to understand function level data access patterns.
> > > Currently it only works with --stdio, but I can add it to TUI later.
> > >
> > > Here's an example output.
> >
> > At some point I think we might as well have our own disassembler. The
> > annotations remind me of the relocation and other annotation output of
> > objdump.
> >
> > >   $ perf annotate --code-with-type --stdio
> > >   ...
> > >  Percent |      Source code & Disassembly of elf for cpu/mem-loads,ldlat=30/P (4 samples, percent: local period)
> > >   ----------------------------------------------------------------------------------------------------------------
> > >            : 0                0xffffffff81bb7060 <__schedule>:
> > >       0.00 :   ffffffff81bb7060:        pushq   %rbp              # data-type: (stack operation)
> > >       0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
> > >       0.00 :   ffffffff81bb7064:        pushq   %r15              # data-type: (stack operation)
> > >       0.00 :   ffffffff81bb7066:        pushq   %r14              # data-type: (stack operation)
> > >       0.00 :   ffffffff81bb7068:        pushq   %r13              # data-type: (stack operation)
> > >       0.00 :   ffffffff81bb706a:        pushq   %r12              # data-type: (stack operation)
> > >       0.00 :   ffffffff81bb706c:        pushq   %rbx              # data-type: (stack operation)
> >
> > data-type: looks a bit weird here. I wonder if the
> > .cfi_offset/.cfi_restore could  make this information richer, maybe:
> >        0.00 :   ffffffff81bb7060:        pushq   %rbp              # *(frame-16) = caller rbp
> >        0.00 :   ffffffff81bb7061:        movq    %rsp, %rbp
> >        0.00 :   ffffffff81bb7064:        pushq   %r15              # *(frame-24) = caller r15

Probably possible, but it's also obvious from the instruction.
I didn't try to be smart here as we're interested in types.

> >
> > >       0.00 :   ffffffff81bb706d:        movq    $0x33180, %rbx
> > >       0.00 :   ffffffff81bb7074:        movq    %rbx, %r12
> > >       0.00 :   ffffffff81bb7077:        subq    $0x38, %rsp
> > >       0.00 :   ffffffff81bb707b:        movl    %edi, -0x5c(%rbp)         # data-type: unsigned int +0
> > >       0.00 :   ffffffff81bb707e:        movq    %gs:0x28, %rax            # data-type: (stack canary)
> > >       0.00 :   ffffffff81bb7087:        movq    %rax, -0x30(%rbp)         # data-type: (stack canary)
> > >       0.00 :   ffffffff81bb708b:        xorl    %eax, %eax
> > >       0.00 :   ffffffff81bb708d:        movq    $0x0, -0x58(%rbp)         # data-type: struct rq_flags +0 (flags)
> > >       0.00 :   ffffffff81bb7095:        movq    $0x0, -0x50(%rbp)         # data-type: struct rq_flags +0x8 (clock_update_flags)
> > >       0.00 :   ffffffff81bb709d:        callq   0xffffffff81baa100 <debug_smp_processor_id>               # data-type: (stack operation)
> > >       0.00 :   ffffffff81bb70a2:        cltq
> > >       0.00 :   ffffffff81bb70a4:        addq    -0x7dcf0500(,%rax,8), %r12                # data-type: long unsigned int[] +0
> > >       0.00 :   ffffffff81bb70ac:        movq    0x960(%r12), %r13         # data-type: struct rq +0x960 (curr)
> > >       0.00 :   ffffffff81bb70b4:        movq    0x20(%r13), %rax          # data-type: struct task_struct +0x20 (stack)
> > >       0.00 :   ffffffff81bb70b8:        cmpq    $0x57ac6e9d, (%rax)
> > >       0.00 :   ffffffff81bb70bf:        jne     0xffffffff81bb7bca <__schedule+0xb6a>
> > >       0.00 :   ffffffff81bb70c5:        movl    %gs:0x7e47b87c(%rip), %eax  # 0x32948 <pcpu_hot+0x8>              # data-type: struct pcpu_hot +0x8 (preempt_count)
> >
> > The variable name in the struct is really nice, it is a shame the same
> > information gets repeated a few times on the line.

I guess you meant 'pcpu_hot'.  But the assembly shows the name of the
global variable and the data type shows the name of struct.  It happened
to be the same in this case.

> 
> Outside of the typos in the cover letter, the rest of the patches lgtm.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!
Namhyung

> 
> > >       0.00 :   ffffffff81bb70cc:        andl    $0x7fffffff, %eax
> > >       0.00 :   ffffffff81bb70d1:        cmpl    $0x1, %eax
> > >       0.00 :   ffffffff81bb70d4:        jne     0xffffffff81bb79de <__schedule+0x97e>
> > >       0.00 :   ffffffff81bb70da:        nopl    (%rax,%rax)
> > >       0.00 :   ffffffff81bb70df:        cmpl    $0x2, 0xe86b3a(%rip)  # 0xffffffff82a3dc20 <prof_on>              # data-type: int +0
> > >       0.00 :   ffffffff81bb70e6:        movq    0x8(%rbp), %rsi
> > >       0.00 :   ffffffff81bb70ea:        je      0xffffffff81bb7a0b <__schedule+0x9ab>
> > >       0.00 :   ffffffff81bb70f0:        nopl    (%rax,%rax)
> > >       0.00 :   ffffffff81bb70f5:        nop
> > >       ...
> > >
> > > The code is also available at 'perf/annotate-code-data-v1' branch in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > Namhyung Kim (7):
> > >   perf annotate-data: Add annotated_data_type__get_member_name()
> > >   perf annotate: Remove unused len parameter from
> > >     annotation_line__print()
> > >   perf annotate: Pass annotation_options to annotation_line__print()
> > >   perf annotate: Pass hist_entry to annotate functions
> > >   perf annotate: Factor out __hist_entry__get_data_type()
> > >   perf annotate: Implement code + data type annotation
> > >   perf annotate: Add --code-with-type option.
> > >
> > >  tools/perf/Documentation/perf-annotate.txt |   4 +
> > >  tools/perf/builtin-annotate.c              |  19 +-
> > >  tools/perf/builtin-top.c                   |   2 +-
> > >  tools/perf/util/annotate-data.c            |  34 +++
> > >  tools/perf/util/annotate-data.h            |   3 +
> > >  tools/perf/util/annotate.c                 | 267 +++++++++++++--------
> > >  tools/perf/util/annotate.h                 |   8 +-
> > >  tools/perf/util/sort.c                     |  39 +--
> > >  8 files changed, 236 insertions(+), 140 deletions(-)
> > >
> > > --
> > > 2.48.1.711.g2feabab25a-goog
> > >
