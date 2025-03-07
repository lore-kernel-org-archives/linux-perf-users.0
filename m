Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F81A3177;
	Fri,  7 Mar 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386812; cv=fail; b=VpoDEnC73rNGy+7h87EC1Jo77R8FBBCxA9TzMPyf0JKJTp9cVNFaALdiV3+hvVB8MUQKXVoRyN7KW9cCX68Ulv2fMvM5LbDMl2jy3L/gCxVL2/IXCcDHBhFwAxk1EBb8k2FA0LeXnd+ZffaTvyS7/sZUglwwpVbVib2d1ofQb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386812; c=relaxed/simple;
	bh=2mO9HQIsw6+KF8bikV6Ehsb5axHdEQl0JEfFBPSrgmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=nV6r0VeuOhcmgksHgeoBBoM6eOb3dKW4STnK0xQnI7MJxrB/6Vu2OJEN4+x3KXXqYCFF8uKo9ZA0akl6FRpYVmwG3YeRwjkqAFIqyHYgg7nJ4yGos0KaV3In0uHUiOhlJ1Pjopvupt2x63uxjdPM5nTywBlSqXzdsL0jjaHS6YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iiYIXHHj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EC2A2DbG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iiYIXHHj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EC2A2DbG"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527LIO2x014688;
	Fri, 7 Mar 2025 22:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kB/5wHoA/hrWF2JRt58YAvB5kEdCKojklKDZCdgZ+Rg=; b=
	iiYIXHHjAV9VYOmMcJw0vjsW33ALB2B6un5B3rOcd3ZDVUOPTgObYFGhs0Un59VC
	heGvWk8EtJEuE7wW7PJWKmsYAMzvQj0pPJwLpWSDhR70unVueddi2WJBa+T9zcZx
	uAaN8iB3T5sKisdiKlY51ys3yFqdGF8feNqb1Sx201mO9nPkkOXDHmKF4hLEYhKL
	QufyhL2w2m11lCFILDdekfCzSX8tk1sD9KDQKXexArqJyU6ImauX1lpzK5GIxjyO
	AYaeRanhCcWzlGmX6ZAWueZGntojhDkduM6Yuy8GXBfa+jvf2OIk/pUwd1i/qHoy
	JRS5It2btqGXoQRwSjBipQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8259xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 22:33:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527MUplb010920;
	Fri, 7 Mar 2025 22:33:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpfqqbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 22:33:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr+T7o6herZFX8gPAc5jFBeMAiSdscqjfFKCFBFZ00+3wetBX7h/ooPiFR9wJF1+8XK1IAb9pG1jrlmYEFC4uBMgLRTNe9X+hjL2srErxWHsAjJ+B4iggEjortsavPWr24ZfleEWOZ5+XyWa7uCOkme3H5rE/eMxhlEgDfrKrtkX8SBZifjpSNflczei/Q66KiDE0BCn48Y6k51Plqwm2yI2YAjzICJDsE4jfRrHImjkpEmqEAdyAC2IV5cbbWOpUKvXCOS1KGbdM1+dZhqGegauhas6WP/0ctB9AQ4NcQ/xFWGQdU+vjRLZm0dquigzNtCnl57S+MwIy2lgb9jmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB/5wHoA/hrWF2JRt58YAvB5kEdCKojklKDZCdgZ+Rg=;
 b=ApDf8TRw9U5+WXI7BcD4auLSRyvhNLGNgmp8/Paayl7eg8g2U4an8CfQlKdr2WR2mDps/vdy1mmGh84dNgJMBug7Qr8njbiyQyGQCZXyTQadlA1AR/crYbEGi9KFch1CTjJShF64B9uVbkn+W3A3VETJnh0jf7WSo5wogIP+ucLtzHGL+Dnh7c+lfMU4/SEzO9ZAhTi/hrYJeiiY/lClvUlyJQPcJaqLNrCaLqxOkHlUDrAz8v+PI7BTGTsextqHEv+NfgWz5F2uKv3fXNW8ZYGAA/nN6XkjBimdy7PFEkk3vx4AaG3qukCviW1krXUqXTEMndB7QjXCBFPDVs+hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB/5wHoA/hrWF2JRt58YAvB5kEdCKojklKDZCdgZ+Rg=;
 b=EC2A2DbGvT3wBAcdAAUPT1n1Ux5Y/hAj0kLMtpyBhymhrZY4ocLR05jsFbNP3Dz6rPNd8aK3erHNDGe/OgBkTi9yBgfk3qFg+I21EtBlMBK3PgcRu8ItraXJEdZ3gMS7tyxq4qEyOOCxOczrNfYBbpfks2pU2iG1a8vWfUkVgwk=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Fri, 7 Mar
 2025 22:33:10 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 22:33:10 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
 <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Jiri
 Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        James Clark
 <james.clark@linaro.org>,
        Chaitanya S Prakash
 <chaitanyas.prakash@arm.com>,
        Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support .gnu_debugdata for symbols in perf
In-Reply-To: <Z8tbEgh7rZscggv6@x1>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
 <Z7-QZKNT4Cc8lspM@google.com> <Z8tSyzcHF2V7Lofx@x1> <Z8tUmcIH1qTF6YTn@x1>
 <Z8tbEgh7rZscggv6@x1>
Date: Fri, 07 Mar 2025 14:33:01 -0800
Message-ID: <87a59wwjxe.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH0PR10MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 19999e41-1ec3-478b-af58-08dd5dc809c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnlGVHc5S3V1dHRhU0EzNUdjWGtyTWt4QTF2OWtMTXpBT1F3S29jL0ZJTDBx?=
 =?utf-8?B?TmJsZVdFcjBPdERWN2ZYYitZNHJPdGwwNE55YnBBQTFlUTlYZ1VqT01CNmdt?=
 =?utf-8?B?THo1R0tMOWlTejBObGQ4WHYrT08zMTB4cEl3ZnlTN2JCZ0toOFlsbWd4ZVNy?=
 =?utf-8?B?a0JtMWN0dmZpbzlNUmlxVlo3ZWg0SFYwalFMeXdQZERIdzlyVGtyanphK2xm?=
 =?utf-8?B?NkhYRUZla0Z6czduZXppWHpsc05taXkyems3dDFnZTRzbTd6SW9vOFB1aVZC?=
 =?utf-8?B?L2xTa1dXMEN6bzE4Q1piN0t2cFpXQnZiMTJGbHc2TUFYVUhGbWVwSnB5d1pY?=
 =?utf-8?B?eTh3SG0rVStkc3YraU1xb0tydEJ3cVpHeDlGTTZDdk9lbko1Ylc3U0Y2UTBn?=
 =?utf-8?B?Z29PL3dmTFdaQU5HMDhYZmFIK3RKejBPZmQyUExYbmc2QVR3U0VIL0Y3ZXpq?=
 =?utf-8?B?QkJieFQ1dmhSY2tONDVZWVViZGR5YmVWQ25jRGRPaDQ0SGcrVXZzazlBdWhU?=
 =?utf-8?B?cWNNSWhkMDdRRk1ZYlRJeHpRcEV6NDNJTEtPQWZGb0x0VXdvZkpPQjhyaGN1?=
 =?utf-8?B?WmZLZUk4dXZ3UVRwMXoxOE95VGVsK0JGaVdZRlVyUkxmbUtMaXdmL3F4SlpT?=
 =?utf-8?B?bnp2MjlGdTRFVUNBM2dkY1BCdC9aS1NRWkRZQWVEa1hqaVpHblRXVURPQlZt?=
 =?utf-8?B?VzdWbHhHajBvcVl4SVJ1bHFyTjVPV0dDLzhLZGNnWnpYeFRXL0xDeHozM2FG?=
 =?utf-8?B?Q255bVEySXBMbEtISWtUOEZYR2NDbC9TaXBxcUQyQ2xpTlpza2M0Z3pzditz?=
 =?utf-8?B?VVRkQiszZGxYLzZxVXh2MHJ4NWFnRWUyaHBpQkFEcnBqcWd6YWM3SFp0L01a?=
 =?utf-8?B?MzdnTEZQSDg5SXhVQ3hKb296VlJQbmNkb1B3Y0JSOWNxaHNjN0tLVE5PcmdN?=
 =?utf-8?B?WlQyd0ZnNGlBVGpEQldDV2pJZmRkY3VaREt2UDE3SFEwN3c2R2YyU3lvQnhy?=
 =?utf-8?B?aE54SVQrdkZCZGwxSXRJbmF3aEtZcGN2ZWJuSCtBOTB2Mi8rNlpQQ245QzBR?=
 =?utf-8?B?QVdUbGhoTlJHNFdpdWdUUXk4NlN6ZUw3YVpLQXdtRjVYZkNlQkpqSnl1VDNZ?=
 =?utf-8?B?SGxMcjArd1F0OGtxOEhZcERrZjBTenJXVTFxeThmeVJvOGJIMXZFbG96eWdD?=
 =?utf-8?B?VXpaczdJNFEySkxNbnkwY3VTK2hCRGhvaTVVejhpeWhHWVBha3N1aU5LU3JH?=
 =?utf-8?B?NzNUU0kvT3FKMUxQalMwVTd0Y0llZmhKVkJrR1JDQm1hbXl6cGw5Y3ozUDhm?=
 =?utf-8?B?aHluZ1N0QjBCbUdXYzhlN0tORnJIWlU2a1ZDMHBSVU9BSGlNWlp1RHFTSG84?=
 =?utf-8?B?NHlyOTFaWnZpS29MVkgzUE5SWHlBcVZtVmdpdUtjaVJ1THN1V3k1ZVM2Ymcx?=
 =?utf-8?B?ZFI2ajBONThSektRcFVPRk5tRnpsaDBGWUtGK3Rnd28wS1IvRTZ3MEJiS25h?=
 =?utf-8?B?YnBUS29xcjM4cElXVzJ2V3VEQnBqV09iZ2lKUnV4bmJFUytsNi9XSTBkbGpF?=
 =?utf-8?B?bG1YRnhFSk1yWm1SZ01ncFJHRS9rSHA0Q1gyOTBTdm1MUTdIT1JMWWt4S2tv?=
 =?utf-8?B?OFl3MmZ6SkVJdjlTZWRKRUlDU0pMMHFnOVM0Q3VCYlFnbVk5YXM2TXk2RFA5?=
 =?utf-8?B?MGZRdmZFMzA1emRxUkM5OFV2cmVLTW5LMjVDTmlUM0toL0hYRHhNNEpPRlpj?=
 =?utf-8?B?TGNZeUt0V1NFMnIyKzNzTFJYbkxvaStVOXVMZ2ppWEh5eTc0ak1LbGxTRjlS?=
 =?utf-8?B?dFZUcXZPMGp0VWtvbzc1b2RvdS9HMFFGUXd3NVFuQ3pWalI4UWlLVlRTbzl6?=
 =?utf-8?Q?yk5XQfQ3PKCeC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elh5aS9jU0R6clpmbEFjTllTaG45OUc1dzRlcjhRV1Zid2Z5ZmZxa0s1VUYy?=
 =?utf-8?B?N0p4MDVWT0p5d3JYY2czcURPKzk5ZEo3cnV6UWtRdDgrdUhaL3lNako2L2RB?=
 =?utf-8?B?OWtkRWo5dFJIQlFJcXZsWmI2VWh1RWR3YmhYaFltSUxDbUNFQ1VmeThoT29y?=
 =?utf-8?B?U1lTdUQxS2VpR09IcG9kYXdtRTlmK3Z2bVRlcWkyb0lLU0J6RlZEUStiWllY?=
 =?utf-8?B?M202bTcvaDc1ZUN5RGxpQy9IM2pKQlVVYjExOU1QenJhRXJhQ2EwVU92SWZa?=
 =?utf-8?B?Zk5ZTHRIcjlxWEVSaklIR2w3NG4xbDJFR2pRZnk1VWNYcmN5QWFPcnIwQ20w?=
 =?utf-8?B?WEZIVXdmRU4xRnkxYlNJVVRYcHBaWXFOMEs1b1BsR1lJQ0N5Mm9DQ2V1S3FU?=
 =?utf-8?B?QWpURVgxOVRQTlppUy9xQVo0QzVDUlFtbTFNUUVNRUp5ellWZE5oVDk1T1ds?=
 =?utf-8?B?eTNqUDQvQjE5WFhuMFUyYWVmMEdmZ3pmV1g0cTdUNnh3elAxUmlnOFlSWVFl?=
 =?utf-8?B?MmxYcTJhUURNNDNpdnZhcDVva01uMjd1V2xsWjllYzJobzk2eEc2N2N2bFRH?=
 =?utf-8?B?eCtPTGsxT1I2bTc4NmVNVWRkNTlOZzk3bDA3Z3FxVGFTTkUyTG9NV051WWRa?=
 =?utf-8?B?L2RNeHFPbVhIZVdGemtYMmliNHEvVTcyK2VCZXBNU0h2ditIQzRwaE0xN2JY?=
 =?utf-8?B?a0taL3BsL0lQYm5nQjJUNFErQXlWWFpURWRDMGlDSFhVbjRoak5XWnVqblFi?=
 =?utf-8?B?bzdVV2pEWnBMeEFUdkVTK09uTXpiR3VSWUhUZmhIQzdQaUxrTEN1a29RTXVp?=
 =?utf-8?B?a1BGQllVR2JOeVBJTU5UUURFSTU2VmYxNU5ZUkg4MTNEUGNPK2V0SU5heFQr?=
 =?utf-8?B?aU1YU2Z0U3VEZjRKaFVPRFc4WUFSZmVUWjJlL2JRRnkvWHhueFRMbWFHd0tX?=
 =?utf-8?B?TmlCM1EwWm0vZFRuUWRTY0JHSlA5S0tFcnBUUCtVaXBRYWJrZ1RDLzZoQ3A2?=
 =?utf-8?B?SEQzNXNocEprYmhnVCtFYnFxZUVNTXYxNzhhQktseG96V1J2NjJvQ09VdWpQ?=
 =?utf-8?B?MTRobksyQm9DNGh0eGlzM3RWc2NNeGhHYkNXbGg2eXVuWXdCL0haZFhkM29n?=
 =?utf-8?B?WTRhN1VEbWlqK3JVQ3M3eWJ1U0JQQlAvMm5aS3ppaFhhTWkreXhtVmVnK0pX?=
 =?utf-8?B?TjNKa09zTU1oemxhbnRqQis5Zk90YmdJYXdWK2tkbjNGK2pMUVhXUDl0bjJq?=
 =?utf-8?B?L2VHSm1DaEx0WC9vZll1QUtpS1NTYVN0TWZpdE1YZitzMy9ET0lSQmcrV0Rn?=
 =?utf-8?B?U3ZuOXVrekdRTDdvYnRXUm8zekgweS9OQ3QzcnlzZ1pKbGhYSVJtQnRFVDJx?=
 =?utf-8?B?Z2ZITVlULzFEMURtd2JuZVloZGRQMDc0V0kxVUFyU1I4eG1ISHpnNVhPQ3hO?=
 =?utf-8?B?TktVVStQcVJGMHR0TjRJK0JFR3hNYWhabzlwa0I2bDlWRkZHT0gxVVdaUnJJ?=
 =?utf-8?B?b2szcU9jcitiWXBGclV6Q0RCQUpvbTRxVmk0ZWw3QjZPUDk2NkFEemQ0UFFn?=
 =?utf-8?B?emNObTRCcDRyTDhQN0JQUjcxeG5zMG42T1NJcDd5UHN2aUZsYzB3THo4OW43?=
 =?utf-8?B?cHQxeVZrSHExOHVyOVBkTDJYejlobXdQdHM5c1BtUFBMZVh0dU02TVlsbFRm?=
 =?utf-8?B?QW5XNE13V2k1ODB5b3ZBR0E4L3pLdkxMb1ZhNkxoL0tvM2xyL2thRklLSWtF?=
 =?utf-8?B?MUw3ZS80Q0d1YjdzMEY2UHJPNnFRRGJoT1BJaFRLbTBJcFVRbG8vQzNxNzht?=
 =?utf-8?B?OVBzTzlEYlQ2TTRNcEY2ell1V3l1V2tLZnd5eHBXQWVlVUMyRUhvK1V2SjBC?=
 =?utf-8?B?b252VzFQc0IrR2dqOXFWL3Q0RkJBdndZZldpSXZxdTVHZC9kR3ZEMzhTVzZ6?=
 =?utf-8?B?SWNKSVNiQ0VWVlpDM1ZpSkpSQlhyUnlZbUx5Tys2aW40aEdWb3lWeG1ENS95?=
 =?utf-8?B?ODFkSWV3dU5OcE94cFFmek9NSUtRN2tna1BYZEc3a3hza0gwM084MmRSMVZs?=
 =?utf-8?B?cjlwM2tTZFNmWkdhczA0dHVZOXFjL0x0QzJoYlJObG5ad2VsTFVrWnFyaEp6?=
 =?utf-8?B?T1dqdmYza3NpRkQzQm1PcGErYWJNVW1JVkhPL01iYjc1bnZ4engxcFhhY2Y5?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PfRicdooyWi7ZLvDDhtgogMx3n4hSQ/AqV8uSb+ZjtsXs+ejd1vU+kkqYgJ44wDzQkB2ZNsVS+R35NZPfOQBwykuhbtXUDJiZexPiC4enEA63rronfaieWiMAiF/IrQBn0xMRqkIBUfWs3gLqgzNBdCbvRtCIQgrWraXZxxv/g2neCbuqADO2mCC4N1i/bc3NURj4BwQYWI8n053OLTE+b9YNdZeaMiHRBArA9uO293KnICs6TFkHTjiCJxkXQS5P1ejoM5pA8A6T1Dxm7SZXiDxIpjGHsRMRsJj4FzLjJ0q8US9VtnkqpHpofko4PJ6STP62rldqsOEyR/M3bfgjbaho5qVOnmRTjdUWG5KXEdEb5yan3e2o6YL6WeIg8EvLwmczEsk2PPjd8l+vDlxWRlDTisGPc1D3FdpwsrY9+kYzLnLgQp38YvlBp1E6o2Yibj3YqCntVtiG6WQoZxIU1ZqnijSKRnDVMqVTSrKeo4SfMGc68ioBZC7MbidMwThbkdTqb1PAen4Qwf2aC6lKynjyrcZZgGVq+XlmF/BFrJ7VMVLxtmMFbBYD2e0c/eXPhT35hqETmeppvo+Fw+btUVJ2wLzDxeab2LuwHfvya4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19999e41-1ec3-478b-af58-08dd5dc809c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 22:33:09.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQRIGjZxY42VeFNmQQ7FX+z7cqL02Dv7/Un4qxyoOSIpYe9VQLS1h1QTpW6dFobFTCVU83O/RHYHamtM/B4lvfHqplmz2SFPtrh62WU8SmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070170
X-Proofpoint-GUID: CmOZtjLEHPLj39sBe0TI5Qd_7ePBa65u
X-Proofpoint-ORIG-GUID: CmOZtjLEHPLj39sBe0TI5Qd_7ePBa65u

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> On Fri, Mar 07, 2025 at 05:18:36PM -0300, Arnaldo Carvalho de Melo wrote:
[...]
> It has a way to use that section tho:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ man eu-readelf | grep -A2 -- --=
elf-section
>                [--elf-section [section] ]
>                [-w|
>                 --debug-dump[=3Dline,=3Ddecodedline,=3Dinfo,=3Dinfo+,=3Da=
bbrev,=3Dpubnames,=3Daranges,=3Dmacro,=3Dframes,=3Dstr,=3Dloc,=3Dranges,=3D=
gdb_index,=3Daddr]]
> --
>        --elf-section [section]
>            Use the named SECTION (default .gnu_debugdata) as (compressed)=
 ELF input data
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bi=
n/find | grep -w FUNC | grep -vw UNDEF | wc -l
> 339
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bi=
n/find | grep -w FUNC | grep -vw UNDEF | head
>     1: 00000000000056d0     35 FUNC    LOCAL  DEFAULT       17 entry_hash=
func
>     2: 0000000000005700     34 FUNC    LOCAL  DEFAULT       17 entry_comp=
arator
>     3: 0000000000005920    121 FUNC    LOCAL  DEFAULT       17 subtree_ha=
s_side_effects
>     4: 00000000000059a0    992 FUNC    LOCAL  DEFAULT       17 worst_cost=
.part.0
>     5: 0000000000005d80    449 FUNC    LOCAL  DEFAULT       17 traverse_t=
ree
>     6: 0000000000005f50     73 FUNC    LOCAL  DEFAULT       17 undangle_f=
ile_pointers
>     7: 0000000000005fa0     72 FUNC    LOCAL  DEFAULT       17 looks_like=
_expression
>     8: 0000000000006030    303 FUNC    LOCAL  DEFAULT       17 get_fts_in=
fo_name
>     9: 0000000000006190     35 FUNC    LOCAL  DEFAULT       17 inside_dir=
.part.0
>    10: 0000000000006330    451 FUNC    LOCAL  DEFAULT       17 pred_sanit=
y_check
> =E2=AC=A2 [acme@toolbox perf-tools-next]$

Wow, thank you for teaching me that!
I had been using:

  gdb /usr/bin/bash --batch -ex 'maint print msymbols'

Because I knew GDB had support for .gnu_debugdata. But the --elf-section
argument to eu-readelf is much more useful.

> So there we can find the new entries, such as the top one in the example
> profile session above:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bi=
n/find | grep -w FUNC | grep -vw UNDEF | grep -w consider_visiting
>    48: 000000000000b460   2544 FUNC    LOCAL  DEFAULT       17 consider_v=
isiting
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> And trat address matches the resolution perf did with your patches:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf report -v --stdio |& head
> build id event received for [vdso]: a2184b81fbbc08eff401d16259eca8ad5f9d8=
988 [20]
> build id event received for /usr/bin/find: 3faf3f04d1b31abc9e5ce8428110e4=
24fd980a37 [20]
> build id event received for /usr/lib64/ld-linux-x86-64.so.2: 765f7ab0f356=
9ffe98de85864a0cedda9b686994 [20]
> build id event received for /usr/lib64/libc.so.6: c8c3fa52aaee3f5d73b6fd8=
62e39e9d4c010b6ba [20]
> build id event received for [kernel.kallsyms]: c3fbb7df4dfb94762b1648bc65=
e4363e50f45585 [20]
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/find
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf report -v --stdio |& head =
-20
> build id event received for [vdso]: a2184b81fbbc08eff401d16259eca8ad5f9d8=
988 [20]
> build id event received for /usr/bin/find: 3faf3f04d1b31abc9e5ce8428110e4=
24fd980a37 [20]
> build id event received for /usr/lib64/ld-linux-x86-64.so.2: 765f7ab0f356=
9ffe98de85864a0cedda9b686994 [20]
> build id event received for /usr/lib64/libc.so.6: c8c3fa52aaee3f5d73b6fd8=
62e39e9d4c010b6ba [20]
> build id event received for [kernel.kallsyms]: c3fbb7df4dfb94762b1648bc65=
e4363e50f45585 [20]
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/find
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 163  of event 'cpu_core/cycles/Pu'
> # Event count (approx.): 68126524
> #
> # Overhead  Command  Shared Object                    Symbol
> # ........  .......  ...............................  ...................=
....................................
> #
>      8.72%  find     /usr/bin/find                    0xb498
>      7.90%  find     /usr/lib64/libc.so.6             0xe51e0            =
B [.] __GI___readdir64
>      7.44%  find     /usr/lib64/libc.so.6             0xa77cd            =
B [.] _int_malloc
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> The only strange thing was not having it resolved in the -v case, which
> I think its because you added a new type of DSO but didn't update the
> code that does the 'perf report -v' verbose case?
>
> I ran out of time, have to go AFK now, can you please take a look,
> Stephen?

Thanks for the catch. I double checked all the places where
DSO_BINARY_TYPE constants are enumerated, and it turns out I missed
adding an entry to

char dso__symtab_origin(const struct dso *dso) ...

I assume that the array defaulted to '\0' which terminated the string
too early for this line. Oops!

Most of the letters I would associate with ".gnu_debugdata" are
taken (namely, g/G for GNU, m/M for MiniDebugInfo, d/D for
debugdata...). So 'n', for the second letter of GNU, is my selection
unless you feel differently. With that change, the table is fixed for
"perf report -v". Here it is running against my test data focusing on a
symbol only found in .gnu_debugdata of bash:

$ ./perf report -v --stdio -i ~/repos/UEK6/perf.data 2>&1 | egrep yy_readli=
ne_get\|gnu_debugdata
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/bash
unwind: yy_readline_get:ip =3D 0x55fdc4509dbe (0x33dbe)
unwind: yy_readline_get:ip =3D 0x55fdc4509dbe (0x33dbe)
unwind: yy_readline_get:ip =3D 0x55fdc4509dbe (0x33dbe)
unwind: yy_readline_get:ip =3D 0x55fdc4509dbe (0x33dbe)
unwind: yy_readline_get:ip =3D 0x55fdc4509dbe (0x33dbe)
unwind: yy_readline_get:ip =3D 0x55fdc4509dbe (0x33dbe)
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/sed
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/date
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/sqlite3
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/sleep
     0.20%     0.00%  bash     /usr/bin/bash                    0x55fdc4509=
dbe     n [.] yy_readline_get

I'll update the patch accordingly.

> DSO_BINARY_TYPE__GNU_DEBUGDATA should be handled at...
>
> int dso__read_binary_type_filename(const struct dso *dso,
>                                    enum dso_binary_type type,
>                                    char *root_dir, char *filename, size_t=
 size)
>
> But you have it there, ok, I'll try to continue later.
>
> Other than that the patch looks great and makes use of this new mini
> symtab, excellent!

And thank you for your testing!

> - Arnaldo
