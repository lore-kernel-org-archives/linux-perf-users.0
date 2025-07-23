Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0826B77D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305382; cv=none; b=JFaF9lEWsnqxJ5aKmYrNRowKwnkRX5D/TCtrYsA0/oAb6RzQpR0qvfiAo/+B27LWOOxX7yONJGRuB2yKIRhsNY3MpPktNr+JcUPcWgEnf0hgCzFkTb5yos6S34vyQcGyCy6Mwld2yPF6Z4FJLp48xop9+759B6StXQA2MdMo6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305382; c=relaxed/simple;
	bh=yWyJDF3Q2SumP8IS31W52vFdyTdD9QP8y32xJ3aVsWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nwrpn13K4rxEFQ666860RJTHe5+7kJ5XcboEuBmTUto7ZN5rbS2zbKip5gXSwn/7mSdKzAL9JQzN8AMCtqt4NhOsHxI08jrqnPUMWgXsGQTRXTATivZJVa0LTEJX5xXIUVy2IYU5W880cQQw1dwCb7FgHS6CYUpjqfpxlpnOY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TB2m0bfb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TB2m0bfb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1492a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753305379; x=1753910179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yWyJDF3Q2SumP8IS31W52vFdyTdD9QP8y32xJ3aVsWU=;
        b=TB2m0bfb5AWnodsdI4fAEe0G25DPq8LtpAMClOdD/1YTS2jhq5Eb5DG1EWe5FtLuLy
         qNrGoar7njwPPDGhlAMbnxBPCljPkWLUXxUz3zyc/VRwGnPAIYhUHn8UZMdGuJjEJ22L
         423/h9wpccWK3CqTPWZDh35goLIjqDiOsjVL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753305379; x=1753910179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWyJDF3Q2SumP8IS31W52vFdyTdD9QP8y32xJ3aVsWU=;
        b=v5GCz1y9CafJtIeARCYTyxk0dSKQl0R9VXQG6W+4T/ImWAVEssG2u9sJ/RU/1pL9bT
         yL0PjZBLBsbVUn9kgjd09W7UIcpB0lynE2lY0uWVmpSzOBOETv5A717MMG0tWYxoj4bG
         +PVWKvY2Frc1lwL42OKR66P4/29fS3z78FvRDlrkocN9CNZd0coq7fGTPqhz/shldKb/
         t6UAZ3qVPoxTkyNwJ5K54rdRT1M/2W94idWhoerpvpazvj/n6vpnxIGhmySYRuORsqLA
         Tcjd0WKR1pHV9CotT9mkRhLLZxFI/8b40ivWQY1gsxm7QYrNfVsLdNJsbbHgh5eEvbBd
         SQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDouHzKl3CGPlfULDQLxqlG6nirCEvo8BWmtCEUXkp6SKMBhRx5FSXm3yNvXl2343lDB8K5odv9pKmPiRAKcb9@vger.kernel.org
X-Gm-Message-State: AOJu0YyTr5iDIDZSRkBPyzw8SoCvQc9X52UcIwkLI0/LcpLiqQ5eSmnu
	ceWJYqIcdV0oiDkgu28YBNLmN7Kb0bprjtfiZ2iLxrN/0tDCzV3WTVDC9I1d6stKiolM0cwRnUo
	/Cgm7usIkgjFmUcuXrwhtIhixcUs8C057gNnnCWLL
X-Gm-Gg: ASbGncuOtQgMmyiA/7RUE9gOK/rS+NrMb2WvscXK/grZhXXvlY5p7pIOG86f8SLpWrV
	MbCREhdk7KMS+Ezk0u3iwZDpX6wRbkShRvOzYah6lhc+CKKFHwALW4TG5GBfbKstz+J6LkUeF9o
	P2edFJLeW1wcXH/nYB4rJ9pIzAng41vuBQdU/dgpT7PHzNIaEGFLG/5XPVzcXrMdasTsBriHVXT
	zeedGHUCYPvzYabHDuDGcxP8Ig0x0aU2g==
X-Google-Smtp-Source: AGHT+IGkycQnfe72S9SyWbMalkjmg0I49bPxAmbp0MCvmAI2AYuaRbELjXuXnq+jCKrEmFtw1MggLjmHYfDowt+Iv2w=
X-Received: by 2002:a50:aa8a:0:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-614cce2f67amr6758a12.1.1753305379189; Wed, 23 Jul 2025 14:16:19
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
 <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
 <20250723-zealous-turtle-of-perfection-e67aee@kuoka> <e9e33fc7-4705-4e6d-bd33-ce9dc1a9b94e@foss.st.com>
In-Reply-To: <e9e33fc7-4705-4e6d-bd33-ce9dc1a9b94e@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 23 Jul 2025 14:16:05 -0700
X-Gm-Features: Ac12FXyYNcqm7jBBLCa0VFOXC51yHGdhXmCX5kALRLR-kvG2ffG7jYjz27Mm2C0
Message-ID: <CAODwPW-bwg-CD8qfP0cb58QVFLfJSqj6DhZSQuqHxsEdLz1QDA@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] dt-bindings: memory: factorise LPDDR channel
 binding into memory channel
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Le Goffic <legoffic.clement@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I don't want anything specific so yes it could be cool to have a generic
> node name.
> "sdram-channel" is fine for me.
> @Julius what do you think about it ?
> Is your existing software generating it in the kernel ?
> I'm curious about dynamic node name generation.

I'm fine with whatever for the example here as long as the kernel does
not rely on any specific format. `sdram-channel-X` seems fine.

On our platforms we generate these dynamically in the bootloader based
on what we enumerated during memory training, so there's no kernel
code for it. If you're curious, our bootloader code generating it is
here: https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/main/src/boot/memchipinfo.c#25
(We can update this if there's kernel consensus on a new format, but
we'll still have older platforms that keep running the old
implementation and we also want those to remain compatible with newer
versions of Linux.)
