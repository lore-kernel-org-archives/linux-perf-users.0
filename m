Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80A156F4
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Oct 2023 13:10:54 +0000 (UTC)
Received: from mail.sakamoto.pl (mail.sakamoto.pl [185.236.240.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685469C;
	Sun,  1 Oct 2023 06:10:52 -0700 (PDT)
Authentication-Results: mail.sakamoto.pl;
	auth=pass (plain)
From: April John <april@acab.dev>
To: linux-kernel@vger.kernel.org
Cc: April John <april@acab.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] /bin/dmesg to dmesg Path
Date: Sun,  1 Oct 2023 15:09:41 +0200
Message-ID: <20231001131047.15176-1-april@acab.dev>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Haraka-GeoIP: DE
X-Haraka-GeoIP-Received: 2a0f:5382:acab:1403:df7a:1afe:5a62:f4ea:DE
Received: from localhost (Unknown [127.0.0.1])
	by mail.sakamoto.pl (Haraka/2.8.28) with ESMTPSA id 8C646383-7EE1-448C-9701-59BAC68A05B4.1
	envelope-from <april@acab.dev>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Sun, 01 Oct 2023 15:10:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=acab.dev; s=s20220914329;
	h=from:subject:date:message-id:to:cc:mime-version;
	bh=dQOO+1RTlukVncTxCKOmVSa3gYvhD7rVj00JNhlBlAI=;
	b=imIyghrhK2UIPXFk8w3ldexzXY9jozTIYM/4zX4m08i4F3ReRHaSOkj/z6YaC/mQxjy35EPAnN
	Jw8mco13GS/QZnj+0aJcJNdUt5KtmXgUJNCAYkm+NFEJOrvsEf9wS0nAHzXr+MPeGH+juilkPba9
	NWvluyWhdXeREVB+kO9MrPM5TB8et41AIauJwPg+QGytxAChui/tkrwhw35I8TZK+EbKgXf8I5Wf
	1tuvFz3Yc2UAWrVMO5LUKSQ7HAZkzuwtLoihjXhFML/tV9cfKqMWS66I+NHg96POe/nSaA6b+NEQ
	G8a8NVymsDkTw+xmo0PCl+2XKULcnhYPhwEUT3qg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dmesg is not in every distro at /bin/dmesg, in NixOS for example, this fails,
but the path should in most cases contain dmesg.
This follows the example of replacing /bin/bash with bash Path in the codebase.

---
tools/perf/util/evsel.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a8a5ff87c..aa602aae6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3053,7 +3053,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,

return scnprintf(msg, size,
"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
- "/bin/dmesg | grep -i perf may provide additional information.\n",
+ "dmesg | grep -i perf may provide additional information.\n",
err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
}

--
2.42.0

Signed-off-by: April John <april@acab.dev>


