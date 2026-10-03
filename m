Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCCA384CDA
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991243; cv=none; b=LXDHVVUaBcuwPt9NUNDPlNOat8HSuA/JYJ+xkiE052XWQ5Mmx2NWyvrAUv4HNWQ1V0Cz3u71bv+BmnQR/exMHqd85+XvwSak4QDxnwsqArp11iwlQz37Ea+Igje4Uv9pmtPitm7MQqlRYcLOB12pqGURQePb8qxl9gJY3QdykmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991243; c=relaxed/simple;
	bh=a4M9+KItV/ORGfeI5NdGqephHjHwpEOjMEksiJwK6ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtPRH1Wnm9/q2jMtYOLs8RmOx1L8SwchU+WAvD+SRvjoF7yV8/1STsgo9BdqdjoSRKCSNn+3kNPKx3pSYBAgeBwH26ZcJvfM/0w4lRibL2C6L4Y8vnVLfULRrM4FfjSmuPHbg6crmNlujMizKaz4Ex+cnbO+memB4hHbOfYQJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olUVJm2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olUVJm2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDCF1F00893;
	Sat,  3 Oct 2026 01:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991241;
	bh=yFvsxIC4JTSUOUqXDWRCBBCZF+xThvgE1jV+Tpanuv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olUVJm2Hky21y+q988maL7LMrgQhxjgv6JsBz/eEJKT0xrcSfHOx6vl4ku7pO8i45
	 41HexcJuyjEnWhP1/f29/v+pVZ4pDYRUxZgAEzWE12tZWGPbyOgqTZGuhd+WVTQF+u
	 T2ccmEzHT68ShDmPpAuCh7k2gsXvQ8rrd2E6EoIYGHWm6NmKJPEyzMV0/84K+X0+O+
	 jtzYUNdAS4YhlTahbENx+Acv8iA6LIKN56iXsmH8V/m2EdOGPHsRtGuzbdVf49L0IM
	 tZ0zZVmudy9aX4Nb3KOnDk7KtH45lxrMIe2gxDZeguTznyA5DLm9/rKrKB+LJPsYqd
	 X74EOXSZWVDvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: Support --bitmask-list with --libtraceevent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002213145.333100-1-atomlin@atomlin.com>
References: <20261002213145.333100-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:01 +0000
Message-Id: <20261003013401.9EDCF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf trace: incomplete AST traversal for TEP_PRINT_HEX_STR nodes
- [Medium] perf trace: --bitmask-list broken for pipe mode streams
- [Low] perf trace: build failure on older libtraceevent due to missing TEP=
_PRINT_CPUMASK
- [Low] perf trace: future build failures due to -Wswitch-enum on external =
libtraceevent enum
--

commit f1dd0cf882822a7f067e6b6c6825d55f9ca3811c
Author: Aaron Tomlin <atomlin@atomlin.com>

    perf trace: Support --bitmask-list with --libtraceevent
   =20
    Commit ab74d1fbe061 ("perf trace: Add --bitmask-list command-line optio=
n")
    introduced the --bitmask-list option to display cpumasks and bitmasks as
    condensed, human-readable range lists (e.g. "0,2-5,7") instead of the
    default hexadecimal format.
   =20
    However, that implementation only augmented trace__fprintf_tp_fields().
    When --libtraceevent is specified, event formatting is delegated to
    event_format__fprintf(), which bypasses trace__fprintf_tp_fields() and
    relies directly on libtraceevent.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c3c7f1f85c530..57249df65fe31 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4857,6 +4857,77 @@ static int trace__run(struct trace *trace, int arg=
c, const char **argv)
>  	goto out_put_evlist;
>  }
> =20
> +#ifdef HAVE_LIBTRACEEVENT
> +static void tep_print_arg__set_bitmask_list(struct tep_print_arg *arg)
> +{
> +	for (; arg; arg =3D arg->next) {
> +		switch (arg->type) {

[Severity: Low]
Will this cause build failures on future libtraceevent updates?

The commit message mentions adding all enum values of tep_print_arg_type to
satisfy -Wswitch-enum. However, because tep_print_arg_type is an external
enum from libtraceevent, any future updates to libtraceevent that add new
values to this enum will break the perf build due to -Werror.

> +		case TEP_PRINT_BITMASK:
> +			arg->type =3D TEP_PRINT_CPUMASK;

[Severity: Low]
Can this cause a build failure on older libtraceevent versions?

If TEP_PRINT_CPUMASK is missing from the installed system libtraceevent
headers, this unconditional assignment will fail to compile.

> +			break;
> +		case TEP_PRINT_OP:
> +			tep_print_arg__set_bitmask_list(arg->op.left);
> +			tep_print_arg__set_bitmask_list(arg->op.right);
> +			break;
> +		case TEP_PRINT_FUNC:
> +			tep_print_arg__set_bitmask_list(arg->func.args);
> +			break;
> +		case TEP_PRINT_FLAGS:
> +			tep_print_arg__set_bitmask_list(arg->flags.field);
> +			break;
> +		case TEP_PRINT_SYMBOL:
> +			tep_print_arg__set_bitmask_list(arg->symbol.field);
> +			break;
> +		case TEP_PRINT_HEX:
> +			tep_print_arg__set_bitmask_list(arg->hex.field);
> +			tep_print_arg__set_bitmask_list(arg->hex.size);
> +			break;
> +		case TEP_PRINT_INT_ARRAY:
> +			tep_print_arg__set_bitmask_list(arg->int_array.field);
> +			tep_print_arg__set_bitmask_list(arg->int_array.count);
> +			tep_print_arg__set_bitmask_list(arg->int_array.el_size);
> +			break;
> +		case TEP_PRINT_TYPE:
> +			tep_print_arg__set_bitmask_list(arg->typecast.item);
> +			break;
> +		case TEP_PRINT_DYNAMIC_ARRAY:
> +			tep_print_arg__set_bitmask_list(arg->dynarray.index);
> +			break;
> +		case TEP_PRINT_NULL:
> +		case TEP_PRINT_ATOM:
> +		case TEP_PRINT_FIELD:
> +		case TEP_PRINT_STRING:
> +		case TEP_PRINT_BSTRING:
> +		case TEP_PRINT_DYNAMIC_ARRAY_LEN:
> +		case TEP_PRINT_HEX_STR:

[Severity: Medium]
Does this skip the AST traversal for TEP_PRINT_HEX_STR nodes?

The fallthrough here prevents the recursive traversal of arg->hex.field and
arg->hex.size for TEP_PRINT_HEX_STR nodes, which share the same structural
payload as TEP_PRINT_HEX. Nested bitmask evaluations inside a hex string
length or field argument could be silently ignored.

> +		case TEP_PRINT_CPUMASK:
> +		default:
> +			break;
> +		}
> +	}
> +}
> +

[ ... ]

> @@ -4908,6 +4979,8 @@ static int trace__replay(struct trace *trace)
>  	if (err)
>  		goto out;
> =20
> +	trace__init_tp_bitmask_list(trace, session->evlist);

[Severity: Medium]
Is --bitmask-list broken for pipe mode streams?

In pipe mode, the event list is populated dynamically from synthesized
events during perf_session__process_events(), which happens later in this
function. By calling trace__init_tp_bitmask_list() here, the initialization
operates on an empty evlist, skipping the AST transformation.

> +
>  	evsel =3D evlist__find_tracepoint_by_name(session->evlist, "raw_syscall=
s:sys_enter");
>  	trace->syscalls.events.sys_enter =3D evsel;
>  	/* older kernels have syscalls tp versus raw_syscalls */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002213145.3331=
00-1-atomlin@atomlin.com?part=3D1
