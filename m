Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEqQUT45"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA1197
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 09:57:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b35199f94so5865e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701367055; x=1701971855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iibl1Xbm3GB8W/wJpqz8MDirHOnwc3sWdRrSTTEFiCY=;
        b=IEqQUT45g2vV8C4ZcEI5BQ0dHUqzhfWW6LcbWdGmcLiA3WgOtSKUfwmCI5nwZpZAIs
         82QQs3MaG4O8hI40EO6zXmSegLKF1QdiVO2jhx8Yeaxr2TcL9kdEIk/JDlgeetvVvgT6
         hDLd6gD42lq040PYpYyiingWCnzTFGy8C94BTaqOQ35V3Br7SvIjvt3FAIIOEzyagEYE
         GJOksbEbHWlO5vPb/qcfLC2vaPlHQMv4dagbR5cOAy+ivxcHz0ht4zs3aaPP5TT2IZsX
         ZfAGtCs4QvYeXzMR49VuQIkNwb1iq+wyG2r3ckmgIbhpaI3cf3Mx27U2kdssrxUHwYuJ
         ry9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367055; x=1701971855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iibl1Xbm3GB8W/wJpqz8MDirHOnwc3sWdRrSTTEFiCY=;
        b=kVj9Hqv0YlkvQ9Wz6KK7Nchm8vgFBFQZhnX3Kchlin3x4EuhyZZa5uuIHMN3DM90pr
         FmTExpI5MN/1v1WRlGGcl7J6vKPx4UfoAUvEyuAXRkY9u4hlr0PIlQPJav4zzVCtAqGX
         SbPjaIadw1nOmjgj361ulY+XF4bs9qDAHL+cHScSabHM9WgxD0xE9utZ9uJ7jcgh0ANN
         NcVzmMMWOgbFdpXhy2lXtQZ4nC+SGC/NtvUq2OSMvs0kmnlBFJWzIlxabUe/+4/gdhHm
         haSbLCWnFnz0/P+qzTR6YXpLmbhZbTvS9TGtI3DjVTXt0HkzoJ10sh+auRxD24GL5zRi
         Pxgw==
X-Gm-Message-State: AOJu0YzivmbkfEKA+RqtdrCiiUcwbQ4YliBTdPB3zkTCWoiYFkOTqlFA
	hW/nX0jvuPCE/lh45lX/z6mCi7s/omKg26PZMSJSsA==
X-Google-Smtp-Source: AGHT+IEpGD0t7I0UEuDM+s1ijAIH0PtY0u4nBUtoBBjhJ+joazqMED3bm0OchkfEGpizhKskl6P3GzHGSmXuKcad5eM=
X-Received: by 2002:a05:600c:1d10:b0:40b:2979:9cc2 with SMTP id
 l16-20020a05600c1d1000b0040b29799cc2mr159073wms.1.1701367054801; Thu, 30 Nov
 2023 09:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWjDPL+IzPPsuC3X@kernel.org>
In-Reply-To: <ZWjDPL+IzPPsuC3X@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Nov 2023 09:57:23 -0800
Message-ID: <CAP-5=fUkUnaGkdPoUWCQBWkTKdWX5KXs7drR34x1bUW6JRJY-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] libapi: Add missing linux/types.h header to get the
 __u64 type on io.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 9:15=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> There are functions using __u64, so we need to have the linux/types.h
> header otherwise we'll break when its not included before api/io.h.
>
> Fixes: e95770af4c4a280f ("tools api: Add a lightweight buffered reading a=
pi")
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/api/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index a77b74c5fb655a8c..2a7fe9758813172d 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -12,6 +12,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <linux/types.h>
>
>  struct io {
>         /* File descriptor being read/ */
> --
> 2.41.0
>
