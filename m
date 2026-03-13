Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF733148D8
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435839; cv=pass; b=OOFSdzmGKlq3g//UUYrXWYXTvVmatELGKF48ZzLRAknYYI8n5Wo9F1Yj/2LpXeI+zASS0KF9sxqymVaq1ZNp7ldFCM4yjRxUdexVZoo58LsoSNq6R7ehZCTLGj9TGgaYmApUriq94bpYQ8RlzYfyGbffNe4RFaAwQeiXnO3sVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435839; c=relaxed/simple;
	bh=1R0Lwql6nSOQ9kWNCc0PkQe60FSIwExCWTenK/CGDLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNsNLHnK7dbb1WnYkcDq1NQCTV+Id5L11vYBEG+39wJp1UkV/3Kf5lBw9aiHjCgnO5LWYN2nX5c9JXiYU/FPyKiJDzzG6Eoa/74dtTO7NHBZJGFO0rmKct7NURcLJmHyxXjoGi9e0WJpPsm4fu8MB+6JJYOsNnc2Np0sfJm1Kws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt+PPXzG; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt+PPXzG"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66391baf250so2293004a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 14:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773435836; cv=none;
        d=google.com; s=arc-20240605;
        b=WpbjKAPfQ42CBJGi9XbW9v9lhhhMSjsDcfuJo5EuhDFfby6DYTl1OpdzjaNxyjTu61
         NNT4KceyS94Vi6kj29mWMA4oTBJ3kSwqsnkaOt1cNps4IeFXYyb7jyGowHogQPK3SUZe
         yqfcPFz8uL+BytZ+alF2bqxaWcnUREn8hKyQKUHyNxIDEI1SMn4Tq4sa89iBkrBuMpHl
         qU/PZCjy3MJtb6EoX6PqI+Csj/q352YDfly6ZW83dAaI2ORZAZFFVLM+6RiiIykVJOr5
         17GOTLvIAUNRjcAG50YvEG4gu7yCXh4Ymm8ozxAmQkSvPOCirZX18sTrao9QFFvHsLyU
         66KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+/kZwgdWmNGCktNPe763uSTYgyKSmDilnHXCY6tJkRM=;
        fh=U0oAe41QuMmE3LSB2oSuiADLmpOV8TeyX/FpQEVNCFM=;
        b=XqWle5r0T3SD6au4tpnQHQDvmnBhAFk+SBekg+VCYRAe8MMu2VbFDMvA1JkyCcvWbB
         vcjKQq7Ig0baja//BUIrNA6wLCQHgzXoSGecRA+PAyUfzs5CyMDrcdhGESEV1NXVxDXi
         sYPR4P5iXKlPjFWuqXTLjyYmNoLsk8h01EeoVryPeN3SKkC+JDYuSRqrQayjxrSsvvg5
         /Zv8ldjWKDK1Uy1PCNcwnn1Xy1ENaYopIYPkhgMsAHUWxbmTtordFf6oHe/uMlt0iDXP
         7pOuBQnpSKSOiUuy/qRKVBWK7fMQzlTNpwM4ghbSDEMLO9eZ1veZ3yRenqw0xww41HlK
         HXBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435836; x=1774040636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/kZwgdWmNGCktNPe763uSTYgyKSmDilnHXCY6tJkRM=;
        b=Rt+PPXzGHR7RSUYpAnBr6bRN1SHpw6OIqwckkvAuccGhw+jMAkuNHVJFTjiXaIBVde
         PWpy6GjywIVpCOM4riZ+Uydcf/rnRapbngH7gu7R/T5H49y2hGXfe0ncLJq3r2VFOaG7
         df4bdsb1YdwNuNtLvTp7OvxCU0gL4dLTFyTiSDGocjyW+c7XUD+iL9jLnSk809oP9GZ5
         tnZahy3Ke6e0jb3ecqRqhM7mHh0m7TJuQR/1ofBv0m8rPuJVK+62LuWWQXZ7wD/jNQnY
         P3Z/mXm04cL16vB0uK+X1PPsR9S4XgyT6ZPHDD6XrKl0ix564D+vZe1jc404RZyZalqp
         rjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435836; x=1774040636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/kZwgdWmNGCktNPe763uSTYgyKSmDilnHXCY6tJkRM=;
        b=TqR2f/eEUQT+RziIT2xk8gzwbb9E32L8oCLAmvXMNdyoMBHkgaLNWPtRjFRByJOw90
         kKO1V5XqFY7taGx5wyjrc3IP5U0J0kHFNgLbiLHC799Fnts1JBpuXFVW8I0CykMu7PVf
         vCJcu0feOxUpKwbZQauRcdy0Zxsyrcudtf8h1LS1PBf/ePwcxjPXF25f5f/UJOYhB58t
         dsy3iDfqpQmPc3WsrHdYx0v1zVcXrGjh2LBdo96SHBL2GwJ6vLkWzq9/4LTVasZolJjE
         lC7CC1XxHtw4XA3pv9YsnnCajAh9SzmGVGR5GabBn0ON3FPEXamkpShEChXKmhI81SYj
         lDnw==
X-Forwarded-Encrypted: i=1; AJvYcCWb2/q/AeNfcF21Cr2lc8xthc6Ep8j8qFu+96sopjYHvCdB7NTqPXezu6aiUdqWQMDxvUs2RW5prBItshVHIW6C@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgKBP72emE3yw52TLexYyjYYhBTt4myhuaQRsAZ6rPc/quOAb
	5pnNB10Nh6zu4W/Dg5jB5DzW0HnS4O1qmqQ06XqAvD3eeVLpQhEMcnIV6ZFmHOf9R5a4d4OKliL
	Ud6+CIKjnqz7cnlgtTVtYa1X1AzUuUmw=
X-Gm-Gg: ATEYQzwh0kW2B1kquZSks9+uz9XFRfdbq+gbY6hfE1gqF7HyCTpzKq6vFXt1xKPV3gv
	kVKUiA9k1OFAEtLIPuj/6x5pvcqNo2ITLibv6vxbP44+3Q70tGv7mD3ZfPwbWc2Geihke9v4K4T
	1prvCUmdnlT7tgcsMMGkFcr2Rp1iNgYNrmNq019Ff2X/2QEG2wMuDmgsABGW6HKji/iqvwfQFJG
	et9gfwY/jvfyzIxKWc8+VZTmkF7xGTAIMkkZP2aNHHEbB4lRU+0h9rtpYn7BdGWW0YarG4AenEX
	7NxojZLMAcfJVJXe8JML3tAQgCowv3P4/PIuRWe98Q==
X-Received: by 2002:a05:6402:1ecf:b0:662:a4d4:abe0 with SMTP id
 4fb4d7f45d1cf-663ba9c2abemr3063467a12.3.1773435835673; Fri, 13 Mar 2026
 14:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313180352.3800358-1-puranjay@kernel.org> <20260313180352.3800358-3-puranjay@kernel.org>
 <CANk7y0jjd6XC7nd2BxtsVhs8vWp_9cC-ckXPGRQK_CW5BSuogQ@mail.gmail.com>
In-Reply-To: <CANk7y0jjd6XC7nd2BxtsVhs8vWp_9cC-ckXPGRQK_CW5BSuogQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 13 Mar 2026 21:03:44 +0000
X-Gm-Features: AaiRm509-qHusHx4y7ZJiuiluPbpVvicudHEcA8o5FlqQsneTuZnsmCxW0jMUuM
Message-ID: <CANk7y0iGmXCLNPJ=W4ZV9tRwWXXK4KmTATfV081kLX51RxJmkQ@mail.gmail.com>
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

On Fri, Mar 13, 2026 at 7:59=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Fri, Mar 13, 2026 at 6:04=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Implement the perf_snapshot_branch_stack static call for ARM's Branch
> > Record Buffer Extension (BRBE), enabling the bpf_get_branch_snapshot()
> > BPF helper on ARM64.
> >
> > This is a best-effort snapshot helper intended for tracing and debuggin=
g
> > use. It favors non-invasive snapshotting over strong serialization, and
> > returns 0 whenever a clean snapshot cannot be obtained. Nested
> > invocations are not serialized; callers may observe a 0-length result
> > when a clean snapshot cannot be preserved.
> >
> > BRBE is paused before the helper does any other work to avoid recording
> > its own branches. The sysreg writes used to pause are branchless.
> > local_daif_save() blocks local exception delivery while reading the
> > buffer. If a PMU overflow raced before that point and re-enabled BRBE,
> > the helper detects the cleared PAUSED state and returns 0.
> >
> > Branch records are read using perf_entry_from_brbe_regset() without
> > event-specific filtering. The BPF program is responsible for applying
> > its own filter criteria. The BRBE buffer is invalidated after reading
> > to maintain contiguity for other consumers.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  drivers/perf/arm_brbe.c  | 70 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/perf/arm_brbe.h  |  9 ++++++
> >  drivers/perf/arm_pmuv3.c |  5 ++-
> >  3 files changed, 81 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> > index ba554e0c846c..db5e000b2575 100644
> > --- a/drivers/perf/arm_brbe.c
> > +++ b/drivers/perf/arm_brbe.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/types.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/perf/arm_pmu.h>
> > +#include <asm/daifflags.h>
> >  #include "arm_brbe.h"
> >
> >  #define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
> > @@ -618,10 +619,10 @@ static bool perf_entry_from_brbe_regset(int index=
, struct perf_branch_entry *ent
> >
> >         brbe_set_perf_entry_type(entry, brbinf);
> >
> > -       if (!branch_sample_no_cycles(event))
> > +       if (!event || !branch_sample_no_cycles(event))
> >                 entry->cycles =3D brbinf_get_cycles(brbinf);
> >
> > -       if (!branch_sample_no_flags(event)) {
> > +       if (!event || !branch_sample_no_flags(event)) {
> >                 /* Mispredict info is available for source only and com=
plete branch records. */
> >                 if (!brbe_record_is_target_only(brbinf)) {
> >                         entry->mispred =3D brbinf_get_mispredict(brbinf=
);
> > @@ -803,3 +804,68 @@ void brbe_read_filtered_entries(struct perf_branch=
_stack *branch_stack,
> >  done:
> >         branch_stack->nr =3D nr_filtered;
> >  }
> > +
> > +/*
> > + * Best-effort BRBE snapshot for BPF tracing. Pause BRBE to avoid
> > + * self-recording and return 0 if the snapshot state appears disturbed=
.
> > + */
> > +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
> > +{
> > +       unsigned long flags;
> > +       int nr_hw, nr_banks, nr_copied =3D 0;
> > +       u64 brbidr, brbfcr, brbcr;
> > +
> > +       if (!cnt)
> > +               return 0;
> > +
> > +       /* Pause BRBE first to avoid recording our own branches. */
> > +       brbfcr =3D read_sysreg_s(SYS_BRBFCR_EL1);
> > +       brbcr =3D read_sysreg_s(SYS_BRBCR_EL1);
> > +       write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> > +       isb();
> > +
> > +       /* Block local exception delivery while reading the buffer. */
> > +       flags =3D local_daif_save();
> > +
> > +       /*
> > +        * A PMU overflow before local_daif_save() could have re-enable=
d
> > +        * BRBE, clearing the PAUSED bit. Bail out.
> > +        */
> > +       if (!(read_sysreg_s(SYS_BRBFCR_EL1) & BRBFCR_EL1_PAUSED))
> > +               goto out;
> > +
>
> The code below doesn't implement filtering, I am currently trying to
> figure out the best way to implement that by reusing
> read_branch_records() somehow.
>

So, I thought about this more and feel that we don't need to filter
for a specific event because the BPF program is not associated with a
specific event, rather it is associated with the CPU where it is
running, So bpf_get_branch_snapshot() should return the branch records
from the PMU of that CPU. Now, if there are two events on that cpu
with different branch filter types, let's say
PERF_SAMPLE_BRANCH_IND_CALL in one event and
PERF_SAMPLE_BRANCH_ANY_RETURN in another event, the perf subsystem
configures BRBE to record the union and then does per event filtering
in software (brbe_read_filtered_entries()), but the BPF program should
still return everything that was recorded on the CPU, which this patch
is doing.
