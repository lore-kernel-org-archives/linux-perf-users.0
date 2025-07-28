Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F868275AE8
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753730422; cv=none; b=gFBmg6pE2eZ3k/kyIMNxewO9agLi1PNxsMWFc70NoMW3lNfaWPAbm7MPOvM15F0iEHg+CDtV2XQQ41suXx1FNW8MB8oI84mGnV8M/lg5sqa7O9tlI151CgohCql3EScv/LpXFHWdqLt8OQkKWWgMCS3EVq7U0rXbseDlJu0dJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753730422; c=relaxed/simple;
	bh=q9SF8B/jc0yRXhsDhczNx/OADAi0lyIYi9pkvkZO2m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sClMJSU/PN/zumrHffWVm3S/GfRRd/JB4Wn+y6Ey/Rd4zBwI995VSYRjZi53OsrkUgh0zmAaLNLNFlt5iOeUMzLqO8BhLjD5Bt7p8fhTm3u7Zff6DlUeCYWoaF716XaVHnAHxsADy5kvc80Iiz5P4Qv844NybhmgdzD/T8e1Qyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UISdtmcl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UISdtmcl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFE2fY029963;
	Mon, 28 Jul 2025 19:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JhZf/yjnp8dIEhq+mYpgDZsvlmICQ/
	LsZyyUUxdk07U=; b=UISdtmclkqA+zsuuJvfHCXLrJtkWzykVIjfyFqwZ1HMo/L
	mg2zR6EbYwpLGDjBZtccbcDVvDDlEyIKqmdLpbybfk1DOmt2rETLzu1NkjNRcoc9
	Nzlsy1ofzJOSDYtxydbA3z7THXgz0iul57NssMbQ4A0TC0LmynCHpwToYJ4yCHc2
	uWSREo9qMh9s+Bk8jtH32Dlg9SYwGijVXqmj0cE3R6f4kF7I9DP0oh9T+9HypFoj
	NMzj1f0r3616Tpxh5QDeeARoSSiyCqMKJ3z7QxmUWS3/L2nUCXPuxvfHk5+6b9pd
	jY4Y2RwxGp91ee8fDTQuavDNv7qMgRuU9rK+mCGA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5atrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 19:20:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56SJIPbr003398;
	Mon, 28 Jul 2025 19:20:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5atrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 19:20:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFsiG9028755;
	Mon, 28 Jul 2025 19:20:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c22eu4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 19:20:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SJKCJt54788470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 19:20:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E162004B;
	Mon, 28 Jul 2025 19:20:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B59E20040;
	Mon, 28 Jul 2025 19:20:12 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.80.228])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Jul 2025 19:20:12 +0000 (GMT)
Date: Mon, 28 Jul 2025 21:20:10 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/1] perf test: Ensure lock contention using pipe mode
Message-ID: <aIfNaheJ5REpoFE_@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250725170801.3176678-1-japo@linux.ibm.com>
 <aIRoR6j1qAfytIPC@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIRoR6j1qAfytIPC@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE0MiBTYWx0ZWRfX2tB5pYRdzQn4
 OTqLhmijZxz0nHTAHhDd8mrwbvqghdhXo2LTJQnJ6sQhPAbyUgLhUES9rHGdrhg5yQcp+qYf8Mo
 cM+y9pFS74p2xodloLJweZojwuD/FsVeWv1s6YhN4cyeZyIUfGilco90gm760NFEFyY8diMBoSP
 jixh5ipLrrLqTqitgyBrMeuYQhvmge1DEzUKDFnEt665xt/wc6t6Lf75iX3iMBCd1LTc//B8TpC
 hqWF6u0XqSx0byyKJNB0Gmt1HEZ5aUREdabPScJ8UTvsWV/XBrrDkKVScgiYRrw1awgyGD4OhDm
 4gVJcfJl9+vOWlYCoBrqUMGv6wLCniVxispODjzvbY3bBNw08gkSfJfqnY9OzCN2qHG+bPjD23g
 6qYgTO5kMX+ii1ZQYoKFZlS0xiyjy3Ui7W4y6wVFXI/gUIKj4iLNsQXa1ffyFf/bC+SPRp/0
X-Proofpoint-ORIG-GUID: sklCIBsHRsPHwiq4n27NZk2GBXf90wg3
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=6887cd6f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qphFsQdMcfBamSn3BXEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: zyUrmbcEUM34NA0bsg7pCo_vX8bAgNq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280142

On Fri, Jul 25, 2025 at 10:31:51PM -0700, Namhyung Kim wrote:
> On Fri, Jul 25, 2025 at 07:08:01PM +0200, Jan Polensky wrote:
> > The 'kernel lock contention analysis test' requires reliable triggering
> > of lock contention. On some systems, previous benchmark calls failed to
> > generate sufficient contention due to low system activity or resource
> > limits.
>
> Right, we need a reliable reproducer.
>
> >
> > This patch adds the -p (pipe) option to all calls of perf bench sched
> > messaging, ensuring consistent lock contention without relying on
> > socket-based communication.
>
> But I don't understand why pipe is different than sockets.  Can you
> please elaborate?

The solution suggested by v1 in
https://lore.kernel.org/all/aIOvdQ003hRqFEH1@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com/
can be significantly faster and more reproducible in some cases. However,
on large systems it may fail with the error "perf: socketpair(): Too many
open files", which in turn can lead to kernel lock contention. While this
can be mitigated by increasing the file descriptor limit via ulimit -n
<number>, we should avoid modifying system settings during testing.

	[root@localhost perf]# ./perf stat -- perf bench sched messaging --group $(nproc) --thread
	# Running 'sched/messaging' benchmark:
	perf: socketpair(): Too many open files

	 Performance counter stats for 'perf bench sched messaging --group 32 --thread':

				 43.14 msec task-clock                       #    0.104 CPUs utilized
				 1,013      context-switches                 #   23.483 K/sec
				   900      cpu-migrations                   #   20.863 K/sec
				 2,905      page-faults                      #   67.342 K/sec
		   162,801,472      instructions                     #    0.74  insn per cycle
		   220,427,613      cycles                           #    5.110 GHz

		   0.414804757 seconds time elapsed

		   0.004687000 seconds user
		   0.071900000 seconds sys

Analyzing the lock content w/o pipe:

    [root@localhost ~]# perf record -e 'lock:contention*' -a -- perf bench sched messaging; perf script | wc -l
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver processes per group
    # 10 groups == 400 processes run

         Total time: 0.135 [sec]
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.363 MB perf.data ]
    0

Analyzing the lock content with pipe:

    [root@localhost ~]# perf record -e 'lock:contention*' -a -- perf bench sched messaging -p; perf script | wc -l
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver processes per group
    # 10 groups == 400 processes run

         Total time: 0.108 [sec]
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 1.604 MB perf.data (14789 samples) ]
    14789

By using the -g option, we identified pipe as a good source of contention:

    [skip]
    sched-messaging 2028653 [003] 625253.243099: lock:contention_begin: 0x85846e40 (flags=SPIN|MUTEX)
             3a211f16200 __traceiter_contention_begin+0x50 ([kernel.kallsyms])
             3a212d92e0e __mutex_lock.constprop.0+0x1be ([kernel.kallsyms])
             3a2122643f2 anon_pipe_write+0x52 ([kernel.kallsyms])
             3a21225789a vfs_write+0x1ca ([kernel.kallsyms])
             3a212257ca8 ksys_write+0xd8 ([kernel.kallsyms])
             3a212d8c8f4 __do_syscall+0x164 ([kernel.kallsyms])
             3a212d99154 system_call+0x74 ([kernel.kallsyms])
             3ff8e2a9ba6 __internal_syscall_cancel+0xa6 (/usr/lib64/libc.so.6)

	sched-messaging 2028652 [005] 625253.243099:   lock:contention_end: 0x85846e40 (ret=0)
             3a211f16280 __traceiter_contention_end+0x50 ([kernel.kallsyms])
             3a212d92fd6 __mutex_lock.constprop.0+0x386 ([kernel.kallsyms])
             3a2122643f2 anon_pipe_write+0x52 ([kernel.kallsyms])
             3a21225789a vfs_write+0x1ca ([kernel.kallsyms])
             3a212257ca8 ksys_write+0xd8 ([kernel.kallsyms])
             3a212d8c8f4 __do_syscall+0x164 ([kernel.kallsyms])
             3a212d99154 system_call+0x74 ([kernel.kallsyms])
             3ff8e2a9ba6 __internal_syscall_cancel+0xa6 (/usr/lib64/libc.so.6)
	[skip]

This suggests that sockets are better optimized to avoid such locking
issues, and therefore are a poor choice in this specific benchmark
scenario.

> Thanks,
> Namhyung
>
[skip]
> >
