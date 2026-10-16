Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2564A21
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110761; cv=none; b=n6cqThKhctz+jkLywgSFRD4deudt2rYFPtIVYyCIU18hsL9IPacARaKpM6vT1M8LU/elI6SGcLeFvpZ7EdoZlrjgyfrIukV/UWNnktaB/TWOc8q7KCfGfnst6QWiCTwJJig8Mzj0XkyHIP0GichTGzKGJu1SDtVFOQ//ULiZfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110761; c=relaxed/simple;
	bh=dTKA9z18ahs8ULJ3LquxBV+UoBW3iB9kTn6IbbnMHeA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UfljvfdSrC+e5RoMnZCBZFRF835Zxh5G1sVQqpWuBHv2OIk9ADnWti6W6mLspJYcb7Kxsfkc5cFHywSTrYg3IncjmxVR0Lsv7TGyXGGhsblKPtbYg/HE9i8/D7ttseFQPBNKAmZvFotkPs/jtPaB/BuSyqtvcBNHjgDiHkXUVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAplx2CK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAplx2CK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B04B1F000C4;
	Fri, 16 Oct 2026 00:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110760;
	bh=llhszl6rZ+ii7CF0NGa+u5lcCwjqQANzfrx54VE/i+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAplx2CKKNiEFUk7tmVIEahaAeaQKJrI/pWsntENuwb80KkTx+BQ1ZoDCuaNQyD79
	 1AFhB62aiX1XdPcQiIH39Aqp/iD6alfLuBcMlgKIwnfr/Yi7aLEEgEJpyxgnqn8bb5
	 mHw1KzfRZwwLFd8Bt1f7i+jiq49uHFSnjDKm2iCwmIo2J3mrpjXEvCX1slOLwhiZcm
	 y45ac0bEQ8/a9Etzjtwhrbf+0ySjPoTrAqCmPOjMH2TG6StAwJQ7EqX5dRCbyyOvZN
	 Htjlqa4BmfGOPaSBVDUU53TnljVHdUs0KAffJcTXaX3zuVImMGlTusIkFDoDo3XCqm
	 Z4nAjghSTK9wA==
Message-ID: <sashiko-outbox-173533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/19] perf test attr: Fix legacy event encodings in
 group tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-4-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:32:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy
> hardware and cache parsing"), event names are resolved with sysfs/JSON
> priority over the legacy encodings, so bare cache-misses and
> instructions now become the core PMU sysfs/JSON events (on x86 type 4,
> configs 0x412e and 0xc0) rather than the legacy
> PERF_TYPE_HARDWARE/config=3D3 and config=3D1 events the tests expect, e.g=
.:
>=20
>   expected config=3D3, got 0
>   expected disabled=3D0, got 1
>   expected mmap=3D0, got 1
>   expected comm=3D0, got 1
>   expected freq=3D0, got 1
>   expected enable_on_exec=3D0, got 1
> [ ... ]
> return value.
>=20
> Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy har=
dware and cache parsing")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D3

