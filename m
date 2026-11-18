Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973336;
	b=Wd9L7rp6hv8zPyPx9Udi9SN/8rNF9zyk3MbjT9M5CsqjE075sTr1P6/M02XDflU0uTjh
	 H8zkP776AdUonuFdgwvvRppbVDyb1GnPR3RyQeMGgW9BYAVOiVLOTlHhET8pfwKWhAIB0
	 FNI8sQpMEwvn2UKcYze09fZF0oykk2+f7NKNDttxw0hgmaVT99CE+lvuj7j8XEDQ9Kqkp
	 pvdbJ7GfP4Dmkf9H4qxbq+7tIuy1iH3UYdWaiSQhA7oOXz1bHQ+OSI7U6ZV8sPQyQtR0x
	 mvcLmdzlwl239i+nsL1X5iLCey4LYCn+Aa0hl8VA2osD6m5f43LMXuKYJr5k8C51TRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QLQQDlXfGYpX/zt1pVA5wOGdCE7geKhz/IyZ5fhuPZI=;
	b=vHg9HnEjfOj7UxhFGlkdknEeNW/fTE3YrXns47VysZDUTMdlY06+qMPj+FAaLUwzR+HO
	 G2AkOG9ViUChIp5afY76scG2A9DL8Gd9qe6kQoYXpYIn8Q6FH48OSX/ZUQcHJE0KAXxSw
	 VNummbu3SMOlvyTjWMAdkAqVBQDUu5aUwXE5XeE2gJvaO9/36dGhqGoyASquGF4p0E6mT
	 cKaA8qncIhetdAVCEghXtyidlp4rtSFFvGV3i/IlbWYgQHmv0OrVNdBXPsa8rCCljTmzt
	 hRwzuRfDWeX/GG5Woait1RuzVPK+HppgHh4QY0xDch6wCYYdNzFvEr/JwuPa7WMh+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaUPlcz4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA2606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MaUPlcz4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDF71F000C4;
	Wed, 18 Nov 2026 03:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973335;
	bh=QLQQDlXfGYpX/zt1pVA5wOGdCE7geKhz/IyZ5fhuPZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MaUPlcz4+KSCapUR2xTyLD4GD+dqQ8F7Bn8TsiBi2LQNuBUQ8n9rRHW6x3PeJvxmt
	 xmCamsigbrJ1r9m3yzq1d/Fl9cw9p1imOOShmGsAgxS8mwLs772T4S+VKcpGxMZUX6
	 c7JYMNfyIu71zYthoPOlI9Enf56bsP1LkfL92yImnlJ4mDLemZH6NxZQKm8Y2fcqFy
	 8BKgNkGGIjAni+nJHyUVFFF/OHl409EhRVEgAJ4LyP+aRb/+ZixuaLpNVOkOYLQGsi
	 Spmbay41i6pBV4zgvwnTsvXpkNFAsN98b9qY/8JJdv3lBIA/WH9jhWTmVrBOU36PBZ
	 aPG0JHhdn1Ptg==
Message-ID: <sashiko-outbox-220033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 09/24] perf/x86/intel: Keep LBR frozen throughout PMI
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-10-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:42:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On PMU version 4 and later, the streamlined freeze sets
> PERF_GLOBAL_STATUS.LBR_FRZ to freeze LBR when a counter overflows.
> However, the current PMI handler clears the LBR freeze bit too early,
> allowing branch operations that occur during PMI handling to be recorded
> into the LBR stack.
>=20
> This can pollute or overwrite the intended branch snapshot, especially
> when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
> In that case, branches recorded while processing the PMI are mixed into
> the original LBR data.
>=20
> Defer unfreezing until after PMI handling completes so the LBR remains
> frozen for the entire PMI path and no branch activity from the handler
> is recorded.
>=20
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D9

