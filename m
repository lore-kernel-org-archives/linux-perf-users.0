Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631643C045
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627779; cv=none; b=j1hwu6ISvdyMQQV4Tc29T4C46XLsKx23N0xZ8rFnN0RWYb08xuxR2VxxzVR5NoYgFGiH6bIziKIjm/5mjEPatwDhYU/0qaFF3jS3o5zhby1XaX+AzIWRdvIFgUDgQyWZepbQOOW0eN9LJkjeXeowHPYeZXO6P61aRFDYthPcQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627779; c=relaxed/simple;
	bh=jnFtV3vE6BuQ5hnpQ0TA2kYD8K5izWoAKYu7tpIluL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EGnYmCESYoLEgGtJs4BUkcNCGZ08XhgKlpyWH82W8HGY2F7HeXtPNEvF4yz6tJfkgj8AYOC6H3vwM4o08iuJ6iwcFHznPSS2eu1gTC54IV2fCJjR+zia5H7ZhVh2SEJhC+JrZAsuyscm6jpY50rvk+kXRtP0n4vv6YywBgocFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQVvF0Do; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQVvF0Do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E481F000FF;
	Thu, 17 Sep 2026 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627778;
	bh=jnFtV3vE6BuQ5hnpQ0TA2kYD8K5izWoAKYu7tpIluL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQVvF0DoS1ZygEtkIN3jWs4N8ed7ycsFSl4LEzBWIRL1GKX2pOl/woijXSWoKd/9t
	 0dvt97wfJP5PhJ86UjMVeOWisBN3ufcOesgA7MWhrJBKc+TpOq9R8Zdd4P+BebmSd/
	 nGQfPqWDaYk5gLAUiAQzOTsTir+vIF8LERSqne3QKz20NM+RS9vsRJL7GeTQbSSc7W
	 8XQD9PxKk87SE3tk3CToYnaRg6EkuOiHR68awujtbG9axPIxcF849YSKavOTxNW5A7
	 u/wtBsWdwNzPgUSKcBj6tv3sm3UebhY4HYEKxexeY9CKDmO4hiIcx3yLXOlyECyuAN
	 QNnJsbIlq+svw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/13] perf test record+probe_libc_inet_pton: Scope
 event to PID, add retries, and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <09c5cdf8edb4c418e417d98a996e14d6b5e68f8a.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <09c5cdf8edb4c418e417d98a996e14d6b5e68f8a.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:49:38 +0000
Message-Id: <20260917064938.66E481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The uprobe name was not scoped to PID, and concurrent writes to
> `/sys/kernel/debug/tracing/uprobe_events` can occasionally return
> `-EBUSY` when another process holds the tracefs inode lock.
>=20
> Scope the probe event name with `$$` (`inet_pton_$$=3Dinet_pton`) and add
> a retry loop with backoff for uprobe addition. Drop the
> `(exclusive)` tag so the test can run in parallel during pass 1.
>=20
> A PID scoped probe is no longer cleaned up by any other test, so add an
> EXIT/TERM/INT trap to delete it, otherwise an interrupted run leaks the
> uprobe into the system. The trap is installed only after the root and
> IPv6 checks that `exit 2` to skip the test, as trap_cleanup() exits 1
> and would otherwise turn those skips into failures. Deletion enumerates
> the probes from `perf probe -l`, matching
> `^probe_libc:inet_pton_$$(_[[:digit:]]+)?$` exactly, rather than reading
> $event_name: a signal arriving after perf probe injected the uprobe but
> before the assignment completed would leave that variable empty and leak
> the probe, and an `inet_pton_$$*` glob would reach the probe of a test
> whose pid merely starts with this one's.
>=20
> While here use mktemp rather than mktemp -u for the temporary files:
> this test runs as root in a world writable /tmp, and predicting a name
> without creating it allows another user to win the race and plant a
> symlink. The perf.data check becomes -s rather than -e as mktemp now
> pre-creates an empty file.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D9

