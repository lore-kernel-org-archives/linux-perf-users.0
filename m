From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Why the need to do a perf_event_open syscall for each cpu on
 the system?
Date: Fri, 13 Mar 2015 17:14:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1503131712230.19926@vincent-weaver-1.umelst.maine.edu>
References: <55033138.5010500@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36794 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbCMVJo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 Mar 2015 17:09:44 -0400
Received: by qcxm20 with SMTP id m20so29770783qcx.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2015 14:09:43 -0700 (PDT)
In-Reply-To: <55033138.5010500@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, 13 Mar 2015, William Cohen wrote:

> Why not have a perf_event_open with pid=-1 and cpu=-1 mean 
> system-wide event and aggregate it in the kernel when the value is read?  
> The line below from design.txt specifically say it is invalid.

you might have more luck asking questions like this on linux-kernel, I'm 
not sure if many of the actual kernel developers hang out on 
linux-perf-users.

From what I gather, having aggregate system-wide events in the kernel adds 
a lot of kernel overhead for not much benefit, as you can always aggregate 
yourself in userspace (which is what I think the perf tool does).

Vince
