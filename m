Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950904;
	b=b2rRjKC1IXqZOru/D1FpuPWRkb19W12g98Yc6bsivf5bR7+9Cd6eSDfoXK6a4B1vPb4+
	 nIrGhoNreiSoUDoFPwTsKgKdbF1gFDPNBlBcEH6Q3tD/p1KY/tijp+AhKvYVpLVk+xmBK
	 HQw3JuTai6m8QG3F61x/0IpH0WGi9BwBQHiIIQLFFpAYTqh0W5C6PmHoGTLqN3sZ0LvNP
	 T4UjTfmI/an7ur3dFtx0pYi0WagNjGKh7OjChxr0/k9PrOXXPVTsNevYWw42GmTZz8hwm
	 6aahAj02BYfDegvftKkKLaKo+44bp09kJL0x9T8Bo5NdvpAImYVD51aoRoziKXlpuXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yxANCzH2/FGTT4nw7oI+TQmRg2KUOh5YfrUVx1MekzU=;
	b=IAJRmaFWMJgwQyU6Qb0A6+zAxOVx6L8gnWA8MYIRPdW6Ed+tA8GhSgyXvSMnEhjnlhpG
	 SCkf8v+YmQQviVNfbsOmidScVJzFhlpWimMqqiUkOTOvVB8zu0dm5FQi4HiM/+JeBRgba
	 zkweyQo+aTM+7bnUkSFzlUvPbtq90l9q/2HNThE/sGtsTvjuIfX4LFDdPTPdwfVwi31P1
	 tHCs2XZD/vD6xEGsOl3IxaVklYrEgwLWCm/zGG5IZoXqyIyJJOyhN7GVJw6vqlhjvDeO4
	 BlR90nFrNJqJEVSQ9wRjFrMBPzxO6dh1P1fWhjTcK8EXtGzpEX1dtPioelms+h71FjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQkv6k43;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1B606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQkv6k43
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3EA1F008A1;
	Fri,  6 Nov 2026 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793950903;
	bh=yxANCzH2/FGTT4nw7oI+TQmRg2KUOh5YfrUVx1MekzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQkv6k43ZuERtp1VUJPwg7kmdTi7QbnsnP9Vb8ZM8c001AXsEZNnzQ3mwFkBkwjLi
	 HdBTZB/wmQwvbsEphzq0afG6jTLyM0yJIecEfoZrlAprl9hQ7lyqbKPdBrwwpIaFSV
	 2RAh2hB8o14y8/Gu3iqIs+tnQYxytJ8R/A5w+iu9+jcTmzmBOOvpunJn822WwoGtx6
	 51zRNWKGFuSpta1jzBNNOmRoDwTkHhaTCcwHqVHBrYSCxRDSwzsw718aavqoPmXJXn
	 H3tO3cZcecMgTZFWsbe6Hp7/kIr+OBG76gET3Ff1UImPVUFUWqyKWpRl5n4ue/9RJl
	 64zeg/nKrEaJg==
Message-ID: <sashiko-outbox-201001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf tests: Skip zero sample IP in object-code
 reading test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106073018.903126-1-dapeng1.mi@linux.intel.com>
References: <20261106073018.903126-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:41:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The kernel may clear the sample IP to 0 when a user-space address is
> expected but a kernel address is sampled due to hardware skid. A zero
> sample IP causes the object-code reading test to fail incorrectly.
>=20
> Skip zero sample IP values in the object-code reading test to avoid
> false-positive failures.
>=20
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202609151503.cb02f753-lkp@intel.com
> Fixes: 166f10836a65 ("perf/core: Fix kernel register info leak via hardwa=
re skid")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106073018.9031=
26-1-dapeng1.mi@linux.intel.com?part=3D1

