Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539291F583F;
	Mon,  4 Nov 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752476; cv=none; b=V4RvdqgzYeMDMLUCoF+ifmqL/gurrycBJhc4FWAgmjMZHUAvrhmVr2Wh6dHP8rvpKTrJDuwikcLNuotOY0RIhviv0UXUWABtvxQpBppiqdcmLOmL7/nOMdqIxLHw1RMklP/+9rI6C6fPXURLQeI0/AYG8RgDL9WcbgZQuiO1qaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752476; c=relaxed/simple;
	bh=R+vj510bqG0l6IcD4qqhWn0sP/yCDAzpKFzn0lQGuT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imOYb1w7ND7K+DHxeR/I80JiPoNH3zDmfAmI2GTEfbH4QzDTOmQcr770pEsbugmCDpu3Kf1StqFPvqUf1XCT1V/M3YkSw3xeR35iPddTxzi8WAZqN6WVRoxlsu3ZOWutG8RmhoDuSMS6CQogRLj8ljupHJlKG1MuxOCvytkj94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL9LFkeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL9LFkeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A89C4CECE;
	Mon,  4 Nov 2024 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730752475;
	bh=R+vj510bqG0l6IcD4qqhWn0sP/yCDAzpKFzn0lQGuT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL9LFkeG4Qp4YRvo1bxLgtgMMd+djytJsTOmKtbtpPvqU/3EbquGklR9/MwgBzUS8
	 oHXqqkq7Nc+3SD0ZBpTFem+LtUQmGJ8EGUxej5imS6oeS2AHdrw4goHpSinu0auuUd
	 hNQIexxsBOb0l882HhpAFKGxFKomVnQ8qhDjiGS66gWLW2Yfl2dxpYvqSmJh908GqS
	 0RYsCfqysz7F2aRZHwTj4+fy2fPEoqGzhtDQZzYGvEHEKXb/hvNaUHGSZ1PPtWW1eJ
	 E226JzAte07yHOOAIyJ6Kkvy4lkmMzuEx+5V4hLYCjrwSE1B9GuwR2G9+4WqEABQIA
	 +isvsj9FfuT+g==
Date: Mon, 4 Nov 2024 17:34:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf-probe: Replace unacceptable characters when
 generating event name
Message-ID: <Zykv2CdUbDIpTkrX@x1>
References: <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
 <173073706473.2098439.14379969075482451249.stgit@mhiramat.roam.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <173073706473.2098439.14379969075482451249.stgit@mhiramat.roam.corp.google.com>

On Tue, Nov 05, 2024 at 01:17:44AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Replace unacceptable characters with '_' when generating event name from
> the probing function name. This is not for C program. For the C program,
> it will continue to remove suffixes.
>=20
> For example.
>=20
> $ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
> p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-lin=
ux-gnu/debug/cro3:0x197530
>=20
> $ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
> p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |   37 ++++++++++++++++++++++++++++++-----=
--
>  1 file changed, 30 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index bcba8273204d..27698b9a8c95 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2729,7 +2729,7 @@ int show_perf_probe_events(struct strfilter *filter)
> =20
>  static int get_new_event_name(char *buf, size_t len, const char *base,
>  			      struct strlist *namelist, bool ret_event,
> -			      bool allow_suffix)
> +			      bool allow_suffix, bool is_C_symname)
>  {
>  	int i, ret;
>  	char *p, *nbase;
> @@ -2740,10 +2740,24 @@ static int get_new_event_name(char *buf, size_t l=
en, const char *base,
>  	if (!nbase)
>  		return -ENOMEM;
> =20
> -	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
> -	p =3D strpbrk(nbase, ".@");
> -	if (p && p !=3D nbase)
> -		*p =3D '\0';
> +	if (is_C_symname) {
> +		/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes =
*/
> +		p =3D strpbrk(nbase, ".@");
> +		if (p && p !=3D nbase)
> +			*p =3D '\0';
> +	} else {
> +		/* Replace non-alnum with '_' */
> +		char *s, *d;
> +
> +		s =3D d =3D nbase;
> +		do {
> +			if (*s && !isalnum(*s)) {
> +				if (d !=3D nbase && *(d - 1) !=3D '_')
> +					*d++ =3D '_';
> +			} else
> +				*d++ =3D *s;
> +		} while (*s++);
> +	}
> =20
>  	/* Try no suffix number */
>  	ret =3D e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : ""=
);
> @@ -2832,6 +2846,7 @@ static int probe_trace_event__set_name(struct probe=
_trace_event *tev,
>  				       bool allow_suffix)
>  {
>  	const char *event, *group;
> +	bool is_C_symname =3D false;
>  	char buf[64];
>  	int ret;
> =20
> @@ -2846,8 +2861,16 @@ static int probe_trace_event__set_name(struct prob=
e_trace_event *tev,
>  			(strncmp(pev->point.function, "0x", 2) !=3D 0) &&
>  			!strisglob(pev->point.function))
>  			event =3D pev->point.function;
> -		else
> +		else {
>  			event =3D tev->point.realname;
> +			/*
> +			 * `realname` comes from real symbol, which can have a suffix.
> +			 * However, if we see some glab-like wildcard in the symbol, it
                                                   "glob"?
> +			 * might not be a C program.
> +			 */
> +			if (!strisglob(event))
> +				is_C_symname =3D true;

				non_C_symname would be a bit more clear,
                                i.e. inverting the logic, as a C symname is
				valid in other languages :-)

				Also since we _can_ know if it comes
=66rom a C, as we have:

root@x1:~# readelf -wi /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vm=
linux | grep -m10 DW_AT_language
    <12>   DW_AT_language    : 29	(C11)
    <2b0a5>   DW_AT_language    : 29	(C11)
    <2f3a4>   DW_AT_language    : 29	(C11)
    <573b0>   DW_AT_language    : 29	(C11)
    <6dd73>   DW_AT_language    : 29	(C11)
    <879eb>   DW_AT_language    : 29	(C11)
    <8c094>   DW_AT_language    : 29	(C11)
    <9ce09>   DW_AT_language    : 29	(C11)
    <9d8fb>   DW_AT_language    : 29	(C11)
    <b877a>   DW_AT_language    : 29	(C11)
root@x1:~#=20
root@x1:~# readelf -wi /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vm=
linux | grep -m1 -B5 DW_AT_language
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0
   Pointer Size:  8
 <0><c>: Abbrev Number: 246 (DW_TAG_compile_unit)
    <e>   DW_AT_producer    : (indirect string, offset: 0x4edb56): GNU C11 =
14.2.1 20240912 (Red Hat 14.2.1-3) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -=
mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -=
mskip-rax-setup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -mindirect=
-branch=3Dthunk-extern -mindirect-branch-register -mindirect-branch-cs-pref=
ix -mfunction-return=3Dthunk-extern -mharden-sls=3Dall -mrecord-mcount -mfe=
ntry -march=3Dx86-64 -g -O2 -std=3Dgnu11 -p -fshort-wchar -funsigned-char -=
fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=3Dbranch -falign-j=
umps=3D1 -falign-loops=3D1 -fno-asynchronous-unwind-tables -fno-jump-tables=
 -fpatchable-function-entry=3D16,16 -fno-delete-null-pointer-checks -fno-al=
low-store-data-races -fstack-protector-strong -ftrivial-auto-var-init=3Dzer=
o -fno-stack-clash-protection -fmin-function-alignment=3D16 -fstrict-flex-a=
rrays=3D3 -fno-strict-overflow -fstack-check=3Dno -fconserve-stack -fno-fun=
ction-sections -fno-data-sections -fsanitize=3Dbounds-strict -fsanitize=3Ds=
hift
    <12>   DW_AT_language    : 29	(C11)
root@x1:~#

	Wouldn't it be better to use that to decide how to deal with
symbols in a CU?

	The advantage of using just the symbol name and that heuristic
about finding glob characters in the symbols is when we don't have
access to the DWARF info, having just the ELF symbol table, when we
don't have the lang code for the CU.

- Arnaldo

> +		}
>  	}
>  	if (pev->group && !pev->sdt)
>  		group =3D pev->group;
> @@ -2858,7 +2881,7 @@ static int probe_trace_event__set_name(struct probe=
_trace_event *tev,
> =20
>  	/* Get an unused new event name */
>  	ret =3D get_new_event_name(buf, sizeof(buf), event, namelist,
> -				 tev->point.retprobe, allow_suffix);
> +				 tev->point.retprobe, allow_suffix, is_C_symname);
>  	if (ret < 0)
>  		return ret;
> =20
