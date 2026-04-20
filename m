Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97381A6807
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645007; cv=none; b=MuQBmNsWBddQk6u2YfAIXKRHwTGUmC5o1LjxXSAj4WdxNASojGfq2hNyoauXZ1T9hb2UCTXy+otl9Nljn5gXwj1ueiOJSK+heK2LUja+/LdPF/KCBfcYwqTrHROWNL3SyBlQYettiKREH316UCdCa7cKLYTwDsUu2r5ffA0249g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645007; c=relaxed/simple;
	bh=OtT/LmLd+h5d5F+sSAjm9kuFZZYaQrsISBvIF/jSKi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXQ9/dkvjrZyUDT8iIo84hFy3ynlS4yGaL2fFtVKZp6iNPda5m44bFikMepXdl4blfIEum/3upg8zew/mB64EJ8CP2WWtAvhr12Xdyg1u5anUiZFx45+rzPKppRpzZ4Vj7x/eBumU6CHqlZWn3XAFxIUN6XiSODcnBOCpnEAU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2ktxOBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2ktxOBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C42C2BCAF;
	Mon, 20 Apr 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645007;
	bh=OtT/LmLd+h5d5F+sSAjm9kuFZZYaQrsISBvIF/jSKi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=m2ktxOBos6G7SIirqLUDGQnaWizLPdBUqyMh4qerO3vajUdahpkkzYPMhsxJnhKhA
	 xPplILVBt1rYtINYG7x5gMH9Pcl/TjYXP26p1Qo2JVPtB3xVmmifUpfZ0j5DcPgo32
	 gRVcpL/QhdI0jZWmFUygwaguFWzknSCBRXp7wHpwdj5FPur310uz87kxDEPzOGmLq3
	 vdU6wcshfip0iBnoZYG50w3k8x2v5LTP1LELk+e5iXYxZCyblSTfQxvt6B1Rr1TThj
	 bUdvNNuJH2aXyU2l12gHzXtoNWPOvLnN0cLz8BFQXIrFKTzZDsFNKxJBZvs2Wtuqzk
	 kT3L42i+JpDRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 34/58] perf compaction-times: Port compaction-times
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-35-irogers@google.com>
References: <20260419235911.2186050-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:30:06 +0000
Message-Id: <20260420003007.63C42C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Accessing `sample.sample_comm` crashes the script with an Attribut=
eError because the property is not implemented in the `perf` Python C exten=
sion.
- [High] Calling `.filter()` on a Python function object causes an Attribut=
eError, crashing the script when a user supplies a filter argument.
--

commit e19ed9f5bdaeeb7d6732e01b049d84fb4e856fc0
Author: Ian Rogers <irogers@google.com>

perf compaction-times: Port compaction-times to use python module

This commit adds a port of the compaction-times script that uses the perf
python module directly to improve performance by avoiding intermediate
dictionaries.

> diff --git a/tools/perf/python/compaction-times.py b/tools/perf/python/co=
mpaction-times.py
> new file mode 100755
> index 0000000000000..352e15ddd5f99
> --- /dev/null
> +++ b/tools/perf/python/compaction-times.py

[ ... ]

> +    @classmethod
> +    def create_pending(cls, pid: int, comm: str, start_secs: int, start_=
nsecs: int) -> None:
> +        """Create a pending node for a process."""
> +        filtered =3D False
> +        try:
> +            head =3D cls.heads[pid]
> +            filtered =3D head.is_filtered()
> +        except KeyError:
> +            if cls.fobj is not None:
> +                filtered =3D cls.fobj.filter(pid, comm)

Does calling .filter() on cls.fobj cause an AttributeError?

The helper functions get_comm_filter() and get_pid_filter() return standard
Python closures (functions) rather than class instances.

Since a function object does not have a .filter() method, it appears this
will crash the script when a user supplies a filter argument.

Should this be invoked directly as cls.fobj(pid, comm)?

> +            head =3D cls.heads[pid] =3D Chead(comm, pid, filtered)
> +
> +        if not filtered:
> +            head.mark_pending(start_secs, start_nsecs)

[ ... ]

> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
> +    event_name =3D str(sample.evsel)
> +    pid =3D sample.sample_pid
> +    comm =3D sample.sample_comm

Will accessing sample.sample_comm crash the script with an AttributeError?

The perf Python C extension does not implement a sample_comm member or
getter in pyrf_sample_event__members or pyrf_sample_event__getset.

The underlying tracepoint exposes the command line string as common_comm,
which can be accessed via dynamic tracepoint field resolution.

Because this property is missing, accessing it will raise an AttributeError
on the first processed event.

> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D34
