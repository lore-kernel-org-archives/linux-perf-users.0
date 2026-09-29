Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6223394A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713551; cv=none; b=FdUYTfrKqMx4CTqpGtwcfNzZz99XOXUiC0LFcF8TUFa8BQOM0PXceP39PWPAA+/H74uasUMZhIRS0Q49FDQPo8Vj+h0D2dPi8I8tOjW8elj1zPgu1Nn0c3ONlFa5UGxYlANkJnrAfvcF5QTgQSGf+AjM2j5ccnM7ZFSJyxw8x4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713551; c=relaxed/simple;
	bh=masAjhx5Ykp1VITWGh+w7nDIen1duXbfP05hPM2Vz10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaCzds6OIw/u57osAwhWPpQRF0QGgMq7Z1l/heOej7i84RFwpJ0xr9NRA4kL/XAN98qIDCgYZf9T6vhBMiWbh68G23SsdhKitVs5JGqzaMryQZbT40Glsy5auYQLtoew8u5LFcr3fm3PlzfRaexEpDp4/MgGkRKkp8idTOgO33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUVZyjqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUVZyjqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE88E1F000FF;
	Tue, 29 Sep 2026 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790713550;
	bh=GDhxdS8vVwRupTv9QxbIu9Zo/HVkIY9SWQGNZaX6odQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUVZyjqMM3r46/rGvZwWCVquTBedudy1AlIT2FA5k88YUN4xq01xbRTjjXPhNlQJ1
	 aRYlQS/gjtyzFX07AToFUenJkOS29h2HoOczcVticFsH2su4kZH52bB5d0WBy1y3WF
	 IAFz8pO4eJH25IP0hAxv4oQywDdlJUhS5J55VpV/khUfINGrjcF0+IzvHaDcgEBhaJ
	 YSNmqDV4sXokzXYA+eVGzdYWF4KhS7sL6SxKgWjF8qQNQGen28tlOkfAGgukJHQXyo
	 YSvHPPiwVMQZaQ4uc1Y9OD4afCjaFonE634YAfDGM6s9YTGFgkcVAC0+T6tZQos7Mp
	 xJDDpmqanuvSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929201524.2507733-6-acme@kernel.org>
References: <20260929201524.2507733-1-acme@kernel.org>
 <20260929201524.2507733-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 20:25:49 +0000
Message-Id: <20260929202549.EE88E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: sparse topology CPU discovery misses allowed CPUs
--

commit 20aa23e4b03f823c93c6019527a360319667c8b2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add false_sharing workload exhibiting cross-CPU false sharing

This commit adds a 'perf test -w false_sharing' workload that simulates fal=
se
sharing across CPUs in a TCP connection structure to test data type profili=
ng.

> diff --git a/tools/perf/tests/workloads/false_sharing.c b/tools/perf/test=
s/workloads/false_sharing.c
> new file mode 100644
> index 0000000000000..344875fb3a4d9
> --- /dev/null
> +++ b/tools/perf/tests/workloads/false_sharing.c

[ ... ]

> +	/* Pin against the allowed set, restricted cpusets still spread the thr=
eads. */
> +	ncpus =3D sysconf(_SC_NPROCESSORS_CONF);
> +	if (sched_getaffinity(0, sizeof(set), &set) =3D=3D 0) {

[Severity: Medium]
Does this loop correctly handle sparse CPU topologies?
sysconf(_SC_NPROCESSORS_CONF) returns the count of configured CPUs, not the
maximum CPU ID. On a system where only higher CPU IDs are present (for
example, if only CPUs 16-19 are configured, ncpus is 4), bounding the loop =
by
i < ncpus will stop checking at ID 3. This could cause the test to miss
allowed CPUs and fall back to unpinned execution, compromising the false
sharing demonstration.

> +		for (i =3D 0; i < ncpus && i < CPU_SETSIZE; i++) {
> +			if (!CPU_ISSET(i, &set))
> +				continue;
> +			nr_allowed++;
> +		}
> +		allowed =3D malloc(nr_allowed * sizeof(int));
> +		if (allowed =3D=3D NULL) {
> +			fprintf(stderr, "Error: malloc failed for CPU list\n");
> +			return 1;
> +		}

[Severity: Medium]
Is this second discovery loop also affected by the same boundary logic issu=
e?

> +		for (i =3D 0; i < ncpus && i < CPU_SETSIZE; i++) {
> +			if (CPU_ISSET(i, &set))
> +				allowed[nallowed++] =3D i;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929201524.2507=
733-1-acme@kernel.org?part=3D5
