Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250137;
	b=X0DZRKpFnXQmILns+MNU0T78GLH8svUV9AettsoWGrbxSrE/FNfr1tkXZvrkNKyYBlpR
	 nQ00yRN15kIqyAI89P3XN2qC+DIStHev5l8ZOyQqf8o0+FNonqvVuxDFzwvWMA+QXNg93
	 +SPQLnYhNX5Y+TANGirbD/gUOwRoByU610aiMvD8IePRyy+obZyM02r5UNlzE6PpzLN7s
	 QVuLq3bEPDottA/YJ5aW1r/5/mpBRSZasv+K1K6IvlbP/fZhNgY/5pW0yPiU1Thk6vMG2
	 T/RHT9cwb8gQX8C+My37oWeijz2H7H5y5E06fAPtB8qwd1Gyl2goy7r5ngWVnRWiOzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250137;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wLgGay1bVCVHTQPgjgiPDmq+ivTmE+04C6jHwXkYJ78=;
	b=qq8dqR8D3LnP1xODHQhTOD2el1zUachZ7oszshQr7zlIamg2feSyjwvWQvVLlNbmA7/m
	 9L97R8GLyfaC0lLUnVjVPGsQnHWZpHPsyz0AIBAR5W+T+Pc6bhRqrmNmZJ8H8oyc0ITLy
	 lOBib5AO7bayjUHD3nZh0gfvmhNistFoSkHru7cz4khK7rPHKuFyyxAcJ44sV+z/3Jnpk
	 B+3P/ULwk9e2t4hKORZpu+3CbySy2Z3/mZcIxCLjGgFq6a2QPqqNE58uIGmNNaNwrA0Fr
	 CtwdZkH6RdSXo8ryjysMTa6WUWjgo11B/3zGIgdfCYERaLVnY1lGAcbB93E9vaMf0WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6lGOAQv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED76606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6lGOAQv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFEA1F01825;
	Thu, 29 Oct 2026 05:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250137;
	bh=wLgGay1bVCVHTQPgjgiPDmq+ivTmE+04C6jHwXkYJ78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6lGOAQvYdN702NM+PkB6pv9xpgTWeTrN5+6xHJP87aweMzy2MI5fGkvkfzROVsfj
	 VIAobFu3RrFs/RPvxzfStI1sag7QbOOiNX3Yb1UKDQ/q+dfd3sVXd+i035HByZYOH2
	 vrRBpBAtq1r/Rqi47+oqyW8+xN03iw7cT9LrGYk4d7W1dmY1oAId8qGw+2pqo99Dyr
	 CufF+HJYp9rdSq3C0B7QMXYoyx9AuyJemnhwEt462dhCKjil4HOKxUZs4EMg/tmQpm
	 5KCYvpCB5DgVx40zC4OIzyMVFX98YiWQKAxFil2xaLGpsyAigGZsTA0FmfFaEjrBRA
	 g/Q1yPMJ36aeg==
Message-ID: <sashiko-outbox-188724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 08/18] perf/x86/intel: Avoid re-enabling PMU and LBR
 for BPF when disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-9-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:02:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __intel_pmu_snapshot_branch_stack() currently re-enables the PMU and LBR
> unconditionally even when they were already disabled in PMI context.
> This can cause events such as cycles and instructions to be counted
> while the PMI handler is running, which is not intended.
>=20
> Only restore the PMU and LBR on the BPF path if they were originally
> enabled.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D8

