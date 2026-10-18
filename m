Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70C3DCD86
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328534; cv=none; b=qSWQ5ceJFCRfnv/PwH3QYutlP4at/9YSFjzkYQEdZKtDp7qVqZPJ6ahEGQ3zpvqLbuFqoEEWNApUq/mt0RC907Gw+CvotSzGIq7Rs79v2Xi8tPtyjvrY7nAk06DWP31gaYNNx4RtnlQTaPlDKZk57LMGmmTkORS6ugyBEqVOdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328534; c=relaxed/simple;
	bh=JKriQ5V4jiSHJo1sgo0MTXBBOupixkTd5kC6XmdA/9Q=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=KCGXcoXRJ8Uu6FBr7+xhYdXce/jxQ4JRcJ20X/EAyyyPACcodKZ1BUwpkgcLtohnuJtjzckg5bzUa1l/BpYeevWxwij09zatU7QVjnaOnfAtnZ+gs3wIW+CWluxI9Csf/WnPzKKe/ScjtGpoR7VEjMsVT8/si8GPc4zVJnpBTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqy/tovh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqy/tovh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6131F000C5;
	Sun, 18 Oct 2026 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328530;
	bh=UQSzQ+FTbDej6/hqlYnRr5b8iotqdk74UIc2gz6rMSY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Nqy/tovhDuOod+t7fpp6z7dgePeEvnoT3+Dw2A5H9iZqIsnX1jT36Lu8+DivrnhuY
	 u3lr4W1c6NVDPBRnc9xB0fY2TCaI0u5vHQDkJ/uXvhI1Cxf1fDRwqfg6kdAKE+J4vJ
	 7NFLf8EryH0DEJy77sPlUHXEb3EqTtCXe9U2hyofEIfcJBvcaMXQ5Ir2FvHZ7dzlTB
	 ce+qqrwbU4yuB2kkhTauKGvsang0a1b0uvQs61ZleT/MvYGuA6OKGm3D7uFpXrcAlQ
	 tr0gjveINEV+XJQGXyKynZMo8TbbMzSBQGg6UR4fc9QqGqa2HVBXwFtXlM8qvGa+Am
	 wQ+YQFXV+H/YQ==
Message-ID: <sashiko-outbox-176142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] perf/tests: convert check_errors_whitelisted.pl
 to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018125641.23064-6-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018125641.23064-6-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:02:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf/tests: check_errors_whitelisted.py is unused and not instal=
led
- [Low] perf/tests: missing trailing newline in check_errors_whitelisted.py
--

commit f4ac81889a756943e8a2c98f2bfeb3dd3b8cd1a1
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

perf/tests: convert check_errors_whitelisted.pl to Python

This patch adds a Python 3 implementation of the error whitelist checker
script in tools/perf/tests/shell/common/check_errors_whitelisted.py.

> diff --git a/tools/perf/tests/shell/common/check_errors_whitelisted.py b/=
tools/perf/tests/shell/common/check_errors_whitelisted.py
> new file mode 100755
> index 0000000000000..352eb1a9dd06b
> --- /dev/null
> +++ b/tools/perf/tests/shell/common/check_errors_whitelisted.py
> @@ -0,0 +1,55 @@
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
Is this conversion complete? While this patch adds check_errors_whitelisted=
.py,
none of the callers in tools/perf/tests/shell/base_report/test_basic.sh are
updated to use it, and instead still invoke check_errors_whitelisted.pl:

    "$DIR_PATH/../common/check_errors_whitelisted.pl" \
        "$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_basic.err

In addition, the install-tests target in tools/perf/Makefile.perf only inst=
alls
*.sh and *.pl files from tests/shell/common/ and omits *.py files:

    $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/c=
ommon'; \
    $(INSTALL) tests/shell/common/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/tests/shell/common'; \
    $(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/tests/shell/common'; \

Should test_basic.sh and Makefile.perf be updated to use and install
check_errors_whitelisted.py, and should the old
tools/perf/tests/shell/common/check_errors_whitelisted.pl file be removed?

[ ... ]

> +    return 0 if passed else 1
> +
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(main(sys.argv[1:]))
> \ No newline at end of file

[Severity: Low]
Could a trailing newline be added to the end of
tools/perf/tests/shell/common/check_errors_whitelisted.py?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018125641.2306=
4-1-breno3011alves@gmail.com?part=3D5
