Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914A1A256E
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450327; cv=none; b=s1kH2LE2Lpf8dCesULeTJDykQu63J9bI9tRZ237udAxkCEMS/1KHcaSBY+/DY5yCcajISTZnxRAiuA9o6iU2mC5QNROwmfzH1c67DcOZcaO6Q3aXYqDw6NLLHz9EgujAmQRlNceTQAtJnuIL21d4q/1EI+URhVGefNeUEqWZChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450327; c=relaxed/simple;
	bh=mHKk6zSrGypDDwTAVaaVdoBpgM0AX3AQXYx1zm0B3EQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g8TcK+S1N0sYAEBhSVn0+im8121j6N0xTcYYx9EMMhxhM8saWp20iG+mRMIYlbev7/IocR5EAbF/C3kisIWBooVMZS0Uf0PAr6RAo01R1tMv6ZG/E8yBx9AgiIylg4dUvr9Phqrj+jUJ6gAKaBpsKP56Lo3CeiO8Jhp0f1RgzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBXXokhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBXXokhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D571F00898;
	Wed,  3 Jun 2026 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780450326;
	bh=mHKk6zSrGypDDwTAVaaVdoBpgM0AX3AQXYx1zm0B3EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBXXokhioaPPZzwSPpsAAnl7cC7kgsSL2hL6lceUWEMN2l2tMfOtmvZ76K/6nD55Q
	 ES0FnyULNtSW4FPo0kLAKnhZZJxYO111hn/5v4OiuzjSKlos+wmqiWkS+yR8MMkI5V
	 vOIXeN6PsPuH//4xBlSy2zgbyTI4mdwSsnM7g56Bhz05OTvzi6xIJzXbKisREAWWmN
	 PNDniHxgiyOHbFgfL0PGJc2pJQ+VuHRFT+OHFR6+zBGUS+wAzqtCtYF5EfDTjHGJ5C
	 W6YPGJEp/tVV8XdI4g6awBJnFXlAE87LDray3ZbXdRiKpA6MRJG3/6vEFMzsfFPQgc
	 J6GS4Cculr61Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf test: Add file offset diagnostic test for
 corrupted perf.data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602235709.1541603-9-acme@kernel.org>
References: <20260602235709.1541603-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 01:32:05 +0000
Message-Id: <20260603013206.09D571F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded little-endian byte sequence causes the test to fail on=
 big-endian architectures.
--

commit af35d72bcb6cca8ee9ddf5a0da66e97329974342
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test: Add file offset diagnostic test for corrupted perf.data

This commit adds a shell test to verify that file_offset diagnostic messages
work correctly when perf encounters corrupted events. It intentionally
corrupts an MMAP2 event's size field in a recorded perf.data file and checks
that perf report produces a warning message that includes the file offset.

> diff --git a/tools/perf/tests/shell/data_file_offset_diagnostics.sh b/too=
ls/perf/tests/shell/data_file_offset_diagnostics.sh
> new file mode 100755
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_file_offset_diagnostics.sh

[ ... ]

> +# Copy the file and corrupt the MMAP2 event's size field.
> +# perf_event_header layout: type(u32) misc(u16) size(u16)
> +# Set size to 16 (0x10 0x00 little-endian) =E2=80=94 below the MMAP2
> +# minimum, which triggers the "event size too small" warning.
> +cp "${perfdata}" "${corrupted}"
> +printf '\x10\x00' | dd of=3D"${corrupted}" bs=3D1 seek=3D$((mmap2_offset=
_dec + 6)) conv=3Dnotrunc 2>/dev/null

[Severity: Medium]
Will this hardcoded little-endian byte sequence cause the test to fail on
big-endian architectures?

The test explicitly overwrites the 16-bit size field of a PERF_RECORD_MMAP2
event using the bytes \x10\x00. Since perf.data files are natively encoded
in the host system's byte order, on big-endian hosts (e.g., s390x) the
native u16 parsing of 0x10 at offset 0 and 0x00 at offset 1 will evaluate
to 0x1000 (4096).

Because 4096 exceeds the minimum MMAP2 event size, the internal validation
check is bypassed. This will cause perf report to skip 4096 bytes and
attempt to parse unaligned garbage data instead of emitting the expected
"too small" warning for the MMAP2 event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235709.1541=
603-1-acme@kernel.org?part=3D8
