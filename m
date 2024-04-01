Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09784D9EF
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Apr 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008672; cv=none; b=R4gAnKtnPkjUwAA8C46Q88QpAWqrz/XEsTTh1uyfGhI1Mwn1cIBiMVJIBAQs0cTMEQFQWyCEDW0LHs68fLtTEOYSYL75qxCnqKcf47h8C7JFk29bp4J7dh3JowzF23W8B7n65CGxbnNvlBePQsVDiajPHb3jh8AQ2uyFXWlyUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008672; c=relaxed/simple;
	bh=AP76Fto+gepIlHQ82OjwUL4RpQumY8jedwJbpyIgDQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1E6fnV6M9wenPKv6gRAPLZ2djPPoactb9WTUcAaq1XXcuUE0iPnAAdNe3nyslmNU5cb9Nd/yjEOZpsF09x42BhowsbS7XSiKU0oI3FG7LnmLlMYJ7n+dWgB5cHPbkMiXr+oKdCJoFLwKgvnnM/7Tq/XhQl92HLgQE2raHtN1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso3042076a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Apr 2024 14:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008670; x=1712613470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8UfSrf52JJMdrVtOwtjSHHbkV0f0ZXXQAnL3rbNBFc=;
        b=BfEP6JL6Surax9Rg2+UIzxCct/9mxvCo97DO//QQvMnao1mOhK6RN0GUHIbcm+1POA
         zICPYfJCIRxMSGRGioHEXrVYHMJph/Wuw846VEXVj6Ki07h+VrKPN+gWqGVB299c1qez
         or0A9QY/xgXtghu0HRhtBwHNPWcJacvVeUu7Hc02KqCOk8novmHJiBKRGFaIoUKDo0Qt
         KXiRe+x3wiTAhtYgEGwT8n/8VyhjjJXsR5E0KD8xfiIxyp8CxV5rpTEN5fkEK1V4BLs2
         EOqdkcIeqN85HpgoAsiri0bnyfYhn4Cad4MeteYxegRvNwrPSiSD2iiK5O4tbn4GF6rg
         EMgw==
X-Forwarded-Encrypted: i=1; AJvYcCUuN1Gm0S7962sQD3Z2Zg4G1JDIv8WowWzaW5UALfmOFraD0Ra+GipMsVb0Y0SuLTz5BcPCwmAFATMrdDOIkwDSCQf0532P9XGJkvCxaG61nw==
X-Gm-Message-State: AOJu0YwWifjCLTLPZDpSkAhG9bgmzA/ymPohme7IT6SL1XYB5Lm91usg
	dM0NW75qFpXMrTWSq+SHlm7dYrU/EAi2wnWqrTFk7Lg5pWKM+uM0qdn6EIRIMD5F5d6u8t2TSp+
	XIP2JeYPajCh4GYPeRd73G1r1i7E=
X-Google-Smtp-Source: AGHT+IE5CshP9G95K3h6KzIjH3gXNmWewC8ljIs5UZIW6UwkBnj40+kP4TBtCCpOFctnp8quyiwNg1BhuAspPAB29L0=
X-Received: by 2002:a17:90a:540d:b0:29b:961a:29c3 with SMTP id
 z13-20020a17090a540d00b0029b961a29c3mr7476698pjh.49.1712008670215; Mon, 01
 Apr 2024 14:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20240309072513.9418-1-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 1 Apr 2024 14:57:39 -0700
Message-ID: <CAM9d7chQBpqipotQwc_ASYhzi9ZOP+TfenBzFJjyQ3-j5kGRBg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add data type profiling support for powerpc
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Sorry for the super late reply.


On Fri, Mar 8, 2024 at 11:25=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> The patchset from Namhyung added support for data type profiling
> in perf tool. This enabled support to associate PMU samples to data
> types they refer using DWARF debug information. With the upstream
> perf, currently it possible to run perf report or perf annotate to
> view the data type information on x86.
>
> This patchset includes changes need to enable data type profiling
> support for powerpc. Main change are:
> 1. powerpc instruction nmemonic table to associate load/store
> instructions with move_ops which is use to identify if instruction
> is a memory access one.
> 2. To get register number and access offset from the given
> instruction, code uses fields from "struct arch" -> objump.
> Add entry for powerpc here.
> 3. A get_arch_regnum to return register number from the
> register name string.
>
> These three patches are the basic foundational patches.
> With these changes, data types is getting identified for kernel
> and user-space samples. There are still samples, which comes as
> "unknown" and needs to be checked. We plan to get those addressed
> in follow up. With the current patchset:
>
>  ./perf record -a -e mem-loads sleep 1
>  ./perf report -s type,typeoff --hierarchy --group --stdio
> Snippet of logs:
>
>  Total Lost Samples: 0
>
>  Samples: 277  of events 'mem-loads, dummy:u'
>  Event count (approx.): 149813
>
>             Overhead  Data Type / Data Type Offset
>  ...................  ............................
>
>     65.93%   0.00%     (unknown)
>        65.93%   0.00%     (unknown) +0 (no field)
>      8.19%   0.00%     struct vm_area_struct
>         8.19%   0.00%     struct vm_area_struct +136 (vm_file)
>      4.53%   0.00%     struct rq
>         3.14%   0.00%     struct rq +0 (__lock.raw_lock.val)
>         0.83%   0.00%     struct rq +3216 (avg_irq.runnable_sum)
>         0.24%   0.00%     struct rq +4 (nr_running)
>         0.14%   0.00%     struct rq +12 (nr_preferred_running)
>         0.12%   0.00%     struct rq +2760 (sd)
>         0.06%   0.00%     struct rq +3368 (prev_steal_time_rq)
>         0.01%   0.00%     struct rq +2592 (curr)
>      3.53%   0.00%     struct rb_node
>         3.53%   0.00%     struct rb_node +0 (__rb_parent_color)
>      3.43%   0.00%     struct slab
>         3.43%   0.00%     struct slab +32 (freelist)
>      3.30%   0.00%     unsigned int
>         3.30%   0.00%     unsigned int +0 (no field)
>      3.22%   0.00%     struct vm_fault
>         3.22%   0.00%     struct vm_fault +48 (pmd)
>      2.55%   0.00%     unsigned char
>         2.55%   0.00%     unsigned char +0 (no field)
>      1.06%   0.00%     struct task_struct
>         1.06%   0.00%     struct task_struct +4 (thread_info.cpu)
>      0.92%   0.00%     void*
>         0.92%   0.00%     void* +0 (no field)
>      0.74%   0.00%     __int128 unsigned
>         0.74%   0.00%     __int128 unsigned +8 (no field)
>      0.59%   0.00%     struct perf_event
>         0.54%   0.00%     struct perf_event +552 (ctx)
>         0.04%   0.00%     struct perf_event +152 (pmu)
>      0.20%   0.00%     struct sched_entity
>         0.20%   0.00%     struct sched_entity +0 (load.weight)
>      0.18%   0.00%     struct cfs_rq
>         0.18%   0.00%     struct cfs_rq +96 (curr)

Cool!  I'm happy to see it works well on powerpc too.

Lots of codes are still assuming x86 so you may need to
add separate logics like parsing the instruction location.

And instruction tracking is also a great concern.
But we may have something in the clang/LLVM to produce
more debug information and hopefully we can remove the
instruction tracking at all.

https://github.com/llvm/llvm-project/pull/81545

Anyway I'm really looking forward to seeing v2 soon.

Thanks,
Namhyung

>
> Athira Rajeev (3):
>   tools/perf/arch/powerpc: Add load/store in powerpc annotate
>     instructions for data type profling
>   tools/erf/util/annotate: Set register_char and memory_ref_char for
>     powerpc
>   tools/perf/arch/powerc: Add get_arch_regnum for powerpc
>
>  .../perf/arch/powerpc/annotate/instructions.c | 66 +++++++++++++++++++
>  tools/perf/arch/powerpc/util/dwarf-regs.c     | 29 ++++++++
>  tools/perf/util/annotate.c                    |  5 ++
>  3 files changed, 100 insertions(+)
>
> --
> 2.43.0
>
