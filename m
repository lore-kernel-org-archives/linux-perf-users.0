Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943547279F
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626655; cv=pass; b=k81CXojnlkDitbIFwurHwkHZ6KJTIYrD/H2hXB2Fz6eyJ0dT3jWPLuGpK15Hlp7HAtC+lxIU695OmTqxJ0UgibcOA5J4TFA/0FbH6NfM5o2tZ3SyEG8eQ7m4s4JE5BYcOMt1MaqenPhxMGZMfRqMYkXUjizl+gANwDyIKZ3iLxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626655; c=relaxed/simple;
	bh=sDoB2P5KGh+urtsUOmMFkr5mJa72QE7lEpEfZHM2CGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiOJNhzp3Mrl3/cmjexArHjRa6P/r3MbYe+RmTMGr+EyldCtkTh9wkUeT2+4kGF2CiJF2UVDoOidwt0M4eouGwxRgGoK91IefHKFMTBdhCwHg0CD75EhwlVtM0qdSrVid9QIyXLG531FagNoFIDtR/+3W0F1lNuTxm1VB7Z83Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI0ptmhQ; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI0ptmhQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bef8b97655eso6088766b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626652; cv=none;
        d=google.com; s=arc-20240605;
        b=ZoTCF1c8ml6oP1Rf81lCSBVf8YWuqMymL1GZGW7t3AC/451NvujpdGSyTtS7ghdkjv
         6M56/8pqlCE3tuU708TfeTapGwY7oIXwMNhPzHaOziWMjPfdGwSX24tjLJj3jOCbZyWE
         GJ9ciMOxVKjWGJj4wkTWVFWAj5AQWJsiED5iz1241vp8By5+TC9jtS23IyEWflyuXWXi
         WkT3z2Qz9NB8K1/3gsDXXIVqbokosd+mlL74Hy1UPl+XjeKM/YzQuxBK+3ZAdMDUCOIV
         zwRy68hG8D/KRXWV1lN2V3QaV28Fs9aV9CHHJP1s9QY9VQCuaC0WkgTqYEQEB921rpJD
         TXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/uFuJQBCMQ82TTH2h3ox5BafprtAZOSVIE0bYWfxjhM=;
        fh=UFbno6OZ5SGNEV2BAFL6NBpbAZjnOkhP1SraYT9eMMQ=;
        b=h8T0PpjcaJJVa+eQHvJv1oAAL/2aS+ZKLXWguLhVVHCrRNt9OJnI0Mt++TBn7VrtFv
         5CEMaJ17bVdUsMFmUr5IhHGXE0ywOtkTrBi0S4fk4pIpDmnreCzNkKoReNjQfK22uYk3
         0yCkFhjde/TPgY2qJYMRL+qcXgjakxzStJgUaRqYQbbQBXQaUoPSVpCol0/hEi91tR8L
         ZdkLXuRotSU+4ZlkPnRvV8+L7KUhRnAheNnSwKkMoKc8VmRy+uXTaPOs7jscn5TgIBWv
         h841ekHQE7b1z3/4vzfZ1ztCzE1qTY4eeRZzReKoM+/sIR1eM05hshjVHVlfCSUTLh5z
         i4/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781626652; x=1782231452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uFuJQBCMQ82TTH2h3ox5BafprtAZOSVIE0bYWfxjhM=;
        b=nI0ptmhQO5RQbzIwitUUGA4ngN/zXr30Pqr5IqTYOs/GR1+1tDkfVXBdhbgv8VMMp6
         gT6XOM7UlGqudNgTJEDud5+4vrJId18IcL2wOmY8EumPAOlInRmy4zYBWl1kVBdCUGKA
         WHVAf+XalLKVGSTTC+na4dhWnsMkaa2fZx8nHQk+hNHoEawxOxCnB0zBxUGm4aVZwY5+
         eKLpK7xoyFQ3CE/CSmX0lbRRMAdh++ylIanV6q9Lfrh1xWlg2yWuEozC92kQKpIKVoz8
         MAdVDtzO4KieuB3Mqrn+P1EInTRS3ylu+DrFw4/olkW/tg7gd/ILg4CQZEZ83QebNEt/
         RV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626652; x=1782231452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/uFuJQBCMQ82TTH2h3ox5BafprtAZOSVIE0bYWfxjhM=;
        b=rpylp+NvqUvthBTg37uAmcZaM+3UJy3k7o6uBp/5mshxqX8OeljIOPPJHXfSJeE+ZX
         pnDuQ/n0sANQAEqsjHSafQVFnaUfrzUCQzmJ17pr4UZRB8VmZu6N6Ue1hEcyxHr82agg
         eYXJDu7GLZvHyjocm1EP5GKg3ay+dNdrHX9WffhV9fW7Ml6zTDSFNmNL4vuBI4v1glE8
         ZONTGwVrEg0IpG8qOpO+VbT2rbyPn17UH9DQUjOpxUdsNdq9I1RzgH4v0VM6XWj0d6CO
         TXK3CTrz22w736hgLmTwPiXXuHWrRDDP/NrMjRRqvWDmC/avTbXs1T9+BYBluSM7unNQ
         nBBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fjFdgLdwTSxj9+y3LZXttLpK5aFmVu0jvOG5qyZ8wBem+wch842JhCL70ti4iSj+GHiJb+7SRHd6+3qYUt6iX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbFq4n5L6uNPzb0QKgWEuNNNx0aPcgGS1MYh9v7QYjWUUTeVr
	sH6ITecCIBFQIh1Wgzr9N07pADjOoNmGUVInM5B+SePsWptwX79lwp5rTfuLl9rjQyBf6RGZg9G
	rT1uavQjGJy2puvkntxyW/OpVvgj36S8Hre5K
X-Gm-Gg: Acq92OFjhIpkfdlEZPdfk/yitGc6zGGzxSliSRfzvAa5sS5DeU2flIK99TXXGuzAoqW
	9uVvFX1yKCyA4hRrttHNsF6ASBjysdHHSsYCkI9ob5C+e1PMwLXK7Z/P/iJXuoEChCR5AZsMXVT
	+Qf6/y03KFSYzoZ6Jq7Vz03R6DcZ7HQ4s4GtPEG+J2sCmmCze+It3YoCFmo42Pt86DRrjw9ZPiJ
	nOKtIvbLyN7NumxZijn8gyOT8tIfVMxncKroKKYeyfL+XqU/X86AR5DwnF60WXD839DmGkrdUAN
	Mo6E2QhefCLADDM0gX1nhD0=
X-Received: by 2002:a17:907:9481:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c05a5c03690mr23715866b.11.1781626651956; Tue, 16 Jun 2026
 09:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-4-puranjay@kernel.org> <20260616161518.088E71F00A3A@smtp.kernel.org>
In-Reply-To: <20260616161518.088E71F00A3A@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 16 Jun 2026 17:17:18 +0100
X-Gm-Features: AVVi8CcjIbUgmhOIANgIq3WI0JBsLxxPAED7PPgYm_NfVPOLivA9qZEJ9eiduv0
Message-ID: <CANk7y0jy5w7TwUnvtTbqOKHOYZFQfco0U62S5UHwoFv2+4c1xQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:15=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] `arm_brbe_snapshot_branch_stack` contains a TOCTOU vulnerability=
 where caching `SYS_BRBCR_EL1` before disabling interrupts allows a stale v=
alue to be restored, unintentionally re-enabling BRBE if an interrupt disab=
les the PMU event in the intervening window.
> --
>
> commit dbaa008d5027ec5e859cbcac51237295c1187ed6
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
>
> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> perf_snapshot_branch_stack static call for BRBE. This pauses BRBE,
> masks exceptions to prevent PMU overflow pseudo-NMI interference,
> and reads the branch records.
>
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index effbdeacfcbb3..a141ad7abcf25 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> [ ... ]
> > @@ -774,32 +795,97 @@ void brbe_read_filtered_entries(struct perf_branc=
h_stack *branch_stack,
> [ ... ]
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
> > +             isb();
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
> > +
> > +     /* Restore BRBCR before unpausing via BRBFCR, matching brbe_enabl=
e(). */
> > +     write_sysreg_s(brbcr, SYS_BRBCR_EL1);
>
> [Severity: High]
> Is it possible for a race condition here to accidentally re-enable BRBE?
>
> SYS_BRBCR_EL1 is read and cached in brbcr before local_daif_save() disabl=
es
> interrupts.
>
> If an interrupt arrives in this window and disables the PMU (for example,
> an IPI calling perf_remove_from_context() that invokes brbe_disable()),
> it would set the BRBFCR_EL1_PAUSED bit.
>
> When execution resumes, the bailout condition evaluates to false because
> the PAUSED bit is now set:
>
>     if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED)) {
>         local_daif_restore(flags);
>         return 0;
>     }
>
> The function then continues, and blindly writes the cached brbcr back to
> the hardware here.
>
> Since the cached brbcr had BRBE enabled, could this unintentionally
> re-enable BRBE globally despite the kernel having just explicitly disable=
d it?

The kernel doesn't leave the BRBE disabled, it enables it at the end
in the PMU interrupt handler and that is the only place where it is
changed. So, this scenario doesn't exist in code.
