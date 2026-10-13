Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E45208B2
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922919; cv=none; b=h1vlQ1RvqOiOKz99wQWy2MblPiN0WfovR9SYGzuWNcNJ8kpnvK2aRuygCcekJTMiwo40Cue1n9T+AWA1Tm7UfQuIUv1gTsd4oFC86kcIGLS7p1RFdHhB32FzKKS8XJEMC2Ti7JxltSLK/l4UoXkSC74cH5ntY6IpSFHTSN6oAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922919; c=relaxed/simple;
	bh=QoVVLdeQd4dDb8pLm0wOOb5+RrcjDE3g/X4BtLn+GF4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bJeIbeub8+JylIKrwfZTbQ2x65Y66m67xKJ5LHDlUpG6rlAqF7UjKxWZmsfHCGvA67N69dlkdkDNrtUmqIGuGwJeMtvK43O0mTkpI9YK4xotM4oo7ayQp9ji6vVFqvRnUc3L9sfUbaZP1uiIR0EGD3IP9YYh5Rd39wTqHWfDiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ZM6SA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ZM6SA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D59E1F000FF;
	Tue, 13 Oct 2026 20:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922917;
	bh=HyEalhcrxkCcl6vCFMRy/djfqMkVygk3ZOQQYZSjOVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7ZM6SA/qrMBqTrkF2zCUImZCgvLYDUwtOJa4UqPPNlJbeAKtusNApt8973Y3uj8t
	 nac0k6dSy/JwMednqvapd+ifXhna6ozuejI02xZY3ZMzdf5B9gYjcysjXK3iupnQN1
	 QCXKAJ9JdjfApsFahmAsbUNB/LyRAPnsCdra3SV1buBRerm7pyA54+5zxYTioyhzY+
	 1RDc88RruS5+9GpL0C6c+5ZCYPwVhVgHWMzSu2/JnF8qvjKHyBj8svvRIdepzQ/sUT
	 BAokNdH4L6OXky/0b1+rhQ3c3z6Rd1E/WRs81dL71SCseyAMw6LRL24cqGrlA3vIMM
	 3i3TsvmIV+SRw==
Message-ID: <sashiko-outbox-170449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/19] perf test attr: Ignore the dummy tracking
 event and the terms it carries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-12-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:21:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> With more than one core PMU the requested events can't cover all the
> CPUs, each cluster has its own PMU, so perf opens the software dummy
> event to carry the tracking terms (mmap, comm, task, mmap_data), leaving
> the requested events without them:
>=20
>   expected mmap=3D1, got 0
>   expected comm=3D1, got 0
>   expected task=3D1, got 0
>=20
> That dummy event is not part of what the expectations are about, so
> leave it out of the comparison, unless the expectations ask for one,
> like system-wide-dummy and test-record-dummy-C0 do.
>=20
> And when perf used it to carry the tracking terms, those terms can't be
> matched on the requested events, leave them out of the match as well.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D11

