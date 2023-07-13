Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A5C0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGMQni (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjGMQnU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2023 12:43:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF4530FA
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jul 2023 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689266579; x=1720802579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ti2aV+8E+xVsRMUvjwciNlmKrTA0Gd6Ag9MVTjte6hc=;
  b=P4lOoolt/cokToWSytuV/sAyQNNh4snKHJOdO0biqce2si4O2gaNnpXZ
   Y/norJL9BFtEGdVGbTOAG0E0T77moE8d1qXH5qedjOcfPCPFqTHO+R84u
   Av+1cBHNoL+zZuM82JW5UDmjYASQJ520UcRXbZK38I1eU3BXAzPg1etGh
   8eSrI2NAa8HiDK9koT/aMo3KlF0F49pi5iVPUdbTUqD/b+T1ti4eqiX4W
   HQ9OoJiUK8IxqqVmj/6w97iDeiInmrRqU5jpqcI2OBR64nja3NpkGel68
   A6Gdp5WLlZBM2JTQwWHdHrWNbbgI6pp7bxYGep6jqjFzxYpVma2IUah58
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="350117204"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="350117204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757232925"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="757232925"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:42:46 -0700
Date:   Thu, 13 Jul 2023 09:42:45 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     irogers@google.com
Cc:     linux-perf-users@vger.kernel.org
Subject: perf command line error handling regression
Message-ID: <ZLAphRzys2lcNICF@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ian,

Since the commit below, I see the following:

$ perf foo
Segmentation fault (core dumped)
$

Before:

$ perf foo
perf: 'foo' is not a perf-command. See 'perf --help'.
$

(gdb) bt
#0  0x00007ffff6f89fe2 in __strcmp_evex () from /lib64/libc.so.6
#1  0x00007ffff6e6387d in msort_with_tmp.part () from /lib64/libc.so.6
#2  0x00007ffff6e63bd6 in qsort_r () from /lib64/libc.so.6
#3  0x00000000005895af in help_unknown_cmd (cmd=cmd@entry=0x7fffffffdaf2 "foo") at util/help-unknown-cmd.c:71
#4  0x000000000040cb52 in main (argc=1, argv=0x7fffffffd750) at perf.c:543


commit 657a3efee43a29d13c4f30e4c8f6a178fd2bf14a
Author: Ian Rogers <irogers@google.com>
Date:   Sun Jun 11 16:36:06 2023 -0700

    lib subcmd: Avoid memory leak in exclude_cmds

    exclude_cmds will shorten the cmds names array, before doing so free the
    removed entry.

