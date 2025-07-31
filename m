Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591839ACF;
	Thu, 31 Jul 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969967; cv=none; b=OOQNtjoBGoUUws8ie6D8OzJOkE2WtzyyEouJg4NgU1AKRf3ZICPMSXpiyHLY7qs07QgZylOXxyBvs8vKSPCbcRoS6nvWT3M0U8ncZ/kZ7cfkC9BOoMx9p4wYmyzWJfB07iY7qeF7mP24Qg7Ipmzg2JEk669V0xwp0RUxw03VSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969967; c=relaxed/simple;
	bh=XdzNgiFrq59/+bhLTk3tmfCHWzWelXvJVRNyC573BUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl6dcXPkUKMi7yPAyQbWVxWl3vhM95BMQz/LrmcHwP1dBru51BMLgZd8T5VJ0hCFEsn4LKxuMd79jsffJJ9BR9ME+aDQrqjieO8QXEteTAXmC9NvUGi3NzASI+u0nutaUVE7c/bhtZt9Byy3SFFcwIVHM5CB1ubCvurJcdWNpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfrGE2Xj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfrGE2Xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69D7C4CEEF;
	Thu, 31 Jul 2025 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753969967;
	bh=XdzNgiFrq59/+bhLTk3tmfCHWzWelXvJVRNyC573BUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfrGE2XjpbFnGJ4vZ2vCSUn4m0X1yMDzIzKdb/bOuAc4BemdM0NnaN8PrBSP1LZpp
	 q6Kz3ikx8T6953wCUG/S7HKiVL9R1mk87ZfE1MU0R+RQHHIYgp4OXhIjSFio9yKhbN
	 MA/ccfQtI8HsmS5xBsIxtQ22DH6gkPdWYKhL+tXU/9cGmRAzsH9dmPqIwzWcxlqQn6
	 wQ5Uz8WpWl3EQeVdwjs9rSyIg2yFXJfh87CrW374TtX96gS4wRWZKB9YR8VhUsla2r
	 xbj0S4w2UXYPqaS9a5eiBk/uGegJgJ3zoOD6anzlI19S8ZvSNDbkzyBGFPwBsCoPoY
	 O9et9Z1d+V65g==
Date: Thu, 31 Jul 2025 08:52:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Cc: Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Le Goffic <legoffic.clement@gmail.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Conor Dooley <conor+dt@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/20] dt-binding: memory: add DDR4 channel compatible
Message-ID: <175396996558.2138050.15303219446364860423.robh@kernel.org>
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-8-03f1be8ad396@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728-ddrperfm-upstream-v5-8-03f1be8ad396@foss.st.com>


On Mon, 28 Jul 2025 17:29:39 +0200, Clément Le Goffic wrote:
> Add in the memory channel binding the DDR4 compatible to support DDR4
> memory channel.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

