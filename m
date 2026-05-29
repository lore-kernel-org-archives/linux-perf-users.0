Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC1390237
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076524; cv=pass; b=HiJfao6QXYCxBGK2W0vgeVpcMbQfihh5123WG8tACbaO5H6kjjXnOJUTBh/YhWpPvJPVn+Qyk0EjojndfURFi3bxhnpdSS7Der4RKQ/rC/CFmnEEnVVt5ajEFVGBRnBOWbmPLf0HGR/eg4fZeyrzhPMn+DPD2Me2srvIOdIxFoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076524; c=relaxed/simple;
	bh=BJeonEZdoXwxXmmMK/D3NNQiRAFWb0eigy/nlt5BihE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZjc9ziV0bgHcjnCxrYlC7fLF5Z2OunsEoAQXdTL6Icy9tlvbcT3wm52rD9Ebn/j8k+ynKbmbCJ2YmIqKgDI8L63csoYsg+eYnVmoJqFxa+r35fXSPrYV9mO3SMLGq7G8xiJKLhRvNMTm9K5jBqL4J+S2hlmDp2UUN/uTQLz04M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMqjnKSD; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMqjnKSD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2d865383so95ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780076523; cv=none;
        d=google.com; s=arc-20240605;
        b=EA//3oYDsQtMqorWYhC3JFf8Krbtz3wT0UK4P9/fHzbIys+HC0/l7tebdgs6HeqQgX
         DwnWcyJlfWAwRscglfUzCOWh5tvWQhL/qNHgSAFE6IdlxNlpuBYaEtFUfOHgCdkDgtBL
         lyBmo2WIFELKk+cJl2U02Ka+EXt9eKTTzOvTFI2jUJY8i2C7kB6qG3mEhpb0SIrTZl7o
         9XfW2LXQ0BIFxlEoGrNBDoe6AR5MaTNgFEUe/SjG833x+uFIdMJosQxkAFHWxPrPnmvD
         Yxqk7YcFWI6sFz6ad8iVRROfgYIYqgQdHDy5uLBVhlwEmH8NUlE/7vql0dKGn0SDFNhp
         RcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YX4oF6pCObKTl0kBgsQiOjoOSc/kNJefAsPyHQO56tQ=;
        fh=XJC//ADKymPRTeybMTBwTexR5y9A8nan0QaItAcRB98=;
        b=AWGQBvcPx7rNczSj6QxsWQhp1SUvceUoqHfuqOYI9TovvLg45McWaTCcDT4Bmy+azV
         LSK8vrFNH/fmc3QJqBQNd24BGNtOQSDCtGb4Zz/E194u5tcf+2E06RHvp2HxbnS5cWn8
         71VRJjQwsg0XrTEcfTQ8c2LrZfq96yozFcwY8oArH8um16nlevY9zVgiFsECuBUKzLrG
         eegNv12Dah9PUfRXQILa3hFH2xAk6VQNZbyoftVebmESpmpVvbmLCH1uReKk5IVmfmAp
         eiHlFnMPOGdY+tDeE5PDsn/kEvgG2XEicGZtIla58GpvmgegnS6lLi3rRYt9ZyPnoPUa
         SivQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780076523; x=1780681323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX4oF6pCObKTl0kBgsQiOjoOSc/kNJefAsPyHQO56tQ=;
        b=sMqjnKSDTJ/kOD1YrVnCh0PtUO1yLVAZdvtV59jgH25khZ+0Iyx4D+5d4ajespjXCE
         QvSGZtYlRQteS9kVAmDWwhx72NnMlc4x992TXhGeKJVVtQ0ZN26jQ7LFUJg6iERGgjwT
         9pv8x3OPzsssArubD8dfI6dL9hA1wa+hfi1SnBwpUsHrrbXiZ1bJbFZEguxcu11wIff/
         vt5YyJQtU82hyekUEKqJZ8UNk4FwGy5d0yu4Umiq1PxGfKoi/+WSSPuO4l1815CfKfrL
         QgFImUEARQeG/gzlzYcdDt3MxoWXm4umMbiw4i0d+QzSRtq3UsdoMIsKtOPQQHaLK8Ek
         ILSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076523; x=1780681323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YX4oF6pCObKTl0kBgsQiOjoOSc/kNJefAsPyHQO56tQ=;
        b=qOAf7rwFKW6jGF4oWf1GTVFpKa4owTnlFKNzALLlf9Ulg2UV1twxpACDcrKnBUxA6l
         9T0qqBhCfee18wN1PWL37Nh0mzozlBbmAP4HV6tz9jarIlRq3vGVB9UfCwQDJCaaIECR
         0K+cacdUafOnpqSC0QTQfak9Nkh5gpDPS9C/H1BDQr0LEz/Bf/J3tjb0Lo7vu9uJGQnp
         6dGxXCzl0DAY7WGMtKEA3EnJzeXQPLEsSZ6HA8ioSRKkd1n/KY8Y/HvDXVLFLhmRlOq3
         HU1VypZWMaQVPdjg4sWMYO5auss3+ZHxOQEMX673Za+v/EFCKDVcZM80euYGaNq4j6T8
         x6mg==
X-Forwarded-Encrypted: i=1; AFNElJ/rtqFgafb95PaTF70zBHt1o9NjVsWW1mCAxHf+Uex+QoHM5iyqUK8P8gzNhSXu3RJZAxZnyOFMyKViVEqw58DD@vger.kernel.org
X-Gm-Message-State: AOJu0YysATLtjuytVcKQn++sCC2JdFHM0EK8cdtjIgMiQHN2FdS3itdo
	ais/5FJGiwGvW9hQs90QNfpPiBWhH6SgmafolvjIxuFl4SvryJnCnr0PfInv74hgKNZCXKWYbrf
	odiLoj5qAblv98UsRVEYCkII3mftoW13ByLG8EvDy
X-Gm-Gg: Acq92OFcdhTPYE/vw9sN41yjrCx1nOHOEzNaNbam10aEDflqQ6JygElJlzL4f/cPgHE
	xtOL7wppEhBlJfpat4j3pBhrywFLVtbb4EwATcls7ARAlJU/7Nbu2rAlbPpdq4vTkscf4TpciXg
	Vt70PhQPvj8N0/msrKqSywhOF87RZqRhRCkbpJ2kdPaUjV8H5mQPAjUVa9bgCqzNC8nHLjiKHv7
	UaxT55jgwjCpLdwvl2JSPO85XeK0J2kf7fA1mhUU0sZooo3ucpv8yJ6IOrcHBwcS5xTDllzcGvc
	7hciYMlSu5M+iICSxl707dS9zEJkONHhsC2wGm2wTKw2SQtm
X-Received: by 2002:a17:902:ce91:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2bfa9eeb1b6mr146515ad.11.1780076521979; Fri, 29 May 2026
 10:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082451.591783-4-dapeng1.mi@linux.intel.com> <20260529104532.CE9D11F00893@smtp.kernel.org>
In-Reply-To: <20260529104532.CE9D11F00893@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 May 2026 10:41:50 -0700
X-Gm-Features: AVHnY4KId2WIOWc59UNbxLiWYFjUfTHpQJ1A2Zgn0kOfsiHu3-A63PsEB_1ZH3I
Message-ID: <CAP-5=fV0wY_B22Zma06JjWaMSWnChwFwk28c1uMfEGBBWA5-Xg@mail.gmail.com>
Subject: Re: [Patch v8 3/5] perf regs: Support x86 SIMD registers sampling
To: sashiko-reviews@lists.linux.dev
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 3:51=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] Parsing of `--intr-regs` and `--user-regs` with multiple optio=
ns is order-dependent, preventing intended combination of General Purpose (=
GP) and SIMD registers.
> - [Medium] Specifying only SIMD registers (e.g., `--intr-regs=3Dxmm` with=
out GP registers) leaves the general-purpose register mask as 0, causing th=
e kernel to reject the event configuration with `-EINVAL`.
> - [Low] The `sample_simd_regs_enabled` field is omitted from `perf_event_=
attr__fprintf()`.
> --
>
> commit 03a81994cf381ee1d67a41deb452833fc73a023e
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Support x86 SIMD registers sampling
>
> This patch adds support for the newly introduced SIMD register sampling
> format by adding functions to support parsing and sampling x86 SIMD/PRED
> registers.
>
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 1c856a2ecc6ec..cd62af14a4f54 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
>
> [ ... ]
>
> > @@ -1594,6 +1595,16 @@ void evsel__config(struct evsel *evsel, const st=
ruct record_opts *opts,
> >               evsel__set_sample_bit(evsel, REGS_INTR);
> >       }
> >
> > +     if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &=
&
> > +         !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
> > +             attr->sample_simd_regs_enabled =3D !!opts->sample_simd_re=
gs_enabled;
> > +             attr->sample_simd_vec_reg_intr =3D opts->sample_intr_vec_=
regs;
> > +             attr->sample_simd_vec_reg_qwords =3D opts->sample_vec_reg=
_qwords;
> > +             attr->sample_simd_pred_reg_intr =3D opts->sample_intr_pre=
d_regs;
> > +             attr->sample_simd_pred_reg_qwords =3D opts->sample_pred_r=
eg_qwords;
> > +             evsel__set_sample_bit(evsel, REGS_INTR);
> > +     }
>
> [Severity: Medium]
> Will specifying only SIMD registers (e.g., perf record --intr-regs=3Dxmm)
> leave the general-purpose register mask as 0?
>
> If opts->sample_intr_regs is 0, attr->sample_regs_intr remains 0. However=
,
> setting the REGS_INTR bit here causes the kernel validation function
> (perf_reg_validate()) to unconditionally return -EINVAL because the sampl=
e
> type bit is set but the corresponding GP register mask is 0.

It is an interesting corner case, we could extend this test to cover it:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n106

> > diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/par=
se-regs-options.c
> > index 70a1cc90b2c13..26d560a486c85 100644
> > --- a/tools/perf/util/parse-regs-options.c
> > +++ b/tools/perf/util/parse-regs-options.c
>
> [ ... ]
>
> > @@ -53,22 +106,96 @@ name_to_perf_reg_mask(const char *to_match, uint64=
_t mask, int abi)
>
> [ ... ]
>
> >       /*
> > -      * cannot set it twice
> > +      * Non-SIMD registers cannot be set twice.
> > +      * SIMD registers can be set multiple times, but only the registe=
r
> > +      * class with largest length (qwords) is sampled.
> >        */
> >       if (*mode)
> >               return -1;
>
> [Severity: Medium]
> Does the order of options affect whether they are parsed successfully?
>
> If SIMD registers are parsed first (e.g., -I xmm), *mode is left as 0,
> which allows a subsequent GP register option like -I ax to be parsed
> successfully.
>
> However, if GP registers are parsed first (e.g., -I ax), *mode is set to
> a non-zero value, which triggers this failure check when -I xmm is
> evaluated. Does this prevent intended combinations of GP and SIMD registe=
rs
> from working consistently?

It's probably worth adding coverage for this too. In this case having
a C unit test may make most sense.

> > diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/uti=
l/perf_event_attr_fprintf.c
> > index 741c3d657a8b6..c6b8e53e06fd1 100644
> > --- a/tools/perf/util/perf_event_attr_fprintf.c
> > +++ b/tools/perf/util/perf_event_attr_fprintf.c
> > @@ -362,6 +362,12 @@ int perf_event_attr__fprintf(FILE *fp, struct perf=
_event_attr *attr,
> >       PRINT_ATTRf(aux_start_paused, p_unsigned);
> >       PRINT_ATTRf(aux_pause, p_unsigned);
> >       PRINT_ATTRf(aux_resume, p_unsigned);
> > +     PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> > +     PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> > +     PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
> > +     PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
> > +     PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
> > +     PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
> >
> >       return ret;
> >  }
>
> [Severity: Low]
> Does this also need to print the sample_simd_regs_enabled field?
>
> This patch adds several new SIMD-related fields to struct perf_event_attr=
,
> but sample_simd_regs_enabled is missing here. Could this prevent develope=
rs
> from verifying whether the tool correctly enabled SIMD sampling when insp=
ecting
> configurations via debug commands like perf record -vvv?

It looks like this uncovers some technical debt. I don't see config3
or config4 being printed either :-( Could you help to address, if not
remind me :-)

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.59=
1783-1-dapeng1.mi@linux.intel.com?part=3D3
>
