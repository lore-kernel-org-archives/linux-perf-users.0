Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E643AE1A6
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002491; cv=pass; b=uzNDJbZ61K/b4FDIX+Ui2q9XO8DpxyKZzrZ6fwkM0v7fff0LHGmEFne6LuO5p6qtm1rV8VRGtZc0/whEANhXhMzzB6ZZvmSrSffX3KgJQ3ljtasPrNyVVHJP/uBZ5APZixKlcd335jgvWp/wsyefbTfr5/MVSew4onpatButMNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002491; c=relaxed/simple;
	bh=oi7NGKLvOKjaijvbHzRLPYD3WV0x5mirsGJI2iGWnoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhiifznk2K8YIG6xOeRQN0psmx716H2K+zHNpw1v+4BWCoEvxUM2jemeFXElOFA6qmSjtwMHCdUhNY9NU5SHNeCbjqSJcEEZ1S5+0uEY34e28a5oFFYdn4xkyQ7ZFLpaiP5FrlWx2sKXiJ9Q0I88nhASp12a3QznCqVS8pM4+EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRUdClsP; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRUdClsP"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c01c79467so95881cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002487; cv=none;
        d=google.com; s=arc-20260327;
        b=Jg0ESa8zXYxDI1HWCdVe221xuhuyxHfP7si4+zGoAUNf39b1lOj918hyKiP+WqXGep
         KPh06jHVDoQbTX4Pkzknhjei7Feu2Y0V2P7DwqoeoOqeIAEWsSP5w/MuYPNYxIkvkHVT
         WIKHkzIyzQ5sJbl36+lDxhlnF6IXu2avPgLGArsH3xppfizbQoybmoiyfTDNxevta9N8
         +9pBJqfKYA4Z6dZFc8ONV1NxGw9/WLwMD8BnBI9j9lI3Yw6ZqXMLl2s//jb9SM1Ejroa
         vm5LVn93SrUToDdTMfj+Grzb004D90jN8j6gxtsApotsHX27P+rugS/UAKIj5NQlCEzO
         guSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dih/w18yldFKiGaW5D/H+lMt+01iZstD43pDoyRHa+A=;
        fh=7mFkBhBFxqyew3Kq1hOfZqoqe/QjpBTp5kSS0mU/HBk=;
        b=KHzkdJE3BqZWZA+uQMBQFybsBSLCnXyVmp9b2P9WB5tXGQSNKrmOMXvpGX1akBO0DC
         FowQybks5QPrAP9UttXC2vsyXy3kEEkGKcalwqo8luqL/o4y0kS0ABYpZ2hKz/jMkIhC
         oxCpzfm+ABTSaL6DDnOZr6CuIucU9tOL5//PU80Of3BYGeBD21sxMxVarhxFIPgZ56dT
         y1wKk9wwe5OINDjUA5j/TrjxWtqYsbJ65GcRU5vXvGmx942l1RmurUmNsETJ7lQOucBc
         fK5P2QwtHGcWSONnvzHtzV4PpA9vt7l44pHiDsGl6AUgNJzYtQ+8+4uve8iKKeNp9U3g
         Sygg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787002487; x=1787607287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dih/w18yldFKiGaW5D/H+lMt+01iZstD43pDoyRHa+A=;
        b=KRUdClsPzA1AC09Hqs7K3LatxGFWoifm4hxmVGm6sodzsXYeg7+8UPCQniNie4gaOH
         b2F4H1KBKSywFnc7VQxTgB8hZdJGlWeC6cYh67Qorj3VF7NYIROr+dkH2TWVf9I3Gt5C
         ewUrk+OhlO22XpRx9t2oJeLBtdyyyEBeQxwjHokOu48TM+u3Dv+VRZGz9R/nCBaMkaul
         37qm0Ry7gz3KxstW5u4qfntpQ/lbE1DSJVK6amu9B9Uf4Tcg2SNui2zJ7zr0LSxYRhBE
         6roJB9af5MH6mV1m360Rh1e/KtROZoW0PwWm0n4SdYRUHjd0DxRVJTqZ5ZT0T0zXXOVB
         r+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002487; x=1787607287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dih/w18yldFKiGaW5D/H+lMt+01iZstD43pDoyRHa+A=;
        b=tFNaFY7/WFNWGg1Gl30ct4bC4h7NqROWuY8PnpP4Lpjs9w1/cJtopOJZoP0wpYIk7S
         xPfsdYjxZUGF8P8Uirq3G89UYiwP+8mSYrvCLdm5mHdqU47qis0l2kKAWGVRyqcCzCIe
         ah1h6iKYsrUliZ5KHz8mOdW/Ceuxc4c0YSxpePsdDiSZcswB13BkrpwZCxOKK8DNr0FI
         yfyap7RqmAdJ7G3turPY/I3BTuQjcoTV/JRnwqKgjZoz/f+zgTNddWSDqP5oi91JhYMw
         FAs36z0/HYXlZ35ZgjF7PCFIf+25i6303Gx1uuBMmevjmYOU+Sy+ePR+1mh+dyPhN2Ed
         7I7g==
X-Forwarded-Encrypted: i=1; AHgh+RpsQr9Jhy5/EdA2XYe80crBTLZd/Vy7UWyF7nsZsuZXimNTDPbrah4LFMc8VGU0H0pcZlPoTpi3WVH1MN0lp643@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eU5S+qgEK2WPg60UpLCgTW+W30JorqGSeTRiPOlPcv3sBX7/
	DpAUXn3OYSKOcjSNa2hR/g3807a7I07NlqkwuL/LioU00kvSIkZbw54dmWBbsK/bUdybNzCopJ8
	uuWAM2AG+a5T3uG5r2Go6dgsn0OqmxcYpmEvjKFCrXogYh4nxowAX9GLW
X-Gm-Gg: AR+sD10WSY07wsa7hBGQq56EE/Fgzfl3IRMxgwOhKznduyJ8v13ljiR3YM+B+969q/F
	OTqCpcjpMSq11UKjgY0px4HmlkABXo+5skW+GBiONvLJiBvQpSch9eFg1wPUWQ/5u0dveYNkYDy
	nXhrxAMSWikq/4bTADMUozwYO2smgUnGkeISe1RcUygJcnKT8LOPzI4lgFaSoTGUYIQGtxN5aZq
	b3cr9JRzfYh5OGqMQplL4UlPjUah/XwLRKamduUdLTTb6fmyeY+fSVgZ7+GgC1r+KHSnAQ3JFmi
	pyjNxrbvevYuiBTgdboVk/Nu2CgO9LdefaTnEhXpc8kWm36siofgor+NqyPy2T/bmnd7qKRoaXk
	=
X-Received: by 2002:a05:622a:4816:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-52dc0403042mr5675061cf.0.1787002486021; Mon, 17 Aug 2026
 14:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com> <20260811173340.96013-4-thomas.falcon@intel.com>
In-Reply-To: <20260811173340.96013-4-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:34:34 -0700
X-Gm-Features: AcwNN1VvlFBc6oL9Eyp1wggySqT8ocjqJNkW4n5fn9HutREzx9FENOF0eg9-5sk
Message-ID: <CAP-5=fVpJQBX=g_s+-j2rdRKZ618+52j=EtzOZYLMd8r3KS=ug@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] perf header: Support memory ranges
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:33=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> Memory ranges were created to track different types of memory,
> such as persistent, high bandwidth, or CXL-attached, that may
> be present on a system for performance monitoring and resource
> control purposes.
>
> Memory range data are parsed from the ACPI MRRM table and exposed
> to userspace tools via sysfs [1]. Memory range data is read from:
>
>         /sys/firmware/acpi/memory_ranges/rangeX
>
> With the following attributes:
>
>         u64 base;
>         u64 length;
>         int node;
>         u8  local_region_id;
>         u8  remote_region_id;
>
> Read memory range data from sysfs if present and save it in
> the header of the perf data file under a new feature bit,
> HEADER_MEMORY_RANGES (35). Memory range data can be viewed with the
> --header or --header-only options of perf-report and perf-script.
>
> Example output:
>  # memory ranges (nr 5):
>  # range0: [0x0000000000000000-0x00000000bfffffff], node =3D 0, local_reg=
ion_id =3D 0, remote_region_id =3D 255
>  # range1: [0x0000000100000000-0x000000203fffffff], node =3D 0, local_reg=
ion_id =3D 0, remote_region_id =3D 255
>  # range2: [0x0000008000000000-0x0000027fffffffff], node =3D -2, local_re=
gion_id =3D 1, remote_region_id =3D 255
>  # range3: [0x0000028000000000-0x0000047fffffffff], node =3D -2, local_re=
gion_id =3D 1, remote_region_id =3D 255
>  # range4: [0x0000048000000000-0x000004ffffffffff], node =3D -2, local_re=
gion_id =3D 1, remote_region_id =3D 255
>
> [1]: https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel=
.com/
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Looks good to me. Did you do pipe mode testing? Is there any
additional testing coverage we can add?

Thanks,
Ian

> ---
> v4:
> -- Fixed bounds checking for local and remote region IDs in
>    memory_range__read(), which made region "255" invalid
>
> v3:
> -- Added missing ff->size check in process_memory_ranges()
> -- used open/openat to read memory range sysfs files in memory_range__rea=
d()
> -- Removed path name and file name buffers in memory_range__read(),
>    instead pass path name from as a parameter from memory_range__parse()
> -- use calloc instead of zalloc in memory_range__parse() and
>    process_memory_ranges()
> -- Removed redundant check for existance of memory range directory in
>    memory_range__read()
> -- Included examples of memory range output in commit message
>
> v2:
> -- Added check for NULL return of sysfs__mountpoint() when parsing
>    memory ranges in sysfs
> -- increased MAX_MEMORY_RANGES sanity check from 64 to 256 based on
>    ACPI MRRM table implementation in Linux kernel
> -- added comment for MAX_MEMORY_RANGES to clarify that it is a sanity che=
ck
>    for malformed perf.data files
> -- removed a line of code was removed from util/env.h but was added back =
in
>    v1 due to bad rebase
> ---
>
>  .../Documentation/perf.data-file-format.txt   |  13 ++
>  tools/perf/builtin-inject.c                   |   1 +
>  tools/perf/util/env.c                         |   1 +
>  tools/perf/util/env.h                         |  10 +
>  tools/perf/util/header.c                      | 203 ++++++++++++++++++
>  tools/perf/util/header.h                      |   1 +
>  6 files changed, 229 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/p=
erf/Documentation/perf.data-file-format.txt
> index b90cba9168f8..1f8e7d8e9ae2 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -478,6 +478,19 @@ The size of the cacheline in bytes. Format:
>
>         unsigned int cln_size;
>
> +       HEADER_MEMORY_RANGES =3D 35,
> +
> +List of memory ranges. The format of the data is as below.
> +
> +u32 nr_memory_ranges;
> +struct memory_range {
> +       u64 base;
> +       u64 length;
> +       int node;
> +       u8 local_region_id;
> +       u8 remote_region_id;
> +}; [nr_memory_ranges]
> +
>         other bits are reserved and should be ignored for now
>         HEADER_FEAT_BITS        =3D 256,
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 70bbfad5653e..169617a884d3 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2306,6 +2306,7 @@ static bool keep_feat(struct perf_inject *inject, i=
nt feat)
>         case HEADER_PMU_CAPS:
>         case HEADER_CPU_DOMAIN_INFO:
>         case HEADER_CLN_SIZE:
> +       case HEADER_MEMORY_RANGES:
>                 return true;
>         /* Information that can be updated */
>         case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index c0e2b9d5f0b2..50993b0dedc5 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -297,6 +297,7 @@ void perf_env__exit(struct perf_env *env)
>                 zfree(&env->pmu_caps[i].pmu_name);
>         }
>         zfree(&env->pmu_caps);
> +       zfree(&env->memory_ranges);
>         free_cpu_domain_info(env->cpu_domain, env->schedstat_version, env=
->nr_cpus_avail);
>  }
>
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 7acca39b42ff..23d35425efe3 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -68,6 +68,14 @@ struct cpu_domain_map {
>         struct domain_info      **domains;
>  };
>
> +struct memory_range {
> +       u64 base;
> +       u64 length;
> +       int node;
> +       u8 local_region_id;
> +       u8 remote_region_id;
> +};
> +
>  struct perf_env {
>         char                    *hostname;
>         char                    *os_release;
> @@ -100,6 +108,7 @@ struct perf_env {
>         int                     nr_cpu_pmu_caps;
>         int                     nr_hybrid_nodes;
>         int                     nr_pmus_with_caps;
> +       int                     nr_memory_ranges;
>         char                    *cmdline;
>         const char              **cmdline_argv;
>         char                    *sibling_cores;
> @@ -122,6 +131,7 @@ struct perf_env {
>         unsigned long long       memory_bsize;
>         struct hybrid_node      *hybrid_nodes;
>         struct pmu_caps         *pmu_caps;
> +       struct memory_range     *memory_ranges;
>  #ifdef HAVE_LIBBPF_SUPPORT
>         /*
>          * bpf_info_lock protects bpf rbtrees. This is needed because the
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e90e541f546b..1dbc83a2d798 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -92,6 +92,7 @@
>  #define MAX_PMU_CAPS           512
>  #define MAX_PMU_MAPPINGS       4096
>  #define MAX_SCHED_DOMAINS      64
> +#define MAX_MEMORY_RANGES      256
>
>  /*
>   * magic2 =3D "PERFILE2"
> @@ -1891,6 +1892,132 @@ static int write_cpu_domain_info(struct feat_fd *=
ff,
>         return ret;
>  }
>
> +static int memory_range__read(struct memory_range *range, const char *pa=
th)
> +{
> +       char buf[32];
> +       ssize_t n;
> +       int dfd, fd, tmp, ret =3D -1;
> +
> +       dfd =3D open(path, O_RDONLY | O_DIRECTORY);
> +       if (dfd < 0)
> +               return -1;
> +
> +#define _R(name, dst, conv)                    \
> +       fd =3D openat(dfd, name, O_RDONLY);       \
> +       if (fd < 0)                             \
> +               goto out;                       \
> +       n =3D read(fd, buf, sizeof(buf) - 1);     \
> +       close(fd);                              \
> +       if (n <=3D 0)                             \
> +               goto out;                       \
> +       buf[n] =3D '\0';                          \
> +       dst =3D conv(buf, NULL, 0);
> +
> +       _R("base", range->base, strtoull);
> +       _R("length", range->length, strtoull);
> +       _R("node", range->node, strtol);
> +       _R("local_region_id", tmp, strtol);
> +       if (tmp < 0 || tmp > UINT8_MAX)
> +               goto out;
> +       range->local_region_id =3D tmp;
> +       _R("remote_region_id", tmp, strtol);
> +       if (tmp < 0 || tmp > UINT8_MAX)
> +               goto out;
> +       range->remote_region_id =3D tmp;
> +#undef _R
> +
> +       ret =3D 0;
> +out:
> +       close(dfd);
> +       return ret;
> +}
> +
> +static int memory_range__parse(struct memory_range **ranges)
> +{
> +       const char *sysfs =3D sysfs__mountpoint();
> +       int i, err, nr_memory_ranges =3D 0;
> +       char path[PATH_MAX];
> +       struct stat st;
> +
> +       if (!sysfs)
> +               return 0;
> +
> +       scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges", sysfs=
);
> +       if (stat(path, &st))
> +               return 0;
> +
> +       while (1) {
> +               scnprintf(path, PATH_MAX,
> +                         "%s/firmware/acpi/memory_ranges/range%d",
> +                         sysfs, nr_memory_ranges);
> +               if (stat(path, &st))
> +                       break;
> +
> +               nr_memory_ranges++;
> +       }
> +
> +       if (nr_memory_ranges =3D=3D 0)
> +               return 0;
> +
> +       *ranges =3D calloc(nr_memory_ranges, sizeof(struct memory_range))=
;
> +       if (!(*ranges))
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < nr_memory_ranges; i++) {
> +               struct memory_range range;
> +
> +               scnprintf(path, PATH_MAX,
> +                         "%s/firmware/acpi/memory_ranges/range%d", sysfs=
, i);
> +               err =3D memory_range__read(&range, path);
> +               if (err < 0)
> +                       goto out_error;
> +
> +               (*ranges)[i] =3D range;
> +       }
> +
> +       return nr_memory_ranges;
> +
> +out_error:
> +       zfree(ranges);
> +       return -1;
> +}
> +
> +static int write_memory_ranges(struct feat_fd *ff,
> +                        struct evlist *evlist __maybe_unused)
> +{
> +       struct memory_range *ranges =3D NULL;
> +       int nr_memory_ranges =3D 0, ret;
> +
> +       nr_memory_ranges =3D memory_range__parse(&ranges);
> +       if (nr_memory_ranges < 0)
> +               return nr_memory_ranges;
> +
> +       ret =3D do_write(ff, &nr_memory_ranges, sizeof(nr_memory_ranges))=
;
> +       if (ret < 0)
> +               goto out;
> +
> +       for (int i =3D 0; i < nr_memory_ranges; i++) {
> +               ret =3D do_write(ff, &ranges[i].base, sizeof(u64));
> +               if (ret < 0)
> +                       goto out;
> +               ret =3D do_write(ff, &ranges[i].length, sizeof(u64));
> +               if (ret < 0)
> +                       goto out;
> +               ret =3D do_write(ff, &ranges[i].node, sizeof(u32));
> +               if (ret < 0)
> +                       goto out;
> +               ret =3D do_write(ff, &ranges[i].local_region_id, sizeof(u=
8));
> +               if (ret < 0)
> +                       goto out;
> +               ret =3D do_write(ff, &ranges[i].remote_region_id, sizeof(=
u8));
> +               if (ret < 0)
> +                       goto out;
> +       }
> +out:
> +       zfree(&ranges);
> +       return ret;
> +}
> +
>  static void print_hostname(struct feat_fd *ff, FILE *fp)
>  {
>         fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> @@ -2628,6 +2755,23 @@ static void print_cpu_domain_info(struct feat_fd *=
ff, FILE *fp)
>         }
>  }
>
> +static void print_memory_ranges(struct feat_fd *ff, FILE *fp)
> +{
> +       struct memory_range *ranges =3D ff->ph->env.memory_ranges;
> +       int nr_memory_ranges =3D ff->ph->env.nr_memory_ranges;
> +       int i;
> +
> +       fprintf(fp, "# memory ranges (nr %d):\n", nr_memory_ranges);
> +
> +       for (i =3D 0; i < nr_memory_ranges; i++) {
> +               fprintf(fp, "# range%u: [0x%016" PRIx64 "-0x%016" PRIx64,
> +                       i, ranges[i].base, ranges[i].base + ranges[i].len=
gth - 1);
> +               fprintf(fp, "], node =3D %d, local_region_id =3D %d, remo=
te_region_id =3D %d\n",
> +                       ranges[i].node, ranges[i].local_region_id,
> +                       ranges[i].remote_region_id);
> +       }
> +}
> +
>  static int __event_process_build_id(struct perf_record_header_build_id *=
bev,
>                                     char *filename,
>                                     struct perf_session *session)
> @@ -4201,6 +4345,64 @@ static int process_cpu_domain_info(struct feat_fd =
*ff, void *data __maybe_unused
>         return ret;
>  }
>
> +static int process_memory_ranges(struct feat_fd *ff, void *data __maybe_=
unused)
> +{
> +       struct perf_env *env =3D &ff->ph->env;
> +       struct memory_range *ranges, *r;
> +       u32 nr_memory_ranges, i;
> +
> +       if (do_read_u32(ff, &nr_memory_ranges))
> +               return -1;
> +
> +       if (!nr_memory_ranges) {
> +               pr_debug("memory ranges not available\n");
> +               return 0;
> +       }
> +
> +       /* According to version 1.1 of the ACPI MRRM table, the maximum
> +        * number of memory regions can be at most 255. Do a sanity check
> +        * here to guard against a malformed perf.data file.
> +        */
> +       if (nr_memory_ranges >=3D MAX_MEMORY_RANGES) {
> +               pr_err("Invalid memory_ranges: nr_memory_ranges (%u) > %u=
\n",
> +                      nr_memory_ranges, MAX_MEMORY_RANGES);
> +               return -1;
> +       }
> +
> +       if (ff->size < sizeof(u32) + nr_memory_ranges * (2 * sizeof(u64) =
+ sizeof(u32) + 2 * sizeof(u8))) {
> +               pr_err("Invalid HEADER_MEMORY_RANGES: section too small (=
%zu) for %u range entries\n",
> +                      ff->size, nr_memory_ranges);
> +               return -1;
> +       }
> +
> +       ranges =3D calloc(nr_memory_ranges, sizeof(*ranges));
> +       if (!ranges)
> +               return -1;
> +
> +       for (i =3D 0; i < nr_memory_ranges; i++) {
> +               r =3D &ranges[i];
> +
> +               if (do_read_u64(ff, &r->base))
> +                       goto error;
> +               if (do_read_u64(ff, &r->length))
> +                       goto error;
> +               if (do_read_u32(ff, (u32 *) &r->node))
> +                       goto error;
> +               if (__do_read(ff, &r->local_region_id, sizeof(u8)))
> +                       goto error;
> +               if (__do_read(ff, &r->remote_region_id, sizeof(u8)))
> +                       goto error;
> +       }
> +
> +       env->memory_ranges =3D ranges;
> +       env->nr_memory_ranges =3D nr_memory_ranges;
> +
> +       return 0;
> +error:
> +       zfree(&ranges);
> +       return -1;
> +}
> +
>  #define FEAT_OPR(n, func, __full_only) \
>         [HEADER_##n] =3D {                                        \
>                 .name       =3D __stringify(n),                   \
> @@ -4265,6 +4467,7 @@ const struct perf_header_feature_ops feat_ops[HEADE=
R_LAST_FEATURE] =3D {
>         FEAT_OPR(CPU_DOMAIN_INFO,       cpu_domain_info,        true),
>         FEAT_OPR(E_MACHINE,     e_machine,      false),
>         FEAT_OPR(CLN_SIZE,      cln_size,       false),
> +       FEAT_OPR(MEMORY_RANGES, memory_ranges,  false),
>  };
>
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 5e03f884b7cc..765037762758 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -56,6 +56,7 @@ enum {
>         HEADER_CPU_DOMAIN_INFO,
>         HEADER_E_MACHINE,
>         HEADER_CLN_SIZE,
> +       HEADER_MEMORY_RANGES,
>         HEADER_LAST_FEATURE,
>         HEADER_FEAT_BITS        =3D 256,
>  };
> --
> 2.55.0
>
