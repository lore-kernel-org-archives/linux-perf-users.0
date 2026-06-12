Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861935BDCE
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303659; cv=none; b=hqd0Udht66rYs6zusbM7EKU3FBHpdL2vFZH6SJuz6+yiC1QJdz/l8gcCyBz6tiYgV5Rjen84lHZd97Td3YNgs8yU9Y1dbajR/rf1YpnBmj+lPs+RiL0ouWquI/Z8cDdLAzT17DOOvXWiWVyS4vEv+8RUoVP4GRu5gcO68OzDPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303659; c=relaxed/simple;
	bh=1lRHawbkdQlqFQUs7m0tAFAmmIbTjhaHmN2CpqICtF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEI4X5JNhw3oDFW+nHHJaBRA56zLUWqX3Sy77XsNq5kTn58nIznePHf7Lye1wLPCf5TuUCbtgF3yqiFzF0IRg3ZUH4Axdjp6DGuGo+rIvZUCChXLh0+UONPfzaFiY0Jx+oCgXzRxCN38y4S3D1Tgac0mrBbHDgLUa7RChzZYrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM7hstwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM7hstwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36801F000E9;
	Fri, 12 Jun 2026 22:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303658;
	bh=GN7F/kTIK2H1jsqGdDL7WcpiWJYg46XVEr98IKyzwJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oM7hstwefAd7vVbn3dkSdUMbvjtaCkKGi7ZMgKiMrBYY6Dg9wA2w+BukUjOPqmQNe
	 KGRgYJwG//8RCPKzOTroi9QH9pH2KYXUEn7TGDT8e058RK1HN8NlUKPMQcxRh9b5rv
	 YIiivCnOJmeF/CJFI8cITPTUiLCzJRAPco56RHXGhy8QwGSgowGCgDgG/bBx9GFgfn
	 SW6F1TNHTdIUIgSBrIOlkewe3NHFC9byynhDYel434oaKafIeAHCac6p3P558QaJkr
	 Qr+y1ppQEUumv1jwRi3JgAWS/kBZa6TXFgNsXe6sXhhPFoZzZHWFVWQr68O0iwujRS
	 FIOAllzNSX7Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 16/19] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-17-irogers@google.com>
References: <20260612221211.1221305-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:34:17 +0000
Message-Id: <20260612223417.E36801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `perf.syscall_name()` and `perf.syscall_id()` Py=
thon API bindings are never used, failing the commit's stated goal of repla=
cing libaudit in `syscall-counts.py`.
--

commit 7f5421e7629b06e56ae07bdbadd1270f016d2cc8
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds Python API bindings for syscall_name and syscall_id to the
perf python module. It leverages the internal syscalltbl support to perform
these conversions. The stated goal is to avoid the libaudit dependency in
the syscall-counts.py script.

> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
Is this description complete, or is there a missing patch to update the
scripts?

The commit message states this change avoids the libaudit dependency in
syscall-counts.py, but neither syscall-counts.py nor
Perf-Trace-Util/lib/Perf/Trace/Util.py are modified in this commit to use
the new perf.syscall_name API.

Looking at tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py,
the syscall_name() function still relies on the audit module:

def syscall_name(id):
    try:
        return audit.audit_syscall_to_name(id, machine_id)

Should these scripts be updated to actually use the new Python bindings so
that the dependency is removed, or is that intended for a follow-up patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D16
