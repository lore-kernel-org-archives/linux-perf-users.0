Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D953B0AD3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686431; cv=none; b=t+KXuZaGYM8fTuCx3/RaTHcbnu+ncWeMHS4otFE+cX5o21Kctf8mjb+fHA5w6uDDi1pCeqHlWZ/JMTIiXV5mvTN+y/U8k60GfzjcgJUWic7Q8J406xZKSztLfX0p5vGdyrjF2lWj8vrH/5sboKmFVXFsF5g5ZOO9HGpIdSRVfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686431; c=relaxed/simple;
	bh=8iRnGuRGTb6iTSQLYxtwJrevKRMyBKlTNObxwRgyDgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3LNx1SSQ18a6KULdHna5nikJAQW6pAUZFzOkGuYM2D8gLU+/T6IOzvhKdxqLWzeje4ybObKZsjaXzJ6tzk/chAlBQX9jh197W85lWVe1TgtefXqitYN49SELlT+LqGUUclmgZVvhUctP/0mtkcRvMjhTG7D0biMfGZrbCbNxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Er2PSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Er2PSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC811F00893;
	Fri,  5 Jun 2026 19:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780686429;
	bh=rPVAR2J34XdZ7+c45TpIE/DzQ+l2/v7xycIbh9/1WVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9Er2PSN3x7OAccnqGHAsaKw7K7Mka7hVAfNcvvbANJph8M7mV1jD8LSPjo3vaKKa
	 0k5MtxT9VlbL6lJcRDC0yjHj3A6jKi4MWx/SPrvz0GJT0YNDr+3jTbe6X3cEhd9157
	 OxOPjSKBRMoPcjrok7iHdTn1i1QGLmm6zq6t4aBDHdxs5Vi7c+Cxiv6OCg0VhtnOUM
	 AP10ADaWzNx01WqtT6Up87KaTfP0iN71hvbAniInwRBiMB835TQklCK5f5iGqt5O6L
	 fdnsBlUYfPmEwCfmJ3xddTQAjkBeMMhwfEhVu+6+xIElzNQMJS9+hYvqme+AokXAoH
	 AqghHXOHU46mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605185215.2359881-3-irogers@google.com>
References: <20260605185215.2359881-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:07:09 +0000
Message-Id: <20260605190709.BCC811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `remap_addresses__hash` hashes the RC pointer handle for `dso` dir=
ectly, breaking hashmap lookups when `REFCNT_CHECKING` is enabled.
--

commit 4e905ffc55cc982a92f6bbc5744803fa9093aab4
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

This patch adds an --aslr option to perf inject that remaps virtual
addresses to prevent ASLR leaks when transferring perf.data files. It
introduces the core remapping infrastructure and implements tracking for
metadata events.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..375a0355f2812
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static size_t remap_addresses__hash(long _key, void *ctx __maybe_unused)
> +{
> +	struct remap_addresses_key *key =3D (struct remap_addresses_key *)_key;
> +
> +	return (size_t)key->machine ^ (size_t)key->dso ^ key->invariant ^ key->=
pid;

[Severity: High]
Will this hash function work correctly when REFCNT_CHECKING is enabled?

The struct dso is reference-counted. Under REFCNT_CHECKING (such as when
built with ASAN/LSAN), dso__get() allocates and returns a completely new
pointer handle.

Because the pointer handle itself is hashed here rather than the underlying
object, two handles pointing to the same dso will hash to different buckets.

Since aslr_tool__findnew_mapping() acquires a new reference via dso__get()
before insertion, hashmap__find() will systematically fail to locate
previously inserted keys. This breaks the ASLR remapping lookup and causes
memory leaks.

Should this resolve the underlying pointer before hashing, for example by
using RC_CHK_ACCESS(key->dso) or similar?

> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605185215.2359=
881-1-irogers@google.com?part=3D2
