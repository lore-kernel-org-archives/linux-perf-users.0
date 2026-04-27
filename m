Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7039B949
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291794; cv=pass; b=Obe7Wa/JLdooHohagWsfu+wF2ijItB7a3jgy1XLDzqaz/7u7sRnnfFtq3buToklxStxTGFZeEeCeS6kSH5uo0iC0CEYwtNJ4+AM9p60jCDc2aE/SvAZjcLqgz4LPUMygFKj8PdMFhymN3DlUOG9t7aHoZ3HQAzE+UpNUTpzDheE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291794; c=relaxed/simple;
	bh=7ou4NuehRA3k1EdFM5tKEMdVpfctBHvyJJ8DBaw1rjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te0gq5LgWR9D7dPCtrOmf2BuBGzlASTCeCyY4GFWWWT93YS6S0MASBGnzbbpKdgA31wk104wTXm819ZDxPjJl0YvgKUseQhHBKFM+cEPn81saB4e3tF1BJxlZFH4yl0eOMYhIHbDj/XMgzLh1sPXOI1wufhMTLE3N/9NncGo5KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGcD3fY5; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGcD3fY5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso13829682a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 05:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777291789; cv=none;
        d=google.com; s=arc-20240605;
        b=A3k2P6vLwEWe6E8clSjm3vjGFYJo3a55xtZoHjoFRtA+bk5Lci7wPQqGypbMIOY4L8
         cOwmjNlcUfiP3eKu/jwKakSyNC2ocoMYg+8IUB2gpSkpDNB8w281pg26b5bVL82BvqkU
         9rymRrhkWbGvNWu7x1mLGicRYc4wy32+bCnN4KJOApGNWjEe3reiE3ADAPT3zPMqnGui
         Kt4AgYG3BVYSyvR79OYjvno6KsM6Of/Yg/x8hdjtZafHGN+ZSSvHINC+9jqxPiqtfb+J
         kzaRSQf+SRFUizscvwQ/0lbKvn9Mkueup6iwSdrKMvjJxBysZeRGgsLgJWDkFuHshS5+
         MfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J4ME7vf7epyDcp3Ddjtmm3VoK4g15VbKSQsr+1vhcdc=;
        fh=7h0izHys8KHgVwAHFbDqh8DXgNjj235aXcN4iZY+6bA=;
        b=Iaxy9pjt+FUZadik3M6YDKVFGelb7fdhK7bGzFm2EiubYLY+tM5ajVGBVixxp/QOnd
         2n0xwLyYHPS8Ez972QwY6AJ9j614xxc4Ebh6xTZbdx9fMx1cjufKQj8MO1STT7Ou8XeY
         0lhuIpGNN8BMGG08e7Q9X4J8Jxfo8AXy9JNkjgCQq8YjC4mD4zBtRitkeqKZ74f8nn2L
         STpojc7k+PsKh7Jr4XXYVfkxXr5Hpwg53kSgIV3mUjM1etCrebFvPhzKXrzIhb+oZXvG
         uMHi01eba9jmacSDcPkZfJm04xyegXF2D0Lv1xCtLZeyHZgc8+RwBgltHadWYy3OHM6e
         eK2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777291789; x=1777896589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4ME7vf7epyDcp3Ddjtmm3VoK4g15VbKSQsr+1vhcdc=;
        b=BGcD3fY5j1ppzOBNY1Mn9/UzTr1el+05beao5sPYcp4trhaMQ247MH3jmWnFzhzdy6
         Ayz3lBPO/dqchsPwozFzvgDe4HdYot+RzgyeYLLNsKlgw4F7ApOn8bpf6MbzyRE/okx8
         UBbXcl0+nuEtnLKJ5Q+tDH5oDqS6FYz+Jj+q07xpZCDZDPQcsp821wXPmK8oeRUOvbHe
         XQUxJADuH8B6CwLHUQDqUW9+iIdG+xxMg39f5nlspTtDDoepcW4Xxz0CwUw95WJ3Fz6w
         yBCi0dFrOsA5x0GSBERdj6gJEKgDww2y0M0grY2kfnuCMwhhThiReRNI2PDvW5X90zJR
         5JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777291789; x=1777896589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4ME7vf7epyDcp3Ddjtmm3VoK4g15VbKSQsr+1vhcdc=;
        b=C8/Bn+a30QpHvIzyWHcGJGEbcRA2oKliFrWEC3IyedZoJb6NN6df/cYfTokVdxUc8+
         kyvHq1ualnvQ33UPsu2eMrBbG48X3AUUgHIiFhVcAZVG6bvUXJa8eD9vohZkTyxjbDLb
         VNyc+9R7MViJjLA0NjXamRe6kaojskdwguNLjaU8sCHx7OSNk4/O12NBBE5e7GlTs8LV
         ecAbEf0BypcIM4kJW6bd6eqQvHdl977ZcIqkNayOXkHV8xFHKSyA2uqvs1mDa1krlYD5
         VFAZKV4Do7aC0+7cPsxU/9K0jSQgLTaXAzQjeG/iyQvCtneksAx918w8LkJrRlsg/p0Z
         hyyA==
X-Gm-Message-State: AOJu0YxlAIvaSZRa7/CaGmVan+8JRBWGpIE/loMosNiPcbFjYS/qnj8a
	D76FJdkO6bobH7y2z2PHLGFSl9RKBGGbHOAd5dIc8ZlW6GUQzeySMuUu+VU+gaurXj3wmpT6sCh
	kJMAX5KaNj3Wf3bWK8AoihLtrGI0E0/EB6ext
X-Gm-Gg: AeBDietS5y1ft3HKz2PpXlXUZTP/nJ8rEwJVKOSQGAxRFLQXKtswW6h/lqrxfD1BvX4
	NsFeUvY+j51FffFbk0m55asE1B4z8zCCRLhFJyL17n61cd/S+ZxGUL8er48ZqVWoZ76gglrtVXY
	/dkc50dxUzSlQ495nGGCY7fkLAcAA6fm4uXxPA5lPnF1gAPtjR2ikTtGUy4uk1fttGjASoRKz1K
	cgagP0zdZr5LOuDQP9xORnWcOZt3jc28gdEZbFBL9YGQhdnm4rTdh9kStXSozIK/fB+fbqBHkoD
	DEcpxS1GjDv+8qlzAPkhyZzBde6xirgWGjDGTD99zfJn
X-Received: by 2002:a05:6402:90b:b0:66a:8002:fe17 with SMTP id
 4fb4d7f45d1cf-672bfdc964cmr18132483a12.13.1777291789297; Mon, 27 Apr 2026
 05:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413185740.3286146-4-puranjay@kernel.org> <20260413203144.EA85BC2BCAF@smtp.kernel.org>
In-Reply-To: <20260413203144.EA85BC2BCAF@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 27 Apr 2026 13:09:35 +0100
X-Gm-Features: AVHnY4IAGYvtHVIU7hTjO364ldbCcFwSbQm2aFRg9p1ZdindgBj_OF_5KAAxkP4
Message-ID: <CANk7y0hHok1WBKmxr=bm7U+Ya0NGNZ+AL2cdGtJbxWU71huSvg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 4 potential issue(s):
> - [High] arm_brbe_snapshot_branch_stack executes BRBE system register rea=
ds without validating CPU support, leading to an Undefined Instruction kern=
el panic on asymmetric systems.
> - [High] arm_brbe_snapshot_branch_stack destructively clears the hardware=
 branch buffer, corrupting data for concurrent perf sessions.
> - [High] A TOCTOU race can unintentionally re-enable BRBE after it was ex=
plicitly disabled by a PMU interrupt, corrupting hardware state.
> - [Medium] Missing isb() context synchronization after unpausing BRBE cau=
ses missed branch records.
> --
>
> commit ce06705327b522bc73c923ff4219c198fe71f3b4
> Author: Puranjay Mohan <puranjay@kernel.org>
> Subject: perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>
> This commit enables bpf_get_branch_snapshot() on ARM64 by implementing th=
e
> perf_snapshot_branch_stack static call for BRBE. It pauses BRBE, masks
> exceptions, reads branch records, and then invalidates the buffer.
>
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index ba554e0c846c4..fd62019ddc839 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
>
> [ ... ]
>
> > +/*
> > + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> > + * self-recording and return 0 if the snapshot state appears disturbed=
.
> > + */
> > +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
> > +{
> > +     unsigned long flags;
> > +     int nr_hw, nr_copied =3D 0;
> > +     u64 brbfcr, brbcr;
> > +
> > +     if (!cnt)
> > +             return 0;
> > +
> > +     /*
> > +      * Pause BRBE first to avoid recording our own branches. The
> > +      * sysreg read/write and ISB are branchless, so pausing before
> > +      * checking BRBCR avoids polluting the buffer with our own
> > +      * conditional branches.
> > +      */
> > +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
>
> On asymmetric systems (like big.LITTLE) where only a subset of CPU cores
> implement BRBE, the perf_snapshot_branch_stack static call is enabled
> globally. If a BPF program invokes this snapshot on a CPU lacking BRBE,
> will this unconditionally execute read_sysreg_s(SYS_BRBFCR_EL1) and
> trigger an Undefined Instruction exception kernel panic?
>
> Does this need a local CPU feature check before accessing these registers=
?

I had this in the previous version, but Rob explained that this
doesn't happen in practice so I removed it.

>
> > +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> > +     isb();
> > +
> > +     /* Bail out if BRBE is not enabled (BRBCR_EL1 =3D=3D 0). */
> > +     if (!brbcr) {
> > +             write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > +             return 0;
> > +     }
> > +
> > +     /* Block local exception delivery while reading the buffer. */
> > +     flags =3D local_daif_save();
> > +
> > +     /*
> > +      * A PMU overflow before local_daif_save() could have re-enabled
> > +      * BRBE, clearing the PAUSED bit. The overflow handler already
> > +      * restored BRBE to its correct state, so just bail out.
> > +      */
> > +     if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
>
> Can a TOCTOU race unintentionally re-enable BRBE if a PMU interrupt fires
> before exceptions are masked?
>
> If the PMU overflow interrupt decides to stop the event, it calls
> brbe_disable(), which sets SYS_BRBCR_EL1 to 0 and sets the PAUSED bit in
> SYS_BRBFCR_EL1.
>
> Upon returning from the interrupt, the PAUSED bit would still be set, so
> this check evaluates to false and proceeds. At the end of the function,
> the cached brbcr (which was > 0) and brbfcr are written back, which would
> unintentionally re-enable BRBE in hardware without an active perf event.
>
> > +             local_daif_restore(flags);
> > +             return 0;
> > +     }
> > +
> > +     nr_hw =3D FIELD_GET(BRBIDR0_EL1_NUMREC_MASK,
> > +                       read_sysreg_s(SYS_BRBIDR0_EL1));
> > +
> > +     for_each_brbe_entry(i, nr_hw) {
> > +             if (nr_copied >=3D cnt)
> > +                     break;
> > +
> > +             if (!perf_entry_from_brbe_regset(i, &entries[nr_copied], =
NULL))
> > +                     break;
> > +
> > +             nr_copied++;
> > +     }
> > +
> > +     brbe_invalidate();
>
> Does calling brbe_invalidate() here destructively clear the hardware bran=
ch
> buffer?
>
> Since BPF branch snapshots are intended to be non-destructive observation=
s,
> wiping out the hardware branch buffer could permanently destroy the branc=
h
> history for a concurrently active perf session.
>
> > +
> > +     /* Restore BRBCR before unpausing via BRBFCR, matching brbe_enabl=
e(). */
> > +     write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> > +     isb();
> > +     write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>
> Is an explicit isb() missing after writing to SYS_BRBFCR_EL1?
>
> Since MSR instructions to system registers are not context synchronizing,
> the processor may delay unpausing BRBE. Could this result in missed
> branch records until the next context synchronization event naturally occ=
urs?
>
> > +     local_daif_restore(flags);
> > +
> > +     return nr_copied;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413185740.32=
86146-1-puranjay@kernel.org?part=3D3
