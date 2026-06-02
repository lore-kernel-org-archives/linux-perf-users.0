Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF193F0A81
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414921; cv=none; b=WBCOuUpSCXB621ggsoVJ/53B1JX6XK7YS1H4ieRNo3k1cnke7xnWwmlAtbHmw/yYZVWdoXiW3yFYv4VXC5q1aBL+eTFTsetp30hN49mZsFnUx4kPfa9hdv5KfD9vT9q7CdLmvquUigKryl6th+lHvy9uQ5m5HOytgIM8w6idyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414921; c=relaxed/simple;
	bh=FnkNbrqEN3/i5QVAbYQYPzPzC5icwOplsblXY6hYgCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iqJqOTn7qpyLF0Z6vWMwX6/7gQfVIU8Su45OR7lOAILg5Wl5bU3nWytH0Rs9NQO930cONrTQKCT4YyXZtE5zA98ajpQTxyJC1Z9iwIjbmwURYrOfL2fhKa+4WVfxFnNJJ6ZrGpCP/ogxAQlcNoyavmRlpLC8qVf5YRLGU5sVRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXz2T2H4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXz2T2H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F21B1F00899;
	Tue,  2 Jun 2026 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414920;
	bh=0rrh6U2LXJG1Sz3Q7HPonUmkdkUc5ywzdgZrIioCRtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXz2T2H4G3naET9kzMBDsmSZ5nP6d7pGoStTuQcqR8eI5Qad64MeVEeh5yc2J+uis
	 j5Z6utYbGnySFcB+tms1VPXByK19kSCVo6znPFqN78cEo9KxnsaFWTI/8pK3FTpihU
	 LV45sMQJw65UEMUnqy92LbMqoyk5LAM9ef2QxfpP31pA4dDUKwUzUMUKh2xMHeirm7
	 vVtjwXQHOOuuMLv6COPvp5F2y17XQm4cBCeh6HSb5caRDVZWcDXiWUf5u4sBfI+tvo
	 pbL0qZjjTRNAw7KNCOC2LGRZaEXoOyrF7QDOL036J1FFMbyCII+XZRgXeDD4D3/U5N
	 3qra8QKonsLdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/19] perf capstone: Determine architecture from
 e_machine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602152516.2831152-5-irogers@google.com>
References: <20260602152516.2831152-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:42:00 +0000
Message-Id: <20260602154200.7F21B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional use of Capstone 5.0 RISC-V constants causes compilati=
on failures on systems with older Capstone versions.
--

commit ba329b9ae926047810786901fac5adc923ce8f30
Author: Ian Rogers <irogers@google.com>

perf capstone: Determine architecture from e_machine

This commit updates perf to determine the architecture for Capstone
disassembly using e_machine instead of an imprecise architecture string. It
also adds new machine translations for MIPS and RISCV.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 25cf6e15ec272..5ad537fea4360 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c

[ ... ]

> @@ -137,37 +142,70 @@ static enum cs_err perf_cs_close(csh *handle)
>  #endif
>  }
> =20
> -static int capstone_init(struct machine *machine, csh *cs_handle, bool i=
s64,
> +static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is=
_big_endian,
> +				  enum cs_arch *arch, enum cs_mode *mode)
> +{
> +	*mode =3D is_big_endian ? CS_MODE_BIG_ENDIAN : CS_MODE_LITTLE_ENDIAN;
> +
> +	switch (e_machine) {

[ ... ]

> +	case EM_SPARCV9:
> +		*arch =3D CS_ARCH_SPARC;
> +		*mode |=3D CS_MODE_V9;
> +		return true;
> +	case EM_RISCV:
> +		*arch =3D CS_ARCH_RISCV;
> +		*mode |=3D (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
> +		return true;

[Severity: Low]
Will the unconditional use of these Capstone 5.0 RISC-V constants cause
compilation failures on systems with older Capstone versions?

The feature test in tools/build/feature/test-libcapstone.c only checks for
basic Capstone support:

    int main(void)
    {
        csh handle;
        cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
        ...

Systems with Capstone 4.x will pass this feature test and attempt to compile
util/capstone.c. However, since CS_ARCH_RISCV and the RISC-V mode constants
were introduced in Capstone 5.0, compiling against older headers will fail.

Could the feature test be updated to check for Capstone 5.0, or should these
new constants be guarded to maintain synchronization with the build system?

> +	default:
> +		return false;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602152516.2831=
152-1-irogers@google.com?part=3D4
