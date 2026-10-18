Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334814ACC6A
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328876; cv=none; b=OMPlBaJX+mpuzTHSmJN8J+Tdiin3Mv6feDJjfF4GjBZ9RV9Vbh0tY76XyyUhm1+rlT5gdEZgUEk3wcQlmOIKRHEU+flG7TFZMtIjQnkz32NQmIFtzOCrs3laH8BWoD7ahnXMchy3p1qT1CIZghzeYw+xoevKA/udDvyjWpXT04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328876; c=relaxed/simple;
	bh=j2RYtmng2Tm+2G/4SGQo/rTTIzQOaq2AbhpggzehTFY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=dhhKXd/n22hbfMN8JvNRDPaQptrM6cdMuYH7VCMpwfaXUlVdZWGaEa8KmDLxrIWCR9Fih49O0dNwSRdoJ5oKkCIww4vvmrUWeOJ9RhmAawvQPAPRcHrDa/skUG6udJNg0nYCopqctaWppLuOt1wcs8Co4ck8njZbCmJ1bzfWi+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bglDiUOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bglDiUOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DBA1F000C5;
	Sun, 18 Oct 2026 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328875;
	bh=ou7AejRSx7sfFfuU6Km/SI+tUc3I05fhuwv4EUWmjVk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bglDiUOTEqI8Uraon6C5ucy+SdtzlkKtDSmjbHrtkRIPUqkdRoETpraNcoXkR4R9I
	 5v4I3ucWm9SNHuxTKdAsfxEIy64fCL1KJNV10zBVVdx05oH+wNyPYtQBajKG23rYfi
	 4sBwz5b/CG2CfRzRN2ge0qUS/e11jp7h2X32y9bSTtejrUBOYf8hJK4RKtA7VRuAYF
	 DDOUiNlpnKyJN4XNb1nodbaKhg4AIyyFEdNVqWv0DjN1/AdexcMq/bpUkPMaBDkjRJ
	 304771AnoyTDozQ9zdozgR6935VWzoAEHvpOwGNDkPbClICEsvjMXzDCOXYcfzljKi
	 CdQKX7BdeNFhA==
Message-ID: <sashiko-outbox-176146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] perf/tests: convert check_all_lines_matched.pl
 to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018125641.23064-5-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018125641.23064-5-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:07:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf tests: check_all_lines_matched.py is never wired up or inst=
alled
--

commit d9f6b313408b62305572a2fb532ed1583f0179f7
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

perf/tests: convert check_all_lines_matched.pl to Python

This commit adds a Python 3 implementation of
tools/perf/tests/shell/common/check_all_lines_matched.pl.

> diff --git a/tools/perf/tests/shell/common/check_all_lines_matched.py b/t=
ools/perf/tests/shell/common/check_all_lines_matched.py
> new file mode 100755
> index 0000000000000..352a56d8b9809
> --- /dev/null
> +++ b/tools/perf/tests/shell/common/check_all_lines_matched.py
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import os
> +import re
> +import sys
> +
> +
> +def main(argv):

[Severity: Medium]
Should this commit also update the existing callers and installation rules,
and remove tools/perf/tests/shell/common/check_all_lines_matched.pl?

Currently, check_all_lines_matched.py is added, but the shell test scripts
still invoke check_all_lines_matched.pl (which is also not updated in the
subsequent commit f4ac81889a75 in this series):

tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh:
		"$DIR_PATH/../common/check_all_lines_matched.pl" \
			"$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" \

tools/perf/tests/shell/base_probe/test_adding_kernel.sh:
"$DIR_PATH/../common/check_all_lines_matched.pl" \
	"$RE_LINE_EMPTY" "List of pre-defined events" \

tools/perf/tests/shell/base_report/test_basic.sh:
grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | \
	"$DIR_PATH/../common/check_all_lines_matched.pl" "systemd|init"

In addition, the install-tests target in tools/perf/Makefile.perf only
installs *.sh and *.pl files from tests/shell/common, omitting *.py:

tools/perf/Makefile.perf:
		$(INSTALL) tests/shell/common/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/t=
ests/shell/common'; \
		$(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/t=
ests/shell/common'; \

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    sys.exit(main(sys.argv[1:]))
> \ No newline at end of file

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018125641.2306=
4-1-breno3011alves@gmail.com?part=3D4
