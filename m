Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F42C11EC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018388; cv=none; b=MD0iV8xlZmYZIAGxq2BnmJrsCHve6TI3vIUJJosfWLJ/Dmbg+5+Ag33vojirkLoFiBjuj9lMV6TqXASBRr2vObD84iIp9Eyxzc7YXnfSBovve6v9JGXG0+vob4159ooWRG2LgmDEvM+iVWggT8kbe+4MFk6y7HwX7rUvGUmmb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018388; c=relaxed/simple;
	bh=2ok48w1w7KOUXd9zly8s4KVnQwWsqmEcAwqHID6jWeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxmU4Mk4BD//jRoDCpFvU8amfRZ6qPzq21wWmv41biW8qS176adrBByomesbv61UxTrptlX2vXvyleEtwnH+iu6CTJpbqaAkWD2RaHtwrmMLFD7jldZ6wbLfLMMKO7h9QDf5+b7qqxAQDBaX4f96UymHqOIpwk2TP3vhbiGRdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-423fc1532bdso36659005ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 03:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018386; x=1758623186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR3Y4U+9jEsROKJfJw59rI/EkalzjoLUt+5BWaKi6Y8=;
        b=CbyyFeFosVHpDnOf2VfRjkx9YfWjtwjVLCsmtE5fMJW6pDOECIdUO68Gx90forNPvw
         2RkLBsQZkWQpblEZanooS40S4cBqN1+PCLG5aapBtavbMY7YWausgQyztjLO6Lp0zCRj
         LPOL66qgEohpQL2HlNfAFcgrip75FYo25BnyPQ101WKchIIL8wcomqw8dmMFLeuGgCmY
         bhLBSlv065JSN2bKu8+k48hrKr6IN1ar9/usCFQRnOGMbZn9QUkFdAKCmK5Za/CF6JJA
         tpveuPUQdFhkbHDAXf54Z9zLAAG2Jn4GC4vFK9Ut7Hyr96aJOtXNBKG/oIi6Y9t/XjLY
         PQug==
X-Forwarded-Encrypted: i=1; AJvYcCWUGPuGKqLzszpFpmVCxBEWbV9wht1UPzKAQDOXvDBVmHmgmcE3y8a63shtiJ602AQ5ZkitvJSaLKiLmlpIjw1M@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZZ0hCC4wYkPIYSAIb0YzvCU6rNIyJijYOy2d0QtDxd4YebNt
	CjPJfk7zIlekq/1X2e8xoKCRwmAmtAnMlhTAH68QKJS94tsQtOXXA1Qq9gkdUFoZ
X-Gm-Gg: ASbGncuYdEk83X1LjwLeG/oGnB+mCq4b70Ls8jrVXvvEZMLAXt989g/NYYmvVn1glaG
	hKMWH7FFS5Oq585MSQTFE4L0P1i48iM4jvKgmZYkpuCZODyVWSHoiVDb8/Sd4bNy36WIo1er9aM
	iqOIl8JcKGJx8Yqku4QfeOf6d/34nt7tcyqLfnRgBgtNWLtGPSnK84WxmVqW8MP8lsOhPO1i/1d
	i8co8O9iDrzeAMFb0487dey/K0V5IbhacrgzFxKyMuedYvyb2CbIMKPeNYrw5lWyILfrJ2baWMM
	Kjajno9XUA95uhnBVOvcAlE5n2fuzDmT5auffMwzQ5vcfVRt7XV4uIO8S5sbtQijZuNZneOWIpm
	72aBhSQ+D4yBc6NdHvVxThLYZOabhR32NL0MqHUMlOt4HUZU1oqMXRBAJBImlOzgs
X-Google-Smtp-Source: AGHT+IGloWg91DPFb+2yf/uNUVb0mrdl0Yp1Yr/IX0Se29eUuX5pSkvayZBPnujT7MW2sORrKcdt1A==
X-Received: by 2002:a05:6e02:4508:10b0:423:5293:574f with SMTP id e9e14a558f8ab-423529359a7mr100555545ab.18.1758018386304;
        Tue, 16 Sep 2025 03:26:26 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067a7bsm5695125173.44.2025.09.16.03.26.26
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:26:26 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4240111d446so26260915ab.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 03:26:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX07abMqzUqMguY9c2A+JOZ+Tx6x4xZ5HpJkjmge8fpqVJwGGmBHlcq1nhcazi2rdl5ucsM1KA4oB3Fz+tyxfGf@vger.kernel.org
X-Received: by 2002:a05:6102:374f:b0:524:4800:77a8 with SMTP id
 ada2fe7eead31-5560908dc48mr5549412137.5.1758017979210; Tue, 16 Sep 2025
 03:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt13i0lh.wl-kuninori.morimoto.gx@renesas.com> <87qzw7i0k9.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87qzw7i0k9.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 12:19:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQTftuiPGw3j-u7bzScs=UmsFruCKvSq-t_=JuKmpB=Q@mail.gmail.com>
X-Gm-Features: AS18NWAlUh-W1y7BXcMGcm9tJYfZlPplczM9NMOiyqYXewDD8MKxNGtLUFMdjw4
Message-ID: <CAMuHMdVQTftuiPGw3j-u7bzScs=UmsFruCKvSq-t_=JuKmpB=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] soc: renesas: Identify R-Car X5H
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Tue, 16 Sept 2025 at 04:38, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>
> Add support for identifying the R-Car X5H SoC.
>
> [Kuninori: tidyup for upstreaming]
>
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Already commit 5284d0b09d1bdc69 ("soc: renesas: Identify R-Car X5H")
in soc/for-next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
