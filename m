Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72E545D8C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188860; cv=none; b=J9Zg8KPHABaWV5uqi2fc93GUbMdl/jEOCo91xxlCQ28pQPXGeHd2Ras5ZL6DlJNIFchizlUpOCPemCFgBbEY/t+hpo/237EbGV+2rmtN4CrhXE1oixp/bM0D3QGC/+bH/+ZKnaQSOKtq6ls3rU7a7LhYq22+8EDSj46dr+L4WwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188860; c=relaxed/simple;
	bh=PFJs/KetOGG7uCDEjDEZs0gSVp6UFlxjGkFuhSSpR/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndZ1V3xGIpiH4qhykOqeG3WM7N8cTQ+UN8A12KZxreOK2N1qrBnIFD4mXXlvS9eSaVNInOUTzh6RhgneRJfXSu3iaEvp/Vwp3uVaGcwss4hR2cK0+yTdV8zKzrJULdwPvl/8D7apWsyCGIh0vilyHZIssU8mG87lbtBm/rzX2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5iuXTIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5iuXTIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0271F000FF;
	Wed, 23 Sep 2026 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188857;
	bh=Uw/WTSGihh//ztg9rDgo5lmRM4+l4iKJjHIAFi43NSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5iuXTIEAcdnwD5shCK8lWTZwcKNm0KZn0Su3yJ/wYS6Pv92uwopzpqO4jZrqTKI/
	 cINSvW0xOGCg3ZpvTCT3cbL2JdpEaXMqeHSnuwRUU7DvD/hlyptU1r+Gw/5vm7MyL1
	 qTIYWGjaNEc533mBGgivfKWZKfzpoqo8k9sWQTrrerpBCHCl4owU2p4dNpAWYCkqWG
	 M8yhLWMaA0crRFZbzTwiopI7Tq6y65kgzk+SmpeWSvtNxi1g0j+9bzG+clZ+FhRXzr
	 E1I5XXhK362f4XuZeEbHBCZrPDQO7s8JZDewjcnpWZ5WOYYEy0cMr4Ioq38KMn3Q7e
	 D8ZTBT33pBKVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-39-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:40:56 +0000
Message-Id: <20260923184057.3A0271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port arm-cs-trace-disasm.py to a standalone script in tools/perf/python/
> using the perf module directly.
>=20
> Improvements compared to the legacy script:
> - Encapsulate trace disassembly state in a TraceDisasm class
> - Automatically search standard kernel debug paths (find_vmlinux())
>   when -k/--vmlinux is not specified, and query
>   perf.config_get("annotate.objdump") for the default objdump binary.
> - Bound DISASM_CACHE memory consumption by evicting the cache at 1024
>   entries and skipping caching of oversized (> 512 lines) objdump
>   outputs.
> - Use sample.srccode() from the perf extension module to annotate
>   disassembly output with source filenames, line numbers, and source
>   lines.
>=20
> Update the ARM CoreSight disassembly shell test
> (test_arm_coresight_disasm.sh) to invoke the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D38

