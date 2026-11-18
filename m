Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973758;
	b=prr6rvTIjwja/mh7fQc0W5ZV63OgLi3jRDKqvIDfS4YnCJk3bjdjRfwyxlkfAdQsT11M
	 nuMynfydNZ3VIk5P8lUj1MpBNrqIvUwSIO4K13v3S8ddBNQVEiGIUF2R3yfV14OvkC4hS
	 uRrOeQvYvNnwiL0u2QRg+hZH1cNQnNtU36n1dQlcjCNYzukacABnQ/joA/W+d+C4lERir
	 FcHVPTXsylypCyrg2ydjRBBVW5bTxDll8qF6Tt9L45LsDaLF2fH1Xph7mKKVfDiFO617S
	 bfNvp1yOVxx6AafsBHKgNWu2Pf1uTvBpNY1bYKE4EgxtE7kaylps7f18/ovHghMVGww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973758;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FzdU1ivq3yqZG3swqS1za+fjyF64F1aLnYbmw1uKnYo=;
	b=iX0+sBfIt8vvgqSMZR3cnj9bD1HQtE528bMtDJgq7OFIUV8hhI0FiVlNYUFAnVQmnMHZ
	 H73J+mBUSOOAfjHuRqrcWGGr/qA/ioQ8X3nRZg3MTLVWE4ssZHzUlCeoUtGD91fMQSPcn
	 TShb9No99T/4gkQvGW8t7XeJV22kDDHY2z4+p4x2XTeKp7BvoaSZviEYjU6fuuZs7w02D
	 Sjy05hyTZHmuqe+qGhea9VNRPjR898IXp5ZF9x20XbaTO9e9OTrTN2Uz4xaeX588O7rsx
	 7ShTa6HE5+M6bfQiHN4S7r33cYp8yc1WjuEsJddUMeDtXKyvCC1N1gX/E1fYa6kMrEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgdjBrrn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AE606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgdjBrrn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46BA1F000C4;
	Wed, 18 Nov 2026 03:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973758;
	bh=FzdU1ivq3yqZG3swqS1za+fjyF64F1aLnYbmw1uKnYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OgdjBrrn8ZtDq3sqIliD5mr+gztbDMg9DGK9WgOsw5OzMe9GHCxBBYrpjgeX7K1A7
	 Xc3ZVfJvnjkjAcG52klvUtZCiPTe/V6oIRG1EIHe4mUZmPGWrZnZ0mQHTK1ot2/N/u
	 PDfEiW2vpzlWYk0YUaz2fHrLuPi4mmw7mVe19GaFvIzHaVkNuSOpexTt3DsAMtQono
	 4oBNtdoNgncAexOIFSoHnHXXGOWYQjkrWpbb16osf8ags1jbC/PCCylb58ie77hsoz
	 qEVMveZhudvIn/3vgkacuya8gVkTQURYgcGt58J+pVrKEMjj9pOeXhNMJnIVR0Z59m
	 4IqNiTCvmSbsw==
Message-ID: <sashiko-outbox-220048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 16/24] perf/x86/intel: Account LBR user counts for
 pure branch counter events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-17-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-17-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:49:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel_pmu_hw_config() clears PERF_X86_EVENT_NEEDS_BRANCH_STACK for pure
> branch counter events. As a result, intel_pmu_add_event() and
> intel_pmu_del_event() do not account lbr_users and lbr_pebs_users
> correctly for these events.
>=20
> Add intel_pmu_account_pure_branch_counter() to adjust the LBR user counts
> when pure branch counter events are added or removed.
>=20
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D16

