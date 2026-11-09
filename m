Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261526;
	b=Ws4Kh+j79+sBxlx3JRMjYjaWUAsq9H42oXiuQn2Ynk4ziIEYRSZ/ec4iSkUqCCkaAqDQ
	 Y02E539dGO+LtppAY5t1gPSyg7dGEbhOWQXHAh+7tS6ei92cmcL0iELWeHbXFTZmeOIUy
	 pIrQ2As6xxHFhWwbZPk7+5oFgu91J89mzvZBzIi6iQmqzFoK6dfBAOAlaJBCDxwt88JGE
	 UNIZI1irIqFX106jlNhIkdMg/Xc8dhAGLioTfsXtVI6/SRfCJtx0mKW+PgiPTmD82u80d
	 pXWhEDJraw2pmmfg0nmsxwQxdHz7DfUbV+U0QT5tELXBUXuoIsmTTuK+k5jsqRKcVuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uLqVpYrYugblw2s7yhpIxkAJxoE4Rn6STxGt4fwu078=;
	b=JU+JdLafrqX1GuGrz56O0bCt18PW39iTSA/HIFL/sWVmq0tWRKS0vP09hDbhO5+1RBno
	 B/Fjk+ELaWEqYFwNM03gp3yo8wqWMVyH2tYGxIOUoY2AK/oAqTWchIW5hkaJRgE8wvSS/
	 TSalmuY5zqUGBiibp0eQmlpZGUyl3INHEtl6GTGgSumOAXtk4/vLEEjDj8AcnqTVEj8D2
	 TiRCmtnYRJZ74ZZp7bvGJKCpX46/LMkqfEztv8kmtZSKu7DyrNlGPMAy1w8BDL3s2vnUy
	 nw5dnJb36taqilp0XsRWDFHbhTnXYS75q1xOfDdp/Mk0lDUYHhO9Cqy0hXr2katY8bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEwJD14k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC68606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEwJD14k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042091F008A1;
	Mon,  9 Nov 2026 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794261526;
	bh=uLqVpYrYugblw2s7yhpIxkAJxoE4Rn6STxGt4fwu078=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEwJD14kRGlTlicULH9KRXiAO+kVMCg1Dl03XUwwpfR6alYGbxbFG84/SVANfHZPq
	 trbF4x8OoUnXi5gYDepR9bz44WaxQXpgNEoqMJR7X1JUk0bH+9ObdHWsi5P8x29KmJ
	 dftPj2l4AgC88eyXtnlq/QQuPncNabU4vlYKb7oP0RrRZDOdSbsxLCfJOWZFlzTT91
	 IjNULtFi7nmeeUrO8TkqSUmDp6XRWNbVLGcZR0LLf0fMHECbTh/pelHTNcd5LhPoaH
	 8UWehO2ysT6fyqPBGqdZJxcz2z5cvW5hnmYZa1c4pVpL9x2Gw49HWLDcnczDgR7ri2
	 /L6y024qZDyRg==
Message-ID: <sashiko-outbox-205700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 16/20] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-17-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:58:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D16

