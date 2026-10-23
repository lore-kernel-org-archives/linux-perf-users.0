Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762597;
	b=e0awPqZtu+AfQDoYEjIWqixAaCWmFjMvqY3aN4CiK+dVBhcpciXB5lqDcqLa+MDB5SG1
	 n1m58c3zhpDGO+PUW8dzVWqWGisAplrD5fFGPQowVhLspP1vw7P21SbChrARpDJz3rbEw
	 xcBYSfoXhHzXhb9kakzvY0A8s0J+KvV7orHvRUyutPPaiUfSQjhYEIvcphlxA06U8ElqN
	 35l/+Wq1B75CU6ASZT77jc2OV+fC6RHAIvzXWzX+TmhdsBl1ymDnYlY38wK2AnbJsM2xi
	 dH/4FFK5HYOdoPC25BEY8CsjgKsJzFQgfEwN5fvlxeW2cpbnhWSmtQ1EEtvboV58fEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pXy7JpyRggBJEvhqJZ871kc+cZo8gKWETFqz+v3433s=;
	b=MAKB4H5EQ0AFVxhFIr2sEOU7jzt2LGca9Mu02Xhx1Bo61HqHeUCf6pey3A6xd9TX9dcC
	 rG8TAenSR4s9O9ZnQo22kNqESfWiUMR2Oug/zLIHWQYP5tbgDS9C2yD6yv4Bl3+7vUeOF
	 0y0nBrAfw7gDz6Tq5W8uXMyJjB04NQ8Zqu6NbbGekqYTAg4hAU81J3oMioaiY0vAYOFKI
	 BsGniFjo9ADUgRAlVXhM8GwpYQM1/UP78zYnNsLciEzCWnC1DmLf6lWdJF4DjAmCjyZMO
	 wgdoMuVAe7JmqafsKBB9BY0lGrzpMVWUDZYcg8Sx/k1oi/91/kVJfZs91AGV1Ff3MGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXbDWlvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B42606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXbDWlvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E711F01825;
	Fri, 23 Oct 2026 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762597;
	bh=pXy7JpyRggBJEvhqJZ871kc+cZo8gKWETFqz+v3433s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXbDWlvA5YCNx0ozRu07+Y2OFybiC2I3INUB2lVyW9gAM0qkJpSM+/yRnWUdbKadQ
	 1dhN0IWMonhSCE2mGAZMALETwdePDiREDtXpRCbMngCinWq3LbeCEMJnxwy6eAhH9V
	 QxLxMCC0fvy+veSm8WYWKUUkyNXXV+k6AnmJDZwgcAgK/24VVnlGcvNth4wGU9ycrG
	 6Gy+LIREvtJvdgWGU23fQhhRggNqVMuAF6h6E0t5keFiQofnQjKoeh4Y82kqFZ50jQ
	 n+k0QyCnd0q87ZptViBdwFrw4zfQYmTKqleGPQasA89PDEX2bAYdiN9gvzPAllXO9N
	 /aXyUw1J/OD/A==
Message-ID: <sashiko-outbox-182829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf timechart: Initialize Textual attributes in
 constructors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023-perf_fix_pylint_warning-v1-2-b9da8dae2fe9@arm.com>
References: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
 <20261023-perf_fix_pylint_warning-v1-2-b9da8dae2fe9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:36:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When Textual is unavailable, pylint cannot resolve the inherited
> virtual_size and sub_title attributes, which triggers pylint warnings
> and caused arm64 cross build failure:
>=20
>   ************* Module ttimechart
>   python/ttimechart.py:1086:8: W0201: Attribute 'virtual_size' defined ou=
tside __init__ (attribute-defined-outside-init)
>   python/ttimechart.py:1422:12: W0201: Attribute 'sub_title' defined outs=
ide __init__ (attribute-defined-outside-init)
>   python/ttimechart.py:1496:8: W0201: Attribute 'sub_title' defined outsi=
de __init__ (attribute-defined-outside-init)
>   python/ttimechart.py:1510:8: W0201: Attribute 'sub_title' defined outsi=
de __init__ (attribute-defined-outside-init)
>=20
> Initialize both attributes in their respective constructors. Use
> Textual's default empty virtual size, with the actual geometry
> computed when the timeline mounts or resizes.
>=20
> Fixes: e7a72d691980 ("perf timechart: Add an interactive --tui mode")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-perf_fix_p=
ylint_warning-v1-0-b9da8dae2fe9@arm.com?part=3D2

