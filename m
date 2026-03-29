Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C11D6DA9;
	Sun, 29 Mar 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801883; cv=none; b=bK2urzXs2R8ageQ8OFQkBh/fOts0tGiWEKt5W4gfBbgrYifJhjFtg/5hmh4dQeUpMUIqcHj/nYAR6vq+nlghEQL795GYd3bs3BtAcNjrw6/zSUH+m8lCzYLiGQI1ZsvYhGG7bEp+Zfbr7dQUs6wFwUnYR5Q7gXt2JiWS82U3khc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801883; c=relaxed/simple;
	bh=ZAA7JFyEPX8fZJyDBVdvdGi1nyK6h+0PqK1+/WxNirc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qwYb10nbCW5W05k/GG8dednF4Evn8sioD4u1NWgbmsdcB2LnkjkvfMqEXz08pRt15q+f21ZLCkjq+zw0PvZK4wVwgsR/32lbZQcElS85LDqCJchTaZvu9Wik3Dh4b2oyaOd7sKe8er1p5m3YBlKujXa/94V2D+e0JvWRgCeEoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOHjTPog; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOHjTPog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8D3C116C6;
	Sun, 29 Mar 2026 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774801882;
	bh=ZAA7JFyEPX8fZJyDBVdvdGi1nyK6h+0PqK1+/WxNirc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=dOHjTPogepQX2xPxX0hSmlgs6yFDTWb04IexwKUJOV5zZC/AjlyyJpiKWhFAhchK5
	 4Tfw/5C4kMe88U8TQf0nU2m7IlO67ALyzPF8vBKIHZ2Xf8T2VEVkIwDKITFrvI18mr
	 VNksCc7KkQBtOhWwarHBXBYwwZr/cYKN4YwS1w5DGIOemZEoBmuUtXRxxCutqdWtcm
	 4XR0DIpHYtovyNLpCKcY2UdmZQfe8vVLfaBBnR0gz8AC/xpK1a1N3nF1dA8Uvw3RHT
	 Z29uR4gBQWrEVvZIaWfoYcU/1Kd/lG+XQbS7ncECd9s1iJfkPbrGMlnWA5TkE2AjGB
	 94lANoVkB8kUw==
Date: Sun, 29 Mar 2026 11:31:18 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
 will@kernel.org, linux-perf-users@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
To: Geetha sowjanya <gakula@marvell.com>
In-Reply-To: <20260329152439.10573-2-gakula@marvell.com>
References: <20260329152439.10573-1-gakula@marvell.com>
 <20260329152439.10573-2-gakula@marvell.com>
Message-Id: <177480187879.3821545.1418210029302677428.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: perf: marvell: Document CN20K DDR
 PMU


On Sun, 29 Mar 2026 20:54:38 +0530, Geetha sowjanya wrote:
> Add a devicetree binding for the Marvell CN20K DDR performance
> monitor block, including the marvell,cn20k-ddr-pmu compatible
> string and the required MMIO reg region.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> 
> Changes in v1:
> - Added a description field to the binding.
> - Simplified the compatible property using 'const' instead of 'items/enum'.
> - Updated the example node name to include a unit-address matching the reg base.
> 
>  .../bindings/perf/marvell-cn20k-ddr.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml:35:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml:35:1: found character '\t' that cannot start any token
make[2]: *** Deleting file 'Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.example.dts'
Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml:35:1: found character '\t' that cannot start any token
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1614: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260329152439.10573-2-gakula@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

