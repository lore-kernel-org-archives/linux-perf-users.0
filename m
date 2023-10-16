Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F62E656
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hwYPQixH"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBFE112
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 09:12:00 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GGA2i8016805;
	Mon, 16 Oct 2023 16:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=YznZj49QJ98hQxgbzTe3UZnGZ0YsIf3ye5ioISIqHbE=;
 b=hwYPQixH6+/gWn9oKCfUFSAs885ZU21R5vyipx4Xa212gqsS/RaEQl3kRmvWecjKnNUI
 V51VHduxzCggsUU0KS+t42wZn3txMAOJ123ZaACErzIhxwQl9h6DBADlYzkB7SGUbnh/
 LeqkBqBgk0HqAzyrdBKkwmJASmR2rT4YyRo0cV2hukrezngjEJJlWi41JOV9B8uTZzsK
 6HIMUqgKZEkMMPDojdE/5stVHa/WjOBkwHxlpOjuhEbXR55mUjcMpoZF0Mzx/JAM12y8
 uDWVfHQUpg7L4hu01zy+qjKh3Ul3AZQ9UBiwm36TTLtkyBVkk0hpFOZEfxsaZ2V7cgrM Yg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts8eyr3nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Oct 2023 16:11:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39GEWkTW027385;
	Mon, 16 Oct 2023 16:11:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5as269y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Oct 2023 16:11:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39GGBo7a41091512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Oct 2023 16:11:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0AFA2004B;
	Mon, 16 Oct 2023 16:11:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E3620049;
	Mon, 16 Oct 2023 16:11:49 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.114.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Oct 2023 16:11:48 +0000 (GMT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] perf vendor events: Update PMC used in PM_RUN_INST_CMPL
 event for power10 platform
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231016143110.244255-1-kjain@linux.ibm.com>
Date: Mon, 16 Oct 2023 21:41:37 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38FC504F-837B-48A3-B55F-CE79A0C4ADAF@linux.vnet.ibm.com>
References: <20231016143110.244255-1-kjain@linux.ibm.com>
To: Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7AO7i2TEOba0EPzf03SQSOxJFHf7M0j0
X-Proofpoint-GUID: 7AO7i2TEOba0EPzf03SQSOxJFHf7M0j0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 16-Oct-2023, at 8:01 PM, Kajol Jain <kjain@linux.ibm.com> wrote:
>=20
> The CPI_STALL_RATIO metric group can be used to present the high
> level CPI stall breakdown metrics in powerpc, which will show:
>=20
> - DISPATCH_STALL_CPI ( Dispatch stall cycles per insn )
> - ISSUE_STALL_CPI ( Issue stall cycles per insn )
> - EXECUTION_STALL_CPI ( Execution stall cycles per insn )
> - COMPLETION_STALL_CPI ( Completion stall cycles per insn )
>=20
> Commit cf26e043c2a9 ("perf vendor events power10: Add JSON
> metric events to present CPI stall cycles in powerpc)" which added
> the CPI_STALL_RATIO metric group, also modified
> the PMC value used in PM_RUN_INST_CMPL event from PMC4 to PMC5,=20
> to avoid multiplexing of events.
> But that got revert in recent changes. Fix this issue by changing
> back the PMC value used in PM_RUN_INST_CMPL to PMC5.
>=20
> Result with the fix:
>=20
> ./perf stat --metric-no-group -M CPI_STALL_RATIO <workload>
>=20
> Performance counter stats for 'workload':
>=20
>        68,745,426      PM_CMPL_STALL                    #     0.21 =
COMPLETION_STALL_CPI
>         7,692,827      PM_ISSUE_STALL                   #     0.02 =
ISSUE_STALL_CPI
>       322,638,223      PM_RUN_INST_CMPL                 #     0.05 =
DISPATCH_STALL_CPI
>                                                  #     0.48 =
EXECUTION_STALL_CPI
>        16,858,553      PM_DISP_STALL_CYC
>       153,880,133      PM_EXEC_STALL
>=20
>       0.089774592 seconds time elapsed
>=20
> "--metric-no-group" is used for forcing PM_RUN_INST_CMPL to be =
scheduled
> in all group for more accuracy.
>=20
> Fixes: 7d473f475b2a ("perf vendor events: Move JSON/events to =
appropriate files for power10 platform")
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
> ---
> tools/perf/pmu-events/arch/powerpc/power10/pmc.json | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json =
b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> index c606ae03cd27..0e0253d0e757 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
> @@ -195,7 +195,7 @@
>     "BriefDescription": "Threshold counter exceeded a value of 128."
>   },
>   {
> -    "EventCode": "0x400FA",
> +    "EventCode": "0x500FA",
>     "EventName": "PM_RUN_INST_CMPL",
>     "BriefDescription": "PowerPC instruction completed while the run =
latch is set."
>   }
> --=20
> 2.39.3
>=20

