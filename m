Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941379;
	b=IEy82OVj1xbho5UhD8rAInm4XPKqFgp/7l4aN8UI+i+hvDI9/izRDnQzngTu5zAM7i0d
	 qb7siR9Ylve7jYCZ3yZ8QjMSVWFMR4fq5sVusLzKEtwth/AosRHfhnYHEvy3abcl2Wa0B
	 7qSIaND5Uvm/gOTw7PrytjiEbq/R+zUiX64ZSsfAOLM398sj2yW8HUit/3jui23tIUZuA
	 mQXYbc1zRndMMyYghURj9cJ4YU3urPlTRmW5MYP/Oa5LU7LABPyDbfe8txSo5BCtURLbN
	 40Zj29cs4g+NRutzpKjlzms92G1WEjwjuA0asRe2vegvuGf/gS+hpjHPvFl0+ZrXVGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+CtJcrEtN9eDgrldMUwlTf29GauoIVdfb5xQnIMdbpo=;
	b=UWDczQtT0v/2KTfo4BpL5DEHcyd7cFy4bxqtieqeOk1Aq//n6EunUHFEb56pqiP0kI7/
	 dmOV2XuLHbx3MU+zcJ+T2MmgnXRGlH/KELn/6pebEV9exokEPpdIvoEEKZe6Fc0ucyk6X
	 3rraYwW17AKiw0I1j2bk7Mz5Kqy38u9yCQCuUIhN3b9Qpyu0rY7VdWu3kuAJBNgPNZyrS
	 1JfAMHIypyiTQ/mgQI1s5QbPtTRTyROKvN6ThnFQpT390OHCw0vLBDqskB1/byCtS32rk
	 SZ/gHVLowxLdPORHYmJTouKpMnwgQBm+Q5hC1WaXPeDZKZNRu6p7oUASEhVn2l3J9Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XYWVXm7B;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F7606A8B5
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03F7606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XYWVXm7B
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b238436265so110537c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941378; x=1795546178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CtJcrEtN9eDgrldMUwlTf29GauoIVdfb5xQnIMdbpo=;
        b=XYWVXm7BfYl3oYYyy7eQKsE/dQUojBu9YQ1nWL9s8UHpNKIIhIesbTkDpRErsHQu7P
         QtVAAlm/rykrYinvE5aTi5UlftUhdUPHbhwdqEIJ+mbqewXPpUXvM+Zk1aRtOuYWMET8
         ub0cOy6XBO9O0DSrD/qpgZKgw3E7QK0vrgmsw3iCBFhdO6AKh5Prhry3uodaksfzuOe+
         o0EjaoJM31MQY9hyzyBqyPwPjzKj9q9aR+xC5R7PPSaMh0qvyBhp+eezN4yhMTFNBie+
         D4pI+nzTDC63i8sxi9k6cJouKR70qUWIpGgClR7yef6SOBt0fLnXDl6SfDAr2/0nb2RP
         vd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941378; x=1795546178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CtJcrEtN9eDgrldMUwlTf29GauoIVdfb5xQnIMdbpo=;
        b=oj9IitmNkq9mDjxKR/VnWmrIdfVVvoF2DN9oEy9ZOCsxYeMfB9NeGLp2bLevJPYMxm
         C0ga27tApk4lMDU74J3swh7NItdsFS3OkLosACiqP+gzib9B1kNqybmBR8Wv1yoK6AYg
         7UK96upZAn/K4PUK7BnJCqfCIZxk68+WzTENUonGROE0ov+LG15sSRF9IQlvFHi0+iXg
         G39uP8MkJGyHAd3MqVKy400+RWNWkTixDH9B2gKPhHt4YhPs9Cjt2VnBi03FJAZUU8yZ
         mWvP2FssJd7ZKaK+n41UhwS81+Lf56yGJ5FsapigzrC142GvfDvR1QNmGXxVFfFPlBH7
         GivQ==
X-Forwarded-Encrypted: i=1; AL+hErHJW61MQCuT1Z0GJr7lQ4CfSPFA/CT4QdR039grqEDCUvpshse5zutQePvdx61vvjaKjrLkGrESWZ1dcBYis90K@vger.kernel.org
X-Gm-Message-State: APuU4Z+nP1MigICNJnME5ZMEwXpTeGGjIh/ep0/uSThGY27UpBEOXerI
	Ukzq3JqIfpC0QW5OXVwL20xGfsn4sydm+ayfo08qerqaXD3r0/auy5d/uDebp4/N95pA+aUEbQQ
	EXLYXb1wY5w==
X-Received: from dlbef6.prod.google.com ([2002:a05:7022:f46:b0:1b2:6c20:7e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:ccce:10b0:1af:16c4:d06b
 with SMTP id a92af1059eb24-1b543cb50c5mr349354c88.10.1794941377630; Tue, 17
 Nov 2026 10:49:37 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:38 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-18-irogers@google.com>
Subject: [PATCH v14 17/23] perf config: Add __guarded_by and __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add __guarded_by() and __must_hold() annotations to static parser and
config state in util/config.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/config.c | 47 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 287401f159e6..0e6b77a0a5e7 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -64,15 +64,29 @@ struct perf_stat_config stat_config = {
 
 char buildid_dir[MAXPATHLEN]; /* root dir for buildid, binary cache */
 
-static FILE *config_file;
-static const char *config_file_name;
-static int config_linenr;
-static int config_file_eof;
-static struct perf_config_set *config_set;
+/* Parsing and rewriting share the static parser state. */
+static DEFINE_MUTEX(config_mutex);
+
+/* Serializes whole perf_config__set_variable() updates. */
+static DEFINE_MUTEX(config_update_mutex);
+
+/*
+ * Protects the global config_set. Separate from config_mutex because
+ * initializing config_set parses the config files, which acquires
+ * config_mutex.
+ */
+static DEFINE_MUTEX(config_set_mutex);
+
+static FILE *config_file __guarded_by(&config_mutex);
+static const char *config_file_name __guarded_by(&config_mutex);
+static int config_linenr __guarded_by(&config_mutex);
+static int config_file_eof __guarded_by(&config_mutex);
+static struct perf_config_set *config_set __guarded_by(&config_set_mutex);
 
 const char *config_exclusive_filename;
 
 static int get_next_char(void)
+	__must_hold(&config_mutex)
 {
 	int c;
 	FILE *f;
@@ -99,8 +113,9 @@ static int get_next_char(void)
 }
 
 static char *parse_value(void)
+	__must_hold(&config_mutex)
 {
-	static char value[1024];
+	static char value[1024] __guarded_by(&config_mutex);
 	int quote = 0, comment = 0, space = 0;
 	size_t len = 0;
 
@@ -170,6 +185,7 @@ static inline int iskeychar(int c)
 }
 
 static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
+	__must_hold(&config_mutex)
 {
 	int c;
 	char *value;
@@ -201,6 +217,7 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
 }
 
 static int get_extended_base_var(char *name, int baselen, int c)
+	__must_hold(&config_mutex)
 {
 	do {
 		if (c == '\n')
@@ -237,6 +254,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
 }
 
 static int get_base_var(char *name)
+	__must_hold(&config_mutex)
 {
 	int baselen = 0;
 
@@ -257,10 +275,11 @@ static int get_base_var(char *name)
 }
 
 static int perf_parse_file(config_fn_t fn, void *data)
+	__must_hold(&config_mutex)
 {
 	int comment = 0;
 	int baselen = 0;
-	static char var[MAXNAME];
+	static char var[MAXNAME] __guarded_by(&config_mutex);
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
@@ -549,12 +568,6 @@ int perf_default_config(const char *var, const char *value,
 	return 0;
 }
 
-/* Parsing and rewriting share the static parser state. */
-static DEFINE_MUTEX(config_mutex);
-
-/* Serializes whole perf_config__set_variable() updates. */
-static DEFINE_MUTEX(config_update_mutex);
-
 static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
@@ -737,6 +750,7 @@ static int set_value(struct perf_config_item *item, const char *value)
 
 static int collect_config(const char *var, const char *value,
 			  void *perf_config_set)
+	__must_hold(&config_mutex)
 {
 	int ret = -1;
 	char *ptr, *key;
@@ -853,11 +867,8 @@ struct perf_config_set *perf_config_set__load_file(const char *file)
 	return set;
 }
 
-/* Not config_mutex: building the set parses the config files, which takes it. */
-static DEFINE_MUTEX(config_set_mutex);
-
-/* Called with config_set_mutex held. */
 static int perf_config__init(void)
+	__must_hold(&config_set_mutex)
 {
 	if (config_set == NULL)
 		config_set = perf_config_set__new();
@@ -975,7 +986,7 @@ int perf_config__set_variable(const char *var, const char *value)
 
 	/* Static: the parser publishes it as config_file_name. */
 	{
-		static char path[PATH_MAX];
+		static char path[PATH_MAX] __guarded_by(&config_update_mutex);
 		char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
 
 		config_filename = config_exclusive_filename ?: user_config;
-- 
2.56.1.703.gf848ed807c-goog

