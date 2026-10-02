Received: from mail-yx2-f37.google.com (mail-yx2-f37.google.com [74.125.224.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF838AC8C
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790985188; cv=pass; b=mWNHzZtACGbGF0QOKJf6QyjseMwUssxr3d4vJWj1aRglg2FnYHb798A3YhWyN/cFF5Saher7TSe6wKzrTv2KjHi/a+nmQUsQt6NJvw/fKSYlJixT3YBnywERXVqshH8hRXDRZ0qMdD51SChth7TvjgM9ifhKqd7bP3oKxDMUhf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790985188; c=relaxed/simple;
	bh=TSRxsIng2LPiyM2hNH2bG7x0/DCnogvfIBYewgQ58xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6Ws93fq6bvlvGVFsuKGZXWQ4/FHHIUvwb0Y8u/U/Sqol2F5PKgVLZu1+cAb3q2QFeY+7p+3/CWtgJePVXXzHTKjtWtu7HhJCkSGWZOfqspJfdXrYMRNJZ/O3yAplW8eVePA+USHG997VQcFIDo+L3yX8i9AFa4QkV5BZ6Vx+6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=q8SF/OHS; arc=pass smtp.client-ip=74.125.224.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="q8SF/OHS"
Received: by mail-yx2-f37.google.com with SMTP id 956f58d0204a3-677a7faac73so42508d50.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 16:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790985186; cv=none;
        d=google.com; s=arc-20260327;
        b=lYmbN6tTP6ReUuIGx4ziuxveGFg0c0IrreeeDiLyfYRBF60mHp9jOchX0vLbm5CBPE
         3MGnQEUALPTeXCGsA5ikpeiE7ccD1P9CUL7PF3m6GjLjL8u8DQw6zoLcZO06Djc2ID4b
         PvVoNNh5mFdv5sLII99XSJGevKo/lLTOYgUVlTG0t4jZdqOjzcJdN5OQPtRWNewCSJJy
         2TQX9S45PdP7PSmV+Zqp+Y6GqfLWRM5twqdI0w+f7kVxYdfdlpnp04GHX49UUIjAl6Fz
         d6gyJBWI9jkj7q9FQyiuchwpJZvqRiKtb9/xBrV0dhcCYjspg0l/07qcxwd6iJq/m9iD
         L5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=snMBNVyodSm2QRZvcyx88wssCDSjiEt9T08zFclT1E0=;
        fh=DoqBoISS8EZE6qU00Gq0KVqYKDuv2toSzBydbeZ0njU=;
        b=dubIIVOq8uBjxySwOKjKAwr/9V7lWgCT4FcAUHu3+gw8T2mmEsV06bitCFlYzs/u/i
         83g4DUxD5DrK+c7unJWW28AqOz4KRdqQEaexzogZ60Jy5QUl4ajpnIjwib08RfF/g7nX
         53m/qQM2pyhIkYIgiSginZzNOuTpePI2XPvQ4BKaPpICv5SUZN98tLNDiiWNtk3npf1X
         WgJETW8b0PsIrxeLgSZy3H2ASa66FItcjt/cVleTIiGexnDd5nN+EM7ydUyyO5M397yA
         v8yBdTiSqX2deWJO67pWenhChUdp4H15v8pu9F2/DumBebb1EgD3997lZof/lizbNPNV
         C7GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790985186; x=1791589986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=snMBNVyodSm2QRZvcyx88wssCDSjiEt9T08zFclT1E0=;
        b=q8SF/OHSdg7NbMsCsGRcn5xGocA4nDcbGLUPZoU4g/U+zDXtA6GYX2IAcp9qX/+isX
         BXDRu7OlEKrfOJnEvO+lHUAD4PBDlvxJLT5dFTYaqY25zOeHoByi3RMGDsZtZI394Yzr
         Bo/7OPSOh4ROJjEpzViryUlmyBSnwkhfX2Ql0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790985186; x=1791589986;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snMBNVyodSm2QRZvcyx88wssCDSjiEt9T08zFclT1E0=;
        b=L/weLQSMGie7hUIWmS77o9YPFjypTspp1HbfYzjrmfQrSNrS2sSGs/2KDIQrwOmUIi
         UAKE7N92btULxm5JHLvLsC9/BbZmNMWagT64dszI5VqMEdTEmIbeiqY3+lkajlxck3pj
         KpzGQojl1381x4/MV3RiqpmJ3qTxqJZBm3NM/I1a+UHfJjAIitp9O/K0KUt0P4K0Bwac
         +ugrojTtjqimioSq8MJENYrlgVjEBeRJ8ZwYQpEkgLjpZkvBDexgOU5iqRdoBNi5Siq6
         OvQ5ewi6igc1RbtjpmS+H8Bf/8wtCaYuHxhKVnNA+ukADVmec5QrkvjMY1jnsnWyKdUu
         /cGg==
X-Forwarded-Encrypted: i=1; AKwUvBxtb0AM5hl+2tiR9h8/fq/buzZRYvfh+GCSEI4KYiRiDMNzl3GqJ7Fv81QfcqRVUKHoEWp3fwqncBG4HbdtJze8@vger.kernel.org
X-Gm-Message-State: AFq9FYKqGHYWG8j2AI1hlHeWK6laFFRkz+p9rlUuAsm9mf+8oYff9GI9
	KzV9MdYrIjoSWm9xo9ClGJA0zZ5hCEabdoTxBJOY6BYIpf4m+kqRvKtdsajonvrff98d0R3Gr1p
	J1J0T90wCmsU0pXfWAKtpkagE7uf2ypsBbp2TMnVaNg==
X-Gm-Gg: AYBFou35EZppbqPSZPc0nAr+SSNmPFldTabVSM7Dli2DVZ21dAI6bBzEviDIT43NwI5
	Kq4k2/9tTRehf2GnP0FbdPOQAKVJqiPMs8nq8lrJwehgyvmIC1nkdxSVlPl4Qua6eHWbLDTROZl
	1ZLr1JLDQnrcx3iZ/VOJd0CPgB8M0LUNrIK0UvcI8x+Scg3HWLH9pJnir/xk1//QnD+PiWj83SU
	kORUUwSHHMeTGmQhZcMCXV2hayQYfOzF6Tsp9A2jM+baIUQ98oXvfvEzBwbG+lAakkDHwC0XsFt
	0fJZkuZWW1O+Giq8Kj8J2EooQ6ACNc0dYa2+5dl1bwoweiLyrwBmenTWtE2twU+63jMaVc7Z6rn
	+bHFZAgvYNwE=
X-Received: by 2002:a53:c407:0:b0:671:3843:62fa with SMTP id
 956f58d0204a3-677ac0ca3a9mr1478803d50.84.1790985185963; Fri, 02 Oct 2026
 16:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-4-0a592bb2539e@uber.com> <CAP-5=fUMvUU=kGkGej4FSTYAMjO_ygZ5uQ4pdb+5NwivdjMwkA@mail.gmail.com>
In-Reply-To: <CAP-5=fUMvUU=kGkGej4FSTYAMjO_ygZ5uQ4pdb+5NwivdjMwkA@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 2 Oct 2026 16:52:50 -0700
X-Gm-Features: AclHuK827T4jon6f_COBhtcH9C1xH434yiGa8Buid9-rGjvKkgkVXDkkQWBvBzE
Message-ID: <CA+w=M=QL7TrqAhd1urQg2BEj2jTxLGU4aDWku8OuF=c1Tbxeyw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] perf script: Add --lazy-load-symbols for lazy
 symbol loading
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:39=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> > +
> > +struct dso_ondemand {
> > +       struct dso              *data_dso;
>
> Could you add kernel doc for dso_ondemand? I believe it is keeping
> state while resolving symbols, but the name makes it sound more
> persistent.
>

Yes, will do. It is persistent per-DSO state that holds the compact index
and symbol source used for lazy address resolution. It remains attached
until name sorting materializes all symbols, or until the DSO is destroyed
during teardown.

I'll add kernel-doc documenting its purpose, lifetime and locking. I can al=
so
rename it to dso_lazy_symbols if that makes the lifetime clearer.


> >  struct symbol *map__find_symbol(struct map *map, u64 addr)
> >  {
> > +       struct dso *dso;
> > +
> >         if (map__load(map) < 0)
> >                 return NULL;
> >
> > -       return dso__find_symbol(map__dso(map), addr);
> > +       dso =3D map__dso(map);
> > +       if (symbol_conf.lazy_load_symbols)
> > +               return dso__find_symbol_ondemand(dso, addr);
> > +       return dso__find_symbol(dso, addr);
>
> Why not do this logic in dso__find_symbol?
>

Good point. Will do.

> > +/* Return the number of entries starting at or before @addr. */
> > +static u32 sym_idx__upper_bound(const struct dso_ondemand *od, u64 add=
r)
> > +{
> > +       u32 lo =3D 0, hi =3D od->nr_sorted;
> > +
> > +       while (lo < hi) {
> > +               u32 mid =3D lo + (hi - lo) / 2;
> > +
> > +               if (od->sorted[mid].start <=3D addr)
> > +                       lo =3D mid + 1;
> > +               else
> > +                       hi =3D mid;
> > +       }
> > +       return lo;
> > +}
>
> Would the upper and lower bound only matter if symbols were
> duplicated? I'm wondering if we can use bsearch?
>

Not only for duplicates. Lower bound finds the first start >=3D addr, while
upper bound finds the first start > addr.

For example:

  outer: [100, 200)
  inner: [120, 150)

At address 130, a range-based bsearch() may return either symbol because bo=
th
contain it. Upper bound selects inner, and at address 160 its outer link le=
ads
back to outer. At the exact start 120, upper bound is also needed so that
decrementing the result selects inner rather than outer.

Duplicate-start aliases are normally collapsed by sym_idx__dedup_aliases();
they remain only with allow_aliases. The lower-bound callers also need an
insertion point, which bsearch() cannot provide.

I can combine the two loops into one helper parameterized by lower versus
upper bound and document this behavior.


> > +static bool sym_idx__from_sym(struct symsrc *syms_ss,
> > +                             struct symsrc *runtime_ss, Elf_Data *secs=
trs,
> > +                             bool dynsym, const struct sym_idx *symtab=
,
> > +                             u32 nr, const size_t *strndx,
> > +                             const GElf_Sym *sym, struct sym_idx *idx)
> > +{
> > +       Elf *elf =3D syms_ss->elf;
> > +       GElf_Shdr shdr =3D dynsym ? syms_ss->dynshdr : syms_ss->symshdr=
;
> > +       u16 e_machine =3D syms_ss->ehdr.e_machine;
> > +       u64 adjusted =3D sym->st_value;
> > +       GElf_Phdr phdr;
> > +
> > +       if (!ondemand_sym_ok(elf, secstrs, sym, shdr.sh_link, e_machine=
))
> > +               return false;
> > +
> > +       if (e_machine =3D=3D EM_ARM && GELF_ST_TYPE(sym->st_info) =3D=
=3D STT_FUNC &&
> > +           (adjusted & 1))
> > +               --adjusted;
>
> Worth a comment that this is stripping of the thumb/not-thumb indicator b=
it.
>

Ack. I'll add the same explanation used by the eager loader: ARM Thumb
function symbols have bit 0 set as an indicator, so the index strips that b=
it
from the address.

Thanks,
Alireza
