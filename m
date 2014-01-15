From: Gaurav Jain <gjain@fb.com>
Subject: Pid namespaces & perf map files
Date: Wed, 15 Jan 2014 20:33:41 +0000
Message-ID: <B69B38A7-7142-4AE3-A109-98800BCF8DCE@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56368 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158AbaAOUdp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jan 2014 15:33:45 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0FKXeC3009281
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2014 12:33:43 -0800
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1hdxbfrvj7-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2014 12:33:43 -0800
Content-Language: en-US
Content-ID: <DC4141B9FBDF884E80190CBB00B6ECFB@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

I have a setup where the process generating the perf-<pid>.map file is using pid namespaces while the perf tool is running in the global namespace. As a result, perf cannot automatically find the map file since perf only knows the global pid of the file, while the map file is named with the pid in the namespace.

The fix I have is to modify perf to search for the map file in /proc/<global pid>/root/tmp/perf-<namespace pid>.map. This works, except for one caveat, how does perf get the pid in the namespace? Is there a way for perf to extract this? I couldn't see a way. As a result, I needed to expose the pid in /proc/pid/status.

Would there be a better way to achieve the same result?

Thanks,

Gaurav