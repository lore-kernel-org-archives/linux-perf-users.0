Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024514;
	b=OSTDcfJP+wwt6IvSB6wPDtVFCMMgnT3C8SQNtEVOrH4j67hmZIgis4bNqmLtM47wr3Z6
	 l+uUTBNuqSwYFscUo6VPet1tOXsw8syyn/ZHL+bMsldx6MFjQhurETW5cys+2FRg4B8aw
	 Pb9zoiMLzMlhbuv5pg3e0wijR9cSE/AD4fPAoqFS5tSlPFFfzYDskPT1q8Y+4PBWnNsZK
	 MVlIXsR53iOszjHe8PKRlMQveoZidmeo//bT3gtaMjfecRYGGVdSXKg6E0B7mbbNpCfcc
	 SecY3XsTtUvXLqG6yXTtk2sJMp8eiFk0gYLF3ajEsnpypzpvpd0Q44BLQKHTZXcCRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024514;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4z408KRzKXpCsZSuJuOfiOKILNxJs3DDuvK5OrkeNME=;
	b=rDSGS+4OvD6o8BspJxlfOXvUpEepHtv6EG9RvTmzugH7gFyoqxb5Sdb7XWfp374ZVMN4
	 BRIDeOwqGscslCTUQ/b5TwrnagojQCOkU+QXcDq3Cr9FTKROiCONssEhZKnBi0sIvOOXT
	 Tlxv/yP2CUCcrzeWam9WQUss50SQNyas5R6keYu/kdkQzGYYR5jYxRRNWp68MR0y86il9
	 Wh3c8QNC9yB2WdRYrDP9oqvKBG+5bz/n2YT/aB0JkJoYMocfWpK3m7mSNgwIFZ6Sy6Kjk
	 abcUv3LwtNG6dD9lBNxaZlzy3bQ9L7Ok15P9/Eu3dmqHbchLLlJCX/hBnRfVHrd8vsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD7ISErN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9107606A31C;
	Wed, 18 Nov 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD7ISErN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743E81F000C4;
	Wed, 18 Nov 2026 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024513;
	bh=4z408KRzKXpCsZSuJuOfiOKILNxJs3DDuvK5OrkeNME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GD7ISErNiRH1kSDWD/DKK44+2FtiIZZ5C2uM+fnf3i2Ticg2DxDMcqsa25Hrwiwf3
	 3Ox7sXw9uc6iiyMcds0kVdjVlH09vF9R3IiVzYcxXN5yO02x3aGYik8TNvMI2+sVuN
	 XP5Pnnk2UtcwzZWJ2XAfnirLnS3W0/WRjZVIIyPF2brAU3KtbnomWoZzrWydNDxKY0
	 Ezd71/gpGWAo35TVjU5bDMmKogzJsb7pLAZr+CxpWsCDjjL+5FJo4oXJahQn8TMBVE
	 hzvxMRgC4ErDn4mYwwLBZ+BqGK2Jy2kbb19WKxZUVj+zapD1cGKgJJsxXtnl1cS1bz
	 DM7/DucS65hZg==
Date: Wed, 18 Nov 2026 17:55:10 +0000
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [RFC PATCH v1 1/5] dt-bindings: riscv: Add Smpdis and Sspdis ISA
 extensions
Message-ID: <20261118-stipulate-grumpily-7567691b396d@spud>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
 <20261118081327.10684-8-zhangzhanpeng.jasper@bytedance.com>
 <sashiko-outbox-220433@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eGumaYRWr8p5wYX4"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-220433@kernel.org>

--eGumaYRWr8p5wYX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 08:23:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] dt-bindings: riscv: unratified draft smpdis and sspdis
>   extensions added
> --
>=20
> commit 6221314245742eb097a15011dd35eda824258728
> Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>=20
> dt-bindings: riscv: Add Smpdis and Sspdis ISA extensions
>=20
> This commit adds devicetree binding descriptions for the draft Smpdis and
> Sspdis RISC-V Precise Decoded Instruction Sampling extensions.
>=20
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 79491ef8f86a8..afda76b9c7c47 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -214,6 +214,15 @@ properties:
> >              ratified at commit d70011dde6c2 ("Update to ratified state=
")
> >              of riscv-j-extension.
> > =20
> > +        - const: smpdis
> > +          description: |
> > +            The draft Smpdis machine-level extension for Precise Decod=
ed
> > +            Instruction Sampling, as described at commit
> > +            2de60e18118ce78e2da82ec33296345c94d8560c of the
> > +            riscv-performance-event-sampling specification. It defines
> > +            instruction selection, filtering and sample collection acr=
oss
> > +            privilege levels. This does not imply supervisor access to=
 PDIS.
> > +
> >          - const: smstateen
> >            description: |
> >              The standard Smstateen extension for controlling access to=
 CSRs
> > @@ -269,6 +278,16 @@ properties:
> >              ratified at commit d70011dde6c2 ("Update to ratified state=
")
> >              of riscv-j-extension.
> > =20
> > +        - const: sspdis
> > +          description: |
> > +            The draft Sspdis supervisor-level extension for Precise De=
coded
> > +            Instruction Sampling, as described at commit
> > +            2de60e18118ce78e2da82ec33296345c94d8560c of the
> > +            riscv-performance-event-sampling specification. It provide=
s the
> > +            supervisor-visible PDIS registers and behavior, excluding =
the
> > +            machine-only state. Firmware must make this state accessib=
le to
> > +            supervisor software before reporting this extension.
> > +
>=20
> [Severity: Medium]
> Should unratified, unfrozen draft specifications claim the canonical
> smpdis and sspdis strings in riscv,isa-extensions?
>=20
> Documentation/devicetree/bindings/riscv/extensions.yaml states that
> standard extension properties map to their originally ratified states, and
> Documentation/arch/riscv/patch-acceptance.rst requires RISC-V
> specifications to be Frozen or Ratified before acceptance.  Defining
> unversioned standard extension names for a draft without final CSR
> allocations breaks devicetree ABI stability if the specification or CSRs
> change before ratification.
>=20

Ignore this, you;ve done the right thing by marking the series RFC.

--eGumaYRWr8p5wYX4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3mfgAKCRB4tDGHoIJi
0sA3AP4+euvhz3AKWQd3Hnr1swUc5gAjV8/GPc3ZTGXpRHo13gEA4wcKF/akdglg
nxbWPJmVUrF8Zj63Rnhg8b134RMyMAk=
=KuZu
-----END PGP SIGNATURE-----

--eGumaYRWr8p5wYX4--
