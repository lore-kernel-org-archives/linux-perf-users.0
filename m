Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A14A2A78
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328503; cv=none; b=VnR9RALzZ2guiFJs7B2uln2RJaTJhs7LHXi8zEgteWvz26DwCUdS43Z5ZeNHK2TfEKSxLeVCCkTdDTum7nyzRS2ocibnj8xtmFMesNxqcS0SdRK1PJROjbf3vEKKLhOKRPGVptFbhIp+/PyvHCVTDuSPo3s0m6mZgdQxl2fbWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328503; c=relaxed/simple;
	bh=Y+Fhoms6r2wV1PCSlnE41n/I4zMPTRwJGfPcNZj+UoA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=OEuzQ73I5e1GVrIWihE95sIWHFLwKzJHmTUVyKrY3Wmw3NpAQQJLCNIdAuJLaqnIuFWgRqlw3ilUYs/BU/qCRqrqRJ+A30hpen7c8lITyu5NTI4PfmDTokVot1tz6o3B/sWkqCCMdIyWbqRkPioVY24OC27JmDlmNn6lYDf81K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUTxldeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUTxldeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FEF1F000C7;
	Sun, 18 Oct 2026 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328500;
	bh=JQZbNMK2/23/3moJecKUSQjZfgruauJJjgXgs8NKcjY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YUTxldeoSJ5xqNZOFczyCgKzZZgHtbtKk/N4lSYpZuTuRA1RKs+xIotuKc6karXnC
	 krZv7e0CW76EpWUi6K3aBPt/yZubpcHjblZvC5aD2VBvNOsOjk4jkp8i2YtdjLkhnf
	 KCPjjwuW59Z1lvVQ1SIlLREiG2/L0tIvaFr/JpMCvTJ/H4rifjOIyQHWR7DJNPIrvM
	 9LzoMwTRts3Snr9csbu18TdmCJfZAltNWglT92QHe//XxPtpgcqYFzfH1lKN8HLNEc
	 VS3tSXkKfj8aTjZ4d/JN/yhhxaehalA51RmdB48jIlg++cvSC0KOtUHVBDk9qAjMr7
	 KRSlDdnnemN5A==
Message-ID: <sashiko-outbox-176141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] perf/kselftest: convert prefix.pl to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261018125641.23064-2-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
 <20261018125641.23064-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:01:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: prefix.py is unused and not installed by Makefile or =
runner.sh
- [Low] selftests: missing trailing newline at end of prefix.py
--

commit f99bbafab30726cd18857c0cc9a21eeae2499158
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

perf/kselftest: convert prefix.pl to Python

This commit adds a Python 3 re-implementation of
tools/testing/selftests/kselftest/prefix.pl to prefix input lines with
"# " in an unbuffered manner.

> diff --git a/tools/testing/selftests/kselftest/prefix.py b/tools/testing/=
selftests/kselftest/prefix.py
> new file mode 100755
> index 0000000000000..2bf16b37dee63
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest/prefix.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Prefix all lines with "# ", unbuffered.
> +
> +import sys
> +
> +
> +def main():

[Severity: Medium]
Should tools/testing/selftests/kselftest/runner.sh and
tools/testing/selftests/Makefile also be updated to use and install
prefix.py, and remove prefix.pl?

Currently, tap_prefix() in tools/testing/selftests/kselftest/runner.sh
still checks for /usr/bin/perl and invokes prefix.pl:

tap_prefix()
{
	if [ ! -x /usr/bin/perl ]; then
		sed -e 's/^/# /'
	else
		"$BASE_DIR"/kselftest/prefix.pl
	fi
}

And the install target in tools/testing/selftests/Makefile still only
installs prefix.pl:

	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/

Without updating those callers, prefix.py is never executed or installed.

> +    needed =3D True
> +    while True:
> +        char =3D sys.stdin.buffer.read(1)
> +        if not char:
> +            return 0
> +        if needed:
> +            sys.stdout.buffer.write(b"# ")
> +            needed =3D False
> +        sys.stdout.buffer.write(char)
> +        sys.stdout.buffer.flush()
> +        if char =3D=3D b"\n":
> +            needed =3D True
> +
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(main())
> \ No newline at end of file

[Severity: Low]
Could a trailing newline be added at the end of
tools/testing/selftests/kselftest/prefix.py?

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018125641.2306=
4-1-breno3011alves@gmail.com?part=3D1
