Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972923;
	b=iTWaBFWSwz7ik1Et0IMOQmhok4GjBRhDCpb2/VARf3a2hSbUEEtmdHeK37S7q4RnnJ4E
	 RC9elz2Dvu9tG8OYFRt2VjLFzMzNri1lOsGe74BsT3tXyGSwQYR/a5Xv7qllS3NeuLU/f
	 GtNvFZFUVc59wxe1Sa0eFyULakvvczEbogFrMWR6iL6pb/n/DHaFV3okDivxl1aL7JmhT
	 PAlPIMlHjlabBn20r6pXXfl43+Eg+U9DaPbfvPpw5/QLkXB6Djpf21NDbbSuWu4t1aTH3
	 8fT71uvY4hsDul9e1W9b5ppiAenWcMukR9xPXqmDr8ZN3rzFMXt3M5Zp68+1z3q9zXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O4sArR1QfEgPXyjrV1gwmXwVMaVZ9IbELLCfEVWMa+s=;
	b=WYb3OSiDor0SSjbH8y3U39/XCLjSs/AnQGKDYItJzbq5SM52YMN+RwXD/RcAPOibmeGP
	 k5HzGLMTZjRXMLzKZ1x07raZczafZhMU+q+9cB+nthuLPfXmMq6S+3fUQeQXXWnNN8KF4
	 uV1r/mJVulr3xNCpzd7mGotGeJhSFmhig71I7JkiS+surnItse3OdjaQQ24rkoQ8veRzm
	 FH57pSHvWvmpxe/0cvof2+cpNTsQmNuucgh3kFpnCFKenELh4FijKMwvvD//UaPtpn2iJ
	 SSpYU8okvefOX0vH9ZqFXJJr8gQhCzu/6clBPiPSLhUFxXvPjO+cDrQX385j/YdvAoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+wZRmf9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD28606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+wZRmf9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD151F000C4;
	Wed, 18 Nov 2026 03:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794972923;
	bh=O4sArR1QfEgPXyjrV1gwmXwVMaVZ9IbELLCfEVWMa+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+wZRmf9Z0eupqPZA9UPH/yE60lKzT2/a8Fdx3lgTSayGczNLi57qZmF7PVI9G+iv
	 FfBOlMmwADKgBW/M3bx8h4xXw7rLMutZW0rRmO8szdUHnqyacBi4FU7MGaIABxm/VH
	 gHL/J6bC+Sh35RJqHHrc7dEzeVmC8CGbymcIUKeBKPyVUt36JL40YdNRaV6FEiqu3+
	 sMqYbfXEa633diKqZIOHnftD8DgCCD4GCpf7b/7luYaGIqAPWlHWQgGA3TSnC9ogbl
	 KM1d7Rz92iY//dMmJTNKuttiIRkBWCO77OBEvl5JeT4we4GjK51mQKYhZQjPxw2ed9
	 NZDfkCVRxTaSg==
Message-ID: <sashiko-outbox-220022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 10/24] perf: Add counted-bounds tracking for
 perf_branch_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-11-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:35:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> struct perf_branch_stack uses a trailing flexible array member,
> entries[], whose valid length is tracked by nr. When this structure
> is embedded as a value member in cpu_hw_events, the compiler can treat
> the trailing flexible array as having a fixed zero-length layout under
> -fstrict-flex-arrays=3D3 and UBSan, which can lead to strict array-bounds
> diagnostics when entries[] is indexed.
>=20
> Annotate entries[] with __counted_by(nr) so the compiler and sanitizer
> track the array length from the nr field. Because a structure containing
> a counted flexible array cannot be embedded as a value member, switch
> the per-CPU LBR/BHRB stacks to raw backing arrays and add accessors that
> return the struct perf_branch_stack view.
>=20
> Also initialize the branch-stack count before populating entries[] to
> avoid false-positive bounds checks while the stack is being filled.
>=20
> No functional change intended.
>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D10

