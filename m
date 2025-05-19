Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D421C8603;
	Mon, 19 May 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666884; cv=none; b=aW5//azH+VCEN398oXvzpojjnHEfuUWXmQBaHqbuF4Ju0td/HUE6NviqJYslQmXW2G6BRdBPIsadXBg9Q8tM4Pcf89PxnhSo9E5MslLjRkYs202loOsXOYrm+uLa2t1FFjVNZLhCAxZyL5Bgf+vhllplORTvDL1KhgqkYvbCno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666884; c=relaxed/simple;
	bh=zm4TrJpRFR6yDTlSW5Gxco8bMqo4caurhb3KmPiKRVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx0OiwwDGjvlwUxsb98dA6ELUV9DcFT0CbiBKd14pF8h9774CwmAfKNQQFrOFhQuFs/flCB8H7CxuVrgmg96AdHMrjAwPFeC3YRSu307sHbKex8e1h8kXeMvMLhXQAJ932dBnJ2smSIpgBg6g+xnzrX6mKiWnNIOf2uK85y6u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsaIYhKv; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsaIYhKv"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7c5d4709caso1023700276.1;
        Mon, 19 May 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747666881; x=1748271681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRb4XhZMBAOQbB7tZB9QA1WsfehPlP9dH/A+kuAvHmo=;
        b=HsaIYhKvi4+kOrZ75GUqwgnHLA+2tQ1eQDzWt+B14EXgDXaIJtTGJ2PLjKL7Ur+mnU
         jGz504N7tG+cjbob92U8cVW+oqaxY7gkU+M9Ga1WvYx7eLhWZKNlhLRsR7+JJPj0LZ6x
         gqo0MB0BzE0Tt0Mawlh0+bvitV3fuliYcNsA3hTJIkTy7f+msuxE+s14DrpLsqfeFtNi
         Jvq/ybPhi5AJJ5DYa4v1J5/Q35P5RkZ0dMlmzMinQiXSj/5APJwcS4JnmzPMnjCRzR/5
         Ey6WtbdxNdT/4FRlhua1oJz8OG0SPF67myLgTfrplefA6l82wBXFBuqhhU9zwxoc0BQs
         ckrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747666881; x=1748271681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRb4XhZMBAOQbB7tZB9QA1WsfehPlP9dH/A+kuAvHmo=;
        b=LGDYkzIiwa1y0kFLeSfh7yeXvEJkw0OABMOmILRSyACz0QC+QtsEAnq3FFiIb8SRb/
         TGryhMjVYFnUtyK5bvmw7/M1EwqFGaaSYLZ9reOhcTiN5R9wH4YqNdQOy7Ll80bKHsr7
         mXKo0dlDS/yZON701g3qJVaIJdby8mkUb+CdlXRReiBRL/wwnd+H8uBOCJFFd/sBa5yg
         RV6FDA4nj69QAlnTGJsxGbPWVL0h8JoDh86UGktIWSGZll9W463QJunXiEI9+9oZ1QF8
         yiaIb4brdXVu0f93TqHa3mea3OpxSqeW5GbK5u20JwK7v7UjvQb+10xopotyhQI0AvZZ
         6v8g==
X-Forwarded-Encrypted: i=1; AJvYcCVhXVJUpm7OscXDzWKmTi14CMfZrf2pAamSAtIldDWhs1l+hpRQo7Uu2Y+VUZAWbfaUfHgiH9ytfn3boI4=@vger.kernel.org, AJvYcCXSlR+fU/Mb3eP3lvuGWSYz0MpDBO3+ay5ZW+U/zVnWeH+g3AFeet86/OhIGVIBVTH/0r2ff+X7OmMwap0FxCuQJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMbmxdTLBkyus1WZhctQDXwIoqqx24fGJvkSOSpBiGv+FVDVV
	u6thv642PfZx6gpEbjy6Bedhkr8OZ3YcbNZ5ebffimUEHGxsfYksWk+0RLit/5VHzxyKI3wSiiJ
	1IHEQZXM0WaiSN7ILGmN+yfLMPvz31GI=
X-Gm-Gg: ASbGncujX2uylHzPvGx7+XZFWVARq3RQBVWwYmzaIRDVqDnBl1UeXVBpqYszFZs+tcV
	BZISB714yNfcBJVqWQp0+Ui5wSkrro94s4Nvdhm0xVGWhRZMqr36Gl9VC6F85gVRdOSLKxEB+2t
	lclNIjPPopQnhojrugZN8I0u55t0aQQo1igRFWh3OdiQ==
X-Google-Smtp-Source: AGHT+IEcq2bwl85yPze827Gxy1c1YoVKRDcb42Qx7C/EXEZt46Ixh9wq2+Q7ScWqn2QChLZwCLcW/3hyV+m139mn7EA=
X-Received: by 2002:a05:6902:228e:b0:e72:85a8:cd14 with SMTP id
 3f1490d57ef6-e7b6d55485fmr15818761276.34.1747666881119; Mon, 19 May 2025
 08:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518190957.58932-1-howardchu95@gmail.com> <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
In-Reply-To: <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 19 May 2025 08:01:10 -0700
X-Gm-Features: AX0GCFsOksR90zOFboBmVHNAfMqgv-_s-jAcFJIR6S3wX8BeOtLJk_y3xnRBrSM
Message-ID: <CAH0uvog3kt=QR1T6uXMBmecDWsh-8UWKXukJ-rRk3in7fud4Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

I jumped to a conclusion, there are reasons other than running tests
in parallel.

On Sun, May 18, 2025 at 3:18=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sun, May 18, 2025 at 12:10=E2=80=AFPM Howard Chu <howardchu95@gmail.co=
m> wrote:
> >
> > Currently, BTF tests fail constantly, this series fixes two major reaso=
ns
> > why they fail, and makes the error messages acquired when using '-vv'
> > more verbose, so when they fail, one can easily diagnose the problem.
> >
> > Before:
> >     $ sudo /tmp/perf test enum -vv
> >     107: perf trace enum augmentation tests:
> >     107: perf trace enum augmentation tests                            =
  : Running
> >     --- start ---
> >     test child forked, pid 783533
> >     Checking if vmlinux exists
> >     Tracing syscall landlock_add_rule
> >     Tracing non-syscall tracepoint syscall
> >     ---- end(-1) ----
> >     107: perf trace enum augmentation tests                            =
  : FAILED!
> >
> > After:
> >     $ sudo /tmp/perf test enum -vv
> >     107: perf trace enum augmentation tests:
> >     107: perf trace enum augmentation tests                            =
  : Running
> >     --- start ---
> >     test child forked, pid 851658
> >     Checking if vmlinux exists
> >     Tracing syscall landlock_add_rule
> >     Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_st=
art
> >     [tracepoint failure] Failed to trace tracepoint timer:hrtimer_setup=
,timer:hrtimer_start, output:
> >     event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
> >                          \___ unknown tracepoint
> >
> >     Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not fo=
und.
> >     Hint:   Perhaps this kernel misses some CONFIG_ setting to enable t=
his feature?.
> >
> >     Run 'perf list' for a list of valid events
> >
> >      Usage: perf trace [<options>] [<command>]
> >         or: perf trace [<options>] -- <command> [<options>]
> >         or: perf trace record [<options>] [<command>]
> >         or: perf trace record [<options>] -- <command> [<options>]
> >
> >         -e, --event <event>   event/syscall selector. use 'perf list' t=
o list available events---- end(-1) ----
> >     107: perf trace enum augmentation tests                            =
  : FAILED!
> >
> > Changes in v2:
> > - Add an extra newline after error messages
> > - Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
> > - Take the debug diff for explanation out of patch 5 to make it apply
> >   normally
> > - Add base-commit in this cover letter
>
> Thanks Howard! I did some testing but see failures that may be
> pre-existing issues:
>
> ```
> --- start ---
> test child forked, pid 264236
> Checking if vmlinux exists
> Tracing syscall landlock_add_rule
> [syscall failure] Failed to trace syscall landlock_add_rule, output:
>

I think this doesn't have any output, a sign of failure of collection
on the BPF side.

> ---- end(-1) ----
> 107: perf trace enum augmentation tests                              : FA=
ILED!
> --- start ---
> test child forked, pid 264248
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> String augmentation test failed, output:
>

Here too.

> ---- end(-1) ----
> --- start ---
> test child forked, pid 278774
> Checking if vmlinux exists
> Tracing syscall landlock_add_rule
> [syscall failure] Failed to trace syscall landlock_add_rule, output:
>      0.000 (         ): perf/278843 landlock_add_rule(ruleset_fd: 11,
> rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffdcf1dad90,
> flags: 45) ...

This is strange to me. No return value, no elapsed time. Judging from
experience this comes from the lack of the second sys_exit event that
sets both of them.

> ---- end(-1) ----
> 107: perf trace enum augmentation tests                              : FA=
ILED!
> --- start ---
> test child forked, pid 279196
> Checking if vmlinux exists
> Tracing syscall landlock_add_rule
> [syscall failure] Failed to trace syscall landlock_add_rule, output:
>      0.000 (         ): perf/279262 landlock_add_rule(ruleset_fd: 11,
> rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7fff37a70fd0,
> flags: 45) ...

Ditto.

> ---- end(-1) ----
> 107: perf trace enum augmentation tests                              : FA=
ILED!
> 108: perf trace BTF general tests                                    : FA=
ILED!
> --- start ---
> test child forked, pid 278187
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> Testing perf trace's buffer augmentation
> Testing perf trace's struct augmentation
> BTF struct augmentation test failed, output:
> sleep/278352 clock_nanosleep(0, 0, {1,1,}, 0x7ffd31550f50) =3D 0

This is the difference in libbpf's btf_dump's behavior. I grepped
"grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\},
0x[0-9a-f]+\) +=3D +[0-9]+$"", the {1, 1,} didn't match. On my machine
it is '{1,}'
~~~
sudo /tmp/perf trace --sort-events -e clock_nanosleep --force-btf
--max-events=3D1 -- sleep 1
sleep/338371 clock_nanosleep(0, 0, {1,}, 0x7ffeb4e9dd10) =3D 0
~~~

Which is strange, I thought we used the same libbpf from the kernel
tree and statically link it. Why is it different on our machines?
FWIW, I do have libbpf installed on my system, from their github
repo's main branch.
~~~
$ cat /usr/include/bpf/libbpf_version.h
/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
/* Copyright (C) 2021 Facebook */
#ifndef __LIBBPF_VERSION_H
#define __LIBBPF_VERSION_H

#define LIBBPF_MAJOR_VERSION 1
#define LIBBPF_MINOR_VERSION 6

#endif /* __LIBBPF_VERSION_H */
~~~

But I thought we used the same 1.6.x version from the tree...
~~~
$ cat tools/lib/bpf/libbpf_version.h
/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
/* Copyright (C) 2021 Facebook */
#ifndef __LIBBPF_VERSION_H
#define __LIBBPF_VERSION_H

#define LIBBPF_MAJOR_VERSION 1
#define LIBBPF_MINOR_VERSION 6

#endif /* __LIBBPF_VERSION_H */
~~~

> ---- end(-1) ----
> 108: perf trace BTF general tests                                    : FA=
ILED!
> --- start ---
> test child forked, pid 278775
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> Testing perf trace's buffer augmentation
> Buffer augmentation test failed, output:
> buffer content

This should have two lines of output, the second line is missing,
something to do with the BPF collection I mentioned above.
~~~
$ sudo /tmp/perf/perf trace --sort-events -e write --force-btf
--max-events=3D1 -- echo "buffer content"
buffer content
echo/393319 write(1, buffer content\10, 15) =3D 15
~~~

> ---- end(-1) ----
> 108: perf trace BTF general tests                                    : FA=
ILED!
> --- start ---
> test child forked, pid 279547
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> Testing perf trace's buffer augmentation
> Testing perf trace's struct augmentation
> BTF struct augmentation test failed, output:
> sleep/279619 clock_nanosleep(0, 0, {1,1,}, 0x7ffcd47b6450) =3D 0

Same '{1,1,}' appears.

> ---- end(-1) ----
> 108: perf trace BTF general tests                                    : FA=
ILED!
> --- start ---
> test child forked, pid 264252
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.333 MB /tmp/temporary_file.pl459 ]
> Failed: cannot find *nanosleep syscall

This test was written by Namhyung, again it failed to collect some samples.

> ---- end(-1) ----
> 110: perf trace record and replay                                    : FA=
ILED!
> --- start ---
> test child forked, pid 278193
> testing: perf trace -s -- true
> Error: cannot find enough pattern ^\s*(open|read|close).*[0-9]+%$ in the =
output

May also be a loss of samples.

There are some problems. From the output you provided, I can see the
obvious sample loss in perf trace, and the differing behavior in
libbpf's btf_dump. Fixing them.

Thanks,
Howard
