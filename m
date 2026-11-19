Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114889;
	b=sAWcsJLV5i+tKusouvJlSCB+skjBPMFdi4gbAJyiSauu7iPs1bH+Kj+CzXI0JDNbBQ9g
	 u6fgQOEO/0Gaz1KV5JieJKrIhaNdq/M419B4O4q7CcnCwhvmi5Y8L3hMUyb+5Q7uMA5OC
	 7TrB46IOw5i7wmngbiBO5fVHw7WKmdN7IPO4v2ToT5lu99FhFXZc6wEo2NNpCZSn6SjKU
	 0TOZVBmjgW0SQ18YbbsDHiopesB6UAzuwHox9U5euZvrmLT/yPDJjPHaoXs/JCxs718e6
	 svggIRc7VZ8KfBei9Tz2Y8LQyKbc7shdvsBcBjYhXu6eOUY7btYTmvGf8iryzShUCcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BRpxc68dMOW51jYRB2E4ojT5I+gx+BF5TbNmCCc3juo=;
	b=hu7AvofOaQHjIiTwXVhk6/1pH3Shg7fNz5rNrGToIF31mKUre66HRQAiduvxvoiYHsCk
	 6R8GGxeg4xkG+KAgjfRLsmRIYNNjJyFa81YgYhmnKqWYdUQzJO7c52D7hav/loqjJaqFi
	 9czcnJz44cF8af+ZbMPeVK/2kJosSZzMm5kQakNAKG0NJz38f8y2Z/hK8RsQtQAZdrB9+
	 H6tyQUjNUP57laSdI7KIW7QwLPfzt97QIOw6H66d7SVYFXxPOOQvcSgoUhy8/zQaRYcbY
	 /fC62cyLDmsp39TEuX+dlS+m9hBVr5m7yJLwDA8cLNhCuxdh+Yyfah70LN0e1capxJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meUN7vZ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE060A260A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meUN7vZ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54D71F000C4;
	Thu, 19 Nov 2026 19:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114888;
	bh=BRpxc68dMOW51jYRB2E4ojT5I+gx+BF5TbNmCCc3juo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=meUN7vZ4C9vxfIkG5FAwNaJw2gpjgb/MoimigGPaXhvccj/zFwEimWSqu+tgykKGx
	 +mrOiBZw5d9yzJxNi7itPUIjm5M4UmDyRa8tnLAJ33a+bRHwO4cTSfXEZP0EC98bk8
	 ugm0VczFoKtJmcFRkdyPb3GIobx8Oueq/nG+RI+WN9cRdpRC2z39H1nmUlyT68PpZh
	 28mMQbBZTR1qPvAo4D4K0tNy513FLEHxBwTHx7v975Qopnpa5uT8dYnXoRPwfj9la/
	 /475FqfFEhKAZvBB6PpQmteWHQPzguW1KbRzLLw45IZqLh2DSCf7y/ctRT2uf3yRXf
	 DGYNB+OW4XV1w==
Message-ID: <sashiko-outbox-223821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/33] perf: arm_pmuv3: Check cntr_mask before using
 pmccntr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-9-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-9-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:01:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When the PMU is partitioned, PMCCNTR_EL0 is reserved for the guest and
> removed from cpuc->cntr_mask. Move the PMCCNTR_EL0 availability checks
> (cpuc->cntr_mask and cpuc->used_mask) into armv8pmu_can_use_pmccntr()
> and un-nest the 64-bit user-access fallback check in
> armv8pmu_get_event_idx() so host CPU_CYCLES events fall back to
> general-purpose event counters when PMCCNTR_EL0 is unavailable.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D8

