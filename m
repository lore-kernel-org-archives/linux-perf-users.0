Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D34D8B4;
	Wed, 19 Jun 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820027; cv=none; b=tKiiSmqnduzHbCIoX65B/qpAw61YiwVXgXepo6+/YJflFcXwbWVgzxpbthL7ejdI7vqNiBfpu6XIVnUP+aybvyEVGR2zc0dcY5FVwpcIuQ+Iyzl+Ec6fIppT3weJhzFqJnIwNLJT5pcg2TOIL3o2Og0OPvDVjLXKaOnyGm8E1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820027; c=relaxed/simple;
	bh=wezZjkXmTaWYP4rFma0MqNU85ZCBg+t5xSHBgf9Hh7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ramc6txaQ9OAr/WhykxjVY65Z0P8Gms5lo2CVMnn4idaThSaFM2MVR+3aVSYj5CNQcc10mPWgH22OxFanMSPHk8z0j1e4POXzM/LRYrlenOZL/zR0wtIlNwcdRncHlB8tbtX3Ku116qa7WvfBXGpicGprxZQxuC73X64G8LyFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGFNrZ0G; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGFNrZ0G"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-63ba688bdc9so4708627b3.1;
        Wed, 19 Jun 2024 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718820025; x=1719424825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzGJzI+a1hmsk6uWkP2pSNgHohQhiQOQuiGnby56M8E=;
        b=jGFNrZ0GLv4s7DV40jDZ07Up3zOc5/iBu37rasHDBwk/QObhOaonb+E8i94z4/QI8g
         /74ddPNhjdBT6PHU2nVtSQ0hNQbAZNT0DDN9K+AQGKDnwdZE94efiMzl/PWcGecGnJyE
         9vHYe0BaQEGYalNZXgXfA5ifPGZBJK0tSuPWAJ6BrOarMAEufRATz7ipYtNl9cakOBub
         Yy5yJ7fywbWy73nJUTBdTAog2FXeoKaeyypwUGG5JvktqWa6XmzC36Ed1VoyVg2U5Ker
         sqnHxjuzEy4AL6hlld61rHp/Jzpciic9YewgKEAisjkhjOGPn0gP8LBhTAyPupDgr9Vl
         dVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820025; x=1719424825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzGJzI+a1hmsk6uWkP2pSNgHohQhiQOQuiGnby56M8E=;
        b=fgYYQSCQXpRtsyQdjQswqOcn9z+vwCrY6fqxT/KowpaEAMu7B3SooWkJAZTXnK24hj
         QMAb1apsVUqTV7oW86Pc0ym2RkonIJI8NUYheLgLHlSzJ24zasOS7Y43MnLWYgk2u9Gy
         46pVgIw33P1+x6xEsqR9Bn+BqBjxBylGvgnmVdC8ZIlQY15Qjz5sECPjoGs4AZU+4mq2
         yDXrw6HJnDS4kry2jp2y6Q6OkCZVBxK8wosyZ6P+u0WwjEUnw4nm96yaySthABTrokmx
         0zG4pAqwXDiq4h1ozu9YzC4mnKZg37GSHjy4R+7PAxzbpOVZk7lRPdlGO7r+7gZIIead
         L9dw==
X-Forwarded-Encrypted: i=1; AJvYcCUn7lhOtqHKVuKQYw+JgBEDIRYseCYb+Y3DKL1wC4V9+Cz2T8E5CxhH2s+X0eWJsVk55MD26hKVpCW6aBgdsgiREILMfxzedtu1qhQjVNkn7fHbiOskC4C+11LQKWLb8OFUoaw8mvIDq4rkiK2TAA==
X-Gm-Message-State: AOJu0YyMRQWH08dPVtJiQVMb+0kcOkAYR5DHblab9xQC6VgkXkqxEBFv
	/B6SFwgMHopQJdZGYNp4ljK8wbocGT7XsLpenEflRGHAELZh9G+4QkloYQArwIG60DmVzeFCsch
	YL57diq48zGjjB2azQYmAR70zzhE=
X-Google-Smtp-Source: AGHT+IGjOyzPa43saZ9QE3Zc9xZIWH73CjgCujjnd8SPWuIYHdDll8DInbhQvUufjZ3T91jYGneqX/RGOdXQ3a9IvrI=
X-Received: by 2002:a81:a605:0:b0:62d:1eb6:87bf with SMTP id
 00721157ae682-63a8d3518b0mr33347287b3.5.1718820024858; Wed, 19 Jun 2024
 11:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-4-howardchu95@gmail.com> <ZnLhQLN7jI38qeJE@x1>
In-Reply-To: <ZnLhQLN7jI38qeJE@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Jun 2024 02:00:16 +0800
Message-ID: <CAH0uvojU0HYnG+69dVkNsNQZwBwp5ScJUg9Rp8s9L5QpRmzP6A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] perf trace: Augment enum tracepoint arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, thanks.

On Wed, Jun 19, 2024 at 9:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 19, 2024 at 04:20:40PM +0800, Howard Chu wrote:
> > Before:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --max-events=3D1
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466c25f18, functi=
on: 0xffffffff89da5be0, expires: 377432432256753, softexpires: 377432432256=
753, mode: 10)
> >
> > After:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --max-events=3D1
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466d25f18, functi=
on: 0xffffffff89da5be0, expires: 488283834504945, softexpires: 488283834504=
945, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >
> > HRTIMER_MODE_ABS_PINNED_HARD is:
> >
> > perf $ pahole hrtimer_mode
> > enum hrtimer_mode {
> >         HRTIMER_MODE_ABS             =3D 0,
> >         HRTIMER_MODE_REL             =3D 1,
> >         HRTIMER_MODE_PINNED          =3D 2,
> >         HRTIMER_MODE_SOFT            =3D 4,
> >         HRTIMER_MODE_HARD            =3D 8,
> >         HRTIMER_MODE_ABS_PINNED      =3D 2,
> >         HRTIMER_MODE_REL_PINNED      =3D 3,
> >         HRTIMER_MODE_ABS_SOFT        =3D 4,
> >         HRTIMER_MODE_REL_SOFT        =3D 5,
> >         HRTIMER_MODE_ABS_PINNED_SOFT =3D 6,
> >         HRTIMER_MODE_REL_PINNED_SOFT =3D 7,
> >         HRTIMER_MODE_ABS_HARD        =3D 8,
> >         HRTIMER_MODE_REL_HARD        =3D 9,
> >         HRTIMER_MODE_ABS_PINNED_HARD =3D 10,
> >         HRTIMER_MODE_REL_PINNED_HARD =3D 11,
> > };
> >
> > Can also be tested by
> >
> > ./perf trace -e pagemap:mm_lru_insertion,timer:hrtimer_start,timer:hrti=
mer_init,skb:kfree_skb --max-events=3D10
> >
> > (Chose these 4 events because they happen quite frequently.)
> >
> > However some enum arguments may not be contained in vmlinux BTF. To see
> > what enum arguments are supported, use:
> >
> > vmlinux_dir $ bpftool btf dump file /sys/kernel/btf/vmlinux > vmlinux
> >
> > vmlinux_dir $  while read l; do grep "ENUM '$l'" vmlinux; done < <(grep=
 field:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort=
 | uniq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g"
> > dev_pm_qos_req_type
> > error_detector
> > hrtimer_mode
> > i2c_slave_event
> > ieee80211_bss_type
> > lru_list
> > migrate_mode
> > nl80211_auth_type
> > nl80211_band
> > nl80211_iftype
> > numa_vmaskip_reason
> > pm_qos_req_action
> > pwm_polarity
> > skb_drop_reason
> > thermal_trip_type
> > xen_lazy_mode
> > xen_mc_extend_args
> > xen_mc_flush_reason
> > zone_type
> >
> > And what tracepoints have these enum types as their arguments:
> >
> > vmlinux_dir $ while read l; do grep "ENUM '$l'" vmlinux; done < <(grep =
field:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort =
| uniq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g" > good_enums
> >
> > vmlinux_dir $ cat good_enums
> > dev_pm_qos_req_type
> > error_detector
> > hrtimer_mode
> > i2c_slave_event
> > ieee80211_bss_type
> > lru_list
> > migrate_mode
> > nl80211_auth_type
> > nl80211_band
> > nl80211_iftype
> > numa_vmaskip_reason
> > pm_qos_req_action
> > pwm_polarity
> > skb_drop_reason
> > thermal_trip_type
> > xen_lazy_mode
> > xen_mc_extend_args
> > xen_mc_flush_reason
> > zone_type
> >
> > vmlinux_dir $ grep -f good_enums -l /sys/kernel/tracing/events/*/*/form=
at
> > /sys/kernel/tracing/events/cfg80211/cfg80211_chandef_dfs_required/forma=
t
> > /sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_notify/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_started_notify/f=
ormat
> > /sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_ibss_joined/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_inform_bss_frame/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_radar_event/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel_expired/f=
ormat
> > /sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_reg_can_beacon/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_return_bss/format
> > /sys/kernel/tracing/events/cfg80211/cfg80211_tx_mgmt_expired/format
> > /sys/kernel/tracing/events/cfg80211/rdev_add_virtual_intf/format
> > /sys/kernel/tracing/events/cfg80211/rdev_auth/format
> > /sys/kernel/tracing/events/cfg80211/rdev_change_virtual_intf/format
> > /sys/kernel/tracing/events/cfg80211/rdev_channel_switch/format
> > /sys/kernel/tracing/events/cfg80211/rdev_connect/format
> > /sys/kernel/tracing/events/cfg80211/rdev_inform_bss/format
> > /sys/kernel/tracing/events/cfg80211/rdev_libertas_set_mesh_channel/form=
at
> > /sys/kernel/tracing/events/cfg80211/rdev_mgmt_tx/format
> > /sys/kernel/tracing/events/cfg80211/rdev_remain_on_channel/format
> > /sys/kernel/tracing/events/cfg80211/rdev_return_chandef/format
> > /sys/kernel/tracing/events/cfg80211/rdev_return_int_survey_info/format
> > /sys/kernel/tracing/events/cfg80211/rdev_set_ap_chanwidth/format
> > /sys/kernel/tracing/events/cfg80211/rdev_set_monitor_channel/format
> > /sys/kernel/tracing/events/cfg80211/rdev_set_radar_background/format
> > /sys/kernel/tracing/events/cfg80211/rdev_start_ap/format
> > /sys/kernel/tracing/events/cfg80211/rdev_start_radar_detection/format
> > /sys/kernel/tracing/events/cfg80211/rdev_tdls_channel_switch/format
> > /sys/kernel/tracing/events/compaction/mm_compaction_defer_compaction/fo=
rmat
> > /sys/kernel/tracing/events/compaction/mm_compaction_deferred/format
> > /sys/kernel/tracing/events/compaction/mm_compaction_defer_reset/format
> > /sys/kernel/tracing/events/compaction/mm_compaction_finished/format
> > /sys/kernel/tracing/events/compaction/mm_compaction_kcompactd_wake/form=
at
> > /sys/kernel/tracing/events/compaction/mm_compaction_suitable/format
> > /sys/kernel/tracing/events/compaction/mm_compaction_wakeup_kcompactd/fo=
rmat
> > /sys/kernel/tracing/events/error_report/error_report_end/format
> > /sys/kernel/tracing/events/i2c_slave/i2c_slave/format
> > /sys/kernel/tracing/events/migrate/mm_migrate_pages/format
> > /sys/kernel/tracing/events/migrate/mm_migrate_pages_start/format
> > /sys/kernel/tracing/events/pagemap/mm_lru_insertion/format
> > /sys/kernel/tracing/events/power/dev_pm_qos_add_request/format
> > /sys/kernel/tracing/events/power/dev_pm_qos_remove_request/format
> > /sys/kernel/tracing/events/power/dev_pm_qos_update_request/format
> > /sys/kernel/tracing/events/power/pm_qos_update_flags/format
> > /sys/kernel/tracing/events/power/pm_qos_update_target/format
> > /sys/kernel/tracing/events/pwm/pwm_apply/format
> > /sys/kernel/tracing/events/pwm/pwm_get/format
> > /sys/kernel/tracing/events/sched/sched_skip_vma_numa/format
> > /sys/kernel/tracing/events/skb/kfree_skb/format
> > /sys/kernel/tracing/events/thermal/thermal_zone_trip/format
> > /sys/kernel/tracing/events/timer/hrtimer_init/format
> > /sys/kernel/tracing/events/timer/hrtimer_start/format
> > /sys/kernel/tracing/events/xen/xen_mc_batch/format
> > /sys/kernel/tracing/events/xen/xen_mc_extend_args/format
> > /sys/kernel/tracing/events/xen/xen_mc_flush_reason/format
> > /sys/kernel/tracing/events/xen/xen_mc_issue/format
> >
> > Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/builtin-trace.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index d93f34e9af74..bd16679fb4c0 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1962,12 +1962,12 @@ static int trace__read_syscall_info(struct trac=
e *trace, int id)
> >       return err;
> >  }
> >
> > -static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > +static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use=
_btf)
> >  {
> >       struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
> >
> >       if (fmt !=3D NULL) {
> > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields, NULL);
> > +             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields, use_btf);
> >               return 0;
> >       }
> >
> > @@ -2171,7 +2171,8 @@ static size_t syscall__scnprintf_args(struct sysc=
all *sc, char *bf, size_t size,
> >                        * property isn't set.
> >                        */
> >                       if (val =3D=3D 0 && !trace->show_zeros &&
> > -                         !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_ze=
ro))
> > +                         !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_ze=
ro) &&
> > +                         !(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum=
))
> >                               continue;
> >
> >                       printed +=3D scnprintf(bf + printed, size - print=
ed, "%s", printed ? ", " : "");
> > @@ -2877,7 +2878,7 @@ static size_t trace__fprintf_tp_fields(struct tra=
ce *trace, struct evsel *evsel,
> >               val =3D syscall_arg_fmt__mask_val(arg, &syscall_arg, val)=
;
> >
> >               /* Suppress this argument if its value is zero and show_z=
ero property isn't set. */
> > -             if (val =3D=3D 0 && !trace->show_zeros && !arg->show_zero=
)
> > +             if (val =3D=3D 0 && !trace->show_zeros && !arg->show_zero=
 && !arg->is_enum)
> >                       continue;
> >
> >               printed +=3D scnprintf(bf + printed, size - printed, "%s"=
, printed ? ", " : "");
> > @@ -2885,6 +2886,15 @@ static size_t trace__fprintf_tp_fields(struct tr=
ace *trace, struct evsel *evsel,
> >               if (trace->show_arg_names)
> >                       printed +=3D scnprintf(bf + printed, size - print=
ed, "%s: ", field->name);
> >
> > +             if (arg->is_enum && trace->btf) {
> > +                     size_t p =3D btf_enum_scnprintf(bf + printed, siz=
e - printed, val, trace->btf,
> > +                                                   field->type, arg);
> > +                     if (p) {
> > +                             printed +=3D p;
> > +                             continue;
> > +                     }
> > +             }
> > +
> >               printed +=3D syscall_arg_fmt__scnprintf_val(arg, bf + pri=
nted, size - printed, &syscall_arg, val);
> >       }
> >
> > @@ -4537,7 +4547,7 @@ static void evsel__set_syscall_arg_fmt(struct evs=
el *evsel, const char *name)
> >       }
> >  }
> >
> > -static int evlist__set_syscall_tp_fields(struct evlist *evlist)
> > +static int evlist__set_syscall_tp_fields(struct evlist *evlist, bool *=
use_btf)
> >  {
> >       struct evsel *evsel;
> >
> > @@ -4546,7 +4556,7 @@ static int evlist__set_syscall_tp_fields(struct e=
vlist *evlist)
> >                       continue;
> >
> >               if (strcmp(evsel->tp_format->system, "syscalls")) {
> > -                     evsel__init_tp_arg_scnprintf(evsel);
> > +                     evsel__init_tp_arg_scnprintf(evsel, use_btf);
> >                       continue;
> >               }
> >
> > @@ -5024,11 +5034,16 @@ int cmd_trace(int argc, const char **argv)
> >       }
> >
> >       if (trace.evlist->core.nr_entries > 0) {
> > +             bool use_btf =3D false;
> > +
> >               evlist__set_default_evsel_handler(trace.evlist, trace__ev=
ent_handler);
> > -             if (evlist__set_syscall_tp_fields(trace.evlist)) {
> > +             if (evlist__set_syscall_tp_fields(trace.evlist, &use_btf)=
) {
> >                       perror("failed to set syscalls:* tracepoint field=
s");
> >                       goto out;
> >               }
> > +
> > +             if (use_btf && trace.btf =3D=3D NULL)
> > +                     trace__load_vmlinux_btf(&trace);
>
> Can we defer loading btf to when one of those tracepoints is hit?
>
> >       }
> >
> >       if (trace.sort_events) {
> > --
> > 2.45.2
