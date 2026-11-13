Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588156;
	b=s8PvoQDSvuFlPz1laHHVtByEFFztmFXgPz3ddl0aqZPcpbAPfo6KGvB5d6Ophp9F3OHF
	 Y+df2yaJ/EU87SiJJnQEwNUf/PW0bwEkklLZD1CD9yGBY/UhyqCJmdN9VzutPl51oo/dG
	 /0Vd1iOBdhsLSq5w5yP1sqtXsTfmSRXPc1FEesEJPsFc7HHWET83v52kKBUsE+iRd7RoB
	 61Wkyq9WlN8RxoKobDLjEFEgDlFuG48GtvuorDFxU09cnnNZ5iraUq8Wf/tqfIDwUQs/h
	 MxOTFZ6I91ODvrT8IZg+BF49WrCj5qqOSfqXktjVL5UXtgFDavPqBtrUdhvtxtM8Mow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+CtJcrEtN9eDgrldMUwlTf29GauoIVdfb5xQnIMdbpo=;
	b=m3am5SJSyfUD2fWZnRxA0heYxGgXhyR9eq55yrD1C8a72iC84D9tBg17blA0cqXGjrBi
	 O6eV6sYLsvZXlBNg3RkxJPD3uK7cY8IEH/oL7K62Fh/I+AMSE7Jh2R3Swd0EAnC+TiEwf
	 kLhP5VUwGKiVgTXGguiAPXBKygeTnq9VQX+qNCMBPQuGVJJz9cR14J5NVovDDbF3BGRed
	 8d87IiUy/FEIT+8S0cNKkZcRwVWcKO08AbtVTjUhA37nLEUiMEz+BD8GEX/uJ50dl2xqj
	 Q5pczVTv//acDDB99MZf6GgTDyt1Rxe+DbF0bSVnxyhvrRxwBM8J4BRVITSJF3AjcUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lX1+txxn;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1A60A263E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A1A60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lX1+txxn
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso5155890eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588155; x=1795192955; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CtJcrEtN9eDgrldMUwlTf29GauoIVdfb5xQnIMdbpo=;
        b=lX1+txxnb/lLy3onI+QYS5gW63/Eg7pZ/GmJH6L9aAdO3XWRb2jT6LoIcQ4eRSgfoJ
         InLvOhychEuCB3ZCTCl7LUcJ5uzInuh+ZU6duO3cQuRCKrB70l4EwazLH4YIgcHmdu2x
         8YBGkihmhM3kyJhS47G+QYmVINj2RSqvJAEX/T5t13alJJ9eWnLVpERRp9ngzoEt4TWQ
         WRmRZM4m36OgJJFMJHq9yoi8235J3tkT6e3HRuHdXI6uYlzMe0hcdG7qK75K+Mux0bQi
         5sENdgXck/1sO9YLx0VXnl7+H4XHlGmpkkWO8+dujgAiGCZJP5ZgYMLy5jdqfLyobcp3
         LtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588155; x=1795192955;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CtJcrEtN9eDgrldMUwlTf29GauoIVdfb5xQnIMdbpo=;
        b=WgGuK2DBj3edXZfUJAnHPKtk5QwN3R/LEc0MLKxFKsegSXrdDK2FKJKepSfqPtVTbF
         9b0zvhLsL2a2xqqfSYLGyCgAapK6QvOu5G+6z3/nf1M/K3U9kT3TZe5yvEuTtF3x4qVz
         acYksNLpj3/s7cLLRrg2X35B0mrbR6o2mfI8anUUGj+eZcpAsIyA7CKDnXGEqpnVCrOo
         YRCdt1SBQG20hynY5M3qKoJgHVYxqSPQE8qtQC4K2jSpRDg7C19mYLcpNCNDSfTyc6XC
         IozHchHchnu9PYG5i4FwF1B/r/Ok0acPiycyKBNJW/GQtvJ4zgGcruZfQIbNGQIZkfMO
         VYLQ==
X-Forwarded-Encrypted: i=1; AL+hErETqgtfFdauW7t5oUYn4SZ8nspopxmuUOjeOdMnAuT7K1zXwmWJzGL3mtRTMyNLVyAEKcYhPWN51HW5U9ehCQoS@vger.kernel.org
X-Gm-Message-State: APuU4Z+/akddOE2hiwUg0Y92OWA6z3/6YtFwaVysJ4JWedKWuZoclMLZ
	UWLOX6y0fwvKbcvebGLej+xOMMd8ESqKltW+CQnwG6TFfd8c82TTlcbWwcA1IYC0ZXeqlE8VVFT
	lhhsenidlBQ==
X-Received: from dybou11.prod.google.com ([2002:a05:7300:e5cb:b0:369:68b5:ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7a01:b0:376:5b99:a816
 with SMTP id 5a478bee46e88-3796395425cmr2784047eec.3.1794588154664; Fri, 13
 Nov 2026 08:42:34 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:48 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-18-irogers@google.com>
Subject: [PATCH v13 17/21] perf config: Add __guarded_by and __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
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

