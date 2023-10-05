Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40330CEC
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikWAsPEm"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287905AE12
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 08:48:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50302e8fca8so6147e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Oct 2023 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696520937; x=1697125737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab1RWq/q/7xQ1yVOIIQTt0NzzLhBI+PnkiYu9FpqEBk=;
        b=ikWAsPEmJOKqFxewntwjtRFelMFr/pZ12c7WhFLQJ5AYWxNI8Asc8tdQDyRePz89Dq
         k5dCK2KsqNtQ+tqHcCZ5wHaoerX6GN2evBFgWaxKPd7IX9jwWcq9f7S1eIeJWE7tgeyl
         Njzf3K46r+PEcKkTuNxhcFHQ8zwi6QQdVKG34jZqj2nPqwzuKuQp2PsR5/FyV9bVv7Oy
         d1cdk84X2hizgALPdSwJ94jwKJcb1esKfIMTN81kTkQ8MrhkUT4w0fLakzwp7HNqfJR9
         hhKjQNqYOY1e0eruljFZM4OO+2u+GYUZED9xzYJApAeGlpaEMS/ELE5U99459Ybex2Vs
         eKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520937; x=1697125737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab1RWq/q/7xQ1yVOIIQTt0NzzLhBI+PnkiYu9FpqEBk=;
        b=lC3Qi5L3jpArT+3dcHZGafl2NAarkU1veiDu56jq7mfUJyzVaxtDqfeAk3KpQ7Ua/P
         jGB2PoO86xeDUAgM2TPaifcDjb4guFKhEStrC7xQdaW96PdSz3QfOI97UNdMo7MXk6Q+
         x5cfw7e77chy/8f9sGtmvDMZ5XxIwHCufBS5bMGjl0QVkgWkMa4UTPb0zloEE5rv6WNo
         niV5E30+WUIL4th2gLYOfwzyADbewelAY1FJRXUTi/5bDwEW89ViMqOCWuGeD49K07+W
         mptEht7Ow1u9+1pO4D9giC2Y6h8am32h1UUCt05EBzTEraou98hhWutr3cF8PvwaJqJr
         ZfZA==
X-Gm-Message-State: AOJu0YxKZzgjB7qq1uGWBbrrD7Sps7zN4xFyAFAp7XXNgO+uiT0m6Sk4
	pa2s7IwY2jX2TNiTw7pYscdQ0KyHAva9ZaOCwLu0mQ==
X-Google-Smtp-Source: AGHT+IEmFE+eKJnuJ392XM3ijGiCa2XIbRjoIRqIvupPrfDAv3/4Na3XeSYkQYUkT1mGSqM50W0hMadkhuSHUVSQNg8=
X-Received: by 2002:ac2:42d1:0:b0:502:932e:2e36 with SMTP id
 n17-20020ac242d1000000b00502932e2e36mr49426lfl.2.1696520937110; Thu, 05 Oct
 2023 08:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com>
In-Reply-To: <20231002221909.2958708-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Oct 2023 08:48:45 -0700
Message-ID: <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> The byte aligned buffer is cast to large types and dereferenced
> causing misaligned pointer warnings from undefined behavior sanitizer.
> Fix the alignment issues with memcpy which may require the
> introduction of temporaries.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

This is a relatively small change that fixes building with
-fsanitize=3Dalignment -fsanitize-undefined-trap-on-error. Adrian, as
this is Intel-PT could you take a look?

Thanks,
Ian

>  .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/to=
ols/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> index af9710622a1f..28659874d84e 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> @@ -83,7 +83,7 @@ static int intel_pt_get_long_tnt(const unsigned char *b=
uf, size_t len,
>         if (len < 8)
>                 return INTEL_PT_NEED_MORE_BYTES;
>
> -       payload =3D le64_to_cpu(*(uint64_t *)buf);
> +       memcpy_le64(&payload, buf, sizeof(payload));
>
>         for (count =3D 47; count; count--) {
>                 if (payload & BIT63)
> @@ -220,6 +220,8 @@ static int intel_pt_get_3byte(const unsigned char *bu=
f, size_t len,
>  static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
>                                 struct intel_pt_pkt *packet)
>  {
> +       uint32_t tmp;
> +
>         packet->count =3D (buf[1] >> 5) & 0x3;
>         packet->type =3D buf[1] & BIT(7) ? INTEL_PT_PTWRITE_IP :
>                                          INTEL_PT_PTWRITE;
> @@ -228,12 +230,13 @@ static int intel_pt_get_ptwrite(const unsigned char=
 *buf, size_t len,
>         case 0:
>                 if (len < 6)
>                         return INTEL_PT_NEED_MORE_BYTES;
> -               packet->payload =3D le32_to_cpu(*(uint32_t *)(buf + 2));
> +               memcpy(&tmp, buf + 2, sizeof(tmp));
> +               packet->payload =3D le32_to_cpu(tmp);
>                 return 6;
>         case 1:
>                 if (len < 10)
>                         return INTEL_PT_NEED_MORE_BYTES;
> -               packet->payload =3D le64_to_cpu(*(uint64_t *)(buf + 2));
> +               memcpy_le64(&packet->payload, buf + 2, sizeof(packet->pay=
load));
>                 return 10;
>         default:
>                 return INTEL_PT_BAD_PACKET;
> @@ -258,7 +261,7 @@ static int intel_pt_get_mwait(const unsigned char *bu=
f, size_t len,
>         if (len < 10)
>                 return INTEL_PT_NEED_MORE_BYTES;
>         packet->type =3D INTEL_PT_MWAIT;
> -       packet->payload =3D le64_to_cpu(*(uint64_t *)(buf + 2));
> +       memcpy_le64(&packet->payload, buf + 2, sizeof(packet->payload));
>         return 10;
>  }
>
> @@ -454,6 +457,8 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type typ=
e, unsigned int byte,
>                            struct intel_pt_pkt *packet)
>  {
>         int ip_len;
> +       uint16_t tmp16;
> +       uint32_t tmp32;
>
>         packet->count =3D byte >> 5;
>
> @@ -465,13 +470,15 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type t=
ype, unsigned int byte,
>                 if (len < 3)
>                         return INTEL_PT_NEED_MORE_BYTES;
>                 ip_len =3D 2;
> -               packet->payload =3D le16_to_cpu(*(uint16_t *)(buf + 1));
> +               memcpy(&tmp16, buf + 1, sizeof(tmp16));
> +               packet->payload =3D le16_to_cpu(tmp16);
>                 break;
>         case 2:
>                 if (len < 5)
>                         return INTEL_PT_NEED_MORE_BYTES;
>                 ip_len =3D 4;
> -               packet->payload =3D le32_to_cpu(*(uint32_t *)(buf + 1));
> +               memcpy(&tmp32, buf + 1, sizeof(tmp32));
> +               packet->payload =3D le32_to_cpu(tmp32);
>                 break;
>         case 3:
>         case 4:
> @@ -484,7 +491,7 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type typ=
e, unsigned int byte,
>                 if (len < 9)
>                         return INTEL_PT_NEED_MORE_BYTES;
>                 ip_len =3D 8;
> -               packet->payload =3D le64_to_cpu(*(uint64_t *)(buf + 1));
> +               memcpy_le64(&packet->payload, buf + 1, sizeof(packet->pay=
load));
>                 break;
>         default:
>                 return INTEL_PT_BAD_PACKET;
> --
> 2.42.0.582.g8ccd20d70d-goog
>
