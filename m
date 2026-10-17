Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D73E51CC
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216145; cv=none; b=DBWGLjHnmytRtawuchWnZjR8vzW4gGAIWIdvvfEjQTW0+jdZ/x8dsRPUwj+dErlTcm6hBM7nxOYDZ0RLkdA+yf5AA4cmP8DAgeXk3JNZvZmWPmcisZyPZK1HtG2TCFrQWDKpYF3LrGZPEl+/QeC2P9KUdS2oayubyyh9tR5Hqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216145; c=relaxed/simple;
	bh=ManiiifUJEK+XrYzNo/b0fmkRWybkGqYuankYGJ222s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DRyFonJNHfTf3Hy6l3VYxAHKfT4tL0Xjd/kP/9TTRXsJWtcRpJHpL5iu1YlF5ShHkNavUlvcAwHLc2cnuZBTbnzVoH8tyia0duEnTInf58OMU8eddzwebluQ46zDjBOEonw6igJ2aqmr9DcUFW8RvXVn5RLVhHy0l2l32pc9/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMdqfwOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMdqfwOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653351F000C4;
	Sat, 17 Oct 2026 05:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792216143;
	bh=scjXqOsIWs+oT7dGwbiJfvtUtGJs+vZc240YBL8kIRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMdqfwOUqyt8m4sE8Tk2BQs4cMVjrnD+JeYQZNwq7Bj1yQ6iW2kF5Erw4seLMDkYp
	 9NHylv5Rf8Gk+wykwzITA5TNCKLAj/HD0X0thcnzsZgxENLvXWH827kTrXdP2dG4bU
	 ACBgXcUV+R5j5brFEk1TbLqA8ooToJ2VGVCL7xfA78/45NswCrLXfMbnqm5Wf/LW+k
	 iBr1Ofs4QnIOIlPKG5CosaKAXa4Z8qa/JfKHBRfDdWAvOdGwU8b81k8rMluTZTHUzf
	 HvVTZMiHN485OvxNKU/TxxCdkdrhesw882K+EZN2Wlso4ZgtsZw7CCbDZ3jqrX1QfQ
	 gtQ0aPJ/zHwaA==
Message-ID: <sashiko-outbox-175313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] perf test: Add tests for lock_held() BPF sample
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017054555.1655407-4-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017054555.1655407-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 05:49:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add unit tests in parse-events.c for parsing lock_held(),
> lock_held_read(), and lock_held_exclusive() BPF filter expressions
> (standalone predicates, negated predicates, and compound group
> expressions) and extend record_bpf_filter.sh with lock_held(),
> lock_held_read()/lock_held_write(), and ':R'/':W' recording tests.
>=20
> Example output:
>=20
>   # perf test -v 'Parsing of BPF sample filters'
>     5: Parse event definition strings               :
>     5.7: Parsing of BPF sample filters              : Ok
>=20
>   # perf test -v 'perf record sample filtering (by BPF) tests'
>   112: perf record sample filtering (by BPF) tests  :
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Group bpf-filter test [Success]
>   Multiple bpf-filter test
>   Multiple bpf-filter test [Success]
>   Cgroup bpf-filter test
>   Cgroup bpf-filter test [Success]
>   Lock-held bpf-filter test
>   Lock-held bpf-filter test [Success]
>   112: perf record sample filtering (by BPF) tests  : Ok
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017054555.1655=
407-1-irogers@google.com?part=3D3

