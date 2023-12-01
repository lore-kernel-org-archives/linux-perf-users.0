Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506294D105
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S16GIxoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BC7C433C9;
	Fri,  1 Dec 2023 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701449942;
	bh=ySU1Do4RoJYFQTmBppKfMwL1Zs9QJ8j0N4J7GgsQg9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S16GIxoMRd4elQiyuXo8z2fG6ZF6RPsXHnh/XMUeZmtFYmLAW06VSOwXYTkMifDbx
	 fOvjwqokKn4G/HI9ygdQjVbvlljIH6+Z5DeWBhpqJ7Ugplw0po37kAT6Y2l5/Osv9N
	 jdsPF8mTqtd5Uy6yFU66y+dOQKGQxAeaQ4rUhrpOMh6wD/M6w+qiv1Q0bRHVuZ7seF
	 QZLIiv/fZRavvt0T7bLIuWXAnQi6nb2wi4HEL7z/hnVCy6Qrs3W4E6RvWav0NHYSta
	 v+V0OlZweKRyXTkSdguQRy+/qCMV2oFzBaAGntoLQ8eMluGwZ+Kdc2/LRlO9rmljXw
	 OmDzevbcsXuWw==
Date: Fri, 1 Dec 2023 16:58:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V15 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <fd278f4e-0632-4474-8609-7711ad725f85@sirena.org.uk>
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
 <20231201053906.1261704-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JISdTfvGKwhKa25v"
Content-Disposition: inline
In-Reply-To: <20231201053906.1261704-2-anshuman.khandual@arm.com>
X-Cookie: The early worm gets the late bird.


--JISdTfvGKwhKa25v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 11:08:59AM +0530, Anshuman Khandual wrote:

This looks good apart from a few small omissions:

> +SysregFields BRBINFx_EL1

> +Enum	13:8		TYPE
> +	0b000000	UNCOND_DIRECT
> +	0b000001	INDIRECT
> +	0b000010	DIRECT_LINK
> +	0b000011	INDIRECT_LINK
> +	0b000101	RET
> +	0b000111	ERET
> +	0b001000	COND_DIRECT
> +	0b100001	DEBUG_HALT
> +	0b100010	CALL
> +	0b100011	TRAP
> +	0b100100	SERROR
> +	0b100110	INSN_DEBUG
> +	0b100111	DATA_DEBUG
> +	0b101010	ALIGN_FAULT
> +	0b101011	INSN_FAULT
> +	0b101100	DATA_FAULT
> +	0b101110	IRQ
> +	0b101111	FIQ
> +	0b111001	DEBUG_EXIT
> +EndEnum

DDI0601 2023-09 also defines 0b110000 as an IMPLEMENTATION DEFINED
exception to EL3.

> +SysregFields	BRBCR_ELx
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:9

DDI0601 2023-09 defines bit 9 as FZPSS.

> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0

> +Enum	13:8		TYPE
> +	0b000000	UNCOND_DIRECT
> +	0b000001	INDIRECT
> +	0b000010	DIRECT_LINK
> +	0b000011	INDIRECT_LINK
> +	0b000101	RET
> +	0b000111	ERET
> +	0b001000	COND_DIRECT
> +	0b100001	DEBUG_HALT
> +	0b100010	CALL
> +	0b100011	TRAP
> +	0b100100	SERROR
> +	0b100110	INSN_DEBUG
> +	0b100111	DATA_DEBUG
> +	0b101010	ALIGN_FAULT
> +	0b101011	INSN_FAULT
> +	0b101100	DATA_FAULT
> +	0b101110	IRQ
> +	0b101111	FIQ
> +	0b111001	DEBUG_EXIT
> +EndEnum

DDI0601 2023-09 also defines 0b11000 as IMPLEMENTATION DEFINED exception
to EL3.

--JISdTfvGKwhKa25v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqEM8ACgkQJNaLcl1U
h9CdgAf+PuTg+CfzlrPSJrZ9Z36MlL8ZKYtD9hjauM4agzZsJ0u0RLkbkBRi6R+q
fcLF3WcaI80+35YGa/1BIyM4qYmO7JJNVDvZNf0E6dL7FzPgf499sOSxYHIn8zWP
5sRunmMDycdZlXGSRVVB+oTf5lFeMT9aKy765546cMNspxDbCOBUBCUcw5I/dxQG
nuzCEyADW36yKxodStDCx6Jptz8dO3qF0r02YEoc/xCNSXv4lG9CLrM0acDXxyZ/
BwvWOvSlv66Ta+QM/DL4UhcditW+HXHK71OPD2q/xhSjI41z6tMxKtZwQ02cFO/Z
cfl0g+Aj1tfzyQdK6OTLxP+i4lASSw==
=Zs5/
-----END PGP SIGNATURE-----

--JISdTfvGKwhKa25v--
