Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6514286;
	Fri, 23 May 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014575; cv=none; b=INF4mOMiFuy6QGwTwvGceB0tnPfNbIzaUXL923HHXcqFcx6mrD/3+smZmmJZFauGHcobKIeorg9RCsw3ttu835wm5R1JxhYar+GqxjUWnEvZPFJqaNGDcPY3DA9v2L1ct40l0/bw/yPLvBQTNX66MSP09LLgpWT1ZAobeP6xG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014575; c=relaxed/simple;
	bh=zG0Aq0dm5zd6tPL905oAGCXNUFTWV4Fg6wvO8nA9YtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKxTxt+rYUE0k6tMtiVzjjZ6SwjK7q8rqTp+EIp/akW3ZiywDlLIKWICJuuB9+CoG1Evohw3GvECRrh3mS8Ks/TthSRM5JxA+IWr6f996nq97Wx4qh2Nk8gmjFSSQl8708R8fzllvZc+dRDRQYNPXVCFwL003Si/9RyIYmjtye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjwldArL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjwldArL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B096CC4CEE9;
	Fri, 23 May 2025 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748014574;
	bh=zG0Aq0dm5zd6tPL905oAGCXNUFTWV4Fg6wvO8nA9YtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjwldArLZVywmL4BtfM9pLrYXkohqEPLLnBQyNP7xfBRFsSzTxTxvrtEaGOep4K7h
	 vZ0k4IlP/x9We6ehTYweyWo2At6E9I1IMrjAwSlUHiEL7Ru/R5yQRAzYqUXxXKlgDN
	 KT98/Ef487LHmYrzwFvHZ4Gtw/y7nigDdaeHZLrFdj3+91C8P1bkIVdrKrSHkysQVQ
	 UXa1YcDU6f10xJNpSegcoSTbuxW4SdAPPk86AOv5uaFfqKgDiwPykkzdKkmEKboTQy
	 l9EMFcVTWjMceFxINNpuVIa9nLdGHG6jg10RAtB+lnucCV5vPUsGDP2bug5aJ+QEVB
	 pyj3DMaJpVIqA==
Date: Fri, 23 May 2025 16:36:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beeman Strong <beeman@rivosinc.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] dt-bindings: riscv: add Sxctr ISA extension
 description
Message-ID: <20250523-ducky-unlisted-5764ad0f698a@spud>
References: <20250523-b4-ctr_upstream_v3-v3-0-ad355304ba1c@rivosinc.com>
 <20250523-b4-ctr_upstream_v3-v3-7-ad355304ba1c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YsbMlZlsa7BrXpPT"
Content-Disposition: inline
In-Reply-To: <20250523-b4-ctr_upstream_v3-v3-7-ad355304ba1c@rivosinc.com>


--YsbMlZlsa7BrXpPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:25:13AM +0100, Rajnesh Kanwal wrote:
> Add the S[m|s]ctr ISA extension description.
>=20
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--YsbMlZlsa7BrXpPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDCV5wAKCRB4tDGHoIJi
0pfsAQCC0vFE1gQIjvjVO3vjHghEg/7zH3pwUyTcP2hPYZcZSAEAjizdb5MtEvdc
ne55YWgcjHCCab8vDuJrO0B3c+3OXwg=
=xhJF
-----END PGP SIGNATURE-----

--YsbMlZlsa7BrXpPT--
