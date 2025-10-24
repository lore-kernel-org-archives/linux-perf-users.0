Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DA2D46CB;
	Fri, 24 Oct 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308270; cv=none; b=Pp6sfx4V/88aKoNbRakz1ZSynr2Vh4n0aNh7eAgBSORZuDxXv8hX2Z5TdyTEogXw4t5ietDR03azjfszwuwICTeASKREBzI+a9JwTywm2P5MCPShaybef7kkB/YJcKFVo27/bFUhCscwOpwHv5ILFX/+YK6nuMnCaSNbioC4jKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308270; c=relaxed/simple;
	bh=xycYvgv55zjJ+/ptA/lKdbtAAXXDhPEaqEymo84QQzA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iDD7/SbnseLusGAyrlpLMTHL5A16kjt8gc8VJRhGqe7Sx5TRga7BFON90Aq/rYq9zeiHPFzfMpW37NEk9+BpM8UEYbynSpdm0Bw7QeF0xXEGP+/MCviq4uEm12a9SAKKKhNRMZdxv/KTq6XfdeUz8U4a35/EV4827dxsnkyAVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Torm9VM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Torm9VM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B71FC4CEF1;
	Fri, 24 Oct 2025 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761308269;
	bh=xycYvgv55zjJ+/ptA/lKdbtAAXXDhPEaqEymo84QQzA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Torm9VM04gKI1mkDVARb43oL9vwvVx+JPTo8xSD36ka6LuxNYgyu7CKZZv1s82UBi
	 DSRtVFKSzTrbcvku9q9+b+Hf/Y3wy3WxH3xS+kRx3N/KPAy64deYm1F5chLTg0UecA
	 XszyIzo+bC2iP4ouJlYz5keD0PN1wNiAJfv5VXGnWZFbLe306TcPyHm8tLcpM0++Pq
	 YRwIH5E5Fp1ncITHAv1+rMnGWnHtqLA8RtVW4OWRhlqK8H9z7s1XEqzjh9uF/EhQ3f
	 6aUpNf0vNEquc+mx7nqV6knMiqzyejrBcuvn5+pGzHqvd6tqjUpstB53A2+oZxdvU/
	 inxEievyyauMw==
Date: Fri, 24 Oct 2025 07:17:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 linux-perf-users@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jacky Bai <ping.bai@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
Message-Id: <176130816644.1464192.1518129756905015635.robh@kernel.org>
Subject: Re: [PATCH 0/6] perf/imx_ddr: Add i.MX8QM and pmu in DB (system
 interconnects)


On Thu, 23 Oct 2025 14:56:40 -0400, Frank Li wrote:
> dts: add soc specific compatible string for imx8qm, imx8qxp, imx8dxl in db.
> driver:
>  - did some cleanup
>  - add support for pmu in imx8dxl DB
> binding:
>  - add compatible string for imx8qm, imx8qxp, imx8dxl in db
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (4):
>       dt-bindings: perf: fsl-imx-ddr: Add compatible string for i.MX8QM, i.MX8QXP and i.MX8DXL
>       perf/imx_ddr: Move ida_alloc() from ddr_perf_init() to ddr_perf_probe()
>       perf/imx_ddr: Get and enable optional clks
>       arm64: dts: imx8qm: add ddr perf device node
> 
> Jacky Bai (1):
>       arm64: dts: imx8dxl-ss-ddr: Add DB (system interconnects) pmu support for i.MX8DXL
> 
> Joakim Zhang (1):
>       perf/imx_ddr: Add support for PMU in DB (system interconnects)
> 
>  .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 26 +++++++
>  arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi     |  2 +-
>  arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi  | 30 +++++++
>  arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi   | 19 +++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  2 +
>  drivers/perf/fsl_imx8_ddr_perf.c                   | 91 ++++++++++++++++++----
>  6 files changed, 152 insertions(+), 18 deletions(-)
> ---
> base-commit: c31b21db1c04ba719c3889a57873f0f7eff54670
> change-id: 20251022-qm_dts-60145802537d
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: base-commit c31b21db1c04ba719c3889a57873f0f7eff54670 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/v6.18-rc2-24-gfda2253ceb14 (exact match)
 Base: tags/v6.18-rc2-24-gfda2253ceb14 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20251023-qm_dts-v1-0-9830d6a45939@nxp.com:

arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: bus@5c000000 (simple-bus): clock-db-ipg: 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: ddr-pmu@5c020000 (fsl,imx8dxl-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8dxl-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8dxl-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8dxl-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: db-pmu@5ca40000 (fsl,imx8dxl-db-pmu): 'power-domains' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqps-mb-smarc-2.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdps-mb-smarc-2.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris-v2.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dtb: ddr-pmu@5c020000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dtb: ddr-pmu@5c120000 (fsl,imx8qm-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qm-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-colibri-aster.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml
arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: ddr-pmu@5c020000 (fsl,imx8qxp-ddr-pmu): compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too long
	['fsl,imx8qxp-ddr-pmu', 'fsl,imx8-ddr-pmu'] is too short
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8-ddr-pmu', 'fsl,imx8dxl-db-pmu', 'fsl,imx8m-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mp-ddr-pmu', 'fsl,imx93-ddr-pmu']
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx8mm-ddr-pmu', 'fsl,imx8mn-ddr-pmu', 'fsl,imx8mq-ddr-pmu', 'fsl,imx8mp-ddr-pmu']
	'fsl,imx8dxl-ddr-pmu' was expected
	'fsl,imx8qxp-ddr-pmu' is not one of ['fsl,imx91-ddr-pmu', 'fsl,imx94-ddr-pmu', 'fsl,imx95-ddr-pmu']
	'fsl,imx8m-ddr-pmu' was expected
	'fsl,imx8qm-ddr-pmu' was expected
	'fsl,imx93-ddr-pmu' was expected
	from schema $id: http://devicetree.org/schemas/perf/fsl-imx-ddr.yaml





