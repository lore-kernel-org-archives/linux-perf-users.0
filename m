Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D79146D5A
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837488; cv=none; b=pMSc+nBOKiSz0w+lt81/xefhkzOrvT1uh/l72h4Rv//gu9jnuD+TnNyIc8z8dcTVIaFILGzzJ1KIhkgC+FQGjT1xJLspKxO2VaXQgvib/Qi9HqMXdlGfwa3KJCoMVbbxt1jwy41tqDVPcXUy420ncluodSCPgD6oQTpaRgGa9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837488; c=relaxed/simple;
	bh=kg0wh06CF050GUIZdsSf7aW9YD/OICgPEfXpjS0aiis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImzYdODzTsWeOf5yHByDhz9VE08HQ1DdYMq5A2scqT077T0FiHD3KKXnaSsUZBMqlpJPgarLOR3FMs2PuZ/VbsfS4tgN8RfyL+LE85Crc6lLuNDux4+15WxfoZjaAfMlA1B98Cx4mCP75a/qXQ/EYAWHyD3v9QxLYUJoyD+C/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFau9Dqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFau9Dqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F6D1F000E9;
	Sat, 15 Aug 2026 23:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837486;
	bh=GvwSLbw1m03t/rBuh8C8NgeJ57PiBQN8fcgPpBsq8vI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFau9Dqxf6oc7x2GAXaj71Yi/HrRcg+65hc2uEVFri5q3L1D73RIycp3aMjLAi+xY
	 2p+Z//WqficoL4Jxmp5u07S0fME0gouG5PChiehc5bJ1TNWUx+UiTX1EtmDT/Rk/5P
	 q/YFWTUBWMaL2sAv1C4TiFi7in8GaAERKiffc3ky0suImYckcSwZxVglC5+hpQVLIP
	 sbDfqL3GnCDnvS/hg2bAPHkeNtGKhXvkRt77fGRlYslHRUvPn3bOWMtSWq7g4Z6Am+
	 Y/NEDLLYU6xq6VcYgmEuepVeTZm7YyTpMkogD6Qetf2wfKCiYeyfnHbbqiDCGmkmhA
	 0ddK1BLwKcL2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next 1/3] perf trace: Introduce kernel symbol
 beautifier for virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815233651.527936-2-atomlin@atomlin.com>
References: <20260815233651.527936-1-atomlin@atomlin.com>
 <20260815233651.527936-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:44:46 +0000
Message-Id: <20260815234446.84F6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Memory leak of reference-counted `struct map` handle in `syscall_a=
rg__scnprintf_ksym`.
--

--- Patch [1]: [PATCH perf-tools-next 1/3] perf trace: Introduce kernel sym=
bol beautifier for virtual addresses ---
commit 0ff39d14d9508d5e3c586057a78b07cbcda7f7fb
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Introduce kernel symbol beautifier for virtual addresses

This commit adds a kernel symbol beautifier for perf trace to translate
raw kernel virtual addresses into human-readable symbol names and offsets.
It uses machine__find_kernel_symbol() to look up the symbols dynamically.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c3c7f1f85c530..102221b301a54 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -750,6 +750,30 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t s=
ize, struct syscall_arg *arg
>  	return syscall_arg__scnprintf_hex(bf, size, arg);
>  }
> =20
> +size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall=
_arg *arg)
> +{
> +	if (arg->val =3D=3D 0)
> +		return scnprintf(bf, size, "NULL");
> +
> +	if (arg->trace && arg->trace->host) {
> +		struct map *map;
> +		struct symbol *sym =3D machine__find_kernel_symbol(arg->trace->host,
> +								 arg->val, &map);
> +
> +		if (sym) {
> +			u64 start =3D map__unmap_ip(map, sym->start);
> +			u64 offset =3D arg->val - start;
> +
> +			if (offset =3D=3D 0)
> +				return scnprintf(bf, size, "%s", sym->name);
> +			return scnprintf(bf, size, "%s+0x%" PRIx64,
> +					 sym->name, offset);

[Severity: High]
Does this code leak the struct map reference?

When machine__find_kernel_symbol() populates the map pointer, it acquires a
reference that the caller takes ownership of.

However, this function returns directly on both success paths and the fallb=
ack
path without calling map__put(map). This will cause a memory leak for every
formatted event that resolves to a valid map, which can quickly lead to mem=
ory
exhaustion or LSAN crashes when running perf trace.

> +		}
> +	}
> +
> +	return syscall_arg__scnprintf_hex(bf, size, arg);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815233651.5279=
36-1-atomlin@atomlin.com?part=3D1
