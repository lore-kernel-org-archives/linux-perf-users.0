Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B98131E5C
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833232; cv=none; b=X/NiLI17MDrVs+31L/OLkoX/hQhlHenKHROwTADtvjQFtM6BpWtyrg9GnruxYPhJ/u3USDugUkk7r34hMj1C2c4g0HwUwqhL1QgUcOj6fXDYhOWLaSdwc6IDIvtK5lDqBKUzPz4VA61cw3JDjFNsFOQ2XMUfEh8R1cA9LdTla38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833232; c=relaxed/simple;
	bh=FRTaxqQ9z0fdBOTvorH6lKFlBCFvX2RUJshMGjEelbw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JSnJElB/PwHHYOl2KAZ1CDJK80V6rv4aFSUOUSb0LBNgHcqRC7IyWTHUsMPPcwkgWsUExfoWIiX/z2ZBSo7JAVegC+B5jm69t2DJJLdLIH+aRauEGvY4RGbY2Dn8r7m1pvLzZ7qId8Aan+ojdj/d8+kHIFwLPUPUTZH1vvgNkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tykL8nx3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tykL8nx3"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e4171382so18079297b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833230; x=1710438030; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=tykL8nx3Lxmlbhg/ZCcq5S1PjFn+xnzTOXsN60VZEC9SuTp5pVRQNfLi6hT60+W+u+
         Qoa39y4717dnKRSLIieopMSabY8/VcAmEu1V+RCX0v+rI5Mcd5o/wy8VrycR0ct1ST9/
         9S0pJhhnKjMh3tlWPPzDYs3uujPnThhlTUYjweLGmNI992lh5AWgagOh6/CtNfivkcvl
         l7YjTe85okN32csOLud2/XOIpLQeH8/s30T7aUkx06aU+L0tEBskYWtmM4kTijPCESc1
         boIXM8cBgjpxzf+SzWnSlZ0ZsSxj+jOVz4theRY7TwdfvWQodQ2enq2T6SYoab+QGONE
         c/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833230; x=1710438030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=MCrnkDCylx25NmG3VF56Eay+1t++hty+Lp8ckAYbBtCkkNf9z4UaHZ4AC4ckAdLFZr
         DQnHzycMOOFe+O18KfYB4miuJZc4yN/NEah18ZGwOuVoOo9H4ysqhWDdSE3Q1OgP3tHF
         cnev13NCutNdmQ6oMTAYKDwqdjUi6YI5LZ01K1Nnhjx0X4d970I1KITg5pwAZ0BbbUBg
         VRp8SF8rGzWS2/n9yeMe5v7GvSecvi92PqXwkbeo8MeeqlxMUSkJL3kvHJKY32Ftfe8z
         Lsk2trz2aPQgqjW0prJyHQiw3X0Xw7HQ889Xq5J+cLrP8j+aqZJ9DAXp7AsyRz86e4hg
         mPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWSRVjoeQYmsG6/tOtTInFYBamuVPbEcUlBmPz86gzeUAH9CS4eLgv7vOVe+QbSdAF8i0Lt9kptOdj1RmBGVtDbbeky8Va7R16wYQFakI2K7g==
X-Gm-Message-State: AOJu0Yzi09hqN2Ng3zMc7LbFREtOazHT1Hq0mwPJZ17vjRaR3lAmZUko
	MMOzwCu0RjbAfIkf0wr3d1Wx8bi3a5IpC20hu94se0aU9SZkYX2eS5gbTzM37RhK1e+YJdpt3kS
	j8+edUg==
X-Google-Smtp-Source: AGHT+IFsavMJluR8mAKN+8BZP435zJgd3jnYIlb4VLH0oAUuObBtrUSpcNLiEJF/6LxQU5VIFDyxCLzLZ+XX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a81:9945:0:b0:609:781f:a7ab with SMTP id
 q66-20020a819945000000b00609781fa7abmr4000841ywg.1.1709833229919; Thu, 07 Mar
 2024 09:40:29 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:52 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 3/6] perf list: Allow wordwrap to wrap on commas
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A raw event encoding may be a block with terms separated by commas. If
wrapping such a string it would be useful to break at the commas, so
add this ability to wordwrap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..e0fe3d178d63 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -22,6 +22,7 @@
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <linux/zalloc.h>
+#include <ctype.h>
 #include <stdarg.h>
 #include <stdio.h>
 
@@ -76,26 +77,38 @@ static void default_print_start(void *ps)
 
 static void default_print_end(void *print_state __maybe_unused) {}
 
+static const char *skip_spaces_or_commas(const char *str)
+{
+	while (isspace(*str) || *str == ',')
+		++str;
+	return str;
+}
+
 static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 {
 	int column = start;
 	int n;
 	bool saw_newline = false;
+	bool comma = false;
 
 	while (*s) {
-		int wlen = strcspn(s, " \t\n");
+		int wlen = strcspn(s, " ,\t\n");
+		const char *sep = comma ? "," : " ";
 
 		if ((column + wlen >= max && column > start) || saw_newline) {
-			fprintf(fp, "\n%*s", start, "");
+			fprintf(fp, comma ? ",\n%*s" : "\n%*s", start, "");
 			column = start + corr;
 		}
-		n = fprintf(fp, "%s%.*s", column > start ? " " : "", wlen, s);
+		if (column <= start)
+			sep = "";
+		n = fprintf(fp, "%s%.*s", sep, wlen, s);
 		if (n <= 0)
 			break;
 		saw_newline = s[wlen] == '\n';
 		s += wlen;
+		comma = s[0] == ',';
 		column += n;
-		s = skip_spaces(s);
+		s = skip_spaces_or_commas(s);
 	}
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog

