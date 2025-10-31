Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3A1C84A2;
	Fri, 31 Oct 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921442; cv=fail; b=nqPCow6f5zx57/1ZtidYbT977pqpKyOCOXneQtOM0GCC3aNyO0TQWPxQMM/ZGZXsClHacIeMCF7B11qnxs7Jhph671a8OGNhKBDK7CfueeKqPtkAbrTal2Dn6/zS+8OGN/5cStXZnKVvpF15vl/MPdHvxKtN3938lfz/3V6Am/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921442; c=relaxed/simple;
	bh=dLS9QVrdOdWVVtfV6wb2rKkRFy3SJ/pY2vnkIpJY6H0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LKzm2YyqIhy5aCG71Otuzp0TYJ/mYRHJXBB4K2hlZIp6+FLLIBmR568bwQoxvafSs/XASVFNVjlzGPbFp7V6uEGP5d/iJgerRYUgMnuV0+p15umTUBxsU8kjIM+bM50R05G4/FsPjFv0tXTuZaQHkGhxULBLSWBezrULaJXTBrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K7fON1Zu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QqFzAum2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K7fON1Zu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QqFzAum2"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VEYjtx024429;
	Fri, 31 Oct 2025 14:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QgZWd3oRiqlSxKWo+5FpSxX85WFClM/p9zDSDGsk2fI=; b=
	K7fON1Zuv3jBnlR55MyJsAHnB4AmPH1uCRze6ck3RO2JUyTj7IUGQRAYTlZWOtP/
	ix1on28cAugLCBF6PLQFsiL/cBO03lHdYHhDLOc65vYoUA+cONAVtiVomZlmA9mh
	M/JFNzrfROXj3cqYA7KfExWGM1lkwYVtIJvA8nfvfxfe97R6EkZzC8fmzZOMaeFu
	INoIpUk+DNiKLSj+ySDfePsLJr9jHvWAtGAUh1OMVTSt1DFd//wGiMxqz7NjCGLs
	EQLyGy8LQNi3h80ulgfAyVmpKBvryV7zwhEB37YnUeBORk/w2tJw4hsjMV8LF709
	5ZfQi8Mc99uMHihEXH98nQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4y0980aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 14:37:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCe7No007868;
	Fri, 31 Oct 2025 14:37:10 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359wrhn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 14:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU/HwEVu9Wr/trkIHTRhE/WwU6xR25PgvLzbE4PmOf2kAV6bW+ohyqlZbjzpFD4IOYe8KZn8GeRAIIaFKmGU/zSJOiAmsNBawsj42vD3+4F3BYcEO8nKywG00C92l0xC6ZxzJ4nYqvs2Xf+zLvwWqdcluTVvyCW5/jRwMijZNcUnohp/oDUZCnifb4zR1lnpjJdXDx1BRsrJB842zv0NYeQ155c4BFpjQbquCkbJOnRz5bzP4EK+sP0qR3yeybDPeYgsqekDh6sh5oWOMy4yGIpG4J7gRR6+ambl/UmPG7JzcvVBVLH/6OYZR3Hnx1rcwMGHU0hFlrNqkEmK3kbfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgZWd3oRiqlSxKWo+5FpSxX85WFClM/p9zDSDGsk2fI=;
 b=gcbLNqj4FM+LHKBc8njO9BkZzx2LMs2chsord5xsvflXfasE/oXBHWeRFjNEnj/8xFdcH6sTf/s+B8SBg9HLmJC81XpmCnTBgYGDkVtN4+88nulSSvLX7HIrYQ2utzRvWK+F3BWkdur84AhcQbtRRDL+TD1a+NEmy69MrV68Wh5suIxAz98xQiXV9gFTj6KXiCh6A9J8LfWRkbU4FFpYRBntRufAUnqvPRXysbT7LbZ1LPgyxZqSvtuAswzpGKTdOJDLCXK2uMjHMk0CqMNfbq4Iu62Qc3z87WBgsCD2eAaBUSuxhrK5Ho+1nbnrzKeU16aO5oIIbYntzt9Nbf1WbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgZWd3oRiqlSxKWo+5FpSxX85WFClM/p9zDSDGsk2fI=;
 b=QqFzAum2KPIVmWMuRTC7PtfYnM/he6ey/EIcfdf32RLabn7h6+xpztFErjSHoqRYsgEoQhezSl69ggXUGRu6r9fWalkqJ3z+wkE3Hhhf3q9Dix1buZ8SIvarNCBLG7awpqQ4NPBEZnudJ1YXGxAcediUDQt8cp5O2VMTzwhq40A=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by PH7PR10MB6627.namprd10.prod.outlook.com (2603:10b6:510:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:37:07 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:37:06 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Fangrui Song <maskray@sourceware.org>
Cc: Peter Zijlstra <peterz@infradead.org>, <linux-toolchains@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Concerns about SFrame viability for userspace stack walking
In-Reply-To: <CAN30aBEO0nKWnHRkT21qEQZCnQ_8O_ayx7DfHaov1YZPZpgjRg@mail.gmail.com>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
	<20251030102626.GR3245006@noisy.programming.kicks-ass.net>
	<CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
	<87zf98tj8k.fsf@oracle.com>
	<CAN30aBEO0nKWnHRkT21qEQZCnQ_8O_ayx7DfHaov1YZPZpgjRg@mail.gmail.com>
Date: Fri, 31 Oct 2025 15:37:02 +0100
Message-ID: <87wm4bw31t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|PH7PR10MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2448be-e476-44d1-38a0-08de188af6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amcvaHhQZGFleThxdldPK01nbHBaVCtRejJ4cEhPOG8ybVBzeVhoaHE4MWJD?=
 =?utf-8?B?cnNqTjkyM29NWFJxdDAwY2s0U2FQa0xFV055L1lEVmt2WVR4NDlwcFBzUVZq?=
 =?utf-8?B?bnJKRGlOMUxwTGtaVFluUmxCS2RyVVhMV0wzS3FxUWhKRG5kYU1NemkzT2Mz?=
 =?utf-8?B?QXVBNkdwdXJSbFV6U3pIaVgrb0VqRDlwRjFYMEJGdEcvVXZXeC8zcC9hdzA5?=
 =?utf-8?B?cWJsV2l6VWZCOUJBNVdvRTNjYVFLOU9sWGZPa1FtbDFURm9rQmxYRHkwOE5L?=
 =?utf-8?B?V3J3clFkbWlrdnltVFEvZGp5NVRMenl0N3VYWXFCNjBVNjBqTEJzaXJQZUg2?=
 =?utf-8?B?ZUhPT1JSSVFsTzZFTkJaU3VDa2hGbzhLYTJ0dW9lMk5JaEY0T05Sa0x4Z2tH?=
 =?utf-8?B?VFpxV0FEdTNEb2d6bkRXengxcFNrQ0tmSDN6L2ltOHN5OGJoeEN5VzBNRnBR?=
 =?utf-8?B?Y3F0UjdCbFNYRnZ1VG9WcjNmYmNwcnkxcHdEQTJpcjRNWjhBZ21QUW1RV2ZE?=
 =?utf-8?B?REl1dzJYOFpubUU3Ui80WUxaYlRxdFVUYld6RSsvWmxBaHRaV1htMGFQYUpo?=
 =?utf-8?B?eG1KaFVIdDJsamNySmFVSVRNem50YTR0cEV5bjIvYzFEcFpmRWxqOHUwY1JO?=
 =?utf-8?B?cmFnRG9NS1VYakZCc0pLV2lRWVFLQlhYZG4vRTBSWU05WDY0V09BOHBDdzVS?=
 =?utf-8?B?bFUzeTBQU3NuZ2E2UEZ2MWl1Y0R2OTdGZW81Q3J2ZVZmVmtUV2pUbURGR0x4?=
 =?utf-8?B?S0hON3oyRm5JWUM1d0hwRjhJYWJnTE1LWFZ6eWpoVkFuc0x5YzFQdzUvbkhj?=
 =?utf-8?B?ZXhqckV2Mzd2bWFYc05VUUQ3VERXaTMwTWRqWG1rSjFmOUVReEwvZVBKN0to?=
 =?utf-8?B?SHVRQVpaREdGaGVwMVRScUhxS2JsL2FoSkdsTytLcTkzVDlXSUt2ZTN2YjRv?=
 =?utf-8?B?WTFwOExVdXVNK1VtQWo0Wm90TVArTFdMOFczL0I5S3FBb0JsMkFTRnIycTd1?=
 =?utf-8?B?QUVkYXBNd1F4SERqWUxxMHg5VEJTNk5oYmxCU3o0UlROYkUxKzg0U1ZZOWZt?=
 =?utf-8?B?S1VnQTU2RE1LclVZNmpFaVdqamZWS2hMaDM1MWRuMnBCSFZGQjZqZ25pRjNN?=
 =?utf-8?B?Q1kzczVUOVQybVVHaU5FY3NlQzNWMTFhV1hsb1k3aDgyVmdKRkZ0RnZOeDYw?=
 =?utf-8?B?cldlSGFsVXJGeUJ1bUlRcWI1djlKRGVWbkt3U3dSWjg4RGxvVlg0Sm15bWVC?=
 =?utf-8?B?ZWxEUzgzTlpvYlNrSUFUTTY2NFpDV3ZnYjlUeWxVVzhWMCtJVFJlaExqalcy?=
 =?utf-8?B?b0ZRaXhPZVlDYnBxVHRDLzNSY0YyQkNldXdQQUxPb1lsT0xNUk56SzdvME5y?=
 =?utf-8?B?cEVPYXRzQmFUM2JIck8rc2swVzB0cUkyOEFBTVRxdkVXZVZCMTMzdEVxT1pG?=
 =?utf-8?B?Nk16Wjd6NWRjNi85a3JwTXF6eG9qbE84OVd6d2R3aFlNSEVNZjRXNjdNVnlF?=
 =?utf-8?B?b2kydGJxeXJyeGR4ak1RMTd1ekJ4SmxRQk5yM3I1L3BjcThVTW1vN3pFSWZM?=
 =?utf-8?B?SGVEdHhsdVZEaHJLcTZnTG1iSHZqam5RQkRnaS9MVUxPTmdnQzhaeStZb3h2?=
 =?utf-8?B?OVZkQm03WHZDUmFEMWl1YlJ5b2I4V2w3YmY1UVd5N3JUVXZLcXIvMnNtaTFT?=
 =?utf-8?B?aWFyV094SURia2VlblVZVk93UFkydU9tMk5FakpwUnIvTEM0YjlZVXZZR0Ji?=
 =?utf-8?B?WTI0cUJjclREOVdYbWpyTmlQcFpiazZVSy9zaTBkVWlzTTNqVGZXUjZnWGFH?=
 =?utf-8?B?czZNenUxMENCSFdMdDZKTVF0b3ViR0laVEhNYnVCUGgzTkdmYitJSFJ1OWNS?=
 =?utf-8?B?cHpWcG1vK1BaZ1pVV2RzUG45S3NHVkVQc2J5cmh1NHV4eVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjNuWXB5aWdnOG42Y0poME5zNmc0aWh6emU0ZGNRZ1dScjZwT0ZOS1RGdXMy?=
 =?utf-8?B?L0x0MU9wUVZYUEZzN3RtNzAxSlZRR3B2MVdGYUVSeTV0RE9wNWtzemRON2NW?=
 =?utf-8?B?azlsbWZ1emc4Nmt1UmIxN3ljUTlCZkZrcTRKNmwvYzdFUysrQmJyOUlRek5p?=
 =?utf-8?B?aE40dC82Z2c2bmQyL2ZCbzZvZzNOV252R0hwdVpackxIRkI0SDBhSkJUR0wy?=
 =?utf-8?B?cFJLdGkrUmt6aHJ5aU1PTGR1MXJpaThXN0NzWU1qSmQrWXNUcmpUOU5MUlgr?=
 =?utf-8?B?UmxJY0ZlMFVDYVNVbTRiQUkvb2Nrc3hKTnl2U3pTMEtDa29ucS9WWEUvbUh4?=
 =?utf-8?B?TXpQbklaaXlHaUVPL0lOWHJZZW1VdGZaZGprb3JXbXd0bXZ4aW04VWhVM1Q5?=
 =?utf-8?B?K28xYjRLalM1T2RlQnRSeGd2SmtlZmxDRmZWVHIrRjRrSC9HM2VtVzhXbmpF?=
 =?utf-8?B?L0VOVGkyemxWV3RJRVNwbFl0K2xnOUpmcURVMTNWVEVtbitoWDJqRXI4N0gz?=
 =?utf-8?B?bG5aaUhrTGZvTnFPUmhKeDcyNlhPNVJkTVYxU0VFQjBkWGJ3NUxIUHhHVW1z?=
 =?utf-8?B?cVJqSmhxUWgrNktCUGp6UTdSVTQ3YVNWYmV2OFJQdDM0UGw5NmJhRWtxUUZr?=
 =?utf-8?B?WTNjdU5PSitQRS9MQUJUaVIvTnpoMlU0TTJDMElxL0ZJNU44bU9CUVpnMG8r?=
 =?utf-8?B?RlR3UEthaUJEV2VtZVFUZmdOWW56MktqQlBCY2ZHTFJVN1lUZGFybDFLMzFj?=
 =?utf-8?B?cXNON3RyUUwrWDJKUWRKZW5RaFZnVU1zY0VNR1RGK3U3ZTlBVTU4TkRRRXZ0?=
 =?utf-8?B?dklNb2srd1IrNXJRRHAzZ0dlSzFmYUkzamZhTjdVeGRtRlhOa1M1QkhncW9v?=
 =?utf-8?B?UzlrcDR3MVdXcExwVDBHdFJQQTNhMW10b3ZPd0FRRWVMMjJOR0ZWdkQ4UnVt?=
 =?utf-8?B?Z1JyTzlBa3o1N0VCbml0RVhpU3FyVnhPUUdYbXFIVTdnSGp2MzdyRlVuMkRB?=
 =?utf-8?B?MnlNTWVrT0VhaVptU3ZPajhjQ2t1NDh6TEJ1Q3dYOUR4d0s5bGo3eG9RNytu?=
 =?utf-8?B?YzE2ZlgyYTRZdDc2OHBTbU9EWlhvYjZSQjVYaGpFVFM0dVlNd2RKMElXOUlI?=
 =?utf-8?B?SDJNblUybDVWbWg3QUc0dkdVVFAwUWJLUjAwWnZaMjBsU1k4RTRRQWRBc3gv?=
 =?utf-8?B?bVZmV1orVkNIOTl0dElSV3J0aWthc2Rkd1F6NXF2RjhpOHF0N2xDc0tDRVVK?=
 =?utf-8?B?bEJESVpmYUtvVlBzMHpOSThGTGlDMmZXOWMyMGZ2bzVIZFhoY0FJL0tFMDFl?=
 =?utf-8?B?bFJkTTVaN3k3R3RFMDBRaUJVNnNQN3FITHBqTHZCNHlONjN6MEwvZExLNVhz?=
 =?utf-8?B?ZnJFRTJ0Y0pzckc1QWFjTURxL1dXbVg3RkYxeWM0VnVQa2pkc1N2YnhIaG84?=
 =?utf-8?B?T25JL2R1cmg2QnV4NllxNVc5SEF1aUZmbk03d2N5Zy95VVM2UmcxbXdoRVRm?=
 =?utf-8?B?UlNRL05UNVdrVFBFa3liUWFqd01yc1NJdHNrcTllMmZWTTk2QmpINEd0V1F4?=
 =?utf-8?B?bDRya1FlelpOWEJDZFR3em1UNW55NTUrUlUrYjRjMG9sbUtWb0Zza2ZEQ3ZK?=
 =?utf-8?B?OXBGVm9ESjgxQTU2K01jWk10WUNVMW5CWFhDZXFwRlc3VXgxYXNJeVFDazFC?=
 =?utf-8?B?ZXEwM0lEcGx5V0lRTWJIRnZ1NkRWc3owWDJwNTY1cmFsOGhvbXRWcjJUYk9D?=
 =?utf-8?B?VVY4VkFPVHBxRlk4eWd0cTRoTDRkejltNU1ZdlVobGhOZU5IVGdOeld6V3dW?=
 =?utf-8?B?Q2NnM2txT1N6MXBGRTRZdUdKUU5tblpkZWFFQjBWOUJEMHYzQVI2ZkxFMFJx?=
 =?utf-8?B?bDNUSDNXWmU0YWtWNVZPbjBhaTk3Q3o5NUMxdUVQNm9nNW1XVFZhelFUSTZh?=
 =?utf-8?B?bXRJeDFGU0FwM2orekk0OUVKVlJUTm1ybEhPNjZRYVRkRUZ6NHRFeUo0cndl?=
 =?utf-8?B?aG1GWU5YYlNPZkV6ZmU4VW5CdjlZZHI0YmRjTWt3ZTV2K1JhZWVXSmd2Mzla?=
 =?utf-8?B?N21DZVNXOGtUQ0ttUDVNd3F5ZE5KU09zS29jeGVNT3pjRWQzZTd2dHk2d1Ja?=
 =?utf-8?B?cjQ1WE5ZSnBKa1ljY0pqNzdRSVY2UFZtMWZUSEd3bE5VTHNsZlNuNlI0L1ZX?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dkzXol11Ip08TLJLDY8/UP/6xT/tzKJcnQdqp7eXy0N/uOTH6Hg59ZdYwHlBywL+JKSqx533xYVY7oB2ssi0LqWXSGcw5cNwym1jaRyDLFEtrjMDO3iqEEk9+RR4ov5LnKLVc9x2Opr0lAW/bu1hNVxPk5Mxx3JkmJzRpS5mMzZiEGZdhnOFsbyCS2GjOKTuMB/putoGzkG+vYjY+uUdd0SYXzSDQBesVHHD87fkGNKHMzEEu3bMxL9ODrmdETvXSXfC571Ci715CrrdmanIYq3gruXXe2HCxFP2gC3//LH2fNho+pUht5uzhNWQs3qO722IdddytQmeCT2uPvzLdNNJG3Rif21YexC9xqVl8WB0ltkFeTBO2SHB52dlitZBoJy8EImqgLnXztqjmgQciUiHxYpEgepVNLljNI2+fLRnySEgAD1EjqJNLnGgCCt6Yphev0+wA4HuewyNRLrSX3CZ3GuKlkZnBygQ2MI44mQK8nowCyY8nARrHgdGaTCpw7Hu3AFsjAjUT/EKRC2hYx3jTStwIJ/ytfVP9y+INVJvnKt/oushSvnMrCZ9x3AsM+BSzPW4gtMiavtpLr7lOIDUJ5LW3gq3IhWmT6Q0p8M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2448be-e476-44d1-38a0-08de188af6fa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:37:06.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmkgK9nQyf7U0nCe3aJwTpK+kA50VYSCW2IgPfptqdHfKQWrUBCPvnPDjTTE+VWzeJB0caNRDRiTk2j68P9EylHWhoDJ5m71Dls5pJqGT9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510310131
X-Proofpoint-GUID: v7z52detllf6SBmPaS61suEK3Jc6zmhL
X-Authority-Analysis: v=2.4 cv=TvXrRTXh c=1 sm=1 tr=0 ts=6904c998 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vTr9H3xdAAAA:8 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=QegZ8fZzAAAA:8
 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=XM2VUtppUgMbbtgruw4A:9 a=QEXdDO2ut3YA:10
 a=_Z14B2EILkUCX44yj2ln:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMiBTYWx0ZWRfX0zRju3pL9ym+
 L31qgMw+fwMH60UDmE8PhluWAzrN3gtK+xLYdIJWQWAu9ZiaK/ZnR99MXSyX/woTbO2eN+m1kgU
 sqBn6c8tMs9dlWTiiyuK4lPPGBUsU7PPnVpvRC5f5t52ua1rEolFGc4Xg4yFYIYERB7BLJ9XGOO
 kqD0VkF1eyyaNYHyJj2GzK7SIwLo+ctp81VNHo+4j06tCupB6Z9kEA+XHEIMRo7DIZq5aOeQ32W
 QDhoC23B6v3yRQG3NaQ5l6bJjrM6NBE0paMhszv9A8DsLZdS90oEdYtIN+a6GCFL7iRsz4v4JLD
 sKX1iFOi6RUS0OrT/O2/meN1wy5qGhI3N0GB9HsiJ7ueI1bOAQtmrWkseh8GSHwl0olXEVqP85/
 T3q85/8GW/dRQOt2+6kR8oT8r5+TWFD65UtReyT1QCif6EVGzmY=
X-Proofpoint-ORIG-GUID: v7z52detllf6SBmPaS61suEK3Jc6zmhL


> On Thu, Oct 30, 2025 at 10:04=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Thu, Oct 30, 2025 at 3:26=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
>> >>
>> >> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
>> >> > I've been following the SFrame discussion and wanted to share some
>> >> > concerns about its viability for userspace adoption, based on concr=
ete
>> >> > measurements and comparison with existing compact unwind
>> >> > implementations in LLVM.
>> >> >
>> >> > **Size overhead concerns**
>> >> >
>> >> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) =
is
>> >> > approximately 10% larger than the combined size of .eh_frame and
>> >> > .eh_frame_hdr (8.06 MiB total).  This is problematic because .eh_fr=
ame
>> >> > cannot be eliminated - it contains essential information for restor=
ing
>> >> > callee-saved registers, LSDA, and personality information needed fo=
r
>> >> > debugging (e.g. reading local variables in a coredump) and C++
>> >> > exception handling.
>> >> >
>> >> > This means adopting SFrame would result in carrying both formats, w=
ith
>> >> > a large net size increase.
>> >>
>> >> So the SFrame unwinder is fairly simple code, but what does an .eh_fr=
ame
>> >> unwinder look like? Having read most of the links in your email, ther=
e
>> >> seem to be references to DWARF byte code interpreters and stuff like
>> >> that.
>> >>
>> >> So while the format compactness is one aspect, the thing I find no
>> >> mention of, is the unwinder complexity.
>> >>
>> >> There have been a number of attempts to do DWARF unwinding in
>> >> kernel space and while I think some architecture do it, x86_64 has ha=
d
>> >> very bad experiences with it. At some point I think Linus just said n=
o
>> >> more, no DWARF, not ever.
>> >>
>> >> So from a situation where compilers were generating bad CFI unwind
>> >> information, a horribly complex unwinder that could crash the kernel
>> >> harder than the thing it was reporting on and manual CFI annotations =
in
>> >> assembly that were never quite right, objtool and ORC were born.
>> >>
>> >> The win was many:
>> >>
>> >>  - simple robust unwinder
>> >>  - no manual CFI annotations that could be wrong
>> >>  - no reliance on compilers that would get it wrong
>> >>
>> >> and I think this is where SFrame came from. I don't think the x86_64
>> >> Linux kernel will ever natively adopt SFrame, ORC works really well f=
or
>> >> us.
>> >>
>> >> However, we do need something to unwind userspace. And yes, personall=
y
>> >> I'm in the frame-pointer camp, that's always worked well for me.
>> >> Distro's however don't seem to like it much, which means that every t=
ime
>> >> I do have to profile something userspace, I get to rebuild all the
>> >> relevant code with framepointers on (which is not hard, but tedious).
>> >>
>> >> Barring that, we need something for which the unwind code is simple a=
nd
>> >> robust -- and I *think* this has disqualified .eh_frame and full on
>> >> DWARF.
>> >>
>> >> And this is again where SFrame comes in -- its unwinder is simple,
>> >> something we can run in kernel space.
>> >>
>> >> I really don't much care for the particulars, and frame pointers work
>> >> for me -- but I do care about the kernel unwinder code. It had better=
 be
>> >> simple and robvst.
>> >>
>> >> So if you want us to use .eh_frame, great, show us a simple and robus=
t
>> >> unwinder.
>> >
>> > Hi Peter,
>> >
>> > Thanks for this perspective=E2=80=94the unwinder complexity concern is
>> > absolutely valid and critical for kernel use.
>> > To clarify my motivation: I've seen attempts to use SFrame for
>> > userspace adoption
>> > (https://fedoraproject.org/wiki/Changes/SFrameInBinaries ), and I
>> > believe it's not viable for that purpose given the size overhead I
>> > documented. My concerns are primarily about userspace adoption, not
>> > the kernel's internal unwinding.
>> >
>> > If SFrame is exclusively a kernel-space feature, it could be
>> > implemented entirely within objtool =E2=80=93 similar to how objtool -=
-link
>> > --orc generates ORC info for vmlinux.o. This approach would eliminate
>> > the need for any modifications to assemblers and linkers, while
>> > allowing SFrame to evolve in any incompatible way.
>> >
>> > For userspace, we could instead modify assemblers and linkers to
>> > support a more compact format or an extension to .eh_frame , but it
>> > won't be SFrame (all of Apple=E2=80=99s compact unwind, ARM EHABI=E2=
=80=99s
>> > exidx/extab, and Microsoft=E2=80=99s pdata/xdata can implement C++ exc=
eption
>> > handling , while SFrame can't, leading to a huge missed opportunity.)
>>
>> The purpose of SFrame is not to be a more compact replacement for
>> .eh_frame.  It is intended to be used to walk stacks, not to unwind
>> them.
>
> Hi Jose,
>
> Let me clarify my concerns, as I think we may be talking past each
> other a bit.

Indeed, and thanks for following up :)

> **The primary concern: size overhead for userspace**
>
> The fundamental issue is that SFrame, as currently designed, results
> in a significant net size increase for userspace binaries because it
> is large and cannot replace .eh_frame (which would mean losing
> debugging and C++ exception handling support).The median .eh_frame
> size across executables and shared libraries on a Linux system is 5+%
> of total VM size:
>
> https://gist.github.com/MaskRay/5995d10b65e1e18b82931c5a8d97f55e
>
> Increasing this to 10% by adding SFrame on top is simply not viable.
> As my reply to Peter mentioned, "If SFrame is exclusively a
> kernel-space feature, it could be implemented entirely within
> objtool=E2=80=94similar to how objtool --link --orc generates ORC info fo=
r
> vmlinux.o."

I understand your concern, but whether the size overhead introduced by
SFrame is "viable" or not, I would say that is up to the users to
decide, not us tools engineers.  If someone wants to trade a 5% increase
in size (or whatever amount, really) for improved traceability and/or
performance, we are not going to convince them otherwise, especially if
we cannot provide a working alternative that would give them a better
tradeoff.

> **What about kernel use?**
>
> As I mentioned in my reply to Peter, if SFrame is exclusively a
> kernel-space feature, it could be implemented entirely within
> objtool=E2=80=94similar to how objtool --link --orc generates ORC info fo=
r
> vmlinux.o.
> I believe SFrame has a size advantage over ORC, which could make it
> attractive for this use case.
>
> However, if SFrame will not replace the existing in-kernel ORC
> unwinder (as Peter suggested), then I'm afraid SFrame doesn't have a
> clear position=E2=80=94neither for vmlinux nor for userspace programs.
>
> **On the ELF format issues**
>
> https://groups.google.com/g/generic-abi/c/3ZMVJDF79g8
>
> The current Binutils implementation disregards ELF and linker
> conventions, which is a serious concern for all linker maintainers.

Sorry, but binutils doesn't disregard anything it wasn't disregarding
before implementing SFrame, and certainly nothing that lld doesn't
currently disregard as well, in the sense both linkers support other
formats that require linker awareness for meaningful merging.

> The proposed SHF_OS_NONCONFORMING_DISCARD flag has faced strong
> objections in the generic ABI discussion:
> https://groups.google.com/g/generic-abi/c/3ZMVJDF79g8

I would be disappointed otherwise: it is their job to resist change, as
it is the job of everyone else to push for it whenever they feel is
necessary.  Don't get dishearted, it is just a single flag what is being
proposed, that doesn't involve any sort of elaborated semantics and that
is a clear logical complement to an existing flag.

So I remain optimistic, but given there are only a bunch of ELF linkers
around, IMO this flag proposal is more hygienic in nature than anything
else and its absence is hardly a showstopper.  It is clearly better to
have "if (section_is_unknown && nonconforming_discard) {
discard_input_section }" than "if (sframe && i_dont_support_sframe) {
discard_input_section }" in a few places, but if it turns out we can't
have it, well.. it isn't the end of the world.

> There are also unresolved garbage collection issues. I had to disable
> -Wl,--gc-sections entirely when testing for
> https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade-off=
s
> I want to emphasize: custom merging rules do not inherently conflict
> with using proper multi-section structure with section group and
> SHF_LINK_ORDER.

As I already pointed out in my previous reply, I think a solution was
found for that and it is being worked out.

> The format could be designed to work within established ELF
> conventions rather than requiring special cases throughout the linker.

Would you _please_ consider helping them to do so?  I believe there is
still time to get changes into V3, so if you have suggestions for
improving SFrame in that regard, other than offloading complexity to
clients or post-processing tools, or throwing the whole thing out with
the bath water, by all means please reach out to them.

> The concern about maintenance burden isn't about the initial
> implementation=E2=80=94it's about committing to long-term support for a f=
ormat
> that requires custom handling in every linker while providing
> questionable benefit for its stated use case.

Thanks for explaining.

So you are saying that the question of whether including SFrame support
in lld boils down to the questionable benefit of SFrame for its stated
use case, the primary concern there being the size overhead.  Yes?
