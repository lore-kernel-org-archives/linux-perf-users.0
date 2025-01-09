Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB919306F
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445257; cv=none; b=sk15cqSHGLLdNhWm/zu18Evym4+Ud+Yt+ExsKTzbxViAAmkrpa2ADINlznR2yonvJIWySGGIToN/g0VVkBUqcEXOQ7on1JSqt3pajqk6NISRytRO+upccxhYUX1BYnFx7DC+BYY4zQEX5qZqQhciBwiwwwgNkcP6V3hRjmkO92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445257; c=relaxed/simple;
	bh=+B5cK4L/P/9DCZxic/K9keD7ba0KBVFqI40tiVaroy4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=uzhuCy+oj+bp4vAJm5e4IXYVsBCKRpRNcsU4iEXPkUfRtt1hppXER35g/svTAcU/MfIah8krOcNFUUN35un7r9d4Yo30/m/yWgXuFNjF6IDbPcnPz/rB4rVaZS58kCQLfWRpjp+y1V8wXpbnY3pVdE4sVyYGXM6Su0XGjxgW68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUwvB0k3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUwvB0k3"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso2741462276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736445253; x=1737050053; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z7r0dYrZLYKc4QlZbZNC2EaiF7lH3kg3YPkL/1XAtFg=;
        b=iUwvB0k3pdDlTcOxLPmlaRcfCUe6wv7frlPw476r1vmP+C9DspEckkjixDvqbw/VGU
         p2sjWx4fCrbdmvT1IqAQBtBKATVyu1ixmcPoQwSzE1J6QbYeGpQ7J0ll9krxVcf5O1W4
         P93VMH018w7JZN3phPnZTcg6sV2RIvK3ypN4+bPJz9aZNwNLC8CTBplFWfzT0W6fim4L
         F15IipAd6oZAGErw1+wUMjt4qabxLyS0J3szKsVBRrKUfXAPaAs2ukoMoo+OGqojvHS4
         9VOKhOmagctcwgDGbXdthcYHlLye0MGz/WrF3yNdKJSK4Yv/uXgneKgy1mXesYs8yiaq
         Ql9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736445253; x=1737050053;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7r0dYrZLYKc4QlZbZNC2EaiF7lH3kg3YPkL/1XAtFg=;
        b=W0e6Na9wxvNmbazNgYEK6XRyE6aXQkSvTbnJDaJl5reA8Mvc+k8TYQrHjbW0k2/EDQ
         KAS+AdQYpflJ/6IaY10oGzkpfYZnAy1zPcbBwjuBXg9y4VKLO2Wprt2IfG3cGnHXpyrq
         w7rho5WMpq8UEHigCypyV1Doiop2olo5GPC7FQRPms0DEWKcvCDrG/vErlF55FhP+Mhq
         T43ZLsWE5LiF1+q1YkafsiH7GvYMc0R9ikOviDWMCqjxMJg+sc7SxQb4WtpmsvbEhBJu
         Ox1kj5QeIvROiL0VIfr3HiVD7pLZ5PMgFJPArvbdwG17P8xNoSjDMr11djU3Q5Xpj7at
         zpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWInON4nBmPWBVUVs6O0kS2Q4sPHiY7ZA7TwmehKt6kTdk7+UBepXA7cW2Ll2NNKwkgCPR+xSuKkot9aUpfN8na@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgg7DyKjCwazEHHNyCw/80kmo3c+F6zyeVKE+Dy2nfvnkenKi
	1tBkOroN4NFjMtpvNnNtJSG6TnNRl/9p4VN5JzRpL1YIO0ikhLRQ2EWwKOe5rsm3RU/pyLYATx2
	wXf3dYQ==
X-Google-Smtp-Source: AGHT+IFqFkjJDa589DE0fYHZRiu00Yp48wFbZ0ExFKzuLBz/qtcsTyE/IXcrpSIB/VeOfdJyres4/mpVmrgK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:2085:0:b0:e3c:9f2c:707b with SMTP id
 3f1490d57ef6-e54edf1eaa9mr19861276.1.1736445253183; Thu, 09 Jan 2025 09:54:13
 -0800 (PST)
Date: Thu,  9 Jan 2025 09:54:01 -0800
Message-Id: <20250109175401.161340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf parse-events: Tidy name token matching
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
before parsing") names (generally event names) excluded hyphen (minus)
symbols as the formation of legacy names with hyphens was handled in
the yacc code. That commit allowed hyphens supposedly making
name_minus unnecessary. However, changing name_minus to name has
issues in the term config tokens as then name ends up having priority
over numbers and name allows matching numbers since commit
5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
"). It is also permissable for a name to match with a colon (':') in
it when its in a config term list. To address this rename name_minus
to term_name, make the pattern match name's except for the colon, add
number matching into the config term region with a higher priority
than name matching. This addresses an inconsistency and allows greater
matching for names inside of term lists, for example, they may start
with a number.

Rename name_tag to quoted_name and update comments and helper
functions to avoid str detecting quoted strings which was already done
by the lexer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.l | 51 +++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index bf7f73548605..7ed86e3e34e3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,21 +53,25 @@ static int str(yyscan_t scanner, int token)
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	if (text[0] != '\'') {
-		yylval->str = strdup(text);
-	} else {
-		/*
-		 * If a text tag specified on the command line
-		 * contains opening single quite ' then it is
-		 * expected that the tag ends with single quote
-		 * as well, like this:
-		 *     name=\'CPU_CLK_UNHALTED.THREAD:cmask=1\'
-		 * quotes need to be escaped to bypass shell
-		 * processing.
-		 */
-		yylval->str = strndup(&text[1], strlen(text) - 2);
-	}
+	yylval->str = strdup(text);
+	return token;
+}
+
+static int quoted_str(yyscan_t scanner, int token)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
 
+	/*
+	 * If a text tag specified on the command line
+	 * contains opening single quite ' then it is
+	 * expected that the tag ends with single quote
+	 * as well, like this:
+	 *     name=\'CPU_CLK_UNHALTED.THREAD:cmask=1\'
+	 * quotes need to be escaped to bypass shell
+	 * processing.
+	 */
+	yylval->str = strndup(&text[1], strlen(text) - 2);
 	return token;
 }
 
@@ -235,9 +239,16 @@ event		[^,{}/]+
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]{1,16}
 num_raw_hex	[a-fA-F0-9]{1,16}
-name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
-name_tag	[\'][a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
-name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
+/* Regular pattern to match the token PE_NAME. */
+name_start      [a-zA-Z0-9_*?\[\]]
+name		{name_start}[a-zA-Z0-9_*?.\[\]!\-]*
+/* PE_NAME token when inside a config term list, allows ':'. */
+term_name	{name_start}[a-zA-Z0-9_*?.\[\]!\-:]*
+/*
+ * PE_NAME token when quoted, allows ':,.='.
+ * Matches the RHS of terms like: name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'.
+ */
+quoted_name	[\']{name_start}[a-zA-Z0-9_*?.\[\]!\-:,\.=]*[\']
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /*
  * If you add a modifier you need to update check_modifier().
@@ -341,7 +352,9 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 {lc_type}			{ return lc_str(yyscanner, _parse_state); }
 {lc_type}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
 {lc_type}-{lc_op_result}-{lc_op_result}	{ return lc_str(yyscanner, _parse_state); }
-{name_minus}		{ return str(yyscanner, PE_NAME); }
+{num_dec}		{ return value(_parse_state, yyscanner, 10); }
+{num_hex}		{ return value(_parse_state, yyscanner, 16); }
+{term_name}		{ return str(yyscanner, PE_NAME); }
 @{drv_cfg_term}		{ return drv_str(yyscanner, PE_DRV_CFG_TERM); }
 }
 
@@ -410,7 +423,7 @@ r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 
 {modifier_event}	{ return modifiers(_parse_state, yyscanner); }
 {name}			{ return str(yyscanner, PE_NAME); }
-{name_tag}		{ return str(yyscanner, PE_NAME); }
+{quoted_name}		{ return quoted_str(yyscanner, PE_NAME); }
 "/"			{ BEGIN(config); return '/'; }
 ,			{ BEGIN(event); return ','; }
 :			{ return ':'; }
-- 
2.47.1.613.gc27f4b7a9f-goog

