Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F92EA731
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329672; cv=none; b=YGu4T40INLLRhFs1/ph6jPiaRJBMy6kKagPbbZP1HbwLMYuvZxDEbx6EZ36rlEZVM7bJYPRyBhHHQDFAYByrOuaXVuPRDpzERvqfJOIcBa2/KGywvMlVo5ENY/22/paxCGYnEOwEB2uu3zrH2lbYKm+j4wa7pxwCleqIreXzhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329672; c=relaxed/simple;
	bh=P71zqFdbJHqALkuUWde4emOmRXJS/+xshbINU4c7KAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDEurlfGXQ7BNm/YcYsEbFmY2aENatYM87NLvMz+2vl68PJIuvXiRhJGOOjviyT7ZTDxTn7NEyLIeuWbEl138U/fBEbA0rwYdhJlAappIP8YkzXZHuBDzGdCLqzGs6Hib36nqvYjkkypsKtXY4gOwy0wTEXB661DKvSJrrVs770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb615Qyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb615Qyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112DE1F000E9;
	Sat, 13 Jun 2026 05:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329671;
	bh=lEqYRif55PKsqd1fJgOFuUJ8nh1D68p6QSkUwQprj2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mb615QyyqnqbKv54jGmQ0hECKsFetPOcJe9cc6jy3NDcFrZDlk5gxJnqIlygpqISb
	 Qne4NgL7Z28m9w4nc4aYQmSjtCIXMgqxb0YWLo8r3oZzQBd/+Rka2G4NsTAucok29m
	 WfINxoRCITGibn1ceCXz/YNRNhEK5NYwzivKG61RSOCShcWr8lVFO1t2PAHsxPvTlc
	 BUNkFDx2K1tNP3wSFhHPScRDl43flsJ3jZd1ILiUQqCemZAtcX56OBiKO9Og6QG9qS
	 0cmuTaxgRVoSWPRAD7/jqc2VhRKm7zmtIdLdSmbEW0yrOsgZ5iodnqIsqGprMGLE/7
	 lIr4eCMnESlHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 16/20] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-17-irogers@google.com>
References: <20260613052722.1424093-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:47:50 +0000
Message-Id: <20260613054751.112DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation: Python scripts not updated to use new=
ly added `perf.syscall_name()` API, contrary to the commit message.
--

commit efc13f37f43255fa0c87ef2573276e5694a324fc
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds support to the python bindings to convert syscall numbers
to names and vice versa using the perf syscalltbl.

> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
The commit message mentions this avoids the python libaudit support
required by tools/perf/scripts/python/syscall-counts.py. However,
were the updates to the Python scripts inadvertently left out of this patch?

Looking at tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py,
it appears to still rely on the external audit module instead of using the
newly added API:

tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py:syscall_na=
me() {
    ...
    try:
        return audit.audit_syscall_to_name(id, machine_id)
    ...
}

The script tools/perf/scripts/python/syscall-counts.py also still calls
this old utility function:

tools/perf/scripts/python/syscall-counts.py:print_syscall_totals() {
    ...
    for id, val in sorted(syscalls.items(),
            key =3D lambda kv: (kv[1], kv[0]), reverse =3D True):
        print("%-40s  %10d" % (syscall_name(id), val))
    ...
}

Should these scripts be updated in this commit to actually remove the
libaudit dependency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D16
