Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940604;
	b=StuFVYlZcZD0qKVRGgQNL2E+lHmuP2SSdOTSzs5MDCaR9fWEBGlHcxwUz84nnsaAMWH6
	 UxTFa9RDWsZBq48HLXsTcy0Sg8liKlYCPsB1DL+78A3SGr3ew5VEIUDESrqIY0HKS5KpR
	 UpjN4E1+mpMchTrinm16OZY4/+QFDIibBgg3DjCzAz682DACRzl9eRDGF37YiM751dt8m
	 5byIXX9W4GWQIPmrsUJrOgIO+5Us2TrtA5lriZprf7uXGMeuMTyf2kzOtaLPjKKgxpvJ8
	 J8BT6xCZ+odD0eAmY0IXuL4Zb6HoLnIxKHT80v4nEllGvkumkuBuA/USnQ9nEVaY9SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SSJDQ0sAgtcaj5PpS53GuIXWB/QOgkr7ILG3AnoMHrI=;
	b=UB+PWneSChgDwWCjEniTO70uACLUnj8bl1sjYPfbOXCVCai5iToZErhuaBy+7ubSAbGa
	 q4uS4Lh3CObKhTtCknOW7VzVI5ZTfCErKVLM3asrtLUodDR5Mwk7KFv+o1j1Z6kv+boyr
	 b7Bz9YTv/I7QUgjNoRqn0u4z++3XaDWyHhrsM8RxM4AqLVb7jOtNBVHfqsQL6w3uLmsid
	 t/i9+5eDdd8oZkRZMbkvOr81v/uQp6Du+gtP9zqr0Qi7FTwILmGfLt7gXDM8pvKB1CXdp
	 ql7D36bYfdhwiPkK0XbOPEvEAWYq6NhOCoqahEnYTNm2TZnpXNnee2j310o842d7how==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jas7aOqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF0606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jas7aOqB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8C91F0089F;
	Fri,  6 Nov 2026 04:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940603;
	bh=SSJDQ0sAgtcaj5PpS53GuIXWB/QOgkr7ILG3AnoMHrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jas7aOqBxIXe5dSMeMwvQdxcHw5Ma5AJCBuo7pCukQGQVUbW9nTweX0BtPc++7A0X
	 AKSK7JfM22SEESSBzw+oFzjgGqbQ79149Q4pAJa84RZEYU7MsfVK0erht66wt+LcKR
	 BAaNNPo4eJ+q9S/j1VBl1ihVmWy32hs7L4ixRVJPGg1Du+LMqBIaSlmK1ROZu+JoEG
	 Kg7GRfgUxzUfQBrx3tJWy8hB6TXLUooW+Z9ofmGrLzVSPPudgwtz2lP/zkiGykVxsX
	 vqyvYR25hbZgbQPoluvXv+s/TCTbZBHP+J5h1Q0vkTeu0P6MsD5D3/6dHw6mNN0uCj
	 qiRRPPAsjMDrg==
Message-ID: <sashiko-outbox-200770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 03/20] perf/x86/amd/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-4-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:50:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Sandipan Das <sandipan.das@amd.com>
>=20
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D3

