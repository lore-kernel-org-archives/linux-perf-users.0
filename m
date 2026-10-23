Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751005;
	b=iGVPdUncz/O3OFa6rnp98/BTVJitSHmb3t0em1xqGi6Qu3/ZI15xY62JZRbFpsCCl4CD
	 adTleaqohOLT3OAN7ix471qfu3cfezHJSbOUrVqFf4Fp4zDwlSq7NVezRQitg4qxh5K6L
	 EJos1Sa5s4PGCIsIF+IigpcrE53tGehgUww5AkU5rNUIFiJw5fpq/PlOnGgudnMIrkTDA
	 cd47fQyEyY8HMb6ZYoSDc+I8IaIoH9j51RAX5Gudts05TkvEdU82tIJSqbFsAwTKWhdcs
	 /UXDfpLAgXxcNZ/1jP04xG22V3aoauiPfE1Wr7tBNvMSUkWbI8jza5H+DLZ9TncXrAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MFxBX0TgOOqc+sf00j5n/NQik5baNqEsSn58wRPz33Y=;
	b=en47sfURRSWEwPROYr+u+ZZOLCYADGiZkKiMozoICiNdqM1lVSytbMmp5ospz98/emtF
	 F358lEotIAEVDkaUFDxenC2IuvNC5nxlwS2HDRAz2nRUGve9bXh1Nae2IkUrM2yLJqWxF
	 GYxSYQ+1S7EcF3pfKmCK3pR4azT3Y+UMkjzRWsCI8LSfkW7HcYPwFsVe52idCPYGPCF7K
	 6bxKkfwXYS8IvSX5N7YtI5ATdYGMUZ3kuyBra5ASIkH0q0mAcItUjmJD89WHuqw44Jkuv
	 328QlzQuksBXn+9/rTr9Go8/6c/sCx+WbXoxN7fZnIBOQ2SnILN87WJV1E5+MP0xzXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1EXHLF6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9D606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1EXHLF6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD681F01825;
	Fri, 23 Oct 2026 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792751004;
	bh=MFxBX0TgOOqc+sf00j5n/NQik5baNqEsSn58wRPz33Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C1EXHLF6itZa6gYjjDrZPNRO08M5xqF0BJQwcB85CENe0ewq7XS8FuMrLSV0z0slY
	 IXAmi29r/KBYDx8ZBNxkPPNI57ZP8THqs2EPHl/GIcUXUDOhq3MmFwi6VJSFPh4lPH
	 T6X14shDnXwyUUTOrU5tlHjXjoDZ+HD7BtT+9WQuo2K2IWRVLZNxV5kvBewOoXaGyG
	 Fu8fSyfhN8LnPgqQiJ5uet4UajfLGO/fCr+jBwjl+9B7Wuwr5RueYas17iyX/vVAov
	 8u0YdkPQVf3T56bKO9MNAPJOOQQyL46gDnepowXl7Ixhn2m0wMAGczTAvofTPocM1d
	 pOiXYT62XaO7A==
Message-ID: <sashiko-outbox-182676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf stat: Start tool events when enable_on_exec is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261023101256.1752713-1-takano32@gmail.com>
References: <20261023085554.1694434-1-takano32@gmail.com>
 <20261023101256.1752713-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 10:23:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When perf stat runs a workload, target__enable_on_exec() is true and the
> tool events are left to the kernel to start on exec.  Tool events are
> however emulated in perf (duration_time, user_time, system_time,
> num_cpus) and have nothing in the kernel to start them, so they stay
> disabled and are read as zero.
>=20
> For duration_time this makes CPUs_utilized divide by zero, and plain
> "perf stat" prints "nan CPUs":
>=20
>   $ perf stat -e task-clock,duration_time -- sleep 0.1
>                0      duration_time
>=20
> Start the tool events explicitly in that case.  They are started through
> evsel__tool_pmu_enable() rather than evsel__enable(), because the latter
> also enables the members of a mixed PMU group, and those cannot be used
> here: get_group_fd() passes the leader's descriptor to
> sys_perf_event_open(), which fails with EINVAL for a userspace PMU
> leader, so the members end up unsupported with core.fd released.  Only
> the tool event itself is started; the kernel starts the members of a
> group it can open.
>=20
> Skip the events that failed to open, the same way the evlist and the
> counter read paths skip them, so a tool event that never opened is not
> started and then read through a NULL descriptor.
>=20
> Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/=
disable")
> Assisted-by: LLM
>=20

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023101256.1752=
713-1-takano32@gmail.com?part=3D1

