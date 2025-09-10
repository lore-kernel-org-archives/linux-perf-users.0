Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FA2D24AC;
	Wed, 10 Sep 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491028; cv=none; b=uYaA21t0w2CGpDvfaBb30y52AHjU33fIx4fKAGmGggBMDqZXJpcDgo2Tg2oBhnw0NzzyUgcOEqtJ8KuDneHHtXJvHe9K1mUuHxFjDWiJYDDSYSiNca3F5aJiHXX1RPHQS5HOssGjxWVr6mytDtxNfRyWN53dg5nzKUEYHc2xWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491028; c=relaxed/simple;
	bh=9fjD2fNRSaM8UgWVZRkBtaZv1nqX5uwHyIlpPz0EWXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB8CXGFN3IRGu5b12TaKMAoEtSQU7uKTRkh031yzQzaUl4R++3qgx9AGhGWSjujUvP1PcUDcEdXC+VsOCBSXMV20moTCqkV81h7Fow5ljc/0MK/dJu8yUYAZQzw6kxzudPAy/TzVJwlpsBA4t6AoyfckGGcy8YuJ29K0oIyT8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaLZpnsm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaLZpnsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F7AC4CEF0;
	Wed, 10 Sep 2025 07:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757491027;
	bh=9fjD2fNRSaM8UgWVZRkBtaZv1nqX5uwHyIlpPz0EWXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaLZpnsmrHrGGLP+0KguzRFCRfaUyvd8cTnmNsdxhg0gWm2UTWQ6Uo+799KsWNSym
	 CrhsRXZgc8VeqUDQ3XRRqKG6KXv3iR6Wf5CeDAZyZRbqRB5k/o5xfwXknqNEN9neoA
	 VgLtVqNSaQmLc9iKjxB30OcWaDJKHvc2TCk64/46ZwBNAJOlwtrWPI7Fr2/arNJxwM
	 ZCKIt0zrgNySUkCx5ycX5hyuNwSEF1PWfMyln4YO+5Vxg3qO5YVxDOe+z24g8ksHOz
	 iT354QBmykiQdgu59sVJGEwJFmmv+oImcIKDNKRvr67QwsclSwr4QjHX8wyL6yDlQ0
	 l4Rr09eDm7cZA==
Date: Wed, 10 Sep 2025 09:57:04 +0200
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
Message-ID: <20250910-adamant-hospitable-firefly-ae30c5@kuoka>
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
>=20
> Signed-off-by: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Cl=C3=A9ment Le Goffic <legoffic.clement@gmail.com>
> ---
>  .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 94 ++++++++++++++++=
++++++
>  1 file changed, 94 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml=
 b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
> new file mode 100644
> index 000000000000..1d97861e3d44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/st,stm32-ddr-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +maintainers:
> +  - Cl=C3=A9ment Le Goffic <legoffic.clement@gmail.com>
> +
> +title: STMicroelectronics STM32 DDR Performance Monitor (DDRPERFM)
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: st,stm32mp131-ddr-pmu
> +      - items:
> +          - enum:
> +              - st,stm32mp151-ddr-pmu
> +          - const: st,stm32mp131-ddr-pmu
> +      - items:
> +          - const: st,stm32mp251-ddr-pmu

You did not implement Rob's comment.

Best regards,
Krzysztof

