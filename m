Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B051379C34
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882245; cv=none; b=YInb/uZxbFyOzmxORJxa5EuSOlSFbq0E/xEW66N5IzJtaUwwyvwwwcod8HlPLIJjWRb1mJPT6yI7emkGNhHzoAgQFWWgJ0qXYFmKCB7yspqFqjSCgDFuItN2z0elldlEsIV8G0kJCb8cdA0MIZTABZ3s0hRA2LLItb8J1xJI6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882245; c=relaxed/simple;
	bh=+VZq9tPEZSrRmGkBjU5IIbWEt6jKcyYqQSWekWVWkcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GyPYVlPglGswhYw0ejXh/2HheJdNvsSQJiQ55NuuAuoFAJ6jsILT122CxDA+d3Irt1HVyaDwoYTdjxomiSAWVifpg8lNiljD724izo5dk1EuXwTcZwBE37IqKvpUNdu041M0DGgKxq9aspYC9EmgAy+6KXf5zYporwE0yEtzFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ8dKbET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ8dKbET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0801F000FF;
	Sun, 20 Sep 2026 05:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882242;
	bh=p/RjcYi+yGAdtleC3MdPm22VanLK5MXdU+Y/NH0ABcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ8dKbETbGyyDwnSnpMpuLm6PZShCGHXClQgcaQHrLuG8GRAS/uHeEYnJRYNl8YP9
	 bGamc+IxmSyxEKohgZplmDVt58JaqSz/DdQ7SpFTJL99N6aPLG+c5HJnWeaBIjHg6M
	 hApbD27ud7jySGqmYBN3TneH62aqwF0+o4+q9EjHxKSCCpYZ9l+pV2W3dERpty1yM7
	 AGdfLqc+Suvyshzo6qzvEuO00cznVKNJQ9tTGtnWuW+6+lH+NeuE6LSBBMyDy3F8rS
	 l04IMSRcsesKb8K+GUOCfbs0eQIWFyIwba0wG38qn4ekb/2NwFk0ZbOM7nE/unn1Gj
	 rIuMutjo49bBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 18/49] perf python: Port stackcollapse to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179539c02f8b44ab0ccdad1b686f22577172bcc3.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <179539c02f8b44ab0ccdad1b686f22577172bcc3.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:30:42 +0000
Message-Id: <20260920053042.9C0801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port stackcollapse.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/ refactored into a StackCollapseAnalyzer
> class.
>=20
> Improvements compared to the legacy script:
> - Traverse sample.callchain directly from perf.session without
>   allocating per-event dictionaries, and fall back to sample.symbol when
>   a sample has no callchain.
> - Replace deprecated optparse with argparse, adding -i/--input alongside
>   --include-tid, --include-pid, --no-comm, --tidy-java, and --kernel.
> - Handle BrokenPipeError cleanly when output is piped into downstream
>   tools (such as head or flamegraph.pl).
>=20
> Add a shell test (test_stackcollapse_python.sh) using a CPU workload
> (perf test -w noploop) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D18

