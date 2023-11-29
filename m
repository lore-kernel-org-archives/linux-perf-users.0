Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1+LsFpW"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13AE172E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 00:10:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd573c2cccso5307697b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701245432; x=1701850232; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfx1JC4eBOGrcYnY6xicCWpxUTppoeccvNEbp92VzIk=;
        b=c1+LsFpWXVZa9f0P5WSJVas0Ky1Ns9z08OWReCQPUx8UbCCItqqEjvqKl9VaEWy/T8
         +KVwuU6p8GeqL84vzu9l2ePUgs154JheZQq+kFRA6eb0XGF5SQqR0fKtljCEUlxCO4mn
         D4n8LB1H18QLEMUBV05lbnVllpkBtSl++Ankn+zpMLqLcPQw8UfhBeVdNAwdhXCe45ex
         bEN5J6Fx4j9jRZ+mKczV96Bz0+gYWgXpqBsQAdNXYxkeg+mJLCuCUnULQ0Y28bc4K4rF
         dJ4RyLAfPIzZ79PeyQ1kmBlcAId4DIzHFFuVS2qe4AzRYdC1nBJDRbe2b4byUD/na57w
         HnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245432; x=1701850232;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfx1JC4eBOGrcYnY6xicCWpxUTppoeccvNEbp92VzIk=;
        b=Dz8xejeGoOhEcNZBTUuADTesTW3fDDO8tVLOh1CYC9URUVhMKeY3WxTvO0xX64MccQ
         HijgBkZsefSHEgErJqD+jAVS9bSEa6M5MgQYPTUp+EML/QOnuxJLpDfoxo1K9/iN0bUx
         OeokUfunpKpUAcYlQbFVzy4UXLEZJm1OjaUN/HCerYlHeNYLjGir8IBY9eEjtR9MYv0l
         /eicBxJ9wveSvdl34Bg9fCJY84R2JvSmcsHfPU2gVbudBgswo0mpLc4M1yp5Zrtgyx+p
         CBUc2WWWv4rpiK6YYMzYFzltZcvQbV11Esotkbc0kpgrrNiOMV7wlBfaguuNfkIhhHIe
         2bBw==
X-Gm-Message-State: AOJu0Yw7LkIlE8rVwP5TvvgcMq/z1xj61/RgzqROv6ZU+74SOfMXra2G
	7YqVdHP9ceqH4x7W4Nj/tpo7tw398Rr8
X-Google-Smtp-Source: AGHT+IE5b9oYoQQYInppAwId01GLHLrLVHBthTMBolUCilxrEIoPz5tuG8kxIflGG6rgmhKBscV72D45W3Am
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b0a:b0:5d0:8fb3:559c with SMTP
 id em10-20020a05690c2b0a00b005d08fb3559cmr253486ywb.0.1701245431941; Wed, 29
 Nov 2023 00:10:31 -0800 (PST)
Date: Wed, 29 Nov 2023 00:10:04 -0800
In-Reply-To: <20231129081004.1918096-1-irogers@google.com>
Message-Id: <20231129081004.1918096-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129081004.1918096-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 2/2] perf test: Add basic list test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Test that json output produces valid json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 tools/perf/tests/shell/list.sh

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
new file mode 100755
index 000000000000..286879a9837a
--- /dev/null
+++ b/tools/perf/tests/shell/list.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# perf list tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+err=0
+
+if [ "x$PYTHON" == "x" ]
+then
+	if which python3 > /dev/null
+	then
+		PYTHON=python3
+	elif which python > /dev/null
+	then
+		PYTHON=python
+	else
+		echo Skipping test, python not detected please set environment variable PYTHON.
+		exit 2
+	fi
+fi
+
+test_list_json() {
+  echo "Json output test"
+  perf list -j | $PYTHON -m json.tool
+  echo "Json output test [Success]"
+}
+
+test_list_json
+exit $err
-- 
2.43.0.rc1.413.gea7ed67945-goog

