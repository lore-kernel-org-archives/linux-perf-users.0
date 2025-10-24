Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7530275F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295223; cv=none; b=mFkT9G7W3cCGdPWZk4T6+43vzCKfMUzecZ/HsLJcMreIV7rjWnoB4o0YEma0extyG5nPo33k0yeffevrYhGN92J0l2xpLlMqMdGYQRddpv9vABo928rtckzmR8rLiWdTk3mbw6mFvQVsgE6QhUQaoUksd6XSkdGDVfgYBzVn3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295223; c=relaxed/simple;
	bh=4+/hJyctbnAMfKvzYqXVKPk4EgYr3yxy4kXQ/o/ThQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWX9uxb4BJ7gepJh8CiPSG+ofhVHUPqcv854urd20Fq/SUESmvq9uLdfko/uDsWxqko2nvsLXJuY2iEmuU8VSRRKxEj7EXvTDRzD2AXhj1c8WfK6VfEzoKEE3EeTOxMA6D15hfstj94WpnR9izgJv+zm6cyrlvks70woHCHrj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vyk38h2M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vyk38h2M"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NK9nrl001343;
	Fri, 24 Oct 2025 08:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d+xFyq
	yygpL4vMqxkLeOiVpQSqjsxKD+1Y2rSIN6Ulg=; b=Vyk38h2Mj45oLqbLjMAT2O
	bv9pa0tSZDwM7vFEpVjFnSczNCtc4PqDJ+yiCpNp7CaF8BhnNRePqpCcMpqtW9W+
	4KG0e8yJKp+yny1AcjMIZGK0lF5WTAK8C6OswP1h7fMS3wWK0jRaXF3RoO9bLte3
	uR2FqphsPE7L8y7pQJiuC+JXNQVUVcwnBGtwFnHtopF0X4APgaX71nkNjEgUXb5B
	9ThENqCsN8fQtABT8JbGeqzNbOOLUYhQLa+D/MtErTGuK+noEHGWuI5QLZbvAy6G
	set9rvWFfqwZx+Zs1G7KVVm7hydM6/6n6Le5oHqcpUQEAgZLYQNxjXVCTbdjj/0g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hvs1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 08:40:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O8e5Kf030657;
	Fri, 24 Oct 2025 08:40:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hvs1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 08:40:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6DNl7024686;
	Fri, 24 Oct 2025 08:40:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqka5ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 08:40:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59O8e2r538404556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 08:40:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 935692007E;
	Fri, 24 Oct 2025 08:40:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 190242007D;
	Fri, 24 Oct 2025 08:40:02 +0000 (GMT)
Received: from [9.111.38.60] (unknown [9.111.38.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 08:40:02 +0000 (GMT)
Message-ID: <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
Date: Fri, 24 Oct 2025 10:40:01 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling
 test"
To: Anubhav Shelat <ashelat@redhat.com>, mpetlan@redhat.com, acme@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com, james.clark@linaro.org
References: <20251023132406.78359-2-ashelat@redhat.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251023132406.78359-2-ashelat@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX65Rf8VR5pgS9
 R/31XTbVn0TGMQYVmX3HA4tZsJv+2TI16hNWFlbr9UWP83Jkhwo70UbAFyjSHJVban0zztIA4tg
 V6mQMRMV4PRv9Ze7NokEgou/Dl8O0hbbyuBaOJLinUwvcM5TQyBWbgF2cry0c6yPRG6reRBwHGB
 LNuqX40/zVZyRXXjvGSIx7xHw0BhcU7z+vVXZP/WZbEmpOGjy4yhD5S5OTePSXiY6PkVeT79bGz
 mtDgpk6MKBCZf4VlrE5lhhPfnol9z5MbPWHziyGa3uVqBTF00tBE5U9URMKh/3UNDYff/UlCc9f
 uKXJXWKcSxJig3EVjxFXDItGUKCf+CbC99qi1ui651aJuAc6fv0PC0uwklaL7C2W9evLb7FqxID
 k3gnYoM+bdepFwAwKKjGEfxKYVzgkg==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb3b66 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=EgBWLl9G_aM1qIDVBUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: liBayK5frHfilyVoN0ZRIKFbCO3xENHW
X-Proofpoint-ORIG-GUID: 497d0hIN6Gt9yxn02gZZIS41LJDD_9QW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On 10/23/25 15:24, Anubhav Shelat wrote:
> This reverts commit 1c5721ca89a1c8ae71082d3a102b39fd1ec0a205.
> 
> The throttling bug has been fixed in 9734e25fbf5a perf: Fix the throttle
> logic for a group. So this commit can be reverted.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/tests/shell/record.sh | 33 ++++++--------------------------
>  1 file changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 0f5841c479e7..13e0d6ef66c9 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -267,43 +267,22 @@ test_leader_sampling() {
>      err=1
>      return
>    fi
> -  perf script -i "${perfdata}" | grep brstack > $script_output
> -  # Check if the two instruction counts are equal in each record.
> -  # However, the throttling code doesn't consider event grouping. During throttling, only the
> -  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
> -  # let's set the tolerance rate to 80%.
> -  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
>    index=0
> -  valid_counts=0
> -  invalid_counts=0
> -  tolerance_rate=0.8
> +  perf script -i "${perfdata}" | grep brstack > "${script_output}"
>    while IFS= read -r line
>    do
> +    # Check if the two instruction counts are equal in each record
>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>      then
> -      invalid_counts=$(($invalid_counts+1))
> -    else
> -      valid_counts=$(($valid_counts+1))
> +      echo "Leader sampling [Failed inconsistent cycles count]"
> +      err=1
> +      return
>      fi
>      index=$(($index+1))
>      prev_cycles=$cycles
>    done < "${script_output}"
> -  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
> -  if (( $(bc <<< "$total_counts <= 0") ))
> -  then
> -    echo "Leader sampling [No sample generated]"
> -    err=1
> -    return
> -  fi
> -  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
> -  if [ $isok -eq 1 ]
> -  then
> -     echo "Leader sampling [Failed inconsistent cycles count]"
> -     err=1
> -  else
> -    echo "Basic leader sampling test [Success]"
> -  fi
> +  echo "Basic leader sampling test [Success]"
>  }
>  
>  test_topdown_leader_sampling() {

I disagree here. Reverting this patch cause the test case to fail very often on s390.
The test fails about every 2nd run, because the is one run-away value out of many.
Here is an example:

# ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.015 MB perf.data (74 samples) ]
[root@b83lp65 perf]# perf script | grep brstack
            perf  136408 340637.903395:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
            perf  136408 340637.903396:    1377000 cycles:           1171664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
            perf  136408 340637.903396:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf  136408 340637.903397:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf  136408 340637.903398:    1377000 cycles:           11716e8 brstack_bench+0xa8 (/root/linux/tools/perf/perf)
            perf  136408 340637.903398:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
            perf  136408 340637.903399:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136408 340637.910844:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
            perf  136408 340637.910844:   39843371 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
            perf  136408 340637.910845:    1377000 cycles:           1171632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
            perf  136408 340637.910846:    1377000 cycles:           1171692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
            perf  136408 340637.910847:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
            perf  136408 340637.910847:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136408 340637.910848:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
            perf  136408 340637.910848:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
            perf  136408 340637.910849:    1377000 cycles:           11717ae brstack+0x86 (/root/linux/tools/perf/perf)
            perf  136408 340637.910850:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136408 340637.910850:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
            perf  136408 340637.910851:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
            perf  136408 340637.910851:    1377000 cycles:           117159e brstack_bar+0x6 (/root/linux/tools/perf/perf)
            perf  136408 340637.910852:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
            perf  136408 340637.910853:    1377000 cycles:           117179e brstack+0x76 (/root/linux/tools/perf/perf)
            perf  136408 340637.910853:    1377000 cycles:           1171606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
            perf  136408 340637.910854:    1377000 cycles:           11716d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
            perf  136408 340637.910855:    1377000 cycles:           1171612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
            perf  136408 340637.910855:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136408 340637.910856:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
            perf  136408 340637.910856:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136408 340637.910857:    1377000 cycles:           1171632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
.... many more lines with identical cycles value.

I have contacted our hardware/firmware team, but have not gotten a response back.
I still think this has to do with s390 LPAR running under hyperviser control and I do not know what
happens when the hipervisor kicks in.

I agree with James Clark that this should be handled transperently by the hipervisor, that means
stopping the LPAR should stop the CPU measurement unit, before giving control to a different lpar.

But what happens when the hipervisor just kicks in and returns to the same LPAR again? Or does
some admin work on behalf of this LPAR. As long as I can not answer this question, I would like
to keep some ratio to handle run-away values.

As said before, this happens in roughly 50% of the runs...

Here is a run where the test succeeds without a run-away value:

# ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.015 MB perf.data (70 samples) ]
# perf script | grep brstack
            perf  136455 341212.430466:    1377000 cycles:           117159e brstack_bar+0x6 (/root/linux/tools/perf/perf)
            perf  136455 341212.430467:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430468:    1377000 cycles:           1171612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
            perf  136455 341212.430468:    1377000 cycles:           1171656 brstack_bench+0x16 (/root/linux/tools/perf/perf)
            perf  136455 341212.430469:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
            perf  136455 341212.430469:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430470:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
            perf  136455 341212.430471:    1377000 cycles:           11716c6 brstack_bench+0x86 (/root/linux/tools/perf/perf)
            perf  136455 341212.430471:    1377000 cycles:           1171622 brstack_foo+0x3a (/root/linux/tools/perf/perf)
            perf  136455 341212.430472:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430472:    1377000 cycles:           1171692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
            perf  136455 341212.430473:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
            perf  136455 341212.430474:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
            perf  136455 341212.430474:    1377000 cycles:           117169a brstack_bench+0x5a (/root/linux/tools/perf/perf)
            perf  136455 341212.430475:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430475:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430476:    1377000 cycles:           11716e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
            perf  136455 341212.430476:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430477:    1377000 cycles:           11715e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
            perf  136455 341212.430478:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
            perf  136455 341212.430478:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
            perf  136455 341212.430479:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
            perf  136455 341212.430479:    1377000 cycles:           1171598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
            perf  136455 341212.430480:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430481:    1377000 cycles:           11715fc brstack_foo+0x14 (/root/linux/tools/perf/perf)
            perf  136455 341212.430481:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
            perf  136455 341212.430482:    1377000 cycles:           11716ee brstack_bench+0xae (/root/linux/tools/perf/perf)
            perf  136455 341212.430482:    1377000 cycles:           1171664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
            perf  136455 341212.430483:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
            perf  136455 341212.430484:    1377000 cycles:           117170c brstack_bench+0xcc (/root/linux/tools/perf/perf)
            perf  136455 341212.430484:    1377000 cycles:           11715cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
# 

So please let this code in otherwise we need an s390 specific check for success.

Thanks a lot
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
