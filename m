Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973852;
	b=ioqEaPstGA5vocCl/d8IbwIa4FpxAjdkTexUrNRvq2ARhcIJSHmNTZF4sVaJyn0x0Mvl
	 tXcT6Kne65SYiAkF4pRQiRTzqrMzFN7MHGcsCrC89TG3fKA1eQHJRJObkdvJLl2gYn/AV
	 XCRYTuBB/SngpOITLLO57q/TgS/3YdzB7AU834jR8ZhYvrNdDbjDJ1y5CO/cr3aiRDEkQ
	 z6ultSCvj1Kmuu4QNXIogUTKSvsmxXTSGIAAzE7lP7rbj/O6DvA/9ZVg9KhEMFbJo0NGM
	 DjVD0MxIYOhVzFLK9QiGLeCd0fIeESDEZebM2o+k1iSB9Gpkat61sn4mAEc82wtW06w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jBvqLjiEjRBRK+edqulpi/SxG8Lbq1dSA5YOGY8q0hk=;
	b=cgMl7b8hk/SeKNVCvOQ+0oxi3JgxdwuCfNJUzJgeM+R4BKwPhx/MFk0589yHVBnsQaSJ
	 UHO8OYm6yFNVRrYscviCOj/yx7VYbmjT1UKNsHAxFiLCwjiT8S7T7A5xm1B0FQEK2jmvh
	 cGODx1+3fs5dVniSHvfKSl1etUyXxbxh8dcy1O4vDK4vHASqttIeINYbn2VF5M0cMZgQM
	 SC9rlRFWSwczi98Ng7VvxEVw1A6tcx5mnSA49iJJMfIJxVKrR2CPdzoudYFgYEcmJjeE/
	 E5tysPrSURAHpjYVPyD0k/rUmqWVIradNA+UVueIO9vT3jl2DZJLDLhdbuU38lCAgBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/yJhcj9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8F606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/yJhcj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDE1F000C4;
	Wed, 18 Nov 2026 03:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973851;
	bh=jBvqLjiEjRBRK+edqulpi/SxG8Lbq1dSA5YOGY8q0hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/yJhcj9aI08n1MEKuZifFnGegPA23tRClE28llYNathwP7TFCIviEhxpjYdSN2W9
	 ShTXnApPOjvniQOUqvm6BTqQFofyxWed47bCZ6OZ+SOojqiVqLGnp2KwOsAp+wD0i2
	 2oLigWQhNR19UojEE5ivJfEy0aITz9Qj0Q1oUBQYJVpsgaMI9RNdSn3Jpj32kk7ctB
	 fdsbifrDAwILi8rZuNvkkQ7rEbIPV4H0Ao33n0xFSgmy9G19daw8mcMgFhRq1qv0g8
	 uB5CEeV9xwnFqWEmNlFfYcWB7yIWYY82IlZThXr4vPNMk0/k9Yag5WlD6Y0RoWpsvg
	 ycQ6/NIsFjDXA==
Message-ID: <sashiko-outbox-220051@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 20/24] perf/x86/intel: Clear raw LBR counters in the
 LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-21-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-21-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:50:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The raw branch counters are stored in the reserved field of each LBR
> entry. The branch counters path clears that field after reordering
> the counters, but the BPF snapshot path and the regular branch stack
> path leave the raw values in place, so they leak to userspace.
>=20
> Clear the raw counters on those paths too.
>=20
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D20

