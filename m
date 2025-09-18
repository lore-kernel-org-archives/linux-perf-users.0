Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA699227B83
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188046; cv=none; b=dVorO1nRYJhde897Ai4ozcspRlKKglbwIuqNYwqfLj/laEuCeSLHuMgtqKFHDcEdY5vbgxqBGGheKC4nQy8TiLwo/B6LZHo7RUeHtdSQt5G6W/GLoHzuXvvuHZZ5WvWOGoEK3W+FAWln518Lyqn4N6yHkpE/R20ReUm5kr6W8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188046; c=relaxed/simple;
	bh=F+7UwolL+d5M3u3SJQMdS/JoH4KAhipm+vZbdTiVTtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYlMuJduWgJM5xdXdjwBfdzv2DQBUh5w40LmCSUT7KbIUwcBb06uyvhbpmw7p322EsBKJGcKpnUn2wtiArNhyIkAfOYZNFjk1at0rNwHrFrM0tA+BIBl4lfmb01vn38gS0Melt9LQ+XjmfPB9mfwKb01vA3/ufUUChCnPIZpbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7639af4c4acso9306606d6.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 02:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188044; x=1758792844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thwzdmTgqO/aYIbO/EaYexBbO6rJAeT6rezea+eeFXA=;
        b=IH+P7WC4bqC7tNzsvSezOC00h/6BJ3zJ6CX4baPJ8qgU84SDGsySnee35bFXQMXHry
         R+bXu4P2s8twfaH/4KjWMVmWTw2bItjJsYdkMuyv3NyTMUf6KRMtLdF5GK4yTiUTOTkN
         UkCHpuz9fFom3so9KOH061uJmAFuDUdnv91GkYh7324dNvzwJ0x//bR+knhfDyqCLsoA
         p47mM56gBsgwWSOsmH+05IA+S/9BHTTSNOTkQQzsQTfrlA4jU1yRr5NcT0eKsrju9mdi
         y2NJYp6fm3B5LmIL/VDFpvmzr+S6PKJtvfLxXGb7pYBAknpCxjrR2S/3FdNLAAYuypne
         74dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIhdqEoiPlotKUCRVzumLnFsZsWq/Nt3er9xVVhT32+yhlUk7nYzzOnSrtDqueG6Ia0AH9e4nZvmkHIL2eAACa@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVGVWxJ0uqIMumyOJ6k4qs4IGEt1gK+SYKJTQ1zYld2yiZkJK
	zSlHfYORfS6evzDiWGXH/pDvl2Nuwg8AdqzLjXlZu3ZqGdEYwoM1NjC3lOjUU1ll
X-Gm-Gg: ASbGncvZ9X7dY4b2gTZN71a7IVipYcA8zXUmcyFp1a1D1wwaLMIKo1s5c8WR9VTYIvv
	FuvLeGD+qpx7PgkNPBzBePIpfFZ/n2E945rnTsROUZ63sRdBGr6je0X9HvqV8qE5XoslLnv9brM
	DF+yobDVryMpY9U1kJOdGuJxdrAkRmkHE3MqeZNFX+mPAVFiVkLJweYRcT3cJLpYBFfx/WbMvsj
	5PSKw3zbvjral7dFxKmcnOqt82S4CpJQR1ENd11pI0OtYLbjFj01JA4alGZN5IGZjB8Oo2OKBn1
	UjBIFs3unVA39q7V789njdnNlL2+xImpAtKmp6trhKJcvQ8AJ+2IEuXq4H4zuz2j07VwkisCf9J
	07iz5TjtUI4TQdxA+S5i+/s9AxUjI3tvGCbmbg7jHX4BaAsVKe3/qAApCcZAFxqUWRYB0zCNhWF
	BUxec69Xs=
X-Google-Smtp-Source: AGHT+IGt8oifhph8cJNcBhgj/o/NsH9wZVF7N8ADDLmwp/pCV7CO91sHrYvbG0HXzTfR9iRL1lEM+A==
X-Received: by 2002:a05:6214:4885:b0:791:34a5:868f with SMTP id 6a1803df08f44-79134a587fcmr35174756d6.20.1758188043440;
        Thu, 18 Sep 2025 02:34:03 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79355ce7048sm10524916d6.69.2025.09.18.02.34.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:34:03 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-80e3612e1a7so126832985a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 02:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7KYqdRenXwv85QW3HsQJhuong6nIPOPVc7sx6tuBz6FlRqon1eDa/9KdfECUIIXmiR8KdW7IUCD5J/VwVenV9@vger.kernel.org
X-Received: by 2002:a05:6102:80a6:b0:51e:92cc:6e6a with SMTP id
 ada2fe7eead31-56d6d57bf75mr1452834137.33.1758187611708; Thu, 18 Sep 2025
 02:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ms6snut0.wl-kuninori.morimoto.gx@renesas.com> <87jz1wnunm.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87jz1wnunm.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 11:26:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfhMKrdnQCjf_Z90EnH_gb-RpdxPiVUjEe3C5ZyuTfUw@mail.gmail.com>
X-Gm-Features: AS18NWDTdMprA4ImYjVf-zjtYmKdsmDO9RIvez5aKcVZCW3WJ100X4TbNjepaRg
Message-ID: <CAMuHMdVfhMKrdnQCjf_Z90EnH_gb-RpdxPiVUjEe3C5ZyuTfUw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: serial: sh-sci: don't required "power-domain"
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

On Thu, 18 Sept 2025 at 08:26, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> {H}SCIF is in the always-on power area. "power-domain" property is not
> mandatory. Remove it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> I'm not sure this is acceptable patch. This is optional patch.

(H)SCIF is indeed part of the always-on power area.  However, like
for many other modules, its power management is handled similarly
through a clock/module controller.  Hence it falls under the PM Domain
abstraction, and the power-domains property is justified.

What this power-domains property will point to on R-ar X5H is a
different question, as there are no DT bindings and no driver for the
clock/module controller yet...

> --- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
> @@ -116,7 +116,6 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> -  - power-domains
>
>  if:
>    properties:

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -168,7 +168,6 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> -  - power-domains
>
>  allOf:
>    - $ref: serial.yaml#

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
