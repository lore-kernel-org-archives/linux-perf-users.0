Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195034CFC6
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896743; cv=none; b=UXuwJxCKcx1CApH5i0xKd9WPlWbfBgMyQN2EaFMYLzOdaXms09ffHocpqSXabxund0yLEHHZZ08jk8aXcoh2lrU0xvJDxGnO4sma9WzlOEuH2tUex5sQwKewtW70gLIwFqE2LDCord8+s8m5Lk+gjETNPzRXknr2W6WkMdQUJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896743; c=relaxed/simple;
	bh=YuZMTrY1GKfpXgCTi5LmLyvfYVaJE1jqwX/LyBPtq2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=brKO6mK5kXiRWX0BEl2WVEdQUunXrUpWC15SIGIPwApjPEnbaUgzI60OGqLBNCVViPE/xZan2p0qZ+ixdkrvB9wOHRMhj//bF56QEzEUrddUsWAKKDE+mlfBBYA/MQ1HaCMt4h14tUUOth3UVj+N4K2J9txnWaVql0xAXy5OG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW8mrm1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW8mrm1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1938F1F000E9;
	Wed,  1 Jul 2026 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896742;
	bh=P+n7Jj9Vo3fYM/4NTFfbONNFunlAj2KbauyihOyGxmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jW8mrm1ufe9so8sPCETAHsbJuHS4gwbYpXhJLHoCmYQsnToj1HBe0trd3PMZk080W
	 1UwPq/3WELkZD3k3yTw73E8PBdNu+ihIM3jxj0OQ6imDs8iy+ueFp6LJoT6rl9DCpZ
	 Bw7k1S828VVCWGheKpeiRk84P1sxPe/fPupjzM4oXOwdOr7uV2D2tzCvPGbh30dMgf
	 9C9u631yn7ViWaV4dXRlQx1CbhCP+CHuVkHpYvajd/Fufu54pOQb+Lp0OhWO3RhJHO
	 fxzkjy4bvkOWaWSMUR37x5aLVMuGZeDYnPKnJo7nDHeVrCetB+gU7A+Irj5Pi2tpof
	 Q2PgODK03PkfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] tools/perf: process htm auxtrace events and display
 in perf report -D
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-6-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-6-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:05:41 +0000
Message-Id: <20260701090542.1938F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Unchecked return value of evlist__event2evsel() leads to immediate=
 null pointer dereference.
- [High] Incorrect minimum size calculation for the auxtrace_info event all=
ows out-of-bounds read of the priv array.
- [High] Unconditionally creates and truncates files with predictable names=
 in the working directory, enabling data clobbering and symlink attacks.
- [High] Direct access to evsel->name without a NULL check leads to a crash=
 when an event is unnamed.
- [Medium] Missing explicit inclusion of POSIX standard headers (<stdio.h>,=
 <stdlib.h>, <string.h>), which breaks compilation on musl libc.
- [Medium] Metadata is improperly extracted from local evsel config instead=
 of serialized priv array, and htm_info_fill fails to populate the payload.
--

commit 30d1cdd44c59f9d127ce163684cc99673a095817
Author: Athira Rajeev <atrajeev@linux.ibm.com>
Subject: tools/perf: process htm auxtrace events and display in perf report=
 -D

This commit adds the htm pmu auxtrace process function for perf script -D.
It defines functions to handle PERF_RECORD_AUXTRACE_INFO records and setups
the aux data queues. It also writes the trace data to files based on node,
chip, and core indices.

> diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc=
/util/htm.c
> index cc733f45ac9b0..0e6638c02716c 100644
> --- a/tools/perf/arch/powerpc/util/htm.c
> +++ b/tools/perf/arch/powerpc/util/htm.c
> @@ -56,6 +56,7 @@ htm_recording_options(struct auxtrace_record *ar __mayb=
e_unused,
>  		if (strstarts(pos->name, "htm")) {

[Severity: High]
Does this unconditionally dereference pos->name?

The name field of an evsel can be dynamically allocated and might be NULL
for certain parsed or synthesized events.

Can passing NULL to strstarts() (which wraps strncmp()) cause an immediate
crash? A similar unconditional access to evsel->name without a NULL check
also appears to happen in arch_perf_record__need_read().

>  			pos->needs_auxtrace_mmap =3D true;
>  			pos->core.attr.aux_watermark =3D opts->auxtrace_mmap_pages * (size_t)=
page_size;
> +			pos->core.attr.sample_type |=3D PERF_SAMPLE_RAW;
>  			break;
>  		}
>  	}

[ ... ]

> @@ -75,6 +76,8 @@ htm_info_fill(struct auxtrace_record *itr __maybe_unuse=
d,
>  		struct perf_record_auxtrace_info *auxtrace_info __maybe_unused,
>  		size_t priv_size __maybe_unused)
>  {
> +	auxtrace_info->type =3D PERF_AUXTRACE_POWERPC_HTM;
> =20
>  	return 0;
>  }

[Severity: Medium]
Does this logic fail to serialize the hardware metadata?

Following the auxtrace standard, the hardware metadata should be serialized
into the auxtrace_info->priv array here, but it appears to be left empty.

[ ... ]

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index 5043ff41a609e..ffddf0e59fc14 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -9,6 +9,24 @@
>  #include "session.h"
>  #include "debug.h"
>  #include <internal/xyarray.h>
> +#include <linux/string.h>
> +#include "color.h"
> +#include <inttypes.h>
> +#include "powerpc-htm.h"
> +#include <errno.h>

[Severity: Medium]
Will this break the build on musl libc systems?

The code in powerpc-htm.c heavily uses FILE, fopen, fclose, snprintf, zallo=
c,
and free, but does not explicitly include the required POSIX standard heade=
rs
<stdio.h> and <stdlib.h>.

[ ... ]

> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
> +				  struct perf_session *session)
> +{
> +	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> +	struct evsel *evsel =3D evlist__event2evsel(session->evlist, event);
> +	u32 nodeindex, nodalchipindex, coreindexonchip;
> +	int config =3D (evsel->core.attr.config);

[Severity: High]
Can evlist__event2evsel() return NULL here if it fails to map the event?

If so, dereferencing it immediately for evsel->core.attr.config would lead
to a segmentation fault on crafted or corrupted perf.data files.

[Severity: Medium]
Is it correct to extract the metadata indices (nodeindex, etc.) from the lo=
cal
runtime evsel config?

For synthesized auxtrace events, evlist__event2evsel() often returns the fi=
rst
event in the list (which could be a dummy event), potentially yielding garb=
age
config values. Should these instead be read from the serialized
auxtrace_info->priv array?

> +	size_t min_sz =3D sizeof(u64) * POWERPC_HTM_TYPE;
> +	struct powerpc_htm *htm;
> +	int err;
> +	FILE *fp;
> +
> +	nodeindex =3D (config >> 4) & 0xff;
> +	nodalchipindex =3D (config >> 12) & 0xff;
> +	coreindexonchip =3D (config >> 20) & 0xff;
> +
> +	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_inf=
o) +
> +					min_sz)
> +		return -EINVAL;

[Severity: High]
Will min_sz evaluate to 0 because POWERPC_HTM_TYPE is 0 (the first element
in the enum)?

If so, this check will pass even for a payload with no priv elements.

[ ... ]

> +	htm->session =3D session;
> +	htm->machine =3D &session->machines.host; /* No kvm support */
> +	htm->auxtrace_type =3D auxtrace_info->type;
> +	htm->pmu_type =3D auxtrace_info->priv[POWERPC_HTM_TYPE];

[Severity: High]
Because of the size validation above passing for 0 elements, does reading
auxtrace_info->priv[POWERPC_HTM_TYPE] result in an out-of-bounds memory read
past the end of the validated event buffer?

> +
> +	htm->auxtrace.process_event =3D powerpc_htm_process_event;
> +	htm->auxtrace.process_auxtrace_event =3D powerpc_htm_process_auxtrace_e=
vent;
> +	htm->auxtrace.flush_events =3D powerpc_htm_flush;
> +	htm->auxtrace.free_events =3D powerpc_htm_free_events;
> +	htm->auxtrace.free =3D powerpc_htm_free;
> +	session->auxtrace =3D &htm->auxtrace;
> +
> +	snprintf(htm->htmbin_file, sizeof(htm->htmbin_file), "htm.bin.n%d.p%d.c=
%d", nodeindex, nodalchipindex, coreindexonchip);
> +	fp =3D fopen(htm->htmbin_file, "w");
> +	if (!fp) {
> +		pr_err("Failed to create %s: %s\n", htm->htmbin_file, strerror(errno));
> +		return -errno;
> +	}
> +	fclose(fp);

[Severity: High]
Could this enable data clobbering and symlink attacks?

By unconditionally constructing a predictable filename and opening it with =
"w",
this aggressively truncates any existing file in the current working
directory. An attacker could place a symlink here to truncate arbitrary fil=
es
when another user runs perf script.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D5
