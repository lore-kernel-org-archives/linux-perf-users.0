Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947A4A35
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339406; cv=none; b=Fl3yNqURw7zDCPwEjEFCqa++DgzSmiVyfaxtgGuI6bhfT2lReNmNPTjWIydRwPus2XepMWAFpbRYu4ct42aqwYh3dNZR5RId2lb5V8eUiViVwyO99Jk564wlB+OkKUiw8fBMSa8Yaw9zG2MhX9N+UIFH/DDeA1OjdgAi4i3b9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339406; c=relaxed/simple;
	bh=/xUEyiqnMV8gKxxBN9v9ptdKQh+toz1bJYdvxrqIw5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sennq0kunKgKyuawiTQfLkxnRTQVDhIlV9hJp12nRc+13Lfn3KlFz3tRLeme99BtFS1NXrW2KAgEhIiuVMi9kt9qlFK4p+GAG9gMVwWHOkHtcDo60OqAwMCH5PJME5RPtfw4A1GkWYQB+xzcDJPLH2HTSuC++uDzbt1vz4iylxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHBB0KTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHBB0KTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC141F000FF;
	Sun, 13 Sep 2026 22:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339404;
	bh=/xUEyiqnMV8gKxxBN9v9ptdKQh+toz1bJYdvxrqIw5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHBB0KTVYAJMQytEcHtsr5CpgotbxCFYxYPSJkuSfWhzmpYUVA1bSpptLkHObrBul
	 U0R9G9GH+9XAQIr9lkNZPneJq/WoHldKggx5ZqgWsgIDkjVP/4akjLFmVYcGHREaqD
	 v2qZH6NosB4GBYEfuBjvjQZIbxqcVMApKtdKu34ekVlU7Cg4vYEZ76VrXStIXI9gw2
	 LSHgyfCfKD20vGcA787CObQnmk0nzr3H4uQA046bKTH5k8rtE16mSzylMghnLSse24
	 yeVcEF2/yIHyWazJEOAXA8ponS9N8HNhucYJ/ydNyHzwr66cl107k3IbW7LGqVMe3B
	 dR/BfVnDXLK/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf mem record: Request PERF_SAMPLE_CPU by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-9-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:43:24 +0000
Message-Id: <20260913224324.BEC141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type profiling per-sample stream keys cross-CPU contention on
> sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
> CPU info" sentinel, documented as such in perf_session__deliver_event(),
> and same-instance reads and writes from different cores are
> indistinguishable from same-CPU traffic, so pahole's false-sharing
> detector cannot tell them apart.
>=20
> builtin-record.c already defines --sample-cpu and 'perf mem record'
> forwards unknown options to the record parser, so passing it explicitly
> works today; make it the default, next to the -d (addr) and -W (weight)
> the command already requests, documenting it in perf-mem(1).
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D8

