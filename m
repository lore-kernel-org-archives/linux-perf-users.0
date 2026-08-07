Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2A33C1AD
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114799; cv=none; b=SVGZmZNg1mp2ZOdQQ974G3cGEriX+/xw1Z42Ampv7KeGqx4tUXTIWWbh/fbrHUl8PiP7erp277zRcQjtnP9by3YZ04k6JQmlgO2rxD+FGKMWE8lnD7ILem+WEWkWzOegnr1MpmfhbK+h6TRcNSOEtZxY+plUc8V8zeVx52+qcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114799; c=relaxed/simple;
	bh=4T94AhgLEiS5axPpnOWYD7lSEqzueZkViesIwzig7IA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UeaAjIwYD8j6xDMOedlFw6U546y21X9Rr41o98+7jFUZnFAAc3ku5eHmzOJP2qYMIZjBGDEIdwksa5OZ1YEqRYNTqj2vh5JeLBBDrGSDovDkXohFs2R5iRl8b1C1VN6kQ9MeElUuP7hC+Q4+aLHIVZfww7vILmnGQUHtEm6nlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olc+Drq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olc+Drq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEF21F00A3D;
	Fri,  7 Aug 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114798;
	bh=cPhG5FWvMrZulkIo4hODIpgrWUdPgdzDAokvSJ7yiZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olc+Drq5k2r49upPvX9Nh7uOi7TYkVDRfsqqSFgRUvhzkab/luaGKa7sfEaBUE1Qm
	 ljld+mKh8yCZuaRje7L0NV/QOhgARko0LAHofvCpPvKHjaVfiwb4zdAr0XsWo44Pbs
	 XSlhaD8mdxd0E70Z2BkNvmdZX9oloRXt2H0UgKdFvtSxQEBit9jR3xyxUFx4n6c+7u
	 zRhuUPrtOpctlCKH2Dem7eS1rB1NC5sk4Mydw4j+GDNm5HwnyPdzrPPa9wsWBbejyu
	 2tGAT+iuG8Vvb9dheD8JUm+vxenH16u4m+xYoAiXmBOUM8yDE9YHlHeBVFyRyAmzPX
	 jYbr0wHNi3rKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807144135.2607-3-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
 <20260807144135.2607-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:59:57 +0000
Message-Id: <20260807145958.2AEF21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Heap buffer overflow in htm_info_fill() due to undersized PERF_REC=
ORD_AUXTRACE_INFO allocation for HTM evsels covering multiple CPUs.
- [Low] Missing explicit inclusion of `<string.h>` for `strcmp()`, violatin=
g musl libc compatibility guidelines.
--

--- Patch [2]: [PATCH V5 2/6] tools/perf: Add AUXTRACE recording support fo=
r powerpc HTM ---
commit 36cc90227b9052ae32b72e6b7df67e4e6bc7ac1e
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add AUXTRACE recording support for powerpc HTM

Add powerpc perf tool support for the HTM PMU AUXTRACE recording path.
Introduce htm_recording_init() and the associated auxtrace callbacks so
perf record can create PERF_RECORD_AUXTRACE records for HTM data.

> diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc=
/util/htm.c
> new file mode 100644
> index 0000000000000..d2fdef4880320
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/htm.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HTM AUX tracing support
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/zalloc.h>

[Severity: Low]
This isn't a bug, but this file uses strcmp() which is declared in <string.=
h>.
Does this code need to explicitly include <string.h> to avoid relying on
implicit inclusion, which might cause build failures in strictly conformant
musl libc environments?

[ ... ]

> +/* Count htm evsels in the evlist */
> +static int htm_nr_events(struct evlist *evlist)
> +{
> +	struct evsel *pos;
> +	int n =3D 0;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (!strcmp(evsel__pmu_name(pos), "htm"))
> +			n++;
> +	}
> +	return n;
> +}
> +
> +static size_t htm_info_priv_size(struct auxtrace_record *itr __maybe_unu=
sed,
> +				 struct evlist *evlist)
> +{
> +	return HTM_AUXTRACE_PRIV_SIZE(htm_nr_events(evlist));
> +}

[ ... ]

> +/*
> + * Fill the PERF_RECORD_AUXTRACE_INFO private data with:
> + *   priv[POWERPC_HTM_PMU_TYPE]   =3D pmu->type of the first htm evsel
> + *   priv[POWERPC_HTM_NUM_EVENTS] =3D total number of HTM CPU entries
> + *   priv[POWERPC_HTM_EVENT_DATA + n*2]     =3D CPU number for nth entry
> + *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] =3D attr.config for nth entry
> + *
> + * One entry is written per CPU in each evsel's cpu map.  An evsel opened
> + * with -C 0,1,2 contributes three entries (one per CPU), each carrying
> + * the same attr.config.  The decode side uses event->auxtrace.cpu to lo=
ok
> + * up the matching config and derive (node, chip, core) for the output
> + * file name.
> + */
> +static int
> +htm_info_fill(struct auxtrace_record *itr,
> +	      struct perf_session *session,
> +	      struct perf_record_auxtrace_info *auxtrace_info,
> +	      size_t priv_size)
> +{
> +	struct htm_recording *htm_r =3D container_of(itr, struct htm_recording,=
 itr);
> +	struct evlist *evlist =3D session->evlist;
> +	struct evsel *pos;
> +	int n =3D 0;
> +	int expected_n =3D htm_nr_events(evlist);
> +
> +	if (priv_size !=3D HTM_AUXTRACE_PRIV_SIZE(expected_n))
> +		return -EINVAL;
> +
> +	auxtrace_info->type =3D PERF_AUXTRACE_POWERPC_HTM;
> +	auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] =3D htm_r->evsel->core.attr.t=
ype;
> +	auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] =3D expected_n;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		struct perf_cpu_map *cpus;
> +		int i, nr;
> +
> +		if (strcmp(evsel__pmu_name(pos), "htm"))
> +			continue;
> +
> +		/*
> +		 * Emit one (cpu, config) entry for every CPU in this evsel's
> +		 * map.  perf record -C 0,1,2 creates one evsel with a
> +		 * three-entry cpu map; each CPU gets its own AUX buffer and
> +		 * must be individually mapped so the decoder can match
> +		 * event->auxtrace.cpu to the correct (node, chip, core).
> +		 */
> +		cpus =3D evsel__cpus(pos);
> +		nr =3D cpus ? perf_cpu_map__nr(cpus) : 0;
> +
> +		if (nr > 0) {
> +			for (i =3D 0; i < nr; i++) {
> +				int cpu =3D perf_cpu_map__cpu(cpus, i).cpu;
> +
> +				auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     =3D cpu;
> +				auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =3D
> +								pos->core.attr.config;
> +				n++;

[Severity: High]
Does this code overflow the auxtrace_info->priv[] array when an HTM evsel
covers multiple CPUs?

The auxtrace_info->priv[] buffer size is calculated by htm_nr_events() abov=
e,
which only counts the total number of HTM evsels. If a user runs perf record
with a CPU list (e.g., -C 0,1,2), there might be only 1 evsel, resulting in
space allocated for a single (cpu, config) pair.

However, this loop iterates over the CPU map and writes a pair for every CPU
in that evsel (e.g., 3 CPUs), incrementing n past the allocated size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807144135.2607=
-1-atrajeev@linux.ibm.com?part=3D2
