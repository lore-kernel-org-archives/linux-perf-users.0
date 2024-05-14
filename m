Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF15117EBB6
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701175; cv=none; b=BAlQzK2f7Mf8+tLfDCQMryHz8KyyD7W8AV3oOuBbgYts8RFQa9YBdefw4MsMBfuKflAuZ127K9qWKuA0p6kRhQnvNOqZh5AIqP06AeaKYkR5iApfnyQXcWJKkI5JSztOqh2QT3RkXWBwUSmKCQm7dzLhZFRNETtQefn2wSb74Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701175; c=relaxed/simple;
	bh=wPQNzP+a91MdWa0iSqIQy+ouXi9GvhZ2QK7RwkKxXjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ABgPPNDGqtunTDa8hJf5ki1NVUwQq2nSE4umeylwF3y2bZkhR/jaYI1HB2xQGJGsmdhN2IKrML7PI3HLp38kNXhKdJmTepVJzBTz88eble6lYsalGZ9roKIfRaYl0BFns1XZtrNidJsF1Mu4uygJ2jbXLF4UGANvPEUBhWePQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tb859D3h; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tb859D3h"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43e14f0bd75so394121cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715701172; x=1716305972; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMCjVuovCRRhsqJzS9OSQQK8JqKttyF9yzBankV6qIQ=;
        b=tb859D3hPAsQabIEeAmjrE0A+xpNNSpjhtnfvoGYoeGhZoXFkEwKRdTWGjRnvbINCV
         qG90Ocr1bBBNzbJGtF9/nWt699Z7WVcS10PnlNcJVNcNUnse93kieyyoSYjhxy8AzJaI
         6yxIffTe/6zTvPi82p5P4TmEhmw2U4/RrNS/0lRBqafuBzwMQ2gKzxgLdDsxhbUmXK5+
         EExW5wZl1xss6Iu9bWBpxqLn2IXOpts9Cn2UJJkUzLVBNiUDAIqHs7/y9YNT7/GxFdZu
         T08nrkiz6mcCwjR1/37M2H82ZLjc7O+K5kp7yeb+UBM9/vl7zvvk1lEtrVSBj2pNjHgH
         9ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715701172; x=1716305972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMCjVuovCRRhsqJzS9OSQQK8JqKttyF9yzBankV6qIQ=;
        b=R4FRJ5NHqYcqXWJBas4gfftW33noJ2/+PzQa+jcpfLYR6ui2epXWC2nbMn5UdHz2wH
         ghpKJNpTLJjb5cbnwbvlU0j1UJf5AnsYT8SiqMnP8ABQPJugE4MxD5SQd2P5D5tRQdR8
         z6WBEw/PzTYgJDjsYJFYYVj6J2K9IccWyx0NN3lNX+c81bgbMJvanAlAmunIScKETnjG
         XN6GEzwqK65qwKt+F+ze/4nJr51L424W5d4OuF3c3BfDtDSuCzAs7H7zoUYhAR5J/x+l
         58wwoGBuiBCdF67SHTn5HYnR/1j2z1YS8Sng0VIbyNFcB7AmkNvZsGiN0qWUMiE2/S11
         MPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgsxvYdruh6plGrIzKZVktEwbhnKUPJu75ZmwytL4sgARiWBlPXD2ydFa0II62SHV/VVU0hYkAQVGB/fu5X+lhyGGHw+3+TR0x/wu1NAjFRA==
X-Gm-Message-State: AOJu0YyzczicA+9vWUoIiuS3LBo3Kb08gaOqj4EdULBuC3dEf0igVCBY
	bNXFL/WMLYH5wfnCPRnmsL90dnwxUnRURJvucpUAXl6mUH39MM+2LNBKz+gszcEEDdu5bXUdE5L
	k77+MGK1ljFcWBGBXDC2Qzb7gBSNZHKwFTnT1
X-Google-Smtp-Source: AGHT+IGRiHrKQBjng6lRxwDWXwXv+NiWgwfQUej3AihZUjdkQkMx6PO1ulTbHW8n5o8KChINFcUfX6NEuDYWxi5Z6nc=
X-Received: by 2002:a05:622a:1e0b:b0:43a:e258:8fed with SMTP id
 d75a77b69052e-43e095453ffmr7359681cf.18.1715701171651; Tue, 14 May 2024
 08:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514052402.3031871-1-irogers@google.com>
In-Reply-To: <20240514052402.3031871-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 May 2024 08:39:20 -0700
Message-ID: <CAP-5=fUc8zFup-87JjDfX38GoRpPdPwTdtfsxPqKmqJr1aHWGw@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm-spe: Unaligned pointer work around
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linux.dev>, 
	James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Use get_unaligned_leXX instead of leXX_to_cpu to handle unaligned
> pointers. Such pointers occur with libFuzzer testing.
>
> A similar change for intel-pt was done in:
> https://lore.kernel.org/r/20231005190451.175568-6-adrian.hunter@intel.com
>
> Signed-off-by: Ian Rogers <irogers@google.com>

+Leo Yan +James Clark surprisingly missed by get_maintainer.pl.

Thanks,
Ian

> ---
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 23 ++++---------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tool=
s/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index a454c6737563..7bf607d0f6d8 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -10,24 +10,11 @@
>  #include <byteswap.h>
>  #include <linux/bitops.h>
>  #include <stdarg.h>
> +#include <linux/kernel.h>
> +#include <asm-generic/unaligned.h>
>
>  #include "arm-spe-pkt-decoder.h"
>
> -#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> -#define le16_to_cpu bswap_16
> -#define le32_to_cpu bswap_32
> -#define le64_to_cpu bswap_64
> -#define memcpy_le64(d, s, n) do { \
> -       memcpy((d), (s), (n));    \
> -       *(d) =3D le64_to_cpu(*(d)); \
> -} while (0)
> -#else
> -#define le16_to_cpu
> -#define le32_to_cpu
> -#define le64_to_cpu
> -#define memcpy_le64 memcpy
> -#endif
> -
>  static const char * const arm_spe_packet_name[] =3D {
>         [ARM_SPE_PAD]           =3D "PAD",
>         [ARM_SPE_END]           =3D "END",
> @@ -70,9 +57,9 @@ static int arm_spe_get_payload(const unsigned char *buf=
, size_t len,
>
>         switch (payload_len) {
>         case 1: packet->payload =3D *(uint8_t *)buf; break;
> -       case 2: packet->payload =3D le16_to_cpu(*(uint16_t *)buf); break;
> -       case 4: packet->payload =3D le32_to_cpu(*(uint32_t *)buf); break;
> -       case 8: packet->payload =3D le64_to_cpu(*(uint64_t *)buf); break;
> +       case 2: packet->payload =3D get_unaligned_le16(buf); break;
> +       case 4: packet->payload =3D get_unaligned_le32(buf); break;
> +       case 8: packet->payload =3D get_unaligned_le64(buf); break;
>         default: return ARM_SPE_BAD_PACKET;
>         }
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
