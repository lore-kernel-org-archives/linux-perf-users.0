Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC311AE86C;
	Thu,  4 Jul 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097048; cv=none; b=tFniedYTVHW+54MAyrFKQFVT4JdMTVnY5JCq+rhlevNFuPrjjcHdBpREzlEHr7WpNpwHo3tG950jjZpsOklnI6sJ5m5EL7p/X8FlidmufKPS5KAMSlGyXbTp0lZpU/zTn8qTZhei2mGA9kzTy4gXAsiC2iP60Migzqb5auI4lfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097048; c=relaxed/simple;
	bh=1IoeeiKDQn4cIh5wAhNK2A9yVDhqBbOIWz+VT/VgCiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go07rnGa2opyWtO/Dcpx+MqHkS2+3hFL2x6dyp1NXIQU697RcoIHOMB2mT5uuCHj+7T3wDfNMA3jN2xn8hAXxaYPt6gmEjaItm4+nBV/R+aLnTXw4Rn96OkIPsO1Jk4srOFprxuq0HxZYtwhTRq6xDvphiULgAY5BpAWcksdvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5ox4Axu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5ox4Axu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso2055845ad.1;
        Thu, 04 Jul 2024 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097046; x=1720701846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwThFutnJmHGHzUHIb+ig5KtDU/wrUyzzPYUrLoH27E=;
        b=i5ox4AxuBE216HoNiQvBG4QK8LJgR/xc51G59LqGfdGVEOFtKFN6fV0hqPV0VmVUYw
         xqV+6SIVfY6tD8dIqQxqgxirsW9w/dWH/8qxxER7cldmyVYanXONDlW98u7Y6N/s0g0m
         ntdTTLi9rBN+DebvADxaX/Pj1WeWkV/fS5x/LZvbufVVB7laZ50Rs3aelnvWKYzhK+/e
         fWvOlnByyJ8FtVVw+xkEx6pCN0jV+3+Nl0z7dR4H6mLsiLG0G+OrmNDyADK+23MJT6WV
         1f1PivvdcdM2m0fPgs2a5GHO5FIkmgdxbH/ukqsHReOEIoXCHzFTx0X0fsmQ3PeV9d/0
         qVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097046; x=1720701846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwThFutnJmHGHzUHIb+ig5KtDU/wrUyzzPYUrLoH27E=;
        b=tU5l2z0rqYMPsVEmJR56U01iho/75pkjnfBCWpS19SwbiVBSdh+QjCk6NJ8vvcS541
         lMpcO/QvTWKPq/ev0fISa7NVhvc2YwofBrK1TMmIxGvNE49Pww8aTyj8iPbg5o62NcPV
         MbaPwg2vZzDBpjskp+b4/YmkdN1/t2VWx0Eayh0iRVfXipSvQUTJF6qbXk5pnqdxrGNg
         8HQPyBX1X+TaS0RFMP2lJec+qX7sBqrah3cRqS9aaIW6t8nrANwxu+uvZh6M1E6Bbp8R
         Exg9oxBHatCYEUjqVKjZlGV+CRI3eNcBZplbOT8UXxrNPzRR413Xxz86FLA9FWPJmqc0
         ceaw==
X-Forwarded-Encrypted: i=1; AJvYcCWUHunE4I7ZP/105Cqg+cH4PwpvI7cxqQRF/wAzwQKc5R+ksj781/ZzrzRF+g7OsVCKIy+P4dl/mpRdrrRjSLmEjDN+4/aLzutEp82HAyEkuw0bXVbQrgWJSk3Z/K/KN++wT4ScVhf6Wxzu37pdvA==
X-Gm-Message-State: AOJu0Yym3K6YyeZ+m3bXRrj+MTi3PmwUrKVrXNoGs7Gxd2fcJ9ArQzKE
	H5y0OW5NcbjXeyXDcAXiVWqFP+krL4u2gifLH8jGtUQuJNUXQf9c
X-Google-Smtp-Source: AGHT+IGCj5WT6hpJwbRAgG+ZoC/jZ6t5VubcKLYGS0+nBOM4pwyEDVfujhAdymmNJwuFo3b1B0gbXA==
X-Received: by 2002:a17:902:c114:b0:1fa:18c3:2791 with SMTP id d9443c01a7336-1fb33e7be44mr10028505ad.36.1720097045668;
        Thu, 04 Jul 2024 05:44:05 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:44:05 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 3/8] perf trace: Augment non-syscall tracepoints with enum arguments with BTF
Date: Thu,  4 Jul 2024 20:43:49 +0800
Message-ID: <20240704124354.904540-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>
References: <20240704124354.904540-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before:

perf $ ./perf trace -e timer:hrtimer_start --max-events=1
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466c25f18, function: 0xffffffff89da5be0, expires: 377432432256753, softexpires: 377432432256753, mode: 10)

After:

perf $ ./perf trace -e timer:hrtimer_start --max-events=1
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 4382442895089, softexpires: 4382442895089, mode: HRTIMER_MODE_ABS_PINNED_HARD)

in which HRTIMER_MODE_ABS_PINNED_HARD is:

perf $ pahole hrtimer_mode
enum hrtimer_mode {
        HRTIMER_MODE_ABS             = 0,
        HRTIMER_MODE_REL             = 1,
        HRTIMER_MODE_PINNED          = 2,
        HRTIMER_MODE_SOFT            = 4,
        HRTIMER_MODE_HARD            = 8,
        HRTIMER_MODE_ABS_PINNED      = 2,
        HRTIMER_MODE_REL_PINNED      = 3,
        HRTIMER_MODE_ABS_SOFT        = 4,
        HRTIMER_MODE_REL_SOFT        = 5,
        HRTIMER_MODE_ABS_PINNED_SOFT = 6,
        HRTIMER_MODE_REL_PINNED_SOFT = 7,
        HRTIMER_MODE_ABS_HARD        = 8,
        HRTIMER_MODE_REL_HARD        = 9,
        HRTIMER_MODE_ABS_PINNED_HARD = 10,
        HRTIMER_MODE_REL_PINNED_HARD = 11,
};

Can also be tested by

./perf trace -e pagemap:mm_lru_insertion,timer:hrtimer_start,timer:hrtimer_init,skb:kfree_skb --max-events=10

(Chose these 4 events because they happen quite frequently.)

However some enum arguments may not be contained in vmlinux BTF. To see
what enum arguments are supported, use:

vmlinux_dir $ bpftool btf dump file /sys/kernel/btf/vmlinux > vmlinux

vmlinux_dir $  while read l; do grep "ENUM '$l'" vmlinux; done < <(grep field:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort | uniq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g"
dev_pm_qos_req_type
error_detector
hrtimer_mode
i2c_slave_event
ieee80211_bss_type
lru_list
migrate_mode
nl80211_auth_type
nl80211_band
nl80211_iftype
numa_vmaskip_reason
pm_qos_req_action
pwm_polarity
skb_drop_reason
thermal_trip_type
xen_lazy_mode
xen_mc_extend_args
xen_mc_flush_reason
zone_type

And what tracepoints have these enum types as their arguments:

vmlinux_dir $ while read l; do grep "ENUM '$l'" vmlinux; done < <(grep field:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort | uniq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g" > good_enums

vmlinux_dir $ cat good_enums
dev_pm_qos_req_type
error_detector
hrtimer_mode
i2c_slave_event
ieee80211_bss_type
lru_list
migrate_mode
nl80211_auth_type
nl80211_band
nl80211_iftype
numa_vmaskip_reason
pm_qos_req_action
pwm_polarity
skb_drop_reason
thermal_trip_type
xen_lazy_mode
xen_mc_extend_args
xen_mc_flush_reason
zone_type

vmlinux_dir $ grep -f good_enums -l /sys/kernel/tracing/events/*/*/format
/sys/kernel/tracing/events/cfg80211/cfg80211_chandef_dfs_required/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_notify/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_started_notify/format
/sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ibss_joined/format
/sys/kernel/tracing/events/cfg80211/cfg80211_inform_bss_frame/format
/sys/kernel/tracing/events/cfg80211/cfg80211_radar_event/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel_expired/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel/format
/sys/kernel/tracing/events/cfg80211/cfg80211_reg_can_beacon/format
/sys/kernel/tracing/events/cfg80211/cfg80211_return_bss/format
/sys/kernel/tracing/events/cfg80211/cfg80211_tx_mgmt_expired/format
/sys/kernel/tracing/events/cfg80211/rdev_add_virtual_intf/format
/sys/kernel/tracing/events/cfg80211/rdev_auth/format
/sys/kernel/tracing/events/cfg80211/rdev_change_virtual_intf/format
/sys/kernel/tracing/events/cfg80211/rdev_channel_switch/format
/sys/kernel/tracing/events/cfg80211/rdev_connect/format
/sys/kernel/tracing/events/cfg80211/rdev_inform_bss/format
/sys/kernel/tracing/events/cfg80211/rdev_libertas_set_mesh_channel/format
/sys/kernel/tracing/events/cfg80211/rdev_mgmt_tx/format
/sys/kernel/tracing/events/cfg80211/rdev_remain_on_channel/format
/sys/kernel/tracing/events/cfg80211/rdev_return_chandef/format
/sys/kernel/tracing/events/cfg80211/rdev_return_int_survey_info/format
/sys/kernel/tracing/events/cfg80211/rdev_set_ap_chanwidth/format
/sys/kernel/tracing/events/cfg80211/rdev_set_monitor_channel/format
/sys/kernel/tracing/events/cfg80211/rdev_set_radar_background/format
/sys/kernel/tracing/events/cfg80211/rdev_start_ap/format
/sys/kernel/tracing/events/cfg80211/rdev_start_radar_detection/format
/sys/kernel/tracing/events/cfg80211/rdev_tdls_channel_switch/format
/sys/kernel/tracing/events/compaction/mm_compaction_defer_compaction/format
/sys/kernel/tracing/events/compaction/mm_compaction_deferred/format
/sys/kernel/tracing/events/compaction/mm_compaction_defer_reset/format
/sys/kernel/tracing/events/compaction/mm_compaction_finished/format
/sys/kernel/tracing/events/compaction/mm_compaction_kcompactd_wake/format
/sys/kernel/tracing/events/compaction/mm_compaction_suitable/format
/sys/kernel/tracing/events/compaction/mm_compaction_wakeup_kcompactd/format
/sys/kernel/tracing/events/error_report/error_report_end/format
/sys/kernel/tracing/events/i2c_slave/i2c_slave/format
/sys/kernel/tracing/events/migrate/mm_migrate_pages/format
/sys/kernel/tracing/events/migrate/mm_migrate_pages_start/format
/sys/kernel/tracing/events/pagemap/mm_lru_insertion/format
/sys/kernel/tracing/events/power/dev_pm_qos_add_request/format
/sys/kernel/tracing/events/power/dev_pm_qos_remove_request/format
/sys/kernel/tracing/events/power/dev_pm_qos_update_request/format
/sys/kernel/tracing/events/power/pm_qos_update_flags/format
/sys/kernel/tracing/events/power/pm_qos_update_target/format
/sys/kernel/tracing/events/pwm/pwm_apply/format
/sys/kernel/tracing/events/pwm/pwm_get/format
/sys/kernel/tracing/events/sched/sched_skip_vma_numa/format
/sys/kernel/tracing/events/skb/kfree_skb/format
/sys/kernel/tracing/events/thermal/thermal_zone_trip/format
/sys/kernel/tracing/events/timer/hrtimer_init/format
/sys/kernel/tracing/events/timer/hrtimer_start/format
/sys/kernel/tracing/events/xen/xen_mc_batch/format
/sys/kernel/tracing/events/xen/xen_mc_extend_args/format
/sys/kernel/tracing/events/xen/xen_mc_flush_reason/format
/sys/kernel/tracing/events/xen/xen_mc_issue/format

Committer testing:

  root@x1:~# perf trace -e timer:hrtimer_start --max-events=2
       0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function: 0xffffffff9e22ddd0, expires: 241152380000000, softexpires: 241152380000000, mode: HRTIMER_MODE_ABS)
       0.028 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff225050, function: 0xffffffff9e22ddd0, expires: 241153654000000, softexpires: 241153654000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
  root@x1:~#

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20240615032743.112750-1-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1391564911d9..5618feb7d01a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1979,12 +1979,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return err;
 }
 
-static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
+static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)
 {
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, use_btf);
 		return 0;
 	}
 
@@ -2188,7 +2188,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			 * property isn't set.
 			 */
 			if (val == 0 && !trace->show_zeros &&
-			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2893,7 +2894,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
 
 		/* Suppress this argument if its value is zero and show_zero property isn't set. */
-		if (val == 0 && !trace->show_zeros && !arg->show_zero)
+		if (val == 0 && !trace->show_zeros && !arg->show_zero && !arg->is_enum)
 			continue;
 
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2901,6 +2902,15 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
+		if (arg->is_enum) {
+			size_t p = trace__btf_enum_scnprintf(trace, arg, bf + printed,
+							     size - printed, val, field->type);
+			if (p) {
+				printed += p;
+				continue;
+			}
+		}
+
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
@@ -4553,7 +4563,7 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
 	}
 }
 
-static int evlist__set_syscall_tp_fields(struct evlist *evlist)
+static int evlist__set_syscall_tp_fields(struct evlist *evlist, bool *use_btf)
 {
 	struct evsel *evsel;
 
@@ -4562,7 +4572,7 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 			continue;
 
 		if (strcmp(evsel->tp_format->system, "syscalls")) {
-			evsel__init_tp_arg_scnprintf(evsel);
+			evsel__init_tp_arg_scnprintf(evsel, use_btf);
 			continue;
 		}
 
@@ -5040,11 +5050,16 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 	if (trace.evlist->core.nr_entries > 0) {
+		bool use_btf = false;
+
 		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
-		if (evlist__set_syscall_tp_fields(trace.evlist)) {
+		if (evlist__set_syscall_tp_fields(trace.evlist, &use_btf)) {
 			perror("failed to set syscalls:* tracepoint fields");
 			goto out;
 		}
+
+		if (use_btf)
+			trace__load_vmlinux_btf(&trace);
 	}
 
 	if (trace.sort_events) {
-- 
2.45.2

