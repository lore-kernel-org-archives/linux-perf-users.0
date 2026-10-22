Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701976;
	b=Cp8m7V1lmPZ0UB3xbASvz04Wijq9jQl1kdRMOB6RPlealyTMcIGZ2jf/8XiGrr7yGetY
	 EepU+5CddsgG+SFeXZ459gMwTNDjDlBLkKS2nvzefexeG7S0xLvy6NGQUe8F7HEOHleVR
	 ilrbojIsgY3155E0aF6e7234pzGFBVCtvsHK0SpsX91KdW4MKb3Y9Opd4MXcmLuoJWv2z
	 NgJadA4HHzgHDury56SiFqd6o8Mf0MFENtUiDkRxHDsKbqNS/+KZI10Hu9SVnorkHXsiW
	 P2TRnQbmLpkBLVC3SmH4JuSJMk5xDdMuQ2sPYoIyZ+EKTpn7zyU1+l2wdixduoKxeiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k7o+bs1VyxclcJW8fnGRaqBybwBYed14ZKVZoCuR7fI=;
	b=w1YHnXCZrrM902Gvild0+K5qEdnQ9aTPH+FBfzqn8n8hE9kuCxc4z5u3aT5TKzr5kIbh
	 J6V6dn4lFTOAiHR/8eBjqHDM7szG6i+iTGE+69XCVktYfi7llVmTz3UlJ4OhEc9fxj3mJ
	 KHQ4BqviIr0+LD7ZU/QYwylgprbOR3e9LNEg+lcx5dGpbp5hvTfAQqxX3mwSvtENY8YkI
	 3uMr3vTOlMVoPgrpSYARJ/tN7wlbTEalVF3+5Tfg+vL+X2wBbXfIjne8ig2CBhXfqMDc+
	 kSeVhtAnpnr+pFpKzg+e/7Ip5teOh0XDvv4cMeDVpzMu8dikk8tsSgA6vRLplGNQ2ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIiuQsG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA07606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIiuQsG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A52C1F01829;
	Thu, 22 Oct 2026 20:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701975;
	bh=k7o+bs1VyxclcJW8fnGRaqBybwBYed14ZKVZoCuR7fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIiuQsG5L08RTIGVMev/Hzw7PGqOl5Eh9Q+YUynEwPeUkYT6FoIaL2Ss6CxplOrSI
	 kdh9dUzK5tP1A8fcVHgF/BJYwXAqL/b+QJC1wwmHIsgGZ/uanw3efrC0SGx8yoqbqU
	 TmANoN3iGyeGQ4j3ppBBTsadLF9K1+yQjyL7rwxuc+Yd0Xov9f6OGgS2c8gsRyb31C
	 EOf2dc9E3Zsu4nvZVDPRf14YR6bFIKMt60rXESWRQgAMrw1bb4GUKmEz/+yWjJtTpo
	 BKwD9I2asizzmYmPtlhRKXevZfL50wA4Pb2F031ys5Gv+S3tqipNUj1vkX38eZy5JC
	 VkUXpg2Qy8g7g==
Message-ID: <sashiko-outbox-182023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/11] perf bpf-filter: Add lock_held() sample filter
 for global mutexes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-6-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:46:15 +0000
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
- [Medium] perf bpf-filter: fix module symbol matching and _edata bound in =
find_lock_sym_cb()
--

commit 50246e2587ada8982167d48e27c24df7afceb9ec
Author: Ian Rogers <irogers@google.com>

perf bpf-filter: Add lock_held() sample filter for global mutexes

This commit adds BPF sample filter predicates such as lock_held(<lock>) to
record perf event samples only when a specified kernel lock is held or not
held. In this initial step, global and static kernel mutex symbols are
resolved via /proc/kallsyms and inspected in kernel memory via
get_lock_owner().

> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 0d3c700d3dcd5..639db6c031379 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
[ ... ]
> @@ -169,9 +178,263 @@ static int check_sample_flags(struct evsel *evsel, =
struct perf_bpf_filter_expr *
[ ... ]
> +struct lock_sym_cb_args {
> +	const char *name;
> +	u64 addr;
> +	bool in_text;
> +	bool in_data;
> +	bool found;
> +};
> +
> +static int find_lock_sym_cb(void *arg, const char *name, char type, u64 =
start)
> +{
> +	struct lock_sym_cb_args *args =3D arg;
> +
> +	if (!strcmp(name, "_text") || !strcmp(name, "_stext") ||
> +	    !strcmp(name, "_sinittext")) {
> +		args->in_text =3D true;
> +		return 0;
> +	}
> +	if (!strcmp(name, "_etext") || !strcmp(name, "_einittext")) {
> +		args->in_text =3D false;
> +		return 0;
> +	}
> +	if (!strcmp(name, "_sdata") || !strcmp(name, "__bss_start")) {
> +		args->in_text =3D false;
> +		args->in_data =3D true;
> +		return 0;
> +	}
> +	if (!strcmp(name, "__bss_stop")) {
> +		args->in_data =3D false;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Ignore kernel text functions, module text functions, and
> +	 * absolute/undefined symbols. On CONFIG_LTO_CLANG kernels, vmlinux
> +	 * .data symbols between _sdata and _edata may have kallsyms type
> +	 * 'T'/'t', so allow 'T'/'t' within vmlinux data/bss (args->in_data).
> +	 */
> +	if (args->in_text || type =3D=3D 'A' || type =3D=3D 'a' ||
> +	    type =3D=3D 'U' || type =3D=3D 'u' ||
> +	    (!args->in_data && kallsyms__is_function(type)))
> +		return 0;
> +
> +	if (!strcmp(name, args->name)) {
> +		args->found =3D true;
> +		args->addr =3D start;
> +		if (start !=3D 0)
> +			return 1;
> +	}

[Severity: Medium]
When resolving a lock symbol through the call chain:

  perf_bpf_filter__prepare()
    -> get_filter_entries()
      -> resolve_lock_expr()
        -> find_kernel_lock_sym()
          -> kallsyms__parse(..., find_lock_sym_cb)

there appear to be two symbol resolution issues in find_lock_sym_cb() in
tools/perf/util/bpf-filter.c:

First, in tools/lib/symbol/kallsyms.c, kallsyms__parse() reads each symbol
name up to the newline character:

	for (i =3D 0; i < KSYM_NAME_LEN; i++) {
		ch =3D io__get_char(&io);
		if (ch < 0 || ch =3D=3D '\n')
			break;
		symbol_name[i]  =3D ch;
	}
	symbol_name[i]  =3D '\0';

In /proc/kallsyms, module symbols are formatted with a trailing module name
suffix ("\t[<module>]"). Because find_lock_sym_cb() compares names using
!strcmp(name, args->name), will lock symbols residing in loaded kernel
modules always fail to match? Other kallsyms callbacks such as
kern_sym_name_match() in tools/perf/util/auxtrace.c handle this by allowing=
 a
tab delimiter after the symbol name:

static bool kern_sym_name_match(const char *kname, const char *name)
{
	size_t n =3D strlen(name);

	return !strcmp(kname, name) ||
	       (!strncmp(kname, name, n) && kname[n] =3D=3D '\t');
}

Second, find_lock_sym_cb() sets args->in_data =3D true at both _sdata and
__bss_start, and the comment notes that .data symbols between _sdata and
_edata may have type 'T' or 't'. However, only __bss_stop resets
args->in_data to false. Should _edata also reset args->in_data =3D false so
that sections between _edata and __bss_start (such as .exit.text outside
_sinittext.._einittext) are not treated as vmlinux data/bss?

> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D5
