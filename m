Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E93955D7
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665510; cv=none; b=RqNs6XlhNZZNEzjYVq5YggOmhWzn8VYVJIWJFTld/Vma8Ys0lB4McVVnOZoc8BbnwXHlFLSLAZ6LnsCXr2f44HvX7yOvqp2l8p0rADoSQwHn0JZXMOGfBY7WwwdEKcUz+ZbfdoeXaCDcQmvPQJzQH+matrypjipRLau6NUBmu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665510; c=relaxed/simple;
	bh=XUnbNcGOULRVG31EtSZ7e2GfAPnQ78KLtXZKIo45+Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K5iCd1xdgIWWVOG15/1EqJAIc9l727BClpOIPtW/DmuIbSY5xV9YZZ6vJw+CgLzbDHuSsXBHjNaiMD+8tHcJQi49velbkTWUZUnAHE30zC6HkE7u2WUgGOn/5PNyAX1Hob7+KnlJPiKR0ef/gMYsnykpt788Cu29u0ppqI7G3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBMlDetS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBMlDetS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FE41F000FF;
	Tue, 29 Sep 2026 07:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665509;
	bh=XUnbNcGOULRVG31EtSZ7e2GfAPnQ78KLtXZKIo45+Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBMlDetSM7w3ib2cL7Nf7iywbZ1h8/vdKpn7buYV2DUNoNMU75cL8jGBBMEmU5VGp
	 EWoiliWioo+W7y2bYJt0gq4ELYT7FRjCYnnnlm9wYraa6SbkQf04vuYcsx+EZPCzyP
	 K1V06B4U0L/ufSwRV/tZJOm6kxInZP/UbU4jyozLdVKGd7hr/mBiPsxdddHYR19NuJ
	 zLu6AXXIirKIMCqFbViuokJ4EVA+jnY5jbyMeZaDW05ot1NrNUp4DBhoPuiaYOb4ai
	 Qdfo3DDmtiRxrjYFK1vcALJOP9z8n57TuSvlv8R/jDIF/ptQ5h2gkxFFcdYPxMQyij
	 FL2szVOVQ+6mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] perf python event_analyzing_sample: Default to
 in-memory SQLite database
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-8-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:05:08 +0000
Message-Id: <20260929070509.09FE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When -d/--db is not specified, event_analyzing_sample.py created a
> temporary file in /tmp via tempfile.mkstemp() and deleted it in
> trace_end(). As noted during review, creating the database in a shared
> /tmp directory does not reserve SQLite's auxiliary sidecar filenames
> (-journal or -wal), and a temporary on-disk file is unnecessary when the
> caller did not ask to persist the database.
>=20
> Default to sqlite3.connect(":memory:") when db_path is not provided,
> removing the temporary file creation and cleanup logic, and test both
> the default in-memory mode and explicit -d file mode in
> test_event_analyzing_sample_python.sh.
>=20
> Fixes: eeb70645a809 ("perf python: Port event_analyzing_sample to perf mo=
dule")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D7

