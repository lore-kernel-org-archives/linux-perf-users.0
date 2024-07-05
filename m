Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FD1487C6;
	Fri,  5 Jul 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172587; cv=none; b=OVVo6hIIBPy3A9gNXw6sKlHKhCFaJDNwWpB21Voi5ui+hDqLIx2UzYq+MRTRwl8Bgt8DCebFoJQ6k2gRrWLCgmIfdRQuAbCskQa/EJa1jyfdQV+Y9VBcFM9L4va4EXZSeuPIyMKd146ts5G48b4GBzaWakoO+ff0g8gfFkPrYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172587; c=relaxed/simple;
	bh=wZt9Yscf3NHoVs//WjE+d/6CjmjjOUhU9J1rClELho4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIm9eGfVNS2obcchPXRKKrKxe15LPKOYCfuz6kQCnqkN2vZwT+cXsLjB0jYKH0rNdpxFc2wJe3ShyBkx7b+LTCCchsdVaUPK+CWRYSGrzTyrdv+BctZwV83B9wFJ5fq5/fC7U+g2HCxpb05s/R9XkTWK3e1W0AUuQHCxQ/ZDAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoo8/Y5Q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoo8/Y5Q"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75c5bdab7faso869257a12.1;
        Fri, 05 Jul 2024 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172585; x=1720777385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrw/+MkpLo+YifaVzEnjYrzCeq2JJtmQbuCJK7soUkM=;
        b=hoo8/Y5QvCSKS+o8gGmDubZv6R5BxrT0KNrP2Q+y5xw/8XhL8V/+uijHZTuJCr9gfm
         t5tCsUlfohGafBl3BcvAix2DNKhi509E75RNHWK5FdyIsUsN5VtDjuLqzEqxEpzLGWDw
         xtXZoAjUT5ahLpw1K7AQlh4CIo3Tx3ZC+SqOPIX9ViYlDH3nzK1v1DkHDVZeoKRcfu/G
         gy+B++Uw+xMZBzZvEgSx1bMVs4WwCPnuCpSjNskqVbJAZll0cnk3/ym7J3GSo1d8PQ72
         YxuXnrVm3HRGgJ/G2wZeWffAYGWqxKo/11Gm0CLvLtGcVooB96Wgyk12RS4Ymbt5/G4i
         RSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172585; x=1720777385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrw/+MkpLo+YifaVzEnjYrzCeq2JJtmQbuCJK7soUkM=;
        b=cBUsS/FwHe8IYyHWj+V5RBbSUDHl1Sw4NApae6dR8FV6x8caD/Rmq8TYBiyKRWD0PM
         xZcv3UKS12pdqH1hzbOLq1D8lRDrnyZ9FRqLyDKd/DNM2/HUt7ffaT7hHFQ5lR9m4NWv
         Q52svoXorbrVSGSASZbs8xOCQv7JPIX8wXKSoT+28rQ7oNtxW9qGZxck3sjGjylCS3nG
         9GeewaYr+fOvSnDdC2+1FvtHePKtuYEvXd61KcEsyrZrEFKGSjN89qM0fERp8NcyZRU9
         JfmOuttq1HGCrzZkyVAu4vVFRrer3ISl+p20tjPam78LyrT75FcnZ/wlzVyfdeIZtZCo
         nT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAMpxIuYuJN4NyKeDOcGnLDyn7jymtkI7plvvKWPIO0mJkM9TNhzNanEftR56K+P64wOHv02e9to4+sQyClhNeOcjGSCHltuN6t+/BQRN6PODyTZtfxSEVpCYv7JB28qcj3CVPkOsfJHf4HLOfqQ==
X-Gm-Message-State: AOJu0YzBePDK29p4IPHbwY1mC9lgIB8AHaoh2h191gYNxUpI+2esAK6T
	AVVzdCH1gp8xPqLzd5OQ+594hb1Y2GPlOmjMMcRocBEEDBWEZDvA
X-Google-Smtp-Source: AGHT+IGA2D94Ha4nD4ajrc88CdhEy0O/8fEX/Bg8KCpQUIDfrSSsFRpHN4WBbPjAK20F05UOfj1p/Q==
X-Received: by 2002:a05:6a21:3995:b0:1c0:bd9c:adf with SMTP id adf61e73a8af0-1c0cc8ce924mr4193981637.50.1720172584916;
        Fri, 05 Jul 2024 02:43:04 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd133sm2958138a91.38.2024.07.05.02.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:43:04 -0700 (PDT)
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
Subject: [PATCH v5 3/8] perf trace: Augment non-syscall tracepoints with enum arguments with BTF
Date: Fri,  5 Jul 2024 17:42:55 +0800
Message-ID: <20240705094300.585156-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705094300.585156-1-howardchu95@gmail.com>
References: <20240705094300.585156-1-howardchu95@gmail.com>
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
Link: https://lore.kernel.org/r/20240624181345.124764-4-howardchu95@gmail.com
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

