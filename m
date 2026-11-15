Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707287;
	b=RbeEreBdQG1n74FYHnRr6uHZVQlnNkk4xAJaoWtBXJOILI5unDOgCFor2drxHALggna1
	 o+ME1R73pbOlSsrLVhX5vYHnCC7H7MsdSAtd6wJQVVikkF2oy/Q1z9eHWyRafb2pDsgtL
	 hiodSny6kVHbFOejhrMN77hpuI0r/MAmicc04D9JDteFu5r2PB2fwFKOallNMEXAcMoRZ
	 Z+smB3r433Mi7CMvTzJyJTZGSNkCvFhZyN3IZclGQF9exmq+dA5k/NeUxaT8BdMeruz4A
	 P0OXZxJ4ZZdQVY6Jxoq78OqOSPBPkRJ31JEAHEouP2R+Wfztp2c2EnB4W3r4cKbEPSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8p0CR49Pj0Mb0tOPY71R4JrDVEt3Y8ekfNJfOQCkQ/c=;
	b=oBF47SSafX51rggCpuVMJR4wmg5BWKLb1/D2BotHrYLAGnnJtYQN9NSJeoEk/a4YSqzi
	 REAaH+0ffO8m8exstgIdZ+I0c317I+7xNx7MardhRaIkDjfvl0hex9NmwwDXnc+LmSjw2
	 iuASwzkoSQkn1+SxjgLLCKUrIRgBtaoJ/umBrmPJ20Zy69l98AS39mgVCfL/dsq14SR9x
	 A5oVyBFm3dwju8Y1T3LHMCyx0xZ2aWx2Res6PGgSqLCtCSF417Yqbh9nQMRm6fWQnHXPT
	 aT3WytUcvqq0OStQ6D6tyese6fgm377YX8agnfDqvAPEuUwaRdWfbAsmUbO+MIpypXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb5m4p5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C44606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb5m4p5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2DE1F000C4;
	Sun, 15 Nov 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707286;
	bh=8p0CR49Pj0Mb0tOPY71R4JrDVEt3Y8ekfNJfOQCkQ/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rb5m4p5cAKyavy3EW6mn2G3oRZ5veatxbBv4gUke8ep4N0atdpFGB+eWoiVqwk+Mp
	 P0YWrPVwd6S/T9X2sLMfuYhpdIpE+2CbfwwnDfvRQpxrDk8XCwIS1afvhtWEIzjYZ0
	 bND7CjKs+hFdEt3vHYlmzJZNgW2NSs1ACoFzFosv6SmjFnpO7vpswLvSi5SqqHsKpm
	 Q4OTNDQDTkXIJclrC/gXTiPyabUV5Gn82BuK1V+JVpFywKECY1O+KiySte0vaHAXIx
	 WLjwbPRwRvL7ymQtvfTcxX+ALDfTCNuFPkPhs9UePSBUdBxFFfh/ZiKp2Fi3qN+2Ou
	 mVszZgfjLezdQ==
Message-ID: <sashiko-outbox-215171@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/12] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-7-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:48:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> At -O2 a struct pointer lives in a register and DWARF describes it with
> a register location, while the unoptimized workloads the data type tests
> profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that gets the pointer from
> a volatile global, which keeps it in a register, and check that its three
> member accesses are resolved from that location.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D6

