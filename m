Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FA54EECC
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873113; cv=none; b=P3cjDNctk9fmmemfe/Ayc/0qzJHPdSFG2INFns1Ph6j1P5JNexQYJ4Pa5ApirC4/ge3VUoI5xEdc2He7Tt0mQUBUo6sB90UW5j420hsiNqbzpQ+jfa2KrRebIpMiqcpu7YjU76p9AJro7bSunlfQj0eQPPL7c0HnGAJJ+ZQIhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873113; c=relaxed/simple;
	bh=bjRe94G5qwWMnNvCbuoQ2KNtWJEiMEmP/bzQTryJ8Vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJwmcbwH0FfvyadZgfH+kcJxIalbEiWAq1fPScwX4t5uAiTgdparQXyXzY+8IguCHRGcdmky7krTH50loCkfnEmimpc81qXadUg3Lrgc6TOJSL6S9YwoolP9341yXAKwEfkmJNmG/NxZwMRLFMCpp7O1X2NKGqtiSxXTQjOs/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az9acUIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az9acUIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230991F00A3A;
	Tue,  8 Sep 2026 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873103;
	bh=bjRe94G5qwWMnNvCbuoQ2KNtWJEiMEmP/bzQTryJ8Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=az9acUIsPLnphUw74/VaoGPhfUQuupGyVQQ3aDwH1c1bEJ+EGsvm0qlUu4iRs0hfE
	 p2VHzf7HGj2J0aYR4PBTGo5AsJPThmaFrP/SlSOvYf14jfu2rKDopgJQXiIkDKfztk
	 XF0CjW/iKtnMF+cBIjM8bZuE7A43wAboexNJsQE+hu2dFI6rLXr8PMelQmd3Uuk2l7
	 C8Xbb7ZbbKIZmngWEaWgK1LNOzvLJRTGuAU0kF3h3WkYmbUWta4UvDYTtzgU9FeUWn
	 RXCO3DL7+QY2v+oBSSbUjQayDTKwZVApcs9RY+1C7WLwQrNL3W1yLBtP0SWtE8Fw08
	 73jkWS8GTIsXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/26] perf annotate-data: Extract
 invalidate_reg_state() as a common helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <62d5646f6a60e40bfa765d9cf93b5d6279b7f8a7.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <62d5646f6a60e40bfa765d9cf93b5d6279b7f8a7.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:11:42 +0000
Message-Id: <20260908131143.230991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The invalidate_reg_state() function is currently static and only used
> within the x86 data type profiling implementation. To prepare for adding
> arm64 instruction tracking support, extract it as a common helper that
> can be shared across architectures.
>=20
> No functional change intended.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D12

