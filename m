Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2492609E3
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832481; cv=none; b=XhrkkqyjH3T/g8JezHZCNUpHp8NX5ex4W/MR9VBCxvs783M3tZjiBQ7kF8aW/JwOgsv8Fo7rjhsLfw6IjvMPn/ymcHPpy25j8LxaQmfwSerT9udKCrs+BWDKdk8LKjkZJmADMnutj6PF0QjxyWQX2vo/zNZqsmpWn0aA/SvbXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832481; c=relaxed/simple;
	bh=lIKlc80afw52CeRZ90doUcgiddXwN4AeWLSLGUW5b3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVWqcZ76CWRFuMqQ+qn0btuMXk770rFbaskyCyKb7JMc6qH9djTEDkhQ26eOREY+uhDkPMbemPQoYavj2y7s9TSKzml4GUtkiA+kO5NfsJd1qe32jBWJmGHY+pTEVEadCSdOnMiHc38K+fSqroU+wGHBNDFXrSh87rbJ2HLwmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkFFFnFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkFFFnFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950D31F000E9;
	Tue, 26 May 2026 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832480;
	bh=xd02oMXX2SuJiL/BWCA0x7Cm6KaS/u+fjtl9TEzSLPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RkFFFnFP7ut9o1WgJmfTiywqG+WNzGThm4qrCS2duJTlBHd4AyzThNCYGXRug46gQ
	 0aRYLSGwCRzqeSxBWdF59fIXWIo0xbkgqnDNuGOsPNcbLvoopx6/rUzJSlSkGjEFeK
	 rmxHOem6UPcG/Ol3ZFr4EMh9WqYBvQSs1Yy3zH85CxhaFvGENbV1Cs4COieGl/DtyK
	 aLM5tqLjUWJE7owXbULy8NeAcfKhCjLIZJL+tM/teky+6D0eGjoAis12VzsaNpB2LC
	 h2AFO653U/3l7Ij7qndO5BAtn6g41IXqKBK/QSdkJrJdkAxnrC/wbYCj0/rlORB7aT
	 3UM2G5aXWrTXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/29] perf session: Validate nr fields against event
 size on both swap and common paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-12-acme@kernel.org>
References: <20260526211806.1193848-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:54:40 +0000
Message-Id: <20260526215440.950D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent error handling for malformed PERF_RECORD_THREAD_MAP=
 events leads to unnecessary session aborts on native architectures.
--

commit 8cc6c3cf14b21b51f888c8eeb92fee4d28388fbd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Validate nr fields against event size on both swap and common=
 paths

This commit adds bounds checking to variable-length arrays in events such as
PERF_RECORD_THREAD_MAP, PERF_RECORD_NAMESPACES, PERF_RECORD_CPU_MAP, and
PERF_RECORD_STAT_CONFIG. It applies these checks on both the native and
cross-endian processing paths.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index aef10d42be354..8588e12f110fc 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> @@ -1912,15 +2029,112 @@ static s64 perf_session__process_user_event(stru=
ct perf_session *session,
>  		perf_session__auxtrace_error_inc(session, event);
>  		err =3D tool->auxtrace_error(tool, session, event);
>  		break;
> -	case PERF_RECORD_THREAD_MAP:
> +	case PERF_RECORD_THREAD_MAP: {
> +		u64 max_nr;
> +
> +		if (event->header.size < sizeof(event->thread_map)) {
> +			pr_err("PERF_RECORD_THREAD_MAP: header.size (%u) too small\n",
> +			       event->header.size);
> +			err =3D -EINVAL;
> +			break;
> +		}
> +
> +		max_nr =3D (event->header.size - sizeof(event->thread_map)) /
> +			 sizeof(event->thread_map.entries[0]);
> +		if (event->thread_map.nr > max_nr) {
> +			pr_err("PERF_RECORD_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 =
"\n",
> +			       (u64)event->thread_map.nr, max_nr);
> +			err =3D -EINVAL;

[Severity: Medium]
Does returning -EINVAL here introduce inconsistent error handling between t=
he
native-endian path and the cross-endian swap path?

On the cross-endian swap path, perf_event__thread_map_swap() returns -1
if the thread map nr exceeds the payload size. perf_session__process_event()
handles this swap failure by skipping the event and allowing the session to
continue.

Here on the native-endian path, the bounds check detects the same condition
but sets err =3D -EINVAL. This -EINVAL propagates up to
__perf_session__process_events() and causes the entire perf session to abor=
t.

Since other events like CPU_MAP and STAT_CONFIG are skipped on error, and t=
he
swap path skips malformed THREAD_MAP events, should the native path also sk=
ip
them to prevent a single malformed event from breaking the entire session?

> +			break;
> +		}
> +
>  		err =3D tool->thread_map(tool, session, event);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D11
