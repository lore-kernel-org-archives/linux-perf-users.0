Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3704E0200
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616194; cv=none; b=U7JuogXVAO0aIgeAq8OL+TNJY8MRJbtGZba88HE4OYgaY17qOTemalrixYUcyPzb9dcFd7oCX4B89CXiBz6eCFlfcRTVAdnDMhZnjomPFkFmOJD1e2P+xfAxDiK+GN86EEIgpNcKqNFpTiPFUOftEexyDv3TLIl8DV5K8PJk5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616194; c=relaxed/simple;
	bh=f8TyX07F9bkJDq0hpSlPawMcU1C1WNfgcVGsy8BnQkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UwbEzcn0Ya65ZbAjD99fiDE5vFUkaH4bXSW8B1+Rop3G8VASGlOPQot4ZMGFiLRzIZG6yWDYHs3QjJKycZIPlECxE7LQC84bKIr9FeIG80TPYOpGJe5r3DM8A8o4m7KSjS1k/4svWAY2u6cd+A1jxJpTSx/DVT5Km2DDxTgGUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4n88eWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4n88eWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E457E1F000FF;
	Mon, 28 Sep 2026 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616182;
	bh=8FRmDjbph95mw0Ep6323WDTsRDhPTkGdhAt6EhX+4Cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4n88eWUURYQetaakWEIppGowu6P/xDWjDivpIzT9TvUcCPopEJfQ02E2Ha1S3MPc
	 RhmKG1A3154iN3oFYjqtKZ7UmuAFPiZu7HrDe1z90kJ4ytO0Az5GIJCZctjxfmbhTg
	 aqMnLddYCFkNTjqkVyZN9wCqrEWIMH8z2yFI7yCCz4bPlbdXxWu/9tPsqNuTqOoLOz
	 Hc70QlY6uXar+ie7qPneikHei8zoyB//qxRVMUupAo8urMzN7E1f/KI8uI/NlT1a1E
	 kN8raWNn0oFgZ5S+BjGww+mogicgo6BB2z3MYPFXl+i/OPHv1SD5vDPTsIjYUDQb6v
	 mxQbI0tTmUbuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928171244.2437283-4-acme@kernel.org>
References: <20260928171244.2437283-1-acme@kernel.org>
 <20260928171244.2437283-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:23:01 +0000
Message-Id: <20260928172301.E457E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf-stuck: gdb script can hang indefinitely via until command
- [Medium] perf-stuck: potential deadlock in gdb script via inferior calls
- [Medium] perf-stuck: gdb script crashes if map_symbol.sym is NULL
- [Low] perf-stuck: shell option injection on process name or log path
--

commit 2f3e215696579c8fa2b53359bc4b83edfc0dd017
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit adds a prototype perf-stuck script and a gdb command file to
identify whether a running perf process is stuck in a loop or runaway recur=
sion.
It samples the process via /proc and can optionally attach gdb to print DWA=
RF
type chasing DIE chains.

> diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-=
stuck.gdb
> new file mode 100644
> index 0000000000000..ad595392f6beb
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.gdb
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
> +      # Pointer type DIEs have no DW_AT_name, so dwarf_diename() can
> +      # return NULL: printf %s of it would error out and abort this
> +      # batch script, handle it.
> +      set $perf_die_chain_name =3D (char *) dwarf_diename($arg1)
> +      printf "chain[%d] die=3D%p addr=3D%p cu=3D%p off=3D0x%lx tag=3D%d =
name=3D", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off) dw=
arf_dieoffset($arg1)), ((int) dwarf_tag($arg1))

[Severity: Medium]
Does evaluating dwarf_diename(), dwarf_dieoffset(), and dwarf_tag() risk
deadlocking the debugger? If the target process is already blocked holding
an internal library lock (such as a malloc or libdw lock), and the called
functions attempt to acquire the same lock via GDB's dummy stack frame, the
inferior thread will deadlock. In batch mode, this freezes the debugging
session permanently.

> +      if $perf_die_chain_name =3D=3D 0
> +	printf "(null)\n"
> +      else
> +	printf "%s\n", $perf_die_chain_name
> +      end
> +      until *$perf_die_chain_head

[Severity: Medium]
Can this command cause the batch script to hang indefinitely? Since GDB
yields execution to the inferior expecting it to hit the saved program
counter, if the target process breaks out of its loop, returns from the
function, or blocks elsewhere, the address will never be reached. Because
GDB runs without a timeout in batch mode, this causes the debugger and
parent script to hang.

> +      set $perf_die_chain_i =3D $perf_die_chain_i + 1
> +    end
> +  end
> +end
[ ... ]
> +define perf-dso
> +  if $_any_caller_is("find_data_type", 20)
> +    frame function find_data_type
> +    printf "dso=3D%s ip=3D0x%lx sym=3D%s\n", dloc->ms->map->dso->name, d=
loc->ip, dloc->ms->sym->name

[Severity: Medium]
Will this crash the GDB script if ms->sym is NULL? It is common for an
address in perf tools to not resolve to a symbol, leaving ms->sym empty.
Dereferencing NULL here causes the batch script execution to abort
immediately with a memory access error, preventing further output.

> +  else
> +    printf "not in find_data_type()\n"
> +  end
> +end
> diff --git a/tools/perf/scripts/perf-stuck.sh b/tools/perf/scripts/perf-s=
tuck.sh
> new file mode 100755
> index 0000000000000..3b9b22124dbda
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.sh
[ ... ]
> +if [[ "$1" =3D~ ^[0-9]+$ ]]; then
> +	pid=3D$1
> +else
> +	# Resolve the name against the caller's own processes: as root,
> +	# unscoped pgrep picks the first match of any user, e.g. one planted
> +	# to get gdb attached to it, use an explicit pid to look at a perf of
> +	# another user.
> +	pid=3D$(pgrep -x -u "$(id -u)" "$1" | head -1)

[Severity: Low]
Could this command fail or behave unexpectedly if the user provides a
process name starting with a hyphen? The $1 argument will be interpreted as
a command-line option by pgrep instead of a positional argument. A double
dash end-of-options separator might prevent this issue.

> +	[ -n "$pid" ] || { echo "no process named '$1' owned by $(id -un)"; exi=
t 1; }
> +fi
[ ... ]
> +	progress=3D
> +	[ -n "$progress_log" ] && [ -s "$progress_log" ] && progress=3D$(tail -=
1 "$progress_log")

[Severity: Low]
Can this command also fail due to option injection if the progress log path
starts with a hyphen? Like pgrep above, tail will interpret the path as an
option if it is not separated from the arguments.

> +
> +	if [ -n "$prev_cpu" ]; then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928171244.2437=
283-1-acme@kernel.org?part=3D3
