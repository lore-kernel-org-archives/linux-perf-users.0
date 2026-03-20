Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409B19ABD8
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773981707; cv=pass; b=XAOvd/Y8eF3rmD143urawl/DOcO6RIEHsb14XppWHvUYGArTrRVL6XfqFm1g2njoKotPzmvLw+YJgqaJT4VYjuVaYGDJKgX9Zjw5WAHFsPisw8QUv1z/KGMt2cSd75WGUeTA7r8JnEaQxBUHz7Ss8072Bb1LlFg7o4uHnIX5CaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773981707; c=relaxed/simple;
	bh=Qu9ynk1ckoA7jcRWTQsEwk+bo7+Skjo94p0isOgfn5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzV17VY6v8K90keji7GrsoXjRtHsp4x74NHjtpXMmQVBG7A7JBqpH157DWUImBkG9jtjCX6Ja4SQSN3JJxKlkogjeBRHuLRu8q6txdtjnub+DyNZmJf9L+QKhiXNFM9Xt+wwiEDXv4+cbjotjBNWzbUNbvFMhRpbyXtHrQEn3cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UE0qa1Fm; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UE0qa1Fm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b052ec7176so34475ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 21:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773981706; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/K9Sf6REQjsMprm84JXfM0QeqdvswSWsiletPHV/F94fKiIs4DcAlMj/tjU9GdzTC
         s5YlZydugYIMTVBoBl6bftZJdJ+1imxJz/SnshKbWCqVv5vBUgBP23OZmXUaiB8rNDJD
         W+W9cCn2bbnuCxehnnp3J99zsbJg/GVWM1CogNkFxF7Q4UTNZEK+bC6jjgsBVl1iR5nq
         cr0IS4HymIVnIRSKugzoYVleadBcdgWNpAobMA1MYP4t8Qz5G1h8l63UXpQhrYZmFsxz
         NFv7utgHtMnXSi4hCCEf40X5pdj9tSojcAVtaxCheJ2gdh5ffv+Fz0p1gsjLVMdJLKow
         60RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uohoBMP5HkASaFKxCxMD8Vj43rtHEGp54XIfdjkUR+Y=;
        fh=MgL0bYARlvWLcLbl36l+gi3QSsmJRzmAGiCMnzqQ1G4=;
        b=VoG0HdiUV76YXtbR54yzUDPm4PamJyg6i9DUoCRU+bfkmtEJfNr6UOQM5eQkLeIFmn
         W5Cmc5r/O/tsZ8ElAHxxfI8rO70oCfwTzqVlE4sfe54t5MFexilGFDp06eY9q/2FYsjK
         LlkiQ26nMvDMKW255aHeCQZfChZAk8oLVTfdI1gyc5y5Bsc3eFFi5m2YnHMBn4QTFzcp
         NKmO/l6J1NrdCoQ0XUrUx+K1Jr2L6ErdfGcv1MgN5um4agWt3RF5+Fbn4u0s4/BJ6z07
         XOdq9pmWgrrPzjWgDu0i0or3HLshexReR1icTleVnUZoBGD/j/Uw1CKq86Q56GE6n4O7
         WoXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773981706; x=1774586506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uohoBMP5HkASaFKxCxMD8Vj43rtHEGp54XIfdjkUR+Y=;
        b=UE0qa1FmBnA+RJmemMZJ6BzFno1zHPkbe0/iZPAPasgt6vtyDmLxeKwdw2ZWS+u68w
         Un48fEx6iMmxQEnDWk9Bj91W7kdKSK3ivTH8smEz/4uz51hiyKjboN/r6qBptyDbOcvR
         NiINqsNZhrlsB/acP8Kml9vejMVv79tEAsU6b2DQlUGB2U8/Zey7VoUZKhKZJvMXrN9d
         uagDwtaJ4ZV+yR8eKdgtKSHLuu/TLH6eaD5iRIqjvz+WngyEGwIB5vXHLIWJ0TwN9k/z
         oPEcwSvRYzqwToyxc4sfKQsAw+XlrVc4MsU8INPy0TKPDnEeKCrJWSRd1WdhDVO+mkiA
         FEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773981706; x=1774586506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uohoBMP5HkASaFKxCxMD8Vj43rtHEGp54XIfdjkUR+Y=;
        b=p1K+6v+KICu2Qp/u9GJNQuGlDZhCe/RMfa5s+ZmwkfPEFOZ46Fen513gydFJ3Kr+sr
         4f5MssdV+QnGPjjQ2xSgrM5PEk+wYNs1gGZIs76CCSE5pu7MmiGPiLDROWmQJVZDk0Dw
         U5AxqCH9hlduWreHmG8gFFLI2NGtNY/xQ9nbXtTWpJPgH+PB/wPNOIJOvvZn0RN8gRl3
         3duiCwB3j0m5M4Jd/nUAbV1Ex3gSHtE9MusjgoxOVrDYfj+5aRTFM3B6+pN868szIlgS
         am5JL2K3JaYpwz/nEoBo0jFE01+sZ19ruHkufRfVr2E5XJRy7ckGY4p35TW5Cpnm2ssz
         W5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW/FuX/h1qyom2GxVMsZuJUB6I92uYyjo4AS3n3vj4/uJp0WmHWi4e+T2vlJBFz8qLRuLEyXNaPCOp1FDKMcY6v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EJG8V1aihdqQno0Ms+sNKrlRW/T/qyyIIojRgECgoxLUROsL
	z7TlhjqaqYiR1hpxnfC38wDT54V9B9Dd9lZjeMOLR95+GNEta97z6LwnV93b8XpaTTBAlmqsWef
	7xu6VzxPnl7SmWv1R8w3NkuRt7tOjAjUA0hklTLVj
X-Gm-Gg: ATEYQzzTGk2BMyRGt0TpQgnhRDLLOgiLIe5TyNIrUIMGzOGrxEFA20uwdkdg5Uz2QGh
	BaTZUePgarpNtjAiffqRa4teLu91N1Vh0XB1iNjEBPJSvHs04N+4fnGcfsB0itPJ/BI8jpz7r37
	3+LIrzpJOuHaP71saID9H/a8CwqUzbVS1F5TQBct7X8WjiZM30J/6LOm42L9yk+L9ITgOzeY8LC
	TDHnuqYHeyqp9tM1CuGz4eDc3BynboJ46/Pxcp7NKjhVC7w5zfgpB5UM6DIknGpm/MSQcJHGphT
	jlvMJ/9Q
X-Received: by 2002:a17:903:2449:b0:2b0:5b4c:a439 with SMTP id
 d9443c01a7336-2b08282922emr1675445ad.2.1773981704943; Thu, 19 Mar 2026
 21:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260209174032.4142096-2-irogers@google.com>
 <aaZQZI2ElVhblz-t@google.com>
In-Reply-To: <aaZQZI2ElVhblz-t@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Mar 2026 21:41:33 -0700
X-Gm-Features: AaiRm504X-nnjrdc9ma65X_4Vp1hA4PSpI5tAndSHpxweoEhstu8kzjBJitnrrg
Message-ID: <CAP-5=fW+-1oP16Uyk1zSkU6c4=eg0aNpqNbE_v_0dxqJiq-PCg@mail.gmail.com>
Subject: Re: [PATCH v1 01/25] perf sample: Document struct perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Chen Ni <nichen@iscas.ac.cn>, 
	Blake Jones <blakejones@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 7:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Feb 09, 2026 at 09:40:08AM -0800, Ian Rogers wrote:
> > Add kernel-doc for struct perf_sample capturing the somewhat unusual
> > population of fields and lifetime relationships.
>
> Thanks for doing this.
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/sample.h | 90 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 87 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> > index 3cce8dd202aa..3fd2a5e01308 100644
> > --- a/tools/perf/util/sample.h
> > +++ b/tools/perf/util/sample.h
> > @@ -81,47 +81,131 @@ struct simd_flags {
> >  #define SIMD_OP_FLAGS_PRED_PARTIAL   0x01    /* partial predicate */
> >  #define SIMD_OP_FLAGS_PRED_EMPTY     0x02    /* empty predicate */
> >
> > +/**
> > + * struct perf_sample
> > + *
> > + * A sample is generally filled in by evlist__parse_sample/evsel__pars=
e_sample
> > + * which fills in the variables from a "union perf_event *event" which=
 is data
> > + * from a perf ring buffer or perf.data file. The "event" sample is va=
riable in
> > + * length as determined by the perf_event_attr (in the evsel) and deta=
ils within
> > + * the sample event itself. A struct perf_sample avoids needing to car=
e about
> > + * the variable length nature of the original event.
> > + *
> > + * To avoid being excessively large parts of the struct perf_sample ar=
e pointers
> > + * into the original sample event. In general the lifetime of a struct
> > + * perf_sample needs to be less than the "union perf_event *event" it =
was
> > + * derived from.
> > + *
> > + * The struct regs_dump user_regs and intr_regs are lazily allocated a=
gain for
> > + * size reasons, due to them holding a cache of looked up registers. T=
he
> > + * function pair of perf_sample__init and perf_sample__exit correctly =
initialize
> > + * and clean up these values.
> > + */
> >  struct perf_sample {
> > +     /** @ip: The sample event PERF_SAMPLE_IP value. */
> >       u64 ip;
> > -     u32 pid, tid;
> > +     /** @pid: The sample event PERF_SAMPLE_TID pid value. */
> > +     u32 pid;
> > +     /** @tid: The sample event PERF_SAMPLE_TID tid value. */
> > +     u32 tid;
> > +     /** @time: The sample event PERF_SAMPLE_TIME value. */
> >       u64 time;
> > +     /** @addr: The sample event PERF_SAMPLE_ADDR value. */
> >       u64 addr;
> > +     /** @id: The sample event PERF_SAMPLE_ID value. */
> >       u64 id;
> > +     /** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
> >       u64 stream_id;
> > +     /** @period: The sample event PERF_SAMPLE_PERIOD value. */
> >       u64 period;
> > +     /** @weight: Data determined by PERF_SAMPLE_WEIGHT or PERF_SAMPLE=
_WEIGHT_STRUCT. */
> >       u64 weight;
> > +     /** @transaction: The sample event PERF_SAMPLE_TRANSACTION value.=
 */
> >       u64 transaction;
> > +     /** @insn_cnt: Filled in and used by intel-pt. */
> >       u64 insn_cnt;
> > +     /** @cyc_cnt: Filled in and used by intel-pt. */
> >       u64 cyc_cnt;
> > +     /** @cpu: The sample event PERF_SAMPLE_CPU value. */
> >       u32 cpu;
> > +     /**
> > +      * @raw_size: The size in bytes of raw data from PERF_SAMPLE_RAW.=
 For
> > +      *            alignment reasons this should always be a multiple =
of
> > +      *            sizeof(u64) + sizeof(u32).
> > +      */
> >       u32 raw_size;
> > +     /** @data_src: The sample event PERF_SAMPLE_DATA_SRC value. */
> >       u64 data_src;
> > +     /** @phys_addr: The sample event PERF_SAMPLE_PHYS_ADDR value. */
> >       u64 phys_addr;
> > +     /** @data_page_size: The sample event PERF_SAMPLE_DATA_PAGE_SIZE =
value. */
> >       u64 data_page_size;
> > +     /** @code_page_size: The sample event PERF_SAMPLE_CODE_PAGE_SIZE =
value. */
> >       u64 code_page_size;
> > +     /** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
> >       u64 cgroup;
> > +     /** @flags: Extra flag data from auxiliary events like intel-pt. =
*/
> >       u32 flags;
> > +     /** @machine_pid: The guest machine pid derived from the sample i=
d. */
> >       u32 machine_pid;
> > +     /** @vcpu: The guest machine vcpu derived from the sample id. */
> >       u32 vcpu;
> > +     /** @insn_len: Instruction length from auxiliary events like inte=
l-pt. */
> >       u16 insn_len;
>
> Does it control the insn array later?
>
>
> > +     /**
> > +      * @cpumode: The cpumode from struct perf_event_header misc varia=
ble
> > +      *           masked with CPUMODE_MASK. Gives user, kernel and hyp=
ervisor
> > +      *           information.
> > +      */
> >       u8  cpumode;
> > +     /** @misc: The entire struct perf_event_header misc variable. */
> >       u16 misc;
> > +     /** @ins_lat: Instruction latency information from auxiliary even=
ts like intel-pt. */
> >       u16 ins_lat;
>
> I think this is weight2 coming from PERF_SAMPLE_WEIGHT_STRUCT.
>
>
> >       /** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_c=
yc. */
> >       u16 weight3;
>
> You may also want to mention it's from WEIGHT_STRUCT.
>
>
> > -     bool no_hw_idx;         /* No hw_idx collected in branch_stack */
> > -     bool deferred_callchain;        /* Has deferred user callchains *=
/
> > +     /**
> > +      * @no_hw_idx: For PERF_SAMPLE_BRANCH_STACK, true when
> > +      *             PERF_SAMPLE_BRANCH_HW_INDEX isn't set.
> > +      */
> > +     bool no_hw_idx;
> > +     /**
> > +      * @deferred_callchain: When processing PERF_SAMPLE_CALLCHAIN a d=
eferred
> > +      *                      user callchain marker was encountered.
> > +      */
> > +     bool deferred_callchain;
>
> If this is set, then callchain entry is allocated for deferred
> callchains.

So when deferred_callchain is set this isn't true. The callchain
points into the event:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n3384

>
>
> > +     /**
> > +      * @deferred_cookie: Identifier of the deferred callchain in the =
later
> > +      *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
> > +      */
> >       u64 deferred_cookie;
> > +     /** @insn: A copy of the sampled instruction filled in by perf_sa=
mple__fetch_insn. */
> >       char insn[MAX_INSN];
> > +     /** @raw_data: Byte aligned pointer into the original event for P=
ERF_SAMPLE_RAW data. */
>
> I think it's 32-bit aligned (or shifted) as it comes right after the
> raw_size (32-bit).  As other fields in the event are 64-bit aligned this
> caused some troubles like in perf trace when you access the pointer
> directly and assume it's naturally aligned.
>
>
> >       void *raw_data;
> > +     /** @callchain: Pointer into the original event for PERF_SAMPLE_C=
ALLCHAIN data. */
> >       struct ip_callchain *callchain;
>
> If deferred_callchain is not set, it just points to data in the mmap
> buffer and it should not be freed.

But if deferred_callchain is set this may also be true. Sashiko is
picking up on the inconsistencies. I'll weasel word it by referring to
the sample__merge_deferred_callchain function.

Thanks,
Ian

> > +     /** @branch_stack: Pointer into the original event for PERF_SAMPL=
E_BRANCH_STACK data. */
> >       struct branch_stack *branch_stack;
> > +     /**
> > +      * @branch_stack_cntr: Pointer into the original event for
> > +      *                     PERF_SAMPLE_BRANCH_COUNTERS data.
> > +      */
> >       u64 *branch_stack_cntr;
> > +     /** @user_regs: Values and pointers into the sample for PERF_SAMP=
LE_REGS_USER. */
> >       struct regs_dump  *user_regs;
> > +     /** @intr_regs: Values and pointers into the sample for PERF_SAMP=
LE_REGS_INTR. */
> >       struct regs_dump  *intr_regs;
> > +     /** @user_stack: Size and pointer into the sample for PERF_SAMPLE=
_STACK_USER. */
> >       struct stack_dump user_stack;
> > +     /** @read: The sample event PERF_SAMPLE_READ counter values. */
>
> The actual format depends on read_format in the event attribute.
>
> Thanks,
> Namhyung
>
>
> >       struct sample_read read;
> > +     /**
> > +      * @aux_sample: Similar to raw data but with a 64-bit size and
> > +      *              alignment, PERF_SAMPLE_AUX data.
> > +      */
> >       struct aux_sample aux_sample;
> > +     /** @simd_flags: SIMD flag information from ARM SPE auxiliary eve=
nts. */
> >       struct simd_flags simd_flags;
> >  };
> >
> > --
> > 2.53.0.239.g8d8fc8a987-goog
> >
