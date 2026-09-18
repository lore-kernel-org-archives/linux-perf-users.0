Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16C35DA61
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742744; cv=none; b=Qr+SqzZ05mfYUgwB/2Aq0ZqLjN4AdUEEFOJ7/Gcl7fZneEwv3mrVbzmIPDFOcMa2XdevybuepO1jIBYnKjNnYg2gBWzT+Q9fasmhPiSPJl9D4/7ZfZ70h+JGDnciqYxzXEj4FkDs3wrczqkKpN0VtarjjeswKBlabHqXarJxOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742744; c=relaxed/simple;
	bh=DMNzMs3sWQvvS6nlIaKDQCZg8YXEYxsOaMvY8EVlEPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qf0nOqAmfRqZABZ+KuHZloBPYBgOwDfj/MRtaMyat5LP0HwM3FvxPwcI113SJVbNvZ9FzXWWyoO8wnwBxKPJjvIo+ZhYgTJc1aXeCvOlGNjWyyrJ+u/m9ZW4C0YBZ6DdMbdQBi1DJ/9U/tGeeaxgPkXnDLjz/pYe0PT/oibuJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EltxdKip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EltxdKip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098DA1F000FF;
	Fri, 18 Sep 2026 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742743;
	bh=DMNzMs3sWQvvS6nlIaKDQCZg8YXEYxsOaMvY8EVlEPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EltxdKipuC3xTq0uz29AnrMos7GjKiUXgf5w94OP1jK8YbB3bCYET6BYxK0CKIiCa
	 K0MYp4iLE1GVdjVkgnoFtb0dK5vTxtJ/UyDJTszn+sxMsWSnHqhIYHLj4cM80qBoVb
	 LLf6+UXf02nmtSY9lc6yZ959xT9uR1cVdsSdrTeefix5Uim1UK6yLpgBMM1z1i2+28
	 8pgvB3gRCBk1JfPKVPUVAX5yTxFn9iW/hsHg6opozz3piTGb4mVbQnS4QqPsp5trWZ
	 26Gk7GAgEsUBSlL7XQWEaAozK4Opnkh0EZJtx2RG2/5RE6gfnYpiOdyqJnh535oayr
	 l/oR4tsaHhsZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/16] perf test record+probe_libc_inet_pton: Scope
 event to PID, add retries, and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-13-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:45:42 +0000
Message-Id: <20260918144543.098DA1F000FF@smtp.kernel.org>
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
> [ ... ]
> true, so the negation would skip the failure path and the test would
> go on to pass without having recorded anything.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D12

