Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024F2557F;
	Tue, 18 Jun 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724372; cv=none; b=DRqVhaZaGzVBUuVpGOnTJ8VVdwVebiHeB+Ti22VaKLmEqqd6nRLWu8a+EzvfORU505Ry0kjlKgJZSE5irz8GlSVwD6wASkJEJ/q1MpHfy7y7J3co2qUUpte7w9xkCHi10HKcvjb33nsLnogTm3Mjp5VhmGBn0I2wi2o9QAJkTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724372; c=relaxed/simple;
	bh=80xKGi15F2H5LmV7pq8mcuOQUaXk733xW6wRhxSn5l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu570ZkEoE9lGOCZRmaQC0Lpa1ufgB+26SlqTI08BxJqsGKePEjZS68jdiZXpVv3v55tioafJAwq3ru4lMZZ0qzUHYlHzyYQyLlTTK9oDYQ8pc7NCN5U/NZfPsLE4juZ6vdyFRnTJ0PIW3F5SePT5ohJTNZi3pxbqxXjOrNNO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGAbb76x; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGAbb76x"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70435f4c330so4613646b3a.1;
        Tue, 18 Jun 2024 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724370; x=1719329170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbEWQHo+YQ1yR/+BSBiAM4ZCezg7MYt6LeR5q7fVzzE=;
        b=SGAbb76x94ST7Au3ZChVlEMRm97g1EYffQEvaugFFyFPT+gwGprwlp0R9YZo+sqWc3
         Ui+BwprwvZi1dtHIBfNQxkt7B0CKJjeSa5GUEyjRQ3xhipH45hctsTs/P3OTp+0J2Jo0
         THde+v4VqMVbztcZPaj0ahQs8tjIMlYzZgQq6yVBvn5fqN01aEBFf1l0twUOv9Zg6Q/Q
         WwrNudeRx8rz+9EQCWyO3F1czvWGVncjffZAJXzPgVnILemgR+mJS5+boP1ToGgphhQx
         ZpUhvJTz+oqK7ZUeFSg442w+by++vlwIs/BuG+b6153cS6P30RsIN9o2TIdhp2TrSrM3
         x+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724370; x=1719329170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbEWQHo+YQ1yR/+BSBiAM4ZCezg7MYt6LeR5q7fVzzE=;
        b=af6VyMl90tiELCnfAzsDczbKJ199RSehyiYf/Dw9+TEpaabG0bg0fys60s6fDRG8KN
         q/e4rumF3Dr6w5VfSLRN7U5pFrJf122NVqHiltELBE1KB/PQ/85YPm4qAJL6vWgW1IAo
         NZh37YejiZo5ea5aoFFwT0v0zbitGHpyraTyXOjsJeqM5wHmyUdELUYzCYiSYYUyD6s7
         Baq8BbYy2tr1FaO10mPYqvaPCwoUPMSdhAraumCRFSaZAeO3norR7qcxW+RoyJBk9NXY
         Z0etpLrmbwqS580kWFhE1frk9p2MsfzccT2ILzs5aoLi70yaQLIyxLhDVX2s4voEZLOU
         KuWw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmHnfESdECOXB7JPDSMFuTemaSzHeS5bJM0HiZ4i7x0D/FTTxXAfHY7CzZ57mPfE//IbjbWXsx4YF+AjB7SJuco7uOurxWfv4JSiaWC+x2gy91iHnfV4pUncm1IQp0aQdX18o+1G6ETBrwVR3vA==
X-Gm-Message-State: AOJu0Yyjk/bcF3I/9ZoxOGVnh8onHpxCo9U8AOFg+JK2gDbZIA3pNUMY
	reMoHmSlMFdH46qkXP/ysw2G8ic83Eddto+ovdZRjXTEbu/l3ec/
X-Google-Smtp-Source: AGHT+IG6HvvTKLyNDsdojshHNCVjjtAYOi+/5NUN0ibZfs1OX2n7jAvzGWyCoAmIDTuQA+J31UWMcA==
X-Received: by 2002:a05:6a20:72a6:b0:1b7:bdb3:7bbb with SMTP id adf61e73a8af0-1bae82a4da5mr14428046637.53.1718724369731;
        Tue, 18 Jun 2024 08:26:09 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4265esm9071388b3a.116.2024.06.18.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:26:09 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 3/5] perf trace: Augment enum tracepoint arguments with BTF
Date: Tue, 18 Jun 2024 23:26:50 +0800
Message-ID: <20240618152652.3446472-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618152652.3446472-1-howardchu95@gmail.com>
References: <20240618152652.3446472-1-howardchu95@gmail.com>
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
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466d25f18, function: 0xffffffff89da5be0, expires: 488283834504945, softexpires: 488283834504945, mode: HRTIMER_MODE_ABS_PINNED_HARD)

HRTIMER_MODE_ABS_PINNED_HARD is:

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

Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
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

