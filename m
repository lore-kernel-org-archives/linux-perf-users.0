Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77036B932
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261255; cv=none; b=IwwD14cmHbJZu0/5k5NxM2/7RoxORKfhGdZixZ+uDz4SEfpHT/eCBail9Wp9GAlbYqcQZ/uNtdbgffayHlckkVWq80fMI5mY9VAyJWydkZW/hY9tlNS785RAm0AvIw1wzeTk6jDymTEPUOG2I5Y4TIRlZ1q1LWoXQunzuZ0Pt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261255; c=relaxed/simple;
	bh=BWwYLu7fCbZlFL3bfRdY8Oc/rOwiu8nFJEoQNynQKGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVDMoU7AyaRQnjYebmHeSKYo5fXlh+y6/qrXNLybK8+M/AArunWC7VMo8z3JSAkFcb7xeBO0XXwqDOhOy3xpUN/JjLOzGD0nX4siPNmSCgiu7FeO/Rsw70v6S+R6XYRTR+fUUnYNVw7o+Loosmwb2fG1CzkqdTB1d9Gl4WZM6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMlkgKYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMlkgKYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEE11F000E9;
	Thu, 20 Aug 2026 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261254;
	bh=ASfuuAEF3n3jTzTQ/KHLysMLAMp1Of/QT7AGBMvP0gI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lMlkgKYveZj0CR7Sj3pXo+o9bA2mqqbnCaP0y5dAJwbhVi/2DE+Y48VOONuXRb3Cr
	 UxMoHQcWZCg/rVNijtRm2BHQjYnIo9oQywlmCOLZ0IcDUWy6L0iquP8Fu+iWDp6Ilh
	 5h0LKDRuBUg0eBOsCCdbS1Qw+UUSfhElH6k5tkPuF4ATJPKhVbp24fn0jbVxDmKq36
	 sjUjufmhLnQONE8+Tflb6DBhkVM8QXD5SjhJc+5CCgO702JKJggYQKPBhprX2fyavP
	 5ZHWyrJzSq+k0+Nvx6W7Hf33S6jerGXV+O7Ayr93TMtVQW1I4ftoloIy3Ud5hpUu2F
	 Pi95LtfVxubgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 4/4] perf tests: Add shell test for
 kernel symbol beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820211100.649142-5-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
 <20260820211100.649142-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:27:33 +0000
Message-Id: <20260820212733.EDEE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BTF type routing test does not actually test BTF symbolizati=
on, as it silently falls back to the default kallsyms beautifier.
--

--- Patch [4]: [PATCH perf-tools-next v3 4/4] perf tests: Add shell test fo=
r kernel symbol beautifier ---
commit c8c43ea37c4e0f26131dd9e871af4241cd478b77
Author: Aaron Tomlin <atomlin@atomlin.com>

perf tests: Add shell test for kernel symbol beautifier

This commit adds a shell test script, trace_ksym_beautifier.sh, to verify
that perf trace symbolises kernel virtual addresses and function pointers
using both the default kallsyms beautifier and BTF type routing.

> diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf=
/tests/shell/trace_ksym_beautifier.sh
> new file mode 100755
> index 0000000000000..30a8429669dd5
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
[ ... ]
> +test_ksym_btf() {
> +  echo "Testing perf trace kernel symbol beautifier (BTF)"
> +  if [ ! -f /sys/kernel/btf/vmlinux ]; then
> +    echo "Skipping BTF test due to missing vmlinux BTF"
> +    return
> +  fi
> +
> +  output=3D"$(perf trace -e kmem:kmalloc --force-btf --max-events=3D1 2>=
&1)"

[Severity: Medium]
Does this actually test the BTF type routing as intended?

Looking at the kmem:kmalloc tracepoint, the call_site field is defined as an
unsigned long, rather than a function pointer. When trace__btf_scnprintf()
evaluates this, it determines it is an integer rather than a function
pointer, and returns 0.

This causes perf to silently fall back to the default SCA_KSYM beautifier.
Consequently, the test passes via the fallback path rather than truly
exercising the BTF routing.

Would it be better to use a tracepoint with a field explicitly typed as a
function pointer for the --force-btf test?

> +  if ! echo "$output" | grep -q -E "call_site: [a-zA-Z_][a-zA-Z0-9_]*" |=
| echo "$output" | grep -q -E "call_site: 0x[0-9a-fA-F]+"
> +  then
> +    printf "BTF function symbolization failed, output:\n%s\n" "$output"
> +    err=3D1
> +  fi
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820211100.6491=
42-1-atomlin@atomlin.com?part=3D4
