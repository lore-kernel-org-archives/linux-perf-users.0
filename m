Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6E406805
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750745; cv=none; b=FW2I8SwKiup8hQaTCZwsKghlKQMB70W7zDOH9FcDl6arOurNV5bwhZy+5VfFQ4o22FUQnlTZmDh5jA2E7Bv4i+jwVxuTjLyLfH94G/DFeWBD4V13vW66JdXzjDXmUuY5IsrkSbEJV/bEhZgMigoW/CAM7Yqt5RmTv5gWXBSRihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750745; c=relaxed/simple;
	bh=kAFelbHccvr3i2ZWRK8kfakdeLh3zH+/kIjmpWlGHOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zm23i5RVYZSEmo5S/wol6KE6DBLCnnzy6ZT0cPIQM85zVHIJJf67jUM4Wz9sJXQPH78Cx8WLjo4YhpfadS2dF9a3n4wlDFm4q3SW+wD6R7RpRscy3M8ZXlrfknBYLb+06+d4vq2xm55INpozQBZXHp7xEAe2YrRU6Ka0V8Ja63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBpBUvtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBpBUvtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221741F000FF;
	Wed, 30 Sep 2026 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750737;
	bh=kAFelbHccvr3i2ZWRK8kfakdeLh3zH+/kIjmpWlGHOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBpBUvtJvcBPMuUVSqfqfqIZxZpJIeHL7Rt9Upy2i9MGvsUrrlGvym19Tuu1GJwFQ
	 Mq6OyRP6jKxjIA/kirhwszHmCvrw6o9mA2aOW+nkpZ5FT5dbCz/NNGdz0zE/4CML41
	 /yoxtwFD28DUzsqSMLLrsB7v8JIsg9hOo0Mgw2Jamy5ou77v4a1JJLdAfBeJcZ3l1k
	 P/4jf4oIHqVjPmjiEn3ALPoJKbg1lvwDGa74kmUgE9gdOWTAE1Wn2JAjluyKm7eXh7
	 hAr5CD6nM+HeyIl1J8e7j2CCq1Wjt2NAlK2QKa2qNvCeLmXamx7atC0WrRzYumgLt5
	 9FQ/KAjKudgqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] perf tests: add noinline to __test_function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-8-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-8-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:45:36 +0000
Message-Id: <20260930064537.221741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In the breakpoint signal handler test, a breakpoint is set on
> __test_function. Compiler may optimize and inline __test_function.
> This causes failure in the test.
>=20
> Add noinline to __test_function so that it is not inlined.
>=20
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D7

