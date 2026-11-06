Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941753;
	b=4J0bgHpfd+NPpmJxxPwgbNZNleKvQkQa5WUlW+GbobwGKNhk7444aufFbCJjuLkF0DfA
	 1t7WWj9XeOJrwlFjS4Wh8VSkSxLJobBLhPIoJcpWd9iZ+KRFcft1YpcY8YY+qn5y480EE
	 txwB/QajbdGBvzQbHN4Mh6d+NW7HmIzZOM+fGVrHLgeiws0w+fJAT28kvw2ExyL7yBB5b
	 RoHtjA/njleB4kLDuDdA9O/Lx7WPClTVr9WHNqQMM3deAnlLvPdzDQjj8cWaRtHr8e7C1
	 zGQbq1CZzYaXadr949LYV0aXRQGWg09qLY9ayFKUW1J7GOyUXYPG7HIfyZNCiQc0ICQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rrtZ9mn2NL24RcVrdZkk0Qc9FyEwHnejzP8/ipKYFxk=;
	b=ibWued5pkpy3sJFMI4tjkBTyh6sizlqLy8gC5iWIGHs5bmrM6icJejLVyPgAnvVk4SQ4
	 P5Mj3sAazPBxqOZoP6Xh3Awav0MvVWARp/Qy3qpcHaHP+OHVbjF/OvutByWlWELDr2l/8
	 i1md5xaTE24ltTts1WNtP5vjvMZ4pXdv3ohSuFS4EImDb1huVmrzkkqetxFJpjU+fQrs3
	 N5qA9Dd3vvyXtcejzlH+k6iCBL1FLWAnn61AbeQsjP8sZgqfqKCtXfzxSmFSYsbMg7q8+
	 rlLKxApK1CugxAm2Zuzh0+s8ZICWb/LMO0YteFdezYVSuaPtVB0kkJ9QhRVIsp6cfhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNxOcSPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CD606A32F
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNxOcSPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2231F0089F;
	Fri,  6 Nov 2026 05:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941752;
	bh=rrtZ9mn2NL24RcVrdZkk0Qc9FyEwHnejzP8/ipKYFxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iNxOcSPaHBcITnppuyIeNg5WXa5uvMUURhFkUE0Ajt1sjHdCxulPJ6pbhadEibrKc
	 PxQiVPzLtfWYRKY8xjuPtO1Na+GQgw0aMpkSaP8hlZhW2+2Q+IohWmzV7b/bnlAHL9
	 5//v14U54fH7IiH9zKEIoD16ThKdtet2ly/kyfQL1XJEGw8QjhJ4wZ5ENdH+ipHcuw
	 dDjgbsh3VLw+5i78B7oBGHcAsFmkDOyxmUUwI6NH66iRW/4lLewsz2UsHkjZtJQ3Yr
	 JS1PzD0JW5oo4d0x3Yrppxfb2L7EcnJTMx4QO8hG0kovqoysHm07ryNtrUh8/+ScPh
	 orMEQgM7v2uGA==
Message-ID: <sashiko-outbox-200797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 11/20] perf/x86/intel: Allow LBR read helpers to
 operate on explicit stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-12-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:09:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The LBR read helpers currently assume the default stack,
> cpuc->lbr_stack, and therefore cannot be reused for other LBR
> stacks that may be in use. Extend the *_lbr_read() helpers to take
> an explicit LBR stack argument, so they can operate on any LBR stack
> instead of only the default one.
>=20
> Update the related callers, including intel_pmu_store_lbr() and
> intel_pmu_lbr_filter(), to pass the appropriate stack explicitly.
>=20
> No function change intended.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D11

