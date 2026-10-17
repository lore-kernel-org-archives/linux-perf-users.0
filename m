Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B780317166
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202889; cv=none; b=Rs8fBhTg/I8EBsmritnK3lmUFYAX4cx9n+/4/4aPGtr26E3wfo4MZ//75gCVR71TN578jJf+DSsox8zMElfbyHKsOuU58POuuYdVBvKnuY5gGgh92etG5Gqa+sFfHGvo3f8mMidazpFbJKKFWGtDY2if/SGQoku4selWYPAQU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202889; c=relaxed/simple;
	bh=v6VEfZnhRfdvxtCHL/12pkt3IFFllw2rmFTd6DTfo0w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EDJwJ97/XK78g6NVygiVlYKWSQdmfhGb2SZ/K33PqgTtr+dennpaX+tgKkWx8uGbtiZdrBkvpbSlNxSBKfzGbORR1Fecb6e/VoIQh8Q2ftvjQDQp/IeOhVNpHvoPEPQhK3XfA6o9ATMNAQlXwfoYy5RQhFpO0igTYdcrSVlE0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr0Uq7Fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr0Uq7Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6381F000C4;
	Sat, 17 Oct 2026 02:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202888;
	bh=v6VEfZnhRfdvxtCHL/12pkt3IFFllw2rmFTd6DTfo0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dr0Uq7FeFhZYLl5TwJ7/CvD7jOGiNp0DGQCNwQfjZBWxYg6oM1fS33cOcU6B8pce4
	 uSCH6z+E2wZnp2j2neI/84CCXvGYzo/ncT+elpid8EPdZdNscc/GskbZeJcbXCd/9D
	 jU1zKMIV+koEtC/i1PDdBEHhWF7gSOWDLLb0x7aZ36Pc+R7y6rRbpQNGVRS+diyK9X
	 fUZjP1MBY69+W5Ynj0FQjxZirk5j3X89hFPWqSx4k833FC7kdClVwFbMBY5OQWqwde
	 9e7LfzPf7NBPd2KPmw5VsZd2RkIXpWF3oHdQxG8y4hYmVE1q3SmrljLXrp0cDbA7li
	 //n2mEEzoQJOw==
Message-ID: <sashiko-outbox-175192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-4-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
 <20261016-alpha-perf-regs-v3-v2-4-17654742226a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:08:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Let perf sample registers and dump the user stack, which is what the
> perf tool needs for --call-graph dwarf.
>=20
> The register indices follow the hardware numbering, so r0-r30 map
> directly to DWARF register numbers, with pc after them. r9-r15
> are callee-saved and live in switch_stack rather than pt_regs, so they
> cannot be sampled. Without r15 an unwinder cannot recover the CFA of a
> first frame that uses $15 as its frame pointer.
>=20
> sp is not in pt_regs either: for user frames it comes from
> user_stack_pointer(), and for kernel frames (PERF_SAMPLE_REGS_INTR) it
> is the end of the trap frame, as in stacktrace.c.
>=20
> Software events such as context switches and tracepoints hand perf a
> per-CPU pt_regs filled in by perf_fetch_caller_regs() instead of a
> trap frame. It is not on the stack and has no room for sp, so report
> sp as 0 there rather than the address of the per-CPU buffer.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-alpha-perf=
-regs-v3-v2-0-17654742226a@gmail.com?part=3D4

