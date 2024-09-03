Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD11C984F;
	Tue,  3 Sep 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355948; cv=none; b=DhmW8PF6mY1plkH0Uy68AiNNlZvzWDt1eIeIVrcHj7iMdD031PEWiBy1EK+Uvbd1i710MQqTQS61RsEVeYQSCkAiaCy71VF3Stef5/iO0CrZF2qT4GD7JWCPuKlPEs8iWSsiJTe8daWb77asqQUhN/NN9h6joZdaRIrUcV7hv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355948; c=relaxed/simple;
	bh=9vKpXNDJSa5XEMHjQtFePtkf4UhKKVqLGwUVgyeDXJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Jy8dYP72/BTdp1albtxO6kj7ygIk2Xc2cvE7l2dwzmJK94LdpgTXOTT8x1OuZvkXy7aEb6515MKOyE0oajE6trJgwS5dbBPJMzEefkk2q07MUhlScjHASQ5xpgUMjxfSJTV6Ch1KfDlkBky09zz59Hfjv3qOu+L5V75btj+gOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YIo0gOXA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YIo0gOXA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4832q46b002730;
	Tue, 3 Sep 2024 09:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=qSifLb6x1zwIny2PFCWIyHyUmI
	krG0SN/fg0te/rcRw=; b=YIo0gOXA4F1FJJfoMsk5v/aJJl33JJIYQDkfNhmezS
	oFKGApbYTIi30DJsEDWgbqgvNyC0nAd5TMrCSQrveQ9a66AEukcg19u2St1zVmsL
	9xKg3HJQY8s7OS1QEg+dWyhBloe7mwROZVjawbFwUQ1dT1DXLwOVHI8Sfkc4olq5
	HZkVyHrh2YvB1i8MEJARmmSiJxaAhR2XaqLsLZu4/qNj9T1qEVl9nbnZCsQ7JI88
	0z5JGRdnNhfKBwTY2o0tUdEBmbG4bVg1Hc05d5TNcgxi7Ri6ffqLZb8OJQkkeMUF
	ljaSE9ETtiAa/stZOfzfXpkckrZ06OevldwVHiUJ2h5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9cx4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 09:32:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4839W8F2027853;
	Tue, 3 Sep 2024 09:32:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9cx4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 09:32:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4838Yghs007930;
	Tue, 3 Sep 2024 09:32:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cfqmsv7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 09:32:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4839W5NT54067458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 09:32:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C642004D;
	Tue,  3 Sep 2024 09:32:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D65420043;
	Tue,  3 Sep 2024 09:32:05 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Sep 2024 09:32:05 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter
 <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
In-Reply-To: <20240903090843.GA17936@redhat.com> (Oleg Nesterov's message of
	"Tue, 3 Sep 2024 11:08:43 +0200")
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
	<20240903073629.2442754-1-svens@linux.ibm.com>
	<20240903090843.GA17936@redhat.com>
Date: Tue, 03 Sep 2024 11:32:05 +0200
Message-ID: <yt9d8qw99j6y.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sr4tz1I6d4hAYZVDJsJkGLaE5aGfXyis
X-Proofpoint-ORIG-GUID: xHkIv-4FlDgm8pLYfOijK6JpAp0X464w
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=800 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030072

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/03, Sven Schnelle wrote:
>>
>> [   44.505448] ==================================================================                                                                      20:37:27 [3421/145075]
>> [   44.505455] BUG: KASAN: slab-use-after-free in special_mapping_close+0x9c/0xc8
>> [   44.505471] Read of size 8 at addr 00000000868dac48 by task sh/1384
>> [   44.505479]
>> [   44.505486] CPU: 51 UID: 0 PID: 1384 Comm: sh Not tainted 6.11.0-rc6-next-20240902-dirty #1496
>> [   44.505503] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
>> [   44.505508] Call Trace:
>> [   44.505511]  [<000b0324d2f78080>] dump_stack_lvl+0xd0/0x108
>> [   44.505521]  [<000b0324d2f5435c>] print_address_description.constprop.0+0x34/0x2e0
>> [   44.505529]  [<000b0324d2f5464c>] print_report+0x44/0x138
>> [   44.505536]  [<000b0324d1383192>] kasan_report+0xc2/0x140
>> [   44.505543]  [<000b0324d2f52904>] special_mapping_close+0x9c/0xc8
>                                        ^^^^^^^^^^^^^^^^^^^^^
> Caused by
>
> 	[PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
> 	https://lore.kernel.org/all/20240812082605.743814-1-mpe@ellerman.id.au/
>
> ?
>
>> +static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
>> +{
>> +	struct xol_area *area = container_of(vma->vm_private_data, struct xol_area, xol_mapping);
>> +
>> +	mutex_lock(&delayed_uprobe_lock);
>> +	delayed_uprobe_remove(NULL, vma->vm_mm);
>> +	mutex_unlock(&delayed_uprobe_lock);
>> +
>> +	if (!area)
>> +		return;
>> +
>> +	put_page(area->pages[0]);
>> +	kfree(area->bitmap);
>> +	kfree(area);
>> +}
>> +
>>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>>  {
>>  	struct mm_struct *mm = current->mm;
>> @@ -1481,6 +1500,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>>
>>  	area->xol_mapping.name = "[uprobes]";
>>  	area->xol_mapping.fault = NULL;
>> +	area->xol_mapping.close = uprobe_clear_state;
>
> LGTM.
>
> but with or without this fix __create_xol_area() also needs
>
> 	area->xol_mapping.mremap = NULL;
>
> ?

I think the code should just use kzalloc() instead of kmalloc() so all
members are cleared. I noticed that when looking into the issue because
the new close member of xol_mapping wasn't initialized. My plan was to
send that change as a separate patch - because it's not related to this
issue.
