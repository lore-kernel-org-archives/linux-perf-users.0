Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920402E092D
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900072; cv=none; b=JOpwuO8bECvk9gwxyQ4prM4o+PPWB+ofYIkltdox018ZMt2YfQw0eK4djB8hS/cI/QSf9eakUhHnO0yXehVHnzqyAogKKpDo5df5mOF6I3lrRbneja91D94xKiPwshEOGrKYvNWhyhgXSmlar2pbHHIE3u0kjzM3qETnAqIwjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900072; c=relaxed/simple;
	bh=fbya6ziaDH/sLgBKG7AReAjVhsTbBpl/73dg3q1ld58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlUUhPLnHkBl3qlksN/4eim43ZEjcMB+Lkw9a09islbP0x1ueQ/MIoUj4SgfS4u0VJw4Zyj/pvx4HLcZaaS1S70LHoRXdPTCZPvm0JQJiQ7gMrwr/Ej6rmgUErSgaWQvVvLcMPbADbA9HLoOc/FHnG8PvvGqvcaC3uSp3rpRQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ktawGwQ1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktawGwQ1"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6156c3301ccso1507a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753900069; x=1754504869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6r4c8nkwybj2LXJUlPp2AEc+KFr7lzVJbq1YiFmFnQ=;
        b=ktawGwQ1WtoTeUeJdGWnpp6Fc28yPbf2RQZNyJSE2f49/eytsVX7bJmlrHoYx4RIbL
         fhxr1r0wnIitTVBqubsT+Edlccm/TD7CvPQFhCNdQfuGJZR9eyzcoCebFF7kc5ie3R51
         QFvG1J7CxNYkpFJAavoIe4nt074t3eju85fHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900069; x=1754504869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6r4c8nkwybj2LXJUlPp2AEc+KFr7lzVJbq1YiFmFnQ=;
        b=PoxXPqzXRIRnvApQolm89nVTIRVp7pqZqLGRtDgwUB+VZPbv3R3njWceB0QyV7tQti
         3NQXcV3GIMgNZnrE7bLVGK50QeS2LJqqH/ZkC21/x2ACPBWjsOs3EFeYR1h/OmfUdplA
         AphPMhDQr62DiuwlrihJehvk6Hc8YQHTAna7zGwMAYODfimQELvfA94PFYpplJtXuV0u
         LJ6IdDAlElR4JBJuW3YzB6pysuPuoGgevlWwWQJXxhoYrztT/uaBPEsjksIynlj+fW52
         hqp/0msn1Jxu8L8f/EeAKNy0Uu9QMWRJpxgJnSftXuGp+WuQrRXYeBAyytQrSc9JQ2rU
         SzDw==
X-Forwarded-Encrypted: i=1; AJvYcCWeKgKUjLTx64YNVpSXLsjXV4HX42gVqlmsm6u0cuQGZno3uT8R8IMBsSfFxMyygJVKWh6P5CB5vGgYBeONVV+1@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHWtJkoy68Oa/IRYdJeOI9+obJb4ji8kRsochoAoZqsSveXl4
	mAoMLx3Hbo035LhX227aWdgZave5hc0hfexzCHPEg5RxYDnynfj+uN6uubGmKUxJxF4tsg9TSRb
	OQchxLrElYpsWGv4ksTH+ErT1ePanE6RqaLJVvVVG
X-Gm-Gg: ASbGncvXPqBvOkuwHojrNAknMBEyCaTr5gigb+UzgX4F75RE5f0U8QCYyViUJc0REtP
	HQj2HtrN5rIoqWbULmd7CC0sc0wxbElMi8uhzK447Ki0C/u3gzLWnetet6XpOse6TzxzgAakYhT
	GrInl5T2PHMFN81xqoftHqVmN5hkUbzAVP2j8+2OWies79asquEwhAjsIFX5khFg3xh4ifOW688
	yAt33bOF5EtzgEqDg==
X-Google-Smtp-Source: AGHT+IH3UPStIjtEwhYQSCAV6DutX/5ZbdtIndLiNMPcdjaVtjZJm+vQdKhY+hsQZbuxeOMWz/367Av3WxhmS8SMryo=
X-Received: by 2002:a05:6402:2883:b0:60e:2e88:13b4 with SMTP id
 4fb4d7f45d1cf-615a62ab546mr9757a12.3.1753900068649; Wed, 30 Jul 2025 11:27:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com> <20250728-ddrperfm-upstream-v5-5-03f1be8ad396@foss.st.com>
In-Reply-To: <20250728-ddrperfm-upstream-v5-5-03f1be8ad396@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 30 Jul 2025 11:27:36 -0700
X-Gm-Features: Ac12FXxlAvE9QxWzw-TPizj7qPTosxk0R2iemsaWz7FP_QlsARKGUQ4HcK2OYu8
Message-ID: <CAODwPW-FjCtPGYkNYozo0ybEjz_rVOeDqkvEPiCmQ6M2in0OeQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/20] dt-bindings: memory: factorise LPDDR props into
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
> +      lpddrX,YY,ZZZZ or ddrX-YYYY,AAAA...,ZZZZ where X, Y, A and Z are in lower

If the revision ID is only one byte for DDR, there should be only two Zs.

> +      case hexadecimal with leading zeroes.

AAAA is not hexadecimal, it's a verbatim ASCII string (at least that's
how I would define it, for readability).

> +      For LPDDR and DDR SDRAM, X is the SDRAM version (2, 3, 4, etc.).
> +      For LPDDR SDRAM:
> +        - YY is the manufacturer ID (from MR5), 1 byte
> +        - ZZZZ is the revision ID (from MR6 and MR7), 2 bytes
> +      For DDR4 SDRAM with SPD, according to JEDEC SPD4.1.2.L-6 :
> +        - YYYY is the manufacturer ID, 2 bytes, from bytes 320 and 321
> +        - AAAA... is the part number, 20 bytes, from bytes 329 to 348

This should clarify that it is excluding trailing spaces (so only the
significant part of those 20 bytes, since they're supposed to be
padded with spaces at the end).

> +        - Z is the revision ID, 1 byte, from byte 349
> +      The former form is useful when the SDRAM vendor and part number are
> +      known, such as when the SDRAM is soldered on the board.

This inversion of the statement is a bit odd? I think it's more
important to explain why we need the latter form (or just explain
both).

> +      SDRAM revision ID:
> +        - LPDDR SDRAM, decoded from Mode Register 6 and 7, always 2 bytes.
> +        - DDR4 SDRAM, decoded from the SPD from byte 349 according to
> +          JEDEC SPD4.1.2.L-6.

nit: Add "always one byte" for clarity and consistency with the LPDDR
equivalent.
