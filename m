Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244368;
	b=g75v7T9cqGVJULQCxhWMPCst1mWh5fyK+ypGa3Dfh+QYjgV3uiQpBztB4e21JO+kg5eE
	 NAnck/QG90VdrB3BMpUxOjhXqVSSU+LdroRXEez+mg8EuX+TCPTZhXQPJFEvvT1i3eJgT
	 SihWJ7CK8uYViK7bZnCAZys+3z0ohUbZgE7nn63dTCLmvq20ekUGW229+/OOLLEZ09knl
	 +wgDUpcTCK9eVxZjhlcITc1EbOliCPz/S3iZJ0OK88o13h7uZok+aZyaCkTzMAH9Y18N3
	 O9x9C0sPnbqX15ks+SU78k4swGbnbW50ac/xmkp/5GRb53bqA3GNDwzfsu2egf1pT7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RDCUlHefqFEbjMztOptVwPQT+i36K/1j1D4kqeoLikQ=;
	b=yIUjKzfS8yRuKwXZ5Q/cIs8xfVZ1i9sXT4q5kRwvB6sqIQWTyK9DkpVNaIpw8i2mEO/Y
	 HbM7g/0y6KYp4NixjIdyJuYt0TlWWxw1tmQqnlvmjiF1dQflZhw3uyzDhVVJ+wxoPpUGx
	 wy3DOy1YaC7tQGf+PT3qfNPrmQVWWIJcdfVSeJySf9C+5PBTzZtubM6loKPhr/IZvQ+nC
	 71BhwgtA9sqgHj00WeoXr9oSnlkfWQ0L1fS059zyd24lU+/ay5zryHaOezrE/ZKfQBCC0
	 kv4BCNutcJw6wIWWAmNg+tL0uba0zpzbhoTEifIQ30/AkwffjdaEXLIdM3UMT/U5Ahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AeGFF0ZK;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57367606A32A
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 06:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57367606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AeGFF0ZK
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2641283eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244366; x=1795849166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDCUlHefqFEbjMztOptVwPQT+i36K/1j1D4kqeoLikQ=;
        b=AeGFF0ZKbz1lnAaz1y7/AWjWr9GiAl4v/7MXQslv906MoFlVh8SK/fpEy1A8KY3Ft/
         bH6bE1nZ8It4VFgg6v7IRR7Qxr6PwRS+GWdbDkBG2KoUL2Ex/yxVVtkE35HFuqNPS93l
         9o/ySBCQJj982HhDtFJ8ORLS9v92h7lmsgPk4wkQYE7MEEaIxpaJlr0GBtSTm/hXjazS
         1LDoJr+r0ew4ZqP480X606btzWDVe7W+gX6O6cTMhxNRsnatpIaGF1IcB8m6ZogmMklB
         oLDAWJ3wrl666UIfFWzV69oQRzh1h90wdDtEdeT3YGKHo88jKdxM6JgMLJ5l1Wx5jWXz
         LlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244366; x=1795849166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDCUlHefqFEbjMztOptVwPQT+i36K/1j1D4kqeoLikQ=;
        b=vHChffMG2v3VFVUSA7TdFE9KAGpQDLxQpEFY6Qukj4+CT5AWYfaslyDOah2ju3j6zX
         kpIt+x25qaSnwZ7vknwqVBIn6vTNs1dohD7F3Lrb7+IxLQgikBDSf0pfc+e3KjfdZSl4
         nc9TVBeGHbPPCsrl//er4Ra5LFXdh2Xf32BRf5fB8WIt/jRrVoDJgX/dCzls2usPNKVd
         pnKh/fisqkpQXde+QSqmBfvoL1yGNn2+KwO6TFoxCMfLcrDbweCM2gL0Jnz3VhUCVWOf
         26TqKGiWANKgZWA2fenlKOt1igG/90XRTIvI3JblYJTDDRqVQtjCPUpCTqJpEx63lKxC
         EyQw==
X-Forwarded-Encrypted: i=1; AL+hErHcwd7nd48WhqpU6Xno6FXjDCwLIEI3yuAiYbKuaIwFZ1Thux5w3L2t68YPhsVoVC5GdcxqMo1dalpaskETCr26@vger.kernel.org
X-Gm-Message-State: APuU4Z9GOujpPnkJ/Z6Z1vl00Q+yGWNvrAHLPFcQwQsdahBek99Ulu8L
	qy6FhS0tm67Bwb4K0eZV1qbWYb251/y0ERH+FwL/3p4y4UJFvDMJh7pt/MBdw22mXsr74CHjXbD
	bDxZfNsPhng==
X-Received: from dybtt7.prod.google.com ([2002:a05:7300:f407:b0:369:f864:c5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d0a2:b0:384:df31:6a07
 with SMTP id 5a478bee46e88-3857073eeafmr5062590eec.30.1795244366178; Fri, 20
 Nov 2026 22:59:26 -0800 (PST)
Date: Fri, 20 Nov 2026 22:58:06 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-18-irogers@google.com>
Subject: [PATCH v15 17/23] perf config: Add __guarded_by and __must_hold annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
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
2.56.1.750.gf70dc682cf-goog

