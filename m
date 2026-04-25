Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09DB36606E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140427; cv=none; b=KPf48gJI9fWWmWA3pk/XRj7YKV3EO4W7tP+7iFrSvUmcK6BCKaUidbU239/8lmBCfWxUnGf7zC7KGu0vZ9xMNpe7cvOnDU1ws/kq0tICDbyHZfhsgNqeLJEE2KOAgsA7h/GEhZaP+Zg5wNCq+fK04DvK3jetvUMnK7Hyv0k/O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140427; c=relaxed/simple;
	bh=xaAWgBFl8mSYc9LN+HF5rTPxCH7JnROUj01M/agnQw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wa564mx2oxNLQut19GJMZdIWXS/TlSVrjkQkCG8Hbu4o4ai183cZWKO1DKb9SVEL9geLtUCnb3K4olwBYtTy2IemIdy3xE4rjRvNS9DeQST9p7plaRIKNH4pwffFr4NFGi5iN+Lzc6+IvuueHPFMaiOR/pbfpPzucNvLF+B6ADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBHX45BT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBHX45BT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41213C2BCB3;
	Sat, 25 Apr 2026 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140427;
	bh=xaAWgBFl8mSYc9LN+HF5rTPxCH7JnROUj01M/agnQw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NBHX45BTm4aVpqOhYaKAaAHtDRzTQ0pE58EjnwjZstwjUeYW4iecDVIV2TNwLHCv+
	 9VGfNWx10pFak4Icd1oJyzDzr9u9WEOEqoVfZqr0I4yZCC8IP2+Dx4EnKJStumZVB6
	 D12ni6nSzUCLQqrN3spWzxaE87y96qcYPl4QwPgNivmKoHSyf9vlA0XITEEBeN0RzO
	 MZIYIaN7YU7KF1ui7b3QDwaFFxbEWeOM3WofmcKlvVWeMPGXrwEWaZCPZyPGBIXRKW
	 f5WAJtbfnCZkwxbLJdJf6XfJm5J0/hRBmWczLUmjS4mreQBzQqZYyzkXuueQmpk3uQ
	 U1ntkAPopzgpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/59] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-25-irogers@google.com>
References: <20260425174858.3922152-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:07:06 +0000
Message-Id: <20260425180707.41213C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Moving exported-sql-viewer.py breaks its dependency on libxed.py, =
resulting in a fatal ImportError.
- [High] The moved standalone Python scripts are no longer installed during=
 `make install`.
--

commit 0db10728d07bb97e6548935001d81b9e0657485c
Author: Ian Rogers <irogers@google.com>

perf python: Move exported-sql-viewer.py and parallel-perf.py to tools/perf=
/python/

This commit moves standalone Python scripts to tools/perf/python. It is
part of an effort to deprecate the tools/perf/scripts/python support.

> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/per=
f/python/exported-sql-viewer.py
> similarity index 99%
> rename from tools/perf/scripts/python/exported-sql-viewer.py
> rename to tools/perf/python/exported-sql-viewer.py

Will this rename cause an ImportError when executing exported-sql-viewer.py?

The script contains the import "from libxed import LibXED", but libxed.py
remains in tools/perf/scripts/python/ in this patch. Because the old scripts
directory is no longer in the default path, the execution will fail.

This regression is fixed later in the series by the commit
"perf intel-pt-events: Port intel-pt-events/libxed to use python module".

Also, does moving these scripts cause them to be dropped during make instal=
l?

The installation rule in tools/perf/Makefile.perf targets
scripts/python/*.py. Since the scripts are moved without updating the
Makefile in the same patch, they are silently dropped from the final
installation.

This installation regression is fixed later in the series by the commits
"perf: Remove libpython support and legacy Python scripts" and
"perf Makefile: Update Python script installation path".

[ ... ]
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/sc=
ript.sh
> index 7007f1cdf761..f983b80e77b7 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
[ ... ]
> @@ -76,7 +78,7 @@ test_parallel_perf()
>  		err=3D2
>  		return
>  	fi
> -	pp=3D$(dirname "$0")/../../scripts/python/parallel-perf.py
> +	pp=3D$(dirname "$0")/../../python/parallel-perf.py
>  	if [ ! -f "${pp}" ] ; then
>  		echo "SKIP: parallel-perf.py script not found "
>  		err=3D2

Because parallel-perf.py is dropped from the installation, does this skip
condition gracefully abort the test and silently mask the missing script
regression in installed testing environments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D24
