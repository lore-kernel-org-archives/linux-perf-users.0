Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446323;
	b=L4QoXxxumSoNfzCc432M95j9S39BD9yBy4rDrAIzi4WlPj6U57pckKXxr5HAwM+ck+ny
	 2JRbxrHbuWoITZllPCRaplMGYV3KCUHmOguet0fZ+wufJVprx8KOaxcQdneOO+4RZJ4Xf
	 wZIC4+aYiSyHxuI1pLg3S1TCnncEqOBG0wnwS4RHPJwSfm6Dk1h42fHXm4WArPl04y2Gw
	 lE48sEp7FuvuYtih1W3zmQL3beGC14Is5Tlo9nOptYQdWdTvuuLjCkPabgr80d4KFAjCx
	 twOPJX8E3P5c/fEJFwDdMEToq1spgXAFsPGDOO0uquhemLkdSAvbxAc8YAm29QrWCMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aDG6tTS8IW/zx6i1abH/D8esUi+hKowni9gBXOs/BGc=;
	b=Q447wgTYKhPFHMyTiujA0qiSWmw4D2YQ8L7Pcf1IUvRHndr1/MQNQl3h0WmbXx4C95Gb
	 Jba6miL9djxHoykMTew9O4lbNsRUlwj0UPOQ5lvrqaRPf7GeoE5tuL3m6pALuAat1jVL8
	 h7R2qxyysTyUR6MP3yZhtsT7d70xAMLMgKs5YmxjfwrFbukxPzG93tfQMwUYUj+E5pxAJ
	 /pE+0qCX+eKQrlHNeKOmrpUcFiug1Ro4X1vbCEe0kHh4fOPYlsgAWTUPitEt7KpwAT4bD
	 +tGwainQ95V23AXR9xVvnjBCyJpSb1bcku/R0jcawKDIEPHOMOwvssgGbDxOBNPuGGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD9Cq5AS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFB606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD9Cq5AS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17D21F00A06;
	Thu, 12 Nov 2026 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446322;
	bh=aDG6tTS8IW/zx6i1abH/D8esUi+hKowni9gBXOs/BGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RD9Cq5ASYPJgBMvJW2uEr0cdEdf09ibG5oTPNxundBx3JZA54E5aerRDCfzwBwgSP
	 FSdbSdsxGnAg1R0E/WOW7XQPpNKl92CNJ4c/736sSRkpFf6k3vgzzbMQUhIEs/O1VL
	 F2jatt+dX5eRgu8UsnfdemV+mveYAH3re3ZdOeuZ5tdYqRKBVmPxF1J2lin/taUs0P
	 zLGBMcAhv0cbV4gzq56kHznl6s3K0roSRtUbo9Les1WzCJLntcft+ihuCbqg9hb8Vw
	 KJqSi9m4x7C8/7tBTGzlCl0UW6easUrOaKiqIgqmBFpTysH9ZyhBbMDcNKvGpPXeDQ
	 Hyj3MeRLY7npg==
Message-ID: <sashiko-outbox-210059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] perf build: Sync bpf_skel.mak get_sys_includes
 with selftests/bpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112011514.4032822-3-irogers@google.com>
References: <20261022204627.1813821-1-irogers@google.com>
 <20261112011514.4032822-1-irogers@google.com>
 <20261112011514.4032822-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:18:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Forward __loongarch_grlen as -D__BITS_PER_LONG and the MIPS ABI, size,
> and endianness macros in bpf_skel.mak's get_sys_includes, matching
> tools/testing/selftests/bpf/Makefile so system headers receive the
> expected architecture macros when compiling BPF skeletons.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112011514.4032=
822-1-irogers@google.com?part=3D2

