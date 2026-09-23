Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9D3B7769
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183862; cv=none; b=h4ZcwPiela9ji+PFuWXBJyiJlOoWuhD5IdwVxlIILysIxAR1C5uUqmbmnBNGGzmI//Oj+COCSX5W9OvdGVn9GYzEsefSFMZAPioNuwlU+odzo9p0UDTEknZGkz+N4X823zbjDsWCJNpky/Pl4Qob8puqXxSxU4gCKKShHVD4l+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183862; c=relaxed/simple;
	bh=a9Ziyl2wjn7RnfcYFa5z9QEA6USLTIGDIlU4tOuiVCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yc3zAce0TTDaBBDT75xUwpNaNTWF5JgJ4PuBterHQdZAUCiBvYxY5CfFvO288YC3rpkaE/RlUcmX5ge36ljeuTJvHnSL7yPhWFAnsqO1WtjtaijXzIHXG+04BFJHHSd9+xHCYmzra01U0nwTIr4x2RxAgLMflazyFCENjdgux+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glpWx+JQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glpWx+JQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C1A1F0089E;
	Wed, 23 Sep 2026 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183859;
	bh=a9Ziyl2wjn7RnfcYFa5z9QEA6USLTIGDIlU4tOuiVCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glpWx+JQA5GVxWl9TfCOf1vfaf7xUQTrn5EuszlHizAoE/GQmDjk0VzW/ePiM9jl7
	 FWjakw+aEdxk8odcShhIHlGgcI3zJirC52XSLQy0FyvJAJ/a3sYGMR6LtghlKuo8Qz
	 2F8tSt2pNIpWFUHb/HD9ZBB7I7LrsGJbvQ2sa/viMeOYJckVavPzRY9pomHzx5Xhrk
	 WVSGLFqRr3NOHgOPmf7H127zqF0nEsQhF5PtjbuZX9E/t7UfQeTSvVXN9pcygo/BaA
	 Oc3XMmkpuor2l9ECNmlmO82ApOjLA/4ASn7551h4srmBwh+EeeixTxEEEh2jELVxjj
	 QbkzC7reaktRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923170903.48388-2-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:17:39 +0000
Message-Id: <20260923171739.A1C1A1F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When printing memory info in perf script, the entire size of the
> buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
> size. Pass the remaining buffer size instead.
>=20
> This issue was detected by sashiko during an internal code review.
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923170903.4838=
8-1-thomas.falcon@intel.com?part=3D1

