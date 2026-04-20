Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124382135AD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645708; cv=none; b=rq3pwxAL5eXIo4OvDIWUTc9tVHmjJpjsMHqzfEGwSHynBhDvJzadtoQMvSkoApc8bPK/47d45Y+e7C2RNiFnaWdzqSLEvxzToxKpoO83xEkGo4NmBMMXsYfgl8sTpmVsasNVEybgOdrl5mZ8ENEeTzpNzKIY1P0LBYm+VC1DcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645708; c=relaxed/simple;
	bh=o7bYxv6U4DpMQBSz5hJPQFmeIU1puJDREeSWL+x8czw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c0QwdBc5Z7XuZiHkUO7Ga6SB9mQzGjIUZehwq+X1oobD9B6wmCtTJbBUhzTUGZaFeaUhE/Gvpb14pSn9fLFHfaToRaF43rl4SR9nzLui5yyKzYkef6ZvUzPTItbjboOKTYvURl0ktga//jdC1TrF7i3Bt/yA5cNb2eVoeIcAQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swlpW150; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swlpW150"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91750C2BCAF;
	Mon, 20 Apr 2026 00:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645707;
	bh=o7bYxv6U4DpMQBSz5hJPQFmeIU1puJDREeSWL+x8czw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=swlpW150c8OKI5jbkawZiV8X9cP/WFPwkCf2FXIaaFR3I3dqLYD1u88ADt5UNGjC5
	 NknfdolaTJiEi8f5TGsyEnIfIlBjwkBjno/ESbcHDptW4f3rs31q3E0a2IN3X2i0pX
	 wKpaasDdalwQdB3jGw1o7SHzG0xVIr2gnV38pFOpR4J8iNlAVqvg6BA2gtJLUCYVBv
	 /O9uxLqOqgrojfEhhj8OUgc27/Um9yVQqMElsO+puTAWf/2TPk8BlrVkxzeyOHkXL2
	 YEJPnhRMHkxO0GudpQd/0T3SlB1xS3AGSwrPOQuyzL3lt6BszKmmTuh8/W0Kw63Zs/
	 J54TqP0M63H5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 27/58] perf syscall-counts: Port syscall-counts to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-28-irogers@google.com>
References: <20260419235911.2186050-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:41:46 +0000
Message-Id: <20260420004147.91750C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] The script crashes with a TypeError when a thread lookup fails dur=
ing 'for_comm' filtering.
- [High] The script crashes with a TypeError if 'perf.syscall_name(id)' enc=
ounters an unmapped syscall ID.
- [High] The script crashes with an AttributeError on older kernels where t=
he tracepoint field is 'nr' instead of '__syscall_nr'.
- [Medium] The standalone script hardcodes the input trace file to 'perf.da=
ta', breaking the ability to analyze arbitrarily named trace files.
--

commit 6f15d3f04b68eebb0fdc02fb0dd260ac9c6fdf6a
Author: Ian Rogers <irogers@google.com>

perf syscall-counts: Port syscall-counts to use python module

This commit rewrites the tools/perf/scripts/python/syscall-counts.py script=
 to
use the python module directly. This avoids the overhead of executing via p=
erf
script, improving execution performance.

> diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/sysc=
all-counts.py
> new file mode 100755
> index 0000000000000..a2e0994ab7369
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts.py

[ ... ]

> +def print_syscall_totals():
> +    if for_comm is not None:
> +        print(f"\nsyscall events for {for_comm}:\n")
> +    else:
> +        print("\nsyscall events:\n")
> +
> +    print(f"{'event':<40} {'count':>10}")
> +    print("---------------------------------------- -----------")
> +
> +    for id, val in sorted(syscalls.items(),
> +                          key=3Dlambda kv: (kv[1], kv[0]), reverse=3DTru=
e):
> +        print(f"{perf.syscall_name(id):<40} {val:>10}")

What happens if perf.syscall_name(id) returns None for an unmapped syscall
ID?

Applying a width specifier (<40) to a NoneType object throws a TypeError,
which will abort the output. Should there be a fallback mechanism, such as
using the numeric ID when the name is unknown?

> +def process_event(sample):
> +    event_name =3D str(sample.evsel)
> +    if event_name =3D=3D "evsel(raw_syscalls:sys_enter)":
> +        id =3D sample.id
> +    elif event_name.startswith("evsel(syscalls:sys_enter_"):
> +        id =3D sample.__syscall_nr

On some older kernels and architectures, the tracepoint format field for
syscalls is named nr instead of __syscall_nr.

Will accessing sample.__syscall_nr raise an AttributeError in those
environments? Is it possible to check for nr as a fallback?

> +    else:
> +        return
> +    if for_comm and session.process(sample.sample_pid).comm() !=3D for_c=
omm:

If a thread lookup fails (for example, for short-lived processes or samples
recorded before procfs synthesis completes), session.process() returns NULL
and sets a Python TypeError.

Can this uncaught exception bubble up and cause the script to crash?

> +        return
> +    syscalls[id] +=3D 1
> +
> +
> +if __name__ =3D=3D "__main__":
> +    ap =3D argparse.ArgumentParser()
> +    ap.add_argument("comm", nargs=3D"?", help=3D"Only report syscalls fo=
r comm")
> +    args =3D ap.parse_args()
> +    for_comm =3D args.comm
> +    session =3D perf.session(perf.data("perf.data"), sample=3Dprocess_ev=
ent)

The previous implementation running under perf script automatically support=
ed
standard options like -i my_trace.data to override the input file.

Since the file path is now hardcoded to perf.data, does this introduce a
regression in usability by preventing the analysis of arbitrarily named
trace files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D27
