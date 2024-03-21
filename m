Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5712BF15;
	Thu, 21 Mar 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036812; cv=none; b=nhTD6pwLJjWEcsjpQcQF9uhRNoMVH8NbSV9qGuOeIOo900QjgFLL/Zj7rICbrrooWkRER7b/3Bd4uxRJn+jlo7LTxs0kzhrLTi/TAljOCNTaWWCqiFKhAb3IN7BPOI7SczzW3LFybxMP+UTbIjZVnXKaYlGzNmlQeC+y8UUWfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036812; c=relaxed/simple;
	bh=jgszpCqH/WMZwNM8t5t78GNbQLJNqJmTX2YntToQXyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlBv2bHmNU/QaMQv6gjCOMgaMcqaxCVZyxl5No6reaKi380RUyt+vV251+G9ihH18HHm9ujii5sm2NSsDKUM9hAGbEVBV3PIos2vOA42xH2vDm2yESyAqJ2teqa2RPXv1LlqkRcTK/4OHMjJSV7wBfLpDEa/ruFQKI0VspLAzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsFba1ko; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsFba1ko"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cedfc32250so782169a12.0;
        Thu, 21 Mar 2024 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711036810; x=1711641610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JedxGpSetrtUkKTUasSUOChUtssLfFO66jso+nC0zqs=;
        b=BsFba1kovw/pv+FL+jItcWw2mIXxAd1qJcO2/OQhR8ewktw6UfI8bm9J/kGi8Y8jYZ
         P4QqBZawv5lOVC44tpraO+Xx/D159Ayr4fnDW66SLfE3cZc6xMIHWvHufmfHLoIwqp3P
         G9EeI5fLttRZ/o0trmTnl0qUwn1Mth3k/D2NoV9KFBB0j9iATjOPKxKtEg9JTP8KRsNN
         g9aOdq1iMNu1SYSk9wtIqZzjyE5TtDK6j7/mRwSzwnva7amiZ0ttMo6GmZi7OV0ygt94
         FGkZqgV0CfD6LPhy2d5DGhUehp+jvfpMAMqAbub3IswPcjNJTWs0rWb0onqOGOECwopR
         OO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036810; x=1711641610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JedxGpSetrtUkKTUasSUOChUtssLfFO66jso+nC0zqs=;
        b=C9JyLYQVlC9G8o7R6E3WXdjOY5qKmDjrSWHiNgrda7gvLlXXVgioURIV6YmCJWECXr
         VQM1N5pK6ZfRPgpvxH3E4oPQOn8hDPB7aQTMC7BKu8iD6xKcY18Y4vp884v8+iaibWrO
         QNMmlizYSq9v9GbRAQTitmQZQ8EQpbsFWlx4FoHW90uLW9adVvsTQFTrzVDO/wneWHV9
         tWli9mq9YFcpRJcHEfOO1wv/7gzcU94lZdCetC1fQK+C3A9iYOSnj9oO0Ojr4fUwXhUN
         23Lk6d5CwGStm+dH29Yqi/vDBHrZ1ZesqtB8hP9/hUrqaqyU0YpyibcZCWGTv9J9WaXA
         AmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsK2hHfVQF0GEBewxUUbU2rnWlJc899oePUU+vXJMI5+ZsoFS94+YRCjeT04y5yhUMg31pHQDeSUKnY5BY9Op+Rmr6bGab8h2kWTViZNXLyRehf32sQni/O/2DKTJPiNjFi15uFQ==
X-Gm-Message-State: AOJu0YyLV4flYgiiGwX1ym27SnHdoUa+q6tsb/FYFvqW9FnV2VXhsyxh
	APfUFg9vQunIduR2FecmEek4RKcVNjQQfRYmjsVE07Mhd8ITeNg3rKO9EvZrKNmbBi199Za31gX
	JaLPFumEyCyypKfix9WHftglrn6Q=
X-Google-Smtp-Source: AGHT+IGvhgHoR/H3/Joew5fwC9WdlIUAZfI4tSWvfbxz0Cmjw6rZcLp6DtCisk5HjPqv4qMcZGzipc9q3RGiyb9GEus=
X-Received: by 2002:a17:90a:17ed:b0:29b:c17c:5fa6 with SMTP id
 q100-20020a17090a17ed00b0029bc17c5fa6mr2263229pja.33.1711036809548; Thu, 21
 Mar 2024 09:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfxKeSF5e6mXpnrs@x1>
In-Reply-To: <ZfxKeSF5e6mXpnrs@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 08:59:57 -0700
Message-ID: <CAEf4BzY2iVCDPajdzNvJPfFHCjHiMb2eq7rk-rfKejhkD9v48A@mail.gmail.com>
Subject: Re: [PATCH 1/1] libbpf: Use (uintptr_t) for a u64 cast to a void
 pointer to fix build on 32-bit arches
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 8:16=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Noticed on several perf container builds:
>
>   perfbuilder@number:~$ grep -B1 -A2 "cast to pointer"  dm.log/*\:*
>   dm.log/ubuntu:18.04-x-arm-libbpf.c: In function 'bpf_object__create_map=
s':
>   dm.log/ubuntu:18.04-x-arm:libbpf.c:5355:24: error: cast to pointer from=
 integer of different size [-Werror=3Dint-to-pointer-cast]
>   dm.log/ubuntu:18.04-x-arm-     map->mmaped =3D mmap((void *)map->map_ex=
tra, bpf_map_mmap_sz(map),
>   dm.log/ubuntu:18.04-x-arm-                        ^
>   --
>   dm.log/ubuntu:18.04-x-powerpc-libbpf.c: In function 'bpf_object__create=
_maps':
>   dm.log/ubuntu:18.04-x-powerpc:libbpf.c:5355:24: error: cast to pointer =
from integer of different size [-Werror=3Dint-to-pointer-cast]
>   dm.log/ubuntu:18.04-x-powerpc-     map->mmaped =3D mmap((void *)map->ma=
p_extra, bpf_map_mmap_sz(map),
>   dm.log/ubuntu:18.04-x-powerpc-                        ^
>   --
>   dm.log/ubuntu:18.04-x-sh4-libbpf.c: In function 'bpf_object__create_map=
s':
>   dm.log/ubuntu:18.04-x-sh4:libbpf.c:5355:24: error: cast to pointer from=
 integer of different size [-Werror=3Dint-to-pointer-cast]
>   dm.log/ubuntu:18.04-x-sh4-     map->mmaped =3D mmap((void *)map->map_ex=
tra, bpf_map_mmap_sz(map),
>   dm.log/ubuntu:18.04-x-sh4-                        ^
>   perfbuilder@number:~$
>
> I think Namhyung mentioned as well on a chat conversation about noticing
> this on a 32-bit build on Debian.
>
> Fixes: 79ff13e99169ddb0 ("libbpf: Add support for bpf_arena.")
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

We've already landed a similar fix in the bpf tree, see [0].

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240319215143.1=
279312-1-andrii@kernel.org/


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index efab29b8935bd9f7..af0b0e24978558f8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -14,6 +14,7 @@
>  #define _GNU_SOURCE
>  #endif
>  #include <stdlib.h>
> +#include <stdint.h>
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <libgen.h>
> @@ -5352,7 +5353,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>                                         goto err_out;
>                         }
>                         if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA) {
> -                               map->mmaped =3D mmap((void *)map->map_ext=
ra, bpf_map_mmap_sz(map),
> +                               map->mmaped =3D mmap((void *)(uintptr_t)m=
ap->map_extra, bpf_map_mmap_sz(map),
>                                                    PROT_READ | PROT_WRITE=
,
>                                                    map->map_extra ? MAP_S=
HARED | MAP_FIXED : MAP_SHARED,
>                                                    map->fd, 0);
> --
> 2.44.0
