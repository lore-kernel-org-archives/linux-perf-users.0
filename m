Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116992E172D
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900205; cv=none; b=LlyiJCy718XZgymi8x9bd+aZTofW7OXVeAl/rihP8ZGHJ2yf86rYwInrwJOKEJKETVbRlgTfIGoHKmp0OBeShjLUzFHqAiyJfqir8DfIRVqaV0pXY5J2ZNbg66z25ULCN30X4txLgaXinRgtkcXlQkLxUddz26r6nVZYqx+r2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900205; c=relaxed/simple;
	bh=+IlnsvCqZpWI1irANdU7vC/52xTZuuB1B7d87Am81c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOgjclZauDJwdbvAyIT5OnxWjBo3gYEupC+VdK5oonOjuPiggh++HvYspVXxShqXfDRf+bfmClscnfZTwP8uKKqqLDcpGbOc3OlHnrhR1NVb/1HIflSe066bp1BTL5gcW8RnjejrHnfeG5SMuYBLXA3JoU1n9TlmPx0t9eWRmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OUHEnhZN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUHEnhZN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61543b05b7cso1823a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753900202; x=1754505002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NIbM6q1x218b7Li1UvxruEIMKkwKF1Zyv43mPS1uqY=;
        b=OUHEnhZN94w5azEkzVDqwNxQbrmR0zEibAM/XasVXnXVjGL0j7E7BmSRNc+bAz7S4Q
         53OPHMTJ8fiBPfeF/8akZnLWWqMP0oSwW/rPr6lwyix61oSq2QbHVphJihJovHmqTBDy
         SLaEN/tShBtJW/9eexd+z/Ov+KVtC7ty5Btf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900202; x=1754505002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NIbM6q1x218b7Li1UvxruEIMKkwKF1Zyv43mPS1uqY=;
        b=ihba5Synag1L9WosBfWI/6BLO9pJBXfNxvHSG8S96uzUxKD1dag0nFtLP2HlT0Zu8r
         le5SMOTVw7P55vAVxiyGB+EV9eu0sxZPiUpnDjX0Sx0sTlPJS8FHgofw0Cv1+Iv+aKme
         30bTV7IkUZqQ9A1Qot6IhugIO5+V7ktUflaFkvNMh1rzE0Qu/lA8xEKr/Ibyudu/9k/5
         ImSMH80LjpFG6gTbarbvfEmnrx+WPudZoOLP510Abj2VailyBzwfu/yE0HvYMqigESq0
         qKfYjShs4yCLPhhqmulMn+RWgywYX9nwV1qLvsMzReLbQ0vrZBTyZtsGh02aS59VoZHW
         /BIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKXoze+3tkJl6mftwHG40j6iXVb5ia+Xc9VckKfVm5oC+ZGUj4IVL7XghiKewlBEhYAZTUOAX+1LSZCgm63feb@vger.kernel.org
X-Gm-Message-State: AOJu0YywLu0tMhP8JIS0B4HhDXHdmI5jGaECK1Mt5R2/KnRQdmB5azAW
	OPqGtFawpRYdrkqNxUP4wa7iPDAEjawG+XE2DcpSBBeyB3Rk1soBpxq+dELtXafuZ+GhB2SyNK/
	Kl1WfaIjjXrxKrThoXFs43r+mQTLuLz9++QgwfD6o
X-Gm-Gg: ASbGncvGC9NzoRVm0UZ4hFvBU8wMku/3UneVXXBISSq1g1W3nvZ0oXTj2HSTe8nPMB2
	4IOKTN8U9PUNfkCwG38UigipWvvRyxUlazzcpGHSW1W/pejrHGx2VIxrl610w1jGj2bgt/L3044
	SBHxmxo1x6qEfyYm0Pmfojt5GulxGeXkmAf+FFpCjIZQVgkp0nZCMLsqO2+I1ZwqQekpWiym/iJ
	8s7k/8=
X-Google-Smtp-Source: AGHT+IFbbK/ul5EAl+qpurW8QCD6MUFcOByL7/YGvDuMq5A8bS06QIOt2f3QRAN6xuePrLmBIsEPhHn7xYqFra8YQrM=
X-Received: by 2002:a05:6402:d50:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-615a5f03c3amr15582a12.2.1753900202156; Wed, 30 Jul 2025
 11:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com> <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
In-Reply-To: <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 30 Jul 2025 11:29:49 -0700
X-Gm-Features: Ac12FXzJRbNK4O4rQzoS61E9llbPlM-a0El1zXFqw746Wesi6zAN_YlMACvZJkI
Message-ID: <CAODwPW8ZXfMdFL2=6ht+BvQq5_LQkwHhQJT5j9DcseEx9naXxg@mail.gmail.com>
Subject: Re: [PATCH v5 06/20] dt-bindings: memory: introduce DDR4
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Le Goffic <legoffic.clement@gmail.com>, 
	Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +title: DDR3 SDRAM compliant to JEDEC JESD79-4D

Should this say DDR4?

> +examples:
> +  - |
> +    ddr {
> +        compatible = "ddr4-ff,f", "jedec,ddr4";

This is not a valid example for the way you're defining it now anymore.
