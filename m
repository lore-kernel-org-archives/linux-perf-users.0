Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AA946A5EC
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306413; cv=none; b=hjb7p3fkDpipKlxKd/aQfOCQwLY7ePgkQcNKd3gobhIEfUKgtIKkFw0An/RgZxG/96dKHTchNR/1hS53lWvg3LRlnI1G3vJaPx5GYZ49PF9XSGJjd2Qh+UGGLZRwl/vVUXZjCGNXUH0+UE3OXOJCKFMUMxwkJH7AzeF9RJa/fEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306413; c=relaxed/simple;
	bh=ODTW676ifgknZoN0XQPq2PfPreouxElPytqOw/HXQKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rryZQoPF5xog+DTy97EZy6PYRj/oNOFIYaEUL96ItTT6ZImOW//ZZ/taA8vEU0kSkeo06UpEwLJXm0Jsj6h7t9ZpFINiu9R7UQxrvfSOH+KdNEUsSgp+a9Xqelj8HWkXBzq7R+fk9ukro8MZO3j/CCS9X2Wxgy0wD4ugHOY3wXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzKDIQjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzKDIQjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483501F000E9;
	Fri, 21 Aug 2026 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306402;
	bh=ODTW676ifgknZoN0XQPq2PfPreouxElPytqOw/HXQKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzKDIQjWYYkKMPeEC2EpXnx7eYnr3UOygFoarYMB/fZEOs6vOaC0EFOwRd+aWraX8
	 7tgUlETqUGXeOl4lN3VQNVgRywVHVrkbiOoofuHIoCTxhYW8JBnhqovbVsP1WiKjVf
	 Qon0Z1SWrsi1HVz3Wf32UQH92NfSsbBvTCfsuOkp7CmeMhJQF9m86Odv+DczVLDfn8
	 sEpR+TCqpsYLoXJSycJuDSF8i4fvaYS1wIyzNphiayPy3Ye+appYnYvyPz8nzh9fiA
	 QE8DvPyHFh1ZvRaeyy4Kjt5bwwVpkLf5AHwxrwlIa+3fQGC68FqlmBa5RFJmYvV90b
	 1C93CO++Sg4Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] perf cs-etm: Fix nVHE per-thread decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-1-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-1-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:00:01 +0000
Message-Id: <20260821100002.483501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing explicit POSIX libc header inclusions for functions and con=
stants used in `cs-etm.c`.
--

--- Patch [1]: [PATCH v2 01/14] perf cs-etm: Fix nVHE per-thread decoding -=
--
commit 0b1cec5f0bbf916c101f1e3a2c758642b42382ed
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Fix nVHE per-thread decoding

This commit fixes the EL host/guest detection logic in cs-etm. It prevents
accidentally falling through to guest machine processing by assuming
everything is the host when perf_guest is not enabled.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 114b3cd2da495..d423f1cb408fa 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[Severity: Low]
This is a pre-existing issue, but the file tools/perf/util/cs-etm.c appears
to be missing explicit POSIX libc header inclusions such as <string.h> and
<stdio.h>.

Currently, the file's include section starts with:

#include <limits.h>
#include <linux/bitfield.h>

Could the missing system headers be added at the top of the file to prevent
compilation failures on strict libc implementations like musl?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D1
