Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMbnETiZ"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A701713
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 16:05:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d7e7e10231so9720287b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701993929; x=1702598729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgzdmxyD187mlNLpFJ4WQcDthQqtT591zShxv4oxXeo=;
        b=mMbnETiZ+g50JfUFRBSzXe0iTlPVlEtdQH9KjOBgOe2a8MDht5H2v5Bb87/ynA61uC
         TjBkNVLQIy3S8s5SfK+izTfVZXDHU2npS2K5ftbIAVDyVgOln2nt8lEuNe8p35SDfjRe
         n116DEtsfGUBxKLIkLDWpQLaix10XVKIu+5PO0xeCW7F5YH1u1kWJyVgGRZGHQEyfkaf
         8fqWP5OuGhpkYuSF7ZELFJJvUIw12xezt8xJVFe+VBhpED9IT/Wt62HVY4vmdFWLoAkv
         edVDk/cvu5b/NCsW5msCzd4vdkz9d7MMJEMyvVQ1XW+cGBT6Lb5uIPjBIv6iKNV+3uj1
         gJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993929; x=1702598729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgzdmxyD187mlNLpFJ4WQcDthQqtT591zShxv4oxXeo=;
        b=JS8TF7uW8M0+qKlo7QsxBmmjxtk/eBM9wVLBUgqbZHOJl90HnmOzcNaqmy8iRVfQbC
         an6gSWFHDtvNR6R6e6mld4usAHYdrGmN5wWJKHzF8zweIEzGomFu2Btwi3Ay1Ni5Iflb
         fXqFRk623e1x0POcQgMFK3DqPNT0XmI7ZoQmGOaycUjdGXGPDxslXwOzJedtFynlQcMx
         XAKlPRBOm7KCz0keIaQSvX/Kl2rV7msmFW0DLz3M5svErqeUp3reuBO2H/hlYoCXPv3J
         fs37skqfG3TxG8h22GX6B+eOeWcy9DRbOAlY6gTWbbb3ZkI9pPW9M2UAqrYIZ5nN5z8E
         Ij2A==
X-Gm-Message-State: AOJu0Ywnx6Rqbjg58jmBXgCEz3lbiMkt1Mf+mAze7hjLReQiNlLDqy9V
	xjfAqkcVpXxZK9YDPMLhSlSGW1i2Il7v
X-Google-Smtp-Source: AGHT+IEIhcIw8xy4mXcVlIVgYRmYedq9Rmvq6nH9O224FYrn8Hf8qx3kHxCVC9QjDwyjRtuRxHCGVJ0OgJF6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aa27:6848:76cc:141c])
 (user=irogers job=sendgmr) by 2002:a05:690c:2882:b0:5d3:985c:800c with SMTP
 id ee2-20020a05690c288200b005d3985c800cmr869ywb.3.1701993929362; Thu, 07 Dec
 2023 16:05:29 -0800 (PST)
Date: Thu,  7 Dec 2023 16:05:15 -0800
In-Reply-To: <20231208000515.1693746-1-irogers@google.com>
Message-Id: <20231208000515.1693746-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 3/3] perf help: Lower levenshtein penality for deleting character
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The levenshtein penalty for deleting a character was far higher than
subsituting or inserting a character. Lower the penalty to match that
of inserting a character.

Before:
```
$ perf recccord
perf: 'recccord' is not a perf-command. See 'perf --help'.
```

After:
```
$ perf recccord
perf: 'recccord' is not a perf-command. See 'perf --help'.

Did you mean this?
        record
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/help-unknown-cmd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index 2ba3369f1620..a0a46e34f8d1 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -73,10 +73,14 @@ const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
 
 	if (main_cmds->cnt) {
 		/* This reuses cmdname->len for similarity index */
-		for (i = 0; i < main_cmds->cnt; ++i)
+		for (i = 0; i < main_cmds->cnt; ++i) {
 			main_cmds->names[i]->len =
-				levenshtein(cmd, main_cmds->names[i]->name, 0, 2, 1, 4);
-
+				levenshtein(cmd, main_cmds->names[i]->name,
+					/*swap_penalty=*/0,
+					/*substition_penality=*/2,
+					/*insertion_penality=*/1,
+					/*deletion_penalty=*/1);
+		}
 		qsort(main_cmds->names, main_cmds->cnt,
 		      sizeof(*main_cmds->names), levenshtein_compare);
 
-- 
2.43.0.472.g3155946c3a-goog

