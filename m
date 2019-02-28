From: Tony Jones <tonyj@suse.de>
Subject: [PATCH] tools lib traceevent: Fix buffer overflow in arg_eval
Date: Wed, 27 Feb 2019 17:55:32 -0800
Message-ID: <20190228015532.8941-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tony Jones <tonyj@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-perf-users.vger.kernel.org

Fix buffer overflow observed when running perf test.

The overflow is when trying to evaluate "1ULL << (64 - 1)" which
is resulting in -9223372036854775808 which overflows the 20 character
buffer.

If is possible this bug has been reported before but I still don't
see any fix checked in:

See: https://www.spinics.net/lists/linux-perf-users/msg07714.html

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Tony Jones <tonyj@suse.de>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index abd4fa5d3088..87494c7c619d 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2457,7 +2457,7 @@ static int arg_num_eval(struct tep_print_arg *arg, long long *val)
 static char *arg_eval (struct tep_print_arg *arg)
 {
 	long long val;
-	static char buf[20];
+	static char buf[24];
 
 	switch (arg->type) {
 	case TEP_PRINT_ATOM:
-- 
2.20.1
