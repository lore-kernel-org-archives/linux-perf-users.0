Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBF44F570
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148908; cv=none; b=oQGoJgRo4mWrfx/pqE286qIU9mluQxMuxzxtyFmRhmoVvFLbrxaSj0fymnM8CUrz3YkvZRsFyI7bB+UJ+7ijfm5rCBdMv1PIOu60Gm0y0eRyTfkq9BbP505k5XEG/vCN8/qZhphvIk/IobENtLgFNjr+k2a3ZsTi5QCFhLg1c/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148908; c=relaxed/simple;
	bh=qfJy9mGPGm0r6nLTQuFDr8EVECFKgPQYGFm/VM+oQck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CaBbrs4KmaEEf21ABcC6ICYI8TEwNTEKF6TffhnaCQzrOwo6KP6fnaNu42T0tIpgpEx0ZO9iiPXzRmwxBs3KyM4+5oBodHLaZ3q3AOumrRskY4mHxy86tr/qcnsaBRQRUKpn5wZQ3wk1WOgGFCfTzReufV1bxdVVs0vRDM+14SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgS+Kx8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgS+Kx8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBF71F000FF;
	Wed, 23 Sep 2026 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148905;
	bh=qfJy9mGPGm0r6nLTQuFDr8EVECFKgPQYGFm/VM+oQck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QgS+Kx8fuhTnRRw7/65HRxCR4J0EMiJaeI8liYbwB0n7zScKk85QS1s/ZagLRJetU
	 7iqwnJSppVC1Ytx82RdKSKeQFkNSdf9PRriqRYCwubSA98YRP44I+KKOVs954gT+pq
	 9hFl4Q1XVkuOYUsMvBOioOr+di7irf5XTASSnN1cYfpdDO4ua7vb2Rmq5o2ffRpOVP
	 NfRE+Y0bmuHFSLzVP0FTgXPG73Yn1gSH+i0HLuLmAHu/8XK3UmTg6MpBeAe+SQ6zz/
	 n+7zprEWxfXwJA4YzSkfQmKBWfA+dxHRmdwCyW0mRffVV+NzDf7v6OIY391V7uvWuR
	 kZDzuFfR+4Mxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/23] perf test trace_summary: Make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <68b5cb9502935fd5bfa3acd5332bb78fe8793388.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <68b5cb9502935fd5bfa3acd5332bb78fe8793388.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:35:05 +0000
Message-Id: <20260923073505.8FBF71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_summary.sh tests various summary modes of `perf trace`. It already
> directs output to a unique temporary file without polluting the current
> working directory.
>=20
> Remove the (exclusive) tag so it can run concurrently in parallel test
> runs.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D22

