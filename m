Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537074;
	b=Ekvld9UmQ6sfBVWl7uBdHc/WIkQQ7gh3XjT+EsWRCS2U9K1QWCwjl2hSvVVhChgbjtGH
	 gqW7TaKZBabQ/Y5elQhnhRCAx8yqHOhmjhA05nUdoSKDJ6Uo3g6zMTjDLD/AgSv7pUMEe
	 8p0uGyjaDstg/TlUAjdNwj3VM+gq2hDdRGsiIDHex1EDtOQV4CzaE+Ie2yKPc+ZXxHTij
	 tLihZ/XkQL2IrQqiSZ4miZRRrSA+rUtCwXQPwiBIWnesKxlRykiqkunQTBoMy0726nXSb
	 ovfZPFy4sY8Cq2QeGrW+HE0sYYGPOQJ6l8NsgWdbF/ybITY7m4jg6LOciVQhs9OPjzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wt0MjZgTKU1V4lPYfcL5TevS8YbbtCT/ukO3a+eT0Y8=;
	b=lN8dPdDICBFndkyB5JZLK1JIi+n7934sI70Ie0YRsX4RZ63wiwUiySxDgjENibjkpU9v
	 ngiLgevNdtgBVDYS8oczo3jzDjrxlISOpzZYe53OFt5R5D20xeboif0v4chfMSQXhVw6t
	 ATAX03lolcah+39BFdvjJkeBHfQlsBXDFHijFU8aPbZLZIqYnN9Jo35TYpuCsf6bmjwIf
	 BcRLNzNGSaQhj4l2xIkM0ruj8hzHWjjRpe6qJYc/f1433DOCsx0sTH6Wa/oSIP3gernW1
	 NPaLlH8OEXmkbMqr7B4K/gFYoc0XiuTNdzU3nMw5MT2tjtjZG9JGgVxH0F3objCsNLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3BfdlvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F46606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3BfdlvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B025A1F000C9;
	Tue, 20 Oct 2026 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792537074;
	bh=wt0MjZgTKU1V4lPYfcL5TevS8YbbtCT/ukO3a+eT0Y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3BfdlvOqU8EYUBGu9+faIWWK8n6t16E0u5aKyayGuafamHb9osbnhsdQnoWYxL5o
	 B4W1NKuE8gzyAMVHqivm6LNBF/F5TWKfWPHN6MtAYGkdIBSjInzjOI8EHZFDTJO/Fr
	 OBKbAZv3xjU01DkMRw6H+ZjJHIWsFu/fP3Bh8ATtMNeJuSi8RhfWbtg2QdONuEjYMY
	 0rwzMucbzqamoITP4YY/iQodCH0of+mEjp/sXSpwNWnBVS4ccQPR2IfijQ7OYy4fzL
	 ezdIGn6nbrd+6tjXMa7Z4mK35BJ9h3+29/UMfRIMQzYoVJ1myT4C4tBxxAGtbYeZVc
	 XVgv+4RnnbcTg==
Message-ID: <sashiko-outbox-179587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] perf bpf-filter: Support BPF sample filters on
 tracepoint events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261020205859.1080743-4-irogers@google.com>
References: <20261019220915.3943592-1-irogers@google.com>
 <20261020205859.1080743-1-irogers@google.com>
 <20261020205859.1080743-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:57:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf bpf-filter: tracepoint BPF filter terms bypassed in is_poss=
ible_tp_filter()
--

commit af3470a1e411bc452a8bb18ee78fdec67327457c
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Support BPF sample filters on tracepoint events

This commit adds a tracepoint bpf program (perf_tp_sample_filter) to
evaluate context-independent sample filter terms (uid, gid, tid, cpu,
time, and cgroup) on tracepoint events using bpf helpers. It also updates
perf_bpf_filter__prepare(), perf_bpf_filter__pin(), and
perf_bpf_filter__unpin() to handle loading and pinning with the new
tracepoint program.

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 1596b08fe4e6a..ac0e7cf40f3af 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -123,15 +123,26 @@ static int check_sample_flags(struct evsel *evsel, =
struct perf_bpf_filter_expr *
>  {
>  	const struct perf_sample_info *info;
> =20
> -	if (expr->term >=3D PBF_TERM_SAMPLE_START && expr->term <=3D PBF_TERM_S=
AMPLE_END &&
> -	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE=
_START))))
> -		return 0;
> -
>  	if (expr->term =3D=3D PBF_TERM_UID || expr->term =3D=3D PBF_TERM_GID) {
>  		/* Not dependent on the sample_type as computed from a BPF helper. */
>  		return 0;
>  	}
> =20
> +	if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
> +		if (expr->term =3D=3D PBF_TERM_TID || expr->term =3D=3D PBF_TERM_CPU ||
> +		    expr->term =3D=3D PBF_TERM_TIME || expr->term =3D=3D PBF_TERM_CGRO=
UP)
> +			return 0;
> +		if (expr->op !=3D PBF_OP_GROUP_BEGIN) {
> +			pr_err("Error: %s tracepoint event does not support BPF sample term %=
d\n",
> +			       evsel__name(evsel), expr->term);
> +			return -1;
> +		}
> +	}

[Severity: Medium]
check_sample_flags() in tools/perf/util/bpf-filter.c and
perf_get_common_sample() in tools/perf/util/bpf_skel/sample_filter.bpf.c
enable tracepoint bpf sample filtering for uid, gid, tid (and pid via
entry->part), cpu, time, and cgroup.

However, when parse_filter() calls set_filter() in
tools/perf/util/parse-events.c, tracepoint events are checked with
is_possible_tp_filter():

tools/perf/util/parse-events.c:is_possible_tp_filter() {
	return strstr(str, "uid") =3D=3D NULL;
}

tools/perf/util/parse-events.c:set_filter() {
	...
	if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT && is_possible_tp_fi=
lter(str)) {
		if (evsel__append_tp_filter(evsel, str) < 0) {
			fprintf(stderr,
				"not enough memory to hold filter string\n");
			return -1;
		}

		return 0;
	}
	...
	if (!nr_addr_filters)
		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
}

A later commit in this series ("perf bpf-filter: Add lock_held() sample
filter") updates is_possible_tp_filter() to also check for "gid" and
"lock_held", but filters on tracepoint events using terms such as cgroup,
time, tid, or pid (or gid at this commit) without "uid" are still routed to
evsel__append_tp_filter() instead of perf_bpf_filter__parse(), causing the
tracepoint filter ioctl to fail when those terms are not tracepoint format
fields.

Should is_possible_tp_filter() in tools/perf/util/parse-events.c also
account for the other tracepoint bpf filter terms enabled here so that
set_filter() routes them to evsel->bpf_filters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020205859.1080=
743-1-irogers@google.com?part=3D3
