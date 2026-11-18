Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019787;
	b=Sry+WjVuAgeqvbSCfn+ylq/JvYj8k3KHC22iKngYHE9pFh3B4cPUPJdY9YF172VchH/C
	 EP5LzSWGzzkbADqKD5TUJwkpe3yEbenLerfFaaJ5tacq3hMwJ17maLpwzz3G8X5dHfptj
	 MhdNGPVSrdZJJ8Ww/Z/fiGE42SOdaDx1WRdD5+lA2Od7ul6l0I45zErNUtp4gnE+v39IE
	 kXvkCxaORZYE6AqNVSYk6yRXHTu6A+wWSXS9iZZ0sUt6Gv8vPn3rdfn+Hb1uEI+aBxYth
	 Hs1zJ9PBI+60hB+XG6tMJuC5pElZeKCkJfTeVYEp9xNcPve9prxkaDG0J4tWdWfWGyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7b7kYPe+z7qT/J9up3hxl1qd3vgQny1PH/3zso9M6HY=;
	b=WKxXE9rLnb+VmHysC/LHnjK3ccL7rizL2E9e/tpkOMfk7ZAdwjbbLT/nsz2IcHLW7guU
	 +TRBorrFdEFrWZrz7a4G88UwXIolyLKMN9xCQbyG9dsWdiJCVch3QrUSK6JSYN0Lbe+R8
	 ADnipxgyjbYumEju8VY98I/54UJcZ+GFZzQwUHgyhk4W4JkX0zW+yzJJE5RlygKmDhKqu
	 PQKzbQAQaU93gEIsKLsa6j3THHsa4zlk0R4MfrZNGVUrcFNpF7TVNfG6r7XDHFHsG8TiZ
	 MhcrCsrt9R6t+vwF4wwHW9koIIPQe4JfBwUTYi5DKgIXGtY3yXOpWjiVCIlj1sWarbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kt/DEg1K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CD606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt/DEg1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ECC1F000C5;
	Wed, 18 Nov 2026 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019786;
	bh=7b7kYPe+z7qT/J9up3hxl1qd3vgQny1PH/3zso9M6HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kt/DEg1Kw4YFKIG6JlKKaoqLFLPVrLDc1blv071Nv+jvuwNrq0nfwvEUpT7I2Ltga
	 EQLYni2/PDGk94U47b0O8HCu0/EEazasytB875Icg5DPruSJt741IsfJxVVcxxz4UD
	 CpOkUEq3BmYPuxAjT6t2afCAo6NQGa24MVySs5cwmR+udjoUD5acsVoQGlMhg2ireV
	 gCXEnyt/Xfm1uCoJOu7dyoc/zEY+2uVnHlwIUH9h+1cnNM8gsBZs4B6UeLeXjNsaLn
	 gg+cOOuAzeJM7DLwi1FkOcUPoF+W+jME1tCabB0Q9UgDhcT7YFK5NSDUnJTNf4XWgv
	 sdltIq4H2ZPkg==
Message-ID: <sashiko-outbox-221508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/34] perf libdw: Don't look up the module by ELF
 address
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-4-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-4-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:36:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> libdw__addr2line() finds the module with dwfl_addrmodule() using the ELF
> address. However, libdw reports modules loaded from disk at a fixed bias
> of 0x10000, so any ELF address below that isn't considered to be in the
> module. This means that source lines for very small binaries and JIT
> files can't be found by libdw.
>=20
> This used to be hidden by falling back to the next addr2line style, but
> now missing information stops the fallback since commit (62d7cdc8d587
> "perf libdw: Optimize fallback logic for missing DWARF"). So perf script
> fails to show source line for these addresses.
>=20
> Perf creates a separate Dwfl session for each DSO and only loads that
> DSO's file into it, so take the session's only module instead of looking
> it up by address to fix the issue.
>=20
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D4

