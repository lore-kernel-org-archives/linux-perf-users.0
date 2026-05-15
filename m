Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B733EDAA1
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887543; cv=pass; b=oRW3T8cWmLruSlWxw5JcoHlezpsoHG+8U6ULd61f5vnvqbCFozrGfunVxCJ/oI0XzWi4KGQq11L2x2hMKauODMYwVcfrlTKHgh3aO8cQJMfm1P4sTcG4y1uNqmRmQQ6JLICQ8FLY2DQz9LZ2EdojsIR3KYA20CjSUNf3ua2hgW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887543; c=relaxed/simple;
	bh=wnlZk7FzDive6bt7JQLR7LLWXuLfT7wCIge4lpkCT2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC27oUI+XmGKpknPhK26TWtAhEhodIb4ugbZRTd8eEDKu45IfJVxNUU3nKVQB9oEFfLrARqJENqIzo3s9pzwPtEJNAG2aLg0EfMlc4NH9OIkbtVTrHMfz2mRT7HREkNP/5uB+AcKnbdO7jp0exolkWSp7DlTUydDWmriKBTrwo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abdghkwH; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abdghkwH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so375ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 16:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887541; cv=none;
        d=google.com; s=arc-20240605;
        b=fhVESvKmqZogNRQvQY3KDnuXYngPkEjxr+d8Y63Enrwau3/kzPgGkwhJHdp+o3q6Km
         lNfs5mSSHXAwwK0lI5zEHeANwDEtes3VsaQwkCYtBVML/yGRLxAr8swA8bUhxwipjj90
         e2KRxlY2D+J9yRNG8moBXXhwMH5l2tpq988C0Js543DY0EBXO9SlnLwzvd1KBojJzUew
         R2SIQaaJ9Tkg74FGjbYMHPMRnvfLUWgq0OIK3uLrLAN98Fjzxi1JS+VG8pTg4hkzngQu
         wlSdGHiAxx/G4cTT7mtRvfNN7zcW/3em1/PIQkKdz08XESGuLaXBpEYyMYgcNXRWjKzG
         /VAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l4tNCP/wX9oSDuG+qCUOGCypJ+OVnOfWnmlm2c/bfiU=;
        fh=LQLdSW01h2ROUwNK2N5+UwHQ+4lE93qNu55uGrsD190=;
        b=H6dVY/GnMnnH0dio1SheyJpFdUPjYzvfngcY6NoDBOJUVnoOvy5E6/ELfuE0TO4xlE
         vquJ1qN4I/E5St4aiPYADx4gR1okn42619dF8QUB2rMXo5yoJtkGjZ0MBEtEHA10ASht
         WUZTbZD2fUOV54iOciGQJ3Nb0gTT2Vg7Xeg5sfL0Wt7FJTMHk8eb/wUJxw7Q7tYl3Kbm
         FuUwVr/g0ZCBxqcD2QJcYtT40VqDFWgmwcN3PN5GN2tEC0FEVEodqLUfUw3p/HHp3wSP
         Moo+5sUx5YaINNnG2WBtmh/itegniPJ5qsK71yx+PDfipshIt+2GZLQe/ydiXQwU4wOf
         vXCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778887541; x=1779492341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4tNCP/wX9oSDuG+qCUOGCypJ+OVnOfWnmlm2c/bfiU=;
        b=abdghkwHWVSBid9SiohGSKhjXnio7YpILW4maOt1V8B4PxdkSj08sQOaq7GqA1NIGQ
         8ZgafQ/hDBGJ6UoTDvKhQfV2qTDFZkPbYgCcyn00idbdDvDqUfELhzyJKefpPnes8fH8
         a392oizPb6LdkVriklgVD9Rmung4Sr8Bu3Zz1YX96GRnf2kQl7T3Iuihj3KZaaed3l6e
         77bcbQ1FVNNZaBNmLe1OlDln7e7bgZJKigrVkqzcNeFGb7RFf8n9DLco1O2Gxnn+DlKG
         37/Eh2YMXlnyrWQ0kB08x9cN1yWiRnjCdLBNnWWW6tDHKIjQU/7KeJwlJhL83zgi+E3+
         rYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887541; x=1779492341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4tNCP/wX9oSDuG+qCUOGCypJ+OVnOfWnmlm2c/bfiU=;
        b=pTLJzbFWt16fNE6OKkGFNGmtku/rus4H8m0mjcm7jToBI8I7ZcGl0apsNPBEihjV7K
         9pw5z/G6lxnenTnZ0j74VUxIo0Gck8GWlFL1XccuW3T9mONkOMRcFyJ3MhfuTzcKn/Mv
         qqBkUKm3de2TpDpDZl81M1z4UovalZeZsayfG/l5zUhabBILpmLWdNaIzU604gyJxzDr
         3YeoryS32lqc/WrVZpbniOOgqEECti1DMPe1Zkg2oPPIqtObEe63OYahF4fJosWNRVsJ
         l/ZJVc7xlBbcAeP1q/qYwVHNayKDqwbJyrdm1eDVHnIBDUMwZTcvxFay0hG9mznA4OgL
         m6dA==
X-Gm-Message-State: AOJu0YyHYxXQnmttSmdMc0MIQwnZm6wKQGSdb4iDAmpGyxqRepm3K2f5
	qY4J5MK/0olDowjVf8RL5fOmzm2KZugvFKlwH7PaqOVn9m/yKGs+zJBgfpdLf/cr5aFSHJtl4Pa
	QDKLLKZISs4XtfsZnBcB8THYkfcVDcgQ8sGPwG+4o
X-Gm-Gg: Acq92OFXv3/SfTTtrD9lEyyw2i//qTpUnNO2ztjCTVjWAVmkIIoO6odFjC8sxjt6/H8
	X2KVnC8qiSgsfs5A3b32lCYC/5scpZpRjjR8eAN78cM/nJz0w2toDTKUDDoeOZPKjN8IgxlWTBA
	qDbwH4mnR3yLwy8D3+hQXyypNJ/k/WSxju324JWHYsXQ95yrKSJ9PO4Zt7YPIhn7jSHwSnmjayB
	v3Xdi+IxPV1UN8UwHwEE4+xqHzo0MMbE9ZpDmty6Do/xDETxDNU2L0GH8YwOsMtkA2AHQUHpCNM
	zO6LSn2JJ1ZiO0uw4Hc=
X-Received: by 2002:a17:902:d48e:b0:2bd:508b:f3ab with SMTP id
 d9443c01a7336-2bda52d2e38mr466285ad.15.1778887540605; Fri, 15 May 2026
 16:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515193314.1593560-11-irogers@google.com> <20260515195854.1A3C0C2BCB0@smtp.kernel.org>
In-Reply-To: <20260515195854.1A3C0C2BCB0@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:25:29 -0700
X-Gm-Features: AVHnY4IThke5hkHBwB57Ywj1l_hyQsZwmcTJ0Bn2phpSTJbZ-iEudXNVqaXDUhc
Message-ID: <CAP-5=fXM_bGY8uiVa-U9SiFrwY+Dxkrt=s66dfoL9YR7=14Edg@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] perf pmu-events: Split big_c_string storage into
 standalone compilation unit
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Incremental build breakage and partial clean failure due to Ma=
kefile dependency chaining and Python file closing order.
> --
>
> commit 6c014984ddc9092cbb7ef975a3904baefa427ed5
> Author: Ian Rogers <irogers@google.com>
>
> perf pmu-events: Split big_c_string storage into standalone compilation u=
nit
>
> This commit splits the large big_c_string literal into a dedicated
> pmu-events-string.c file to allow parallel compilation during Kbuild.
> It updates jevents.py to output both files and adjusts the Makefile
> dependencies to ensure jevents.py is only executed once.
>
> > In jevents.py, defer closing output_string_file until
> > the absolute tail of main() to guarantee identical modification timesta=
mps
> > with output_file, preventing redundant rebuilds during incremental runs=
.
>
> Is this guarantee accurate? Since output_file is never explicitly closed
> in main(), it gets flushed and closed automatically during Python
> interpreter shutdown, strictly after main() returns.
>
> Will this result in pmu-events.c having a slightly newer modification
> timestamp than pmu-events-string.c on filesystems with nanosecond
> resolution?

So previously we were worried about the opposite scenario. Using &:
for a group of generated files solves the problem but Linux builds
only require GNU make 4.0 not 4.3, which added this group construct.
We may need to drop this change as I don't see a way to satisfy
Sashiko.

Thanks,
Ian

> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
>
> [ ... ]
>
> > @@ -224,6 +234,10 @@ endif
> >  # and inputs are dependencies.
> >  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
> >       $(call rule_mkdir)
> > -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $=
(JEVENTS_MODEL) $(OUT_DIR) $@
> > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $=
(JEVENTS_MODEL) \
> > +            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
> > +
> > +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> > +     @:
>
> If pmu-events.c consistently ends up newer than pmu-events-string.c
> due to the Python teardown order, won't Make permanently see
> pmu-events-string.c as out-of-date?
>
> Could this silently trigger redundant recompilations of pmu-events-string=
.o
> and relinking of perf on every incremental build?
>
> Additionally, if pmu-events-string.c is deleted while pmu-events.c
> remains up-to-date, Make will execute this dummy recipe and then attempt
> to compile a missing file. Does this pattern handle partial cleanups
> gracefully without creating a build regression?
>
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
>
> [ ... ]
>
> > @@ -1476,6 +1488,8 @@ struct pmu_table_entry {
> >    print_mapping_table(archs)
> >    print_system_mapping_table()
> >    print_metricgroups()
> > +  if _args.output_string_file:
> > +    _args.output_string_file.close()
> >
> >  if __name__ =3D=3D '__main__':
> >    main()
>
> Should _args.output_file.close() be added here alongside
> output_string_file.close() to ensure their final filesystem writes happen
> simultaneously before interpreter shutdown?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515193314.15=
93560-1-irogers@google.com?part=3D10
