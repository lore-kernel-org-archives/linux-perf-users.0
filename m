Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795550039;
	b=qt/Hcep1PdiCbyGe88vwe8NixiVuEvhyK9q2GUAbwDWS45mESGAZf1Hh+yQnviIBPvSs
	 PKffdHRqZd8dzjwu25s76Y65vgj8AdIto47EBa/Y5Xwc9RdOUQ91Zvc10E6JYSU1oGA+S
	 ANWC7xISzP1JWKrIDokMcwxGeHkSxk1jqyaC81nnYoOyM4hxhXKKDszeK68A3Kvo11uzL
	 2Trm3iYE/e7+ArisNvMQheK0fVMLZdVytsHBA98Bl85HygSjoP4fS7cEVJ10eR7xTJ4jd
	 HwJvw7W+IjLhz3lcrgtwrRmBdXdfJEw+PnM2wYzICBo7XB6teRYEbGYBJypLbERHqgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=N6ZDf32T5nk+m9wvqXhF4I4mA8DVMOcsP/R42tSMkxg=;
	b=QOazTLm8OlSsaM2KSEDI6UbYQgiHg7iPnxsJA5HfqXafZ/zfQdxS72HT5QX/LdHEe1h4
	 F67pVoJlwOtCWsu2tcG6Re5uLBvpz51wi6Zl1KvSCkKDuCfp0Ps9Tb9QlCy5FQaBki2Fa
	 N3vrXTX+1JvnyvYy7vR1aeF4Gze2X9yKURKpGPP7u+Hc4assneXJH033WJ11CfWDw+MEc
	 5IY65Nip2r3X10yV7bE8TLOSFvCHCwTyEITvjzdJUGzxmswBzU3axiLnKj021hPy4Fm/8
	 CgLsMg8K4vwZ4nwIEiFesk6NlYvxl61aabpyu8LywIBycoC0ofH++7ayCfSf1Tzm2Hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m7dKlY44;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72402606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72402606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m7dKlY44
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-54492d8a988so1035131cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 11:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795550037; cv=none;
        d=google.com; s=arc-20260327;
        b=g9BqXOudnOw8dvD+r/niVCvrAui78E0gahT9eGowTRIzO5y+oLFRCsVqJs7asIIoVr
         FkyLJetQWATnJ2rq31eTXKYNOnJ0tm1FZi//YhI5GFyAvbew7rm/QGGQZ13QtyDonlyR
         qzqDjZfR11EzxYlVrc3TVVo3jLvd4M3uj6OGf9dsMofI9W/DyRdGRz7tWhrXHUqgukzR
         X4uENDENLVVbtn3OxM4yPs9xYnBj7DHuvh1Nwd8N1nT6+oJbR67m0u9dkjAaekDhye3E
         Lzi7uqfEIMM3c2etQH7Ay6kctTnI5p7tWEcgGRaxnwZ/iTBH0TkIjmPWHLaMLRjb26Pg
         3SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6ZDf32T5nk+m9wvqXhF4I4mA8DVMOcsP/R42tSMkxg=;
        fh=WZhEATVeDcOH4twRv18RdlRbezB5Ad9GXyc5ka8MMrQ=;
        b=IkpNLJC76k9Q+WO6HCLgCCRd8Jk1/VS7scfVAOlP0L1kzznDVRk0+cSxqwFHJYj14n
         67G1faVrmYnE2qkBv1hcWw1pjYFHv7sh7fy7Jd1ReRFYLhYrjsglVou9nPhXdZWEuz02
         t/p9VfpIemuCXh2RHydW2ZDfiIh2KALb8kwsyEu9csQtKpd+0f0QrmG26JJf8wmOqdfI
         /JCU2DOyRcd7+C677vaHSugEZjgk51iKyNGAMwbaLwm3skgtsdmTuTsnSuohwYvk1u0f
         xQSEik86t95Pta9kFoizhNqULqRETCK1yDE0FMhBGJvJ6o04DVfYbOSLrt+oxt2aLN7B
         UiLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795550037; x=1796154837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N6ZDf32T5nk+m9wvqXhF4I4mA8DVMOcsP/R42tSMkxg=;
        b=m7dKlY44pC/+c16oejDGXzDJlmCY6pTFCcJ4svC7Nzdhr5/1XP3p8+YapylGbS5gdR
         kUWih5IOLkt8HwVIK8DxT+wpC29qsTeiWtXzocUQv7VuKT1PFYo13YwaMZyWi0Z81TfW
         7CABF2NA2iYMErTLz4AGuVEhvw8i4hPkaCrNLdiLvnNe6GXfwKrug5JYrsZoCTPKaxy8
         lXQgrS2a9IIsi0d//UkLYkAcYylvClK8TO8BKyLg+YlGEXvaoXWYQsCyp7YGAfi9A1iM
         l9ODMId9I0aVNBk/1L5cHJ9LLQbLiN9gUYPkuYJa2+xj1AUFxuVSaLpCoT1HZLsdmQC6
         MBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550037; x=1796154837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6ZDf32T5nk+m9wvqXhF4I4mA8DVMOcsP/R42tSMkxg=;
        b=tqAZi7lyVLmOUKplPguxdw/GAV+5e17opvlvoJ3eYjZDmj1nPnoqiX9I0gSoY6oyU7
         1u7egKrEnAZiPZ67req0b5tr3Efi9OumSaQFANYZJan1HspvKQxOUX2+1GMN9rpxn32s
         O07kdjuxUk1syxIC2O6Qe5lYg9NtrKaSPzjiy4TbDgoBVyLDnAnnxBn82aRbzv26lYGi
         mH9KdbfcY5yAMTxEsbI/dwTLMgQyJWgkDPxQP+U6ZV208gmDrYb6V5n4SsV3wYygeqL7
         ggAi1OSSUDM991n1wVFcdbzdNSr9AhgAwjjb0PcNaMRGaZyCbExomrPGxefCVP42rwxh
         +RDw==
X-Forwarded-Encrypted: i=1; AL+hErHO35Ra+2tUj7hAlNLGp6DcjZwkf+gIITXFieMpF5U/+/0SmRue+AH8hzDJies5bzdkZtzi67XaMfviOIHczUeU@vger.kernel.org
X-Gm-Message-State: APuU4Z99i+OD9Ph7dIsiVCTaLkYnXZqgmTayHiabVUHm1+IFelL7gGMR
	pnWYeorDe5tIH0zovB++pi/WsNqK8fUCxl7G9FBrGkhsCTIsoIdtDXuULHQTKinlsMhmpzIKNZz
	KUWY7MkoSURD5Iyq0ypTB/JKMUovuYuzLCb7FCWBu
X-Gm-Gg: AZFdTZfE5dBZSyquWsMgumh2t0QEnhaWxnpLxVyPXneWw4w4D5LXfVsKVyx4c2p11xa
	JarcCoBKK0NLVSgwD44lern+xGz3l3Y2wJit68mW2pRHcor64AI6OJ0bcOK5fp623LNKdhQRzHA
	6AoZvjkRex1hl3eYmjqsDecEa5gHgglIEdJS+4O7SB4dRdmsEdRnksKUoPRMqagNULGR3O7oplt
	q+mSm7o4z58dkuOv7znX+60tooc5RPl6Z/tBAAYHUAdN9QOlN2/oraN+eed9uqLIy215QC/NIFz
	Cqdj/pJRzGV1UtjxwFge7LmiBzA4mGf3p2Fc8JSsMjNlTATwHPIVEKebGwIMFEnXiZyG0GQERa2
	pV8rBNHIyKPfe4CZ0WooiFFyLiao6Dc50RUlSfXMsTep5lvR6QT0wpQcC798wLmybmYw=
X-Received: by 2002:a05:622a:544d:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-55d89061678mr68501161cf.13.1795550036714; Tue, 24 Nov 2026
 11:53:56 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com> <20261116074414.3174737-4-irogers@google.com>
 <awTf5TZhEyoYCgjH@google.com>
In-Reply-To: <awTf5TZhEyoYCgjH@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Nov 2026 11:53:43 -0800
X-Gm-Features: Aa3M54r_R7N5tykK528Kk0UaPPpJN4-KPZlHhxP0nzf_Gn4oainZgaRRyC6TiE8
Message-ID: <CAP-5=fUXDW6BGEr1nfJpzVjSav_E3WM6CFmTqXJ2PnUWpK3xDw@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to UAPI
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 4:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Nov 15, 2026 at 11:43:58PM -0800, Ian Rogers wrote:
> > Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> > PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> >
> > For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> > PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> > set), encode a deduplicated table of variable-length build IDs
> > (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> > u8 data[size]; } entries padded to 8-byte alignment) and an array of
> > 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> > 0x00 for unresolved user addresses and 0xff for kernel/context entries)=
.
> > In common cases where multiple callchain frames belong to the same
> > binary, each unique build ID is encoded only once.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_=
event.h
> > index deb7c42d109b..775420ed9aee 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -165,8 +165,10 @@ enum perf_event_sample_format {
> >       PERF_SAMPLE_DATA_PAGE_SIZE              =3D 1U << 22,
> >       PERF_SAMPLE_CODE_PAGE_SIZE              =3D 1U << 23,
> >       PERF_SAMPLE_WEIGHT_STRUCT               =3D 1U << 24,
> > +     PERF_SAMPLE_BUILD_ID_OFFSET             =3D 1U << 25,
> > +     PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET   =3D 1U << 26,
> >
> > -     PERF_SAMPLE_MAX =3D 1U << 25,             /* non-ABI */
> > +     PERF_SAMPLE_MAX =3D 1U << 27,             /* non-ABI */
> >  };
> >
> >  #define PERF_SAMPLE_WEIGHT_TYPE      (PERF_SAMPLE_WEIGHT | PERF_SAMPLE=
_WEIGHT_STRUCT)
> > @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
> >   *
> >   *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of preci=
se events
> >   *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> > - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> > + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
> > + *                                         PERF_RECORD_CALLCHAIN_DEFER=
RED events
> >   *
> >   *
> >   * PERF_RECORD_MISC_EXACT_IP:
> > @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
> >   *   Indicates that thread was preempted in TASK_RUNNING state.
> >   *
> >   * PERF_RECORD_MISC_MMAP_BUILD_ID:
> > - *   Indicates that mmap2 event carries build ID data.
> > + *   Indicates that mmap2 or deferred callchain event carries build ID=
 data.
> >   */
> >  #define PERF_RECORD_MISC_EXACT_IP            (1 << 14)
> >  #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT  (1 << 14)
> > @@ -1095,6 +1098,38 @@ enum perf_event_type {
> >        *      { u64                   code_page_size;} && PERF_SAMPLE_C=
ODE_PAGE_SIZE
> >        *      { u64                   size;
> >        *        char                  data[size]; } && PERF_SAMPLE_AUX
>
> I think AUX should be the last entry so that it can take the rest of
> sample area after processing all other sample data.

Good catch, agreed! In perf_prepare_sample(), PERF_SAMPLE_AUX clamps
its payload against U16_MAX - header_size, so placing new fields
before PERF_SAMPLE_AUX ensures AUX only takes the remaining sample
space.

One minor caveat with inserting new fields before PERF_SAMPLE_AUX is
older perf.data parsers that warn on unknown attr.sample_type bits
rather than rejecting the file (such as legacy tools/perf's
perf_attr_check() / __evsel__parse_sample()): when PERF_SAMPLE_AUX is
not set, the wire layout is unchanged and trailing build-ID bytes are
simply ignored via header.size, whereas if both PERF_SAMPLE_AUX and
PERF_SAMPLE_*BUILD_ID_OFFSET are enabled together an un-updated parser
expecting AUX right after CODE_PAGE_SIZE will misread the build-ID
bytes as aux_sample.size (failing OVERFLOW_CHECK, or seeing size =3D=3D 0
when bid.size =3D=3D 0). That matches the precedent set by
PERF_SAMPLE_CGROUP, PERF_SAMPLE_DATA_PAGE_SIZE, and
PERF_SAMPLE_CODE_PAGE_SIZE, which were all likewise inserted prior to
PERF_SAMPLE_AUX.

In v4 I've moved PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET before PERF_SAMPLE_AUX in the
UAPI layout comment, kernel
perf_prepare_sample()/perf_output_sample(), and perf tools (sample
parsing, synthesis, and perf inject --sample-buildids).

Thanks,
Ian


> Thanks,
> Namhyung
>
>
> > +      *      { union {
> > +      *              struct {
> > +      *                      struct perf_build_id    bid;
> > +      *                      u64                     offset;
> > +      *              };
> > +      *              struct {
> > +      *                      u64                     zero;
> > +      *                      u64                     context;
> > +      *                      u64                     cookie;
> > +      *                      u64                     ip;
> > +      *              }; && attr.defer_callchain
> > +      *        }; } && PERF_SAMPLE_BUILD_ID_OFFSET
> > +      *      { u32                   nr_build_ids;
> > +      *        u32                   nr_offsets;
> > +      *        struct {
> > +      *              u8              size;
> > +      *              u8              data[size];
> > +      *        }[nr_build_ids];
> > +      *        u8                    pad[];
> > +      *        u64                   offsets[nr_offsets];
> > +      *        #
> > +      *        # Entries in offsets[] include PERF_CONTEXT_* markers (=
which
> > +      *        # have top 8 bits 0xff). Kernel/hypervisor entries (aft=
er
> > +      *        # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GU=
EST,
> > +      *        # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word fol=
lowing
> > +      *        # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. Use=
r
> > +      *        # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUES=
T_USER,
> > +      *        # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 b=
its to
> > +      *        # encode a 1-based index (1..254) into the build_ids ta=
ble and
> > +      *        # the lower 56 bits for the DSO file offset, or 0x00 fo=
r an
> > +      *        # unresolved user virtual address.
> > +      *      } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
> >        * };
> >        */
> >       PERF_RECORD_SAMPLE                      =3D 9,
> > @@ -1306,8 +1341,22 @@ enum perf_event_type {
> >        * struct {
> >        *      struct perf_event_header        header;
> >        *      u64                             cookie;
> > -      *      u64                             nr;
> > -      *      u64                             ips[nr];
> > +      *      union {
> > +      *              struct {
> > +      *                      u64             nr;
> > +      *                      u64             ips[nr];
> > +      *              };
> > +      *              struct {
> > +      *                      u32             nr_build_ids;
> > +      *                      u32             nr_offsets;
> > +      *                      struct {
> > +      *                              u8      size;
> > +      *                              u8      data[size];
> > +      *                      }[nr_build_ids];
> > +      *                      u8              pad[];
> > +      *                      u64             offsets[nr_offsets];
> > +      *              }; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_=
ID)
> > +      *      };
> >        *      struct sample_id                sample_id;
> >        * };
> >        */
> > --
> > 2.56.1.703.gf848ed807c-goog
> >
