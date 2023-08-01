Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6930C0015E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 20:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHAUcR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHAUcR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 16:32:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3712E127
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690921935; x=1722457935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IVt2YibuYUaOYhhmOcOvUXXHxkVU/MgwXTGvwEzxRuA=;
  b=BzTi+Xf1VZsJyjJxjP/5B767qD8rx6m/mKtUhZAvU/plTyeyXTqIUhQq
   wpXm7oB9kgw5RcDOeMAd1mJKfzj67QV6Hl9emg5Ucs0ndpZDAeYIf73YG
   VT+Pg1misnAz5d6yZ/ogHSoD6WkcPiv2vTxFhSY0xfz5t3bEvgKaF+I3v
   GsJrPPeBkh149zvjEBj+G3JARVsKpJlVd5Th1SA8Zu9n5GgR6VGqJiVPY
   THqVJADdJH0RmyFRYDnYo/rRlDRiqMSICt+Pm5TcFg5I6jJD3ePXEbuWL
   yhXwyKvsaoaOGATRCIvMmnBYYV/MDN6OhdAf6HShqHr108nI16ghGfMAd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455776404"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="455776404"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818925614"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="818925614"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:32:14 -0700
Date:   Tue, 1 Aug 2023 13:32:13 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     linux-perf-users@vger.kernel.org
Cc:     irogers@google.com, acme@kernel.org, namhyung@kernel.org
Subject: duration_time regression
Message-ID: <ZMlrzcVrVi1lTDmn@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


With recent perf duration_time output regressed:

e.g. with an older version I get duration_time only once:

% perf stat -e cycles,duration_time true

CPU0                 190,925      cycles
... all the other CPUs printing cycles
CPU0                5,047,008 ns   duration_time

       0.005047008 seconds time elapsed

     
with the current perf it is printed on all CPUs, but not counted on most
of them:

% perf stat -e cycles,duration_time true

# started on Tue Aug  1 13:29:26 2023

 Performance counter stats for 'system wide':

CPU0               61,301      cycles                                                                
... print cycles for all CPUS ...
CPU0            5,343,556 ns   duration_time                                                         
CPU1        <not counted> ns   duration_time                                                         
CPU2        <not counted> ns   duration_time                                                         
CPU3        <not counted> ns   duration_time                                                         
CPU4        <not counted> ns   duration_time                                                         
... repeat the same for all CPUs ...

which is fairly useless.

-Andi
