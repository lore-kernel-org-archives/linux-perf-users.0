Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49709239E9B
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188915; cv=none; b=Z6Q4fmxeuDUF9F+GTgbo1e2COIFss1cu2df/ItVKm5UaCLgbiJW7YGhce7F4yPZ5X0PbaDViueYWf7PpUK9KTvLQVn0xhOWOKtlOMgzC4G3/w9KDuSYXPFnSJwyUsi2l3k3F4DkZw96CH+51RhWP9VQcOHGXKgVtDkLIS/MHYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188915; c=relaxed/simple;
	bh=5YsjBQy/YezBVj0BFOzvGjh9f8k/fvVFmNhk6i9EceA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iJ9K0EeMSo7+s5yzeVkAMufemktUiMLYfluxRa+MCTHkqwkfFAu6c0brBmBBp8BJc/4hWvZyFo7OchanB3CjU3Py+yEKuj20Xb3Y5368c6k2sRNPkfxe+4y3EsCsci44bcQqFpj1HMolD2ji8QYe17n5lHOyBmZrFxRmSNy/3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxYfFZmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxYfFZmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC064C2BCB2;
	Thu,  7 May 2026 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188914;
	bh=5YsjBQy/YezBVj0BFOzvGjh9f8k/fvVFmNhk6i9EceA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bxYfFZmgHW+DAwFhTa1trvp52TysAPtyHZHXtyhdN2TJZIGfy8MLXEM7fcbCXEweD
	 8+4k9OLz506XBG+/CROUH/eYzjMA5LNWLA+QV8T6yFgZ4geqmqWdM1aTNGGru0Ajle
	 EvFIkaG2g1FQdD53AaJCshoqjShqSa7sEnVUtDLokCNK0xyIalAprvN0+e74D5JP8n
	 GwRYCtjd4U3gRYuZFQSzvSdaWrRl+UGtQQI5ed0AyArNKYh9WcJz6fiiXz3xoTONpX
	 8Hxw/6m1dU5BcWdiQfEUC3NRGVLhi1+0kTK4tlgHcw5iD/509hTBHj4qWQX4wFbtFC
	 J4Rj7oG750+Pg==
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH v2 4/7] perf-x86: iostat: Change iostat_prefix() to
 static
Reply-To: sashiko@lists.linux.dev
To: "Yushan Wang" <wangyushan12@huawei.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507063737.3542950-5-wangyushan12@huawei.com>
References: <20260507063737.3542950-5-wangyushan12@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 21:21:54 +0000
Message-Id: <20260507212154.BC064C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Reassignment of `evlist` pointer passed by value in `iostat_pr=
epare` leaves caller with a freed pointer.
- [High] Missing cast for time_t in sprintf leading to argument misalignmen=
t and potential segfault.
--

commit 8f78117186fde5ac8fb2f432eade998540fdbd61
Author: Yushan Wang <wangyushan12@huawei.com>

perf-x86: iostat: Change iostat_prefix() to static

This commit changes iostat_prefix() to a static function since it is not
used outside of the local file.

> diff --git a/tools/perf/util/x86-iostat.c b/tools/perf/util/x86-iostat.c
> index 7442a2cd87eda..f8d4c97185949 100644
> --- a/tools/perf/util/x86-iostat.c
> +++ b/tools/perf/util/x86-iostat.c

[ ... ]

> @@ -332,6 +332,28 @@ static int iostat_event_group(struct evlist *evl,
>  	return ret;
>  }
> =20
> +static void iostat_prefix(struct evlist *evlist,
> +			  struct perf_stat_config *config,
> +			  char *prefix, struct timespec *ts)
> +{
> +	struct iio_root_port *rp =3D evlist->selected->priv;
> +
> +	if (rp) {
> +		/*
> +		 * TODO: This is the incorrect format in JSON mode.
> +		 *       See prepare_timestamp()
> +		 */
> +		if (ts)
> +			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
> +				ts->tv_sec, ts->tv_nsec,
> +				config->csv_sep, rp->domain, rp->bus,
> +				config->csv_sep);

Does this format specifier cause a segmentation fault on 32-bit systems with
64-bit time support?

When _TIME_BITS=3D64 is used on a 32-bit system, time_t becomes 64-bit=20
(8 bytes), but unsigned long remains 32-bit (4 bytes).

Because sprintf() is a variadic function, passing the 64-bit ts->tv_sec tak=
es
two 32-bit slots on the stack. The %6lu specifier reads the first 4 bytes,
%09lu reads the upper half of tv_sec, and the %s specifier reads ts->tv_nsec
as a pointer.

Dereferencing that integer as a string pointer would crash.

> +		else
> +			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
> +				config->csv_sep);
> +	}
> +}
> +
>  int iostat_prepare(struct evlist *evlist, struct perf_stat_config *confi=
g)
>  {
>  	if (evlist->core.nr_entries > 0) {

Can this pointer reassignment cause a use-after-free regression for the
caller?

Looking at iostat_prepare(), it takes evlist as a pointer passed by value.
If the core entries are greater than zero, the evlist is deleted and a new
one is allocated:

tools/perf/util/x86-iostat.c:iostat_prepare() {
    ...
    if (evlist->core.nr_entries > 0) {
        ...
        evlist__delete(evlist);
        evlist =3D evlist__new();
    ...
}

Since the evlist reassignment only modifies the local parameter variable,
the caller's pointer is left pointing to freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507063737.3542=
950-1-wangyushan12@huawei.com?part=3D4
