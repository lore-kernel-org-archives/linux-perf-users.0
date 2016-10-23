From: Vince Weaver <vincent.weaver@maine.edu>
Subject: perf bpf-output example program
Date: Sun, 23 Oct 2016 13:10:54 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1610231302040.27722@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35953 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756102AbcJWRLB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 23 Oct 2016 13:11:01 -0400
Received: by mail-yw0-f194.google.com with SMTP id e5so4824475ywc.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Oct 2016 10:11:01 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Wang Nan <wangnan0@huawei.com>


Does anyone have a working perf bpf-output example program?

The one from the original commit to the kernel 
03e0a7df3efd959e40cd7ff40b1fabddc234ec5a
does not work for me:

sudo perf record -a -e bpf-output/no-inherit,name=evt/ -e 
./test_bpf_output.c/map:channel:event=evt/ ls /

WARNING:	unable to get correct kernel building directory.
Hint:	Set correct kbuild directory using 'kbuild-dir' option in [llvm]
     	section of ~/.perfconfig or set it to "" to suppress kbuild
     	detection.

event syntax error: './test_bpf_output.c/map:channel:event=evt/'
                     \___ Failed to load program for unknown reason

Vince
