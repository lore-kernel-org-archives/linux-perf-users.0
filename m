Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606598;
	b=MrbMsPBY+btgSJ9OvnOUDX/H8fllEaDjusA4IpRJZNaAxsmk0E9JNpuOVDn/W51pAiGi
	 xOlSbD7OiOytVvc9TpAGRfSo3cN5/+U8skN0F7CjTHKdjJET3xDyh/jexnx2/dgXyvvZK
	 UxVUb3b+OMK91eJRu5wDl+SR51ST5Se2ffoc+7xLvU8C3I/a6fP3mZ9hr7VmhhPL3zHr0
	 5ym+0o9TV7BcnYT0a5b9vuDTCy7vcCO2x725hXUbEqPbgjcJV+TiDlQEupAQP4jxCYr1W
	 dXnsbCbCiWT8rkAg5g2o9pNFGnQwvHSpvIEgQbm0X/1RLl4+cRZjHQGH1u/yJBuvCYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pA1qyfllAf+v5Ejm5ZH1kCG25GG0E8C1nb+645hahNw=;
	b=jBw6MJC73qhe0t+UI431R6AQjqdhxiqSO3KcER92mjsr9rt2SjkYX7ngwV4kMMaiZwpF
	 QcvOqvOKNktfCRoSXB5HHYW7N/KELo/8yoyuUUHsRQWsU9csvFm/yWSSGk02gw++lB979
	 EUCZf3SR+bM/ZX3q/UVjoWjbFyONEwL0UW27J8rNnFGYfiXJzlyxOnRd4B57uuU2l9K2Q
	 gRHhUSEJRMDos/R/W9P8lWMEjCHusxOLdQo0XOp9W6TwhEhk1amuBUervvCPOT2B2AUbF
	 5VoyucU3U6Snx4VRGup1ImFAhgslj2bo+u9kyh8Lp69toyFf0t0eAppKzg4zoRVDUng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e8UcjoJf;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F1606C98A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05F1606C98A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e8UcjoJf
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so235202c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606597; x=1795211397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pA1qyfllAf+v5Ejm5ZH1kCG25GG0E8C1nb+645hahNw=;
        b=e8UcjoJfaoBS2Y1Rk5uigCUaiMmJ/91+zQ/nWxxJDRnYzOj7+ncOaTTPzXqoAWhOFJ
         w4E057TaRgnwC32m4eVeN3Mu79e+a0BGIQeXmwktZBfy2pV929E9uysSB/2kZ3Kb5Of0
         R1eSe9DOLPTlW8wLymVXC4Uuv0z4IlIT6EHinNerZGhAMsgnSu4qG/HLOnwII1dWkZGN
         HrE2a7+qutkPGQntR2vDKzyCn8zDOnndDhAOaDwjqmEjGcAjJed4YBCPDP/GNYOlIPZV
         e7rECcKf1n6ix8nMzLHorJMajHN8HIaQZF+VFHhKrITlS14Tau5uOJLwfu2zltCMdS35
         aSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606597; x=1795211397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA1qyfllAf+v5Ejm5ZH1kCG25GG0E8C1nb+645hahNw=;
        b=0kuQkaid0m+LT5WBMfcFRHa92c0MrQKObe7WHuBdsSF3qCg9FULCjgXQkLgHHVzf2K
         wVhISzHabav3iv0gpDpWpHeNP0keSPY/snrWDtCRkjRL9ctkpXbra/wm+HWnN4YAMObC
         39Jw3ZqU7EG6sXsm+B8a74tPKTG2UHeV5T1CJbnaXEwGgEs2zL0Debaw3ux4S+awZVcp
         1A+GwqZAvTmAv5oPz0Efcmf2+pjJjhwvSjTv2kt2GvCA4HP4nSnPUMmsogzreiiL7iF/
         Qqo/q3KvJeEnJ3SVJXG+utB7KeHBdMwnyKETG+BSJHQ6NIwE3CH+HME7crMtuVasFXBd
         JB/g==
X-Forwarded-Encrypted: i=1; AL+hErEf89smWFXBnaMdoXGP9fk4ZMwCMoAcyiE4I1EphEIHMtXExUKQKtnxI9qAeWW0PN97VpRaeAbfNB4rK8J2x6yY@vger.kernel.org
X-Gm-Message-State: APuU4Z/j43ZSbui8qHubo4+/m67pIwnZpndtCm95f/2giNp3k2jnTGAL
	JvpJyrx3RhXC2PupPGEMFLMrxxGVLjrDebxGMzQB7bJRkjeS1bmgX1v9Q4CmDmtTox7J6bXqYOb
	floqDqVJCCw==
X-Received: from dlef5.prod.google.com ([2002:a05:7022:b0c5:b0:1b2:3e9d:97df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea56:10b0:1b3:aceb:b8dd
 with SMTP id a92af1059eb24-1b50317aa00mr3754089c88.38.1794606596491; Fri, 13
 Nov 2026 13:49:56 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:41 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-18-irogers@google.com>
Subject: [PATCH v1 17/26] perf hwmon_pmu: Use generic hashmap for hwmon events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert hwmon_pmu::events in util/hwmon_pmu.c to
DECLARE_HASHMAP(hwmon_pmu_events_map, long, struct hwmon_pmu_event_value *)
and use hashmap__for_each{,_safe}().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 57 +++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index c150fc0d7bd3..95049f5fead3 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -101,9 +101,12 @@ static const char *const hwmon_units[HWMON_TYPE_MAX] = {
 	"'C",  /* temp */
 };
 
+struct hwmon_pmu_event_value;
+DECLARE_HASHMAP(hwmon_pmu_events_map, long, struct hwmon_pmu_event_value *);
+
 struct hwmon_pmu {
 	struct perf_pmu pmu;
-	struct hashmap events;
+	struct hwmon_pmu_events_map events;
 	char *hwmon_dir;
 };
 
@@ -237,8 +240,8 @@ static void fix_name(char *p)
 static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 {
 	int err = 0;
-	struct hashmap_entry *cur, *tmp;
-	size_t bkt;
+	long key_val;
+	struct hwmon_pmu_event_value *value;
 	struct io_dirent64 *ent;
 	struct io_dir dir;
 
@@ -257,7 +260,6 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 		enum hwmon_item item;
 		bool alarm;
 		union hwmon_pmu_event_key key = { .type_and_num = 0 };
-		struct hwmon_pmu_event_value *value;
 
 		if (ent->d_type != DT_REG)
 			continue;
@@ -324,16 +326,15 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 	if (hashmap__size(&pmu->events) == 0)
 		pr_debug2("hwmon_pmu: %s has no events\n", pmu->pmu.name);
 
-	hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
+	hashmap__for_each_safe(&pmu->events, key_val, value) {
 		union hwmon_pmu_event_key key = {
-			.type_and_num = cur->key,
+			.type_and_num = key_val,
 		};
-		struct hwmon_pmu_event_value *value = cur->pvalue;
 
 		if (!test_bit(HWMON_ITEM_INPUT, value->items)) {
 			pr_debug("hwmon_pmu: %s removing event '%s%d' that has no input file\n",
 				pmu->pmu.name, hwmon_type_strs[key.type], key.num);
-			hashmap__delete(&pmu->events, key.type_and_num, &key, &value);
+			hashmap__delete(&pmu->events, key_val, NULL, NULL);
 			zfree(&value->label);
 			zfree(&value->name);
 			free(value);
@@ -397,12 +398,10 @@ struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 void hwmon_pmu__exit(struct perf_pmu *pmu)
 {
 	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
-	struct hashmap_entry *cur, *tmp;
-	size_t bkt;
-
-	hashmap__for_each_entry_safe((&hwm->events), cur, tmp, bkt) {
-		struct hwmon_pmu_event_value *value = cur->pvalue;
+	long key;
+	struct hwmon_pmu_event_value *value;
 
+	hashmap__for_each_safe(&hwm->events, key, value) {
 		zfree(&value->label);
 		zfree(&value->name);
 		free(value);
@@ -463,13 +462,13 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
 {
 	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
-	struct hashmap_entry *cur;
-	size_t bkt;
+	long key_val;
+	struct hwmon_pmu_event_value *value;
 
 	if (hwmon_pmu__read_events(hwm))
 		return false;
 
-	hashmap__for_each_entry((&hwm->events), cur, bkt) {
+	hashmap__for_each(&hwm->events, key_val, value) {
 		static const char *const hwmon_scale_units[HWMON_TYPE_MAX] = {
 			NULL,
 			"0.001V", /* cpu */
@@ -500,9 +499,8 @@ int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callb
 		char desc_buf[256];
 		char encoding_buf[128];
 		union hwmon_pmu_event_key key = {
-			.type_and_num = cur->key,
+			.type_and_num = key_val,
 		};
-		struct hwmon_pmu_event_value *value = cur->pvalue;
 		struct pmu_event_info info = {
 			.pmu = pmu,
 			.name = value->name,
@@ -537,7 +535,7 @@ int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callb
 						key, value->alarm_items, /*is_alarm=*/true);
 
 		snprintf(encoding_buf, sizeof(encoding_buf), "%s/config=0x%lx/",
-			 pmu->name, cur->key);
+			 pmu->name, key_val);
 
 		ret = cb(state, &info);
 		if (ret)
@@ -560,8 +558,8 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
 	enum hwmon_type type;
 	int number;
 	union hwmon_pmu_event_key key = { .type_and_num = 0 };
-	struct hashmap_entry *cur;
-	size_t bkt;
+	long key_val;
+	struct hwmon_pmu_event_value *value;
 
 	if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
 		return false;
@@ -571,15 +569,13 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
 
 	key.type = type;
 	key.num = number;
-	if (hashmap__find(&hwm->events, key.type_and_num, /*value=*/NULL))
+	if (hashmap__find(&hwm->events, key.type_and_num, /*value_ptr=*/NULL))
 		return true;
 	if (key.num != -1)
 		return false;
 	/* Item is of form <type>_ which means we should match <type>_<label>. */
-	hashmap__for_each_entry((&hwm->events), cur, bkt) {
-		struct hwmon_pmu_event_value *value = cur->pvalue;
-
-		key.type_and_num = cur->key;
+	hashmap__for_each(&hwm->events, key_val, value) {
+		key.type_and_num = key_val;
 		if (key.type == type && value->name && !strcasecmp(name, value->name))
 			return true;
 	}
@@ -602,15 +598,14 @@ static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
 				 * Item is of form <type>_ which means we should
 				 * match <type>_<label>.
 				 */
-				struct hashmap_entry *cur;
-				size_t bkt;
+				long key_val;
+				struct hwmon_pmu_event_value *value;
 
 				attr->config = 0;
-				hashmap__for_each_entry((&hwm->events), cur, bkt) {
+				hashmap__for_each(&hwm->events, key_val, value) {
 					union hwmon_pmu_event_key key = {
-						.type_and_num = cur->key,
+						.type_and_num = key_val,
 					};
-					struct hwmon_pmu_event_value *value = cur->pvalue;
 
 					if (key.type == type && value->name &&
 					    !strcasecmp(term->config, value->name)) {
-- 
2.56.1.703.gf848ed807c-goog

