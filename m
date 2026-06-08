Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA739E9D5
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954951; cv=pass; b=D7qohEQ0/x85wlFAPawt6vVJoFkGevZMTYc9lMgcxz4BbHGoj3ac7LkSVuairjBYG+mwYkw06wWXXe287O43PADqhrZX1qX03j9f2nLJwh5cspzJrTBi2lVn1fm4KV/s/dWNtPe2jtBiRN+9mblzlnXLI/iohj2RPIQE2d5L250=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954951; c=relaxed/simple;
	bh=kA5IPMaGV6bsjMgoQFN6W8mAwD3VgKJp+kNfn84h+fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/4fOhD0AuzxIYO38t0ugRDiDKDNHJxuE3R2W8Hk+FduHIoA78yB4wG/KLKHHX08d6hnpAXhXaKmDOVrsrx47osRJ8H9USGE19TIi9k2FHX41YZoA1MLc8YtrT/mdxKH+tlN4GuAn+drb4HZuu284P60NMsR91C3G2BkpYEEVxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikmg3xRp; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikmg3xRp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf22c18ad3so445895ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 14:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780954949; cv=none;
        d=google.com; s=arc-20240605;
        b=B5f6nmmnYJ0nZsNNaDyyZgXPX7lm4y/Bdp/QYRnZF5qDrTZg1mFWpgLk/Vk9jyz5r7
         NvUyAxgisL3Az9nYa7uh6CBHt3G1PD2ernmNwL7eK+U+Ik1hKIBxc7hO4SGnim/mkA7D
         xYlaCAqCnuVlNrLotRAgvEmeblyJ0TOQN1cccWQF1qSfQnJBkd7BHwkwohqQEgv8uTwe
         +vr+jUcSI1XE8Zt/Khguctc86JU1hxmcDfVQ8KLmg71c51NNXFJ6JGX/hzK5gczEos+F
         7bA0d1pHK/H1kEPjkwsfA8sCvmP4vzsfgM+Zu29XX/JrVApFbrQC8crgxTn3+mt3MehB
         fOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=63DxqAHC9s5R21up42youiKFCHuQoEs5er9JrbIe9hM=;
        fh=whn027Y1E8bqDlmisWLYrWVfxr371bDKwhhRkyiRiMA=;
        b=h6ENwGlPj09OUbMbnwdDhprXvoBE15YaaCPaaOmub39b+MksaeSCkVqgWEjWSpmVNa
         A+/1OXw3ZFOLRVIgbHETrSZuM3shHPptVk4bzBP19zI3BrCgArG5D9dMOoeGFacI42+e
         Aa87shLuHZQpKVwGvnF5rP7aKRPohtEkYQIlG06P7ilq4gCXLppGLfPXKwLSy3fbWc/M
         xyrD1FyX2an1B9rp2ffwiBLlsRahDYVtDc9/g+8OvsOTJLTE03qGfSAn/826HX0LWdsF
         SMnFAkRQyQYxQREcGryNj3c8NKE10MRzGU7iF2kiDYVvAZ8qw07zqSYYxNbQUbEjCXLg
         DNPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780954949; x=1781559749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63DxqAHC9s5R21up42youiKFCHuQoEs5er9JrbIe9hM=;
        b=ikmg3xRp33igEIsOM2YsVqmk6JwySCNbr7vhqG9D3Pqp2zyQw6Bwmo4D7IHvotgC2t
         xhpYsQGXon33n1BmZzDfgwkpccj+tazTS0eD8/TaxE0Sl7WRv8Mb7Kwq3XcWTrlmaTfY
         2grt+QKinjvvi1f5lv8ZcgNUy8HlxxOTdoK/YDZ2THmcAZdUlpUHCzv+oilnehGd/O4u
         SuIplYiNDAw6SLHS8boOnasQZRIoDb/6tj2a+v5lnDOAbT2ytWgUbe4aR9PJnGGxBlN3
         vfGEwXZETW92lVnCoRZHmPJueh+yebIEsqJsiGg1Tw65l5xFqx0TpT6G7I0ztnWvUxxB
         RM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954949; x=1781559749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63DxqAHC9s5R21up42youiKFCHuQoEs5er9JrbIe9hM=;
        b=VobFK2n5N4YA+WPZHomGOd94B58kZ1crJgdguwVfexn79WYGra6+fH8671tl+fvp4C
         1ZXk7drZ7yRSdf5TRYVfln3Ah7XTVsDSXt1a5zXQvEmzWOFkwwmEc7wROWgpMsRdlQmh
         nKCBUe+kM+JFERAWNoFohjISz1FicXGKllaDjx+IdLeWC2PeEKoroJISQTWnnMwo1qka
         rXbrmJdwKPyuo72zQCAsNi1CBwyVLc/8g6rpKn6r92cYZbB11MhkTciaPa/vzByuqI+B
         qgtxOcgxuZOXQ/tEjCJDFBxeQDn0P2D1Br02EN+DIZKC5vbTDDwAIvmIImNSwHRdiGT0
         lF0g==
X-Forwarded-Encrypted: i=1; AFNElJ+q593TEIQtxXFxusbG10tmcEpSSXSx+tu5qyBIJlFY/fD9+oWVcVm8meyb1oCPg4j52DFvaVQQmkdGpfskSQ1D@vger.kernel.org
X-Gm-Message-State: AOJu0YwtquwGFZtNcYm85gq/TdHIQBpMnOVEih6Jgs1MdubRwhbPmgrv
	yiwHU1UxSXsnwUMGHvTeJRhimwve6oN5WFX1u1jBTaxIlJMWqIUkZXkr4I4hpeR3MJqOwZchnMN
	Ne3MWzqzCR1Til+asW003iW/9iAkZBAq11Xl4oexu
X-Gm-Gg: Acq92OHSmA/dRS89M1bzJqdxRQNL1fR1YEiU9akOLNyO4/1K4Ux54B3XlO99ycRnmcx
	F5fdFm5cecK95UoU+GvtefR0Dscx7kYtVk5NOUHmm7crI1A1sWJd+O7M3gaNpXFbQRSydhjt88m
	yZhtGOFc5h+WYg18u5vzVlEaCKyWbPnQa1kuTwqpMxlp8EQyH0ad3tsbgzhjr/UNA9LTjxexf3z
	88CKpuwcdAiStE9q7VrYTaiEQaBxHu3ntp8xAtXduB0oGGMPTYoFOmpHp8SSBHl6UqYBR/IEywK
	h7SyDexgBdJ1e2TfHlk/9s+UIbLUZ34UN2evFheGiPdawra6
X-Received: by 2002:a17:903:ac6:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2c1eb1dbf25mr6658785ad.10.1780954948196; Mon, 08 Jun 2026
 14:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-3-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 14:42:17 -0700
X-Gm-Features: AVVi8CdQz7xqR7AmGrqk5Y0tTEyg0X77Mpuo40b0Q6M9n2QaJ24LCwIaQFlXdbE
Message-ID: <CAP-5=fUQQv5vVRpmPMPJyPVCsLhGOsC4NG-VLiUbSDce2suiJA@mail.gmail.com>
Subject: Re: [PATCH 02/11] perf tools: Use scnprintf() in cpu_map__snprint()
 to prevent overflow
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> cpu_map__snprint() accumulates snprintf() return values in ret.
> snprintf() returns the number of characters that *would have been
> written* on truncation, not the actual count.  When a fragmented CPU
> list exceeds the buffer, ret grows past size, causing `size - ret` to
> underflow (both are size_t), and subsequent snprintf() calls write
> past the end of the caller's stack buffer.
>
> Switch to scnprintf() which returns the actual number of characters
> written, making ret accumulation safe by construction.
>
> Fixes: a24020e6b7cf6eb8 ("perf tools: Change cpu_map__fprintf output")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/cpumap.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 1fab00ec4a59a0c7..23ebe9b97f8e58af 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -692,21 +692,21 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, c=
har *buf, size_t size)
>                 if (start =3D=3D -1) {
>                         start =3D i;
>                         if (last) {
> -                               ret +=3D snprintf(buf + ret, size - ret,
> -                                               "%s%d", COMMA,
> -                                               perf_cpu_map__cpu(map, i)=
.cpu);
> +                               ret +=3D scnprintf(buf + ret, size - ret,
> +                                                "%s%d", COMMA,
> +                                                perf_cpu_map__cpu(map, i=
).cpu);
>                         }
>                 } else if (((i - start) !=3D (cpu.cpu - perf_cpu_map__cpu=
(map, start).cpu)) || last) {
>                         int end =3D i - 1;
>
>                         if (start =3D=3D end) {
> -                               ret +=3D snprintf(buf + ret, size - ret,
> -                                               "%s%d", COMMA,
> -                                               perf_cpu_map__cpu(map, st=
art).cpu);
> +                               ret +=3D scnprintf(buf + ret, size - ret,
> +                                                "%s%d", COMMA,
> +                                                perf_cpu_map__cpu(map, s=
tart).cpu);
>                         } else {
> -                               ret +=3D snprintf(buf + ret, size - ret,
> -                                               "%s%d-%d", COMMA,
> -                                               perf_cpu_map__cpu(map, st=
art).cpu, perf_cpu_map__cpu(map, end).cpu);
> +                               ret +=3D scnprintf(buf + ret, size - ret,
> +                                                "%s%d-%d", COMMA,
> +                                                perf_cpu_map__cpu(map, s=
tart).cpu, perf_cpu_map__cpu(map, end).cpu);
>                         }
>                         first =3D false;
>                         start =3D i;
> --
> 2.54.0
>
