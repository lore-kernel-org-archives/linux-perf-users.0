Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FA528453
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923235; cv=none; b=aQLUCT2C0C8mJBZ8SRdUJU1XDKT3eJclouILhPJoljR7y4TE8qjhklKBEj+eG5daIOj9xqhBdHUNZNRVq9s9TlrS2ic0lqA04sL/xy3isIGLbqtZu6GtRKqhrf4+78oRKfftKXX1nRcPU0RSgWCnG/7fBEK7pH2ugRw37MyBSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923235; c=relaxed/simple;
	bh=geU53jW64O4FY3aewvhvIJ+2EMBI25k54eJsNCU2xH0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I1jjkus606XP+lkZUPP0yIDhaAVOb2XphhcWXqu130Rym6bTHxuhhouMzFIw3dvxCi/1Qibe9X6FBkgL1k63og34esKaD1lKpozgw9CUs2RTVOEBtykCQvcKzcvnhS+RyDb9FWVwYoHkxi6J71mG0iLsizkSe+kYB4smKSkEPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtZP4u+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtZP4u+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B891F000FF;
	Tue, 13 Oct 2026 20:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923233;
	bh=geU53jW64O4FY3aewvhvIJ+2EMBI25k54eJsNCU2xH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtZP4u+NiQpDTl1rMqSBPDBHxjYjPIfz6fBVEE6TXpOmijBa+7uLhi+jrmZTkPiyG
	 QUQyvgyQeaUy2pBTozmapR9Vw6ylHXslVHwO+0sQ2/X+c03jBbadSnNbg9zVKVm97Y
	 2BW1xkt5YXVipYKw8DVYQUpBfQvHZnvqNPBX77ZbHObKkRZpmsdC8fQg5gSf1KiK42
	 EbGjrnnXUG9rE6W838KcbQmX1TH+aot/YFMz17sA36GWp4FdB0yqbH1+2cwIWAwnRl
	 3NtG+MkWt0r3GkyMS1dnrZiHVIFJtXzhrJWLdeVEZjeWConJlccAqRMfZWGuiMB6Oy
	 Kvacb5WgxUZFw==
Message-ID: <sashiko-outbox-170461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/19] perf tests: Mark the shell tests not mapping
 perf ring buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-20-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-20-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:27:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Shell tests run perf, that maps ring buffers, so they take a turn using
> the per user budget in kernel.perf_event_mlock_kb by default, see the
> previous changes; the ones that don't map them, like the ones running
> just 'perf stat', say " (no_mlock)" in their description line and thus
> keep running in parallel with the ones taking turns.
>=20
> The 'perf sched stats' tests are among them, they synthesize the samples
> from /proc/schedstat without mapping a ring buffer, and the tests already
> marked " (exclusive)" don't need it, exclusive implies every other
> requisite and keeps them running alone.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D19

