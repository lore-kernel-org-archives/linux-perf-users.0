Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DC48988E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179521; cv=none; b=WXJjBMxj1Wai3smwP9LJB7GlrBeR9iFsIPdt78pgmUhJbc8wERXlL1lPqKTEjSO+ng9j+ps8kEN89yO1xvlDiFvIJ5D/xs36zGwHx1BOPpym9kghXLY02D97FZExaKaeHDE0+qRHmCA8jAjio+K9l48eUnU0Pj8dJeZWBQGVaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179521; c=relaxed/simple;
	bh=DRQKvqiZK2SQyU9iy4aOAbU1PcVS2foo2J36HvQVgFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=poAbi7poi4osXmSVrJBvZ2PiqYrZt9JBbVWGcbvSAmVJ1RXsubpWo+Ejj9oWtGoLs/Iht15lVngbMcbUUx64F/oaxEXDwFhvMocJRchSoT/cgUlOj+g7tJxceJ3uuVtGALpiW0LJl+CMx+1AdWIWq5/Dyi9qOCh9XSyfCehDl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBqmq7mY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBqmq7mY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD551F00893;
	Wed, 23 Sep 2026 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179520;
	bh=DRQKvqiZK2SQyU9iy4aOAbU1PcVS2foo2J36HvQVgFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBqmq7mYH757txv8qjmlsb7VWthb4x69sUMoGVMd8kHKMIb4e2MBwbUriPhrv3jBG
	 eDwjouK0WN49M3tHehWBcNgcjBZq9kM34IjMQMEkdV7KyOU2lQTxGwfkiiSBT+mqc3
	 wdWVSTOY1EPvQAvXr4XA4x8zIWtCU+vLx2233YufQBwCE0uvmdW2u23sJm5Rj2im5Z
	 qWpkWf0ORrAQLJjeUtysxu2413JKCe1IsqSixrzxC70RiNGpRH/jIhycq8uLBxSYa6
	 l2SWDejAC9fEl1WN9dmHncxMXSbXXNxOCW8CUdry2ULh9AZYJQByaR568qWUm9ysds
	 3EqxS94yyRj1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923155703.34814-2-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
 <20260923155703.34814-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:05:19 +0000
Message-Id: <20260923160519.CBD551F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923155703.3481=
4-1-thomas.falcon@intel.com?part=3D1

