Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CC4A99B7
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328545; cv=none; b=RoqfefqFODrllB7pWoTrb/6nTkvSHDB2pVwYLpRYpJhQ7o1rceFFjqRW5SrdsMB/FAFrkxMQiUEzSJBkkZ6UbGrwM2+DC1pxtqo3yVRmyPGD5RrQ0YrT9zsr1GXlYFesb0TVMccuv19ZibXwEDkO94I099+4+9Cjq8CPqjGXti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328545; c=relaxed/simple;
	bh=y5RcBAJAnrjq2z7PyyU5HRPQxE5D2SDKIRHvWhWeNSk=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=bicqm4bpxr6h7FFdikA1xdXGFugmAHGZ03xkLWpAYsW0g2NPnYnSvy3CgxZ8y0mC3ypd4LIi61IR31ZsKR0smDxUr9oNtzeXjDd7pqPXA0ZbE6Z6MnVp1XiFHOF7wFu4jAB22WGP1s+/FxkL8+9Pqfzo6Qa67IQ6x333OqxB3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdSb8zvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdSb8zvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231891F000C5;
	Sun, 18 Oct 2026 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328536;
	bh=mbkXq72qu+flmHGoUaMcMq83P83bnKR673QsEtKJQk0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YdSb8zvXn6TZWM3831faEoBKzwadf4w5rY6LoPpcs2gEUtPVJQzKGf5d7sWb2PU2C
	 xY7r0qWcg3FwLOHgvGOIK+xgt9am/3KGt9Y4oRLilWjWP9ADWkaAgVPQBc8pY8ayh/
	 pn3lM94owlYVLJev/Z0XZfpnqE+EFUMQr66vtMhTt978u/l6qYZQ1QGMkCaJekGmxV
	 WZVzCKZcrkMCGbdvWP/ORAQhKkDd3fAYgykAyjUSSFnJnFe6zrn59yKEs5IwS2yweK
	 zDnP7yf/2l0YUWP2MTUL0jM5OQdwgFjuFc+pmIPfD5K/yzJKwTVaWVnDi+XH8rXBZ7
	 hFKVs28vX6McQ==
Message-ID: <sashiko-outbox-176143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] perf/tests: convert check_all_patterns_found.pl
 to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018125641.23064-3-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018125641.23064-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:02:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: check_all_patterns_found.py added without updating c=
allers
--

commit 069a51b64d65753bb41f5e2b0b33fd3d38c715f2
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

perf/tests: convert check_all_patterns_found.pl to Python

This commit adds a Python 3 implementation of check_all_patterns_found.pl
under tools/perf/tests/shell/common/check_all_patterns_found.py.

>     perf/tests: convert check_all_patterns_found.pl to Python
>    =20
>     Faithful re-implementation of tools/perf/tests/shell/common/
>     check_all_patterns_found.pl in Python 3 (stdlib only). Same
>     regex matching, same TESTLOG_VERBOSITY/TESTLOG_ERR_MSG_MAX_LINES
>     environment handling, same exit codes.
>    =20
>     Verified byte-for-byte identical to the Perl version.
>    =20
>     Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

> diff --git a/tools/perf/tests/shell/common/check_all_patterns_found.py b/=
tools/perf/tests/shell/common/check_all_patterns_found.py
> new file mode 100755
> index 0000000000000..3eb907af3d6b2
> --- /dev/null
> +++ b/tools/perf/tests/shell/common/check_all_patterns_found.py
> @@ -0,0 +1,35 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import os
> +import re
> +import sys
> +
> +
> +def main(argv):
> +    quiet =3D True
> +    try:
> +        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >=3D 2:
> +            quiet =3D False
> +    except ValueError:
> +        pass

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    sys.exit(main(sys.argv[1:]))
> \ No newline at end of file

[Severity: Medium]
Should the callers, tools/perf/Makefile.perf, and the old Perl script be
updated as part of this conversion?

This commit adds tools/perf/tests/shell/common/check_all_patterns_found.py,
but tools/perf/tests/shell/common/check_all_patterns_found.pl is not
removed, and none of the subsequent patches in this series update the
callers or build system.

All 37 call sites across the 6 test scripts in
tools/perf/tests/shell/base_probe/ (test_adding_blacklisted.sh,
test_adding_kernel.sh, test_basic.sh, test_invalid_options.sh) and
tools/perf/tests/shell/base_report/ (setup.sh, test_basic.sh) still invoke
the Perl script directly:

    "$DIR_PATH/../common/check_all_patterns_found.pl" \

Also, the install-tests target in tools/perf/Makefile.perf only installs
.sh and .pl files from tests/shell/common/:

    $(INSTALL) tests/shell/common/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/tests/shell/common'; \
    $(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/tests/shell/common'; \

Without updating the test scripts and Makefile.perf, the new Python script
is unused and is not installed by make install-tests.

Additionally, the commit message mentions TESTLOG_ERR_MSG_MAX_LINES
handling, which is not present in either check_all_patterns_found.pl or
check_all_patterns_found.py, and the new file is missing a trailing
newline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018125641.2306=
4-1-breno3011alves@gmail.com?part=3D2
