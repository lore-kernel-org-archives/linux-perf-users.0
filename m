Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C293403EC
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782317; cv=none; b=b7LENhUWC+OYVEMrel97o2GRAwEMaf2h8Gl6aeS9evWPXi9nCY3EavvIGAeyTV6xLJSPbQMlWQIT/MB7feU1+hIghluxoz1/pwp6pUPXLpMc35ekBz0Og7yNi6K1n5WB9jh0BhVH7aRmDUWZo1I7Z6QPtsPsvpfsYcWT1wA4TVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782317; c=relaxed/simple;
	bh=GGNmQPKut+1EoFABetIPG+8+y+lTjolxfUjcc/N5ANg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QcxwJe/xx6fRR4owBscWtMA/K51BP/qScBFMLhWplIrQFQZlp30or4BCNAjDzEPidZYCNkAboZskN/lXvBFBVEYE+2KPVD3BV3bhs/oYJ2ryczXVuvqFN1+ywTBI9dYiJvB7bvU2qBoD4SaBtRTmfv5wxE2yh1zS2+HThoLNTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIuY5Lh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIuY5Lh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B241F000E9;
	Sat, 15 Aug 2026 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786782315;
	bh=yM6K9bL/MO+Z9JJNTPZXCCw1FUKcCVN0fqz8EL3Sz7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIuY5Lh57RHFePb1GLoaVLdEYEfUUDO3JOGDpQVm3OqXU9dQ0mSv/hr9bhZXiThr/
	 0Y8clcvMgf2ri/FHAiCZ7rJwkpbpbcnAOVAhzzzypChpOHn+zb/mgBOZKvrCAGBnei
	 loYN4DV7imICNCbGqECdn55ndtIIBYxPB03CKr78gU9YCyrmSWZZopceRGTkqcrWOl
	 DW8e/reF138UqOiywTrdk2LQqcniWhNE8Idf0in6uik5bn75rHw7Jkw4wS7+LUsLAA
	 8r6Qz8NInw7PkOqjVElxLaI2N3gfKkfiA16klJpljPishH8RlN3EBvZDP5QDELDKm6
	 AgOjEZw9rd81Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815082048.4043217-2-irogers@google.com>
References: <cover.1691900000.git.irogers@google.com>
 <20260815082048.4043217-1-irogers@google.com>
 <20260815082048.4043217-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:25:14 +0000
Message-Id: <20260815082515.33B241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The YAML schema fails to enforce generation-specific constraints=
 for the `firmware` property, and the provided DT example contradicts the d=
ocumentation.
--

--- Patch [1]: [PATCH v12 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi=
 AXI PMU definition ---
commit 758d3c70fc67aa6ef59b9abc25e70058474c3055
Author: Ian Rogers <irogers@google.com>

dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition

Add Device Tree bindings for the Broadcom AXI PMU hardware blocks present
in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).

> diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.=
yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> new file mode 100644
> index 0000000000000..8f8686f673377
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
[ ... ]
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the Raspberry Pi firmware node. Required on older silic=
on
> +      (BCM2835-BCM2711) where VideoCore VPU endpoints are exclusively ac=
cessed
> +      via firmware mailbox IPC.
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Should there be an allOf conditional block here to enforce the firmware
property requirement for older silicon?

The description states it is required for BCM2835 and BCM2711, but device
trees missing it will silently pass schema validation without an explicit
constraint.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmu@7e00a000 {
> +        compatible =3D "brcm,bcm2835-axiperf";
> +        reg =3D <0x7e00a000 0x100>;
> +    };

[Severity: Medium]
Does this example contradict the documentation above?

Since this example uses the "brcm,bcm2835-axiperf" compatible string, shoul=
dn't
it include the firmware property that is documented as required for this So=
C?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815082048.4043=
217-1-irogers@google.com?part=3D1
