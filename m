Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D5238E2A;
	Wed, 11 Dec 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918649; cv=none; b=mCnRvRTHaxTizetKAHFLJOKWy/OpyI8azSjHsMcuP65f91f6koG6eDW0kRm2rq0euKqCTLGqM2Y4aBIsqRz0LLqlYQ81VzA2lF11XT+xDtEoEK1pNiwowR2poO8ukMjtpC/Zi6ACuvl8n4PxHOdoqaVdixYIFWC8+dsMCQyOA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918649; c=relaxed/simple;
	bh=rMPVcZy3p3Qi6CPvdNMvMH1oc6Cd7yGvrAU4VRfJodg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwjTN14KZxkHkZBEjWh6rvljl2aZWUvKgGYsrn3V42BJeHUu1t7y1FQvnqumJvq2LxbjhV7lyNFVUPTP7Xg4FwIFb2+Vk3ExEcE6n+EtTW+aS3chm/9JZI/KWj8wjTCmTaY2kt5H8GMBx85ReTtelKvja77cdNVC0U849+283rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VzjBNOoy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VzjBNOoy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBBmdJx004010;
	Wed, 11 Dec 2024 12:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bk4z+B
	XNc7INWKxnV2jndBKbb+GAjAAU6iqs5XR9nW0=; b=VzjBNOoyA2KHDx7/qiNwcG
	Vukq6i/CLG3RxX5Z6qdyj4mnpfHYr8JzmnItDJ0V6d9p78CzdCPH23Ohuu91sAHI
	gQWBf0OQudbFkoEJKGVxTi4eHOyDcm8u9rlBsflYuLgI+FDrBwNQDRHenF43ctOg
	LhT0aO6XoGd0B+ZS1fwt508j64sGFMuOD4avBQuei6g0gIx1om8P4WCVATAU801H
	Mjq0vECUZFmPzSwbPvhlPF3xHXiAbtucj1Xf93ZKNhAs/VQ3WIrD5mPWUWkLJaw7
	SNs4AxqxVsiIrzl7lZmHfmYf3MBLshPF1RGgOSXVooK5B3Ibq3xCDevBNClm59LA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xkvk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:03:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBBlWqq004062;
	Wed, 11 Dec 2024 12:03:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xkvk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:03:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8mPfv032754;
	Wed, 11 Dec 2024 12:03:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pshgqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:03:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBC3rcY34603662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 12:03:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD6742004F;
	Wed, 11 Dec 2024 12:03:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E082004B;
	Wed, 11 Dec 2024 12:03:51 +0000 (GMT)
Received: from [9.43.88.53] (unknown [9.43.88.53])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 12:03:50 +0000 (GMT)
Message-ID: <32b19139-27f2-4f39-a2ae-25027acc980e@linux.ibm.com>
Date: Wed, 11 Dec 2024 17:33:50 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] tools/perf/tests/shell/base_probe: Enhance
 print_overall_results to print summary information
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, mpetlan@redhat.com, vmolnaro@redhat.com
References: <20241206135254.35727-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20241206135254.35727-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _KR0Nxkvzby3-R667MgtWf1OGbQdV1-o
X-Proofpoint-ORIG-GUID: ExJA96fz_2FZSREYP-9BZBrRlK-wBMQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110085



On 12/6/24 19:22, Athira Rajeev wrote:
> Currently print_overall_results prints the number of
> fails in the summary, example from base_probe tests in
> testsuite_probe:
> 
>  ## [ FAIL ] ## perf_probe :: test_invalid_options SUMMARY ::
> 	11 failures found
> 
> test_invalid_options contains multiple tests and out
> of that 11 failed. Sometimes it could happen that it
> is due to missing dependency in the build or environment
> dependency.
> 
> Example, perf probe -L requires DWARF enabled. otherwise
> it fails as below:
>  ./perf probe -L
>   Error: switch `L' is not available because NO_DWARF=1
> 
> "-L" is tested as one of the option in :
>    for opt in '-a' '-d' '-L' '-V'; do
>    <<perf probe test>>
>    print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument
> 	for $opt"
> 
> Here -a and -d doesn't require DWARF. Similarly there
> are few other tests requiring DWARF. To hint the user that
> missing dwarf could be one issue, update print_overall_results
> to print a comment string along with summary hinting the possible
> cause. Update test_invalid_options.sh and test_line_semantics.sh
> to pass the info about dwarf requirement since these tests
> failed when perf is built without DWARF. Use the check for
> presence of dwarf with "perf check feature" and append the
> hint message based on the result.
> 

Patch looks fine to me.

Reviewed-by: kjain@linux.ibm.com

Thanks,
Kajol Jain

> With the change:
>  ## [ FAIL ] ## perf_probe :: test_invalid_options SUMMARY ::
>  11 failures found :: Some of the tests need DWARF to run
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
> v1 -> v2
>  Check presence of dwarf using "perf check feature". Add
>  failure hint message for dwarf based on this check
> 
> v2 -> v3
>  Check for empty task comment to avoid trailing space
>  at the end as suggested by Michael Petlan
> 
>  tools/perf/tests/shell/base_probe/test_invalid_options.sh | 5 ++++-
>  tools/perf/tests/shell/base_probe/test_line_semantics.sh  | 5 ++++-
>  tools/perf/tests/shell/common/init.sh                     | 5 ++++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> index 1fedfd8b0d0d..c51d8d9bfdb7 100755
> --- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> +++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> @@ -22,6 +22,9 @@ if ! check_kprobes_available; then
>  	exit 0
>  fi
>  
> +# Check for presence of dwarf
> +$CMD_PERF check feature -q dwarf
> +[ $? -ne 0 ] && HINT_FAIL="Some of the tests need DWARF to run"
>  
>  ### missing argument
>  
> @@ -75,5 +78,5 @@ done
>  
>  
>  # print overall results
> -print_overall_results "$TEST_RESULT"
> +print_overall_results "$TEST_RESULT" $HINT_FAIL
>  exit $?
> diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> index d8f4bde0f585..f5d3b6e8d0d6 100755
> --- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> +++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> @@ -23,6 +23,9 @@ if ! check_kprobes_available; then
>  	exit 0
>  fi
>  
> +# Check for presence of dwarf
> +$CMD_PERF check feature -q dwarf
> +[ $? -ne 0 ] && HINT_FAIL="Some of the tests need DWARF to run"
>  
>  ### acceptable --line descriptions
>  
> @@ -51,5 +54,5 @@ done
>  
>  
>  # print overall results
> -print_overall_results "$TEST_RESULT"
> +print_overall_results "$TEST_RESULT" $HINT_FAIL
>  exit $?
> diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
> index 075f17623c8e..259706ef5899 100644
> --- a/tools/perf/tests/shell/common/init.sh
> +++ b/tools/perf/tests/shell/common/init.sh
> @@ -46,10 +46,13 @@ print_results()
>  print_overall_results()
>  {
>  	RETVAL="$1"; shift
> +	TASK_COMMENT="$*"
> +	test -n "$TASK_COMMENT" && TASK_COMMENT=":: $TASK_COMMENT"
> +
>  	if [ $RETVAL -eq 0 ]; then
>  		_echo "$MALLPASS## [ PASS ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY"
>  	else
> -		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found"
> +		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found $TASK_COMMENT"
>  	fi
>  	return $RETVAL
>  }

