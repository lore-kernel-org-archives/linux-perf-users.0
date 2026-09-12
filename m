Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E51A3160
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789190772; cv=none; b=oSmeBk0fZZVSwvPGplcGeVh9elupKCH+KIOd9uoQsIGC4F0HFMpaCBWQDYma8zg8YIsfjtqmPYQsQSThlJp2ANGeEvpO4BVUJXilKa2Tgu1ZNpw9/1iaW5/Gtc9VsHhyaNvlaeY2OGZIpwmfoy3KoPzflgk3PVugaUwgfTOHhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789190772; c=relaxed/simple;
	bh=EkjYCyNArVNqScJ3VSEVx6QwgPBUP1PwzsliMZroHNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+ofcTSxipxifOgk9TX47mtw0AKwKCHzti4yZIoaWHKOgDsu5k12qoDatjhwVXje4VSwJB+ZGUBHPI+2NOrBeM6YHJ1KXINKeIy4vVFdUJQWFrujaa3j61vQ+P9JQZLXAVZ2qhp65gE8wuGKvCdCThTi3uzCL0JcVAV4ttjLE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhmzO9CK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhmzO9CK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCB11F000FF;
	Sat, 12 Sep 2026 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789190770;
	bh=v3iS9ycJ6aRtiyxqNTO/gtwcbLgHBmbFkKS6SO+s5dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JhmzO9CKvyUEL3WxUpBlXKBdRQQ6ThVyoEPf4EyRwozhGhCafq3aGUgL/GXgIltIP
	 ba935bKE/Sz+pKkNP9i0zD2sf/g4LNQHgCH1Sm0eZiR8rYQ92QLFklAt/cDTfOvO+9
	 uAKbJOGorXmJzrYSY/OPFmD0m2tL4yYAXwO1NlIHRtF+/tl2wHH3XHpuYyTR9eMjsi
	 LZtnruCZfmr3RQuuCyGQoRyDo8BzWhhyQAI6UZLlybp5EzBTcSkJ8508Y01pkGKcs1
	 5gH/6kNLoU9oZPIj851A/fXSF/SU9aZSkkO8KTJYCCsB8jKVeQu9m5PB24NW5WoXLU
	 fCvleaVziIC8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf thread_map: Deduplicate numerically equivalent
 PID and TID strings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912051747.2215776-1-sh_def@163.com>
References: <20260912031112.1814574-2-sh_def@163.com>
 <20260912051747.2215776-1-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 05:26:09 +0000
Message-Id: <20260912052610.AFCB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> thread_map__new_by_pid_str() and thread_map__new_by_tid_str() attempt
> to deduplicate adjacent PIDs/TIDs using prev_pid and prev_tid.
> However, prev_pid and prev_tid were never updated inside the loop,
> making the check "if (pid =3D=3D prev_pid)" dead code.
>=20
> Furthermore, even if prev_pid/prev_tid were updated, strlist sorts
> lexicographically (e.g. "010", "011", "10"), which means identical
> numeric values with different string representations (e.g. leading
> zeros) are not adjacent in the list and would never be deduplicated.
>=20
> Before this fix, the new tests fail at the first duplicate TID case:
>=20
>   $ perf test -v 35
>   35: Thread map                                                      :
>   --- start ---
> [ ... ]
>   ---- end ----
>   Thread map: Ok
>=20
> Fixes: b52956c961be ("perf tools: Allow multiple threads or processes in =
record, stat, top")
> Signed-off-by: Hui Su <sh_def@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912051747.2215=
776-1-sh_def@163.com?part=3D1

