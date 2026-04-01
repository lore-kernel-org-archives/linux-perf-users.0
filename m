Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA63446DE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081540; cv=pass; b=RpGJCnyCfF1d7kbGrL95Wq9HTOKu6KQaGOvmMjtJqnXnz0qLB9pxYrhizhV2KKZbkYIsCVaXYiRPW/rmt/1v7sr2MGoRiLQzNISA3dmBZ5Iz8IcnWRG6eOhHjl8+5eWUAhatWZezAF2RSix9TBouxWXPzsI1hAfJBhgVNHITDZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081540; c=relaxed/simple;
	bh=ceIqb/mnUeRiBS4ut7KqufwYi0+MbuC6ay0IRlAyWjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK6IrD40+UaJNBHPxQXjq8s1uRAdQo4CsIw40BoiV7StIW09FRphVi6vPR1EI6iSXKt1N3ebgUcP4LEEC8CkVYiJi0/6WjVFSJOjVGmEsvsvo80ZpSbm+jl4BLGQ5r6vx32nNdXyl9OsOTTbeODa4rKZsbFd+6Ie0Of6jO+kgMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8Cdh1RY; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8Cdh1RY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2591757fbso42005ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 15:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081539; cv=none;
        d=google.com; s=arc-20240605;
        b=bn6J7bIXDjBXPb1oTaphJTyBdUn/wSBtoGtdP21GmuXUGNdF4fT3SL+PXYxd5Ahk69
         WShQvJKmyxOTfowmqE4qkdjp5PJJ2HwaBz3m5HFFlOpEL+vf2L9hF16fzjKNUk36ZEvB
         BUQ/J0FVxIFCgoRjY3zOJB5bL9z/T8+o7HG2ATRiJ5njFT7dAQY0CLeZaDv06bXPqrkq
         y1n10W3o/oIGqOUZmj5+BS5/qav96AYGwcl/RuiuPxWwW8rRGl8BWaBIdwp8vGwOb3W5
         /Zk/l+NLB4adqbyY6RaeRtiolpGWP3nwhsEOjnrRDl7zemGcM19b6hzQ1EDEyRBQV8iN
         xdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lWfKpxz9DPYLdoEGcWZ6wMuOrJpeQXrKrsocBd3L44o=;
        fh=NQ9XAQbM9Sbg8y3nVd6bgw7g/yJSKk3ew9daAFev0xU=;
        b=Fp3KNlVQuqkGu397J3DMBCT/Gh+BDeSJgzH8GzGzLDPRLIVkCPrRutX3M2MyUuVUZc
         EVAGJI3Nbl62TKWrL/SeRAfmkzRnwW+JPqdqbaHj4FINIxHcklI9qFef8p/kXFpx771S
         k6YfjY0SbfwI5oor6ePowR64eZoUNO21IWI8kwlRynAhax1xcs7+FtSvdMfk7r2omkS9
         tGapJrnSZFNVpCx3SmW92KaZ3f2/LXYAdgbE5AG4zYgdbLmIdZ9blFM8P0rYWmYjPmwG
         C+OLUH3gdFNToTMEU3GEPk8Md+KcuMnJ2UyVnh0ZAGtzd9vxwlByeTR10wVhBoiDlSBB
         Zx3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775081539; x=1775686339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWfKpxz9DPYLdoEGcWZ6wMuOrJpeQXrKrsocBd3L44o=;
        b=k8Cdh1RYcvpa5YKWMAoL2fpWxwf9RFFsXKjS7tJQa3dqziepUfd7ANDQ8EfGDl5NKt
         zqvwm0bJXgLT5fWFF1Pm2g6BKs671FgX6g+wjoeFawwJTwZp6yyaoigOdBd0wHhLoyfN
         z5ooiIfWF1mD4/z0lMbEBClxWG9O+mz0T2MnYiq8Egf/tuwy8K4MIjBEId3HH2Bjsc51
         e9xJIcD2tH0FMhL6YeChD1r7vKC/DFSZbYqoKv1WiJoRG7C9+YJnX7mXoBZ4D/U5P/Jh
         T0S62Nb2PfWCkGv08rd0kRvApX9BToxu191LIs1Z1ujBHhKUH8AZ8wG6wI61xCwyJptJ
         gplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775081539; x=1775686339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWfKpxz9DPYLdoEGcWZ6wMuOrJpeQXrKrsocBd3L44o=;
        b=p59VkGQaYboOWaZMmTt73iHtk08aMjug+D/o51E+8+zOj7TGecGa2fk2AdT5pJ/kV7
         HnZaeQif+6yxwiAERaifX2TveVItNyhamyqtpbxukJp3F6idxawGWm/DF+KyZgQQfuP1
         8+v7jL8jdJWKs7CyTZSfnek/GNEvvB7QbQycwjMwOtR2CsY2oECq5657VnzFYZpyd6+V
         Q39VHVDp43OO7xVOb05yiDQ+hI90oR4DzcEig3Ronj8pBhiECAZIerxSHrM+qPJabWHz
         v6UdEWIQx+47BuYEyFRVhzFze8MaWVj8/KGaNBP05opCu91cc39gnxq5FxKvmHVZza68
         6QDw==
X-Forwarded-Encrypted: i=1; AJvYcCUt63tS1nJ2IDeqLYnq+GZJFseDpardEQbF9+y1oqGVzlVwIJys+fYyDdPoH4AUgyGFAMrFt3m3MSO36VG3gezG@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzRdraXoqeijnOYYFguC1/gqgll2mfXesUUH+xgEqV5e8ykPm
	IvPuRi8o3yUdvX6Phiq4g7zVFeKOEMjNFLIkR2hGDhGz2G8K5HpWlku9BeoWZnuMz6j5ac/1tTV
	kASacYX2juwI6pyAWiMziPr7HvE7qz9k5LnrT+Jih
X-Gm-Gg: ATEYQzxc30sszkEaioLv7dai8pPp1+E0FdNpnmFJ3QJqki8T7VBM9bI73/++KuIzdR6
	PMiX5cqbaBL5KOkknDAZ0j9m300HDRhvCiSUJmLVqmh8zsm6mZbYPfKguCZjp/vgZNmHtPqmokN
	YJpJ3FLODNYAy1cvewo/AJwR2g2BBV4wO45KMA8pYT5o0C6fNWIGpl3t9S8bv2hKHhpliakvxQ2
	BEAEYsnScrFQOddpIUXutk0a1jSYml3Ce2tm7Dzp5wn7nzyBOPZN2pygbVgBOY7r3vCE3pdIJdx
	0tVrs/w+xVtcbcShhfiHDKFEoh45Xva7f/hgq7sjuY1B6W4=
X-Received: by 2002:a17:903:8c8:b0:2b0:be7d:a25e with SMTP id
 d9443c01a7336-2b276ada7fbmr846075ad.18.1775081538450; Wed, 01 Apr 2026
 15:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401215310.348463-1-suunj1331@gmail.com>
In-Reply-To: <20260401215310.348463-1-suunj1331@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 15:12:06 -0700
X-Gm-Features: AQROBzCkvecDsZUs05zgYST163BTeENm9LvsCyxh_vka7_3Ql67ykZ7vAFZRlUc
Message-ID: <CAP-5=fXbicqGBLjJqYjUvqdmVo2SsLWYgtaQbp=QCPt3uRgsMA@mail.gmail.com>
Subject: Re: [PATCH v2] perf header: Validate build_id filename length to
 prevent buffer overflow
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, brcampbell@google.com, 
	shuah@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:53=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com> =
wrote:
>
> The build_id parsing functions calculate a filename length from the
> event header size and read directly into a stack buffer of PATH_MAX
> bytes without bounds checking. A malformed perf.data file with a
> crafted header.size can cause the length to be negative or exceed
> PATH_MAX, resulting in a stack buffer overflow.
>
> Add bounds checking for the filename length in both
> perf_header__read_build_ids() and the ABI quirk variant. Print a
> warning message when invalid length is detected.
>
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2:
>  - Add warning message when invalid filename length detected
> ---
>  tools/perf/util/header.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9142a8ba4019..132d360d716a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2545,6 +2545,11 @@ static int perf_header__read_build_ids_abi_quirk(s=
truct perf_header *header,
>                         perf_event_header__bswap(&old_bev.header);
>
>                 len =3D old_bev.header.size - sizeof(old_bev);
> +               if (len < 0 || len >=3D PATH_MAX) {
> +                       pr_warning("invalid build_id filename length %d\n=
", len);
> +                       return -1;
> +               }
> +
>                 if (readn(input, filename, len) !=3D len)
>                         return -1;
>
> @@ -2587,6 +2592,11 @@ static int perf_header__read_build_ids(struct perf=
_header *header,
>                         perf_event_header__bswap(&bev.header);
>
>                 len =3D bev.header.size - sizeof(bev);
> +               if (len < 0 || len >=3D PATH_MAX) {
> +                       pr_warning("invalid build_id filename length %d\n=
", len);
> +                       goto out;
> +               }
> +
>                 if (readn(input, filename, len) !=3D len)
>                         goto out;
>                 /*
> --
> 2.52.0
>
