From: anshuman.gupta@intel.com
Subject: [QUERY] "perf record h/w events only for a linux kernel function target"
Date: Mon,  5 Feb 2018 14:19:17 +0530
Message-ID: <1517820557-22812-1-git-send-email-anshuman.gupta@intel.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:60675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeBEIu0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Feb 2018 03:50:26 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.gupta@intel.com, rajneesh.bhardwaj@intel.com

From: Anshuman Gupta <anshuman.gupta@intel.com>

Hi, 

I want to profile a Linux kernel function (i8237A_resume) at instruction level.
This function is basically hits, while system resumes from suspend (S3).
I want to record perf CPU-cycles events only for this particular function (i8237A_resume).
Is there anyway by using perf i can record the CPU-cycles and other h/w events
only specific to a Linux kernel function.

Thanks ,
Anshuman Gupta


-- 
2.7.4
