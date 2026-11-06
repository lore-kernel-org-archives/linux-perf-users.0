Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941861;
	b=rEdY2XBjG6y606vss5h6qiH+z5t7YQLOsLsN+30/qR4nN/wDUHXlOGVdUmjtTPS8MVbC
	 16k7z0+5GE6aBrAODmQYivNPzyThcmVYeqbB0sHpUGSjrvmIKaeVyHL/kyhpTAWSiSO9l
	 kPvKsgxk+HAoXnrJDZjS0EL3eoeclhQLr13fHEZuKUYF91bKuJdRxPqFI9gRB69UQsc0P
	 gksulenSendYvNRRdtnZvz/JHPZxVUnwiXne/y7rzih5MF9ddXHkZSPaIF7I+YEGUuzSw
	 7wNxBhvNtopd4Y3OWGY4j8mxESlp30+iU9AYB2kptXjMpqWauDoUBJdwLVRIpQXD+gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SEyhYTJkjTCHug+lLyq3SoX07Fj32Nw303gTX5sWY6k=;
	b=L4SEYRnq2N4GkLauoPxXtMFJmQgB8G6fGJVA920NPBh9bFMK0Gn5dXWsHJIt7thFD5hJ
	 LmTjWZCZGsqiwuLZld7LyNRDp7IEiD7dEFlmV2uyzpP/l5hAQdG2P3SEW5pPIsl28lBSq
	 kpkiBkz8eWgUDjW5ijfPt4u1k1JVFhHTK4XOH/qKAwJwvQ1cjUdJDkAw+IhnsM+7O8KNq
	 ExfzOMGFTR+X/eE8tjBC45tkHi+DH0IohAHPR9/55wecAfKtpQMVqrJzfM5gzR/AKPLxc
	 6mhetx3zto7V4tChZMFTDKKgNlqJIQQsw+zaVCoR1HpjJl5lg9tNqkb8DAsQeqGtMfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Df9612RK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01435606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Df9612RK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A31F0089F;
	Fri,  6 Nov 2026 05:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941860;
	bh=SEyhYTJkjTCHug+lLyq3SoX07Fj32Nw303gTX5sWY6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Df9612RK8IfA3MOQ+BwHhGrp/CnWb1gl+rX4h0PCP0MybmJrFXlv2Hd+QMe/nIueu
	 MmRIm17LVg/P81Xt3f6kvjjaujnOcIGf3sDfR8EjXAclgp15EeMDkOiI8vLMcJfvjq
	 W+1F1nZZtibu9+YOx2u2IyVsqFZnTiks+2yQumZQHUIImwp/kco8u9imXURoZObaaq
	 RN4d9n9BOxYQt/VorW3PCSlLspGMB4OepL4hMhRVc2lB+mp+vUhyzusup/UctexCyi
	 7LQnfsqJ1qL0oRUcXKcOoUWoopMckZUFrM4dmPmesYSnj5+A9DWZDR4Iqe+A9/RZ+1
	 Gemu5UPbLkrpg==
Message-ID: <sashiko-outbox-200801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 05/20] perf/x86: Add lbr_enabled to track LBR state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-6-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:10:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a lbr_enabled flag to track whether LBR is enabled. This will be
> used by a subsequent change to avoid blindly re-enabling LBR in
> perf_snapshot_branch_stack() without checking whether LBR has already
> been disabled.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D5

