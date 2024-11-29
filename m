Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F3198E61;
	Fri, 29 Nov 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888776; cv=fail; b=VcMBEHGtrbC1KinR2Vv/MmKqCuptlmdAbjpDL9+lo0BO0uVm4+mRZSwox9QmnIavM34vCiobGa5rjpmO2S1e6Qrj8E16JP/HXZ7w4MokiyWOEV1Jw8zqf3E3pHG8Y6GPHx97fSRp1FrCTrlh9gQu8CbfOy08YNy5eXA7NScmpRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888776; c=relaxed/simple;
	bh=mfj9eQ0p7gynNzlNu+QPPCsyQh/dT8qAjUYL+Ge2IJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JnF8Yo27swiEqi1qAatNn99IwFIGH0dsBBpLIgKYe54AtKa8Q0BeYvP+ReSTOpfNKu/To+ZEdGHRZvPl8A2Z+G53J4zE5e4yht2T9y+DZ61i3NhShwaJw7DBt+20Kzw8rcPgOYXW3lOgwItr/h8v1e1pCs7Z5tLTcRI2SIih0UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LReitMhT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QLpSmOaH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LReitMhT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QLpSmOaH"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDff0M001103;
	Fri, 29 Nov 2024 13:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=P4MUM+qG1Asm4yfPNf
	NXyfS1VYLtnRlAmjSxa0RDT8g=; b=LReitMhTpcEMT+44cwys5TvGzbEfm75hka
	azPCFSEwRsBbNLS6EJ1VGlPHI1ntDhOYurUAtKJ9rd+dzm6G0HcQlm0psQi7Enrq
	ijZIeMV8rjMsZ/CSTRFr35CUH7v9Uk5rudycSn0fHzf6f1P4+UjNYoVV20mNfI5D
	S30JmYCxOapiUC8WZC7NYq4XGLoSuLRJW+pi79CTSU6dpxhpwFhYz0MTGzYkuQ32
	S1H2Jk+U1hYF4NBMtknNvo81GV5anul/TlCTJ5XkrkBjIJvTxGNmwIYe7latyY56
	54AsPRzyG6qUfi9CpB5D54yOPBtFWgT1jJeNZt8qoTT9tWZ+f9Jg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xybd14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:59:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDPfoX027564;
	Fri, 29 Nov 2024 13:59:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4367056xc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuEPpf2ZI7Rd9NKzQfQL1u7+2yLi8MsybOEmdKvrXr3kXd8GlsCv5MnaBe1lkF0rZK0YUlGZfie/OG54rZaIQuuoX+JjMTQwZtlX5VaqknAIEwQ5hgAh4Ir9n/C8sIwkROa1sW+nNOSHgYrK/8vull3kqipxOWY81kEQBitqUsO9ei+FU+CYRmZ28HY44L5wQopz5/Lo/Rl5ZrMDWYmXn80pxk6PDAh220DNug5Jno9PMeEhiRBJC9GUV2eMuDQK7SREtVu9Tmr4IBCM5w0W4kwzsk8WKjCIfYXuCwbLLdgl/sJZWXrZ59zgbFB1uipzWdgRIi0ds/qNgTWScL/u3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4MUM+qG1Asm4yfPNfNXyfS1VYLtnRlAmjSxa0RDT8g=;
 b=IHUSZr4IIMzjmv5RoLwkVFe2AsTvvfi4UEm3HeQzZ4mABAALm/ctJ8HNle/JN4d8vDhCrmrqzhhf3y4SjYSE7bX9FAdVX6daC78Fyo9l5XZd48JTidP+dN4j8y6PAkiWRc0NpRBCP+hmo7VwlwdtwA80U3SinicNSU47lPls4dNQBstAlcUqtcJ/RbnrkyILDew3QC0gPG99Vl0ef4jQxP27AgyzOCbAPRkNok453uLdn8ZYIjNJJ+rh94ewR56DmeT6D96XCrq4XcKvHohW4hBPIB8v6PHLlst4T01GvSthgIbVEAz9XCaBmalgvWoXAtkedJuV4xV0Z/AdW1ueqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4MUM+qG1Asm4yfPNfNXyfS1VYLtnRlAmjSxa0RDT8g=;
 b=QLpSmOaHP1b+wW+s/JIOG5EGqVm4O0eA0kGVn+vk2rSC/2CsoxWV/TPalrciv/lBrmdIRLT0G9Lpsh+k92tRvYy0LfqBblqGBxDCdRtV6YxMzeI28NGY+CaYCmlnoFMxxXUdKKk9Lj3h2exU8iNJqxPM0zVZSp3RD2JfjMMyeA4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6450.namprd10.prod.outlook.com (2603:10b6:806:2a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 13:59:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 13:59:10 +0000
Date: Fri, 29 Nov 2024 13:59:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <14895682-a013-419f-bee8-1476540ddedd@lucifer.local>
References: <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
 <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
 <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
X-ClientProxiedBy: LO4P123CA0169.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: e42db7d5-0eac-42bf-7f6c-08dd107dffd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5JXlMD15eczRf6rtf94WYbv/3rZloKBOzoMlA0vyTYo++q7ssMLWZoFadKt?=
 =?us-ascii?Q?CH8AfV+mhbQwbA8VmxzzyvNOE0fgIzpmZj0z6UCLDbD73evyLjZAaEzktIDi?=
 =?us-ascii?Q?kOmG8hlyVfrs/1mhxGW5DZdxC43L87oxadPeuQTPi22hF2vIKUtXuRj7hoB4?=
 =?us-ascii?Q?QY9Eg9qXBt0ZC1Jc/AKXTgYiNX3pWV0bjEG5nAcSvkcdYBbamAA0ChROiWR8?=
 =?us-ascii?Q?vfWOxeSoPKddWRqgDIfMJSw8CMB4QXOx0ylgFLy2hRXvX1vGYNq8MGKUg0sD?=
 =?us-ascii?Q?5hz5w84iqJH4zuj1LEezwbmI+e2YubCQAfehzNOFJOuRsAQ/FVLq+WXmTskY?=
 =?us-ascii?Q?aK/1/w702A2tc+fxjzfqdWipJxiNEW6oC+LLZKa7XlrSt9a29Cecfdah9Uix?=
 =?us-ascii?Q?ZDhme16nPNC44JWOZO4gx3yNmHMGCJg6RdIgX4Yjq3KzARPlq8ONXq3ta0cx?=
 =?us-ascii?Q?52DSEVBs6IpaCe4fKhugKjAEGVAGSxWERWIVXzWEn/jJJW2JmKOb7LUq/8E0?=
 =?us-ascii?Q?nZy2afWwYhJaAd3OXhbSvtDq8202lisrUGn3kC9pn2UZlM1iQruZS668KOKD?=
 =?us-ascii?Q?xLIvnauPxD7BQDWk1fDyImPeRQK3f0mmdOItZQZXHSx/ta5U0Q59ivVJV5la?=
 =?us-ascii?Q?p0c1D5fG8MgD6WXS8rZYKUbFS3MRJ/3NNuLRYL6EJyid5YX2vZagj9IUbi2d?=
 =?us-ascii?Q?HRXbPk9g4OcwcIE/w+c3gs7gmXJrvq3OwCCV8g0BTKjf5vTV5bu4HcG4onMG?=
 =?us-ascii?Q?wQ3AA7UkLb0r/zkt9DlYC96qzkYmFANRTfvbH7FC89sx1lK0QYMqCPyQZblS?=
 =?us-ascii?Q?YbYXg61Elx3SNUQ0iZwZV0kzA10MN8uMlqMXirN3wcO95xbG1oBekt4TLWXg?=
 =?us-ascii?Q?ZQP3V//aWQrEOUAMS2H1TzzE/2z/TT9tWFbUdFFp15NfwTGJ8ihyYQwTxIz6?=
 =?us-ascii?Q?Oz6DNaFS2sW2uq+baqUPkzb0m49ywU48AvM0NPxDwICcSWvB0e+oPE0Ew3gZ?=
 =?us-ascii?Q?zB9zWB4iNsyvZiBKriCVwygb2GCCr4n+li2QPMj8f4QPB0AaYRZrLRm3bifv?=
 =?us-ascii?Q?kSEF9Oz5pbHYxQnv/6KSesGRY51eKnLaBfbeV5Z3VvZXb9u1L0JeR0L5HTwn?=
 =?us-ascii?Q?CisXoKVbkkh66Kw8KZZePWBPbAj6K6GH6+2usiNKG30KbYWRi/PPO/CfttHY?=
 =?us-ascii?Q?40NWzm7prevSAPOy1PeNx8gKExOO8Q82JqA7P9iw/Phn0GNQvQTuzAQ0+5qo?=
 =?us-ascii?Q?OiF8fAW5bCTIGBdR+Qa0Db//tlgpA/+QbSQYJXsToxonyZwX7uizqzM/e4zz?=
 =?us-ascii?Q?yLi730Js9lN4VB6usX2PIbKcFpnXjw4pQe1y8DGw0xgg3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlrQQHUJTf6O8mKeXbW0GvvpOE7t3bZGDwcF8aNDJLh+tQkk0uv+pYhHUyXR?=
 =?us-ascii?Q?DAmTI0zTPMbH9n1MIDHML4xOruKQo+ysUpDopGZBu+JG1fnjewMslVLeUkhe?=
 =?us-ascii?Q?knEmu8MFBOWntU5GMcWxHeiv9vhWzSp/JHGDPGd7j38fxCMpkhVIMmW6zTeP?=
 =?us-ascii?Q?gDAx9ErygHyPnJ7j/LJWrD4RxGtUukEqVoUVKZF0tDWhN6BnMlnwY8PjI1de?=
 =?us-ascii?Q?QzFkSRUkZjhlKxFMZXUBKZp5xSHF6ydDO/H62fQDndHqFf8Rxzrc93NRLdv1?=
 =?us-ascii?Q?5Cy6Nc3tCilVqX33Myvqy0u1eqr4JnP2SqxfL7NaYGlV0AqRSOpGr55MaCOf?=
 =?us-ascii?Q?+crtzhEetY4kVB2nTrrpogvzBup80ltQL+JrCbZOpNBwtzih/Y25EmhbEXeo?=
 =?us-ascii?Q?gr4NL4/fQfLX53ZSDjDNHRKMExVHbAHiq4g/GQ60cR+ce+qLLn91kAaXBjct?=
 =?us-ascii?Q?0Va6QOTmYgAAy6SYDMZTl2r0X82LaWOx/KXPTT3HcebsLl+Ygaezg0IsE/0f?=
 =?us-ascii?Q?0UCu4UW2iRWKdalwr85/Pb5pMQd2fybDURq58OZgNKoRqKHj4PWiB2CfaCvL?=
 =?us-ascii?Q?FnWfqxq44aou3yVxRsxJ7H7xwLUzrx7Vr6I/pzQcwmSqaVx20xSvPGmotUdj?=
 =?us-ascii?Q?TK/pUn9/fwHYHKXYuCjo/+VhkQQcAyOD0ODTwdDVvxPwlLzweQlz4V28bM/K?=
 =?us-ascii?Q?eQQFd8iKTUcTVd3ucYO8Y8M18a0fWMtEni8wBSg8rMouT3M2G7EkOmwyapY7?=
 =?us-ascii?Q?MAEA+jhKnY5ahE7x/OZNX66STg1GkQLskh1UrwS816iQ/k/VjMHPuh/OWP2G?=
 =?us-ascii?Q?mOotwrvTmkzH1WixhiT+S5rRjts7w0avWXPqamgepqL1WelnXK73jaF0l/kJ?=
 =?us-ascii?Q?jsMmawdrjq5YxqNW6FcDohMrVfh49huLvL4nYykZX1WwFrR+9Zu9eKVCY/Pe?=
 =?us-ascii?Q?ufzs0blx1Dj5EV0c5M6bNrFWBK5wrMfzRGzpWKZ9cgp8Yh62qM6pW9+R39Ot?=
 =?us-ascii?Q?cDgRhpPOawanh7HIoaj28fQlcX6GkFt0pZaNhV7xofS+5ol2ze7DhCF/tbeF?=
 =?us-ascii?Q?fHKbfpRmIe+BBMs6PMHmxIMsFp5ECHP/cIEW1KVhZ6gInqCdAPXEycbpic9u?=
 =?us-ascii?Q?o9ZIWEeMNGEXcTScIBCvM/KeUFiY77tgnMuhIfzxmoxuvE8YZcggUNRGQxA9?=
 =?us-ascii?Q?owY8VGo9z8X/C8RGgLdOMxQnqRdG4uSZDDjMcUcGVZXwR0esci2TUVquOPno?=
 =?us-ascii?Q?gVtBGHiZtxuG9Qp58UJ7TrHGIHBXTnQRQ0TaHvHnb0V1Sh9RaID/VCGGtai0?=
 =?us-ascii?Q?5ZPJ/DTr2K9YAh72CJ1fW6kIifHHE61egCszt7Aj89Xvx6+SqKvDfRIYmqd2?=
 =?us-ascii?Q?zdcQjtiE4RIxEVkEG6hqZIEooBPp2YuCbrkKoAsJqWJGcR4WIJ+Hy6XhQtvJ?=
 =?us-ascii?Q?p2V/p+p5b7ZvuGcr363mYgjzrdQo6thDREZGT2q56IPZuSutOYf0tlpueLbR?=
 =?us-ascii?Q?CmvQ8tJLHkSd9YCA0bluq2Yfc42IaTX1rSB5wnbfUAMMzpRNkM+vWNaeClfl?=
 =?us-ascii?Q?TLWpbHHabe9bSofywZ+AWwT/omeoF9ecwd6gRsiHHjUgp/zxzZfInM+esLdQ?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EQopIPnxoz5YlPYVPkMZHYlq6MRSr4cfgosvI3lcqTTBl43jfar9vr+liSMJNu6wHjtTl85hSTpsD73QE/c+gTrgU+8duL6m0gPEoiiD3Q7l0Y6vDefUgmkRabgPWdaMjsHVsIyw9iZyjD9yOtUJAMjeA6Kgi4ALIRWNBMQPvH5FeGf+h68vR2EACrIcm3wPdMzAbszHaCShdU33Z4+pkKP7J1lxvgbak8t973NIsAq6+6RcX5CKTBXgNsTPlxxaDlUPQmTMAEp6g0wwQGL7eOy2tOQoI1qkglKyzSjkWufb5RbtLOksExJa8RZjCorI1XNJe3i5z13bIcpD9qoYluBvF+itY3FkwzQPhWjJ+IlT7F/sSbjWeWN3NQtAYTV3Ft6i8K+KatDj6ESBogVt4PaeHPGPlZpaU+490yE9PjdSGxZkmCLQS4LZ8tNQKeQmMzE/PrWj4lOb2BsZWABc20vMKpZ9lO/RXrQ/Y1eFmUbTQmZYtRxR3Iw8qOKeMvRtgMDc+IaMqrWJuQa/TMZDf3o9x+3yYp70ree/e+7m/bHnbaW1OHhq9NVt2Ar04VkAZkJlYZN2P9oeyeHnnbHoYYFhQSrbnEBSeKYhUl4OC7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42db7d5-0eac-42bf-7f6c-08dd107dffd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 13:59:10.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTP86aR4C0rTGYCHkWEfBQWd8cBf8FcLfXngPZTYeFGsZw8ijXPpkWWF3J0Iyr0c4R8SsUQQ9QeFavu6VKkN6UXPldQgb7gw4SwdIMkx1yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_12,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290114
X-Proofpoint-ORIG-GUID: zyxLlvz-71WtVkGy5EoPzY43NS6m84X8
X-Proofpoint-GUID: zyxLlvz-71WtVkGy5EoPzY43NS6m84X8

On Fri, Nov 29, 2024 at 02:47:59PM +0100, David Hildenbrand wrote:
> On 29.11.24 14:38, Lorenzo Stoakes wrote:
> > On Fri, Nov 29, 2024 at 02:24:24PM +0100, David Hildenbrand wrote:
> > > On 29.11.24 14:19, Lorenzo Stoakes wrote:
> > > > On Fri, Nov 29, 2024 at 02:12:23PM +0100, David Hildenbrand wrote:
> > > > > On 29.11.24 14:02, Lorenzo Stoakes wrote:
> > > > > > On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
> > > > > > > On 29.11.24 13:55, Lorenzo Stoakes wrote:
> > > > > > > > On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
> > > > > > > > > On 29.11.24 13:26, Peter Zijlstra wrote:
> > > > > > > > > > On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> > > > > > > > > >
> > > > > > > > > > > Well, I think we simply will want vm_insert_pages_prot() that stops treating
> > > > > > > > > > > these things like folios :) . *likely*  we'd want a distinct memdesc/type.
> > > > > > > > > > >
> > > > > > > > > > > We could start that work right now by making some user (iouring,
> > > > > > > > > > > ring_buffer) set a new page->_type, and checking that in
> > > > > > > > > > > vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> > > > > > > > > > > and the mapcount.
> > > > > > > > > > >
> > > > > > > > > > > Because then, we can just make all the relevant drivers set the type, refuse
> > > > > > > > > > > in vm_insert_pages_prot() anything that doesn't have the type set, and
> > > > > > > > > > > refuse in vm_normal_page() any pages with this memdesc.
> > > > > > > > > > >
> > > > > > > > > > > Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> > > > > > > > > > > these things will stop working, I hope that is not a problem.
> > > > > > > > > >
> > > > > > > > > > Well... perf-tool likes to call write() upon these pages in order to
> > > > > > > > > > write out the data from the mmap() into a file.
> > > > > > > >
> > > > > > > > I'm confused about what you mean, write() using the fd should work fine, how
> > > > > > > > would they interact with the mmap? I mean be making a silly mistake here
> > > > > > >
> > > > > > > write() to file from the mmap()'ed address range to *some* file.
> > > > > > >
> > > > > >
> > > > > > Yeah sorry my brain melted down briefly, for some reason was thinking of read()
> > > > > > writing into the buffer...
> > > > > >
> > > > > > > This will GUP the pages you inserted.
> > > > > > >
> > > > > > > GUP does not work on PFNMAP.
> > > > > >
> > > > > > Well it _does_ if struct page **pages is set to NULL :)
> > > > >
> > > > > Hm? :)
> > > > >
> > > > > check_vma_flags() unconditionally refuses VM_PFNMAP.
> > > >
> > > > Ha, funny with my name all over git blame there... ok yup missed this, the
> > > > vm_normal_page() == NULL stuff must but for mixed map (and those other weird
> > > > cases I think you can get0...
> > > >
> > > > Well good. Where is write() invoking GUP? I'm kind of surprised it's not just
> > > > using uaccess?
> > > >
> > > > One thing to note is I did run all the perf tests with no issues whatsoever. You
> > > > would _think_ this would have come up...
> > > >
> > > > I'm editing some test code to explicitly write() from the buffer anyway to see.
> >
> > I just tested it and write() works fine, it uses uaccess afaict as part of the
> > lib/iov_iter.c code:
> >
> > generic_perform_write()
> > -> copy_folio_from_iter_atomic()
> > -> copy_page_from_iter_atomic()
> > -> __copy_from_iter()
> > -> copy_from_user_iter()
> > -> raw_copy_from_user()
> > -> copy_user_generic()
> > -> [uaccess asm]
> >
>
> Ah yes. O_DIRECT is the problematic bit I suspect, which will use GUP.
>
> Ptrace access and friends should also no longer work on these pages, likely
> that's tolerable.

Yeah Peter can interject if not, but I'd be _very_ surprised if anybody expects
to be able to ptrace perf counter mappings in another process (it'd be kind of
totally insane to do that anyway since it's a ring buffer that needs special
handing anyway).

>
> > > >
> > > > If we can't do pfnmap, and we definitely can't do mixedmap (because it's
> > > > basically entirely equivalent in every way to just faulting in the pages as
> > > > before and requires the same hacks) then I will have to go back to the drawing
> > > > board or somehow change the faulting code.
> > > >
> > > > This really sucks.
> > > >
> > > > I'm not quite sure I even understand why we don't allow GUP used _just for
> > > > pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
> > > > whatever mapped it will maintain the lifetime.
> > > >
> > > > What a mess...
> > >
> > > Because VM_PFNMAP is dangerous as hell. To get a feeling for that (and also why I
> > > raised my refcounting comment earlier) just read recent:
> > >
> > > commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Wed Sep 11 17:11:23 2024 -0700
> > >
> > >      mm: avoid leaving partial pfn mappings around in error case
> > >      As Jann points out, PFN mappings are special, because unlike normal
> > >      memory mappings, there is no lifetime information associated with the
> > >      mapping - it is just a raw mapping of PFNs with no reference counting of
> > >      a 'struct page'.
> > >
> >
> > I'm _very_ aware of this, having worked extensively on things around this kind
> > of issue recently (was a little bit involved with the above one too :), and
> > explicitly zap on error in this patch to ensure we leave no broken code paths.
> >
> > I agree it's horrible, but we need to have a way of mapping this memory without
> > having to 'trick' the faulting mechanism to behave correctly.
>
> What's completely "surprising" to me is, if there is no page_mkwrite, but
> the VMA is writable, then just map the PTE writable ...

I've had a number of surprises on this journey :)

To make sure I understand what you mean do you mean the whole:

do_wp_page()
-> wp_page_shared()
-> if (page_mkwrite) { ... } else { wp_page_reuse(); }
-> wp_page_reuse()
-> maybe_mkwrite() [hey VM_WRITE is set, so yes make writable!]

Path?

Yes this surprised me too... so you can't just say 'hey map this read-only' and
get what you want, because the kernel thinks it's somehow spuriously read-only
mapped and just needs correction (probably there are situations where this is
necessary).

It has to be explicitly CoW in VMA flags or implement page_mkwrite() (or if
!vm_normal_page() then pfn_mkwrite().

You aren't saved with !vm_normal_page() mappings either without a pfn_mkwrite()
because:

do_wp_page()
-> wp_pfn_shared()
-> if (pfn_mkwrite) { ... } else { wp_page_reuse() }
etc.

So it's the only game in town...

>
> >
> > At least in perf's case, we're safe, because we ref count in open/close of VMA's.
> >
> > This is a special case due to the R/W, R/O thing.
> >
> > In reference to that - you said in another email about mapping one part as a
> > separate R/W VMA and another as a separate R/O VMA, problem is all of the perf
> > code is set up with its own reference counting mechanism and it's not allowed to
> > split/merge etc., so we'd have to totally rework all of that to make that work
> > and correctly refcount things.
> >
> > It'd be a big task. I don't think that's a reasonable thing to put effort into
> > at this time...
> >
> > Also who knows if there's somebody, somewhere who _relies_ somehow on this being
> > a single mapping...
>
> The main issue here really is that we allow R/O pages in VM_WRITE VMAs, and
> want to make write faults fail :(
>
> What an absolute mess, yeah, without some more core changes
> vm_insert_pages() cannot be used, unfortunately.

Yes indeed, sadly. Maybe an idea for a series, as memdesc's are at the very
least a long way away.

>
> --
> Cheers,
>
> David / dhildenb
>

So overall - given all the above and the fact that the alternatives are _even
worse_ (having to spuriously folio lock if that'll even work, totally
unnecessary and semantically incorrect folio-fication or a complete rework of
mapping) - while you might be sicked by this use of the VM_PFNMAP - are you ok
with the patch, all things considered? :)
