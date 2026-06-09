Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A33C3BFA;
	Tue,  9 Jun 2026 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983007; cv=none; b=ru5OPkjXs2qgfjWgox0I9WChRZu7e8Ec7H4clBZKd/YOjOhsP/UW5VjeasISqFQldP05K6K7krmq9CagnmniiwRYM6mX8WumUolhrU+Cm2Y3HXhGNJ7CVduNjbbGHyuu2G6SOzML1m0PEfK5AGLePOPcSispfmQ+Z574i5LQArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983007; c=relaxed/simple;
	bh=oVo/eIoSyQrLnSYHxj9BBPn2wH9G2zi70ZLk1IPcGDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MOBhV7MRIo4+N6guti+y6puGEmWGUkoQyP4z8pyDbDdiDR2bUHM9xTgSdBm41C4SoOEPNrkrQpz4zuzRCrh9vIo5xOhx09E/mbRuipvWF/y7B/g5ef/tf08VlVJMrpWRxu/GhVTRGzUYd1yha3GMq9/MLRds/SiF5sGbUJBVMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz8Kqbuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz8Kqbuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429141F00893;
	Tue,  9 Jun 2026 05:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780983006;
	bh=1WXZInKDWymdqWGiUb+m2hFHO3lIO70OD0+G2Ce7+8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rz8Kqbuhs9YUfwn3/I1bNjphEdD8FtMm7ZYQLlIoSYdlwhVLjnjhWdFKXJiaCbH+4
	 YxBy3RThk8q7G6Ju/F0gzfOQKqB7Ky1HkeOzQ2Vwgfc7MsaWz2b4LfMBtRSkrzkEHt
	 yhsLZU2evGDDSsssoRH4nLcoeRs5iUz1QaZYUVAXysPLsAycFmgwDvW2yTfNBREaNY
	 lRQ6oGhSuWUUz8QWELuVhk2AWDq3nfB6axls+cB5u/6xRiAUuJgxH96QQoXh4Cv9yI
	 zR2Szz7WBF5hgLBkF2P4xcFG1W5em4wn78tW65bw8reSJmRX3QXnK7XnTUAFdheE8L
	 VxkcCPBc1htcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] perf annotate: Implement elfutils libasm
 disassembler backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609051759.405027-4-irogers@google.com>
References: <20260609051759.405027-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:30:05 +0000
Message-Id: <20260609053006.429141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect usage of the elfutils libasm API causes severely truncat=
ed disassembly output and incorrect error handling.
--

commit a3f0b9f1213f96fa27632210d1db364c7cad8286
Author: Ian Rogers <irogers@google.com>

perf annotate: Implement elfutils libasm disassembler backend

This commit implements the core disassembler backend in libasm.c utilizing
elfutils' libasm API. It hooks the backend into perf annotate disassembler
routing and configures libasm as the first-choice disassembler backend.

> diff --git a/tools/perf/util/libasm.c b/tools/perf/util/libasm.c
> new file mode 100644
> index 0000000000000..6daac121b8f81
> --- /dev/null
> +++ b/tools/perf/util/libasm.c

[ ... ]

> +struct disasm_output_arg {
> +	char *buf;
> +	size_t size;
> +};
> +
> +static int disasm_output_cb(char *str, size_t len, void *arg)
> +{
> +	struct disasm_output_arg *oa =3D arg;
> +	size_t to_copy =3D len < oa->size - 1 ? len : oa->size - 1;
> +
> +	memcpy(oa->buf, str, to_copy);
> +	oa->buf[to_copy] =3D '\0';
> +	return 1;

[Severity: High]
Does returning 1 here cause the elfutils libasm API to abort parsing the
instruction? If elfutils expects 0 for success, this non-zero return
value might indicate an error and cause disassembly to stop prematurely.

Also, does this correctly append successive chunks to the buffer, or does it
overwrite the beginning each time it is called? It appears that oa->buf and
oa->size are not advanced by to_copy, which might cause successive strings
(like mnemonics and operands) to repeatedly overwrite the buffer at index 0.

> +}

[ ... ]

> +	offset =3D 0;
> +	while (pc < end) {
> +		struct disasm_output_arg oa =3D {
> +			.buf =3D disasm_buf,
> +			.size =3D sizeof(disasm_buf),
> +		};
> +		const uint8_t *prev_pc =3D pc;
> +
> +		ret =3D disasm_cb(handle, &pc, end, addr, "%7m %.1o,%.2o,%.3o,%.4o,%.5=
o",
> +				    disasm_output_cb, &oa, NULL);
> +		if (ret !=3D 1 || pc =3D=3D prev_pc) {

[Severity: High]
If disasm_cb propagates the 1 returned by the callback, does checking for
ret !=3D 1 instead of ret !=3D 0 cause us to treat an aborted disassembly
as a success? This might mask the truncation error occurring in the
callback.

> +			/* Disassembly failed or got stuck */
> +			break;
> +		}
> +
> +		args->offset =3D offset;
> +		args->line =3D disasm_buf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609051759.4050=
27-1-irogers@google.com?part=3D3
