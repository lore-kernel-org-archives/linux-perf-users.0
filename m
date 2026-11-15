Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717485;
	b=ZUUtabtq8rlJ2e60NzweyLdUE0Her+8AzrPwp7gt0HHpEbSVUTz+vovGtsVohwSoGELc
	 uZOCZYtNdLR398WiVOF5CWrqlqeJwhAHy0cO8HwooTtNPpICByrDiLezI9HaF0L1ZEAwW
	 7rurHgfkIVaoTA4sXwKrblfkqqMrvjvoS75zJ4DFe4HpeHijA36KsLQj6dp3obm/fwBwM
	 //5gEjO2kgavfO91oIzc+jaOs+oGcrZqLLRAchj6WSBbrRASHaC1grztVb2p7An0nWieY
	 ERCwXKH4yTHt7H5U3oim2buMZou7f2ZgWaS3cZDsatbJULFfjFNkrPBOtmVA4qTjU5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717485;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eTAtwv8LC/7Kmx51xP50msCZB6LstWUGVLLiw4wXJ4E=;
	b=ckXHK56mLmGJyG2W6Brq4HWwCrZUhzPXrsUj7XfgWeZDp39G8ld3H74fUu25oD9VQFVE
	 ErHF7x5JzRJ8dT6LmQB44oph5yXaZvUtRd9wocOt9R33gPi3a2rPk4EOY6FJbWPQ/3x4X
	 viE4MygNvfb5N6m7cni1nBry5pY/GEWV0EbDfN/PianwcZTeiIUFc3LbvX3xArxRCUGjz
	 v3dmegsd83NalMDUdyxA/CPpMlkhweme0EvzFHvpzEVwlEo1EnS69lOysciUpkWK1TLCw
	 tI6zFsEDVJbHZjpfWWLkLGwFJCjop5fdzJokIOyJnn/3iDokLaaTb7qaomNiXynlcfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dO62Rwp5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23F606A323;
	Sun, 15 Nov 2026 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dO62Rwp5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF11F000C4;
	Sun, 15 Nov 2026 04:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717484;
	bh=eTAtwv8LC/7Kmx51xP50msCZB6LstWUGVLLiw4wXJ4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dO62Rwp5k+lZdGhBAagX7icFaGZXztfIV8BWuFQ9aMxF2JlYdWqeCgSWinMgySk8P
	 VJPUnz8VHFeg/IblllImUA4QF9BoU3T21uNo5bkFdPXrh56OiN2QjglT+SGZeMRcMh
	 8nRhPqsBzvp7TLl7FkWpo9+Aoq+OxkOVIUqrnnLRPmzL0k6D8zxqHloJV+jEfSfqPc
	 8+ymDazW+oAi+pUhUF80d44wKCE0G2iuglVeB1RodB/oec7c96Gwpc7PpLGFWFDUDp
	 /O+14kNSlt3CDkZjYkPYrJkvUv4pw19a3Wg2jrqFx+DIvEyWP7VD3Om6Sleb7IeDuA
	 EUnB08Z6YBBxA==
Date: Sat, 14 Nov 2026 20:38:02 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, haghdoost@uber.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 16/23] perf maps: Optimize tail insertion and
 small-append sorting
Message-ID: <avk3KocLVDvvPbNU@z2>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-17-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113171734.2188066-17-irogers@google.com>

On Fri, Nov 13, 2026 at 09:17:27AM -0800, Ian Rogers wrote:
> User-space map insertions (from /proc/pid/maps synthesis, runtime
> PERF_RECORD_MMAP2, and jitdump) and BPF ksymbol registrations all flow
> through maps__fixup_overlap_and_insert() -> first_ending_after().
> Currently first_ending_after() has a fast-path check for the first map
> (maps_by_address[0]), but no fast-path check for the last map
> (maps_by_address[high]). Because /proc/pid/maps entries are synthesized
> in ascending address order, every synthesized mapping starts at or after
> maps_by_address[high]'s end, yet currently executes the full O(log N)
> binary search loop. Add a tail check in first_ending_after() so
> non-overlapping ascending insertions complete in O(1).
> 
> Additionally, track the sorted prefix lengths (nr_maps_by_address_sorted
> and nr_maps_by_name_sorted) in struct maps:
> - In __maps__sort_by_address() and maps__sort_by_name(), when the
>   unsorted tail is small (k <= 8) or the total map count is small
>   (n <= 64), binary-insert the newly appended maps into the sorted
>   prefix instead of re-running qsort() over the entire array. This
>   avoids O(N^2 log N) re-sorting when maps__find_by_name() is called
>   repeatedly between single-map maps__insert() calls in
>   dso__process_kernel_symbol() and dso__split_kallsyms().
> - In maps__by_address_index() and maps__by_name_index(), binary-search
>   the known-sorted prefix before scanning only the unsorted tail.
> - Add a unit test in tools/perf/tests/maps.c covering the tail
>   fast-path and incremental binary-insertion sort.
> 
> Using 'perf bench internals maps':
> 
>   Before:
>     Average ascending insert + lookup: 63.370 usec (+- 0.476 usec)
>     Average append + lookup: 7477.450 usec (+- 20.829 usec)
>   After (-6.9% ascending, -98.7% append):
>     Average ascending insert + lookup: 58.970 usec (+- 0.609 usec)
>     Average append + lookup: 96.670 usec (+- 1.353 usec)
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP] 
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index f808df2fe77b..98401fdd0e51 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
>  #include <stdlib.h>
> +#include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include "debug.h"
>  #include "dso.h"
> @@ -56,6 +57,16 @@ DECLARE_RC_STRUCT(maps) {
>  	 * maps_by_name.
>  	 */
>  	unsigned int	 nr_maps_allocated;
> +	/**
> +	 * @nr_maps_by_address_sorted: number of leading entries in
> +	 * maps_by_address that are known to be sorted.
> +	 */
> +	unsigned int	 nr_maps_by_address_sorted;
> +	/**
> +	 * @nr_maps_by_name_sorted: number of leading entries in maps_by_name
> +	 * that are known to be sorted.
> +	 */
> +	unsigned int	 nr_maps_by_name_sorted;

Can they be shorter like nr_{addr,name}_sorted?  Sorry for the naming
argument but I generally prefer short names.  As it has 'maps' in the
struct name, probably we can skip it.

Thanks,
Namhyung

