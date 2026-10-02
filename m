Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3A48A8D1
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940379; cv=none; b=ixCCobP+7Khn/+oRHpb3jkafq+MOrSQZVZ1kJGUtFI4EQYicwvXUE6J7K9ZfVeIYosjc6tfHn/dM85mkuwAAftmLp7s7vMHrvHiNVrV+zDjKPkTlMS9sRRnOjEPympKID/izx3QnX7GwohNQAIMfKYKUSAb2f6up13IvR7uLths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940379; c=relaxed/simple;
	bh=C4rku3u8Ayezi+BFRnkBar8pBAyurcg6X4KpHME8Fec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hVkBwsjrTBpwoNBt2mJzIYEQS3VNuF/dOuvHwBYN11OqJHV3kqSGIcr7RFbuJQESSr91fj/Kjm62/duynTg9nBjgkQXMO0FQhbPEDmpqAJQWvTNqoP2DlbJS3aGlW3+y9sOcxFSdbJ4iw/akBWmuWcCw/fg80+Lj1H2wUGar/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an9tFPQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an9tFPQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F691F000FF;
	Fri,  2 Oct 2026 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940376;
	bh=C4rku3u8Ayezi+BFRnkBar8pBAyurcg6X4KpHME8Fec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=an9tFPQPt6vse7VjhNXJSLwnz+xJvrlPQSuHPy2UWPY+F7kQZDahfrpbz0FZRpCkn
	 KtulLHaHD3v/Y7H3fu4qNrd51NBW8OU+LVq38X03Kl0KqpWtgZgFUziYSY7WdN5Ueq
	 BOISYVYI476jZXYPiZwUWF4HUx8AxP+A7PSiko2V3XsvpSCW42raElckfLifavutmd
	 AODmnEM44ByYrOhi+9XsQaC0s+FRqQzc0Pq4YPn9VdYmNgyuZ5fO9q4FeKzpSfvIVP
	 W1G9Xhlwj4JtPqwOPUyrxRDEgJoxTmINQJ+4MvrpIylEZnFPtRKlspOtfbyrEAn9cJ
	 3xRReku2gFKCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] perf: cs-etm: Respect --no-itrace option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-4-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-4-1d8b6ef339c8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:26:15 +0000
Message-Id: <20261002112615.C5F691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If there is a bug in decoding then Perf will exit early and you can't
> investigate by using the raw dump mode. Make the --no-itrace option stop
> Coresight decoding after printing the aux header so decode errors don't
> stop the rest of the samples being printed.
>=20
> pmu_type and evsel_is_auxtrace need to be set so that the
> unleader_auxtrace() behavior is the same as without --no-itrace.
>=20
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-james-cs-h=
w_id-output-failure-v3-0-1d8b6ef339c8@linaro.org?part=3D4

