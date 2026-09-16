Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827835592E5
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602826; cv=none; b=nDnxwt/PNo5yd5YYf5QXOCOgPte+FABbmVpaxWQarCBOqDF9PSB7BBm073fnSPKvJbgeceqXesO0bJyVnjM0n2GBPT8lApDRmnqb2UQnrAng+blS092uKsZVw7LcKe/AJgPYzgqFJmBWGngTysNmFuPOdNMd8629XENHginigNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602826; c=relaxed/simple;
	bh=ZvxGxloaW0JRVsQ+HpkD+MOzaeQq1WrTUXoMdTK/Dxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aoi+UCemKKeVeRriKPC7AUCwq0rn5cNnjh1o3mZNFKuoOvyZE08oecouRipF6PW5x8/QQMsE9tkaqeg4HUAmeqYQaN5E4ipuFeJUhohR49u6XpVLGaj0c58wmZe9QbyGsTG3UcANEHtWZJmw7sp6JnJV28GAhgMrAdV+n2PjRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5JIk99T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5JIk99T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DA61F00898;
	Wed, 16 Sep 2026 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602825;
	bh=ZvxGxloaW0JRVsQ+HpkD+MOzaeQq1WrTUXoMdTK/Dxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5JIk99TtGIcMk6Mgn6CEMHQEX+GtOfJ63sfKGsBq4sZBcAmdRIs0Ad6sy+hUcBGx
	 K6WmEvUJdIoPCCWYD+etCLOQlxzdtVgS/dPa+3vFpSf+NWeNuu3KP2/iUa2tN4tGVy
	 kYmttRg9FwygmgPKkx7ipOTv6dM6lfBj4l+Ew4jlFM89aNTZ8LJPOREBoyjqSmyClA
	 WmD0wdFubBpwM0Tus7p6iB/mVg0uXjpRg3HYw6YkAf2Vk01Hrzq6K/K3G0HD+GV4vM
	 W7RldEZZ9QTOSKlRUEjNJsSFxEJsjbhVoknFG4iILoy1vXojAmmSecrtlW6ceBw2Gc
	 yzuQT/lf6twew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] perf tools: Add TUI hints for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-7-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:53:44 +0000
Message-Id: <20260916235345.34DA61F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add dynamic TUI hints prompting users to restart with --hybrid-merge
> when heterogeneous core PMU events are populated in the sample view.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D6

