Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2984A6CFD
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918388; cv=none; b=d29Ko62wxpdeL6GA/tLb6YFFzOHMFcfg5GOz6pQI6k4fWLzXiiGl9pui3A3/CLv33q2WAslxrf2kPEW3kWuEAJzCCjv5Co8w2w8TDueXKHiyXXFDhgjnso8G5/URkKzOfuog2iW324k0AUe27GhKpkHpLrpAIZmxFlFbEL5g2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918388; c=relaxed/simple;
	bh=Sim5ET35xY62dXpYXobF5FlZpEyCWehvd+i/nfk0FFY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a22B8N3kjiRDD7ad5qaWcSqgwbyHE+8rT99ingY43mh4QJeFo3WeTYORMv6Iif2xV0tPxA33Z4auc2AD2p7jFRtMspNlNyI3EM59b/yhBidwG0inCpyjdVZF7viMzkYBxcPwEEiykADxBIV8qfzEYOyjbddrsGLz8mNRUQ8GHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhtmOKx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhtmOKx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AF91F000FF;
	Tue, 13 Oct 2026 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918386;
	bh=Sim5ET35xY62dXpYXobF5FlZpEyCWehvd+i/nfk0FFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhtmOKx8wWKB+Yh/xawH5XQZvTzGHzFOIFvt3rh6VESHFZGv5t+jvf6D/u2m5SI3v
	 6VZD/FaNFUg3JQu/rns/UfYNjbsbhQRMtRJatSiSP5hVsI52l3nPMpR4y4VXb9T2D8
	 SSnvW6Gv4UP+nh9RZ9UuU/zU4mRnhDD2WdfzaAFAc7Z/4cfVe3fagLRm7AOSFZclQ1
	 8TDRvIUL4L2wCAIgfdKtdP6Ve8+APAjvmHlrEunm4mc5ZOg6TYMH75fsKXr3U3jRoB
	 6QAnjnAizJK/if9KEvlprzjn90lSSDK449lBHfmhP4Gk81KiY4ttxcYmM5b/utXTrM
	 t2R09TR0immiw==
Message-ID: <sashiko-outbox-170378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf/core: Fix perf_pmu_migrate_context() leaving
 events behind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haris Okanovic" <harisokn@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013185603.1347265-2-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-2-harisokn@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 19:06:25 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> __perf_pmu_remove() walks the group leaders of a CPU and PMU with
> perf_event_groups_for_cpu_pmu(), removing each one as it goes.
> perf_remove_from_context() takes the leader out of the groups rbtree,
> after which rb_next() on that node returns NULL, prematurely ending the
> walk. Other groups stay behind in the source context.
>=20
> On CPU hotplug, they are then torn down with the dying CPU. They keep
> running until teardown, while the PMU's interrupt and migrated events
> are on a new CPU, which drivers rely on never happening.
>=20
> Walk ctx->event_list instead and pick out the PMU's events by their
> pmu_ctx.
>=20
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Haris Okanovic <harisokn@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013185603.1347=
265-1-harisokn@amazon.com?part=3D1

