Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D83403F6
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016019; cv=none; b=MlVIp9w/cpa+VZustkv+/Qec57q5FkqbhgzKcZfkXfZyWA3GfziStujgqlDTeTUQYXQJLiH+Zc86dSdFSAGLWXAUGV2pyH6M9nXPt2JkqRqHQWfo9eLCrQ3Z4pr+Rioyr5Qq4g5Uy0XqBEtsrC5DyBu87MNktpAxo2iGgRkwaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016019; c=relaxed/simple;
	bh=5Aj+VDgNQh+U2LJDBJf2bkydcIHzPWGjVmFacd09OYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o+9N8tU76AM+beelFejQve/Q3wI/AtsIdDIFRm/XuVBikB7dJMf7pgk8qND++Xj2N0rOCO5uKwOVEhJesXGQBS64ZhdMbHBIWTUQcqvCljtSo8d36DuNhkxZITUe0nGinUWDaFtv7+SabieVNyaHvSI+f94wqtF4/nR6073tGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlrCfFBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlrCfFBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D77E1F00893;
	Tue,  9 Jun 2026 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016018;
	bh=T/E59KL//R2Cp4XgcdV5KscYt/X6qQ+FIH6dEDf2cNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlrCfFBf1hDPNr6tKKxVAeymO/YNWxEadZKWW39DKVPla5hjAYzp5Z4p6S8S8OUjq
	 Qi5iekzkwcQFISYWihZ8gx0fLD7kbZyP/bHhA1lZz8V9wWrUv6I0AnviVnRV05G9lP
	 EaezFUd/s1uLAGsqj1Cc3KlRJ+2ecVsdiMZotrj75sfoKJmPxi60U6ESARIZiXD90i
	 dVe7YS/rDn45aFgjiCj49iD+s11oe9U3n7xWftdWGDJT1Eq75Kd7AeVPhYsDao0bZa
	 XvBMKL3OLrZ120P7V7AMu2mwpBm3bGysvCC329nY3i1FLX9c+dCoFgDU4xc/RU2tH9
	 EIsGTrz3RkNfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/19] perf test: Add workload-ctl option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-2-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-2-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:40:17 +0000
Message-Id: <20260609144018.2D77E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to add a `--workload-ctl` option, but =
the implementation actually adds a `--record-ctl` option.
--

commit be5e10b3228f286fe50c54ca1ba231a4a933afc1
Author: James Clark <james.clark@linaro.org>

perf test: Add workload-ctl option

This commit adds an option to 'perf test' to open a named FIFO and send
enable and disable commands before and after invoking a builtin workload.
This allows syncing with a 'perf record' session to limit the recording
scope.

> perf test: Add workload-ctl option
>=20
> Add a --workload-ctl=3Dfifo:ctl-fifo[,ack-fifo] option for 'perf test
> -w'.

[Severity: Medium]
This isn't a bug in the code, but there is a mismatch between the commit
message and the implemented option. The commit title and message specify
'--workload-ctl', but the documentation and code implement '--record-ctl'.

Could the commit message be updated to match the implementation, or should
the option be renamed to '--workload-ctl' in the code?

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -1486,6 +1664,8 @@ int cmd_test(int argc, const char **argv)
>  	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
>  		     "Run each test the given number of times, default 1"),
>  	OPT_STRING('w', "workload", &workload, "work", "workload to run for tes=
ting, use '--list-workloads' to list the available ones."),
> +	OPT_STRING(0, "record-ctl", &workload_control, "fifo:ctl-fifo[,ack-fifo=
]",
> +		   "Write enable to the fifo just before running the workload and disa=
ble after, with optional ack from ack-fifo"),

[Severity: Medium]
This is where the option is defined as "record-ctl" in cmd_test() instead
of the promised "workload-ctl". Does this option name need to be updated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D2
