Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249814;
	b=4qkzWbuenyxDQuN8Ck4vVeb6/xIHCtxMlP6VUHcBqM8BxWmGLsWMj7xcL0Dds9gMuJYX
	 em83j3Gx2HPa8NtNQ5goMaD56KDAxw4tdfPW9scE8v/aNYPgAI9vnccun2dRNY7KEEVKW
	 IXI00CmV7sY4TVZOO3yINzXmn/oe4YCo6TiwxAgnHgcVX1IMMk7IsDmxrD4yu+CiwZynB
	 lR1g6FD28XI3Kd9/WsZiFuWl0jp2H2ZoD5MEehpa3c8lxrmB9cyOma/5jdnyCWHtk4Vjg
	 RMyFpxmSTS/LKohGifbywjygPaYoToLd7QshqwvXELBXSi0TpZios4kiiGlc1Ub9MgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GtqUVf5g2BxB2u+2sQW9Yk5GRLfclf2euq0YO3NPkSg=;
	b=q4NKUDq+/3C9+5DAO/8DfG4ivpbWhSZzw1VuLUc8Q0p4SWMyD6HGeHCXV6+mXKLuE6hB
	 pJk4UrHXLrUYTLpgSotIT/S8Dqb06jKqsgWsXsRUahsLO/F1fzP/l9N6yFBOmK8G6Gb6o
	 ZyCxmCQ6OZ2bvpJl5XzQphDhKpfs3GHMPE6RV7nNTrFtrokX8zmmzf3HfIt9TKg2Hf2tS
	 A8Q4pQRNaRIZ0mEIDmpfr4pQ85pfyCI+GIPf5GM4WizHz3OD94NF/EUBUAblvGpvR9p9x
	 qRcjrZMomq8hLKTlQ4LHn//tXKzpNDzA12BjxRt4o+2n5IsMHDUaqGrnz0+NkouRM2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGU8kEFb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF99606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGU8kEFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6481F01825;
	Thu, 29 Oct 2026 04:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249813;
	bh=GtqUVf5g2BxB2u+2sQW9Yk5GRLfclf2euq0YO3NPkSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dGU8kEFbLHRrlHcsoMCV1Y5CID79Cc0gAe40lNWEfh4aNjW5h6vDCOnFpc1dcaKxT
	 VrtlmP8Ka5RGEY1/wdrF6LdHcbEEwOb9uUuROk/+aeKqMLVAvrRtXPuJYP+C2kOGrQ
	 Na+sPHLdB6x15lB5C5VgllV7CoQDAx2qMYENsnB8pZSIGlNPJsJ2qFulF79FbsN3eC
	 0172Raejb4Io0T7Od+6NdPLFh5ISW+Z8L3xLt4xInT77ToLAJCuwSsw3B7HrCQcH2o
	 BXL5s+U8NaRJWH1v1i816G6V59iN83p00oprj7kbJucQTnNkYkmmOGEG83Ibx50Fsu
	 VZNrdq60I7QhA==
Message-ID: <sashiko-outbox-188718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 04/18] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-5-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:56:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The branch snapshot callback used by bpf_get_branch_snapshot() always
> copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr hold
> invalid branches which end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> no active LBR events or LBR hardware is owned by guest. So the stale or
> guest LBR stack data can't be leaked.
>=20
> For the case where all LBR events are PEBS events, hardware LBR reads are
> currently skipped; that can leave stale LBR stack data from previous PEBS
> sampling in place and may be inconsistent with the intended semantics of
> bpf_get_branch_snapshot(). This will be addressed in a follow-up patch.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D4

