Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08CE7640E;
	Sat, 29 Nov 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764443243; cv=none; b=gh3eBnrAN7HL5AO262qI1tNLcm9PdeihW0gZ+aSDafNNABYpnurr32+gC0GNWgiyHuFpAyznog2w271LxophTpDW70adO9CnWyEHdRd63Ii6AHNmrXQ/LGPMKINDSZNgyUlskIlsvv/xMBj+u3zOmPFjwsZpulXYDxsGU28l4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764443243; c=relaxed/simple;
	bh=Zkw51WqaNjqA1kvB4VKBpElPxu2esZazCU8ql+Q+Tuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7y4ZDORBtvNYuvvFWhm5rREI6QguUNNP52R0Dhmbe9pr2+KMhwiiJdd72V/KGdqnTlahy7m714r+v2hyIeZbgQnb9Zt0OvuY4hTVzRubHchSv/wfxS4FDrTL7lk2efpzPbRG9LBMynFjPn9oKK9X7GrqL25fOOB7vccMsG+rmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4xQA9NS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4xQA9NS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E093C4CEF7;
	Sat, 29 Nov 2025 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764443242;
	bh=Zkw51WqaNjqA1kvB4VKBpElPxu2esZazCU8ql+Q+Tuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4xQA9NSHQnu46gZ0Dk0L4/B9XOQq/k9lt0PXl2utoC6BGQX0rT+nCxJqVBp0MfDw
	 U0We3HFclDclUdJd7rBhJkaBCaKROmb1SdMdm5MxeJPc2+/PxdxjzLk7+eXn76E7jt
	 IXqb4WQivPyJETVk3xUJxrA0Hg9ha6ZleAEfiKO7R8rtAtAEiQAxKpV0NxnV0LJO3y
	 XEuoOzmXqr7G178UTNtiPPDqLxXGklQ5MRml3LGYyDXvrGCNvfdSbggXkrO1UY4P0r
	 qvdmwovKOojZsRQb51XLo8UkMzDb9TnAmZBa9MuYruOdo2spTjBmlwXgF0+0IApnYb
	 YurEOCQLsG5Xw==
Date: Sat, 29 Nov 2025 11:07:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
Message-ID: <aStEaM9tcGlRclQ4@google.com>
References: <20251127044418.677379-1-namhyung@kernel.org>
 <20251127203052.12a6a163@robin>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127203052.12a6a163@robin>

On Thu, Nov 27, 2025 at 08:30:52PM -0500, Steven Rostedt wrote:
> On Wed, 26 Nov 2025 20:44:18 -0800
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Recent changes in the linux-next kernel will add new field for syscalls
> > to have contents in the userspace like below.
> > 
> >   # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
> >   name: sys_enter_write
> >   ID: 758
> >   format:
> >           field:unsigned short common_type;       offset:0;       size:2; signed:0;
> >           field:unsigned char common_flags;       offset:2;       size:1; signed:0;
> >           field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
> >           field:int common_pid;   offset:4;       size:4; signed:1;
> > 
> >           field:int __syscall_nr; offset:8;       size:4; signed:1;
> >           field:unsigned int fd;  offset:16;      size:8; signed:0;
> >           field:const char * buf; offset:24;      size:8; signed:0;
> >           field:size_t count;     offset:32;      size:8; signed:0;
> >           field:__data_loc char[] __buf_val;      offset:40;      size:4; signed:0;
> > 
> >   print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsigned long)(REC->fd)),
> >              ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_val, 1),
> >              ((unsigned long)(REC->count))
> > 
> > We have a different way to handle those arguments and this change
> > confuses perf trace then make some tests failing.  Fix it by skipping
> > the new fields that have "__data_loc char[]" type.
> > 
> > Maybe we can switch to this instead of the BPF augmentation later.
> > 
> 
> Even with this patch applied, I still have a segfault with this command:
> 
> # ./perf trace -e syscalls:sys_enter_write 

What about this?

  # ./perf trace -e write

Thanks,
Namhyung


>      0.000 sshd-session/5421 syscalls:sys_enter_write(perf: Segmentation fault
>     #0 0x560ea815187a in dump_stack debug.c:366
>     #1 0x560ea81518f0 in sighandler_dump_stack debug.c:378
>     #2 0x7fb5e14d1df0 in __restore_rt libc_sigaction.c:0
>     #3 0x560ea7fc0cec in syscall_arg__scnprintf_buf builtin-trace.c:1857
>     #4 0x560ea7fc2692 in syscall_arg_fmt__scnprintf_val builtin-trace.c:2398
>     #5 0x560ea7fc2aad in syscall__scnprintf_args builtin-trace.c:2476
>     #6 0x560ea7fc3ea2 in trace__fprintf_sys_enter builtin-trace.c:2885
>     #7 0x560ea7fc57a5 in trace__event_handler builtin-trace.c:3312
>     #8 0x560ea7fc68dd in trace__handle_event builtin-trace.c:3649
>     #9 0x560ea7fc7f7a in __trace__deliver_event builtin-trace.c:4183
>     #10 0x560ea7fc80cc in trace__deliver_event builtin-trace.c:4209
>     #11 0x560ea7fc92b7 in trace__run builtin-trace.c:4577
>     #12 0x560ea7fcd648 in cmd_trace builtin-trace.c:5773
>     #13 0x560ea7fd35e3 in run_builtin perf.c:349
>     #14 0x560ea7fd387b in handle_internal_command perf.c:401
>     #15 0x560ea7fd39d4 in run_argv perf.c:448
>     #16 0x560ea7fd3d1d in main perf.c:555
>     #17 0x7fb5e14bbca8 in __libc_start_call_main libc_start_call_main.h:74
>     #18 0x7fb5e14bbd65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>     #19 0x560ea7f25f41 in _start perf[53f41]
> Segmentation fault
> 
> This doesn't crash in a kernel without the __data_loc.
> 
> -- Steve
