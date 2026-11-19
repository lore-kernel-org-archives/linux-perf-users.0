Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105438;
	b=paGvP3MHGhfqoEOSHtU27t6VdRnjUaHa6XAUTtAtmi71KP5EOjjYHvBmawnlov6iLwpm
	 xaqrldz29g+fVAxzxU+c3ZYH19Jq13uaRs5FFKjII3Kn79oXrh3vEGayQ5rcplnyswWev
	 YqHx31MoIwB+rtrWcQbsDlbqpzD1Dwr8SkL5putgia+xA3xFIFgR2vIZJP+HIzMXnWhlH
	 taS1PC35MV0YJQeVANHJFNAX2qOwNTIIFhzQ2DP33gLW6rXCjeUuFj41UOgTKIeGDwctB
	 jy0NtvVvQGa2VkFwsT8frhTLM6jJgv/5TdVbXXM+jzyxp3TidDGC0tZG/LOkAFNsX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105438;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ASPP9Zc3Zh0uvcMkx39f3kA3ni4lHB7NDdB+FYKmk0g=;
	b=RcdGh56/8I9WIUZaTPTGazVjZKejeCpSkDvwDBvF6fhu/8E8+URG+I3qejrfckr5EeHu
	 qvEaZ0QOnF5v8aj1L8QAz8xEbG7AY5Zk0pMFWwzKCHPVZygWRoihNII+d+/12rZ2YDy5a
	 VGVxxBPK59guYPEHYhmM9r451CIQI0XBt2nr+s5YwyF2WtD1tf4Ug6VOYMW4Lq+sy4pjd
	 F9l6wAp6pulhs6NnDqwkUF0qZztv3/z9jyI6+E/4YvAxfMnf1QvEZ8yEFtHfnIR4GHv5R
	 khE8pbOl45+nfitC5s72ePBXBYuGdduf89rjT1cZUTFYfFqLjfpI9ekEZtF/Yk7PKDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+N2fTiZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DB606A324;
	Thu, 19 Nov 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+N2fTiZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D5F1F000C7;
	Thu, 19 Nov 2026 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795105438;
	bh=ASPP9Zc3Zh0uvcMkx39f3kA3ni4lHB7NDdB+FYKmk0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+N2fTiZ/FzUCuPmCtvP9jnkiQdxnim7Uz3ZrINJJ+GtqB+zX9H7t5zFO47wX5GNQ
	 7dS3qOTrfAzdUIjwYFrxsZYpxZVIz7ZMOtsEdfe0rObN9V8gcGedLZphZBpee/vXkA
	 ihTAhB51VhfKuK7fses/UO2DV2AjASYAbXzI5J0zvOFiWF6J4WsgjeSwFiJgSSu4qK
	 6tZT/t+EYzNsHHs5393nRvzDtGgo4BXrTpfJrc28N+1QumoV9EvMuT98WG6QlULwFU
	 GHHOe2+kO79vvlClOvinEY3Co0GnTt6FY1t39hKp/NWlTMgBuIFwVlI3KXi3JV8dMZ
	 kajZSeXAuNmjw==
Date: Thu, 19 Nov 2026 16:23:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, atishp@rivosinc.com, anup.patel@oss.qualcomm.com,
	will@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, beeman@rivosinc.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v5 7/7] dt-bindings: riscv: add Sxctr ISA extension
 description
Message-ID: <20261119-drainable-muscular-697e071393a6@spud>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="J8Dk75YY+52XvXQ7"
Content-Disposition: inline
In-Reply-To: <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>

--J8Dk75YY+52XvXQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 03:20:53PM +0530, Vikram Singh wrote:
> Add the S[m|s]ctr ISA extension description.
>=20
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-8-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

With this stuff sorted out as Anup mentioned
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

Thanks,
Conor.

> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 79491ef8f86a..dde2f28cfda5 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -202,6 +202,13 @@ properties:
>              mechanism in M-mode as ratified in the 20240326 version of t=
he
>              privileged ISA specification.
> =20
> +        - const: smctr
> +          description: |
> +            The standard Smctr supervisor-level extension for the machin=
e mode
> +            to enable recording limited branch history in a register-acc=
essible
> +            internal core storage as ratified at commit 9c87013 ("Merge =
pull
> +            request #44 from riscv/issue-42-fix") of riscv-control-trans=
fer-records.
> +
>          - const: smmpm
>            description: |
>              The standard Smmpm extension for M-mode pointer masking as
> @@ -263,6 +270,13 @@ properties:
>              mechanism in S-mode as ratified in the 20240326 version of t=
he
>              privileged ISA specification.
> =20
> +        - const: ssctr
> +          description: |
> +            The standard Ssctr supervisor-level extension for recording =
limited
> +            branch history in a register-accessible internal core storag=
e as
> +            ratified at commit 9c87013 ("Merge pull request #44 from
> +            riscv/issue-42-fix") of riscv-control-transfer-records.
> +
>          - const: ssnpm
>            description: |
>              The standard Ssnpm extension for next-mode pointer masking as
> @@ -1189,6 +1203,21 @@ properties:
>              - contains:
>                  const: zicntr
> =20
> +      # Smctr depends on Sscsrind
> +      - if:
> +          contains:
> +            const: smctr
> +        then:
> +          contains:
> +            const: sscsrind
> +      # Ssctr depends on Sscsrind
> +      - if:
> +          contains:
> +            const: ssctr
> +        then:
> +          contains:
> +            const: sscsrind
> +
>  allOf:
>    # Zcf extension does not exist on rv64
>    - if:
> --=20
> 2.43.0
>=20

--J8Dk75YY+52XvXQ7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav8ilwAKCRB4tDGHoIJi
0kVlAPsG4DXR9ueGc0XhRpoMYfNdTGaoRfforrmj7DuWFcQZuwEA0fKo7E+f/t+0
hf4bzQ8P5iwPUbFDhzYjmtwJKU/pVg8=
=/fE9
-----END PGP SIGNATURE-----

--J8Dk75YY+52XvXQ7--
