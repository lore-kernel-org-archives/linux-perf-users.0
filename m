Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874207;
	b=a9njWrYHEPQkPC3Ep+STxPfwy4bTQCy6tumPOWxISpWTjQ5L7xdmtj/pl7XzOI/k2XeN
	 uy2PcmuyAROeadKiZE+Khhs7P6dCZNc7/kq4q22Bif1kZ2mikIdBnmdK+0BsDM4Z9NzTo
	 tT8RNk20o2fqP9nSWr6SKRqCOKMF+wzZ39DJZ75arkKtjFrVlCk75DNnEiEKHrJBTcObc
	 0wd44+ZF+Ka9iCqWSme78+QaZT7aiSBhGDJwbP2r3Ui1MFEs9GzZRK37x727CQ2mCxzMQ
	 bwXeqhzh/yX2tKk1lC/c7GccTRGejyNam+i781ReGkWDCYU0PIfCxw6axHISyLd2Q9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874207;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6nCa6du6skxGM+5g/s0pjC3B870Fl/Uih2OQbEFVArc=;
	b=kC4xAQGj14pSt5GmnDSaTczJZ7xxI4Vm3eAo0lFbFJYFmyPwPI7L6HAB4c8jY4RWDzUa
	 h2nJ/ZENHZ5YSCMU0dZC8lgtHlkomrFYcxH9oT7Zc6W2PHcLarPCRMpJIbms5oYLbHs34
	 K85BfOVVOmi4Y1uRmXROFmIrg/gyFLgZ4jIPETbpY8lpyzFi8Ft9CsGRruuun9w01t06R
	 y9w2Hx0LcpMJU5aV7WzwmLnNtkh+sclKdOVY9kKMS/7NVadNQghxIjKByqEVKg/FLqJMM
	 LjE01s/OxScuwgie//BJ1h3m87AzsaOoOMz8kEOBHIJcKFuF7QV1VRTz7PmkUUsrT9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkdQt1rY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9E606A31C;
	Tue, 17 Nov 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkdQt1rY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF891F000C7;
	Tue, 17 Nov 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874206;
	bh=6nCa6du6skxGM+5g/s0pjC3B870Fl/Uih2OQbEFVArc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mkdQt1rYNlGi2fOmE89kHOcE7oBot+6Q6cgG5dc17VQkf/p3Nx6n7Nqz1wiMkldJl
	 pimwLm/OKTCywL538UxyK5D3IVJUj5fhXLZ/TnirbtYR1RfT9L6HSxt1xmwwzJfubF
	 BVKW9gZIjGW81y9ruaLvEnCIHIcgBSU4dXQRTY7SHuy+npjTfXIJ3xv6d3gpkwM+rb
	 MIoWUTvEY3cZoV/1NcX5iQzTVrp6gzDVF60tzoQWm26VqI+8LGgb7J3P3x86uuIKaa
	 kc9yqjMxk3nPD/TA8umfSEj3WdUWfTHeLJaZmpXogeQHswzIVAejz1KaAN4WATUtZU
	 X+BjTgASPnk1g==
Date: Mon, 16 Nov 2026 21:10:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v4 03/12] perf annotate-data: Resolve DW_OP_addrx global
 variables
Message-ID: <avubWsVfjfyWXWnN@phoenix2>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-4-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116234659.3950531-4-acme@kernel.org>

On Mon, Nov 16, 2026 at 08:46:49PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> clang emits DW_AT_location with DW_OP_addrx for global variables in
> DWARF 5, gcc emits DW_OP_addr.  The address index was not resolved, so
> those variables were not found by address; the by-name fallback also
> missed the ones in .bss past the file backed end of the last segment.
> 
> Resolve the index with dwarf_getlocation_attr() + dwarf_formaddr() and
> use the resulting address in the by-address lookup and in the global
> variable cache.  The new global_data workload keeps a zero initialized
> struct in .bss and its test checks that the accesses are annotated: when
> perf is built with clang and DWARF 5 it goes through DW_OP_addrx, with
> gcc through DW_OP_addr.  The test skips on 32-bit PIE builds, which
> load globals through the GOT, something the resolver does not follow.

[PATCH v4 2/4] perf dwarf-aux: Support DW_OP_addrx locations for global variables

By James fixes this, I'll leave this just as a shell test in v5.

- Arnaldo

 
> Fixes: d60469d7c0e5c4e8 ("perf dwarf-aux: Add die_find_variable_by_addr()")
> Fixes: d7b60803a790b716 ("perf dwarf-aux: Add die_collect_global_vars()")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/builtin-test.c            |  1 +
>  tools/perf/tests/shell/data_type_global.sh | 70 ++++++++++++++++++++++
>  tools/perf/tests/tests.h                   |  1 +
>  tools/perf/tests/workloads/Build           |  2 +
>  tools/perf/tests/workloads/global_data.c   | 55 +++++++++++++++++
>  tools/perf/util/annotate-data.c            |  4 ++
>  tools/perf/util/dwarf-aux.c                | 37 ++++++++++--
>  tools/perf/util/dwarf-aux.h                |  5 ++
>  8 files changed, 170 insertions(+), 5 deletions(-)
>  create mode 100755 tools/perf/tests/shell/data_type_global.sh
>  create mode 100644 tools/perf/tests/workloads/global_data.c
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 86698b86657f45b0..299e07bd16a5a53f 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -199,6 +199,7 @@ static struct test_workload *workloads[] = {
>  	&workload__deterministic,
>  	&workload__callchain,
>  	&workload__false_sharing,
> +	&workload__global_data,
>  
>  #ifdef HAVE_RUST_SUPPORT
>  	&workload__code_with_type,
> diff --git a/tools/perf/tests/shell/data_type_global.sh b/tools/perf/tests/shell/data_type_global.sh
> new file mode 100755
> index 0000000000000000..7db2e898a41657bc
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_type_global.sh
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# perf data type profiling test for a global variable
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> +
> +cleanup()
> +{
> +	rm -f "$perfdata" "$perfout"
> +	trap - EXIT TERM INT
> +}
> +
> +trap_cleanup()
> +{
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +if ! perf check feature -q dwarf; then
> +	echo "Skip: no DWARF (libdw) support"
> +	cleanup
> +	exit 2
> +fi
> +
> +# 32-bit PIE loads globals through the GOT, which the resolver does not follow
> +if [ "$(getconf LONG_BIT)" = 32 ] &&
> +   [ "$(od -An -tx1 -j16 -N2 "$(command -v perf)" | awk '{print $1}')" = 03 ]; then
> +	echo "Skip: 32-bit PIE uses GOT-relative global accesses"
> +	cleanup
> +	exit 2
> +fi
> +
> +# No point in recording if the PMU cannot do memory events.
> +if perf mem record -o /dev/null -- true 2>&1 | \
> +		grep -q "failed: no PMU supports the memory events"; then
> +	cleanup
> +	exit 2
> +fi
> +if ! perf mem record -o /dev/null -- true 2>/dev/null; then
> +	echo "Skip: cannot record memory events on this PMU"
> +	cleanup
> +	exit 2
> +fi
> +
> +if ! perf mem record -o "$perfdata" -- perf test -w global_data 1 > /dev/null 2>&1; then
> +	echo "FAIL: perf mem record"
> +	cleanup
> +	exit 1
> +fi
> +
> +if ! perf annotate --code-with-type -i "$perfdata" --stdio \
> +		--percent-limit 1 > "$perfout" 2>/dev/null; then
> +	echo "FAIL: perf annotate"
> +	cleanup
> +	exit 1
> +fi
> +
> +if ! grep -q "# data-type: struct conn" "$perfout"; then
> +	echo "FAIL: global variable in .bss not resolved"
> +	cleanup
> +	exit 1
> +fi
> +
> +echo "global variable resolved"
> +cleanup
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 8c399840a735910d..bbd23dd7e0455a9d 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -272,6 +272,7 @@ DECLARE_WORKLOAD(context_switch_loop);
>  DECLARE_WORKLOAD(deterministic);
>  DECLARE_WORKLOAD(callchain);
>  DECLARE_WORKLOAD(false_sharing);
> +DECLARE_WORKLOAD(global_data);
>  
>  #ifdef HAVE_RUST_SUPPORT
>  DECLARE_WORKLOAD(code_with_type);
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 43cc4da6fb0786de..03017aaaaa0bec32 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -17,6 +17,7 @@ perf-test-y += context_switch_loop.o
>  perf-test-y += deterministic.o
>  perf-test-y += callchain.o
>  perf-test-y += false_sharing.o
> +perf-test-y += global_data.o
>  
>  ifeq ($(CONFIG_RUST_SUPPORT),y)
>      perf-test-y += code_with_type.o
> @@ -35,3 +36,4 @@ CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_callchain.o        = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_false_sharing.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_global_data.o      = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/global_data.c b/tools/perf/tests/workloads/global_data.c
> new file mode 100644
> index 0000000000000000..63da5300c5d92387
> --- /dev/null
> +++ b/tools/perf/tests/workloads/global_data.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A zero initialized global struct, so it lands in .bss, past the file
> + * backed end of the last segment.  clang describes its address with
> + * DW_OP_addrx in DWARF 5, gcc with DW_OP_addr.
> + *
> + * 'perf mem record' of this workload followed by 'perf annotate
> + * --code-with-type' (see tests/shell/data_type_global.sh) resolves the
> + * accesses to struct conn.
> + */
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +struct conn {
> +	int saddr;
> +	int daddr;
> +	long bytes;
> +};
> +
> +static volatile struct conn conn;
> +static volatile unsigned long conn_sink;
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +	done = 1;
> +}
> +
> +static int global_data(int argc, const char **argv)
> +{
> +	unsigned long sum = 0;
> +	int i = 0;
> +	int sec = 1;
> +
> +	if (argc > 0)
> +		sec = atoi(argv[0]);
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGALRM, sighandler);
> +	alarm(sec);
> +
> +	while (!done) {
> +		conn.saddr = i;
> +		conn.daddr = i + 1;
> +		sum += conn.bytes;
> +		i++;
> +	}
> +	conn_sink = sum;
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(global_data);
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index dd9c1d7b2da8be8a..d8d00646ef63b30f 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -140,6 +140,10 @@ static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
>  		case DW_OP_addr:
>  			pr_info("address=%#lx\n", (long)ops->number);
>  			break;
> +		case DW_OP_addrx:
> +		case DW_OP_GNU_addr_index:
> +			pr_info("address index=%#lx\n", (long)ops->number);
> +			break;
>  		default:
>  			pr_info("unknown: code=%#x, number=%#lx\n",
>  				ops->atom, (long)ops->number);
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 48a11c95a67686e4..8736229d567e158c 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1629,6 +1629,31 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
>  	return result;
>  }
>  
> +/*
> + * Get the absolute address of a location expression that consists of a
> + * single address, either DW_OP_addr or DW_OP_addrx.  libdw leaves the
> + * DWARF 5 address index unresolved, it has to be looked up in .debug_addr.
> + */
> +static bool die_get_location_addr(Dwarf_Attribute *attr, Dwarf_Op *ops,
> +				  Dwarf_Addr *addr)
> +{
> +	if (ops->atom == DW_OP_addr) {
> +		*addr = ops->number;
> +		return true;
> +	}
> +
> +	if (ops->atom == DW_OP_addrx) {
> +		Dwarf_Attribute addr_attr;
> +
> +		if (dwarf_getlocation_attr(attr, ops, &addr_attr) != 0)
> +			return false;
> +
> +		return dwarf_formaddr(&addr_attr, addr) == 0;
> +	}
> +
> +	return false;
> +}
> +
>  /* Only checks direct child DIEs in the given scope */
>  static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
>  {
> @@ -1647,11 +1672,13 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
>  		return DIE_FIND_CB_SIBLING;
>  
>  	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
> -		if (ops->atom != DW_OP_addr)
> +		Dwarf_Addr addr;
> +
> +		if (!die_get_location_addr(&attr, ops, &addr))
>  			continue;
>  
>  		if (check_allowed_ops(ops, nops) &&
> -		    match_var_offset(die_mem, data, data->addr, ops->number,
> +		    match_var_offset(die_mem, data, data->addr, addr,
>  				     /*is_pointer=*/false))
>  			return DIE_FIND_CB_END;
>  	}
> @@ -1777,7 +1804,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	Dwarf_Die type_die;
>  	int tag = dwarf_tag(die_mem);
>  	Dwarf_Attribute attr;
> -	Dwarf_Addr base, start, end;
> +	Dwarf_Addr base, start, end, addr;
>  	Dwarf_Op *ops;
>  	size_t nops;
>  	struct die_var_type *vt;
> @@ -1792,7 +1819,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
>  		return DIE_FIND_CB_SIBLING;
>  
> -	if (ops->atom != DW_OP_addr)
> +	if (!die_get_location_addr(&attr, ops, &addr))
>  		return DIE_FIND_CB_SIBLING;
>  
>  	if (!check_allowed_ops(ops, nops))
> @@ -1808,7 +1835,7 @@ static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
>  	vt->die_off = dwarf_dieoffset(&type_die);
>  	vt->die_tag = dwarf_tag(&type_die);
>  	vt->from_alt = !die_same_file(die_mem, &type_die);
> -	vt->addr = ops->number;
> +	vt->addr = addr;
>  	vt->end = 0;
>  	vt->has_range = false;
>  	vt->reg = -1;
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 803182cdff8a3b4f..0c1297507bd2c254 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -10,6 +10,11 @@
>  #include <elfutils/libdwfl.h>
>  #include <elfutils/version.h>
>  
> +/* DWARF 5 address index, libdw's dwarf_getlocations() returns it unresolved */
> +#ifndef DW_OP_addrx
> +#define DW_OP_addrx 0xa1
> +#endif
> +
>  static inline const char *die_name(Dwarf_Die *die)
>  {
>  	return dwarf_diename(die) ?: "<unknown>";
> -- 
> 2.56.0
> 
