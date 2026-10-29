Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793236168;
	b=AKtmXtmp9de1evnNYCIty91MWD3ZGb75aUQ34ZincVNfpkH6XLK137oTh5Ag81S/XtnP
	 G70w3PNu/oCdjUTCi/kEdTguvwkF5H7KFruQBUg57vmZAqKn2klPE7poFNw0F4YgkDNuc
	 sMzfOE2uZ4zFCX0+2k2XVr4U3y2+Ny+N5O9LC0CYLaidB73GenBF4vAzAnmzVz9cdFWpn
	 xWwz3X48W+L4abUjGZL67yH6AXGEL5F4yrMv9j2ePBq4lkbWe9r/El9wq3Maytnr208pa
	 8+pt1B/fJCa9uLjtCBK3ZvpvWfAatLcVVOFEYrl111dz+UJxzqbTFJ/jgdSeNm78J1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236168;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=J0z6i/x+SSReuexKdxldMPnjcr1rAA0IW7TCb4Fznoc=;
	b=kguIaVKfhGv7ZWfeU2svOYDyf7XtvBeQJQPoPFsauB67HwF5yn+u1Kfloe4yyAcT2K01
	 4TcoGM04KbtvGe2SlNsqyGvxRTYD1WBsl8yUxWJjG/ZF3HEWqQrD2j7Ept5Tg9RjqsPlY
	 lZWL3tpqATur3sAKBpZA0Nx2Luf++X9ucQYc3BBA/NnzXbXB+KjHX2rJUu1wDu0ttzhZJ
	 oRQPwMnf3aUNgDPg0kvjoP7VPnUH4Sb6s+C2MjM65ufbB8XYuviAy0vApYiZt3p64syyS
	 avVTwdFnuwiEILcPJb2tOB8WPRHqK6Pek4lZIKipjPX1ESm/uAY8qM4E4UoTd2mWCug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=os.amperecomputing.com;
	spf=pass smtp.mailfrom=os.amperecomputing.com;
	dkim=pass header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.a=rsa-sha256 header.s=selector2 header.b=LuFq2tqE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.98
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022098.outbound.protection.outlook.com [52.101.53.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290F606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 01:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C290F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.a=rsa-sha256 header.s=selector2 header.b=LuFq2tqE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5nkIfdDqHC6NBTTObUcj3FI0O0A4culfIanVbeypH/7QKIhIS4gP1Z4xXnjEBajviIQQxoDsDkC2/ghcfwOEaW6hydbr9hgz7NKSF60CmEtKlpiQ+w/HoCKOTlNXCUGaR9gqc/JHttYt13LpvjtF3aq8Uf1w8i6RA6MJIEfLDJ4sLZujKHRdH6GVfJ/MxaYT5c2ylIvXFFByn1+kaYA4mC7wSY164Q86Iu34rWEVoJlbdGjIC+QU+k82Fopfm1l9OecZ24DT5T5udnfcizUopJJuD511FahrI2iN40uxjDPFlm5B7wrUTBv5Ud7vBGF5hEGdBcXRhhLMgeL+H35LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0z6i/x+SSReuexKdxldMPnjcr1rAA0IW7TCb4Fznoc=;
 b=Llo6LaTokkepQWaTffKYw7EdqN7MOLVKj3IMpsbDN3nwIRSG+gc81z0VgpQ4XANZYub8hVtBlETiPW7y2TL5hX8eXwTR9v1uZTuuJccwnBWaiKvNZbUg9p8J1j3ph/COYGHpfh9Sbjpb0aXjDlmav48qUhF/SBQUQbzrzZyVlevZ8MkaCBP6Ck90X5zIG4J+tSHye6PdxAY5xRaDqSGgMz/eAL4RWpOJQUhMOR41yDzEpUliWIaY6X4ITL3Jn+EFqEd+ngeZGFXJAmWwjgBSr5tpghjFjq9jkmLYzx80wIWSbbbF3j2PEYSXaXe8MU5iWLzImhoKE2roQWbvJHjn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0z6i/x+SSReuexKdxldMPnjcr1rAA0IW7TCb4Fznoc=;
 b=LuFq2tqEM7man8wiTO9N15+09EDFvcQZkpIqS8jwcS1q63OohafJFLwG+lm70E8Ms6cU5WgqSZTwoRqVX/4G4O+1BmUSANe9Jw2yFlY56M9pgZ2RXqiRrlkNY2PUWGZ9dfYv5r7ulwppMccS+eHxL5nht5x26DUaxJOsKDcpdTc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH3PR01MB488663.prod.exchangelabs.com (2603:10b6:610:34b::13)
 by DSVPR01MB352955.prod.exchangelabs.com (2603:10b6:8:37a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.8; Thu, 29 Oct 2026 01:09:23 +0000
Received: from CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973]) by CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 01:09:23 +0000
Date: Wed, 28 Oct 2026 18:09:01 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Ian Rogers <irogers@google.com>
cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    TAKANO Mitsuhiro <takano32@gmail.com>, linux-perf-users@vger.kernel.org, 
    Namhyung Kim <namhyung@kernel.org>, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale
 BPU_FLUSH_MEM_FAULT entry
In-Reply-To: <CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com>
Message-ID: <d310869a-26c0-06b3-2043-4d94b14a9074@os.amperecomputing.com>
References: <20261021224527.167637-1-takano32@gmail.com> <auEK6E-jX12Bi8u_@phoenix2> <CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="8323329-1501527541-1793236163=:24101"
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To CH3PR01MB488663.prod.exchangelabs.com
 (2603:10b6:610:34b::13)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR01MB488663:EE_|DSVPR01MB352955:EE_
X-MS-Office365-Filtering-Correlation-Id: f718e8e0-e74a-49c6-1082-08df35594501
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|4143699003|5023799004|56012099006|261026140227099003|261009223027099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|10067099003|261021123027099003|55112099003|18002099003|22082099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	8ziuN/x79hQhvur9HiARd51dCEv4r2i/hMKpRUa2egxSr/GP3SFijl+0NgP/Qd/uj53eeszlgfuC8DsD8nECTK3EDOwNtTz4AM8DgOMmzbz0Ozt/OZ82IxU3D9eu5eIrR8VdEwSOr677xws33Yxw9lkO5j57OSyWo3cPH38i0G+xdzTsKpZHoLd+0iE18pFEb7GRSOfJ9yQPeHKcXgvfNpzPf0k90FY0TYxI9Dw+66gbNjw8XGpzyjGy9ZUGQXMb3O883vYxGy1AIASlRTBsXB+7E9VPxXtDL7iisz8yuZT7z2x4l3lcdSzKIlmIUYBWluG+HIdTSqb0BLK9c29EwZUFrS0XOTGvQtLeZaeLzgw7DjLPEre8QgIBqT+/GZXYd4hhwXfD49yhef2bFuvZvM+MaqiVpg2pbKBI42QA3uTfcWHPJNTjar/7pupDSfbDSoSKh/oEFpF8wQ8ZntOicoce2aGpMYWZvDBIXCM/7CRbQ4sMEkDbkd7DwMnkgwFCDDBB8JizkkbOtSqLyUQCHADdfYWGut9L1rMcgpgK8AH/bvPHGHihy/ZumO1UbEwFeqtyweL6zp6TTIukoF4+kybuJlN6DDdAkm25MUWaA1xtAZtPbaWG+9ulV1Fm6H4hr6sJrMaNC4Hag+Wj9YL9z8AJqG9XVYWV0yGPGr0pp6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR01MB488663.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(4143699003)(5023799004)(56012099006)(261026140227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(261021123027099003)(55112099003)(18002099003)(22082099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhLVkh3RUM0NjdWOUdCS1RoNVEwSFhQUmZmVzkyYnNOeFJlejgvTWE0YVZs?=
 =?utf-8?B?Tmk0NEo5Z3FtclBjOFpOdEVqWnFGOEZYclM2bzh5ZHdScTc3VlZYR1l4Nmd5?=
 =?utf-8?B?YkpTOTB4SjBxZ0xjREFiYzY4bXAza3lwa3V5VEt2RnE2WWlWRHNkSHRLVnRo?=
 =?utf-8?B?M2RJc1pzamphdENmTFFORzRuVzV5YWRqdkIzVWJYVDR3ZDRkYS9rb01laGM0?=
 =?utf-8?B?b2l0b1FqMXJadm1tVW16cDFUTHVvaCsxTnhGblZqVnA4VEJCV1I3NU1QcUpk?=
 =?utf-8?B?a1plZWVqVDRIU2VmYTg3aVptcU5WQi9pbFVQK0x4SFkyczZvM04xc2U3Sm03?=
 =?utf-8?B?TkFYKzFPczE1VXZQdkJ4aGV4S3h0eDJrN1lWVUNMRjdQYzlKcVE2akVOTklZ?=
 =?utf-8?B?NVQ1SElKMHB6MjJUQTVnNUhaeXhJV2s3N0ljbzUxTzluR1MzOXVEanVwQWw0?=
 =?utf-8?B?bmdKVEFrZ04wQURoYTNHc2MwemdlZlRIcFpicUtxWE1IRUN4eS9mRFNrL2VW?=
 =?utf-8?B?bGZLUWpGUjZ1Sm1nWFZ0Qkt5enZwNWVUSjNJL1drRmJtN0F4b0tQci9xUkp0?=
 =?utf-8?B?KzV0a1NNdHAvYm5iN1NvWEVxem9JbkdhdXk3WUpQWEdBZXpiYlhzK1kvNERX?=
 =?utf-8?B?Ti9va3FKb3RlRi8rWXg2WTZIMmJ4VkJSMWRuSnVZWWduYmptekFEcng4RGRy?=
 =?utf-8?B?WWRmVUlONnNMZ2hINnlTbWdBeGtYQktDSWZCMGFvbUdFd0ZIdG1jS1VCeXNN?=
 =?utf-8?B?Ym1JYWgvQVc2WFYvNStheXhtdkM3eEFyTVBVbXduNzFaZmdvWEp1eFVoNU5D?=
 =?utf-8?B?elc0ZGhaajV3aloxdDRQMGQrV1dyYWgrSHJ2U0kvZWJqZmJjNGE5azdzOEVE?=
 =?utf-8?B?dE9jWE9EOU5vNENaQUp0eTFTYjlIRWgzaE1MS1lIcjVoSFJUUEV1VDg1QnpP?=
 =?utf-8?B?V3lhVytIdVIxaDlRRldZQlhsMjQyTFN2MTFnWFlPTnQrUnFOUVFVbHlvQkFa?=
 =?utf-8?B?em4vSzRTbjVtNmE1QWVBa2xCWUxnWkZOaXplcjJxbjJqSjY1bm03dm5PMlZx?=
 =?utf-8?B?TTc4OFRQbjF6MzEvaCt5bUkzM1dGb2ZWck1BdThhSnlyUTg3YXZWMTdidzI3?=
 =?utf-8?B?ampTU0FBYlZoNHNwRXBXZTcrcHZkdFE0K1FGMW4xWFliYk9KaFZvdXQ4dTJo?=
 =?utf-8?B?QUVuNW9XbjJGaVBXbWx4cWsxQzdVaEd0K08vdGwrUW9vcEdad1ZrQkZjN0FF?=
 =?utf-8?B?Y3ExREdRbkJzb2kxWHF5cHlOU1lNb3pvbGE5V1dsMyt6cVQrYW9Rb3prency?=
 =?utf-8?B?eFVXV3Y3VXVzWFNIS3ZUWlB5cXZ1R1p1ZmtvTmVvSkNNQStvUE53YlgvK3ZF?=
 =?utf-8?B?ZTFtcEdTQk1na3A2bWYxcmFWNkowdlVyU3VFVk9vYk1JSEdNNVNCREticDIy?=
 =?utf-8?B?OGtrOWRPWk1rc2E0b2F4WjJhcHNDejN1N0RnbnprZmpBM3pZbEdJT0hBMUpy?=
 =?utf-8?B?OFZGVUV1QnZramRBTTVySWRmckgxeFRnR29uNjNKMk4rU2xpMXV6bmZVY3B1?=
 =?utf-8?B?dUI5dkEvRjlvd0NaUUw0NkZleUhxcTc1aldFV2V2ajNDVFQ2M3NNZGxhU2g3?=
 =?utf-8?B?cnZhaWVjR1kyRVZFSHJUMUFaeEpYSDROZXdMN3J1dVRHSjNPWHpxQzkyK2Vx?=
 =?utf-8?B?RE51Ni8wRkc4WUFYUVFxRFFyYTFxMzUreUY1WFlObTVvdjdTS2JQRENVTnJJ?=
 =?utf-8?B?UHhRM05WUGRkMWc4VGRvb0EvUEk3SGFXYTlaK2lQSnp2RkdVNUJmRGNUSmkv?=
 =?utf-8?B?OXJwQXNTc3lVR1JJTkMxNmo4TWprN0hXdEQ4WXM0UW52Vjc2TGZtUklxZitO?=
 =?utf-8?B?Z0t1ai9kK2VoU2s1cHVYWnZ5N3RlV0MySkZ3Nm9QV3h1aG1zM2FFeWN4dnRE?=
 =?utf-8?B?Z3JJS2t2bXJBMUpLbkJha0pzSzdaVk5GbzUzRCtpVGxWNkRxNlo5S3VlMUpm?=
 =?utf-8?B?K3MwbHpWWUtFbnBGUUZ4OUtnUklFK0RtZEFjWHdObGZHOGk2cTBsTE1KeUlO?=
 =?utf-8?B?bGZoRWJCOTVIRUpVU3NFK1ltdW9mbFdSRWJqbklaN0YrQ09xQmdDZEozWWZu?=
 =?utf-8?B?YUY4ZFBVLzJhMG9scTh6ek82cnhET053UlE1bzJlQS9VT1ZtNC8rMU9uMFVR?=
 =?utf-8?B?N25rNURUYi9DVzVTeDhwRnp3RHRqRXRsTHZMcG1KUmFZdEVZcGNJR2JGeTQ0?=
 =?utf-8?B?S1NBKzlvN09tWldOK2ZUNVN5N2lGTm9SbUZPd3BuWHRvVHYrZWsxT1dQeTlQ?=
 =?utf-8?B?am9vaVNyWURFejMwMVg4SUU4dmQvdC9oWTdpbGx1Qms1Sk9WdFk2cVBMN2hM?=
 =?utf-8?Q?IpSF30MZusRY0pW0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f718e8e0-e74a-49c6-1082-08df35594501
X-MS-Exchange-CrossTenant-AuthSource: CH3PR01MB488663.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 01:09:23.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLqFTQz6n9rl4G11It3OHukRdkRxTKSVWPWuIWJXQ1DQTPXdpCOY6VDSJPYRXu/OI3v+/9qEZ+NBOu2/XqDwFn2rfgdakVw5/qMJB8umVeJ+c3vW8hZWzLrvq6ERfU8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR01MB352955

--8323329-1501527541-1793236163=:24101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Tue, 27 Oct 2026, Ian Rogers wrote:
> On Tue, Oct 27, 2026 at 1:34 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> On Wed, Oct 21, 2026 at 10:45:27PM +0000, TAKANO Mitsuhiro wrote:
>>> AmpereOne carried BPU_FLUSH_MEM_FAULT for EventCode 0x121 until it was
>>> renamed to GPC_FLUSH_MEM_FAULT in 10a149e4b4a9; that rename and the
>>> AmpereOneX table were patches 3 and 4 of the same series, so the new file
>>> kept the old name.
>>>
>>> The result is a table that names the 0x121 counter twice:
>>> ampereonex/core-imp-def.json has GPC_FLUSH_MEM_FAULT, and
>>> ampereonex/memory.json adds BPU_FLUSH_MEM_FAULT with the same code and
>>> the same description.  On AmpereOneX perf therefore lists two events for
>>> one counter, one of them under a name the documentation does not use.
>>> No metric and no other file refers to either name, so removing the stale
>>> entry cannot change a metric.
>>>
>>> It also leaves memory.json holding only the ArchStdEvent aliases the
>>> other files of that kind carry: AmpereOne's memory.json has no raw
>>> EventCode at all, and neither has any other file of the AmpereOneX set
>>> except the ones where raw codes belong.
>>
>>> Nothing catches this at build time.  jevents.py asserts on duplicate
>>> event names, but x86 repeats an EventCode for many events because the
>>> code carries umask and unit bits (3756 times across its tables) and
>>> powerpc repeats five codes, so a duplicate-code check is not possible.
>>> arm64 is the only architecture where no table but this one repeats a
>>> code.
>>
>> Maybe a followup improvement to jevents.py?
>
> It is expected that events may share an event code but they may be
> differentiated by unit masks, filters, etc. We might have identical
> encodings even with these extra differentiators, due to old and new
> event names.
>
>>> Not tested on hardware: there is no AmpereOneX machine here, so perf was
>>> not run against the real PMU.  The change only edits a JSON table; the
>>> perf build was verified and the generated table for this PMU goes from
>>> two names for 0x121 to one (rebuilt, counted in pmu-events.c).
>>
>> Ilkka, can I have your Reviewed-by or Acked-by?
>
> An alternative to deleting the event is to add:
> "Deprecated": "1",
> as that makes the event not show up in perf list. Using Deprecated
> means that anyone using the event name won't be broken by this change.

Sorry, I somehow missed the original email.


Takano, thanks for the patch!

That seems like a bug I made, when I tried to address the specification 
change. I'm fine with either option, taking the patch or set the event to 
"Deprecated".


Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka
--8323329-1501527541-1793236163=:24101--
