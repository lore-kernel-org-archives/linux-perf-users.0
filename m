Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765751AB6F1
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082811; cv=none; b=qot+YX36bKpgm+u71HD+NoDy8m+1KLRAUUGKdWaG1zzp1DroaalvEzvuf5bNBhmK0UJBJJLqkvm2Jpg9X68v3MbDKCa46D0JJlcz6XhrjIGH8dLscQJ/vgssLllbsgXgB6iiRjapwUYTJE5PlWTnlC3ifh+n8quXZ9kb4i5/cSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082811; c=relaxed/simple;
	bh=qF5G//iIx8HoPSHLy3EvCM8REtUG4znkZ7Oue3yBBTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRSo2M20J5UpSYdb70YS3S049eQs9fhbdLtyV5PCtpJ/kES+ycUJ8j97Dt0gdE63IQRvk1oE25VyAPCnR7+B+01BW5XdR6pVijerHJexsG/8fDh3VOmg1xo0o7aMMKNM6c0TinI4nwNUBEEH8sd0itbr+f7ebd6YTzrWWWjOmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZgIACg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZgIACg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D8EC19425;
	Sat, 25 Apr 2026 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082811;
	bh=qF5G//iIx8HoPSHLy3EvCM8REtUG4znkZ7Oue3yBBTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sZgIACg5TKhXb8j9EEvgrdOZszpVnfYjL9w47aJDOdRL02miXyfE4fTmLU5aRX1ZB
	 UjgqU+kmjKjI7bSSMuaENuqRx0L0Mb1i5X/jXYSZ2lWGkRFYaaDlEmocu3PVyxyK2/
	 zLFkX3ZhcKvK4fYWft/5YugnPI7US1yqHubS8oSaKoX7jqoDXAb8i7e3OqbeXPc+20
	 SP8tqIRrVykQdtqVzOU9KxAjb21+EQwah832etg52KZ08GEImkPf72he1cU9pjQHK9
	 yojF/VZr6j5puVVCbCOBhB27lhM8VNeqpFGSjk2irwzp6BpebXGaQHnEr1dCGoXGOQ
	 QvSjFQi0SmNjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
Reply-To: sashiko@lists.linux.dev
To: "Tomas Glozar" <tglozar@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260320150651.51057-4-tglozar@redhat.com>
References: <20260320150651.51057-4-tglozar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 02:06:46 +0000
Message-Id: <20260425020650.E2D8EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Segmentation fault when parsing abbreviated help options (`--he`, =
`--hel`) due to `RTLA_OPT_HELP` macro definition.
- [High] Options `-u/--user-threads` and `-n/--nano` incorrectly swallow su=
bsequent arguments or fail when placed at the end of the command line.
--

commit 7b68f92828ddb67d26e43dca96fdb16d529c279d
Author: Tomas Glozar <tglozar@redhat.com>

rtla: Parse cmdline using libsubcmd

This commit moves RTLA command line parsing from raw getopt_long() to
libsubcmd's parse_options(). It defines reusable macros for common and
tool-specific options.

> diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/tracing/rtla/src/cli.c
[ ... ]
> +#define RTLA_OPT_CGROUP OPT_CALLBACK_OPTARG('C', "cgroup", &params->comm=
on, \
> +	"[cgroup_name]", NULL, \
> +	"set cgroup, no argument means rtla's cgroup will be inherited", \
> +	opt_cgroup_cb)
> +
> +#define RTLA_OPT_USER_THREADS OPT_CALLBACK('u', "user-threads", params, =
NULL, \
> +	"use rtla user-space threads instead of kernel-space timerlat threads",=
 \
> +	opt_user_threads_cb)

Can this swallow subsequent command-line arguments or fail at the end of the
argument list?

Since OPT_CALLBACK is used here without PARSE_OPT_NOARG, libsubcmd's
get_arg() will strictly expect a value. If someone runs=20
"rtla timerlat top -u -p 100", the "-p" would be consumed as the argument to
"-u". If "-u" is placed at the end of the command line, it fails expecting
a value.

Could OPT_CALLBACK_NOOPT or OPT_BOOLEAN be used here instead?

[ ... ]
> +#define RTLA_OPT_DEBUG OPT_BOOLEAN('D', "debug", &config_debug, \
> +	"print debug info")
> +
> +#define RTLA_OPT_HELP OPT_BOOLEAN('h', "help", (bool *)NULL, \
> +	"show help")

Can this cause a segmentation fault if an abbreviated help option is provid=
ed?

While exact matches for "-h" and "--help" are intercepted early by libsubcm=
d,
partial matches like "--he", "--hel", or negated "--no-help" bypass the ear=
ly
check and perform standard prefix matching. This leads to get_value() being
called for the boolean option, which attempts to dereference the NULL value
pointer.

[ ... ]
> +#define TIMERLAT_OPT_STACK OPT_CALLBACK('s', "stack", &params->print_sta=
ck, "us", \
> +	"save the stack trace at the IRQ if a thread latency is higher than the=
 argument in us", \
> +	opt_llong_callback)
> +
> +#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
> +	"display data in nanoseconds", \
> +	opt_nano_cb)

Does this option also unintentionally consume the following argument?

Similar to RTLA_OPT_USER_THREADS, using OPT_CALLBACK without a flag prevent=
ing
argument consumption causes libsubcmd to require a value. Could
OPT_CALLBACK_NOOPT be used to ensure the flag behaves correctly as a toggle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260320150651.5105=
7-1-tglozar@redhat.com?part=3D3
