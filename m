Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138762;
	b=38TZpJGOPiPSeTDGxcQzVKE6uU8xKDqkMqcwN4u27fTp3f33iXzymbawPuP2eIRQHg78
	 UtfpS5vYRq7sUlKh1CPBMP/eA+tjcK48QCM2pqefPXIjtd0w4I6tZ2eMxr56c5e/SDJY+
	 OJz4DTHIChjlPC6v7sJjuDCZFRPp2sif0LU5X1Bvm0BR40V44l1fjgjSz0hZWcUD2SPfj
	 5WEtRqWselbBCo5RjM62x/UXJ2PuTqeDTDNGUDRasKkPf0GUOmc1SHmUruHC74bRlBDAX
	 eY3kRJXs0xP2AP3/1KulD6WaXyiHY/rHvI0m11i4Q6qY0fFe0gsTLhjMOiWke9HJvHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138762;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZknI2jppZlaa18vYyP+vZNhL+uOA0qZYDqV6QZ8t5FU=;
	b=FW67Gq2HXu9NRhBpfo0rVdxK8GPSqqV2aWOFwzSi356I0+8RHFsq1NtJUatg897ttAgt
	 0cU5ufW5mI1BAXpRrVkYr21H7QtMLBVqF9ihu0+4Cc8D+KUdn0mRNlR+Zu50z9zHmpJyS
	 Qwdxl14615IfG//quAcvhDx2U0qMQstnlXlK1iKbVyH2javTjhjk9ihKQksBfJC00ZDL/
	 KACw/YkzA8llt3YK+Or9J8S1lns6eLUEQXDeose8HnPS6xtrFJRW0xiUrFdKkfqq20oGe
	 5JR1dwiIWxTtcJdkUbhtU+AFHH8fFK2m/Yl6GuKq/+HBAGHBKDxOwGqReNMojJBqAJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVB3CVYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B6606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVB3CVYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CF01F000C4;
	Fri, 20 Nov 2026 01:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138762;
	bh=ZknI2jppZlaa18vYyP+vZNhL+uOA0qZYDqV6QZ8t5FU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IVB3CVYBmg0goa4XX3E+nwkshS37icoGLrh9jbM8UclvX9It9RHSxQN8GAJ7FRHb6
	 wfDWr8PWnT4Mk5U55njMX5yE2FfNbsPJ0+vV6puyuFelTNRPAPZRLJVtrh4p61Syro
	 et2NET9J1X6F8+PvemHXLr8kESbg/Vd5zrONC+qa/ghdR7Tko+47s0em9k7rYC+uxj
	 8N8CFupefCB0Xafha8h/HIWtERvg7m8GyE8OrPCB0s5Zw/q1E3UJSCT089i5lftTVp
	 FpMBZF//1YZZaJHZtoDvklJx4kSx2yDVQZ/b8hNFQiSV6vjL+2v2bHmOoWzexH2r2e
	 iO6hIuaiwJf9Q==
Message-ID: <sashiko-outbox-224330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/13] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-12-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:39:21 +0000
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
> On an Intel host the virtual LBR check failed with:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> The record leaves the buffer sizes to the tool defaults: the data ring
> follows perf_event_mlock_kb, and the runner's small value left a single
> page, too small for the AUX samples.  Pin 4 data and 64 AUX pages, so
> the test does not depend on the host sysctl, and give the AUX ring room
> instead of the single page the tool sizes to the 4 KiB snapshot.  Both
> fit in the default mlock allowance regardless of the CPU count.
>=20
> Also require the Python perf module to export session: a perf module
> without it, like the distro's python3-perf, made the check fail instead
> of skipping.
>=20
> Fixes: 915d6b14dc0c8971 ("perf test: Migrate Intel PT virtual LBR test to=
 Python API")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D11

