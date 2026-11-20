Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201350;
	b=iUlbFS53h4sPxc2SLsai4kWru28dWthBAJ+B12SoM62wosYUAT6aqo2dSINc8er/NJEV
	 fzDxDbYb/w+qbQk1RktDdtdm7Fa+QYEIzUL3D/jJKYUzSgbo0mj2s2KQ1RVKGS+Vdg7t7
	 bhl1QBhSvqASexrP0J+BGYq0wdPz8vbnHGnivuxEzzcl+9A/67rPKD8s2ukF7CWe4IcBf
	 ti8/dBuvzOkUbxMFv6Djg4H8RTAKxcohe/Yoc4H9GoX8KuTs3Ee2alYviecJRJFPpDPZ7
	 tZAuyNlPGp5gRjWq0zsufokI4o866gzCipZCo1t+q6dh++6JFJR/V7WXICx668NdK+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2sURyAOeDs7sELRWdz95XnIxLMie3qQzWrNIF4Vym8A=;
	b=VfP48oUp+9zGtU6K/xyt6IuBdNnxUE4dAzYZEHSv9ZPc2a79PxjuDDcJBtzhSJzrnU8Y
	 cyYq31LYdJGjP8Jc+zZ8jjxwy4o7PgfFLltfOUnkcbU8kC+mPJzh/i+c1/sxsqLeZBzE+
	 dWPtKSOfsunz0N7dzTTTpF5wSYjfdAD4lClhHYOZJYYSQ0B93OfW7saj/YQXJSAN3MfL+
	 +abFf7ZdzxiqeMU3LOzultK0FjHTQtXRGFw8PUdc8N4PVvkyfj6+cZcFe3K0joRZluZmW
	 NVNAPysfi84Eej0n9PauI8vIs2ezr5+wD/ysbW8zzfqO49MNfsXTkeFd0Q3oRMOmujw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TC0YNG1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEB60A2612
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TC0YNG1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB51F000CA;
	Fri, 20 Nov 2026 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795201349;
	bh=2sURyAOeDs7sELRWdz95XnIxLMie3qQzWrNIF4Vym8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TC0YNG1TJGIaGcCC9M98MGm9ZS4FuSw5o1nzMvaMUgLcpjgdkGC4Oyjd39jsBOuz6
	 vTm2pjBytjyVaSXQPuy/RjHfQ+YPTAOmja2XiH4DJ/aqV+xaX6WQi+iVioxB7cBFj8
	 YDvkOQ0r5oFYsk5gAlVg7kbCcyeD+AfIejzFax65Op6kxqTgHF4VZBRidy32Fez8PO
	 wuCxHB+qNrOa5A7QMF9+8wxP4d3ocQ6pYc3nbI2OzH9a0aTd3rZixio2cqi2cdHe8x
	 Bk2mv7EItmH0mpkZyrCqtpamgcGgmIP3AywlOYXxzDpPBQa+NV+PE4+wkFmbCnR7SH
	 aFrP7dL5dt45g==
Message-ID: <sashiko-outbox-225882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] coresight: Add pmu_pulse/extout_pulse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d15e5919ff7c24a6454befcc6ccd2e1928530528.1795196854.git.aaupov@fb.com>
References: <cover.1795196854.git.aaupov@fb.com>
 <d15e5919ff7c24a6454befcc6ccd2e1928530528.1795196854.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:02:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Drive external output 1 from the always-true trace resource for an
> external consumer to count. Change only EVENT1 so other event fields
> remain intact, and avoid output 0 because it is the trace trigger and
> can stop TRBE capture.
>=20
> Producer resource validation loads the feature only on trace units
> implementing EVENT1. PMU counting support and implementation-defined
> output routing remain independent consumer responsibilities. Include
> the preload declarations in the defining translation unit and document
> setup-time source filtering and the separately selected trcextout1 event.
>=20
> Assisted-by: Devmate:GPT-6.1-Sol
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795196854.gi=
t.aaupov@fb.com?part=3D4

