Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1353D9EB
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922986; cv=none; b=MA6fu0YarktpDOnJfOS2cGkskmaWHJlEzQTIwKquwJ94fd6GOM2+ZTiZXTdcdLstYLdIdvyuWCWx5wGE6u/R5RkNZXQGDxjsrVKcqqApG6p8x4LTQpKNMpBdHebyTOgbSuAJBArYnST5K3p6VV8y32yrd6yS1vjTJtznmQvzu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922986; c=relaxed/simple;
	bh=PJFg1sIszPffo1ZduJTzuzG21ogz5RIgDdx4m666oTA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HtPT7wlmAcOzg2umDoPGWYzNH+ybbnbJBQujXFLebr1wQPP3p1tZhZEQhhpz/g9e3WFw0hnSUEQEP+7I5BplPy2sN7FaU/9jVB7t2it0B7QeJhsMcfmTyR1t2mjrmQ+BAhpJPWDjuX80uJyqHG6/KbGSYyOCzVRvya0aVKJs9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K518Dv6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K518Dv6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012701F00893;
	Tue, 13 Oct 2026 20:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922985;
	bh=mvQtI+O9SmYKBHqC9jqHNG7YNaAZYhuplHPIvQzcjm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K518Dv6J3ror/wbQ6Q5bbfvVcAr8Qk0DMT20G6aRTVLip1gSOo5YeSd+QaXHB0UCI
	 ZJ8zRyAZB/DVtsbUaxXZsmWc5HCWH0RqqyCUeusw5nQH0FnEhJIIC/NlBC9wmPt9+E
	 5T7iW+dUakAn0sdTqjmEm3ox8ugbfwp+G35bkkwGBhcoi7NKslFZe523Tg9Bg5ELpS
	 jsl4GV1hdyPVmNEaPGCHSRhDVlCj8Z1DSueq1jBfZjIr2McDSa3+J3jIbcn3PlnUAY
	 8WWUvbFzwRxhXUdvvqG1mDgzEh4FblFLu+FQxD3i9SYKryftYW1CBB4pfK4ZYfNywg
	 KAnpJ+u+uVSXw==
Message-ID: <sashiko-outbox-170452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/19] perf evsel: Mark the event as supported when
 retrying an open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-7-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:23:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Opening a group with perf record on a machine with perf_event_paranoid >
> 1 and no CAP_PERFMON fails the first perf_event_open() with EACCES, after
> which evsel__open_cpu() clears evsel->supported; evsel__fallback() then
> adds exclude_kernel and record__open() retries, and the retry succeeds
> with supported left false.  get_group_fd() treats unsupported events as
> ungroupable, so the retry opens the group members without their leader:
>=20
>   sys_perf_event_open: pid 12345 cpu 0 group_fd -1
>   FAILED '.../test-record-group-sampling1' - group failure
>=20
> which fails the group subtests of "perf test 82", the Perf attribute
> expectations test, when it is run as a regular user, while it passes as
> root or with CAP_PERFMON, where the first open doesn't fail.
>=20
> commit 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling=
")
> dropped the pos->supported =3D true that record__open() did after a
> successful open and moved the resets into the stat code only, while
> saying "When an event is tried the supported is set to true again".  Do
> that in evsel__open_cpu(), which every open entry point funnels through,
> so that a retry describes its own try instead of the previous failure.
>=20
> Fixes: 2cc7aa995ce9ecd8 ("perf stat: Refactor retry/skip/fatal error hand=
ling")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D6

