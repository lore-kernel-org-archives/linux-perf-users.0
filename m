Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07982DCF57
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918540; cv=none; b=Axgvxpmcp46vGdIhxER8XymuXAl/Lw6jOYuLBSShhxOlcm5pM3X56HM4fxwGCSuRpg+3pHSrpmtqf3Nclr89F4InvIPbLsR2Ou6KzYoV4dK6nua03PIvDsFDU9o26s3oGJ03HViYWSm9/P++e+Ny7rau+BS/PEb5ZJUl1ZThENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918540; c=relaxed/simple;
	bh=BOBUcAMU+9wAzMhPF11+/4w2xe+DUMvLN/MTloIpHnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ClPfz8+vUd3ejjs8djOfQm8rQ+OHC8c+97pB94WOGNy35z0zSPZPoO309vaf0r8kPEn4RsUujEMw1aaR3izGHB6bnwREWH+RlFgDakLio/qeU8e4redhTto5vlnbCR8Q91404TZCIbdOYcl3rl4qFynK0GXR3FaPTLFfRDSUfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3xyE181; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3xyE181"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8D0C2BCB2;
	Thu, 23 Apr 2026 04:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918539;
	bh=BOBUcAMU+9wAzMhPF11+/4w2xe+DUMvLN/MTloIpHnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=G3xyE181NBI3ckXpDC2q4BDwj708xaRilOI/qpqlJELSOjXdy3Z57JVDMQhsHts85
	 pvV/b0S30skaoRuH5vRnuwJIbQ+Ow/wGEHIDeqTSMcVMzkaNlYnt9BGfJpEJdEkB+A
	 RUa6NrK52/99z1ZQ1cbE+SXjQGD1rvRtO9Q7w7w4MZsPBgq/Zz2vmNa+U2WCpWnvbw
	 PSM5tXVEl0D8A/C7OU58qxUz3WawGs6nYb8gLtYpfp5M5X7QO4JUwqpO3g5RApm+If
	 hM4+zZnUdyoWjA0PWtyeICT0Cn2lTBb69hj73ooTErezEwESpddOX3fhYcaTfEZMRE
	 EpBxrw74qCNew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 48/58] perf rw-by-file: Port rw-by-file to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-49-irogers@google.com>
References: <20260423035526.1537178-49-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:28:58 +0000
Message-Id: <20260423042859.7D8D0C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Unconditional script crash due to accessing non-existent `sample=
.evsel.name` attribute.
- [Medium] Hallucinated tracepoints `raw_syscalls:sys_enter_read` and `raw_=
syscalls:sys_enter_write`.
--

commit e4f0d99904b4502561143e05b3d670fc00f299f5
Author: Ian Rogers <irogers@google.com>

perf rw-by-file: Port rw-by-file to use python module

This commit ports the legacy Perl script rw-by-file.pl to a python script
using the perf module in tools/perf/python. It uses the perf.session API
to track read and write activity by file descriptor for a given program.

> diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-fi=
le.py
> new file mode 100755
> index 0000000000000..f71e0b21f64ec
> --- /dev/null
> +++ b/tools/perf/python/rw-by-file.py
[ ... ]
> @@ -0,0 +1,103 @@
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D sample.evsel.name  # type: ignore

Will this raise an AttributeError and crash the script on the first event?

The Python perf.evsel object implemented in the C extension
(tools/perf/util/python.c) does not appear to expose a .name attribute.

Since this access occurs before the try/except AttributeError blocks below,
it seems this will bypass the exception handler entirely and halt execution.

[ ... ]
> +        if comm !=3D self.for_comm:
> +            return
> +
> +        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_e=
nter_read"):

Do these raw_syscalls variants actually exist in the kernel?

The kernel's raw syscall tracepoints are generic (like raw_syscalls:sys_ent=
er)
and do not have per-syscall variants.

Even if generic raw syscall tracepoints were used, wouldn't they carry an
args array rather than distinct named fields like fd and count? Attempting
to extract these fields from raw tracepoints later in this block would
likely result in missing attributes.

> +            try:
> +                fd =3D sample.fd
> +                count =3D sample.count
> +                self.reads[fd]["bytes_requested"] +=3D count
> +                self.reads[fd]["total_reads"] +=3D 1
> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sy=
s_enter_write"):

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D48
