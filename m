Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8635452A9
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922845; cv=none; b=Zy++AwHT68y7PSkCOuycDRKyag9Yy+HGd6t9IvQDVFE7hDzcrPG6LmAYpPMPHmtroriK5ShawcjWUtuk8U7EBlmenc5Jkot3SncKIW1UbOK3UIhn4WGEJka99IfFfb/mtthi4+lG6DlATe/hvAOdpN+pEibiusSuofCd9WUW3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922845; c=relaxed/simple;
	bh=WAO693BTN/Q8F7MlE3RkHqfPvu6WcQya3GPFjWbe45U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=az96GO2T2IHMbZxg73H9YJEuJtK5c+WfNwGu8QDcOurP2W8S9AZW2pd9QQnrac9skKlDWMU7v9wj9glPfPes6ODC9QfGBqLagEOIIfhk/Pa7SfNefpK7VZdZ0GzO7p5TfrfvgVgpCS/zCba0J1fbXfYcQbCMbJYQVbhJTTDqt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeDWjXct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeDWjXct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD901F000FF;
	Tue, 13 Oct 2026 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922844;
	bh=V1p/nXxpWWz/v1iPHTRjc/tv/TQppjD5dEukvrmhkas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeDWjXctF1iwkudjkilW8+2KELnwCbS+UKdSRM0eRpBmd0nFW+qeZqAnPXP/jHPq+
	 7lxCLd+FiFKA0UjUlIrM2z5qEufWW+nLuJ/c9ZdSbdbkQ4Phs8x/1rDhWzm0FIX1JD
	 dgksbu2d+snTJ/QGTORD6ByRnpi/LNqJyXpOSAxhU3KV+fiV5Fo1dYEq8LJauzMs34
	 G5n3/uilqM9pXtRsWtNFR1Y080XQ8VgSHH5+4F2hVrJLr/tYSIRz/PgEVjOuRBxnO0
	 1XF5NoYDVO3m+Azk/ekrQjlRlTspTX8EuLaO38pF7YgYGaLEmyLfdnEk64qB4vVLrG
	 ktctjbaD4QGnQ==
Message-ID: <sashiko-outbox-170445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/19] perf test attr: Ignore the group read_format
 bit the PMU count can remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-14-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:20:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> read_format's PERF_FORMAT_GROUP bit asks for the group members to be read
> along with the leader, which aside from this bit is verified with the
> fd/group_fd based group checking in Test.compare(), and with more than
> one core PMU a group whose members are pinned to one of them, say
> 'default_core', leaves the clones for the other core PMUs without any
> members:
>=20
>   $ perf stat -e '{cycles,default_core/legacy-hardware-config=3D3/}:S'
>   ... the A53 leader keeps its cohort, both A73 cycles clones are alone,
>       read_format 20 instead of 28
>=20
> so that bit isn't there: whether it is there is a consequence of how the
> evlist got expanded to more than one core PMU, not of the groupness the
> [ ... ]
> as when attr.py runs without setup_python.sh, the count isn't available
> and the bit is taken out as well.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D13

