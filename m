From: =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] Properly interpret indirect call in perf annotate.
Date: Thu, 23 Aug 2018 14:29:34 +0200
Message-ID: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0328B748A44F4D19A89A1CE5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------0328B748A44F4D19A89A1CE5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The patch changes interpretation of:
callq  *0x8(%rbx)

from:
  0.26 │     → callq  *8
to:
  0.26 │     → callq  *0x8(%rbx)

in this can an address is followed by a register, thus
one can't parse only address.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
 tools/perf/util/annotate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)



--------------0328B748A44F4D19A89A1CE5
Content-Type: text/x-patch;
 name="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Properly-interpret-indirect-call-in-perf-annotate.patch"

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..e32ead4744bd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 indirect_call:
 	tok = strchr(endptr, '*');
-	if (tok != NULL)
-		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	if (tok != NULL) {
+		endptr++;
+
+		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
+		 * Do not parse such instruction.  */
+		if (strstr(endptr, "(%r") == NULL)
+			ops->target.addr = strtoull(endptr, NULL, 16);
+	}
 	goto find_target;
 }
 


--------------0328B748A44F4D19A89A1CE5--
