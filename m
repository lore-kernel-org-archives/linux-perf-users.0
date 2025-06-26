Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D119D06A;
	Thu, 26 Jun 2025 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972758; cv=none; b=q6/RqvBao/iB0lpv14h1LDVCAKF1qLbVxFmceEbNzxshFyHWG46RWzzQEziS6qicjQnXNv02BEJCBGUjTrsBRkA5NpLfx4+wNGVDaZlNAKeh+Wfv3nTQi6SY4CYfs9MvtgtD7I0XQzch/4wjJwYQisyej6P/ajxWL9QP1L6vFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972758; c=relaxed/simple;
	bh=28uNc/vEFpqvghgBWV99ylJqmaORBokqPOIAZlT5Edg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tuT8ZMo4cy5YDUXyk92dx/FxWZZys3v6PcuTU/2uawxkhQtMs0d3Lzi1CZtPbdKVdB+/7sEUpSjEVWKsNtz3shd+chsdAw+16yKdj8xJ2+O9tT5l+OWDX6K3TGvccBLTN/ugweROncpo7w6P3jMG3b5vB/mU648BpXycXamdMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbF9XJlu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbF9XJlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9E8C4CEEB;
	Thu, 26 Jun 2025 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750972756;
	bh=28uNc/vEFpqvghgBWV99ylJqmaORBokqPOIAZlT5Edg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bbF9XJlul92CmEGz3T4uQ+yndC/DlJOuuo42kGpnawZlzPRbvVNUAo6S1NnSvvvqJ
	 mGLgTWTcyPGSpu74VJjKbv8HrO3lcGcLqj1eTACiGW7PwR8fKbklDtULObkihl1Ue7
	 PPi/EI5Dw3ZMUccOKbL5/fISnsfHPTQxB5cUEivQV8vItuLr6JxecvCBNO1YEENwqQ
	 qcc0e6LguLIwq34dOxDixADb2i9t8PlGSiIgwYXD8AGhrgiVvX1JWn+6kQnV80QWcf
	 9L6Yh0PXMyH5ilHF58rjqvrbzb3ZepOM25v3iGmIcC2smqNXGYYbswVPhcDu5IrXtG
	 6c47qfe4l0hgQ==
Date: Thu, 26 Jun 2025 16:19:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Mark Rutland <mark.rutland@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 Will Deacon <will@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
To: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
In-Reply-To: <20250626-ddr-bindings-v1-2-cae30933c54c@foss.st.com>
References: <20250626-ddr-bindings-v1-0-cae30933c54c@foss.st.com>
 <20250626-ddr-bindings-v1-2-cae30933c54c@foss.st.com>
Message-Id: <175097275573.957711.15313846796838099778.robh@kernel.org>
Subject: Re: [PATCH RFC 2/2] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings


On Thu, 26 Jun 2025 21:48:35 +0200, Clément Le Goffic wrote:
> DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
> It allows to monitor DDR events that come from the DDR Controller
> such as read or write events.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> ---
>  .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml: ignoring, error in schema: properties: compatible: oneOf
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml: properties:compatible:oneOf: {'enum': ['st,stm32mp131-ddr-pmu', 'st,stm32mp151-ddr-pmu'], 'const': 'st,stm32mp251-ddr-pmu'} is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml: properties:compatible:oneOf: {'enum': ['st,stm32mp131-ddr-pmu', 'st,stm32mp151-ddr-pmu'], 'const': 'st,stm32mp251-ddr-pmu'} should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml: properties:compatible:oneOf: {'enum': ['st,stm32mp131-ddr-pmu', 'st,stm32mp151-ddr-pmu'], 'const': 'st,stm32mp251-ddr-pmu'} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.example.dts:44.37-47.11: Warning (unit_address_vs_reg): /example-1/ddr4-channel@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.example.dtb: /example-0/perf@5a007000: failed to match any schema with compatible: ['st,stm32mp151-ddr-pmu']
Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.example.dtb: /example-1/perf@48041000: failed to match any schema with compatible: ['st,stm32mp251-ddr-pmu']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250626-ddr-bindings-v1-2-cae30933c54c@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

