From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/91] libtraceevent: Remove unneeded semicolon
Date: Wed,  6 May 2020 12:21:16 -0300
Message-ID: <20200506152234.21977-14-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

Fixes coccicheck warning:

 tools/lib/traceevent/kbuffer-parse.c:441:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lore.kernel.org/lkml/1588065121-71236-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/kbuffer-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index b887e7437d67..27f3b07fdae8 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -438,7 +438,7 @@ void *kbuffer_translate_data(int swap, void *data, unsigned int *size)
 	case KBUFFER_TYPE_TIME_EXTEND:
 	case KBUFFER_TYPE_TIME_STAMP:
 		return NULL;
-	};
+	}
 
 	*size = length;
 
-- 
2.21.1
