Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795A3B8BA4;
	Thu,  9 Jul 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625218; cv=none; b=fD2xZcsqIekW0WI7W/eQpusZAn05HiN+2HQpuA8taqtQd3MSTZIHqJYemuBr0/GvKje012Lg5bEqPjCBi0pMo2jk5z1aMnKGz1+ZuwTgOeCcmP1skvvcc23FRmdZ02Mrbw+BqD8pj5U4VD/+OFXO3Y8O6J8BlOsg/0UDG2V0CRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625218; c=relaxed/simple;
	bh=WYcBq+2OehXUkps9RBfzqulNDwbhuWbGqAnSWT50caA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GGwhq7gHTKoqm92EqNehEfYIaxZt6VMIIilxInGPhkCOYeB+xWcc+d9+IOzHkHpdGdHVyrIUuEd6v3i6I+hifHg5oKl5yA118vBEj6/cVFkR3y/Ee0T5PPeDJ/hx3GccGsLNV7pY6Nz8H6MSLviTGRV/7zRrZ+PkaC9trvSv/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pnkbbwv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pnkbbwv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41AF1F000E9;
	Thu,  9 Jul 2026 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783625217;
	bh=3YNXmK8iqaVmcFh0KFC0kmph0vK3sC1aXnxnkc76EXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pnkbbwv0i2TLMQrlHfxFYvONIbzh4I2luXYHAQHWd6+lafkFjfI486YC2Ycm5xF1/
	 dTU4t2Nilpwul9W1fHGuQz28NZOXm0dBPXcc0cWh2/my0aeOwD3dDtUiy8yeBxpqyl
	 i2YCyoCkN1cRflPgvsMx9qVMeZbJZdOzdYhSnx2BfcjMPR0fIZgSeWrOYOuSLDNMS9
	 k99ampotjKJPixUd3HSQm4sCbJNGpeVKok0F+oCHTDENBSwRstPFtG6oL2ePRRcNzb
	 M0j/1FVuoOp9Ypx4CBKxWQ+KguLSD7St3gnTmYaK2vuOKRqbMSdQNCAqqP+R6p1O6C
	 PR+sFlkJEEKow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: perf: Add Arm Bus Monitor Unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <1cd17d9c07e9695e1dffdeaa5409f0a1db8ccb81.1783439341.git.robin.murphy@arm.com>
References: <cover.1783439341.git.robin.murphy@arm.com>
 <1cd17d9c07e9695e1dffdeaa5409f0a1db8ccb81.1783439341.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 19:26:56 +0000
Message-Id: <20260709192656.C41AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The YAML device tree binding schema is missing the mandatory `examp=
les` section.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: perf: Add Arm Bus Monitor Unit ---
commit d43448a74f2d7de7e06899d55b1561b64c21375c
Author: Robin Murphy <robin.murphy@arm.com>

dt-bindings: perf: Add Arm Bus Monitor Unit

This commit adds a new device tree binding schema for the Arm Bus Monitor
Unit. It defines the required properties, including a mandatory label to al=
low
end users to correlate instances with platform documentation.

> diff --git a/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.=
yaml b/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
> new file mode 100644
> index 0000000000000..3cdc3a05b9a63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - label
> +
> +additionalProperties: false

[Severity: Low]
Does this binding schema omit the mandatory examples section? Standard devi=
ce
tree bindings typically require an examples block at the end of the file to
provide a reference node implementation and allow full validation by the
dt_binding_check tool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783439341.gi=
t.robin.murphy@arm.com?part=3D1
