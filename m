Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24C352FA5
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404336; cv=none; b=C4ONQ4ZHyUHtgJrlWm2q1Pms+19la5dvb2k4XfTuNG669Z7Amw4idoQTQy0uT6bSkAhlwNO5eSff/EyHhRb/1OKxuFqxQQ66ugms9q4T6i+w/JmuTHW9S2DXhR0OFkABrfdCdYiE0+v1dM0lQhcAoPAqp1r4fIEIYAJZE5xPPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404336; c=relaxed/simple;
	bh=z5pdZslgZDB2MFtTOYORxrCLK0yQpBQYPWtl3SCTmE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MxNVwchnToeUgMuUBmOB8Pd31TzWzIrzjfifTZ/eKdaK6Z2n3yEnvTNnygPz9yDmM7WKpysPsb9pJlpO6bFsTrND2XvF0pXNhT7mhZHtdc/yL8A7nJSfSHKuY9I6Q1jKuDJX0FL5jk6DNqX23zsAZZagsitV3C84ZW84fLRFIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0qTMi8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0qTMi8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E801F000FF;
	Sat, 26 Sep 2026 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404335;
	bh=8r8UH35p0iEBOFxZITo8DxcG/3XYe14aUpq0edHXBRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N0qTMi8yXxO6/WV9gqXRCt0tI6dtw76bC6ZhehVd+XLfC9IndDGuWipwGepohAj8a
	 RFpl1ZkJ+9AakaPaR//IsKjRHkfZyRwaW0NUAjohW+mBOSS7ah70sM6ocoDditmd9h
	 L6gRJ4fy5yWiqe8/CVemgz81ck2ND6IQdD33bL6a+C7xNtnm6ggWRXx5OsfoR9nDhm
	 sNmnHhNmAFN3V0w8seHuCl1RCczwt9vAd6mwltQBUZs6Q8thSx/GL94fl5laBxXrVv
	 awsZBgF4G2l8aSd3uy4mzTtJCzQX04NudRsnjXCEHur/rfba3e8pjWEPPi+q9Uza1G
	 MJiswvioEd3hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 27/49] perf python: Port rw-by-file from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-28-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:32:14 +0000
Message-Id: <20260926063215.29E801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-file.pl with a standalone Python
> script in tools/perf/python/rw-by-file.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Encapsulate per-file-descriptor read/write byte and call count
>   aggregation in an RwByFile class using perf.session and resolve thread
>   command names via session.find_thread(pid, sample_tid).
> - Add argparse CLI support (-i/--input and target program filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_rw_by_file_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D27

