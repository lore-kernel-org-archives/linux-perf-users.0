Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB6286D55
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674039; cv=none; b=hQcWtcfBGMGPjojEYAg9S888za7WdgihYn+8shhsYgjM/y7gDeWAKG6Up6pfVlf6FWyfL40CSjGIKST97ofazbABSeNY3AeKKXV85CvPAujkhE06ciw/l4KFA0ptyBaMX+xsiOJq/4R83jieDdWkp3iV4cGQvDBHoZDxK6hswzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674039; c=relaxed/simple;
	bh=omr3wYR5ZM4vFufKGEQv0vBxziCZIckw9Wtf6hFiQZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1ylSMkUv+PZmM0ZHjLcdU+JG1kddanhskQ4YH2xBpVbtVaaesP7vUXr/Gi1VzHufxjvfxg4oS7ljZDXt6WE2G7JVk8ztUee25HXuipXQY5QuX4sbRmh6BJoziGhuCsQidHPFfXBlPTqmuCkZHh8NeWeVPxmrNo1wKcpMEPrMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bfMlXyLR; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfMlXyLR"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so467245ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747674037; x=1748278837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G99iNQ0HCfc2DgSrnrzIo8CNcnrGRVjxOQhxJIG7B9Q=;
        b=bfMlXyLRIWkZxhajtQDxprrIQXJ6guHhLQDWTZxePyJug0EmbzzGYvVJQjZUxaqF6u
         PB8mRjvYKOu9ggi+OL5PNeyVcWohNRobqGxMhnEsyIz8M0NGZOKV01KwTE4AHYWIEdDO
         UpsvJSSIsyGeC2w5SYijjb4td4TQmyyEd5LTyzkIyIXlt3xY4PkMhKwFzINB08NjqsX+
         gz24/brWgjA7Z8bGvr9TamoqshVnZ8GsjhGT27KFommGrxQKLur7Xwz/bwjlrj3IkAAi
         vakCY88f+J5RWijOPc+lxjl63yTMUi9ujbhYn6TL3N+iic/OB81vyoHluixHDw/5VFzC
         m3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674037; x=1748278837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G99iNQ0HCfc2DgSrnrzIo8CNcnrGRVjxOQhxJIG7B9Q=;
        b=knyt16P9INKA/ve8FVu8YgHhR9hKICCoteoAJam56ZlJm9Z7nBAjqdZNDgIE3MTii2
         IwGReRQuGatoPDMGjfkSCLncnZJmxdp+FVyXWyJai5L0wHZ31Q5s1In1LUE88K28lUuI
         7SrmJyC9FyqzODNi9qTdtsrsSPqQRmzKda4SeTkbilzjtogkogj3W4ZosW/kfzToxPCG
         oj6Gii5rlpB9EQ/snpUj7UXgMRnQNn8fDC1sVnD3OtdS+Hkn/JOeMhnkUW1aOpnRcuyK
         wOPFl5oHHTgGCF0j5AKpfXcEQS932odlsIud572ShXF3eUUa5U0oIytJ3uUYRspOXXgy
         B1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBCIkwvykg2opFxtiSIUI0eOC1Lwds05oMj/HOZ62+sN/4Fd07XluEWS+iU3Kb73riX1O96MWVI2h+EA+/O2V3@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIltkDc5Nsj+fU7f9tqPC8X0gCwihTCstKCKxJkjQyylG6tKR
	v9ewWVljBpCXgTeMRmJL5TJhRRxZ4SPO7pYtu58xK5UEYWPbUOSGl2alpSXgRM6mIvd7b9h6pDy
	eCwKYQEld04YLOKXL3mEA2wfgxm5wwio04+ma+uBS
X-Gm-Gg: ASbGnctxAq+Q7wcgxnIxrpqgMgzrkfocrS3umcjMlqXwsC0vq0KzyiIcqHnvku5itnT
	UZry2ZLNT970DfO1yJ32AdQeF2/gMEy/sS74MIkbl7RQgz3Oxclq+0rCxLIPeAtgrkva7P1zWcO
	d6tO9J272nrEaZRvynFFsbhTQ7rdPOT+ZghmAayII1euhUboP5V0NZgsz152LfVg==
X-Google-Smtp-Source: AGHT+IHmjIcIcW/A2mqSe82tbuCso2SQ0qGRvJ5nONQuPEDFkBrx3yBcs/t5ZmN5ehldBwq2FRf20sAck2RWJhtGLnk=
X-Received: by 2002:a05:6e02:1888:b0:3db:6f8b:3191 with SMTP id
 e9e14a558f8ab-3dc5e5c7538mr6772805ab.5.1747674036885; Mon, 19 May 2025
 10:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518190957.58932-1-howardchu95@gmail.com> <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
 <CAH0uvog3kt=QR1T6uXMBmecDWsh-8UWKXukJ-rRk3in7fud4Eg@mail.gmail.com>
In-Reply-To: <CAH0uvog3kt=QR1T6uXMBmecDWsh-8UWKXukJ-rRk3in7fud4Eg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 May 2025 10:00:25 -0700
X-Gm-Features: AX0GCFusDLkWeT5qa-H2pFGyYPY41UrYzTsWOd209LakY8HHelr8zIfxWKy9N_I
Message-ID: <CAP-5=fU_UUKmu0gTmODXCG5JUK6MRFOTFU+LCJTfA5yTP+aomA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:01=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Ian,
>
> I jumped to a conclusion, there are reasons other than running tests
> in parallel.
>
> On Sun, May 18, 2025 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sun, May 18, 2025 at 12:10=E2=80=AFPM Howard Chu <howardchu95@gmail.=
com> wrote:
> > >
> > > Currently, BTF tests fail constantly, this series fixes two major rea=
sons
> > > why they fail, and makes the error messages acquired when using '-vv'
> > > more verbose, so when they fail, one can easily diagnose the problem.
> > >
> > > Before:
> > >     $ sudo /tmp/perf test enum -vv
> > >     107: perf trace enum augmentation tests:
> > >     107: perf trace enum augmentation tests                          =
    : Running
> > >     --- start ---
> > >     test child forked, pid 783533
> > >     Checking if vmlinux exists
> > >     Tracing syscall landlock_add_rule
> > >     Tracing non-syscall tracepoint syscall
> > >     ---- end(-1) ----
> > >     107: perf trace enum augmentation tests                          =
    : FAILED!
> > >
> > > After:
> > >     $ sudo /tmp/perf test enum -vv
> > >     107: perf trace enum augmentation tests:
> > >     107: perf trace enum augmentation tests                          =
    : Running
> > >     --- start ---
> > >     test child forked, pid 851658
> > >     Checking if vmlinux exists
> > >     Tracing syscall landlock_add_rule
> > >     Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_=
start
> > >     [tracepoint failure] Failed to trace tracepoint timer:hrtimer_set=
up,timer:hrtimer_start, output:
> > >     event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
> > >                          \___ unknown tracepoint
> > >
> > >     Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not =
found.
> > >     Hint:   Perhaps this kernel misses some CONFIG_ setting to enable=
 this feature?.
> > >
> > >     Run 'perf list' for a list of valid events
> > >
> > >      Usage: perf trace [<options>] [<command>]
> > >         or: perf trace [<options>] -- <command> [<options>]
> > >         or: perf trace record [<options>] [<command>]
> > >         or: perf trace record [<options>] -- <command> [<options>]
> > >
> > >         -e, --event <event>   event/syscall selector. use 'perf list'=
 to list available events---- end(-1) ----
> > >     107: perf trace enum augmentation tests                          =
    : FAILED!
> > >
> > > Changes in v2:
> > > - Add an extra newline after error messages
> > > - Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
> > > - Take the debug diff for explanation out of patch 5 to make it apply
> > >   normally
> > > - Add base-commit in this cover letter
> >
> > Thanks Howard! I did some testing but see failures that may be
> > pre-existing issues:
> >
> > ```
> > --- start ---
> > test child forked, pid 264236
> > Checking if vmlinux exists
> > Tracing syscall landlock_add_rule
> > [syscall failure] Failed to trace syscall landlock_add_rule, output:
> >
>
> I think this doesn't have any output, a sign of failure of collection
> on the BPF side.
>
> > ---- end(-1) ----
> > 107: perf trace enum augmentation tests                              : =
FAILED!
> > --- start ---
> > test child forked, pid 264248
> > Checking if vmlinux BTF exists
> > Testing perf trace's string augmentation
> > String augmentation test failed, output:
> >
>
> Here too.
>
> > ---- end(-1) ----
> > --- start ---
> > test child forked, pid 278774
> > Checking if vmlinux exists
> > Tracing syscall landlock_add_rule
> > [syscall failure] Failed to trace syscall landlock_add_rule, output:
> >      0.000 (         ): perf/278843 landlock_add_rule(ruleset_fd: 11,
> > rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffdcf1dad90,
> > flags: 45) ...
>
> This is strange to me. No return value, no elapsed time. Judging from
> experience this comes from the lack of the second sys_exit event that
> sets both of them.
>
> > ---- end(-1) ----
> > 107: perf trace enum augmentation tests                              : =
FAILED!
> > --- start ---
> > test child forked, pid 279196
> > Checking if vmlinux exists
> > Tracing syscall landlock_add_rule
> > [syscall failure] Failed to trace syscall landlock_add_rule, output:
> >      0.000 (         ): perf/279262 landlock_add_rule(ruleset_fd: 11,
> > rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7fff37a70fd0,
> > flags: 45) ...
>
> Ditto.
>
> > ---- end(-1) ----
> > 107: perf trace enum augmentation tests                              : =
FAILED!
> > 108: perf trace BTF general tests                                    : =
FAILED!
> > --- start ---
> > test child forked, pid 278187
> > Checking if vmlinux BTF exists
> > Testing perf trace's string augmentation
> > Testing perf trace's buffer augmentation
> > Testing perf trace's struct augmentation
> > BTF struct augmentation test failed, output:
> > sleep/278352 clock_nanosleep(0, 0, {1,1,}, 0x7ffd31550f50) =3D 0
>
> This is the difference in libbpf's btf_dump's behavior. I grepped
> "grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\},
> 0x[0-9a-f]+\) +=3D +[0-9]+$"", the {1, 1,} didn't match. On my machine
> it is '{1,}'
> ~~~
> sudo /tmp/perf trace --sort-events -e clock_nanosleep --force-btf
> --max-events=3D1 -- sleep 1
> sleep/338371 clock_nanosleep(0, 0, {1,}, 0x7ffeb4e9dd10) =3D 0
> ~~~
>
> Which is strange, I thought we used the same libbpf from the kernel
> tree and statically link it. Why is it different on our machines?
> FWIW, I do have libbpf installed on my system, from their github
> repo's main branch.
> ~~~
> $ cat /usr/include/bpf/libbpf_version.h
> /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> /* Copyright (C) 2021 Facebook */
> #ifndef __LIBBPF_VERSION_H
> #define __LIBBPF_VERSION_H
>
> #define LIBBPF_MAJOR_VERSION 1
> #define LIBBPF_MINOR_VERSION 6
>
> #endif /* __LIBBPF_VERSION_H */
> ~~~
>
> But I thought we used the same 1.6.x version from the tree...
> ~~~
> $ cat tools/lib/bpf/libbpf_version.h
> /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> /* Copyright (C) 2021 Facebook */
> #ifndef __LIBBPF_VERSION_H
> #define __LIBBPF_VERSION_H
>
> #define LIBBPF_MAJOR_VERSION 1
> #define LIBBPF_MINOR_VERSION 6
>
> #endif /* __LIBBPF_VERSION_H */
> ~~~
>
> > ---- end(-1) ----
> > 108: perf trace BTF general tests                                    : =
FAILED!
> > --- start ---
> > test child forked, pid 278775
> > Checking if vmlinux BTF exists
> > Testing perf trace's string augmentation
> > Testing perf trace's buffer augmentation
> > Buffer augmentation test failed, output:
> > buffer content
>
> This should have two lines of output, the second line is missing,
> something to do with the BPF collection I mentioned above.
> ~~~
> $ sudo /tmp/perf/perf trace --sort-events -e write --force-btf
> --max-events=3D1 -- echo "buffer content"
> buffer content
> echo/393319 write(1, buffer content\10, 15) =3D 15
> ~~~
>
> > ---- end(-1) ----
> > 108: perf trace BTF general tests                                    : =
FAILED!
> > --- start ---
> > test child forked, pid 279547
> > Checking if vmlinux BTF exists
> > Testing perf trace's string augmentation
> > Testing perf trace's buffer augmentation
> > Testing perf trace's struct augmentation
> > BTF struct augmentation test failed, output:
> > sleep/279619 clock_nanosleep(0, 0, {1,1,}, 0x7ffcd47b6450) =3D 0
>
> Same '{1,1,}' appears.
>
> > ---- end(-1) ----
> > 108: perf trace BTF general tests                                    : =
FAILED!
> > --- start ---
> > test child forked, pid 264252
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.333 MB /tmp/temporary_file.pl459 ]
> > Failed: cannot find *nanosleep syscall
>
> This test was written by Namhyung, again it failed to collect some sample=
s.
>
> > ---- end(-1) ----
> > 110: perf trace record and replay                                    : =
FAILED!
> > --- start ---
> > test child forked, pid 278193
> > testing: perf trace -s -- true
> > Error: cannot find enough pattern ^\s*(open|read|close).*[0-9]+%$ in th=
e output
>
> May also be a loss of samples.
>
> There are some problems. From the output you provided, I can see the
> obvious sample loss in perf trace, and the differing behavior in
> libbpf's btf_dump. Fixing them.

Massively appreciated! I was running the tests with `perf test -v
"perf trace"` so there was parallelism. Running the tests with your
changes and with "-S" for sequential I still reliably see:
```
--- start ---
test child forked, pid 279547
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Testing perf trace's struct augmentation
BTF struct augmentation test failed, output:
sleep/279619 clock_nanosleep(0, 0, {1,1,}, 0x7ffcd47b6450) =3D 0
---- end(-1) ----
108: perf trace BTF general tests                                    : FAIL=
ED!
```
but the other problems appear to go away.

Thanks,
Ian

> Thanks,
> Howard
