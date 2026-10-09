Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885D4EE86E
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562309; cv=none; b=cUng68YR0tSbdxMpMYBZjmy9ICf+qUjW3PK5+C/J6e7DmWEuQ2q3g/+1aPShJWouqVKM6HifUXiY4L19FKXIxAi9/MVOR1h5Oehj6d7F2X+G6b5AH49y5Lcomrx9weT66EgLQE/K2I1LuGrMWvE4dZdJQRexfXmkZWLjthIORdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562309; c=relaxed/simple;
	bh=6GQsgiMsDrdHr8EdPQ18yNRMvwdvsv38lDtPPzML0gA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YF0/A4APPcKL6sRQTNmrOxL8Tti/aO6khcEwKu8V7mssPij7SEei/xl25Pu5l05QqwrEo5LptyROpR94/RlYQEUILD4hrWutpBT0qWcs5YeNHwnCn0WAh5ydTsYQaAZZjPh64zk8ZxOWTrcx/6tHtb06VKPvk392u8Ff+Wb4ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1/iLMiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1/iLMiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3477F1F00898;
	Fri,  9 Oct 2026 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562304;
	bh=cusL3vHyF4ze67/INh9TP2cPR9Rh2knSanNZa7Cer/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1/iLMiHceRi6ayNwlneOByHax+iovAQQGfj/vLeEQeDi2+j6MUb6v6AP/Gjx0C4P
	 +r67gRYPcqQaw4w9RLIBFJTgs76xuMF/nzvx/CHZLBMF3mXsFZ1bP78/umkmv5U9ML
	 NwcUe+6IyGRLmwd7YSrv/038t7QRo6QcL3pgK6wQj5SrLLcHCHq7NHhjhk68MyGNw0
	 ZJnpCM4E9rzRLnVLxHSrEmKrw2X77x+z9L4GJRSrJIDLfInrLG70guKr/PCb6nqh2p
	 0eik0Va+DBgwYRJZ/V3gguUWEi70NUriORt/CmJnAEzlqlQRbiGmDma+bIaxV0VRkE
	 M5md8qoKUSaqA==
Message-ID: <sashiko-outbox-165817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] perf/core: add KUnit tests for AUX
 kernel-consumer API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009160010.1829642-4-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-4-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:11:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Lian Wang <lianux.mm@gmail.com>
>=20
> Add a KUnit test suite (perf_aux_kernel) for the perf_event_setup_aux(),
> perf_event_release_aux(), perf_event_aux_head(), perf_event_aux_tail_set()
> and perf_event_aux_copy() functions.
>=20
> A self-contained dummy AUX PMU is registered in suite_init so that
> every test is deterministic and needs no hardware.  The dummy
> setup_aux pre-fills all pages with a recognisable pattern (0xAB);
> aux_test_produce() advances the published head via
> perf_aux_output_begin/end, and copy tests verify the pattern.
>=20
> 39 test cases cover setup/release lifecycle, writer admission and
> blocking, head/tail/copy accessor contract validation (including
> wrap-around, boundary cursors, and data correctness), buffer-full
> [ ... ]
> Gated by CONFIG_PERF_AUX_KERNEL_KUNIT_TEST.
>=20
> Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009160010.1829=
642-1-kunwu.chan@gmail.com?part=3D3

