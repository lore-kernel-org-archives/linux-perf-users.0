Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28F3D647C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882670; cv=none; b=eGhI8WfEL7UQ5dbub/kFIlr6xPcsVHRr3EIor1Pkk/yEurh1ZU8JrOKxHCHKh4XPeKGGmN4fIYHd/t8PF7K4agnAOchI/NJSFC2VZT6tMiB5ctIKVNQB1rFyxgKn9WUj1+TyFMV9dFrFTADUB0SjR/mLxr/+ejmRVRf4LLzlPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882670; c=relaxed/simple;
	bh=174Dx6rbG48C015XaAvJbQwOIyU/0rQ6/jaSw8vvMyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gem8cvq7kQI0t95McWgg9QZJOrHzfxcLVgqUf56LrV51TVIcHsZ8/annH1hC+OBqFKpsG/ymMauq8hsV+eEHvCGSdtMbCmPodL9KtK73n1JVLpalkfW/9xxuG4kWeXIEWAk7wwYST16XnKHVZS7i+og0EQ/hQq7HdQ8xppPf0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8IM+ROD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8IM+ROD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF91F000FF;
	Sun, 20 Sep 2026 05:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882669;
	bh=3pPBYphXcIpUoPyun0hSOMXnDUYnrT5BJ51iwp98miQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8IM+RODnGDZgSRNt6BKAKreU4Z2TUG323sjkvAI5Ym4S/OzRZIQikEMhwxrDfveo
	 +vTxrPYxHr0+T9ge064nVZKiK5va8OhzlpIP5WBWv3vdEV0VXfn6fbKUkd1vRcxqQx
	 r72Mpw30RmLBw9RSQXSfJ+jliBCXoxRQkpk4otp5/9tqqqk41M2AqC88P5rtE2FwWa
	 GnUsKOhTGArvaXzlZN7pf7gEty0u3Z9L/jcnI15oYhIbWO7mwcZhaMa/mT0XcWxsJF
	 Bjos8wLtLrATgtgaUBXWhz/sjY04yuAU5/8aZ4plhBGmnE/vHMo2Qg1x1LrKPj+oUm
	 8LbuieywWQTwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 35/49] perf python: Port net_dropmonitor to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3a269ced8b8514db66c664d40a1750c779d8e64d.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <3a269ced8b8514db66c664d40a1750c779d8e64d.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:37:48 +0000
Message-Id: <20260920053749.42FF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port net_dropmonitor.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into a DropMonitor class with full type
>   annotations to encapsulate state.
> - Use perf.session for skb:kfree_skb event processing and add argparse
>   CLI support (-i/--input and -k/--kallsyms).
> - Resolve kernel drop addresses via perf.session symbols/callchains and
>   binary search over /proc/kallsyms, ignoring zeroed kptr_restrict
>   addresses with graceful fallback when kallsyms is unavailable.
> - Remove Python 2 compatibility code.
>=20
> Add a shell test (test_net_dropmonitor_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D35

