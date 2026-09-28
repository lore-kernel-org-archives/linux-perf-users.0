Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422C37E5C0
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620747; cv=none; b=SL3UcoM8vl5/L+b+Tvi7TVJDwBD1ezhcRWFvlhy6oK+AycwTjWZqHyIA6JLIH/f+VXHWW/NLgY1RxrWeXgrwI2yZevH+lDyVlEWkOVi9/zTmzDy1Zpp6AFdPhytUnM7KarcRzUEY681nsEmPMvrv/CSIghOlYuW9+yjPqSOHz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620747; c=relaxed/simple;
	bh=WJH81LNxUh07coIdGXhNJBevbNHP6ObCDDlbwCvW9ls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IpROwWJmO9wQfwjOrm8JjSN4y4rGICHCHJj1zxRko9yVYXSwu2G27UGZCfios6QcoUFYQZJ6LKevxOevRWWGx7VBy/3TLp3nVtO0RwCqKDjZa5EXX1oZ96+k+HybTV+CIBZAfINJQcmLR5YQeQk3WG35YfwKI8Kemj8dlFI9RUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4kn5mPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4kn5mPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B21F00893;
	Mon, 28 Sep 2026 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620744;
	bh=WJH81LNxUh07coIdGXhNJBevbNHP6ObCDDlbwCvW9ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4kn5mPXCLgoMHJ07W2r4GFb+NoQWC4rQsaKCxHUm5WuoMK69k3yQBvdBcD9GkNz+
	 WQk/rIiUuyw2vh+FZ6V+syV5773vB56remp7pBMJLYCMiT0mhgxqDdUl/wP/2QTHYh
	 pMad6p3lu+pZ/8Ym6Pexr/6V0qDxIV3O9fA/69cFOafgG0hvgV/SJK0a/ObRwwKGs0
	 qIGio1gvCFJpl3cwA8cF5VXtbFr6Cn8al/vNB5xSLgDXrLjdeCPt/wQdUsYG451ohb
	 UOWRy/LeHti0qp38DQi36IIjDcXpj0bEARWHN7UZO5FEfG00pa0qrwWaXnZOzqClDb
	 yoMJAb9JF3Gvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/26] perf trace: Filter the target's tasks in BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-16-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:39:03 +0000
Message-Id: <20260928183904.444B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The augmented syscalls BPF programs are attached to raw_syscalls system
> wide, so they run for every task. To make the bpf-output event system
> wide, and so augment the target's children, they need to know which
> tasks are the target's.
>=20
> Add a pids_to_trace map, seeded from the target's thread map, that
> sys_enter and sys_exit check, leaving other tasks' events alone. tp_btf
> programs add children on fork when inheriting, remove exited tasks and
> follow a thread that exec gives the leader's pid. Tasks that don't fit
> in the map, including when seeding, are counted and reported as lost.
> Other forks drop any entry for the child's pid, seeded for a task that
> had exited, such as a zombie. A workload waits for its exec, like
> enable_on_exec.
>=20
> When inheriting, unless given threads with -t, key the map by tgid,
> like off-cpu's task_filter, so a process's threads share its entry. New
> threads are then traced with their process, which is forgotten when its
> last thread exits, and exec keeps the key.
>=20
> The sched programs attach when the skeleton loads and the map is seeded
> before the events are opened, so the forks and exits that follow are
> seen. sys_enter and sys_exit now attach once the maps are populated,
> rather than at load where the empty prog arrays made them veto every
> raw_syscalls event.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D15

