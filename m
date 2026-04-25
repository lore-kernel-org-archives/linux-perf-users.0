Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFE38C402
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158709; cv=none; b=uu6KTqOOEzWDpgwZD1Ctbia/WCk5+1vGJvXe3ur2Z0g7ggSTCPBvV0CwMBF7KLf5241f0qciW0BWuG1/W8cShFdun01LqFB47f7TZqOEWSP7HkwBbT+WrDAiJBRGzcFn8cXKQ08y1f6Nq6W9TXfH9Y4sUpTp0doZTlIKUMhX6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158709; c=relaxed/simple;
	bh=lY56A7SIpZ1a7X7tK0CbSFON7Ub6XtBhl4uP4Hg7FsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f3gDXiWkTpY5JdH9oCwPD+md389ecYZ9DF+tgnJm4s0t9LE+YqO8pUd3nO2IVikNHi+q2uqoz2wv3Cm0mkcGSQgzlCPBR2DEzW3Hev599lLyr5Z+24AS/bqF/PwMvtwfvbjwlubtIorE0DLYcs9GvbxpVIDjHKVCv7LPeCl5TjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNmIOeKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNmIOeKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A5DC2BCB0;
	Sat, 25 Apr 2026 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158709;
	bh=lY56A7SIpZ1a7X7tK0CbSFON7Ub6XtBhl4uP4Hg7FsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vNmIOeKH74k2JEmXYLA6oNPpo1MCjhjwPJQ26JMSb1loZHuehbSuXLVN7STwiD0vc
	 ZyDOSYeminVNGQuk78bIFG8FSULMr85KcEzF0KOw/xR1BEh5+sNkf1E/9JKRtIjRHt
	 sUIdRiRZEG8v/hVKKI7qGI+gPUncgfiYbXXIcBdBPSqPNY1/L0uJsOCU5DRNpAKdKB
	 2olg3qrbGPafIqRceet72onsURkSNCQWdWK2bFjv2xjAsMwsl2GNVKQghE+KJD1wNN
	 3wnexB/7ClbN5lHDmvxS3UO1rK6abGG4pChhrbzm2SaHejYhH5eg11If3IGIygVhwh
	 VUf3hsWXwz97A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/59] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-25-irogers@google.com>
References: <20260425224951.174663-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:11:48 +0000
Message-Id: <20260425231149.38A5DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Moving `exported-sql-viewer.py` and `parallel-perf.py` to `tools=
/perf/python/` drops them from the `make install` target, breaking installe=
d tests and user availability.
--

commit 96b6213f3c26c1df2ecfda1cfe0e88d0ee35dbee
Author: Ian Rogers <irogers@google.com>

perf python: Move exported-sql-viewer.py and parallel-perf.py to tools/perf=
/python/

This commit moves the standalone scripts exported-sql-viewer.py and
parallel-perf.py from tools/perf/scripts/python/ to tools/perf/python/.
This is done in an effort to deprecate the tools/perf/scripts/python
support.

> diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/pyth=
on/parallel-perf.py
> similarity index 100%
> rename from tools/perf/scripts/python/parallel-perf.py
> rename to tools/perf/python/parallel-perf.py

Does this change miss updating the installation rules in
tools/perf/Makefile.perf?

If the makefile relies on a rule like install scripts/python/*.py, moving
these scripts means they will no longer be matched and installed by
make install.

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

When the test suite is executed from an installed environment via
make install-tests, will test_parallel_perf silently skip because
parallel-perf.py is not installed to the expected path?

I note that this regression is fixed later in the patch series by the
commit "perf Makefile: Update Python script installation path".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D24
