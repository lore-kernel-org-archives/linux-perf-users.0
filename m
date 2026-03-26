Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF03CEB98;
	Thu, 26 Mar 2026 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521197; cv=none; b=fNvnZripIXm218+Rr+8eFWFPc7LJqO0vBUojAXJDNhHMGO/QsaDxJhZSI/pnJGL/WrKbigGkWJNxydOB5G1NM8EPhvmrDVhKpdbLCdndjiJLf0kDfkp16ZXawm+LhIc+j/fjSuXNjmpwa1EJapfe2pczb+OJT5QFqt+SkNEXUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521197; c=relaxed/simple;
	bh=NyCZxhrmAGFbyrL6h2c2w6JZvW0gffjIb4o1sEXE/4g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fQ+7nCZpMlP6djvBTWbScmtbP6/z6MbSBWDyQHergtCfL9WkzDMKAhhJ0JnsD0DkozQ2iNeCrx5w+pLVFHLdsnaWBVNuSyFDBdxhX/egA7u2Pyy3d0jacxSGadiYDsK63ajpd0zKRQRkk7v58t4jyYO4nd+QuJGl8w4R65UJ9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C94S+xEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C94S+xEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2844EC116C6;
	Thu, 26 Mar 2026 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774521197;
	bh=NyCZxhrmAGFbyrL6h2c2w6JZvW0gffjIb4o1sEXE/4g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=C94S+xEBpyEIESagZYsh6vWRmPxqlxpYq8f+4SuY2THKpf/FdX9VBeOUuEJPAGuZ6
	 MLZcIml1C3R7WhiYcNN+yxjDjmz9nAa5NOJPXrj0yqlwtf/A6x2iiR4ObLgs3u0V8m
	 vnj3MS00gVVjTevcNP8QFZd15DSzbPUJctmh7fFGchJyI23Cer2OtY7vzM2kp2GXIL
	 TNazfChQquXqpy+AoWcU0awhaRUYN1pGGxGLLTvDu422fZi1zC9E6A9u/57jyrd/vD
	 U9lTVqHtQJwSxklSTcMvF5bwwZO14Esba62N4mrK9vjEJQYLyg53uuzzfu4hFjNXaN
	 BG45J7/0eW1eQ==
Date: Thu, 26 Mar 2026 05:33:15 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mark.rutland@arm.com, will@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org
To: Geetha sowjanya <gakula@marvell.com>
In-Reply-To: <20260326090645.22590-2-gakula@marvell.com>
References: <20260326090645.22590-1-gakula@marvell.com>
 <20260326090645.22590-2-gakula@marvell.com>
Message-Id: <177452119218.1921575.14174289122061565308.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: perf: marvell: Document CN20K DDR PMU


On Thu, 26 Mar 2026 14:36:44 +0530, Geetha sowjanya wrote:
> Add a devicetree binding for the Marvell CN20K DDR performance
> monitor block, including the marvell,cn20k-ddr-pmu compatible
> string and the required MMIO reg region.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../bindings/perf/marvell-cn20k-ddr.yaml      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.example.dts:22.21-25.15: Warning (unit_address_vs_reg): /example-0/bus/ddrcpmu: node has a reg or ranges property, but no unit name

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260326090645.22590-2-gakula@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

