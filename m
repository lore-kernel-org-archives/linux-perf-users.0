Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B021D5AD4
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052266; cv=none; b=U7kq1+JULfXNcwTox8IRW0yNl2OjjbzMqCh0uT7EzfX2NO2RdDy96WZaLElMPgDQnm0wNl2ROsIjELai5huP0pOslsJ6bVSUFeXCRZ8Ke99H67ycj0qR6JA7KGiKcxqowYxfm8+K+0GsO+wTkStNxZzi4ntXfdx5w6ccPUBvBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052266; c=relaxed/simple;
	bh=Y7gOVcGZmNQl5pS6/PTKING4iWjDxx+cRy9lGH7PV88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZgvlMu+JXn32KhS27sT5qV7oz39rC3qFYeiAD89SxTY1hXPe3I3V3qS06XyDiZgXlBF0yJ4n1WEPjKyjYyfXVFzDB46oCfyWvAV66Mndwgd+Kqwy/dJQw58ZBiCLkY/sSYOpNld/F1rNPn3pSjoUTvcCvi8KgkvI8Ube/WyoFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/ilqF+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/ilqF+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA4C19425;
	Fri, 24 Apr 2026 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052265;
	bh=Y7gOVcGZmNQl5pS6/PTKING4iWjDxx+cRy9lGH7PV88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B/ilqF+cXi2L2hfEu8Pa2o0fHdEqlNU6oeKeIglIsd2HckzO1Xowa6fgMGB4PHV7f
	 5jgcE3PCFxzyjww3akr0/jxc6CJ7HgV+TJC5/oezmcglNDfDsuFN/jiYeZY3XAKlbQ
	 r5/EBTHmQKitPxwzG8WeMWwVbxVzIosPSM0obWk+XM6uB5LZoaqqMU+hBxvXpJqHeX
	 jlTbNgg00s0VvcYbdtdP4vym65ZDhSsYynuzQ8c+yB2656nqrtDbqsovLcYoGCXf46
	 on8sKSf6F8C8sYdeTkINF4FxPwPiU7SQbN5FWxlv7+vpxYGj11OUdqv456NnWbjULA
	 r7JBuzkQANDSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/58] perf evlist: Add reference count checking
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-13-irogers@google.com>
References: <20260424164721.2229025-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:37:45 +0000
Message-Id: <20260424173745.C9AA4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `evlist__p=
ut()` breaks atomic reference counting, leading to Double Free or Use-After=
-Free.
- [High] Reassigning the local parameter `evlist` in `iostat_prepare()` cau=
ses a Use-After-Free crash in `cmd_stat()`. (Pre-existing issue)
- [Medium] Leaked `evlist` reference when removing `probe:vfs_getname` even=
ts due to bypassing `evlist__remove()`.
--

commit 277a4b5e346eb6e74fad04ad6b9e88d0d32aa103
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This patch adds reference count checking to the perf evlist object so that
gets and puts are paired and easy to debug. It also introduces accessors to
evlist functions and updates the codebase to use them.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index a362f338f1044a..29588af735e5af 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -215,16 +225,32 @@ static void evlist__exit(struct evlist *evlist)
> =20
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> =20
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count)
> +			count--;
> +	}
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:

Can this sequence result in a race condition that breaks atomic reference
counting?

Because the decrement via refcount_dec_and_test() and the subsequent read
are not atomic, concurrent calls to evlist__put() could both decrement the
refcount before either reads it. Both threads would then read the same coun=
t,
subtract the back-references, see a count of zero, and proceed to out_delet=
e,
causing a double free.

Similarly, a concurrent evlist__get() could increment the refcount after
the count is read, leaving the other thread with a dangling pointer since
the first thread proceeds to free the evlist.

[ ... ]
> @@ -235,10 +257,11 @@ void evlist__put(struct evlist *evlist)
> =20
>  void evlist__add(struct evlist *evlist, struct evsel *entry)
>  {
> -	perf_evlist__add(&evlist->core, &entry->core);
> -	entry->evlist =3D evlist;
> +	perf_evlist__add(evlist__core(evlist), &entry->core);
> +	evlist__put(entry->evlist);
> +	entry->evlist =3D evlist__get(evlist);
>  	entry->tracking =3D !entry->core.idx;

Does this change leak the evlist reference when probe:vfs_getname events
are removed in evlist__add_vfs_getname()?

With the new reference counting semantics, adding an evsel to an evlist
acquires a reference to the evlist. In evlist__add_vfs_getname(), unmatched
evsels are manually removed from the list by explicitly setting
evsel->evlist =3D NULL and calling evsel__put(evsel).

By bypassing evlist__remove() and setting evsel->evlist =3D NULL without
calling evlist__put(), the reference to the evlist acquired during insertion
is permanently leaked.=20

Because the event is removed from the linked list, the cycle-breaking loop
in evlist__put() will not traverse it. The evlist reference count will never
reach 0, leaking the entire list and its resources upon exit.

> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util=
/iostat.c
> index e0417552b0cbd1..a0baa6cdefd891 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
[ ... ]
> @@ -334,7 +334,7 @@ static int iostat_event_group(struct evlist *evl,
> =20
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)
>  {
> -	if (evlist->core.nr_entries > 0) {
> +	if (evlist__nr_entries(evlist) > 0) {
>  		pr_warning("The -e and -M options are not supported."
>  			   "All chosen events/metrics will be dropped\n");
>  		evlist__put(evlist);
>  		evlist =3D evlist__new();

This isn't a bug introduced by this patch, but does this code cause a
use-after-free when reassigning the evlist?

Since evlist is passed by value, reassigning evlist =3D evlist__new() only
updates the local parameter. If the user passes unsupported arguments,
evlist__nr_entries(evlist) > 0 evaluates to true, and evlist__put(evlist)
frees the original list.

The caller retains its original pointer, which now points to freed memory,
potentially causing a crash when it iterates over it later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D12
