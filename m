Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AC3A5E8E
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663874; cv=none; b=TUS6t/N/vSAZqSg1v/h7OIsM716Zq3nsHbWhv3tb5BPgfD2Kd5d0yuY9/g0TQCkQ/mw0GMtNyIM1bpX0SMnR5G/9JiMfMQiq4LAe0HAOYv9kLL2Uu1u1zbG5CTT2CmffYJ0uu0ZK20bu7asPgTbON19a9ZCVabAPrUdmIKrIE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663874; c=relaxed/simple;
	bh=Xpub1Ud7TnHA24KwVMlRLMFTLCGXBCc0nlgfjkdARug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UoCNQY/LCFftKRiruGNmzRJrW/CDkpnaEmswtTSJ3XAE3BF6ywMK2X6sOAEHKzUD9CGqGgXrTTeD6SyLU20VZi5Uj2lbQJH+xeDd7rvG33Pmq9FK/DBzCxbZmgRK+4aabAXorojxWVVxbjtRPwLWhrxEfrXgEfjKqYIlMConnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLzt4pkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLzt4pkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF91F000FF;
	Thu, 17 Sep 2026 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663873;
	bh=Xpub1Ud7TnHA24KwVMlRLMFTLCGXBCc0nlgfjkdARug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lLzt4pkQBYXmgQltWwzUVT59qkThn6/HfxoL7TcLCgz8MeudOqZYy4GtqJjmr1AzI
	 +P+1yaot7G6SCVbc7M1xcoKiShOyXH487pOolJXwmo4VH28bBd2R31uV1iF0Txh92j
	 H+TFj4PYm3tv10yzpft6CpTJg3v8W9Y4zcB+9SAzD7xZjgCVr1g6Lpqgt00UYKbgGB
	 1AliySmBUdbtoEoZEMXb+c9G5ug/M304QyPfEHkiKJPjLt/em1kJmpkygrxytMBMds
	 QQwMxgNwO01o4KuyLKJ5cibTrLri8FNxcZvfIAaZQ9GPGYeBPyFD8oNnzhhNHLmm8O
	 DaNqLrRoOsRvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] perf test trace_summary: Improve error
 diagnostics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ad0c14591fba9273f8078a88d1231c0683fd1349.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <ad0c14591fba9273f8078a88d1231c0683fd1349.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:51:12 +0000
Message-Id: <20260917165113.40DF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pattern matching fails in test_perf_trace(), print the command
> that failed along with the actual match count, the matching lines
> found, and the first 15 lines of output to aid debugging.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D11

