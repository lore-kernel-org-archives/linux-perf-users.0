Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C9301036;
	Wed, 10 Sep 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490891; cv=none; b=r7QfbAmtjrQhpreNXS8GWPiwoxQAjcIAl9z9CTvlsOCjX/XLH0R0uQQMl2BmbjJ+3ybL5HCbm8OcrbPPU3cgy8rvROFJGi1GxejcMzLJmPG8m5c86sIUh6vGFzWMdY6QPno4G8lJqc39bjqvm5GST/3B5FUTSsJEwV3BDprc7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490891; c=relaxed/simple;
	bh=/Cvlcl3lSVxIswV9jynJ/e4AYCtz89efpAEudugYMIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlK4Dy1GhtzkOrxnqHNpO4M4mYGSQuKcErk7jIqDu4jEZzvQ/FpGfE5nTWS7ehXIwn9dmiEmZeDT0yf8M0dIw55/c4eR9F3jKqVe8z1ILeAQ99EZPs8I6ZhK2Sy1Sqsezt8qyfnUNKh97YDRcEDV5sD51qFiyZ8OwMlGkW9D4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByAqknhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByAqknhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF3C4CEF5;
	Wed, 10 Sep 2025 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757490891;
	bh=/Cvlcl3lSVxIswV9jynJ/e4AYCtz89efpAEudugYMIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByAqknhQxTz5AuwNFMa3NeXS+psWNlXu858IH8RhV5WRDRT6/Er16498NMAI/6bBD
	 SsC6di1+qrYZKG0/JLFvcqTvMr778/sGlSuvjhc3v7KNFW/kHbl2CwMpRFR4Bu051l
	 ErX7CASZW0ejiZAsqXt0gFlI0gWrH7YNL4Xmy/DMDRBbPry/DVhl/4pP5qqFKV8f2x
	 h8yd10TqVJiygJy32AMSB5ilvaj42MMp/VVLc9xh6do1MDxS1tIxU07JPOTLpA805e
	 e8Cp5j4A/PLS0IIY/yEHZyxPqkY8mah+LGTBZfNzP7ncfQCPQbt5Z5LJlbCiidHE0R
	 kPE8/SWr9/cPQ==
Date: Wed, 10 Sep 2025 09:54:48 +0200
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
Subject: Re: [PATCH v6 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
Message-ID: <20250910-flat-raptor-of-temperance-5e8c7c@kuoka>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-5-ce082cc801b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-5-ce082cc801b5@gmail.com>

On Tue, Sep 09, 2025 at 12:12:12PM +0200, Cl=C3=A9ment Le Goffic wrote:
> From: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
>=20
> LPDDR and DDR bindings are SDRAM types and are likely to share the same
> properties (at least for density, io-width and reg).
> To avoid bindings duplication, factorise the properties.
>=20
> The compatible description has been updated because the MR (Mode
> registers) used to get manufacturer ID and revision ID are not present
> in case of DDR.
> Those information should be in a SPD (Serial Presence Detect) EEPROM in
> case of DIMM module or are known in case of soldered memory chips as
> they are in the datasheet of the memory chips.
>=20
> Signed-off-by: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>

Is this email defunct now, that you add second SoB?

> Signed-off-by: Cl=C3=A9ment Le Goffic <legoffic.clement@gmail.com>

I still see in this patchset around 5 different subsystems. Nothing in
the cover letter explains the dependencies, so grouping looks like
coincidence and you just make it difficult for maintainers for no
reason.

Please organize your patchsets per subsystems, see submitting patches
doc for more details.

Best regards,
Krzysztof

