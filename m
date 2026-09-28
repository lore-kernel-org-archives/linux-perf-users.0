Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2319F40B
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590842; cv=none; b=PjdqtLveCGmISjQStWbctEXybmszVx4Q4aWkZaq3oLU+WWy2UVUTbPvLETtZfLlAVrfkE9zcvx+Y0UX9Yd+se5agnADNug3mfq7gdDGTBDa1lXfO5nDeBrY/57msMmeVjnxzumFjQV35z1J/GCelKElr4vxJJS56Xubgq/KSrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590842; c=relaxed/simple;
	bh=TkTxOqv610DsgWgcpf3TwNXqn1NDt5pAlAaZiac4cJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DUkl01EdOu5KYQDGN6tywkIJMrtxYFiygYnz+QQ9Udz/YezMJ82uVqfOR+iqre86otWg4bhtm/r1RomuPNYYtlGTTV4cT1sVwVTOkfcIzquJPxEk3t9F7z9nbki/9j3wTv9YeFL+WjYaDeax97U/R1IvPWSKkr4X7qcb4J3Xngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaFNFDi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaFNFDi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491221F000FF;
	Mon, 28 Sep 2026 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590841;
	bh=TkTxOqv610DsgWgcpf3TwNXqn1NDt5pAlAaZiac4cJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kaFNFDi4/f6Kuwxpt2mEnfwNy4HsPX+jQwcwnEyqHaEjrAYiMcw5vRg0JjaQYRDX+
	 zwOwdDmZqr9aEMpiqJ5iQIruMAIUPpW3CU3XDLwUw+RHVXMA7J3qC7g9ysDn3bba8m
	 Iq9RlUTlEnZF+Ji3gmcn0exLaLkd9elTwmfuFYuFTQ6JluK4IPPyFkUhnph/FbSU4v
	 W+7al6N9gMvAwOamAPVoqisC6XqQhdXHua9imLP6wN8djF9QZJQKE1hVp5yiGFg2eJ
	 EsEqOg+mcR6BUmJoCYNYCE/16VL6STinTe55zdj1OkzeZAtpgI4E3xpNp6T/N3GRa1
	 OPAa3tBxApqYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test: Record kcore for the CoreSight callchain
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928-perf_cs_etm_callchain_test_add_kcore-v2-1-24fff6fab009@arm.com>
References: <20260928-perf_cs_etm_callchain_test_add_kcore-v2-1-24fff6fab009@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 10:20:40 +0000
Message-Id: <20260928102041.491221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The CoreSight callchain test traces both userspace and kernel execution
> and checks the callchain across a syscall.
>=20
> Add --kcore to perf record to save the running kernel image alongside
> the trace data so perf script can use it to decode the kernel trace.
> If kcore is not available, the test will be skipped.
>=20
> Add a Fixes tag so the change can be backported to stable kernels and
> improve the test reliability.
>=20
> Fixes: ca0e19074bd6 ("perf test: Add Arm CoreSight callchain test")
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-perf_cs_et=
m_callchain_test_add_kcore-v2-1-24fff6fab009@arm.com?part=3D1

