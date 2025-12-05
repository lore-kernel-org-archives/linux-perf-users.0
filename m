Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA319CCEF
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963626; cv=none; b=lfRz15UM6G0RLWMcALhOv047JE+56Hm3V58gH+9ZpZYaM1N1HJoyBuGyKfJ9Skhi4RxKth4YhVY9YSAugysUJ+3VszxJ9ZKyufYOuGgUpIrhalCf+Fw28d+9QyBLHcjZlpmakgFqmL1ZN7w30qgwIjoRQzrcPJauBHlxCyrauig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963626; c=relaxed/simple;
	bh=K1cD7X9KMjQPlim6JkJq7aVBdI4r7IaDsw+ClBS3wZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uCfh6UhqfBE6/ZGjowHDGb0hufPNRHENf/kmIXDS5M/Y0Jc18J26n/s004HPX291IkXpraLj8MOQ8aXINoWkF9Zhw7im8qBaAnkh+PLj2aE/0AkVmBIAoDlTtfbfyQ5mASusWrWGgWFEfIuFWS91EmF2a4DnII/E1d204G81ggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQTWQvhw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQTWQvhw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29852dafa7dso20295ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764963624; x=1765568424; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+3QFrDdsEC6ia4rTVbK/1nejUfDjNZ//u0RhNdC+A8=;
        b=ZQTWQvhwl0hKG36rgShBAkhsuVsgYdQG+CiXUvJuqkZ0HlI8EXSFfxit2ESR9qvS2w
         s8afLNUCDJHJ8bIcrimbG5LTMlDTLrRq3hm87tPxrdDKCKIq865eLOh2AVAe8OiWzczD
         yH/ktdFz0FJfJB0FFAhy7xGKTR0xvrXB805OQHzIXWc7kDbsNgm0iXs8a4l4OMJwh06C
         oLzJ99kUDgyh9068Tq8O2Zmnp6lq4M/9FQpshgHjzZl+9f5BCSzOB6mCX/Pd4M9Xn9uC
         EKjX8MWvEPuWykNkW7o8LwFBGm4DOq+tWTlYh8MslcIa/DQV+JdavtqoxJTHFVh2ESkM
         8I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764963624; x=1765568424;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+3QFrDdsEC6ia4rTVbK/1nejUfDjNZ//u0RhNdC+A8=;
        b=wZlXh6lWw7mMCOCVpivHEGYL7WRJgQkwHrUcJ+G7L1fPq1UJuxI5fPpbm7nCrTkFI7
         OkOXY2HFKF8YyZJSiK9y7/oOlXhHklrKBnsKqvMcm+Ruf/YFpJh2oK/G+Kfb4QX4h2vl
         bwbHcW7arTC/vzfccIZ3iBG+0f9YCNQrZbhviFandms0QzXqExELEz9w/8Hb6sPAY1S/
         WHnULsA8IJE4a/PqUrOVVvC18vgPCqpS/Aks2DPHvtXzDfWJMsdNcfUBpHSrRGE2A/pv
         Ttbot+9GnLGaXDdMPkEuE9VaL5HlP62OR5/yklFvvQOOosSbvh7/ohxdtOQlq/9UdB6c
         +F3w==
X-Forwarded-Encrypted: i=1; AJvYcCXvyHfr2KqG+D+QdYSerrxoNKTLDuRnoE5dxmzWD0cTLqR/V/H1uO/uVQ9w6CHF8jv4PoXev9AXlSXR3tbpHOhd@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCzsUnjHg7jtQzWxPnE8YuVu0++hzQ5D4/hnhdDQ5NzL/xNnd
	MVb6WXZ3P6foWSOPWZcBMefa0OQlY3257OLU6Z/6PVOTg7NVBDPq6odAI5wfIMKIackIts4jMP3
	spj1biwyTBdp5uPl3vl9LrtJ5zrh4XuYlk/S9IkZY
X-Gm-Gg: ASbGncvwM4Gk1LY2XX2FvYr9tUaRWfnm3R/8K8fXJ0bZ/XMHOarHpGzp8BYLxHDORJW
	Nl4AL/0SNK+TrukXOMx3C9XyiOW+A9cIbYgDdeAuMN3VqWbvfqTj+kA7tA3GjL5EdmSsT8BvVX9
	t0gqWbUdP7lWA45Dz1NOnso/fKdKeDb9oRGBc9x8NJkX0lUB16t2oC0o2Nz2G84UInSA9CvlqDA
	PUe8ftERSJmv/Xy3svCHp13mPw6MEaijj4+ynohEArB/BnOwkUhd6NOhx4RjkLXTmf67Pqd8yvB
	/S5k1BZXIVQ+g8/sYPc33VIx6uAqV/UDP2A3
X-Google-Smtp-Source: AGHT+IHghvBzIU6I30I6e7fclyovQDEVU64hwmrtS8kxoAgw2CsBfZP3OIddc8FefWUYFBDXCmQUgMQXnLYC2M4vxVk=
X-Received: by 2002:a17:902:e80f:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-29df498664cmr362075ad.2.1764963623489; Fri, 05 Dec 2025
 11:40:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com> <20251201205509.195451-11-irogers@google.com>
In-Reply-To: <20251201205509.195451-11-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Dec 2025 11:40:12 -0800
X-Gm-Features: AWmQ_bnuIPjRKJPUtWqZarpqqfaIFpeu2YMEJ4_WgEb9JFuvFuQjVkJDRCYAODk
Message-ID: <CAP-5=fWe-Aax42D_9goaX3e-QFpSQBagqWh6ZD+JgLkrMLSe8w@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] perf symbol: Fix ENOENT case for filename__read_build_id
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 12:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Some callers of filename__read_build_id assume the error value must be
> -1, fix by making them handle all < 0 values.
>
> If is_regular_file fails in filename__read_build_id then it could be
> the file is missing (ENOENT) and it would be wrong to return
> -EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
> reported if other errors with stat haven't occurred.
>
> Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regular f=
iles")

We might want to prioritize this fix.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-buildid-cache.c | 6 ++++--
>  tools/perf/util/symbol.c           | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buil=
did-cache.c
> index c98104481c8a..539e779e3268 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct dso *=
dso, int parm __maybe_unused)
>  {
>         char filename[PATH_MAX];
>         struct build_id bid =3D { .size =3D 0, };
> +       int err;
>
>         if (!dso__build_id_filename(dso, filename, sizeof(filename), fals=
e))
>                 return true;
>
> -       if (filename__read_build_id(filename, &bid) =3D=3D -1) {

This check here is clearly wrong when -EWOULDBLOCK is returned from
James' change.

> -               if (errno =3D=3D ENOENT)
> +       err =3D filename__read_build_id(filename, &bid);
> +       if (err < 0) {
> +               if (err =3D=3D -ENOENT)
>                         return false;
>
>                 pr_warning("Problems with %s file, consider removing it f=
rom the cache\n",
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 76dc5b70350a..f43e30019e21 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2008,8 +2008,9 @@ int filename__read_build_id(const char *filename, s=
truct build_id *bid)
>         if (!filename)
>                 return -EFAULT;
>
> +       errno =3D 0;
>         if (!is_regular_file(filename))
> -               return -EWOULDBLOCK;
> +               return errno =3D=3D 0 ? -EWOULDBLOCK : -errno;

I've made the fix after the other changes as it is simpler to fix in
one filename__read_build_id rather than all the libbfd, .. variants.
If we don't want the series in the short-term perhaps we still want to
carry some parts of this fix.

Thanks,
Ian

>
>         err =3D kmod_path__parse(&m, filename);
>         if (err)
> --
> 2.52.0.158.g65b55ccf14-goog
>
