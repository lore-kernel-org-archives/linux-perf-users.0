Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9B1BD9D8
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797553; cv=none; b=r5XL17+8KLWSAA649Trrd7HKNQ4VJT3zYF0+1uGWzYt9AyiN5qT8keNIJoxnzgaqLt/nvzOwSnipUKABBx6dvF4A9qJOuBv/o02ImquaXb/Ow0gh96abueYdux6EEtB6qdK9n/EOod515x3QGXbXRUx3Hne7+UdKrpePYcxq/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797553; c=relaxed/simple;
	bh=KeNlaPvzChcjf3R2kGDxqjzOsCcORxgIpry4AfDj4lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+Im+ui65nWQAJkfv7VoBD/0wO0f8CoS4+zHmaPYOyKYoGkP3NE5LDAgL7T8LSzV+Jqsn4q26QtKXJ9sX/3Kb/DAvNJkEwJampuh0kmSl9QR3g2gZ9tOEsTQz96SFxApr7z9cbvcQEJso3G5SWbGU8/0BUyLq1HTU1Wg7hTP6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pxk/27O; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pxk/27O"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a814c54742so20045ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736797551; x=1737402351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzaZxcXDEFLe3xIBNkpQCPFqJ0x+en9zj51Bgj1MHWQ=;
        b=0pxk/27Oq/V0aZ2s+iZTJHF+cK0q+/NAp9kNPEFJBLEO+xRBdXeYldDpAgeMQHpVtN
         fZSGY/juDbdi+ujedOjXAZHCUsL0SvNOPZ4foGKIVbIXVu7vqovSIvlY9uNG82rkExZs
         cMo/D0qaVAOrzx3VrBUDLxA0j42jwATxcT88oxu9t1iRdPYhB3KPx9J4jmV/U43UslJl
         c9yXZOOmylRuzm/zkBg5JK1uWDQCEmW37XJHrOe6oqYuixbGMXTX4Z3gCXjmiWV9ACf/
         Fv7c0Tq1OYtwB6FG/YO7A9BJ8QrAfxm9/hqijYo73x5hJxAoK9xClDMl7bJUtBWrb0GY
         HHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736797551; x=1737402351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzaZxcXDEFLe3xIBNkpQCPFqJ0x+en9zj51Bgj1MHWQ=;
        b=DDEDkWAVL1y/MBSKlPdfiWnkO0x+behY3vk4+psxnGun0SY/0sLQAtotC3rvqbY1We
         guPKrcE9cMSufdZwHg4AlQ9phJTWHAVAENv9e7P/JjwJaWRMXVcK6rU72CjT3u229E7b
         L3HtKIGzzCiXkhlVtZiqEKq6jL1HhftKXxm3MaOmgJaqXTJKwDl76DdUCHHia8F/PQb8
         cfSNCnTKIQjGoPXDBUL6HSZHdx+4Vw52WltqgyI8iARAjzRrbKucJ6L6AWN5U/jO/Ert
         sn0L4a9VHJjrz62XN/vV5KaNG+XP9BqrnB98Kcqf1MHX74+OPDMM/ktJXCM21fWytBW/
         /vAg==
X-Forwarded-Encrypted: i=1; AJvYcCX35mLD94h2sIQswJkLBXa4fKKLYYykTQDUPodAVN9bawpnKShv3Hi70LXOsNohL3mwbZmhk83AK+AHXLmUZHOf@vger.kernel.org
X-Gm-Message-State: AOJu0YwRC+T+g12Z/zWqi5fMdm6aaTe8afFpCL+j0/gvDMhZquV0J/W/
	ctJvobQb/EZmYBkcBhDbC1DxyUj3/1l/Vk5vA5C9/t3v4JayW/yyDiXie/eAcjdF6RDp3qhnob8
	z+YeB9fx0oPqubEa8I1fVL8uB1xIdovtCyroB
X-Gm-Gg: ASbGncsq4r2+HAjkmfjiRzkIK1NFoucfTal3nvLPNiZOPxnmcOwdFvThQQWiHC7X0D5
	9gHJzRDuzFov1JEO4aFsiCXFm5Kn5T4ACSYuCi8LSFoJRYe2FlVRPHRMMKIUzv/E5Yt4NQQ==
X-Google-Smtp-Source: AGHT+IEmtxbOrY9+g5mPjy4uXM2KP3iH8q9Z2TSZqn3G+G/4yD1BKVTobi8RELPxFpmeFB6/d4ETG7ICILV00WbGLCY=
X-Received: by 2002:a05:6e02:1a25:b0:3ce:2f93:a02b with SMTP id
 e9e14a558f8ab-3ce7ac5662fmr300905ab.12.1736797551035; Mon, 13 Jan 2025
 11:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com>
 <c29a4cdc-9419-4f1e-92bc-a75c3b10e37d@intel.com> <CAP-5=fWjH9uU6eYAFXBY0X2KrvbU8xYAzwzPATYPMW1t46-pgg@mail.gmail.com>
In-Reply-To: <CAP-5=fWjH9uU6eYAFXBY0X2KrvbU8xYAzwzPATYPMW1t46-pgg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Jan 2025 11:45:39 -0800
X-Gm-Features: AbW1kvZ2Ru9IOyn2Ibq009AMGr3gOWt70W4rwczKVDCQ2WVNcSOhUQKNis9-D-M
Message-ID: <CAP-5=fXrCMJW-j9Y1qvrxxymLnjOt4GCQ5pdMPSPrT9ZmDPA3g@mail.gmail.com>
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

On Mon, Jan 13, 2025 at 9:30=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jan 13, 2025 at 12:15=E2=80=AFAM Adrian Hunter <adrian.hunter@int=
el.com> wrote:
> >
> > On 11/01/25 19:56, Tavian Barnes wrote:
> > > C designated initializers like
> > >
> > >     struct perf_sample sample =3D { .ip =3D 0, };
> > >
> > > set every unmentioned field of the struct to zero.  But since
> > > sizeof(struct perf_sample) =3D=3D 1384, this takes a long time.
> > >
> > > struct perf_sample does not need to be fully initialized, and even
> >
> > Yes it does need to be fully initialized.  Leaving members
> > uninitialized in the hope that they never get used adds to
> > code complexity e.g. how do you know they never are used,
> > or future members never will be used.
>
> First thought, perhaps we can use sanitizers to catch mistakes but
> leave the default optimized code to not have any overhead.
>
> Second thought, the perf_sample looks like:
> ```
> $ pahole perf
> ...
> struct perf_sample {
>        u64                        ip;                   /*     0     8 */
>        u32                        pid;                  /*     8     4 */
>        u32                        tid;                  /*    12     4 */
>        u64                        time;                 /*    16     8 */
>        u64                        addr;                 /*    24     8 */
>        u64                        id;                   /*    32     8 */
>        u64                        stream_id;            /*    40     8 */
>        u64                        period;               /*    48     8 */
>        u64                        weight;               /*    56     8 */
>        /* --- cacheline 1 boundary (64 bytes) --- */
>        u64                        transaction;          /*    64     8 */
>        u64                        insn_cnt;             /*    72     8 */
>        u64                        cyc_cnt;              /*    80     8 */
>        u32                        cpu;                  /*    88     4 */
>        u32                        raw_size;             /*    92     4 */
>        u64                        data_src;             /*    96     8 */
>        u64                        phys_addr;            /*   104     8 */
>        u64                        data_page_size;       /*   112     8 */
>        u64                        code_page_size;       /*   120     8 */
>        /* --- cacheline 2 boundary (128 bytes) --- */
>        u64                        cgroup;               /*   128     8 */
>        u32                        flags;                /*   136     4 */
>        u32                        machine_pid;          /*   140     4 */
>        u32                        vcpu;                 /*   144     4 */
>        u16                        insn_len;             /*   148     2 */
>        u8                         cpumode;              /*   150     1 */
>
>        /* XXX 1 byte hole, try to pack */
>
>        u16                        misc;                 /*   152     2 */
>        u16                        ins_lat;              /*   154     2 */
>        union {
>                u16                p_stage_cyc;          /*   156     2 */
>                u16                retire_lat;           /*   156     2 */
>        };                                               /*   156     2 */
>        union {
>                u16                        p_stage_cyc;          /*
> 0     2 */
>                u16                        retire_lat;           /*
> 0     2 */
>        };
>
>        _Bool                      no_hw_idx;            /*   158     1 */
>        char                       insn[16];             /*   159    16 */
>
>        /* XXX 1 byte hole, try to pack */
>
>        void *                     raw_data;             /*   176     8 */
>        struct ip_callchain *      callchain;            /*   184     8 */
>        /* --- cacheline 3 boundary (192 bytes) --- */
>        struct branch_stack *      branch_stack;         /*   192     8 */
>        u64 *                      branch_stack_cntr;    /*   200     8 */
>        struct regs_dump           user_regs;            /*   208   544 */
>        /* --- cacheline 11 boundary (704 bytes) was 48 bytes ago --- */
>        struct regs_dump           intr_regs;            /*   752   544 */
>        /* --- cacheline 20 boundary (1280 bytes) was 16 bytes ago --- */
>        struct stack_dump          user_stack;           /*  1296    24 */
>        struct sample_read         read;                 /*  1320    40 */
>         /* --- cacheline 21 boundary (1344 bytes) was 16 bytes ago --- */
>        struct aux_sample          aux_sample;           /*  1360    16 */
>        struct simd_flags          simd_flags;           /*  1376     8 */
>
>        /* size: 1384, cachelines: 22, members: 39 */
>        /* sum members: 1382, holes: 2, sum holes: 2 */
>        /* last cacheline: 40 bytes */
> };
> ```
> The two regs_dump structs are 79% of the size. They comprise of:
> ```
> struct regs_dump {
>        u64                        abi;                  /*     0     8 */
>        u64                        mask;                 /*     8     8 */
>        u64 *                      regs;                 /*    16     8 */
>        u64                        cache_regs[64];       /*    24   512 */
>        /* --- cacheline 8 boundary (512 bytes) was 24 bytes ago --- */
>        u64                        cache_mask;           /*   536     8 */
>
>        /* size: 544, cachelines: 9, members: 5 */
>        /* last cacheline: 32 bytes */
> };
> ```
> So the cache_regs are taking up the majority of the space. I have a
> WIP patch set to make user_regs and intr_regs optional/lazily
> allocated. I'll send it out shortly.

Sent as:
https://lore.kernel.org/lkml/20250113194345.1537821-1-irogers@google.com/

Thanks,
Ian
