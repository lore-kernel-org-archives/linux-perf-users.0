Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zk+ZQK6m"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F91718
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 16:05:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so18091147b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701993925; x=1702598725; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7VAKwLUWVywjDo2dEK6wuoDMXw70DBGya721KiihN0=;
        b=zk+ZQK6mfuXD8rwusqq6/iZLf88yIvrSr7z+pQN1LBu7Ry5t8uJSCmbzOjFdJQz2vw
         ngv3+RCm16WGwNxa/4jLNueonxJ9g42GPRWa/lZgoSRHBpzwscaAGaq912opu6z2Uqgr
         YZeBjOa6WNUFVQjZmCqjSHgiyS3dhEUo25EF48eCNbFCipwifW5Kq+49bUDDB9llv9IT
         ury7cuHLAVFSeLfxi2fa0U1GSxl8FL6A2y9gRMwCcvjykHEC07voPe6U4RVz5KhuWTeV
         nhdSpXV20fYNK4jYgHXUOhCnoLAFgJrZdM5iNOPr5W5DokPb9aqNJu/LQ5dOqZOJExyI
         xIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701993925; x=1702598725;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7VAKwLUWVywjDo2dEK6wuoDMXw70DBGya721KiihN0=;
        b=kk71/JDc0UJoSlUJ78zKYxBoLVvy8bOP3KanWAd1lXKaOjeMi5Rz5m1H7o3ovSerKo
         PhmqHbghDIWnCqZE2itqzc6zBjclk3oMkOhOc8jDniJcLEzoq+yUKj0gTYjEWoMQpeg7
         mrn4Z/jiw8msWsL7RRx/jpMIKfnXOeCmkv9cU8ByPySDxdqDbUz6ZHWms6sL7FVSAaud
         7knzHzETg3JHc+ki/OA2j6tbagEi9h3mRlvQ4MZ/Zn2UST8BaAsz7lbrrXmAhaB9yh02
         BjchuZVTnbNxjsCCka6+Jd5D7VDcBB4/z1fuD4ijb5uMm4Y3MGNCOl525WCZolp2cNe3
         YioQ==
X-Gm-Message-State: AOJu0Yzkzn7aFmwAc3GwLaYeNnDR1c5tFy+/CiFsvn4jlnBi3btzoo4I
	ZlSk4n6BKmFO3gW314FJHNFwFDqXM6yc
X-Google-Smtp-Source: AGHT+IHu9T2Gy2CB3/Hupo7gAYRgMRacMV5kSjT6ATlNY2CuCYfwMUaXFiD8Fs/UWATBZndJDix8xNo+IImI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aa27:6848:76cc:141c])
 (user=irogers job=sendgmr) by 2002:a05:690c:4607:b0:5d3:9513:4aad with SMTP
 id gw7-20020a05690c460700b005d395134aadmr53065ywb.3.1701993924731; Thu, 07
 Dec 2023 16:05:24 -0800 (PST)
Date: Thu,  7 Dec 2023 16:05:13 -0800
Message-Id: <20231208000515.1693746-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

uniq will write one command name over another causing the overwritten
string to be leaked. Fix by doing a pass that removes duplicates and a
second that removes the holes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index adfbae27dc36..8561b0f01a24 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -52,11 +52,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
-- 
2.43.0.472.g3155946c3a-goog

