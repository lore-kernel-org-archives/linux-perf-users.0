Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA362155747
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968182; cv=none; b=PMtAFPhW0MoHlbpaK6NpUgfUfGFATBkhfY/ozjiPfZrKZ7Zlhn8n0RCp/dF4nJq9EuWHkddsYLJqlNa4AT1gWJiHo7ncF6lKkAVhsVLXIC4+qDARpfVlx/SdumEXOkq3rjrEO5LuTKlE+FLv91eFIMxN4VNGsIonbNfXoEHkvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968182; c=relaxed/simple;
	bh=PWfr48iIxmPoBdzMI3DTq6hzy5Jy0gTeDn4ivR24Umo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yfx+yg7wkU3727qYTem6JNPNgLySP3aMcFeOYXwP0yafcAAtjGHx5OU/7nHOhRjsmcu8HKhmx3SVFXQwejp5PFxOSW9zWO7I8nEQIyNuKcArNga5VJFYwgIJZemthiM5NJ1VnT1st7A2jbn6JnNrqhCfFPGXC292mCKcWfU5Yd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV79UdSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV79UdSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DE41F000FF;
	Mon, 21 Sep 2026 05:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968181;
	bh=886n4pm2wTo1avC9YC2R70/mEiIoAyxbI3MuYVIZSIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cV79UdSA3gi5MeOMcFvqxc4hlXXVI9BALA3jFWNp3yvSmutDyHsU8xhhTNcCd97Dl
	 NStuqyUTLgsA48mBo8gBmDwevqvespLV+UyOurBvuYJQYKAeIfgMsKWbPbRUfkzLuC
	 rJ8x5ryiOp6jXP5FymqfIYo986xlxMoDzMt9JobeCse13Hw46BGAo2j9bJdvgUbB3b
	 xJRvH8lfOvotdgktb/HGtF72m4/M8LfW6NHXacdoVU0lwmEBTpEH2gMzTpcxMnsym7
	 brbUWsp+ZKjPg8kbq5zI+sY5MBofuu61kPooTBrBZEw3SFCxbS73YcDSv2Ewi0yW8S
	 glWJV7fZ8Z9MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/49] perf python: Clean up pylint warnings in
 tracepoint.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <503b656ff0cef2a2d6126b74e7cb4f3c2c7f823f.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <503b656ff0cef2a2d6126b74e7cb4f3c2c7f823f.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:23:00 +0000
Message-Id: <20260921052300.D6DE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in tracepoint.py so that it passes pylint
> without warning suppression comments:
> - Catch ImportError instead of bare 'except:' (W0702: bare-except) when
>   importing setproctitle.
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evlist.enable().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D5

