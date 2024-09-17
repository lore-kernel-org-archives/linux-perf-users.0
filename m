Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DF182;
	Tue, 17 Sep 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594685; cv=none; b=d4oQ1KklOu4XCtTDAbqj8HsVI3UTACQTY8cxh2pQCfU4cZTEvPqnNlJB828GSq3lQne41Vp78wmUkd6MSCftr3v0wOkcUwMga7Z/Z5t6X/fmzkokkZI+jIY7SM2RMJW7+9uXWiFCBmw/yltOjewlepn7Ec7NpJhgBG012GIJER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594685; c=relaxed/simple;
	bh=YJp4V6wTyZO1On2Nxmm2Polq125vQIdvl/cYgDZH4AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAF1ELT9ATjuEdgRwdtJLwWqSvPm2fEGvyNC5f8VqwQn4pp9QEznrLcp0Pmjh8suuomDyGnPOcsdzf9fDJA1hIN1ELOEFDDlQKj0fVanaVKT1FhlqOwC5RPRkjCJgIPpICype4E+4z2U+FussKePS0u7ys+2B1aZyeK5ys3DVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq59L0xT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq59L0xT"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9f84699cso4893229276.3;
        Tue, 17 Sep 2024 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726594683; x=1727199483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctUVWsq6yFff6NPSbR4N6oZRMK3QB0xNYNo/96feZm0=;
        b=fq59L0xTM1qbNLQhvCvNLPdY9svKMIWKZvlbCBrMG2Ca3M7obGj+wHSq9uwCFNUxHk
         /oeVlF+zi3OQm7CZgVBluoR1fJeW+YrxeIov8rHALrgPr1jNFjP3BS4C5ETc2xih7oJh
         ec5cjrfUu706RnGodpJ0bVUnYnVQTneoPkkqZsaKW9EyMyxXjptF8lwwDKfFtEz6XHm7
         4VuQYfAT84komxXmf4OMXFNaZCZSIBWzIsnYz3T5TRiSA2b34s3nQWHOT81iny3aZkRc
         26R9ZRP7E0DGQBYv/ENvSBWSyu3c74Fhb/1gPShpE96yIXwWbr9Y32V/lpsWHDe9Dnrb
         /khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726594683; x=1727199483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctUVWsq6yFff6NPSbR4N6oZRMK3QB0xNYNo/96feZm0=;
        b=VwKqZsGE6/IiuUH96Gnd10y42SR+ED14yLq+cF3EvLEm39fJ2ZumdKufzsO28atm2v
         FZJw1KI298pPdWLa7sv+k68bNNogVJAiBFUWjUAKfQ4nLF8QWXJvF9bErE0Ef1Z0/MZE
         nyt3TlNpQOQ9pqPxOdGlPf5TrGkXR9YB3AooI2HSYALOO1I0WQW5PwXNu/mukJX0VPsY
         pJRjRSy6QxmmzOfotPj42FnExyH/c6cBIBkIva6aUVZwjSexLMyQzqkxTQC/K9ZpI4ZM
         gVNt7A5bHsKzioEgCpbab/PVabOx/7E3oHWYDqJMsnDhVNUOpVZ6/3YPG3hxBeHXK/J+
         TjRg==
X-Forwarded-Encrypted: i=1; AJvYcCV6oZsisikaag5nFCdSmPMCFSoLwvZtBBfil4lww6vJKc1T3Xsr0lwSGHnijRmrEoPiYwfPc5qBM5GRqbc=@vger.kernel.org, AJvYcCXI0uhrOhlq8Nn6scrK/xqAwN7KFALbbZcO9ptSIckGOba4cVEI/e6iA4XfFefm1h/p21YNJlTvmjAgZy8sPrQPLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEAD6ynpIL9TYDKaT7NrZXfJoQ1gfESb7UI1oBY2LJxwVlI9A
	GnvAtp3xrL/29rqtxIM1tKqryPHuzFGg6Y/Kolf8mvMxrZkWga9/sHxyCx/fNBF7F/VciEU+RlH
	QiwzL8Ll1WHEqZWYnSueFyTdbgGGqiNtAFKM=
X-Google-Smtp-Source: AGHT+IGVgtwWU9Z2K41HQPQnqv2+/TBePM0zz6xMOUSstQJVK15xQU8Ls11t5ydHHcBhyGHOyOhUjYD3XFItudA4IMk=
X-Received: by 2002:a05:690c:110:b0:6db:c12b:4d76 with SMTP id
 00721157ae682-6dbc12b4eb1mr115474717b3.29.1726594682664; Tue, 17 Sep 2024
 10:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuGL9ROeTV2uXoSp@x1> <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
 <ZuL_0V5jgaaEUOY_@x1> <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org> <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
In-Reply-To: <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 17 Sep 2024 10:37:52 -0700
Message-ID: <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
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

Hello James and Arnaldo,

On Fri, Sep 13, 2024 at 3:42=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Fri, Sep 13, 2024, 7:20=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>>
>>
>>
>> On 12/09/2024 15:50, Arnaldo Carvalho de Melo wrote:
>> > On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
>> >> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
>> >>> Howard reported problems using perf features that use BPF:
>> >
>> >>>     perf $ clang -v
>> >>>     Debian clang version 15.0.6
>> >>>     Target: x86_64-pc-linux-gnu
>> >>>     Thread model: posix
>> >>>     InstalledDir: /bin
>> >>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-g=
nu/12
>> >>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>> >>>     Candidate multilib: .;@m64
>> >>>     Selected multilib: .;@m64
>> >>>     perf $ ./perf trace -e write --max-events=3D1
>> >>>     libbpf: prog 'sys_enter_rename': BPF program load failed: Permis=
sion denied
>> >>>     libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>> >>>     0: R1=3Dctx() R10=3Dfp0
>> >>>
>> >>> But it works with:
>> >>>
>> >>>     perf $ clang -v
>> >>>     Debian clang version 16.0.6 (15~deb12u1)
>> >>>     Target: x86_64-pc-linux-gnu
>> >>>     Thread model: posix
>> >>>     InstalledDir: /bin
>> >>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-g=
nu/12
>> >>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>> >>>     Candidate multilib: .;@m64
>> >>>     Selected multilib: .;@m64
>> >>>     perf $ ./perf trace -e write --max-events=3D1
>> >>>          0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\=
0\0\0, count: 8)                         =3D 8 (kworker/0:0-eve)
>> >>>     perf $
>> >>>
>> >>> So lets make that the required version, if you happen to have a slig=
htly
>> >>> older version where this work, please report so that we can adjust t=
he
>> >>> minimum required version.
>> >
>> >> I wasn't able to reproduce the issue with either of these versions. B=
ut I
>> >> suppose it could be an issue with only 15.0.6.
>> >
>> > Interesting, that complicates things, probably the best way then is to
>> > try to build it, if it fails, mention that 15.0.6 is known to be
>> > problematic and suggest working versions?
>> >
>> > - Arnaldo
>>
>> I still wasn't able to reproduce it with 15.0.6. And I double checked
>> with V=3D1 that the build was using the right clang. I suppose it could =
be
>> a build configuration issue, or maybe with a different kernel version?
>
>
> Howard? If not reproducible we can revert it.
>
> - Arnaldo
>
>
>>
>> $  uname --kernel-release
>> 6.8.0-76060800daily20240311-generic
>>
>> $ ../../llvm-project/build/bin/clang -v
>> clang version 15.0.6 (https://github.com/llvm/llvm-project.git
>> 088f33605d8a61ff519c580a71b1dd57d16a03f8)
>> Target: x86_64-unknown-linux-gnu
>> Thread model: posix
>> InstalledDir: /home/james/workspace/linux/linux/../../llvm-project/build=
/bin
>> Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
>> Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
>> Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/12
>> Candidate multilib: .;@m64
>> Selected multilib: .;@m64
>>
>> $ git log
>> commit 003265bb6f028d7bcd7cbd92d6ba2b4e26382796
>> (perf-tools-next/perf-tools-next)
>>
>> $ make O=3D../build/local/ CLANG=3D../../llvm-project/build/bin/clang -C=
 \
>>    tools/perf
>>
>> $ perf trace -e write --max-events=3D1
>>
>>       0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
>>         0x7fffa102d9b0, count: 8)                           =3D 8

Thanks for the effort! But this output seems to be unaugmented? I
think you are testing the perf/perf-tools-next branch that's slightly
older (perf mem: Fix the wrong reference in parse_record_events()
003265bb6f028d7bcd7cbd92d6ba2b4e26382796), and I think that doesn't
have the new perf trace feature yet...

That's why the perf trace output looks like:

>> $ perf trace -e write --max-events=3D1
>>
>>       0.000 ( 0.026 ms): gnome-shell/5454 write(fd: 5, buf:
>>         0x7fffa102d9b0, count: 8)

With the new buffer augmentation it should look like this:

perf $ ./perf trace -e write --max-events=3D1
     0.000 ( 0.011 ms): gmain/1408 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
count: 8)                         =3D

The new perf trace can be found on
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
perf-tools-next

perf $ git log
commit 1de5b5dcb8353f36581c963df2d359a5f151a0be (HEAD ->
struct-aug-arnaldo-2, perf/perf-tools-next)

Also, if you want to test the clang, you may want to checkout to the
commit before the clang-16 guard (otherwise you can't test different
clang version).

perf $ git log --oneline
1de5b5dcb835 (HEAD -> struct-aug-arnaldo-2, perf/perf-tools-next) perf
trace: Mark the 'head' arg in the set_robust_list syscall as coming
from user space
0c1019e3463b perf trace: Mark the 'rseq' arg in the rseq syscall as
coming from user space
edf3ce0ed38e perf env: Find correct branch counter info on hybrid
9953807c9e01 perf evlist: Print hint for group
eb9b9a6f5ab3 tools: Drop nonsensical -O6
89c0a55e550e perf pmu: To info add event_type_desc
f08cc258431d perf evsel: Add accessor for tool_event
925320737ae2 perf pmus: Fake PMU clean up
d3d5c1a00fcd perf list: Avoid potential out of bounds memory read
4ae354d73a8e perf help: Fix a typo ("bellow")
74298dd8acb8 perf ftrace: Detect whether ftrace is enabled on system
83420d5f5863 perf test shell probe_vfs_getname: Remove extraneous '=3D'
from probe line number regex
9327f0ecad48 perf build: Require at least clang 16.0.6 to build BPF
skeletons. **********[[[[[[[[[[[[!!!!(This is the clang
guard)]]]]]]]]]]*****
4c1af9bf97eb perf trace: If a syscall arg is marked as 'const', assume
it is coming _from_ userspace
e37b315c17df perf parse-events: Remove duplicated include in parse-events.c

My machine is debian 12, and I cannot build perf trace with the new
augmentation feature on clang-13, clang-14, and clang-15.

perf $ uname -r
6.11.0-061100rc7-generic

perf $ git log
commit 4c1af9bf97eb56d069421c3233ce61608458d5c8 (HEAD)

perf $ make CLANG=3D/bin/clang-13 && ./perf trace -e write --max-events=3D1
...
libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int sys_enter(struct syscall_enter_args *args) @
augmented_raw_syscalls.bpf.c:509
0: (bf) r7 =3D r1                       ; R1=3Dctx() R7_w=3Dctx()


perf $ make CLANG=3D/bin/clang-14 && ./perf trace -e write --max-events=3D1
...
libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int sys_enter(struct syscall_enter_args *args) @
augmented_raw_syscalls.bpf.c:509


perf $ make CLANG=3D/bin/clang-15 && ./perf trace -e write --max-events=3D1
libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0


perf $ make CLANG=3D/bin/clang-16 && ./perf trace -e write --max-events=3D1
     0.000 ( 0.010 ms): gmain/1408 write(fd: 4, buf: \1\0\0\0\0\0\0\0,
count: 8)                         =3D


Anyway thank you so much, I'll try to reproduce it on Ubuntu, like you
mentioned.

Thanks,
Howard


>>
