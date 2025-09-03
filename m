Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0329A9FE
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915663; cv=none; b=ZzUa1XH+itYFK70DUA21S2mb3z/JClJOr7sgn+2z+YTIL9YASJghB6+jLxjmjDzpeTaqmAW2P6+Hjk3/WeCvOW7ixq1g0CJiERXPpjmhr8eeVRR5JGXwtRMfKTvZXoViwNxCy9kr1anvrEBGEzdpqmog4NvDzBH+G66R+GbLWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915663; c=relaxed/simple;
	bh=OFtpyMYJm0RX/dGSDrdWjsxAmihpdsSEchmktPlLzVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDS+zZn55KAg9sIjt2TBHDlsWxLYfjjcru/t1jArL3dC74sMW+7FWMdajqCAKESfzaOFrnuB4Ngn+hy0rYRgfidZkFSsgTM+rR7AhM/fJI/X3dCFoVXBjTA8SLLy1SkMFN3RW0jqslHbidYH2XIVZghHvmTtBKkCJ8LtLzhOVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUyKxGU3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUyKxGU3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24b2d018f92so187425ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756915661; x=1757520461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6FyRX3RqQ7uAdygDY5zFdlCnnOh0ERjuiJ9MzY3XoQ=;
        b=zUyKxGU3YT1A0p5UIY09jBfiO3bP9THtEqfxb4+nV7vpB+ZDGkCRNmufhNyiMTFjpm
         vY76kyOX4o4ssHWM3X9L7JCNTi7p/9+/5dJLOLcvgfRxhT2bkCq8hstIEb3HuZxLOyVZ
         IQjcdKLhCy5uUxyINGgHhWPdmM7vEqIVHJb0vLsF6g6ER9n10jidgQNzkqSl1HlYj135
         wGpkLsAVgLsZhVVoIGOo5Q5APirKdFkwFkVRvd+BzrLB7P+TW6Qba70EUZ0KlsA7OXgR
         GYAsAII1PAEKMrTQGY2XE9tICnPcRjl77E2KWSkbAP6EzKS2ogxsgcFXXQM/dvXtO9fQ
         lstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915661; x=1757520461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6FyRX3RqQ7uAdygDY5zFdlCnnOh0ERjuiJ9MzY3XoQ=;
        b=juBUfVLJw0nNRAkNTzKrwufiEIKtFfzdhSaeKV3I7yX5MER9Hj5mITGOrirbM63Crk
         XA0o63C/eadrnk8Br6YZ9Zt3G/7aMGWEY26yA6zh3+6s307sPostAgPxxXs3MDulbORf
         34U2NqY/cd8tG8DKPK9cWTqURrd9DYx1VMfGmZJJXXeWG43/n/eVE+9oAch6n+fUluG1
         T3hqbzQs1He+DMghDhgMPWw3qLe5GmzF6C25HqQweG1YU50x+5Zm9KyAktUPF/pZNyN8
         9hwX4Hjkgr5vG8XDnheY6EW884RgOy0CeNoJ1gpqVWSu3HCDjow6iI7QuUuyNBNKL0cw
         FP1g==
X-Forwarded-Encrypted: i=1; AJvYcCX7r453qI1PIeWD8ASwc5t8RihfYEDWB+O/J/so3o0v57KGQTqhe2e2lwATF1YHnRDw+gGCGnxqzmg48jfwICJM@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdaytF1vrZKD1QSdV5Jf6+w4E/LuhPelEo+toCtTBMJYNuOjI
	DUiQe/AjF7BS7XGfKOkUkkUoJBy3wrvqYZvGEfvjI14WFzn5w7izNWMgnbntIWgyiurJ667ZO6C
	goDi4sk4sLcR0A2zl4pMiqCzQE3Q9lhTSj+gUVhMS
X-Gm-Gg: ASbGncvDfGJlDYqz8OCYvEVH1oRtB4udjHW5i2lIMcU8FLAafY1rNME0BhF6SaJVwxP
	YJW7vHWncSUoBcsq2pWj1h84OLfiudgjj/ZT+wnx4+Avgn4SxAK1t4Aeg37PIjOiMyCxh/gHNux
	QVMlMzcif1h3+fz7bLcw/McQ+Hf+8daF+WlAv/sjy4aOu3pLOhc8P1l0h4Ff4ssgi96oaqZarNI
	EfhBqIJ2N2DPw0xw6py/0yWyt5G+Vo0mdIiJlqdRmFU
X-Google-Smtp-Source: AGHT+IEdKqM0yI9d3FegODPcz8GkpOP5O8L0IfPsJctIDdNBeIqC8u1dG7wD10gYweodKVqqZ6RoslvzScA9OsJ9oYk=
X-Received: by 2002:a17:902:e802:b0:249:2caa:d5c9 with SMTP id
 d9443c01a7336-2493e95f176mr5989925ad.17.1756915660778; Wed, 03 Sep 2025
 09:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 09:07:29 -0700
X-Gm-Features: Ac12FXzP2PTUXzu2aYtuKjZooEp21EjqaYSgWFDnBx0sI44DuB4kcoiVcARy6Kw
Message-ID: <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: James Clark <james.clark@linaro.org>, Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> read_build_id() now has a blocking argument, but libbfd uses fopen()
> internally which doesn't support O_NONBLOCK. Fix the build by adding the
> argument and ignoring it:
>
>   util/symbol-elf.c:964:8: error: too many arguments to function =E2=80=
=98read_build_id=E2=80=99
>     964 |  err =3D read_build_id(filename, bid, block);
>
> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__rea=
d_build_id")
> Signed-off-by: James Clark <james.clark@linaro.org>

Libbfd should go away:
https://lore.kernel.org/lkml/20250823003216.733941-14-irogers@google.com/
but I can imagine that currently this is hit in a build test - sorry
for missing that and thanks for the fix!

We should probably honor the blocking argument (use fdopen) as the
probe perf tests will invoke perf record system wide with data pages
and predictably hang on this for files like mmap-ed in sound devices.
That said, maybe this hanging will serve as an indication not to use
the deprecated libbfd code. From the sounds of things this will break
gentoo :-(
https://lore.kernel.org/lkml/87ldnacz33.fsf@gentoo.org/

Thanks,
Ian

> ---
>  tools/perf/util/symbol-elf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 033c79231a54..e0d6ff7d0acf 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, size=
_t size)
>
>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>
> -static int read_build_id(const char *filename, struct build_id *bid)
> +static int read_build_id(const char *filename, struct build_id *bid,
> +                        bool block __maybe_unused)
>  {
>         size_t size =3D sizeof(bid->data);
>         int err =3D -1;
>
> --
> 2.34.1
>
