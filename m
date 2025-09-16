Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261F283FD8
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018097; cv=none; b=n+zvx0tv6+z8N2d1NjMgwU2rJY3Of9rayiBwRqGu/yrWKKBCXS93VZFdBiNw/0aZtgNY3SF1P3iU02Hcf/eCZCNqt3WApXb7m40jYouXqEISKAbF4Yln40w1rToI+pzXMIEVTu8Pg1zBjpC5+J7gM6FVMIMoR02/sR29rmBII+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018097; c=relaxed/simple;
	bh=M5TSTKdOE7KOvxaTBZ6x7dRz7TvGD4id6ZsQA8rgfRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcOu5s+ua4JVsJY5Z7I0tuHj0Qj1K0IIIwXBxQlceuZCp0L/G8sTHWQzOHA/xk5zour5sSmdvSN2+rZ0yj0YwOEtOPxx46pRmYI1W0gJB9GMoMkUalWEKVXhSOpnBWsqIREDrQTxB7ltZKMy4FMW9AD8HLmwKp+crjuZu7WQQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89a89313bb7so1685019241.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 03:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018094; x=1758622894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1FWUIy12ESADGq4B/o282N3x/QgWaUFK1UozSJnDAM=;
        b=TGIRr9YxkUZl3gkt7ODqagctJv6us6yzEhHarKasxkmpt72JeJZ2TBHPL8kMthwNOP
         YrRcYefgz7xMFoqQPLcV/mTh95cc2sDO6PlOuoG9/hKdtFNky94XYMd19a9pLi4Z0Ar4
         Nbdc3ZJcVkpDyUeDeX8e4grhPpaXru84YUkrX0LLgXGjn11KcNKjmb5vwlbGc/sw7oOe
         AKJNCaFBOx1Xg4lWyXInxqAXoLl4Llm6NfTyHN97VFHy+xr5ms8aY/z++VdMG7Z2KL91
         jH+9VhTu3MJsbYMW10LnOzbi0mshWAkIFvdwVtmJplxajoQ1HqIuZR4MDZJ63PcDIALn
         3Afg==
X-Forwarded-Encrypted: i=1; AJvYcCXkj1xuMAfdM/P81cuWMz6/0RKDCEAPdxuTmlmc29PCzigiHt/LsOQ5KulRfgpP/0aHXdiV16A57p2T9EtoMFBn@vger.kernel.org
X-Gm-Message-State: AOJu0YzRN+oQhWwkiAyPcvPsJkJGrMoHxEZ0pVgmpXKcTNT7Nyu1XhUM
	xaUysYQjqmLsPPyOnMbOUzZTGSX0NmiYbWiUCD2Zx2gGzdHN9pDhQswlOK1oKDmS
X-Gm-Gg: ASbGnctAXhbKeiYYx/tE5UPp24br73IBeSZBlnundqmj959d/PDngGisDClkAGAdaM5
	DW0qGhFmsF5Ve48dEys1bAaXr82/YBsACJzKVfG/Qm7DKtZ77ce4M2/KQkklgi0VgstAJ/fAEEB
	WzCf+ZMPPZJYrKSleZob18BAUpYM55KT727hP7fb/hknmXdQwTBi/YipA+Aeh63+XRFTxl8QWdL
	Eg0O5GFQo7J2Dxj4wbDfKBiZbH5VeeOLdzUGpMW8zvq8ugiHjPDa2mwwFh7la/evSxsOHMuDq1k
	6vHE25nbMhs+yGQ3XOeUyDkvpApitEVHS62gfLssG6hkuhPGdDjKRZLfqpd8sPassYNfFTrmZf7
	ja5rIHO0PmQY3fQesQBp1cqkIWC6Dly3d9soS6gL7+A93QpzEXrt/dhk19Y43Cj+EDH2F9ts=
X-Google-Smtp-Source: AGHT+IFE5KedVb0gydHuqWxDHOgxEEQ+HS86xDlVMqV/q9jKqW2qCVktp1jRVvxHpxVoynhbIS4q8Q==
X-Received: by 2002:a05:6102:808f:b0:529:4887:9f05 with SMTP id ada2fe7eead31-5560fd2fd89mr5488763137.27.1758018094036;
        Tue, 16 Sep 2025 03:21:34 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5537062c9c5sm3478871137.5.2025.09.16.03.21.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:21:33 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52e231e3d48so1937242137.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 03:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu/byXehGoPO2UwNAr57by7HaSkomHLV6JvNvXirD5e57NiyNBpZ1u9mZIrGWtZM8YIKnBZJ7YR+vzFCKHu/wo@vger.kernel.org
X-Received: by 2002:a05:6102:3ec6:b0:529:ee6c:6760 with SMTP id
 ada2fe7eead31-556091886d7mr5576842137.7.1758018092612; Tue, 16 Sep 2025
 03:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt13i0lh.wl-kuninori.morimoto.gx@renesas.com> <87o6rbi0jy.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o6rbi0jy.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 12:21:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKhw3t6oJhWrdFCkpaXKL5EXxBAPtqiYSDPv5aDNiFkA@mail.gmail.com>
X-Gm-Features: AS18NWA-CCVGKbHBzPrL9HA4tPoq9LGRxBm1encbDpHU-DmGUfLkgrDyZx8KuHI
Message-ID: <CAMuHMdVKhw3t6oJhWrdFCkpaXKL5EXxBAPtqiYSDPv5aDNiFkA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: arm: cpus: Add Cortex-A720AE
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ian Rogers <irogers@google.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Leo Yan <leo.yan@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Namhyung Kim <namhyung@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Will Deacon <will@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Tue, 16 Sept 2025 at 04:38, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Renesas R-Car Gen5 X5H uses Cortex-A720AE. Add compatibility for it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -148,6 +148,7 @@ properties:
>        - arm,cortex-a710
>        - arm,cortex-a715
>        - arm,cortex-a720
> +      - arm,cortex-a720ae
>        - arm,cortex-a725
>        - arm,cortex-m0
>        - arm,cortex-m0+

Already added in commit 0f356eb097c31471 ("dt-bindings: arm:
Add Cortex-A320/A520AE/A720AE cores and PMU") in dt-rh/for-next
(next-20250905 and later).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
