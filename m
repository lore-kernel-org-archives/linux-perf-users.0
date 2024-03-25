Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD413E3E6
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381489; cv=none; b=ipUqP4bqsyy2lpD4Yp5uxf0WQTBQyGpvAE+KJSNiOmxgS7LOi2Td4SjQCw/PxgPaBhqaktiPyEm2CPmXTEsDHhk51HxxwGEyLnKD0s2O6zODVlXN0ieZMiq24dWHjGHOZYiW4vz7aw9uigkJto1w3EDGYVy7Rk4q+laLkvmzOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381489; c=relaxed/simple;
	bh=hI0zAgAoFcTFey6QwDB/oJAgO4DjsZH4qGirAUzPb3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTss9vlB7NwDXNNzgxo16zwwX++5m3IFVgSU6ztWoS0eZzI+2PFe9ZiAxl0PQueYe5rqV8SIVo0yDpcDM1PKdYX5GvCejFMknNYk1oNdajNnugILNHvxMBsO2NNYifGDGISw8eqsLdff0vo88dGE7EinAS2PoIXCekjQoGv8FkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0XBLpjG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0XBLpjG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430d3fcc511so453831cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Mar 2024 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711381487; x=1711986287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHwgONi54zeAS9H3FwlrZb+Tu7LJRtkfNEdM23AQhlo=;
        b=X0XBLpjGxPy9ocwtsAugWD6qDqaFRTTOS3WqJIR1kyQA0PWtA7FrLx1Q/OSMtDX5Ne
         gzl2hk0GtBMRMXA0FBwoq3iSuyo/twnnTWSqp+zGMIAhGHnkuhGPOYwyE8hNQtKn0dg/
         JmG8JSA7IUO4tzUGe9WCtEiPyxgzk7Keoj/OBNiUsWH/bALzcUMhvEG2REnkIiNqyBkY
         aKQ4e1aZZtSkctYBzr18vCdyZ+jc6rO5p1vPUPxmddRIRcZDmzdc4+jX+WnN1ezRWegM
         oQIYoqLP0LTOhfoTfF/XrXSC1WRsYNhG7UyecfGc9XQ8gngsw3Hx77ekn+ZMu0TH0n2E
         mA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711381487; x=1711986287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHwgONi54zeAS9H3FwlrZb+Tu7LJRtkfNEdM23AQhlo=;
        b=SjP4XQVAHwu8KWLgv5nglLLNkEUiCs4Pqm71EcPCiwUlDb7jWghx/lCDtpNhy8BOxM
         5CR4CSPIEqdzssd7RgHc6HCMDd44UhhGmo54SbAhNMFcaJh2HwFBAHJNesyhsYykCPnJ
         05cXMU1MJunAIWWiXb8rA+DOS+5Wd6pyZdBtY7+gor/pNUjUg3LnlPmzHokDFO46xjWA
         oPp7J4zu5WmWqWBSfO92Qy4aJJOKN4gKJDi33i/s2DybBDgRt78D3DwOsHiRHdmYw6Th
         HkiW1RNSM3SyVoIUHHFrIpXSlkc29nu3YrhGzpRWcx8i2p7xU/Qd2UptZxHR4IdTKev8
         lvWw==
X-Forwarded-Encrypted: i=1; AJvYcCX51ddeWa/XQ31uSzxZOgrLfSXhI4uIhqj3/1iKt7n/h9gzBYBfO7FrE453VhTufXef2IEBbSzgHKhMXXGW1n22tqHbtX2BSkWOOZXD0hriaQ==
X-Gm-Message-State: AOJu0YwuHK0JZvODTQOdCCAdtk3oz29yngI6OtLCGJplTwhHE7pdfFvq
	TMktcEt4joREFWCY4jXY9hZzDZF0CEqlkt4qjAsuEnV8jWyOJEf9QhzFtNX1mcl7QhfqlWaMb5y
	JjOUdx905Hwajq4j6I7OIDXekzt3kyMGZNT6M
X-Google-Smtp-Source: AGHT+IFz3J/qBlrAs+LJHUtQV8DyHLZsbHms50+vYkNV8y6PXAojd9KIKTwqrW/hBWtbDTUNcRR11EALoYMqvnBj6tI=
X-Received: by 2002:a05:622a:5590:b0:431:3698:81c5 with SMTP id
 fk16-20020a05622a559000b00431369881c5mr672951qtb.18.1711381486399; Mon, 25
 Mar 2024 08:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320162619.1272015-1-irogers@google.com>
In-Reply-To: <20240320162619.1272015-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 08:44:31 -0700
Message-ID: <CAP-5=fU0XQ_F2Bax0fzPMtP9BQv3XaNuiGWKQMRQ7g54yzM8xQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: Fix memory sanitizer use-of-uninitialized-value
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:26=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Running the test "Miscellaneous Intel PT testing" with a build with
> -fsanitize=3Dmemory and -fsanitize-memory-track-origins I saw:
>
> ```
> =3D=3D1257749=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c=
:1527:17
>     #1 0x5581c00c5cf6 in intel_pt_run_decoder tools/perf/util/intel-pt.c:=
2961:3
>     #2 0x5581c00968f8 in intel_pt_process_timeless_queues tools/perf/util=
/intel-pt.c:3074:4
>     #3 0x5581c007cf49 in intel_pt_process_event tools/perf/util/intel-pt.=
c:3482:10
>     #4 0x5581bffa269a in auxtrace__process_event tools/perf/util/auxtrace=
.c:2830:9
>     #5 0x5581bfb826c0 in perf_session__deliver_event tools/perf/util/sess=
ion.c:1649:8
>     #6 0x5581bfba1d7f in perf_session__process_event tools/perf/util/sess=
ion.c:1891:9
>     #7 0x5581bfba82e4 in process_simple tools/perf/util/session.c:2452:9
>     #8 0x5581bfbabcc3 in reader__read_event tools/perf/util/session.c:238=
1:14
>     #9 0x5581bfbad942 in reader__process_events tools/perf/util/session.c=
:2430:8
>     #10 0x5581bfb78256 in __perf_session__process_events tools/perf/util/=
session.c:2477:8
>     #11 0x5581bfb702c4 in perf_session__process_events tools/perf/util/se=
ssion.c:2643:9
>     #12 0x5581bf2da266 in __cmd_script tools/perf/builtin-script.c:2855:8
>     #13 0x5581bf2bfcdd in cmd_script tools/perf/builtin-script.c:4402:8
>     #14 0x5581bf67004b in run_builtin tools/perf/perf.c:350:11
>     #15 0x5581bf66b8ea in handle_internal_command tools/perf/perf.c:403:8
>     #16 0x5581bf66f527 in run_argv tools/perf/perf.c:447:2
>     #17 0x5581bf669d2d in main tools/perf/perf.c:561:3
>
>   Uninitialized value was stored to memory at
>     #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-deco=
der/intel-pt-decoder.c:1256:25
>     #1 0x5581c001a932 in intel_pt_walk_fup tools/perf/util/intel-pt-decod=
er/intel-pt-decoder.c:1428:9
>     #2 0x5581c000f76c in intel_pt_walk_trace tools/perf/util/intel-pt-dec=
oder/intel-pt-decoder.c:3299:10
>     #3 0x5581c000899b in intel_pt_decode tools/perf/util/intel-pt-decoder=
/intel-pt-decoder.c:3988:10
>     #4 0x5581c00c5180 in intel_pt_run_decoder tools/perf/util/intel-pt.c:=
2941:11
>     #5 0x5581c00968f8 in intel_pt_process_timeless_queues tools/perf/util=
/intel-pt.c:3074:4
>     #6 0x5581c007cf49 in intel_pt_process_event tools/perf/util/intel-pt.=
c:3482:10
>     #7 0x5581bffa269a in auxtrace__process_event tools/perf/util/auxtrace=
.c:2830:9
>     #8 0x5581bfb826c0 in perf_session__deliver_event tools/perf/util/sess=
ion.c:1649:8
>     #9 0x5581bfba1d7f in perf_session__process_event tools/perf/util/sess=
ion.c:1891:9
>     #10 0x5581bfba82e4 in process_simple tools/perf/util/session.c:2452:9
>     #11 0x5581bfbabcc3 in reader__read_event tools/perf/util/session.c:23=
81:14
>     #12 0x5581bfbad942 in reader__process_events tools/perf/util/session.=
c:2430:8
>     #13 0x5581bfb78256 in __perf_session__process_events tools/perf/util/=
session.c:2477:8
>     #14 0x5581bfb702c4 in perf_session__process_events tools/perf/util/se=
ssion.c:2643:9
>     #15 0x5581bf2da266 in __cmd_script tools/perf/builtin-script.c:2855:8
>     #16 0x5581bf2bfcdd in cmd_script tools/perf/builtin-script.c:4402:8
>     #17 0x5581bf67004b in run_builtin tools/perf/perf.c:350:11
>     #18 0x5581bf66b8ea in handle_internal_command tools/perf/perf.c:403:8
>     #19 0x5581bf66f527 in run_argv tools/perf/perf.c:447:2
> ```
>
> Adding a curly brace initializer for the intel_pt_insn in
> intel_pt_walk_fup rectifies this, however, there may be other issues
> lurking behind this so initialize all similar instances.
>
> Fixes: f4aa081949e7 ("perf tools: Add Intel PT decoder")
> Signed-off-by: Ian Rogers <irogers@google.com>

Adrian, could you take a look at this for the sake of tests passing with ms=
an.

Thanks,
Ian

> ---
>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/=
perf/util/intel-pt-decoder/intel-pt-decoder.c
> index b450178e3420..b4a95af2e4cc 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -1115,7 +1115,7 @@ static void intel_pt_sample_insn(struct intel_pt_de=
coder *decoder)
>   */
>  static void intel_pt_sample_fup_insn(struct intel_pt_decoder *decoder)
>  {
> -       struct intel_pt_insn intel_pt_insn;
> +       struct intel_pt_insn intel_pt_insn =3D {};
>         uint64_t max_insn_cnt, insn_cnt =3D 0;
>         int err;
>
> @@ -1418,7 +1418,7 @@ static inline bool intel_pt_fup_with_nlip(struct in=
tel_pt_decoder *decoder,
>
>  static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
>  {
> -       struct intel_pt_insn intel_pt_insn;
> +       struct intel_pt_insn intel_pt_insn =3D {};
>         uint64_t ip;
>         int err;
>
> @@ -1461,7 +1461,7 @@ static int intel_pt_walk_fup(struct intel_pt_decode=
r *decoder)
>
>  static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
>  {
> -       struct intel_pt_insn intel_pt_insn;
> +       struct intel_pt_insn intel_pt_insn =3D {};
>         int err;
>
>         err =3D intel_pt_walk_insn(decoder, &intel_pt_insn, 0);
> @@ -1626,7 +1626,7 @@ static int intel_pt_emulated_ptwrite(struct intel_p=
t_decoder *decoder)
>
>  static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
>  {
> -       struct intel_pt_insn intel_pt_insn;
> +       struct intel_pt_insn intel_pt_insn =3D {};
>         int err;
>
>         while (1) {
> --
> 2.44.0.291.gc1ea87d7ee-goog
>
