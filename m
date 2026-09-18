Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0E526A98
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766994; cv=none; b=pvnqqHdx/OuM8cjBeU2EFLodHPp2hqajnq40RUyr19Eys6qeGhrB3//YV/IFP9cBSg7sIK3DhdzndumPRZPYC8GNj+q/rx/0MxyfgyMsmaqn3ponIZN06vDItvXkVNktCymHXdGgfraQUMhcPUnPJYgOPIhA14x45Kt5XHZIL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766994; c=relaxed/simple;
	bh=4yJK0Q/nPoSwVwk8j/AzGipJfcNbomLeQ0R0R7VAJjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GZNjvU/xVL/A5mkaLGsfh2uC7M6p6OD5ewYpEfL8s762xjoewogGYAQOLVyupRQZIfC7FKQ2eiZCObVIfzJLmXyZcsDOnsTo6RBErUe0z+8nikStuFFMZCY4oQCnXfuSo5RjKRvuuEesHwvxnxBtk4qqhvHFd20nxvLwcJwrZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abft6Fzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abft6Fzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2A21F0089A;
	Fri, 18 Sep 2026 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766991;
	bh=4yJK0Q/nPoSwVwk8j/AzGipJfcNbomLeQ0R0R7VAJjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Abft6FzxjWnpZak5DsTcb4FiAnbnMB5coDhWxW886ErbvS117sX2yA8nyqcgjWqmu
	 82ODLWzjgTrBKRx6wOZUUepksNA4L7IA580DbSHwLlxecYBf7ogl9oJqDrnKv33oz9
	 AJcFfx0jalLAUIrTYLY5stTiKNeHV4Xj7ZFowzhKiWhWNU3zqCDTqTSAIp/VqoQqs3
	 /6nXxCKka+dJStAtfUeqOXS0XnPspk1v5lnD/RBSKSVa8p4yuBF0Da9aFqZPxlBSDx
	 OB9HXXqrUkfqTePnpMMVSfcQm/RtpZaBB42D7UGngcivVCgxllKwuAzaRkzTe5X215
	 HhfyUXpb/q5rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/18] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-8-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:29:51 +0000
Message-Id: <20260918212951.5B2A21F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D7

