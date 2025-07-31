Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66739ACF;
	Thu, 31 Jul 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969925; cv=none; b=IEA47UAG704WulION9g/dtu2KR7hhLR3S+Z8vvxQc0oeddbwMzseODGBDD6MOudIyzwN10OV1L1snto1J/sFDUsQfOIJaumSkuP0Ua+y0tebPVry219LwpX8h+mDGaFv0y6Aa5f94nrZweYhZ78jt1LNZF+GZLvLVO5lPXCrX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969925; c=relaxed/simple;
	bh=VVahUZQ1Biwbin4MULCT2k9NK1SumhMf83loM/viyg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb7Ytxk9gdBStTJwtsNohIV3QlQ9wDu4dl/fTLuIZOTjTg4AJZGe4tTPCwBcU8wIn4EPWyOISbyUsh5Dp8pyg6MKcwyZlyxYbOwUofKPMpgNAWH1lP/YF+GTtX9EA3X4zT6P8md53jRuY8N59GrtJTOp/3wbCVf9zqO3xmh7wwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjjlSHCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjjlSHCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E67C4CEEF;
	Thu, 31 Jul 2025 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969925;
	bh=VVahUZQ1Biwbin4MULCT2k9NK1SumhMf83loM/viyg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjjlSHCStIOMpeo15olXb/biIbvxMM69OjYpZCudIwwOzoPQf1zBLe89/aFhlUOvV
	 3F4703yIk33j41LiugyF4QgiVFY6nDdYD3d+KdMLueqv+pAsBp8izXLVL3QKz969xH
	 zWQnfelBt1oXl7k9zdWL5n9YqchwmJDkyyZRv3ExfRJBfy2GWoK/BjluA6hTB3Y4/R
	 JKpdvvwFD/aI6Glj41dXNcq17R3161h+BtL4ehO9BDx0v7+miQ39KnqiwnE3fR+m/S
	 sY+6oYRrhcWpa6XWyGo7GM3KHVUkdFH6tt1DCOyZRml9dnUj6W6+I5zUWFK4P3f7po
	 11PzPv+LO3guQ==
Date: Thu, 31 Jul 2025 08:52:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Le Goffic <legoffic.clement@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	linux-perf-users@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Will Deacon <will@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 07/20] dt-bindings: memory: factorise LPDDR channel
 binding into SDRAM channel
Message-ID: <175396992348.2137172.17706395913252452350.robh@kernel.org>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-7-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-7-03f1be8ad396@foss.st.com>


On Mon, 28 Jul 2025 17:29:38 +0200, Clément Le Goffic wrote:
> LPDDR, DDR and so SDRAM channels exist and share the same properties, they
> have a compatible, ranks, and an io-width.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  ...lpddr-channel.yaml => jedec,sdram-channel.yaml} | 23 +++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

