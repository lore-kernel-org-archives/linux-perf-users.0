Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142063BF
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857184; cv=none; b=sWRZIe706upty31wt2OCAZ9muW/hZjBV5IKGV6QJxhOWEaD6c4sr+oBLMDpfTjw3NSQfoIb8p02G49M14IYMuCmmGE1G94qe+G3KMhHDPzwpx2XndgIT3qvcv2KuBKLtpxVUf0azY8Es5l6osN47vk3ELYHErxIYU+VOitFKAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857184; c=relaxed/simple;
	bh=FRTaxqQ9z0fdBOTvorH6lKFlBCFvX2RUJshMGjEelbw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q509FakfstHy3SUA/kzT32VScCjqt2umUlcqvOekMXaoOnkTJWaaaxTFhtOHa0Ehq76XSiyJ4LMWpZMyqz6PBIQbfvuj0MDhKGj33eti02ds6ryQfKUl9OiDJR5FiwZtf0cFfFQ1QHEJWYkTIVSMt6yyyuHXytgpfr/K3LHjfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIkvQnQI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIkvQnQI"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso2724913276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857182; x=1710461982; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=pIkvQnQIWFxNjYJNyjvMsnfG4CsaRWlnjpM/gDrLqTO35Y3Xp+G51s7QoiwSl6XSUx
         CubaXRgY1mqdxO9cImQC1OFCqtVU46K77QWORxLr9j/RlswtREscTEoqIWYcdqLm/y9R
         x2r0r9neCJ2vkXigtbuYXindTKpRd7Byqo6DPKWmVJE4gcgVKiXI8uxfx1D+5OUnvtH7
         JERjBdz+3+qz630bxjMiS8Ui1W27wj0+gZRzmls9eidTIU8P6VyCq3+nwEyJwNltuTma
         r49bl8T1ddDrasTYjfOZFu7wkqTYVEmDm9oo5BHB2+Tc7gvBeInJISOAXZFLd2IzuKxK
         WCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857182; x=1710461982;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=TNQB5AFeI8zayHiP9Cu1p4CfPI05bThXgwv4+lfCnxAGPU7FDcs1zvpV3uHDOUQY3N
         oIcxX+iRitGZgvkjROBnbbSFIzbzCCWpiXeZUGtetAAW3EnlfOPQLhND8Z1dceRwWuUO
         DH8YzIvlduEtKkOR9n6YkPpjYhjM8cRTDnaW8uoMugwlzh/gvl4chaNcDop/d4XO68UM
         mhdtE/ApQk6PzwUdyg+g6p6lIdEA9UX8GzLgOr2j/omqy5hS9owPN69UiN5u0yJdMY5b
         +iRnzWCNXJyfihs3FJNgsihQ6yvRVez/EdLuutNSm2umOwWDvLLoJ5MV2bTcQVsJh8Sd
         KuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGoZ5pONVihvljMMNHESuu2V0L987yOGdXT6SJBA6kySgbuw1D2tCkT+wpc39zOHw4H/ReTWvUvyvqPhzX05uhN6vlV8KCiMagOMuPV+f69g==
X-Gm-Message-State: AOJu0YyoC2GYbZPk40MUczLLetdS2BXb6gMbJwZ+2DmkA2Q41HgfQceW
	T3t6cgp4wSsGoRiLELoE4V1mOqbAqWhZftIHgqpQT0iR0A8N5M6lGRARcEH0vtaYqqC4xP0qTYz
	BQv0/9w==
X-Google-Smtp-Source: AGHT+IGZxH2VZwUiw1GgVvXnRBpm+B1jZaK1xeAq56iEuY9fI4p8nAEwAgnGzMx47spPAqo13VuXbW27mppI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr4897415ybt.6.1709857182253; Thu, 07 Mar
 2024 16:19:42 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:12 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 3/6] perf list: Allow wordwrap to wrap on commas
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

