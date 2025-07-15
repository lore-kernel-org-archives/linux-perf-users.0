Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E280B;
	Tue, 15 Jul 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549621; cv=none; b=C/XVzWqcBGuIZBWPy3s6Mf4ncBODzx51B0MafzoqE8yGvUhOAcU4EDEXX6X9KdeG9/VPagXKKUu8hMEx10L3DaaiP9FOtonpFrO2bskFtYBUDGc38ETMIk1vKH+a1y+rk7mXbItAGwHW9OuE/JrTe6P2ageFu9M+zGHE9AIaCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549621; c=relaxed/simple;
	bh=TDYuRWmFZrwnvk8qMS3AlGvkZ3xUWYu930vi3adDEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCqaYP5nxrM1X9ra+vZftmt3pgMMpm8pvWBSMsTXiD00pnK6fN6m3R/F6TgdGrqotxDCh/pC+7EO2eNvfS+/qsqw7CPeJV41syb1G5dMM9fle5tBe/dm7fx9pLZ0rXDY3zh0tJx7WtrEy45mTQRBfwvxkEOTzTKL8RJqSRPplQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhnvEVxT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhnvEVxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5B9C4CEED;
	Tue, 15 Jul 2025 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752549621;
	bh=TDYuRWmFZrwnvk8qMS3AlGvkZ3xUWYu930vi3adDEoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhnvEVxTxd7nbP4JvA3c5oAI7v4Uh1XECXIYdE/N/qy0huEeZvo77oD3clb4yTeWg
	 ymcvNK/OWxZiNy8QB28n853qDQu5Onfy2QbNM99FmG7C495d6/1pBwDdOtioibMSSr
	 /rlMD2bWz/hqVqcD18knvPH4J8lLajX/kcQ2Ilm7eWdWbm7ZGc4Q/ZTnOWmINuwNNe
	 BxX9zMQoXhN+gpCMRRtNwTSi0RuN0t+Gkpq8fEib5xKs3IOxjBmVBIpaSmzbYDP8qg
	 xOWvSr5FiKi9K5beUealNgIeVFiD9nCqjoctx0r+oRvwk+1p8VUoHmrFlNxs9LXyT7
	 106sWikoj8ffw==
Date: Mon, 14 Jul 2025 22:20:20 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Le Goffic <legoffic.clement@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 06/16] arm64: dts: st: add LPDDR channel to
 stm32mp257f-dk board
Message-ID: <20250715032020.GB4144523-robh@kernel.org>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-6-cdece720348f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711-ddrperfm-upstream-v2-6-cdece720348f@foss.st.com>

On Fri, Jul 11, 2025 at 04:48:58PM +0200, Clément Le Goffic wrote:
> Add 32bits LPDDR4 channel to the stm32mp257f-dk board.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
> index a278a1e3ce03..a97b41f14ecc 100644
> --- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
> @@ -54,6 +54,13 @@ led-blue {
>  		};
>  	};
>  
> +	lpddr_channel: lpddr4-channel {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "jedec,lpddr4-channel";

Not tested because this doesn't match the binding.

> +		io-width = <32>;
> +	};

What would multiple channels look like? I think this needs some work. 
Like it should perhaps be within the memory node. It's a lot to just say 
32-bit LPDDR4 x1.

> +
>  	memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x1 0x0>;
> 
> -- 
> 2.43.0
> 
