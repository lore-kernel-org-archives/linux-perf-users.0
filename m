Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041724;
	b=lc6ulzqV+jOApsizy/NmghJZqp785NuN/Z9shj0oWMpC01Ufos7HpsC6TQowYfSEqDMd
	 pbGqdJDBmSf8Pyxd1plwBSCpgq88yXpjhov9myIsBrhlib1fqYUCSHsa5snERhXUisbjF
	 KyslCO7+vpyhCF2yHCxeX8GRESHOoMlbwDAu8Cg5xFzlk3N55sz7lwZW8K/uxP8Eedk5X
	 jWZh2DllITEivXG6qN5Gbw/uH6wO6xWM8eQeXLtzdg/y+LBqdtvyKNvcfy/lT1Tltq2fp
	 dFCWfh4C+O430cfdLAjq4U8uMcJ0G1/DUfKdMOtIXKUIqYGrM6IMxIBwJlVGnpySBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5D/n03tvNJphHizdbYOFgNrNG9S5z5EDYbsqqaqYbWA=;
	b=i7xbNXamCkczSJEr8NiB1791PnQn4Y6++crTNwPcjw6bLqcE2csc8jGGaAt0RqjcS578
	 VP8FsfiRsyuX+oo+pC+V8nlvoU4k6KejDQNIBChJS8Xut8f0I7Pp6aZrnPCvJVSuobebL
	 Cf445hSF196NgHKyoh55XXMZAq72iGPi0pHNHVJ1H2L6uyhoZ1K9eZDSfauM+e6m86W/b
	 Tst8dLS8o3imKF/QHO4TPRL3TJbhRYy3grrEKGAVTer0rsa3nki9JOFlrrM1c0getsMoQ
	 tCJBGBNsNugdReaVuc/7NmAxKztnuTw78R/UX7ppcU5EkyElhZ1Ji0R6y4b4Zm0IXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJeqdZUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3A606A336
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJeqdZUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150831F000C7;
	Wed, 18 Nov 2026 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041724;
	bh=5D/n03tvNJphHizdbYOFgNrNG9S5z5EDYbsqqaqYbWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJeqdZUipIKs9IS1nATRdWK4zmsBJPiS+Sf7Z+q8tUUDQtFV+ZvUxgZLmylNmuIb6
	 oFy9IY71pUBw9K6jyJuO5E0NEewGljQ6VXmJB5/MAyDRNWlXi/p0+HKwB/2uFi9YGu
	 OEfVdKlMpsFWvz8jfco3U6gozyJUVUMU5Olg1CL9Kbfie2ZFdEYwAjuUe6HEhYRavF
	 sfvP/PdhwMgNoSoSRwtJgVEQoqBKbyGi31klWL49SZuaD60E89/Q8/xjmkkY+8g/BF
	 m9CthgS8rUkOVAGJ7AIYXwTmvuzQwSikplWx1oNYgN4cxOQUAZBkCBdB6Yj7SmX3Hc
	 htdFLwRfNjTiw==
Message-ID: <sashiko-outbox-222110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/13] perf build: Link the jvmti agent and the GTK
 UI with EXTRA_CFLAGS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-2-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:42:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The jvmti and GTK objects are compiled with EXTRA_CFLAGS but their
> shared objects are linked with LDFLAGS only, so flags with link-time
> parts never reach them.  With -fprofile-instr-generate the jvmti
> agent's __profc counters had no __llvm_profile runtime to write them,
> and its files showed 0.00% in the coverage report.
>=20
> Pass EXTRA_CFLAGS at link time, as the dlfilter rule already does.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D1

