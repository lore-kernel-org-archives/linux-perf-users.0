Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602571;
	b=uCGgF5YG0ZLZCuPGlfFq2vFFQrdfpTEB6lITQ4IxMuEi40Z6H8FzrvZF95fCIo4fy4zd
	 qpm5yZHRpiz178eeHOfMPji+A6uU80ypEzAgarpOnP64fs8Yt2jb4oPQYXllAkblm2xQ3
	 xI12Q5ftBiNrsiY4OMDRCO2+4SH6VjrSTeCUYFxm/0DDTWv6M3/hrPuvq/Yc/A/GNZAlK
	 m+KejKWfCeUzlso6Dnr7/Vc3QiF7mOQhG5TJZOTYkRy3mCzb9BtyNbrwGdpwcWHH7mQYG
	 LtCXUBggF0WZYtwqI8/Gzf3BYeM3ELKjdyv1CQQGFN1uFMhnNSvGm5nhPuh0skbt4eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LnyI28lMkC0Lg1H8DtJTa9DNURWXz3zfDR38hJwnQjk=;
	b=MZl7jqYiexb06D7RghGdcIjGVLqpiDBq22w6lJh5wa01FRfP/6ceTrk8kKThsknFb4yN
	 H0134HNfiF7MJjUcjf8BUU1i1CeAWHUOJTzdBsV1eQtx4Tnp1PONXANaVaTUZawcxg6B4
	 pl96H7uAEIOqVBYdRQX8oDt8Ur25splxF04ri6KxhRNjtuFlIrf5c/h+gDuRQs9FoYozZ
	 wm0sKhpQaDOmmz+UgKUjobDvDEnMw/mihZPW+mnbbCBjTH+AOgMekDh1B/ElZrFMyYUEU
	 rau9l68D9xN7/pROB5gk5U43w9LeIkv9F7szADgt1gYW22Qh2FQ16ZxTAySP9dyp5sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dicZEOpi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F52606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dicZEOpi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AAD1F000C4;
	Fri, 13 Nov 2026 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602571;
	bh=LnyI28lMkC0Lg1H8DtJTa9DNURWXz3zfDR38hJwnQjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dicZEOpinOHuX+bpLfKINRBblLGc1w/9OaVwInLMQ40/8pTpH5X8aG0S51jAyLaqq
	 ru4eWp6cqQhHiyTa+03TOBjN0e9ukTpdW6kQBKsxX8aTZ7UIChe558WuGi3MU8x/qY
	 ogRqQ1vyV9YXOUytljZpReMhDBMMF6bIs6gFUtHGfL3Wnf1aGO1hZmM7I/onI80jiv
	 c1QV9ca7BuffgGr6OMQHmx406/li0hbL6dEoYTt9TPacCbvb9EDT5yq80O1L2MyWoq
	 XwUHngApmLKQnPc3pcoEPrEpZkXd2T0J7c4jozM7UXxO7PNNjm09aw/9SpqZY026Uq
	 V8dRJyQhrqStA==
Message-ID: <sashiko-outbox-213672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/30] perf metricgroup: Add
 metricgroup__add_recorded_metrics()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-28-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:42:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add metricgroup__add_matching_metric_groups() and
> metricgroup__add_recorded_metrics() to parse metrics or metricgroups
> requested on a recorded perf stat command line (or the Default
> metricgroups when no events or metrics were explicitly specified) and
> match them against the recorded events in the evlist.
>=20
> When reporting commands such as 'perf stat report' or 'perf script'
> inspect a perf.data file recorded by 'perf stat record', this allows
> reconstructing the exact metrics requested at record time (including -M,
> --transaction, --smi-cost, --topdown, -d, --cputype, and --pmu-filter)
> or optionally adding all matching JSON metrics when --all-metrics is
> enabled.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D27

