Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CE2114;
	Thu,  2 Jan 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845908; cv=none; b=m0RmIt9xNkab9joi8tSpsfhYRROJxTnColn0SKsuhk1GfNs93IVrPPTpu1jp0PDBeDe+qD7LL6+cU962voK2bm9EIjDfHm2a5lMVqtcM1EB/ZZluB9XmqexwdjOT9hLOHOJR+GPryxvZ89bqw85327pYu9c2AS5nSm0GbTa1O8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845908; c=relaxed/simple;
	bh=Dn+/fJGOrxRDCtbh7ywPiIaHDd42MT7ijYh8SZxqpzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLkir/tVIq8C+tGPWpG2ODI9XYHJtmQjeKqpUJr42g8WQDAA5ghAq1ANTleAfRGs2nX5X4ozKexCeNszkzLWDNSJpknUDvHjEUE8jIYUtDYvO4ZadZsN5zC0yd1f7AgkE3Z4Ve7KsCy7R03pCcM+qo7iHsj97G4YBBx8ASkiwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAamjA0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAamjA0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E617C4CED0;
	Thu,  2 Jan 2025 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735845907;
	bh=Dn+/fJGOrxRDCtbh7ywPiIaHDd42MT7ijYh8SZxqpzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAamjA0atAW6M/BavYUN37oXN38ICppp0l5/zHl34ZujcR8QPV0Z0hugvgmupReMX
	 R7i+KyTKH1fyMGfE72HRE2undLqt8fPZpDrnLSJKFAI5nacoaAWlh+5X7sy9SZbDuW
	 1hlGjzCZmV+fPT6Ju4BzIn4DxmCDQfXejKfzmDGBzR1375BmvAf3Y1uCZHa4Yhd/A0
	 kYNzfC+FLlEcRXl645URlK7OjO+yqKKkBp2fO3uuiKxfqr8WPlP5kp+adWQ9I9XFCT
	 lJI7e6B8AD8tY7sRr+phypIkiT5CnmBjAs7QD1D70l0h/KWcTEAupQBprzU6q0GzKL
	 EppY0HlDz+SNQ==
Date: Thu, 2 Jan 2025 16:25:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf top reports not being able to resolve kernel symbols
Message-ID: <Z3boDyuus0fiGcok@x1>
References: <Z3bd2uCdo2EAMSnG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3bd2uCdo2EAMSnG@x1>

On Thu, Jan 02, 2025 at 03:41:34PM -0300, Arnaldo Carvalho de Melo wrote:
> While investigating a report by Christophe I stumbled on this:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git bisect bad
> 77b004f4c5c3c90b20ad61c5fa2ba7d494c1dba1 is the first bad commit
> commit 77b004f4c5c3c90b20ad61c5fa2ba7d494c1dba1 (HEAD)
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Thu Sep 12 15:42:08 2024 -0700
>     perf symbol: Do not fixup end address of labels
> 
> ⬢ [acme@toolbox perf-tools-next]$ git tag --contains 77b004f4c5c3c90b20ad61c5fa2ba7d494c1dba1 | grep ^v6
> v6.13-rc1
> v6.13-rc2
> v6.13-rc3
> v6.13-rc4
> v6.13-rc5
> ⬢ [acme@toolbox perf-tools-next]$ 
> ⬢ [acme@toolbox perf-tools-next]$ git merge perf-tools/perf-tools
> Already up to date.
> ⬢ [acme@toolbox perf-tools-next]$ git merge perf-tools/tmp.perf-tools
> Already up to date.
> ⬢ [acme@toolbox perf-tools-next]$
> 
> Running just:
> 
> # perf top --stdio
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: 0/0 [cpu_atom/cycles/P],  (all, 28 CPUs)
> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> Warning:
> A vmlinux file was not found.
> Kernel samples will not be resolved.
> ^C^C^C^Z
> [1]+  Stopped                 perf top --stdio
> root@number:/home/acme/git/pahole# 
> 
> But kernel addresses are being used and there is a matching vmlinux:
> 
> # pahole --running_kernel_vmlinux
> /lib/modules/6.13.0-rc2/build/vmlinux
> #
> 
> root@number:/home/acme/git/pahole# file /lib/modules/6.13.0-rc2/build/vmlinux
> /lib/modules/6.13.0-rc2/build/vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=d6f220b80bb50b35238aec50ed10f98df58849c0, with debug_info, not stripped
> root@number:/home/acme/git/pahole# perf buildid-list --kernel
> d6f220b80bb50b35238aec50ed10f98df58849c0
> root@number:/home/acme/git/pahole# 
> root@number:/home/acme/git/pahole# perf buildid-list -h --kernel
> 
>  Usage: perf buildid-list [<options>]
> 
>     -k, --kernel          Show current kernel build id
> 
> root@number:/home/acme/git/pahole#
> 
> I'm trying to figure this out now.

So the original logic seems borked, its a kernel sample that isn't
getting resolved, but that doesn't mean that other samples are not being
resolved, so we can't say a vmlinux wasn't found, as it _was_:

Thread 31 "perf" hit Breakpoint 2, perf_event__process_sample (tool=0x7fffffff9bd0, event=0x28ef890, evsel=0xf68860, sample=0x7fff867fb470, machine=0xf8e818) at builtin-top.c:813
813				if (symbol_conf.vmlinux_name) {
(gdb) p symbol_conf.vmlinux_name
$8 = 0x0
(gdb) p al
$9 = {thread = 0xfe8cd0, maps = 0xf8ee80, map = 0xf8f120, sym = 0x0, srcline = 0x0, addr = 23076781, level = 107 'k', filtered = 0 '\000', cpumode = 1 '\001', cpu = 0, socket = -1}
(gdb) p al.map
$10 = (struct map *) 0xf8f120
(gdb) p al.map->dso
$11 = (struct dso *) 0xf8ef30
(gdb) p al.map->dso->name 
$12 = 0xf8f0bb "[kernel.kallsyms]"
(gdb) p __map__is_kernel(al.map)
(gdb) $13 = true
(gdb) p map__has_symbols(al.map)
$14 = true

So looking at that logic I think we should just do those warnings if
there are no symbols:

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 724a7938632126bf..ca3e8eca6610e851 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -809,7 +809,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
+		    __map__is_kernel(al.map) && !map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 

With this in place we get there when we specify an ELF file that is not
suitable as a vmlinux, be it a mismatching vmlinux or some other random
ELF file, when we then end up with the kernel map "loaded" (attempted to
load but found it invalid, so no symbols in that map):

   PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: 0/0 [cpu_atom/cycles/P],  (all, 28 CPUs)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Warning:
The /bin/bash file can't be used: Mismatching build id
Kernel samples will not be resolved.

[2]+  Stopped                 perf top --stdio --vmlinux /bin/bash
root@number:~#

But why is that before your commig we seemingly would have entries in
the symtab that would cover addresses we now can't resolve?

One of these addresses is:

   0.58%  [kernel]                              [k] 0x00000000016001c1

Which...

root@number:~# pahole --running_kernel_vmlinux
/lib/modules/6.13.0-rc2/build/vmlinux
root@number:~#

root@number:~# readelf -sw /lib/modules/6.13.0-rc2/build/vmlinux | grep -B5 -A5 ' 0000000001600'
259227: ffffffff8156e290   262 FUNC    GLOBAL DEFAULT    1 zs_free
259228: ffffffff8183a4d0   269 FUNC    GLOBAL DEFAULT    1 security_inode_g[...]
259229: ffffffff81c8d900   191 FUNC    GLOBAL DEFAULT    1 devres_find
259230: ffffffff812e11c0    16 FUNC    GLOBAL DEFAULT    1 __pfx___probestu[...]
259231: ffffffff81c985a0    16 FUNC    GLOBAL DEFAULT    1 __pfx_pm_qos_sys[...]
259232: 0000000001600000     0 NOTYPE  GLOBAL DEFAULT  ABS text_size
259233: ffffffff81487f10   117 FUNC    GLOBAL DEFAULT    1 shmem_read_folio_gfp
259234: ffffffff81e08540   155 FUNC    GLOBAL DEFAULT    1 __traceiter_smbu[...]
259235: ffffffff811e13a0    16 FUNC    GLOBAL DEFAULT    1 __pfx_thaw_workqueues
259236: ffffffff81b04c70   599 FUNC    GLOBAL DEFAULT    1 acpi_install_method
259237: ffffffff81de7d40    16 FUNC    GLOBAL DEFAULT    1 __pfx_psmouse_se[...]
root@number:~#

There it is, that "text_size" symbol stayed with with a prev->end equal
to prev->start and thus 0x00000000016001c1 stops being resolved, which
leads us to get to that buggy warning.

I'll put all this into a patch and send it for review,

Thanks,

- Arnaldo
