Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A1275104;
	Tue, 15 Jul 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567594; cv=none; b=jLINz4C7CwD3GhBlqtkFbGF61uhSkKJviYskB4uPg9Kz2NCOLV8fZNeZpgY/z6MwuQAreUXl5Zg/gBFswyMSUze73vBnoYNiE8Q76wsp8O7ZgS0RSTLWTCqErN0ZfbxS1cSwNjzlSu8BOfq/oOmeotdPps2FajOWUS04p690/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567594; c=relaxed/simple;
	bh=BM4P1drWzjMjfg/pk0Xn1FWtYJygertGpkbq/ASGuqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyFLIFuze/wYZkLZmRu39SEc+Vg6v7HhZ6WnluCwQy6QWaRtKxLYP9iOE6qHKO/YyjR8yeHYybG997LCOsFqWrh0R1vtX2Pd0T1P8lXwZo+Nc2p7yTl3WX+uraTr51R0UCyUs3/CEBTjHKH0LgKHtu14DN8vIXOr+IyywkVA+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0m7zk3C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0m7zk3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24862C4CEE3;
	Tue, 15 Jul 2025 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752567593;
	bh=BM4P1drWzjMjfg/pk0Xn1FWtYJygertGpkbq/ASGuqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0m7zk3C0jSevJgK6jHj+8KsagqEKqsohNFNjyxuUufAK0FsT7yJNCNpaFOU4qIx9
	 u5U9AJpnkIbaI8iC8Dg4oZAecD5oub8zKKyVtM16y5Qs2D5okcKbPp5PQ8IKt9Mnrd
	 FUFZCnQ4p6IvkvCBWBTUgxF3w+A3Ri2VqbA0DuzPsHnsN6kywA88NMDdZGek85OLA1
	 yygBzAIe+X6glhbwR0mkYgosi0w9Rzx8T88TxgNpPWzn8IdAhtJxkJopO2XixHkdwu
	 tMo8uetR18UQcRZ8q52L5tdNT1W3eE/qPrDItMRTCW13sGPEVEo0ID28KDRWTsRwqn
	 ayjlkQsVSjg4g==
Date: Tue, 15 Jul 2025 10:19:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, 
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Le Goffic <legoffic.clement@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 02/16] dt-bindings: stm32: stm32mp25: add
 `access-controller-cell` property
Message-ID: <20250715-belligerent-savvy-marten-fbd1a5@krzk-bin>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-2-cdece720348f@foss.st.com>
 <20250715031717.GA4144523-robh@kernel.org>
 <765eccdc-7d51-42c6-bcba-07813077fc1d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <765eccdc-7d51-42c6-bcba-07813077fc1d@foss.st.com>

On Tue, Jul 15, 2025 at 09:37:00AM +0200, Gatien CHEVALLIER wrote:
> Hello Rob,
>=20
> On 7/15/25 05:17, Rob Herring wrote:
> > On Fri, Jul 11, 2025 at 04:48:54PM +0200, Cl=C3=A9ment Le Goffic wrote:
> > > RCC is able to check the availability of a clock.
> > > Allow to query the RCC with a firewall ID.
> >=20
> > If it is tied to a clock, do we need another provider? We have the
> > "protected clocks" thing, but that might be a bit different.
> >=20
>=20
> I couldn't find any reference to "protected-clocks" outside of qcom
> related code, is there a documentation? (Couldn't find it in
> clocks.yaml).

Huh? protected-clocks is in clocks.yaml... It is there with an explanation.

Best regards,
Krzysztof

