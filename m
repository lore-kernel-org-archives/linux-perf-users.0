From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: Annotate is broken with --symfs option
Date: Tue, 6 Feb 2018 18:17:43 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989261C1F5@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co300216-co-outbound.net.avaya.com ([198.152.13.100]:55824 "EHLO
        co300216-co-outbound.net.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752599AbeBFSRq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Feb 2018 13:17:46 -0500
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Since commit a706670900073d236938d539d1109338d64b47bb, when using
"perf annotate --symfs SYMFS_PATH" or "perf report --symfs SYMFS_PATH",
annotate no longer produces any output.

Cause is an unnecessary call to __symbol__join_symfs in dso__disassemble_filename,
which results in looking for the .build-id directory under SYMFS_PATH/SYMFS_PATH/.debug
instead of under SYMFS_PATH/.debug.

May be able to submit a patch, not sure where to send it.
MV
