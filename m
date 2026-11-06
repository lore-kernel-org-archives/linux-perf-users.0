Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941207;
	b=fiTR9jsVfk5+wGC2t6r7ItnkK0S4Y3OXhMBTFVV1NN8SbGbNCSqYrHfRpC3hvWtb6Wto
	 GFKll2MGDXO90TmiKT21WSNk+zBMy7TPQKnJBkbooUsNzsT65hsX4RJxQvqCOC40OMjYv
	 0bFzQea+3qILK42tqGBpMjm62Rtjxc+e2DjszNw/1I5qrOzefDnd0XHye5u58aKx6V6ZI
	 4hUj7GixcPx2BMYDMFynp//JVMlf9L6p1XGvBkTywxn3/pvuotTXgl/NLg6OBAW0/gCMX
	 S36NS6JBZtSrghAL7EWGriIV1aHaqH8H8XKs7QM0W/7xwI/0+NGw6pVs5YgG7MrUPhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aOUfFJBTTaOdjRE/CRBSHVVme2DZ8y5+FwV7mkY9f0w=;
	b=quJEmOntXN5zBM46LyM6mPP2d3EAznwTh4U0T5ub6uCKZsuMUAlzL3P+sCZvCYq1z+7D
	 FzkjSWbzezPCNLZ0gBwr5+R/uwCkyPSzcj/MXMawMBQB7J8QuyB8J6ZDMH2liTHi2Ippr
	 LjcPZnLajs87uMbcBwKKC+Gxbc4avjGR8wbPDBCkhFzm3am32+AO9m6HODjR0VEQE9vJn
	 PtRuoMF/mrFEZbzRJUusX8bNSFb1tsI+li0WH4xFRb0fjtir+CDr2e++8EswEKxVLXBte
	 9svA6IL+nHirpvneHtL6raV/wkd5Jmt8IjzMnnsRQYo5Or1ZLVVdQPCTFZ8KR4Sw5nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nV+HiHIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A73606A32C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nV+HiHIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C416A1F0089F;
	Fri,  6 Nov 2026 05:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941206;
	bh=aOUfFJBTTaOdjRE/CRBSHVVme2DZ8y5+FwV7mkY9f0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nV+HiHIuxPtEcHB0mH7dPAp1t58Fjf+92uDpEC3u5R7y02WtkUhNsniMjHx9vtpdy
	 UyzjJdEU95fxtelIgu7m78tneEJR4wRBiThFHTE2A1pnGI2bjRE0RWRGwUjkBIGNkH
	 QrdJM2CT5pjSVz86WpCmmJQSqz5AjV8LKziiMBk55TaMfvSYG3VUp32OIZsu8efzzC
	 mehTTlMlpoS0pI0NPstQB9VTeRmutBSqaWL/CkukTK8nH1vGM3/jSqxg+ExzGQjsMY
	 PJ9qbG3Zw3AEcRk1sADeBBWxczl+vM3WwMj01HVw7hvZpVDa0bKtZ5KubrfFiqYJz6
	 9CHugXOK1sobA==
Message-ID: <sashiko-outbox-200784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 10/20] perf: Add counted-bounds tracking for
 perf_branch_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-11-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:00:06 +0000
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
> the per-CPU LBR stack backing storage to a complete __lbr_stack[] array
> and add a helper cpu_lbr_stack() to recover the struct perf_branch_stack*
> view for x86 and powerpc.
>=20
> Also initialize the branch-stack count before populating entries[] to
> avoid false-positive bounds checks while the stack is being filled.
>=20
> No functional change intended.
>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D10

