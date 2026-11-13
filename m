Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600763;
	b=QborKRvCx8YXNGttPCFZ5kR0T1t7ASvrLw51FMXr5ZdmGMqJ/obT7gSTguzZbbV5/+1Q
	 BFE62wLJLHE5lThHLSeTZUJeQysQxBPvxQZoSu620Xr/6bUD+xwkUKvknQpdJUIX6/0Rs
	 hHQvBsfHw75iMiMdzG63paE3eQSYRJj0Q4s60rDWDD5xcDW5TTxY+rGfYi23wBtCG0UWF
	 XAQNpQvaTsf27oZ1+lOeBtX77LiNyUpkoiBa/X+39qwcIclHLRY/4G1VbARrQ3jmGiCnO
	 wYFWGO+owt8Y6tz/c6+Y36UMvR7pbhcdodM9Q4E1iMk1L1YgVmjB51mNcdinoujcPWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HF0bw9JWMiSf0+/XvnRYSDGDNilkyqdNJ4e0Rwj8NBE=;
	b=fR8UpPGHXmpG4feFvb6m7nRbOBh2zGz5W7c+064e+QLg80+dcBcklYeoKMjPhQFofyDe
	 SLyahnycBfHXddG/UJKUV6m79BxqIqX/4Tn4w6UGWqVqOKa6/EzgKan569T9/PpAlg16J
	 nlmiDLbmAOiXF7PTY9zkIbY+TLBac7VaFEF7cg/hkInHWNcdDYaPWO+p1diQMx2Rk3bgX
	 qNRZAJ420IikYHf119y/kkPzmiLSA3DOOrgyR7/DErwR9btNiP3kY42/QNH4SvhIAQdmJ
	 ES5FhmGInHRvrVbqS3PGPYlr+VOBgdGsPayuGgaeoOBP7kroGLo6k/Cn5tx4sGcLzVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BvYXPwN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EF606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvYXPwN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFDF1F000C4;
	Fri, 13 Nov 2026 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600763;
	bh=HF0bw9JWMiSf0+/XvnRYSDGDNilkyqdNJ4e0Rwj8NBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BvYXPwN/CAvXWZ/eH3ozSQDaQ+1mlzkJCXqPYJqbiuwhZ4MUNqScW3+LftmP+pFFi
	 oMeQOOqMDmfUANlo8s8CXSrkbebe7bgaob4nj8Qsjiq5zXhoAoZEkYwOluGqk6jseb
	 1uk6krodsMBCy6CrPWB/nRxynpcMHhhYEgmPMHk4knjIH03ddkn6sBuFflvIOAUigB
	 HMcz51c95X8vvqtbfgPd4DcjsV+q0z7mYlSnlQwFVGFw83oN/sN0QYSLkPUW78Po+Y
	 h2MnZumYGsomlMcWvTH2vXOjX4RxfeKu4rI5HYMbgJiADsqPEWFCpCdbdCoSqsbsZX
	 cLXz1KLBMTLLA==
Message-ID: <sashiko-outbox-213624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/30] perf pmu-events: Add e_machine to struct
 pmu_events_map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-12-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:12:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CPUID strings in the pmu-events mapfile.csv files have an
> architecture specific format, such as "GenuineIntel-6-55-[56789ABCDEF]"
> on x86 or a MIDR value like "0x00000000410fd0c0" on arm64. When perf is
> built with JEVENTS_ARCH=3Dall the tables of every architecture are
> present and map_for_cpu() compared the host's CPUID against all of
> them, even though only the host architecture's tables can match.
>=20
> Record the ELF machine of each architecture's CPUIDs in struct
> pmu_events_map, EM_NONE for the test and common tables, and have
> map_for_cpu() only consider tables for the host's ELF machine. The 32
> and 64-bit variants of x86 and PowerPC share tables.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D11

