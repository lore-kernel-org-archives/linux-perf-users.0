Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC31388
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398997; cv=none; b=uxjOvsSyCGkay02SmVj4L2ogav6wkuvjm3UFsZv27cbdkcdtxpe8AYzU3lFetBCbFEcltPMa2UJzowyloJx7xD1gBMpWJ0ZV9vr2pL2Ised/Jwwjb0cHohdjDeWaey6tBrdcwCgDMeUKnaDjWFrVxYsRM3QIEsu9K7ELZVe0hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398997; c=relaxed/simple;
	bh=7n7coIRSnIIUb70FGA+XX4U1DxR53yWq+cl7ObqvJ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiH02YOakACxEpgBv/WphJVA6iGVZFBjzkzN22YnpN+NJj90me+x8Bf8myzY301Xy4OWt+rp3BYIB+0esKnaQ4UCiAKc85T8xeJKePlYuz8PN/H9I8n1g46120m9jhhLzX+9Cc6/nQsV2qr/Dz+hgc3bLbCzZDMxGK2yAVrIyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUPXSPJ/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUPXSPJ/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso164395ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742398995; x=1743003795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruRlgxoG6v9cNtBSfSIFgCF68XbtgVeUTkhXsZTDt+4=;
        b=BUPXSPJ/MXMpoUtuK0ii8H4BA4MEnFsVxKQ48tAivGXisYW0mZp3Mwy+/Hpcug0han
         lNquvEwahAjH3+M3VaU9NzL+FkpK5dDLeOuqWTNk9ZHLABFKzdqkeuTgnzg7F/Hy60h6
         UNipxjLVtaCzjkzmaqA/cx2NZVxvNsRgnYwZbz1GcL/nonI4vBhxNBaW5vfPF72re/1T
         7B0D51ygbdRhsS4bChRgqNpQdnZNrJZWlo7l8fO6InhKBtYaGkQmHLb2PrqhUaGzFR6R
         i7fNzNANKN3VReVBG09BIGNISSUCy7hC8xW6DrvkONwBplVnIgnFP3gUZ9BnTpEcOO+U
         dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398995; x=1743003795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruRlgxoG6v9cNtBSfSIFgCF68XbtgVeUTkhXsZTDt+4=;
        b=maj2UkgIhwCdeyNVmVdVIPyD1l3cUcGPCwPKSB/FlKxNAhtI8Gc8y9LafisirfcDf3
         Kjt/aavXxSU1YizaR93w34dLYlitG7b8jr+Obq6pdtarPFtfVeBJ2e8FGIlXurTDtq0q
         HR6J11QHstz1W4ILhY+dahkp78nD9ygyisSRg5MU12wdxoHqgCQO7RuQf1MDdyYcBgIP
         YzoY7PTiIfpnXCtW7r7AU64/hKUiETiPQIQYFdkyfTLLPDrKUnSTFGsIjM9aMKQjYta5
         TxYKyAcTXVpc3f0kSYL6sm87VcjfVvHTURIwW2RiEorMMkVrQ4K6C11bkrmkVx7RcSff
         NjdA==
X-Gm-Message-State: AOJu0YxiK0hJ1SuGp1aoUfSH5WDUkUI71WY/0jxEs/DN7Qzf+O4r/pIJ
	12L1DnLNl8/+UBegOAawNucttPp7UnIrzR+1vsKH2YUpISO2vChlBKBP5BeVvXom/zU7HA5Yi25
	I0S2VZZbnLAd62Gpbq6zaoQUypbi9/aM/ctah
X-Gm-Gg: ASbGncsa+w2nzjn0s3izldV1Zp5kiR/ZIsjSxZPjxWdtngf7ZWnocN0l2bJAPHa1ZpC
	T+w2AWkEN5rSlStTkK67aCvmNYPnyZL0HfhMRiZuQLxZt+ms49XVUr0nJ3NyLC39+Djap0nKSes
	goOYGTdxHZYKtI/7dcpMJyfB4KrukkqJjyvY7NLa+6lgMhbXnjJ/YzLg==
X-Google-Smtp-Source: AGHT+IHWuHkIvSY7Z7leEA5ObRosRaPTXfKMrBJgStcMtBCk03WBIodbKRyZj0G2hp2kbvK9CAx9KYC8ulnXyu8DMX0=
X-Received: by 2002:a17:902:dac4:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-2264c6695b2mr1643575ad.20.1742398995201; Wed, 19 Mar 2025
 08:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319114009.417865-1-james.clark@linaro.org>
In-Reply-To: <20250319114009.417865-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Mar 2025 08:43:04 -0700
X-Gm-Features: AQ5f1JqhweX5mSsHqDCo1dNNZ_4dvCD1fV5lK-3_zkFLf6aJz7th2SNf3IvmKUs
Message-ID: <CAP-5=fVHGryhBtt9SANOdyw3JijvefgqAHgZuiFBEuPmSdoTxA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Don't remove -g when EXTRA_CFLAGS are used
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 4:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> When using EXTRA_CFLAGS, for example "EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D=
1",
> this construct stops setting -g which you'd expect would not be affected
> by adding extra flags. Additionally, EXTRA_CFLAGS should be the last
> thing to be appended so that it can be used to undo any defaults. And no
> condition is required, just +=3D appends to any existing CFLAGS and also
> appends or doesn't append EXTRA_CFLAGS if they are or aren't set.
>
> It's not clear why DEBUG=3D1 is required for -g in Perf when in libperf
> it's always on, but I don't think we need to change that behavior now
> because someone may be depending on it.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/perf/Makefile | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 3a9b2140aa04..478fe57bf8ce 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -54,13 +54,6 @@ endif
>
>  TEST_ARGS :=3D $(if $(V),-v)
>
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS :=3D $(EXTRA_CFLAGS)
> -else
> -  CFLAGS :=3D -g -Wall
> -endif

I suspect this was cargo culted from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/bpf/Makefile?h=3Dperf-tools-next#n81
I'm not clear why it was ever that way, but perhaps a wider cleanup is
necessary than just this one patch.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  INCLUDES =3D \
>  -I$(srctree)/tools/lib/perf/include \
>  -I$(srctree)/tools/lib/ \
> @@ -70,11 +63,12 @@ INCLUDES =3D \
>  -I$(srctree)/tools/include/uapi
>
>  # Append required CFLAGS
> -override CFLAGS +=3D $(EXTRA_WARNINGS)
> -override CFLAGS +=3D -Werror -Wall
> +override CFLAGS +=3D -g -Werror -Wall
>  override CFLAGS +=3D -fPIC
>  override CFLAGS +=3D $(INCLUDES)
>  override CFLAGS +=3D -fvisibility=3Dhidden
> +override CFLAGS +=3D $(EXTRA_WARNINGS)
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>
>  all:
>
> --
> 2.34.1
>
