Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606965;
	b=rqnNSvqHZ5fy33lA2uHQ0WIQ3LtQwaBLZiNOS6NjaN7gmDoW6F87zhJ7BvqQACrSwtj0
	 oJmmQ39IZJI1K5RP2SEV6XQW47QlvapqSZkcfOs0wERWHysjYeLan1QIP4gNAx77ezrPC
	 NKDEJ9F0ehORygJ8bhy+I5fmccHxRl2Xxvow0h5I6BWbD9KIrOOE2oiLezT0OqX11WeLx
	 bh6OlWt2RShxO1SaYonlPHhCVUrsXoejEOQywPVK7m9VoGh1DUEwWz0GuUB3lnNMjYgD+
	 Gnm5SVClcuXNx1XgFRP319fN973TnoB8Tgz2wAfW+80AswegXoOHHnAQUBUpAkiagfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W1R3CGx4eXhV3KCnp5e0y7w4I5vC5ZPQ7+s+PjDoWFs=;
	b=bPHVfs2hbUyexy/q406UbYbV3K7VNVx/x1y86i15X4NoZaQyJ/WE+OnbFuQ6bReu5mNO
	 xhAD1p+ukyPO0UJnLJfz/zFF+3zUVlg9PZjVWaffzKohxmYPZUeCtjJpaQ+ugW7Bqe8D1
	 cbfCOE62hdhUUlMCorsnYX1LOkRuGN5e+sOAgjAR7wbZQGZpzwxII0FnBcexad1ZTX3Ht
	 TUI/jDkpbKIH6N/sGGfyGukDf6CJp7xwiSVpQm0Tbf0lm+gPKL1BJUjTbEbiuPmBMl8TQ
	 NTxu7WwOoaih8QUfkUSv/GCuQbLVxHXLzFs5E9eXx4a+ZCVxyjXVxy4CBK0vWnd6s1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsNXucu7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA3606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JsNXucu7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0373B1F000C4;
	Fri, 13 Nov 2026 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606965;
	bh=W1R3CGx4eXhV3KCnp5e0y7w4I5vC5ZPQ7+s+PjDoWFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsNXucu7th4LRAAhB9UQyievn33WHs8bwivnHtoyeKsXeDSBlJZieYTUy0PEdtJPa
	 DWO126cR374gBkUDINk75+BSCARJB+PuZvDYRseJGjz89qUSyifvZ7/m3VRfYQG/tL
	 KAsAiAGY6Gn/0kCiF8hWW9cm5CuF4c4oOlQUVhYjVjEG87kWQBN2eDPFRJGbRxOr2e
	 sBkJL9C94/SrtZI0XeIjO2A6IqZj+LhfbxQhPFVT25pMihmHDb/3/kxD6E7BQcwJwg
	 vm+/Q41sx7+J39XENtvLkC+6i1mjYJEuTBMXu2Vbb3/RS6lsZGw8Fk+e6l5SlGZrBy
	 Bdblpf9nxNL6g==
Message-ID: <sashiko-outbox-213747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/26] perf threads: Fix uninitialized pointer put
 when thread removal misses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-2-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:56:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf tools: TOCTOU race in threads__find() [1]
--

commit dc3a93695be3841c2b7a294d1207451c21b43854
Author: Ian Rogers <irogers@google.com>

perf threads: Fix uninitialized pointer put when thread removal misses

This commit initializes old_value to NULL and checks the return value of
hashmap__delete() before calling thread__put() in threads__remove() and
threads__remove_all_threads().

> diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
> index 6ca0b178fb6c3..98cf7edaf7480 100644
> --- a/tools/perf/util/threads.c
> +++ b/tools/perf/util/threads.c

[ ... ]

> @@ -154,14 +154,14 @@ void threads__remove_all_threads(struct threads *th=
reads)
>  void threads__remove(struct threads *threads, struct thread *thread)
>  {
>  	struct threads_table_entry *table  =3D threads__table(threads, thread__=
tid(thread));
> -	struct thread *old_value;
> +	struct thread *old_value =3D NULL;
> =20
>  	down_write(&table->lock);
>  	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
>  		__threads_table_entry__set_last_match(table, NULL);
> =20
> -	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=3D*/NULL,=
 &old_value);
> -	thread__put(old_value);
> +	if (hashmap__delete(&table->shard, thread__tid(thread), /*old_key=3D*/N=
ULL, &old_value))
> +		thread__put(old_value);
>  	up_write(&table->lock);
>  }

[Severity: Medium]
This problem wasn't introduced by this patch, but can a concurrent
threads__find() race with threads__remove() [1] and resurrect a
removed thread in table->last_match?

threads__find() looks up the thread under down_read(&table->lock), drops
the read lock, and then acquires down_write(&table->lock) inside
threads_table_entry__set_last_match() to update the cache:

tools/perf/util/threads.c:threads__find() {
    ...
	down_read(&table->lock);
	res =3D __threads_table_entry__get_last_match(table, tid);
	if (!res) {
		if (hashmap__find(&table->shard, tid, &res))
			res =3D thread__get(res);
	}
	up_read(&table->lock);
	if (res)
		threads_table_entry__set_last_match(table, res);
	return res;
}

If threads__remove() runs in the window after up_read(&table->lock),
threads__find() overwrites table->last_match with the deleted thread:

CPU0                                  CPU1
threads__find()
  down_read(&table->lock)
  hashmap__find(..., &res)
  up_read(&table->lock)
                                      threads__remove()
                                        down_write(&table->lock)
                                        __threads_table_entry__set_last_mat=
ch(
                                          table, NULL)
                                        hashmap__delete(...)
                                        up_write(&table->lock)
  threads_table_entry__set_last_match()
    down_write(&table->lock)
    __threads_table_entry__set_last_match(
      table, res)  <-- resurrects removed thread in last_match

Subsequent lookups for that tid then return the removed thread from
table->last_match, causing stale event attribution and leaking the
cached reference until another lookup evicts it.

[1] https://sashiko.dev/#/bug/linux-4e27d490-a049-4f85-8e0b-b969e5b6a6bc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D1
