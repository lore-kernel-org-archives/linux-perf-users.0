Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EF3B777C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431973; cv=pass; b=ZN/p7g55NJIg8TCg5wKUrGdCTUoM5Zwg4QeyodHsFBg+ws6eBUy+j1fwQxRcBXf6ob7VgJOH7bLV3lgoD2xlei4KU9TbUai1WXAfWUkJ40rafcMkW8oqCCAfZufFzrs2gxyvDQVdo5HdZK3PUlNb8MJEso34GeOGT+0J9QTA6Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431973; c=relaxed/simple;
	bh=i0+eb4fdjODYE0EO5C/d9RUVro7JvdDRobBCgvtT/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVh6YFVF1VeeX51VRaCz+59FUQWIvSTfcxEcxqt1UnCWNHu827awJE5J+HnylZWNJLPZWkAvP4vruJCivRzKS27oBnASE3ke629TJ7NTMmhdAUgnfRXXeopeG0UlZw5E3lWtPimYApES5O+eSUBG5O8L/WgMzo9DmflWSuh3wso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwNk8QPl; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwNk8QPl"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so4271160a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 12:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773431971; cv=none;
        d=google.com; s=arc-20240605;
        b=Eoh8kSwAJPszVSYraPMNN8+1pOCe4dRSnBOIuSs+Kwdj5We4HcYWRdicUDyX701N31
         eclaw+CsGkumftIl+aLKNU6SuzeaKtIT0wqKi3hwI07atw3K1o/LBCh2gDywBZh9Smip
         cd8+bBmtXPvLXxCkEe4MdgGuIXCw6qNniS+hvt1dAoPAyf/7WOubK9jtvkK3pYuYB96a
         10RXIL2RvXwfTLmsEuhxmdjD0Po//mwWrA0MpiqSWRI4ejc3Or4QJ10zUeSoeMqzO1mY
         fij9EDopXzMjjQak5aWrJ8ZOCUxdIcD0yKQOR/dzYT6+AEwDX0hWeF9LsVZEdhzIwmME
         oL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Act0nsQpNOTwOEOVN8vznQnBkgNXARysghnHBxbiaY=;
        fh=MYpbDUOwmND9NoFDa/QQA3c74H5jVnCOlK6uqMbhhlw=;
        b=R82SMFfPq5STBWhAU1DismkAbmabBot0UVit37qKJ6X4He7m3Hy69IPw5ub2JV6yfI
         ntfINz3H4bfxQq7Ou/Lm+nXZ8xtyGWiLrdA4FDDe/1zYQGlYwYsywwOke9Lk6xRVhJVj
         QUWFZa5OnqaWATGfX8YRjwglFzNlvgjanyLUNwzUqXYGRwNPjrt9rdp2N9qfqwNDrGsx
         GWx/rI4biHaIdS1Yhnn4VSZJSINNd9xpVSnR0hb4SE6wVDCMyS2QY2ax6rDutEms5WVU
         X9Un5N9xNwxNYtxZBNyNBFoUYtQR5PvyC0pePDvnu1MzFjjjd9noJTHMbO7jsBFD+K5Z
         hZaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773431971; x=1774036771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Act0nsQpNOTwOEOVN8vznQnBkgNXARysghnHBxbiaY=;
        b=VwNk8QPlxUtcnVvlIptERHurfSTYWBrgs+O7jj294xKq4lZF8eP2Ny3iUxlvv4G1yO
         Udh0UBvSR1ErLkys+/kmeGnwN0EKG3+2CEJqQM4/oKCkpQcfIjxU8b8zBXXHQyLDfDvd
         9WCo/WSulpEEWFa4sCItK2S2b8Iq0O3PVFn4SEwyNJzbRI3UtU/Zhl4wNhM3JlLryZMm
         OpUnU8yOl34a0BtWhnlN2MBVqKXRlRAGZlQ15kiCcNJq0hPWm5UD1Z8j+VMagz2/HXRg
         WEC49D5UHD3qRvRPeWjN130P1OyEr+pU+1bhOdJNTgc0CUnIEredH7dc1bmeZYQnXOWM
         ZRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773431971; x=1774036771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Act0nsQpNOTwOEOVN8vznQnBkgNXARysghnHBxbiaY=;
        b=lBgoMq13MJovPbDTzRucGTXN+NdNy3KYbPZDDFt2hnYzReK7aKlPRyIhIVXQXnM5BB
         UIKJWQMubZ5U6gScWw4c3FO+PH7gJLSYmSZH6rNabJuHqmDnAJgurL6/VXa6C4tq9zqB
         Glvi7lpMQDNCrstOAoFz438a9rJn1jrhDD/vWBtmJcnNX+Po4lXgwRzopazYHqBjRFu/
         OurlvRGHvbm2PXSAjnLm9h2mI2J/e2ykw/VO7HItnWBDXD+obdvBVviAS8591NW7v9WP
         2qZpTU6+i4oj8UijqTm511fm8JWCGmALLiRl6popIQDQzDxez/CedK6V7YL+rlN+1H8y
         1hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXulvvH5Ff/oXbgy/76gQuFTqGiMrjS/w/BZzIqzdjasVh9yzXOWhMnZLi98JUysuu+vdtSPZG6vWQ10e9v85Zr@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtH0ROsu1CGvlDgSsvc9uFMDKqlz7whDSrQsyekS+f4Sxf3zy
	1V+lPAhMgQbdIe9yjuYfKh2d6inEGUn8jtxxIkhQsoArB1I/rblC1Cu0x6vNC6MoR68TKbkf0vj
	JsKhmQE6zWsq7fKrlgh1mpz+lfqjMc77xKoPBS7TPGg==
X-Gm-Gg: ATEYQzyAlq/MCihYCwbbHsdsVIayF5rIn8AMRjxkhf4svAO9v0+35Lrvw3D9SHTWiEY
	rTBilOX2ZaQy8wAxOZvkS+UYOG7aa6fq9mk3fv7ZHwkIGgfgcgYnrQS9gN5LqlRzAlxtpKS1QjJ
	sqJWtCGZfx+4Xc1y7mZ1vn5gbB0JUjBXPIypAjpWD3Ql7KFQQBwD8xC5ff/81pkbK2LSOJMKGLF
	RDjFqxfnT0NCcC21ZCG5TD1mN1XJsxAw0Lm0eGlfZKzX/r6ubjRe0MVkMtgxdWQ1nMvv66UUp77
	v5dAk4AM7rDFWEA4TeCzZ0qq+VXVpxvCmfsh7XHlXA==
X-Received: by 2002:a05:6402:254a:b0:663:8e2e:f0a1 with SMTP id
 4fb4d7f45d1cf-663bac038dbmr2432564a12.28.1773431970504; Fri, 13 Mar 2026
 12:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313180352.3800358-1-puranjay@kernel.org> <20260313180352.3800358-3-puranjay@kernel.org>
In-Reply-To: <20260313180352.3800358-3-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 13 Mar 2026 19:59:18 +0000
X-Gm-Features: AaiRm51GikI9-zP9fY-3_TgKJfmb6uaUMWjbiaWm-fp3xLHqk8JTGxatmTS6nYg
Message-ID: <CANk7y0jjd6XC7nd2BxtsVhs8vWp_9cC-ckXPGRQK_CW5BSuogQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/3] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:04=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Implement the perf_snapshot_branch_stack static call for ARM's Branch
> Record Buffer Extension (BRBE), enabling the bpf_get_branch_snapshot()
> BPF helper on ARM64.
>
> This is a best-effort snapshot helper intended for tracing and debugging
> use. It favors non-invasive snapshotting over strong serialization, and
> returns 0 whenever a clean snapshot cannot be obtained. Nested
> invocations are not serialized; callers may observe a 0-length result
> when a clean snapshot cannot be preserved.
>
> BRBE is paused before the helper does any other work to avoid recording
> its own branches. The sysreg writes used to pause are branchless.
> local_daif_save() blocks local exception delivery while reading the
> buffer. If a PMU overflow raced before that point and re-enabled BRBE,
> the helper detects the cleared PAUSED state and returns 0.
>
> Branch records are read using perf_entry_from_brbe_regset() without
> event-specific filtering. The BPF program is responsible for applying
> its own filter criteria. The BRBE buffer is invalidated after reading
> to maintain contiguity for other consumers.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  drivers/perf/arm_brbe.c  | 70 ++++++++++++++++++++++++++++++++++++++--
>  drivers/perf/arm_brbe.h  |  9 ++++++
>  drivers/perf/arm_pmuv3.c |  5 ++-
>  3 files changed, 81 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c..db5e000b2575 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/bitmap.h>
>  #include <linux/perf/arm_pmu.h>
> +#include <asm/daifflags.h>
>  #include "arm_brbe.h"
>
>  #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> @@ -618,10 +619,10 @@ static bool perf_entry_from_brbe_regset(int index, =
struct perf_branch_entry *ent
>
>         brbe_set_perf_entry_type(entry, brbinf);
>
> -       if (!branch_sample_no_cycles(event))
> +       if (!event || !branch_sample_no_cycles(event))
>                 entry->cycles =3D brbinf_get_cycles(brbinf);
>
> -       if (!branch_sample_no_flags(event)) {
> +       if (!event || !branch_sample_no_flags(event)) {
>                 /* Mispredict info is available for source only and compl=
ete branch records. */
>                 if (!brbe_record_is_target_only(brbinf)) {
>                         entry->mispred =3D brbinf_get_mispredict(brbinf);
> @@ -803,3 +804,68 @@ void brbe_read_filtered_entries(struct perf_branch_s=
tack *branch_stack,
>  done:
>         branch_stack->nr =3D nr_filtered;
>  }
> +
> +/*
> + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> + * self-recording and return 0 if the snapshot state appears disturbed.
> + */
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, un=
signed int cnt)
> +{
> +       unsigned long flags;
> +       int nr_hw, nr_banks, nr_copied =3D 0;
> +       u64 brbidr, brbfcr, brbcr;
> +
> +       if (!cnt)
> +               return 0;
> +
> +       /* Pause BRBE first to avoid recording our own branches. */
> +       brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> +       brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> +       write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +       isb();
> +
> +       /* Block local exception delivery while reading the buffer. */
> +       flags =3D local_daif_save();
> +
> +       /*
> +        * A PMU overflow before local_daif_save() could have re-enabled
> +        * BRBE, clearing the PAUSED bit. Bail out.
> +        */
> +       if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED))
> +               goto out;
> +

The code below doesn't implement filtering, I am currently trying to
figure out the best way to implement that by reusing
read_branch_records() somehow.

> +       brbidr =3D read_sysreg_s(SYS_BRBIDR0_EL1);
> +       if (!valid_brbidr(brbidr))
> +               goto out;
> +
> +       nr_hw =3D FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
> +       nr_banks =3D DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> +
> +       for (int bank =3D 0; bank < nr_banks; bank++) {
> +               int nr_remaining =3D nr_hw - (bank * BRBE_BANK_MAX_ENTRIE=
S);
> +               int nr_this_bank =3D min(nr_remaining, BRBE_BANK_MAX_ENTR=
IES);
> +
> +               select_brbe_bank(bank);
> +
> +               for (int i =3D 0; i < nr_this_bank; i++) {
> +                       if (nr_copied >=3D cnt)
> +                               goto done;
> +
> +                       if (!perf_entry_from_brbe_regset(i, &entries[nr_c=
opied], NULL))
> +                               goto done;
> +
> +                       nr_copied++;
> +               }
> +       }
> +
> +done:
> +       brbe_invalidate();
> +out:
> +       /* Restore BRBCR before unpausing via BRBFCR, matching brbe_enabl=
e(). */
> +       write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> +       isb();
> +       write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +       local_daif_restore(flags);
> +
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
> index 2d097fad9c10..e00c7c47a98d 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1456,8 +1456,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu,=
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
> --
> 2.52.0
>
