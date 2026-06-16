Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CE248886
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574864; cv=none; b=AT6z0l++HIPBeFSxkMjazgkpekxsc1kv97Gcje4rl3WnTO5kBSTSuRpydMI1BaDNZQy4i0+y+mCK5yH5hR/O3n/QFBmofImTV42E3MDAbz3rHXuxjDN4KxeKDTejlDuPWSc1kt6rv7InvnQE9km/cLp938mthjqXna7Ajz0oRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574864; c=relaxed/simple;
	bh=U31/kGTpU463zB/h9sHmSpKdPO5ZsVwNIleB5G056Vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aQgKfGsb1vZx6EigiDNQ67oUwhhmTNwcJc4ge2kY/o3/pnRKJK5QTYWzCj+kqzzhg5c6cV9EwZgtsQMvHRWZhzbdjzZxbxRcu8ni+5DCjzhU/C8CZEMlW39g95x5sWUForH+VMtPhCZik5qysUPZ1rIiGYSeSs5tz64PSC0g/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZd2zTZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZd2zTZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6DC1F000E9;
	Tue, 16 Jun 2026 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574863;
	bh=E2ZTGBVZi953FY5ortuwWYBkELE+CFfuoSqNHtKSUqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZd2zTZ23sZULj3yZwnr0s1g+fiGJVkAVhBZ6eNCLSF+2DApcvBAzxjxIFIJ13jPf
	 mn5odrrI0XyAamgAuny499AGcKmxkaxRwyiq69FkfztvuDgBUQ05rCZoAcRpCnwUs8
	 GyZxAIeGyN/gV57Lpyk+NuOi5ZNQWWonk0eaHc083IhiNEzir4pzW8CR40UIx8uwFv
	 FUQpd7f3wYjg6JMBQ70FaVyvkHLnnB1n2OUg3DgA07Sa0aVCCaJ47kQMHjvmCb6uZz
	 VgClYyjxrPt1Vm+iEJ7enDmHX0yaxADlR8zX/T2N7BreaZBjRfOvtELkfHC6FOVZg5
	 k0OmCQjLsr/sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf trace: Guard __probe_ip suppression with
 evsel__is_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616013157.38960-3-acme@kernel.org>
References: <20260616013157.38960-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:54:22 +0000
Message-Id: <20260616015423.0B6DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `evsel__is_probe()` check evaluates to false for Ftrace dynami=
c probes, breaking the intended suppression of the `__probe_ip` field.
--

commit 0e15cda4a40a59d474ee0a3a5cdae64267b1f3b2
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf trace: Guard __probe_ip suppression with evsel__is_probe()

This commit adds an evsel__is_probe() check to trace__fprintf_tp_fields()
to skip the string comparison of __probe_ip for non-probe events.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a8492da23a9cc..57f3f14c5d435 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3267,7 +3267,7 @@ static size_t trace__fprintf_tp_fields(struct trace=
 *trace, struct perf_sample *
>  		 * If verbose mode is enabled, ensure it is formatted as a
>  		 * hexadecimal memory address rather than a signed integer.
>  		 */
> -		if (!strcmp(field->name, "__probe_ip")) {
> +		if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {

[Severity: High]
Does this check accidentally disable the suppression entirely for Ftrace
dynamic probes?

Since trace__fprintf_tp_fields() processes fields specifically for tracepoi=
nt
events (where evsel__tp_format() succeeds), the event has type
PERF_TYPE_TRACEPOINT. For these events, the PMU name is "tracepoint".

However, evsel__is_probe() resolves the probe type by checking if the PMU
name is "kprobe" or "uprobe". If it evaluates to false here because the PMU
is "tracepoint", the condition short-circuits and the __probe_ip field is
no longer suppressed.

Will this cause __probe_ip to be erroneously printed for all dynamic probes
instead of being suppressed by default as intended?

>  			if (!verbose)
>  				continue;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616013157.3896=
0-1-acme@kernel.org?part=3D2
