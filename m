Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB937C908
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661098; cv=none; b=ajCX0bD2ckNDXhIsuYxm3lJChwdK691H3YMX4SRrM5VXPlrPfW+4C3AjHKcNk+22aHtJLUDEVykLon00hWmc4AbxRta/DXoPt3UqiGrJLWWnBttXktkVWG535U+3CfKly3YXIQzWcdVgHoCqJc4zAxZEwq3EfsEMpLO4TsD/um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661098; c=relaxed/simple;
	bh=XCXuPRCPlIajCgsagTOOgzL56X7AC1KWhJn2MTnoBU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YgAgF34K50icOPN9fI0bW8JoXBmprwt6A8vXeEmzxlUlcClKX8fjwRF0r9aLvh9CtQJlrvqw5IxRr2c540eVaw2be+YBiD18B6hjHSMQxAjwIaPhtjfn9+oc3yuCe6c1RlHPYpzqjIW73QAr/Hgj2tsydxQnqKxxMQJwJ6c7b10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohpVzrW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohpVzrW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3131F000FF;
	Thu, 17 Sep 2026 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661097;
	bh=1A83SJIFWteXxtuViRyt6YJNZ2h6TtwRJQD8zYwyiZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohpVzrW0dFgmxVbqTTY8CexRqsNRmFhA1ut3VGw4g75XRhUPwtB25nStUlJCyQtl7
	 MI1sm7aB+GZQlwu9cnjWSEkhMc0oilarWAd5mz1upXHPRYFrJc9Q+RBwMuzak/25ca
	 At57/2DEPRoUKslsnApMdkiYlNYIGsPKOj9EpfSnxrzi7wOZvXsC5yJSGbx8S0ceXj
	 2EaAM4g9p3L3IZDIfL0QE9RHxTf4FA5eWi3iZooDFkGV+cGcdSZbLrbQUyLrwas2zt
	 rEa/cb0Rwm4bh7FYI/7ddnPgRdyF0DETQ90bx2Q7BIoqWQo7bn74lBKTo5ioLQ/AEq
	 kX0Obd2H66nDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-10-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:04:56 +0000
Message-Id: <20260917160456.CD3131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf/scripts: privilege escalation via unscoped pgrep in perf-stuc=
k.sh
- [Medium] perf/scripts: gdb script crashes on NULL dwarf_diename()
--

commit 31fcb1c1d74aa548fa6dd4ca2fccfd9cd7dfd922
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit adds the perf-stuck.sh and perf-stuck.gdb scripts to sample a
running process and determine if it is stuck in an unbounded loop or
recursing. The script checks /proc/<pid> entries at a fixed interval and can
optionally use gdb to dump the DIE chain being walked if the process is stu=
ck
in a DWARF type chasing loop.

> diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-=
stuck.gdb
> new file mode 100644
> index 0000000000000..53e9019828b6e
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.gdb
> @@ -0,0 +1,104 @@
[ ... ]
> +define perf-die-chain
> +  if $argc < 2
> +    printf "usage: perf-die-chain <function> <die variable> [iterations]=
\n"
> +  else
> +    frame function $arg0
> +    if $argc =3D=3D 3
> +      set $perf_die_chain_n =3D $arg2
> +    else
> +      set $perf_die_chain_n =3D 10
> +    end
> +    set $perf_die_chain_head =3D $pc
> +    set $perf_die_chain_i =3D 0
> +    while $perf_die_chain_i < $perf_die_chain_n
> +      printf "chain[%d] die=3D%p addr=3D%p cu=3D%p off=3D0x%lx tag=3D%d =
name=3D%s\n", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off=
) dwarf_dieoffset($arg1)), ((int) dwarf_tag($arg1)), ((char *) dwarf_dienam=
e($arg1))

[Severity: Medium]
Since pointer type DIEs lack a DW_AT_name attribute, dwarf_diename() will
return NULL for them. Will GDB's printf with the %s format specifier evalua=
ting
a 0x0 pointer result in a "Cannot access memory at address 0x0" error, abor=
ting
the GDB batch script?

> +      until *$perf_die_chain_head
> +      set $perf_die_chain_i =3D $perf_die_chain_i + 1
> +    end
> +  end
> +end
[ ... ]
> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> new file mode 100755
> index 0000000000000..70e59192b1d96
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
> @@ -0,0 +1,194 @@
[ ... ]
> +if [[ "$1" =3D~ ^[0-9]+$ ]]; then
> +	pid=3D$1
> +else
> +	pid=3D$(pgrep -x "$1" | head -1)

[Severity: High]
Since pgrep -x searches across all users, could an unprivileged user create=
 a
malicious process matching the target name (e.g. 'perf'), causing this to
resolve to the attacker's PID instead of the legitimate root process if an
administrator runs this script?

> +	[ -n "$pid" ] || { echo "no process named '$1'"; exit 1; }
> +fi
[ ... ]
> +	if [ -n "$use_gdb" ] && [ -z "$gdb_done" ] && [ "$stuck" -ge 2 ]; then
> +		gdb_log=3D$(mktemp /tmp/perf-stuck-gdb.XXXXXX)
> +		gdb -p "$pid" -batch -x "$gdb_cmds" -ex bt \

[Severity: High]
If the PID was resolved to an attacker-controlled process, does invoking gdb
as root on it allow local privilege escalation by executing arbitrary code =
via
malicious DWARF debug info or GDB auto-load scripts?

> +		    -ex 'perf-die-chain-all' -ex perf-dso -ex detach > "$gdb_log" 2>&1
> +		gdb_done=3D1
> +		echo "... gdb output of $pid in $gdb_log"
> +	fi
> +
> +	prev_cpu=3D$cpu

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D9
