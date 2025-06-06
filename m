Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0F17BEBF
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Jun 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231731; cv=none; b=CTvGJfuTjvYhdB78HUq2MoChJM4QQ/Aj1TLygdVDDqPY1wA71cthPAMRt2XKHrqy6ElXuP+A9hMQSP9V9rG4Qw4abepPx1XwZgG/E50RYa8ZPHUYYigL1Qdghfgkxg4z/sH3qCi/JWe+AqRx6DK96KbPhKeKqH7U7bP6ExrSpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231731; c=relaxed/simple;
	bh=IY099Uhb1zX/RB33FhT1UpmqkmN2CKjhfyfZMLkCXhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHu2mkq6D5kqf+vcNWvGuaUYUSu5vm7qE7yOsQIMW5reDN5F1KK7YasjD6yvPMXq81aXmHRieGxJ1Mr2dn65IEyZm1hgrkECAaFxtrw9r8YKl1txzv2bSmZ/YwUpQHt/F/P1EcXQLn91RL0YpSnsg0pLI8Feu43KRCn8vLBOfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zxm5RVH3; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zxm5RVH3"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so12605ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749231729; x=1749836529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQl5xXzidYCajSXaZTPWFkCXGQM4eKdlGCBdNyt/Kpw=;
        b=zxm5RVH3d8b2QCG6cqHfmFjeWBOKfqh0E4ezxfnFwTGUk6nYdK/d+jFjTY2hG7y+c6
         qoeeqF3v/Zp6oF9oWfzXjS6Um/VLtfHnHo3NPOcdvakS23HEFdxSoJ7qkKmdecwksnDO
         09+bxOprPHyuupu99bYAokuDNPLpXL4YyIhIckTHac7emstkFQHcoteHWAkBZEqCWMgw
         qAdoUL8QnBlBAcaXNCraHGmXI2G0lQtWl8PEaBl73ufeT1Zqr7/X8rZUoCiSxvk/y/wU
         ngTyIjMlGIimHfxOXT5o4nES1eOA6cyoZDvKwSDYpByPNoxzrevzYhGyls+2dk1Qt0yl
         vFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749231729; x=1749836529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQl5xXzidYCajSXaZTPWFkCXGQM4eKdlGCBdNyt/Kpw=;
        b=sL3ESBSjvnifmKAFfpPVDSoYF9/OyIaaHt4SxouLLlU9v5ZefcCM3PeXo66j7p3W4j
         2XdXz+4Y3lXCMMhIXAX14W46OhCMSYnQbpzBzxH/efuex3d387Hjs8akw2nSrJc8x332
         BsUGztsyVaNF5pY8hmKOSNVuUVFg1j2zgYtEJShQ6ZsRjwtHtHn4YE+8fy3x4Vy7oNuB
         HMspglX46kUDGX3Iyu5sn9TufYMxcNs51okRFAZ66t3pITVef/oQxnyYoO8Xmx4AU6m2
         lzUW5t2qUjpoWtjyXw6oVcDYT+4bTIQa7qy/nilOVqpq7jS12ICFpCOBi7Ynd+tVU31Z
         Ce9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2P9WKuTzav0c5BqHWN5Y/iN40YMTDqjned+Vw9H5fwiEm7yVcynhqL5xe8d2rcnrV+o2kND5Lplt9oK4EGcvv@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRBPyIEYvvM9TCuARhDdYT7j6f9+xsmnxrZyDG2p5FF2cc4Zn
	R9VgpoSQ0xgR9qIb7fVkIhgJfJgCI2A7HCoBXHS+EH3p7/L9Y8TAkVYmbKSYER4T5T+aN5TiAZ3
	gZ7/jb4ne1iSdLWc4LnMCVLCajWrmVo8mLKKM7ZEF
X-Gm-Gg: ASbGncvxxTDWgjgysAzn0Bj1HYYGEK9Tnyiw1Jj6IyGMSP0Uv/6goOgwi8DDN4OJ+Dc
	RKW7+eyJnT9cnFeSI7YnbT89CadTttqFXIZYY3NBkxMb9piH8k7fXVTRzA7AD3V5ia0uOsF3w7a
	EwQ3goNppWZSVXcBstY5s8bgCwaZGjCYcRT8XrklqJ+jP+
X-Google-Smtp-Source: AGHT+IEaErEvILJie5Tmz89Tuc+xBqtQ7zBkH1qVfOJ+VRiiLqP/QHRYIFHfTIDoR0abJbgO7FVm6GHUfB9tlyHI0pM=
X-Received: by 2002:a05:6e02:1a64:b0:3d8:18f8:fb02 with SMTP id
 e9e14a558f8ab-3ddcf7ea5e4mr3434155ab.17.1749231728819; Fri, 06 Jun 2025
 10:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604173632.2362759-1-yuzhuo@google.com>
In-Reply-To: <20250604173632.2362759-1-yuzhuo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Jun 2025 10:41:57 -0700
X-Gm-Features: AX0GCFsX-VpS06G-xJ802yPwn-9wk6wzreUGSmx1m9rom3fxFg49sUrQl_WjOSU
Message-ID: <CAP-5=fWKUa3uz+wwwN4P7-bftRMFe5W1WYgVDV0kOhGJGLpU2A@mail.gmail.com>
Subject: Re: [PATCH v1] perf: Fix libjvmti.c sign compare error
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:36=E2=80=AFAM Yuzhuo Jing <yuzhuo@google.com> wro=
te:
>
> Fix the compile errors when compiling with -Werror=3Dsign-compare.
>
> This is a follow-up patch to a previous patch series for a separate
> issue.  Link: https://lore.kernel.org/lkml/aC9lXhPFcs5fkHWH@x1/
>
> Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
> ---
>  tools/perf/jvmti/libjvmti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index fcca275e5bf9..82514e6532b8 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -141,11 +141,11 @@ copy_class_filename(const char * class_sign, const =
char * file_name, char * resu
>         * Assume path name is class hierarchy, this is a common practice =
with Java programs
>         */
>         if (*class_sign =3D=3D 'L') {
> -               int j, i =3D 0;
> +               size_t j, i =3D 0;
>                 char *p =3D strrchr(class_sign, '/');
>                 if (p) {
>                         /* drop the 'L' prefix and copy up to the final '=
/' */
> -                       for (i =3D 0; i < (p - class_sign); i++)
> +                       for (i =3D 0; i < (size_t)(p - class_sign); i++)
>                                 result[i] =3D class_sign[i+1];
>                 }
>                 /*
> --
> 2.50.0.rc1.591.g9c95f17f64-goog
>
