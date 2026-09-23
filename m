Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C33AD51C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179337; cv=pass; b=ef1sgVoEZJfAlYJDEPsQoBx0r/0w0fHjJcRCF5Upm1KoSe3XuDTBZ3f4cAa9UjJZ+laeuga56HV8wGBwRTNXM6zNee/DQ+TSlMnQEW+zFPRIRA80M+VpA3hHFd/4wK0SMfde99xfcOm4bqhgbqlCUsQxvrvm/iyjeQG7mZ5W/RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179337; c=relaxed/simple;
	bh=NP+H7PjEoIPuiV93EFzMidYwVu3CLiGCx+Heu7oB4r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUgJm2w/TLQ2VZtktNu5Gbu4/LSWbo1n5M7+gRkJfVpIqk4fCHrW3rK4/6ynjCJhohkvIowwfOqjKARvcwfGwdWCmeDhEAH+3Niz1800ojWanrDxIy02BAQFRj80ZxmL5KvPmJgHgQlQ/zjFAj6xJS3GGBGAXI5O8mPS55+ZUTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uglv+ckk; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uglv+ckk"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-143490b97f7so11476c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179335; cv=none;
        d=google.com; s=arc-20260327;
        b=DBqqye3cAolrarjBhWbHH0/bXRnhpRRnrwf67xPTXxnPyD87nzBEwut806d2tuwyBf
         XPc5VXZBgTA4PLFBhLW1CJvMr1gnvPnlTwfscO7W+oJhWCqeEjGBVtyehYlQAkGPrn7R
         1mA7xtWO/0C7gC4K/P+PomKW26x5CeJrpuHbRbkFDGDNQwq8ggjuzkUOyvFQC9o6T358
         j7tAo2uGSMkmV4EilXJDpvvunHr3wVBhF2YYqqzbb1C2RPaOZGSK+WLLfXT4/qmsSlea
         odd41DwlZ72BGlCnRnRggiwh2No3xmLNsGoht0wk0LIaEsQgzyKo3jI4ufHerrwxHedi
         u77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOKbhUIy6EEpbSvjSPwd3o0SWscGSKfJTKCWmcPuzI4=;
        fh=/RKx6/fyXRWC3mcDbPTAqCt9ei0KooeuzKLo9wz1kGU=;
        b=MHv+UrLIuX1fysC3A/6QDX2Yzv+wE2Np0siC19wzswnfQY9AidFw3h47mva2OoZgYz
         /vKmEZV3DEgPnpVJZiU4TXZ8Ho2l2l4FyuaPjCSgydVvgn18xYzWG84bkyjS9SAsgFAc
         ye2qk0ukLhci4oqCEPoPFhnCt3xYbLKwYoNqZbj9dfRZ8SbuUr1QAQq9aSUn5uoFDEEw
         sgSklZbHMTkodXoqNVEu5l1OnPhelMrG89B9RS90p6vlrXnopmDwlAyidxGyJNynDLBK
         zo5jOQ0d/YY+qzUUC6qnWgAsUUyaoB3hfTn5IKmr8d8fmfrKeKZDSpxBmf7vquYMYW2p
         XaCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790179335; x=1790784135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOKbhUIy6EEpbSvjSPwd3o0SWscGSKfJTKCWmcPuzI4=;
        b=uglv+ckkKbWdEkxpiEIonVhWdxoXoI24tKajsN1VZKwNfk/HhLMSy8hhXJ1REaPWj1
         WO5K1tAl4kAgnp6J+F/rv8HiVgf89Xpyi/Izs9x6vyG6cgTLHOHJK4z3KI38gMYUqA2F
         fzKI4HipHdCW8zTWh22Ggp1uTvCWUv+TeHYlH52OyYLANsBHM665Wk9Wz3ZfM8KLIVIO
         TiKjK7ey0HNbRM4+03lCVnQ5DwuPQPHexGfyC7MhpNNmbhyUAfC30k5H0be4hp3lbdLx
         v280cWHCEigc3NszS2/OqmHja1Yi/k16GT+9dk6Wy66cv/sHipeSh53JSt4abNxg+VIX
         S2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179335; x=1790784135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOKbhUIy6EEpbSvjSPwd3o0SWscGSKfJTKCWmcPuzI4=;
        b=NqYV2A3M8LzzJJ3QZZ2MNCZEFiiJSyFMLBzHoZMVj0p9B563NqFRdRzOgsT+ffc+G9
         Fwdla3OruNw7RuQTkX75BNIhmnYGRu+C4oGW2wsN8oZbzDqb95MvMVcJxHbNRW7IUDVc
         oU+Aal1Yge9J025lpx3TPWftNfOWyQVH9DHT36K0xQ0fj/JL0clCRJuYN3V6OoaQi7r6
         BiEc8rYKSV2tpXcPuZm0ibNoc/3AEiXa7/t/jWp7znbIbwWtd/rCB1me3tKwwn7AD/ZE
         trbwoAOIF3wf117Ong8gup8ZWk9GYrg2iZI+wUVSsW2/Fohu3SYepCiCUiyxzD/wDVHQ
         6tJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdQZScQr+SVLZDuUTOMgz/g9RSRdgDQY7/0WlLnqX25QbX+K4UTy6e3qa5R0HBBbMdm0uRjdHfOhLGAFk5TuOf@vger.kernel.org
X-Gm-Message-State: AFuF++kWkKLagP3ogV3BX/aB7iZRVqCCB3rLWfyArPrwZDug/VluDX/f
	MG/ed3VACKRDq4hFy+nhBIgdijCHdPoepn0hocHzJgNPH2hm6Qgk+B03Y6J9lxVsxt3osPmiVFq
	8vbsH+L+6GBMutj1dp1mpc8d+KFtvQc9v4TCpuf2/
X-Gm-Gg: AYBFou0vp0jkScsb39F5TmbEgVtwqDdwchZKFRxw6P9spvr3VhwEVpnDJTP8al5h02j
	8d3418+Y81sW/CijKzqdY6pIqrI+77+VwWDRkXb8JNReJOe+l34t86IcoRvIEb7uWQ7PFRMIsxQ
	F1hcfDFEEolDNU0vm7B2pN77nkZGUnehMrBgz5CAox2fjovKhjSbR/iMZYJrR6Eb5B3jB2pSKbd
	hRVu+Pi9JcKFDhteY96mbfx89cv7swxREkZmCMYgejvHk86j1iBb4sa7tm/2oHwWRWhoCcA0yia
	am0axj1FFdKxlUKL3DNUkULcZO1pAdvs8XL9LmRbPvZEo41+fcUr4yiUfBv6wMX0FKm8x6N1DTA
	xHdaebI/GWw==
X-Received: by 2002:a05:701b:42c8:20b0:141:5392:d9c2 with SMTP id
 a92af1059eb24-1450301047fmr34774c88.8.1790179333753; Wed, 23 Sep 2026
 09:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923090429.2026529-1-stian@itx.no> <20260923090429.2026529-4-stian@itx.no>
 <20260923091443.2C7971F000FF@smtp.kernel.org> <32d5f620550bab0cffdeac83147ca0a28c9834ed.camel@itx.no>
In-Reply-To: <32d5f620550bab0cffdeac83147ca0a28c9834ed.camel@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 09:02:01 -0700
X-Gm-Features: AclHuK8wzq4FJs-uW46sfVK9Poi2TYUKKlTUYN20qa4CfUzo_WE8zAAkTI-HQCI
Message-ID: <CAP-5=fUuRm3dWra4a-6eNF3F=tafcHvvDipqmDEXN5+ti-sW0A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
To: Stian Halseth <stian@itx.no>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:57=E2=80=AFAM Stian Halseth <stian@itx.no> wrote:
>
> On Wed, 2026-09-23 at 09:14 +0000, sashiko-bot@kernel.org wrote:
> >
> > > +   case PERF_REG_SPARC_Y:
> > > +           return "y";
> > > +   default:
> > > +           return NULL;
> > > +   }
> > > +
> > > +   return NULL;
> >
> > [Severity: Low]
> > Does this rely on implicit header inclusion for NULL?
> >
> > The NULL macro is used here, but neither <stddef.h> nor <stdlib.h> is
> > explicitly included in this file. It appears to rely on the implicit
> > inclusion
> > of <stdlib.h> via the ../../arch/sparc/include/perf_regs.h header.
> >
> > Should this explicitly include <stddef.h> or <stdlib.h>?
>
> My take is: No.
>
> perf_regs.h includes <stdlib.h>
>
> It's done like this to maintain consistency with perf_regs_arm.c,
> perf_regs_mips.c and perf_regs_loongarch.c.
>

This is a low priority item we're trying to keep cleaned up, so no
action is necessary. The issue is that musl libc doesn't transitively
include what glibc does and we frequently break the musl build. Let's
try to catch it at review time. It is also nice not to have transitive
dependencies. But yeah, there's nothing wrong with what you've done
and following the surrounding convention is the right thing to do.

>
> > > +/*
> > > + * The sampled window's %l and %i registers (DWARF 16-31) are not
> > > in the
> > > + * sample; the kernel flushed them to the register save area at
> > > the start
> > > + * of the dumped stack.
> > > + */
> > > +static void libdw_set_sparc_window_registers(struct unwind_info
> > > *ui,
> > > +                                        struct regs_dump
> > > *user_regs,
> > > +                                        Dwarf_Word
> > > *dwarf_regs)
> > > +{
> > > +   struct stack_dump *stack =3D &ui->sample->user_stack;
> > > +   u64 sp;
> > > +
> > > +   if (perf_reg_value(&sp, user_regs, perf_arch_reg_sp(ui-
> > > >e_machine)))
> > > +           return;
> > > +   if (!(sp & 1) || 16 * sizeof(u64) > stack->size)
> > > +           return;
> > > +
> > > +   memcpy(&dwarf_regs[16], stack->data, 16 * sizeof(u64));
> >
> > [Severity: Medium]
> > When analyzing a SPARC perf.data file on a little-endian host, will
> > this
> > memcpy() write raw big-endian bytes into the little-endian host
> > variables?
> >
> > The dwarf_regs array is composed of Dwarf_Word (uint64_t) elements
> > and expects
> > values in host endianness, while the stack dump (stack->data) retains
> > the
> > target's original memory layout and endianness (SPARC is strictly
> > big-endian).
> >
> > This can cause the 64-bit integer values read by libdw to be byte-
> > swapped,
> > breaking cross-architecture DWARF unwinding for SPARC as the stack
> > unwinder
> > relies on %i6 and %i7 (DWARF registers 30 and 31) to find the
> > caller's frame.
> >
> > Should this code perform conditional byte-swapping when copying from
> > the stack
> > dump?
>
> No.
>
> Checked by analyzing a sparc64 perf.data on x86 with this series.
>
> unwinds leaf -> mid2 -> mid1 -> main -> __libc_start_main -> _start,
> the same as on the SPARC T4.
>
> The dump of a 64-bit sparc stack starts at %sp + 2047. It's 16-byte
> aligned, so each saved register is one swap unit and is already in host
> order.

Thanks for testing! In session.c the functions like
perf_session__process_event will swap all 64-bit values by calling
event_swap, for a sample every 64-bit value is swapped by
perf_event__all64_swap:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/session.c?h=3Dperf-tools-next#n1202

In libdw__get_entries the registers and then stack will find the
64-bit values swapped. I'm wondering if the case of 32-bit needs some
fix up like with PERF_SAMPLE_CPU in __evsel__parse_sample:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n3527

The PERF_SAMPLE_REGS_USER always samples a 64-bit value, so I think
they are okay with a 64-bit bswap. For the PERF_SAMPLE_STACK_USER
accessed in memory_read in unwind-libdw.c, I wonder the byte swap 64
done in perf_event__all64_swap means we're off by 4 bytes with the
value being loaded from the stack. I wonder about the code:
```
 *result =3D *(Dwarf_Word *)&stack->data[offset];
```
should be something like this:
```
if (!ui->stack_is_32bit_differing_endian) {
 *result =3D *(Dwarf_Word *)&stack->data[offset];
} else {
  union u64_swap u;
  u.val64 =3D *(u64*)&stack->data[offset];
   /* undo swap of u64, then swap individual u32 */
  u.val64 =3D bswap_64(u.val64);
  *result =3D bswap_32(u.val32[0]);
}
```

Thanks,
Ian
