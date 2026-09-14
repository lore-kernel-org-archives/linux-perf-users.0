Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2268476056;
	Mon, 14 Sep 2026 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393958; cv=none; b=umZBQz7T+BRBE5MBOjLvP9rr87T5MY8VZxg7v7W7t8J2OeW+zD4SZ7g8G+0uDBq+CritdpPH7aI9Tmevl3Yul/n48g613r3WQvhUMhuPLsQuq6tVLXMAEQzu0f0PeZOrdA47zgQ+HK2aTs3LWa2A61vKxj2dwN/g0ZMIWgbEzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393958; c=relaxed/simple;
	bh=2reY8C2tQnnOl9p5+2Jg89Nne8CY4B1JDJSpQj65R0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=itJJNRCuJ5aNxRMhDbdgQSIgYFxTpTMUTAmnU8mq1GHEjLzJOYii40VyaEGlaxTovxU5cfhEuN724aMNnsVh4ayN2HkppbBiuR9g6LOZBcrrU8tknKOwStQmr8WduDCWB3bslFAB155IgasVlkepXin2/TDRi6WOcTZHefFUQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APDlhb79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APDlhb79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC0C1F008A0;
	Mon, 14 Sep 2026 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393955;
	bh=2reY8C2tQnnOl9p5+2Jg89Nne8CY4B1JDJSpQj65R0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APDlhb79CGCrJJSubrf/5EYdDpULqadDoMNZVXS3wTTBcoKV/NZJmayoBzORMjkZ7
	 tkG0O/yeFjRrsJ3XRjaTDt+hG4EcRpcAHaq2XrYkacLqL5d9gzVJYtxYUYcvzcngQ6
	 NhAv6Pkxq7YMN4OeWmNAPvtjYuMzA+Gui+KjrDUMzyvqIk6ffEKL6lpK1LaJj8Tmf+
	 Aea403nNyGoAMHco6TOrWu8zinlLHCMOZBBISsD/oN4OF4dKN5aAe+PvFFbl34C5wx
	 9/L6E3AYQrmiDGmARfUK5yllxV7GezVPo1Oh/ah9FSDRrR6QQ9+/DHkY6GFqMtxwqT
	 qtMiWT+cV/e1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 05/13] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939023566.94750.959822747583037477.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939023566.94750.959822747583037477.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:52:34 +0000
Message-Id: <20260914135234.DBC0C1F008A0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add modify_local_hw_breakpoint_addr() to update only the watched
> address of an installed hardware breakpoint on the local CPU without
> releasing and reserving its hardware slot. This is available when the
> architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
>=20
> The caller must provide an installed local event and a valid address,
> and update other CPUs separately.
>=20
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf9=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D5

