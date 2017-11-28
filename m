From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf annotate: Fix objdump comment parsing for Intel mov dissassembly
Date: Tue, 28 Nov 2017 08:56:32 +0100
Message-ID: <20171128075632.72182-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750850AbdK1H4n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 02:56:43 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAS7sSFB029734
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2017 02:56:42 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eh1hgddvb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2017 02:56:42 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 28 Nov 2017 07:56:39 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

The command 'perf annotate' parses the output of objdump and also
investigates the comments produced by objdump. For example the
output of objdump produces (on x86):

23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
                                # 234008 <stderr@@GLIBC_2.2.5+0x9a8>

and the function mov__parse() is called to investigate the complete
line. Mov__parse() breaks this line into several parts and finally
calls function comment__symbol() to parse the data after the comment
character '#'. Comment__symbol() expects a hexadecimal address followed
by a symbol in '<' and '>' brackets.

However the 2nd parameter given to function comment__symbol()
always points to the comment character '#'. The address parsing
always returns 0 because the character '#' is not a digit and
strtoull() fails without being noticed.

Fix this by advancing the second parameter to function comment__symbol()
by one byte before invocation and add an error check after strtoull()
has been called.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index aa66791b1bfc..900147454fe9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -323,6 +323,8 @@ static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
 		return 0;
 
 	*addrp = strtoull(comment, &endptr, 16);
+	if (endptr == comment)
+		return 0;
 	name = strchr(endptr, '<');
 	if (name == NULL)
 		return -1;
@@ -436,8 +438,8 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map *m
 		return 0;
 
 	comment = ltrim(comment);
-	comment__symbol(ops->source.raw, comment, &ops->source.addr, &ops->source.name);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target.name);
+	comment__symbol(ops->source.raw, comment + 1, &ops->source.addr, &ops->source.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
 
@@ -481,7 +483,7 @@ static int dec__parse(struct arch *arch __maybe_unused, struct ins_operands *ops
 		return 0;
 
 	comment = ltrim(comment);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->target.name);
 
 	return 0;
 }
-- 
2.13.4
