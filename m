Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BC286D7E
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221485; cv=none; b=e6cNw6qb2GicyPY3PBWplbMI8BVtNooM4w4GLgFm8ofnFzypR7dTR1ii/dbKTEy5ghF7f437x+G2Pt2BR0Va7zU0B62QJhYYQ6SYiwBGtKIegs7n5fPlzJB6oD0JLo5ppWWKi6kKXan4KScvQoBaNwMv0zLMOSXcIjeGuM01xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221485; c=relaxed/simple;
	bh=lYiKyYXdjjhyUxtYTcfFpjzBCFZEpw5hRFn/BBVvuuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2MGMyG7idrJM9feyoXBNaCAch4IAeGBbRyvuVkVAFOGCvUo4VY+qjMceGQ33kv2IYBSQva++g96JrEBpinV/8VbvcuN21ui98H2VOpqaljxtbPkv/TL3rUCuD4TIokpPf8j9jjZwqbEoLJAlwFRmH75QzQaT7Sb+mx1PoUvWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PgQxFV3x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgQxFV3x"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so2002a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753221481; x=1753826281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8hcD+fzN/rLyW2ntnhyBmLcEi4uK+H7gUEsQ2j7Juc=;
        b=PgQxFV3xVIYVzvqWxGeXB8OHIHNRoHKHmCv76q4RO7nQqdxZQcLB1ty5/mVtzmWnwG
         CYrnztOoFpxdfzJbLKQ+RtauRKd5aUt8LmxexpNafhIWydzVe1oLnNWOnH7bcJc5Plae
         Phwml768EXjZoAvaIxiXDoeC4RIPomr8tMQlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221481; x=1753826281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8hcD+fzN/rLyW2ntnhyBmLcEi4uK+H7gUEsQ2j7Juc=;
        b=uEvnaCAnG+h8LYg/9t0OmaJPde4Pb3CKT4AIwa7Q9mhLYMHxx5oFsr2q2Xg0Bl6roO
         RU5qGx4OYFxvFOWMh/j5NFTc1gTW0MtPt7g+1ZqUj+Ld3YsXsNZfyAI46HpmKPK1hNNl
         56N+DNAhdIyE4ECKRusArnyGcsvXBVsNh+aye4qWrOlj3L3l5PCVkopZPj0zC5riW3Cr
         lFjdEn0k0MvX3QlB7DHehVhje9MJ0eimhuE6ejOPkzkWgDX3Do0TkgD44guVD7NYxShn
         +q5m3ao5S1P4XGmPCpZtw5l0qoMAJAb2HhYZOyLSuU+o5dsNXfnWPjCXPtXEycqVpfe3
         SD6g==
X-Forwarded-Encrypted: i=1; AJvYcCWafwI1h5YBaCiPtGzRPHxpO7F3Im0ILsWb9GjbFvVHkN8EiV6Lsu+1Sj26VcTrbQb/clEAHtXpzhRw8I2NlG5y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sbVkl4JuvM9/2ZG6bbvhTn9I1D7vk/g4fElsS2e8gOhnNgxE
	WshM3Xr7ypcq72P8KxHy81JqrzE4r6CsgB5+mCDPf76lhH68MHUrCUXKdlbkdSX2t0jT/J0cfwT
	WHYBhT7S1GkZrrnkKlr2xRUlMck1vBqdOJHitAGOH
X-Gm-Gg: ASbGncvydAWhlw+2wPRJmn4xNm4g7k7A7gYitFbZqwfe8k1XT4I0xjHPbBbPE2nespW
	7F9FRMvDbJiHw3n2DvbSqTB/PAwR+lpE4FAsP315pWbZ6Yj5w3GOYuJoIsljlGHhNTgKKxQvVz7
	3pr5KZzXjEjnUONTAbaM+Y6RKg1iVYNPMxZq1dzcT7iZs9chFQoTVRH4WFds4ucjjfTqE9O2qyB
	3oKJKQRDbSKgtjUO6uGdAOD7lsVBrkDlQ==
X-Google-Smtp-Source: AGHT+IFuRyHVLlTc9+mvjyXn9nDzKUxgSkHkWINR1NMMOVHEBiRhg+HBPAtm00VgI63bbY4a+rdh39BgoHymQ+H8ciM=
X-Received: by 2002:a50:cd42:0:b0:612:ce4f:39c with SMTP id
 4fb4d7f45d1cf-6149a332acamr34752a12.0.1753221481275; Tue, 22 Jul 2025
 14:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com> <20250722-ddrperfm-upstream-v3-6-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-6-7b7a4f3dc8a0@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Tue, 22 Jul 2025 14:57:48 -0700
X-Gm-Features: Ac12FXzhD62MTJBHmWXOCNn35YJ884MYdMc4gPYhqJDJjbLE29Cjc-kRxryta0g
Message-ID: <CAODwPW_7aYdEzdUJ7b2nT4-zS9bu_hbNqjc7+_wSHbedXZXJ=Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: introduce DDR4
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

> +      - pattern: "^ddr4-[0-9a-f]{2},[0-9a-f]{4}$"

This pattern doesn't really make sense when DDR4 doesn't have the same
manufacturer ID / revision ID format as LPDDR. You could either only
leave the fallback constant for now, or define a new auto-generated
format that matches what DDR4 SPD provides (which I believe, if I read
Wikipedia right, is a two byte manufacturer ID and then an up to 20
character ASCII part number string -- so it could be
`^ddr4-[0-9a-f{2},[0-9A-Za-z]{1,20}$`).
