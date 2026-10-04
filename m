Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5C46D2CF
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135373; cv=none; b=OUioJB9tFMif+fe+spjDl8xD5hyjTKHY+7WeTjmlurshuURDBVcusJraXFbaA9mp7+W++VaZH/0Shhlv2SbpYhRahl5XEEIUP32Zxt3hRKDL5GfEkydPIVpKiRrChpZOah+85yp+tChvXlpMAagBPplj2Al3vPXc1WEcn0ccHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135373; c=relaxed/simple;
	bh=3GCKDPgQKvBip6UH0r7aFwCE7agZL8MBM6Ke/P0HTqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=blqUSWLNjaC6MiECvgn3HIX0HHocSaRqsFbjADoaNw60HqR8vWAzno5IqkXod2R3mrJSqTtGMy6y4hVVapiP6o4zhegKxI6dMupu6pl1j4BV0mBl//9zwY2iWcs3kfVBzdEXxYtZbc342/AcEJ8rcAaBhV5AObluSWJZeRXihdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoZy6BJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoZy6BJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96201F000FF;
	Sun,  4 Oct 2026 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135368;
	bh=3GCKDPgQKvBip6UH0r7aFwCE7agZL8MBM6Ke/P0HTqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoZy6BJKublYsuw9NMO31x+40I13+fNVmFlDwioFdHhsjru5G1/XV+LXvaKA5MOAz
	 /8vgwqjuV5hgQzLHmjg7ienliLnzmXqpATAsNRHEBXttfqAzaZqcplk4C8GmeVX0A8
	 y4NVb/ngu+y2ZOa1VNMgxwy9wtJjiImYQTLl6iOxMJNWfFzdM+M+GfcCom9iBB++yM
	 Kaj/9faGPuxLPZNrTBVl24hAdQKUTdVGrRFTK//Eqf3GcIGdJmUX4RkKGPwMkkemNd
	 TZS3NLMZkXQr6ZtVs6MV1AEuM+yjFVPCYlfR1d5z+bgu78Hxp+fuGDyFxs6twVL32V
	 TBnPwBcrdbI3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/9] perf mutex: Add DO_ONCE() for one-time
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173000.2863935-5-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
 <20261004173000.2863935-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:36:07 +0000
Message-Id: <20261004173607.D96201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For lazy init that more than one thread can race into, without
> pthread_once() so that it stays within perf's locking primitives and
> clang's -Wthread-safety keeps an eye on the mutexes involved.
>=20
> Mirrors the kernel's include/linux/once.h DO_ONCE(), dropping its
> static key fast path, unnecessary at these cold init paths: a per call
> site static bool plus a statically initialized mutex, double checked.
> As there, code reachable from more than one call site must go through
> a common helper.
>=20
> The lockless fast path reads ___done with an acquire, paired with a
> release store after fn(), so that fn()'s side effects are visible to
> threads taking the fast path, which the dropped static key used to
> guarantee.
>=20
> The __atomic builtins are used rather than smp_load_acquire()/
> smp_store_release() because ThreadSanitizer understands them,
> avoiding reports on ___done and on what fn() initialized.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173000.2863=
935-1-acme@kernel.org?part=3D4

