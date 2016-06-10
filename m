From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: perf segfault in docker container
Date: Fri, 10 Jun 2016 15:58:48 +0530
Message-ID: <575A9660.4070907@linux.vnet.ibm.com>
References: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42292 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752222AbcFJK26 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jun 2016 06:28:58 -0400
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5AAO0Hb014823
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jun 2016 06:28:57 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23fcmejagj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jun 2016 06:28:57 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <aravinda@linux.vnet.ibm.com>;
	Fri, 10 Jun 2016 04:28:56 -0600
In-Reply-To: <CAE40pdfWpz6rreOCMJCs1P8WXfOXO_B5zZoeOyC_5usYGp8xRQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Ananth M <ananth@linux.vnet.ibm.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Hi Brendan,

I though of replying to your mail as I saw you running perf inside a
docker container. I believe you would be interested in events specific
to the container context as you are using "perf record -a".

We are working on supporting "container-aware tracing" i.e., whenever
you run "perf record -a" inside a container it should report
container-wide events rather than system-wide events. Towards that goal,
we posted an RFC patch in LKML [1] last year and also discussed possible
ways to restrict events within a container in Plumbers (Container
Microconf) [2].

Based on the discussion in Container Microconf, we are coming up with a
new prototype which should be ready for review by next week. The new
prototype introduces a new namespace "perf-namespace" (namespace name is
just a placeholder. Suggestions welcome). If the container is created
with perf-namespace, then "perf record -a" inside the container reports
only those events that are triggered within the container.

We would like to know if you are looking for "container-aware tracing"
and also like to know the scenarios/problems you are trying to debug by
running perf inside a container.

[1] lkml.org/lkml/2015/7/15/192
[2] linuxplumbersconf.org/2015/ocw/sessions/2667.html

Regards,
Aravinda

On Friday 10 June 2016 02:44 AM, Brendan Gregg wrote:
> G'Day,
> 
> Default docker container, in Linux 4.7-rc2, with latest perf from perf/core:
> 
> docker# ./perf record -F 99 -a
> Segmentation fault
> 
> The segfault is in perf_event__synthesize_kernel_mmap(). I know
> symbol__read_kptr_restrict() has been updated recently to fix similar
> segfaults, hence getting perf/core.
> 
> I think the problem is this:
> 
> docker# id
> uid=0(root) gid=0(root) groups=0(root)
> docker# cat /proc/sys/kernel/kptr_restrict
> 1
> 
> (I'd previously set "echo -1 > /proc/sys/kernel/perf_event_paranoid")
> 
> The current (May 24) code has, symbol__read_kptr_restrict():
> 
>                 if (fgets(line, sizeof(line), fp) != NULL)
>                         value = (geteuid() != 0) ?
>                                         (atoi(line) != 0) :
>                                         (atoi(line) == 2);
> 
> assumes that if euid is 0 && kptr_restrict isn't 2, then we're aren't
> restricted. But we are. Maybe the code should check for CAP_SYS_ADMIN,
> instead of euid == 0?
> 
> Brendan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Regards,
Aravinda
