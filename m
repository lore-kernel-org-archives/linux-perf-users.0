Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7222139DD;
	Tue, 18 Jun 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728270; cv=none; b=SbJo9bcsaYKoPPV4aFCIsvTMoQcFnjKlI6Wh2AbySyiWudZ1DDVHi2jxEmJ7cypYMKgon760yjTwedSwL/zGvqx/tyMLflmKgSNTcCcyyMynB7c9KMj707LKAec1TdtIhCDCBD0zpLPcyfAwfdzxC/8idZDG944e4g6XCCZqrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728270; c=relaxed/simple;
	bh=ipNK1DNPjPj02CvIb2UxDssrTu5fGqmSWwIkgO9vXeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoYxgjdsh3QtoJlYpk1HBqkE9k98KeT88Rqd02nIXg6xwDrtSr1GR5niUxA3PEOtRn+yHeg53/UW0zElGW5eyuDLB86Tg4C0Z0XIrbeEmeb/kltZ5Wv6NP+oyhP9z+BFWUBNG+W1CsrkVgvQiMEwW7IMFGROFS+UhZ9hGYn+CVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/8JU4WV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/8JU4WV"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IExTVd026826;
	Tue, 18 Jun 2024 16:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=7fRvitGnLdRLtXoxO7a1YqA4+XuRt4xeHZWtf/PQQYI=; b=C/8JU4WVU2qu
	SGlYG6H5VFeFKzI7hDQC62JpMXNor1OI721VQAjozQ6V03Nvuyy5yanLdb/LPCof
	eEoY60DUpZPL5Wkjrga1mj7dF9txew+YMZzqHfn5U83yA1XqszuubimBgMyMYeGh
	EwbjogNwJYURJ3rBJnZFz3RDXkh+sRXJfrYH+G9syyDkmGwTUSyIOdApHLNa6+CK
	lE36GlamMGZrjzgU9I4d+eTosHCZiPayjVPpUCb6Y64t6Hh+Ejj9jJpZu60qoXBa
	P8M1+nQDfD8M4UK96jgAp8tOwWRTpN/ypRcnAk8X9gF3a/oZ5+vo8mz6g3yswan5
	DlMMOtcwvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yucfh08n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:30:55 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45IGUsPG018154;
	Tue, 18 Jun 2024 16:30:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yucfh08mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:30:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45IF0giq023874;
	Tue, 18 Jun 2024 16:30:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9q4ywh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:30:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45IGUpXL25690762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:30:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA9D5806E;
	Tue, 18 Jun 2024 16:30:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C98C58067;
	Tue, 18 Jun 2024 16:30:41 +0000 (GMT)
Received: from [9.43.113.104] (unknown [9.43.113.104])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 16:30:41 +0000 (GMT)
Message-ID: <f6af24a0-4a00-4d06-bff9-50d78bdd9b23@linux.ibm.com>
Date: Tue, 18 Jun 2024 22:00:39 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf sched map: Add command-name, fuzzy-name options
 to filter the output map
To: Chen Yu <yu.c.chen@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240617125006.31654-1-vineethr@linux.ibm.com>
 <ZnGRDyWrAUHnghtb@chenyu5-mobl2>
Content-Language: en-US
Reply-To: ZnGRDyWrAUHnghtb@chenyu5-mobl2.dal12v.mail.ibm.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ZnGRDyWrAUHnghtb@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _w_hedYibiKhmSHg5V0-KUrwr1PK9IHX
X-Proofpoint-ORIG-GUID: P433UZO4a02CohMc0U45QMzDt7Pjr6uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180123

Hi Chen Yu,

On 18/06/24 19:22, Chen Yu wrote:
> On 2024-06-17 at 18:19:30 +0530, Madadi Vineeth Reddy wrote:
> 
>> +static struct CommandList *parse_commands(const char *commands)
>> +{
>> +	char *commands_copy = strdup(commands);
> 
> Should we check if commands_copy is NULL in case of allocation failure?
> 

Thank you for the suggestion. I will fix it and send a v4.

Thanks and Regards
Madadi Vineeth Reddy

>> +	char *token = strtok(commands_copy, ",");
>> +	struct CommandList *cmd_list = malloc(sizeof(struct CommandList));
>> +
>> +	if (cmd_list == NULL)
>> +		return NULL;
>> +
>> +	cmd_list->command_count = 0;
>> +	cmd_list->command_list = NULL;
>> +
>> +	while (token != NULL) {
>> +		cmd_list->command_list = realloc(cmd_list->command_list, sizeof(char *)
>> +							*(cmd_list->command_count + 1));
>> +		cmd_list->command_list[cmd_list->command_count] = strdup(token);
> 
> ditto.
> 
> thanks,
> Chenyu

