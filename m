Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1C43D515
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627928; cv=none; b=gGGOByLcDqnDlA7bnUfwI6viitoPN3isVNYI+6gb3bMHChm1yP/V5ThW4HTTsGHJgeJZWBa9KoFvV4Yp6Io9fUFJbclsTJ5yX3f7n2N07FCrMG1ab4pCls293kkkgorjPRF4+2O9hxWTyxKqQJ3XU5YyyjHBsXc2Zm94Y7AcFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627928; c=relaxed/simple;
	bh=xy+XAunr3S212zo7htH3qb0BkaT3ylP7IZrXJrC9c9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ut1Xg44qz2iGqBB1G2PZxSlxccuZV73FluQ8nbur4vKF9gSobfrVO6CSSG7zWH8j+jvgZp+S7ErlwTx08Mo5g2cd3Qp2vKTbtYDGUJ+4w6unB9RWf0RhVZ7p0kwoSi9lpxv5pwi3IBl/8SaySSANBIkrTwSXKI25ulgzFecvxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev7UI6dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev7UI6dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0155C1F000FF;
	Thu, 17 Sep 2026 06:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627927;
	bh=OhpbRkFDUtC44XjzZ5cNlNpkku2m8yCJm/TJfRoqL0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ev7UI6dZzG+mg/fbQxZrx4ukLftQxhdZx2NgNOa0OROr59dS74ituHiUPsqgXEB+L
	 zEsoMMVcmvtvRs6+cDuwxwQWvyAuNLN9YVMZ+hvKpSb7+dw2KGl7iVTnXia2WvH3VR
	 rMxGDcHxH/TRd8rEnXBAP4h6QSNEasZFyfRtdMcEJF/MyFXIAmOfR6HMSxuyqvU+Cs
	 Hefh8XnldSmbrX6Q6bWA3rBIkyZXF/o7NE4bJBExAevkBf96PCBOwgYUhTdYmYGmgb
	 q4QYfj6Dz5ZjgXgSvvSYO1SM/vNEJRnElO/K/M0Aa/Nbd20dAAxXnt2cPHd8pT3Jmt
	 c2eh9Hvx42wLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/13] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <79b1a85a5a40701e57f72f6a205148f2c1155058.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <79b1a85a5a40701e57f72f6a205148f2c1155058.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:52:06 +0000
Message-Id: <20260917065207.0155C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Linux 6.19+ added __data_loc char[] internal fields for string
> arguments in syscalls:sys_enter_<name> tracepoints (e.g.,
> __data_loc_oldname in sys_enter_renameat2). While is_internal_field()
> was added to detect them, several places did not properly account for
> them:
>=20
> 1. In syscall_arg_fmt__init_array(), when an internal field was
>    skipped, the arg pointer was still incremented, causing the
>    subsequent argument formatters to be mismatched.
> 2. In syscall__scnprintf_args(), internal fields were not skipped,
>    causing spurious trailing arguments like ", 0, 16" to be formatted
>    and printed.
> 3. In trace__bpf_sys_enter_beauty_map(), internal fields were not
>    skipped, offsetting beauty array argument indices and breaking string
>    and buffer augmentation.
> [ ... ]
> __augmented_syscalls__ bpf-output evsel, and size arg_fmt after dropping
> the syscall number field.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D2

