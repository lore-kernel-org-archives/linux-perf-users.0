Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30D30DEBE
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216403; cv=none; b=dsPVQbPvOsKo5BgM6PaBFHF1bi7ziME86kWQ2P90JK1LsnljDBx+nABOYK6oYht7UCSUuwpy5VbqKCosNJVQKUCgTEnuoGyoC2/gTePEs+VejlKIEi8HfADWlJgGyswfcbMuHpxqhBfp4t9PgfjUXoc86Or7L4alrQBN4tB5tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216403; c=relaxed/simple;
	bh=KvTcb3hl7Y/XASV5CBLgsyoKWezElURjY4NPA8/NGcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fxsOY6pm2q4Ax+WNk94HB0ge412UUfoPW0cQsNUBzazVBRHCzt5GtEaSZc+I7ujXziPp0I/1GdV/+lEr7RZNguqh4lIYxwzKVclquLoHWaqhcSkLpggSSvUspQ3oJ2wvjPXsl6jPvMMxWE3qA+1TLD3q9KQtymKpJrtCh013whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQkuVHdz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQkuVHdz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79BD1F00893;
	Sun, 31 May 2026 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216402;
	bh=ATRPdUA4OUsZjG1GFLuDff015uN0GLKl2bK+MA14mWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQkuVHdzF3Pxowx8JzW78o4Xe8XmwdXCRhBqtOQOp9Ppnzn9NCLQghESHue5fCD6E
	 3poEDyj7f4uOQvmQ2UMyxXT/Bys2HGv01WNzxP+c5FjQ6RGBIQn64ugsII6cKkRzxi
	 rrqPk5XKbkyFLM/lG3jOL4bOq4vgQFSntm6Hqfh/rB5fDWxH1kRFT+RsH9pCv6s4dB
	 CJ2/WiSO30fE2iQziu//QyK2AHcU/14DrLmep3HRIb/yNBjQR93KFqI7sPi/QjcQcG
	 kLQC0cwA/QPbV592zapUnR1o5huyHvdqQYUE0nsc/EHWYLCfyB5LXhYZWSMZ2dV5sR
	 a/HGbO3NJ7x6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/15] perf test: Fix subtest status alignment for
 multi-digit indexes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-11-irogers@google.com>
References: <20260531082235.940833-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:33:21 +0000
Message-Id: <20260531083321.D79BD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The ternary condition `len >=3D 4` used to guard the `subw` calcula=
tion is a tautology.
--

commit 769ba0590c3bfba1dad8b4eb8bbb7b78766b7efe
Author: Ian Rogers <irogers@google.com>

perf test: Fix subtest status alignment for multi-digit indexes

This commit dynamically calculates the subtest description width based on
the exact length of the test suite and subtest index prefix. This ensures
the status column remains vertically aligned across different index lengths.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -373,10 +373,12 @@ static int print_test_result(struct test_suite *t, =
int curr_suite, int curr_test
>  			     int result, int width, int running)
>  {
>  	if (test_suite__num_test_cases(t) > 1) {
> -		int subw =3D width > 2 ? width - 2 : width;
> +		char prefix[32];
> +		int len =3D snprintf(prefix, sizeof(prefix), "%3d.%1d:",
> +				   curr_suite + 1, curr_test_case + 1);
> +		int subw =3D len >=3D 4 ? width + 4 - len : width;

[Severity: Low]
Is the condition len >=3D 4 a tautology here? Because the format string
"%3d.%1d:" will always produce at least 6 characters (3 for %3d, 1 for the
dot, at least 1 for %1d, and 1 for the colon), len will always be >=3D 6.

If the goal was to prevent subw from becoming negative, should this check
evaluate width instead (for example, width + 4 >=3D len)?

> -		pr_info("%3d.%1d: %-*s:", curr_suite + 1, curr_test_case + 1, subw,
> -			test_description(t, curr_test_case));
> +		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
>  	} else
>  		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_=
test_case));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D10
