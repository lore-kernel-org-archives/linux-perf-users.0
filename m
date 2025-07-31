Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5361E502;
	Thu, 31 Jul 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969804; cv=none; b=t/fvFR7fmJM9O3XIz0BppctDmkqTlaerywGS7mNVaE5WLYHtPP1j7LMUmssor21pgpOgOvUbEl3bHtcHWQwTTCUhkVN1det0pdFbNkyngoSchobAS5Db94tyhMUuBIfDU7BOgurE68KftS3dphrfDzx+v3VW4+FAtpr7livlcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969804; c=relaxed/simple;
	bh=jawTeo3jrKl31BlPRVIr+R1PBzhaxmiMePBk8kxuwVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJzO03ywRHSBoj3AlxXLAACFF2YPRJl5cDxvekkMod9BZ5XrbTfBKEf/JQhbKqAhoI1C6259T7huHopdqPgqIbP+gXx+5FY9+ooy9X9QM/L+6tx7tsVcQIPhZSUt4F3fzGIUyenY3PyxIkz3S5moNwe6AQMKs6YB0lQUWKXYA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYvfVm/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYvfVm/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466DCC4CEEF;
	Thu, 31 Jul 2025 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969803;
	bh=jawTeo3jrKl31BlPRVIr+R1PBzhaxmiMePBk8kxuwVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYvfVm/ZsnER1HAKkEC4ux4CBvQVHusXAIuQa7z1ZbnKXII3hVV0Vn6nrQDFfiX8s
	 IRdZpm0EQQII1M9WaXzoygW+pWRitgstvVXD/ZlpibPf1tutHLt/QsaliYM4OU3u1w
	 qBs4XJvMcr091e+bw3lFfjJr5tAIDLaOboOA8r+jbb8ev/LYEcDbA4keqduCjzqmdL
	 87p7crjoiKMwL4dJ7CAtIp7BJ8bfAGCAtE9FYCezeSVRHNfEcSxoPRB0kF+Mg8B3Ud
	 sHuncQm80xlb2D2GQQ2hL52M1WqmHfZ0HkZnwQ9KqTy5t+q6zDZXtJgCkz2Pu/yzqc
	 oyDag2pTvuaUg==
Date: Thu, 31 Jul 2025 08:50:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Le Goffic <legoffic.clement@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Conor Dooley <conor+dt@kernel.org>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-clk@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 02/20] dt-bindings: stm32: stm32mp25: add
 `#access-controller-cells` property
Message-ID: <175396980193.2134840.5721329894183158883.robh@kernel.org>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-2-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-2-03f1be8ad396@foss.st.com>


On Mon, 28 Jul 2025 17:29:33 +0200, Clément Le Goffic wrote:
> RCC is able to check the availability of a clock.
> Allow to query the RCC with a firewall ID.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

