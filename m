Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499514AD20
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177025; cv=none; b=tHqZ3dW07me+S40NG95XoAO/cfwiPFGdz7gejDOdiQsSdmKOFDRLcXkYM5RJlSvH0MrwjKr4I4QbdjwoULjIwmDtJt8Q9KDqkeallPiE5bWIl0ontKfrTGZgwmS2/ZRks+qTDMv770azq/zaELJLXAtynTIxwOiAIHGU+m/MJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177025; c=relaxed/simple;
	bh=WDglDz8IHfabNSHnHBO991Z4oCNkyw3jmHMVpw4jWhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/6DV8TmqNCOYv6q1meW7PYkhBX8ZDyJ3GH9VCkDqY0Z6a5oOU3NghNZX3nkoEq+KpBtjJyyI5VBOhcLQ4Zq6hgUa+EVjZ1tPmN3MpojjFp9hKfo44lNuFz1QPBhsEujunBL7vnU9iLjWIlM41mYbhiybmKw7ZqAK6a9zbSOY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQWYWTuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQWYWTuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F401F000E9;
	Thu, 16 Jul 2026 04:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177024;
	bh=m4c/VlbJEYKgqg4gvbnXAezr+WoHo9Qw0JRYXpZuApM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQWYWTuwG7ZLor3eRhVABGsM3q49h9fI1EJFRPmyifHvKqXuaXRaFsc7y7Np70UZH
	 m5L2bmTXq33MYU1Uv69i5tF0KuIfb8TJKkzjSyMyakq9N51fzOJQmndB+5DHct18sn
	 1DH1g3czmlCzr+0LQYLvKMkCuBSb1DLxb5+K5BLOQ6BmZ5Sr8creJEcOeJEdKinHfp
	 e7Mxaq5dKSgnMDKyUerODbJNs88vq6ln5WVaCOFzUxlgU+EXm7veuNUpjpsMIRMU+j
	 ZT2Y7DziZ9epAEyKktZr4GlJP5p1pg86nwxHbDw10yGRpDW/T+eKOGsLQZxxm0JpkX
	 pPD+oFy+jz8dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/14] perf stat: Extend STD output linter to test
 advanced PMU checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-6-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:43:43 +0000
Message-Id: <20260716044343.C7F401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added test for `--per-cluster` silently succeeds witho=
ut actually validating the standard console output, rendering the test case=
 ineffective and contradicting the commit's claims.
--

--- Patch [5]: [PATCH v3 05/14] perf stat: Extend STD output linter to test=
 advanced PMU checks ---
commit 6ca9850895a48d9a46d217a2535f3b76f2a6f0f3
Author: Ian Rogers <irogers@google.com>

perf stat: Extend STD output linter to test advanced PMU checks

This patch adds check_per_cache_instance and check_per_cluster to the
stat+std_output.sh test script. This is intended to ensure that standard
console outputs are verified under advanced topology-aware aggregation
environments.

> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 8dee005a72816..0d38a12839670 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -131,6 +131,8 @@ then
>  	check_per_core "STD (New API)" "$perf_cmd"
>  	check_per_die "STD (New API)" "$perf_cmd"
>  	check_per_socket "STD (New API)" "$perf_cmd"
> +	check_per_cache_instance "STD (New API)" "$perf_cmd"
> +	check_per_cluster "STD (New API)" "$perf_cmd"

[Severity: Medium]
Will this actually verify the output as described in the commit message?

Looking at the preexisting definition of check_per_cluster() in
tools/perf/tests/shell/lib/stat_output.sh:

check_per_cluster()
{
	echo -n "Checking $1 output: per cluster "
	if ParanoidAndNotRoot 0
	then
		echo "[Skip] paranoid and not root"
		return
	fi
	perf stat --per-cluster -a $2 true
	echo "[Success]"
}

It appears to be missing the commachecker --per-cluster validation step fou=
nd
in other check functions.

Without the commachecker call, does this test silently pass without
validating the output?

>  fi
> =20
>  cleanup

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D5
