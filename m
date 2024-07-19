Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7917BA1;
	Fri, 19 Jul 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406785; cv=none; b=ZkIS/MuYY8qDaO4rz2cpOBxjCrpKhomBQKQLY70DPi46Y/yrVBbB0rxbnxoMZJIXZptxV7Hv0anzeS9FDPsncIyw3LunBo7dnqyanf/IVuaqQ27KXX9+Q9hAotc8U9/6nNuBOGW33pl+HMXe3CZd4DY7kCFd7lLIns44sd9+U/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406785; c=relaxed/simple;
	bh=vCgDxtM92EMcet/2ODbLilYIezMdoV2VzFsAlpmiByg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsqRom4vonlzOQkRg5bHxWX2fbDe9xBPmLZN5eAjZa8dcOG6AOORdeZnlnKfwk3gFD42C/z9gAmPi1O8eG19mkkjzdz9FK5LLLieBWYySV4MpSv3pEvkH4u7uYTZckhYAE50bAaZhH3gML+4yQb1d3fV7FidPtoOuGJ+RMTx+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ne6JvRTb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ne6JvRTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721406747; x=1722011547; i=markus.elfring@web.de;
	bh=tKB/9IfmPQhFDUyEYuYxts3W9iVFsm3A7Nr8lOyjDAQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ne6JvRTbEcEOZwvZlV45xt7xazD8uktJJ6/x8cotkh47eyZHPEKRBLPYmS2s8ZBE
	 eQ9w+x4hmsfyafJCmLrWyDPN3Nkx5itj8Mxpx7UX6YlI1OEwMAUXYpoZsoIr/eFOA
	 YXWEOnMh+ITIvkxoUfLRfI3eKEVnyRgbOCsuyA9ZpW2NqCC7nViGdAQbvB3V92UoF
	 9L1J7umyYkJoKSnnEcUxT0eOfLSsH/V7AzDQOS1UGEBtJ7/+CWxIDW+Hx3AmA1YdD
	 jAwe9cM7nyGeAPfU4ca5/r46+zeJf2wgL0MQpEeYk18F4afqE9l1bmBSvTTLiQRUq
	 /SQf58rFx2WdsOV5Ug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRM5-1rpj0u1xiJ-00e50U; Fri, 19
 Jul 2024 18:32:27 +0200
Message-ID: <b3943cc3-234f-4789-a894-314a3890ac8e@web.de>
Date: Fri, 19 Jul 2024 18:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Avoid duplicate code in fprintf_duration()
To: Christian Heusel <christian@heusel.eu>, linux-perf-users@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <c564da16-062f-4da6-9021-c68f9c6eab63@web.de>
 <c105871a-6462-4678-9f0c-b2ed5a254bb1@heusel.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c105871a-6462-4678-9f0c-b2ed5a254bb1@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:izcLLRtKN2tl5cnMkA2RKDkS0FZOj4kaZVkPTSuhXHCil2apFGj
 mZDo3OOyNt9/QGuNhDKcUHrz4sQ4JqwjtXfS9Gt7UMUr+9/H+1XlwpCD5xnmu+5+B1nKAB7
 tKfwCMHmrHpF6l4vm1qKJGpAHXW4RGTUy2hBolcmMyXGc/ZbIf+7Ux3mTrzHJNhQxwWkqt7
 PMGp66wOR2lbUBoghbIgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qdvJeijTlOU=;xLDU+rJhYO3/M+UsHZgEzc29UmV
 TkjU5Ewn4rgok96ps0o06ljVo124/hLrRJ4oYqok4n1s1IDfackadaxK0kDooufAGcwJMGHZF
 bPasFyTZ94/AYm/V+uJjJUf7JP0kuSyS4bouIxLVKRtVfqi/SKyy/GMs0bb7pLN7vRj9yAbG+
 Nkk1IEa6RoEGeqn6J56P5Wq7XklT+rlYjC4No+CujL8bjU6B+2p3f6PU5qEVrZg59igZ0btmE
 0VVq/pQxb+PhabFYGg1VA6t3FzGdqq6N3LkPFwo2QT8y4ZuQO+ahFtGlDjSF6HanHxVMHJWeW
 svu2YcwIGiRZ8h4+qrGZxt5YI2Xh3SGYS8jzXNKRu+x002eBFEPyCLqgD+TM2OWIffMr/jwhc
 NfmXU9lXzDbG+jwYGTWFCUgx45DfiBDdh+VCO75vYf8HMrxhPHfx7qvRbpjRaOg8sAaH8RiNW
 bkIRMsvSjrHvh8x4yYX2YAq8l8GQNtkVeLtOBMQow+rqPqpMJDRDbW0PxUOSY57VH0CGbt95t
 Z9+HiTVf03bNij714zwqIdNvvstLz9dsPG5Q+s6Mo5Wu73AT0UCAQxcNyrHcMjmA99YiN0TDx
 waW7TRLWxFWoe+0BEtTmF2X1AJwozN1cRqUmMSgAOdx0yV3pn/+Ln2wrKaoZ0XwXqVqdAL2Al
 WsPZ2UOveqOnn/urbvUbsHCWAGc9LXqnun4NXbdnFZAfa7C4zxcgq+jgQMLuYsIx+C2U7zTD1
 zdYvK+UF7FaxXl8d41u99xHEtgUBlHYhfW+NEp0zRF0DKNb0NgcJaVrEOiRagBNXB4VqZhMZ8
 d6xWLCnJSTjCFrqp4JR/bN7Q==

=E2=80=A6
>> +++ b/tools/perf/builtin-trace.c
>> @@ -1258,12 +1258,16 @@ static size_t fprintf_duration(unsigned long t,=
 bool calculated, FILE *fp)
>>
>>  	if (!calculated)
>>  		printed +=3D fprintf(fp, "         ");
>> -	else if (duration >=3D 1.0)
>> -		printed +=3D color_fprintf(fp, PERF_COLOR_RED, "%6.3f ms", duration)=
;
>> -	else if (duration >=3D 0.01)
>> -		printed +=3D color_fprintf(fp, PERF_COLOR_YELLOW, "%6.3f ms", durati=
on);
>>  	else
>> -		printed +=3D color_fprintf(fp, PERF_COLOR_NORMAL, "%6.3f ms", durati=
on);
>> +		printed +=3D color_fprintf(fp,
>> +					 (duration >=3D 1.0
>> +					 ? PERF_COLOR_RED
>> +					 : (duration >=3D 0.01
>> +					   ? PERF_COLOR_YELLOW
>> +					   : PERF_COLOR_NORMAL)),
>> +					 "%6.3f ms",
>> +					 duration);
>
> Why is this a desirable change?

I find it helpful to specify the affected function call only once
in such an if branch.


>                                 Folding the if-statements into the
> ternary operator makes the code quite unreadable compared to what it was
> like before and doesn't give any obvious improvement.

Do you prefer to store the result of the colour determination into another
local variable so that it can be passed as a separate parameter?

Regards,
Markus
