Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6D79F2;
	Mon, 23 Jun 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674745; cv=none; b=Vl3VLhBiutKKNKUHOugcHd4HQ2fx27BPGhz9p2PYugzcWs0SQKLAjK4jWHqXLekNFhOWP/54hwsmoy0aOM0+bSeNy4j2FH/Gy8o2wdCEdMhCL1CYz40+bDKvBjZ7+v0Wom40gGJE7Zc20jEhm3qHGH2RVeHGTyL9YvOvTHZ6iXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674745; c=relaxed/simple;
	bh=EGeyXFdsfxr7KZpT6G79mftHlRMgrE71/+ChmGLxj2A=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TYqT7Wz1lss1+eYhEENEPjc0mfC+4bztKM67eStKMfX5G5vYDSVKRP0gdW0F0HkNOm9OduXpX7xkYR8U/gdl89vioXRj8Ay0Z0sghtjdSTiGtWAlATiC7Y0D+O39sm6GmF9wc5oymdqVvJ9bWTM5EDARZ/v1bmyJB779CFAsJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/otWl7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/otWl7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07916C4CEEA;
	Mon, 23 Jun 2025 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750674745;
	bh=EGeyXFdsfxr7KZpT6G79mftHlRMgrE71/+ChmGLxj2A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=b/otWl7mH6gUD6120u91A4shQyhwDjQK/XF57IoyHx/pvO+4w3pCfYB8NNfroQzxv
	 dgcukgYvgsY1ds1YaeKUOrC6Zs3ly4TcxwiX8n9eQkHBm5V+FgnS4ZuiznXEj7nI84
	 xrnua+iSQPdPAXWvw1ZS0nftkw+8zQAPS99gLXvovcJbHkNCwTEVEJxVPO9dMb8x88
	 iJJDxLAKEeyTncO6PqV7f/0L6y8VJUOE5+QpnSW9piE/HSs6r3fu1GI+3SQGwRJjfW
	 TjvlC21dh2u1zGaPPj8habmBy8SXpKSa703cbJQ2FmClzEXYaTtY0TcyfSVo5Zahqv
	 Bp6w9Auijcd2g==
Date: Mon, 23 Jun 2025 05:32:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-doc@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-clk@vger.kernel.org, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Will Deacon <will@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
In-Reply-To: <20250623-ddrperfm-upstream-v1-2-7dffff168090@foss.st.com>
References: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
 <20250623-ddrperfm-upstream-v1-2-7dffff168090@foss.st.com>
Message-Id: <175067474413.2253758.6430293849129423927.robh@kernel.org>
Subject: Re: [PATCH 02/13] dt-bindings: stm32: stm32mp25: add
 `access-controller-cell` property


On Mon, 23 Jun 2025 11:27:07 +0200, Clément Le Goffic wrote:
> RCC is able to check the availability of a clock.
> Allow to query the RCC with a firewall ID.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.example.dtb: clock-controller@44200000 (st,stm32mp25-rcc): '#access-controller-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/st,stm32mp25-rcc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250623-ddrperfm-upstream-v1-2-7dffff168090@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

