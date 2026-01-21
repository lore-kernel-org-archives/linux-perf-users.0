Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F835770A;
	Wed, 21 Jan 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018008; cv=none; b=B4qCR8HGNaDygqJAE3lZrkqeIZZf1mV0LzdtuJvezZlXnFU2M4B3cqarnZr54E2v4iG1+nR2FqhcwhZLH+OrTcoKyPvE1FWPEc+85y0Im1qHsCVGlKRbMkvPKXowgt4muPLOhVq6bNsFV/OMHT4Zcbt3UeGO8aivmP6E+TPAOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018008; c=relaxed/simple;
	bh=QF3lPdI+CIz6/GhB7FygDKqTpWTErY7HMdqIyBct5fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB1UHSiSXryXQu8FwAF5KixCXS4YMgl5fOotNnv/v6h6BaAqsB6vuxNx+8UzLvnpQCzaz41HOqsQQOvrg7JPwg/QzSOguAAYRryFHoR2otJ1CUWR51zukJqa3ezejtWhQ0faCOr0UyV2wAIWkaSaPZAt44ckNhW2/G9G2x+HEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AlUdw2Ns; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AlUdw2Ns"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LDE8UK019506;
	Wed, 21 Jan 2026 17:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yy1Oo9
	8+FyzM4dRGVomnDzgndnFggV06xa0DhYU05/k=; b=AlUdw2Nsu3JqHodCzi03dY
	OvpWY7pCbnTTCOvD0zXUuG73hclL39UF3OPqpnDzY4XpTZDVcX9TLi2JqNVu7tKS
	Vup1MhYW8a7xdSz0iEDQbslsBx8Y6XCFPLAaC2BngDS6+urWeKz+DmpAc4jZST1n
	BUf9LRo2/rV/RyKTYIx4kvTlnJYiWsAQ0Cl+mZsdlY0Gfp8/em+tSwMVxqSrPG/3
	pVtvX0E/283NGi00YqZuk0Uq2SA6hdHfML7SvNi1wZEHQxX6amyHCEdi+WXFqz/U
	qYZXeuotC3dO13wGgmUavIPzmXygw5V2BAjiFHk2jyw6N5j2+w8ET0DPL7Q0oElQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2565n0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 17:52:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LHmfDG012828;
	Wed, 21 Jan 2026 17:52:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2565n0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 17:52:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LGiVbU027382;
	Wed, 21 Jan 2026 17:52:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrn5hrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 17:52:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60LHqn9N46334252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 17:52:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BED9020043;
	Wed, 21 Jan 2026 17:52:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B3C20040;
	Wed, 21 Jan 2026 17:52:42 +0000 (GMT)
Received: from [9.39.23.228] (unknown [9.39.23.228])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Jan 2026 17:52:42 +0000 (GMT)
Message-ID: <ae2b9422-d203-4fc2-ab52-e0fd86e93f39@linux.ibm.com>
Date: Wed, 21 Jan 2026 23:22:41 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: ravi.bangoria@amd.com, yu.c.chen@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, juri.lelli@redhat.com,
        yangjihong@bytedance.com, void@manifault.com, tj@kernel.org,
        ctshao@google.com, quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
        blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
        dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
        graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
        tim.c.chen@linux.intel.com, linux@treblig.org, santosh.shukla@amd.com,
        sandipan.das@amd.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@arm.com
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260119175833.340369-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE1MCBTYWx0ZWRfX1m90f5nzNjDV
 VRyMfpcDBcIvPuR8t0YIl53YlfqRotXpZ6sODEvtZ4S/W6c7RRGzQeNSnSQQJsGrGV7aXxwfmJR
 /aOoWoHcTuiJGOHz0VW01yTobOHMCFHIz+aAS5iGsJpg8j8hGWjyrdFgyFV9vUa3dmRH9wg53pH
 vMsenwK3QHhwfPmuf3RCMwwl6o9s3pS87SheLuxwyGaGv5HTzuZv9QELh6rKOKxSoSDxFuwD9zv
 J3XQG4h9nEqELWdlT4y+umtpf+cb3plishYyEtfwSOmFu9yBLsgQcegKSYSVI7K9uTPOth2ChON
 zzKdjbwAz0A3pOwN9YuggGxApkSstbqOJKwEameMkS0LZSCZDIYojtXjXc15iPp4ld0asPBTnxM
 rXliTh5h3kqURwwBadJAun3Mb+EN21rI1GA3mA2pjeV4r7TGaF1RW/6JBE8z6wIV9BzNcqgvbx0
 mO/Bt5S0Afi4F8Fl+fw==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69711276 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jJrOw3FHAAAA:8 a=NEAV23lmAAAA:8
 a=J7HDwo72zrmOvIwastwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TDzqVCLJa7YYHMrj-ppIV8lCrGF8CNBZ
X-Proofpoint-ORIG-GUID: VMO4CKOAnFYbhQD-fnIqYSOJACyWNmvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210150



On 1/19/26 11:28 PM, Swapnil Sapkal wrote:
> MOTIVATION
> ----------
> 
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
> 
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched stats record` takes
> snapshot of the /proc/schedstat file before and after the workload, i.e.
> there is almost zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched stats record` is much more light weight
> compare to `perf sched record`.
> 
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
> series to report the analysis[6][7].
> 
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.
> 
> USAGE
> -----
> 
>    # perf sched stats record
>    # perf sched stats report
>    # perf sched stats diff
> 
> Note: Although `perf sched stats` tool supports workload profiling syntax
> (i.e. -- <workload> ), the recorded profile is still systemwide since the
> /proc/schedstat is a systemwide file.
> 
> HOW TO INTERPRET THE REPORT
> ---------------------------
> 
> The `perf sched stats report` starts with description of the columns
> present in the report. These column names are given before cpu and
> domain stats to improve the readability of the report.
> 
>    ----------------------------------------------------------------------------------------------------
>    DESC                    -> Description of the field
>    COUNT                   -> Value of the field
>    PCT_CHANGE              -> Percent change with corresponding base value
>    AVG_JIFFIES             -> Avg time in jiffies between two consecutive occurrence of event
>    ----------------------------------------------------------------------------------------------------
> 
> Next is the total profiling time in terms of jiffies:
> 
>    ----------------------------------------------------------------------------------------------------
>    Time elapsed (in jiffies)                                   :       24537
>    ----------------------------------------------------------------------------------------------------
> 

nit:
Is there a way to export HZ value too here?

> Next is CPU scheduling statistics. These are simple diffs of
> /proc/schedstat CPU lines along with description. The report also
> prints % relative to base stat.
> 
> In the example below, schedule() left the CPU0 idle 36.58% of the time.
> 0.45% of total try_to_wake_up() was to wakeup local CPU. And, the total
> waittime by tasks on CPU0 is 48.70% of the total runtime by tasks on the
> same CPU.
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU 0
>    ----------------------------------------------------------------------------------------------------
>    DESC                                                                     COUNT   PCT_CHANGE
>    ----------------------------------------------------------------------------------------------------
>    yld_count                                                        :           0
>    array_exp                                                        :           0
>    sched_count                                                      :      402267
>    sched_goidle                                                     :      147161  (    36.58% )
>    ttwu_count                                                       :      236309
>    ttwu_local                                                       :        1062  (     0.45% )
>    rq_cpu_time                                                      :  7083791148
>    run_delay                                                        :  3449973971  (    48.70% )
>    pcount                                                           :      255035
>    ----------------------------------------------------------------------------------------------------
> 
> Next is load balancing statistics. For each of the sched domains
> (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
> the following three categories:
> 
>    1) Idle Load Balance: Load balancing performed on behalf of a long
>                          idling CPU by some other CPU.
>    2) Busy Load Balance: Load balancing performed when the CPU was busy.
>    3) New Idle Balance : Load balancing performed when a CPU just became
>                          idle.
> 
> Under each of these three categories, sched stats report provides
> different load balancing statistics. Along with direct stats, the
> report also contains derived metrics prefixed with *. Example:
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU: 0 | DOMAIN: SMT | DOMAIN_CPUS: 0,64
>    ----------------------------------------------------------------------------------------------------
>    DESC                                                                     COUNT    AVG_JIFFIES
>    ----------------------------------------- <Category busy> ------------------------------------------
>    busy_lb_count                                                    :         136  $       17.08 $
>    busy_lb_balanced                                                 :         131  $       17.73 $
>    busy_lb_failed                                                   :           0  $        0.00 $
>    busy_lb_imbalance_load                                           :          58
>    busy_lb_imbalance_util                                           :           0
>    busy_lb_imbalance_task                                           :           0
>    busy_lb_imbalance_misfit                                         :           0
>    busy_lb_gained                                                   :           7
>    busy_lb_hot_gained                                               :           0
>    busy_lb_nobusyq                                                  :           2  $     1161.50 $
>    busy_lb_nobusyg                                                  :         129  $       18.01 $
>    *busy_lb_success_count                                           :           5
>    *busy_lb_avg_pulled                                              :        1.40
>    ----------------------------------------- <Category idle> ------------------------------------------
>    idle_lb_count                                                    :         449  $        5.17 $
>    idle_lb_balanced                                                 :         382  $        6.08 $
>    idle_lb_failed                                                   :           3  $      774.33 $
>    idle_lb_imbalance_load                                           :           0
>    idle_lb_imbalance_util                                           :           0
>    idle_lb_imbalance_task                                           :          71
>    idle_lb_imbalance_misfit                                         :           0
>    idle_lb_gained                                                   :          67
>    idle_lb_hot_gained                                               :           0
>    idle_lb_nobusyq                                                  :           0  $        0.00 $
>    idle_lb_nobusyg                                                  :         382  $        6.08 $
>    *idle_lb_success_count                                           :          64
>    *idle_lb_avg_pulled                                              :        1.05
>    ---------------------------------------- <Category newidle> ----------------------------------------
>    newidle_lb_count                                                 :       30471  $        0.08 $
>    newidle_lb_balanced                                              :       28490  $        0.08 $
>    newidle_lb_failed                                                :         633  $        3.67 $
>    newidle_lb_imbalance_load                                        :           0
>    newidle_lb_imbalance_util                                        :           0
>    newidle_lb_imbalance_task                                        :        2040
>    newidle_lb_imbalance_misfit                                      :           0
>    newidle_lb_gained                                                :        1348
>    newidle_lb_hot_gained                                            :           0
>    newidle_lb_nobusyq                                               :           6  $      387.17 $
>    newidle_lb_nobusyg                                               :       26634  $        0.09 $
>    *newidle_lb_success_count                                        :        1348
>    *newidle_lb_avg_pulled                                           :        1.00
>    ----------------------------------------------------------------------------------------------------
> 
> Consider following line:
> 
> newidle_lb_balanced                                              :       28490  $        0.08 $
> 
> While profiling was active, the load-balancer found 28490 times the load
> needs to be balanced on a newly idle CPU 0. Following value encapsulated
> inside $ is average jiffies between two events (28490 / 24537 = 0.08).
> 

Could you please explain this? I couldn't understand.

IIUC, you are parsing two instance of /proc/schedtstat,
once in the beginning and once in the end.

newidle_lb_balanced is a counter. In the beginning every iteration could
have decided domain is imbalanced and once load stabilized, it could have
decided now domain is balanced more often. i.e initially counter would add
quickly and then may stay more or less same value.

Also, what is this logic ? (28490 / 24537 = 0.08)?



> Next are active_load_balance() stats. alb did not trigger while the
> profiling was active, hence it's all 0s.
> 
> 
>    --------------------------------- <Category active_load_balance()> ---------------------------------
>    alb_count                                                        :           0
>    alb_failed                                                       :           0
>    alb_pushed                                                       :           0
>    ----------------------------------------------------------------------------------------------------
> 
> Next are sched_balance_exec() and sched_balance_fork() stats. They are
> not used but we kept it in RFC just for legacy purpose. Unless opposed,
> we plan to remove them in next revision.
> 
> Next are wakeup statistics. For every domain, the report also shows
> task-wakeup statistics. Example:
> 
>    ------------------------------------------ <Wakeup Info> -------------------------------------------
>    ttwu_wake_remote                                                 :        1590
>    ttwu_move_affine                                                 :          84
>    ttwu_move_balance                                                :           0
>    ----------------------------------------------------------------------------------------------------
> 
> Same set of stats are reported for each CPU and each domain level.
> 
> HOW TO INTERPRET THE DIFF
> -------------------------
> 
> The `perf sched stats diff` will also start with explaining the columns
> present in the diff. Then it will show the diff in time in terms of
> jiffies. The order of the values depends on the order of input data
> files. Example:
> 
>    ----------------------------------------------------------------------------------------------------
>    Time elapsed (in jiffies)                                        :        2763,       2763
>    ----------------------------------------------------------------------------------------------------
> 
> Below is the sample representing the difference in cpu and domain stats of
> two runs. Here third column or the values enclosed in `|...|` shows the
> percent change between the two. Second and fourth columns shows the
> side-by-side representions of the corresponding fields from `perf sched
> stats report`.
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU: <ALL CPUS SUMMARY>
>    ----------------------------------------------------------------------------------------------------
>    DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
>    ----------------------------------------------------------------------------------------------------
>    yld_count                                                        :           0,          0  |     0.00>
>    array_exp                                                        :           0,          0  |     0.00>
>    sched_count                                                      :      528533,     412573  |   -21.94>
>    sched_goidle                                                     :      193426,     146082  |   -24.48>
>    ttwu_count                                                       :      313134,     385975  |    23.26>
>    ttwu_local                                                       :        1126,       1282  |    13.85>
>    rq_cpu_time                                                      :  8257200244, 8301250047  |     0.53>
>    run_delay                                                        :  4728347053, 3997100703  |   -15.47>
>    pcount                                                           :      335031,     266396  |   -20.49>
>    ----------------------------------------------------------------------------------------------------
> 
> Below is the sample of domain stats diff:
> 
>    ----------------------------------------------------------------------------------------------------
>    CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
>    ----------------------------------------------------------------------------------------------------
>    DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
>    ----------------------------------------- <Category busy> ------------------------------------------
>    busy_lb_count                                                    :         122,         80  |   -34.43>
>    busy_lb_balanced                                                 :         115,         76  |   -33.91>
>    busy_lb_failed                                                   :           1,          3  |   200.00>
>    busy_lb_imbalance_load                                           :          35,         49  |    40.00>
>    busy_lb_imbalance_util                                           :           0,          0  |     0.00>
>    busy_lb_imbalance_task                                           :           0,          0  |     0.00>
>    busy_lb_imbalance_misfit                                         :           0,          0  |     0.00>
>    busy_lb_gained                                                   :           7,          2  |   -71.43>
>    busy_lb_hot_gained                                               :           0,          0  |     0.00>
>    busy_lb_nobusyq                                                  :           0,          0  |     0.00>
>    busy_lb_nobusyg                                                  :         115,         76  |   -33.91>
>    *busy_lb_success_count                                           :           6,          1  |   -83.33>
>    *busy_lb_avg_pulled                                              :        1.17,       2.00  |    71.43>
>    ----------------------------------------- <Category idle> ------------------------------------------
>    idle_lb_count                                                    :         568,        620  |     9.15>
>    idle_lb_balanced                                                 :         462,        449  |    -2.81>
>    idle_lb_failed                                                   :          11,         21  |    90.91>
>    idle_lb_imbalance_load                                           :           0,          0  |     0.00>
>    idle_lb_imbalance_util                                           :           0,          0  |     0.00>
>    idle_lb_imbalance_task                                           :         115,        189  |    64.35>
>    idle_lb_imbalance_misfit                                         :           0,          0  |     0.00>
>    idle_lb_gained                                                   :         103,        169  |    64.08>
>    idle_lb_hot_gained                                               :           0,          0  |     0.00>
>    idle_lb_nobusyq                                                  :           0,          0  |     0.00>
>    idle_lb_nobusyg                                                  :         462,        449  |    -2.81>
>    *idle_lb_success_count                                           :          95,        150  |    57.89>
>    *idle_lb_avg_pulled                                              :        1.08,       1.13  |     3.92>
>    ---------------------------------------- <Category newidle> ----------------------------------------
>    newidle_lb_count                                                 :       16961,       3155  |   -81.40>
>    newidle_lb_balanced                                              :       15646,       2556  |   -83.66>
>    newidle_lb_failed                                                :         397,        142  |   -64.23>
>    newidle_lb_imbalance_load                                        :           0,          0  |     0.00>
>    newidle_lb_imbalance_util                                        :           0,          0  |     0.00>
>    newidle_lb_imbalance_task                                        :        1376,        655  |   -52.40>
>    newidle_lb_imbalance_misfit                                      :           0,          0  |     0.00>
>    newidle_lb_gained                                                :         917,        457  |   -50.16>
>    newidle_lb_hot_gained                                            :           0,          0  |     0.00>
>    newidle_lb_nobusyq                                               :           3,          1  |   -66.67>
>    newidle_lb_nobusyg                                               :       14480,       2103  |   -85.48>
>    *newidle_lb_success_count                                        :         918,        457  |   -50.22>
>    *newidle_lb_avg_pulled                                           :        1.00,       1.00  |     0.11>
>    --------------------------------- <Category active_load_balance()> ---------------------------------
>    alb_count                                                        :           0,          1  |     0.00>
>    alb_failed                                                       :           0,          0  |     0.00>
>    alb_pushed                                                       :           0,          1  |     0.00>
>    --------------------------------- <Category sched_balance_exec()> ----------------------------------
>    sbe_count                                                        :           0,          0  |     0.00>
>    sbe_balanced                                                     :           0,          0  |     0.00>
>    sbe_pushed                                                       :           0,          0  |     0.00>
>    --------------------------------- <Category sched_balance_fork()> ----------------------------------
>    sbf_count                                                        :           0,          0  |     0.00>
>    sbf_balanced                                                     :           0,          0  |     0.00>
>    sbf_pushed                                                       :           0,          0  |     0.00>
>    ------------------------------------------ <Wakeup Info> -------------------------------------------
>    ttwu_wake_remote                                                 :        2031,       2914  |    43.48>
>    ttwu_move_affine                                                 :          73,        124  |    69.86>
>    ttwu_move_balance                                                :           0,          0  |     0.00>
>    ----------------------------------------------------------------------------------------------------
> 
> v4: https://lore.kernel.org/lkml/20250909114227.58802-1-swapnil.sapkal@amd.com/
> v4->v5:
>   - Address review comments from v4 [Namhyung Kim]
>   - Resolve the issue reported by kernel test rebot
>   - Debug and resolve issue reported in the perf sched stats diff [Prateek]
>   - Rebase on top of perf-tools-next(571d29baa07e)
> 
> v3: https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@amd.com/
> v3->v4:
>   - All the review comments from v3 are addressed [Namhyung Kim].
>   - Print short names instead of field descripion in the report [Peter Zijlstra]
>   - Fix the double free issue [Cristian Prundeanu]
>   - Documentation update related to `perf sched stats diff` [Chen yu]
>   - Bail out `perf sched stats diff` if perf.data files have different schedstat
>     versions [Peter Zijlstra]
> 
> v2: https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
> v2->v3:
>   - Add perf unit test for basic sched stats functionalities
>   - Describe new tool, it's usage and interpretation of report data in the
>     perf-sched man page.
>   - Add /proc/schedstat version 17 support.
> 
> v1: https://lore.kernel.org/lkml/20240916164722.1838-1-ravi.bangoria@amd.com
> v1->v2
>   - Add the support for `perf sched stats diff`
>   - Add column header in report for better readability. Use
>     procfs__mountpoint for consistency. Add hint for enabling
>     CONFIG_SCHEDSTAT if disabled. [James Clark]
>   - Use a single header file for both cpu and domain fileds. Change
>     the layout of structs to minimise the padding. I tried changing
>     `v15` to `15` in the header files but it was not giving any
>     benefits so drop the idea. [Namhyung Kim]
>   - Add tested-by.
> 
> RFC: https://lore.kernel.org/r/20240508060427.417-1-ravi.bangoria@amd.com
> RFC->v1:
>   - [Kernel] Print domain name along with domain number in /proc/schedstat
>     file.
>   - s/schedstat/stats/ for the subcommand.
>   - Record domain name and cpumask details, also show them in report.
>   - Add CPU filtering capability at record and report time.
>   - Add /proc/schedstat v16 support.
>   - Live mode support. Similar to perf stat command, live mode prints the
>     sched stats on the stdout.
>   - Add pager support in `perf sched stats report` for better scrolling.
>   - Some minor cosmetic changes in report output to improve readability.
>   - Rebase to latest perf-tools-next/perf-tools-next (1de5b5dcb835).
> 
> TODO:
>   - perf sched stats records /proc/schedstat which is a CPU and domain
>     level scheduler statistic. We are planning to add taskstat tool which
>     reads task stats from procfs and generate scheduler statistic report
>     at task granularity. this will probably a standalone tool, something
>     like `perf sched taskstat record/report`.
>   - Except pre-processor related checkpatch warnings, we have addressed
>     most of the other possible warnings.
>   - This version supports diff for two perf.data files captured for same
>     schedstats version but the target is to show diff for multiple
>     perf.data files. Plan is to support diff if perf.data files provided
>     has different schedstat versions.
> 
> Patches are prepared on top of perf-tools-next(571d29baa07e).
> 
> [1] https://youtu.be/lg-9aG2ajA0?t=283
> [2] https://github.com/AMDESE/sched-scoreboard
> [3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
> [4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/
> [5] https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
> [6] https://lore.kernel.org/lkml/3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com/
> [7] https://lore.kernel.org/lkml/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com/
> 
> Swapnil Sapkal (10):
>    tools/lib: Add list_is_first()
>    perf header: Support CPU DOMAIN relation info
>    perf sched stats: Add record and rawdump support
>    perf sched stats: Add schedstat v16 support
>    perf sched stats: Add schedstat v17 support
>    perf sched stats: Add support for report subcommand
>    perf sched stats: Add support for live mode
>    perf sched stats: Add support for diff subcommand
>    perf sched stats: Add basic perf sched stats test
>    perf sched stats: Add details in man page
> 
>   tools/include/linux/list.h                    |   10 +
>   tools/lib/perf/Documentation/libperf.txt      |    2 +
>   tools/lib/perf/Makefile                       |    1 +
>   tools/lib/perf/include/perf/event.h           |   69 ++
>   tools/lib/perf/include/perf/schedstat-v15.h   |  146 +++
>   tools/lib/perf/include/perf/schedstat-v16.h   |  146 +++
>   tools/lib/perf/include/perf/schedstat-v17.h   |  164 +++
>   tools/perf/Documentation/perf-sched.txt       |  261 ++++-
>   .../Documentation/perf.data-file-format.txt   |   17 +
>   tools/perf/builtin-inject.c                   |    3 +
>   tools/perf/builtin-sched.c                    | 1028 ++++++++++++++++-
>   tools/perf/tests/shell/perf_sched_stats.sh    |   64 +
>   tools/perf/util/env.c                         |   29 +
>   tools/perf/util/env.h                         |   17 +
>   tools/perf/util/event.c                       |   52 +
>   tools/perf/util/event.h                       |    2 +
>   tools/perf/util/header.c                      |  285 +++++
>   tools/perf/util/header.h                      |    4 +
>   tools/perf/util/session.c                     |   22 +
>   tools/perf/util/synthetic-events.c            |  196 ++++
>   tools/perf/util/synthetic-events.h            |    3 +
>   tools/perf/util/tool.c                        |   20 +
>   tools/perf/util/tool.h                        |    4 +-
>   tools/perf/util/util.c                        |   48 +
>   tools/perf/util/util.h                        |    5 +
>   25 files changed, 2595 insertions(+), 3 deletions(-)
>   create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
>   create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
>   create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
>   create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh
> 

