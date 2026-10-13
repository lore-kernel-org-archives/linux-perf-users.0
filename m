Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00738D686
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912629; cv=none; b=ZySIBnf5tOND6x+syEEdIqaLHvYOGf0nh1MweqCUaiTWZGUZBx4RkCxqFBKn8lvc/LGPPX+ovrnJOtNigcWI8Ru4Nl4hi0lGrS6cGYtxw0vAAkzFV0O+LsMr/hHH8blCf1X1Z0XB1RrN0p7CqIYVG7L6j4TWTwa4KBZUWzBFDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912629; c=relaxed/simple;
	bh=PjmcN7tTziBOw/POo7TK5D9EIdVPxkwJAtUJ58BzB0g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JimqNtv/ldlhtMeihpSwcSfxBvD1XHdiouc9ef7zIKvUcmap//ZPYa2s7fGPlH9q+KqTo0V1Q0Xl2/oF44bafe9r2jewfyce3zvzooDfS5k1ySScflMkOrkRYlJN/oLmcenfUHLQON1rGxnFhrqqW5JkMt5A+0s83vmrH6cvaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwEIZZcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwEIZZcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F71F00893;
	Tue, 13 Oct 2026 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912628;
	bh=PjmcN7tTziBOw/POo7TK5D9EIdVPxkwJAtUJ58BzB0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwEIZZcZeOSOnZ8mO9Rla0QqHYnDs6G2x0PcPGP6HaJhWnjZkgzYe3hXA2d6V7pd9
	 3WqZYsHDqpCErMP2TDgXqxM0BInwBZCV0LiU/nNMkxM/ca9PFyfCDJ16cNS5/AgHwH
	 rHTeqGUrAl1QhAoK2huZAP8qfmeyjv2tB4xL50/j08fqFm3wtRy5p4a26G4DuiJe1/
	 D3GkqrhkidhTuON+pWIbOCoHpTADIdzQg3AW7bPvO24JuHVEc1OQhWWEe08WHwibSP
	 ZJepW1A8mHtCz0ma04reyFSk8EebSlXcdhvr14/aGmzyV3XAZ+S/UetAT/ku/qvIE+
	 izdJ/50dKhnGQ==
Message-ID: <sashiko-outbox-170230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] perf symbol: Set binary/symtab type for split
 kallsyms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-6-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:30:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When it creates new DSOs for split kallsyms, set the binary and symtab
> type to KALLSYMS properly.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D5

