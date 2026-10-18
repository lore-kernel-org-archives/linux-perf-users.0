Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A084B5CD0
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330560; cv=none; b=eJ09TgAD8GESNnKlZHasMH+LMNw6Efb1JmOt6O4m7ewiFwvc+WaPtdmOW3b+q4C0IJJeuVNhlh4FurSebI2+5OhjPGmNtKIXD4JlNORh7hfeeNCmSnZwFd8+0WfuhA/rWqC0GJSWWyOtSLw5iHWYDnj6Aclzj+icfK+aoIYnzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330560; c=relaxed/simple;
	bh=3ZGZ2cY6q5THjHfoca0wm6PCl8n6ZMJhr+g5o53i7iI=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=CW+OMXaG9roWnrS2JszYV+NzXnpTOewsRVdutkGdZpN3pahw8EdGbVdj8ZPDe+eUvPh4bW/2y+M8a1Q1b1BYogSgUf4OHVOhfciMSIY4a49GrOT6IYZN1j5XaH6VwVI85D06SOORKjAJnovl4GZgzjJ+cBFuqKRMsC9OvnTJ6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQaTGoSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQaTGoSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7078D1F000C4;
	Sun, 18 Oct 2026 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792330559;
	bh=quu5eLvMRsAUFIFWI+iMD237o8/INyV8XJT3ulJ0ZeM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hQaTGoSZ9tn4t3IANRVIbXlkXSCJNQjdGLuSdFd3RvEh7Ob4+OKGspm+jvrnfk7j3
	 ZUNXu35vLBFa2BnsuoKhJP6neBhcHaBs7UltlMzeAJ7mbDgqkvvVi5S6Ja4ilhDNo2
	 5Uu8yX3QoKFk6S6d+rhwENohyjclab9pvwSgcw9PL5FgRtSY6qXluUikUInjBoE8Lj
	 DC+g6dZ+IqL+fp+OzSNnMLAl7q6I56IAaueM1hxSESMjn3AfDxXB0OFCt/K93+NPUQ
	 qvNUPbyN/Rvv3x3emuDw9yOYEOatM6r2oAgJ8Xxb/+Lijw11kmR3/l1yEBTrNX4+9R
	 BvfTss08bj5/A==
Message-ID: <sashiko-outbox-176156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] perf/kselftest: convert prefix.pl to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018133032.24467-2-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018133032.24467-1-breno3011alves@gmail.com>
 <20261018133032.24467-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:35:58 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: accidental deletion of tap_timeout() header in runner=
.sh
--

commit 3307ba1d73611e0bd22bd59e12d190de9b29a3a2
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

perf/kselftest: convert prefix.pl to Python

This commit replaces tools/testing/selftests/kselftest/prefix.pl with a
Python 3 implementation (prefix.py) and updates runner.sh and the
selftests Makefile to use and install the new script.

> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/=
selftests/kselftest/runner.sh
> index 311811dc55a07..b61ea6c2de89d 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -29,15 +29,12 @@ TR_CMD=3D$(command -v tr)
>  # with sed instead of unbuffered output.
>  tap_prefix()
>  {
> -	if [ ! -x /usr/bin/perl ]; then
> +	if [ ! -x /usr/bin/python3 ]; then
>  		sed -e 's/^/# /'
>  	else
> -		"$BASE_DIR"/kselftest/prefix.pl
> +		"$BASE_DIR"/kselftest/prefix.py
>  	fi
>  }
> -
> -tap_timeout()
> -{
>  	# Make sure tests will time out if utility is available.
>  	if [ -x /usr/bin/timeout ] ; then
>  		/usr/bin/timeout --foreground "$kselftest_timeout" \

[Severity: Medium]
Was the removal of the tap_timeout() function header and opening brace here
unintentional?

Without it, the body of tap_timeout() is left at top-level scope followed by
an unmatched closing brace:

tools/testing/selftests/kselftest/runner.sh:
	# Make sure tests will time out if utility is available.
	if [ -x /usr/bin/timeout ] ; then
		/usr/bin/timeout --foreground "$kselftest_timeout" \
			/usr/bin/timeout "$kselftest_timeout" $1
	else
		$1
	fi
}

When tools/testing/selftests/kselftest/runner.sh is sourced (for example via
RUN_TESTS in tools/testing/selftests/lib.mk or
tools/testing/selftests/run_kselftest.sh), the shell executes the timeout
logic immediately and fails with a syntax error on the closing brace.

In addition, tap_timeout() is no longer defined when run_one() invokes it:

tools/testing/selftests/kselftest/runner.sh:run_one() {
	...
		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
			tap_prefix >&4) 3>&1) |
			(read xs; exit $xs)) 4>>"$logfile"
	...
}

=E2=80=94
AI reviewed your patch. Please follow the URL below to transplant the feedb=
ack or give kudos to the AI:
https://github.com/kernel-patches/vmtest/wiki

=EA=B3=84=EA=B0=80

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018133032.2446=
7-1-breno3011alves@gmail.com?part=3D1
