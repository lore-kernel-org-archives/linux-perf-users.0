Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BA176FAB;
	Thu, 20 Jun 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870775; cv=none; b=aMGqf/aRRwY7eIW2MPiTWBoZBPEsjStI/P+2G9UEzLwXPIYj5cBNsF7ldZl1P2ZVyChRUylf8oDl5ft9lbZQoAhDg5RNG953kd8QnaP1EbXb96xvQGWuKj69asJxQuI2L2SHJVQUsIrArLe74QG/yR4Q/6DEqjpM7z1l6k/K6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870775; c=relaxed/simple;
	bh=khxZuLNnlOBsNJrXTBa58zLjY2vHMddMsycJQQOcWc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/9gr4X0w/T6uIqgU38C9y9ZE/fOSR9q/9QHFeRDr+kcbtUQiw5sNCoUI4K2YMDQer5sy6WyHR3vNJN8VJFZJN1i55Z/6RI2PVSO58Wi8FRJl9mdakP1eq9zGHVIrXTQW18WVcOsMY7J4mCjQ863fOTsKMEUnbhXHodjIx87zgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gmo1romH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gmo1romH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K7wguG005744;
	Thu, 20 Jun 2024 08:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	vGuUl/ve6yHgWLHOyONffSjElv0EqPmsEFzjhBZ3SCQ=; b=gmo1romHgQllBoKr
	VJiI8bL/om79dKtI5qZvVPDUEKJufLs1j7xGx7TGAoONuaIAxBufuTwhHa3qzCVt
	YH8Au5cqzx+eC9Q5NIOAgebMEnAoaSeutlI0iTKGpUyz1LkbVflWLdjXfPoNlHS3
	p+9pCFpN5+npoY98a6V7znolIKy6kuxgS5uj9BkgFkucnT2SdwXhdQjuSDjM2z8I
	hk+EHouqyCKDp/qeuxa+SsbZjPqHX+rtcOIsZ54wHF1+lunA+5Tmw2x/v/EVCYaZ
	e96Nw14RQPHuVRz5uVC90dC/qBDKJz2JMT46aC+tFLveS1DsiBuO6HEUGc84gvT9
	Wu+d0w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvggs80jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:06:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K76g4a009425;
	Thu, 20 Jun 2024 08:06:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgn3nsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:06:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K85v1R49742268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 08:05:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D37672004B;
	Thu, 20 Jun 2024 08:05:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B585220043;
	Thu, 20 Jun 2024 08:05:57 +0000 (GMT)
Received: from [9.152.212.23] (unknown [9.152.212.23])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 08:05:57 +0000 (GMT)
Message-ID: <fb82c22e-e72d-4d0b-9e66-29e3975919a4@linux.ibm.com>
Date: Thu, 20 Jun 2024 10:05:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [perf test] 658a8805cb:
 perf-sanity-tests.perf_annotate_basic_tests.fail
To: Namhyung Kim <namhyung@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Cc: lkp@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202406181535.eacba363-oliver.sang@intel.com>
 <CAM9d7cgDUQL82ToJN5kXJpdEm0aTEJmU1iuxCwSK5Vhi2jnpPQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAM9d7cgDUQL82ToJN5kXJpdEm0aTEJmU1iuxCwSK5Vhi2jnpPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZZdbU0iY0_nBJsnT_klbXoAjXM8fo25d
X-Proofpoint-ORIG-GUID: ZZdbU0iY0_nBJsnT_klbXoAjXM8fo25d
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200056

On 6/19/24 20:34, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 18, 2024 at 3:54 AM kernel test robot <oliver.sang@intel.com> wrote:
>>
>>
>>
>> Hello,
>>
>> kernel test robot noticed "perf-sanity-tests.perf_annotate_basic_tests.fail" on:
>>
>> commit: 658a8805cb604260ae9f35ae5e50012e3d1ed5e3 ("perf test: Speed up test case 70 annotate basic tests")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> [test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]
>>
>> in testcase: perf-sanity-tests
>> version:
>> with following parameters:
>>
>>         perf_compiler: gcc
>>
>>
>>
>> compiler: gcc-13
>> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> we didn't observed the issue on parent.
>>
>> f5803651b4a4b67d 658a8805cb604260ae9f35ae5e5
>> ---------------- ---------------------------
>>        fail:runs  %reproduction    fail:runs
>>            |             |             |
>>            :6          100%           6:6     perf-sanity-tests.perf_annotate_basic_tests.fail
> 
> Hmm.. strange.  The only change in the commit is to save
> the output of perf annotate into a file.  I'm not sure if it'd affect
> the test result.  Maybe because of sanitizers..?
> 
> Thanks,
> Namhyung
> 

Apologies that this patches causes trouble.
I retried the patch again on my Intel virtual machine and it did succeed.
I do not know how to help to get this fixed. Please advise.

Thanks a lot

>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
> -- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

