Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6025F794;
	Mon, 28 Apr 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830973; cv=none; b=RVBKbe9j9TkDiVV9YfLCp+EWCRgxWIwG48gmh/6K+3SdU5DtAvvllxBzefraCHl9sKdoct/E7ZQ/qNQWXBIHdrmCHoRXMLUfSGCavEEGVjJcDYiidpJQ/q6YWCTh/LOOXX//ffOzdwDpbu9YsjxBtjkqSZbP+pNHXE7crCZrWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830973; c=relaxed/simple;
	bh=jk2xPovHc5F6l7T8mmd6XwqbNZPK/rB+qGPsEbuP4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bn6YaAexS+A98BRtgXPj/WIo9b0492LYK0N+LScVmuNGHcgmuG4RGcgllmh/AOedQA3JMgDHwAGkvkGRnj9QYHq3wrNqbKOC+/ZkBSCBrNYe89KJYGtwiGXqs57s87fcywMH7X8iBeRHBtqtltohsNxvYBux8YLx0nCSc7DCezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJvkzJn5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJvkzJn5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RMu5b7023190;
	Mon, 28 Apr 2025 09:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2FVh8p
	KWRuaqN3fBqmPyc2Nc7uaC9djDNtBndOlCsIg=; b=nJvkzJn5ZARn6vwwP5m5q9
	FubFQ3/ZU8MiFGZEQu4r5jjAl72RcEC1YVz94xHhI4tOBI1wsbJI92w+nbJkXnbO
	X7/WCbfWcJMjp0roQuJktbH1BGYGllW1b17i0BKvi26TdEdUPPR7W4E+JFrOXux8
	LCced+QhTs6XUn3Ah8RaXUL2W1ZImLE1H/Zho9rwNcvE1YJaIol9Nb/dA0kr5t0X
	rGUZ4fvwRScozf5kLGL9q5/6tx2n+9n5DoEOfrcmkQUN2OIZlYbMDfFCoZuuyRRH
	gLYxdS+zrBvlkFmXkVjK9lB2uYdpsc/un7VJshESFQusfi/rH/jN48nne5l/gAGQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469v5kj87x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 09:01:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53S8nZ83032396;
	Mon, 28 Apr 2025 09:01:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469v5kj87t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 09:01:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8k1ob008518;
	Mon, 28 Apr 2025 09:01:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch2wawx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 09:01:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53S919Un46924108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 09:01:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7720720148;
	Mon, 28 Apr 2025 09:01:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41CFC2013C;
	Mon, 28 Apr 2025 09:01:01 +0000 (GMT)
Received: from [9.111.133.157] (unknown [9.111.133.157])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 09:01:01 +0000 (GMT)
Message-ID: <5aaab4c0-accd-4b37-8093-d2664483f985@linux.ibm.com>
Date: Mon, 28 Apr 2025 11:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] unwind_user/sframe: Add prctl() interface for
 registering .sframe sections
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Weinan Liu <wnliu@google.com>, Blake Jones <blakejones@google.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        "Jose E. Marchesi"
 <jemarch@gnu.org>,
        Alexander Aring <aahringo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20250424201511.921245242@goodmis.org>
 <20250424201824.466438405@goodmis.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250424201824.466438405@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kJDEausPcbwEQ5UVXsuWsVgepzjfRBDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA3MCBTYWx0ZWRfX6HmmDtG6yVbm 5sAPffm3RWr8Ok53wbtDbbgnczO/VpoLTLYRq4daoO8iqz/d3q2DPi3eHMj+BCGax2bpXNgEyjo S+ziWTBLpq701Gr0BXej3kcZnj6JkbIlZ1zJKerDSrG1qOFM4yWTyA3T6noFe07bMAFQAucieMF
 J+81Y6T4ufIayQh429v2nGqLIpEhaUq7C5dPJOVApl7GtBsxy65cuOFyL6B+P0h69e17SqktpJS bSI2/2vC+Fcsaeu6s74MZW57hjf0LDsoSzRBpLkdfdfS8HyQceKTjjsaeJ0vOnUQAXGiMAKuBbd ky8JV+T9iJwIj/q3G6HQDttlCp/2o2noxQ1cNR+lgoaBYi/47uSshxlV6yNHnkHia+Z3HP8OCOL
 dSgXhCRcqnT2uyia/ZX8kCw8lRkB7CSVrBdRd7ZW0HKdTBVkD0NBNTRcTNcxeHCywuQni/VG
X-Proofpoint-GUID: 3C0i5nYl02Er9XYf-2XXf9tbdHY-GiOS
X-Authority-Analysis: v=2.4 cv=DvxW+H/+ c=1 sm=1 tr=0 ts=680f43d9 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=0MvmVg10__VCTnNSAJcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280070

On 24.04.2025 22:15, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> The kernel doesn't have direct visibility to the ELF contents of shared
> libraries.  Add some prctl() interfaces which allow glibc to tell the
> kernel where to find .sframe sections.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h

> +#define PR_ADD_SFRAME			78
> +#define PR_REMOVE_SFRAME		79

Note that those values have been bumped since Josh's v4.  Therefore
Josh's related Glibc patch needs to be updated and Glibc needs to be
rebuild as well.  Otherwise the Kernel won't be able to find any
.sframe sections for DSOs.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

