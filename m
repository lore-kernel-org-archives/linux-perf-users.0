Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565047F3AE
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937191; cv=none; b=PmPm6u1HpdJ+BOJbaKulJUiTyczbZTus19kisTdmfrH+6PZDyeZNJO+mNQelm8S1VegCN272eOdfFKVrEKEw64SDeYgNO9+Lxxl72Ix+Mn+GNqLlH1gc0F/xtO/dgB33t6Us9vbR2EH8s61ojZ/2hNauya5MyR4aYKRWWL+yxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937191; c=relaxed/simple;
	bh=+4tHL6i5O37u41IuK4OOYYwj1NK4S4KcQyWsZm8iZNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXL2ssBoNHWCd1OlXllAn/MljdzTBKawG0uvrzyKpDTTuZ+uAQ4dydkqm6al8tjwzejB/Y9zARjqjl60srwQd3605vuXHWOIanSxKFRvdIi2zW4Ba/wfsmZX7QA6XQj5WIc20jr0KwMeW9UvA5xa3lWxIcg3wsFxBTV0Eg6MYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww729hpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww729hpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B92B1F000FF;
	Fri,  2 Oct 2026 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937190;
	bh=YXqSjhv3q2De2q9vz4v9eJK/1V1LUhnCeYD/tkHGDXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ww729hpwz2kZMzKW1od/NoTur1RUkBnzNWx6fegbtQVaT06BVSWw75LxOxIh+/6pR
	 8DXs0rludkMKTcMPxXjkKv5dcenuL9Oh5nt4n15XNRlEb9/6RpnBc7naX85GYtO5tp
	 op9CtdwwgvZ8hs9e89tD2NhOwPO9+ZqLEuL41FWrWIkZ/jcsH49hjs4vLavkqqio3y
	 BbenK3mSgBBk0GY2hRohqMM7cnQFJiLzjO5JdGHnHHx1LJisWHADJKLFovmSIYQyBJ
	 1zj6MD1/j2j0r7C7UAyVsbhdD7ioTF7eJCORFEqXA94U2bD09lX3H5V5RdUVOyvBcC
	 1pGELoE7ZwPQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002102110.27587-2-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
 <20261002102110.27587-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:33:09 +0000
Message-Id: <20261002103310.2B92B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Move perf_config__set_variable() out of the 'perf config' builtin so
> that opt-in features can persist their choice from outside it, e.g.
> util/debuginfo.c writing core.debuginfod=3Dfalse when the user disables
> debuginfod for the rest of the session.  The set_config() body becomes
> perf_config_set__write(), with the system_config choice as an argument,
> as the builtin's use_system_config/use_user_config statics are not
> available outside it.
>=20
> perf_config_set__write() checked fopen() but none of the fprintf()s or
> fclose(), so a write failure after truncating the file was reported as
> success.  Harmless for the interactive 'perf config' this came from,
> but this makes it an entry point a background feature can call with no
> other feedback, so propagate those errors too.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102110.2758=
7-1-acme@kernel.org?part=3D1

