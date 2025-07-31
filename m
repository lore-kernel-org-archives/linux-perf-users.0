Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B312D191F;
	Thu, 31 Jul 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969996; cv=none; b=on0teBuQCxQ/TJUsO66VC8yGsgxZHKZlP1Ssth2zSmoTgTfxuIsCI7ypO+9mRY3vavHJWw9gTcOF6t2E/VN7jFc+1FZ41h95TfeTxCMDvz+jwSd2oPrU5bI444da4nGTH6Uct7bNj+999fb7GIIOWgplxPE4yoM/rGxsrdu2HIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969996; c=relaxed/simple;
	bh=yXz5mBUZF6Q+N9j0CfMMnnCvdMIaf13rIadj2MRnX6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbY3uCVNrYUlewGMInqx3VuVblFc00d8oOzlQqgbLo8yb4amdPzG4xxex77OAfOm2a6DJPA66dhHxOA2FkVfyvEUWuIHMjjTqMwL45qwJdPsuxbQ25r518CtxPtTocAxTYWD9uMt1UnAu4UpCmQcDmpmbuOI2DQUY7ZZ6NJQQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuKFVyrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuKFVyrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAF4C4CEEF;
	Thu, 31 Jul 2025 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969995;
	bh=yXz5mBUZF6Q+N9j0CfMMnnCvdMIaf13rIadj2MRnX6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuKFVyrU6RyPSXasWhoG+PZAXbRQvg71zY3Sb4uTSLtkzVcZM0ctCwZO3WwvbrI09
	 ofP7XRFAPu1cfff9IQtvv+PsZrp7DYf2mrsMz4ChCf7VEdMnancKGYNTWTjE6nTgv4
	 jkH4N26DgfRG0wbOfGY5i72biU7CN1WqAAjiYVz3VcYFVBazuo0nDfZbuitZk1w+Qa
	 t1dnTWlsxZqR9BiurwrZeHrk8ddZNmlW4lAIpMUpX2ytaljEbDNC2ctWKdiOTqCGJ7
	 Uccf4zOgOrnGHzrK+5ybIUOuYGenFyIiknGkpjqzCdoVc7TLn//RW+GppLnn3oeaof
	 /JXo+hqbBlLwg==
Date: Thu, 31 Jul 2025 08:53:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Julius Werner <jwerner@chromium.org>, linux-clk@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Le Goffic <legoffic.clement@gmail.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-doc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v5 09/20] dt-bindings: memory: SDRAM channel: standardise
 node name
Message-ID: <175396999408.2138783.9344122999119698215.robh@kernel.org>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-9-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-9-03f1be8ad396@foss.st.com>


On Mon, 28 Jul 2025 17:29:40 +0200, Clément Le Goffic wrote:
> Add a pattern for sdram channel node name.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml       | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

