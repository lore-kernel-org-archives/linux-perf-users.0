Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F194AEBE0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269908; cv=none; b=PPxQx/SDN/ODAnH0s1aVxsmRKJCV3IBIXpHBG9UcTSzn2FjHFMPGKcWj+4817EI0mcczgzO8n9PYayltJEoZ+jKypnljIYrTUOwL0AOJP0Q5xCjF8Sbh5ErAgiKzl8ZuN5NTjaG+70Nyxho3DzJbBmLlFgNQafhXNhJHdlkL54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269908; c=relaxed/simple;
	bh=OVb962Az8dvU6Zgg0D/QEVlgo4hU9+jfPpwZBKKh8/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GJrb8+mHSuxG3wL1pL3Yb9iFC+WFnPhn7iFtpbKpM/BKRZgfcl6apyyKbUn7A+zx/vZk0dt695stiQCSykIFIzvaV10mCis3INsaBpx3c5O/He4TaTl0PJrY3eB0+ysSIDVRwmrBW4Qn8GsQxmOIM6SEARTJyVM9inIGeTomAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXfeg6m9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXfeg6m9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F241F000FF;
	Thu, 24 Sep 2026 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269907;
	bh=OVb962Az8dvU6Zgg0D/QEVlgo4hU9+jfPpwZBKKh8/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXfeg6m9LFnk5n5TsaPR8SXcvqypoW63ixq5vPfQv5R3iM4y0h4DZyUPWlzaqO/jA
	 Fs6bdMCEP0FI46LE7fN7spKH+ITpEf/Ch9TBtPyjGtfBjEQJHuGhv+DzFGMzjykb2o
	 qtP0aJzqELzB2wCrtZPFMFnabUVhArWvz6usZAbDs/OvlBjiCTMAkPm7mFZg/YWzPK
	 CMHLWo9ija7KngTtlq44W8DO/eSh8RiFYnQcLOHvnFixKtyjUIiZ507+8/FP8el9lq
	 V2uKFf7W3UwNKap/515JA9SeAL2F/PDLTpkfHKutNxklwUrQMDCmP4cqNX266Q/vKG
	 ShCUk5a4jVJlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/26] perf vendor events intel: Fix sierraforest
 umask encoding.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-25-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:47 +0000
Message-Id: <20260924171147.74F241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Fix UMaskExt that was wrongly encoded when the UMask was 0.
>=20
> Fixes: 9626368d429a ("perf vendor events intel: Update sierraforst events=
 to v1.01")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D24

