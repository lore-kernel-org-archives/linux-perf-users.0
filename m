Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54F363C62
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060485; cv=pass; b=BwgIyiZitfETjyRkQlplu7eEJZaErBYRDU+johhlLW9pLnp5raZe+bawfsjt08LoODzBkatPaORLbL2vHd4adqXYv0EeylcJllNmoI3YELduVMcaaKyOa8lfVbxl3uVL5bkXt2XjIC3fmkxbwKoetBmWXva/yTwecbIBXZOLk5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060485; c=relaxed/simple;
	bh=kjka6yapCfD4HbjmN7gRU//AkLrg1C0JenYZqph86Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3PEssL/jHGhOzo1G/6/k5Q5xCjPCg48CuIeWhW4RzYIwd4/3vx6rRmuVEC6UjBwiHtgUU4dhCTqlOjbe9jW6hwbv2u4mH75MOvL0V4y8Vg8pNWMtRC03yNFgeg+UUrWlIvthJtcl5VzuhCLt43RStbduAcrLG2ylagpOX3tBZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAKWHmG4; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAKWHmG4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0c12be0ecso247355ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060483; cv=none;
        d=google.com; s=arc-20240605;
        b=ITImrZipI6C4iwV9zCaZ4pvhKjW/YAtLYxqD8w36W7muEVVKAs2h97LKw9QzdPHho2
         4OaafSbhxp0y96UwPkHsmQjqHk3e86CW6kGvZfmghfM7diLq1cmYHoC/r+zh7rvC7lSP
         tYg06NqyUetHh+/SesatEPpqMdTeTZRptuTKRd7xRBcV/pH4OFTnu3vgfN/4AEoRALU/
         KJWFC7tU9B1aXjoYnEbSmxXQVxYI3QfVGUqzyeaB9HuaA1yY9QuzceekBLv+AE1aa8M5
         FJkryttEWUpIZHvHail/oOd+lmRM31IlXz65y6DRe27RAGXF+DP911BZU1wCp6mpOe1u
         xT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=It2kT+OoR+9WkA2mdJTiTtziM+WKTEpYI7PsO4s0uBs=;
        fh=k1DzDG8nhzQIzOp5psYNQ8y0dWdsdo+Ol4sUl3VcpVI=;
        b=E2BnzMMTrkGVku1T0PEic0bENVx9/MMAjTP/Ck/xQZBh4/HcE/0cLpDMrKRBAdBNx/
         +WMLAd1hvqBm/i2e7f9mNd5fytcWGVFOV5tGD66EqpuTsApozAXUQyQmXd1TIO8Zcmmk
         GSwICQrRrn+llI36FfEtckgQM0ya1aDzT2q0DMBB1bq2n4qRuOXlpmXQ7QwMdFTu0CBh
         35hmSk88eF7UTh4KydiFLWjJ3vRkBBUtKpQ7toTh2X/Zbv7HrDLtECGFPWukJ/M4/Rpe
         UdQDHjj9drIp8/ofFNIRaMG/j/KwDyQmSDJ79j6xefn3pP0YaYjUSw1K7Aa1v2/NMUZS
         tEnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060483; x=1775665283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It2kT+OoR+9WkA2mdJTiTtziM+WKTEpYI7PsO4s0uBs=;
        b=dAKWHmG4XLSBxEac0RdiJspMLnC51y9/3wQj/dyYAcYCIei5BXXKqk0ERLiT2otB7T
         7iPrukCbdbL1zxXy7w4+nQ8zKibnWnG45oCL52IwCW+4aM/hkQWFr1/zTeIropSGUdrg
         CxjYypPqZdQ/FUgvTqN7jS2qcMJQ0Uia8aY0XBlPcBD5ZbD7432EBtodgzinXxAmt1Zk
         dWDTC0pUZXnEZuBfGctchhJQzr87ZA2Ch2ixs64sNJPOVZkchaStZS1lR7pi+5UWiWGm
         Mv92yydnOc2roe9AsNxvM4FwcI+NRT5b3LV5CqErdbGJZJ4GI+5PBXUDU/+XI1p/wZoF
         nJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060483; x=1775665283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=It2kT+OoR+9WkA2mdJTiTtziM+WKTEpYI7PsO4s0uBs=;
        b=VVeSRN4icit8mblhQ/S6oKt+BX+Dy8qJYwqvNDRjv/FmizzclAQPupUHGnCgQYuQHf
         6R9xmLKGAtSlYqY8I6hCv5VbjReBME6XNsm8mhMDgqkDKiZbayKS/BDx44LaWIdnSCeS
         VUqAwz1h9nEbDbF5CJl2bMWkUXdPfA/q+9nVYe1TzrPReHeGstSjuPeOPPaF6oOBSttS
         3DlQ1LNgDmLjEvW3kZlJfmMFFhdOww4rl4+kXHZpvkUXUgXNNe9c7gEtV+V3WvjIYXIs
         B5bPNYSAy525rwwPgvYdQYNdMw9up9CLrYwcAMlNdrULT2XUFwu+gCpC3T7eU/ws095Q
         SB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlkUHNpIT82TsEzXZS4avVHpSLIhqSJDlNNAavhKHgWZT4uI8i7/H/gdyrbiyCcwSEn72DuqGT3fX/HxA/hNBE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1865z1gL/ydFwTvpCFs9FrC82h5qnk2H8H1PenWRLjpqyqHzL
	r94hNb0CGPO5U8CD8jtzl3r+d1mSUT7fKvufDdA0HhbvsrAD8e2givOirHPHc9qfDldu605kayI
	VjilhtkAfdbbnmVRMeUOrk/znjNP6MamZnxGZwa2OOfNERZwecmw80VvU
X-Gm-Gg: ATEYQzzR5d0Rx2rK5kEfLgpJ1e1oy2P45m4KaS0vuo8rFGzYfT0JvV04EP1lzunhULg
	VIzN38vMZkbWURIItRY3FAiJly2JCaRWxUV3H5aO/dCFSzYgjlwxOD6JU8xHt6ADND5kagw8azf
	PCipnZPLjp69DmvK47TaQFsPb7MwawHeEc45B/QUACnimgqPj8GDR++71wWrKN2slQCwFY+Z7Lm
	DSwXpZX4B9d/8HXL2bPQYXlilMi59ToGV+mZqO+Z5dDAOxIEsd9SYGgUnGiP4geCXlA9IzADn/L
	gNcCgea8JDeOec+DA7nYZ98YLPg0Aews931A
X-Received: by 2002:a17:902:c409:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b274d795admr298295ad.9.1775060482802; Wed, 01 Apr 2026
 09:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401122102.30737-1-tmricht@linux.ibm.com>
In-Reply-To: <20260401122102.30737-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 09:21:11 -0700
X-Gm-Features: AQROBzCCfjfl2yfm_IJE4MRh31I5SUD0IvXQE45wm3CfBrnbzlLRCqeCHdIGvas
Message-ID: <CAP-5=fXpU52Y1H-KgLrpYnTiPvZ59DViYTOuML1a6bETBt8Kag@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Skip perf data type profiling tests for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:21=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Test case 'perf data type profiling tests' fails on s390 with this
> error:
>
>   # ./perf mem record -- ./perf test -w code_with_type
>   failed: no PMU supports the memory events
>   # echo $?
>   255
>   #
>
> because s390 does not support memory events at all. According to the
> man page, perf annotate --code-with-type only works with memory
> instructions only.  As command 'perf mem record ...' is not supported
> on s390, skip this test for s390.
>
> Output before:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : FAILED!
>
> Output after:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : Skip
>
> Fixes: f60a5c22967b8 ("perf tests: Test annotate with data type profiling=
 and rust")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/t=
ests/shell/data_type_profiling.sh
> index fb47b7213b33..eca694600a04 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -15,6 +15,10 @@ err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfout=3D$(mktemp /tmp/__perf_test.perf.out.XXXXX)
>
> +# Check for support of perf mem before trap handler
> +perf mem record -o /dev/null -- true  2>&1 | \
> +               grep -q "failed: no PMU supports the memory events" && ex=
it 2
> +
>  cleanup() {
>    rm -rf "${perfdata}" "${perfout}"
>    rm -rf "${perfdata}".old
> --
> 2.53.0
>
