Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6B1EB5C
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178331; cv=none; b=jJ1t3xfgBrILACZHFOuR8/URR4YAfhGQXptX7AmCSBdOUTesVIv4U6q0ac2JVJ6P8UjuDnxOu/dlgRrXSqW7DI76OniWfuZFjuUX6tK601Qm6Zm6rmLT4KvCSBmEzv4rNEpVIMK/xvDEhfPaqUHIffWxUx6bGNpcVe63+auDBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178331; c=relaxed/simple;
	bh=w/h8OjhttXfU3CUAE6EGwM4XSPBtXhwAH4Wp53YQdMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKyTMXYe4ZS3fgvxB7yX8aeo4p2hoCBQslS1FXoOscJZbs9wB+mU4qUAlJkHI2KNhlPU4PD8B4E8ObOsFv8iU7q6gWKRvF/BeMeOoWt85A2DsC5Ffgx78v5ZKRa8S7JbqZ5HvcrK39L1VWC2Fl/DcAVe/2UnBFKB6z61g/YPP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wm7eArVD; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wm7eArVD"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36645c1169cso3335ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710178329; x=1710783129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DlekkPh0laC58G52mB2a/RNPKjPOMLVB09DJgjZ9Fg=;
        b=wm7eArVD6UVgRkLxtGhoOE+obaVgOUqa9bXujSiI/JtbYez8USR+tQV06T+V2q4Yj1
         UKTFhSPogmAMZdaHUzhCXlEzw53MN+vHh1o8xObT4Irz6pxvybqQhTt/sDBA4DQFGHz/
         +i+BU+wgIYfr1cwlSOIQyZmdRM3oVpg3/qkM4reGEhcdLfAgprCLUhm0NRomxpEbQ48q
         8ePhQMExqt0IxnWyXHC63RpEzmSd/XZKRy41TV1wsZ+1+beLr8oOjWQpQeMtPDdCRpkE
         V05B7AUiWOJ8ByQyBNqBAW6E4/kndz0cWlkZugCuJJ9yHUWwwXrwgJPQOvyY1g8VH3RP
         dh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178329; x=1710783129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DlekkPh0laC58G52mB2a/RNPKjPOMLVB09DJgjZ9Fg=;
        b=gIuCKv3CH5WuEBtP9jrgvykB8OkORwHx5lW/2KpNqyWOOX2VGB44VV5p03+oaiihNg
         sobtaQNPqIrWKWE0XC0ZW9SauVoWqJq4qcQf3W0wFgJtB6+u3oMZTyxu2Z5XAeJHSh/K
         oUsBSZ/T/BvInusreTcy/sRWVpB0KfFQfjhPFSs7ziJveK5c0X5S8OF/dkj+KG8x2/nx
         GROOVd7g1S/1lfDOAJepy95SZeyg6eG1AkbuoQDfg253OBi5XWjoQd3RBFHk5oFCGbs9
         QBeLKpakS4tgf0MnAcj0qGfEwFFJ3dwad5y40ymq7v/EYo5TV3TQtVLgYslzam0w4V1D
         sDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTNvwb6UEg+Jq5Ag4JIA9bwLcFp4/esVkpX2pVVtwBbqVcYLNKDtG4F4+pJLWeoRGj/mfsh51KtLErjEO7w8zypeLym2rGjoBanoQDEVUGpw==
X-Gm-Message-State: AOJu0Ywr9TAOd0L1+k/9mEcj0kLHri9vI99/20xRNuGgmWEzkOULHhrF
	vcV7ic2L3aUMCBqB06WGBTfi/z+Cpi0NTnl33m9DIc9FY9FvvGWCGYyD5mNUu8VVPQoiq1j9548
	uh96pg1mo/KVFjgyiS891iSSS6yR6sy/KJnpN
X-Google-Smtp-Source: AGHT+IFqqUDxG5nSYR9CNt3lcrS2qaUADNQ2icj244Wbcu0EAS27Sf03v95Ckd5irwyhvQmIxWJIPCkkN/CyFTUsjMY=
X-Received: by 2002:a05:6e02:3709:b0:366:3131:60e6 with SMTP id
 ck9-20020a056e02370900b00366313160e6mr730270ilb.25.1710178328535; Mon, 11 Mar
 2024 10:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHoSAufhtBjD_CgSXY1SOxqkAcY9n1gEwixiK-bL=Ktf7dtDA@mail.gmail.com>
In-Reply-To: <CAKHoSAufhtBjD_CgSXY1SOxqkAcY9n1gEwixiK-bL=Ktf7dtDA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Mar 2024 10:31:55 -0700
Message-ID: <CAP-5=fUa+-Tj2b_hxk96Qg5=Qu7jYHgHREbsmBa2ZmuF-X9QaA@mail.gmail.com>
Subject: Re: WARNING in free_event
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 9:38=E2=80=AFAM cheung wall <zzqq0103.hey@gmail.com=
> wrote:
>
> Hello,
>
>
>
> when using Healer to fuzz the latest Linux Kernel, the following crash
>
> was triggered on:
>
>
>
> HEAD commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72  (tag: v6.8-rc7)
>
> git tree: upstream
>
> console output: https://drive.google.com/file/d/17rMhBgYu1sr1d8fiFPS2cPQ6=
0VNJv8H_/view?usp=3Ddrive_link
>
> kernel config: https://drive.google.com/file/d/19VXB1YKwoBFpzjqTmm02jVi4-=
N9tNIvm/view?usp=3Ddrive_link
>
> C reproducer: https://drive.google.com/file/d/1fC55GmW0di5HgxQWhrf6Vj1EA2=
LXsaNJ/view?usp=3Ddrive_link
>
> Syzlang reproducer: https://drive.google.com/file/d/1uTbMUGRUK4kLiJHyK5dD=
2-_beUqx4V55/view?usp=3Ddrive_link
>
>
>
> If you fix this issue, please add the following tag to the commit:
>
> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
>
> ----------------------------------------------------------
>
>
> WARNING: CPU: 4 PID: 817954 at kernel/events/core.c:5254 free_event+0x8b/=
0xb0 kernel/events/core.c:5254
> Modules linked in:
> CPU: 4 PID: 817954 Comm: syz-executor.1 Not tainted 6.8.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> RIP: 0010:free_event+0x8b/0xb0 kernel/events/core.c:5254
> Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 23 48 8b b5 3=
8 02 00 00 48 89 ea 48 c7 c7 00 5d cd 8e e8 86 2e c3 ff 90 <0f> 0b 90 90 5d=
 41 5c e9 69 aa ef ff 4c 89 e7 e8 21 73 1c 00 eb d3
> RSP: 0018:ffff88811864fd78 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 1ffff110230c9fbd RCX: ffffffff8bd1ba08
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88811864fb70
> RBP: ffff88810e94f2d8 R08: 0000000000000001 R09: ffffed10230c9f6f
> R10: ffffed10230c9f6e R11: ffff88811864fb77 R12: ffff88810e94f510
> R13: ffff8881046744e8 R14: ffff88812ee40768 R15: ffff88812ee40000
> FS:  00007fc2f7eb0700(0000) GS:ffff8881c0200000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffca566ae18 CR3: 0000000164ee6001 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __do_sys_perf_event_open+0x4fd/0x1d50 kernel/events/core.c:12803
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xb4/0x1b0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fc2f8b62c8d
> Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc2f7eafbf8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> RAX: ffffffffffffffda RBX: 00007fc2f8c9e050 RCX: 00007fc2f8b62c8d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
> RBP: 00007fc2f8bc04af R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff421d61cf R14: 00007fff421d6370 R15: 00007fc2f7eafd80
>  </TASK>

I find reading the reproducers hard work. Turn things like:
```
...
    *(uint32_t*)0x200000c0 =3D 0;
    *(uint32_t*)0x200000c4 =3D 0x80;
    *(uint8_t*)0x200000c8 =3D 0;
    *(uint8_t*)0x200000c9 =3D 0;
    *(uint8_t*)0x200000ca =3D 0;
    *(uint8_t*)0x200000cb =3D 0;
...
    res =3D syscall(__NR_perf_event_open, /*attr=3D*/0x200000c0ul, /*pid=3D=
*/0,
                  /*cpu=3D*/0ul, /*group=3D*/-1, /*flags=3D*/0ul);
```
into the corresponding type/config. Then work out what's going on with
the case statements, is the test running in a hypervisor, etc.

I've seen a similar failure to this reported, but in that case the
event was a software cpu-clock event. The warning is:
```
...
[ 2519.138665] unexpected event refcount: 2; ptr=3D000000009c56b097
...
[ 2518.913630]  ? free_event+0x8b/0xb0
[ 2518.914040]  ? report_bug+0x2cc/0x430
[ 2518.914467]  ? free_event+0x8b/0xb0
[ 2518.915380]  ? handle_bug+0x5e/0xc0
[ 2518.915965]  ? exc_invalid_op+0x25/0x70
[ 2518.916565]  ? asm_exc_invalid_op+0x1a/0x20
[ 2518.917635]  ? __warn_printk+0x158/0x200
[ 2518.918112]  ? free_event+0x8b/0xb0
[ 2518.918538]  ? free_event+0x8a/0xb0
[ 2518.918944] __do_sys_perf_event_open+0x4fd/0x1d50
...
```
That is free_event was called and we expected the reference count to
be 1, it wasn't and so the memory wasn't freed potentially causing a
memory leak (better than a potential use-after-free) - hopefully
whoever has the other reference count will free the memory. A suspect
for holding the reference count would be the interrupt handler, but
maybe it is another CPU. I think it is inherent in the nature of the
bug that there is a race condition. It'd be interesting to know if
this is 100% reproducible.

Thanks,
Ian
