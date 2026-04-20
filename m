Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE99946C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645113; cv=none; b=VmecR6UR7Bhc61WzbwZmGBkujcrpHQusBtFaOu70seHlu1FcB/C+RVcdr6ivMutF0HzuD+auQBy6o8TaTNf99UhkA/zy9LUpWfIvOPR6ZvmEDlPzL/6jUxYRXdv9ZusmwibW3MEDnh88cPAJSTMivBTLsD3t2nv2jYz1svLQ/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645113; c=relaxed/simple;
	bh=kDtm/PRHGQosQvI2qcvl0ciHN6eRkK/kwvHqNut14xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ib1ugdJoLUlrqNc73hs9WEsFKg/jYmGihqmBnJpdXGoIVYQEwf0rqj2RWph7uArwiL20cFw/MXR4WK9KmVHEHkqU8lAiRLpP51aayyEmwUTzrKYAZD6a+3iPiramn1XZ7PoOEA/60LJaTwKeJ+AxFfvJT12eBiJ1EMAC+pd4hng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZmdrG7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZmdrG7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7579CC2BCAF;
	Mon, 20 Apr 2026 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645113;
	bh=kDtm/PRHGQosQvI2qcvl0ciHN6eRkK/kwvHqNut14xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hZmdrG7AEBoq+onfVFjgTNXsRKUUksvL4uD40lfULswlkp77fSuTCN5c0chMDqtaN
	 Ydwy/yNrXUWxzV+veIaFAyWRQTrgtBwwsXubYXbDmLcHsG5g8gUZBGItpMCsCjDMr+
	 IFL2nBRAPe/tiFmiXGGG6ZQYa4RNw71BBmVKfgxe5fnmouglDrZ80wuwZ3a6LLee38
	 hmftck6UrBlAHcsCBeH9a1yiRFJ1M2yxW32zbqIbf/HtFVQeqYOelgIMf8dEboBcL7
	 V0ODMDSC/qvcQ5Yjv64OecgkvE1d5YFUMcshq4g8aoUAdtrQAF44OPFNoHQC53PSqV
	 RT70N/NZLcmcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 33/58] perf check-perf-trace: Port check-perf-trace
 to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-34-irogers@google.com>
References: <20260419235911.2186050-34-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:31:52 +0000
Message-Id: <20260420003153.7579CC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script accesses a non-existent `sample_comm` attribute on `p=
erf.sample_event` objects, causing an unconditional `AttributeError` at run=
time.
--

commit c7ead2d8a935aefa471da2549e7433796e508f75
Author: Ian Rogers <irogers@google.com>

perf check-perf-trace: Port check-perf-trace to use python module

This commit adds a python script port of check-perf-trace that uses the perf
python module directly. This approach improves performance by avoiding the
creation of intermediate dictionaries for event fields.

> diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/ch=
eck-perf-trace.py
> new file mode 100755
> index 0000000000000..a5c6081c422c2
> --- /dev/null
> +++ b/tools/perf/python/check-perf-trace.py

[ ... ]

> +def print_header(event_name: str, sample: perf.sample_event) -> None:
> +    """Prints common header for events."""
> +    secs =3D sample.sample_time // 1000000000
> +    nsecs =3D sample.sample_time % 1000000000
> +    print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "
> +          f"{sample.sample_pid:8} {sample.sample_comm:<20} ", end=3D' ')

Will this raise an AttributeError when accessing sample.sample_comm?

The perf.sample_event C-extension wrapper implemented in
tools/perf/util/python.c does not appear to expose a sample_comm attribute
or property.

Because sample_comm is also not a tracepoint field, the dynamic fallback in
get_tracepoint_field() will likely fail, causing PyObject_GenericGetAttr()
to raise an exception and stop the script when processing the first event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D33
