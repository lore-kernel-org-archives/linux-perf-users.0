Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96154652
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644456; cv=none; b=JSrhqy/0t8I3ZbSFdWrIMgtWRKgGEiI11t7Kuw7EBHVyri4XFd57fwkixvRpyNckA8qz6d6MZv97Tuj/TEKOXStPx/abZwJ9+LIGhtGsjBrWan0Od+30033w1Fo1XyIWzYzIM8U3Dpfn3bAH0YrbvBBHfbQ5ovjk17SJxiSkGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644456; c=relaxed/simple;
	bh=5xEqhXHrRuP5Vf+mwbdm+qSygjkDZGtFfYhOQ+EoqNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qszrpdbT7PcZsNu1XglC3kM4n8P0dKQERMi2xfA2Zh5iLWKcYfB97ZcSuKgLCTLcoyzrj4eagqEVxrudVSgPo1tA3CU2CC+qbecrpceBs9Mx8qg4XYF4sduQ4dq+CscYmz6nu84fl2aSlFZEdm2a0Tj5HmAh8fkRA9CmFV4w/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzDyzHPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzDyzHPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04CC2BCAF;
	Mon, 20 Apr 2026 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644456;
	bh=5xEqhXHrRuP5Vf+mwbdm+qSygjkDZGtFfYhOQ+EoqNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uzDyzHPbzA8IqaURf8zx981xf2miEuA5Skpf4epnJe9CkIp0ULh2X9YOVvC6IrxyF
	 V9vfny2eSW3svlGbsrq5RTJhqgS3VmUdvxLu8WjfLonZUu0nv175OYkVbYitm8lhr6
	 x7l5WlNhGgyd7Y6nXN9kMeREbNpjkjnBbNPx7b5yIcOuW/qePh/a3VLG4oHnIQXK7o
	 bLyPQUHgrmYcFbkb4NIx8CGnPhvO8eLKmaGpErWhfUcp8VjUWw9iEMFhAEl2YrhvOq
	 HYNUtSqbMOij2jK2LRJCF6lb5vYNEf+pqAUs+B7zsIeODPVHxYSpCXFL26nuPv0G+7
	 33Z47g6hK9CCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 26/58] perf mem-phys-addr: Port mem-phys-addr to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-27-irogers@google.com>
References: <20260419235911.2186050-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:20:55 +0000
Message-Id: <20260420002055.EB04CC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Usage of the Python 3.10+ `key` argument in `bisect.bisect_right` =
breaks compatibility with older distributions.
- [Medium] The script hardcodes the input trace file to `"perf.data"`, comp=
letely disregarding command-line arguments.
--

commit 22e68e7b074a4ff246baf1ab64fb15c29cdbff00
Author: Ian Rogers <irogers@google.com>

perf mem-phys-addr: Port mem-phys-addr to use python module

This commit introduces an example of using the perf python session API
to load a trace file and perform the behavior of the mem-phys-addr.py
script.

> diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-p=
hys-addr.py
> new file mode 100755
> index 0000000000000..17d6fd4f1a2bf
> --- /dev/null
> +++ b/tools/perf/python/mem-phys-addr.py

[ ... ]

> +def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> +    """Search iomem for the range containing phys_addr with the maximum =
indent"""
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        position =3D bisect.bisect_right(iomem[i], phys_addr,
> +                                       key=3Dlambda entry: entry.begin)

Will this crash with a TypeError on older Linux distributions?

The key parameter for the bisect module functions was only introduced in
Python 3.10. Running this script on older, widely-supported environments
like RHEL 9 (Python 3.9) or Ubuntu 20.04 (Python 3.8) might fail to
execute.

[ ... ]

> +if __name__ =3D=3D "__main__":
> +    def process_event(sample):
> +        phys_addr  =3D sample.sample_phys_addr
> +        entry =3D find_memory_type(phys_addr)
> +        if entry:
> +            load_mem_type_cnt[entry] +=3D 1
> +
> +            global event_name
> +            if event_name is None:
> +                event_name  =3D str(sample.evsel)
> +
> +    parse_iomem()
> +    perf.session(perf.data("perf.data"), sample=3Dprocess_event).process=
_events()

Does this ignore command-line arguments by hardcoding the input trace file?

By hardcoding perf.data here, the script ignores sys.argv and forces users
to ensure their trace file is named exactly perf.data and is located in
the current working directory.

Could this be updated to parse arguments and support dynamic trace files,
similar to how the original perf script implementation handled the -i
argument?

> +    print_memory_type()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D26
