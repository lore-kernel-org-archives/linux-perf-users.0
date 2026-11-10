Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350054;
	b=n9z3fIy/lwPm9QQfWPrjmCdsn8qaYOebfLwKaq5iiG3gCZVx4Q3dHi5sTNxxkgEIj6pO
	 FZlv2jLAgPBRNMwvxc8sPCZc88DWG5BajVeVbVaBwuiSZGlkl2Fb+16P6DuKaoEpo2pjG
	 BMfkezTIkPx7IGxCS9jykTK7TOL/8604dMJ6BPc/pkrdJYEpnsJbsnoIjr4MeuRQHfl3s
	 c3Dh+95TS9fBmTaBaSQs/TW3lp3TWY4gUQsqDPnpkEEMt6hNwMMtNDg6s9AXpc+to9+de
	 m93ZtuqF+rBob1Y+cRpLSMI+iQR2lB2vt4xVitlhcDDhURaeCMKSj0VfnTGkLR01QhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350054;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lvjPG9A1wGmaOaIj5kjOGXvD22YyctHTMgDh2EJK0mc=;
	b=soWFYUQ5pf+HrLvcUpKr7qcO45CKbe8rENFtuD6Cs9R504r/B9hYRJtNyJyZgYkhsdez
	 3swCe4qMcN9Y8sO36ASTlFvmb28J2cIFIT7QDu0oIvO5c0J2lKzXBUKc5Zsn4NNg0DND3
	 62sORw3ki1+XQmN7WyLAj+rAxEXEPAlEq9zhErobK7310lXMELrRIMZ4jVX6/ZAgwKimc
	 ZE+Kvr5emkbnIHrCb123PTu9ZXjkC6jYrwQg3NTcVM24RD8UrNLddoCdeeJ3SSQa8VQPO
	 o+01cfSmgtcQPOCRDIQ0lKYw2jb5o2XUF+wO6Of4BmzXbz0uc2tWJabpjbGIbTIa9+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvgsMehe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FA606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvgsMehe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D441F008A2;
	Tue, 10 Nov 2026 22:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350053;
	bh=lvjPG9A1wGmaOaIj5kjOGXvD22YyctHTMgDh2EJK0mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvgsMeheoGZZOrYhKt3eQYBvYyN+h8FLeTsi9NM7xqQ63+7BWOhqn8MGPAszFIZc0
	 MH/iyNAwSgw0eicyBANjYwJ2b4+YIFx4gCJ2mJlea2ILQlZ77B8NDU2enz4BtHvWeW
	 qvllIKDMAAIRyJdMjO++iuYUUKIn+6OtdP1qM4V2aQ/2oWq+RO2NOfJnRer0Or156e
	 mmfY7KHxE+gGDvh/v2eIn2z8nqaWLWrOesegWTqJAgWerQPe44wV6qpLCywC1dY/aD
	 +Jj86sx+MqT9dlJH1o97ERz9tAWR2b5K6a87gwMDDDXhWJLYaWmqP2LTRuV+cNDlyR
	 BqY1Nc9fjtKBA==
Message-ID: <sashiko-outbox-207833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/20] perf symbol: Optimize symbol sorting with
 natural-run merge sort and binary insertion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-17-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:34:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ELF .symtab and .dynsym sections are typically already mostly ordered by
> address in ascending runs, and dynamic symbol resolution
> (dso__insert_symbol()) frequently inserts one or a few symbols into an
> already-sorted DSO symbol table. Invoking full-array qsort() on every
> sort after incremental insertions or across pre-ordered ELF runs spends
> avoidable CPU time in symbol comparisons.
>=20
> Speed up symbol array sorting and out-of-order symbol insertions:
>=20
> - Track the sorted prefix length (@sorted_cnt) in struct symbols and
>   replace full-array qsort() with a natural-run merge sort
>   (symbols__sort_range_with_tmp()) and galloping binary-search merge
>   (symbols__merge_runs()), plus an O(N) in-place binary insertion fast
>   path when <=3D 8 symbols are appended.
> - Insert directly into sorted position in dso__insert_symbol() when
>   symbols->sorted is true so dynamic single-symbol insertions maintain
>   the sorted invariant without triggering full re-sorts.
>=20
> Using 'perf bench internals symbols':
>=20
>   Before:
>     Average DSO load + sort: 6.242 msec (+- 0.057 msec)
>     Average bulk insert + lookup: 1404.150 usec (+- 18.752 usec)
>     Average append + lookup: 40429.750 usec (+- 507.578 usec)
>   After (-7.0% load, -13.9% bulk, -99.6% append):
>     Average DSO load + sort: 5.808 msec (+- 0.047 msec)
>     Average bulk insert + lookup: 1209.250 usec (+- 18.446 usec)
>     Average append + lookup: 152.900 usec (+- 0.736 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D16

