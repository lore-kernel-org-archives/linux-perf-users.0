Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D813328D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206459; cv=none; b=Bquc61pYn77wzXoHIEB9oYMK0ieaVV+h6ptQ8WGfKQfGRsW0hrkMal4SBfVFTTwKt4Sb3YZEoDdQwtC7O8DkqGOX0nqVl5il1Y/rP0ni6N0w0be22lS0JmQGKTfkqe5E8hvDA68q7gDjPaf6XIUAKgq/t/l+KiQJcK3y4AWgeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206459; c=relaxed/simple;
	bh=SY3te0gY8EpEl5E689hBYo4WycQ2ACiXqT0tWFK/u1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4nANh1RcXeQPpZsXLFdW5mSx+rzqadSIhPd5rPvr66vbFc/QgTdJ8Xdr1OqkHwHzlIsIRx9PFitymzvvXO7L3xqzfvZT8+wv3Jk4uq3ogVd/IXzcij+E2MEEXDGg+scecXQ8HVvtZiYoRaZOcEAPLW1RD98VIwMwoVLlOs7bpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1nk+o4U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1nk+o4U"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso52355ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715206458; x=1715811258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+C4NWbW6e+o3FY/4yD/C5aK+kcXnZU1WPZD0Mhpw68=;
        b=r1nk+o4USVy9oe7yUEF6LlzevnLOp8MzdIkrR/q+L8o8K8uWeZU2AJsD85nb3Xx8xP
         hGmiV8KK8o/hyHQ70H08KzA+1YabNpBZmSG38rqnPcYIegz7228OxdiRMC2rTe4pscpk
         RfD1OsdTGAPcybkNB1E0TYtG6CFv392Rpz1JmED0QiTSf9KUl0IXOD4/FYBM9A5dNrBb
         X/yrK51O5ZPr/h1iv8tWJja0k1FilkPhxeh0k3iwmzQSD++MoaM4vH3SIryaOHQcc4TV
         SsFzA4HXKMvDREco0JIZYNDqyxUHwTh7CfYfZfAcxkmir+kp2suDY55+dkB2vD6OCx6f
         GkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206458; x=1715811258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+C4NWbW6e+o3FY/4yD/C5aK+kcXnZU1WPZD0Mhpw68=;
        b=PVedBWUcPRq7Jw0sqkb9poNK3bp+KqCN1J0YxI7IqCYn3BSBt8uIPK6wVeHiAmoNAp
         5TaPMGn3S8n2Xu0NKFTKdFgok64fp5hrbYi3kHLM++Mm7NZ/wqlkaUF9H4ecJ6+VuONu
         HcX+ebGwCbVg5bKwnZD68KSGcXsOyDtvZm5C+HZ5XGKvDoYY2pROHlurO9ghAQb9BODO
         nr6m7z1P9Noclr6xAQ1S++4OayncLaI2UChHAHZshks9WOhjBZS5HTZ3yAJSEZZ2hxN0
         u3JjTiy2MDLjugsIX6EC1sxfJpK6Ty6YZH4v1rWIQH8iwXCW2IK6pVIZAtpI18qzsVWD
         wOCg==
X-Gm-Message-State: AOJu0Yy+3injr2SQn8GwiDy9qB+GBh7bOrDUjA2aAnIlB62T9xgKkNjc
	pY0l8ITjv8ETRmtV47PBdOG2lfdwz1y5DwnkDnRLFDYv+sPlQE3YmkR4tLgJ7CZuCuH2LopTvI3
	5EaqvPsImE1Wo0F3E827PCQ+R1js1xtYvqYj1
X-Google-Smtp-Source: AGHT+IFp8koGJ5z9B2iYuRA1SjLPqE1fjH610M4HsbYYGGiU8xRXw3/oOjPyK1aeZTnnxlfQV4bGyWTVncicCz94LjI=
X-Received: by 2002:a17:903:22cc:b0:1ea:963e:2e2d with SMTP id
 d9443c01a7336-1ef01244e57mr775635ad.24.1715206457473; Wed, 08 May 2024
 15:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507141210.195939-1-james.clark@arm.com> <20240507141210.195939-5-james.clark@arm.com>
In-Reply-To: <20240507141210.195939-5-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 15:14:06 -0700
Message-ID: <CAP-5=fWJCfz6VPRC+A4pcsGYVBTv_ANis6kxByELVRiOWsPhxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf symbols: Fix ownership of string in dso__load_vmlinux()
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:13=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> The linked commit updated dso__load_vmlinux() to call
> dso__set_long_name() before loading the symbols. Loading the symbols may
> not succeed but dso__set_long_name() takes ownership of the string. The
> two callers of this function free the string themselves on failure
> cases, resulting in the following error:
>
>   $ perf record -- ls
>   $ perf report
>
>   free(): double free detected in tcache 2
>
> Fix it by always taking ownership of the string, even on failure. This
> means the string is either freed at the very first early exit condition,
> or later when the dso is deleted or the long name is replaced. Now no
> special return value is needed to signify that the caller needs to
> free the string.
>
> Fixes: e59fea47f83e ("perf symbols: Fix DSO kernel load and symbol proces=
s to correctly map DSO to its long_name, type and adjust_symbols")
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index e98dfe766da3..6a0900dcdfd3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1977,6 +1977,10 @@ int dso__load(struct dso *dso, struct map *map)
>         return ret;
>  }
>
> +/*
> + * Always takes ownership of vmlinux when vmlinux_allocated =3D=3D true,=
 even if
> + * it returns an error.
> + */
>  int dso__load_vmlinux(struct dso *dso, struct map *map,
>                       const char *vmlinux, bool vmlinux_allocated)
>  {
> @@ -1995,8 +1999,11 @@ int dso__load_vmlinux(struct dso *dso, struct map =
*map,
>         else
>                 symtab_type =3D DSO_BINARY_TYPE__VMLINUX;
>
> -       if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
> +       if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type)) {
> +               if (vmlinux_allocated)
> +                       free((char *) vmlinux);
>                 return -1;
> +       }
>
>         /*
>          * dso__load_sym() may copy 'dso' which will result in the copies=
 having
> @@ -2039,7 +2046,6 @@ int dso__load_vmlinux_path(struct dso *dso, struct =
map *map)
>                 err =3D dso__load_vmlinux(dso, map, filename, true);
>                 if (err > 0)
>                         goto out;
> -               free(filename);
>         }
>  out:
>         return err;
> @@ -2191,7 +2197,6 @@ static int dso__load_kernel_sym(struct dso *dso, st=
ruct map *map)
>                 err =3D dso__load_vmlinux(dso, map, filename, true);
>                 if (err > 0)
>                         return err;
> -               free(filename);
>         }
>
>         if (!symbol_conf.ignore_vmlinux && vmlinux_path !=3D NULL) {
> --
> 2.34.1
>
