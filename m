Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15391442B06
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148462; cv=none; b=AZrVsJogeTWYDsbGppllL/zV2ZJmxuDdlXS27HsN7RE7Xg01uNLdLtNBIfyLW40gvMChRhp/x9knooDZn3suaYzp3wRL71g/bJ5Kac9Jh59iYhY90L7iV0+vvdpQZMo3IeCPNFXHk0skKie0yXhFN62KV7BIys6XdZjfJZnYbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148462; c=relaxed/simple;
	bh=tO1siduWqOY4SNY2AcO/1xhowHnrWHMga6GGTLJxXjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bk2sEePNDhnLCXF8jA+Ez4JOHDQJPRU7YT6LYmphIKmgHvveFyw4yFsFL46eLIuHdxaKwyDY9bHJN5wLuWRi3kt21zlhlBVbr255Y8mhsWXYQOmUONQAxvXjn4OJemqoOcA8paYIzEJVZgsYDyyZRWIafglPt/ccb2cesSDrn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4juxx7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4juxx7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979011F000FF;
	Wed, 23 Sep 2026 07:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148460;
	bh=tO1siduWqOY4SNY2AcO/1xhowHnrWHMga6GGTLJxXjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4juxx7JUAJY8aBTjOTmX+NBdXYrs+5wlBuNl7eQ+strorMzh3prTSTMfjKGhy2vF
	 hB6kGM8kahzOd122xvj5Zgt3DCeRKoeAqjYMB5+XqBSPAQkE+oqTnLk8kqxonC2TYB
	 WVL5cTRo6sT27v9BZLn/DuWB7eT5gS6YQjQg3kc93HHwlxHoZsHR2+8OgUj5UtMJIp
	 cMdSyhlL0W5qqSaudzluUYPvYBf8zdRU8NvBT01yMv+6vTFGklyWfsxF6alESXsRvr
	 neZgxiZ+u9SIhKoxdC3XkCwhf+u3oY/38+NZGuNCS9zxjywpgZuI3o4DP6QU2lEWcz
	 Ex2kpnyUrkAiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/23] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b77523973d8012f1cdc36eca15021b204a42aaac.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <b77523973d8012f1cdc36eca15021b204a42aaac.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:27:40 +0000
Message-Id: <20260923072740.979011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The BPF augmented_raw_syscalls sys_enter and sys_exit programs returned
> 0 for syscalls that were not of interest. Returning 0 from a tracepoint
> BPF program vetoes the event for the whole system, so an unrelated
> concurrent perf trace, perf record or ftrace session listening to
> raw_syscalls would silently lose events. This is a cross-session side
> effect and shows up as flaky failures when perf tests run in parallel.
>=20
> Furthermore, syscall_unaugmented previously returned 1 without writing
> anything to the __augmented_syscalls__ ring buffer. This forced
> userspace perf trace to listen to both raw_syscalls:sys_enter and
> __augmented_syscalls__ in its evlist, requiring userspace event
> deduplication.
>=20
> Address these issues:
> 1. In augmented_raw_syscalls.bpf.c, never return 0 from tracepoint
> [ ... ]
> The inner report becomes a pr_debug() and the caller prints the error
> it was given, which leaves out_errno without a user and it is removed.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D12

