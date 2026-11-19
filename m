Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115227;
	b=QTruWAWhP1jaIAqBk95hED8PDsuJW3ns9ZO5qszGxOYo69iMHC+YJrfFOvTV5szzuRGm
	 bime7/4x80MiGgyBGqJDfAki3cO1IIH8Lc/AHdrp50ENHxoOvR/kOTKMX+0mHhDLg+/me
	 3sOeTbHxcseVJQLAbud5ZXXZSH/Ng5p99IftsPrGk2HKd346KVjx9/oBXf9HuYam1Dma3
	 PkLK4AzK0dhdlVLjUliVXb9b8B4yfDLyIbJAZLgJC/nNbirUtHELLydqxL0vymCO7E4QC
	 5MXd3HmIN5nXrbkGTVmzF41JOcDXci8MXBJQQfKBgtQ9QMIZoRjf32OLcriRG4e/2jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=spVXShDIIPjIvY5MQvCQWYl359TqE6AkBJZukPWORfc=;
	b=cIo/RHYznMHr4fbLZBj4etWhr9p2Uovm19k6/blbYzKH1BUhIy7JVzApnYnLpYjhOgLB
	 1dg0iEInsgqtb2SB0BYpGXWxlfifKZdo74V3KvglU8b3fgMOHoGXduAWM+4VYPHt6gw4j
	 AoZgTox3oE8A++9l+N+rMo1Vu0uSZLmQVtFliIH94L0rQZqK5CXHvfFd8BKeGd++WQgIk
	 Z4HX6HQALcBvWfGLkQOUA5G36Sst7cs9+8RVqWCd1cSEL0wn19vD4gw+D3Q/IuTHzVajL
	 vtjtSkSsg4RHHZFAYTyIzssqPTu9PkfBWxQtSBdITkyvI9mhTDK+6otEbFh9nOHMJGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHGROPCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E781606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHGROPCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F721F000C9;
	Thu, 19 Nov 2026 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115227;
	bh=spVXShDIIPjIvY5MQvCQWYl359TqE6AkBJZukPWORfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHGROPCtEAGjkgz7bTpEStQuXJdeN9hwqHPDmm5wPbuzDiN4gdEnJO/AFlMqoGWW5
	 T/akGdNrxTCVnyaFb2ja15Bj2VL7bLbhnDY1bw3g9VSzJC0R8FrhGkXM5BH5PpoTVo
	 TkNVS2QGWBBiAEwSd7HtbNUsGxg6Yn8xcsHk9jTW/KWzCGmr8mKaJulQggh0MrGXql
	 smKr3rPWd0syOtjtUnfk/KqGw+adN8R/KicFijTStKVMXnN6LUyHceXq9morYioEBI
	 2j+x41gbAfBIr3htDzFhGMcCzPWCAVC6+b0gXH7nr0qSWwbOwImtrlaU16cFxI8B5A
	 ZO1YcmvopybVQ==
Message-ID: <sashiko-outbox-223830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 21/33] KVM: arm64: Allow kvm_vcpu_pmu_resync_el0()
 to resync filters in process context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-22-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-22-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:07:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, kvm_vcpu_pmu_resync_el0() only scheduled
> KVM_REQ_RESYNC_PMU_EL0 when called from interrupt context (such as an
> IPI reprogramming host perf events). When perf_pmu_resched_update() is
> invoked synchronously from process context during vCPU load/put to
> reschedule host events around guest-reserved counters,
> armv8pmu_enable_event() calls kvm_set_pmu_events() and
> kvm_vcpu_pmu_resync_el0() in process context.
>=20
> Update kvm_vcpu_pmu_resync_el0() to call kvm_vcpu_pmu_restore_guest()
> directly when not in interrupt context so that newly rescheduled host
> perf events have their EL0 exclusion filters applied immediately.
>=20
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D21

