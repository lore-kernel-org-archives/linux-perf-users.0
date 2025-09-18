Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559341E505
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189686; cv=none; b=LF+NDBcH+TKxuRdMAN4MKwayAsl+lXCaKglLsQRS9kbkkpLcT0QrVkSsRMYro/K81FWd0r2lNob0x+jZ0HLK0W3RnhWDYlsCJm+vLsWYVbbQGVd2rRTffkgJF5Kli8kL6WSGDYAvz6jxIx7Zh0UDgzG2Acr8ZjtXQNXz5hf3hUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189686; c=relaxed/simple;
	bh=Xhd+Zs+m+eFeRxYfwTUWH3/IgVMq5TlAz+/WIR4VgFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE7haT1KsLV76DxO5WlgsywHrqrAiCibKRTWS9oEbwHmNDaIdgaIpWTyIN0ELRqlpDj16HnhIo8kofsvGK1UprYmaSJu+y2hCuxp5UeoanM89mRqZzYi7nIJmfVP0bZf3BrsYLppTyxHhxqyEBD9NAflMQU6pImn4dToNcCXLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8a00c77a62dso508335241.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 03:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189684; x=1758794484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCgJo7Iim2r1QY3epPnNwQa02OhmB0pJps80hKObtxM=;
        b=SMcMtC6Lp8XtEgdL2fY7PBYznqEBKzj+DP5JqAkshvnEl5eCbHfy1mPlxhu1zwzrV9
         +aga9zXa0y40e1x+Oo9ffAlSO0nVK8N9H3MDb3+hDL1hMEWCvz5/Rg4zAH81ANANMZPK
         8PNZ88HwQV9UoJZ8nWLTHH4u0IyRR8IilfEl6xEN7zGwVOVB/RRHdnGLD4AGPeAuwCHp
         rgH6ArQliIEOeFAyGaLn2FQyq60FvYhgG0YRgzIXtiC+zozdP4CICt0iDqLi3NXpE86k
         0P/ywCU6YCfkg/QPMBCEIeLJmEWDrxdRrglXl0Cx8gztk0HND5TG5Fgal4uDbdFycnhy
         O7QA==
X-Forwarded-Encrypted: i=1; AJvYcCVdwmS9L173eCbT6VyrIKTn/ZlbFjMsOHIKLv1+xCuotwt9N3IAfAPhb2/f5zUEBMnq2PNYZBjmhMACJmD/0hvL@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOlqsPxFVYtBLcttl2ipu2KRP4FcZ6mYUTsxAVy2EYW2rFKxt
	3mxpPwVzUm3ydYA37038ea1IkDl3oVvpTKbYEq8tEqlFFvGeTYVqbeGdYJiNtYG6
X-Gm-Gg: ASbGncsgs21ZgCiBpdQsNX7N1DSvQChDiiFG01UA6Ee9GkmcNoJ8LriHprlmX4TlLTu
	2NVgU+oZRPYFSUm9t66RtIWj444koTWzdZ2CVHepkOgF8xzQfZRSrYxPfFxgYmeq63oLmFdETa5
	KUkHu29gKLF7/T+oIaWEhil0PK0vV6tO+l2oFjEIy1aWQD6aUq6BPOCQnQHDg7jv+LHBAzAmlUZ
	zJtQ3hA9t1B3528lRwxDSRC1Mymc57LOV/P4eEsSDuJcahVONJIw2MhLAwOYHaMMg5+cXQ/slwz
	J2kIl8a2EE51Xn/3Fg1W5MdW/bE3SfADJ6LHUnl6RyBJX8/qWKG7rIDRotyJUko26p6FKpFNb3n
	kemBshyilLs8/UmqZmMm7Ej9EKeQGCk9BpcqbbmloMClJKgSRNVESA8inBiVT2JrFew9OaMEba7
	JDtV/5h8bjpLLzPg==
X-Google-Smtp-Source: AGHT+IGi8q7paeE0IazNnZFnw6OmNzpsYozMkcKpSDyBVz/siHr5+32V3nwJVZnNTItnNcPcNlFphg==
X-Received: by 2002:a05:6102:4b04:b0:4e5:ac0f:582c with SMTP id ada2fe7eead31-56d51ca1fcdmr1779521137.13.1758189683889;
        Thu, 18 Sep 2025 03:01:23 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-579ed35f674sm495753137.7.2025.09.18.03.01.22
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:01:23 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5570a77eabcso568980137.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 03:01:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/n08fEhy2imVfqI5zPwRBeq33+OCqkefZUbOXeAH1CUIk6lCPKOC0VxezEf29vkPNi2EDSaVuNaUhe+Hg9XeW@vger.kernel.org
X-Received: by 2002:a05:6102:4b04:b0:4e5:ac0f:582c with SMTP id
 ada2fe7eead31-56d51ca1fcdmr1779501137.13.1758189682008; Thu, 18 Sep 2025
 03:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ms6snut0.wl-kuninori.morimoto.gx@renesas.com> <87cy7onul5.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87cy7onul5.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 12:01:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8+V-EbrSFF_f-pAm95zZLtV8mMjOFAGX+af2JO9Q0LQ@mail.gmail.com>
X-Gm-Features: AS18NWABsRlKpDFFCpae_UW48HuvCqA9B-vtOkVv8ToG4xGXl4aYc_QckQPRgYY
Message-ID: <CAMuHMdU8+V-EbrSFF_f-pAm95zZLtV8mMjOFAGX+af2JO9Q0LQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] arm64: dts: renesas: R8A78000: Add initial
 Ironhide support
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

Hi Morimoto-san,

Thanks for your patch!

On Thu, 18 Sept 2025 at 08:27, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Hai Pham <hai.pham.ud@renesas.com>
>
> Add the initial support for Renesas X5H Ironhide board.
>
> Note: It is using "maxcpus" in bootargs to limit number of CPU, because
> SMP support is now under development. This limitation will be removed
> in the future.

You forgot to drop this paragraph.

>
> [Kuninori: tidyup for upstreaming]
>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
> Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
> Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
