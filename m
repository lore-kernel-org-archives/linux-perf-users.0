Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF68175D53
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640001; cv=none; b=i3PsXPzs3TGg7Disya1XaZSOlzcw72KJDLasPVNigWh16tAChe/uOJOUK+eRwLg5eO1ntjvTlZZbPJNDHahlY2v7F0I964MgSBCFtPBY7gln0XCw+hRnQPIdlLFvWNJNoWgwGrqovQ9gOWao4gOikCw8OFLZrVQ+4ovhAsKRVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640001; c=relaxed/simple;
	bh=O8Ozx2fqYIK1Czw9vxTAE/Q6rDlI6ehP0rXpbbniC90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ch+VASsWCe1AJCTtCRZGjunSvHrBDDyfJBYiq/rTHUE3CRyaKCHasRioBHO77+127ur1DwuNRO0fZo8oOi9CVANiBF8+VCloXnauwIBSzZPNa2vP2NMf+0mfY9oXmqgubkU7V0jGL0HCmG728XH53+ZxcsTKe3KhFXzoWQuqpgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0KwAtuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0KwAtuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806181F00893;
	Fri,  5 Jun 2026 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780640000;
	bh=wgcC98uGZ+IjWBbHEmrXBw8KzaFQMrmRz2iEh4XE1xg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0KwAtuBIZqt8T2yxPHq3WTYP1GmMTHoi/wyXealDkA/XmaAu1oEbn8x0tBdYKRT5
	 s1jaqgcLl8cDpr1yfJN4+98vuXKW5EJrIRBSzYYoZibP3zzSr+g1aBn28dIENPF/jm
	 eED8MYbMS7LIvjQxWdIvUClr8J5izvNha1cehGITIdMHV5avYkgrDr2HVxLJRZvoQJ
	 RedYE1INpSlbT+sUmxPRpkoYeHKZl8fuTFUfx3RfZVKLFk1g1rci2ueempp/PBeX61
	 MOG7VaMwDyqtAwX6Zr3mrXgwrh3nJLu6q4V+pKMR339dtEegA/fubS/OksbyxGwr1J
	 J1xbu9YVhpzLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] perf test: Add inject ASLR test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605060610.1529996-5-irogers@google.com>
References: <20260605060610.1529996-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:13:19 +0000
Message-Id: <20260605061320.806181F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The trap and cleanup logic incorrectly clobbers the script's exi=
t status (`$?`), preventing the temporary directory from being preserved on=
 unexpected script failure.
--

commit c84fe24323edc3828dba95662be22cc7389443c1
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

This commit adds a new shell test suite for validating the perf inject
ASLR feature. It provides coverage for basic address remapping, pipe
mode processing, callchain normalization, and report consistency across
both user space and kernel workloads.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 0000000000000..9dd0a4e5f903e
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
[ ... ]
> +cleanup() {
> +  trap - EXIT TERM INT
> +  local exit_code=3D$?

[Severity: Medium]
Does this code accidentally clobber the exit status? The command=20
trap - EXIT TERM INT will execute successfully and set $? to 0. That 0 is=20
then saved into exit_code, masking the original failure status that=20
triggered the cleanup.

> +  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
> +    echo "Test failed! Preserving temp directory: ${temp_dir}"
> +    return
> +  fi
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =3D~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +}
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup

[Severity: Medium]
Similarly, does the echo command here overwrite the actual script
failure status in $? before cleanup is invoked? If so, this would
prevent the temporary directory from being preserved as intended
during an unexpected failure, making debugging test failures more
difficult.

> +  exit 1
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605060610.1529=
996-1-irogers@google.com?part=3D4
