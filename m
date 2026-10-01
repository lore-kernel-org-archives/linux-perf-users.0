Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107C253B42
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822702; cv=none; b=ZhavUxhEkkOvR5pPS/oYnz0xvWA6a3K6aMRa3rFpBJSXN+Qk6Y74VBlUOCgf6hJB9YBVLRDBZ861QY3M/wxGPDsj/ZDHknWncp1nvHKvbQqxftAyYALD9cIDUQoct1ZwH0whPwF1bhQW157c+mzTaNcb87LJYUBerNCGBwQ2XXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822702; c=relaxed/simple;
	bh=ODpqdVCSu9HHa3kvsq2fW404Mxtsy3nYwHCMQpxDmaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VX5CSzzChxvGxggyl2aMVl0ukIfh6885Qq1r4YrF2IGb8+IkB4P8Jz7HtKlUz6L6CbC8pmHpuyDua0swJxURCX6eeMsX44NzdkcmgG9eI6A9447jMsRrNs379ikIXeI5j6UqX4U5i+kUnakLx6klKZEzlD1VcdKIda05JoDIy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJxHdVdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJxHdVdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB6D1F000FF;
	Thu,  1 Oct 2026 02:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790822700;
	bh=8CTDIiLiSsz/cqA+K2gL2OhtAfXUWnBB4o1fOvDWenk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJxHdVdQL9NPXkrx10oKZxEvvfcsAIRE885kCkCLRl46XW+dvnFzAQOMfiyOv54Np
	 m0nd/3zVvw4NT4o8P3weyYXAKGU6WclUmyaciQDc9t7jycF0d0qAf/mkJCY+a9tTwA
	 ZInnNd/d6HnSgR1FWG4HOcW6BHARiCwBX3oAERZFoRh5LcKXkt4aSKUUOYIDgio/4H
	 hlvI8Lb2PopNxExtQAyAavyv1n1VWtdMtsDcQeQFtkFkiKaBCKeghgpB+bmMW7+rTs
	 T8/BanBmN5LPcqoVBAS34k53ltg94yX/nqTQdMM3Rcxw7Hfh61F83T2nnIarBsK9PL
	 S58LgCwmKXVxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf build: Fix clean and install target
 dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001023423.1225713-5-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001023423.1225713-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 02:45:00 +0000
Message-Id: <20261001024500.AFB6D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf build: install% wildcard makes install-build-deps depend on=
 all
--

commit 96fc82160f943f83538b4ed54809e23a269afef0
Author: Ian Rogers <irogers@google.com>

perf build: Fix clean and install target dependencies

Fix several missing dependencies and ordering issues for clean and
install targets.

> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index b8d38728306ab..a0d7035cd97bb 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -93,6 +93,13 @@ ifeq ($(has_clean),1)
>  $(rest): clean
>    endif # rest
>  endif # has_clean
> +
> +ifneq ($(filter all,$(MAKECMDGOALS)),)
> +  install_goals :=3D $(filter install%,$(MAKECMDGOALS))
> +  ifneq ($(install_goals),)
> +$(install_goals): all
> +  endif
> +endif
>  endif # MAKECMDGOALS

[Severity: Medium]
Does the wildcard `install%` incorrectly capture `install-build-deps` here?

If a user executes a combined command like `make install-build-deps all`, t=
his
will add `install-build-deps` to `install_goals` and create the dependency
`install-build-deps: all`.

Reversing this target dependency order forces the `all` target to compile p=
erf
before the required system dependencies are installed, causing the build to
fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001023423.1225=
713-1-irogers@google.com?part=3D4
