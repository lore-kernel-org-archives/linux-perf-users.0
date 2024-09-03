Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A01D7E2B;
	Tue,  3 Sep 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391906; cv=none; b=Pg7cnrKpmb2P+FY/jpJjFQb8hhvkBWipoxeQEt1hhrFpUXFlxTxuHTkPCqIcmGUFgx6zYqUBI6jaZ5f5LCfXjIpOvGzggdzb9334JlHQpOgIA0+hBXPuJWwd1PWtSwASwODzYRNiks0BDRUke0uuoCh2xqkxCDBL66nVR1m/UWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391906; c=relaxed/simple;
	bh=8NVlSAhPbLS9tVw+K1ap2578F27xZpLzZhH4qSnlQE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=tRha/xIznGX+WSHC48Bb05TN9WwZOtY/fPoDXCa06qSbsSoizoqX7FpyEx+LzhH62CwtZemliHLBSJRi4VRdl4PO8kbiGSplZKHhdZg28Lt2fX+dprpZEgA4jhkcYO2viUeR3WdxnDBYIm1Ut9S7dxQi8LK+gDcMWl9vIMAkX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NQyi+wO+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NQyi+wO+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483JN5wP030261;
	Tue, 3 Sep 2024 19:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=hjwvO+rPhIvu2QQRDyOzFD6wT+
	0RGvlT2tXAAMKBb2I=; b=NQyi+wO+UJdpi9+i+wdL5qcZ3bj3KaoAUuDgPjAt4+
	m1qm63S0spLBmOhqLXWmpkEmlXG/WKSlXqJ74/ELNKoCpNitZL099Eo/q01k0aCy
	1qSKLJWqgW+6AxBAnD1fhDGDKiTgM15WXC0PsTEWiMlRXNxh0ieB/6PoUXLEY7l+
	Ub1V4Nkp7gFchmB640KOaXIAfI1oOHCYdMXxF+KwJGqMNoP0A3YCrw+wXSaYpDcH
	dYBabQ2czIgWhR2wpmhCk3KRCmfoDqMEhUH2/nv/ZVVPOszAjqjPQYGExytjZJCY
	1tlwLDPplrTB9kAAVuxSbTIQUsfLJ2QJ4y70ZuTAi+aQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btuwygkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 19:31:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 483JVJ3n015116;
	Tue, 3 Sep 2024 19:31:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btuwygkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 19:31:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 483H4nbC009151;
	Tue, 3 Sep 2024 19:31:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73kyk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 19:31:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 483JVGWK59441558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Sep 2024 19:31:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FDCA20043;
	Tue,  3 Sep 2024 19:31:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 198C020040;
	Tue,  3 Sep 2024 19:31:16 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Sep 2024 19:31:16 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho
 de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
In-Reply-To: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 3 Sep 2024 12:12:34 -0700")
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
	<20240903073629.2442754-1-svens@linux.ibm.com>
	<20240903090843.GA17936@redhat.com>
	<CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Date: Tue, 03 Sep 2024 21:31:15 +0200
Message-ID: <yt9d7cbso7p8.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oHyLFMB79jshGnAwcS6io3lm6FwAGjP5
X-Proofpoint-ORIG-GUID: uEDhFTZ9rOsVYy_LgtFzxa7rv1kNgqfA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=651 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030149

Hi Linus,

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 3 Sept 2024 at 02:09, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> but with or without this fix __create_xol_area() also needs
>>
>>         area->xol_mapping.mremap = NULL;
>
> I think the whole thing needs to be zeroed out.
>
> It was always horribly buggy. The close thing just made it more
> *obviously* buggy, because closing a vma is a lot more common than
> mremap'ing it.
>
> Either use kzalloc(), or do a proper initializer something like this:

I sent a patch which does this today:

https://lore.kernel.org/all/20240903102313.3402529-1-svens@linux.ibm.com/
