Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7937AA94
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574065; cv=none; b=JXt4fNFBSqAvyJhc8nIUx4sIKllBv3UxYD+WbowrEoeThkEzBprzs3qrrmA0JVF0YMgIVWVRbbOJs+vVfTqTkFGNmtobExoMJQXqg4bkkKAtHDXthDX+uZfSHsAXKwI1eKDa+t/gAOEPVxOZiaF93Do1faIgHTffGdY3RkZZuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574065; c=relaxed/simple;
	bh=/44rIJxB9EykhLjSuTQbIpT1eL0FFKlnnv+Hu9pkWgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQgDI3wQ/j3AGk6Nj4rSYA++bOPoBpk+dXnZ2v3JwaOcTECMPvMQ4VpkT8iljHlBCD/E8MNzRc7FKGz8lqJcYkWl8FgnoD3i4p6IEXiN5X6m5pxCPhUX9Uj99n2LuYFpoM5PWNYTkUCD76qBJPhHxvCjiEQseklmmrijWqTX6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICyCnFtF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICyCnFtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC96A1F000E9;
	Tue, 16 Jun 2026 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574063;
	bh=c6qbZ2IwsAD5qiUEUNlKaO/DBbVk9t7vJf9+ClI0qC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ICyCnFtFfBKVx+U3hi6yHH5BuE8M1oh9Ex6remxgXBcC6OYq/UApct38x/E0yqjiH
	 QFHmGYN0d509j6JeineX9Q8Y6gZ1QOBwY92EjjOQCQSu/5BF0BIKMSs588sb8mHLHB
	 7I3qxyzN/ZGF7v4xm2yANHyDJfyOg86CgofKrpsILxneNoadnXKf6h0NxXVN7d1bnr
	 49L5oK1bF4mDsHvHC1dezxF9Zur4e4pl9eVdlEBAXTzku0x3HwhBWDihNj9DIx5AYR
	 ykMNcgDQsgYOvI1KPrqPawakYg3wwZsHuV8EFFoLbhbf8V1JQHpmqNYuGinz8sSnwv
	 SH1MjRBXFfB5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/12] perf tests: Skip metrics validation if
 system-wide recording lacks permission
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-6-irogers@google.com>
References: <20260616012744.4049193-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:41:03 +0000
Message-Id: <20260616014103.AC96A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Insecure temporary file creation allows arbitrary file overwri=
te via symlink attack.
--

commit c60696a6dd47d2ab5c2a513da9f459f6cbd7d660
Author: Ian Rogers <irogers@google.com>

perf tests: Add robust record retry helper and use subsecond workloads

This commit introduces a shared library helper, perf_record_with_retry, to
prevent record test failures caused by transient recording or workload dela=
ys.
It updates several test scripts to use this robust retry logic. The tests n=
ow
start with very short durations and scale up if the initial recording fails.

> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> new file mode 100644
> index 0000000000000..c5de252447705
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +perf_record_with_retry() {
> +  local perfdata=3D"$1"
> +  local check_cmd=3D"$2"
> +  local testprog_base=3D"$3"
> +  shift 3
> +
> +  local logfile
> +  logfile=3D"/tmp/__perf_record_retry.$(id -u).$BASHPID.log"
> +
> +  # Save the e flag state and disable it
> +  local save_e
> +  if [[ $- =3D=3D *e* ]]; then
> +    save_e=3D"set -e"
> +  else
> +    save_e=3D"set +e"
> +  fi
> +  set +e
> +
> +  local duration
> +  local first_run=3Dtrue
> +  local ret=3D1
> +  for duration in 0.01 0.1 0.3 1.0 2.0; do
> +    rm -f "${perfdata}" "${perfdata}".old
> +    perf record "$@" -o "${perfdata}" ${testprog_base} ${duration} > "$l=
ogfile" 2>&1

[Severity: Critical]
Does this predictable file path and unsafe shell redirection allow for an
arbitrary file overwrite via a symlink attack?

Since "perf test" is frequently run as root to evaluate system-wide profili=
ng,
a local attacker could pre-create a symbolic link matching the
"/tmp/__perf_record_retry.$(id -u).$BASHPID.log" pattern to target arbitrary
system files.

The redirection here will follow the symlink without O_EXCL and overwrite t=
he
target file with the output of the command. Could this be fixed by using mk=
temp
to securely create the temporary file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D5
