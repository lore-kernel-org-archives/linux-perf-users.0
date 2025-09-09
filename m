Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2325DAF0
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Sep 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442725; cv=none; b=LrdBQwrRLJoEMtdg64wng8CnqZIjH4s9M8PcaZUYCSaKTvlb/Yrb4dQ3a9YKX7jDTEDqIizq1V0IG0UUZLDEIZWs7CdJPBTAGCjXGu1T08JiZfxjcl7J65fJXg9PsoDi5/Sw9vcF3KY5X7EQnhDktZENbLKbESbZndRcm7Juhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442725; c=relaxed/simple;
	bh=6AAUlrnohGGrI+J0MWrA1OGh0ETm6EyZ1CIiP3AnRCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC3csG8ca987OzFpkuG9QhbmZgtE02Xbn5fo6wDhX0ydfbDJuDsPdy2Kg51iA9V+TQp7IYOZDprTDCeIv4zQdfhure96Fi3/WZZ0sRiqserXgPofmhUgY5RgtDxOzVLh3jAK84IXSGAs9ZCSysT2pAcol+iEkFSvme1huMVuH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3x1fj1sq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3x1fj1sq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cf5bcfb60so26305ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Sep 2025 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757442723; x=1758047523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIPDNeClQeqdnLL/QKbandyvntWZcY3ztNetbZo+c00=;
        b=3x1fj1sqWkZwfX2dHcj5J7oEDfwg4nHxIxJVlMzH0ivxg+WBYRGqSZYkBKjMiTWPdV
         FjWkdEnLXzlSwTl/0UhMc5lIsh8uBRfNe2wGmbc2KqP3ggg75vVQY4CI6A1itZ7uUdqV
         /Hn/ATQWf2tMH1EMMhxMK4AtQi6xZT4tooqF2g1PUOJffo30y8lEiIpdqzidC7GFYwVY
         OIOA2F0SpCD/0cxn+Hsa0qgBkqzt3vgMM1t6+uQVeunypEDMFZpdfJveJX4x5SZhLETr
         tygC5F+mv9d9i1FcLevBiTWx/r5RQoUdU0Qgdpng1BI8LK4UcInKqRwI9Z4dc3l9CWfC
         NGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442723; x=1758047523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIPDNeClQeqdnLL/QKbandyvntWZcY3ztNetbZo+c00=;
        b=CxSNytcam2Y6LDOKjS9gnUZlGBziHxHDWLsK9tDs8lAWbY193qndTcA5ZP0LNkzjEJ
         suC1l6oU5l2foZSMFMv/5vg9AHzvqaHMfVgBuSGvEmkXLDP7Qzxum8jDSdjs/vdNDpJj
         csHeEiL6402m4/Lb+xnbSkhyeCPzOfZIqEZgjtSLgBoqnJCBkSHZGbOcgG4s3s6FRxNT
         WcCLslvLS0Dlahwjo8YHVo3HkR1MqOpxpqLfTplPNNNGFx9AGZrIOzXoBZ+mlv+EBzk2
         4J0SQbqGmuyndi7AFO5fOgmHKQzFGGj9XUVUzdoC3R2Y7BXdZPCd0jdUgjJ7s4fdOwnQ
         wceg==
X-Forwarded-Encrypted: i=1; AJvYcCWMkcMJ9p2pX4aRaQUjQpfwyYgFgAb4hqMBsAmCeL9S0pnIzTvsKRN9fqjDMSAbl9JosjQyAwHSetvTQBXFPXp6@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVVvpgcYEYdYer0PFbiVghabB7shlVmU3ZkieJMj0/NF84V8v
	6CfQyCVt0EkSYDVBIPCu2e40G94Do6PeaqwkPPebIs/kZVibFi2i+8sC3wMJJ9f7r0XpFOq/JFb
	1o9hw0xcX3Hf8iqJUqA1v83v3PR/DpcT+NldKuc2L
X-Gm-Gg: ASbGncv3vGaVFQCtpLd/j37Mb3MwJiyLQZ2EpRrlSw7keJhAVwmoaqjemED4dybEvOR
	/oWiEjtefYcv/odshWAbLnzEK+CBC2+o3quEbwblkCAdGDIPocdMeMNJNH5pShvDr2pVKEptQTN
	eN+xZ0V6npsY/ZbcN6kHL/Z41f0P/WAHBtUxCA/FMQSTgh/miN5R7fw5PsMl0Pah9kQ6CfqkoRZ
	wxnp/dQnh7hDJyys5Vfila/yuDQU2v88WauxxhqXjhyb+7iLKsFjOB7wZCU6EMOmg==
X-Google-Smtp-Source: AGHT+IGZLwzdjypUrYwsHkVBGt+rdl3qjVNxww8nM8h1q9KwE/jrMFjGashARVH68XP4Y+EA2LtLQmYuSwlViGOmG1c=
X-Received: by 2002:a17:903:185:b0:248:f683:e980 with SMTP id
 d9443c01a7336-25a539a4fecmr487735ad.2.1757442722903; Tue, 09 Sep 2025
 11:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701201027.1171561-3-namhyung@kernel.org> <20250909094953.106706-1-amadio@gentoo.org>
In-Reply-To: <20250909094953.106706-1-amadio@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Sep 2025 11:31:51 -0700
X-Gm-Features: Ac12FXymMBpx6OEzUcR2rYto9x8srb0rgq2MgfkIOdb5qVU4JRQYY3mKRpIU3is
Message-ID: <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
Subject: Re: perf --help triggers an assertion
To: Guilherme Amadio <amadio@gentoo.org>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:49=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi Namhyung,
>
> I was updating perf's package in Gentoo Linux and noticed some problems
> which were not there before. I tested with the version below and the prob=
lem
> still seems to be there. perf --help triggers an assertion (see below).
> Looking in the list, it seems related to the patch below:
>
> https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyun=
g@kernel.org/
>
> Cheers,
> -Guilherme
>
> The problem:
>
> gentoo perf $ ./perf --help
> perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
> Aborted                    (core dumped) ./perf --help
>
> Some extra information:
>
> gentoo perf $ ./perf version
> perf version 6.17.rc5.gf777d1112ee5
> gentoo perf $ ./perf test subcmd
>  69: libsubcmd help tests                                            :
>  69.1: Load subcmd names                                             : Ok
>  69.2: Uniquify subcmd names                                         : Ok
>  69.3: Exclude duplicate subcmd names                                : Ok
> gentoo perf $ ./perf bad-command
> perf: 'bad-command' is not a perf-command. See 'perf --help'.
> gentoo perf $ ./perf --help
> perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
> Aborted                    (core dumped) ./perf --help
> gentoo perf $ gdb run --args ./perf --help
> GNU gdb (Gentoo 16.3 vanilla) 16.3
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://bugs.gentoo.org/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
>
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./perf...
> (gdb) run
> Starting program: /home/amadio/src/linux/tools/perf/perf --help
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
>
> Program received signal SIGABRT, Aborted.
> __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ER=
RNO (ret) : 0;
> (gdb) bt
> #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> #1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=3D<optimized =
out>, signo=3Dsigno@entry=3D6) at pthread_kill.c:89
> #2  0x00007ffff74c166d in __GI___pthread_kill (threadid=3D<optimized out>=
, signo=3Dsigno@entry=3D6) at pthread_kill.c:100
> #3  0x00007ffff747509c in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
> #4  0x00007ffff747637e in __GI_abort () at abort.c:77
> #5  0x00007ffff746e023 in __assert_fail_base (fmt=3D<optimized out>, asse=
rtion=3Dassertion@entry=3D0x555555974d03 "cmds->names[ci] =3D=3D NULL",
>     file=3Dfile@entry=3D0x555555974cfc "help.c", line=3Dline@entry=3D104,=
 function=3Dfunction@entry=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclud=
e_cmds")
>     at assert.c:118
> #6  0x00007ffff746e075 in __assert_fail (assertion=3D0x555555974d03 "cmds=
->names[ci] =3D=3D NULL", file=3D0x555555974cfc "help.c", line=3D104,
>     function=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds") at =
assert.c:127
> #7  0x0000555555693813 in exclude_cmds (cmds=3D0x55555614e5e0 <other_cmds=
>, excludes=3D0x55555614e5c0 <main_cmds>) at help.c:104
> #8  0x0000555555693eb3 in load_command_list (prefix=3D0x555555954071 "per=
f-", main_cmds=3D0x55555614e5c0 <main_cmds>,
>     other_cmds=3D0x55555614e5e0 <other_cmds>) at help.c:252
> #9  0x00005555555e9987 in cmd_help (argc=3D1, argv=3D0x7fffffffd1a0) at b=
uiltin-help.c:458
> #10 0x0000555555685d45 in run_builtin (p=3D0x555556130de0 <commands+192>,=
 argc=3D1, argv=3D0x7fffffffd1a0) at perf.c:349
> #11 0x0000555555685fe1 in handle_internal_command (argc=3D1, argv=3D0x7ff=
fffffd1a0) at perf.c:401
> #12 0x0000555555686142 in run_argv (argcp=3D0x7fffffffcfac, argv=3D0x7fff=
ffffcfa0) at perf.c:445
> #13 0x0000555555686493 in main (argc=3D1, argv=3D0x7fffffffd1a0) at perf.=
c:553
> (gdb) quit

Thanks Guilherme,

I tried to reproduce the same version with various options: DEBUG=3D1
-UNDEBUG in EXTRA_CFLAGS, -fsanitize=3Daddress. Being in various
directories with "perf-" prefixed files. I'm afraid I wasn't able to
reproduce. The assert is trying to avoid a memory leak, so
non-critical, and I couldn't in a quick inspection eye-ball an issue.
Without getting a reproduction I don't think I can make progress with
the issue.

Thanks,
Ian
