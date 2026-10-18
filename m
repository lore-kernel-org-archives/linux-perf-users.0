Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A612AAF1
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331143; cv=none; b=rJzu7CJInz2Bg2LXuOZ77GO/ugrRbq3uJkPnYGjHGQKVRNezc+0ztg3XX9FxDIUpotABc8sbywMJ6XVN8TvpHc1UIGnZdzQWuQHAIX5U4Z3ZwVCJKakMsCmngxgsnhKiQ3me7LSsSJv++dcjjJZlvhEzsRV9xJfesfF7tE4RvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331143; c=relaxed/simple;
	bh=sQt8QCtfa0qj+EoPRMXALsdinNfRnoj4iH4M2Qha9uA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=CsXGUqiFr3qalwvixwnZXwxBgHM9t8oAJ3ZUR73cHcSTSq2K+ONCJY9tak7L+PQILHVyHhJNS6d9eGg2ZSHOUv7wlui7IwOKXHuPJ/nC2+0QExGzLAT1/nhNNNTKmg17GEWrU96n6atm6WTMY3jAFKK6/xrLZFptaAoWEk2CYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqhbPSLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqhbPSLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16FC1F000C4;
	Sun, 18 Oct 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331142;
	bh=9a1ijdJQ69VOH2zuW8zQbl9cb7xma5EQlX9dyWrsgQg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KqhbPSLexdDErS7TJD5/lsaGwHcrw6a6r+IWITdwcf+wSHykv54j02YejaagMDYa5
	 DFiKckThmw+6kdh2SAcPBslvMNSwn0ZtvoOMqX1GDdDpYWrs+JzrVF849sVc/cc2p/
	 qluD+gP2l0Qm8I7uRrwaHDVlFdDTstkODdLYg0nXTHnnC4hC3R8IqW2RyQpEuSU6ng
	 DB7xmQg9jgPlR5+guuEs+0F+9n/qWogxiBMBipj0u94eL8FI3L5sG9qLk4CKVIbEf7
	 V+2t3MmD2zG2RM21J9cRdEM0EJIyXDTKtnnnlPX4xXj1n6iW4fewu4ZWhARKi8lrrM
	 U6N6I9DxEf/vA==
Message-ID: <sashiko-outbox-176158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/2] perf/tests: convert check_*.pl helpers to
 Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018134322.26445-3-breno3011alves@gmail.com>
References: <20261018133032.24467-1-breno3011alves@gmail.com>
 <20261018134322.26445-1-breno3011alves@gmail.com>
 <20261018134322.26445-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:45:41 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134322.2644=
5-1-breno3011alves@gmail.com?part=3D2

