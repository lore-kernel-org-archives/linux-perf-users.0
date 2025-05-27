Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC324DD17
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339997; cv=none; b=ZZaagE7FpcnD6aw4pE3YsISLv+Zt55g/jRhyaWYkM3e9pBkRF4Rf8TOhOyps0F795dEr/pxyrRI93WRYPszKAsbOMvjZkA6KZ1I9O9VwN3ike8cZEfPELiINV6uIptHPYwG4MX1bNu3zAMBSM8qyxwc512vSGGAUNJknie/F210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339997; c=relaxed/simple;
	bh=MzOvGX8O+4utQ4eU3Iajmah5bipRwCmAxAIkr/YrneE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHim2iW97+PdgnP8c6APTxs6/iWfjZKqsOX4V25cNAy1ja4K8iAFCM5PmMT6CQLciYvnSCfLeYTDe9uXTReMBdKNVZS8TtRDUbOiUnHKjYlICSGUTtYHHy31Mo7W//wqrnbdyVqPfVgp5TbMzMyqNwcJpjyJ0d47wpkA1rwboaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VnQLdZeL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VnQLdZeL"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a37a243388so3222959f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748339994; x=1748944794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4DLlx+hKQhw+ENgyFAqY2PL5hW4DHMG/cxZu2R2Xik=;
        b=VnQLdZeL7eOji61GOi7HPGKca7NmU8WKZcqkehppqcA4IRKmDSOKCJrlYt4HlmKPpa
         eU6KKNINEfg8PZk3Pwek9poAcCqF/Tv5Y4by5Yc6Apt0pdGRpVlB/T+CcDEV60/pGIHu
         MD5er/23EVDP2Bsyzxdj7696KH8cZjSXkY23qXG7Q7/ekSiI8NR5tZb85VCPQC04iWMS
         PrsdakJ7e0TJbq451Nple24CBk5DGAZpZW0pV0BWfN2SZi6wBNb8MfOlIXHXaaSjM+Ky
         Dd4wTBqQQ79dVBtPHsIj2JaAzYTbC94IWzgcAp1PZDmkyI4cbQEUh9+2m8p6VnXPfS2C
         bb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748339994; x=1748944794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4DLlx+hKQhw+ENgyFAqY2PL5hW4DHMG/cxZu2R2Xik=;
        b=dSXDNDBdbCJHlwoIBJr2IZa9hg/kQsVV5ewNJVJgoHdd+oC98/8L9+ivkrR+F1i6Dt
         YEEk5vKyVG9ycWjbalHPtnlHcZQkn0Z3XOmpd1PnuqJPMF6OVAMev4nkJIk069k9vtKd
         mcNGm6pM3/Bl2L1MC4g6Z7X37WtO8DXOJVBBo5cGETL45w3cT4I70bkrcRc+z5wtbVhE
         CbCXUb9vss/6YKmXxSgIjnghvmWRaanx9kk7ky+lfXUvcH7cgkcQtIDdnmsilpkf9aAp
         6vRuMhfqfECnnTGRXtnEEGgcEfzYvzfRVADOjBxPNHvvwNBLEfaSJvdZJjTUcPFmjPTX
         KVOQ==
X-Gm-Message-State: AOJu0YyNw5sKvF/gcy4Px6eLcaV5X3f1gh1iRcExoHNBVV+/tyDBJ9TV
	/dWKpvBDnT8dAbrbDHfRg12XYEMnPV2KS6MIXmp2k1J4ZzppkyU6lQuasNdim4pXD/ulJAhZhco
	gxxBT9mg9GXVfbrP+jBjFB4lP1N8K7PlTd0wmFcs21w==
X-Gm-Gg: ASbGnctiD/U/fBm3JTk2vLnad/yxq3PYsTHjlHzI+Fx9Rh61TsXe7wsQnyVV8X2dySq
	N3EHt3C4uiHsX7A/H2IC/SwFiKHBm8cBG+can5X7lkyzrU19FyY79idxCmETa+RqBZdiivZxLJ0
	BPpfGS6EEH7HkDStyr4+xNCHmDqE5NVvg=
X-Google-Smtp-Source: AGHT+IEW4jiGzBYUUJeQ+hZ9q3VAC3c3XCEXdCJkYQj3sC6I500v3SraZXfwDAQYqmh+I1E3eL9qo1sRnEJZg8HQc9I=
X-Received: by 2002:a05:6000:240d:b0:3a4:d6ed:8e07 with SMTP id
 ffacd0b85a97d-3a4d6eda68cmr5556606f8f.32.1748339993821; Tue, 27 May 2025
 02:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com> <20250523-b4-ctr_upstream_v3-v3-1-ad355304ba1c@rivosinc.com>
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-1-ad355304ba1c@rivosinc.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Tue, 27 May 2025 10:59:41 +0100
X-Gm-Features: AX0GCFvLUhtMwBzFmk1b4gn3Tur4pK0okxD3qyqun7XWisCr-irbPglToM7Uhec
Message-ID: <CAECbVCvPCsHVvm5QKQrw+DDLsZGaHMgCHyJ=cp_gFcAyiFA4ow@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] perf: Increase the maximum number of branches
 remove_loops() can process.
To: ak@linux.intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Beeman Strong <beeman@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Andi Kleen as this was originally written by him.

-Rajnesh

On Fri, May 23, 2025 at 12:26=E2=80=AFAM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
>
> RISCV CTR extension supports a maximum depth of 256 last branch records.
> Currently remove_loops() can only process 127 entries at max. This leads
> to samples with more than 127 entries being skipped. This change simply
> updates the remove_loops() logic to be able to process 256 entries.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  tools/perf/util/machine.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2d51badfbf2e2d1588fa4fdd42ef6c8fea35bf0e..5414528b9d336790decfb42a4=
f6a4da6c6b68b07 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2176,25 +2176,32 @@ static void save_iterations(struct iterations *it=
er,
>                 iter->cycles +=3D be[i].flags.cycles;
>  }
>
> -#define CHASHSZ 127
> -#define CHASHBITS 7
> -#define NO_ENTRY 0xff
> +#define CHASHBITS 8
> +#define NO_ENTRY 0xffU
>
> -#define PERF_MAX_BRANCH_DEPTH 127
> +#define PERF_MAX_BRANCH_DEPTH 256
>
>  /* Remove loops. */
> +/* Note: Last entry (i=3D=3Dff) will never be checked against NO_ENTRY
> + * so it's safe to have an unsigned char array to process 256 entries
> + * without causing clash between last entry and NO_ENTRY value.
> + */
>  static int remove_loops(struct branch_entry *l, int nr,
>                         struct iterations *iter)
>  {
>         int i, j, off;
> -       unsigned char chash[CHASHSZ];
> +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
>
>         memset(chash, NO_ENTRY, sizeof(chash));
>
> -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
>
>         for (i =3D 0; i < nr; i++) {
> -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ;
> +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is not
> +                * needed as hash_64 will anyway limit the hash
> +                * to CHASHBITS
> +                */
> +               int h =3D hash_64(l[i].from, CHASHBITS);
>
>                 /* no collision handling for now */
>                 if (chash[h] =3D=3D NO_ENTRY) {
>
> --
> 2.43.0
>
