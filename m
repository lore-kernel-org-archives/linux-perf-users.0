Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7D84039
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767390693; cv=none; b=b5hyAU44hrIg0oBL5Utgw9dfllgi/MIJDHFuxt1DC2CUS9e6rjnplp0ktgPpFvpg7RXoSZV5zajFukBngqgvjxOJNGJ6idm02Z7B/7EGXPWte7AMKfUeq+Qy9N5Lk+vv6/GgD9YWovE3qXNbXT8GX+5YpbJ3Ulh7m39Kh5cajLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767390693; c=relaxed/simple;
	bh=KsvLGK9RQiKtIWNgCWMFpZpfI1NepM0HRMPVSqtSF+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTFnj+30yrse8kGluVosDR/OpbzXUtMyVqBbO0piFA4pG1dNPU2ppe39P7wFSoztuRFFakZRhLXwST1DQq20cvwzoq1ErZvi5WkezJAW9WWeuf8Bt5zb1DronjS3iefJH2gPNW0vG2JKbtnn9bnieJnuQmwHLe+PvDVq7VVT3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH9ei010; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH9ei010"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1654865266b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jan 2026 13:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767390690; x=1767995490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTenAvrqvobAuiOnSDe7zsX4M/71bvsOlNzXbEIzkOU=;
        b=gH9ei010qj8mfAzdGqqWjA8KAN6zKk0e/iGi/SYEFJtJILRNHuy0Uj3v4/VpUI3680
         EIso2xzHOS4qeAMdiW6uuu++NNOyLhwegWIWo2kPfO87xKxa3RtbvXmJuTc4fYRvbg0k
         gb7MX7mDBDaDhaqJD+tmq02VD6cFwei6CxIBHSIOSOkbwJqdbHC/HrEEKZifMXmo/0p8
         uwnYQnd+d0NTmwkqtDUQHHMzFKiD6dbzOo1jAtjmFAnMlO7acfx0zzMmVShjcMOI3W0Z
         f/xBtPZxH+8E9PMZkpm7u+HOkbteoZKjYcNTbBWWhCHcS3VPMqT4RDVvzXJIaWNegoHF
         Uz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767390690; x=1767995490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTenAvrqvobAuiOnSDe7zsX4M/71bvsOlNzXbEIzkOU=;
        b=bLrL+xndJEPTN8G0+/o+oGoB9HEhwucyvFxEfaW3yTpiz2pg5osfHpfHLCB6/DHcp7
         8D7pJppAGcLHhpV0BXpSQDRRLBUK3MHFaqL6Ev36iuIdi7pNAAFhheL3Dl/sPfte/GFf
         IkpGGSSCpTQxjoskroFz/60BzsuKpP2mHamJzJc05u0AgC1nl2LxaybmmI1UaYWnQtV0
         QpidaRUCtY/cVu6TYOHFWeR32H6PnU5MB6iI3mla85F0O0SdDj9XMLvhYAZt3/QraIBW
         yWyIBPCPqVS5iL/KaU0caQE8o+xJhSu9AGUI9/2mzRjeG4Gt4fFL+9V5Uyp+II5QkEwP
         ziww==
X-Forwarded-Encrypted: i=1; AJvYcCXdWC+Nz63qVAzkAnZXh1zHCxSXv2HgzmpBlN6LNCfPsy1oRoDnMraKmd0YZ5+QOj6BdIKgxG+CLqfeNQsrhvc3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hp66YmL7SAgKVtmYUvE3X1Zt9/wBeOWtJBuMSvpVW9LuzO9T
	ZtyTlVsNlFfDTPK6sNVgLuZ35xUz6S2RZLhmmJWTjdQWXZZyAeSYy0CKdJCNf5nalPccfbwPvrY
	DtNF4p2nc/9rKPBKvG2Ir/Zgs2sKL6Sw=
X-Gm-Gg: AY/fxX459IOgUJvWZDIauyDZqw9I/jfhUFmfCybtjIx+D5loktHNl6dsS0IUoR8na8p
	mxGcjAVzPGhYugvzkGoNrWiPWuKax1fa44d71VGZzUPyytiGnyY/GcszK44QYN9mUHtdfDDjnvz
	kGqUC53dAUedZuYDGsf3e1UvNdvDDRt2iTMsvdIGNFauDw8Ku0P8cnXD4JivpDqrzEGHFcP3efX
	uLQWzqnr8S4v7wIw1rMCoM47Y23ZS39p1oxy1Cv/IiDF93WF49zX2H1MsDsH8Ea/e281p8DfUwg
	lqE2dZTufQ==
X-Google-Smtp-Source: AGHT+IGjZuqFXesd/PyiRzHysiotY9qzHDKLlbgVdwqG0k8JVSXWkfBUHAnebHZ354irsP07y4fQEuSwGXKhe1VKLAo=
X-Received: by 2002:a17:906:794e:b0:b5b:2c82:7dc6 with SMTP id
 a640c23a62f3a-b80371a71c3mr4567485566b.40.1767390689322; Fri, 02 Jan 2026
 13:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102214043.1410242-1-puranjay@kernel.org>
In-Reply-To: <20260102214043.1410242-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 2 Jan 2026 21:51:15 +0000
X-Gm-Features: AQt7F2o2g8WMwL4DWvrJg3zxf8TCKOgBvkEBSVur3aBXGErVLgcQ2alRYtrUUTA
Message-ID: <CANk7y0j7hAJ7OcH_HgN0cVGnUh=iBz=iuD9sYZmSy-koMjB_cg@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, Will, Mark, and Rob.

I don't have access to BRBE enabled hardware and Qemu doesn't support
this as well therefore I just sent the compile tested version.

Can you help me with testing this:

The relevant bpf self test is:

./test_progs -t get_branch_snapshot
#132     get_branch_snapshot:SKIP
Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED

skipped for my setup as it is not supported.

Thanks,
Puranjay

On Fri, Jan 2, 2026 at 9:41=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Enable the bpf_get_branch_snapshot() BPF helper on ARM64 by implementing
> the perf_snapshot_branch_stack static call for ARM's Branch Record
> Buffer Extension (BRBE).
>
> The BPF helper bpf_get_branch_snapshot() allows BPF programs to capture
> hardware branch records on-demand. This was previously only available on
> x86 (Intel LBR, AMD BRS) but not on ARM64 despite BRBE being available
> since ARMv9.
>
> This implementation:
>
> - Follows the x86 snapshot pattern (intel_pmu_snapshot_branch_stack)
> - Performs atomic snapshot by pausing BRBE, reading records, and
>   restoring previous state without disrupting ongoing perf events
> - Reads branch records directly from BRBE registers without
>   event-specific filtering to minimize branch pollution
> - Handles all BRBE record types (complete, source-only, target-only)
> - Complies with ARM ARM synchronization requirements (ISB barriers per
>   rule PPBZP)
> - Reuses existing BRBE infrastructure (select_brbe_bank,
>   __read_brbe_regset, brbe_set_perf_entry_type, etc.)
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>
> This patch is only compile tested as I don't have access to hardware with=
 BRBE.
>
> ---
>  drivers/perf/arm_brbe.c  | 95 ++++++++++++++++++++++++++++++++++++++++
>  drivers/perf/arm_brbe.h  |  9 ++++
>  drivers/perf/arm_pmuv3.c |  5 ++-
>  3 files changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c..cda7bf522c06 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -803,3 +803,98 @@ void brbe_read_filtered_entries(struct perf_branch_s=
tack *branch_stack,
>  done:
>         branch_stack->nr =3D nr_filtered;
>  }
> +
> +/*
> + * ARM-specific callback invoked through perf_snapshot_branch_stack stat=
ic
> + * call, defined in include/linux/perf_event.h. See its definition for A=
PI
> + * details. It's up to caller to provide enough space in *entries* to fi=
t all
> + * branch records, otherwise returned result will be truncated to *cnt* =
entries.
> + *
> + * This is similar to brbe_read_filtered_entries but optimized for snaps=
hot mode:
> + * - No filtering based on event attributes (captures everything)
> + * - Minimal branches to avoid polluting the branch buffer
> + * - Direct register reads without event-specific processing
> + */
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, un=
signed int cnt)
> +{
> +       unsigned long flags;
> +       int nr_hw, nr_banks, nr_copied =3D 0;
> +       u64 brbidr, brbfcr, brbcr;
> +
> +       /*
> +        * The sequence of steps to freeze BRBE should be completely inli=
ned
> +        * and contain no branches to minimize contamination of branch sn=
apshot.
> +        */
> +       local_irq_save(flags);
> +
> +       /* Save current BRBE configuration */
> +       brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> +       brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> +
> +       /* Pause BRBE to freeze the buffer */
> +       write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +       isb();
> +
> +       /* Read BRBIDR to determine number of records */
> +       brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> +       if (!valid_brbidr(brbidr))
> +               goto out_restore;
> +
> +       nr_hw =3D FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
> +       nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> +
> +       /* Read branch records from BRBE banks */
> +       for (int bank =3D 0; bank < nr_banks; bank++) {
> +               int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_ENTRIE=
S);
> +               int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MAX_ENTR=
IES);
> +
> +               select_brbe_bank(bank);
> +
> +               for (int i =3D 0; i < nr_this_bank; i++) {
> +                       struct brbe_regset bregs;
> +                       struct perf_branch_entry *entry;
> +
> +                       if (nr_copied >=3D cnt)
> +                               goto out_restore;
> +
> +                       if (!__read_brbe_regset(&bregs, i))
> +                               goto out_restore;
> +
> +                       entry =3D &entries[nr_copied];
> +                       perf_clear_branch_entry_bitfields(entry);
> +
> +                       /* Simple conversion without filtering */
> +                       if (brbe_record_is_complete(bregs.brbinf)) {
> +                               entry->from =3D bregs.brbsrc;
> +                               entry->to =3D bregs.brbtgt;
> +                       } else if (brbe_record_is_source_only(bregs.brbin=
f)) {
> +                               entry->from =3D bregs.brbsrc;
> +                               entry->to =3D 0;
> +                       } else if (brbe_record_is_target_only(bregs.brbin=
f)) {
> +                               entry->from =3D 0;
> +                               entry->to =3D bregs.brbtgt;
> +                       }
> +
> +                       brbe_set_perf_entry_type(entry, bregs.brbinf);
> +                       entry->cycles =3D brbinf_get_cycles(bregs.brbinf)=
;
> +
> +                       if (!brbe_record_is_target_only(bregs.brbinf)) {
> +                               entry->mispred =3D brbinf_get_mispredict(=
bregs.brbinf);
> +                               entry->predicted =3D !entry->mispred;
> +                       }
> +
> +                       if (!brbe_record_is_source_only(bregs.brbinf))
> +                               entry->priv =3D brbinf_get_perf_priv(breg=
s.brbinf);
> +
> +                       nr_copied++;
> +               }
> +       }
> +
> +out_restore:
> +       /* Restore BRBE to its previous state */
> +       write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> +       isb();
> +       write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +       local_irq_restore(flags);
> +       return nr_copied;
> +}
> diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
> index b7c7d8796c86..c2a1824437fb 100644
> --- a/drivers/perf/arm_brbe.h
> +++ b/drivers/perf/arm_brbe.h
> @@ -10,6 +10,7 @@
>  struct arm_pmu;
>  struct perf_branch_stack;
>  struct perf_event;
> +struct perf_branch_entry;
>
>  #ifdef CONFIG_ARM64_BRBE
>  void brbe_probe(struct arm_pmu *arm_pmu);
> @@ -22,6 +23,8 @@ void brbe_disable(void);
>  bool brbe_branch_attr_valid(struct perf_event *event);
>  void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>                                 const struct perf_event *event);
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
> +                                  unsigned int cnt);
>  #else
>  static inline void brbe_probe(struct arm_pmu *arm_pmu) { }
>  static inline unsigned int brbe_num_branch_records(const struct arm_pmu =
*armpmu)
> @@ -44,4 +47,10 @@ static void brbe_read_filtered_entries(struct perf_bra=
nch_stack *branch_stack,
>                                        const struct perf_event *event)
>  {
>  }
> +
> +static inline int arm_brbe_snapshot_branch_stack(struct perf_branch_entr=
y *entries,
> +                                                unsigned int cnt)
> +{
> +       return 0;
> +}
>  #endif
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8014ff766cff..1a9f129a0f94 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1449,8 +1449,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu,=
 char *name,
>         cpu_pmu->set_event_filter       =3D armv8pmu_set_event_filter;
>
>         cpu_pmu->pmu.event_idx          =3D armv8pmu_user_event_idx;
> -       if (brbe_num_branch_records(cpu_pmu))
> +       if (brbe_num_branch_records(cpu_pmu)) {
>                 cpu_pmu->pmu.sched_task         =3D armv8pmu_sched_task;
> +               static_call_update(perf_snapshot_branch_stack,
> +                                  arm_brbe_snapshot_branch_stack);
> +       }
>
>         cpu_pmu->name                   =3D name;
>         cpu_pmu->map_event              =3D map_event;
>
> base-commit: c286e7e9d1f1f3d90ad11c37e896f582b02d19c4
> --
> 2.47.3
>
