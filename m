Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF380F513
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920666; cv=pass; b=T0CK50rA8p0WNRb2X86GvD2BJtlzN0lkpd4gxAQMq7NrFJkuP6OMk0I6Tp1rpSqmcrz5+QBPmq5j1ICst1ob/SuwgV3s2lg3ZOkJFCfw3pHa7mUPUJK9IsPZIcyeRwvaqJBnCgm7/bRWQp/eq88vLifaVQ64BNLk7Dd3a0nONXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920666; c=relaxed/simple;
	bh=LsV+SyhkrxuVIXOsSNqgyv5N2AIt69nuNItNAbAFHyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr82FMPViv8vcPFm2d3K1RbK/qbMpq7bI5sx9xuDjv3FRmI7zI1I24UDdFukS/6J9eCwW/wBvgiGoCVTym65AoVzdq3g3F8ZJSyiVzgmJQ3EGj9NaOsAo9ES2/hdxpHKfIB389fpjbdKwQXE/DPHog4tN8qfkCQeAGxCIrl5LnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfbgHpSN; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfbgHpSN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a964077671so5795ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 10:24:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770920665; cv=none;
        d=google.com; s=arc-20240605;
        b=d7XZQTHBl+/Xzs6QogL01OwbTelLd4uDzclStvYPjZcBXiPIKGjdUPR0bKmqdHsqSw
         IHmER9gEy5Bo/ymQT+GRmvYmacm1e/egsSLKuccu7hOwaCCFiJCJlcPIMDTH+7nFqmWz
         /0n2/pRZ9MNr96DQJuE82xpOSnWMuuQfFLSb+7g0HYgRcIPaWCsU+KpJO3GwJUdTvK6x
         Hd7QkZae6VcWUEjZUh4QhjwixBtB+bIjVzR8HBx1ddNyu3/lve7e+0UpTKkqqG5+RPBj
         ekDH8YFv4zdAVrWCCZiBjX5lMPWh74fqNmY0RYLU40mPAsj6p9f4pdhkv1jALLnRVr8g
         hy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=akZ72RXQBtn/wck1o5xnkn2kWx3a2RI8OI7tK27nWmM=;
        fh=en+OeE9zWIhFbSOcY4I7gxS1Kkqqcxg0p3+0iBQWcww=;
        b=LYv7bag+lRvhfFcGUX6iCx91z/D5SArgft/8yGuUFISMHAlAedzETFFIQcfBXFHFB4
         Zd+lCJghpvA/TqzE18HnuLzzgSRUUDTqrrWuFxXp0T8/FvtN7GjQBRYBq5Tb0QZfuQyl
         ljy20ZSVhVnvGVbgQoLs1zkSKsDRfXIZvsnil/ar40XRooWaZr2H0vyNremEq+2MBxL7
         DjsVgPyRgPHMwdVe6GnxP43fYHhtSGU4XNN7c2tZoIppd0tYdeNY8UJuxBvMshFJvGyT
         f2sc1OUXuSIm6olE8sIp4xkDTTEljPw54rhkFwYhSgT2rRJ6YozrD9B6/vmxOGtb46fv
         +8ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770920665; x=1771525465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akZ72RXQBtn/wck1o5xnkn2kWx3a2RI8OI7tK27nWmM=;
        b=yfbgHpSNyee+4cuVYcaBJInTWTsWkUf3Bq5i9bl6BbzrVz/5diX9SfM391phu/E2G3
         DtYq9doWzajNkguGyraAgTddEViddtYp4+IoU2PyIIzqwDuX9tCa2BECJ7jKI88QhqZ0
         4ioJzKdkts8tb5Tl7khYy+h6AEyf+9uqKwjATW0SyI8TBKjqHOuuxoH/WefdCSPzFYTg
         x93aU8CI8pQ1P1FXHdM3+NlVbkFgqemU6FruoLWE65pmB5mtezIUpKM2aZIi4O5vhaZ0
         i0LEpV48afKt62doCA6QdmbDV0Gv0xRr79MYJ6eq0XvIEWvZEg3PbmZ+4GwKIwtQUhd5
         8LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770920665; x=1771525465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akZ72RXQBtn/wck1o5xnkn2kWx3a2RI8OI7tK27nWmM=;
        b=YMYvf+aiIywnqfN9hlmu+mOVXQYQsUIh1WC08wkqv/NA+JOMOzknnax6Z4fPptIvpl
         nXuv72RYqDNr4+671CyIw2nzG73zcUa6lWhwHpI3J2CTwlrPkBpKryc33rj/tZx6Y9cf
         jU8BxNEkmGJgjaDpZj/HG27A3A8K5n+8Bj/qzGARm1ryhu0ATfj8XvvrJ1PimlinILI4
         2909cRatI/pTKTULAkVLWYMQ3cnk9fnERNwhE6lg8usnMy5uxPE9EOiGJbDzL1KVnNNn
         GKFeWkL7It0fasUuDkZ39/gWUwJHnpq/IvU85QDEOSeXpgF7Fy77Q9p3MnkH/eRuiJ2U
         SdkA==
X-Forwarded-Encrypted: i=1; AJvYcCW1D//RUIMb/DwP9GOGKVMSfXhJYklPE7BzIZQ9juF3nzLu3lQuBM/S064NNoYnoP+aRPCbtEoRq1GHcRkuTxq4@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAfDfgJKrBNx17zCvtJ5OoyEwdiEMJgDLU5CKBSxTqWT/KZB+
	flPO5BcbTkXdFYjif8Ah1A9MvUl5O303A+xFBF+O7Rzng2O/arQz0Unt3b1Ozi1wdm/qotZ1ir1
	hVzLBj8mjady/GmIqrC9I4V7NeN16baFpICu5SqUP
X-Gm-Gg: AZuq6aJKeyKG+/gqh6qPRbpEAn9yVVWbc1QixtdjJhsu0lOgKeTzNSJ7k4oRqzVUI63
	WUAUTVS8yW7TsM8OAKxRk12EHJY4GvVKGhLfXD+wlKrqDSaWv9++JPLomJPwfzz3oxdkRX2JQgj
	mWpAWkJ1M4vZAtntWYTNC58PbhNWjH4x9/JtZ5fHjwyu2sRKse7BNgxs2sSun8hUoq/t6qodlgg
	nzhYAden3s6BRB5CdaR40iuIgpsuypdG2N7+fcW7NbJDghNPtnryHxe/bcy1Qj5Yt+L58hWTOdZ
	2dP9OlCnTTMHOL+9fgBkwUIlS+dPUZgdV0Og
X-Received: by 2002:a17:902:dac1:b0:2a9:5bfa:54ef with SMTP id
 d9443c01a7336-2ab4c71241amr112165ad.10.1770920664447; Thu, 12 Feb 2026
 10:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212025127.841090-1-liqb365@163.com>
In-Reply-To: <20260212025127.841090-1-liqb365@163.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Feb 2026 10:24:12 -0800
X-Gm-Features: AZwV_Qhv1zvWk0-INS9ux1YQSe9i_Dx5DmeBfSZpmlzwrgOxIznadzCEwFUp4Rk
Message-ID: <CAP-5=fWqP43QH0=+Cx+s=GM0uwJ9Lzt9Zw2Xw-NxOP-tXkoOJQ@mail.gmail.com>
Subject: Re: [PATCH] libperf cpumap: Fix argument x range [] exceeds maximum
 object size
To: Chingbin Li <liqb365@163.com>
Cc: james.clark@linaro.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 6:54=E2=80=AFPM Chingbin Li <liqb365@163.com> wrote=
:
>
> On RISC-V 64-bit Ubuntu 24.04 Server (Running on QEMU), the following err=
or might occur when compiling perf:
>
> cpumap.c: In function =E2=80=98perf_cpu_map__merge=E2=80=99:
> cpumap.c:429:20: error: argument 1 range [18446744069414584320, 184467440=
73709551614] exceeds maximum object size 9223372036854775807 [-Werror=3Dall=
oc-size-larger-than=3D]
>   429 |         tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from cpumap.c:4:
> /usr/include/stdlib.h:672:14: note: in a call to allocation function =E2=
=80=98malloc=E2=80=99 declared here
>   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
>       |              ^~~~~~
> cc1: all warnings being treated as errors
>
> We use the volatile qualifier to prevent unnecessary errors caused by the=
 compiler's constant propagation.

This shouldn't be a RISC-V specific problem.Does changing tmp_len to a
size_t fix it? __perf_cpu_map__nr and  perf_cpu_map__nr should
probably both return a size_t too, and the type of nr in struct
perf_cpu_map should not be signed.

Thanks,
Ian

> ---
>  tools/lib/perf/cpumap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 4160e7d2e120..ccf473994111 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -410,7 +410,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_ma=
p *a, const struct perf_cpu
>  int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map =
*other)
>  {
>         struct perf_cpu *tmp_cpus;
> -       int tmp_len;
> +       volatile int tmp_len;
>         int i, j, k;
>         struct perf_cpu_map *merged;
>
> --
> 2.43.0
>
