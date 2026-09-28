Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D1377AB9
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620438; cv=none; b=HfcmdDgCzpI0PJdLJRnuiD8adAMz/bcghXVDLD+iEoq6ltvRDFU9gHUint/dlv1Fg0z+SHOvTHRpnfidwfzyYr87ayrPD1Mrqn4oL1JGJ++PLG7BwCL7y9fy+I6rjODRF0MsOfxuG9vbiYHtytsctWc5mVdaYHRvJF5vINPHOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620438; c=relaxed/simple;
	bh=7mjHoOHTQLStF3EJ8bOOrOsUkLR8pSVfo/Xd02G7whA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F/shf5Uwnea3E54DYhGmFnBd/ov4l4y2QEv/YlNZce8hc4N3P9kWlvv0HClVqXtE+s8i+oJJdakITVC+/Lg5RlPLwgmPbfVyACezCwxxwMO5nQo4Ja8KI+sc0doGNNuW9atCd1/zviHwDtBZT6tEpo2rEYhXFZS8hsRC3yAjTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1HqXuWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1HqXuWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E5C1F000FF;
	Mon, 28 Sep 2026 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620437;
	bh=7mjHoOHTQLStF3EJ8bOOrOsUkLR8pSVfo/Xd02G7whA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e1HqXuWo9vcZ50N1dtlSmmuhb6g50m0c5HMr1VrmhwEut2+2ZdCL+shjLn/UvjkJH
	 i4kPEBurmnlzguo1VQ5davL7kEEJCaC2CZ3kiIryWnBO32Kn7QjQfT7p2hUpVROK4M
	 LAI+P31xMvE6ZPIQ+LStNWlg4tr+okompyTACyoAxGXh9KPHwuooV6vWpNiuM26aBb
	 6LjoTVICtFz0HkjbS+6kPHxu8qSrVuXo1qmLYkJTzl12F6TmUEOZ7uIISMRRWhyAwu
	 tZtGtZ3NJ+YNM/IuFavi34POrxCg/KXWkm2ycQChyIeterjw/27Z5w6+bsRRGNH5Ay
	 jdiKrBNEHacAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/26] perf trace: Only take augmented arguments from
 the BPF output event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-11-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:33:56 +0000
Message-Id: <20260928183356.D3E5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> syscall__augmented_args() treats any data after the syscall arguments as
> augmented arguments. trace__sys_enter() avoids this for
> raw_syscalls:sys_enter, but trace__fprintf_sys_enter() also handles
> syscalls:sys_enter_* tracepoint events, whose trailing data since v6.19
> holds the __data_loc strings of internal fields. Only the BPF output
> event carries augmented arguments, so only look for them there.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D10

