Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707464;
	b=WEIHrZrrPYUimla1TOXbUNhINPrNCc/KApZL0BUIJlT0GXIx8N5E8A1TUVwAfkecrvLB
	 sBguDu3D6F1OgwJbCfAq4xJnuWSL5R08aYXg4IL/yhVZDhmVym8mPiDJkG/2p/mT7hYLr
	 yeanbBEM/GESD9v/rpalBXga/a9oxHL5ZtxNXzm1IwSAax5+4yT+J2UzkTlXLUZ4D+7gn
	 zfAhEE4Cm5cRV9OWF8CAgTsU8i+m94y+9KjkJ8C7LYvr9f1+56vI6C4pggwb7CisHfc5o
	 BIm/mNIzM1OaTLq9PlIzfYt4L+GgYUUcPfBCJwhs7nETH2jlRlK37V3/jUL2pN0QvPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707464;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cfZzyLvJnl6UWMFbEE6DoHZ9osZ0WviajBuqWlPFKmo=;
	b=Hw8Ei48q1/GKWzI/b09WgkPO9rSP1uMmKg2+WjaYLuPtGugchC7miRYJhJlqeGdga2pQ
	 UX1cEi+7dD0u9+pbndPAwDhGCc0a8/Jjjz4HFMilKIoSpPz2HjN/CgeHm8/poP+IPj6LG
	 AErBnCPpOcOsG+Ntj8KCxSLntA4wRICw+iEEO8+Suip7uE2sxJkvsaZBbhUlAVFircT4v
	 YX1B9YnHu+t1wmczWeUqGkoNO4lk4A57yEkgQCd+z/0/Ap/hTqoyqPEap2Jg2q2Wi5plD
	 cwIAi/bk2LPt7dy0VdZR83N00W+qnrv+QB5Q7pVwibWvKhFE0Eo4aHd1vOXtTkSGBAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V57e+6CX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AA606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V57e+6CX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A6C1F000C4;
	Sun, 15 Nov 2026 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707464;
	bh=cfZzyLvJnl6UWMFbEE6DoHZ9osZ0WviajBuqWlPFKmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V57e+6CXixXL8APASkCg2ng6VDPIetSeWIoCl64GgSR0X1kJowyedFir10t7VcoTe
	 g9PJOdN1YyJk2FqSH0KWB4TQ24X+HzmqoxJTQ1BNI7Wc/Ar3ECBArPjW2Q808/giSD
	 AReUW4rDnwI4tHezvhkFF4xcuSUF5CM1yxOrzBVuaTmE/MD2jH7XX0DMCKBwWZrTkn
	 NOdq+6lgrOdLjjssNkAjbQrcak84/mPBdiM1ifwfIceTSUCpSsfZ2QL+ImGe7K7egk
	 kV/3Y65FWdpIkNX6ef4pVN89rXXNY0e09La0kSr7LjAQA+somQ7PcH1v1D9HdqAzMs
	 QuFn5yS5grDzw==
Message-ID: <sashiko-outbox-215174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/12] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-2-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:51:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Build perf with clang source based coverage, run the complete perf test
> suite, merge the raw profiles and report line and function coverage for
> perf, optionally against a baseline.  This is pahole's
> coverage/coverage.sh + coverage-diff.sh merged into one script, wired as
> 'make -C tools/perf coverage' and listed in 'make help'.
>=20
> Without -f the report lists the files with the most uncovered lines,
> which is where new tests should try to get more coverage; -t narrows
> the tests, -f focuses on specific files, --html writes a browsable
> report and --table/-T, also available as 'make -C tools/perf
> coverage-table', prints the last run as an ASCII table with the
> per-file line and function coverage, like pahole's coverage_table.py.
>=20
> The build can be split from the test run: 'make -C tools/perf
> coverage-prep' builds the instrumented perf and records the build
> [ ... ]
>=20
> The run above was unprivileged, so tests that need root are skipped or
> fail; the report still points at the gaps.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D1

