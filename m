Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708471;
	b=suli/Dz7izqvjvAaMMjS3xTbpb97IFuYdmoYf/54Yeag0oL/N/nldw6N8pbcInjdP0vt
	 uHr0mPOwifArmQ4Gz9Dk6Vzvvbnqcoaqle5v6Y/zOQXc8EZSfSoRD49+P6R/COBpFVJBb
	 Xbye731TPttK6X8XeYCQ1JO318L/3NV0PFH0KOtUPL0UvcrtysmnuysU2L+Ucdc75mgSz
	 sf4S3F/ZGR9oQAQXzxsK94c2uxr1Ndvx2QfMUW8UWe/GrMBiL+su+JzEhBTOXOIPY2TL7
	 6USMdwi5EQHE5XM5fXq9eJdVGmVBF3ZmH7IR+fYicX0j9ovW1Aneq8GFq1tpdVJoInw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708471;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PbwOkQeMj8RvbR6+GM6dIxrIHu556+IHdJy/b7d7WDg=;
	b=qEn8cOR75kgiRu/AYZN5U1Aro+iorUd5MEu+WcSFu0KdjpMiGsOkXRCH8okKBCOWDEcW
	 KXYqGtK9IygHDVYrb5a5qH2TxHXAU3tKE9gfedR+UKua8cZm1LrTKVvWkmShAPUnypSnX
	 w63V0lF+ivIsRHaiDBk/5T9pR7xvS9pYuuytY3yGi/db2V3Gyo/ET4PFJ550fyqwrZRMR
	 zUCnFzmYtuXuaguJEpnL6BrLto40U892acJ9O12xFQCFdud13IZU7nCmJvX3OBGEWnUr/
	 KfDlsAL8W2z20Hl/u3DlJysEbe2gqWy+db4HlhLbPmG1kNdOy/ye+yrH+N0vlAzRw9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTPvaYXf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344D606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTPvaYXf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8271F01829;
	Thu, 22 Oct 2026 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792708471;
	bh=PbwOkQeMj8RvbR6+GM6dIxrIHu556+IHdJy/b7d7WDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTPvaYXfMI4qhn9UZ19Zwx8iHnGKbTiYD7i3xDXyRj6IHpXySLMbsHhGZqLoJ2sRO
	 eQSkY9tQyVRly4um+K2yW5haInr4D07/mUB3DwjaxBDN2r7hlruGBokQUGVPebO2ov
	 VB4T8Zj6fCQ/Q+T+k7Cly84ewfVPSdK+p2Jk2ywrD+exSbCyR8YZMHLoxhwrH/AV62
	 fIf5XXCTLKx8S8IHvTUMAeZgy9XsNWyUXme3B5CTq6FlT3T+N8VcRhfa5QEslK93YS
	 Fufkc7QTDA3NSRlWji4U3hK8zXN0L+BcO90r8C6b4Dd7MABCdwR1Drr81CpZvAt0iN
	 7sOeF2Pirhchw==
Message-ID: <sashiko-outbox-182125@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] perf test: Add per-test timeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022222245.2064964-2-irogers@google.com>
References: <20261022210753.1851597-1-irogers@google.com>
 <20261022222245.2064964-1-irogers@google.com>
 <20261022222245.2064964-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:34:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When a test hangs in 'perf test', the entire test run hangs and makes it
> difficult to inspect output from other tests.
>=20
> Add a new TEST_TIMEOUT result category and a per-test timeout (default
> 120 seconds, configurable via '-t'/'--timeout', with 0 to disable). When
> '-F' ('--dont-fork') is specified, timeouts are disabled.
>=20
> To enforce the timeout:
> - Place each forked test child into its own process group via
>   setpgid(0, 0) in the child and setpgid(pid, pid) in the parent so any
>   subprocesses spawned by shell or workload tests can be terminated
>   together.
> - Check elapsed child runtimes against test_timeout in the existing
>   finish_test() and finish_tests_parallel() polling loops, sending
>   SIGTERM first and escalating to SIGKILL after 1 second if the child
>   process group has not exited.
> - Report timed out tests in red ('TIMEOUT!'), track and display them in
>   the test summary, and emit '<error message=3D"TIMEOUT" type=3D"timeout"=
>'
>   counted under the 'errors' attribute in JUnit XML output.
> - Document '-t'/'--timeout' and '-F'/'--dont-fork' in perf-test.txt.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022222245.2064=
964-1-irogers@google.com?part=3D1

