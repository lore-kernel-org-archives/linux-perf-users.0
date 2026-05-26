Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379253C4B68
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833983; cv=none; b=B5vSjUlnBPGOp0ruRLeaFTQxZs30XgSDHViPsR4FPEDpd5sMglCqSBjF6EwfiOMuEvM/MzBM1HvWCOM+ErlIyOtMBxg8CcbfleZHad/ahj0Vd242nG1pjzcGONxyC1aL7UdwSfWa6jWxgdB51+fl1YZKz/qa/MhFON7rCrIZhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833983; c=relaxed/simple;
	bh=BpgwJ2Bfyymgr5tHahMEzp+aApRQkVo8UDPhNirz5fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sAEqmFtjcdgpnhDCQxcgXwO3SAP1tAXNl3uA2iAgC/4SpcjH3YZCwvpuVPxSCpOyk7o1eJP76qcseYIv3Q5z/59IS1CN+yKZF8CQMzndF8gFUYCIdX9s4Q0G+oMwK69tZ0c3wpur8mrZBX9l+5Hl56TIGLb4f0lgI5+NVnfalLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ocdz+9DN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocdz+9DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5806C1F000E9;
	Tue, 26 May 2026 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779833981;
	bh=XRgSVPjl6GM+Els5iWBOgpZr1ikf4CK/d7drigjDAX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ocdz+9DNZQk/5Mn62UkzJXRn+6G8XUk0NWI9QcChnFAy5Gb8LnrGMezxde49HRB2F
	 aNBrS3P8GTtNAPo5H3mUEUClXaEx+6W1ErdAm72kMxRs7QPDdp/2KhHHfZ1EOIk/Jb
	 DQnuHBCaI/wip4tJVHqBbSOEtfwXziS1sK8gi86WU5Cw44tN9gsffvRS4SV1O0v+gm
	 qbF0w8bGXCljndtPWnloyMlBxVrmDEJdlQVnECekj+CfogFy+ZVg5heJkEzny0xODt
	 mQljUAVg/OPLKwOB7N2JLpKTjNLr76xw9JOUCTqqB2Q7hkMArvE1h/tLLCYmE51xBA
	 J3r9CyVywzi9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/29] perf test: Add truncated perf.data robustness
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-30-acme@kernel.org>
References: <20260526211806.1193848-30-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:19:40 +0000
Message-Id: <20260526221941.5806C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The cleanup routine may delete a file named '.old' in the curren=
t working directory if temporary file creation fails.
--

commit 6d5a7740cf583f089ba666236f38032085207496
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add truncated perf.data robustness test

This commit adds a shell test to verify that perf report gracefully handles
truncated perf.data files. It records a simple workload, truncates the file
at various offsets, and checks that perf report exits cleanly with an error
rather than crashing.

> diff --git a/tools/perf/tests/shell/data_validation.sh b/tools/perf/tests=
/shell/data_validation.sh
> new file mode 100755
> index 0000000000000..5c3e6fced6fce
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_validation.sh
> @@ -0,0 +1,85 @@
[ ... ]
> +err=3D0
> +
> +cleanup() {
> +	rm -f "${perfdata}" "${perfdata}.old" "${truncated}" "${stderrfile}"
> +	trap - EXIT TERM INT
> +}
> +trap 'cleanup; exit 1' TERM INT
> +trap cleanup EXIT
> +
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX) || exit 2

[Severity: Medium]
If mktemp fails (for example, if /tmp is out of space), the perfdata
variable will be empty and the script will exit, triggering the EXIT trap.

Will the cleanup function then expand the command to rm -f "" ".old" and
silently delete a file named .old in the current working directory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D29
