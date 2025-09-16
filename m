Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81D3176FD
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018270; cv=none; b=UfJwsqLPw1Gsv6Gse5JqVXAav4OyaKHn8wN8aM+mjBjfRPRe9SMwh3S2QjkE3G+ocyCoX9vhVEyE3rki63lV767vdfUELA9KPLQluLuvjofjQB30RgXJX2Ioz+imjTK41+wGwS7KpRB69oTLitEay7hbNo++lk31fSHMQ7MVe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018270; c=relaxed/simple;
	bh=2HZc75dZXq+Z0RKpYly9QbI31fy1NZoUzdLLkl+FAos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esg1brWHlJpYd3wu0LAp8wXbpxH/UF4OZSTeZ4t4xG6nrVkKcslx5P826Ms2o9TIzCkbrHpuOW3tVQy84x3s56HCJiyIP3CVNsC5dfAFV18/TQycF/WHoGrA5VmzyOJ8lJ+HIgd+DQF90/hc7VzoDSQAn4XQk5b/PLjKH+vb96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-55716f2d3b9so3075570137.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 03:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018268; x=1758623068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzQC5o3G/5QL6Qh+OxxIc+msYH/uvK2UseyCJUUA/QI=;
        b=Ha9yIVlwp7LY7Q/geL7e4bpEJJ6dxnWqj1mwireAfJAa7aW9ACY23E1LVjD/G/nwsZ
         YUY+HPaAROZ8VRFDwort/W8VYyuHNo4vDWfFCu/uVeaHPZ3Ov4Fgu/Ldq6ji8cqwuenS
         dZTyfK3+ufVQZZo4PX+wIW6UpDZi1pgVJes2Odkv+YtkGaBSu/IY4QmRSLbL/uydt4aq
         Brf6sIRvkqVFGoNcpm5/jgLTQDgiZhtzmkLCfVkwv82ytSYpHaewSau4qIRYh4ITLfQ2
         jBUBQucSMICNXi8zvJSBaykMDo9P6tDlqT2AS1ztqNDHACDsN17vCqNucj7JeTK1zov5
         5Uew==
X-Forwarded-Encrypted: i=1; AJvYcCXT42Sb9MO8coST8u4AddOFjrT2+7s3Z4VL75FoOAf3G7ZDEiXqWAHE/3YUo1odY7MMGo/U+pWny53g1ybOiJpn@vger.kernel.org
X-Gm-Message-State: AOJu0YyYbXV8VHTKZhDV+c5v1Hk33e/Zs7XKlOa7++HZKHhmW+oNCRXf
	MDswUqn0s+Zn3xgqFy1mzbVTP8fA2X19ctoO47HiVBiFaqe/fkwf+PxsFShK6R2b
X-Gm-Gg: ASbGncsiPvnXl0kqvE9m/bGOKzpsjDjFnNTsMsoSC9c6mrTlghVhj5BxaNZ/rdeh6Ph
	CnuuKVo+pxP5AFaKC8uySCHBXZQSBTSVvAoJs9qchehIOksMTmlgGzh5fS8UnFSobH2nUmwqydI
	V08RMQ4sYvr6iPDuPME2p/JLxxO0i350rGrWszmzEfbmVkdLmI4WasZPtkkMYuO4i+iqYlICp8s
	ZHOhSE4WNhJ4E54xsUGqPA2hKRzi4gMmTB6FoLsJbncG6GDKG/YnnBRk3f0WbttAtKvixbrIuqy
	lAwgbVqJphxygR8LWQC3drLjBA8ft2o9NwUNEDLEKfBAFjAS+m92eo/zkODUbw+Vn5CUgkxNfAE
	R7+zDmCOHU2CP0K1W2q3B9LUKilwDViB7GFdeCFrEXUptLl4hXGvKODBZb3PP
X-Google-Smtp-Source: AGHT+IHwFWSQRCdGrS9xkpuOw9Kq/z/7XPVG758hYjdXUTHg/YEQKbMnRYkwIu6oHkVDAAPFXmINpA==
X-Received: by 2002:a05:6102:8025:b0:523:d0d7:b964 with SMTP id ada2fe7eead31-55609f106d4mr5664340137.12.1758018267930;
        Tue, 16 Sep 2025 03:24:27 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5536f7c6aafsm3499218137.3.2025.09.16.03.24.27
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:24:27 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-55716f2d3b9so3075563137.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 03:24:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVv/E6QBE5L2ZxtMucGd4rNFJ6xO/3krzyEmGv7j6KBWVfHobQ0IuutBdtPeN8hUz1KzVLg1FX1khROy6C7rQfT@vger.kernel.org
X-Received: by 2002:a05:6122:c81:b0:544:7057:a812 with SMTP id
 71dfb90a1353d-54a16b7e208mr5192058e0c.3.1758017916045; Tue, 16 Sep 2025
 03:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt13i0lh.wl-kuninori.morimoto.gx@renesas.com> <87segni0kg.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87segni0kg.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 12:18:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRNUDNnF7QVwUxbxyOCsTEdJjCuWw3-bqA0tA2uoxiFQ@mail.gmail.com>
X-Gm-Features: AS18NWA9ABGiKPyMIlR3UAj5Udf9cOnnhSw8y3TAUBDcJz0NhqQSnwO50GNAW48
Message-ID: <CAMuHMdXRNUDNnF7QVwUxbxyOCsTEdJjCuWw3-bqA0tA2uoxiFQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: soc: renesas: Document R-Car X5H Ironhide
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
> Document the compatible values for the Renesas R-Car X5H (R8A78000) SoC,
> as used on the Renesas Ironhide board.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Already commit 1ed2786e9ef8f162 ("dt-bindings: soc: renesas: Document
R-Car X5H Ironhide") in soc/for-next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
