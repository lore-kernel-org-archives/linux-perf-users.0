Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373901;
	b=kmeqyRUVZU9mlNYOYZxcC9acucaoOtls883JKDNVWFm8b9BbuVb5atC/vMhUWen4Wmsg
	 +q1GVW2h/DYWNujrh+nJccTbeZc8QDxRrDFuGO50bnSK6i28q8YStjkQvCOiDWwD+g/ID
	 /tpIQXukj6nEd71GTjDsiOI+gTnnVr0O2VoACKw7BOxYfLlu6GcN5qkuRTJLvnz8nfqeT
	 6W6OtrJyEbbJVkQik2jVVKasTiIj1BH9sXOk/pNvjjX4bQKiktbxot+JKnjNn/PXYUzCl
	 TigDnKbDMSbcC886ys+hgp17ntWAZuqInprF0YUXXbdVQ+H5ohz4b9S7Uz1OveD/cRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y/B0+SkVKPpiJ2ROVX+wOsXnjuXfJIkbm1MljtNGjxE=;
	b=oMPxrepxyO5T88Ac2rvtI1BCs+R/AVGVcBQVBGVWem3JWdz0r9kRNPDOKaqTfrJLBNVv
	 1uh5+RVU6iCGAae/N7f8VK80skgkNKOcLNzXaSHZIwgJc7nLOPLv+v+Fe2dk5igJWADvK
	 mCmyLksodje8CbPWSGO+f1viJDsljA9omIDFSKJDkm6WT7v9A7YTn921CTu/Iv5COtN4G
	 PObMwCULwI9U6gLe8siUwdXVoczcBs2oGzLPSQgAzumYg2Ji+ZqXPfMAfKqNW6Kb/rx+Z
	 m+Do54vViOXH+m0U3wv7SuFP3DLoQfUxseDGWXAvncJGu+Mbn1l7QvDGofzDmq44ndw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cubsKKwc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5B606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cubsKKwc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245431F000C1;
	Fri, 30 Oct 2026 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373901;
	bh=Y/B0+SkVKPpiJ2ROVX+wOsXnjuXfJIkbm1MljtNGjxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cubsKKwcC/h3Tbw0Ibr4xoz8/v8rFA8HLf4btUP7qd4iLOL5JqEJf62GLhd0/W4dx
	 TZZ8hniXs2B4stSoD+NEVxjB9eNKq7hl+7GOT/3OuXLKfdRdpmXqF9uZT7EZt9mbvE
	 CLZvBDs1GGmXHn4g3FLFM+EOsDP54ja/nfbkoOSTa9pt2gNd+cf5pXFYDTTqHx/cq9
	 cpnZILYkmxFmRU8pm3x5l/Xxzm2JYnlX2fZurBBaWxLES3tYVJ4eyFGU7ahMhiW+Ke
	 lTH4pgUIb+l37FR2+xrYeXKA8TD4Q6Tw1BHN+jjNg4W+CI+IMotlh6JH67mkQ8XsX+
	 4W44Rvi1plaQw==
Message-ID: <sashiko-outbox-191170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] perf intel-pt: Preserve return addresses for
 asynchronous branches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-2-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-2-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:25:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Intel PT uses a zero instruction length for asynchronous branches so
> the thread stack resumes at the source IP. A dlfilter can fetch the
> instruction before call/return processing and replace that zero with
> its opcode length, advancing the saved return address.
>=20
> Set sample.ret_addr to sample.ip for asynchronous branch samples so
> instruction fetching cannot change the return address. This also
> covers asynchronous trace-end samples and VM exits.
>=20
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D2

