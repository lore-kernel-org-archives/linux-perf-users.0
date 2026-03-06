Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185322D7B9
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755939; cv=none; b=F2YsvvmJQxlyIIkd3ltzm/YZd4PheC+HFrddQx93gjLD3MwoxXOdxFvadD86p7tzOwdtFDrUCXXJM/nn14Kzwx3m7jyWdJ1dfAi8zdyyMsWXiZiySdolQTABFJD3R4GS4+ugchvs0ENfS/lgnXgaI4h0wii1ehSTcXU0VC9Gwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755939; c=relaxed/simple;
	bh=VFE5Q6r/BsqbE9I9kWLyYXFvB2L7KGo0PCbBHQ7FgbY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5dy91Ij3h1KnXmcRInRVoN8k8NRgKyfnpzP918FE7r7/hHtCDjJ1TguO7fAMpOtLozgoIO7/Z/+yx5dt8l3t4T3QK5BYmOE8HXyqJURIqhMxbLcxm65wBR+lO3JhZNfdAZZu8iwaPn+ENy4ckzIwaJTLzFNomodtDZ/jJSBgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BPn5JDRk; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BPn5JDRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ujmfgvqhifdvdn7vpd5hyobhcm.protonmail; t=1772755928; x=1773015128;
	bh=O9+GzxDNQjalgQgAYXLPoktkB3BKo0iUQzGGAi0joSc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BPn5JDRkUrVxckO4V+o/Av7uH5WoNJ5q/4tmftKQK+fYOHp61brUKhfR8EawFXkrg
	 h7pmf/0yjLgeEFmt4q9CKVdmdo4cFZJ62GeWHwncrc1HcRvK0Z4ZbCHULRsllfVWvL
	 5H5Ya63D8aB9nOUTMBrCR4p8AZxZFKRLUdDVHi0RpJ/lMYNO7hhbkfgRF27b/3cEFk
	 q1PbeaH2gH7PNtO55WPypBk4K9Vn7ePvNrXJRtngYFeYDyCc45oBwJQCQH7MJivWjG
	 Mujc09XL0xQnPTNmBCh/OcGQ9R2uQ3MVSFbrTKqWanSxWl4CqkGOvl/HzkF8ihw2R3
	 4Wg5n+a6rfetg==
Date: Fri, 06 Mar 2026 00:12:04 +0000
To: namhyung@kernel.org
From: Ricky Ringler <ricky.ringler@proton.me>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ricky Ringler <ricky.ringler@proton.me>
Subject: Re: [PATCH v2] perf utilities: cln_size header
Message-ID: <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me>
In-Reply-To: <20260305235655.40779-1-ricky.ringler@proton.me>
References: <20260214040659.168769-2-ricky.ringler@proton.me> <aaeKBOolC3AyHAFa@google.com> <20260305235655.40779-1-ricky.ringler@proton.me>
Feedback-ID: 171348601:user:proton
X-Pm-Message-ID: e576ec7c27cd29114dffbbb9201f9c60a3d14a9c
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Apologies all. I just realized I rebased on the kernel instead of perf-tool=
s-next. Please hold off reviewing. I will submit a v3 patch rebased on perf=
-tools-next.

On Thursday, March 5th, 2026 at 5:57 PM, Ricky Ringler <ricky.ringler@proto=
n.me> wrote:

> Store cacheline size during perf record in header, so
> that cacheline size can be used for other features, like
> sort.
>=20
> Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"
>=20
>  Testing:
> - Built perf
> - Ran record + report with feat enabled
> - Ran record + report with feat disabled
>=20
> Tested-by: Ricky Ringler <ricky.ringler@proton.me>
> Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
> ---
>  tools/perf/builtin-inject.c |  1 +
>  tools/perf/util/env.h       |  1 +
>  tools/perf/util/header.c    | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/header.h    |  1 +
>  tools/perf/util/sort.c      | 37 ++++++++++++++++++++++++++-----------
>  5 files changed, 58 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index aa7be4fb5838..9639154459d9 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2047,6 +2047,7 @@ static bool keep_feat(int feat)
>  =09case HEADER_CLOCK_DATA:
>  =09case HEADER_HYBRID_TOPOLOGY:
>  =09case HEADER_PMU_CAPS:
> +=09case HEADER_CLN_SIZE:
>  =09=09return true;
>  =09/* Information that can be updated */
>  =09case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 9977b85523a8..04580c64847b 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -93,6 +93,7 @@ struct perf_env {
>  =09struct cpu_topology_map=09*cpu;
>  =09struct cpu_cache_level=09*caches;
>  =09int=09=09=09 caches_cnt;
> +=09unsigned int=09=09cln_size;
>  =09u32=09=09=09comp_ratio;
>  =09u32=09=09=09comp_ver;
>  =09u32=09=09=09comp_type;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f5cad377c99e..ad15829acc69 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -54,6 +54,7 @@
>  #include "bpf-event.h"
>  #include "bpf-utils.h"
>  #include "clockid.h"
> +#include "cacheline.h"
> =20
>  #include <linux/ctype.h>
>  #include <internal/lib.h>
> @@ -1288,6 +1289,18 @@ static int write_cache(struct feat_fd *ff,
>  =09return ret;
>  }
> =20
> +static int write_cln_size(struct feat_fd *ff,
> +=09=09       struct evlist *evlist __maybe_unused)
> +{
> +=09int cln_size =3D cacheline_size();
> +
> +=09if (!cln_size)
> +=09=09cln_size =3D 0;
> +=09ff->ph->env.cln_size =3D cln_size;
> +
> +=09return do_write(ff, &cln_size, sizeof(cln_size));
> +}
> +
>  static int write_stat(struct feat_fd *ff __maybe_unused,
>  =09=09      struct evlist *evlist __maybe_unused)
>  {
> @@ -2084,6 +2097,11 @@ static void print_cache(struct feat_fd *ff, FILE *=
fp __maybe_unused)
>  =09}
>  }
> =20
> +static void print_cln_size(struct feat_fd *ff, FILE *fp __maybe_unused)
> +{
> +=09fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
> +}
> +
>  static void print_compressed(struct feat_fd *ff, FILE *fp)
>  {
>  =09fprintf(fp, "# compressed : %s, level =3D %d, ratio =3D %d\n",
> @@ -2933,6 +2951,16 @@ static int process_cache(struct feat_fd *ff, void =
*data __maybe_unused)
>  =09return -1;
>  }
> =20
> +static int process_cln_size(struct feat_fd *ff, void *data __maybe_unuse=
d)
> +{
> +=09struct perf_env *env =3D &ff->ph->env;
> +
> +=09if (do_read_u32(ff, &env->cln_size))
> +=09=09return -1;
> +
> +=09return 0;
> +}
> +
>  static int process_sample_time(struct feat_fd *ff, void *data __maybe_un=
used)
>  {
>  =09struct perf_session *session;
> @@ -3453,6 +3481,7 @@ const struct perf_header_feature_ops feat_ops[HEADE=
R_LAST_FEATURE] =3D {
>  =09FEAT_OPR(CLOCK_DATA,=09clock_data,=09false),
>  =09FEAT_OPN(HYBRID_TOPOLOGY,=09hybrid_topology,=09true),
>  =09FEAT_OPR(PMU_CAPS,=09pmu_caps,=09false),
> +=09FEAT_OPR(CLN_SIZE,=09cln_size,=09false),
>  };
> =20
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index c058021c3150..04394331630f 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -53,6 +53,7 @@ enum {
>  =09HEADER_CLOCK_DATA,
>  =09HEADER_HYBRID_TOPOLOGY,
>  =09HEADER_PMU_CAPS,
> +=09HEADER_CLN_SIZE,
>  =09HEADER_LAST_FEATURE,
>  =09HEADER_FEAT_BITS=09=3D 256,
>  };
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index aa79eb6476dd..e636b9f88e5c 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -30,6 +30,7 @@
>  #include "time-utils.h"
>  #include "cgroup.h"
>  #include "machine.h"
> +#include "session.h"
>  #include "trace-event.h"
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> @@ -2474,7 +2475,26 @@ struct sort_entry sort_type_offset =3D {
> =20
>  /* --sort typecln */
> =20
> -#define DEFAULT_CACHELINE_SIZE 64
> +static int
> +hist_entry__cln_size(struct hist_entry *he)
> +{
> +=09int ret =3D 0;
> +
> +=09if (he && he->hists) {
> +=09=09struct evsel *evsel =3D hists_to_evsel(he->hists);
> +
> +=09=09if (evsel && evsel->evlist->session && evsel->evlist->session)
> +=09=09=09ret =3D evsel->evlist->session->header.env.cln_size;
> +=09}
> +
> +=09if (!ret || ret < 1) {
> +=09=09int default_cacheline_size =3D 64; // avoid div/0 later
> +
> +=09=09ret =3D default_cacheline_size;
> +=09}
> +
> +=09return ret;
> +}
> =20
>  static int64_t
>  sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
> @@ -2482,11 +2502,9 @@ sort__typecln_sort(struct hist_entry *left, struct=
 hist_entry *right)
>  =09struct annotated_data_type *left_type =3D left->mem_type;
>  =09struct annotated_data_type *right_type =3D right->mem_type;
>  =09int64_t left_cln, right_cln;
> +=09int64_t cln_size_left =3D hist_entry__cln_size(left);
> +=09int64_t cln_size_right =3D hist_entry__cln_size(right);
>  =09int64_t ret;
> -=09int cln_size =3D cacheline_size();
> -
> -=09if (cln_size =3D=3D 0)
> -=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
> =20
>  =09if (!left_type) {
>  =09=09sort__type_init(left);
> @@ -2502,8 +2520,8 @@ sort__typecln_sort(struct hist_entry *left, struct =
hist_entry *right)
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09left_cln =3D left->mem_type_off / cln_size;
> -=09right_cln =3D right->mem_type_off / cln_size;
> +=09left_cln =3D left->mem_type_off / cln_size_left;
> +=09right_cln =3D right->mem_type_off / cln_size_right;
>  =09return left_cln - right_cln;
>  }
> =20
> @@ -2511,10 +2529,7 @@ static int hist_entry__typecln_snprintf(struct his=
t_entry *he, char *bf,
>  =09=09=09=09     size_t size, unsigned int width __maybe_unused)
>  {
>  =09struct annotated_data_type *he_type =3D he->mem_type;
> -=09int cln_size =3D cacheline_size();
> -
> -=09if (cln_size =3D=3D 0)
> -=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
> +=09int cln_size =3D hist_entry__cln_size(he);
> =20
>  =09return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->self.t=
ype_name,
>  =09=09=09       he->mem_type_off / cln_size);
> --=20
> 2.53.0
>=20
> 
