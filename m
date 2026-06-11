Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2652DB7B7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218789; cv=none; b=B6/anFmBj5WZy0yPNeYf6BKLIq+CTZ0fn5gBkkAzL2sCsx5JlngzkjqOPNzXSqacU2mO1q8YggVzGt47jTFhLX/ynTIm96M2x36B8f47EroyGobKHpOMymLf6pH57kSKoTmxGPbNWM8L2ccmtvKwArNPaZ69uqnQ1WXZ+69aQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218789; c=relaxed/simple;
	bh=e7uiirg9gESmg4b5swbIdbOvG2VA39CfOKWR/4dPO2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yqqc0882zPopKGZNuxBFgf3r5gWl/MzJ1+i2v/oqU53klwOcSkoLHWPQ9T5axjT+z+bumpXx0+NkYg3FMtyaUhy0bjVUvzPc5Ff7Ql/ppNUMTi6GFz5ayqYhm8MHFbzICkNtFEUyNxAgKn1BlE6Rs/1ZctreIO18tUHTOrurX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtqNMrAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtqNMrAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593B21F000E9;
	Thu, 11 Jun 2026 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218787;
	bh=Ht1Mh/gKtKlFCyqCkQa20bG6yI7rHYbp6Hly3EhS3xM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtqNMrAyCUzJ+c78gqtN2z4QNYFZsrRvau6lSh+iY/EQfq1s2IJku1XzN5qLCaons
	 toQyL6iqSsa+rrP8pl8LUd34nn8sbKElQkR6kPLJMvfblTSgcIOMmuDXiFrDtbMm/U
	 WZDXz2xCeRem5OFWBIHS6INCih7I4CGAZdzGre50dgixTqdZaUFoJjVPL779y23lve
	 EY/DNBe8biEMlytW0++8tm8t+bX9iqfjkfA0Bdm1v4/J9RNNb8UA1nKJyHQNDIZYyt
	 pkY4Er6hXDcstInkXa2JajIBHTtQKxqYT7HUaXZIINuku6lDc8OI4DpqzaKO+gD3I6
	 5Ybfd2dOOGGpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 16/19] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611224455.201994-17-irogers@google.com>
References: <20260611224455.201994-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 22:59:46 +0000
Message-Id: <20260611225947.593B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch claims to replace the python libaudit dependency for s=
yscall name resolution, but fails to actually update the target scripts to =
use the new API.
--

commit f73770fc51566b093a8761c15558720af551dc5f
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds syscall_name and syscall_id methods to the perf python
extension to support converting between syscall numbers and names. This
allows using perf's internal syscalltbl support instead of relying on the
python libaudit package.

> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
The commit message mentions avoiding the libaudit dependency in
tools/perf/scripts/python/syscall-counts.py, but were the updates to the
python scripts accidentally omitted from this patch?

The target scripts still import and use the audit module for syscall
resolution:

tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py:
    def syscall_name(id):
        try:
            return audit.audit_syscall_to_name(id, machine_id)
        except:
            return str(id)

Would it make sense to also update these scripts to use the newly introduced
perf.syscall_name API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611224455.2019=
94-1-irogers@google.com?part=3D16
