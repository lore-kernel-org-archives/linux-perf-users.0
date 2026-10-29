Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249961;
	b=a0WXVAYaq0pmrT+Bxuynimq+A9Q9bYgOCM4Bf4XsLjM/O8NX7FI6i42kpKC0kj/AqYKq
	 PSJYCY7UuCH/GCzM5y6C1+oGJ1Sqjz7+N9UG9pBN+x3yj4GFuWy43hi6x0lqEP4xNByTs
	 xGrsnXkiC1rOGlx65FceOu3cVo0+qh6cLq6yNo+Nrk8DJzRGE/9vLA6vcIAhInnPSHkEY
	 GoljIBJdM+w0vWR+eEVDDcQSLcFSrVpsKJ3zT65Y0ZueOZkbX7p87yqvYTIcenPWjYRas
	 tTpBgvGRluOewKd64tePRl7ofVcx9LldueAuDJJ2RpFRgYs8rbZzW4LTVGM8mZT6/2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249961;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9kDbe0yh7n6BnoHo6J/RmWHspqOg/gy9Edkn+bTpJ/E=;
	b=hMOHCIb2Jc1FQcCT+NjVMsr223cA568rVrLAz2k+WcOEHSlsatY5GaqX2rMYQkf68yu8
	 oDJmXFmvmq42NmHKXpWMwMeQYd0fqXJgIPtWrkzxthkM2gnr3ondZZwxdFy6ZY3c5vn/b
	 yWDDSi4toELYmN98/RsjGPpkVdiQDhg6fjjzLOHSZZj/C66VPU7cawJrLsukyiq+HnNX+
	 hv3mlfhnRzWI1yL8B+Adt+kgGC1JVIg1B6RZj8XcsHdYF6lE6IlySll5nt8uI5uaqtz79
	 oyeHK09/gsBjPKReq+ttJn64Z6jmsbKZ1ZtZ/mn0zOOKezpZK0tw63yBLFTXuBByRlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaEOc3PZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19923606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaEOc3PZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC21F01829;
	Thu, 29 Oct 2026 04:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249960;
	bh=9kDbe0yh7n6BnoHo6J/RmWHspqOg/gy9Edkn+bTpJ/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaEOc3PZ1nsGVf/y2gtVuxD9rJW0pOXNnVoA0rms1YasbfZBQm1zuB1V9tkX/vLtM
	 LxXgEhVDjakH3KaKhw6IqBc1HRMpaqXrl0ds2x7TPqmJSxxpCf1Bv79bYVxqF15L86
	 jb3BZ0DoK5ukhWZ6vcMN1a+FG6YiS+81AzkPplfAfCOnu7I+SO9OQ5QJJvZ34fVfWl
	 fuWhAcnWuCt46NDkQn3C1a0mIsIW5XktWisV1ADj43tAFm5Y+9qG4I6Mdun6MbpRe9
	 FmvpdQh7JF/xsPShiBUB/wGBNtYqwfCMSsY5JsUM8WBHxhjEpJyuoubIhs/z0cUX/p
	 vWwDoaqJp2bYQ==
Message-ID: <sashiko-outbox-188721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 09/18] perf/x86/intel: Keep LBR frozen throughout PMI
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-10-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:59:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> For the platforms which has 4+ PMU version, streamline LBR freeze is
> supported. The PERF_GLOBAL_STATUS.LBR_FRZ bit is set to freeze LBR once
> a PMU counter overflow. However, the current PMI handler clears the LBR
> freeze bit too early, allowing branch operations that occur during PMI
> handling to be recorded into the LBR stack.
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
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D9

