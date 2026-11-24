Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548568;
	b=KhH5/xdsGxKCACxf61cRx7X+I6yhFQGIncArmcWqRl0pVyfTXtbObbiDGFLreHNMyDC2
	 loRhptgnRRLSlaZwIskgMvomE4l2dUWg/wPn7ctJ1O0a03nZ93AXmeWfyRLwmS5e6E0a0
	 mV1CHxe92RMHScct6JFCkiyF3HR17sbgyvahzfst8Hr8dLdGx68Ks1+a6Ari3i0zAQi4u
	 OFvYlfkYPmH5Ko3+Inkgdg0XQlCxG1MkGtjfoAadwkvdHolLOX345YSZfXmgpVE+uVCgj
	 lB1wA40D+zpt3UwAj6+J6xxfU126F1GErRuP0HOk/GXyOfLUlj/vVlCWbKH70wnWiyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548568;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Jy1neylt+cp4YTrEG01gzCHBY/dd4h8FGy6qmg6zPOA=;
	b=T5RS8/MFIXti7vnoYUExJo8Rotxl/qn5hhP083EnzabkHtCcRNW39opPBg8MnXZ8bK1R
	 /opjmjICHLimJePECfvhWWO8ZyhfbFoapZw3oea4vw4d+/OU0bKgAE/WN6MST4w1t/55r
	 Jae2VQTn6OgA7fNgXYNKpQXStRLYFXnBJum7+qdXKCzhBUbW0sA1e6EAXWW/hcSqksSz6
	 LZfNBBd+mSZcC7eEOSZszUUGYMW/vCt6eEhX4DovzkGsDJBZ6JTJB9MBD4F3eGQ38+R3o
	 EwvEPHuCr1Wb9rRrkrR40ZF472NvcztI1Oc8dZsNIkQgUY2d9dpd6N71S1Lej3M0V6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2VknBrI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169D606A68C;
	Tue, 24 Nov 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2VknBrI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795548568;
	b=0/WrPEbjEw5zxBVpAlT+KAIww+D0ovH7SzbXEs2hJ48XgxSh+ZARidwBnfKpO6m1guod
	 agOXRV0QTnSmtOBFiOkbV4LoM7KdkGDdtgO56+8UiG2mWkfwBQS9L80orlPO4WuthVGTD
	 F9g7aeFrZk9VNGqxzZ3WyWVC9/Srmp771ABc6zf4iQxdaIi2YvRw15fQq4HTDN5/HnGK0
	 eDZ0M1ZoVUSBXKt8tU3HsTWJ3LxTmHFll9iGc7Bp1sFtR6RPn+kyS8DqYQzbOQortz9e5
	 fCHRpxxner1fF0hRzF0a3ng3VqkjSc3P7WBOO9HRt4GzVor16YVZZGZ6yoJmQ+TArfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795548568;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Jy1neylt+cp4YTrEG01gzCHBY/dd4h8FGy6qmg6zPOA=;
	b=ICbIhuas9H5LfRenyczPeUFprJ43m/dyowdD0ZXf2dtMenzmQRTH/Zj1uVwjHwpMANWS
	 85MqW8zql2MJuBXCB+ViIAOJWXQj81bIL2rZ+KJbC/aBb+QHJ6gSXvUnfF9HCLIqR8A2S
	 8YwWN8q0+81YmLuIXSyc0PvJxSLmA0AkDyKaTAiCKyC4sB1cjhPju64uxbhGDYgUzdDfn
	 ipaOIeESF+bwAyWWMbh7TR1vVdM0Dtx7Qg99lTLb4iARWV3F4xRB7NormY9UKFJSBidgz
	 AeGgUTnx7zrXQyqWCmO24DrWrzmIayKDchXIxQM7kthT4Js3o++J8rUnOA8HtoszkLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D07841F000D0;
	Tue, 24 Nov 2026 19:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795548568;
	bh=Jy1neylt+cp4YTrEG01gzCHBY/dd4h8FGy6qmg6zPOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l2VknBrIyjMYwzc1m+reNohre/dhdv37RbXywO3vqwUoZM6fiK3NktRUU1gee8EWQ
	 tJhg4WH8CW4eh1/yIt7ewnlbQeYIBoV3wH34s4qn1/y3LI3XgRBZzFeiKZKnB9AM5n
	 As1AfkJV2Ki62cygSsQZP57tT/SjOVlQmFUahp52hHp6mPVW3lgGs+TybZ2UzKRG96
	 rGwLrHqdP88gLlc19Qs3fDT9FuMtCHUaImyISxAxTN9dv7asaV2Wo+qqF5ScqM2lZe
	 Hhym8s2+/+gdhTIxa5cOw6OjjN27xjYGanZRjM3G/2rV53Cz8pF6+j+pSU1nLlY/Ex
	 LBsI3qhpdWPbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 54E8E4CB75;
	Tue, 24 Nov 2026 19:29:12 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Tue, 24 Nov 2026 11:28:28 -0800
Subject: [PATCH v9 5/7] perf report/top: Add --lazy-load-symbols
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-perf-symbol-memory-send-v9-5-56f298185eae@uber.com>
References: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
In-Reply-To: <20261124-perf-symbol-memory-send-v9-0-56f298185eae@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4380; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=ppNlZ3VOcLClwa+EW9IutebfWNly9+u9DmMSRGXy758=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrBeWGZh4iQF23SP/Y42mypuFVMFz9EAybh/V5y
 hjctM41xl6JAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawXlhhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtizlw/+O2YceLqSGMpr4EXoCF1/P86+mBZY3AE
 4c7ar5wUoEjUVE6ghOGrlA+GIEZWtixn6jYxnWVKEIBq+6sB/V9WonqZ0G3O90SMKCKF3PJkG5b
 8mJSS6m9AyqN48PPeQyGyZsUs/FzpH9FQDiDCBCkpPEPvT/8aE6Fv1lhWBB+AYT/53u/53b3nRD
 jFYr+YILHh/EQu/bfUcKLqA8zS/XzE8yClE/0dvX/aUqh0v8hJubeaJl+Ku25GP+99fYi5hSIMB
 MeNFEXdbidsYmbBg1HYmnTB/F2qd2mM4eWSsOaratdB42RmXRBDxySF6Jy/idO6803UXd3U9SDx
 jlQbJTte8r03r3IsBfvFhRw3DnwYkn2KWGnZTvKBN8TlTrxKi6ZOXJkRq2Ixv35rxBFWtF85nz2
 V4TSyegQqUIQzfQvw3Rxilol7g+xS5UHYVcchF5vLaziGpewi2OYLP8zZ4mS1+jfyNh2ZzmkK/0
 Bs8t6AokLhZAL9vlzVqXvcOidEhfe0EhXemVa9tDtppc2HK6l9GKGMpB9rt/atlkXgLXWTfzl7y
 xluLmf7lnp+krOYS+Z2PWKcEFjtNKtpCnJDBWGbr/3DFhjOjJV+L6TKSNppULp1bQeAVN93+MlW
 yb8UIBeE3ek+pcSIEleyVUaVymzz3MF6vHWl634IalBc35mjdz+o=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch adds the --lazy-load-symbols option of perf script to perf
report and perf top. Like perf script, they load the whole symbol table
of every DSO that appears in a sample and keep every name until exit.

The symbol code already handles both tools. The address lookups that
build the histogram entries and call chains load the names of the
symbols they return, and the TUI map browser gets all names from
dso__named_symbols().

perf top reads the names while it runs, which can be long, so a binary
that is updated in the meantime can show wrong names. The documentation
of perf top says so.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/Documentation/perf-report.txt |  9 +++++++++
 tools/perf/Documentation/perf-top.txt    | 10 ++++++++++
 tools/perf/builtin-report.c              |  2 ++
 tools/perf/builtin-top.c                 |  2 ++
 4 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index e145124d6c9a..b8c34bb4cd74 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -347,6 +347,15 @@ OPTIONS
 
 	Default: 127
 
+--lazy-load-symbols::
+	Read and demangle userspace ELF symbol names only when perf needs
+	them. By default, perf reads every symbol name from each binary
+	referenced by a sample. This option reduces memory use when samples
+	reference only a small fraction of a large binary's symbols. The
+	names are read from the binaries while perf report runs, so the
+	binaries must not change in the meantime. If a binary cannot be
+	opened when a name is needed, perf shows that symbol as unknown.
+
 -G::
 --inverted::
         alias for inverted caller based call graph.
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index c5e96da6ed82..9ec039c8e0b9 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -218,6 +218,16 @@ Default is to monitor all CPUS.
 
 	Default: /proc/sys/kernel/perf_event_max_stack when present, 127 otherwise.
 
+--lazy-load-symbols::
+	Read and demangle userspace ELF symbol names only when perf needs
+	them. By default, perf reads every symbol name from each binary
+	referenced by a sample. This option reduces memory use when samples
+	reference only a small fraction of a large binary's symbols. The
+	names are read from the binaries while perf top runs, so a binary
+	that is updated in the meantime can show wrong names. If a binary
+	cannot be opened when a name is needed, perf shows that symbol as
+	unknown.
+
 --ignore-callees=<regex>::
         Ignore callees of the function(s) matching the given regex.
         This has the effect of collecting the callers of each such
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6672a4d16529..8ca54463a84b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1414,6 +1414,8 @@ int cmd_report(int argc, const char **argv)
 		    "Set the maximum stack depth when parsing the callchain, "
 		    "anything beyond the specified depth will be ignored. "
 		    "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbols,
+		    "Read symbol names only when they are needed"),
 	OPT_BOOLEAN('G', "inverted", &report.inverted_callchain,
 		    "alias for inverted call graph"),
 	OPT_CALLBACK(0, "ignore-callees", NULL, "regex",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a79230b81300..02363e5c6460 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1589,6 +1589,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_INTEGER(0, "max-stack", &top.max_stack,
 		    "Set the maximum stack depth when parsing the callchain. "
 		    "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "lazy-load-symbols", &symbol_conf.lazy_load_symbols,
+		    "Read symbol names only when they are needed"),
 	OPT_CALLBACK(0, "ignore-callees", NULL, "regex",
 		   "ignore callees of these functions in call graphs",
 		   report_parse_ignore_callees_opt),

-- 
Git-157)


