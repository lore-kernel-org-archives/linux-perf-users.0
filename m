Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C526E711
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074773; cv=pass; b=rsNXzV0+MuoOr+LdO9d8v+u6/p6A0n+qvKnVrNE5iR5AANpXfWTiNnNTXHDZn9NkoMWAFE5vUsrX7M3EJb8KasgsEM/0uua3/ZlH6HhWVC4tApSGzc2Gzdxr74Tknxooc33qh6g5P/nKm/2YfgG31HvE1+1k6yUY6qWRTnINrfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074773; c=relaxed/simple;
	bh=U/1q8St8TnmA/SZCFHzc4m+lx+G8wwA4LU0u4eP7hcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKwpPHveT8RVB4RfvuGE3ZO9CbLSs42Rt9/aNsvAGxQs0EIIqdPsTnbOZjDGIUZKV+CAtGQll22gE9lcua1lYozPHrBoOng2kOLn3uKUmkZ3hTfQCsZ22gPlXWF89mWXGR+MSiDMvmMyZXH8sfcP8PtLzoMb5UkUCYgHDPAOQTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzwEOpfx; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzwEOpfx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2591757fbso31665ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074771; cv=none;
        d=google.com; s=arc-20240605;
        b=f6j3BTn6Kl4hI7/7hgWwvE8TVs6AsZpl+negsppEG7lJYBX4SW0f2e0LjT6BGOt9MO
         /TyOC1PWkwaHJM283v92gPsi3PdtHU3J4RfeNFl/+CnrcdIf16LlhhEZFFLBHKWFdj5Z
         5i8zSqROHQoS2PccmCDuc2rLWbgccKb/JypFupAp3w0bCT711osgo/utX0Pj5un/gHkF
         dH+5cWPTiE4K7tcGXYQIbAHNqci1Q2gMMOcP1YROFlXGmaQlCRREdcpxkQkHXruCnq8O
         rDr9dL/AMQPFuGzqigTuWxRNxfSJWY3LCPeW2hAPjh1kGF5V8O01rj7e6WOU7mxavR4B
         tDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VogKmgMJI/Iz6W+JNUsewCe6JfJostZibLnqG9U396o=;
        fh=BBXy+spPhf5l1N8q8lO9rXHlqI+l306nRl3MONxsg4A=;
        b=Wyjw03QvOqLkYYwblOnZagBNYSU/wBJEno+7tTKqbX0tZhDS6cfZVLhxKWpfSqP6cq
         yFFg90Ij/8We/m8h7OO9+XCCHRTqZFMd+egQSBnJG/TT2uybiTMumBRFLBmDmbcqZgcH
         d4eahsH5jytopAHrhqWUpEnTOxNrIbM+nG9BxC0kLdLA+FstVhwfiENTSYpOV83VYb2y
         eFhFCHMxe8wLs8AZgQkBBptsGN+3XQ2jvsZeghTEUPROed0dnViF+m21e1SVzLGPHlZN
         uz7JHQUUsXUg/O4VwHOuZKnu5loWZQfLKPf2nvTndANrr+Gu9qZfmTMfqe/dp/C+KgiJ
         g54Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074771; x=1775679571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VogKmgMJI/Iz6W+JNUsewCe6JfJostZibLnqG9U396o=;
        b=VzwEOpfxg69GbQDgkNRbSm60lEQwP756uyt8vt6rjqlx+Gzojymm8yFzMPJrjgHy5K
         Zs4MOBJkCU0uQQ7lvdixVR62r4t2D84AxXmQ5xYqLcoZ6PUGvZ695pkF9FsqkJ8LOe5L
         yO7UriPpoP6b4fUt/ECbRn3m7BQvqraX+y/E1RwjmT0CO2cvmN5PVX+xnELo1x2XenYz
         lAU4ln3P38uByJBEPWOW36tHtDC2lxWSJWzNnSe+7j8ut5eN6Nv6Y5z+C9xKhzgnocHP
         1CZYnAH9iGJJ7HSL8r4R5rXeVz/gjdzUUPUW27WRuVmCKccURtKP7OkzJjA1OPqReebo
         kBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074771; x=1775679571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VogKmgMJI/Iz6W+JNUsewCe6JfJostZibLnqG9U396o=;
        b=W/pOyO/ZMWYpxU3r4/GrvWBmVCiu3mC1oiMWMO+3mGvc1joPANY2zaGY5VcPoCPcvo
         ZijMEKf01hoDpjXfT6hRMRKAiYFpAu5yt8hItdkl0jC5/EZ2t/QjVDbHKwm9oYxAvhga
         HgetTj7tGSrDXxbhiWEiBi3/ErpJUNyT42lzHAItsIzwjNMznDUAwPsqgzCQ81ENOE3h
         YBtZoExdMnWdaGFEmbh0Xc5HWqukSYn50EG9v4tvOmxTq0fDBTxrwliznAqT52ms/pAR
         JLKpJ2bQ/KcYE2xZvnIfWQFhwhCCIQLKQb8QHMQUiyqGrvhvoa7h8vOpv7CHr0qddCdO
         eFow==
X-Forwarded-Encrypted: i=1; AJvYcCVB/Rneq+bVHjWcy9pHR1pxV4gtTU6jCHyHUdian9UFOT4wYoskyUqn4BxNbwGlB9G1L0PtodX4zbYKcVjGidUN@vger.kernel.org
X-Gm-Message-State: AOJu0YwugYYLKy6pIFeq8fhLJ8VQCrIXoSd6UrW6v/Xyu+imH9DOJnDT
	N0Mcgfz36FoO2HtmxpN4+xaH7qSztz5KCCt680qjNrEovxRP9Z84vKTBh8MNMAUQWAIvbw8qvdp
	mFTPx3d4AccuIxn0C0O3I8MP9QG7vKHzwfBZfHinw
X-Gm-Gg: ATEYQzweN/hbJNc1qsWGkHFAHZebzizKk0au3oZhuQN68IoGICulxrZuQIqhga4Hgoz
	Fmys2+i3uraqAB5hmOZw1Avo1ZVkvoo6148wxC6TVOtjcfOywMBxuGTaO4oz9zrncSUWGc5cZ5H
	AMlzNKom/Jlp/Em6yRAPkBBXjQO8orzHPMr01vM9GUP3HEufKIn2PrHg5FX2+/UEgTULs/7mC1F
	PMIUvUzr0jyH79ZSP0iKb54yyO5FMWDFNEmKr2pM4MHjfK1qt7Ck/1fGmP0D5uFvBQS9giXsqgZ
	Vgr0cSlqhWLfPs6aKap6guwn4GQD53Q8IlMF/dBwjlweadQ=
X-Received: by 2002:a17:902:f60d:b0:2b0:b925:da98 with SMTP id
 d9443c01a7336-2b276adb1f5mr409195ad.19.1775074771009; Wed, 01 Apr 2026
 13:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323155804.7216-1-cel@kernel.org> <cd24821d-2357-4203-85d1-8db37ac11640@linux.ibm.com>
In-Reply-To: <cd24821d-2357-4203-85d1-8db37ac11640@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:19:19 -0700
X-Gm-Features: AQROBzBlX5tvfvU7oitjZCWtgvyVdsCgmq27PVrASnBOp9QPIi2e6fcxitRpTB4
Message-ID: <CAP-5=fVLHeR9Nd+s4ifhMWQ_jXw6cNpdeCD2P2WnnR+frQ_Emw@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Fix module symbol resolution for non-zero
 .text sh_addr
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Chuck Lever <cel@kernel.org>, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:19=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/23/26 16:58, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > When perf resolves symbols from kernel module ELF files (ET_REL),
> > it converts symbol addresses to file offsets so that sample IPs
> > can be matched to the correct symbol. The conversion adjusts each
> > symbol's st_value:
> >
> >   sym->st_value -=3D shdr->sh_addr - shdr->sh_offset;
> >
> > For vmlinux (ET_EXEC), st_value is a virtual address and sh_addr
> > is the section's virtual base, so subtracting sh_addr and adding
> > sh_offset correctly yields a file offset.
> >
> > For kernel modules (ET_REL), st_value is a section-relative
> > offset. The module loader ignores sh_addr entirely and places
> > symbols at module_base + st_value. Converting to file offset
> > requires only adding sh_offset; subtracting sh_addr introduces an
> > error equal to sh_addr bytes.
> >
> > When .text has sh_addr =3D=3D 0 -- the historical norm for simple
> > modules -- both formulas produce the same result and the bug is
> > latent. As modules gain more metadata sections before .text (.note,
> > .static_call.text, etc.), the linker assigns .text a non-zero
> > sh_addr, exposing the defect. For example, nfsd.ko on this kernel
> > has sh_addr=3D0xa80, kvm-intel.ko has sh_addr=3D0x1e90.
> >
> > The effect is that all .text symbols in affected modules
> > shift by sh_addr bytes relative to sample IPs, causing perf
> > report to attribute samples to incorrect, nearby symbols. This
> > was observed as 13% of LLC-load-miss samples misattributed
> > to nfsd_file_get_dio_attrs when the actual hot function was
> > nfsd_cache_lookup, approximately 0xa80 bytes away in the symbol
> > table.
> >
> > Use the existing dso__rel() flag (already set for ET_REL modules)
> > to select the correct adjustment: add sh_offset for ET_REL,
> > subtract (sh_addr - sh_offset) for ET_EXEC/ET_DYN.
> >
> > Fixes: 0131c4ec794a ("perf tools: Make it possible to read object code =
from kernel modules")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  tools/perf/util/symbol-elf.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index 76912c62b6a0..968e269d9be1 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1356,8 +1356,12 @@ static int dso__process_kernel_symbol(struct dso=
 *dso, struct map *map,
> >       char dso_name[PATH_MAX];
> >
> >       /* Adjust symbol to map to file offset */
> > -     if (adjust_kernel_syms)
> > -             sym->st_value -=3D shdr->sh_addr - shdr->sh_offset;
> > +     if (adjust_kernel_syms) {
> > +             if (dso__rel(dso))
> > +                     sym->st_value +=3D shdr->sh_offset;
> > +             else
> > +                     sym->st_value -=3D shdr->sh_addr - shdr->sh_offse=
t;
> > +     }
> >
> >       if (strcmp(section_name, (dso__short_name(curr_dso) + dso__short_=
name_len(dso))) =3D=3D 0)
> >               return 0;
>
> For s390
>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
