Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC6C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Dec 2022 15:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiLMPB2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMPB1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Dec 2022 10:01:27 -0500
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 07:01:26 PST
Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84559209B8
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Dec 2022 07:01:26 -0800 (PST)
Received: from [134.158.76.195] (wd-graland.ijclab.in2p3.fr [134.158.76.195])
        (authenticated bits=0)
        by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 2BDEVIIH010411
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Dec 2022 15:31:18 +0100
Message-ID: <58f34e62-81d7-fc71-dec2-03e88ee36392@ijclab.in2p3.fr>
Date:   Tue, 13 Dec 2022 15:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     linux-perf-users@vger.kernel.org
From:   Hadrien Grasland <hadrien.grasland@ijclab.in2p3.fr>
Subject: A few questions from writing a perf tutorial
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi everyone,

I recently ran a perf tutorial for my colleagues (which I hope to eventually
translate to English so it's of more general use), and noted a number of
surprising things in the process.

In the interest of fixing my understanding and reporting bugs where 
appropriate,
I would appreciate it if some of you would care to help me triage the 
expected
from the abnormal here.

===

Many of my issues stem from the fact that I'm providing a shared server to
ensure that everyone is using the same version of perf, the same kernel, 
and the
same CPU. Which means that I need to set up the system to give participants
fairly broad perf privileges, without wanting to giving them full root 
access.
That leads to various permission issues.

I have read
https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html#privileged-perf-users-groups
and tried the suggested workflow of giving the perf executable various
capabilities while making it only accessible to a "perf group". However, the
capabilities don't seem to do anything. For example, even with 
cap_syslog set,
I still need kptr_restrict = 0 to see kernel symbol names in perf top and
system-wide perf record. Ditto for cap_perfmon : even if it's set, I 
still need
to tune down perf_event_paranoid for system-wide profiling.

I cross-checked with the procedure discussed in
https://linux-audit.com/linux-capabilities-101/ that the capabilities 
are set
correctly on running perf processes, so I'm not sure what's going on 
here. That
would be the first mystery.

===

The second mystery is that perf trace run as a regular user does not 
correctly
report thread names for all multi-threaded executables. It just reports 
the thread
numerical ID, which makes the output hard to read unless supplemented with a
little `ps aux -L`. This may not be feasible when the threads being 
monitored
are short-lived.

When perf trace is run as root, it has no such issue, which suggests 
that this
is a permission problem. Would you happen to know what the missing 
permission
is and whether/how I can give it to non-root users?

===

I also noticed that trying to use `--call-graph=lbr` on non-PMU events 
(syscalls
and tracepoints in general) fails with an "Operation not supported" 
error. I do
not understand why this operation is not supported, however, given that 
from my
limited understanding of the LBR, it should be active no matter what the 
CPU is
doing, and perf should always be able to sample it including on tracepoint
events. Can someone shed some light on this?

===

Thanks in advance for your help!
Hadrien Grasland
