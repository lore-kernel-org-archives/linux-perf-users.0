Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583E214A66
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479258; cv=none; b=pSY2rPEbIPOY5jagQkPjVRfSf/ifnYKb2/SOUZJ138j0664KWx0Bs1MOYNp4iAlqsBFwikpq6/EoW13rSbQbdYOdf6KD0WNYSMN+EBnL773rFlLGccwWAVOS9M1Gyo7JhnMq/B20tbMtH22dFV0wyCvAyx3Q0v0eAGfjPfb1qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479258; c=relaxed/simple;
	bh=PFaPJW6WbKpaphdDjGJTGVYm4CBQjgl3CqLs6bFrP7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mkKIrT8Tylw0conJMJVH0Af4cKQoPRkSbDoU20MjsVX/jqnBX8iyEkXglKefmcbM2qY9/Cg+J3R7Y91Jwh+xB2ilIObWxWoV033JZaM2nbiA6IvAyoI6+VPPzM782GzmKHKFTP/XQImlMg/6lM3Ty5DL0iuzPIgYQCqD4SO6DjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUeeFOjd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUeeFOjd"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so174345ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745479256; x=1746084056; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdXVRWu1cWa5yFS/BktSM31ONwJYqjrvHb1KL6pTjnw=;
        b=tUeeFOjdl9/ApKD4yEV7oZXKTzNUlAGtv/8Xm9AW86rBeNrdQaUlGLAM7WPQz17VDg
         5HVHtPaOXskdSvPD0/wrgMetaDfz+D9CBTwxU6du4uJk/h2mCp38geZrQVIVA4WK+TSP
         bHWe2w3qri1J0vPnjEdmmurC2KZJk64SEtgF/xODyzdiaF6bYeW2Sdkyz8GWDL/ZcZMj
         IakLXGjCa9jpphgVJSZG3khkBKBtVVqNAJ5kXyoLy5YcLm9Cqg1WgpdHw45+ERcEM8+i
         yjc2wbzyp6uJfBpXk8n+jGbzXQdC0XbvcuaI48zO/YSvFgvi4lekqbzhhR7kf+z2ah5q
         jcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479256; x=1746084056;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdXVRWu1cWa5yFS/BktSM31ONwJYqjrvHb1KL6pTjnw=;
        b=YruB8qltPJIYCmpIp+33984J1iLRBr2BWWPMKria5Ru9N9DnZofsOXFI06bThiVbuo
         J7uF58bPREpSRbkVarYlgRdPMBZKKXrrF4LygXZJiZq1+gjMiEypbmKE5SNev1c2fVK2
         6f+xNYzuAiqeYj9unWZRleF1n8I2ojcR8tpV+OYL4Xi7LikdTOj/HK28BV4ZbFRin8PZ
         gHeuOXYKFaUHB/4bS23Mn6BWgfSCpaMNiHv9NTR2hfRnR5OVmQpWw7hZ/9v7U9RhLJZa
         wjbpt6f5jdo22YKxoIcHbTtEQ7tOnFCd9FPGKYALMvAgMaMXntXNnJsv/rdIsKAm2oTx
         8W4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4HMz0O3Qz75wzwGVOJGHqAApHBS+JHWs+ZhskFldcecoueM1L4bBS+wq6SU4oNJPqWl6kwv/RMMdKaqrcKnrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/We9iiVwvkzlS3YVsRfAEY+6LWKtH4680URHDb555Hg6G6dp1
	7yYIITc/qAxfm8JsFCO1OJKx5hlSgpFeNdQArthCxJZNIgzs8pvvKgcf/aNiLPL/zTW8yrX6Fcp
	cGRQZjqymRHtHxkk5sE2RcGErinhuY53SJ30B
X-Gm-Gg: ASbGncsmVB4f/GLFqaVMEmjRI/IZOfCg8kPQr8eMelFE/Az8Go6S7y8hCEem4903MNT
	0S6KOtekmnMvBR8cJPWYX0TOpuLjXdMdTX7iQ4KVnTXi0zfUBK2wNkVCcKt1Mhlh6k0avRprQnK
	QEP2YABnmRhZjYGnhTqNRZdk8=
X-Google-Smtp-Source: AGHT+IEpBptf66jSOD/k1VjkSt/DcKFRh42zBUPLdQXqMg7qrD6+Zv8DAqrIIwqhqqSAJAw8zZkOZeHHV+YhgfOdErU=
X-Received: by 2002:a05:6e02:3c86:b0:3d4:2362:9fbc with SMTP id
 e9e14a558f8ab-3d9303bbbbdmr1910165ab.27.1745479255440; Thu, 24 Apr 2025
 00:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20250424061943.1321025-6-irogers@google.com>
In-Reply-To: <20250424061943.1321025-6-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Apr 2025 00:20:44 -0700
X-Gm-Features: ATxdqUHbvDTReF8oer7yYmxaK6piTc5lulDTad5CJ_WnpQIjCkfaH5FP3w14a-c
Message-ID: <CAP-5=fXHay1Qn7c3JUe4nH-cTw8zPhPv6-XWMZdPKpwwT=9n2w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf record: Make --buildid-mmap the default
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 11:19=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Support for build IDs in mmap2 perf events has been present since
> Linux v5.12:
> https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
> Build ID mmap events avoid the need to inject build IDs for DSO
> touched by samples when perf record completes and can avoid some cases
> of symbol mis-resolution.
>
> Unlike the --buildid-mmap option, this doesn't disable the build ID
> cache but it does disable the processing of samples looking for DSOs
> to inject build IDs for. To disable the build ID cache the -N
> (--no-buildid-cache) option is necessary.
>
> Making this option the default was raised on the list in:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfXP7jN_QrGUcd55_QH5J-Y-F=
CaJ6=3DNaHVtyx0oyNh8_-Q@mail.gmail.com/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c        | 35 +++++++++++++++++++-----------
>  tools/perf/util/symbol_conf.h      |  2 +-
>  tools/perf/util/synthetic-events.c | 16 +++++++-------
>  3 files changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba20bf7c011d..0fcb0f469488 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -169,6 +169,7 @@ struct record {
>         bool                    no_buildid_cache_set;
>         bool                    buildid_all;
>         bool                    buildid_mmap;
> +       bool                    buildid_mmap_set;
>         bool                    timestamp_filename;
>         bool                    timestamp_boundary;
>         bool                    off_cpu;
> @@ -1795,7 +1796,8 @@ record__finish_output(struct record *rec)
>                         data->dir.files[i].size =3D lseek(data->dir.files=
[i].fd, 0, SEEK_CUR);
>         }
>
> -       if (!rec->no_buildid) {
> +       /* Buildid scanning disabled or build ID in kernel and synthesize=
d map events. */
> +       if (!rec->no_buildid && !rec->buildid_mmap) {

So I think this is wrong. It matches current behaviors, but it is
wrong. If we don't process the kernel's mmap events the DSOs won't be
loaded and the build ID cache won't contain the DSOs. There is also
the bug that the sample processing to find maps to find DSOs, doesn't
handle call chains. Given the broken nature of the build ID cache I'm
not sure it makes any sense for perf record to be by default
populating it. I think it probably makes sense to consider the default
population a legacy feature and make -N the default along with
--buildid-mmap.

Thanks,
Ian

>                 process_buildids(rec);
>
>                 if (rec->buildid_all)
> @@ -2966,6 +2968,8 @@ static int perf_record_config(const char *var, cons=
t char *value, void *cb)
>                         rec->no_buildid =3D true;
>                 else if (!strcmp(value, "mmap"))
>                         rec->buildid_mmap =3D true;
> +               else if (!strcmp(value, "no-mmap"))
> +                       rec->buildid_mmap =3D false;
>                 else
>                         return -1;
>                 return 0;
> @@ -3349,6 +3353,7 @@ static struct record record =3D {
>                 .ctl_fd_ack          =3D -1,
>                 .synth               =3D PERF_SYNTH_ALL,
>         },
> +       .buildid_mmap =3D true,
>  };
>
>  const char record_callchain_help[] =3D CALLCHAIN_RECORD_HELP
> @@ -3514,8 +3519,8 @@ static struct option __record_options[] =3D {
>                    "file", "vmlinux pathname"),
>         OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
>                     "Record build-id of all DSOs regardless of hits"),
> -       OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> -                   "Record build-id in map events"),
> +       OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.=
buildid_mmap_set,
> +                       "Legacy record build-id in map events option whic=
h is now the default. Behaves indentically to --no-buildid. Disable with --=
no-buildid-mmap"),
>         OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
>                     "append timestamp to output filename"),
>         OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> @@ -4042,19 +4047,23 @@ int cmd_record(int argc, const char **argv)
>                 record.opts.record_switch_events =3D true;
>         }
>
> +       if (!rec->buildid_mmap) {
> +               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> +               symbol_conf.no_buildid_mmap2 =3D true;
> +       } else if (rec->buildid_mmap_set) {
> +               /*
> +                * Explicitly passing --buildid-mmap disables buildid pro=
cessing
> +                * and cache generation.
> +                */
> +               rec->no_buildid =3D true;
> +       }
> +       if (rec->buildid_mmap && !perf_can_record_build_id()) {
> +               pr_warning("Missing support for build id in kernel mmap e=
vents. Disable this warning with --no-buildid-mmap\n");
> +               rec->buildid_mmap =3D false;
> +       }
>         if (rec->buildid_mmap) {
> -               if (!perf_can_record_build_id()) {
> -                       pr_err("Failed: no support to record build id in =
mmap events, update your kernel.\n");
> -                       err =3D -EINVAL;
> -                       goto out_opts;
> -               }
> -               pr_debug("Enabling build id in mmap2 events.\n");
> -               /* Enable mmap build id synthesizing. */
> -               symbol_conf.buildid_mmap2 =3D true;
>                 /* Enable perf_event_attr::build_id bit. */
>                 rec->opts.build_id =3D true;
> -               /* Disable build id cache. */
> -               rec->no_buildid =3D true;
>         }
>
>         if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.=
h
> index cd9aa82c7d5a..7a80d2c14d9b 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -43,7 +43,7 @@ struct symbol_conf {
>                         report_individual_block,
>                         inline_name,
>                         disable_add2line_warn,
> -                       buildid_mmap2,
> +                       no_buildid_mmap2,
>                         guest_code,
>                         lazy_load_kernel_maps,
>                         keep_exited_threads,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 8fb2ea544d3a..f48109c14235 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -532,7 +532,7 @@ int perf_event__synthesize_mmap_events(const struct p=
erf_tool *tool,
>                 event->mmap2.pid =3D tgid;
>                 event->mmap2.tid =3D pid;
>
> -               if (symbol_conf.buildid_mmap2)
> +               if (!symbol_conf.no_buildid_mmap2)
>                         perf_record_mmap2__read_build_id(&event->mmap2, m=
achine, false);
>
>                 if (perf_tool__process_synth_event(tool, event, machine, =
process) !=3D 0) {
> @@ -690,7 +690,7 @@ static int perf_event__synthesize_modules_maps_cb(str=
uct map *map, void *data)
>                 return 0;
>
>         dso =3D map__dso(map);
> -       if (symbol_conf.buildid_mmap2) {
> +       if (!symbol_conf.no_buildid_mmap2) {
>                 size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u=
64));
>                 event->mmap2.header.type =3D PERF_RECORD_MMAP2;
>                 event->mmap2.header.size =3D (sizeof(event->mmap2) -
> @@ -734,9 +734,9 @@ int perf_event__synthesize_modules(const struct perf_=
tool *tool, perf_event__han
>                 .process =3D process,
>                 .machine =3D machine,
>         };
> -       size_t size =3D symbol_conf.buildid_mmap2
> -               ? sizeof(args.event->mmap2)
> -               : sizeof(args.event->mmap);
> +       size_t size =3D symbol_conf.no_buildid_mmap2
> +               ? sizeof(args.event->mmap)
> +               : sizeof(args.event->mmap2);
>
>         args.event =3D zalloc(size + machine->id_hdr_size);
>         if (args.event =3D=3D NULL) {
> @@ -1124,8 +1124,8 @@ static int __perf_event__synthesize_kernel_mmap(con=
st struct perf_tool *tool,
>                                                 struct machine *machine)
>  {
>         union perf_event *event;
> -       size_t size =3D symbol_conf.buildid_mmap2 ?
> -                       sizeof(event->mmap2) : sizeof(event->mmap);
> +       size_t size =3D symbol_conf.no_buildid_mmap2 ?
> +                       sizeof(event->mmap) : sizeof(event->mmap2);
>         struct map *map =3D machine__kernel_map(machine);
>         struct kmap *kmap;
>         int err;
> @@ -1159,7 +1159,7 @@ static int __perf_event__synthesize_kernel_mmap(con=
st struct perf_tool *tool,
>                 event->header.misc =3D PERF_RECORD_MISC_GUEST_KERNEL;
>         }
>
> -       if (symbol_conf.buildid_mmap2) {
> +       if (!symbol_conf.no_buildid_mmap2) {
>                 size =3D snprintf(event->mmap2.filename, sizeof(event->mm=
ap2.filename),
>                                 "%s%s", machine->mmap_name, kmap->ref_rel=
oc_sym->name) + 1;
>                 size =3D PERF_ALIGN(size, sizeof(u64));
> --
> 2.49.0.805.g082f7c87e0-goog
>
