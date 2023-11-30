Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRwBHf/e"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FAD7F
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:23:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b35199f94so15005e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701368623; x=1701973423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dzWqt5ncHZST4wzgqFNCBg5DuH2RtK6Ow/4bVvt1ow=;
        b=fRwBHf/ehmbMzI+xp1Wgy5ut5j7hKvYuNH3M/m/x1RKdzT2glOcBRdAj0WLOeHZi9N
         OlzaK1+1nWJT63JXzj2EUTFVRE61rEySlk6vg0nmX7V2ljb9Zu2R7ueXET3vgz+iREc6
         9MDOpB55mbSUeGtFY5Z/TpDcghMqnDwVXM9ccpd3MXdk+8ar7qCkW2ef1SxK2/0MBy/u
         N4FXbv6fuL4N/V8La7QUjOoM300FUDWEpRGfxO4/eXjik1mnwTkOdgr2mpPx24+treRq
         PsU86/ibOkeYmQyJpMQDvcv/W4MMAL9IJZw3oQ2UuT8whhO4iFP/HbU5QYVO58UbCu1R
         PXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368623; x=1701973423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dzWqt5ncHZST4wzgqFNCBg5DuH2RtK6Ow/4bVvt1ow=;
        b=ZxtuOKRzfEgIO6tPC/dartRUrOEteQgDe7tTWy5GlxQ1wSLoxLx0AXS4PCl3nTYKtC
         utHCJnr1R5R3n4RZiz+I/3SQRLfU+WTkJ4YSwlSmbmq8+BPkvc3qCM3BdQIGy086J8Ci
         MalZYplzEpiIZGUYVBd/hvd3WlOtW0wHvkLYDMLoHDkL5cqLYD/K5m7zBpgTi/iNVy+V
         YDjjD1lM/+waGNtxLHKHagogegdPsKhRe4uPjv34fY+FxU7GFBnkNURIgOy0gJIStdrE
         Nn6vd4ms/r0kk0D161dNvHRkC5XnqWmZm3Eg4l9f7ujNhUuKgaKrdzvuUtW0pJ/lQnhf
         C6Xw==
X-Gm-Message-State: AOJu0YwXt3yrsKO/G+gk5GSIFFOzt73U6emidtLoBQs3p1MaCJn6zhRQ
	8i0iuTLrcjXOhBFK2ezcatL6Qwc6Rr9f3Vv/KA13Sw==
X-Google-Smtp-Source: AGHT+IGJ/dqFXLX14CP4bI3K+z+4pw6j0MP3GokxnGr9wksHIOdLtsmRecnShIRMY+T2S0kzSDmGyAYqFHVJ5xZk4hU=
X-Received: by 2002:a05:600c:a686:b0:40b:4355:a04b with SMTP id
 ip6-20020a05600ca68600b0040b4355a04bmr213498wmb.6.1701368622681; Thu, 30 Nov
 2023 10:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130135723.17562-1-chengen.du@canonical.com>
In-Reply-To: <20231130135723.17562-1-chengen.du@canonical.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Nov 2023 10:23:31 -0800
Message-ID: <CAP-5=fWGfaTwhJRHWUZgRwb4Z16C=zdWWjb8eeQB6PReEtw9Sw@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Parse NOTE segments until the build id is found
To: Chengen Du <chengen.du@canonical.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:57=E2=80=AFAM Chengen Du <chengen.du@canonical.co=
m> wrote:
>
> In the ELF file, multiple NOTE segments may exist.
> To locate the build id, the process shall persist
> in parsing NOTE segments until the build id is found.
>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>

Acked-by: Ian Rogers <irogers@google.com>

For this code to be run then libelf needs to be disabled, I guess this
is why the problem has existed, out of curiosity why not use libelf?
If you look at tools/perf/Makefile.config, disabling libelf disables
libbpf, which means a whole heap of perf tool features are going to be
missing for you.

It may also be possible to add:
Fixes b691f64360ec ("perf symbols: Implement poor man's ELF parser")

Thanks,
Ian

> ---
>  tools/perf/util/symbol-minimal.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index a81a14769bd1..1da8b713509c 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -159,9 +159,10 @@ int filename__read_build_id(const char *filename, st=
ruct build_id *bid)
>                                 goto out_free;
>
>                         ret =3D read_build_id(buf, buf_size, bid, need_sw=
ap);
> -                       if (ret =3D=3D 0)
> +                       if (ret =3D=3D 0) {
>                                 ret =3D bid->size;
> -                       break;
> +                               break;
> +                       }
>                 }
>         } else {
>                 Elf64_Ehdr ehdr;
> @@ -210,9 +211,10 @@ int filename__read_build_id(const char *filename, st=
ruct build_id *bid)
>                                 goto out_free;
>
>                         ret =3D read_build_id(buf, buf_size, bid, need_sw=
ap);
> -                       if (ret =3D=3D 0)
> +                       if (ret =3D=3D 0) {
>                                 ret =3D bid->size;
> -                       break;
> +                               break;
> +                       }
>                 }
>         }
>  out_free:
> --
> 2.40.1
>
