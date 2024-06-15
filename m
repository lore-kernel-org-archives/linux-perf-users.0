Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676058C0B;
	Sat, 15 Jun 2024 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718422078; cv=none; b=NxleycU4uJYq/iNf4J3EDs4EkPrWBuREWAG5jp5TrUZPdcgP1jpreLjQLqh0W6Xscs7HWQEEhskqYZqYnHtAukR0u/RmzDWqHbxb5IkFZX+PxeaOj70lvt9TS3gjavERL09IpPyYDPl27OaJiiyKteCx56rVuAqK9T1nyAklTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718422078; c=relaxed/simple;
	bh=eUnYZ6dsq24ODgZVgABMAhd0T6ohsMkbjPbqYMPO6AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HX+luiSxfLrQ4vjpQnvrW0Q3yCfwUi856JGYupA2ERLHteYNPEdsVq1vJlbNEo9YXiUxhAXSQJwcDlQU1cUfTyo2zomSu8AO6zU6w5dFpx46Ik0Wytow2SUAmF0Q0nuFEzXavHEW9ZH85Cd/5DAX1AmAHHB2Vx/S9IJYvqdw6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd49wXFL; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd49wXFL"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8d0a1e500so1844684a34.3;
        Fri, 14 Jun 2024 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718422075; x=1719026875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaRZNxrV1NEonmvgnByb6dIvOd8uaxHy8naR0k2YNoo=;
        b=Xd49wXFLrB08DzQRj5MQcWfxtXK6nlBuC5m9kVW0K8EoabEdeftx6tYGROO0ZQc6NY
         1GBhQ14C4opRS7blB1ioTddrtlW01GrSmWh36tJ+4zwxlY6DC4r4a9gz+uTXVV3nI7xw
         mnZY/u/wOR2dfGTFwBh34dZy5ZKaCW0Gbo6QREsLC2b6nwZf1Gu7ysUrtXu1CJ4p6uS9
         iFiW53rugsY9z+CIQ7LrUHjQT1O/mpo6IHJtQFlab9jE/W2f12Jcl7WINwAMdiYGnzFS
         AwkldEWsI2k9S0gIkS4MC0VqS1fXcaFSOuHgQW81O/M7Ci6yN9erBDM4YAkrANNU1DDo
         m0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718422075; x=1719026875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaRZNxrV1NEonmvgnByb6dIvOd8uaxHy8naR0k2YNoo=;
        b=oisAeP8r1pcUsKpKK5OH3R6PoBwheRIBCVK3LQf5A36T5oOnmtwO9r4aZFek0cXXyP
         oicofO4LZf6z7YZuHyKJDTeqDTkkW7ur9fHtmeNkgYjkQDgd5Fplv7jn0LeCHIVzqD4t
         Rn2jEvdb466NhHeRpdhKhQWcAy77dQUq1TDLVBi7/DSvJ0renUw8wewhNrQH/JP9AZbU
         GuL84Gv9ItCZP02fubg4fzEy2sUyTJzlgvRK5C0csgXeQm1aWpZuXI3Kj8ZAG3MOv9SS
         SMmRSSUf/Iy2JL9McZSk4DrhvEtxnMzVAD/sdLYsa2acsf8pRVLWt5AfCD2GkpG0+NZJ
         QlCA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4oQtLp3ozP0d4G7J4y5V1QkCUsVw6PGOiNv+nrHgM9olr1+NW919bnBFfHUgT3t7jPvHuMD+mfemAwKANI0PwCY15pbDHAFKGLW4KEFJwye8ITW3syHYRsUN1La2z3y4LaJAOxTfkdGEEtqyEw==
X-Gm-Message-State: AOJu0Yxpk/3pE22OJo3c810aacnYrQ+1Yo5X0HQw3kU7A3ZP6N1zq1uR
	dZjfwF06NNdke4O480MNjiismAe4IwtIT3YGNGTixEozfwAYX6rF
X-Google-Smtp-Source: AGHT+IFsnLdoXbO34kMVgxxuXZLphOIhvoAB7ZLKrThC9O+As2iZcq6+/KeZyudSSvR8XydooAGwWw==
X-Received: by 2002:a05:6870:612c:b0:254:9433:c88 with SMTP id 586e51a60fabf-2584293535amr4964969fac.27.1718422075150;
        Fri, 14 Jun 2024 20:27:55 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96868dsm3792193b3a.65.2024.06.14.20.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 20:27:54 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] perf trace: Augment non-syscall tracepoints with enum arguments with BTF
Date: Sat, 15 Jun 2024 11:27:43 +0800
Message-ID: <20240615032743.112750-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>

---
 tools/perf/builtin-trace.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d93f34e9af74..bd16679fb4c0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1962,12 +1962,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
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
 
@@ -2171,7 +2171,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			 * property isn't set.
 			 */
 			if (val == 0 && !trace->show_zeros &&
-			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2877,7 +2878,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
 
 		/* Suppress this argument if its value is zero and show_zero property isn't set. */
-		if (val == 0 && !trace->show_zeros && !arg->show_zero)
+		if (val == 0 && !trace->show_zeros && !arg->show_zero && !arg->is_enum)
 			continue;
 
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2885,6 +2886,15 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
+		if (arg->is_enum && trace->btf) {
+			size_t p = btf_enum_scnprintf(bf + printed, size - printed, val, trace->btf,
+						      field->type, arg);
+			if (p) {
+				printed += p;
+				continue;
+			}
+		}
+
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
@@ -4537,7 +4547,7 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
 	}
 }
 
-static int evlist__set_syscall_tp_fields(struct evlist *evlist)
+static int evlist__set_syscall_tp_fields(struct evlist *evlist, bool *use_btf)
 {
 	struct evsel *evsel;
 
@@ -4546,7 +4556,7 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 			continue;
 
 		if (strcmp(evsel->tp_format->system, "syscalls")) {
-			evsel__init_tp_arg_scnprintf(evsel);
+			evsel__init_tp_arg_scnprintf(evsel, use_btf);
 			continue;
 		}
 
@@ -5024,11 +5034,16 @@ int cmd_trace(int argc, const char **argv)
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
+		if (use_btf && trace.btf == NULL)
+			trace__load_vmlinux_btf(&trace);
 	}
 
 	if (trace.sort_events) {
-- 
2.45.2

