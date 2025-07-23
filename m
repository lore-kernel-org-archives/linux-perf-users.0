Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79722A4F1
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307319; cv=none; b=FX0HEBYb8/KVcVfE+I2203p8uUezq+FC4vyPQAojLku7B1paMTdWwm0UIy6iQCP7knfI4lWbumwkspFCBWYlYxYxWlXDPFcSU6+Z3Xx/MIP4oQnwNcTT5H5kKRy9sZCw/A16UaqsNMBTlPKHybeZkAPZwop6nHdLE8tzS8hbS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307319; c=relaxed/simple;
	bh=hmDFVGB3e5lJKHPj2nV0N+TQauvjtNcfS7zNmuXI2+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRG7ZHMI3C0xYciP0uY8B08tKJM3M7taqFexy+EdGuwZFz7wrWODUuqKFimS+ZiFuPeGO5Lw9Lo5FJVmHVJclHoZ2fBf8t2sHt+SEMqKU4Eko+lJ50BLoLp14jatkyPCKoas8SCIldX4ZDnU9/rgLl1nbjgnb6qPB2NRhZMFYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L00Ogef6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L00Ogef6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1813a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753307315; x=1753912115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urCBknSfoBxunYc3x4TdwqCRcefY8UK7ESNufBc9V5U=;
        b=L00Ogef6AVXYklHfKTL60sm9mYzOQqVhffloVPAHXppU6QIRTlyBY0YW4Jq7sh/9Yr
         AuoDkJAWCqG2L4FmReSWmh0b+qq+octBXu7GxV9YNvIJWquYjIWOxSh2JCwLTroiNgrA
         Sm6pFcfPUGA8j88ybJblzjaF4X0IL8Qgxk35U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307315; x=1753912115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urCBknSfoBxunYc3x4TdwqCRcefY8UK7ESNufBc9V5U=;
        b=ml0eVpa8y24gK/tSB5qj13YuCOJ263qI9V7RRyQxHanUV5oMY3Gm9lE9h97OHUFmDl
         zJVA8tHKnrBaOhResIPvXBmuYgJsEW+/tK2NRdURp28PZiWAMCr0/1ztN04v+unS6+cJ
         JM6qEB5NPE/D2UnhbsAbrY/BUPr0CM1tZxjUaCR29GIKXVXx+sKWSbxHwmCA+M0rbbik
         s1fMgoAKN+uU0GuCgYweAzHeonfMI3uOsZoo/s+Ss8UqqkmK8IMZNu494GxG+Ao3CYiE
         O/eKK3v9JDqQv2P5jPN1UjMUwdDa0VQyVhgckTRsg5URFOR4p0C6Hf9gQEia8+OnvG6a
         IEuA==
X-Forwarded-Encrypted: i=1; AJvYcCWLtEvBBdTn9ATT/SgAieyps2gbVpGoA9rALWm6iwjTMjc3OL/HFoHqs9aGdm2oOWWG2EAogiQZeyanAZLsnkZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzAshCktmjiY7g6iIZ+FNJert+rH2Us6vfkTbq58TbTLFrYHE2e
	Qj6tZY88obOsOTN0OSGq5+Q3VJdQKROoHffeg1YU1ab7/qxm4APXhlxalhX8Bq48aYvIfE5CHdY
	VvXP8ravPmAZtqHE28ZwRd4+u9M/GUwtCvk9GNXsX
X-Gm-Gg: ASbGncvZq1VZl8AyTsXwaCTNFX/Sn9TfJBcVdzlCbXnXEGETZAX8Ic+OEI0yE5klh9v
	G3cHa+c0Cfa2oDFWZ9PspJtC1BsAviniiWHcQRIxOgboFc/Ebp6//XZlST/VL99Lbl8UkybAME4
	vV2q0ZCp5B41+A0ajfDQcTZwRhdPtoDAuMiDH6iFnpeWP5JoyTgXWbW7a0QVVTRdVeoNZGsFSB7
	jaY8yHSZt9NDCRUyE1rYUjbOlgA+hN7z5amnDsVuZln
X-Google-Smtp-Source: AGHT+IE29O588oLM6SeiuCxCPB4k1tkTOOJCtmrayG7KngivziL2hZUa8WDJp6fjlpiSMU5FMaGeqaamK89e2HKbNPg=
X-Received: by 2002:a05:6402:cbc:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-614c4dff31amr25156a12.2.1753307314360; Wed, 23 Jul 2025
 14:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com> <20250723-ddrperfm-upstream-v4-5-1aa53ca319f4@foss.st.com>
In-Reply-To: <20250723-ddrperfm-upstream-v4-5-1aa53ca319f4@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 23 Jul 2025 14:48:21 -0700
X-Gm-Features: Ac12FXxzDR1_uTCXgfJ-I1tKRpXZw5fnYQthEfx3HR3N-6vAUe5POy6l3eogw2g
Message-ID: <CAODwPW_kex5Agqxg_i-XC308scEpUJU0me55G7iZ8nB9LC0acg@mail.gmail.com>
Subject: Re: [PATCH v4 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
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

> +      Compatible strings can be either explicit vendor names and part numbers
> +      (e.g. elpida,ECB240ABACN), or generated strings of the form
> +      (lp)?ddrX-Y,Z where X, Y and Z are in lower case hexadecimal with leading
> +      zeroes and :
> +        - X is the SDRAM version (2, 3, 4, etc.)
> +        - for LPDDR :
> +          - Y is the manufacturer ID (from MR5), 2 bytes
> +          - Z is the revision ID (from MR6 and MR7), 4 bytes

It's actually one byte manufacturer, two bytes revision. The YY,ZZZZ
is supposed to represent the amount of hex digits needed.

> +        - for DDR4 with SPD, according to JEDEC SPD4.1.2.L-6 :
> +          - Y is the manufacturer ID, 2 bytes, from bytes 320 and 321
> +          - Z is the revision ID, 1 byte, from byte 349

I don't think this will identify a part unambiguously, I would expect
the DDR revision ID to be specific to the part number. (In fact, we're
also not sure whether manufacturer+revision identifies LPDDR parts
unambiguously for every vendor, we just didn't have anything more to
work with there.) I would suggest to use either `ddrX-YYYY,AAA...,ZZ`
or `ddrX-YYYY,ZZ,AAA...` (where AAA... is the part number string from
SPD 329-348 without the trailing spaces). The first version looks a
bit more natural but it might get confusing on the off chance that
someone uses a comma in a part number string.

> +      The latter form can be useful when SDRAM nodes are created at runtime by
> +      boot firmware that doesn't have access to static part number information.

nit: This text slightly doesn't make sense anymore when in the DDR
case we do actually have the part number. I guess the real thing the
bootloader wouldn't have access to is the JEDEC manufacturer ID to
name mapping.

> +      SDRAM revision ID:
> +        - LPDDR SDRAM, decoded from Mode Register 6 and 7.
> +        - DDR4 SDRAM, decoded from the SPD from bytes 349 according to
> +          JEDEC SPD4.1.2.L-6.

nit: Clarify that this is always two bytes for LPDDR and always one
byte for DDR.

> +      Density of SDRAM chip in megabits:
> +        - LPDDR SDRAM, decoded from Mode Register 8.
> +        - DDR4 SDRAM, decoded from the SPD from bytes 322 to 325 according to
> +          JEDEC SPD4.1.2.L-6.

Are these numbers correct? I downloaded SPD4.1.2.L-6 now and it looks
like 322 is manufacturing location and 323-324 are manufacturing date.
(Also, I think all of these are specific to DDR4 (and possibly 5?),
but not to earlier versions. I don't think we need to list it for
every version, but we should at least be specific what it applies to.)
