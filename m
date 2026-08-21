Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6F3F7873
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291885; cv=none; b=nV1PQvwd6KuJ4vA0CDeJDB+KIqv/TgtBCFuAHsSwqnk2BCbEZI6Lf4TIUyByOM14eRS5ZzHGsZmKudD/bBGaT/j3CXXL052buP47FbWnrAKv9puVCji89uRFOnfwcuEbF3Rv9cet2yKNby7L4YSGtBmidMD0GIqnuePlINYVLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291885; c=relaxed/simple;
	bh=DjaJ4XGso3e93jfg0DQ3rsiqNF5aT0CTXd3sruScg7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QarI2kaOEBAuQ29Dq5w6EwQCWH51Dv51J3meNi1qF6rYxU7zuExlJAS1rBqgEPJJsLUwHYLO41jyGKVoOy08GyvDqsHIxTrl7FrF5ThCNWfufe/8UqyZjyP0fHVwZPQue3K4kKiNopXF7nkV2BMmdAImstVOmqyC7pnCVYAk/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TACHLyND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TACHLyND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B191F00A3A;
	Fri, 21 Aug 2026 05:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787291883;
	bh=Zicduwo+PcZiP9XvE6WaUsbHgMciOUbzGatEdqDZgh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TACHLyND3WIw15Y7Sc3Qo75NQG4EXTXXgVWpvLSpNGNsSMJeVs35gX8hTXkBRYby1
	 4I/V/+maIUfuJx4Oso1m2sbzA91XXCI0GbjiLdi3hQK6DjhTFbqmlP1o7d//H9I5eC
	 kQSvXHtSq2LperB/iQPJGYB5Jk+I7BQOPi5wEaMYz00ZitlVDRAvf68jMw2AMe5d1z
	 cI1ptYRESh4l3jffRdyg7S/QlCCFccKC7FfcoG+m+JQN5S3caQuio3uFcDBSXTD1OM
	 jGCCHWPGvng/hkOWPGO9Pyv+2nJ0jyfrFtNI1QLCIUFzvNH53CGZd6w4b/uqUP9jJ/
	 Zq/BepyWJZbUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf tests c2c: Add function view stdio coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9bd7a313c9c1d71058e857c320c6d5c30cf4cbfa.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
 <9bd7a313c9c1d71058e857c320c6d5c30cf4cbfa.1787283281.git.jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:58:03 +0000
Message-Id: <20260821055803.74B191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `test_c2c_function_report` test fails spuriously=
 because it incorrectly assumes `perfdata` is valid when `err` is 0. If the=
 workload in `test_c2c_record_report` fails, it returns early but leaves `e=
rr=3D0`. This causes `test_c2c_function_report` to process an invalid or mi=
ssing `perfdata` file, failing its diagnostic checks and setting `err=3D1` =
(test failure).
--

--- Patch [4]: [PATCH 4/4] perf tests c2c: Add function view stdio coverage=
 ---
commit 32c977aa30c2c6186f39077056298ef3b53307dd
Author: Jiebin Sun <jiebin.sun@intel.com>

perf tests c2c: Add function view stdio coverage

Exercise the function view without driving a terminal now that it has
a stdio path. Keep the existing datasym record/report coverage and make a
separate recording of the contended locks used by the futex hash benchmark.

> diff --git a/tools/perf/tests/shell/c2c.sh b/tools/perf/tests/shell/c2c.sh
> index f5f223cbf9cc7..cf76359d19ccd 100755
> --- a/tools/perf/tests/shell/c2c.sh
> +++ b/tools/perf/tests/shell/c2c.sh
[ ... ]
> @@ -58,6 +63,114 @@ test_c2c_record_report() {
>  	echo "c2c record and report test [Success]"
>  }
> =20
> +test_c2c_function_report() {
> +	echo "c2c function stdio report test"
> +
> +	if perf c2c report -i "${perfdata}" --function -c pid > "${perfout}" 2>=
&1 ; then
> +		echo "c2c function stdio report test [Failed: report accepted missing =
iaddr]"
> +		err=3D1
> +		return
> +	fi
[ ... ]
>  test_c2c_record_report
> +if [ "${err}" -eq 0 ]; then
> +	test_c2c_function_report
> +fi
>  cleanup
>  exit $err

[Severity: Medium]
Will this lead to a spurious test failure if the record workload fails?

In test_c2c_record_report(), if the 'perf test -w datasym 1' workload fails,
it returns early without modifying err, leaving err=3D0:

	if ! perf c2c record -o "${perfdata}" -- perf test -w datasym 1 > /dev/nul=
l 2>&1 ; then
		echo "c2c record and report test [Skipped: perf c2c record failed during =
workload]"
		return
	fi

Because err remains 0, test_c2c_function_report() will conditionally execute
and attempt to use the missing or invalid perfdata file. This will cause
test_c2c_function_report() to fail its diagnostic checks and set err=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787283281.gi=
t.jiebin.sun@intel.com?part=3D4
