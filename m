Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA1353A8E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968890; cv=none; b=uHzLUKREjjlp0JVszlXisO/UmOtgbdsV6RV9rn/EdP6/PngCDmD1DhJ0DejP7xE/lAVcjyCKhWKQQqjixEdw5P47nZpLlLXKnVWjd6lc3VyUTv+9hC0oONE8EtcJ17nD8tNtuUIzVzGEb3J6xscNaq+lQBTHPm1HHn3AzfZVO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968890; c=relaxed/simple;
	bh=50XA+/AfalE9fA3579KYftMjBTfYmWJ4FR3OknR5P80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VsNHF+sReAtjxVQ7VGtNL5H88JZapWO8s2MM8LWIY5RQQyil+L1+wIquq4p5wGWd9E1dhlE3SZgt1sjj96Uhkq6eS2em4dLlURyOgeirZ/t8PMqUQRilkaOKz89LtRXdqYCBp0aFqiB0icj4Od8p9rLp+w4hJQ1e2/CoP81Ej6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeF0hKMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeF0hKMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E1D1F000FF;
	Mon, 21 Sep 2026 05:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968888;
	bh=pl1wHmj9znMfk3KhCocuyjqyD/bfe5itlieorGtFa7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oeF0hKMjckf9t1a9kviWx/ZYnvk4URzfVZnCbmG1tigxpnRZJr3L2QWfF6Idke0V9
	 iNoRRe46DNjRqn2qdGj3+0ystzXMcdsHrwxZdImo27PpvnRMmEp8JH6R9m1iKmAqkB
	 dgxtCVUU6Sc+sls0/kgD5QOHhA4BXinESGaMM+wbkwODrZhgnMhstTg0zRekt9aucD
	 JstxBM/hq/caIevqWzcEfQ+cjNEDRm1pqUDpn9UJdgELyKESOTo2JKPpwOSdQb+fy9
	 fNtvNR7A3bLnun4WLf3FYEC9yLs/hLwCtLEcfLDVnwtr8pNRg48bwHDMIUHPd3qXHi
	 sAnwIs4G9WhRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/49] perf python: Expose addr location,
 transaction, and context_switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5116186e1258404cbbc7e15d145d463ab71e2491.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <5116186e1258404cbbc7e15d145d463ab71e2491.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:34:47 +0000
Message-Id: <20260921053448.58E1D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: default guest samples resolved against host symbols
--

commit 7820cd6d68d2c391ed1e11785faec0799b2925fe
Author: Ian Rogers <irogers@google.com>

perf python: Expose addr location, transaction, and context_switch

This commit exposes various destination address location components, branch
metrics, and other fields directly to the Python extension. It also adds
support for fetching sym_offset and populates sample machine_pid and vcpu
from the evlist when perf_guest is enabled.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index fbfa71b1c4b6c..49f37198f4b34 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -679,6 +683,7 @@ static int pyrf_sample_event__resolve_al(struct pyrf_=
event *pevent)
>  	struct evsel *evsel =3D pevent->sample.evsel;
>  	struct evlist *evlist =3D evsel ? evsel->evlist : NULL;
>  	struct perf_session *session =3D evlist ? evlist__session(evlist) : NUL=
L;
> +	struct machine *machine;
> =20
>  	if (pevent->al_resolved)
>  		return 0;
> @@ -686,8 +691,14 @@ static int pyrf_sample_event__resolve_al(struct pyrf=
_event *pevent)
>  	if (!session)
>  		return -1;
> =20
> +	machine =3D pevent->sample.machine_pid ?
> +		machines__find(&session->machines, pevent->sample.machine_pid) :
> +		&session->machines.host;

[Severity: Medium]
Will this ternary operation incorrectly redirect default guest samples to t=
he
host machine?

When pevent->sample.machine_pid evaluates to 0, which represents
DEFAULT_GUEST_KERNEL_ID, it seems this bypasses necessary cpumode and guest
fallbacks. This could cause KVM guest trace events that lack an explicit
machine_pid to unconditionally fall back to host symbols instead of the gue=
st
machine, yielding incorrect symbol mappings for guest events in Python scri=
pts.

> +	if (!machine)
> +		machine =3D &session->machines.host;
> +
>  	addr_location__init(&pevent->al);
> -	if (machine__resolve(&session->machines.host, &pevent->al, &pevent->sam=
ple) < 0) {
> +	if (machine__resolve(machine, &pevent->al, &pevent->sample) < 0) {
>  		addr_location__exit(&pevent->al);
>  		return -1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D8
