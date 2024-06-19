Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919C14388B;
	Wed, 19 Jun 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804805; cv=none; b=XbXviD6VbHeBgHcXSOTsXJJ0h7wgff7BYFiU44sqS5fINq3xjaHOMfs1prdnyoklVOhdDDWB6+NVQKGz8IsmG43zQc/KaxQlsfTtNWaM+uK5mVTcyv2J5QaH+D5Y9An9lqzM9gqoO801kGJtoilMetzdthYgUVHT9jIs04zWl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804805; c=relaxed/simple;
	bh=6psmr/Oi9oRoteHdSp3C5bu04ThHQpHwlrJB6BdmvLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5IDCryFLbsh+btokxc5Ktmhrp4i3ti7lLxn8KQ2H1ZhEr0BBZKe+L8K+uzt7OSYryjRWdT1usfddLIIvW299+bMg/mfz8oLSrx9i8baVNmJEK2gvqFwv4KJW6NfmB3V1+tdpRZ85pMg5PYLhUMzaHJzXlzU2cduytIs5XwO02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIP4aAPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIP4aAPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21AAC2BBFC;
	Wed, 19 Jun 2024 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718804805;
	bh=6psmr/Oi9oRoteHdSp3C5bu04ThHQpHwlrJB6BdmvLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIP4aAPr9ShyjbgKzpymG7KjqmXcHdFEkXvInPoDqxNutomdgau53ZVlltSVJsahK
	 MISVwaJ9PcMTRkqrMk9stEbMS0Qvjn38V9nGkiMNJzdvRyUeishwDzabJ5n4Q/Rrol
	 u4hEmvENmfwh4VlS2/kfG955utB2vhaiH/NQtvZRwK0MXMorLK2Fbgim44UyYOdJ5E
	 Wza5Xi5FJfQjHjuMILgukqKCz85WpAH4jYutX0mKqmX3N30YeH6dxtcCUHZJs592Lb
	 tbKBohf/yC54f4gLwCPeXcRCufH3xg3LogmBcMFTBbZGLTfyInCcdbhJT0jhwjwvdp
	 4R+AFvQvtt2EQ==
Date: Wed, 19 Jun 2024 10:46:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/5] perf trace: Augment enum tracepoint arguments
 with BTF
Message-ID: <ZnLhQLN7jI38qeJE@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-4-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619082042.4173621-4-howardchu95@gmail.com>

On Wed, Jun 19, 2024 at 04:20:40PM +0800, Howard Chu wrote:
> Before:
> 
> perf $ ./perf trace -e timer:hrtimer_start --max-events=1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466c25f18, function: 0xffffffff89da5be0, expires: 377432432256753, softexpires: 377432432256753, mode: 10)
> 
> After:
> 
> perf $ ./perf trace -e timer:hrtimer_start --max-events=1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466d25f18, function: 0xffffffff89da5be0, expires: 488283834504945, softexpires: 488283834504945, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> 
> HRTIMER_MODE_ABS_PINNED_HARD is:
> 
> perf $ pahole hrtimer_mode
> enum hrtimer_mode {
>         HRTIMER_MODE_ABS             = 0,
>         HRTIMER_MODE_REL             = 1,
>         HRTIMER_MODE_PINNED          = 2,
>         HRTIMER_MODE_SOFT            = 4,
>         HRTIMER_MODE_HARD            = 8,
>         HRTIMER_MODE_ABS_PINNED      = 2,
>         HRTIMER_MODE_REL_PINNED      = 3,
>         HRTIMER_MODE_ABS_SOFT        = 4,
>         HRTIMER_MODE_REL_SOFT        = 5,
>         HRTIMER_MODE_ABS_PINNED_SOFT = 6,
>         HRTIMER_MODE_REL_PINNED_SOFT = 7,
>         HRTIMER_MODE_ABS_HARD        = 8,
>         HRTIMER_MODE_REL_HARD        = 9,
>         HRTIMER_MODE_ABS_PINNED_HARD = 10,
>         HRTIMER_MODE_REL_PINNED_HARD = 11,
> };
> 
> Can also be tested by
> 
> ./perf trace -e pagemap:mm_lru_insertion,timer:hrtimer_start,timer:hrtimer_init,skb:kfree_skb --max-events=10
> 
> (Chose these 4 events because they happen quite frequently.)
> 
> However some enum arguments may not be contained in vmlinux BTF. To see
> what enum arguments are supported, use:
> 
> vmlinux_dir $ bpftool btf dump file /sys/kernel/btf/vmlinux > vmlinux
> 
> vmlinux_dir $  while read l; do grep "ENUM '$l'" vmlinux; done < <(grep field:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort | uniq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g"
> dev_pm_qos_req_type
> error_detector
> hrtimer_mode
> i2c_slave_event
> ieee80211_bss_type
> lru_list
> migrate_mode
> nl80211_auth_type
> nl80211_band
> nl80211_iftype
> numa_vmaskip_reason
> pm_qos_req_action
> pwm_polarity
> skb_drop_reason
> thermal_trip_type
> xen_lazy_mode
> xen_mc_extend_args
> xen_mc_flush_reason
> zone_type
> 
> And what tracepoints have these enum types as their arguments:
> 
> vmlinux_dir $ while read l; do grep "ENUM '$l'" vmlinux; done < <(grep field:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort | uniq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g" > good_enums
> 
> vmlinux_dir $ cat good_enums
> dev_pm_qos_req_type
> error_detector
> hrtimer_mode
> i2c_slave_event
> ieee80211_bss_type
> lru_list
> migrate_mode
> nl80211_auth_type
> nl80211_band
> nl80211_iftype
> numa_vmaskip_reason
> pm_qos_req_action
> pwm_polarity
> skb_drop_reason
> thermal_trip_type
> xen_lazy_mode
> xen_mc_extend_args
> xen_mc_flush_reason
> zone_type
> 
> vmlinux_dir $ grep -f good_enums -l /sys/kernel/tracing/events/*/*/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_chandef_dfs_required/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_notify/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_started_notify/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_ibss_joined/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_inform_bss_frame/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_radar_event/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel_expired/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_reg_can_beacon/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_return_bss/format
> /sys/kernel/tracing/events/cfg80211/cfg80211_tx_mgmt_expired/format
> /sys/kernel/tracing/events/cfg80211/rdev_add_virtual_intf/format
> /sys/kernel/tracing/events/cfg80211/rdev_auth/format
> /sys/kernel/tracing/events/cfg80211/rdev_change_virtual_intf/format
> /sys/kernel/tracing/events/cfg80211/rdev_channel_switch/format
> /sys/kernel/tracing/events/cfg80211/rdev_connect/format
> /sys/kernel/tracing/events/cfg80211/rdev_inform_bss/format
> /sys/kernel/tracing/events/cfg80211/rdev_libertas_set_mesh_channel/format
> /sys/kernel/tracing/events/cfg80211/rdev_mgmt_tx/format
> /sys/kernel/tracing/events/cfg80211/rdev_remain_on_channel/format
> /sys/kernel/tracing/events/cfg80211/rdev_return_chandef/format
> /sys/kernel/tracing/events/cfg80211/rdev_return_int_survey_info/format
> /sys/kernel/tracing/events/cfg80211/rdev_set_ap_chanwidth/format
> /sys/kernel/tracing/events/cfg80211/rdev_set_monitor_channel/format
> /sys/kernel/tracing/events/cfg80211/rdev_set_radar_background/format
> /sys/kernel/tracing/events/cfg80211/rdev_start_ap/format
> /sys/kernel/tracing/events/cfg80211/rdev_start_radar_detection/format
> /sys/kernel/tracing/events/cfg80211/rdev_tdls_channel_switch/format
> /sys/kernel/tracing/events/compaction/mm_compaction_defer_compaction/format
> /sys/kernel/tracing/events/compaction/mm_compaction_deferred/format
> /sys/kernel/tracing/events/compaction/mm_compaction_defer_reset/format
> /sys/kernel/tracing/events/compaction/mm_compaction_finished/format
> /sys/kernel/tracing/events/compaction/mm_compaction_kcompactd_wake/format
> /sys/kernel/tracing/events/compaction/mm_compaction_suitable/format
> /sys/kernel/tracing/events/compaction/mm_compaction_wakeup_kcompactd/format
> /sys/kernel/tracing/events/error_report/error_report_end/format
> /sys/kernel/tracing/events/i2c_slave/i2c_slave/format
> /sys/kernel/tracing/events/migrate/mm_migrate_pages/format
> /sys/kernel/tracing/events/migrate/mm_migrate_pages_start/format
> /sys/kernel/tracing/events/pagemap/mm_lru_insertion/format
> /sys/kernel/tracing/events/power/dev_pm_qos_add_request/format
> /sys/kernel/tracing/events/power/dev_pm_qos_remove_request/format
> /sys/kernel/tracing/events/power/dev_pm_qos_update_request/format
> /sys/kernel/tracing/events/power/pm_qos_update_flags/format
> /sys/kernel/tracing/events/power/pm_qos_update_target/format
> /sys/kernel/tracing/events/pwm/pwm_apply/format
> /sys/kernel/tracing/events/pwm/pwm_get/format
> /sys/kernel/tracing/events/sched/sched_skip_vma_numa/format
> /sys/kernel/tracing/events/skb/kfree_skb/format
> /sys/kernel/tracing/events/thermal/thermal_zone_trip/format
> /sys/kernel/tracing/events/timer/hrtimer_init/format
> /sys/kernel/tracing/events/timer/hrtimer_start/format
> /sys/kernel/tracing/events/xen/xen_mc_batch/format
> /sys/kernel/tracing/events/xen/xen_mc_extend_args/format
> /sys/kernel/tracing/events/xen/xen_mc_flush_reason/format
> /sys/kernel/tracing/events/xen/xen_mc_issue/format
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d93f34e9af74..bd16679fb4c0 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1962,12 +1962,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	return err;
>  }
>  
> -static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> +static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)
>  {
>  	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
>  
>  	if (fmt != NULL) {
> -		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
> +		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, use_btf);
>  		return 0;
>  	}
>  
> @@ -2171,7 +2171,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			 * property isn't set.
>  			 */
>  			if (val == 0 && !trace->show_zeros &&
> -			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
> +			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
> +			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum))
>  				continue;
>  
>  			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> @@ -2877,7 +2878,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
>  
>  		/* Suppress this argument if its value is zero and show_zero property isn't set. */
> -		if (val == 0 && !trace->show_zeros && !arg->show_zero)
> +		if (val == 0 && !trace->show_zeros && !arg->show_zero && !arg->is_enum)
>  			continue;
>  
>  		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> @@ -2885,6 +2886,15 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		if (trace->show_arg_names)
>  			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> +		if (arg->is_enum && trace->btf) {
> +			size_t p = btf_enum_scnprintf(bf + printed, size - printed, val, trace->btf,
> +						      field->type, arg);
> +			if (p) {
> +				printed += p;
> +				continue;
> +			}
> +		}
> +
>  		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
>  	}
>  
> @@ -4537,7 +4547,7 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
>  	}
>  }
>  
> -static int evlist__set_syscall_tp_fields(struct evlist *evlist)
> +static int evlist__set_syscall_tp_fields(struct evlist *evlist, bool *use_btf)
>  {
>  	struct evsel *evsel;
>  
> @@ -4546,7 +4556,7 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
>  			continue;
>  
>  		if (strcmp(evsel->tp_format->system, "syscalls")) {
> -			evsel__init_tp_arg_scnprintf(evsel);
> +			evsel__init_tp_arg_scnprintf(evsel, use_btf);
>  			continue;
>  		}
>  
> @@ -5024,11 +5034,16 @@ int cmd_trace(int argc, const char **argv)
>  	}
>  
>  	if (trace.evlist->core.nr_entries > 0) {
> +		bool use_btf = false;
> +
>  		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
> -		if (evlist__set_syscall_tp_fields(trace.evlist)) {
> +		if (evlist__set_syscall_tp_fields(trace.evlist, &use_btf)) {
>  			perror("failed to set syscalls:* tracepoint fields");
>  			goto out;
>  		}
> +
> +		if (use_btf && trace.btf == NULL)
> +			trace__load_vmlinux_btf(&trace);

Can we defer loading btf to when one of those tracepoints is hit?

>  	}
>  
>  	if (trace.sort_events) {
> -- 
> 2.45.2
