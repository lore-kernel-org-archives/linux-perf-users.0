Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70F37E304
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183886; cv=none; b=iRrEhb7rtFTAx0izz/Xn3QVsWWjSwZ7bEsVRrdZEGvvAIiTc+JWhaT2aOi/JGhgF2Ex+e6/4tXWrmES/eG18IbfVPeMUT521JfRW9+ZzFFv5/kk8BpAznJ7ZokceeSS25EXaDvJjLB2HAtLwUZPrgM12g3ejHRLXAuJ9ZMce32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183886; c=relaxed/simple;
	bh=YnNolMYiuXxLpFlmedfmYnA+YQQ0MVbpuu7yxuKlp6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccPwtFAnoAtEiJBOMo4GE/Hpmlz0+coeD64Ej66JijqvcpCAkxVgQGYIUowLPm/Oh92CIRb7Ucdt74eIoS6xWMFRHMIu91BBaROViUAs5wF8QC9x1yXv0rhKhjBjGCVs1rjxjRwrwEShtcD4aR0JvKbRjjopF62P1igyzMqY+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8ueCaSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8ueCaSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502FF1F000FF;
	Wed, 23 Sep 2026 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183885;
	bh=lboBVHD38jkGnr6nm3T4DK2zkrxLnoDZNCFL07HdG1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8ueCaSuHVyAuE3wZgBq4knMFE7/pKVfGI4qAAj8l3zYPvP4nUirSunpXL+XZv3wX
	 lObDRQY15T2vL3o7opmrgDRK6YKPHTNRXJRG2A8i745ihoKeqvjxv3IRcTZcaPLkTf
	 xTzdbv1mPxTYzPusg/VHhTpwCYb6YiEazVj+uMU8t7GsS9ad/aHIQRd/owsV7OzKIv
	 KnhXp1mcJz6otnsDMpH6Rq6Z0v5iaApgXj7uRFs/RrHU2gyoy6+IX8gwnBSe24bmP5
	 vxGsz+JPAo8hOj4/sLfqd+TXnaQyvNdqi9VwLhmOvvBmEnZM+7gukIAQ9d3/mPj69L
	 X5Z2s9V0augXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/6] perf header: Support memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923170903.48388-4-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:18:04 +0000
Message-Id: <20260923171805.502FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Memory ranges were created to track different types of memory,
> such as persistent, high bandwidth, or CXL-attached, that may
> be present on a system for performance monitoring and resource
> control purposes.
>=20
> Memory range data are parsed from the ACPI MRRM table and exposed
> to userspace tools via sysfs [1]. Memory range data is read from:
>=20
> 	/sys/firmware/acpi/memory_ranges/rangeX
>=20
> With the following attributes:
>=20
> 	u64 base;
> 	u64 length;
> 	int node;
> [ ... ]
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923170903.4838=
8-1-thomas.falcon@intel.com?part=3D3

