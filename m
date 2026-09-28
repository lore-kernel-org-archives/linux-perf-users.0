Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CA38A720
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620686; cv=none; b=eHNtVIua8TKmS/01nCk6IHXPj8HIAd9bH2m8NhEdiFLILR5pyqx3GWOoJtzHlEF85OKSK8BkvxnW9JyWGHFnkrwUeo70xjPCPrYM2HxZpgaoTQLDXqt5iLNCgxttSUoSXCt9l4A7ruIuPzj7DuGg6d20oRvh8C5UlZqnLBNukN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620686; c=relaxed/simple;
	bh=8TPnqiEd3eITQTGZ1dliX/34YTJoyQkEOMugtVqG2+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5StMlXm7mGtEA1izmkAA/hIaxMdPA+1J804X3QDL76q8FDE+2UUgMBhq+113RwSko8dyztJyujKEzzA8srvUTJ50Mx43O/lOO7MxKGu6Gk5RHf0qobLFY5/JXbi23FerT03HFIk8m1vrNA+Q1BSoHW+wwAaqbhF5LnVlIZn2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxGSu7W7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxGSu7W7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3633C1F000FF;
	Mon, 28 Sep 2026 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620685;
	bh=8TPnqiEd3eITQTGZ1dliX/34YTJoyQkEOMugtVqG2+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HxGSu7W7alm7SueAwzNP0huwMmJv4NuYPCmMdNCT+RsH4yOWStePxL6PKxKRA/rhD
	 N1aZcRCYMstoYknfjfGvVYdR5/+X0LwRPMP5OKePHXf6rJd5U/ZwzK41mJnOCJB+5Z
	 hKSdk/C45m8Q1WSAzd69luinZIZokN+fGCSKVs/q6G5XyKRp5OKJ5w1aSegup7kDQn
	 a5+4km3GZ6OfLpVXfFWGwVriLIT59LeZCymX+ZdJlw6fDsgAJa9On8/SOGifm3n96q
	 d0iKW6FcAryg0CoUFgn/wYVtHb0wVrbdz36ZgxgOV3gS4a2fqg7xddBIF0H9iMiBY4
	 /bwzUZIjj1cwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/26] perf test uprobe_from_different_cu: Scope
 probe name to PID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-27-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:38:04 +0000
Message-Id: <20260928183805.3633C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf probe names the event after the function and binary, so concurrent
> runs, as with 'perf test -r3', all add probe_testfile:foo and all but one
> fail with 'event "foo" already exists'. Name the event foo_$$.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D26

