Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9E1DA619
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639182; cv=none; b=JW4gGeP5zyud+luWQ4JTd0G5pFKFeVc2/QJWBV6QQsq4D/C62P0WbAiR6tsuNaSvEHevQktw18NKYdQaqc2oYweV1MWLoooGj5t5n8+Term3+AoGCxOJrtBb2QpDYNROhjNnp8H9ipJ92/z55F3z3WuD1g48euQDX24tjueqQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639182; c=relaxed/simple;
	bh=SyE2gnrOG6nWWHL4RupTjWF0VX7sMCYZbtDepkw4eO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWWs2TTLSjOY7ftmxSzFXF7kKqNeSv4Cz1fqBSH04YaY9HjvKp1KM3IB98T0U5NyygkIn8VKffTADgyJhik3ETxxyNJxFCMazOWVx800dXLjbYiCtKkwkiJte3axlaSV3KQXHl3sSdycjT+WqOI2txBPRXaQ5q6B5F+6B90XrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRO38w3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRO38w3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A2EC4CECF;
	Tue, 26 Nov 2024 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732639182;
	bh=SyE2gnrOG6nWWHL4RupTjWF0VX7sMCYZbtDepkw4eO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRO38w3F0HSLadCDbUf0Rwov6xvNTuBWEV6HQYsER59XhM/lkNUbqc+Y5OA1peeSz
	 fh1aKfI1yVmuLZ2tqDzdTF/DoRykgHEtSRIR8n8rTYOyrl+eBnZ3mg6aSioXO8X9Sl
	 +qDLGd8tYCVieAml32aHgzeQqBiiCjVuGdfdeVn2LVuF8o1PoJF0xXEP56pePpzZ8g
	 /J8uGBbD3+TsfZYVHTJC3XDMAVaoBBqzy/zK7qwRmbJuHDnNyrXM0RhPGP+KECpNvi
	 HerXSzs0G7gLVLAze3xKpOk8q9BjhNKp8E1zdsp9An/I0LMT2HKTVruTLIx6/DAXOc
	 t42bpFQ6OVxEg==
Date: Tue, 26 Nov 2024 13:39:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <Z0X5y-1ZiE-_FnbY@x1>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
 <20241124105053.GA812108@e132581.arm.com>
 <Z0R3ySrb8iZQd17O@gentoo.org>
 <Z0VXvySyHm4q4r2c@google.com>
 <20241126102705.GA15252@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126102705.GA15252@e132581.arm.com>

On Tue, Nov 26, 2024 at 10:27:05AM +0000, Leo Yan wrote:
> On Mon, Nov 25, 2024 at 09:08:15PM -0800, Namhyung Kim wrote:
> 
> [...]
> 
> > > Using nm $libc in both cases, and increasing max-stack to 4 allows the test to pass:
> > >
> > > $ sudo ./perf test -vF pton
> > > --- start ---
> > > ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
> > > 7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> > > 7f7c34d4b517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
> > > 7f7c34d4cb73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
> > > 55680ac46518 [unknown] (/usr/bin/ping)
> > > ---- end ----
> > >  86: probe libc's inet_pton & backtrace it with ping                 : Ok
> > 
> > I think it's very fragile as it depends on specific entries in the call
> > stack.  As we want to test if perf probe (for uprobes) and perf record
> > working correctly, maybe it can just check the number of samples only.
> > 
> > Arnaldo, what do you think?
> 
> Though this question is asking Arnaldo, I have a different idea for
> fixing the test ;)
> 
> The middle entries in the callchain are varied on different archs and
> distro.  E.g. Guilherme reported back the '-D' option is not needed but
> at my side it is required on Arm64 machine with Ubuntu distro.
> 
> However, the three entries in the callchain are existed consistently:
> 
>   ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
>   7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>   ...
>   55680ac46518 [unknown] (/usr/bin/ping)
> 
> We can change the code to only matching these three entries.  The
> change is as below.  We can consolidate the code for all archs
> (I am not 100% sure for x390x so I leave it).
> 
> Please let me know if this makes sense for you?
> 
> Thanks,
> Leo

Seems to work:

Before, on a:

root@number:~# grep -m1 'model name' /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-14700K
root@number:~#

root@number:~# perf test -vF pton
--- start ---
ping 229025 [017] 34027.968348: probe_libc:inet_pton: (7fc4542c10d0)
7fc4542c10d0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
7fc4542d5a55 getaddrinfo+0xcf5 (/usr/lib64/libc.so.6)
FAIL: expected backtrace entry ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" got "7fc4542d5a55 getaddrinfo+0xcf5 (/usr/lib64/libc.so.6)"
---- end ----
 86: probe libc's inet_pton & backtrace it with ping                 : FAILED!
root@number:~# 

With your patch:

root@number:~# perf test -vF pton
--- start ---
pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
line: ping  231118 [023] 34089.948542: probe_libc:inet_pton: (7f635297f0d0)
found=0
pattern: .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6|inlined\)$
line: ping  231118 [023] 34089.948542: probe_libc:inet_pton: (7f635297f0d0)
found=1
line: 7f635297f0d0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
found=0
pattern: .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
line: ping  231118 [023] 34089.948542: probe_libc:inet_pton: (7f635297f0d0)
found=1
line: 7f635297f0d0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
found=1
line: 7f6352993a55 getaddrinfo+0xcf5 (/usr/lib64/libc.so.6)
found=1
line: 55ae71919969 [unknown] (/usr/bin/ping)
found=0
---- end ----
 86: probe libc's inet_pton & backtrace it with ping                 : Ok
root@number:~#

Replace that "unfound" with "Didn't find the"

And using 'found' as a variable name that when zero means "Ok, found"
and when 1 (grep failed to find the regexp) means "Didn't find" looks
confusing.

General idea seems to make the test resilient to the differences while
still testing the backtrace in uprobes events for expected entries.

- Arnaldo
 
> ---8<---
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 47a26f25db9f..6ef58aedf2d8 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -43,17 +43,8 @@ trace_libc_inet_pton_backtrace() {
>  		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>  		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
>  		;;
> -	ppc64|ppc64le)
> -		eventattr='max-stack=4'
> -		# Add gaih_inet to expected backtrace only if it is part of libc.
> -		if nm $libc | grep -F -q gaih_inet.; then
> -			echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		fi
> -		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> -		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
> -		;;
>  	*)
> -		eventattr='max-stack=3'
> +		eventattr='max-stack=4'
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	esac
> @@ -76,14 +67,23 @@ trace_libc_inet_pton_backtrace() {
>  	fi
>  	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
>  
> -	exec 3<$perf_script
>  	exec 4<$expected
> -	while read line <&3 && read -r pattern <&4; do
> +	while read -r pattern <&4; do
> +		echo "pattern: $pattern"
>  		[ -z "$pattern" ] && break
> -		echo $line
> -		echo "$line" | grep -E -q "$pattern"
> -		if [ $? -ne 0 ] ; then
> -			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
> +
> +		exec 3<$perf_script
> +		while read line <&3; do
> +			[ -z "$line" ] && break
> +			echo "line: $line"
> +			echo "$line" | grep -E -q "$pattern"
> +			found=$?
> +			echo "found=$found"
> +			[ $found -eq 0 ] && break
> +		done
> +
> +		if [ $found -ne 0 ] ; then
> +			printf "FAIL: unfound the expected backtrace entry \"%s\"\n" "$pattern"
>  			return 1
>  		fi
>  	done
