Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB23612F5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390630; cv=pass; b=I4pMGc+g8sMyQW3kUY/0Co5jBwRept5DwHzhH/fsWAUBRWg7MKZw1p4NZ8h5p8cyBjjVxiVqybPMF2xCJRTr1sB8tcc5egOD1/qUh/zPJaU9OFicWgTLi5jp7p1bffn8S5PR50jd+yd0RhgCUjZDzr4+Z1O+YKHCfLV4DOw8mPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390630; c=relaxed/simple;
	bh=Y+5f81K7DHNtXPtB/F7Xz+mM4DRnLSK/j3ypDuLllII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXKuTZCNPJAiTSYniLnm9T/5sCWqnQjpLlv3+FBJHgKgl+HLWgaBm69OCilPH06qdTREIvMxG1e/FGkeJTpiHOtzI2VPMEZdsYnddAweokLX5I3q4GgMMivN8JSTJstgebMUt9oHj+ML5wO8ldfCBcbL3vr3gaaDXLFLYZZV7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPdYYAU9; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPdYYAU9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bef1e6423e7so73703266b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 01:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780390627; cv=none;
        d=google.com; s=arc-20240605;
        b=UN73KE/jpJSL/yxNJjhRB6I9e31zblUqZcngsatcrPHQSFuuB8ljKUKaI6xW1ur0B4
         PgJJRr3bfx9EHleZjGo1wxBxvptIHc/o3dBlB+i9lKM7ySZJ//VOQvURsy4sVuLrgw6D
         rxoRsPEJqW6l3wosJhi5m5S/b3TGWF1LMfpq+qd5/WKKAc/GPswq3qkz5d8ffH3lVtLf
         ivNArQWte8qMpTrv2G8HRKQz5dYlPf/6maQCv3GerhzqZdk45LcJCcKeKgnB2a0E7TPr
         1mQzaGsq1eHL4235zcsvowxGPgDTBNjFinTNmO62dZXAQkws13ddEAYUD1MKwcA6X3ao
         A3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZg0g8kfpnyHG9bcYNNs04NW71/x368Tj2iB4Wk0/04=;
        fh=6kWUO23jvpruyV0F2mN4DGuijMp8uyY16aSVcNz2v1U=;
        b=bE9jrZO6QPbIz+uhRHjHhnhLd3wiRgjB+a0/QYNDKWcNoNMHo38PaHLhf+pIm7o80P
         qpTYEDOl5P9ZL/RK7+1tI8VucSoBr0o0sTgy5O731i67DQo4Gy55fmxHEIcCbzm8YZwo
         2n2m0QJSSZKlIyOZvlgUbMDhjwzVFFF/cWO7rq/+6nimiNBY6C2Y6+QFJICeD7xq5KPj
         v30j1kJbvgtiHXzgblf4zVXR6M1A8SMv8pytDk7aXhWIPwrCLeErvK/4YBZgx8JkZ17k
         q6NADOoT2mAVoUNM3wou+vv0qPZgVPjAqKYtWi1+MlyaQfPWjdPZFcBtMNPmK0k7saUL
         G5EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780390627; x=1780995427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZg0g8kfpnyHG9bcYNNs04NW71/x368Tj2iB4Wk0/04=;
        b=EPdYYAU9Ky+TqgXVSVc8lWMcSufieuHahRV5BeUYoXlJdskStBJVxF6JIyDaPmvTA7
         FXYbZonMDBdt6JyRCdnZWXvz0TmTjuStrIZIrgg1G+P0ZiuPHqVfKjTaKowN88/Rm1mX
         7e2sl/I6+OJw4qg5pHjIJSRXGHbls17jzGDf0aNL+nAWOnAxUKhemKeWXzKtMV0y8qbH
         bBiJHnie/xWSELspKfk9+iPs9b6Gi/s67oiqMOqc13fJKPnaiFzjvkf1IQ2euteN1CgK
         Y7fJ2x5UBFi7SQ6gkD0TBdXk5gcalgUHgmtrhZ8oX5TmtbkR91oKqMdhN5jGX4g52vM/
         CGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390627; x=1780995427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZg0g8kfpnyHG9bcYNNs04NW71/x368Tj2iB4Wk0/04=;
        b=cYdSqXSFnXU1ybYu7tbAiACU8sHVW1a5ykp7fbsCjeB3Q1cuyorP96oER0XpavSRJL
         7TtmLW4zgPueLamubWnN/zb2ZtucXE86aj/Sv2X8fTlkuDVXDqsVfAgmRw75kys2bO/n
         6BwkyEe1m29wxF4v+u+JDj8vv725joFvnF6519j6o82DZIq69PUqAnFYm710Awf+pGvy
         36JYSPIV2KAxhHEVJTefX50yetgTKPSgDrQjD27AYDqtQsL3EPUlgApKzHpn3EHr1hRu
         gN1W6tAl2l3NsLxWsAz+V9MZKZZsKo5wHilrBGCpqXwFEXeHyQaLBgx8g+hQ5WNfkkTA
         CkmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/H/E9JhtNLEhTy39pwfnOmPjQR1PXzIP4MO++HYvNra5bgQkz+j20zaBZjNAMHZ2aUnqFi+VJou5m4mF7LXt/@vger.kernel.org
X-Gm-Message-State: AOJu0Yylmk1ShDOjgWbXFAIIUBhAGueOAUxQw62r0viweojE2NepcDoI
	/wYjdqcZsfkTcDKtRjybMEBYwJjLniwp5xHGFKC2UuHDCG+4hkrgAAf/NnRqlD5M6dF7uoTmr8C
	Us/hyd9wRYTJ74IrGLnn8fr5NAAArlaI=
X-Gm-Gg: Acq92OG4XYZiW1LF+qjTkcz+lfYystzAXLN1mkQwqfSC7LK8g3rK1WzGQPwGe8s21HW
	Y2stgfUmXvtYQFezA7qp3N44Uhs0QN/PNzrLkmEeHgs4n5lBfrritsgJUAdqOMuiG4BL1a8NnGr
	xt4FjWYBcq8FctZUPiUaVie0NV2afLZiVXjBAsabDDU22Jday5rX5/sW0spnjzCeUS5AanEvC9l
	pVpgGXVib9v5AqIKwRaZeZUpLZkahHQLju7uXHOGlsUhnQgh34EmIFapEslbQeDr8Mjoiec0TOE
	OoSSFuEeGYtfqA4evFx9TN5fTeAjooAYmA==
X-Received: by 2002:a17:907:7705:b0:bee:a25:b977 with SMTP id
 a640c23a62f3a-bee0a25d320mr331236166b.45.1780390626557; Tue, 02 Jun 2026
 01:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527121207.2312181-4-puranjay@kernel.org> <20260527140948.3D61C1F000E9@smtp.kernel.org>
In-Reply-To: <20260527140948.3D61C1F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 2 Jun 2026 09:56:51 +0100
X-Gm-Features: AVHnY4KJgazUFImKAaO7E45UDwpfkanii3pt25-o-KKfnSa6wozbSJrvqWPTL3g
Message-ID: <CANk7y0jT_xi45gKdu=s2Gsoew1fde8cx0bcKQFiiHUtWcWW9Cg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] TOCTOU race in `arm_brbe_snapshot_branch_stack` leads to hardwar=
e state corruption.
> - [High] Unconditional calls to `brbe_invalidate()` destructively clear h=
ardware branch records, breaking concurrent perf events.
> - [High] `bpf_get_branch_snapshot()` unconditionally fails when invoked f=
rom a PMU NMI handler.
> --
>
> commit 4683208c7439e46b2ca26814f22b69f16e4ad0c2
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>
> This commit enables bpf_get_branch_snapshot() on ARM64 by implementing th=
e
> perf_snapshot_branch_stack static call for BRBE. It pauses BRBE, reads th=
e
> records into a buffer, invalidates the buffer, and unpauses BRBE.
>
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index ba554e0c846c4..aede95e277842 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> [ ... ]
> > @@ -774,32 +795,96 @@ void brbe_read_filtered_entries(struct perf_branc=
h_stack *branch_stack,
> [ ... ]
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
> > +     /* Guard against running on a CPU without BRBE (e.g. big.LITTLE).=
 */
> > +     if (!cpu_has_brbe())
> > +             return 0;
> > +
> > +     /*
> > +      * Pause BRBE first to avoid recording our own branches. The
> > +      * sysreg read/write and ISB are branchless, so pausing before
> > +      * checking BRBCR avoids polluting the buffer with our own
> > +      * conditional branches.
> > +      */
> > +     brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > +     brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +     write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> > +     isb();
> > +
> > +     /* Bail out if BRBE is not enabled (BRBCR_EL1 =3D=3D 0). */
> > +     if (!brbcr) {
> > +             write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> > +             return 0;
> > +     }
>
> [Severity: High]
> Is this check incompatible with PMU NMI handlers?
>
> If a BPF program attaches to a perf event overflow, armv8pmu_handle_irq()
> calls armv8pmu_stop() before processing overflows, which calls brbe_disab=
le()
> and sets SYS_BRBCR_EL1 to 0.
>
> Would this cause bpf_get_branch_snapshot() to unconditionally fail and re=
turn
> 0 when triggered from these PMU events?

That is acceptable.

> > +
> > +     /* Block local exception delivery while reading the buffer. */
> > +     flags =3D local_daif_save();
>
> [Severity: High]
> Is there a TOCTOU race window here that could corrupt hardware state?
>
> The function reads and caches SYS_BRBFCR_EL1 and SYS_BRBCR_EL1 before
> disabling local exceptions via local_daif_save().
>
> If an interrupt or NMI arrives in this window (such as a perf_event_disab=
le
> IPI) and modifies the BRBE hardware configuration, the function later wri=
tes
> back the stale cached brbcr and brbfcr values at the end of the function,
> overwriting the PMU subsystem's intentional changes.
>
> Does the mitigation check below catch this?
>
>         if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
>
> It looks like it might fail to catch this because brbe_disable() leaves t=
he
> PAUSED bit set, leading to the function silently re-enabling BRBE and
> corrupting the hardware state when restoring the cached registers.

The NMI handler always leaves the registers in same state to what we
cached. This is not a real issue.

> > +
> > +     /*
> > +      * A PMU overflow before local_daif_save() could have re-enabled
> > +      * BRBE, clearing the PAUSED bit. The overflow handler already
> > +      * restored BRBE to its correct state, so just bail out.
> > +      */
> > +     if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
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
> [Severity: High]
> Does unconditionally clearing hardware branch records here break concurre=
nt
> perf events?
>
> Since bpf_get_branch_snapshot() can be invoked asynchronously at any time
> (e.g., from a BPF kprobe or tracepoint program), if another perf event is
> actively profiling, would this snapshot silently wipe the hardware BRBE
> buffer?
>
> When the active perf event later overflows, it would read an empty or sev=
erely
> truncated branch stack, potentially corrupting the profiling data. Should
> snapshots be read-only?

No, this is expected behaviour, if we read the branch stack we have to
clear it. perf event later will read empty buffer which is correct, if
we don't clear the stack it will read corrupted data
