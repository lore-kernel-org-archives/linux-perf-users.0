Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82037405EB
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XCytRvT3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0998798
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 03:02:59 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H9qNkB029478;
	Tue, 17 Oct 2023 10:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YOYedebsK0W1tfL4CB50dFavxrbhDJx+djVrBA9ASAA=;
 b=XCytRvT35GDvhmN5ZVIg4lz9a4zuh45szn0upGUM34IaKiPijeF7mdAcp3AJCv1OqVBU
 hKFZUxmt1c6rTUkS/S9H5nQWmjUSMudN2tgANsvk8d0Uq6RUiDKn6altUP0SMkJxAVuI
 N65vM/npHGihG5EKBEZF9S9XTWLldu85qaN/hemuh4TpsnFSJEF+91yjDoMzYSL9Ix/I
 GGNiS9gcgFDMp46Q035UzWGE75sHBFiZ7L+QATzoPh5cZh4S3QC+v3uxQT/KxYhM+I61
 vezW1A7KpKmW3v+AgU0ssJSXDKw7d/Q5MT7rPqqaEObNNeWv45/mX7l6JGQ/X4c12PFV mQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsr11gapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 10:02:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39H8j2st026879;
	Tue, 17 Oct 2023 09:57:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5as89vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 09:57:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39H9vq4911928228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 09:57:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39CF82004B;
	Tue, 17 Oct 2023 09:57:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D04E720040;
	Tue, 17 Oct 2023 09:57:50 +0000 (GMT)
Received: from [9.109.252.67] (unknown [9.109.252.67])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Oct 2023 09:57:50 +0000 (GMT)
Message-ID: <c3ce6a20-9906-8fb5-f087-1fefba5e03d9@linux.ibm.com>
Date: Tue, 17 Oct 2023 15:27:49 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] perf vendor events: Update PMC used in PM_RUN_INST_CMPL
 event for power10 platform
To: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        Disha Goel <disgoel@linux.vnet.ibm.com>
References: <20231016143110.244255-1-kjain@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20231016143110.244255-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _S_vehjm-iNTOjyalhtwgkWi7-hZiZay
X-Proofpoint-GUID: _S_vehjm-iNTOjyalhtwgkWi7-hZiZay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170083
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/10/23 8:01 pm, Kajol Jain wrote:

> The CPI_STALL_RATIO metric group can be used to present the high
> level CPI stall breakdown metrics in powerpc, which will show:
>
> - DISPATCH_STALL_CPI ( Dispatch stall cycles per insn )
> - ISSUE_STALL_CPI ( Issue stall cycles per insn )
> - EXECUTION_STALL_CPI ( Execution stall cycles per insn )
> - COMPLETION_STALL_CPI ( Completion stall cycles per insn )
>
> Commit cf26e043c2a9 ("perf vendor events power10: Add JSON
> metric events to present CPI stall cycles in powerpc)" which added
> the CPI_STALL_RATIO metric group, also modified
> the PMC value used in PM_RUN_INST_CMPL event from PMC4 to PMC5,
> to avoid multiplexing of events.
> But that got revert in recent changes. Fix this issue by changing
> back the PMC value used in PM_RUN_INST_CMPL to PMC5.
>
> Result with the fix:
>
>   ./perf stat --metric-no-group -M CPI_STALL_RATIO <workload>
>
>   Performance counter stats for 'workload':
>
>          68,745,426      PM_CMPL_STALL                    #     0.21 COMPLETION_STALL_CPI
>           7,692,827      PM_ISSUE_STALL                   #     0.02 ISSUE_STALL_CPI
>         322,638,223      PM_RUN_INST_CMPL                 #     0.05 DISPATCH_STALL_CPI
>                                                    #     0.48 EXECUTION_STALL_CPI
>          16,858,553      PM_DISP_STALL_CYC
>         153,880,133      PM_EXEC_STALL
>
>         0.089774592 seconds time elapsed
>
> "--metric-no-group" is used for forcing PM_RUN_INST_CMPL to be scheduled
> in all group for more accuracy.
>
> Fixes: 7d473f475b2a ("perf vendor events: Move JSON/events to appropriate files for power10 platform")
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Thanks for the fix Kajol.
With this patch applied getting correct PMC value for PM_RUN_INST_CMPL event.

# ./perf stat -vv -e PM_RUN_INST_CMPL sleep 1
Using CPUID 00800200
Attempt to add: cpu/PM_RUN_INST_CMPL/
..after resolving event: cpu/event=0x500fa/
PM_RUN_INST_CMPL -> cpu/event=0x500fa/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
   type                             4 (PERF_TYPE_RAW)
   size                             136
   config                           0x500fa
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
   exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 750989  cpu -1  group_fd -1  flags 0x8 = 3
PM_RUN_INST_CMPL: -1: 1593381 483118 483118
PM_RUN_INST_CMPL: 1593381 483118 483118

  Performance counter stats for 'sleep 1':

          1,593,381      PM_RUN_INST_CMPL

        1.001107900 seconds time elapsed

        0.001087000 seconds user
        0.000000000 seconds sys

Tested-by: Disha Goel<disgoel@linux.ibm.com>

> ---
>   tools/perf/pmu-events/arch/powerpc/power10/pmc.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> index c606ae03cd27..0e0253d0e757 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> @@ -195,7 +195,7 @@
>       "BriefDescription": "Threshold counter exceeded a value of 128."
>     },
>     {
> -    "EventCode": "0x400FA",
> +    "EventCode": "0x500FA",
>       "EventName": "PM_RUN_INST_CMPL",
>       "BriefDescription": "PowerPC instruction completed while the run latch is set."
>     }
