Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCA450FE
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Feb 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579887; cv=none; b=ltItM1G50PtD/g6m47yD2xvlHXVf5SjId3A2eOWdpMtsxMt1bgxML1a1pb1bX4LEV2BTNDjhwP/wUzoux/7bTstTKph3mbBXoEVuqgxrEkaVRI7zJjF8ROywEOxuKFrn0NMiSKoNry/JeG+OjVMw1irdhpTAj9vakv23u0AwuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579887; c=relaxed/simple;
	bh=OAzq24Cgg5GTy9/Fk0bQ117bVlPfx39KI2BMm0bShZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrAEDxVzwdGaoZte0H8Qv3deWGsoS4vce5MSLGYJuaE30QtloF9iHnPpu0ixH5dpdsB4mwKR7ZJnGrVZQZyxcD6e1WgrG5aCzeVoOVPnZ09qN+th6WLujaXoAhmQDIuMiD4Jx9lPMbZxnGNj4eL5whJqcrb67WAZpmnnKy8fSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=te6VY3iH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="te6VY3iH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JL72m41369990;
	Fri, 20 Feb 2026 09:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qLbQbQ
	UrbiZJzcsIZvM1TJuGkb7cReSvsFmhdx1WFOA=; b=te6VY3iHIhlp1VsbD7fitH
	1NfVCKDhQJCFrbKmjVPoP27pE3Te2KBSykHnVUr9EOPjvOSJ4vZ7xOaX7+clpaOl
	oktFQ11I+6mm8LJ0935FJ6LEbNhXR7uXxS51+Ln00VnLBOaSK5BXmshCYRMYjPuH
	NmnqPaybBYHWrktUY09VaMSOe2Df65/hAQ0gIvN3JAn/7Dawh+IaYDoVuTjgQsET
	YcyxjB4Yi0NWnICoXXswZM2yZHJjKVsGHM9Pwe1h+vrWd2kVl9wqutLhhVy4eQfj
	yRxkHRlPMToqajW3YFOG11qJlJuVydhUkywnE5DyCn1TWdsJ75lIesbNWraT45Yg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjrx99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:31:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K48qqh015679;
	Fri, 20 Feb 2026 09:31:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fuec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:31:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K9VIsq52625776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 09:31:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4602F20043;
	Fri, 20 Feb 2026 09:31:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E57D720040;
	Fri, 20 Feb 2026 09:31:17 +0000 (GMT)
Received: from [9.111.12.64] (unknown [9.111.12.64])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 09:31:17 +0000 (GMT)
Message-ID: <53e9060e-cd7d-49eb-a100-7f658fa0f17b@linux.ibm.com>
Date: Fri, 20 Feb 2026 10:31:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: PING [PATCH v4 linux-next] perf parse-events: Fix big-endian
 'overwrite' by writing correct union member
To: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
References: <20260217131456.4085419-1-tmricht@linux.ibm.com>
 <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <9a16463e-c2d9-4ab9-bd1a-a9c6e7981412@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: holjI-Ad2thjQCQ01VzwCLzp4u9fvU0f
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699829e9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=jA90nVa0FwVCZjxjU6cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA3OSBTYWx0ZWRfX0qtkfvoKOPod
 QvqkxQvXcLausKT+INMmmWBAX1q+3UYS3MT9tB4WdtmAPC7PKh+W4DMtdzHEw6Hhu7vtrayl5WW
 YxZzyosYwkZSqWZiFgfchX7AVwjwOXuJ6vuWmgsx9Ib8/oNPr4klts2r8ITRagJbLfFB2PP6JER
 WGWbobVHUGXk9XMBPsZcFqYZZNdzzN8C/cau6qI/Pf7PsJ6QUrXoCq37gjTe1kjgTIoczYuMPzH
 CWZ18P1Gorhf43cmoSN7VgleyXMdxaonKmEH8PHUq6jBlY9zppKy+fQzkhsyjS2Z3iISMiuDdgP
 XcRMCYpPHpZKIv4ep7YbLurE3VgVXHNQdgY1bWVAMTmR0YMmPb3laQbl7erCdMlSuMQmJ8v4UJx
 RQtE8HhWPxhWieL5lKQyFNweFjQedsWsLcQSi1ei2iL1t3lXSr/1GTHMyVe1Hu4IfdqqdMqB5mZ
 DZuQs2mGopTWWIRxGjQ==
X-Proofpoint-GUID: yXN-Au6A3Vxz-XTEHz8Dwj5MIUyNDBok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200079

On 2/17/26 15:09, James Clark wrote:
> 
> 
> On 17/02/2026 1:14 pm, Thomas Richter wrote:
>> v1 -> v2: Add comments from James Clark and Ian Rogers
>> v2 -> v3: Improve switch statement in add_config_term()
>> v3 -> v4: Fix clang warnings
>>
>> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
>> due to a NULL dereference when the backward mmap path isn't enabled.
>>
>> Reproducer:
>>    # ./perf test -F 'Read backward ring buffer'
>>    Segmentation fault (core dumped)
>>    # uname -m
>>    s390x
>>    #
>>
>> Root cause:
>> get_config_terms() stores into evsel_config_term::val.val (u64) while later
>> code reads boolean fields such as evsel_config_term::val.overwrite.
>> On big-endian the 1-byte boolean is left-aligned, so writing
>> evsel_config_term::val.val = 1 is read back as
>> evsel_config_term::val.overwrite = 0,
>> leaving backward mmap disabled and a NULL map being used.
>>
>> Store values in the union member that matches the term type, e.g.:
>>    /* for OVERWRITE */
>>    new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
>> to fix this. Improve add_config_term() and add two more parameters for
>> string and value. Function add_config_term() now creates a complete node
>> element of type evsel_config_term and handles all evsel_config_term::val
>> union members.
>>
>> Impact:
>> Enables backward mmap on big-endian and prevents the crash.
>> No change on little-endian.
>>
>> Output after:
>>   # ./perf test -Fv 44
>>   --- start ---
>>   Using CPUID IBM,9175,705,ME1,3.8,002f
>>   mmap size 1052672B
>>   mmap size 8192B
>>   ---- end ----
>>   44: Read backward ring buffer                         : Ok
>>   #
>>
>> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
>> Cc: James Clark <james.clark@linaro.org>
>> Cc: Ian Rogers <irogers@google.com>
>> ---
>>   tools/perf/util/parse-events.c | 82 +++++++++++++++++++++++++++-------
>>   1 file changed, 65 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index b9efb296bba5..7b4629625b1e 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1117,7 +1117,7 @@ static int config_attr(struct perf_event_attr *attr,
>>     static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>>                            struct list_head *head_terms,
>> -                         bool weak)
>> +                         bool weak, char *str, u64 val)
>>   {
>>       struct evsel_config_term *t;
>>   @@ -1128,8 +1128,62 @@ static struct evsel_config_term *add_config_term(enum evsel_term_type type,
>>       INIT_LIST_HEAD(&t->list);
>>       t->type = type;
>>       t->weak    = weak;
>> +
>> +    switch (type) {
>> +    case EVSEL__CONFIG_TERM_PERIOD:
>> +    case EVSEL__CONFIG_TERM_FREQ:
>> +    case EVSEL__CONFIG_TERM_STACK_USER:
>> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
>> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
>> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
>> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
>> +    case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>> +        t->val.val = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_TIME:
>> +        t->val.time = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_INHERIT:
>> +        t->val.inherit = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_OVERWRITE:
>> +        t->val.overwrite = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_MAX_STACK:
>> +        t->val.max_stack = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_MAX_EVENTS:
>> +        t->val.max_events = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_PERCORE:
>> +        t->val.percore = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_AUX_OUTPUT:
>> +        t->val.aux_output = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>> +        t->val.aux_sample_size = val;
>> +        break;
>> +    case EVSEL__CONFIG_TERM_CALLGRAPH:
>> +    case EVSEL__CONFIG_TERM_BRANCH:
>> +    case EVSEL__CONFIG_TERM_DRV_CFG:
>> +    case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
>> +    case EVSEL__CONFIG_TERM_AUX_ACTION:
>> +        if (str) {
>> +            t->val.str = strdup(str);
>> +            if (!t->val.str) {
>> +                zfree(&t);
>> +                return NULL;
>> +            }
>> +            t->free_str = true;
>> +        }
>> +        break;
>> +    default:
>> +        t->val.val = val;
>> +        break;
>> +    }
>> +
>>       list_add_tail(&t->list, head_terms);
>> -
>>       return t;
>>   }
>>   @@ -1142,7 +1196,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>>           struct evsel_config_term *new_term;
>>           enum evsel_term_type new_type;
>>           bool str_type = false;
>> -        u64 val;
>> +        u64 val = 0;
>>             switch (term->type_term) {
>>           case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
>> @@ -1234,20 +1288,15 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>>               continue;
>>           }
>>   -        new_term = add_config_term(new_type, head_terms, term->weak);
>> +        /*
>> +         * Note: Members evsel_config_term::val and
>> +         * parse_events_term::val are unions and endianness needs
>> +         * to be taken into account when changing such union members.
>> +         */
>> +        new_term = add_config_term(new_type, head_terms, term->weak,
>> +                       str_type ? term->val.str : NULL, val);
>>           if (!new_term)
>>               return -ENOMEM;
>> -
>> -        if (str_type) {
>> -            new_term->val.str = strdup(term->val.str);
>> -            if (!new_term->val.str) {
>> -                zfree(&new_term);
>> -                return -ENOMEM;
>> -            }
>> -            new_term->free_str = true;
>> -        } else {
>> -            new_term->val.val = val;
>> -        }
>>       }
>>       return 0;
>>   }
>> @@ -1277,10 +1326,9 @@ static int add_cfg_chg(const struct perf_pmu *pmu,
>>       if (bits) {
>>           struct evsel_config_term *new_term;
>>   -        new_term = add_config_term(new_term_type, head_terms, false);
>> +        new_term = add_config_term(new_term_type, head_terms, false, NULL, bits);
>>           if (!new_term)
>>               return -ENOMEM;
>> -        new_term->val.cfg_chg = bits;
>>       }
>>         return 0;
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 

Friendly ping, this still fails in linux-next...

Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
