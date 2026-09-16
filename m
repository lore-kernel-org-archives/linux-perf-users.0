Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1514D0CE0
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584227; cv=none; b=Ko7CMIcotJESVeVfymYwgdPg7kIc7AwfQgGYCEDEjszhynjrpvHkSX7Y8bz7PC7I3BIujrHyRy3CnEqut7tyhA/eVQSLgKV3d4H5DOGKG93i8W0CMwgOT1aQX5vdu7lLGMiXpAab4bOWOxwpvZHqu0SANtWfnUbeH5hQFUQ2BFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584227; c=relaxed/simple;
	bh=RoBo6A/xWem9H+cP+i1HyzjgkM01CB691Dm0/Hk4HK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PwSRSiT9pqlw6nd30WOxPPYfWIGUeZ8XUBS+htZ1+r7zGJWeNJaEIaas0en5//SpWqMQ4Da5zrgHJ24p2aHaZ3ELgbrTUNwDDx/Ue8ytGvdshq+zcKcOopoGhmD9FPz0Rg0RxbNXuDrUHRxnc3sBFEZL5FRb8fTMVNxtn+OG/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6vCM6kV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6vCM6kV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75631F00899;
	Wed, 16 Sep 2026 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584212;
	bh=JSDlBq/TTK4cYgnpHnmHoDIlsDocDWlfXnkQQTgI9Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6vCM6kV2g/Hq71kToieWBHIvQUHHdgONfoEBATw5WX4laIrg4IcQ76KFFYxmw0w3
	 31mAk9Kl6LUvoSJnxV+EnEqJ9tJGwCXyR7mULHNKA+yjv4fZC6AmuWXLSj+9BLEMri
	 4/Xi/p2RwU8uUZPPm0/H3aUxgIQZ4s7ahJEqGzo2oJ504WhgKfP3W9mnOceip9CvBC
	 AWKDCIGL/eMrKRBPNn5T4zqwtR4dptugABwhabn8sYRa7rndmG2HODPAScIf6cF7kS
	 YA+tk0TkqJY63Dj/2kdIbaJA7zrq9CRJ8P2/569DTsFOtB+qYHv05I83E3+YVQaVYV
	 82O5PsD6kgQgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-4-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:43:32 +0000
Message-Id: <20260916184332.B75631F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> It is code from the 'perf config' builtin to set a variable in the
> configuration file perf is using, the user's ~/.perfconfig, or the file
> named by the PERF_CONFIG environment variable when it is set, rewriting
> that file from the config set, the same rewrite 'perf config' does,
> i.e. the comments in it are not preserved, as the config set carries
> just the key-value pairs.  It has to honour PERF_CONFIG, that makes perf
> read only that file: the config set is loaded from it, so writing
> ~/.perfconfig would replace it with the exclusive file's entries.
>=20
> The next patch wants to use it from util/debuginfo.c, so that when the
> user asks for a debuginfod fetch to be skipped, pressing 'd', the
> disable can also be made permanent, moving perf_config__set_variable()
> to util/config.c, together with the set_config() body it uses,
> parameterized as perf_config_set__write() with the system_config
> choice as an argument, since the builtin's static use_system_config
> and use_user_config option variables are not available outside it.
> 'perf config' keeps its behavior via the set_config() wrapper.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D3

