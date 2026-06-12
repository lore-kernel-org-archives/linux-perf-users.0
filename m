Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429C1DFFD
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296372; cv=none; b=o5g8dz/QJkynOR68dyX4ra+aIID32Fv6k0V2G87rHysqlCoIoqNjC9l16r2b37iXr1aT3SQKvgq0Q+KBmjIRwaBkBuBjoDevgXS2N+V0CrC4PHgNqI7Z+9vB0tJn5DjD2G4a7oTsm0fXCoqYoXTwBpT1yv5vd/K2zyuPcWyiMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296372; c=relaxed/simple;
	bh=RuToLs2nlOCGNirJ0kfdoYEzAIzgzpO45HASDDDSmA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9ckVOLJ6JZ1CaINtOvUionYR0R8oqTfI4KcE3KKKZ83ssF4NPpamS72MwYymSrlD1AWKgITbc2gVtR2UcU4xmGsfohStTTHU7vCoh5I/dTLw95aRFwMVFm5RA3a+EuTeIegmqmSSQeukQoKu5O2cUJDa63hoNqhrnA5vZE+k2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6TQzXjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6TQzXjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C081F000E9;
	Fri, 12 Jun 2026 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781296370;
	bh=WClvr1IPlzo+Hfttoa45VEZmNKAg47DxFzAhGreLLrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6TQzXjzxIMDvWQFHeTb45W+Iu5O5HY02r9ASYItaubGtx1kOgqR3x+7PRuTnWWX8
	 1g8wszP+/wFTJgzzoEejW46+vljJRhmfrqnvLbg2PR9S4Ba14kMAQ8xzcJHzGGuJGJ
	 g7y/0JcwquPpWiH3RjuV+GrRy+oWIYC1fI64mG/RXowvMp0kNswz+4aEOMdDHxrvyY
	 yrixmjJtRYlkHAb12iFqz8BJEpxxhJH6K44EXKyG435VJ/AWZ/lyLVQIpse7V45fyD
	 XuiM5eg0rOyGnag7SJcGMLFwK7GT/LbyqlKVBYAH+qidkrqkrDv/LH0NSlbuwWXt4v
	 bKGQQafttsxZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/19] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612180956.1105352-8-irogers@google.com>
References: <20260612180956.1105352-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 20:32:50 +0000
Message-Id: <20260612203250.B1C081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in the =
lockless cycle detection of `evlist__put()` leads to a Use-After-Free and D=
ouble Free vulnerability.
- [High] Asymmetric cycle detection between `evlist` and `evsel` causes a p=
ermanent memory leak if an `evsel` external reference is dropped last.
--

commit 64d001165a86b6b54d79edbd25c45848ec2075c1
Author: Ian Rogers <irogers@google.com>
perf evlist: Add reference count checking

This patch adds reference count checking to the perf evlist so that gets
and puts are paired and easy to debug. It adds accessors to evlist
functions and switches code to use them.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -212,18 +224,40 @@ static void evlist__exit(struct evlist *evlist)
> =20
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count, ref_cnt;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> +
> +retry:
> +	count =3D refcount_read(evlist__refcnt(evlist));

[Severity: Critical]
Is there a Time-Of-Check to Time-Of-Use race condition in this lockless
cycle detection that could lead to a double free regression?

If multiple threads concurrently drop the final external references to an
evlist, refcount_dec_and_test() will return false for both threads. For
example, dropping from 4 to 3, and 3 to 2, where 2 references remain from
the internal evsels.

Both threads could then enter the retry loop concurrently, read the current
refcount, verify that exactly 2 evsels hold back-references (count becomes
0), and check if the refcount has changed.

Since the refcount is stable at 2, the check passes for both threads, and
both proceed to the out_delete label. This allows both threads to
concurrently execute evlist__purge() and free the evlist, leading to a
use-after-free and double free.

> +	ref_cnt =3D count;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count &&
> +		    refcount_read(&evsel->refcnt) =3D=3D 1)
> +			count--;
> +	}

[Severity: High]
Could this asymmetric cycle detection between evlist and evsel cause a
regression with a permanent memory leak if an evsel external reference is
dropped last?

The cycle detection here assumes that external references to the evlist are
dropped before external references to the contained evsels. If a caller,
such as the Python bindings, holds independent references to both an evlist
and an evsel, and drops the evlist first, this loop will see that
evsel->refcnt > 1 and return without purging the list.

When the caller subsequently drops the evsel by calling evsel__put(), its
refcount drops to 1, but no cycle detection is triggered there because
evsel__put() simply decrements and returns. The evlist and evsel would
remain in a permanent reference cycle and leak.

> +	if (refcount_read(evlist__refcnt(evlist)) !=3D ref_cnt)
> +		goto retry;
> =20
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:
>  	evlist__free_stats(evlist);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612180956.1105=
352-1-irogers@google.com?part=3D7
