From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf script: man page fix
Date: Fri, 13 Jan 2017 10:06:52 -0500 (EST)
Message-ID: <728644547.14560155.1484320012612.JavaMail.zimbra@redhat.com>
References: <1c3f6e9cbe4a3c9e8b36aea8b0f71b2c48ad5bb5.1484319836.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:55944 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdAMPGx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2017 10:06:53 -0500
In-Reply-To: <1c3f6e9cbe4a3c9e8b36aea8b0f71b2c48ad5bb5.1484319836.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

The "--dump-raw-script" is not a valid option.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 5dc5c6a..4ed5f23 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -36,7 +36,7 @@ There are several variants of perf script:
 
   'perf script report <script> [args]' to run and display the results
   of <script>.  <script> is the name displayed in the output of 'perf
-  trace --list' i.e. the actual script name minus any language
+  script --list' i.e. the actual script name minus any language
   extension.  The perf.data output from a previous run of 'perf script
   record <script>' is used and should be present for this command to
   succeed.  [args] refers to the (mainly optional) args expected by
@@ -76,7 +76,7 @@ OPTIONS
 	Any command you can specify in a shell.
 
 -D::
---dump-raw-script=::
+--dump-raw-trace=::
         Display verbose dump of the trace data.
 
 -L::
-- 
1.8.3.1
