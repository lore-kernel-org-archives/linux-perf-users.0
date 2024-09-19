Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DC14A84;
	Thu, 19 Sep 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726715604; cv=none; b=ua27mMj2Qawwyw+f5wkiVH9Lft2TBw/ZMPpnBrD6voM0VZdLDfUjAwi4JcrFtBAmTZq/BpFuDnpheiQ0QT7UVlmOaMGp85pX0kUlhI2tsp5y8kAgUt6Ym4ALtfPSAaGHHN7jPAiqoDzNnOprkO4Fv9TpuiIUuXBjAbgQ55uMqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726715604; c=relaxed/simple;
	bh=v3XOtCJC/1XwDoiw4CBQI3MmYr11dA0qJXyLGJnCVZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6R7IQtCfrXnI2V13tyFKRGmeAmzOh0dAea1LM0HyAw6J5hrZhXt9jT22LK1L/DrFCnxJ5U+eUiCnbX2VGFGP43y+A06WMJSarLs1E9nI55V9rbIR60kjmVGJ7kkEverH5/7J+QW3p9LZB4wZRy4EplOC26heKwb5+gmA2Qvy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+NPXoXZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+NPXoXZ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6c3f1939d12so2837617b3.2;
        Wed, 18 Sep 2024 20:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726715601; x=1727320401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoh6I9pRMH2Ha4+5ncvU1mo3BNzHyMVvp2g0FcI9knY=;
        b=F+NPXoXZKb4B+zK4HtM1bkSJ+lRr5xVEib0f0Am/T+rjnwdZxwT+6iJLXUM/29BOvu
         vlB2cghSSVQb3iqm2znrweUS5mt51pnoG+S8nBgzE/s9jsiJj8avHqVodZplYfZBy5RX
         PgJ9+790ViIWXGBFYJtVR1Yyu5c9WfJi8l1J/Rb2b19boP811yO1nviyMxf4eHIEdPi7
         S9RVweDsIok+tnbc1BiDpr+M3Bif8bubhmI6aa+/STmzHpq65+uW0UiPVSPBPavq6gF4
         Xy6dvxFVHuTQuhrb3QOhw67od3UVMx+FAxSzteVBPlQm5V/m1QppsihwoAttI0vPZQWP
         iXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726715601; x=1727320401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoh6I9pRMH2Ha4+5ncvU1mo3BNzHyMVvp2g0FcI9knY=;
        b=iEf/umnOPpViZgsT4IKoOWMy+FpDv+As58zcU09Rp0vkLTt/hFX07FfsBsl/G7tW/P
         96RBwPpbsVH1n/bpZtd+MjrvDJaM2XcWGsFjo3Ik1I59t66icWitQLn2CWAxox4aepY+
         dLvxFCDbwtAUp5xjeSfKh+xIf72JgfHZZ/216s4y+XWMyaOaOOYNjbOiWJL1xr0ZwSN4
         MgCUZNAwl0vYrxVnwEh4k56G8IpRA8OpGJJNh/NiPIYEUtLr6DhAbXtPnjQd+ZXWCs+Y
         1INXPoh8LUYT3iZ9w0vVGETmOHfBw6dq1LzlnwpQwVRBb2cC+n/C08w9Kfz8vNbYq2ZK
         usGg==
X-Forwarded-Encrypted: i=1; AJvYcCX0fJQ4y5QetXpmOmgfZ3zCCk1qIfXdqNE8Ryq78BrAQ9TDhLcLo6yyw4s9FA88IyNhAhdFKuOrmXGrQxA=@vger.kernel.org, AJvYcCXUpnyovIpHtv1sdl9i1pUt3nxiogZxC7inih35IEXXepWbpyrRgo9qV2bzP+XMQoSEi7lrJizoEdol3pLSwYFTOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxNGth/G1wNrwOUDqy+Bcyn9LvA9QFNrBkg4yo7E267ovf84+
	hl35Ya+eMmuRgfDYbWBQK6PU4OvSv/6488MYsb55LnRzpAs1SuLFVcW26fVH1V/uIQaf/s0jz5v
	MWOqtDwewR46cclY9gjnIDKaL8wc=
X-Google-Smtp-Source: AGHT+IHVjXHj4Phb2hIUE0cqjxV2DzLDo/lER3vuCTZd4zkpZpIb+TJaeCFWcAh0nNQk6pDQxt5SVF/gSMbesHiEh3A=
X-Received: by 2002:a05:690c:10:b0:6db:4536:8591 with SMTP id
 00721157ae682-6dbb6b86541mr223601037b3.28.1726715601549; Wed, 18 Sep 2024
 20:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuGL9ROeTV2uXoSp@x1> <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
 <ZuL_0V5jgaaEUOY_@x1> <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
 <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com> <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
In-Reply-To: <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 18 Sep 2024 20:13:10 -0700
Message-ID: <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm able to reproduce it on Ubuntu 24.

perf $ cat /etc/os-release
PRETTY_NAME=3D"Ubuntu 24.04.1 LTS"
NAME=3D"Ubuntu"
VERSION_ID=3D"24.04"
VERSION=3D"24.04.1 LTS (Noble Numbat)"
VERSION_CODENAME=3Dnoble
ID=3Dubuntu
ID_LIKE=3Ddebian
HOME_URL=3D"https://www.ubuntu.com/"
SUPPORT_URL=3D"https://help.ubuntu.com/"
BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-policies/priva=
cy-policy"
UBUNTU_CODENAME=3Dnoble
LOGO=3Dubuntu-logo

perf $ uname -r
6.11.0-061100-generic

perf $ git log
commit 4c1af9bf97eb56d069421c3233ce61608458d5c8 (HEAD)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Sep 10 13:54:23 2024 -0300

    perf trace: If a syscall arg is marked as 'const', assume it is
coming _from_ userspace


perf $ clang -v
Ubuntu clang version 15.0.7
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /bin
Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
Candidate multilib: .;@m64
Selected multilib: .;@m64

perf $ ./perf trace -e write --max-events=3D1
libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int sys_enter_rename(struct syscall_enter_args *args) @
augmented_raw_syscalls.bpf.c:275


With clang-16:

perf $ clang -v
Ubuntu clang version 16.0.6 (23ubuntu4)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /bin
Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/13
Candidate multilib: .;@m64
Selected multilib: .;@m64

perf $ ./perf trace -e write --max-events=3D1
     0.000 ( 0.021 ms): sudo/4741 write(fd: 8, buf:
\27[?25l\27[37m\27[48;5;96m\27[H[trace] , count: 205) =3D

> I'll try to build it and see. But Ubuntu 22 only has clang 11 to 15 so
> making 16 the minimum could be an issue.

Yes, I think disabling any distro that doesn't come with clang 16
(released in 2023) is not a good idea. I'll try to tame the BPF
verifier.

Thanks,
Howard

On Tue, Sep 17, 2024 at 10:37=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hello James and Arnaldo,
>
> On Fri, Sep 13, 2024 at 3:42=E2=80=AFAM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On Fri, Sep 13, 2024, 7:20=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >>
> >>
> >>
> >> On 12/09/2024 15:50, Arnaldo Carvalho de Melo wrote:
> >> > On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
> >> >> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
> >> >>> Howard reported problems using perf features that use BPF:
> >> >
> >> >>>     perf $ clang -v
> >> >>>     Debian clang version 15.0.6
> >> >>>     Target: x86_64-pc-linux-gnu
> >> >>>     Thread model: posix
> >> >>>     InstalledDir: /bin
> >> >>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux=
-gnu/12
> >> >>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
> >> >>>     Candidate multilib: .;@m64
> >> >>>     Selected multilib: .;@m64
> >> >>>     perf $ ./perf trace -e write --max-events=3D1
> >> >>>     libbpf: prog 'sys_enter_rename': BPF program load failed: Perm=
ission denied
> >> >>>     libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
> >> >>>     0: R1=3Dctx() R10=3Dfp0
> >> >>>
> >> >>> But it works with:
> >> >>>
> >> >>>     perf $ clang -v
> >> >>>     Debian clang version 16.0.6 (15~deb12u1)
> >> >>>     Target: x86_64-pc-linux-gnu
> >> >>>     Thread model: posix
> >> >>>     InstalledDir: /bin
> >> >>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux=
-gnu/12
> >> >>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
> >> >>>     Candidate multilib: .;@m64
> >> >>>     Selected multilib: .;@m64
> >> >>>     perf $ ./perf trace -e write --max-events=3D1
> >> >>>          0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\=
0\0\0\0, count: 8)                         =3D 8 (kworker/0:0-eve)
> >> >>>     perf $
> >> >>>
> >> >>> So lets make that the required version, if you happen to have a sl=
ightly
> >> >>> older version where this work, please report so that we can adjust=
 the
> >> >>> minimum required version.
> >> >
> >> >> I wasn't able to reproduce the issue with either of these versions.=
 But I
> >> >> suppose it could be an issue with only 15.0.6.
> >> >
> >> > Interesting, that complicates things, probably the best way then is =
to
> >> > try to build it, if it fails, mention that 15.0.6 is known to be
> >> > problematic and suggest working versions?
> >> >
> >> > - Arnaldo
> >>
> >> I still wasn't able to reproduce it with 15.0.6. And I double checked
> >> with V=3D1 that the build was using the right clang. I suppose it coul=
d be
> >> a build configuration issue, or maybe with a different kernel version?
> >
> >
> > Howard? If not reproducible we can revert it.
> >
> > - Arnaldo
> >
> >
> >>
> >> $  uname --kernel-release
> >> 6.8.0-76060800daily20240311-generic
> >>
> >> $ ../../llvm-project/build/bin/clang -v
> >> clang version 15.0.6 (https://github.com/llvm/llvm-project.git
> >> 088f33605d8a61ff519c580a71b1dd57d16a03f8)
> >> Target: x86_64-unknown-linux-gnu
> >> Thread model: posix
> >> InstalledDir: /home/james/workspace/linux/linux/../../llvm-project/bui=
ld/bin
> >> Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
> >> Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
> >> Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
> >> Candidate multilib: .;@m64
> >> Selected multilib: .;@m64
> >>
> >> $ git log
> >> commit 003265bb6f028d7bcd7cbd92d6ba2b4e26382796
> >> (perf-tools-next/perf-tools-next)
> >>
> >> $ make O=3D../build/local/ CLANG=3D../../llvm-project/build/bin/clang =
-C \
> >>    tools/perf
> >>
> >> $ perf trace -e write --max-events=3D1
> >>
> >>       0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
> >>         0x7fffa102d9b0, count: 8)                           =3D 8
>
> Thanks for the effort! But this output seems to be unaugmented? I
> think you are testing the perf/perf-tools-next branch that's slightly
> older (perf mem: Fix the wrong reference in parse_record_events()
> 003265bb6f028d7bcd7cbd92d6ba2b4e26382796), and I think that doesn't
> have the new perf trace feature yet...
>
> That's why the perf trace output looks like:
>
> >> $ perf trace -e write --max-events=3D1
> >>
> >>       0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
> >>         0x7fffa102d9b0, count: 8)
>
> With the new buffer augmentation it should look like this:
>
> perf $ ./perf trace -e write --max-events=3D1
>      0.000 ( 0.011 ms): gmain/1408 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
> count: 8)                         =3D
>
> The new perf trace can be found on
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
> perf-tools-next
>
> perf $ git log
> commit 1de5b5dcb8353f36581c963df2d359a5f151a0be (HEAD ->
> struct-aug-arnaldo-2, perf/perf-tools-next)
>
> Also, if you want to test the clang, you may want to checkout to the
> commit before the clang-16 guard (otherwise you can't test different
> clang version).
>
> perf $ git log --oneline
> 1de5b5dcb835 (HEAD -> struct-aug-arnaldo-2, perf/perf-tools-next) perf
> trace: Mark the 'head' arg in the set_robust_list syscall as coming
> from user space
> 0c1019e3463b perf trace: Mark the 'rseq' arg in the rseq syscall as
> coming from user space
> edf3ce0ed38e perf env: Find correct branch counter info on hybrid
> 9953807c9e01 perf evlist: Print hint for group
> eb9b9a6f5ab3 tools: Drop nonsensical -O6
> 89c0a55e550e perf pmu: To info add event_type_desc
> f08cc258431d perf evsel: Add accessor for tool_event
> 925320737ae2 perf pmus: Fake PMU clean up
> d3d5c1a00fcd perf list: Avoid potential out of bounds memory read
> 4ae354d73a8e perf help: Fix a typo ("bellow")
> 74298dd8acb8 perf ftrace: Detect whether ftrace is enabled on system
> 83420d5f5863 perf test shell probe_vfs_getname: Remove extraneous '=3D'
> from probe line number regex
> 9327f0ecad48 perf build: Require at least clang 16.0.6 to build BPF
> skeletons. **********[[[[[[[[[[[[!!!!(This is the clang
> guard)]]]]]]]]]]*****
> 4c1af9bf97eb perf trace: If a syscall arg is marked as 'const', assume
> it is coming _from_ userspace
> e37b315c17df perf parse-events: Remove duplicated include in parse-events=
.c
>
> My machine is debian 12, and I cannot build perf trace with the new
> augmentation feature on clang-13, clang-14, and clang-15.
>
> perf $ uname -r
> 6.11.0-061100rc7-generic
>
> perf $ git log
> commit 4c1af9bf97eb56d069421c3233ce61608458d5c8 (HEAD)
>
> perf $ make CLANG=3D/bin/clang-13 && ./perf trace -e write --max-events=
=3D1
> ...
> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int sys_enter(struct syscall_enter_args *args) @
> augmented_raw_syscalls.bpf.c:509
> 0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()
>
>
> perf $ make CLANG=3D/bin/clang-14 && ./perf trace -e write --max-events=
=3D1
> ...
> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int sys_enter(struct syscall_enter_args *args) @
> augmented_raw_syscalls.bpf.c:509
>
>
> perf $ make CLANG=3D/bin/clang-15 && ./perf trace -e write --max-events=
=3D1
> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
>
>
> perf $ make CLANG=3D/bin/clang-16 && ./perf trace -e write --max-events=
=3D1
>      0.000 ( 0.010 ms): gmain/1408 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
> count: 8)                         =3D
>
>
> Anyway thank you so much, I'll try to reproduce it on Ubuntu, like you
> mentioned.
>
> Thanks,
> Howard
>
>
> >>
