Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3023F41A;
	Fri, 28 Nov 2025 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294058; cv=none; b=fI9dnCnvkXBe43o/g6u1Bu71voE6of2gjMcSLgQ6OtMVMROBoHe884hrekGswf3VPbXxb7fUcqY35yP1O+TTkxzJyQLKpQOH32Wt5+lHmGqRQZj4fPhG9OXDT6Nu0+YIRsNdNfZlQJTRt91EWnpU825FNZkU5k/saFO+gXcyXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294058; c=relaxed/simple;
	bh=B0snoIO4DIssM/3MluaTUDWIzFLs+WlIXq1i3K5fwP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGqbF7le6CPnIxCTmI4qpAD5SrWIralwTKQ0WpWwXiberAlDNLa/o9mcbjhdEMtmHLzjyYWM9oZ4pnQa1ywUEoGuD06ZdmKAaGODxa9NouyscvEiFbxszHY044W6LGzTOevvcHmItghW8NnyaVXN4DBi5FISER/1mEV8j8FYdgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 28B6513A8DA;
	Fri, 28 Nov 2025 01:30:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 82F8B6000F;
	Fri, 28 Nov 2025 01:30:54 +0000 (UTC)
Date: Thu, 27 Nov 2025 20:30:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, James Clark <james.clark@linaro.org>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Thomas
 Richter <tmricht@linux.ibm.com>, Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
Message-ID: <20251127203052.12a6a163@robin>
In-Reply-To: <20251127044418.677379-1-namhyung@kernel.org>
References: <20251127044418.677379-1-namhyung@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 82F8B6000F
X-Stat-Signature: ef4kd6ngckcbhygzz63uzh686kxk3z89
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX180BQlLGKo4bV2wPAA1VN+seUAypEy5ukY=
X-HE-Tag: 1764293454-796527
X-HE-Meta: U2FsdGVkX1+DlQXYtASB+EjZTRtGn4NEvOL0JFzEJmnEewNe0stY/VoLI7odMDHwS+JchfhVsbi23/z28y1mmNq/LCXC4khvp+za18CAvHk0WmmXaHk8vjVQgkWRl2gdizafLuiw8B89m5H3Cxdvg21+mp3bv0EEFyqmCheUt86JG0/S4ZDEqR3O1kKAAA5pkweJ2/iYhF6cAE/AowqaDOosIrJXLKURENknVDo5KSVK6Zke9Pv3rgNnIk2qvwwDnCdrAulAhWUtbzTzNWTes8/7XQ70lXXHP5100yqsK6KYk4RYV6L48DTujaA0sf/ZKU1boR0tojBXOSBaulFvhq7VxXYRr8Mf

On Wed, 26 Nov 2025 20:44:18 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> Recent changes in the linux-next kernel will add new field for syscalls
> to have contents in the userspace like below.
> 
>   # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
>   name: sys_enter_write
>   ID: 758
>   format:
>           field:unsigned short common_type;       offset:0;       size:2; signed:0;
>           field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>           field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>           field:int common_pid;   offset:4;       size:4; signed:1;
> 
>           field:int __syscall_nr; offset:8;       size:4; signed:1;
>           field:unsigned int fd;  offset:16;      size:8; signed:0;
>           field:const char * buf; offset:24;      size:8; signed:0;
>           field:size_t count;     offset:32;      size:8; signed:0;
>           field:__data_loc char[] __buf_val;      offset:40;      size:4; signed:0;
> 
>   print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsigned long)(REC->fd)),
>              ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_val, 1),
>              ((unsigned long)(REC->count))
> 
> We have a different way to handle those arguments and this change
> confuses perf trace then make some tests failing.  Fix it by skipping
> the new fields that have "__data_loc char[]" type.
> 
> Maybe we can switch to this instead of the BPF augmentation later.
> 

Even with this patch applied, I still have a segfault with this command:

# ./perf trace -e syscalls:sys_enter_write 
     0.000 sshd-session/5421 syscalls:sys_enter_write(perf: Segmentation fault
    #0 0x560ea815187a in dump_stack debug.c:366
    #1 0x560ea81518f0 in sighandler_dump_stack debug.c:378
    #2 0x7fb5e14d1df0 in __restore_rt libc_sigaction.c:0
    #3 0x560ea7fc0cec in syscall_arg__scnprintf_buf builtin-trace.c:1857
    #4 0x560ea7fc2692 in syscall_arg_fmt__scnprintf_val builtin-trace.c:2398
    #5 0x560ea7fc2aad in syscall__scnprintf_args builtin-trace.c:2476
    #6 0x560ea7fc3ea2 in trace__fprintf_sys_enter builtin-trace.c:2885
    #7 0x560ea7fc57a5 in trace__event_handler builtin-trace.c:3312
    #8 0x560ea7fc68dd in trace__handle_event builtin-trace.c:3649
    #9 0x560ea7fc7f7a in __trace__deliver_event builtin-trace.c:4183
    #10 0x560ea7fc80cc in trace__deliver_event builtin-trace.c:4209
    #11 0x560ea7fc92b7 in trace__run builtin-trace.c:4577
    #12 0x560ea7fcd648 in cmd_trace builtin-trace.c:5773
    #13 0x560ea7fd35e3 in run_builtin perf.c:349
    #14 0x560ea7fd387b in handle_internal_command perf.c:401
    #15 0x560ea7fd39d4 in run_argv perf.c:448
    #16 0x560ea7fd3d1d in main perf.c:555
    #17 0x7fb5e14bbca8 in __libc_start_call_main libc_start_call_main.h:74
    #18 0x7fb5e14bbd65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #19 0x560ea7f25f41 in _start perf[53f41]
Segmentation fault

This doesn't crash in a kernel without the __data_loc.

-- Steve
