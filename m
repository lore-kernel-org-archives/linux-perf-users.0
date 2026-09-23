Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155553CA71
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180315; cv=none; b=lVCYYe2omqcttBDSaItTdTOvzSSvKTOYZWH7Oh34F+OtJiTtYWOVyF8zVkuWAGJhyM/zjLIBSQd+rugiarzCameDOwPTevS0JFE/yuiWTqLoalOeoC2uLmFMEOIdQkwV71BRWC+awQIaMMFfOQY8dP0qBpT8+DIdHctqJDj+Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180315; c=relaxed/simple;
	bh=z6nVL2R3qX/Cr4WjDjWha5uEnFISzowBwhhzjKdaunM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BhKJbe6n6Vccth1qkvnZZCCqw+nBOd1W0FlWRCFaJkLJgpoJlp3p9Y6JC0XdZYaK6HKDuwgUdh0t9SUxsbpzEL9amHmEtACb50aCkTAi5beohVmRn1hT6rq07uhRyPZxRYEZykmPpd36fukAT3TT+h2JxNYIZ27DdpzYU7wO4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csBWSSvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csBWSSvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387C01F000FF;
	Wed, 23 Sep 2026 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790180313;
	bh=z6nVL2R3qX/Cr4WjDjWha5uEnFISzowBwhhzjKdaunM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csBWSSviR8pxw+3FCpMcKq/JaXKmW3Ky5KKb6pi/+KbKkI514IcqSu2n3PciOfOCw
	 4ql3PD+Y6V+qbm2VPB2LNzGMFuLA50S0Pwgrb5gZcpHO9Qjie8Z6xfQkx2eML61H22
	 BUdrzpMOMrN7kMntCrdCg3dXua+2mB8w4irKTjYYuhk5KXHqqSHry4D67KBwDDcllz
	 ZSSx0mVRxQzOCDCLII5xoHpRWLCYynaucQWUF24lblDq9pKhbztFqqZEezzc2mEfgM
	 pv7I0TAQPAKuzmoJ4rxXYJabK8dQVgc3+19hdB2YaRmAXdVQLI+JUjadwYdaAGh3i1
	 Yuin3zANy8Auw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] perf cs-etm: Centralize branch sample
 synthesis checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-8-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-8-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:18:32 +0000
Message-Id: <20260923161833.387C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Move the branch-synthesis option and packet checks from cs_etm__sample()
> into cs_etm__synth_branch_sample(), alongside the existing branch filter.
> Call the helper directly from cs_etm__sample() and cs_etm__flush().
>=20
> Accept trace-start and trace-end flags, this preserves boundary samples
> without a taken branch.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D8

