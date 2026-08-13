Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DA36195D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604782; cv=none; b=qbcqPi3pGx9lNPruZyJrlBTRXS99AWNpGO2rvwjszXvUgKBs5OSe6RyS7vdA//TCUGMCTm3J9wP7Aw9rXWswXALVPDA8hQaWnZXrFvkYtH4BbzeDYZ1VplJMFP+0dOxMpU1tktJcOVabLj4wqIT0Xc7vIhh92Fv+/UBWqErWGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604782; c=relaxed/simple;
	bh=pWoHJxdUns7aPT+v8yWdhhp99YUx7pMqBxw73/nb5uI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YLDav7OlqrXmrwvaWfCCVL3SvliAVhhRNhhYGJtXwzVlthpGPCAp1U12TYERVh3P5JZVv1iV5rdWYwtDetdUMDuGXh+KjU/f0T+9QlqJ4ZUYrkTlCvj2l4fggZvs0eqVIIPTz3UIH+4Djr61Uwi4DgyArb9lwRGtnbFJKSDqhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGzEtIbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGzEtIbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD6B1F00A3A;
	Thu, 13 Aug 2026 07:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604778;
	bh=IhHpz7WrfqM7mrXtVPNLqrchSPh6vdbvaWm4dEqF3ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGzEtIbirABYWxoNZ8LypJloAdSnKublvv0aw16qBvqHpP0QQu3pi/CVs/A4L5j3h
	 bKBlRDNRoC6SPSd633+I1SpjHVtnCDBd9z2mDC1AeZ8YkYhV8rOFVj9C4deFmblH+/
	 AL38H8o5H52jm2k98YoN/7+UG8evu38xK9ZuRsP9LwyRD7k2Hzah5bKVJVRtkq+1SC
	 yVSZmtgwMSYdKPpL1LWtwvoBg7/DsJtqzRgGVUAdttyNGc58J706OamosTsbtWWR9g
	 s2leoLva3pD0WJsZdnfpHWAGkFNhlGqT5wdyvKf8krBhMXsbxPwE885i+tz/iDLgdi
	 k31djeSDU68Kw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
References: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 07:06:17 +0000
Message-Id: <20260813070618.1CD6B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
> not be reentered. If so, one instance may observe stale buffer state and
> potentially access out-of-bound memory.
>=20
> Most invocations happen in NMI context, which naturally prevents reentry.
> However, drain_pebs() is also reachable from process context via
> intel_pmu_drain_pebs_buffer().
>=20
> In those paths, the PMU is often already disabled, but not guaranteed.
> For example, __intel_pmu_pebs_disable() only disables the target counter,
> so other active counters can still raise a PMI and interrupt an in-flight
> drain_pebs(). Here is an example,
>=20
> __perf_addr_filters_adjust()
>   perf_event_stop()
> [ ... ]
>=20
> Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
> not disabled.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813064346.3354=
58-1-dapeng1.mi@linux.intel.com?part=3D1

