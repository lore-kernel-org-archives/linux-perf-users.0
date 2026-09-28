Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C082877DE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557637; cv=none; b=gdMGCm7G4Wjapp0m6zOUxlnH6kditlr/zios0j5ORQgjD6HVSNEx0U1VZSfrjgsjzuRwsJOdx2nsINp8DVcbt/K9RMXsq2HSxxkvIkU3LKNi6ZoIdsU8UM8frK8k2v4gyIrWey9IpWS4PdQHbVKNdLjvfuQLq9nso3ILfRFxj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557637; c=relaxed/simple;
	bh=ZKT5fxoSjIeydWyftEM9RMJjRErHJzn6Y0XdobpPl/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N27f3nVMYcdsWwweHAvljmtlqA1uEgtj2mOJkPDzxnFvXlW1DnSe+ifjA1SDVWncIQq0ZDH+mRAnfJc42X9BjCRbhhShYDjCuZVdd6+VFW/azFFQYVPsBR8pmgntIJITxLC81Hets3q772oqmnkj3kM69Z+cZs+zTXTJKW8jxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs0Kiktt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs0Kiktt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEA51F000FF;
	Mon, 28 Sep 2026 01:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790557636;
	bh=LwXeyocLv2D3l67m5qk9rscya0PaaH7Rf8mcxquZiGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fs0KikttFcG+0n27iPmgWs7BA8zfEbuc3sbgMKs1/EHywhJ1Sl2PHoTqmSV6vc3aR
	 ELjWRFZoqzCEhbxyIWlyF+RfDXkNBRxGR38t2W096LKUvWco1XZOeh8hjDzUgN4+js
	 /33iTNn5TDyLjJMCGQc7pIuBa3OdTTkSs9R1vgT4yQlnZDT01g+UqZ9xnPJxIrbRXV
	 OweNvPx5YD+7HR9cCpSynwwVmf4R9v3mpNLF7HHk4W7HCiKs+Tq7gL1qCby4qEo/aN
	 LeNdYB1hU5Etb/jmr28mtKZhL9n6fQHwNa184CLa7gqjqxm4BpDjoY//JLIWTwRzED
	 46NOblxlz9DKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf symbol: Move Rust demangling into its own
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928010227.1903673-6-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-6-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:07:15 +0000
Message-Id: <20260928010715.EFEA51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> dso__demangle_sym() is the only place that implements demangling logic
> inline.  The other three are one call each to a helper.  Move the Rust
> parsing and buffer growth into rust_demangle_sym(), with the same
> signature as the other three.
>=20
> A Rust name that fails to demangle now falls through to the other
> demanglers, matching how the other demanglers chain into each other.
> A v0 name can't be misread by any of them, since none accepts its "_R"
> prefix.  A legacy name can only fail here on allocation failure or
> hitting the output bound, neither of which is language-specific.
>=20
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928010227.1903=
673-1-michalpl2003@gmail.com?part=3D5

