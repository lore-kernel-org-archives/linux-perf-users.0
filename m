Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315352;
	b=D9vIXT8XbJc3Iw8OsvgiLvvevUbwMrQsQ4y3jnaOpScJYaKhcs73dPJ7LYFlh19eC/Ku
	 PAhn+oL7U8mCzn4rg6yuj8sInmxEXVbEzuAhiVK+Z2bye/I5FTaaXJo7AWsgz77IabxJT
	 fOJbFAJZysVDN5HQ39X7FdiZnjE4eUxqqX4NBsvWq34EMroKFJr94MzoPG+S2Q0AUNqz3
	 0u48cVdKcl1W29j0UyO2yIhcaqt1QwPFZgweXltgL7mlgeqrczBNWojCurLnXtuClEzBp
	 9kTU+EPBSTNe99GVd65zoPmkd4+fhlqlSekP29567Ck+CaK7yDhLTzcBwv4rFB7jowQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315352;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=60uiQLKWD96KNyNA8n1SFH/9ebNVNGe69HhykEBopfM=;
	b=SL2jlr/12e+eD/nEQJVsFrOFSl674ScxC4wD70xQXIwgVDMj/1XrTDLMQvAkakgmEpDY
	 JFhnGAORHFDGGeMWQgLEVNqYl7rBrV/1OTZRfX4FtbPhQxFBsol1+vRifnUCjlQRe9TIR
	 bvNqow9vRyVU7m8PAMW0wxpk2PqrItZmCZW8OxA98IhiSILbsZ7HStM2IwHPYvUxMoAVC
	 fRhMNowVzgwRV+9Q5UD81l4gEIuxA5xpUIW1OW8DLoqyUwahD9O2AouVhIR5J9OvD4lWF
	 sb9SRTNlWvrsATnr1CWI5uzWbuBagxRnRzExIWYxR/255e/XOSueCRuznEcEQAV4n6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vlu78CTP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DF606A31A;
	Thu, 29 Oct 2026 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vlu78CTP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED671F01816;
	Thu, 29 Oct 2026 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793315351;
	bh=60uiQLKWD96KNyNA8n1SFH/9ebNVNGe69HhykEBopfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vlu78CTPyf+ZyY+6ssCTxabXF8StOgXlJTsB8rxtQsxtjj+HkyKmR5Uwb579/tLj6
	 +zSzMd5S7bFy4FRVCskYPFFb9odTDQ9Nw7618th22JQa7FSyX75FWZenMNGNsHkgwO
	 M7p+XN2mnP5UeWEPfLyQC6qpJ7+dDhqHH93bcaObz/qaE9RU3DOrrU/JRAD9nVN1Vh
	 7naVbLRzCja4Zla2Y24qeex84MAMc7RPm0c6rGOuxC9yBTn0+S0dNGqfsmNxBTk2he
	 an6ZJHJX3iZRnGI4AVVnzUD+YrmzjSrpYS+y0un3VgY/y+ryce03Z4N+Pjj9txHyV9
	 MW4JC83uKif9w==
Date: Thu, 29 Oct 2026 23:09:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
	Anup Patel <anup.patel@oss.qualcomm.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Atish Patra <atish.patra@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
	yuanzhu@bytedance.com, yang.yicong@picoheart.com,
	yang.susheng@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v12 09/11] MAINTAINERS: add RISC-V SSE maintainers and
 file coverage
Message-ID: <20261029-tidy-scorpion-c8601a1761ba@spud>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029114953.27453-1-zhangzhanpeng.jasper@bytedance.com>
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
	protocol="application/pgp-signature"; boundary="Xqo+bfadgatXB3Qq"
Content-Disposition: inline
In-Reply-To: <20261029114953.27453-1-zhangzhanpeng.jasper@bytedance.com>

--Xqo+bfadgatXB3Qq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 07:49:51PM +0800, Zhanpeng Zhang wrote:
> Add the RISC-V SSE maintainers and cover the architecture entry,
> firmware driver, PMU documentation and selftests in a separate patch,
> as requested by Himanshu Chauhan. Also add coverage for RISC-V firmware
> drivers and the architecture selftests.
>=20
> Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.=
com/
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  MAINTAINERS | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65e8a4b5c90..f275e9d4847 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23506,6 +23506,7 @@ C:	irc://irc.libera.chat/riscv
>  P:	Documentation/arch/riscv/patch-acceptance.rst
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
>  F:	arch/riscv/
> +F:	tools/testing/selftests/riscv/
>  N:	riscv
>  K:	riscv
> =20
> @@ -23518,6 +23519,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel=
/git/iommu/linux.git
>  F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>  F:	drivers/iommu/riscv/
> =20
> +RISC-V FIRMWARE DRIVERS
> +M:	Conor Dooley <conor@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
> +F:	drivers/firmware/riscv/
> +
>  RISC-V MICROCHIP SUPPORT
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  M:	Daire McNamara <daire.mcnamara@microchip.com>
> @@ -23573,6 +23581,7 @@ M:	Atish Patra <atish.patra@linux.dev>
>  R:	Anup Patel <anup@brainfault.org>
>  L:	linux-riscv@lists.infradead.org
>  S:	Supported
> +F:	Documentation/arch/riscv/pmu-sse.rst
>  F:	drivers/perf/riscv_pmu.c
>  F:	drivers/perf/riscv_pmu_legacy.c
>  F:	drivers/perf/riscv_pmu_sbi.c
> @@ -23612,6 +23621,19 @@ F:	arch/riscv/boot/dts/spacemit/
>  N:	spacemit
>  K:	spacemit
> =20
> +RISC-V SUPERVISOR SOFTWARE EVENTS
> +M:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> +M:	Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> +R:	Yunhui Cui <cuiyunhui@bytedance.com>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	arch/riscv/include/asm/sse.h
> +F:	arch/riscv/kernel/sbi_sse.c
> +F:	arch/riscv/kernel/sbi_sse_entry.S
> +F:	drivers/firmware/riscv/riscv_sbi_sse.c
> +F:	include/linux/riscv_sbi_sse.h
> +F:	tools/testing/selftests/riscv/sse/
> +
>  RISC-V TENSTORRENT SoC SUPPORT
>  M:	Drew Fustini <dfustini@oss.tenstorrent.com>
>  M:	Joel Stanley <jms@oss.tenstorrent.com>
> --=20
> 2.50.1 (Apple Git-155)
>=20

--Xqo+bfadgatXB3Qq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauPSDwAKCRB4tDGHoIJi
0kttAP9dzoNQAI2SKPQomjar/n9Qd4olyeHc1OusqrZHxxNv7QEApaGoAI0AgXlN
NFcCol7iifOclsEwiEBBMmF4CzFvhAc=
=aCSu
-----END PGP SIGNATURE-----

--Xqo+bfadgatXB3Qq--
