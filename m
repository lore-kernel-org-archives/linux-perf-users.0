Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1712877DE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557627; cv=none; b=SMd4XT1pZIe9jTZob0CQzdHMJBW2yRRrpKhxkzTqlqZzADYMybgU6OYZMU6gUBgK85I8X2QwEKIJ8rg4Vp3U6S1YHyL1hhUPfHjvljIyknxNuwoz+YJESdh4C/u9yC2yNskDmL6TqLr4edSoU8eUMDjUUgqaOITFJXHjmxveIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557627; c=relaxed/simple;
	bh=ene7yaoBI4yVbXEOuEC1Jcbng3jTxHQAQT2wtR0rrYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NdBXmX9SAuv0hbe5HXyYSZ6Rxu2ZcnvaIPEr9jiQ5796rLT94wXkzXDJES/RMoQUFMBQStEJfGZcnWUHwuoaroRRvQnA4UPEDMyfVbLMIgdj/UMJM2jSCnORvvFTJhYlCkp+d9+xMdbj1PJMIO7Tv9QXOh+S8t81wKKgB1em51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7PltE6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7PltE6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3211F000FF;
	Mon, 28 Sep 2026 01:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790557625;
	bh=ene7yaoBI4yVbXEOuEC1Jcbng3jTxHQAQT2wtR0rrYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7PltE6fytVe8qlHDZOpCEb7ctvo0X8nR0rwfuEZMbLh103+y+DSLhuQgRAermz4g
	 W+ljRBMFJ2UrWUp4aG1sV7QrcPmTSLNmcrw8cEF31IiGed9GNysbq4csIYPDIWcsiN
	 LKxNDKi27xAZd+MkSdfvp22QpvBSrvDGYz9S5tvE5iKQuNfbsz7futAnIp5GfeBHA+
	 4nFFN1PMz3JQNYsWGjvdetgrOX2XbT+HVKHdEo+G/CKKR05GHbsJSf56xXk91oPpdd
	 fKqpLUW3Slr7OiFkmQw8MafLdcWh51JJPvcnwXTJePlh1aUX7Olj3goZZoTm3IFxkK
	 sofcTFp3/3b7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf symbol: Shrink the demangled Rust buffer to
 fit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928010227.1903673-5-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-5-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:07:05 +0000
Message-Id: <20260928010705.6A3211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The buffer a demangled Rust name is returned in is sized to whatever
> attempt succeeded, which is usually larger than the string it holds.
> Shrink it to the string's exact length before returning it.
>=20
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928010227.1903=
673-1-michalpl2003@gmail.com?part=3D4

