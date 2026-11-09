Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219917;
	b=0KZAMOcf4hQ8O+Q90RMopstZrcfgdUHCvONbuQQ9wRSLetM31SLj8WF+5YV+KjYv53AK
	 jxkIeWwy7nhNA84YrTfEy7rHAzW7Hgw+WKxRXzE8Junz0+PGnfcP5yIB2uClGFVZvvFvi
	 NYwz6Yx+EFZrsAWbyN5pzLmfwg+bE39sesNXRlybTJSkJR8KOK0RRb52H6B15WStLeDhq
	 4AlzIXsw18aaL5lyATKiSrUTExJSSOOQQuisP06UvS67gj351Cfp+ZY2FynUtQrGNVO0f
	 AatlH8jIyhNqcQ2/2Z2oUV1FzD/gi5YAeJ8wG6czrJae/CmfqEu7Os9ARptWsdEsjvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219917;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nGyxI/Q9JmeepkVOALMCx5GBmOlBB0FwASBy9mF3VVY=;
	b=r21yrtDgLEMfRxWg5/P3LHFX7jrDtifdhzXZqTXzt07aBMz3NsbzixjD6WzdcCGToyHO
	 eA6wZMJJ50Sy7vm07P7BDBqX8vogFXHTaTCN8umfSji8sAeYGLC9oZw3BnPFia/91t1Eo
	 lwJa0qd1xGtwEhzRIRms93sNbsr2aQ/7VeEcce3YNgyvIb6bgu+Zo4FMKLsPORdsTSDUK
	 3hkmP2gvXuYpbQ+CXRWmN9HHMejBLx9V7IzJPGTl1eQNg5BCUlyLvpYqJ6XL1mxoFp6L3
	 I+55r3LdKnpYh3G2/YRcszZb9OdLpQesI1pWL9hQjKeaOIcmB5Fhe7dd/SrML3X8JQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auaWciCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13286606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=auaWciCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863641F008A2;
	Mon,  9 Nov 2026 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219916;
	bh=nGyxI/Q9JmeepkVOALMCx5GBmOlBB0FwASBy9mF3VVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=auaWciCLiHWmwUjG1WGhWr56zeWDJpFaYWZrSdiFMd+sWNOHEe8oALN2F6+xDzXss
	 uEYmgY0sPA40Kk2FM2phjT9DpJV/hiPF0KIiPpwdkkMcgAa07c76mldOu730MrN0BE
	 qOT3ozgHybv7GP1VZ5ME+/TlPhpkZpRWMSmhJTfSF64MG4TZxRoxDxgAiBIpHOeWYN
	 7y7vIqTdLD9p3qTXoW7V/o9fNklX5In5Mb0VuJQSQ6QDs8bh3kClH2llhOxJgnCxlL
	 9Zteg0swXY0LDph/lt4nkGMEBbEAfq6T/I4euMVeJV8AWoa2M7Mhmbuoz1IcyRa6HV
	 s//6z+iEssxdg==
Message-ID: <sashiko-outbox-204814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf dwarf-aux: Support DW_OP_addrx locations
 for global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v3-2-e8d0a65e618a@linaro.org>
References: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
 <20261109-james-perf-test-fixes-v3-2-e8d0a65e618a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:25:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> die_find_variable_by_addr() and die_collect_global_vars() only accept
> global variables with a DW_OP_addr location. DWARF 5 producers like
> clang use DW_OP_addrx instead, which is an index into .debug_addr, so
> global variables are never found when Perf is built with LLVM=3D1.
>=20
> Add a helper that also resolves DW_OP_addrx and DW_OP_GNU_addr_index
> through dwarf_getlocation_attr() and dwarf_formaddr(), and use it in
> both places. This fixes the "perf data type profiling tests" test:
>=20
>   $ perf test -vvv "perf data type profiling tests"
>   ...
>   Basic C perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe C perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ...
>   Basic FS perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe FS perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ---- end(-1) ----
>    88: perf data type profiling tests : FAILED!
>=20
> Fixes: d60469d7c0e5 ("perf dwarf-aux: Add die_find_variable_by_addr()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v3-0-e8d0a65e618a@linaro.org?part=3D2

