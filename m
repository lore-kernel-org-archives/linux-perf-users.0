Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18203A1C9
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645672; cv=none; b=JfeyXn9H7VOgsdovCKVwdeJYBeYC3C+JBySZv1+5crPtMg+GM4poJ1Q0hzU7Ha0wuE0jBV+S1in49uKEd9ZN63tYDNDdi/Y0h95MVu2QSnaGZiBw52GaU4JS2ZZtLzjyvrVLlnyUws4bC86E2eBcj0mUuwWDrtCTMy2yP5yNMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645672; c=relaxed/simple;
	bh=qlZCxqFE1wLYjqkjwIv0Bnox3SXFoHHX4J3KkLndGns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CE5JPVBNdFIlXixmmLxYbHF7IHfTIKTv9C/+JM79ueyN8BGsqnVrbTuRhaqUdDB6Km5grl1sNcU0e0Igl0PW9YBnALZqlAcE0AENa4THkyaCWaH3Ht5vBm2QJek54W5vQxIQJvi9XH38SFsXQJ0Q/br+7dpM0RmYNsUl338v/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtg4cBJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtg4cBJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72364C2BCAF;
	Mon, 20 Apr 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645671;
	bh=qlZCxqFE1wLYjqkjwIv0Bnox3SXFoHHX4J3KkLndGns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gtg4cBJ76D64nOmcfnOik3uep9X+7oVfmmgwm4hLNkCE6uXoEpyUhvsS0Ssh7CvQZ
	 qcjA/NBlnSnrxjJwCO4yAiduKqgRSKW5p9210w+xx+99EXoLElk6iaOs/b/oWycMXu
	 nZ2MP4yxcKGKJdbJMv3yjPU8vLvAt54YYinxlILjxBfbMT9nZWBGQPHnstKFrC9a21
	 /rFaoZVukQdnq98mO2u7S9j4bW9lDtwdGWSqDbk+MJLm9Wfif6Im3mwX+od9uoJiEp
	 kxVMs1qLVeZgH1tKyyGE/lHw7N56F+LooAf2D9BYOzhLYK5yLcFn8+zOB2yHrX4EXa
	 o3dj9ZfTK6vHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 45/58] perf stackcollapse: Port stackcollapse to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-46-irogers@google.com>
References: <20260419235911.2186050-46-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:41:10 +0000
Message-Id: <20260420004111.72364C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Script crashes with a TypeError on samples without callchains du=
e to a flawed hasattr() check.
- [Medium] All samples are incorrectly grouped under an 'Unknown' process n=
ame because perf.sample_event lacks a 'comm' attribute.
--

commit 83683025e1c59392ea964951295fc45bfce78ff1
Author: Ian Rogers <irogers@google.com>

perf stackcollapse: Port stackcollapse to use python module

Modernize the legacy stackcollapse.py trace script by refactoring it
into a class-based architecture. The script uses perf.session for event
processing and aggregates call stacks to produce output suitable for
flame graphs.

> diff --git a/tools/perf/python/stackcollapse.py b/tools/perf/python/stack=
collapse.py
> new file mode 100755
> index 0000000000000..22caf97c9cac0
> --- /dev/null
> +++ b/tools/perf/python/stackcollapse.py
> @@ -0,0 +1,120 @@

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect call stack for each sample."""
> +        stack =3D []
> +        if hasattr(sample, "callchain"):
> +            for node in sample.callchain:

Does this code crash when a sample lacks a callchain?

The perf.sample_event object exposes callchain as a C API property descript=
or.
If a sample lacks a callchain, pyrf_sample_event__get_callchain explicitly
returns Py_None.

Because returning None does not raise an AttributeError,
hasattr(sample, "callchain") evaluates to True. The script then attempts
to iterate over None in the for loop, which raises a TypeError and
terminates the script.

> +                stack.append(self.tidy_function_name(node.symbol, node.d=
so))
> +        else:
> +            # Fallback if no callchain
> +            sym =3D getattr(sample, "symbol", "[unknown]")
> +            dso =3D getattr(sample, "dso", "[unknown]")
> +            stack.append(self.tidy_function_name(sym, dso))
> +
> +        if self.args.include_comm:
> +            comm =3D getattr(sample, "comm", "Unknown").replace(" ", "_")

Are all samples grouped under an "Unknown" process name?

The C extension's perf.sample_event type does not expose a comm attribute,
unlike the legacy perf script dictionary. Consequently, getattr will silent=
ly
and perpetually default to "Unknown", preventing proper process separation =
in
the collapsed output.

> +            sep =3D "-"
> +            if self.args.include_pid:
> +                comm =3D f"{comm}{sep}{getattr(sample, 'sample_pid', 0)}"
> +                sep =3D "/"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D45
