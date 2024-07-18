Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FE78C7F;
	Thu, 18 Jul 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292506; cv=none; b=J57gR5o8OkQIxrZd2MvbmSLksUoLrW1uQ/HcP6e2bFarEq3DfPRUY1u2dBsC9rRFqO48dDLRDvKsDqg/FtKaVp3imTfKxMgICBIuCTPmsam9yj0IFJ0a3ERuvUkZjW9dMHNP6uZ4hEb66CnsHJP2CrOlFrb+3qv3WPwoJz/p3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292506; c=relaxed/simple;
	bh=M8B7nK5QS1XayxeoEXQ34C+iSS2fuBashk39HHL2JsU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UXar+jwa8/ayTcuN36w4CIm0PSMY/JBo5xxYdoyhIfhxBjNKus9VS+0MUHedQy4wG4tgeZTyEUOjBmoaPNdHzsOLRTfVSV5rdUIcD5iSybGNvteXZ0hT4070G9aRYuo4SOxg317tfrNmfwL/OOPowoVyjnBgNvK6PTKLfT1UZZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ph9l9f2B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ph9l9f2B"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I7vD9s010017;
	Thu, 18 Jul 2024 08:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	t6qHBKoOTZCAntpCci5zD8gB9Up74avaeJCF1kFQXcg=; b=ph9l9f2BTYspNd8G
	OcHqzOayb5mqd3RC/o9iAIGqgUbTRTP4TKE3Fi5ztEQpxaT6MI1GvHmqmUfGgCIk
	ECfKNhRbVphR7VvSuls2vAgDEcUyVZhUm5jfUj54vML8Bq30/gbHvb14rytAf8g3
	XOI1LNTlMD0G9xh42fs1DQ7i371SLepQNQa5ZYQvFEEbN1woDB3bDAoHL7yuw+2s
	D/bLvI3lS4mRlRc2LcC9uVhuGYPTLOiF9+E1/AgUYMjXQ9YdUosxEpKK+63MCTmu
	i7VPkVuhS0pMlVqEg3nMlLr4CHTeW+DfO6I36IbJjVgqvsvVtpLSm2BWQqTbdeT7
	q0fuGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40eev9aghc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:48:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I8m9pV023545;
	Thu, 18 Jul 2024 08:48:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40eev9agh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:48:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I50lmp006337;
	Thu, 18 Jul 2024 08:48:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmgs69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:48:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I8m2dE55575014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 08:48:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E952004B;
	Thu, 18 Jul 2024 08:48:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4EF320040;
	Thu, 18 Jul 2024 08:47:59 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 08:47:59 +0000 (GMT)
Message-ID: <6645190c-e66f-49db-a23d-e08f6308a422@linux.ibm.com>
Date: Thu, 18 Jul 2024 14:17:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Avoid python leak sanitizer test failures
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20240717165717.1315003-1-irogers@google.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20240717165717.1315003-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6cSHL7E-ksIuD889sKrLbRPMT5vLkiDW
X-Proofpoint-GUID: MssmmmpBkH6WQ8HBJ79YHge55LoAFZxA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_04,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180054

Hi,


On 17/07/24 22:27, Ian Rogers wrote:

> Leak sanitizer will report memory leaks from python and the leak
> sanitizer output causes tests to fail. For example:
>
> ```
> $ perf test 98 -v
>   98: perf script tests:
> --- start ---
> test child forked, pid 1272962
> DB test
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.046 MB /tmp/perf-test-script.x0EktdCel8/perf.data (8 samples) ]
> call_path_table((1, 0, 0, 0)
> call_path_table((2, 1, 0, 140339508617447)
> call_path_table((3, 2, 2, 0)
> call_path_table((4, 3, 3, 0)
> call_path_table((5, 4, 4, 0)
> call_path_table((6, 5, 5, 0)
> call_path_table((7, 6, 6, 0)
> call_path_table((8, 7, 7, 0)
> call_path_table((9, 8, 8, 0)
> call_path_table((10, 9, 9, 0)
> call_path_table((11, 10, 10, 0)
> call_path_table((12, 11, 11, 0)
> call_path_table((13, 12, 1, 0)
> sample_table((1, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954119000, -1, 0, 0, 0, 0, 1, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
> sample_table((2, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954137053, -1, 0, 0, 0, 0, 1, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
> sample_table((3, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954140089, -1, 0, 0, 0, 0, 9, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
> sample_table((4, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954142376, -1, 0, 0, 0, 0, 155, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
> sample_table((5, 1, 1, 1, 1, 1, 1, 8, -2058824120, 588306954144045, -1, 0, 0, 0, 0, 2493, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
> sample_table((6, 1, 1, 1, 1, 1, 12, 77, -2046828595, 588306954145722, -1, 0, 0, 0, 0, 47555, 0, 0, 128933429281, 0, 0, 13, 0, 0, 0, -1, -1))
> call_path_table((14, 9, 14, 0)
> call_path_table((15, 14, 15, 0)
> call_path_table((16, 15, 0, -1040969624)
> call_path_table((17, 16, 16, 0)
> call_path_table((18, 17, 17, 0)
> call_path_table((19, 18, 18, 0)
> call_path_table((20, 19, 19, 0)
> call_path_table((21, 20, 13, 0)
> sample_table((7, 1, 1, 1, 2, 1, 13, 46, -2053700898, 588306954157436, -1, 0, 0, 0, 0, 964078, 0, 0, 128933429281, 0, 0, 21, 0, 0, 0, -1, -1))
> call_path_table((22, 1, 21, 0)
> call_path_table((23, 22, 22, 0)
> call_path_table((24, 23, 23, 0)
> call_path_table((25, 24, 24, 0)
> call_path_table((26, 25, 25, 0)
> call_path_table((27, 26, 26, 0)
> call_path_table((28, 27, 27, 0)
> call_path_table((29, 28, 28, 0)
> call_path_table((30, 29, 29, 0)
> call_path_table((31, 30, 30, 0)
> call_path_table((32, 31, 31, 0)
> call_path_table((33, 32, 32, 0)
> call_path_table((34, 33, 33, 0)
> call_path_table((35, 34, 20, 0)
> sample_table((8, 1, 1, 1, 2, 1, 20, 49, -2046878127, 588306954378624, -1, 0, 0, 0, 0, 2534317, 0, 0, 128933429281, 0, 0, 35, 0, 0, 0, -1, -1))
>
> =================================================================
> ==1272975==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 13628 byte(s) in 6 object(s) allocated from:
>      #0 0x56354f60c092 in malloc (/tmp/perf/perf+0x29c092)
>      #1 0x7ff25c7d02e7 in _PyObject_Malloc /build/python3.11/../Objects/obmalloc.c:2003:11
>      #2 0x7ff25c7d02e7 in _PyObject_Malloc /build/python3.11/../Objects/obmalloc.c:1996:1
>
> SUMMARY: AddressSanitizer: 13628 byte(s) leaked in 6 allocation(s).
> --- Cleaning up ---
> ---- end(-1) ----
>   98: perf script tests                                               : FAILED!
> ```
>
> Disable leak sanitizer when running specific perf+python tests to
> avoid this. This causes the tests to pass when run with leak
> sanitizer.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/script.sh             | 3 +++
>   tools/perf/tests/shell/test_task_analyzer.sh | 3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
> index c1a603653662..d3e2958d2242 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -61,7 +61,10 @@ _end_of_file_
>   	esac
>   
>   	perf record $cmd_flags -o "${perfdatafile}" true
> +	# Disable lsan to avoid warnings about python memory leaks.
> +	export ASAN_OPTIONS=detect_leaks=0
>   	perf script -i "${perfdatafile}" -s "${db_test}"
> +	export ASAN_OPTIONS=
>   	echo "DB test [Success]"
>   }
>   
> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
> index 92d15154ba79..cb02bf23e6a5 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -11,6 +11,9 @@ if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
>     export PERF_EXEC_PATH=$perfdir
>   fi
>   
> +# Disable lsan to avoid warnings about python memory leaks.
> +export ASAN_OPTIONS=detect_leaks=0
> +
>   cleanup() {
>     rm -f perf.data
>     rm -f perf.data.old

Looks good, and test passes with this patch:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Linux-ci build test results: 
https://github.com/adi-g15-ibm/linux-ci/actions?query=branch%3Atmp-test-branch-25073


Thanks,
Aditya Gupta

