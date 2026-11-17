Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942183;
	b=rBeCUrgvkHOmBcjQ6sJr1i1JAKygiuDjS+MmR/j5NdRtbNsxydVOSAdF0iU1jTgyEHxH
	 PugLLW0dD4UFXVKUFt1zVhXl1rXOhMkfS5Zd4dJZishNwJDl64eQBwo6NezC+gNeAak+W
	 E1xCNNgIUrzL1sKKBg+aY6JmiHpfTlMbM6N5AxYOT9FXZW/BEdjXRY3UgPjB8sxihj8El
	 0oyRXTcefaTD1hTF/GiH0+ftMMdHEZb7mx2I1KMbV8WfCROf0MelaZKHibIIHiJWout/z
	 sYqmxtHU7oy1H7C88qKmFU4ycznRa0KYLbOYLEeR80xM0ySqFIAV/VLL+Cvb9ZP+e7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hPA+/2ihh4zU62r/x7jr0nQBrvd8Rz3YhqPBwkEZ4FE=;
	b=3bIWK5OQXeORAfTtwbpwn/EY3AIs5LkXBxHUuvNZDNlhPWuczy+ndE/Xnj2mhrBLQzwS
	 ijwSOCGvVGf8G3Zk/tlIOCZ1YIcu80iSGTAbxBMLIW15PUJHdMp1N2gw/lEH9bxY1lMQI
	 JokwKFYORHOrPX3YpZ/KucRHqQvOLUZhvJyz+VEWKxJ4uNpl9177KLanxAYKlH/sCYlNt
	 JY/awZLB7mhMgAa+mu9hk1WkgyvjY6j0VHACgdK4RdoNWkFBdAYGZPkYv1wLLTLpmUUel
	 7hH62aRUt8H0ykC1trGsRGJHhESrqqrACE+prUKbF9rAH3Xct7vbN2GSiSIb8omKmWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lb/KBjUx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F98606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb/KBjUx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08651F000C4;
	Tue, 17 Nov 2026 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942182;
	bh=hPA+/2ihh4zU62r/x7jr0nQBrvd8Rz3YhqPBwkEZ4FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lb/KBjUxv6uDsF5FOg3IYhQpuGtSm3mPloplKOUw2wZ0Fyt7ucgnvMexzvNyDSHSu
	 fQ7oh2JQhkS9lcW+TobHLgdAUzqD89nHy6eWdUDDdHSCwOnx8qCi+xB+eM8PMGIU7X
	 13c6Hr+/CJgVreC2CzCCQsFOYfb9DOBIiWnvQL9whV2jTEBYipw3dpSfFpfEn+klAu
	 szIuhcA3+GmkFaaV8bgPsV48NpvPxx3p/NL9e0/q4mvRtHJ2mvluDr1VXfeWYNv+A2
	 JIkcWRBL8rXLEy6RVEir1shlNMDZVicq7ltHkpgMihAaQ2oDYveJI9iqW6qxDclqP1
	 6ymzvwmLXC/RQ==
Message-ID: <sashiko-outbox-219427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] perf call-path: Use struct dso_symbol to retain
 symbol DSO lifetimes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-2-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:03:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> struct call_path stores resolved function symbols for the lifetime of a
> call_path_root (in thread-stack call/return processing and db-export)
> without holding a map reference. Similarly, Python callchain frames and
> nodes store resolved symbols across Python object lifetimes.
>=20
> Replace bare struct symbol * fields in struct call_path,
> struct pyrf_callchain_frame, and struct pyrf_callchain_node with
> struct dso_symbol so that each retained symbol pins its owning
> struct dso until call_path_root__free() or Python deallocation. In
> python.c, this also avoids duplicating symbol names for call_path frames
> and allows pyrf_callchain_node__get_dso() to report the DSO of resolved
> call_path symbols whose ip was zeroed. Also document the DSO-owned
> symbol lifetime invariants in kernel-doc comments on struct dso_symbol
> and struct map_symbol.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D1

