Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D433EB818
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411207; cv=none; b=hvdRdPW+8/q6lQJ8BfpN8idtlUwP+NkkWkE4mDlvsZ64UrgB7JQwO+pfhfqPanNRkJicTJo+El58LF0lDP594sshBSIilTt2R4zVVgn/SiAnr3zvAkbOjrfJIKgoQZeY1tiszHCoLuLpi/TGHD2hZgyCQE0JBJEUsFA8GeOm5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411207; c=relaxed/simple;
	bh=aie3jLRvo+Q9XfENSEDQ7lUfXjCQfqiVsImGvOdsIgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y82xw1wNYQVFcnIHVR2TPPj0+JSdx23Qts2YNSQqRN5hspPohBipTaPMH+D781x64lRA0KFGSyiH6s6vbxB51fWoTA7TeWQDCLuRM/+Ipl/lQfd+hPj8EZD1v/sSHcLUH0YJ8BZjMaTKJTqA+Q7F5z91cgCgdalQLionve53+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOxjtT/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOxjtT/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA081F00893;
	Tue,  2 Jun 2026 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411206;
	bh=zgbs/7s3KjbRCCY+OCxNr1zaDPu7anh7WM5OAOZFAoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOxjtT/HuVtoXEqrKbDlMxoJkpyfkZ52eZXU15s2Z0Q5/oTaMJs98QRgwG/+4hAbv
	 igtMJBryufy9LNK3BzViz2GBb/jONiWblq0R2sZ3kWPTz5ImNwO35Shc63603YDoDB
	 4UCEdXFqb5lc/z19euVzFgEczrcxaTf066kDC5oRJlfZ60xCe/TOqGV/rbRjnbNmQU
	 J615ujXdc0zkO3yc1+xnPq4uawH6ZOCD26jtMzPUs1qbU7XaFJpaUcpKJaGfZwDzn/
	 OVy778jnHMeN8CP5meownJw14vMFLg4WbqAjVjP/NLrBveivhhW05U3V2RpjecsUnA
	 /3odt+ILokA8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/18] perf test: Add workload-ctl option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:40:06 +0000
Message-Id: <20260602144006.7BA081F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect command logged in error message on partial write failure.
--

commit 49160052733bc1acf9df33b623a7dd76ae191072
Author: James Clark <james.clark@linaro.org>

perf test: Add workload-ctl option

This commit adds a --workload-ctl option to 'perf test -w', which uses
control and ack FIFOs to coordinate the execution of builtin workloads.
This allows perf record to be scoped strictly to the workload's execution
time by waiting for synchronization.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> +static int perf_control_write_cmd(int fd, const char *cmd)
> +{
> +	size_t len =3D strlen(cmd);
> +	ssize_t ret;
> +
> +	while (len) {
> +		ret =3D write(fd, cmd, len);
> +		if (ret < 0) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +			pr_err("Failed to write perf control command '%s': %m\n", cmd);

[Severity: Low]
If a previous loop iteration successfully wrote a portion of the bytes,
cmd is advanced (cmd +=3D ret) at the bottom of the loop. If a subsequent
write fails, will this error message log only the truncated suffix of the
command rather than the full original string?

> +			return -1;
> +		}
> +
> +		if (!ret) {
> +			pr_err("Failed to write perf control command '%s': short write\n", cm=
d);

[Severity: Low]
Similarly, could this also log an incomplete command if cmd was advanced
during a prior partial write?

> +			return -1;
> +		}
> +
> +		cmd +=3D ret;
> +		len -=3D ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D2
