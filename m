Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973582;
	b=j3j9OAkKlQMa8wGFXVcC5Y9yxp0sE9xNXhi7ZWRNA703awNcXkVxlJ7xyR4gRzGbNQ7i
	 EnNYtqceFWujrWBSEjEvnuOXfd6XIUMKTfQPj+LWNH44x2PzMj6rV9bLbAbHsHxSRGOrq
	 xA1O24idYgWT0BVjUT8vJ9NthC6olEbyo15Mn00cu6oJLp6sN6xkscP/jtn4RS+cK2osi
	 XWyKydwamHEnRjPPgHrnsYIf8+74iLlSCqzzZYpd1pLcVwpL/Ml8AbzBNk1gQe+lb+H25
	 zZBoPDs+EHs3L7LFzy+VAN/VZaDtBrelTT8kdmlsYZhytSRVOAhqu5uuyIaE8d7z8kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mzhbaXCC32RCE4ViEcszlnakk/sOnWVM4JKQa5wuYE0=;
	b=Or7AQDIHo/7akoxakfgIpVsGdal4m93kyhNvV8HzbL/yi8LeFFhmbUUacHEqZuoKIVb3
	 uvI9+bz5PHTTc9ZK2ZqG7nG+eprCDZ3RNelYimcH/n6/QnPlZQnnAAH6Yr+TeQCCubMeb
	 Qfgv2ryP7SY1/HvzV5Q2pffjmkVtoexlF45+6Oh0gIYG5+bC/AeQUqk62v8jvYehDhXO4
	 FCZtan0NfitWkVbG6E2eIl9WdZzauqzI9BX8yB9Xh7PENGqNi2m0IIhKdHqi4iOArWOVV
	 k+DvY2PS7bXApdxCfZWvAlX0AMkS/kkCUDmO6sEwYaAv3zAfBLBFTDM3v2pR1XklHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/0vnui/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC274606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/0vnui/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386131F000C4;
	Wed, 18 Nov 2026 03:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973582;
	bh=mzhbaXCC32RCE4ViEcszlnakk/sOnWVM4JKQa5wuYE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/0vnui/DNONmBMfjBFIUJCPBqXIOCwDGIwvcAViPQLW6lsnaHAfJLqFEKs8KX5Ns
	 7BZq4ocJGSXfyYvtQ08fH9QTLo+/RjxM2Koj1v31cg/R/wtFMJCmqZfzD1SklfJ9JH
	 M5fV2czrgH2Wkm20exCBUkSDEmfNJ04wD/pGtbZ2gHgYME9dvsMVXMAhkBdd/vCTFl
	 6Zmmy69DPUY8kpI1IcQZQpyolEYk6HmrZruYB/3/clDuXukN+ObKvAEhyLQ8FODYct
	 o5gXXt22SwCy2zntlBr5UcjVft+5r0BP/BPOuWaGeIpdHuukcPWDbwsb8xzALh/IYu
	 ndGsD4JCVbe4A==
Message-ID: <sashiko-outbox-220040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 18/24] perf/x86/intel: Fix draining of un-overflowed
 PEBS buffer in PMI handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-19-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-19-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:46:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When a regular counter which is read by a PEBS counter-event group
> overflows, handle_pmi_common() drains the pending PEBS records to
> ensure the stale counter snapshots are processed before handling the
> counter's overflow. Currently this is done by invoking the
> x86_pmu_drain_pebs() static call with a non-NULL regs argument.
>=20
> This is incorrect. At this point the PEBS buffer has not reached its
> interrupt threshold yet (a real PEBS buffer overflow would have
> already been handled earlier), and the PMI being serviced belongs to
> the regular counter, not to the PEBS events. With a non-NULL regs,
> the drained records are processed with perf_event_overflow(), which
> charges a PMI to the PEBS events via __perf_event_account_interrupt().
> These spurious interrupt counts may falsely trigger the PMI throttling
> and unexpectedly disable the PEBS events.
>=20
> Call intel_pmu_drain_pebs_buffer() instead. It passes a NULL regs to
> x86_pmu_drain_pebs(), so the records are emitted with
> perf_event_output(), which skips the overflow handling and throttle
> accounting.
>=20
> Fixes: e02e9b0374c3 ("perf/x86/intel: Support PEBS counters snapshotting")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D18

