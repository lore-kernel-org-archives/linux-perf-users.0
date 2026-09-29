Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675523394A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713384; cv=none; b=pj0Qv4txPaHMSB+lT6bZjU6lrZqp7hSHxngPeAkh8ISEHILcjzP6LUwAgppPH6nthZnLxjki84MhMxwSyNZh4btZ2AGglSyRFjRVJFTKfu26NATng16TE24VHQbiPVmxgbrgm7GCW9cQZ032SDzIYXRSyEiqEJ9Qn+Do18tXyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713384; c=relaxed/simple;
	bh=/xmRVn1Y7Najlpu5RNRFyAaVzOhu0NqznVNlMoxbFMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/GHgrweaEschpJe4az8ZET7YVWziGy+xDt0HlHeU7xLSwUlWvy5GH12YyhmunXbdweky8qKJYq5+o2sTYv2MA4ivod2wBuggF5NU4T0L9vsPjgxx21k71OCF2zudbhPVlm/CNpmmGrgaoyxMVLmK0UtZuKFy+m6jFRMMrfK26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAWtgqWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAWtgqWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7ED1F000FF;
	Tue, 29 Sep 2026 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790713382;
	bh=DmhcEdGZmxrKnwT7g8ur1Vbtjps6N2sf392Y1ZL4tM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAWtgqWb3AyB7yBhiH8I8YbpklZVdyDVkBrcsGAxw16t4DvcQT019585zZ4org/nI
	 wCH5Rvn364VW+zUZmKruQm0VQfqbTla7BtB74mlNByn88v7tH0ebr6DxAKtSUOpRYe
	 MlOzq98RCgXbt3K8bZpb0SlMTrzWMmO+xOPqYNJgXYxqXVMWpeikFzRL/adgqdi5vp
	 W0O/SLhSmiHTG0bAsGzYbMjXufuluchNd5WNFLlK+fJvHIrEhqtemlfAQycpwwuZtK
	 OM8eYXVN7G53tn8x7ivWd4gf/koOlDBT5Z0yGM4EqqaHeAePdDbW/5cIVd5SwaYkIW
	 RdLvv07xJC/Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929201524.2507733-3-acme@kernel.org>
References: <20260929201524.2507733-1-acme@kernel.org>
 <20260929201524.2507733-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 20:23:02 +0000
Message-Id: <20260929202302.8F7ED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929201524.2507=
733-1-acme@kernel.org?part=3D2

