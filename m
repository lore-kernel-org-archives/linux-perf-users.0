Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7325334B
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641498; cv=none; b=OuXshG0DBd2TH0LHZ6grywVG6eYcNalc6cseZGj5iaCVeNgeDNhOtwhUWCoxcfhXZdNVz0AYDFpdmbJTE3DVhCH+WmU3JxrIWMtNknxLDoAZFU35EI29A5Ci7qtz6gLAg2q1fjcniHLDRPLSebzJdYfPNY5L+lh8dNsZmbe914c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641498; c=relaxed/simple;
	bh=5EbTfCGmVfE/X7Z/ipstJE3RcvDhvzYcTBQuVyMfcT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8Xm4juOgJqU/o4rdKcxpuFcEe6H+hPAgZ4RUHsALSLj/BGNXV0udXulMG4nDhclxFJvpX+9gZ94RpwAibQtonw2ji25w97mpZjFfU8tyrN5nvDni9uY4jgFBxJ9fgzeO6pvC5ZRbDRS5ncBpCD9047uzLY+JYwSEy7RZM+fSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsdVciYg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsdVciYg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7277324204so51742266b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jan 2026 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641494; x=1768246294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKP8BXcQ6rjEgwWhGXyvSC3sJuSoh+CpPU6v8uC/NLU=;
        b=nsdVciYgaPDxR2s3Tdhz8Oyyvj6QivVZhV3NzQIUtVTo1pkB5qL4pIXLgDJQYo4pIW
         MBEOxOJTO76VWnmmLNAVBeDOt2nSpLWMnFoTCZStMwg0G1Yk/bfLnq/Np8f/jbmmuwam
         rE5WkD4spU1bu8K6KKrzTn29bPlPv7ASo7YgaWFHQmJ5WKQfN0Qvbje8tt8QZx4SrGtH
         u8w0Ah9B92m6p7/yIlqbWwgqu24dAdWcskR0FH8Bo9PL22l0RnP26Kgc7M7zRVncm6uD
         797k9hGGGVNTJ5PRO2E9sgpsPc/0yCDiWZA/89UmIqJ5g9xoyp1Qyv3KmKCq/IDuHVHd
         Zi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641494; x=1768246294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKP8BXcQ6rjEgwWhGXyvSC3sJuSoh+CpPU6v8uC/NLU=;
        b=EglNOvt8ANVxmvN8vkHetKVoqyueivLbUOLjf36pKS0z2XW0MThDjNpMfyV/xuM+sK
         GIpeQ4gLVB7ZhcpHcqibrk2A5zP3NBLH9m+mEou9jeslb3C4Yy8H/oh0bur1Ge6DszFv
         YECMhjdCPT/xzmqpc0AXBKuApmIyPRrcoB+7Uq6Jm9LPZoOvcmTZU91MKOHakkOym3U3
         wgeYNHH4wdWg8tvaczNYTt4kZqI7uxaaa9Lo+5Dq78LtNSs/huDw1TDD/EqchfBnA0sP
         ODQqVH0T7ZAM3pm1bH7bF85tBGEllH92r28eDnYXlPedbE7cXszgiirbaRQZrSAU14Vh
         f0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV281e15r4aqfBWcPq+mwjxG+NeDMXqLfl74WL0fW26KP6VqifR89qRjr8GeQ1hzHNskjP0E0h26k+5/+4Oi2r@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1m10n3PijFrvRIZdN9zZIUM5c9HuHrcdXlTtGHRxJPdGm46yD
	aAENgD2/CblfkbItBGfVPl0K81WbhEXvXy7nBQ/6lyF8dX8m0tlcp49AW8Hs4abvNSWtzp1lJ1/
	xA3v3GH2tmE4I6XNr0iEq7atNFJAHD/E=
X-Gm-Gg: AY/fxX71+xsJzSkoZpvf6OgIlnlmRsrIeotsyyczSBjhPUkUFu5l7Kh1UAAoWHOEUdF
	640BiFp1PZfr5eD3ikkekLkl6Tgakt4fNbCnh/NoFzID+ELZ2fKoBCt57xMpCjicm/f+2f0puPj
	3VpsZ+oHQB3qZMuUKq2BpAhXWvUY0FlEC5sdJfezpXOqeauzTpnMh65vkdh7HXnAv2laAJXuet6
	GYAN2O9csyWwvrvwFhobouxNtc9W3I7olON28Q1cV9Jd1+LnK5XwSSQRYtFSyRAxh2eUxeaQn2Z
	R+CdaZtVNtw=
X-Google-Smtp-Source: AGHT+IHWXWcSL2ypRzwrXhZGRYXDxTuhkUPTtqeF8miccqaxHJcqkcxP/4yTCaxUzXMQIBg+77A8IP9i8mP3CXWFU2c=
X-Received: by 2002:a17:907:7288:b0:b76:eec9:a1a9 with SMTP id
 a640c23a62f3a-b8426a56bb3mr72786566b.7.1767641494141; Mon, 05 Jan 2026
 11:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102214043.1410242-1-puranjay@kernel.org> <aVv5nq5QTVDOz1Zk@J2N7QTR9R3>
In-Reply-To: <aVv5nq5QTVDOz1Zk@J2N7QTR9R3>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 5 Jan 2026 19:31:19 +0000
X-Gm-Features: AQt7F2qGhDBs3pKZB2Wr69RbJg7A6Q93VsSbpiAu0Y3FJEpYrfWHO1XDHG-ebLE
Message-ID: <CANk7y0gthCiw5K-z-8sWsWF0ZcbmDgYuDHjE4RPLfHTjQk=4nw@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Rob Herring <robh@kernel.org>, 
	Breno Leitao <leitao@debian.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:49=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> Hi Puranjay,
>
> I have a number of techincal concerns with this, noted below. At a high
> level, I don't think this makes sense without a better description of
> the usage, and I suspect we'd need changes to bpf_get_branch_snapshot()
> to be able to implement something useful.

Hi Mark,

Thanks for your review.

>
> On Fri, Jan 02, 2026 at 01:40:41PM -0800, Puranjay Mohan wrote:
> > Enable the bpf_get_branch_snapshot() BPF helper on ARM64 by implementin=
g
> > the perf_snapshot_branch_stack static call for ARM's Branch Record
> > Buffer Extension (BRBE).
> >
> > The BPF helper bpf_get_branch_snapshot() allows BPF programs to capture
> > hardware branch records on-demand. This was previously only available o=
n
> > x86 (Intel LBR, AMD BRS) but not on ARM64 despite BRBE being available
> > since ARMv9.
>
> When exactly can bpf_get_branch_snapshot() be called?
>
> How is it expected to be used?
>
> The driver is written on the expectation that BRBE records are only read
> in the PMUv3 overflow handler.

bpf_get_branch_snapshot() can be called from any BPF tracing program
so from unknown context.

>
> > This implementation:
> >
> > - Follows the x86 snapshot pattern (intel_pmu_snapshot_branch_stack)
> > - Performs atomic snapshot by pausing BRBE, reading records, and
> >   restoring previous state without disrupting ongoing perf events
>
> If BRBE is stopped, then we lost contiguity of branch records (e.g. for
> a series of branches A->B->C->D->E, we could record A->B->D->E). The
> driver is intended to ensure contiguity of those records, and if that's
> lost, we deliberately discard. That's why brbe_enable() calls
> brbe_invalidate().
>
> Restarting BRBE without discarding will produce bogus data for other
> consumers. If BRBE is stopped, we *must* discard.
>
> > - Reads branch records directly from BRBE registers without
> >   event-specific filtering to minimize branch pollution
>
> If BRBE is paused, there's no polution, so this rationale doesn't make
> sense to me.
>
> BRBE can be configured with various filters (specific to the event),
> multiple events with distinct filters can be active simultaneously, and
> if no branch-sampling events are active, BRBE won't record anything. I
> do not think it makes sense to record whatever happens to be present,
> without filtering. Regardless, BRBE won't be recording if you don't have
> events. so this doesn't seem to make sense.

In the expected usage of this bpf helper, perf_events are expected to
be created with the correct filtering.

From 856c02dbce4f ("bpf: Introduce helper bpf_get_branch_snapshot")

    Introduce bpf_get_branch_snapshot(), which allows tracing program to ge=
t
    branch trace from hardware (e.g. Intel LBR). To use the feature, the
    user need to create perf_event with proper branch_record filtering
    on each cpu, and then calls bpf_get_branch_snapshot in the bpf function=
.
    On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.

>
> > - Handles all BRBE record types (complete, source-only, target-only)
> > - Complies with ARM ARM synchronization requirements (ISB barriers per
> >   rule PPBZP)
> > - Reuses existing BRBE infrastructure (select_brbe_bank,
> >   __read_brbe_regset, brbe_set_perf_entry_type, etc.)
>
> This duplicates other code (e.g. the body of
> brbe_read_filtered_entries()), and I don't think this is justified.

Ack.

>
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >
> > This patch is only compile tested as I don't have access to hardware wi=
th BRBE.
> >
> > ---
> >  drivers/perf/arm_brbe.c  | 95 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/perf/arm_brbe.h  |  9 ++++
> >  drivers/perf/arm_pmuv3.c |  5 ++-
> >  3 files changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index ba554e0c846c..cda7bf522c06 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> > @@ -803,3 +803,98 @@ void brbe_read_filtered_entries(struct perf_branch=
_stack *branch_stack,
> >  done:
> >       branch_stack->nr =3D nr_filtered;
> >  }
> > +
> > +/*
> > + * ARM-specific callback invoked through perf_snapshot_branch_stack st=
atic
> > + * call, defined in include/linux/perf_event.h. See its definition for=
 API
> > + * details. It's up to caller to provide enough space in *entries* to =
fit all
> > + * branch records, otherwise returned result will be truncated to *cnt=
* entries.
> > + *
> > + * This is similar to brbe_read_filtered_entries but optimized for sna=
pshot mode:
> > + * - No filtering based on event attributes (captures everything)
> > + * - Minimal branches to avoid polluting the branch buffer
> > + * - Direct register reads without event-specific processing
> > + */
>
> As above I don't think these differences are necessary nor do I think we
> should be duplicating this.

Ack.

>
> > +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
> > +{
> > +     unsigned long flags;
> > +     int nr_hw, nr_banks, nr_copied =3D 0;
> > +     u64 brbidr, brbfcr, brbcr;
> > +
> > +     /*
> > +      * The sequence of steps to freeze BRBE should be completely inli=
ned
> > +      * and contain no branches to minimize contamination of branch sn=
apshot.
> > +      */
> > +     local_irq_save(flags);
>
> The PMU overflow interrupt can be delivered as a pNMI, so this can race
> with that. Disabling interrupts is not sufficient.

In that case this implementation is completely broken, Do you have
suggestions about how this should be implemented?
The use case is to find out how the execution reached a bpf program by
looking at the Branch records. Do you think BRBE can be used to fulfil
this?

>
> If this is only called within a perf event overflow handler, then we
> already have the necessary serialization.
>
> > +
> > +     /* Save current BRBE configuration */
> > +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +
> > +     /* Pause BRBE to freeze the buffer */
> > +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> > +     isb();
> > +
> > +     /* Read BRBIDR to determine number of records */
> > +     brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> > +     if (!valid_brbidr(brbidr))
> > +             goto out_restore;
> > +
> > +     nr_hw =3D FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
> > +     nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> > +
> > +     /* Read branch records from BRBE banks */
> > +     for (int bank =3D 0; bank < nr_banks; bank++) {
> > +             int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_ENTRIE=
S);
> > +             int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MAX_ENTR=
IES);
> > +
> > +             select_brbe_bank(bank);
> > +
> > +             for (int i =3D 0; i < nr_this_bank; i++) {
> > +                     struct brbe_regset bregs;
> > +                     struct perf_branch_entry *entry;
> > +
> > +                     if (nr_copied >=3D cnt)
> > +                             goto out_restore;
> > +
> > +                     if (!__read_brbe_regset(&bregs, i))
> > +                             goto out_restore;
> > +
> > +                     entry =3D &entries[nr_copied];
> > +                     perf_clear_branch_entry_bitfields(entry);
> > +
> > +                     /* Simple conversion without filtering */
> > +                     if (brbe_record_is_complete(bregs.brbinf)) {
> > +                             entry->from =3D bregs.brbsrc;
> > +                             entry->to =3D bregs.brbtgt;
> > +                     } else if (brbe_record_is_source_only(bregs.brbin=
f)) {
> > +                             entry->from =3D bregs.brbsrc;
> > +                             entry->to =3D 0;
> > +                     } else if (brbe_record_is_target_only(bregs.brbin=
f)) {
> > +                             entry->from =3D 0;
> > +                             entry->to =3D bregs.brbtgt;
> > +                     }
> > +
> > +                     brbe_set_perf_entry_type(entry, bregs.brbinf);
> > +                     entry->cycles =3D brbinf_get_cycles(bregs.brbinf)=
;
> > +
> > +                     if (!brbe_record_is_target_only(bregs.brbinf)) {
> > +                             entry->mispred =3D brbinf_get_mispredict(=
bregs.brbinf);
> > +                             entry->predicted =3D !entry->mispred;
> > +                     }
> > +
> > +                     if (!brbe_record_is_source_only(bregs.brbinf))
> > +                             entry->priv =3D brbinf_get_perf_priv(breg=
s.brbinf);
> > +
> > +                     nr_copied++;
> > +             }
> > +     }
> > +
> > +out_restore:
> > +     /* Restore BRBE to its previous state */
> > +     write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> > +     isb();
> > +     write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > +     local_irq_restore(flags);
> > +     return nr_copied;
> > +}
>
> As above, this is duplicating a lot of logic we already have. If we
> really need this function, we should be sharing much more logic with
> brbe_read_filtered_entries(), if not using that directly.
>
> Mark.
