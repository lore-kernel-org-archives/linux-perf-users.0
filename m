Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571B548541
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188832; cv=none; b=MGZZbDW3XFWPGdsYxuXjFk/Unu9nL2WE6UzTegsKL8WhuhKHfA1C+6vjKo9HHITEC9HG9DliBh6KFqMXF5tmF0Fmi5Yi0S1FK41Izljbl41IbuSjrbssbXIHVnYRCLFwZ+3X3F/IXO/ct1tk30ALVTH5t0Q1dFgkUO4oMwYC8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188832; c=relaxed/simple;
	bh=Pp7ET2u81qT9P37T2fXdLY0N0Qm6KaI0gJkW2jteqeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKrvMA+SIHEETaMHnMODGNAQH9lOFK3EBEh4N5qUNi1gf/rcjx5Is4hK5+9MSCGGFgQcxRi4urYkA2IWgZ5QYVC6GKCDhNbB0/LAJpTzlG1y0672TQ4k5GV1SMldb5OZa4GNq2ws3m5YhZCxayE2ba8xs2yd96a7oRNxJ6rfGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcxV7LC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcxV7LC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3581F00893;
	Wed, 23 Sep 2026 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188824;
	bh=Pp7ET2u81qT9P37T2fXdLY0N0Qm6KaI0gJkW2jteqeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcxV7LC0p5utREf9cMCH5rJJltmQ/lZbuXhfDYwJizLhHaNGQOkx9vjO4pyNiZmlm
	 ojUZfqYYirEFipKJzjiVIx1ttfOQmR0Spt0lzhf0KZ3BPWkcKy+ct5HjrsURagNpHG
	 pjJKTzHaFSZUx3ldU33GZ4+ZJ25nAQ349m/mKpL48b7Gm3vdvdFPLsqcSLdQ247yW4
	 /lfDDQ5JQ3L9bMSS/iumThefjbXtb+fiIK9/oDrPw/QgveMxPX+3/BKonUVgWgJMPm
	 0IpPIHuRoi/tb/oslCi01F80M6PjvECHUQdz8JS1CqJezz+pJX98zn130kr3EFF6SA
	 eHEzY9nNbrgdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 41/49] perf test: Migrate Intel PT virtual LBR test
 to Python API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-42-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:40:23 +0000
Message-Id: <20260923184024.2F3581F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Migrate the Intel PT virtual LBR test from generating an inline legacy
> perf script callback to using a standalone Python script
> (perf_brstack_max.py) with the brstack iterator API in the perf Python
> module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D41

