Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4630F803
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270612; cv=none; b=h5MPyuow2tQP72ykeQnEbkkVe60bMvGz6M7ciVA0z6o/OuhMCZZXb2goci+I4PYygW3Iv4owPMBcRcIIjV3VFEF2xJrTKy+ZEidE27J+b9cwnwi7xRtn+KWnuicykXI/vpRNyvMqc5zhWs0G/swYMrv5eC1DK3L0GdpKum696F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270612; c=relaxed/simple;
	bh=BE0Bwn9HWChdRESzSLfrSJc4s35DSYPcr6gGAdev0d8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IwkQs27X/iQtBG5+ngYz0TYOjgWsQagXSqd5yCOsqtmJjG8Q/4xgtf8jCjrySAQkf37flIHu6cMUOkNPeUtTbrywGLBP3QxCBWZPz//8VXrjAP1bz+CfYwao+lD/tJw0HtZQZtOh5u78ntVyTCFDAuOS3I0pdD214sibTfA8xWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E910ZfYD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E910ZfYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5686D1F00893;
	Sun, 13 Sep 2026 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270611;
	bh=Mn66cLb+Vizu0MxhA1Ess4N04LmNqAkshBfPX6FXYu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E910ZfYD/Q4OOedSdUcRmJItGaBkGQj16W0M2Js4lqIX2TAFildPYEZnxHnXq1mR7
	 /kOjvzGULKE6GsFH6k2ibZnKOpJv3IS2bcUktrsmX8nrH25vCGVjo8IghwBU1RC8Nc
	 sY43tbz/NZPrlujc2lBPn0oypembwJ8oeN2eJoi+CyzJrLwdlBSLbJh1wRtDy4PhOB
	 aBFSsvjrjLTZRNlw1GjQRbH5LX1GjNU/2cDgz+OWruwPouYjBOXTP+JCeMTuZTXtiM
	 0+JzKLIrjjQ8Hy8jW9WnGoth1hdPHe9Cj2HeLpgTIwHkCJvPbdLSE2OVuQ3nt5ihxC
	 EUuZ8co1dTYag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] perf debuginfo: Fetch debuginfo keyed by build
 ID using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913032632.116277-3-acme@kernel.org>
References: <20260913032632.116277-1-acme@kernel.org>
 <20260913032632.116277-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 03:36:50 +0000
Message-Id: <20260913033651.5686D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition in debuginf=
o__find_build_id() leading to redundant network fetches and memory leaks.
--

commit a2b8e0baf731e115b13a42e3b82a0348a1a8851a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod

This commit introduces the ability to fetch debuginfo keyed by build ID
using the debuginfod client when it is not found locally. It adds mechanisms
for progress indication, user cancellation, and caching misses to prevent
repeated network fetches.

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 84a78b30ceac1..6f3023c96375c 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
[ ... ]
> @@ -139,6 +149,443 @@ struct debuginfo *debuginfo__new(const char *path)
[ ... ]
> +int debuginfo__find_build_id(const struct build_id *bid, char **path)
> +{
> +	int err;
> +
> +	*path =3D NULL;
> +
> +	if (!build_id__is_defined(bid) || !symbol_conf.debuginfod)
> +		return -1;
> +
> +	if (debuginfod__cache_disabled()) {
> +		pr_debug("Build-id cache disabled (buildid dir is '%s'), not using deb=
uginfod\n",
> +			 buildid_dir);
> +		return -1;
> +	}
> +
> +	if (debuginfod__missed(bid)) {
> +		char sbuild_id[SBUILD_ID_SIZE];
> +
> +		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
> +		pr_debug("Not searching build ID %s in debuginfod again, it was a miss=
 earlier\n",
> +			 sbuild_id);
> +		return -1;
> +	}
> +
> +	debuginfod__fetch_lock_init();
> +	mutex_lock(&debuginfod__fetch_lock);
> +	err =3D debuginfod__fetch(bid, path);
> +	mutex_unlock(&debuginfod__fetch_lock);

[Severity: Medium]
Could this introduce a time-of-check to time-of-use (TOCTOU) race condition?

If two threads concurrently call debuginfo__find_build_id() for the same
build ID, both could check debuginfod__missed(bid) and symbol_conf.debuginf=
od
outside of debuginfod__fetch_lock.=20

After the first thread acquires the lock, completes the fetch, and records a
miss (or processes a user cancellation), the second thread will acquire the
lock and unconditionally perform the same fetch again without re-evaluating
the conditions. This could lead to redundant blocking network requests,
ignored cancellation requests, and duplicate entries added to the
debuginfod__misses list.

> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032632.1162=
77-1-acme@kernel.org?part=3D2
