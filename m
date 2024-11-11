Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D0146D55;
	Mon, 11 Nov 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312353; cv=none; b=FYkhPZr1GV5BBBraqwvZ99aHBtrFVg9ntVl6CAbEX1Ab7NcQpPZ3dvqTJ8JKQKK80XEiSj8ZfCkB4PtLc1hq3w+RNIjBcXJibWVgKINmS56n8WXDbH29k3N98HbeVE1ORFT2d4Jb8CmfhrC7apk4jPViB6qImn91LnXI6xUc5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312353; c=relaxed/simple;
	bh=NUzT7qis3G2PMzqGOdQIvYboYyM3fBdfDclpzvRNjS8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sKGlHJzXz25tDmGITb/ZXbtmOELJHKZVWv8AgUHI3iRIkMr6YF2JUHjFoE6IpidROrqk9t6TYkfSmesDpZXkg+HS4vE7D70CSAAiQnZBg4SZ5MOGd/emGp5c/VkRiA693sOWb2ifISlXNq2rEXJHCUpxaCkKG+knfxc7ZM3jyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ+sluzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ+sluzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A0AC4CED0;
	Mon, 11 Nov 2024 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731312352;
	bh=NUzT7qis3G2PMzqGOdQIvYboYyM3fBdfDclpzvRNjS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cZ+sluzQxyskW6cslZczV85CeTtPovcFVA8N45KWOiCw/ELd+ZQ3dkhGWPgYbm24f
	 mOivdv8sHlFC6B9x3R+UcQcZZSgykjmko5c0yG98NCHpK/t5QSg1vC3X/XDu4hxVeq
	 gf6GjoLtl7xjQk5ZzIotgTiVgOXWaA7FVJiaGp0Bgb4rOK0O8egWtwzp+4vnHdo/EH
	 ISmlS2X7QRxEAXSyHmVNyFDvCR/Lep2DjD2kgcF2ctGp7acGzDQS1jgfmSkHeUNFB9
	 1Bp+U+Pe+ezIFQaGSM58Fx4IywWto7VX3B+QpuglJZpa1+jWCBmn/dq/IzYo7Vj/BS
	 Z+fbSvD6dXAuA==
Date: Mon, 11 Nov 2024 17:05:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <namhyung@kernel.org>, <mark.rutland@arm.com>,
 <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
 <irogers@google.com>, <adrian.hunter@intel.com>,
 <kan.liang@linux.intel.com>, <dima@secretsauce.net>,
 <aleksander.lobakin@intel.com>, <linux-perf-users@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf probe: Fix the incorrect line number display
 in 'perf probe -l'
Message-Id: <20241111170549.e4d1ba7b65aee3d890889277@kernel.org>
In-Reply-To: <20241108181909.3515716-2-lihuafei1@huawei.com>
References: <20241108181909.3515716-1-lihuafei1@huawei.com>
	<20241108181909.3515716-2-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Nov 2024 02:19:09 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> I found an issue with the line number display in perf probe -l:
> 
>   # perf probe -l
>     probe:schedule       (on schedule:-6751@kernel/sched/core.c)
> 
> I founded that in debuginfo__find_probe_point(), the fname obtained by
> cu_find_lineinfo() is different from the result returned by
> die_get_decl_file(). The 'baseline' and 'lineno' do not correspond to
> the same file, resulting in an incorrect calculation of the line number
> (lineno - baseline).

Good catch!

> 
> The DWARF dump information shows that the probed address
> 0xffff800080e55bc4 (i.e., schedule+20) has two source file information:
> 
>   # readelf --debug-dump=decodedline vmlinux | grep ffff800080e55bc4 -C 2
>   ./arch/arm64/include/asm/current.h:
>   current.h                                     19  0xffff800080e55bc0
>   current.h                                     21  0xffff800080e55bc4               x
>   current.h                                     21  0xffff800080e55bc4       1
> 
>   kernel/sched/core.c:
>   core.c                                      6777  0xffff800080e55bc4       2       x
>   core.c                                      6777  0xffff800080e55bc4       3       x
>   core.c                                      6777  0xffff800080e55bc4       4       x
>   core.c                                      6780  0xffff800080e55bc4       5       x
> 
> The first location corresponds to the inline function get_current(), and
> cu_find_lineinfo() should have found this entry. However, the probed
> instruction is actually in the schedule() function, which is
> disassembled as follows:
> 
>   crash> disassemble/s schedule
>   Dump of assembler code for function schedule:
>   ./arch/arm64/include/asm/current.h:
>   15      static __always_inline struct task_struct *get_current(void)
>   16      {
>   17              unsigned long sp_el0;
>   18
>   19              asm ("mrs %0, sp_el0" : "=r" (sp_el0));
>      0xffff800080e55bb0 <+0>:     paciasp
>   Dump of assembler code for function schedule:
>   ./arch/arm64/include/asm/current.h:
>   15      static __always_inline struct task_struct *get_current(void)
>   16      {
>   17              unsigned long sp_el0;
>   18
>   19              asm ("mrs %0, sp_el0" : "=r" (sp_el0));
>      0xffff800080e55bb0 <+0>:     paciasp
>      0xffff800080e55bb4 <+4>:     stp     x29, x30, [sp, #-32]!
>      0xffff800080e55bb8 <+8>:     mov     x29, sp
>      0xffff800080e55bbc <+12>:    stp     x19, x20, [sp, #16]
>      0xffff800080e55bc0 <+16>:    mrs     x19, sp_el0


It looks like get_current() is embedded at `0xffff800080e55bc0`, and

> 
>   kernel/sched/core.c:
>   6780            if (!task_is_running(tsk))
>      0xffff800080e55bc4 <+20>:    ldr     w0, [x19, #24]
>      0xffff800080e55bc8 <+24>:    cbnz    w0, 0xffff800080e55bf8 <schedule+72>

`0xffff800080e55bc4` is in schedule(). So line info looks strange.

> 
> And the DWARF function dump information:
> 
>   <1><11eae66>: Abbrev Number: 88 (DW_TAG_subprogram)
>      <11eae67>   DW_AT_external    : 1
>      <11eae67>   DW_AT_name        : (indirect string, offset: 0x233efb): schedule
>      <11eae6b>   DW_AT_decl_file   : 18
>      <11eae6c>   DW_AT_decl_line   : 6772
>      <11eae6e>   DW_AT_decl_column : 35
>      <11eae6f>   DW_AT_prototyped  : 1
>      <11eae6f>   DW_AT_low_pc      : 0xffff800080e55bb0
>      <11eae77>   DW_AT_high_pc     : 0xb8
>      <11eae7f>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
>      <11eae81>   DW_AT_GNU_all_call_sites: 1
>      <11eae81>   DW_AT_sibling     : <0x11eb12d>
>   <2><11eae85>: Abbrev Number: 50 (DW_TAG_variable)
>      <11eae86>   DW_AT_name        : tsk
>      <11eae8a>   DW_AT_decl_file   : 18
>      <11eae8b>   DW_AT_decl_line   : 6774
>      <11eae8d>   DW_AT_decl_column : 22
>      <11eae8e>   DW_AT_type        : <0x11b2b34>
>      <11eae92>   DW_AT_location    : 0x5be6f0 (location list)
>      <11eae96>   DW_AT_GNU_locviews: 0x5be6ec
>   <2><11eae9a>: Abbrev Number: 78 (DW_TAG_lexical_block)
>      <11eae9b>   DW_AT_low_pc      : 0xffff800080e55bc4
>      <11eaea3>   DW_AT_high_pc     : 0x0
>      <11eaeab>   DW_AT_sibling     : <0x11eaeb9>
> 
> Therefore, here we should use the result of die_find_realfunc() +
> die_get_decl_file(). However, regardless, we should verify if the fname
> obtained from both is the same.

I think this is a corner case, but to fix this issue, we have to
change the process pipeline instead of adding a check.

> If they are different, we should use the
> latter to avoid inconsistencies between lineno, fname, and basefunc.

I think filename comparison may not be enough because the inlined
function definition can be done in the same file.

<source.h>
20 static inline void foo()
21 {...}

<source.c>
1000 void bar()
1001 {
1002	foo();
	...

In this case, we can check whether the function names are different
("source.h" != "source.c"), but usually inlined function defined in
the same file.

<source.c>
50 static inline void foo()
51 {...}
...
1000 void bar()
1001 {
1002	foo();
	...

In this case, both has the same file name.

Currently debuginfo__find_probe_point() does

 (1) Get the line and file from CU's lineinfo
 (2) Get the real function(function instance) of the address
     (use this function's decl_line/decl_file as basement)
 (2-1) Search the inlined function scope in the real function
     for the given address.
 (2-2) if there is inlined function, update basement line/file.
 (2-3) verify the filename is same as basement filename.
 (3) calculate the relative line number from basement.

The problem is in (1). Since we have no basement file/line info,
we can not verify that the file/line info from CU's lineinfo.
As Li shown above, the lineinfo may have several different lines
for one address. We need to find most appropriate one based on
the basement file/line.

Thus what we need are

 - Introduce cu_find_lineinfo_at() which gives basement file/line
   information so that it can choose correct one. (hopefully)
 - Swap the order of (1) and (2*) so that we can pass the basement
   file/line when searching lineinfo. (Also, (2-3) should be right
   before (3))

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
