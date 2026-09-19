Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB373515DC
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800185; cv=none; b=lzxSEnPClyoZNkqFbsOWpAVLWZthSF6NGIo7MLhJf86spC2QGQX1UCtWLqASQaj6gLz4pzK+BwLwYFfa5q6LDMKYm9xXl1U7+3Tm5GLuYEplSWA6Y0sCoPeKSYOsVewUULXyEwOp8eeA/PWSwlQCgM5c67STMZYqwNy+ryU5fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800185; c=relaxed/simple;
	bh=tiJh5YvKGYyRiwNZMl29HAwspsLUcvQLZqAMy04/ico=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJqv099WEBCqWPRiGIq4BLMOwgqx+l/juvwmw+dza4QO+5j4Qw6QC8v9dU9+86zTD5Hym90M20Xn5ZOqSdhcEDqnpj7JZ/9gv8+P5Ckf0KqxnR1nkQ6NL1ZB+/mcIrLrPR1K6k7zinkQrz7HYwD8Lj5WsCiLEZgKPe235PGnzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItKsp7Hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItKsp7Hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578D01F000FF;
	Sat, 19 Sep 2026 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789800180;
	bh=7HOaBuCCSanOvBvN1IvYLdnFsVYAlAy4MOQwiQiyKMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItKsp7HsXgZ8QsFuK8d+8y87EyhHYEFTkV6/NaqzxQUHDBf6lloyJM7vBo8WpGgP1
	 B9LOHkUlVSVh1fkPZEWaEJgr0urieV9geIZgw8ypbx9jo5NAVIz1+UhC3V+9qULfPs
	 McxzgLgVcFGtMbTFh3UP9p24ZvpnwHrIxIY4l6ix8kWTGrjtL+gzB4h2wpKvxk21xv
	 kbpkaY1K2dbdPbRXOXoCrDl6NovyaeAyQ2vi5YYC6U76S65IyRt3s42GwC35YzgiXx
	 zJE2zZMkC2j33xCCG8AawpISxBQYbzp8vqISGVLqd7EZo3friC33wu0PlQBiR+WScL
	 YwLDqDu0GSXlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] perf dwarf-aux: Add die_has_flex_array() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919063745.48444-2-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
 <20260919063745.48444-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 06:42:59 +0000
Message-Id: <20260919064300.578D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The die_has_flex_array() returns true when the given type is a compound
> type and contains an array at the end.  To prevent an infinite recursion
> add a depth field to the internal function.
>=20
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919063745.4844=
4-1-namhyung@kernel.org?part=3D1

