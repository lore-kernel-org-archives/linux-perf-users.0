Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B037BE64
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615909; cv=none; b=ic7kqJe0Owdp5XjJk9o3ZVeonyDg2KFrq7EgsjFpnDLLSQVWtBIADNKVpCx42u/PV+IA3uKuMSHXRYEJHS1ljKNSoIQnJpX+Oj1qTF6AM8t2nChVIUilNfemQq4EsX+H0p4Pz3ivLqZ0IQezjx948TJn0hQAWeQOT6YRgK0C5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615909; c=relaxed/simple;
	bh=e2gn+ijVxSkGi9NutQBMKQ4uCl/igFQ/1i0iER0Az2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ulO3mhmLBV97eV+ZPABc615mMIt+zkqLoAKqMbd7yNzL0jz885NpMHDdEglqNGvVeqETmZEm/SjDHbvzn1UJJAn2Z5rBzukV8H12GAf8/9tg5kLKUtfzCAVPmxv+3vOuUjB6VWoGMwZA+vQlSagytjkmhT0qiYtbbwZNfz79yaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLH47LUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLH47LUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C713E1F000FF;
	Mon, 28 Sep 2026 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615906;
	bh=e2gn+ijVxSkGi9NutQBMKQ4uCl/igFQ/1i0iER0Az2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLH47LUfYxUKdQOmw6hoVrj8gqkmGpUI6QEqLNgILVEY6itP1nln3AX1rja9axt8P
	 ChV9Q9UORNTflyjw5rOXtWM7rLGtApO6X+RUaU7bWgj2bZM9+wqQmzmHx6ttEKtRWK
	 Hoqoea3n36hjoyBQ+fEE5+KVjSbxpTfAqkPOAeE3DWJh7y37I3NrG4odvV0Afw7m8r
	 1yOnDwSujHszhpw5iHPVBm7lLG7XU4FR+1/i2VH3QZvO9UWGgZgpY7eW1R+4pD/Iru
	 QGQtTbRGYYnRhFJ5fkVxzfDy9jDqg5hZ4va8oTuNzHY2ouEKG0iYtvZB0M3W+jQpr6
	 i8BLPmjXWj+GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928171244.2437283-5-acme@kernel.org>
References: <20260928171244.2437283-1-acme@kernel.org>
 <20260928171244.2437283-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:18:26 +0000
Message-Id: <20260928171826.C713E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add a 'perf test -w false_sharing' workload that hammers one shared
> struct from several CPUs, shaped as a TCP connection: a read-mostly
> identity (five-tuple) shares a cacheline with per-packet rx counters
> (the false-sharing line), a second line has packet-path private tx and
> congestion control counters, and a third the connection config.
>=20
> The packet path runs in the main thread and up to four lookup threads
> hash the five-tuple and pull the config, reading one volatile shared
> instance directly so the accesses are PC-relative and resolvable by the
> data type profiler.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928171244.2437=
283-1-acme@kernel.org?part=3D4

