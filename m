Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6C4C1502
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330460; cv=none; b=MxGrLq5HGv9jVzMHevEQVFk0/bR/ZFsegsgczGnAEt6vYVJyByG7pXzhFic9UNT/XMtPEyX5xDvcoEzRwwpNIpPuRAhN0DyYUYCjOMRTAny6XdCF0lQl5zXD4hwgn5CkgZfQDsgNpq44TL2GPCgL8o1FWfge95roq579giA6wiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330460; c=relaxed/simple;
	bh=lv3YayMImsXRmR6bqxNw3ehRb/djenh0BEHnucOQjpo=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=dhjaA5ivhhiMiI01K/d7VHXVvyZPMttOvsswtRh7r/R03Uyd7Ik2gkFbpwXdoYxP6kG+AsTX3wz170ddGESy5rw7e4uI6p1nWJ2RLHiGqwLEjbbJrC+bHjlk/Y2lrXG+5Ei1u/E0px+a7T9RYgKtBN8dDOIXcqZ32gQaULUh2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7tFFomI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7tFFomI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9166E1F000C4;
	Sun, 18 Oct 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792330458;
	bh=j33mblNw912dGI+R0rZZpjFJrsQKTGeXKShV3eppFj8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F7tFFomIaJLGBWmHqmcI2dQPPHqsLtdG/C0n91KF6aGWrN1PZ0XoA7xoSTDXQlbXu
	 OsnYJuDqYaats2XInUoW9ITBbcwkH8jyxPNFcLOGDHg4rTqYMw7sAajgeCOYySswVF
	 FmaiLdOAdO4c3ojaIWVlwK/CApxDpcAQ6UfkQm8kL5LCmS4GNGS0r5ERvizrYigi4c
	 fD7Mvc7vgSGK2cdwkKi8Spq7LWDEz0EsMHYtWT/gsXXNjYtJ1YIaxbx89oaKaSkcMI
	 BQ9bTERBMX8H+7559U1WWGE+77lAEcd558gEUB4KJ1ogDj8W7YnKClWqMk3c+eEdIO
	 3ltYMa+Htszuw==
Message-ID: <sashiko-outbox-176155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] perf/tests: convert check_*.pl helpers to
 Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018133032.24467-3-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018133032.24467-1-breno3011alves@gmail.com>
 <20261018133032.24467-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:34:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Faithful re-implementations of the four Perl test helpers in
> tools/perf/tests/shell/common/:
>   - check_all_patterns_found.pl
>   - check_no_patterns_found.pl
>   - check_all_lines_matched.pl
>   - check_errors_whitelisted.pl
>=20
> Same CLI, same output, same exit codes. All use only the Python
> standard library. TESTLOG_VERBOSITY and TESTLOG_ERR_MSG_MAX_LINES
> environment handling is preserved.
>=20
> Update all 37 call sites across base_probe/ and base_report/ to
> invoke the .py versions. Update Makefile.perf's install-tests
> target to install *.py files (in addition to *.sh) from
> tests/shell/common/. Remove the four old .pl files.
>=20
> All four were verified byte-for-byte identical to their Perl
> counterparts on synthetic inputs.
>=20
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018133032.2446=
7-1-breno3011alves@gmail.com?part=3D2

