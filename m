Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717241E9B1A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648691; cv=none; b=mnUCPeCBDslalheJwn1lOmdLqgdIu14cWBh9EM/WFVApklaPi+Y75kGZQixRZnwCLuzTHnPYgSW6ZwnCH+Qb4DXHyPCauYe33hGideBGDm1qxZ30jb721zGH4KY8sX39kt7fsjfZokwrIhmrBkwAWYGZS7qzZ1GBsdcXMpg0O7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648691; c=relaxed/simple;
	bh=Rzf21babHJo6+aGHexSX5NBDkMkLe3fQH9zsLXSGbXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpM+Nk5vxDfqsCikklRe03/bkwUUhZtmT0YwYKqPAX6k9bNvsZpQhews6oNZAmAU74y6wmFqRMEhqMe7cc9Y02XU9k6nfGRdV3R3YruB2TCFKLbwvFoSBYPjKcKf4dyVkeo9BCNsOcM4BZVd3MwaDrUzj8GE3rYJn2DofVRDHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeMfAAF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeMfAAF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F41E1F000FF;
	Tue, 29 Sep 2026 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648690;
	bh=Rzf21babHJo6+aGHexSX5NBDkMkLe3fQH9zsLXSGbXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeMfAAF7Yar6BO2CVxKp3Yp302opom9lcsJZBrINbOnjNpOJILN41bttc4TqOQQQj
	 1o2IEJ4b+0SQD6hY4qDhgKEqqKcWoeWSt1EbBKy53obLe+rHdqQemxz9GjHn7G1cjW
	 aWL0HsCg1cFMbKxoCJ9QGNhBlMBLqMcYRuXEJLMGYcbT1vdCifqhZQxkiSFq7ElxYs
	 qZaPwnBU50eznFOFZx0srjE61R1iUSTax7MNoElBCNK7kEKuAaAVZZK1KAXO/UuSxD
	 GkYAz8If80lxukaQ2lygLfr7DHTyTUVp80J6Zquyc7eu4cpiCdIAJxW8YJBeRB6EA2
	 TiK+siFQy4lSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/9] perf python event_analyzing_sample: Default to
 in-memory SQLite database
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-8-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:24:49 +0000
Message-Id: <20260929022450.1F41E1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D7

