Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFD285CB9
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126452; cv=none; b=mbcV5dkaXg5Hs08Hej/SIDae/mn3+xDMy59dLVwZ09fjM/M4pGW8k3IuXGoD6D6fb647wlu9PX9rOq6f+dcDyT3eNG81vqfCvjmE2rbQDnNNoMwbI/48SEVjAzK4oiQAXjZrMwr0njZYhHvpfbsUOebSifSXZBmevkzH9L2E12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126452; c=relaxed/simple;
	bh=8qxUkjLgaDFESpcVov+37pBe3LxCqjVHuKeMLJ5daqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFTjLENzjalVl/q0hU52PFmH2BtgLJr4LZu0Dt8h8EfbWdOL2THn89yLge4ythLWrpSeXUuchpk9GXfUxAzxD0sEoMm0O0Ay1mpRJou8BvBRG6hXC685jLYE/iXKDfQOJtNdAeAU8YlDGu0YI/HylyDw1e5sq+Bsgk+0DhhNFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F7L8UsYV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F7L8UsYV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569LbJQg025932;
	Thu, 10 Jul 2025 05:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dOA2S2
	2e+6MmT1LnRvf93hjky0vmdDFv8f1AVrejjLk=; b=F7L8UsYVDdAX9GSUpnFX4M
	WUp86qC9TRI7wMMDY3YnpDDcIexUb1rd9PQ9tlyBWdSpHc0tT/8FP5zJvmfGzOSF
	2NjwLWFQ1CdzFTwUcwj7xmnGNU73eaz801et3DkZJBIHRT58nBlhJXZK6eBGYoMB
	3Y3gJrdxOXzWMhNBqTubJdZ3k2ZEZ+E967hW/I9EMNDrDx9zVNSvidAdgnhIoFgq
	laWCETLs64z2idJqskRszdJi3wRPXxHL5+bXf1f+K9VI7BbmHasBiG0xNNBDK+RH
	NmzrEDQijriGuATIfPPpDiIu5c5jGeIhBVEI+LKINoe7KOTSUdvSHXmEDsE0E3ug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjr9yvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:47:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56A5iJaA020578;
	Thu, 10 Jul 2025 05:47:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjr9yvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:47:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5enDT021561;
	Thu, 10 Jul 2025 05:47:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectv9xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:47:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A5lNra33751568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 05:47:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74B3920043;
	Thu, 10 Jul 2025 05:47:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515DA20040;
	Thu, 10 Jul 2025 05:47:23 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 05:47:23 +0000 (GMT)
Message-ID: <18cb8b10-4788-4d2c-9160-9d88dcec5c91@linux.ibm.com>
Date: Thu, 10 Jul 2025 07:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] perf test: Increase load in lock contention
 test on low-activity systems
To: Jan Polensky <japo@linux.ibm.com>, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
References: <20250709203809.3211178-1-japo@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250709203809.3211178-1-japo@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686f53ee cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EpcKC404fjMj24PwXX-RrdQ4N_JI76Cz
X-Proofpoint-GUID: IeGKfqOt4_3oCzHuUgouBJ_lcO0ukWJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0OCBTYWx0ZWRfXy8GIEhzZby0p 8f6NZK9W+CSOf/Qux7aaHZMEyYLJNpIo0/oOrDku9/ij5kMxNH/VcnCgMO8dZmKGls35+mVRGb7 V3+CtxixqJNC9jzmVZGgRjuXsKHCuOBrgKR2AmEmSCobuLB43X50UX6UuBqcLJwR1KOkxr/ELJV
 goxUhtMFY/9mtr3/XOkf+tSgjDfw8hX2g3buPhD/tzI6Bvdqgo1cp4hKcw4sgg9+X+ICDZZrILs oc0FWQ9FuL0jevSDG3dERAyjzpkIov0WsOtlw8ANd8/lkPAVvhVsItOGzs4Zyyv6hh/XpdPVoQh lEvPv3sD6A9kEi7q9F2r3QdVe3BgYBbZnIhoGJW+H9xmddCjUIFk/4Uis1Jw+RE6Xn4mPkMlEz8
 VcoeKGPNJM6nBygf3m6olGh8waN7AgPmGU82Lp8dczktW73M075Qwehlu/AvUt7rNHaiXVC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100048

On 7/9/25 22:38, Jan Polensky wrote:
> On low-activity systems, the 'kernel lock contention analysis test'
> often fails due to insufficient system load. To address this, the test
> now increases load by using multiple groups and threads in 'perf bench
> sched messaging', scaled to the number of available CPUs.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lock_contention.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index 30d195d4c62f..e859e1503b5c 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -44,7 +44,8 @@ check() {
>  test_record()
>  {
>  	echo "Testing perf lock record and perf lock contention"
> -	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
> +	perf lock record -o ${perfdata} -- perf bench sched messaging \
> +		--group "$(nproc)" --thread "$(nproc)" > /dev/null 2>&1
>  	# the output goes to the stderr and we expect only 1 output (-E 1)
>  	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
> --
> 2.48.1
> 
> 

Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
