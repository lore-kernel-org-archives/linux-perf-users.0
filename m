Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761743;
	b=nx8Md/A8nGTORcVClk32egeamIpwBSuZ8Ejl4WZzkRSD32+6Z/kk8qLATGcd4ZAmNT1k
	 xARtXpuIHtnlZeFmGBnEl0/pZ9wOgWJx9/LFCSbUhhMoxgzUea8ywRlejby97yYjttOB/
	 oBcxQyTEOs6Q1XuE8MMKIr5dcGBaGOHaTdkBeHK3+BfCbIQixKvweWVvvNruqgI3LIp1W
	 0EYjPg7xjWvQ217luWDFTYjOogJflYzuZ4mGqs01LdXZMFKNw4ZtiMU/mB9id2R1Hy7xE
	 QFMLSET3cyQCYQwuW+D+OBB/8eT6nu3iJXNfTO8KPycpCGWBAZxS8HapjUx7dgxZDnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b+QDO98Qz3kf7L5qQirMMfSsiJHpp3HEN/j18ZWD3j4=;
	b=AmCDF4aP7fIC0O/6IcOto7bb1dLcD5aUMumFocLDRFCJYjSHPY5cDREZWKD45BX5Z2tm
	 R2kMOPiNHjGkAKW4O8YrI0LnuuFWdnP9Mi/vaHivOzAoz+vr1cVdBBFhrMz7dyXwkkj/T
	 cwoVRfiW4TpzO1FbG/hUX9wdOv4Z4kizsaJtbSOtx8QFda/R28shiiTaF/CRYpky0lUCM
	 xytJs2zEUoLVQTcvmWml7XQeT9ypv2AEEDPdJJsetZUVeKjn6EE6ejJNgDvL52nX24lyB
	 914snB7MP6jpGGFooZJWPQN45fMLY8Q+SK3tsu9r/UNJaPQsPA7V6p3D+76EjRzN1aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7Ov4Ygo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4E606A326;
	Wed,  4 Nov 2026 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7Ov4Ygo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15F31F000C1;
	Wed,  4 Nov 2026 03:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761742;
	bh=b+QDO98Qz3kf7L5qQirMMfSsiJHpp3HEN/j18ZWD3j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i7Ov4YgolQ1MCHS69WQl2wJvQVghK9ujmjUTxehbrvjN6y8OEJ+pKeY2Rw8IaRB3n
	 Cw7lKc+3DqfL71pdC/7uvkuykAAODXQ1NQ8oBtrJtpXiQyUPLjcyA4XBhFX0tJJmzg
	 pSi+y0FGsSVXn/p9eeSZUFP5VviFd75S9DzifDYQD9Q5mzClK7kN31J79a+9fwDzxf
	 uRLzCQqjBEGYbBAciM81vFwbxLkIZey8D9rWM60K8lXb2F0S4WF7MM9PAqiT3wuCUB
	 iVYQTS18uR3IOX6VfjOIMEaKWUiaJUtekcn8FHb9fAtSJTN+i084/Z7YUybzCTCsm+
	 DmDGw7ycaq48Q==
Message-ID: <sashiko-outbox-196587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104030300.1140180-2-irogers@google.com>
References: <20261104030300.1140180-1-irogers@google.com>
 <20261104030300.1140180-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:09:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: perf: invalid plain scalar colon in brcm,bcm2835-axipe=
rf.yaml
--

commit 585240cf0e14c8ec2eefa09a1ecc59a1d82cc72f
Author: Ian Rogers <irogers@google.com>

dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition

This commit adds the Device Tree binding schema for the Broadcom Raspberry =
Pi
AXI PMU block on BCM2835, BCM2711, and BCM2712 SoCs.

> diff --git a/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.=
yaml b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> new file mode 100644
> index 0000000000000..2f1f4f286ab57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/brcm,bcm2835-axiperf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835/2711/2712 AXI Performance Monitor
> +
> +maintainers:
> +  - Ian Rogers <irogers@google.com>
> +
> +description:
> +  The Broadcom BCM2835 series (including BCM2711 and BCM2712) features h=
ardware
> +  performance monitors on the AXI bus for evaluating memory bandwidth and
> +  system traffic. Two monitor register blocks are present: the primary m=
onitor
> +  evaluates the System fabric, while the secondary monitor evaluates the
> +  VideoCore VPU fabric. This block is distinct from the BCM5301X AXI Tra=
ce
> +  Module.

[Severity: Low]
In Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml, the
top-level description property is written as an unquoted multi-line plain
scalar and contains a colon followed by a space in "present: the primary
monitor".

In YAML 1.2, a colon followed by whitespace inside a plain scalar is parsed
as a mapping value indicator, which causes make dt_binding_check and yamlli=
nt
to fail with a syntax error ("mapping values are not allowed here").

Should description use a block scalar indicator (such as description: |) or
avoid the colon followed by a space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104030300.1140=
180-1-irogers@google.com?part=3D1
