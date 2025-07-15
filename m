Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED41E9919;
	Tue, 15 Jul 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591746; cv=none; b=RukhKOyPwEDS8k5weBMScdeyZXQ6vxvdP7ho7afFeRksXKw0qO/L+KFo9c8XNOovFVnNYM7hTKhMpjDsVjE1qXgybIpyD91HUaYIQ180RDxc2U7iLMKsNQ/vQIpDqd7rI5YZOFp5r0+gB8+dkkzhviZHf6VI8kUYq+CbQMZzokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591746; c=relaxed/simple;
	bh=exdnCy6Q0C3xztw8Y5wA0w4YeM3tO9kw+ROGW6J34Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j62E4IzItlB0YzpWZ8vYjpbLz4ppI3rsTwHlIscwJVprhMMLsfxTdIzFygGD2S9Qk9U8rx7K+61aybqfHFmL0d3gI4UTaTfxI0doZkFKu+hkeg4JYmbubCLR+rhSBAIOdjNumG4g4CQOSfQ1qawNQvjtOOY5cJNNlQa1CI6DgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3nVs5JA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3nVs5JA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A969C4CEE3;
	Tue, 15 Jul 2025 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591745;
	bh=exdnCy6Q0C3xztw8Y5wA0w4YeM3tO9kw+ROGW6J34Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3nVs5JArxYZr5IH2Ok+/K4hHyHoWBVdGIoU6WY8tNh0eZVhrimCIIocOoTFKgPJd
	 ZY8KvLnsN9tFCaasqmMFKfi17RPbEEOvbvE1XJIf72g/np8VLh7I+KENFzR+c6mJ1/
	 lREjBaJpi3lTbwvoKrglymKwsd2cFD6hR2i+eNWA11UDOgOzp+dBD2/d1FHvGiZMOO
	 7smub8SEg4+w2NOnrTOBV8tyvOb5iUl/7hAf/J63avI/ml4S8tKpDgM6GIPX8N/Qqe
	 0PRTfmcpzkLp+wV/p2hKVJhMhgdC9QZH8kjTRduAUoGsgh6ImOHdA7WFvZKdPrx1Pm
	 mBI+wFd67+pHw==
Date: Tue, 15 Jul 2025 10:02:24 -0500
From: Rob Herring <robh@kernel.org>
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
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
Message-ID: <20250715150224.GA1319886-robh@kernel.org>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-6-cdece720348f@foss.st.com>
 <20250715032020.GB4144523-robh@kernel.org>
 <ae960a16-65ad-4b22-b9fb-89efbffacd3e@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae960a16-65ad-4b22-b9fb-89efbffacd3e@foss.st.com>

On Tue, Jul 15, 2025 at 10:32:09AM +0200, Clement LE GOFFIC wrote:
> Hi Rob,
> 
> Thanks for the review !
> 
> On 7/15/25 05:20, Rob Herring wrote:
> > On Fri, Jul 11, 2025 at 04:48:58PM +0200, Clément Le Goffic wrote:
> > > Add 32bits LPDDR4 channel to the stm32mp257f-dk board.
> > > 
> > > Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> > > ---
> > >   arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
> > > index a278a1e3ce03..a97b41f14ecc 100644
> > > --- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
> > > +++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
> > > @@ -54,6 +54,13 @@ led-blue {
> > >   		};
> > >   	};
> > > +	lpddr_channel: lpddr4-channel {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		compatible = "jedec,lpddr4-channel";
> > 
> > Not tested because this doesn't match the binding.
> 
> Hmm, I've tested with make dtbs_check and dt_binding_check and it didn't
> complain on my side.
> What I have miss ?

Oh wait, we already have a binding for that. I was confused with your 
adding "jedec,ddr4-channel". Sorry for the noise.

Rob
