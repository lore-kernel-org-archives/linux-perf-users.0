Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833A347500
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557739; cv=none; b=UTBa9qxis1BL61ws4BVc6YKbTowmSyFXsCXV7a1g3Ei0M7tHQ+SWbEYV/b9b+wh7WUQ0/aGwiGE3altUP6htP1JexJTgsPk7pmgibJcflJlKWVUXSLhbgf2yLZ8OCbZVj4mddE3lUknUzmrpNqxlFz+FVp4ayp4YUsOZ9aJKIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557739; c=relaxed/simple;
	bh=BwIW/jk1ow2Nc/IsOcA2yD7YtYwb9quOYyYSqlYnUXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOrmEgsIO4HNeN4C3k8EGZA5bLkUomiR5vABYYv/g2ThMI2V3GgusI/nLG3Xm3KOOdrCg2PxCEN4pVeWQDsy0n8wzx7/m7/p3OukLsWxUxPYf0Jr+MlE4JUoQwYhIj+fqzilmgX7TrSxmeAHMuICtLqT0XWCpPFaXlICqSIObII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxS+hd5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxS+hd5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C001F000FF;
	Mon, 28 Sep 2026 01:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790557737;
	bh=9Bds2qFNEE8Q+GfzjrgTLZAF6Db6zVPfWVZGOTbtlCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxS+hd5kIbTrKiocEf8kqlyGjMC82tdUvmBLDHyeKGijnNcyZvuh4Yi0m280C/pfH
	 HR/61QUKEsje7iQoOF+jOLnyNGV5mPwly1UuA4OzPFR/hWEH/pBNaC0les/7wVZoC/
	 EbCeu836aoVaDUGpV825cPDWqT2zd7SaPrBEu7U52qHge79NcgoXTBwsGOtBZ6fwOl
	 r/dojefNU5UDlQ3Kte9zl5ZqubbSoBVOB20K3j6LA6H+/13Vgn+xW1Dnj8aZdsMw9C
	 GGJAVWFT5CNk1xagTIG5kTkg4kxVjR3Q/yB8gdQOdLIsNE/Hicm91urS4Tfx2N5g1W
	 lwaHc3bVBHTxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf symbol: Grow the Rust demangle buffer
 geometrically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928010227.1903673-4-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-4-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:08:56 +0000
Message-Id: <20260928010857.50C001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a demangled Rust name doesn't fit in the provided buffer,
> dso__demangle_sym() adds 32 bytes to it and formats the name again from
> the start.  The number of attempts grows with the length of the output,
> so the total work is quadratic.  Names with deeply nested generic types
> need many attempts, leading to noticeable slowdowns in larger programs.
>=20
> Double the buffer instead, reaching the maximum buffer limit exactly
> rather than stopping 32 bytes early.  The demangled names are
> unchanged.
>=20
> Add a test for a symbol whose expansion exceeds the bound.
>=20
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928010227.1903=
673-1-michalpl2003@gmail.com?part=3D3

