From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf buildid-list: Show running kernel build id fix
Date: Fri, 27 Nov 2015 14:48:09 +0100
Message-ID: <1448632089.24573.114.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbbK0NsM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Nov 2015 08:48:12 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>, =?UTF-8?Q?=E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3?= / =?UTF-8?Q?HIRAMATU=EF=BC=8CMASAMI?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

The --kernel option of perf buildid-list tool should show the running
kernel buildid.  The functionality has been lost during other changes
of the related code.   The build_id__sprintf() function should return
length of the build-id string,  but it was the length of the build-id
raw data instead. Due to that, some return value checking caused that
the final string was not printed out.

With this patch the build_id__sprintf() returns the correct value, so
the --kernel option works again.

Before:

	# perf buildid-list --kernel
	#

After:

	# perf buildid-list --kernel
	972c1edab5bdc06cc224af45d510af662a3c6972
	#

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/build-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 217b5a6..6a7e273 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -91,7 +91,7 @@ int build_id__sprintf(const u8 *build_id, int len, char *bf)
 		bid += 2;
 	}
 
-	return raw - build_id;
+	return (bid - bf) + 1;
 }
 
 int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
