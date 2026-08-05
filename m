Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FD3D5661
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956313; cv=pass; b=G9IY94oJo41X6emvhVwlH57x9w/IuhWZDY3d2UPEMaeKnXj5lusJFa4769VKuISD6GEU7uh2smQydumUcIjD4RVcWSp5oCD0PpN5l1SMg4ACV0mjH49X6AaEgDMzq5oprO0sVRDn1llYVFPJdNuqxZrzwZU3rp0FyIxLS0HoPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956313; c=relaxed/simple;
	bh=3rpNT2bCyHAdqTDYDozDlAcvmALQ8RwOKVWfcxey87c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6UGezN99tj9R3JVHhBytplt5pC5RJd5hJ3Te1YjY1w0LzOO9ZQbPTyvxuH+gidN37BmaonPuxGKCyjpN72PotmQXTaK8YosVKrLk9q8ETJxvc48xYiEwEo/oexWX4Vp8BhLM6PE81yED9ZkPfk9iXkqfa/AgDQ5LM4973hCg+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1Vogv9r; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1Vogv9r"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c01c79467so51781cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 11:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956310; cv=none;
        d=google.com; s=arc-20260327;
        b=cIAj/bI+7k0kgQtnOkSGTM5VEAsQa3f+D744L+NoWjHYArrttbKrVKhMWH1dh7eEOM
         VWGEPGNNNSS1V5DU+VKyyqRNdREYhE7mJZLmcYHiNKXsRLxb2VwkT3Ksw2bGqQbRYIUJ
         Ph9/j9OAEdG8zcq39kbuRtHjOm0hCPT+WFMn4oOos/5dlE1KsNVoYuFGm7HwzzDLLoRR
         xVja0wpwcIXpMwUqcmKh87MrHrfZAOJdaEt4DttfhlgvpPY+242Wh+Ly1cR1mr3ME6NP
         ENzJQECcAmcff/1PUMimHEZDYGDtTFlq2F/4Fmdt0kWGvjeOUbeBZFDv8wDUk2DBK2Ku
         agzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4b985DtoLXI0QgsFYBfnSe6W1L24alcZJnRWdk9TLE=;
        fh=/u3uJ6CeTGr8ApY6f9yftgbm48LDUEoTWnzKU9F+5j8=;
        b=aOOtiZ3fKXhPhndxqSK+AruPTwIH8lI1W+yt2Ha4Qkkc9yIAc1OmzxheHzH7Nx4jYB
         yuTW2WX8QzMLvwWlmeWFA05bu3SYJBDOaoW84KUz9OJaA1bNGi3iCvpi7b9PVASEYSvK
         Fv2HoqzbVWVVwwhhiEuannHlkAVmjS5peM3jvZStn2/o2fsdX+SKttAw9Qi8TgGa6Y+G
         gjPRjcK89mYxbC7nlx6fcRh6gLkaMWp2++JUPfG4ZJF/X6vkEYkB4O4m9/jnMV6o/iFg
         OCXksaWaXifzSe0+6Yp0IHJPgFSMEk9jnBOYCpAnEroLpMMldSifBeZIQHDxPSAhoY1p
         6p/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785956310; x=1786561110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4b985DtoLXI0QgsFYBfnSe6W1L24alcZJnRWdk9TLE=;
        b=B1Vogv9rnviWcMWcZMkWhfwXugacjCyuwsAt0z6sTKvazAYecMmgjRYzDWJyMUNERg
         gV5AIBz1q4szHJ7hsBE6b51yp/Wg/nGt+A6SbpWayudBzYfyZ2dPrCw+iXqo2M/HNP89
         sg2DlUcGKORH1yHrPbEVKbDGAx75581fgU8fOgf68ZOSTrQOVlM18BVLJ2dWE2ofIGVW
         29q3GM61y1Z+FteD/J56AYprDKcoAlfagH+PhMvH8MnqjWZXf2sj5Ct2FemlPNPCyeS8
         DOsy0MfwywQVmdOxgmElOUisgtdtbG4QOb+E/FftgANg+hsYPeQWjDmm7ftp16IqkKud
         LSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956310; x=1786561110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4b985DtoLXI0QgsFYBfnSe6W1L24alcZJnRWdk9TLE=;
        b=EZW2xtxa7w+dnAIZLpGFcyAaH8VBwaGynY6edISbNK1r9kWr1ElGzM3f07+fsBkqcv
         CCi2UJiwhOu8u7MQSN80P7lKI2DEJz80BB4KH3XqpF4vkIolrcNH58sLOZOFr7nLOhfj
         dKDt/3sSSFw5tDQXjyybCgCn17yugumbWfbp115nOJmtiQxFiKOukaLOKe11mpSHOkZa
         Djiw30lz5i12dNVRV5oZrAGrb5n81PB4Y7HjV64S2jrvz25el4ufc3Qp2FI4sA0Va+hq
         3ELJ/bj0tZpfdHRPN36YNaBUhxxWOiBvXu+IT7Gqdu7PuwzZBy/xze5faDXPWMa5+veT
         7SKA==
X-Forwarded-Encrypted: i=1; AHgh+RqKXkD8HwHDMny3DE+97rquBtAjH72AMe9R1CqaPxpW2R/xVKfwXpVbjK0xdgJV0noFg1uNz9z4xtS8FPiXtH3Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3DwZdvk4ER08F+K+nlQY3/REeiXU2XIPMmUflYLyJ3ttmALJ
	IEK1U3jFKgzxHWMSysR9QSJXTSDLlQlsFFzusi5y8D2tRoj9/sWaQYCi52cRCrXVCmLrUMffU8s
	NgJda2HACrS8Q6BVOYWbEv5ER5TYpPz061itkCFdX
X-Gm-Gg: AR+sD13zzlFbAX72RRUKbfSxLH7IOyuJT1p3iAuDDFes4H44AobpzhVEdsg6YBj1e9t
	9vgXGihYF9rwXwDWxcTthF2UM4J2UP/6/ZUjCpNELz37FjRjak0T2o4RnOaOqcVt7NoKrGdZxpu
	wZosunY2MyRlmDjYWTEg/M/Beq+0O2RGgYquwfWBqvIqqoa5SDVB/dxp0p5hW/5FiMAFQxXapHw
	zRhGELCUzuhLR8/fX4Pjt/KCgo0CeH+YVHrPWxL98zBvGbOn0Qebvsj3dqI8fdY0Ao+paxh2rVx
	/nJjZaQYxvBl/RcC7IoR93H+EAqMUNGFVICsrCxloOxLfLwfse3Hr2Qy
X-Received: by 2002:a05:622a:1493:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52cfc0ad149mr2815371cf.3.1785956309887; Wed, 05 Aug 2026
 11:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-3-acme@kernel.org>
In-Reply-To: <20260805133013.235016-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 11:58:17 -0700
X-Gm-Features: AUfX_mwsFa9unwTEGVRPfYRQ8R1GG-Edz4H3WxcsUmue-ErlLcDBq1Qu_F-vMHc
Message-ID: <CAP-5=fVn_FEioEzuf6g3C9pQHLFSTVSXeHa1MUgNJRcHmAg+Rg@mail.gmail.com>
Subject: Re: [PATCH 02/12] perf jitdump: Validate code_size against total_size
 in code load
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_code_load() reads code_size from the jitdump record and uses
> it to compute a pointer to the code blob:
>
>   code =3D (unsigned long)jr + jr->load.p.total_size - csize;
>
> An oversized code_size underflows the pointer arithmetic, causing OOB
> reads into earlier heap memory.  Validate that code_size fits within the
> record (total_size - sizeof(jr->load)) before the pointer computation.
>
> code_size is uint64_t but csize is int; values above INT_MAX wrap
> negative when narrowed into csize, which defeats the bounds check and
> sends the code pointer past the end of the record.  Reject those too.
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Assisted-by: Opencode:mimo-v2.5-free
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/jitdump.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 4b7c7ba7cd95ddbb..3195f94187164066 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -9,6 +9,7 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> +#include <limits.h>

very minor nit: The header files are only partially ordered which
means we may accidentally double include header files later, etc. `git
clang-format` should be able to automatically clean this up.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  #include <byteswap.h>
>  #include <sys/stat.h>
>  #include <sys/mman.h>
> @@ -450,6 +451,16 @@ static int jit_repipe_code_load(struct jit_buf_desc =
*jd, union jr_entry *jr)
>         csize =3D jr->load.code_size;
>         usize =3D jd->unwinding_mapped_size;
>         addr  =3D jr->load.code_addr;
> +
> +       /* code blob lives at the end of the record, validate it fits */
> +       if (jr->load.p.total_size < sizeof(jr->load) ||
> +           jr->load.code_size > jr->load.p.total_size - sizeof(jr->load)=
 ||
> +           jr->load.code_size > INT_MAX) {
> +               pr_warning("jitdump: invalid code_size %" PRIu64 " (total=
_size=3D%u) in code_load record\n",
> +                          (uint64_t)jr->load.code_size, jr->load.p.total=
_size);
> +               return -1;
> +       }
> +
>         sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
>         code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
>         count =3D jr->load.code_index;
> --
> 2.55.0
>
