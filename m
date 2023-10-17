Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52517CB
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B6B0;
	Mon, 16 Oct 2023 18:55:43 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8cQB0jRqzvQ9B;
	Tue, 17 Oct 2023 09:50:58 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 17 Oct 2023 09:55:40 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [RESEND PATCH] perf: script: fix missing ',' for fields option
Date: Tue, 17 Oct 2023 09:55:24 +0800
Message-ID: <20231017015524.797065-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A comma is missed at the end of line.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 200b3e7ea8da..c01894b9b9bf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3899,7 +3899,7 @@ int cmd_script(int argc, const char **argv)
 		     "comma separated output fields prepend with 'type:'. "
 		     "+field to add and -field to remove."
 		     "Valid types: hw,sw,trace,raw,synth. "
-		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff"
+		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
-- 
2.25.1

