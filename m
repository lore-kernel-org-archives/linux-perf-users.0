Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF293B637E
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002105; cv=pass; b=gydPLCR1t+g1xKsaBLS7Nf98e9s4tBBPvk4Qc2SHIU/8XiuEsYeHUokAUNJP1/Y+lMJmdqr7u9ugiklLqO7GIiHQjdEpxUnn+x1EQBPUfa0zzva+ojiCpuan2TicJ+UGLzRLxgJdBP4lDPUhjTp1IqoP/DmxfWv+aqpw07H/Cz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002105; c=relaxed/simple;
	bh=vhmxFfFO0jKOSDwa0ULehSJCfNMpcJXf+tjhGNSZN00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8dVSvtCK9Gakn4AxRFEEWGWOgEeuhlWPn/v6sqqIS2c2CfIzqlVKF0zcT9wLVIPmnFJAKb2P3GkAPZVt3K3SPixyqwsDVBApzyWvl5y6bTw2DfSpCNdhQac5F0NjgthWqxOXShyMTFRyeHnx38AiDE7wwhFfUhWsJcbK5E4TTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCUwyZNG; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCUwyZNG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c15a5b265so88461cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002103; cv=none;
        d=google.com; s=arc-20260327;
        b=j3boHj1k9zQ3qj3fM8h+aTHrury8MXB14SQICI4n9z+FAGLEX3n6Vkm35yBuUb17Ni
         0+tFFN+CgYIwB4DUwbN3WkPkVpYQOASmG5BMJXzfzYc8gkN3zkznZ3pmmTMTX6G1rjNh
         hNJVeb+E8EbahMK/lWo6JdkodjHJYBdkaBHjXOwNCnuw5Ryh4ZF1jy9pVfqU6d02rwby
         tB2DM8EpQw2cSQwh2iyK0AV59nhDOP0wXIpr2lpSubZN9qMBF+okKRMm5AlhU+lBc9jk
         FsoF7BK/9M2qxxpK3kKAQjVW974QO+41wv3RfbcbjoKgykmTi1YKhIN3KB3+xYpVKxpK
         l53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XG07HmJ1K/tlTNDntZU/hI9F20RVrlxoXlFhou2oAr0=;
        fh=iGc+aRTTM9sbQfMOxoFnQZS9JZK2UoHT14XTkWd+39w=;
        b=BkR11YbPqyWwLw8CVpwQx66qnaRNXYDT0hlhDC6+5JpzI2lzohwdvqx4A1ODwkO0Sp
         dQ5atz1aboAeRPAEN10MQ+nPbYXqTZ1vDIYNrnq5vh9S/jorkt4A3DFFxGWEIWU7C8u5
         6USqM3AfOpwJmMcrZPviVs/gyODhRMF/8ahOPTzfUW5kaBkL1j7r+c+1UYU9jA4exlHn
         4FlPU/d2cQTVzgdb9ECpW1cm/ddUClcQ2hJtNoYmuWeErVnmCEznXp1ODNyywCluw2nh
         TXc+4MPKm/+B/6J1G4cRIXT40x5Z59tpuVwu6hisWFXjm6S7J2M7OpRCjhst7vd7v0WB
         Ydgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787002103; x=1787606903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XG07HmJ1K/tlTNDntZU/hI9F20RVrlxoXlFhou2oAr0=;
        b=mCUwyZNG8Vh0eAuM1DvqERuHrB1Mt3p+2Vof3dvc7I8NEX9WaQ2P3XSLCgvvHx+CyV
         jqzPQYfLyP/TSVkNUKRzgjhXbKKpf1rTJ2N69+RefNMN9Yi3qyCDNR6V3sJakVgCV0xT
         urpYlVeA6YJ1ZQn/3AvuhCWhNr2MN+xpkekPvi+FFMBUV2UgF/aR9aYz9uWrBUCd2woV
         9zRrljaPjh1N3aZT9cHLKG4Cu1Kv+l+kHPK7g03i1QNcba2euAgJqaSxp+IqQwuNhWNH
         M3dMz9UDlEaMI5UnnLezgISn1xfPrRVDqwSHLk2BURMOOqpasulvev4gap+0YhfC1XsD
         qrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002103; x=1787606903;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XG07HmJ1K/tlTNDntZU/hI9F20RVrlxoXlFhou2oAr0=;
        b=SmCt6UbHHocavSiwvna8J7gk+Ci3bIkQLQ7hK+e4uZu7RnzMHqesGXxFlZAUVyIdJO
         pToLml4coNefesLQGBye5LJlwC9scaT8ihwuWCAGzJnHpVq4/1f+Dpql4PFUKNXQ/13n
         tyszXkPL+Ik4lfkLukwrmHR5AR0O2OHIQ5QhB1F/rgsYmD0ggfIn6wq+jJKqaMXIBQHj
         MDvNbkiwXCFAPlu4trrjlrF0GqDRYqHiAj2R5GqQPVocyPt41cBxfidT9o9zIQ7Z1kfa
         OYjD8ND6jy/aHNG7fB019Yk+538z5i+D1MDwD0uCIe8yELAzt+NhEtgn4FIBHZQVZWED
         nQTA==
X-Forwarded-Encrypted: i=1; AHgh+RrKHnOg+W8Ke93V22ZU4mHYJ0xbbxc8HwCLoJTn0uwMM0BsCDLom0pRRlozITe54Lg0fHOvCzW8sYwSGB6tZ/Z8@vger.kernel.org
X-Gm-Message-State: AOJu0YziWVY4hsTHz5fWfhBzvtYCSlLKLrDSOSZAtHWvJBBMTgtDdrzU
	VRQPYeSthZZOdTx3jNFQTPTVBGLVR++4sFLV4JWMa1iW7vANBpGbtCE4CXbxzlA2fCadkuQr0dE
	E98asTAa17aJd3ajT0D9ijBrkEuKiJPEBvcmVs05t
X-Gm-Gg: AR+sD11bHy2+eRoX6ZwaTGqK/gIIt3vKJ0xegjsVWYLhJ5Wgfefy7/5d+JLv5En2G+7
	tO03kPDYNlIAyqwUmsniYM9EaKIfP5aUdvmYqxhGV+Kfe1UfoAx49icmZwvIT2LPhXTl2tZvtir
	yYPaU2JSwinXO2yq+SDzpAce8BnkiUn6VwAjm41ouDyLLHZ7lyf6wxijYFmh7bs1fTrPnLeVJmn
	67uJOd/pNeWpX5m3QzBMB73R+jc/uJ01DDjYJ55DHtrX3BYv7qb4svlPxO/hb2N9s+pRethI9JN
	2JKwud80B6F0Y1Z6ovlz7JfkuLO4vd03UNBTBODf2jlRxeM1D/TLcc/2zLhJHSsHS/zY47MTikA
	58H4N55m8j5I=
X-Received: by 2002:ac8:594e:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-52dc47ef8b5mr45641cf.3.1787002102312; Mon, 17 Aug 2026 14:28:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com> <20260811173340.96013-3-thomas.falcon@intel.com>
In-Reply-To: <20260811173340.96013-3-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:28:11 -0700
X-Gm-Features: AcwNN1XdrMqd5tREKMuD-tbUHpHM-Otpi7uKDf2DiacCoWNJ-Jr-rLrfhwakkeE
Message-ID: <CAP-5=fV8LVwvfGbVM8hAFUkwH5NTOZeyZ2nJ7ZmX=av1V5Fgew@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] perf mem: Add support for printing PERF_MEM_LVLNUM_L0
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:33=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>
> The L0 cache is newly added a small piece of cache which is
> the closest, lowest-latency memory cache tied directly to the
> execution pipeline.
>
> The table "Table 9-4. Data Source Field Encodings for Panther
> Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
> "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
> Auxiliary Field Layout"[1] indicates the code "01H" means the
> "L0 Hit - Minimal latency core cache hit. This request was
> satisfied by the L0 data cache."
>
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel=
-architecture-instruction-set-extensions-programming-reference.html
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v3: Included more information about the L0 cache in the commit message.
> ---
>  tools/perf/Documentation/perf-record.txt | 2 +-
>  tools/perf/util/bpf-filter.l             | 1 +
>  tools/perf/util/mem-events.c             | 5 +++++
>  tools/perf/util/mem-events.h             | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index 178f483140ed..b54032efe41c 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -212,7 +212,7 @@ OPTIONS
>         The <value> can be one of:
>           <number> (for any term)
>           na, load, store, pfetch, exec (for mem_op)
> -         l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl=
)
> +         l0, l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem=
_lvl)
>           na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>           remote (for mem_remote)
>           na, locked (for mem_locked)
> diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
> index 6aa65ade3385..1be9df6550fc 100644
> --- a/tools/perf/util/bpf-filter.l
> +++ b/tools/perf/util/bpf-filter.l
> @@ -131,6 +131,7 @@ store               { return constant(PERF_MEM_OP_STO=
RE); }
>  pfetch         { return constant(PERF_MEM_OP_PFETCH); }
>  exec           { return constant(PERF_MEM_OP_EXEC); }
>
> +l0             { return constant(PERF_MEM_LVLNUM_L0); }
>  l1             { return constant(PERF_MEM_LVLNUM_L1); }
>  l2             { return constant(PERF_MEM_LVLNUM_L2); }
>  l3             { return constant(PERF_MEM_LVLNUM_L3); }
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 4e490f9cd348..4fd48fd20055 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -391,6 +391,7 @@ static const char * const mem_lvlnum[] =3D {
>         [PERF_MEM_LVLNUM_L4] =3D "L4",
>         [PERF_MEM_LVLNUM_L2_MHB] =3D "L2 MHB",
>         [PERF_MEM_LVLNUM_MSC] =3D "Memory-side Cache",
> +       [PERF_MEM_LVLNUM_L0] =3D "L0",
>         [PERF_MEM_LVLNUM_UNC] =3D "Uncached",
>         [PERF_MEM_LVLNUM_CXL] =3D "CXL",
>         [PERF_MEM_LVLNUM_IO] =3D "I/O",
> @@ -831,6 +832,8 @@ int mem_stat_index(const enum mem_stat_type mst, cons=
t u64 val)
>                 }
>         case PERF_MEM_STAT_CACHE:
>                 switch (src.mem_lvl_num) {
> +               case PERF_MEM_LVLNUM_L0:
> +                       return MEM_STAT_CACHE_L0;
>                 case PERF_MEM_LVLNUM_L1:
>                         return MEM_STAT_CACHE_L1;
>                 case PERF_MEM_LVLNUM_L2:
> @@ -915,6 +918,8 @@ const char *mem_stat_name(const enum mem_stat_type ms=
t, const int idx)
>                 }
>         case PERF_MEM_STAT_CACHE:
>                 switch (idx) {
> +               case MEM_STAT_CACHE_L0:
> +                       return "L0";
>                 case MEM_STAT_CACHE_L1:
>                         return "L1";
>                 case MEM_STAT_CACHE_L2:
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 5b98076904b0..daa22748f9fe 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -109,6 +109,7 @@ enum mem_stat_op {
>  };
>
>  enum mem_stat_cache {
> +       MEM_STAT_CACHE_L0,
>         MEM_STAT_CACHE_L1,
>         MEM_STAT_CACHE_L2,
>         MEM_STAT_CACHE_L3,
> --
> 2.55.0
>
