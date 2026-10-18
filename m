Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FE4AA3FF
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328602; cv=none; b=qQHsuiYaBRiXPirMC1z1lRv1NO5em+rIn/0rHOsxKD9b042enm9yVQDdjv4HKZ1O4okjiifhQ8NV6P5cVyPt/fBkHXo5tT8EoL8Tr4Lq+2KiXmASOQsHpiJTy/YUBeNHUwMSZqkYsfEdOfaBWjwKl8HUrfe72vhOm0xBVpVkL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328602; c=relaxed/simple;
	bh=0EPwV2o5VKJhzCSY8XBEE8XMHE+PpPIQeARK/mBkq0Y=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=rnEjsW5apuZ36pnNT1YPCy6/XP1+YM8NtN5FOLrgYN2ZyRv2+Ig64DPFGsvxMRhUpWPngiMKuDOLvJWVWYfHsngpzeakckH0KwoEuW/3bhCnE45OMXHr5UasFaaonE33JPeo85ZvV4sqdw5QphuRCYUCiEInADahZ9LVTKhy3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIreJi+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIreJi+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D802F1F000C4;
	Sun, 18 Oct 2026 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328597;
	bh=94THmX+4ctoLEkG10ryQzP6iribN3lnddOqvta9v7U0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GIreJi+h4zmdG5Gf4im9y+IQSqzmVsPUW2DqKGh46ama5bax7KbaOZo5G9E9lGdYH
	 Lohl07gKd+8WDHpLRYs6EwUagiKbRFocfHiyCq4JvfNDdT54Ebab2W/1On2sVvkxsf
	 4u5TAPL8FeAR8mWK+tTjKpWo6Juyh5MXixwItJffheUWVMas9/zOMXxy7GIGUPikF+
	 XwppH7od8prjSOJob0tZaPXEu3VDnmZCgPpRhAgiv7ACxA+kG4BBAIXyZcNDr0Y/1E
	 ZGNxc1I1NMp14cpkxa2bjmQdD0scB0+nRP2ztHoe5A3TSl0ue6+6N7IxiciUBlxsMV
	 JnJ7wg5kLbdSg==
Message-ID: <sashiko-outbox-176144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/5] perf/tests: convert check_no_patterns_found.pl
 to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018125641.23064-4-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018125641.23064-4-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:03:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf tests: check_no_patterns_found.py is unused and not install=
ed
- [Low] perf tests: missing EOF newline in check_no_patterns_found.py break=
s PYLINT=3D1
--

commit d6b15fdc56a31f78fa7365cb6aafd5034b2a393d
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

perf/tests: convert check_no_patterns_found.pl to Python

This commit adds a Python 3 implementation of check_no_patterns_found.pl
under tools/perf/tests/shell/common/check_no_patterns_found.py.

> diff --git a/tools/perf/tests/shell/common/check_no_patterns_found.py b/t=
ools/perf/tests/shell/common/check_no_patterns_found.py
> new file mode 100755
> index 0000000000000..0e5d931b903a2
> --- /dev/null
> +++ b/tools/perf/tests/shell/common/check_no_patterns_found.py
> @@ -0,0 +1,35 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0

[Severity: Medium]
Should this commit also update the existing callers, remove
tools/perf/tests/shell/common/check_no_patterns_found.pl, and install the n=
ew
script?

All existing call sites in the test suite still invoke
check_no_patterns_found.pl:

tools/perf/tests/shell/base_probe/test_adding_kernel.sh:
	"$DIR_PATH/../common/check_no_patterns_found.pl" \
		"$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err

tools/perf/tests/shell/base_probe/test_basic.sh:
	"$DIR_PATH/../common/check_no_patterns_found.pl" \
		"No manual entry for" < $LOGS_DIR/basic_helpmsg.err

tools/perf/tests/shell/base_report/test_basic.sh:
	"$DIR_PATH/../common/check_no_patterns_found.pl" \
		"No manual entry for" < $LOGS_DIR/basic_helpmsg.err

In addition, the install-tests target in tools/perf/Makefile.perf only
installs *.sh and *.pl files from tests/shell/common:

tools/perf/Makefile.perf:
		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/com=
mon'; \
		$(INSTALL) tests/shell/common/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/t=
ests/shell/common'; \
		$(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/t=
ests/shell/common'; \

Without updating the callers and Makefile.perf, check_no_patterns_found.py =
is
never executed or installed.

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    sys.exit(main(sys.argv[1:]))
> \ No newline at end of file

[Severity: Low]
Does the missing trailing newline at the end of check_no_patterns_found.py
cause a build failure when building perf with PYLINT=3D1?

In tools/perf/tests/Build, PY_TESTS collects all *.py files under tests/she=
ll
to run pylint:

tools/perf/tests/Build:
ifdef PYLINT
  PY_TESTS :=3D $(shell find tests/shell -type f -name '*.py')
  PYLINT_TEST_LOGS :=3D $(PY_TESTS:tests/shell/%=3Dshell/%.pylint_log)

Because main() in tools/perf/tests/shell/common/check_no_patterns_found.py
ends without a final newline (and without pylint directives or docstrings),
pylint reports C0304 (missing-final-newline) and fails the build when
PYLINT=3D1 is enabled.

Can a trailing newline be added at the end of the file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018125641.2306=
4-1-breno3011alves@gmail.com?part=3D3
