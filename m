Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3A38F23D;
	Thu,  9 Apr 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722241; cv=none; b=Dag1BfZ5fEG4Azq1uiMp7xJGg3kQPCcIC6N3a9MJ+SEEZYj3fF3Opt+SgBuHxyrQmRLZFgc07WN3J408tkUtxKGI/wy/pN/F0myAX/6lbgiK4xcH0lf3+L6rf+UGM1GvgQkCnESExRIgxH3Kj6IKNpABQxYMCa/zBKY67E0aC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722241; c=relaxed/simple;
	bh=J+SGhUD52q5MWINYcfndMkcY7ldyo5b2pp4NmBb+LWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8Evi1KMYaXUos7PxZxpoMU1xB2t/Kzdtni7BDa8MMjlf/RZPXThRnTvRRz7VBAutm7Ua07NBftCYTjyzOR7wf8+Ud0vtN47DwoeRpuQl1UGFWUhoI/WxBlvPZoYy68Dbd2TLZAby5hkbv9jI5ktt8X3xS3OBjpoFxz9G5QtOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q60cZPU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q60cZPU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C7EC4CEF7;
	Thu,  9 Apr 2026 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775722241;
	bh=J+SGhUD52q5MWINYcfndMkcY7ldyo5b2pp4NmBb+LWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q60cZPU9qf6dJig+MFrL+jfcD6RH0ObI/ZZwaOsOToE1hixUItSRWHxg2396ZJ2I/
	 tQ4T8bsVdy6QqkGlZMxQ0EPDW18ip3rzgQrI/axSJitdOgIe3hYVa+YnbcwIbC3aNC
	 VC3T3u5ycvdTTk9etEKVVJggnwD82PKUK9F67aFXIuMSea6KusYYv1lGkjJw/WbiTV
	 x26xFdEcGWt+0ZuOK5IcjlMh1I6Uwgg50QlVg0+WgwZKUE1XqwerB271/DIOlzVkFT
	 jfOoipRfIHgX0/q/m45EolCcCZkHpEIzYbHm53LIB/7f/xSInShH2ccyrU/7COSgzj
	 R0tUajRsa09GQ==
Date: Thu, 9 Apr 2026 10:10:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: iommu: arm-smmu-v3: Allow PMU child
 nodes
Message-ID: <20260409-outstanding-arboreal-peacock-2de6f1@quoll>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
 <20260408-smmu-perf-v1-1-d75dac96e828@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-smmu-perf-v1-1-d75dac96e828@nxp.com>

On Wed, Apr 08, 2026 at 03:51:15PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The Arm SMMU v3 specification defines an optional PMCG (Performance

"optional" in a meaning some SMMUv3 implementations do not have it?

> Monitor Control Group) block. Per MMU-700 TRM, it has three 64KB pages,
> with TCU Performance Monitor Counter Group (PMCG) registers starting at
> offset 0x02000 in page 0. So PMCG could be described as a child node of the
> SMMU in Devicetree.
> 
> Add a patternProperties entry to the arm,smmu-v3 binding to allow child
> nodes matching "pmu@<addr>" and reference the existing
> arm,smmu-v3-pmcg.yaml schema.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 82957334bea24402b583e47eb61b5724c91e4378..1d09c5476e5f1a7c3e5c935b677641ee6cc9897e 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -50,6 +50,10 @@ properties:
>              - cmdq-sync   # CMD_SYNC complete
>              - priq        # PRI Queue not empty
>  
> +  '#address-cells': true

Instead enum [1, 2]

> +  '#size-cells': true

Same here

> +  ranges: true

I guess only one mapping is allowed so:
maxItems: 1

> +
>    '#iommu-cells':
>      const: 1
>  
> @@ -83,6 +87,12 @@ properties:
>        register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
>        doesn't support SMMU page1 register space.
>  
> +patternProperties:
> +  '^pmu@[0-9a-f]+$':
> +    type: object
> +    $ref: /schemas/perf/arm,smmu-v3-pmcg.yaml#
> +    unevaluatedProperties: false

Please add another example with 4-space indentation.

> +
>  allOf:
>    - if:
>        not:
> 
> -- 
> 2.37.1
> 
