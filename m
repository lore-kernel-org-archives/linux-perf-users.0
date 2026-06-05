Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847047B432
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646581; cv=none; b=INxDFCkW4yWm/4ctNV92FXWeCZ+ElujaXb4rNgktZBX7+JZp37qlAOrYIthb49n2weTaogdjyzvyw/kcl72xf6dpMCELF6YQSlnip+Jp3HYI8vhgbzjexijSu+DFpOaw8p225fgIPTNDhF+cyfK5aygQDmvLCCXguVUDe6KDIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646581; c=relaxed/simple;
	bh=UbTvYKFL2Xt4KMm11sSc45EBLMFRXdoFbsg0371BArk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WPmesWrnSjmB4P/LF7J6qTd0xbVDoXoqbOTUQ3nnO3n5rq6paeFkDOW+pGBkGFz3AfZNmLS9D6Vu965PwsJCFZuZRGJN2JUtyhid7cm0UAsDCcu0pF4+Ifr0ogrXjgPKfH2tT23a8Y7YRfWgICQTmBexiTmI2dTwcWp+KEiQn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6OzogR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6OzogR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E911F00893;
	Fri,  5 Jun 2026 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646580;
	bh=O0erWN73mpxEzmpQw/4rHDWkVnR1HqL713Fyv7Fo6VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6OzogR/EDObCVw8Sbqmh2ViaDAPRnrPQJyM2W7FjBnmuV4u58LRS9vwe5JG8fEGy
	 YYgWbilgRThUB9rqTc1U+bljJisr+JkThzUHG6jlFqnUO8IjcAHW6vp3Ggb5C3Lkys
	 MeK5XazSBXGeq3BXcorJAjWZl98OGBxxLAr0KWfFNdnH/hCaAN0wYSBwpIK/oYYuiI
	 pk0kQASMNngea640YGXEq0vwykOIF6ipIoWaSzhIUtpnPMGeOMYqO8ZuOUrh8FFX6/
	 Zvp01EiIAL/gKEXMpUlNesc/wGP7l6eg3KTI6iV/Zp5OcY+8DIYyuaWPrcu9vOsbqB
	 8r99cYQ0x5ROg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/19] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-17-irogers@google.com>
References: <20260605074003.1730715-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:02:59 +0000
Message-Id: <20260605080300.46E911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces `syscall_name` and `syscall_id` to the per=
f python module to avoid the dependency on python libaudit, but fails to up=
date `syscall-counts.py` or its `Util.py` wrapper to actually use the new A=
PI.
--

commit f477c88fcc2c1516b8d5945cfc3bf37bdd3b52f2
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds syscall_name and syscall_id functions to the perf Python
C extension module. It aims to use the internal syscalltbl support instead
of relying on the external libaudit library.

> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
The commit message indicates this avoids the libaudit dependency for
tools/perf/scripts/python/syscall-counts.py, but the patch doesn't
seem to update that script or its wrapper in Util.py to use the new API.

Looking at tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py,
the wrapper still relies entirely on the audit package:

def syscall_name(id):
	try:
		return audit.audit_syscall_to_name(id, machine_id)
	except:
		return str(id)

And tools/perf/scripts/python/syscall-counts.py still imports this legacy
wrapper:

from Util import syscall_name

Should this patch also include the migration for syscall-counts.py and
Util.py to actually call the newly added perf.syscall_name API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D16
