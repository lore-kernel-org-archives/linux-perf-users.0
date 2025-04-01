Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E92206BC
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531910; cv=none; b=YuCpBpSk8JiKe/Kk/QA/HqQFU8HwyJSGqdtpCA8cwSMQBezTgongEVLeIcVokIxQTKWhHJK2wVwZXOcHUgyLV2jkzYoK9/l9cS6H+dSii7SqoWA2Vvywq9vFVMPxz/U9s29q3IXcLZ5OEtQIumUDexCIvGlBX2dj+AIz/D/KkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531910; c=relaxed/simple;
	bh=LJ5bCbL+1daj73vhuubS5IIoYg4jtmiDU7rvTqttR9Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eqUmgqIau0EKTCVt3sDfKCtT6h53iuEN4icQXy+UAwchyxl9FHyZKFConM7g8DyYtq6rOZ1WGj2qldCmHrx71EK4IVhHSJ482EoJSFJ/88ao5JSFRiiMqrDSHloZ4fvBNRgA72XuRJQ3SFBUL3LvsMnSmoPA3Lpje6B+hrUSb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ee1gaJVF; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee1gaJVF"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c7ece3d81dso1584231fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531907; x=1744136707; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Da5DUiJVSsEnsA3gzfAHXUpLTR3Ufuk1FvHZfSFlCg4=;
        b=Ee1gaJVF00LEQ6hDSsNMINNiE9yL7LSeT9izMBg/ST1mSddj4XsNBnkPsBfP5rbIT+
         DW9I/XnOi8ZnRgMro8xUyxDtJmNk2zPx0WMvDlFpPqfW9qx+kkwLCwJ8G0K7Ax2DxhRx
         YdpTzyq3Xbt8VC+KaymsiJgT+U2aVA8jBjlIyG/bPICLP3TNP/XXXx536YrTaIOQ7vdF
         a/D8pdpdyLiyEW7+OMyYk2lo1rHcGca+S69xgb1NOvDXfNsz21m3HDsiMlL3fub634R2
         QsGiubqsgglNohJCBKDNbQZB1MP1COP1Jgzkos7hT4ZmFSq/ROAmmuhuPoSgHyVMCY6K
         wqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531907; x=1744136707;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da5DUiJVSsEnsA3gzfAHXUpLTR3Ufuk1FvHZfSFlCg4=;
        b=Rmim8sBuKQGnVVlq/2hAuCXKHEs7Hl77DqOB8brC4EvkOzkcE9GvzN1/sBe0UaViIe
         29VlPdcQKV9T/7LIu28KuF32QiNMwIsHXMrCHZznT3K6dWzlxMJQKI8drGOI4Su/Xsv9
         M8v7AnOeKQkbyXTRmlnEX7Q7rC8gKNhcFYUIo1fyLDLGbnwYBllEWgM/1eDYCSoBVyRM
         Kw2khL70Q27XfZWdPZ3b2v7UwpuCj8B7ZB+g/yeIylK9olTtcak8+AuEbZtToSquu3cE
         SdLQRdVJZki0teN3qn9PsST5XtrXtw2mJuxlCXbG1itrhRIPc56alnPnbEBRaYmgr1xB
         JKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgLowKF5CKUTyFlixhoqxgAf8PwCapQr+PunOQvfU9a51TGlTCen0g7o0mL6YwLn6+ONgQK/LTi5B1ZEYuZZBA@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBVSs7rjNrnd7ABm2tv7BOxn4hXtk02UsEq8GcAZE/2yT2SId
	QhmE6Cn2K6dWxHJcGS4dSXsQU6d6txULHu9ilGqOdNRieGWn2TwVqj+qrmGii860+JBBRXVQPJb
	r+ABwaQ==
X-Google-Smtp-Source: AGHT+IHEwV4zAtKk0PBs2gzq5sOI+YyZoow9R1UWlEQXJU1TorP5CNFdlUvUeobymJBu8Fg99nd3p4RriyMG
X-Received: from oabsc17.prod.google.com ([2002:a05:6871:2211:b0:2c1:665d:545e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:3a0b:b0:29e:5897:e9d1
 with SMTP id 586e51a60fabf-2cbcf825a7emr7646545fac.39.1743531907119; Tue, 01
 Apr 2025 11:25:07 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:13 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-16-irogers@google.com>
Subject: [PATCH v1 15/48] perf pmu: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c |  8 ++++----
 tools/perf/util/pmu.c       |  9 ++++-----
 tools/perf/util/pmus.c      | 16 ++++++++--------
 tools/perf/util/tool_pmu.c  |  2 +-
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 3cce77fc8004..6245eeb593c9 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -170,7 +170,7 @@ bool parse_hwmon_filename(const char *filename,
 	for (size_t i = 0; fn_type[i] != '\0'; i++) {
 		if (fn_type[i] >= '0' && fn_type[i] <= '9') {
 			fn_type[i] = '\0';
-			*number = strtoul(&filename[i], (char **)&fn_item, 10);
+			*number = (int)strtoul(&filename[i], (char **)&fn_item, 10);
 			if (*fn_item == '_')
 				fn_item++;
 			break;
@@ -194,7 +194,7 @@ bool parse_hwmon_filename(const char *filename,
 		return false;
 	}
 
-	*type = elem - &hwmon_type_strs[0];
+	*type = (enum hwmon_type)(elem - &hwmon_type_strs[0]);
 	if (!item)
 		return true;
 
@@ -213,7 +213,7 @@ bool parse_hwmon_filename(const char *filename,
 			 fn_item, filename);
 		return false;
 	}
-	*item = elem - &hwmon_item_strs[0];
+	*item = (enum hwmon_item)(elem - &hwmon_item_strs[0]);
 	return true;
 }
 
@@ -352,7 +352,7 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const cha
 		return NULL;
 
 	hwm->hwmon_dir_fd = hwmon_dir;
-	hwm->pmu.type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
+	hwm->pmu.type = PERF_PMU_TYPE_HWMON_START + (int)strtoul(sysfs_name + 5, NULL, 10);
 	if (hwm->pmu.type > PERF_PMU_TYPE_HWMON_END) {
 		pr_err("Unable to encode hwmon type from %s in valid PMU type\n", sysfs_name);
 		goto err_out;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b7ebac5ab1d1..5a940bf004fb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1269,7 +1269,7 @@ __u64 perf_pmu__format_bits(struct perf_pmu *pmu, const char *name)
 {
 	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 	__u64 bits = 0;
-	int fbit;
+	size_t fbit;
 
 	if (!format)
 		return 0;
@@ -1314,9 +1314,8 @@ static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 
 static __u64 pmu_format_max_value(const unsigned long *format)
 {
-	int w;
+	size_t w = bitmap_weight(format, PERF_PMU_FORMAT_BITS);
 
-	w = bitmap_weight(format, PERF_PMU_FORMAT_BITS);
 	if (!w)
 		return 0;
 	if (w < 64)
@@ -1824,7 +1823,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 	if (!pmu->is_core)
 		return 0;
 
-	for (size_t i = 0; i < ARRAY_SIZE(terms); i++) {
+	for (int i = 0; i < (int)ARRAY_SIZE(terms); i++) {
 		int config = PERF_PMU_FORMAT_VALUE_CONFIG;
 
 		if (i < PERF_PMU_FORMAT_VALUE_CONFIG_END)
@@ -2281,7 +2280,7 @@ static void perf_pmu__compute_config_masks(struct perf_pmu *pmu)
 		return;
 
 	list_for_each_entry(format, &pmu->format, list)	{
-		unsigned int i;
+		size_t i;
 		__u64 *mask;
 
 		if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b99292de7669..0b9071219376 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -59,7 +59,7 @@ static void pmu_read_sysfs(unsigned int to_read_pmus);
 
 size_t pmu_name_len_no_suffix(const char *str)
 {
-	int orig_len, len;
+	size_t orig_len, len;
 	bool has_hex_digits = false;
 
 	orig_len = len = strlen(str);
@@ -353,7 +353,7 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
-	int last_pmu_name_len = 0;
+	size_t last_pmu_name_len = 0;
 	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
 
 	if (!pmu) {
@@ -364,7 +364,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 
 	if (use_core_pmus) {
 		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
+			size_t pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 			if (last_pmu_name_len == pmu_name_len &&
 			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -376,7 +376,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
 	list_for_each_entry_continue(pmu, &other_pmus, list) {
-		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
+		size_t pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 		if (last_pmu_name_len == pmu_name_len &&
 		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
@@ -581,7 +581,7 @@ static int build_format_string(void *state, const char *name, int config,
 			       const unsigned long *bits)
 {
 	struct build_format_string_args *args = state;
-	unsigned int num_bits;
+	size_t num_bits;
 	int ret1, ret2 = 0;
 
 	(void)config;
@@ -631,14 +631,14 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 			.long_string = STRBUF_INIT,
 			.num_formats = 0,
 		};
-		int len = pmu_name_len_no_suffix(pmu->name);
+		size_t len = pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
 		if (!pmu->is_core)
 			desc = NULL;
 
-		strbuf_addf(&format_args.short_string, "%.*s/", len, pmu->name);
-		strbuf_addf(&format_args.long_string, "%.*s/", len, pmu->name);
+		strbuf_addf(&format_args.short_string, "%.*s/", (int)len, pmu->name);
+		strbuf_addf(&format_args.long_string, "%.*s/", (int)len, pmu->name);
 		perf_pmu__for_each_format(pmu, &format_args, build_format_string);
 
 		if (format_args.num_formats > 3)
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 97b327d1ce4a..155eea8a0a49 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -103,7 +103,7 @@ enum tool_pmu_event evsel__tool_event(const struct evsel *evsel)
 
 const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
 {
-	return tool_pmu__event_to_str(evsel->core.attr.config);
+	return tool_pmu__event_to_str((enum tool_pmu_event)evsel->core.attr.config);
 }
 
 static bool read_until_char(struct io *io, char e)
-- 
2.49.0.504.g3bcea36a83-goog

