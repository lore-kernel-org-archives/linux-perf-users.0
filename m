Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XShmD2D/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98EDF
	for <linux-perf-users@vger.kernel.org>; Sun,  3 Dec 2023 22:15:22 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B46BG0Q014654;
	Mon, 4 Dec 2023 06:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=o5UFbXoyv9MEufVOOBjSHZAjfaSo65cWJk2nKcflfXM=;
 b=XShmD2D/xP38sFdZHl6sEQy0rDKQZ/4OVpOGBvnXQHh9Ydi0WH4Go4m5IREkcr9J4BT9
 atBKaX7eZVV7Bb0r9+S9ySLf3cmTIsUnHCyRJBn3AC8GhLHqf19BZuTnJFp+WnYlw4fA
 +hKMnfS+CP7J0pCPthPRFLJVpHa0pcxp/hHQOAoOkeEj/t7dlJM8hs/ewiJ8B5hZjieO
 TI6L+vfMEnxWxb59zQ9M88jB9M7XEj78X3pDnLDjWje4yubwTj1tqrTXD9VuBhgsFKji
 uPUt5OJQ2Js2iYo7X8/54+5IU8KDpPlO7RWv3nwsBNkMh7X5rht6/Q73Nb848gpEdc2y 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ur6vb0r9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 06:15:19 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B45cm1Y007533;
	Mon, 4 Dec 2023 06:15:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ur6vb0r9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 06:15:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44ne0b019461;
	Mon, 4 Dec 2023 06:15:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewt6n2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 06:15:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B46FDRs39191150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 06:15:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17FF20043;
	Mon,  4 Dec 2023 06:15:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC5722004B;
	Mon,  4 Dec 2023 06:15:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.171.5.155])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Dec 2023 06:15:08 +0000 (GMT)
Date: Mon, 4 Dec 2023 11:45:03 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v7 0/4] Introduce perf check subcommand
Message-ID: <cju7tubxca3euwkfwqqmpnx4d74zkaijcfcmgzn2ssbbpbhsh6@pd576iaoevoj>
References: <20231116213435.382484-1-adityag@linux.ibm.com>
 <ebgef776v5uvigu2mqkj5mba36cewrhrxzo63fbczrcvyqexlt@nebkf5roy2gv>
 <ZWiPPtwhWHAFfpX8@kernel.org>
 <ZW0bRAi4Yo76TG4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW0bRAi4Yo76TG4c@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SaFu0HQerxVQj6W_eBH92e6R3XhhAvBm
X-Proofpoint-ORIG-GUID: sa5jpVbfLoIE82LPgZ2bxYTUmByK5DXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=936 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040045

On Sun, Dec 03, 2023 at 09:20:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 30, 2023 at 10:33:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 29, 2023 at 12:39:43PM +0530, Aditya Gupta escreveu:
> > > Hi Arnaldo,
> > > Can we get this moving if the series looks good ?
> > 
> > I'm testing and applying it now.
> 
> tomorrow I'll check this:
> 
>    3    28.84 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027)
>     builtin-check.c: In function 'cmd_check':
>     builtin-check.c:132:3: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
>       132 |   strncpy(feature_list, check.feature, strlen(check.feature)+1);
>           |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     builtin-check.c:132:40: note: length computed here
>       132 |   strncpy(feature_list, check.feature, strlen(check.feature)+1);
>           |                                        ^~~~~~~~~~~~~~~~~~~~~
>
> <...snip...>
>

Oh I see, I will fix it in next version.

The idea was that 'feature_list' is basically a non-const copy of
'check.feature', since strtok which has been used later requires it to be
non-const.

'check.feature' size we don't know since it's coming from the argument parser,
so instead of fixing a size for 'feature_list', I am instead using 'strlen' to
get buffer of same size.

I will put strlen into a variable, and use memcpy instead, how does it sound ?

Thanks,
Aditya

