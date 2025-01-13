Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEC1AAA3D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789424; cv=none; b=a1+9s60m+RXN6+GuBWQg1vskYArB9+FrEv22lUZ2jTv6w+vQuzSVogyizKeOzfJRKAfQLVV1YoPa0JHZnRZA0s70GW2aJKVczoAO7uGqgW5zHNTCtk3LP0TMYvdrPPFxxNgOqHz3jF9H7P396lBfq8n5Ho5k9K5Uc0zmx2cuuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789424; c=relaxed/simple;
	bh=q9dt7T2kxh2ksAAIKPPdkrerh8F8r8F+Xqh8cUY+9Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUIF3SKUrbyA5ZLmYvrEbifXj1NNmbdSbZAyBoXi+DLUB8gat9rtjxZ0wP9kNRLhmI1vuO8u2mXLa+8DzsUBuNVZvxHF1uKvl5Qo800URZhlMcV6JRw34gDLRr+zd+N/KDdaJrJmF1Nrk+EZKJ7dleCl2qK36+T3batGG4NX/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+2uxO/r; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+2uxO/r"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a814c54742so328555ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736789422; x=1737394222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXuPa8TVlTiVWqQHEixqwitz1pTYvCwxg2IKbYzMpWs=;
        b=S+2uxO/r0Wb9PixLl/KOcz6pSsp/dNptQQd113EKler8L/QcqdHZZlwlm0Rg0ydMH+
         F9KPjVm5MvTYIq3SQdwagPr2VVQeMZUeJ0xUAuO/1WTny9VrdNqlX2EGQfuEaruIdHxX
         6pkFFauey745nrHTeQPLdbH5G6K5BTWWd2UCEcHysU0hJ7+UgIk1X4M1SuCNp3fkCa5/
         ZDSfiePqf5hOurYT7HnkYUyPNZKLMGza1zDl64XRSPsCsZknBCQV0hK6I814LT6RLS9a
         XLsSkcuaU4iNnV7Rx3dR0+bibz2UJ3DUzNDL4sWvDKEEqmDrt3bP4McTyCwIExQX8MDS
         XH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736789422; x=1737394222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXuPa8TVlTiVWqQHEixqwitz1pTYvCwxg2IKbYzMpWs=;
        b=W83jelrUie7d9WKA1LNwFOzDpt2NIcC9wrFt4BrAAq1d8T5B9FqTRkuSt0hwxHGXxG
         K/M3zdP4Cz/ZQRx9o5Xgcm2CElS0WUZpcQbI6pa/vLlprAUyqBexET0kAy0CnnVGF37T
         flFdCTW6pmJvKg4zWXn6ZiJMJ3fPYBkEy9ny+p5b4gGCaPE95lyWZg0BcIBFRjhCFB6p
         eDIvn/3vju2lsS86GpFWLvMgLUuKe58DzX7XYay3u5+AevemM2Hh60ap0aEHaTrMAewE
         FGEFAqXs/BXuezyndEzZ+oqHQ3ELAO8NCsBtRHMP/YVhaz6swlGaUSfnOXslReM32aBS
         q4lA==
X-Forwarded-Encrypted: i=1; AJvYcCU6FIpBfYQQ+WN6f0HxwCnG8BcDmCegLMGh2DVdH+pJ3pogkwJgB6JnGu8VtFQJKci8Wh2DjP9Yt29HgSwSd6EE@vger.kernel.org
X-Gm-Message-State: AOJu0YwoipOj0NqVs7/YpxIR6oacRc86DqRJZK73qpA0w5mU4UBWXUGC
	LstdXwesYDjWqhIKU2UNywH9IiJ6gWB+adfioHDtXAKoUwUu//e2LGLszkJzIeKo6Qa5naZpQxW
	Vfj2VrF9AfewdyCa0+a4T94S7x8t8ZZdQUmb0VWa+tnuZREzoqPyV
X-Gm-Gg: ASbGnctbMTNyjwBz7Xbe68yJ1B/vi1B3Ps9oDbw71K8ba3LWIoKnaIYoLU9yhPRoRDv
	y49+07KUg3w7Hs+QC2JyBKuGJhSW8H9ikH+OVEgdK0XcK1XjfW8IpSxOjQnY8ohMKatIzIA==
X-Google-Smtp-Source: AGHT+IE2sx4qDIrq8fYgSGJTLqsShCWh9kHpeWGmHHMq0VuwMrWZqdl8dWm+55qTxXbi08h7+tsfeT6SLVVDYoROVY4=
X-Received: by 2002:a05:6e02:12c2:b0:3ce:3711:3229 with SMTP id
 e9e14a558f8ab-3ce56c03376mr8878155ab.14.1736789421435; Mon, 13 Jan 2025
 09:30:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com>
 <c29a4cdc-9419-4f1e-92bc-a75c3b10e37d@intel.com>
In-Reply-To: <c29a4cdc-9419-4f1e-92bc-a75c3b10e37d@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Jan 2025 09:30:10 -0800
X-Gm-Features: AbW1kvb3D1yGkkahXdX_s0MCJLAseBq8X3uXWYK8KE2z9_AJTCAraCEUAAmAQrA
Message-ID: <CAP-5=fWjH9uU6eYAFXBY0X2KrvbU8xYAzwzPATYPMW1t46-pgg@mail.gmail.com>
Subject: Re: [PATCH] perf intel-pt: don't zero the whole perf_sample
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Tavian Barnes <tavianator@tavianator.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Andrew Kreimer <algonell@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:15=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 11/01/25 19:56, Tavian Barnes wrote:
> > C designated initializers like
> >
> >     struct perf_sample sample =3D { .ip =3D 0, };
> >
> > set every unmentioned field of the struct to zero.  But since
> > sizeof(struct perf_sample) =3D=3D 1384, this takes a long time.
> >
> > struct perf_sample does not need to be fully initialized, and even
>
> Yes it does need to be fully initialized.  Leaving members
> uninitialized in the hope that they never get used adds to
> code complexity e.g. how do you know they never are used,
> or future members never will be used.

First thought, perhaps we can use sanitizers to catch mistakes but
leave the default optimized code to not have any overhead.

Second thought, the perf_sample looks like:
```
$ pahole perf
...
struct perf_sample {
       u64                        ip;                   /*     0     8 */
       u32                        pid;                  /*     8     4 */
       u32                        tid;                  /*    12     4 */
       u64                        time;                 /*    16     8 */
       u64                        addr;                 /*    24     8 */
       u64                        id;                   /*    32     8 */
       u64                        stream_id;            /*    40     8 */
       u64                        period;               /*    48     8 */
       u64                        weight;               /*    56     8 */
       /* --- cacheline 1 boundary (64 bytes) --- */
       u64                        transaction;          /*    64     8 */
       u64                        insn_cnt;             /*    72     8 */
       u64                        cyc_cnt;              /*    80     8 */
       u32                        cpu;                  /*    88     4 */
       u32                        raw_size;             /*    92     4 */
       u64                        data_src;             /*    96     8 */
       u64                        phys_addr;            /*   104     8 */
       u64                        data_page_size;       /*   112     8 */
       u64                        code_page_size;       /*   120     8 */
       /* --- cacheline 2 boundary (128 bytes) --- */
       u64                        cgroup;               /*   128     8 */
       u32                        flags;                /*   136     4 */
       u32                        machine_pid;          /*   140     4 */
       u32                        vcpu;                 /*   144     4 */
       u16                        insn_len;             /*   148     2 */
       u8                         cpumode;              /*   150     1 */

       /* XXX 1 byte hole, try to pack */

       u16                        misc;                 /*   152     2 */
       u16                        ins_lat;              /*   154     2 */
       union {
               u16                p_stage_cyc;          /*   156     2 */
               u16                retire_lat;           /*   156     2 */
       };                                               /*   156     2 */
       union {
               u16                        p_stage_cyc;          /*
0     2 */
               u16                        retire_lat;           /*
0     2 */
       };

       _Bool                      no_hw_idx;            /*   158     1 */
       char                       insn[16];             /*   159    16 */

       /* XXX 1 byte hole, try to pack */

       void *                     raw_data;             /*   176     8 */
       struct ip_callchain *      callchain;            /*   184     8 */
       /* --- cacheline 3 boundary (192 bytes) --- */
       struct branch_stack *      branch_stack;         /*   192     8 */
       u64 *                      branch_stack_cntr;    /*   200     8 */
       struct regs_dump           user_regs;            /*   208   544 */
       /* --- cacheline 11 boundary (704 bytes) was 48 bytes ago --- */
       struct regs_dump           intr_regs;            /*   752   544 */
       /* --- cacheline 20 boundary (1280 bytes) was 16 bytes ago --- */
       struct stack_dump          user_stack;           /*  1296    24 */
       struct sample_read         read;                 /*  1320    40 */
        /* --- cacheline 21 boundary (1344 bytes) was 16 bytes ago --- */
       struct aux_sample          aux_sample;           /*  1360    16 */
       struct simd_flags          simd_flags;           /*  1376     8 */

       /* size: 1384, cachelines: 22, members: 39 */
       /* sum members: 1382, holes: 2, sum holes: 2 */
       /* last cacheline: 40 bytes */
};
```
The two regs_dump structs are 79% of the size. They comprise of:
```
struct regs_dump {
       u64                        abi;                  /*     0     8 */
       u64                        mask;                 /*     8     8 */
       u64 *                      regs;                 /*    16     8 */
       u64                        cache_regs[64];       /*    24   512 */
       /* --- cacheline 8 boundary (512 bytes) was 24 bytes ago --- */
       u64                        cache_mask;           /*   536     8 */

       /* size: 544, cachelines: 9, members: 5 */
       /* last cacheline: 32 bytes */
};
```
So the cache_regs are taking up the majority of the space. I have a
WIP patch set to make user_regs and intr_regs optional/lazily
allocated. I'll send it out shortly.

Thanks,
Ian
