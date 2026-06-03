Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062D2882DE
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482972; cv=none; b=JQ9NNjUiqsyB7dxwGgmf4MpGLqIVEjxozGiQs5wW8ZdcHzQePoj/PVWD/LZSiZxwhjVBnag3gmI1GgnliTtnVsh6ECPyznMi8EVruWyAT6PctDczGLpfqpag6RJXyS9ydwMVxHDBnFlTRuHndQQcXfaVOenXt3BeY1U0cBOG5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482972; c=relaxed/simple;
	bh=8mzVM7/WPaBWQqj0YJfIV5edDYMaCV7mpUo965FOumM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WUSs2fp/WkIb7d0FdJ26Nchtmr8YSW7YtKFW0iU+QmkE2riEGrebH4M0ZYPpjq6nlvJo1tHwPZDoOvouhzB05tHU1Z695SghCiJri8StSySgRbyrhfV9jfSFqWXbxbwXd+ukJFLJtP7e+/sD9hUdKcZT3jb/wiM9pDWvRfgpmKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5v2dedN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5v2dedN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1221F00893;
	Wed,  3 Jun 2026 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482971;
	bh=FO9MUcqi4YqBUDuD+zAwN5DHhxEqU6YLLLTm3gqucbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5v2dedNl/8RE7B4seQD7UxM5t3dKW4DCUIbFhOSQ2vrfkwpw9CfuoekMy+bAy5O3
	 2TYb4aEAGiFMPHn/qfm+3q63N9Q36DoHVcKGGaNvSeOjSgK0vojFjaCN8ntgZDEDdS
	 9fQ8kvhGfOLEEqPcL7qvv3KNuDA5GcOm6RqPC0DGgu/rMJrTPQJQiZOE0RJr2GqwGX
	 c4lyscQ1HOBR6lqs5Ukwkr96v8Egkqd4jRDmM52W4pa8jXLqmxQNs7N19Mg6bB8Hz9
	 Frul/gl8I2uzy4tM0fXZ5WPYw2Ok2BiQgME9ODX8J56QgcbMCGQiUK8yjV0RePp7q/
	 1u2YumUDk9SJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/19] perf test cs-etm: Make disassembly test use
 kcore
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-16-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-16-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:36:09 +0000
Message-Id: <20260603103610.2E1221F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The arm-cs-trace-disasm.py script fails to use the explicitly pr=
ovided kcore file for dynamically loaded kernel modules, silently falling b=
ack to the unpatched build-id ELF.
--

commit fb1d5bc3ba8d47081f18c5b9c0c07af6646b6389
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Make disassembly test use kcore

Hits in modules return empty disassembly with vmlinux as an input to objdum=
p.
Make the disassembly test more reliable by always using kcore. And update t=
he
comments to say that this is supported by the script.

> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/per=
f/scripts/python/arm-cs-trace-disasm.py
> index ba208c90d6311..8f6fa4a007b42 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -18,29 +18,29 @@ from perf_trace_context import perf_sample_srccode, p=
erf_config_get
> =20
>  # Below are some example commands for using this script.
>  # Note a --kcore recording is required for accurate decode
> -# due to the alternatives patching mechanism. However this
> -# script only supports reading vmlinux for disassembly dump,
> -# meaning that any patched instructions will appear
> -# as unpatched, but the instruction ranges themselves will
> -# be correct. In addition to this, source line info comes
> -# from Perf, and when using kcore there is no debug info. The
> -# following lists the supported features in each mode:
> +# due to the alternatives patching mechanism. In addition to this,
> +# source line info comes from Perf, and when using kcore there is
> +# no debug info. The following lists the supported features in each mode:
>  #
>  # +-----------+-----------------+------------------+------------------+
>  # | Recording | Accurate decode | Source line dump | Disassembly dump |
>  # +-----------+-----------------+------------------+------------------+
>  # | --kcore   | yes             | no               | yes              |
> -# | normal    | no              | yes              | yes              |
> +# | normal    | no              | yes (inaccurate) | yes (inaccurate) |
>  # +-----------+-----------------+------------------+------------------+

[Severity: Medium]
While this commit advertises kcore support, does arm-cs-trace-disasm.py
actually use the kcore file for dynamically loaded kernel modules?

Looking at get_dso_file_path() in
tools/perf/scripts/python/arm-cs-trace-disasm.py, if a module (e.g., [ext4])
is encountered, it bypasses options.vmlinux completely and attempts to use
the unpatched ELF from the build-id directory:

	if (dso_name =3D=3D "[kernel.kallsyms]" or dso_name =3D=3D "vmlinux"):
		if (options.vmlinux):
			return options.vmlinux;
		else:
			return find_vmlinux() if find_vmlinux() else dso_name

	if (dso_name =3D=3D "[vdso]") :
		append =3D "/vdso"
	else:
		append =3D "/elf"

	dso_path =3D os.environ['PERF_BUILDID_DIR'] + "/" + dso_name + "/" + dso_b=
uild_id + append;

Additionally, if get_dso_file_path() were changed to return the kcore file
for modules, would process_event() still fail?

process_event() sets dso_vm_start to the module's map start address:

		if (dso =3D=3D "[kernel.kallsyms]" or dso_start =3D=3D 0x400000):
			dso_vm_start =3D 0
			map_pgoff =3D 0
		else:
			dso_vm_start =3D int(dso_start)

The subsequent read_disam() call then subtracts this from the sample address
to pass relative file offsets to objdump. This works for module ELFs but
breaks kcore, which requires absolute virtual addresses.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D16
