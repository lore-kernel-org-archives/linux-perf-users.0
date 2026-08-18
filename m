Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522147CC9E
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069452; cv=none; b=gtf1sre1ajbAL374GMo6tzlpK+f4hD9s3P/jT7csIYiksESc6EibimXOFlR+dQeJb/7H/CPQF5SgMdig4MpnmTBgUFtnfvdY+2ee4WPrf90ipzqKqDvaPEOFy9BJ0O9MrdpQLoJ7hK+aspnz4KLzBjMkSSkodF2ctWt56QxjlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069452; c=relaxed/simple;
	bh=wxWEVVnXux8dj5ebTm1uRY2F2VlrYB/8DUu2qP+/BFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wdt7ewcqV52Z4igCA16FoLk6fMLoy3afUsvIoVy1KIoFgjbw2Zh1eHXCDuwSJutgFcCUC+nQELsicPNCRI4646QBqiEuh4YN8Q61RvBP8GIbjEoPGAn1HQvQbdBZU6hNMNR1yp/+eIlYXQzunsgA8fUUMDZgadsQSp1Fb5kFkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFx35jwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFx35jwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF7E1F000E9;
	Tue, 18 Aug 2026 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069449;
	bh=wxWEVVnXux8dj5ebTm1uRY2F2VlrYB/8DUu2qP+/BFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFx35jwJBCuTn64dNXfNCNsFu/d6Pp6APl9g8IOTaj/El8bnkeGnoietZ2ciMsD8c
	 IDRh1Y7zGQFKa6zr6X75DoLPSat4ybcOdO623kyY7AHY0AwCxLuUShaPe+WQKGcc8F
	 Xb5xWuSICNdsKUkBzFZb9Wz2U7H3psg2LVcCNKlc6bVDlV9GuiJcoQ6s17A5ViN/3t
	 g4AtI3KOlQuyIGRhzWk7B2y4BCE11MD97lnXso2A4qS6jufFAkwvCxjCxh+bbdHzh1
	 LfuXPq488YKnFTpLxD4MDbh8ayFmKMRzK8dJxuFjvmQX1c0ZbmHs5rH5u9YnQrGHjI
	 JYIVNQWfpToyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf annotate: Honor explicit --source option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Enju" <kohei@enjuk.jp>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818144149.101248-3-kohei@enjuk.jp>
References: <20260818144149.101248-1-kohei@enjuk.jp>
 <20260818144149.101248-3-kohei@enjuk.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:10:48 +0000
Message-Id: <20260818161049.5BF7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Source annotation is hidden by default to avoid forcing objdump -S, but
> currently an explicit --source doesn't override annotate.hide_src_code.
>=20
> In TUI mode, source code can be shown later with the 's' hotkey, which
> re-runs annotation with hide_src_code cleared. In --stdio/--stdio2 mode,
> there is no such interactive fallback, so --source did not show source
> code unless users also set annotate.hide_src_code=3Dfalse globally in
> advance.
>=20
> Track whether --source/--no-source was specified and synchronize
> hide_src_code only in that case.
>=20
> Fixes: e201757f7a0a ("perf annotate: Fix source code annotate with objdum=
p")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144149.1012=
48-1-kohei@enjuk.jp?part=3D2

