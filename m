Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66197269D18
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254485; cv=none; b=mI9Rqfs86rxaZN+va0AbEKLlpKHTu4ROROywDQM3egPvOjPGutXPw/KwlPPrOptfETr0wafrlH6lmse4zxSrjCtDLqX0z7euDhSBYHVzLCVTuJ/fjACsoUsEhmoKVm0xa8I5D04peAwAnFWayemMQIllf13I4IAz1tgki/QM13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254485; c=relaxed/simple;
	bh=zgsfxp8HusqYq10eb/Hu9avq2T9WBK5TbBv+veut81Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mg9Q8dxTO4Xuwn9tBp9ecP1p1e34GS0DMLHxeule5y5Tqumu6bv3KHWkrKmLipZfOCJ33jxPa30dFjGpss2PKb5JgDxWHInPmIGGVfq8cJLBCqdp+KxfEQl23btR+8dxrPyznFDVzxUejXO3JRSEEnTTXgA5dDaDa5Bt+2T0G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BESO2AqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BESO2AqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0883E1F000E9;
	Tue, 23 Jun 2026 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782254484;
	bh=gX7QNJXRg37LLYw9ZlRq+ZfQUVmzwVNRbro+Yf//jPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BESO2AqSNLFd5EPDDknMIKbJLmZ/TIBRn6GAhFrCB0UCHXCHVcL4cIiwvn3ZnnwGK
	 pOb9cKJrwoz/s/DrUuzKZ4GJoV9/T4/MBrE+Yn0OXcb0dDaephWcfrmn4wCQtSXaIP
	 BUGDYq6hQ3/ibJEsqFMKrVsuAmw02HvV8kzA7WSOtboR1s3GcK86EnrtUocOcWi02l
	 zC2EE72f2INkZZN5eqXGzdIAoqoG1QzzmIVktT2rVSfwWp8oYjowWmkUeL+ja36aqi
	 6pBTHgEHXx52AWG1dqV6++3asSDNd0VLsfYug5+dAFj6U4gkyjWi0nkFenL8Y7md7J
	 XeN5rDTgwEQ2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/13] perf python: Fix MetricGroup return type in
 perf.pyi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-14-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:41:23 +0000
Message-Id: <20260623224124.0883E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but local references=
 to the Python objects 'key' and 'value' in `pyrf__metrics_cb` are leaked o=
n the success path.
--

commit 0b60b233b211850d4730f46ab4faf2da85366d5f
Author: Ian Rogers <irogers@google.com>

perf python: Fix MetricGroup return type in perf.pyi

The metrics() function can return a dictionary where the value is either
a string or a list of strings, so the type signature in the stub file
should be Union[str, List[str]].

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> index f266c9baffd01..58b0b3ed819d8 100644
> --- a/tools/perf/python/perf.pyi
> +++ b/tools/perf/python/perf.pyi
[ ... ]
> @@ -12,7 +12,7 @@ def config_get(name: str) -> Optional[str]:
>      """
>      ...
> =20
> -def metrics() -> List[Dict[str, str]]:
> +def metrics() -> List[Dict[str, Union[str, List[str]]]]:

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the return
type update for metrics(), I noticed a potential resource leak in its C
implementation.

Looking at tools/perf/util/python.c:pyrf__metrics_cb():

	if (!value || PyDict_SetItem(dict, key, value) !=3D 0) {
		Py_XDECREF(key);
		Py_XDECREF(value);
		Py_XDECREF(dict);
		return -ENOMEM;
	}

	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||

Does this leak the local references to the Python objects 'key' and 'value'
on the success path?

Since PyDict_SetItem() does not steal references, it appears that 'key' and
'value' might need a Py_DECREF() after a successful insertion. Without it,
a script repeatedly calling perf.metrics() could continually leak memory.

>      """Get a list of available metrics.
> =20
>      Returns:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D13
