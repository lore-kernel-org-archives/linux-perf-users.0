Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D332B12C
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094341; cv=none; b=WuRh9/P5lDdOpo1zu7dUnQec+S67IdwbYYgNL7xPnIifRxXT9+CXfVyX7UQua5IvamEdK/dVxTv9liuJH8SL9YlARVLYYygl0+vCB0F2SzYOcZeGrnt5p3HtWnVBzp8rtt40vktEPCc61HlgT6bd7DEtVYGC7ppTMTT3P11IFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094341; c=relaxed/simple;
	bh=ZsmemU33cKuLEyWNs+BXfsugxQiiCJl2jMUIslZE0Cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rHKQSiemjRMJIA3xu+n/r64ljrEs68Ra/TooyhAFj/wv+jZmcMeGYTzDEhLUL5hSpCBe+kUDpHp6GQBlwTtQjT9TQZthhhrLuWG10uJHnzOO2PadA8yrbnU1VWZs68i9/5D9jEO8YXbrfuj9zkw+d9Z0TRxMA/5VhvrRmXn5C6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8RcJxa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8RcJxa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F220F1F000FF;
	Sun,  4 Oct 2026 06:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791094340;
	bh=YC8f9p7wKbEskkUQIiVzfbHJ6ZtSt9GWUzNlv9/GiFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8RcJxa9brg1oCzc7SaThClNzwdIfsuno2bFSmvX8B0bgSKSiToipmE7cRgh6ymem
	 SQpdbT0qCi2HR+d935TpedLq4U1EHwZWUHFDWVo+Tb43ChqDbMT+S+SqyuOw098S65
	 70IZPS85xXob6uQiJXjawLe0NYdtbag859OJh5KSKcY82i4cVB4i0ZaHZubbYWwTKJ
	 x7D4ruNMbMW8ywjR9nif6Fj6xPrchQEsek2i1rD/JPbHjCfkfTHFIJBxVK8T1XMMag
	 ioGISoWVAF3bif4jjXl2iXD+NlfRMY9aXZi54CJITPM69Z0Qfq6CTVE2Hv6BuMX/VM
	 +Ra49n4M94s0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004060457.3353-7-acme@kernel.org>
References: <20261004060457.3353-1-acme@kernel.org>
 <20261004060457.3353-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 06:12:19 +0000
Message-Id: <20261004061219.F220F1F000FF@smtp.kernel.org>
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
>   Processing events... [ 42.3%] 317M / 746M
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004060457.3353=
-1-acme@kernel.org?part=3D6

