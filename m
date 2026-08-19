Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2352E11C7
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106861; cv=pass; b=XsRaC7iBa+MuAwbaI2PI2yCE/pndqjzlphHkMxcmGMH9CJ2v1kqNufLNqem/dUA1xe3u0blnDqx1s071hI2jWT3aGlT57LiyX5vR20DSr1UuQdLTtFLQXDbSIQ6X+x38wx1YAiq3EKiECw3sw4WCcMtDKZQKlBwNJ2U5oGxgf6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106861; c=relaxed/simple;
	bh=adpF/Tno591f8mEssOpDyjexp4uHf/dyFagic3DKkd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKoARXGmCTccDBBJUDlkskPiafVRjcXvvVOjRmMQkh3hK3vW2qSKQ9PMJ72PGJX8MZYZMXDWi3PkHXGhpnX8/dfKVNARvgnnh4ADmxX5RoxDl4WPdJsLCd7m1Ci2TKvYWri4+4VJMDn1vUpSVoT0OBpJp8oanYgIBcvADW2KgHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uecvGr6V; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uecvGr6V"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10ed63c0so53201cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 19:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787106857; cv=none;
        d=google.com; s=arc-20260327;
        b=RfH8DmaKXegJzknLXHvEBaBKe5CQDbiE5ccwNZMxYjBX79qFgKorJxEXLWDdZnnJCv
         pv11vRgMu9bLAPZcHlX3v02mwoTmcgWQY7c8HBAFq0s785kMzfALbWxCMV9D1e4rhmeW
         3nKD8DF5yusR0qvqOc97CBCFEbm7pp9RtQlmQw0dT7zyLx7uM45Yf78vmHZT5SwVWbG5
         ZUjN9RHyRjQkxE0XYOtucxSzfSyrZUABuV8JPRnNtZV/4YOjZV+pNnyxygaNpLscSAeW
         oSjmhyjH6KbZHYdhPEoF/woAyktN7KVtW/TwMiJD108WN6Y5lF3+QfN9gNcyHSiCK4Lx
         OZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGZh3nBi5ovn3lsP6U4923r7iN+Li4UJQ1uh8BKIv4U=;
        fh=OgGnt6iXs0wE6gEQ78p+uWxIwa/H9rkNh7p+2eeyorY=;
        b=jol7I6vuJCi5vmjBY2sC1nRqeJjV3RlUGZ8UW47CeYOE7ftOj8z4rhkscudBauqeyO
         QPYYrTcdz07W2KEcFBgxjcBgiOVM16hhoS7bdQ20Sr5MCzFEv+KZI5g0/7QTDwWxeimC
         wb2Hgy/bKiGq8fGcLDhGIVj89zI+YOQAVfudwOcumr4+1ZIWwaWvxVugwDJ8U55c5TZA
         WP083rGx+X+uSrORbaPVU832VCFwaflHPTmZxBmLTb5e5WTdtE46kB4cRQXvEA2YV7AU
         GfYffxdtX9nhlehAeIyFvIXrVkFj7D5nMGYRublzmp6r64/HYrN62EdCtcyNPnaz55p6
         TnNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787106857; x=1787711657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGZh3nBi5ovn3lsP6U4923r7iN+Li4UJQ1uh8BKIv4U=;
        b=uecvGr6VgLFRr2pZ/H6vR/2hnbfe+1b72CnWeAHH0zM+eSjJzx1eN+TDdye0PPWYAO
         SZ7SuIWj6HAnOYt6X2rB7oPfUmRZfKNyaPC2eHyL/LEnqaZg1uXptlQzklE25mEEbc7l
         92fFvrx6eNlPsHZauRvyWYahhC7kSF06yzDmlZWoOtuWUglWIfdthjH3lTMWn7plfhFU
         YiyU6xT/Z/e3QDcxR9r+dgMXnA19yrAHBY1X1karBR0z3qG5arINSwyUgDbT8pkWRVlj
         2E5l3pDDiq+TvPNmlRznWHv2k5xj7BepZ/JWRWU1Z+RAbdM39pUGJrRNEW4PUWxOLk/D
         Uprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106857; x=1787711657;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGZh3nBi5ovn3lsP6U4923r7iN+Li4UJQ1uh8BKIv4U=;
        b=FKHQGXZ5xlF7VQQ2EpcU1Fm0CLMf+7U+0+P7LUATuthCreMCJjFESt2uTcfjQKaTyu
         3zdRhY93/QKBIPcZfZsf34mwNUnl05mlraWKmsTzUiH9g+UM0/2h6xFetxu7BeFVZrfe
         8jUCQ25wEcdopc2PZQ77Ul7fQAbwAtlvQZzamUYszO6iS9T4vp9afTDX4CwSuH3yg3BZ
         2uGZWPb35CYWww3gNKDNhNaS+I6cK5rtRo0IlmgCGStf5QMNabOYjx4lNvy+4Kj1x9Za
         P5Ocvh97EgzQ0vW/z/2QLnLY1J343KM2rO1ZBqBBYDS8AM8nIaBf5lz6S9WyfPkZfsxc
         1SNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrod8NvYiSM8EKVgg1jp0HY9E0OInJMfyaevQJgl/DhlYN+EB/aT0IDdYHEc7H41/cdcvJL4C2H13Upq3yhm4hS@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCkpOzvQq7zUBAFaRzk2BQt/v9ZjvnA0Fi7KZhIIOkpVBp9ip
	w4I3hM2a2vKSKcEdZPCIk5UIQqPg7WZmHGrh8Gn44WYrKn2d8VVsU1KLV6IlTbyanS2g+R9xztq
	czJtMczMdLp9qh/M9J0YeRY2FKJkbBPruo+RwWaS1
X-Gm-Gg: AR+sD123ZH71sdj8Pp7gZlk9C+6L3CC6KUUGA1SX41NUG/7OI5SgalyF+7XPaS1XMoE
	9kdfTXrCk5ZnVd5NfPr19aK3sBQdlqs6RH/gfMp3yiz5PeZ6SuG+fhlFIPfDCqcKubYd3uIImmJ
	xBTEYBQim8Y4h4aT+ffktvCtmzajICjgKK9Z1g/5wtE5yTyks2/SbWhgLpHzAxfVVbKCxZZUdkM
	DIoLqzxg0uJ5fNgXMflbsxu+Q8LVbgd3Q9/CjsRj2b7Ke52RppomOg58qh+1mqpsfhdIec4OpTT
	qOdrvumarqpyHyg3TszZsm3A4+XS/wxtN4zOvvKlXS37Il65yvc=
X-Received: by 2002:a05:622a:1905:b0:517:5ac7:332e with SMTP id
 d75a77b69052e-52dd67b169bmr4175601cf.6.1787106856379; Tue, 18 Aug 2026
 19:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com>
 <20260811173340.96013-4-thomas.falcon@intel.com> <CAP-5=fVpJQBX=g_s+-j2rdRKZ618+52j=EtzOZYLMd8r3KS=ug@mail.gmail.com>
 <99f7a17930a49330972860f131d06e480e682bae.camel@intel.com>
In-Reply-To: <99f7a17930a49330972860f131d06e480e682bae.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Aug 2026 19:34:04 -0700
X-Gm-Features: AcwNN1X1ywdewoMHLD5p19sul5PgIo2IK23bB0gZn3bebpAEx36LKZkM90_WsF8
Message-ID: <CAP-5=fWn-QudUC0c9qgDX5FFXikpRFva8h08ssPp8-n9qdAABg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] perf header: Support memory ranges
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "james.clark@linaro.org" <james.clark@linaro.org>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, 
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:16=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Mon, 2026-08-17 at 14:34 -0700, Ian Rogers wrote:
> > On Tue, Aug 11, 2026 at 10:33=E2=80=AFAM Thomas Falcon
> > <thomas.falcon@intel.com> wrote:
> > >
> > > Memory ranges were created to track different types of memory,
> > > such as persistent, high bandwidth, or CXL-attached, that may
> > > be present on a system for performance monitoring and resource
> > > control purposes.
> > >
> > > Memory range data are parsed from the ACPI MRRM table and exposed
> > > to userspace tools via sysfs [1]. Memory range data is read from:
> > >
> > >         /sys/firmware/acpi/memory_ranges/rangeX
> > >
> > > With the following attributes:
> > >
> > >         u64 base;
> > >         u64 length;
> > >         int node;
> > >         u8  local_region_id;
> > >         u8  remote_region_id;
> > >
> > > Read memory range data from sysfs if present and save it in
> > > the header of the perf data file under a new feature bit,
> > > HEADER_MEMORY_RANGES (35). Memory range data can be viewed with the
> > > --header or --header-only options of perf-report and perf-script.
> > >
> > > Example output:
> > >  # memory ranges (nr 5):
> > >  # range0: [0x0000000000000000-0x00000000bfffffff], node =3D 0,
> > > local_region_id =3D 0, remote_region_id =3D 255
> > >  # range1: [0x0000000100000000-0x000000203fffffff], node =3D 0,
> > > local_region_id =3D 0, remote_region_id =3D 255
> > >  # range2: [0x0000008000000000-0x0000027fffffffff], node =3D -2,
> > > local_region_id =3D 1, remote_region_id =3D 255
> > >  # range3: [0x0000028000000000-0x0000047fffffffff], node =3D -2,
> > > local_region_id =3D 1, remote_region_id =3D 255
> > >  # range4: [0x0000048000000000-0x000004ffffffffff], node =3D -2,
> > > local_region_id =3D 1, remote_region_id =3D 255
> > >
> > > [1]:
> > > https://lore.kernel.org/lkml/20250505173819.419271-1-tony.luck@intel.=
com/
> > >
> > > Assisted-by: Sashiko:gemini-3.1-pro-preview
> > > Assisted-by: GitHub-Copilot:claude-opus-4-8
> > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> >
> > Looks good to me. Did you do pipe mode testing? Is there any
> > additional testing coverage we can add?
> >
> > Thanks,
> > Ian
> >
>
> Hi Ian, thanks for reviewing,
>
> Yes, here is some example output in pipe mode:
>
>  ./perf mem record -o - -a sleep 5 | ./perf script -i - --header
>
> ...
> # memory ranges (nr 5):
> # range0: [0x0000000000000000-0x00000000bfffffff], node =3D 0, local_regi=
on_id =3D 0, remote_region_id =3D 255
> # range1: [0x0000000100000000-0x000000203fffffff], node =3D 0, local_regi=
on_id =3D 0, remote_region_id =3D 255
> # range2: [0x0000008000000000-0x0000027fffffffff], node =3D -2, local_reg=
ion_id =3D 1, remote_region_id =3D 255
> # range3: [0x0000028000000000-0x0000047fffffffff], node =3D -2, local_reg=
ion_id =3D 1, remote_region_id =3D 255
> # range4: [0x0000048000000000-0x000004ffffffffff], node =3D -2, local_reg=
ion_id =3D 1, remote_region_id =3D 255
>             perf   12280 [007] 82283.852958:         63 cpu/mem-loads,ldl=
at=3D30/P: ff40225e7b1acfb8     10e6a100042 |OP LOAD|LVL L0 hit|SNP None|TL=
B L1 or L2 hit|LCK Yes|BLK  N/A|Region N/A               4             302 =
             17 ffffffff9eafe901 perf_event_ctx_lock_nested.isra.0+0x31>
>          swapper       0 [000] 82283.858694:         63 cpu/mem-loads,ldl=
at=3D30/P: ff40225e7d0b31c0    810668100842 |OP LOAD|LVL L3 hit|SNP None|TL=
B L1 or L2 hit|LCK No|BLK  N/A|Region Local-shared-cache              60   =
           62               0 ffffffff9e858b3f update_sg_lb_stats+0x13f>
>          swapper       0 [000] 82283.878498:         63 cpu/mem-loads,ldl=
at=3D30/P: ff40225e7d9b3f98   1810668800842 |OP LOAD|LVL L3 hit|SNP HitM|TL=
B L1 or L2 hit|LCK No|BLK  N/A|Region Other-non-shared-cache             43=
4             435               0 ffffffff9e863e80 _nohz_idle_balance.i>
>        perf-exec   12283 [023] 82283.882372:         63 cpu/mem-loads,ldl=
at=3D30/P: ffe698a847e86408   2011a68101042 |OP LOAD|LVL RAM hit|SNP None|T=
LB L1 or L2 hit|LCK No|BLK  N/A|Region Mem-0                             16=
4             165               0 ffffffff9eb97335 zap_present_ptes.con>
>
> I think we could test that perf c2c/script show the "Region..." field and=
 perf c2c report --stdio and perf report/script --header print the memory r=
ange table, if supported.

Thanks Thomas!
Reviewed-by: Ian Rogers <irogers@google.com>

Ian

> Thanks,
> Tom
>
>
> > > ---
> > > v4:
> > > -- Fixed bounds checking for local and remote region IDs in
> > >    memory_range__read(), which made region "255" invalid
> > >
> > > v3:
> > > -- Added missing ff->size check in process_memory_ranges()
> > > -- used open/openat to read memory range sysfs files in
> > > memory_range__read()
> > > -- Removed path name and file name buffers in memory_range__read(),
> > >    instead pass path name from as a parameter from
> > > memory_range__parse()
> > > -- use calloc instead of zalloc in memory_range__parse() and
> > >    process_memory_ranges()
> > > -- Removed redundant check for existance of memory range directory
> > > in
> > >    memory_range__read()
> > > -- Included examples of memory range output in commit message
> > >
> > > v2:
> > > -- Added check for NULL return of sysfs__mountpoint() when parsing
> > >    memory ranges in sysfs
> > > -- increased MAX_MEMORY_RANGES sanity check from 64 to 256 based on
> > >    ACPI MRRM table implementation in Linux kernel
> > > -- added comment for MAX_MEMORY_RANGES to clarify that it is a
> > > sanity check
> > >    for malformed perf.data files
> > > -- removed a line of code was removed from util/env.h but was added
> > > back in
> > >    v1 due to bad rebase
> > > ---
> > >
> > >  .../Documentation/perf.data-file-format.txt   |  13 ++
> > >  tools/perf/builtin-inject.c                   |   1 +
> > >  tools/perf/util/env.c                         |   1 +
> > >  tools/perf/util/env.h                         |  10 +
> > >  tools/perf/util/header.c                      | 203
> > > ++++++++++++++++++
> > >  tools/perf/util/header.h                      |   1 +
> > >  6 files changed, 229 insertions(+)
> > >
> > > diff --git a/tools/perf/Documentation/perf.data-file-format.txt
> > > b/tools/perf/Documentation/perf.data-file-format.txt
> > > index b90cba9168f8..1f8e7d8e9ae2 100644
> > > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > > @@ -478,6 +478,19 @@ The size of the cacheline in bytes. Format:
> > >
> > >         unsigned int cln_size;
> > >
> > > +       HEADER_MEMORY_RANGES =3D 35,
> > > +
> > > +List of memory ranges. The format of the data is as below.
> > > +
> > > +u32 nr_memory_ranges;
> > > +struct memory_range {
> > > +       u64 base;
> > > +       u64 length;
> > > +       int node;
> > > +       u8 local_region_id;
> > > +       u8 remote_region_id;
> > > +}; [nr_memory_ranges]
> > > +
> > >         other bits are reserved and should be ignored for now
> > >         HEADER_FEAT_BITS        =3D 256,
> > >
> > > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-
> > > inject.c
> > > index 70bbfad5653e..169617a884d3 100644
> > > --- a/tools/perf/builtin-inject.c
> > > +++ b/tools/perf/builtin-inject.c
> > > @@ -2306,6 +2306,7 @@ static bool keep_feat(struct perf_inject
> > > *inject, int feat)
> > >         case HEADER_PMU_CAPS:
> > >         case HEADER_CPU_DOMAIN_INFO:
> > >         case HEADER_CLN_SIZE:
> > > +       case HEADER_MEMORY_RANGES:
> > >                 return true;
> > >         /* Information that can be updated */
> > >         case HEADER_BUILD_ID:
> > > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > > index c0e2b9d5f0b2..50993b0dedc5 100644
> > > --- a/tools/perf/util/env.c
> > > +++ b/tools/perf/util/env.c
> > > @@ -297,6 +297,7 @@ void perf_env__exit(struct perf_env *env)
> > >                 zfree(&env->pmu_caps[i].pmu_name);
> > >         }
> > >         zfree(&env->pmu_caps);
> > > +       zfree(&env->memory_ranges);
> > >         free_cpu_domain_info(env->cpu_domain, env-
> > > >schedstat_version, env->nr_cpus_avail);
> > >  }
> > >
> > > diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> > > index 7acca39b42ff..23d35425efe3 100644
> > > --- a/tools/perf/util/env.h
> > > +++ b/tools/perf/util/env.h
> > > @@ -68,6 +68,14 @@ struct cpu_domain_map {
> > >         struct domain_info      **domains;
> > >  };
> > >
> > > +struct memory_range {
> > > +       u64 base;
> > > +       u64 length;
> > > +       int node;
> > > +       u8 local_region_id;
> > > +       u8 remote_region_id;
> > > +};
> > > +
> > >  struct perf_env {
> > >         char                    *hostname;
> > >         char                    *os_release;
> > > @@ -100,6 +108,7 @@ struct perf_env {
> > >         int                     nr_cpu_pmu_caps;
> > >         int                     nr_hybrid_nodes;
> > >         int                     nr_pmus_with_caps;
> > > +       int                     nr_memory_ranges;
> > >         char                    *cmdline;
> > >         const char              **cmdline_argv;
> > >         char                    *sibling_cores;
> > > @@ -122,6 +131,7 @@ struct perf_env {
> > >         unsigned long long       memory_bsize;
> > >         struct hybrid_node      *hybrid_nodes;
> > >         struct pmu_caps         *pmu_caps;
> > > +       struct memory_range     *memory_ranges;
> > >  #ifdef HAVE_LIBBPF_SUPPORT
> > >         /*
> > >          * bpf_info_lock protects bpf rbtrees. This is needed
> > > because the
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index e90e541f546b..1dbc83a2d798 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -92,6 +92,7 @@
> > >  #define MAX_PMU_CAPS           512
> > >  #define MAX_PMU_MAPPINGS       4096
> > >  #define MAX_SCHED_DOMAINS      64
> > > +#define MAX_MEMORY_RANGES      256
> > >
> > >  /*
> > >   * magic2 =3D "PERFILE2"
> > > @@ -1891,6 +1892,132 @@ static int write_cpu_domain_info(struct
> > > feat_fd *ff,
> > >         return ret;
> > >  }
> > >
> > > +static int memory_range__read(struct memory_range *range, const
> > > char *path)
> > > +{
> > > +       char buf[32];
> > > +       ssize_t n;
> > > +       int dfd, fd, tmp, ret =3D -1;
> > > +
> > > +       dfd =3D open(path, O_RDONLY | O_DIRECTORY);
> > > +       if (dfd < 0)
> > > +               return -1;
> > > +
> > > +#define _R(name, dst, conv)                    \
> > > +       fd =3D openat(dfd, name, O_RDONLY);       \
> > > +       if (fd < 0)                             \
> > > +               goto out;                       \
> > > +       n =3D read(fd, buf, sizeof(buf) - 1);     \
> > > +       close(fd);                              \
> > > +       if (n <=3D 0)                             \
> > > +               goto out;                       \
> > > +       buf[n] =3D '\0';                          \
> > > +       dst =3D conv(buf, NULL, 0);
> > > +
> > > +       _R("base", range->base, strtoull);
> > > +       _R("length", range->length, strtoull);
> > > +       _R("node", range->node, strtol);
> > > +       _R("local_region_id", tmp, strtol);
> > > +       if (tmp < 0 || tmp > UINT8_MAX)
> > > +               goto out;
> > > +       range->local_region_id =3D tmp;
> > > +       _R("remote_region_id", tmp, strtol);
> > > +       if (tmp < 0 || tmp > UINT8_MAX)
> > > +               goto out;
> > > +       range->remote_region_id =3D tmp;
> > > +#undef _R
> > > +
> > > +       ret =3D 0;
> > > +out:
> > > +       close(dfd);
> > > +       return ret;
> > > +}
> > > +
> > > +static int memory_range__parse(struct memory_range **ranges)
> > > +{
> > > +       const char *sysfs =3D sysfs__mountpoint();
> > > +       int i, err, nr_memory_ranges =3D 0;
> > > +       char path[PATH_MAX];
> > > +       struct stat st;
> > > +
> > > +       if (!sysfs)
> > > +               return 0;
> > > +
> > > +       scnprintf(path, PATH_MAX, "%s/firmware/acpi/memory_ranges",
> > > sysfs);
> > > +       if (stat(path, &st))
> > > +               return 0;
> > > +
> > > +       while (1) {
> > > +               scnprintf(path, PATH_MAX,
> > > +                         "%s/firmware/acpi/memory_ranges/range%d",
> > > +                         sysfs, nr_memory_ranges);
> > > +               if (stat(path, &st))
> > > +                       break;
> > > +
> > > +               nr_memory_ranges++;
> > > +       }
> > > +
> > > +       if (nr_memory_ranges =3D=3D 0)
> > > +               return 0;
> > > +
> > > +       *ranges =3D calloc(nr_memory_ranges, sizeof(struct
> > > memory_range));
> > > +       if (!(*ranges))
> > > +               return -ENOMEM;
> > > +
> > > +       for (i =3D 0; i < nr_memory_ranges; i++) {
> > > +               struct memory_range range;
> > > +
> > > +               scnprintf(path, PATH_MAX,
> > > +                         "%s/firmware/acpi/memory_ranges/range%d",
> > > sysfs, i);
> > > +               err =3D memory_range__read(&range, path);
> > > +               if (err < 0)
> > > +                       goto out_error;
> > > +
> > > +               (*ranges)[i] =3D range;
> > > +       }
> > > +
> > > +       return nr_memory_ranges;
> > > +
> > > +out_error:
> > > +       zfree(ranges);
> > > +       return -1;
> > > +}
> > > +
> > > +static int write_memory_ranges(struct feat_fd *ff,
> > > +                        struct evlist *evlist __maybe_unused)
> > > +{
> > > +       struct memory_range *ranges =3D NULL;
> > > +       int nr_memory_ranges =3D 0, ret;
> > > +
> > > +       nr_memory_ranges =3D memory_range__parse(&ranges);
> > > +       if (nr_memory_ranges < 0)
> > > +               return nr_memory_ranges;
> > > +
> > > +       ret =3D do_write(ff, &nr_memory_ranges,
> > > sizeof(nr_memory_ranges));
> > > +       if (ret < 0)
> > > +               goto out;
> > > +
> > > +       for (int i =3D 0; i < nr_memory_ranges; i++) {
> > > +               ret =3D do_write(ff, &ranges[i].base, sizeof(u64));
> > > +               if (ret < 0)
> > > +                       goto out;
> > > +               ret =3D do_write(ff, &ranges[i].length, sizeof(u64));
> > > +               if (ret < 0)
> > > +                       goto out;
> > > +               ret =3D do_write(ff, &ranges[i].node, sizeof(u32));
> > > +               if (ret < 0)
> > > +                       goto out;
> > > +               ret =3D do_write(ff, &ranges[i].local_region_id,
> > > sizeof(u8));
> > > +               if (ret < 0)
> > > +                       goto out;
> > > +               ret =3D do_write(ff, &ranges[i].remote_region_id,
> > > sizeof(u8));
> > > +               if (ret < 0)
> > > +                       goto out;
> > > +       }
> > > +out:
> > > +       zfree(&ranges);
> > > +       return ret;
> > > +}
> > > +
> > >  static void print_hostname(struct feat_fd *ff, FILE *fp)
> > >  {
> > >         fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
> > > @@ -2628,6 +2755,23 @@ static void print_cpu_domain_info(struct
> > > feat_fd *ff, FILE *fp)
> > >         }
> > >  }
> > >
> > > +static void print_memory_ranges(struct feat_fd *ff, FILE *fp)
> > > +{
> > > +       struct memory_range *ranges =3D ff->ph->env.memory_ranges;
> > > +       int nr_memory_ranges =3D ff->ph->env.nr_memory_ranges;
> > > +       int i;
> > > +
> > > +       fprintf(fp, "# memory ranges (nr %d):\n",
> > > nr_memory_ranges);
> > > +
> > > +       for (i =3D 0; i < nr_memory_ranges; i++) {
> > > +               fprintf(fp, "# range%u: [0x%016" PRIx64 "-0x%016"
> > > PRIx64,
> > > +                       i, ranges[i].base, ranges[i].base +
> > > ranges[i].length - 1);
> > > +               fprintf(fp, "], node =3D %d, local_region_id =3D %d,
> > > remote_region_id =3D %d\n",
> > > +                       ranges[i].node, ranges[i].local_region_id,
> > > +                       ranges[i].remote_region_id);
> > > +       }
> > > +}
> > > +
> > >  static int __event_process_build_id(struct
> > > perf_record_header_build_id *bev,
> > >                                     char *filename,
> > >                                     struct perf_session *session)
> > > @@ -4201,6 +4345,64 @@ static int process_cpu_domain_info(struct
> > > feat_fd *ff, void *data __maybe_unused
> > >         return ret;
> > >  }
> > >
> > > +static int process_memory_ranges(struct feat_fd *ff, void *data
> > > __maybe_unused)
> > > +{
> > > +       struct perf_env *env =3D &ff->ph->env;
> > > +       struct memory_range *ranges, *r;
> > > +       u32 nr_memory_ranges, i;
> > > +
> > > +       if (do_read_u32(ff, &nr_memory_ranges))
> > > +               return -1;
> > > +
> > > +       if (!nr_memory_ranges) {
> > > +               pr_debug("memory ranges not available\n");
> > > +               return 0;
> > > +       }
> > > +
> > > +       /* According to version 1.1 of the ACPI MRRM table, the
> > > maximum
> > > +        * number of memory regions can be at most 255. Do a sanity
> > > check
> > > +        * here to guard against a malformed perf.data file.
> > > +        */
> > > +       if (nr_memory_ranges >=3D MAX_MEMORY_RANGES) {
> > > +               pr_err("Invalid memory_ranges: nr_memory_ranges
> > > (%u) > %u\n",
> > > +                      nr_memory_ranges, MAX_MEMORY_RANGES);
> > > +               return -1;
> > > +       }
> > > +
> > > +       if (ff->size < sizeof(u32) + nr_memory_ranges * (2 *
> > > sizeof(u64) + sizeof(u32) + 2 * sizeof(u8))) {
> > > +               pr_err("Invalid HEADER_MEMORY_RANGES: section too
> > > small (%zu) for %u range entries\n",
> > > +                      ff->size, nr_memory_ranges);
> > > +               return -1;
> > > +       }
> > > +
> > > +       ranges =3D calloc(nr_memory_ranges, sizeof(*ranges));
> > > +       if (!ranges)
> > > +               return -1;
> > > +
> > > +       for (i =3D 0; i < nr_memory_ranges; i++) {
> > > +               r =3D &ranges[i];
> > > +
> > > +               if (do_read_u64(ff, &r->base))
> > > +                       goto error;
> > > +               if (do_read_u64(ff, &r->length))
> > > +                       goto error;
> > > +               if (do_read_u32(ff, (u32 *) &r->node))
> > > +                       goto error;
> > > +               if (__do_read(ff, &r->local_region_id, sizeof(u8)))
> > > +                       goto error;
> > > +               if (__do_read(ff, &r->remote_region_id,
> > > sizeof(u8)))
> > > +                       goto error;
> > > +       }
> > > +
> > > +       env->memory_ranges =3D ranges;
> > > +       env->nr_memory_ranges =3D nr_memory_ranges;
> > > +
> > > +       return 0;
> > > +error:
> > > +       zfree(&ranges);
> > > +       return -1;
> > > +}
> > > +
> > >  #define FEAT_OPR(n, func, __full_only) \
> > >         [HEADER_##n] =3D {                                        \
> > >                 .name       =3D __stringify(n),                   \
> > > @@ -4265,6 +4467,7 @@ const struct perf_header_feature_ops
> > > feat_ops[HEADER_LAST_FEATURE] =3D {
> > >         FEAT_OPR(CPU_DOMAIN_INFO,       cpu_domain_info,
> > > true),
> > >         FEAT_OPR(E_MACHINE,     e_machine,      false),
> > >         FEAT_OPR(CLN_SIZE,      cln_size,       false),
> > > +       FEAT_OPR(MEMORY_RANGES, memory_ranges,  false),
> > >  };
> > >
> > >  struct header_print_data {
> > > diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> > > index 5e03f884b7cc..765037762758 100644
> > > --- a/tools/perf/util/header.h
> > > +++ b/tools/perf/util/header.h
> > > @@ -56,6 +56,7 @@ enum {
> > >         HEADER_CPU_DOMAIN_INFO,
> > >         HEADER_E_MACHINE,
> > >         HEADER_CLN_SIZE,
> > > +       HEADER_MEMORY_RANGES,
> > >         HEADER_LAST_FEATURE,
> > >         HEADER_FEAT_BITS        =3D 256,
> > >  };
> > > --
> > > 2.55.0
> > >
>
