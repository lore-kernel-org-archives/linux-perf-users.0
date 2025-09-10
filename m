Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC17305E19;
	Wed, 10 Sep 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491076; cv=none; b=WZYxbljNNYYhZDcl/Pp/PT9dKmHYH4Q4KOI3v85t8SX+qHQf9m/eOnnh7dLMMNcShPJjPw01jBgAt1K6eZj6QWAQlgszM3LBdrnccuhnCN0LyMaoUOru6toN7Ftd6UNEfwDgzC0p9zCnEfMxsxhTrEx7Nb8X87Hm5eR/szoWOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491076; c=relaxed/simple;
	bh=6uVpYxLKgfz2XvbYZoJ8wzUbrjvZJR0Y4MBIqOJj0J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDBF+gOBiK61oRzfcDzuwYLPILHCTRQHSWrqXWI33OcAZxFmehZkmGMj8cmvFfq825YByMlHTcJdmvunHlOW+bQeyeic9sp7hY6T/8CmwAhL64CZgZHgU6alFjyd4Lw6Q1nh7ucdDLbpj48IqTEE1gJQaYixhsqist0J29AqmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ+7M+e8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ+7M+e8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41744C4CEF0;
	Wed, 10 Sep 2025 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757491074;
	bh=6uVpYxLKgfz2XvbYZoJ8wzUbrjvZJR0Y4MBIqOJj0J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQ+7M+e8mrS/qUabUDxQGA+IrOlNrJ/W1e/kVNdL2rEOx9xwy5R0VZYrC5aKWmoN0
	 CFlRAkOhoJl0/qGhK75yDnQ1nmMpzrHL05fQvr8Ex6EA1HFx2t3MRamt8EcGv0wzbE
	 zsB8nSvKD+dQ7hyH6b2v/bs3POgOGyWqDgOlmRFbinttriUvWAUYF5hwLoVS5kUtI+
	 c6/hrqv5mVWzzmHUaTwalsO5jeGyG9DS4AFuJQHLVYQK1D+gCZ3bZYqIdEXA5hj/Dk
	 mJxUw5rUzCSLkV4Ayzz4Mi+U+N6J8JDprluIx8uja7fPPNfuE/9FvgKzGiPW1/OzV1
	 6wGhQ70VBn9xw==
Date: Wed, 10 Sep 2025 09:57:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?Q?Cl=C3=A9ment?= Le Goffic <legoffic.clement@gmail.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Julius Werner <jwerner@chromium.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>
Subject: Re: [PATCH v6 12/20] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
Message-ID: <20250910-encouraging-masterful-dodo-3d1f60@kuoka>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-12-ce082cc801b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-12-ce082cc801b5@gmail.com>

On Tue, Sep 09, 2025 at 12:12:19PM +0200, Cl=C3=A9ment Le Goffic wrote:
> From: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
>=20
> DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
> It allows to monitor DDR events that come from the DDR Controller
> such as read or write events.

Also:

A nit, subject: drop second/last, redundant "dt-bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/=
bindings/submitting-patches.rst#L18

Best regards,
Krzysztof

