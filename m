Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D338945D;
	Wed,  9 Sep 2026 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986764; cv=none; b=gVN2TvZooKB8aBru5VqshLCR+grW40XbJinC+QQ3H1kJ+zabfyyA4OhVOpzlbWoAU49rafcMhvDRiAA4mOk8U2LDGXrDiEpDx8XU6HAcUffzz6wlN+p3rrnf9cYamVC0SFkWaVLle/AOXuiSv8ZSgNIjFiBj8F5Y4rOj5rcqoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986764; c=relaxed/simple;
	bh=8jFl1+dXklLUJ2hW6bDkW0h4Sy8m0EnMHvIOBN4Ql5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gmroninoWGO6QC3qnZ/czs3jSZkIsX/BSSiiCJtqOK2a/1fJ7DXm9RFWOYOVvthbs8eEf3ivjE0bY4v9RdgijCVC0vbDpctzbyJiqygqSfTb3qGVQ87URPeVFQ2wgeVyYHJ3NWtK6IKWjE57o7/4HlzGtXah2M94OwjTxwGNPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An5zeqxG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An5zeqxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFA1F000FF;
	Wed,  9 Sep 2026 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986749;
	bh=8jFl1+dXklLUJ2hW6bDkW0h4Sy8m0EnMHvIOBN4Ql5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=An5zeqxGnEfA9MV3OeNnnJggbF+h1UQnnAl51/glU4q56Kb7tisrssk/G11lfJn3g
	 CTwAVhFAiLnzfECKHpwaTK8I/M3oNoCEOatve1EypCdwgkCXrth1NKieyhG9Lx4O9B
	 3ELelaIdRXLpWAn98qyQOs51adD0xqibJsoDy8jQYojcyjXbQ0/QqH/r5wFcRsAY9Z
	 jaxErcYv20+233E0FiHrCVkv4XK692/V6J8o2Ma9w6d/HNUrdYA3ELc1ooIUHGL0B9
	 aBy6CWkaEPfCrJu6C1j8XhoRb/MMCBWJb0IQqRnVSqYotZiu+gy//iexuX+CV7Rxgy
	 YZEWGfTlWgWMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] objtool: Add explicitly sequenced -lzstd to
 libopcodes fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260909204122.1993010-5-irogers@google.com>
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 20:45:48 +0000
Message-Id: <20260909204548.B5DFA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Distributions like Fedora currently ship a statically compiled binutils
> libbfd (an intrinsic dependency of libopcodes) that internally utilizes
> zstd to decompress sections.
>=20
> Because objtool resolves host dependencies sequentially via a manual HOST=
CC
> shell loop, build failures will occur (e.g. undefined reference to
> 'ZSTD_decompress') unless the loop probes for it.
>=20
> Add the '-lopcodes -lbfd -liberty -lz -lzstd' combination to the fallback
> chain, assuring successful compilation on hosts packaging static binutils.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909204122.1993=
010-1-irogers@google.com?part=3D4

