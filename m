Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250568;
	b=CpASCrkoJVWIRo3rvucnkO/mPA8KkyD3Ndidpl+ljfMi6jWzw8vT4C4E8BY6Cw2XhCkn
	 Q3bzhm3X7vD6kUGCDS5gXM+UnKw+aK7ZXXkLrkGBBaf0P1xGOcNOry1yjESnsbv1p9UvC
	 XI4z8GlMp2MQR82DIwWxRihNaHbXDssn7ndHRcz8NHt2IMWOnvksUPNZ8aDNhdMhqM4Zw
	 m4iRPVL+xizJqiq/P/0Bkvl64Tfyya1uzXq7feB4LxjuJnQeaT2pQIlcRrpqInxESj89g
	 00Rlof6SWceCyhdQxOC/9Hcj10EggEXZQ9xZwDStXj70/Vkwc2btyh3Otmf6sw/jKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1ec51C7fmvGhoJryO6K+ZWBeZv8aSoh/LRI1ec7GIeg=;
	b=DgPqZafpuKgAFOImjUv545LUDX73RHwllYMNHcu135Q4Um19HFLUsJCbXVSTyVQu2AW5
	 aDGALnj1yiZteJGciZCdwCbNJZ55xqo/oFW0OkfWBf6W5mDHLRGtCwLnJrEIU28lIahzl
	 UL2QVulND8MQ5Ty1j2w0va+iDWgYfDKyzaKrTiLD0LWnt2ZVtRZFDykEooIPSQxyN8BoO
	 G9j1diG1oNj27TKwoSB/8HojOIPHAcN9ya7Xu9d4xfIuBUeJeeAfgQD8OSSEA6zvDRSVa
	 Ve5/O469UTffnJCfO4dtmF1xJlLTaiC7/8bopn1UqYzUgGjk3C84+6/4FJhqY6Ug1OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YveIbc3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54F606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YveIbc3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3A31F01825;
	Thu, 29 Oct 2026 05:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250567;
	bh=1ec51C7fmvGhoJryO6K+ZWBeZv8aSoh/LRI1ec7GIeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YveIbc3iSlca1zdzl+vscDqI17vIOpShgd8mTPx9HrOAIPR83vl2vc4G31avUxrDB
	 DJtqfKjH/cgeqx+26d4EQ7DZPjPlFPkM6+qFsFYE80qfebJHQDcn3zMrqCPorW/tDh
	 E4vI6o5YQH11JR+lN+GSEgVA/OxHZpwYoLD5twDSgLt888oub3sTWWITlGQrTH+bi8
	 Hk9+hfCOn0b7+Lifzuj0CQKUvRovT83eGOE1v4EvhYJx6YJmIFJi4AyArQPCrfuF5u
	 NWiJv57uyoMeBw/gT7halxuap3qXa5Nvaoch2wtaYVsMH4PRsX6TTiZO6hygDzgK+E
	 f0lLJ7/EtmKBw==
Message-ID: <sashiko-outbox-188731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 13/18] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events if needed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:09:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> PEBS and non-PEBS events currently share the same LBR stack,
> cpuc->lbr_stack. In the PMI handler, the non-PEBS path refreshes the
> LBR state before the PEBS buffer is drained.
>=20
> When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
> PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
> This leaves stale LBR data from the PEBS record in place, and userspace
> may observe the wrong branch stack instead of the live LBR state at PMI
> entry.
>=20
> Add a lbr_need_update flag to indicate when the LBR state must be
> refreshed. If PEBS events and non-PEBS LBR events overflow in the same
> PMI, set this flag so the non-PEBS LBR event refreshes the live LBR
> state. Since the LBR state is frozen for the duration of PMI handling, it
> only needs to be read once even when multiple non-PEBS LBR events
> overflow in the same PMI.
>=20
> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D13

