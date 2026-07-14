Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DD4C77D6
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047179; cv=none; b=YGUP/QYcvd8LRN82h4rpNLBWrn4od9I1aOqmuD7Ed4m57UqoXC0yYRX5j8dhvuujc0nnaPpYI9UG/zhbgSCcyrUKg2bJNwuFH24Rw3u8kuNUCWd0Q8payTlRXiVnQXHDXaas0VVuTPGkoEx8jxnseck6UzpFOYXDc7JWrSGao+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047179; c=relaxed/simple;
	bh=BsFAI0vG4dzpXheb2SIx5xQInHitbcPaJpwKkelFepA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iF5C9t6ExIHqVyCSJwOeYsAb8OnHaS19FsPmo+k5whK5WzCssnAH3j8gqLk0L5f2wmzdhw8GD8d3PjQdgYP9d/+HliJU7ssQYEn8LoTmmx/oxmrcj308ddVM9BsVY9/+Ww/23t1waLdoxtZ5F2MnxV177hllyc5rCbkuhrSVvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqXQbwS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqXQbwS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7109C1F000E9;
	Tue, 14 Jul 2026 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047177;
	bh=VniDhwTam7KNDcwa7WCnCTRkeVFuzH9O5qOKtVpg9To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqXQbwS06RopsdcbQU2Plzo21+T0SIZEoYbo+NfGJtnUx5E/kGj6NqQ5pGioASHbe
	 /bdX2rQ91wKiw293cUuiX1HwhXa27VfOmjoSB6Aifh1ppfWzlKUKV8qgQYifHXL3PL
	 tXhYbXux1dEt20QPkukOL5lOsJrEtukk+j4uv/Zb6aNeLM9Ms9JrrwmEDT0AetdVQu
	 nWKUgCjt2e45smFMwXt1xexuLsTkHCk7gYaFu2o+xS+8oPuxxEttTbFOTlyudXTly+
	 d6beG+3PwKfYJY46Wx13Wq9vvL5ANlnH2qSSKCGhRES8eT6+UV4bFsg4h0M07EDxTv
	 fKIy7Ckrlc9yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: Add --bitmask-list option and correct
 cpumask formatting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714162947.214270-1-atomlin@atomlin.com>
References: <20260714162947.214270-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:39:36 +0000
Message-Id: <20260714163937.7109C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The cpumask byte parsing and bitmask rendering ignores the endia=
nness and word size of the trace payload, breaking cross-platform analysis.
--

--- Patch [1]: [PATCH] perf trace: Add --bitmask-list option and correct cp=
umask formatting ---
commit 3ae8add0cf042fd56dee83eecdf3dd3e5eeef32c
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Add --bitmask-list option and correct cpumask formatting

This commit corrects the parsing of dynamic non-array fields like cpumask_t
in perf trace to resolve raw pointers properly. It also updates the display
formatting for cpumasks to show zero-suppressed hex strings by default and
adds a --bitmask-list option for human-readable bitmask formatting.

Fixes: c5e006cdbd27 ("perf trace: Support tracepoint dynamic char arrays")

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ba0f8749fc7d7..cd75ac4e51693 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3238,17 +3239,65 @@ static size_t trace__fprintf_tp_fields(struct tra=
ce *trace, struct perf_sample *

[ ... ]

> +			if (trace->bitmask_list) {
> +				if (syscall_arg.len > 0) {
> +					unsigned long *mask =3D zalloc(BITS_TO_LONGS(syscall_arg.len * 8) *=
 sizeof(unsigned long));
> +					if (!mask) {
> +						pr_err("Problem processing %s field, skipping...\n", field->name);
> +						printed =3D saved_printed;
> +						continue;
> +					}
> +					memcpy(mask, (void *)val, syscall_arg.len);
> +					printed +=3D bitmap_scnprintf(mask, syscall_arg.len * 8,
> +								    bf + printed, size - printed);

[Severity: Medium]
Will this memcpy() and bitmask formatting break cross-platform analysis if =
the
perf.data file was recorded on an architecture with a different endianness =
or
word size than the host?

It appears we are doing a direct copy of the target payload bytes into a
host-native unsigned long array without utilizing evsel->needs_swap.

Could this result in garbled or reversed cpumask values when viewing trace
data from a machine with different architectural characteristics?

> +					free(mask);
> +				}
> +			} else {
> +				unsigned char *b =3D (unsigned char *)val;
> +				int i;
> +				bool skip_zero =3D true;
> +
> +				printed +=3D scnprintf(bf + printed, size - printed, "0x");
> +				/* Print in little-endian order */
> +				for (i =3D syscall_arg.len - 1; i >=3D 0; i--) {

[Severity: Medium]
Does this backward loop assume the trace data is unconditionally little-end=
ian?

If the trace data comes from a big-endian architecture, will this hardcoded
assumption fail to print the values correctly?

> +					if (skip_zero && b[i] =3D=3D 0 && i > 0)
> +						continue;
> +					if (skip_zero) {
> +						printed +=3D scnprintf(bf + printed, size - printed, "%x", b[i]);
> +						skip_zero =3D false;
> +					} else {
> +						printed +=3D scnprintf(bf + printed, size - printed, "%02x", b[i]);
> +					}
> +				}
> +			}
> +			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714162947.2142=
70-1-atomlin@atomlin.com?part=3D1
