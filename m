Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD642E42E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663680; cv=none; b=G5JNiBAMx/8dU4s6NHNK1XAdXD8iEpDcZBnVwKbzMv0KyLIdu9Z38GVGQcQgGZfZ9HITrGUkbrHoGv4lx9Nq//WXBUNZXVt8kluqNLS1gFtkNVi7HQBF85vhOVNa+8pYU7YUYENS+Md8tKNnTJtgoyMWIYTTDluphi8zLeehU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663680; c=relaxed/simple;
	bh=5Tj0HwjMRSNd/B0/8fGElyHm9jo/js9tvcAxplM1J04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhUEjfH5K9RrADoJp6oK1PEULyor6niovy1lbQtvVAwFKoB0sUC6yP3yGjsQOYvdFv0c2RwzNcA6413dAGj3ZgvGOy8FGRM+Ct8ZDSfHvONp6t13DFcf5cI/dC6aH3JpDBjN0V/LvZAJMXkR2j9RKjo9Li2CpjJFNJPdrE8IRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=earqooro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="earqooro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C431D1F00898;
	Tue, 29 Sep 2026 06:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663678;
	bh=5Tj0HwjMRSNd/B0/8fGElyHm9jo/js9tvcAxplM1J04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=earqooroEQWL1K9pcWcHiheMpaRifWdkcAHL4jdOZZ2W4+zki/n57VSLqXii1/6kX
	 V5bXsjwbJsHwYJLeH9EOMfNKZY9P7/lk3jTHC6icfK+9LuKeIQXxWqnV4tQohCEMMZ
	 7MjXYptNS3HgMYS0Wpkwfx5VTx5nW+BiA9MjA4Jh7xQWZMpNRs+KSEh88eyOTeRHqR
	 JXF9o26o9pDqWmQgUPbAseGOFKOvm2S7AbBmofYWCZTuRgStiWQl4+iApzD73V82Wa
	 Rf8ZkB+Btg0HlUmV0vN/WcBsxPNZvZjN83UCe5L1nkaOVkdW5LonEeSaj8wTLrJQpg
	 iUKhWuSQFHwuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf test: Deflake failed-syscalls Python shell
 tests under load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-6-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:34:38 +0000
Message-Id: <20260929063438.C431D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When running 'perf test' in parallel under heavy system load, a one-shot
> 'perf record -e ... -- ls /does_not_exist' without '-B -N --no-bpf-event'
> can exit in under 300 microseconds before 'ls's PERF_RECORD_COMM and
> ENOENT sys_exit events are captured, while also contending on ~/.debug
> build-id caching and BPF event synthesis.
>=20
> Pass '-B -N --no-bpf-event' to 'perf record', sleep 0.05s in a subshell
> after 'ls' so its events are flushed before the parent subshell exits,
> and wrap the record and check steps in a bounded retry loop (up to 5
> attempts).
>=20
> Fixes: b76c43d09b06 ("perf python: Port failed-syscalls-by-pid to perf mo=
dule")
> Fixes: 4e3fe6987cba ("perf python: Port failed-syscalls from Perl to perf=
 module")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D5

