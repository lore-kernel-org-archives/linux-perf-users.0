Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8843D47A0
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786914529; cv=none; b=I/VR8DNetpBZ0WA+Cxu75cWwLe1zdWxFkiVZ0KPCJvH6Y+ef4EF16LaNAe20lNR2BbGhDko8vbVuNM7aVB67BysCRkweyQWpGHvTc9NI0W8zTeebZe1uoMZ5ZIZc42Iy7IL4aT7UplUXX2cukFiEHHo7LwjaIT/8Yir6nhUSxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786914529; c=relaxed/simple;
	bh=F1Lf8JzTuR1Pzp5HHrvXi+5+rAj5TZXruym1QZlW/ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zg+eFQ/ROVCxOivJP8hcwWnFBPpSybP+WBTV/WhuZ1F9fqKVlvRyOQ6vMpPQw1AQcK91YPBCIGDF+Qz7zKRlUvJuD+czZ1vM3mHYF3OBLtrWZy9abSN02jKgKCGba/VYGlbZCsjcFD9igV/T5TGVguMOkzzuXLs3F4+LIjEHj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIZ93JIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIZ93JIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D6F1F000E9;
	Sun, 16 Aug 2026 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786914525;
	bh=VZtswvzWHtDqniICZB/LFFw1vluKqfZnP3ube2sfGQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QIZ93JInHPlF8SlJPjttjcgZIdpsl4w2EwyFNlpQA65ISpzW0TvApriH2JxYL0mwi
	 7DyNqeef+pMrfJP3Y7nHsGbB4tam8GWlzWRvPs5v4MAudiVwfhZao1C7KsnAwgOVIr
	 p4ALi95rMxXCZP1eSGUuTPgr5UqWA+DiMBAWtVGqMt8tREaaTNzhCAgLGFejRUV7gX
	 ef673L7gx3eX7oYWUATTrF2aiT83ZB7j1HtEyrBVcOig1TnP6gRTioG82iPfshriKF
	 k23MLZ0qjKq3jhubL/NZEhl84aXUO5p251GxDsuSGaWOr169KjTu3Ii1zwdtzkGUH2
	 uubIJosnaBRFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260816205921.576365-3-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
 <20260816205921.576365-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 21:08:45 +0000
Message-Id: <20260816210845.B5D6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The patch's commit message explicitly claims it will "register c=
ommon function pointer field names within the sorted syscall_arg_fmts__by_n=
ame lookup table." However, the code completely omits any modifications to =
this table and instead hardcodes the string comparisons inline into `syscal=
l_arg_fmt__init_array()`.
- [Medium] The hardcoded `field->size =3D=3D sizeof(u64)` check breaks 32-b=
it compatibility and cross-platform analysis for function pointers.
- [Medium] The hardcoded list of function pointer field names misses standa=
rd tracepoint fields like 'func' and 'callback'.
--

--- Patch [2]: [PATCH perf-tools-next v2 2/4] perf trace: Auto-assign kerne=
l symbol beautifier to function pointer fields ---
commit b4ca96eef1273e64d4ffedaf8b32cf198586f462
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Auto-assign kernel symbol beautifier to function pointer fields

This commit automatically detects function pointer fields in tracepoints by
name and type. It assigns the SCA_KSYM beautifier to them so they are
symbolised automatically instead of printing as generic hex values.

> Additionally, register common function pointer field names within the
> sorted syscall_arg_fmts__by_name lookup table. This ensures tracepoint
> arguments such as workqueue:workqueue_execute_start.function are
> symbolised automatically without requiring explicit per-event
> configuration.

[Severity: Medium]
Does the patch implement this update to syscall_arg_fmts__by_name?

The commit message explicitly claims to register names within this lookup
table, but the patch omits any changes to it and instead hardcodes the
string comparisons inline in syscall_arg_fmt__init_array().

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0030489465032..85abae09d328b 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2198,6 +2198,15 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt=
 *arg, struct tep_format_field
>  		    ((len >=3D 4 && strcmp(field->name + len - 4, "name") =3D=3D 0) ||
>  		     strstr(field->name, "path") !=3D NULL)) {
>  			arg->scnprintf =3D SCA_FILENAME;
> +		} else if ((field->type && (strstr(field->type, "(*)") !=3D NULL ||
> +					    strstr(field->type, "_func_t") !=3D NULL ||
> +					    strstr(field->type, "_fn") !=3D NULL)) ||
> +			   (((field->flags & TEP_FIELD_IS_POINTER) || field->size =3D=3D size=
of(u64)) &&

[Severity: Medium]
Does this field->size check cause a regression in 32-bit compatibility and
cross-platform analysis for function pointers?

On 32-bit systems, function pointers are 4 bytes, so field->size is 4. Since
sizeof(u64) is always 8 on the host compiling perf, this check fails on
native 32-bit systems or when a 64-bit host parses a 32-bit perf.data file.

> +			    (strcmp(field->name, "fn") =3D=3D 0 ||
> +			     strcmp(field->name, "function") =3D=3D 0 ||
> +			     strcmp(field->name, "callsite") =3D=3D 0 ||
> +			     strcmp(field->name, "call_site") =3D=3D 0))) {

[Severity: Medium]
Does this hardcoded list miss standard tracepoint fields like 'func' and
'callback'?

Tracepoints using common standard names for function pointers, such as 'fun=
c'
(e.g., in csd:csd_function, rcu, and wireless subsystems) and 'callback'
(e.g., in ipi:ipi_raise), will fail this name check and will not be
automatically symbolized by the beautifier.

> +			arg->scnprintf =3D SCA_KSYM;
>  		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name=
, "addr") ||
>  			   field_has_hex_fmt(field, len))
>  			arg->scnprintf =3D SCA_PTR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816205921.5763=
65-1-atomlin@atomlin.com?part=3D2
