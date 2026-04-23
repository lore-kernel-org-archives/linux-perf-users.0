Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A653612FB
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918305; cv=none; b=QPh+gcGznyjnV6+l6M+TFioisbiYvwbk5C2y+DN0IKcUYpgrMrQEvFqMH4e2J2BN3Ve87JOJblxI5pB/yepG9m5zSHdhs6GEX3R4cKpljavwh7HqZjlmg/F8kB/9j/R3TQQuIJcIb9g0/tJssGfLR9ChzW1ei4PDI5AfOONKkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918305; c=relaxed/simple;
	bh=ZEB1wtMwnQ09M50K1eBjNVAvpQ8YHDZTjRbZ66q5LGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xe4bTkgIN/OUCsZtZVDR7jAVfEJqiaVyLHwHCtlQvSpGefzK71UMxZTdrMaRaEvig91Ohvk3z8dFaPpz8HoSLRhAdFgXTFKBEkemFzI5uBw2lGPls9n86dHM5ENJFOZ4BRLp2z8IedVgJHdy4D1sq/OugcPW8bzOMRlksd29oOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftNjy/AS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftNjy/AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA6C2BCB2;
	Thu, 23 Apr 2026 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918305;
	bh=ZEB1wtMwnQ09M50K1eBjNVAvpQ8YHDZTjRbZ66q5LGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ftNjy/ASDe5oxHGCB4b5OKHuO2nwRgHVxsvDGTLuEji89OPkIZCb294qCsEoK/BCa
	 fD2VXSv/x5FzPtQf0ylAwdKPODVvd6MoIBwVlVYNZWZ8sZ05i72WMLHrGegaOR0YqR
	 Mu6Dvppn/PowMx1YHcbmIqOGynNxD9rjwoskfayRh3XvFCDr3VdYKI23L17deOL7Aa
	 zJhIDSDGkf3SkAUZXvap9SSSweHijRBma2MtvQ04cYyU/F1oIr2WBorT0q3KmcHV9p
	 +b6ZHrU4vEd0PvM4HV29UbP7YNKh6B1p9WC+7IfEbcMctJI+QuScierQVf9eZdmW9a
	 drVYiEK0Fgd6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/58] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-17-irogers@google.com>
References: <20260423035526.1537178-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:25:04 +0000
Message-Id: <20260423042505.7CAA6C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Hardcoding `EM_HOST` in the new Python API prevents cross-archit=
ecture trace analysis.
- [Medium] The new Python methods are artificially restricted by an incorre=
ct `#ifdef HAVE_LIBTRACEEVENT` guard.
--

commit 9353ccc90917e94e1031cafe3957fc3490c205f2
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name
   =20
Use perf's syscalltbl support to convert syscall number to name assuming
the number is for the host machine. Avoids python libaudit support as
tools/perf/scripts/python/syscall-counts.py requires.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 9cd7cca321aa1..d90aa24e53105 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2632,6 +2634,38 @@ static int pyrf_session__setup_types(void)
>  	return PyType_Ready(&pyrf_session__type);
>  }
> =20
> +#ifdef HAVE_LIBTRACEEVENT

Is it necessary to restrict these methods behind HAVE_LIBTRACEEVENT?

The underlying syscalltbl API has no dependency on libtraceevent, as it only
uses generated string arrays.

If perf is compiled without libtraceevent, perf.syscall_name will be omitted
from the module. When scripts like syscall-counts.py are later ported to
unconditionally call perf.syscall_name(), they will crash with an
AttributeError.

> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args)
> +{
> +	const char *name;
> +	int id;
> +
> +	if (!PyArg_ParseTuple(args, "i", &id))
> +		return NULL;
> +
> +	name =3D syscalltbl__name(EM_HOST, id);

Will hardcoding EM_HOST restrict the ability to perform cross-architecture
trace analysis?

Because EM_HOST is hardcoded and the API accepts no optional architecture
argument, scripts are prevented from correctly parsing cross-architecture
traces.

For example, analyzing an ARM64 trace on an x86_64 host will silently
map syscall numbers to the host's syscall table, leading to incorrect
output.

> +	if (!name)
> +		Py_RETURN_NONE;
> +	return PyUnicode_FromString(name);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D16
