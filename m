Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A26421239
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154971; cv=none; b=dhGhCBkj5Fcwq3D1dAYs/+cUfe9zNFhL3RyI3qV7URg4Vtb/3eC88NIp335sUtpL9sPAS7m++6ucoLMIPl1JWrw1jXbe/EMF5IwnsvnX62RY8RL2fCay62kuFMw813+cEalfBHm/VTV1aNNRBsqLrzjPEqaSNO5eG6Yyc1uyijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154971; c=relaxed/simple;
	bh=vchegoOg+CtMlZVzOZMh5IxmCJEBHDugzAhxu36LeKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndVDxdYEEgwwBE/Wa7JHIjMn3Y/myVJidrGvUKADWMyF8eM7BifpsITA/8teZimQqCiWVZaDTUovJhbZzPvb0/tgHJnBrQ9rfd236/RKNmcjA5WZZtLwVonBmllkV8Ty8DKBrvw8PtFhv1LgPc/zNomKdbsZ01SjLan1PI72QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU5Iveu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU5Iveu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C101F000FF;
	Wed, 23 Sep 2026 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790154970;
	bh=vchegoOg+CtMlZVzOZMh5IxmCJEBHDugzAhxu36LeKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OU5Iveu1m3qj9SJmbolYxX5ZTCbsZATDia/F5IxJow/eLMzBPScMdZdFyhDyPaF+D
	 4xfZ4kAJHTsxOvvmVKkuD4bqEyPyh/o9GmxRamNhCxNZMj/QwAMTOyTnGykPZaXcp3
	 JaVB+FUN3tKP8JrLz8sw6kKHM/PWjBidwngCgUZFpg8PFGQYYvLqBQM2uIw3ERhnzP
	 OYCbKiIlVwpM+eBxOEUKzGeZXgnBwezS6XsUBOgwcWuTQnQK55hDjaSnGwbpNWvGxw
	 rjR9MGhYc6fhrSX53ml8A6v3VYeck386raek+3lIOKc0qeOvMgT6M0ZyhnU7CW76t5
	 3apJJWw+vCfDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/3] perf/core: Let an arch prepare and locate
 the user stack dump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923090429.2026529-2-stian@itx.no>
References: <20260923090429.2026529-1-stian@itx.no>
 <20260923090429.2026529-2-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 09:16:09 +0000
Message-Id: <20260923091609.D4C101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_SAMPLE_STACK_USER copies the user stack as it is in memory,
> starting at the user stack pointer. Two things about sparc64 do not
> fit that.
>=20
> The sampled window's %l and %i registers, including the frame pointer
> and return address an unwinder starts from, may still be in the
> register file: they only reach the stack when a window spills.
> perf_callchain_user() already handles this for the callchain by calling
> flushw_user() first; the user stack dump has no equivalent arch entry
> point.
>=20
> And a 64-bit stack pointer is biased by 2047: the stack starts at
> %sp + 2047. Starting the dump at the register value spends a quarter of
> an 8K dump on memory below the frame, and gives no dump at all when that
> page has never been touched, as for a leaf frame at the deepest point a
> thread's stack has reached.
>=20
> Add two hooks in the style of perf_arch_misc_flags():
> perf_arch_prepare_ustack(), a no-op by default, called from
> perf_prepare_sample() before the dump size is computed, and
> perf_arch_user_stack_pointer(), user_stack_pointer() by default, the
> address the dump starts at. Flushing in the arch PMU interrupt handler
> instead would not do: software events such as cpu-clock reach
> perf_event_overflow() without passing through it.
>=20
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923090429.2026=
529-1-stian@itx.no?part=3D1

