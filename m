Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C7BE4E;
	Thu, 14 Nov 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616477; cv=none; b=pxvYOAMf/yFOKXYhnox2vNFFeqLyS3QItIl3Prki7KqbmY6l7BJPCFeHfvgjR6H7BgzTNVaRsU8Rqcl8mCOwyHMsyNY8pne05SezkHcNKkkRuYZoEoRfpOxeicTJlTbSIugEPLMUn65kvJRISaE0hhblRa5pcRbVYfxBWdE7/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616477; c=relaxed/simple;
	bh=uRDTDHZtoJInR4Fa8SRU+Ox5PSi7vdJRf8I7zs/CUss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuY63xafYJm6ZEjzVWpgGyb+yixdp0nUvoItqj/fihmNBp0xTv/iM3pw/HIwMBXpgzQKXQs68qWfceVZgWI++/qvzdfkMnZziR+nrKJ6gUXG7aLURLue3KYP9ROCtSzSMPmxuea3Z1wwU7xtln3SjFuQqXnM6gF6IHvu1PlR57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFdWGqiB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFdWGqiB"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea5f68e17aso13535957b3.3;
        Thu, 14 Nov 2024 12:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731616475; x=1732221275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqN9PB0CAhc+Mei+nRyz+CxD1TaQWjBmQDfatTrJIx4=;
        b=WFdWGqiBxUfaHsNIkViWXMJQ6AtgjxVdEUx2/JTlmVjHc6Akv+/LCSoNVKySbwYOPb
         r7KBmOV4pZE+dCrZ2hn/TdeMV97WZDsR0d5Uh2La9I3AxzCvqENQANM5ulAYURLHxsa3
         Vmv4gWsKBd4Qm3hBlgLvBzb+v2NVWgZyn21dGhByVTFWbFs3L7kVEsGmsOfgyjyIVHuO
         r9q9h03ymOp9ZYOh9z5Vaj5Nl1HiOAGQcYqfakNAmOToEQbrdtdQNnFm1s0YCO+4pU3N
         /ag9AlRQQfdQVSfrSTEyNuzYMJoyB6ablQYUwWbtvvkMfhMdah5fT3jW4hbnsZlJmQUX
         2WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731616475; x=1732221275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqN9PB0CAhc+Mei+nRyz+CxD1TaQWjBmQDfatTrJIx4=;
        b=LmYjmbeyGOD4sPMA1CHC0SNO8J9evvPxJKdPeWMoU1Bx8GO0hcTLH/pzSeADa9djNx
         i/UG+a+Mp9Yv58Lh8XpU9nTBBxCS71FpYnRHIDt3u3suCB+7ZFHu1g7HVu05HuiV1pmq
         2VP/37hk6qyLzgCHVnFyBqfWvCkuL4NCWCTCyNRjXz+ARngeJDpFpXl2YJjwlES+uwWC
         A69K34epO2rm307IBfSl5zXSIUauzJRGHk4qqIdrXmnuc8t3XAjeFhC71rp3XvEK8nM4
         2ku3BMtG3XO4ppt4GL62TuOZYR0iPR7b/CSgz6wz+KhETMnfwyDrKu/Epn/zrLyLJ6kq
         302g==
X-Forwarded-Encrypted: i=1; AJvYcCVij4o8gX0zsO59UTFYDu2JrDgr3G6os00kFmPYiRULf7XsBkHPLhRaUwomCDa8p1kjH1iFxbxDEL6VyIY=@vger.kernel.org, AJvYcCWJISWor3A9BuMROLBX6IX6Zm9+r0ZFXijN05CKGyjRl6awuPqX/qTlbpgdh8A5+vFFFthkXrz/cMi6xgJsKD19PA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1H31qH3YN4c69DoNHcAp/ptbqzXJyELGJRuyVNkt8yjVY8Aor
	O6JUcridvcDZjjYULwXLzZRCa/J39k1BIkGSfkFszPH8yDg37fy04RQwBZLv5AjsFT2dzXODXEH
	E/rS09aYJE1h2bQQxwbE08U9Kyf4=
X-Google-Smtp-Source: AGHT+IEsc3nn6kxSIyxcqc0eBxQ134nhitPWXlu7lmMUJkUoOWyndANqA9XGkYR1qTeMaYIDk9YIDO/K6MASt7Q1ua0=
X-Received: by 2002:a05:690c:6f87:b0:6e3:32e2:ecbf with SMTP id
 00721157ae682-6ee55a7813dmr4522937b3.24.1731616474667; Thu, 14 Nov 2024
 12:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030052431.2220130-1-howardchu95@gmail.com>
 <ZzOLU-9QkwGHsb3w@x1> <ZzY57jorg1wScxq5@x1> <ZzZXnC9wdyFfihVn@x1>
In-Reply-To: <ZzZXnC9wdyFfihVn@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 14 Nov 2024 12:34:24 -0800
Message-ID: <CAH0uvojdUT=OTBBZje--AJRd8gyHASqno5+Mhw2+_xMjvwqYPA@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix perf trace tracing itself, creating
 feedback loops
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 14, 2024 at 12:03=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 14, 2024 at 02:57:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 12, 2024 at 02:07:36PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Tue, Oct 29, 2024 at 10:24:31PM -0700, Howard Chu wrote:
> > > > There exists a pids_filtered map in augmented_raw_syscalls.bpf.c th=
at
> > > > ceases to provide functionality after the BPF skeleton migration:
> > > > commit 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a=
 skeleton")
> > >
> > > Thanks, applied to perf-tools-next,
> >
> > There is a problem with this patch, I'm investigating it now:
> >
> > root@number:~# perf trace -e syscalls:sys_enter_exit_group true
> > perf: Segmentation fault
> > Obtained 12 stack frames.
> > perf() [0x6229a1]
> > perf() [0x622a8b]
> > /lib64/libc.so.6(+0x40d00) [0x7f704364fd00]
> > perf() [0x4b5f2e]
> > perf() [0x4ba3e6]
> > perf() [0x4c03bc]
> > perf() [0x4c0663]
> > perf() [0x4c07bc]
> > perf() [0x4c0b05]
> > /lib64/libc.so.6(+0x2a088) [0x7f7043639088]
> > /lib64/libc.so.6(__libc_start_main+0x8b) [0x7f704363914b]
> > perf() [0x412265]
> > Segmentation fault (core dumped)
> > root@number:~#
> >
> > (gdb) run trace -e syscalls:sys_enter_exit_group true
> > Starting program: /root/bin/perf trace -e syscalls:sys_enter_exit_group=
 true
> >
> > This GDB supports auto-downloading debuginfo from the following URLs:
> >   <https://debuginfod.fedoraproject.org/>
> > Enable debuginfod for this session? (y or [n]) y
> > Debuginfod has been enabled.
> > To make this setting permanent, add 'set debuginfod enabled on' to .gdb=
init.
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> > [Detaching after fork from child process 1965197]
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > trace__run (trace=3D0x7fffffffa5e0, argc=3D1, argv=3D0x7fffffffde90) at=
 builtin-trace.c:4330
> > 4330          trace->filter_pids.map =3D trace->skel->maps.pids_filtere=
d;
> > (gdb) bt
> > #0  trace__run (trace=3D0x7fffffffa5e0, argc=3D1, argv=3D0x7fffffffde90=
) at builtin-trace.c:4330
> > #1  0x00000000004ba3e6 in cmd_trace (argc=3D1, argv=3D0x7fffffffde90) a=
t builtin-trace.c:5490
> > #2  0x00000000004c03bc in run_builtin (p=3D0xec4068 <commands+648>, arg=
c=3D4, argv=3D0x7fffffffde90) at perf.c:351
> > #3  0x00000000004c0663 in handle_internal_command (argc=3D4, argv=3D0x7=
fffffffde90) at perf.c:404
> > #4  0x00000000004c07bc in run_argv (argcp=3D0x7fffffffdc7c, argv=3D0x7f=
ffffffdc70) at perf.c:448
> > #5  0x00000000004c0b05 in main (argc=3D4, argv=3D0x7fffffffde90) at per=
f.c:560
> > (gdb) p trace->skel
> > $1 =3D (struct augmented_raw_syscalls_bpf *) 0x0
> > (gdb)
> >
> > I.e. when we specify a syscall event tracepoint, we expect to use
> > augmentation, but are not setting it up.
>
> We can't assume that trace->skel will be always set, as it is only
> initialized if trace->trace_syscalls is set, so I added this patch on
> top of yours:

Yeah, using syscall tracepoints won't load the BPF skeleton.

perf $ ./perf trace -e syscalls:sys_enter_exit_group
     0.000 dirname/3732242 syscalls:sys_enter_exit_group()
     0.268 bash/3732241 syscalls:sys_enter_exit_group()
     3.951 :3732246/3732246 syscalls:sys_enter_exit_group()
     4.756 tr/3732247 syscalls:sys_enter_exit_group()
     4.945 :3732245/3732245 syscalls:sys_enter_exit_group()
     5.235 bash/3732244 syscalls:sys_enter_exit_group()
     7.975 tmux/3732249 syscalls:sys_enter_exit_group()
     9.160 :3732252/3732252 syscalls:sys_enter_exit_group()
    10.062 tr/3732253 syscalls:sys_enter_exit_group()
    10.308 :3732251/3732251 syscalls:sys_enter_exit_group()
    10.619 bash/3732250 syscalls:sys_enter_exit_group()
    10.853 bash/3732248 syscalls:sys_enter_exit_group()
    11.143 bash/3732243 syscalls:sys_enter_exit_group()
    15.379 tmux: client/3732255 syscalls:sys_enter_exit_group()
    15.985 sh/3732254 syscalls:sys_enter_exit_group()
    20.111 tmux: client/3732257 syscalls:sys_enter_exit_group()
    20.697 sh/3732256 syscalls:sys_enter_exit_group()
    24.849 tmux: client/3732259 syscalls:sys_enter_exit_group()
    25.461 sh/3732258 syscalls:sys_enter_exit_group()
    27.087 date/3732261 syscalls:sys_enter_exit_group()
    27.333 sh/3732260 syscalls:sys_enter_exit_group()
    27.596 sh/3732240 syscalls:sys_enter_exit_group()
    27.850 tmux: server/3732239 syscalls:sys_enter_exit_group()
^Cperf $

>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0f8678142fbfdbcb..14794725669d49ee 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4327,7 +4327,8 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>                 }
>         }
>
> -       trace->filter_pids.map =3D trace->skel->maps.pids_filtered;
> +       if (trace->skel)
> +               trace->filter_pids.map =3D trace->skel->maps.pids_filtere=
d;

LGTM.

>  #endif
>         err =3D trace__set_filter_pids(trace);
>         if (err < 0)

Tested-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
