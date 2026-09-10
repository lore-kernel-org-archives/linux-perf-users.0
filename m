Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8238C42F
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062453; cv=none; b=Zw4PVIF9YLrxQCwyGMMVJDmam7maiAT05Q1NbMLRS9NVP0BMLZqLqb5mtDV0G5Ef5W5Wnhxn5q14lmx392/FbrKQ1chOnHQfNj9YQPysi5pcaEfjqvX49N1SrgWxkVOZfsJ/VCExv0CqRGRaXb1spahw4WQZm+tgH3tivrMy1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062453; c=relaxed/simple;
	bh=fofdJsmYzxpN+g45FGBpVMQEXg/T+b5EE2ed4kyI0nM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W/VUiYlulW4n82LB8Yoi8l3cgxO72bW5vhv5dqUNNYS7bt5R+6EhwCaLrsmYHmq+3pz5FFWZi+m6Neo0RXHk3Vmoy3ZEMdvQCWSchdA146myCmQaHjlx66MYxoih6WUCkZQJtJYhkD9t6Es5Gelis1akJ3DTal3HlmNy2oGxdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDjFfcf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDjFfcf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213BB1F000FF;
	Thu, 10 Sep 2026 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062447;
	bh=fofdJsmYzxpN+g45FGBpVMQEXg/T+b5EE2ed4kyI0nM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDjFfcf7S0HpfCg2kOpQBlkNAqmqK6kTUhzp9yw3tS0w/sSLiuirnbAp47HYqmynm
	 IzAldzRQ3iOHuQP7L3HPjHTANnfyi7wZ0VzTjac2967jD1IeQ33pgid3Rgz973n7tK
	 Gvq6BlBZVkDfdKg8pcn+wWGIvqKwOu4Iy5KmCn2WG01sOXh501n0y1HBxfDknIrnr6
	 //pJnX0vuLs3dUuLUvcXcEPlARbj198p7tm0T4YzZK0WzTHOdAPIJiBLFJk05wvOT5
	 AvPNln+wWvt7LKbp8V6Xg+U5+9YGzi1rzB9uUKmMvf1b9n77KbJG1556Cb+8J1Acum
	 7K9hetPOYOd2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] perf header: Fix potential memory corruption in
 cpu_cache_level__read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910173715.2996571-2-irogers@google.com>
References: <20260910173715.2996571-1-irogers@google.com>
 <20260910173715.2996571-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:47:26 +0000
Message-Id: <20260910174727.213BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> strim may advance the pointer assigned to cache->size which causes
> later frees to crash. Fix by performing the strim and then memmove-ing
> the potentially shifted string back over the original string. The bug
> was introduced by the transition from rtrim to strim, as rtrim
> wouldn't move on the left.
>=20
> Fixes: 13c230ab6e56 ("perf tools: Ditch rtrim(), use strim() from tools/l=
ib")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910173715.2996=
571-1-irogers@google.com?part=3D2

