Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26869515898
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931015; cv=none; b=EefQPa8Libt9reifInKrdaJm3YvMot3opxbV/v5Xh/HTILVnhifM8BLAsx6a5juFdFknEo/l0omkJH/8MYLs2eO/18lGZJrsaGPdmAko25+o2dlBU7TqBBsiEEO/PbbPIxzZZpI4ecjp6XMhrHf1WAT5cfjzkt/eXmucTWm62EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931015; c=relaxed/simple;
	bh=sh5y7NpNzu/I2uPH8AAQW0L/eJd70ckokaWDuw5H9gA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bcdvY10bNAU4E0T6pfrznIHK6D+mXQrLHjeGtFPM2Q1EtTokvR+rM9ieXlhdQHJXGx8tQZJ2PCfH54MvJGPydp3CPgLXNbH93aAXKdTmF4eCui9fWeUJQmjmiwKZ8/U+U5TuCIIrhHfdUK7otCw16yXNysJ/tC1yZ7QlP1qFK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRTwEVbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRTwEVbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4CD1F000FF;
	Tue, 13 Oct 2026 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931014;
	bh=sh5y7NpNzu/I2uPH8AAQW0L/eJd70ckokaWDuw5H9gA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRTwEVbE0B4D+dZoBtFRnGsn2Wmgd95paRfaR/JsGHDRqx88fbSnxA9/BFUP+srrN
	 Hobfsw9BXuAGdFZ+zRRiliVewoLIA0yHzyi8ujyXw40UWoEpZDpfVmFkdGXg2OQT8T
	 9vxmWF2hxCcO4JCsFmIXW2NCSd7ZZAAlfpnxlhNv/fEOH1VBbnPQey4ugj8i7lP0CG
	 gqXjUD6IdGlf3Xhg1829QU1Q2M5ZWrMpDfq5OFaIh22ssDCg13YxR8DaGJhT+xlM00
	 YqBK0LwztYeQpabm1ymxZ6QGedIOXLqt+zcYawwBCn4U0nxEyP3aZcVrPKH+Rx97FC
	 sjDvt4GE9YsKA==
Message-ID: <sashiko-outbox-170584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-9-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:36:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D8

