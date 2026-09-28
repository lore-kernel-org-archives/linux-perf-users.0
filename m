Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53403630BE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575106; cv=none; b=VRjAQzyQC6uMQfhDv5o04Z5DAEQ3cgIzDpv26yECF97PSHOLFcEttJyZuS6y0L5qyy4bN5vTY7Hb1LdUxNyCFIu2m+MM8m6F+mfrh0CZlw3n6Nkv+pDgf0rBvq5wFORApQFiWskZ2UIMDDm0TTkfSwuxOuWHmxw4EadfS+L7FT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575106; c=relaxed/simple;
	bh=YzYBAtEp350jL6vNh0at+HkF4n/aSB2QynyY24XcSSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=caa+kmHXsaTp0q+d8IvB63xbUT/Qtdy3hr1XzdXku5elvBqnMXKTiGVA3KcSNW0jaXvtaqTTDLniiEtDjcCQFb2HSyD32OGn/BMFs0l9tP+UjvHgL2b5j+7cpjA5erR1sq9hCJ66UJUyhFEIF923loHRbpi1x+kseWmwCW3SBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4NiZfJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4NiZfJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518DE1F00893;
	Mon, 28 Sep 2026 05:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575105;
	bh=5ugrgHl0wQpLTtFv+JuqK22lnYam1JrjJy0YTiZN+P8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j4NiZfJxK1MXh7SJj0gC8S8gzQAyAE4DfNUV88kvC4bb0EjYC2mDrrFUmxWGR84AN
	 mOYNP//3pjjtlwiD616L2B7tBdG8RYKc/ih0utzY9fGwELt7zu5e+H1nGbTYASQ15u
	 d+ykYnwiVWfUKYm1zaapJNrrsOXKPKBANs6hqO92M42OoHpnKolRbX65JqZq7IJyGd
	 /NL94XY8gZ+bMGvh7q0kqbtpr985vsReyJLelfXYieaaOGyI/Il6Fhs6tjED6lmIPl
	 o4HvELmFuDwJO1d33jN5bF+Rjyz5+5dwmxuwWvlLAlCQpqje8QYq/UDphzXF7NuZgG
	 NzgOyq1ym2xCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf intel-tpebs: Stop record process before deleting
 the last entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenxin Fu" <fuwenxin@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179057437287.652774.7332965203936908557@t50b09067.sqa.eu95>
References: <179057437287.652774.7332965203936908557@t50b09067.sqa.eu95>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:58:24 +0000
Message-Id: <20260928055825.518DE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: tpebs reader thread aborts when closing multiple events
--

commit d4a909ca7f9c0a17dd3c8d1e6eee06c407ecc815
Author: Wenxin Fu <fuwenxin@linux.alibaba.com>
perf intel-tpebs: Stop record process before deleting the last entry

This commit modifies the teardown of TPEBS events to stop the record process
before deleting the list entry. The goal is to allow the background reader
thread to drain the remaining samples without failing to find the deleted
event.

> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index b41171b5df77d..e7a0118bc5e42 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -711,11 +711,15 @@ void evsel__tpebs_close(struct evsel *evsel)
>  	mutex_lock(tpebs_mtx_get());
>  	t =3D tpebs_retire_lat__find(evsel);
>  	if (t) {
> +		/*
> +		 * Stop while the entry is still visible so the reader thread can
> +		 * drain samples flushed after STOP; otherwise it aborts the
> +		 * session and closes the pipe, killing perf record with SIGPIPE.
> +		 */
> +		if (list_is_last(&t->nd, &tpebs_results))
> +			tpebs_stop();
>  		list_del_init(&t->nd);
>  		tpebs_retire_lat__delete(t);

[Severity: Medium]
Will this abort the session if there are multiple TPEBS events?

If there are multiple events in tpebs_results, evsel__tpebs_close() is call=
ed
sequentially for each event. The list_is_last() macro only evaluates to true
for the tail element of the list.

If a non-tail event is closed, list_is_last() is false, so tpebs_stop() is
skipped and the event is immediately deleted from the list. The reader thre=
ad
remains running.

If the running reader thread processes a sample for the deleted event, it w=
ill
fail in process_sample_event() when tpebs_retire_lat__find() returns NULL:

tools/perf/util/intel-tpebs.c:process_sample_event() {
    ...
	t =3D tpebs_retire_lat__find(sample->evsel);
	if (!t) {
		mutex_unlock(tpebs_mtx_get());
		return -EINVAL;
	}
    ...
}

Returning -EINVAL here aborts the entire session.

Since tpebs_stop() already protects against being called multiple times, wo=
uld
it be safer to call tpebs_stop() unconditionally before deleting any entry?
This would ensure the reader thread is completely stopped before any event =
is
removed from the list.

> -
> -		if (list_empty(&tpebs_results))
> -			tpebs_stop();
>  	}
>  	mutex_unlock(tpebs_mtx_get());
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179057437287.652774=
.7332965203936908557@t50b09067.sqa.eu95?part=3D1
