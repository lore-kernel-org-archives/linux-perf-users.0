Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5161DED45
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047805; cv=none; b=Wr79b5yFqshphy9vFH7OGA22ds/vHllJcyW2v/D9efvk4FSgAd+GOYGWk7IK2IG6LHOBRUBSyU3p4xRpMJSfX99oGeijGuzhP5rNNO1R0stHkJq5KSVdezg4DoIwd8yNiSD2uwMHbnzHs1r+/Ar/uifrT5DBqcBmj1qR6+cLYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047805; c=relaxed/simple;
	bh=OAqxoR0E3k1d3Zicqw0ChBG2rot6oEjKv+BbQAAHrKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUQXBIzZdZ+yiDUX1TzY70Ia89nAsisJhGm+fQhM4gtCVqt+gj6q9Q9N2f+6/mQBH/ezpb1GGrzGBmP4iT7wdMxX+ch4+BKErsWloMunOuv8gAkA15d9Q+3eixV+/OMKym1F40rfwRgpEZe248vVKjFyEmM0WxWT1/0OB/137zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfZidjAg; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfZidjAg"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a814c54742so35545ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 15:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734047803; x=1734652603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB5bX3v/DMA7yD60ulRchWAjL+y6HgiWpq/uuN5wDvI=;
        b=sfZidjAgT84BeF+mu96SCQRAYVmRUIhiF8R7qs+XXBSXMWCabXSvsoeVXPlIMrSWn9
         Fx9c6tMnEBFzaR0oSqFkcjPx4QKyjQkY/L7e0ewnBLTbQgqUUqKD5KW88hXXHsXxl7L3
         K+f0Z27ilPrFJ3uO/kqhPo27Jn5q9JdCXGQzCxga1b6bA8rhGi1R0a39iNujrethUwcI
         fKhGYivHwuPJTkbGFOAXJXtE8N4duj8SH7pjySZ3S/WM1XBku3sK+lmKbPW2lACRe6GN
         rz82+Lu8dkwHxa8hyRskbS6fa4zta+WEc8V7hYlztwFkXf1CEiqvF5AZx3T1Cfr3PNSB
         dS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047803; x=1734652603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB5bX3v/DMA7yD60ulRchWAjL+y6HgiWpq/uuN5wDvI=;
        b=HYJF5LfD6huDC5CZGe6O/TZasmh/AEKx9t8IAdJGbyPPp7HdhI1RJ1fYCIaJ7u77xO
         NN9Wr5wb0Bq1DCID7W7cy21tK5Drcjg9ScjCC7j1E6+xB9p+2EG64d4OPnEf3mjV2dO+
         ZgLrde2H51WPcyC1ZeHAEhr+x/M0jgIPaDEWOHIsD3BxNLHGyczDnHzeM2Do4fMdjMLU
         zJp2Cvl/ZNGnd7dnJoXqXyUrZgAl1NbasLhpenudZJgAsKuU3KYc8E8AbOg5hBoymGuB
         l7yqZjsFnrSriRFmSMEFTOUWckVIANqZ51LuMK5VhdVaqeYP6TVqf+cGmSE47kgc7Nof
         Ty1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK1YZR3qyC/4Lx7w6kI5GEXLEI93vuLmxT6vdpvuoGYn95bZM+UEyGwt8JYP6n2MENvIY9e+ace9oMOmjwha70@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWbmK8Qokn8HEnph6DZRRn2K4MbZON+dIWUOEEI/JNSMdpKAw
	Em8d6ileHqXjzstz0aSUw9htFRCmoBMJBFHW0M6hyPPxx3BXTiVmoGSN9dZd/XrXhzQYURSqYXV
	609bD2ENCTMSwcZ6MgMYDQOGIQ1wy58a4KZ3o
X-Gm-Gg: ASbGncuKOpOdJJJ99CTPRAsrHNsDTmzRIL6jFo4GUEOvPI46oHj4BCIctXLFL2E3DuK
	TxNjsUxRoF3C//PksSvBjbhoT4Wl/CGuiXwH+51s=
X-Google-Smtp-Source: AGHT+IFE0MXaXTiKwdCeEqzuur+/EXqmoUorCxXi8ZAavQNCLD4dCXv4DKrdTry+I1dAHgrFT+uoWbkSKulwbk7M6w8=
X-Received: by 2002:a05:6e02:180d:b0:3a7:c7fc:1fdd with SMTP id
 e9e14a558f8ab-3b0267494a7mr461345ab.3.1734047802699; Thu, 12 Dec 2024
 15:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212655.922196-1-namhyung@kernel.org>
In-Reply-To: <20241127212655.922196-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Dec 2024 15:56:31 -0800
Message-ID: <CAP-5=fW5bbxXakiFuUAG-HTH2aH_hTXQjJp6o-bZcjcPvNmVrA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The sample data is 64-bit aligned basically but raw data starts with
> 32-bit length field and data follows.  In perf_event__synthesize_sample
> it treats the sample data as a 64-bit array.  And it needs some trick
> to update the raw data properly.
>
> But it seems some compilers are not happy with this and the program dies
> siliently.  I found the sample parsing test failed without any messages
> on affected systems.
>
> Let's update the code to use a 32-bit pointer directly and make sure the
> result is 64-bit aligned again.  No functional changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index a58444c4aed1f1ea..385383ef6cf1edaf 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_even=
t *event, u64 type, u64 read_fo
>         }
>
>         if (type & PERF_SAMPLE_RAW) {
> -               u.val32[0] =3D sample->raw_size;
> -               *array =3D u.val64;
> -               array =3D (void *)array + sizeof(u32);
> +               u32 *array32 =3D (void *)array;
> +
> +               *array32 =3D sample->raw_size;
> +               array32++;
> +
> +               memcpy(array32, sample->raw_data, sample->raw_size);
> +               array =3D (void *)(array32 + (sample->raw_size / sizeof(u=
32)));
>
> -               memcpy(array, sample->raw_data, sample->raw_size);
> -               array =3D (void *)array + sample->raw_size;
> +               /* make sure the array is 64-bit aligned */
> +               BUG_ON(((long)array) / sizeof(u64));

I think you intended:

BUG_ON(((long)array) % sizeof(u64));

Thanks,
Ian

>         }
>
>         if (type & PERF_SAMPLE_BRANCH_STACK) {
> --
> 2.47.0.338.g60cca15819-goog
>
