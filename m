Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941263;
	b=he7tF2JuiOv/a//+1KYRwgxRlzYwLT7wTNstySKpezl1C1piusPBdwaZ8IG0vdpSsQRc
	 X6kUaL673CWqbJe7JhYVFCibiIZrgwP0rM6xFO+29FFEUMAwV3tWCHb7f96jX/Bj8+4ov
	 UCKaF9YR346cuEPkFDdLeczTmVjlQPD6xs7oi2hyZgEfGcYMXzkY3dmIionmY4iCJA6hE
	 0zdNYWfxG9DATzDPP6HDOSRV93qz33YV3j1g9z+67hISs7/yUvGPQeCQVYefyclg9/60Q
	 TAdLJv1rpMi2KaDZslO5bVLl8s/WGyD/abkWiQt7qcrffDE4EhMHZiKZPCqqQed5fBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NjaPzUNO+ytiIJFwqDVDeJjbFy9QPzVeP+UIkDQlTfc=;
	b=cwM7FnR/ooTKy+A8HKEcQZkybW0wHqsQA5oZ3CE0SVxz4+mvUO/FdEzQ4lTycJ4ho3gj
	 N6kvQ8S7pYtDagz3FAu8PRBtpn8KJOjahHH+zp74O42Bw2d7NvFvlEDMxOK3hD9/hPJU6
	 klntJS/sOmd+zZm+EK3/z3299JfLgi5yCuvbm1dttr/cHQSryoPFBV20RN9JAqXFRH+MD
	 StJ36Ryb3JKPHhO9sfN47WH6d7ZI+CHC3MTiA0ex8wYpZpNAPMejFiObIA/D9l1z5CU7P
	 ZqjKzBfEbfYhjyNza8TSwetPF9VwLeoTOGupgar0pMLLH8YfLfU2UnNKFISW0X1a7wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6nhxWtN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64D606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6nhxWtN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D241F0089F;
	Fri,  6 Nov 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941263;
	bh=NjaPzUNO+ytiIJFwqDVDeJjbFy9QPzVeP+UIkDQlTfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h6nhxWtNA9/S0o4b4lXP0zZiDR/zONvAGK0ackqNtHTYBK+2kNHB06FfAwkENF1lR
	 3vJe96zpsO07BUMeWdH+BAOHNLebks44opflodKzmcUAsayfB4H6ZxyhSGStlc2wie
	 kx5FYnr5l2ZcqDyb9A9c3k/tTbgHFYr3iy92DfDBpv62dgfqX/b6SFM3lq4P98A/Cf
	 MuzxbRA4afWaCiYjqya37Ec6Jwey8b9A/G9KwEwPKZZlKJtkaSCVEK8UKLfa0ISxvi
	 KZbyapu1wg/2ai3nh6YNn2fTzqiR/0iBSWIq9O7wCIyWimlA80j7EnbhTg4ZdPUo0j
	 gSToTGrAMRFYw==
Message-ID: <sashiko-outbox-200786@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 01/20] perf/x86: Disable LBR if x86_pmu.lbr_nr
 exceeds MAX_LBR_ENTRIES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-2-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:01:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Disable LBR if x86_pmu.lbr_nr is larger than MAX_LBR_ENTRIES, preventing
> out-of-bounds access in the cached LBR stack handling path.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D1

