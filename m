Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678B1A314B
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739016963; cv=none; b=R3mWtKB6WV53/co4stXFIkB35aKr9PsR4vUwf7I1oh1y/17fth/b/IhRilsjVYaEP/5gsL9b6C+/5h9g3HWLTDQcBGZmHb6+novA0jIyq2VtHPHJrf0y1DnkDp3Ih5ppeYaWBz+R0iJdONnx2Lf58zk+awC9yew0r3bhtHD97bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739016963; c=relaxed/simple;
	bh=9X2Is+8nuobfxML0MD5sD223L52EmcedujL3Xs/3XYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9aDSyoqL2Wq8Pw73Z8gMX/+IAvA/E7TCMZ+X25zRNJ6mmq/w8WT51l9iliCx2CMmMcyVvChtWvnHfSwKak8Dx+M4nvGrIcEvj58tJ8Y/N+zogFl4v0+QSLRH3dZcSk/H+IafeYRBdMsaXV7uKmPAACVjVyVG5JIup7GA6GovsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3i6Aa3h; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3i6Aa3h"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d146357fb2so109435ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Feb 2025 04:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739016961; x=1739621761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoOoCJvlzdVunFC7wiBiDQMCVTStsZBMYKUPjj4jfuc=;
        b=F3i6Aa3hS6LFsijtTSWQ7IFYUzI6NIicPul65bYhnvgpYAT8ZrHJ5copa/oG6SrT7p
         E3eFUMMVL+t93W1Af9ydw4+mo7c2QbTod0+zrpZrFbBLwD6hwCWCVDDMpVhQNvSTrgs/
         7yPH37e799AlZnr/3gxYhUPOexr3MlLbNTzbWI5DLu1fndh4sGZalfwchu6M27EcObCf
         6K7JTaj2YCwsU97TK/u32m6nh+cRqfrkO0o5NwcRQ1NwI/D8a7EpJjhTaUDMMY/y2GxH
         sbiTJcvVg6ZVKuHF1UV+DSYBXDEqmRclIqHtHMA6K2YdNtaHdgRNuY/KyA56mZbwr+3A
         tNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739016961; x=1739621761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoOoCJvlzdVunFC7wiBiDQMCVTStsZBMYKUPjj4jfuc=;
        b=EbIJ4Uop4s5dUxuSx4IpT9c+BfiTjx746QT+qif6mTufOEj+6WsrQGVNI4YxyNhOth
         qPa6sTZAuSunIGUDWe/lj2jbheF8r7TQh/67fwHGroghpo8u/hckkbYKv7/PWimlpoIQ
         XAQHexk8qbXm5cynY00d9rfx/ouuYORkctltUoXlby49iHiqWJtL/hfnfrH/l4ZaKv82
         EfMnSTWIwdkFOilaMS9HVwCwByWwRp5UkeausexQdfPQ8XKWFeMfPDIpsXBAG2wR0Jx3
         KlMDHn1QuJ60rSAp5AuOwLmUOsl3EKba5gbFgerQNL4h5jNXXy8O8aADCUfYOKewh5C9
         BZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCXRXSVlF+3KhSYCgCR5N4y9fqGdwqiX2D2TaRqobydmCFNgGYXcHG6kvkX2G05WgNZzjjQR+U+2CoLX4rwjHVbG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18rTFGgCxMSGs0+4/lzzVN/TUn3kRBeA+PLf8thMUax5KR5ny
	j//V2WmR4kyDxPKCtltaf/axrTCg3CPIJZksl9+n7X53P0qkn3l3cllHg8U6BcRS+j1j753yewy
	jWrh2AY/FktTci38HiL4EMQ7qVN6p3qVOcjsE
X-Gm-Gg: ASbGncuX0OiP9l3oV5CFvx02w4fRuEru9lNSvv+yLZPCEp0jXtaJW3DL53Zjoo4HByk
	V1N3r2xC7SJARiBZPc3iLc6u76BY+EoSd7nf03IURtee2xeDN6WDdPg731Vvk2nyQQ5MVxO/n3A
	==
X-Google-Smtp-Source: AGHT+IE7xLwciQpOBh5kEi79e8nvKtwvjRTETio4RpgpbmjNlMzN+v2v3C2ofkwJKzl2CcPXM8t4vv555F2CK9S3kvk=
X-Received: by 2002:a05:6e02:138b:b0:3a7:dea7:87a6 with SMTP id
 e9e14a558f8ab-3d14f10028bmr1206915ab.29.1739016960879; Sat, 08 Feb 2025
 04:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com> <20250208105821.1cdb54fc@pumpkin>
In-Reply-To: <20250208105821.1cdb54fc@pumpkin>
From: Ian Rogers <irogers@google.com>
Date: Sat, 8 Feb 2025 04:15:49 -0800
X-Gm-Features: AWEUYZmdU81z1QP8kW0muXTcrFk6d0O579gpWvr9mW1sB6x5E2KegUHMGlcIBs4
Message-ID: <CAP-5=fV+iad1-7O=63QgS=3AztxPxVHc+tui_2iNbBvxuHwuHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add io_dir to avoid memory overhead from opendir
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Anne Macedo <retpolanne@posteo.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:58=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri,  7 Feb 2025 15:24:41 -0800
> Ian Rogers <irogers@google.com> wrote:
>
> > glibc's opendir allocates a minimum of 32kb, when called recursively
> > for a directory tree the memory consumption can add up - nearly 300kb
> > during perf start-up when processing modules. Add a stack allocated
> > variant of readdir sized a little more than 1kb
>
> Does 300kB really matter?

For someone on a laptop, probably no. For a company running the
command a large number of times in consolidated and heavily loaded
data centers, where binaries run in memory constrained containers,
memory usage contributes to latency of the 99th percentile slow
executions, which because of the number of machines is something seen
all the time.

That said, do you need to optimize usages where you recurse over the
kernel modules? That's something you wouldn't try to do in a data
centre, so there isn't so much need.

> You seem to be trading memory allocation against system calls.
> My 'gut feel' is that the system call cost will dominate.
> (Unless all the directories are small.)

It isn't so much directories being small as the filenames within them.
getdents64 will vary the size of each entry based on the filename size
which can be up to 256 bytes. As an example, for trace points:
```
$ sudo ls -al /sys/kernel/debug/tracing/events/raw_syscalls/
total 0
drwxr-xr-x 1 root root 0 Feb  8 03:23 .
drwxr-xr-x 1 root root 0 Feb  8 03:20 ..
-rw-r----- 1 root root 0 Feb  8 03:23 enable
-rw-r----- 1 root root 0 Feb  8 03:23 filter
drwxr-xr-x 1 root root 0 Feb  8 03:23 sys_enter
drwxr-xr-x 1 root root 0 Feb  8 03:23 sys_exit
$ sudo ls -al /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter
total 0
drwxr-xr-x 1 root root 0 Feb  8 03:23 .
drwxr-xr-x 1 root root 0 Feb  8 03:23 ..
-rw-r----- 1 root root 0 Feb  8 03:23 enable
-rw-r----- 1 root root 0 Feb  8 03:23 filter
-r--r----- 1 root root 0 Feb  8 03:23 format
-r--r----- 1 root root 0 Feb  8 03:23 hist
-r--r----- 1 root root 0 Feb  8 03:23 id
-rw-r----- 1 root root 0 Feb  8 03:23 trigger
```
So each d_entry is going to cost you like 20 bytes plus the length of
the filename. So 6 entries with filenames varying up to 9 characters,
you need 24 or 32 bytes per entry after padding. If each entry were 32
bytes then you'd need a buffer to hold all the data of size 192 bytes,
the code here is using 1kb. The value used by glibc is between 32KB
and 1MB, which is pretty generous when all you need is 192 bytes.

An issue in perf is that we may recursively descend directories and
use opendir on each level, so the buffer size gets multiplied by the
depth of the tree. So at 100s of KB these memory allocations are some
of the largest seen in profiles of perf - BPF has some large
allocations too.

So why not fix opendir? I've found trying to get things landed in
glibc is slow to glacial [1], and someone once thought those buffer
sizes were good so who am I to argue? The LLVM libc and similar are
making similar smaller than glibc buffer size choices. The addition of
io_dir means we can tune for the use cases that matter to perf, such
as kernel modules, procfs, sysfs, .. in general we don't see
directories with lots of entries and we're a long way from the 256
byte file name max length. While the code could potentially increase
the number of system calls, in practice it doesn't.

Thanks,
Ian

[1] I sent patches bringing back the "stack:tid" convention in
/prod/pid/maps by naming stacks on allocation (an extra syscall). This
can be used, for example, to identify stack vs heap memory accesses.
Linux used to support this but Linus himself removed the support - the
code to do it had quadratic execution time due to searching for each
stack allocation the corresponding thread stack pointer. Fixing
opendir memory size and stack naming in glibc would be good things
imo. Were libc better we may not need this series (we still know our
use cases better than a generic implementation).

> There might, of course, be other code in glibc that is designed
> to make it all slower than necessary.
>
>         David
