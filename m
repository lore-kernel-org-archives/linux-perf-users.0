Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5910F2;
	Thu,  6 Feb 2025 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804282; cv=fail; b=OBdWSPRDFIIjYEF9ZMie7BuWZe7pwp8CpXJDXgbE3c1E89puudOoi1Zv8qkz9cIeUBg/TK4m/34ZNstkp+IK/vzGt+vjP9p0XLIYGcCXYHmNXCkoIKSi4vNAr5Qh1t1gyJcC8Dp7q3IKKhnQCmoSYKI9gVD13bANnTmkKUC6r8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804282; c=relaxed/simple;
	bh=S1hxggiVKFC2+uYhcFJVlz6NdAGWG9F0od9bozQ8Eyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aql3l5WL+FuNMe8mQrrozQmyXmWOssdYK+G67gdBoYOsDPfz3bRlfW0mSpz3EnOf/uce5ACOd/DefnCExll03VF0yA2QIlCG1DCn7gxZn2dlh7Iaq6PSjRrxOBm97Uo4KHB+xeovgLgP+QowbsS2TctQKwsXkJdAtxB9IJJZBOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kn2wM7lL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xEqeZjvR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kn2wM7lL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xEqeZjvR"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515N0wal013659;
	Thu, 6 Feb 2025 01:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/A9veZMO26zFOW3tvRrPoG7e30g2jcnf8cvSLRc2s8M=; b=
	kn2wM7lLakDTkeEyBQfAyERru7WrBRsEHpQequ7tWW9kZBess/wdb8oZp9Op4yXr
	N20s/ZoaETSObaaYSO+a4kXSDQzwmSYFV1OXSXNNN77RuKI2JnalZ/+II1RHeSGw
	87ShH2vbKBl4wg4TRdXeylIMdk3tHuO0mywsBRkGA8qnarDYWz21rfKK/yZiHhf4
	KdADqh6t/SHWYV62BbGBJzJjkJwcwBGETKfOxA7XaTByhjOH+opYEbQLBMWSZkBO
	vmQWQhAv2vtLUTX31zVPSmYm9uPum42x2Jb9zWglZKFAp0Ehg9l25kqUXGjVBPnx
	4nEpLzxa598eop8m4AyHrA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfch0h9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 01:10:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51602Kqn020619;
	Thu, 6 Feb 2025 01:10:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr65y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 01:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3oZCiXLkotG3LZefa6jn/k1VC3agkym/PDGrp7R6hafoeWuSWVMGotmkH24OYrsZ1Pn5AJhPwEXmUSVIA6eTVlVXc0H1erhOTKjcGgK/hbcS0GVG67Q/gdWv4nEQBnGEVbh/lijqVUP4IXGE02hDEmS2KycmkLsbiOPniJWJ7h2uQMH5IeZkx9mAMn61IhG56WGSfGgR079bkZ/xsGsPmKAp+JZ4WIRfDy6bpsZsVSsO3/Fe3no2bx8n0F3uL9aGPVFFWzassj0/8TuZfcP5W0B0notnnLjCuNUa1ZNT6Gc+7mir1Aann/zXaTYyzdHLjacYSJ5pNLw8j+9ddmlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A9veZMO26zFOW3tvRrPoG7e30g2jcnf8cvSLRc2s8M=;
 b=N5CsBY6D0KrmssmPKvRmNj7V0tlM3NA2ADvRzUjorbkQ3/FtVbjollXty3rBxBK0gnJ2ghWndXoLBhZC+uLjHXzkKPwT1Ui8X/VymDevdUta6hzbCOqMepVL4Ew0a2LN5eYDT9fo+4uCjgjU6mF6If8UOUiXG0Lnk2pSBqzfVa8KwHm8cx9PCCxLT7MCH6fV2XbLhLCwfoOJFuZXYcyjC/DtvYoEFB/63IHMsjgKHp+oT/VvwxETA0O6CxbIHWnfnxsp4Gna+RSTprEPKgUrgHlV3e+Ow8Zhq6TjQUAHL/KQBbdwTymGPvZduScwrloLGHKUUQxtC/HPSThoLLjoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A9veZMO26zFOW3tvRrPoG7e30g2jcnf8cvSLRc2s8M=;
 b=xEqeZjvR+y3LMMIXPJLEGhfQ9FS66h1301VjXJ19PIuinH9i7jbA5xYhJCLNEW57yBQ/pHmizZ7jXPE3pN6QU61YiWIITyJnlGLR3UdI2g8JDzDUWbcKD8AZj+ogAAFYmo3vCBsjcXhUqvEJ97BzQni+ann7t590enULkVjeO5g=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by BY5PR10MB4209.namprd10.prod.outlook.com (2603:10b6:a03:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 01:10:53 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 01:10:52 +0000
Message-ID: <85aa82ce-dde4-4ffa-8180-6616f72d6580@oracle.com>
Date: Wed, 5 Feb 2025 17:10:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
 <20250129020249.owmklacvuvss7z7n@jpoimboe>
 <e4a52247-af59-4c0f-9215-00ee83a61339@oracle.com>
 <20250205005710.35wdzvobyhm6zyda@jpoimboe>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20250205005710.35wdzvobyhm6zyda@jpoimboe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|BY5PR10MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: c8107a8f-4cc5-4efe-89a5-08dd464b1998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWVGZXBzUDAzNkFidkZCa28xaUQrL0wwdkUxVEI0K2lTU2RJY2dVbU0yK2xK?=
 =?utf-8?B?NE1ma0RCQzFBTmc2VE1pZXRQZlZ0cG1oSnVoTEViSjdla0RnMVAwZWV4QU4r?=
 =?utf-8?B?QmNKaFJnTzFMV3UxT24ySGRlRVh1RlFOK3F6Ukh1ZEVsMllNMmtUUmR1bUhH?=
 =?utf-8?B?ZGFtNE1rVmJMRDBpNVYwQy92Z3dhcXFtVDVOMmdnL25pYVB2dHRISmxUdHhL?=
 =?utf-8?B?ajl3ZHVmdXJhQ1FSbzk1MWNEQWZsTWpkSTZRbmFwbXhFVkdqOG9iUVFweCt5?=
 =?utf-8?B?d3VJZi9OTVNTSFlFL1VROCtHYkZYTXM2MVlUbUVNYlQ1U1hBQWh5Z2QvelRj?=
 =?utf-8?B?VGlIMFJKcHI1bytFQ0pid2JYajh1eTd6WHBJUEp1WEdteGJJNXpZdWMzSUZU?=
 =?utf-8?B?dHl1c2V3OUh2M3BUUVdUSyt5SjZiMmF0U2dNMmpmVG90OXlYMUJFOFZUZXhF?=
 =?utf-8?B?REJmbWxMemhwcnIwNkxzRVpocnE0MmdMd28xR210dDdZcDV1V0tjb1RTNWx5?=
 =?utf-8?B?S3RMV0p4azgvZlRDQzBKUWpPVGdyRGY0cGp3Mm5RdFhHaHJNVE04VmtQLytp?=
 =?utf-8?B?MDByeStLNlJ2Z2ZQTkhhTlFWSDU0cHRuOUYvekM5dmtWTHdoaFZjMGVFV01Q?=
 =?utf-8?B?TVVZNGgwZWRXWS9LNHVhYno4d1loY3ZmbXQrOVZHeEtLTGRIQzlyRFNuVnJG?=
 =?utf-8?B?ejZ2VTIxYXIwSHBWc1RaVjZKa2hkMWhvYWtIdXYva2hveENjWTZDanpPWU13?=
 =?utf-8?B?TVY4eW0rTy9aNm90RzhYZC9wamprRGRKSExJejVSeXJmeGU5NWppTVhrQkVl?=
 =?utf-8?B?SFZ4cjRxYzlUWHVyNStJTDJNVG9HMk95K00vY1FqczFTbGh4TDRkckdHTXRa?=
 =?utf-8?B?TS84RXlHNE1Wai9CT01PdUxyK2Y2cjFVcnovYWw0R2ZObVlvbDFhVHZZc2sy?=
 =?utf-8?B?NWJHeFdBVFhqOWZpVkFDRTUxRkxjQXozS0txUzlTY0lUanlYRmkxbjZqUnFj?=
 =?utf-8?B?ZGNGNVgvS1pqTzY4N0J0OHlNK3FScmxKWGM0L2YzdG56c21ocHhrblpRL05H?=
 =?utf-8?B?bzVUcnJEbXBLVm1qek1XaHUzWVB1U0V1NkxGMGttY1d5TERPZ05DbU5RbzA0?=
 =?utf-8?B?UDMwN2ZmZW9MMEVVbE5XVm02akoxQlBxYlBVem15L3JvM2s3ZmlsR1NTTGoz?=
 =?utf-8?B?ekJPenMxOW0rTXAvRHc3bjNibmJVL3ZpNlNWUjY1U3dBd1g5QnRyZmtYaDJa?=
 =?utf-8?B?STE0MU9kRno2dVlyZGdBcXFTbnhsMTdzWktaVkp0dFpveTg5eVpoRnlMcGtQ?=
 =?utf-8?B?UjVuSEJjMGdNNk9KR1FYOW5LU09yVUJqVFFWQllRQnNUUXJlbDY5V3RyWUFk?=
 =?utf-8?B?NXNGTlJnK2FGUktoNFRNNnhJNG4zUTQ5ZGRVQW95VTFHeTlWTmNLVXR0K1NH?=
 =?utf-8?B?bDJsVFdKVUYvQlpGUEdHOVQ3aFliWFp5WkpaVXZSUC9Kb21uL1lrYzNYVUNZ?=
 =?utf-8?B?Snk3VEE0UUdqNU4zbkVkVEdiaEdqczdza2dwTTdXbDlkNitRbWQyOXB3VTNo?=
 =?utf-8?B?VWxZSGtNOEd0bjVUMzZ2MUkzN1cvOVA1Vzd4MllIcnpKSXBRVW4yM3htT0cv?=
 =?utf-8?B?QUVtUjVOVVJMMkc0TzBpOGpvRi9DNm5nZ2dNZ1dydHBwR01GZEorRDRPbyto?=
 =?utf-8?B?WmtkUXBZNzNJQWZ2TEQ0VUhlRGJGUkNsK1djZTFLNXQ2T0h6SEEzK0lRUTFM?=
 =?utf-8?B?VCt0K0J2bzdOZzBjK2RYN2c2M2FqM296Q21Kd2JKQzV4ZWJZNDAxWW9yY28y?=
 =?utf-8?B?SjA3NDEzQ1lwVjRYblFsbXNiVmw2YXFxUWNiNUFXdk1ZTENUM2lmL0tkVzFr?=
 =?utf-8?Q?YgXoPcDuDXuNJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTl2QzJJL1dlTC9Bd3gyQ01tN0VhSlUxMUsxbVFzYlRqN0hTcldtbzFtaGxj?=
 =?utf-8?B?Qmc2bFAvL0MyMnF5MGlIY0RFMllMaDg0bXNHb2pBNGdrOFNPYXZzVUhocXZN?=
 =?utf-8?B?RStiWjdlYW5kTTlKTXVNZWJ4VWhVT0c1TnAxSG1ya0JpTlRJNlhUWjdiL1No?=
 =?utf-8?B?eXgrMk1OSGtVNzBlUGJnZ3NPRDNiTHVPTG9TSmVZKzY3QUZNeDg5VTl2a1Uv?=
 =?utf-8?B?ck1lWDl3YVorR09Xd3NrcE5tRVdrUS9Eei9sOWRCTERkS1dvWVh3SWMyREdW?=
 =?utf-8?B?UDdOSU13WGxZTVVzWnRoTEhSWnhQUFhPVkZYeU9pM0cyNFplSm9WdTc2T1RN?=
 =?utf-8?B?UWRGc1FqUmhERVdpVVpQRmpPeXJlRC9hSW5oR2ZvN1VSOXh2SWZLY2lGOVpy?=
 =?utf-8?B?dkJOR1gra1RtOFlORXczMVBnZXJ6b3Vnd0NwalpCTmFBVTJITERsdDNYVVhy?=
 =?utf-8?B?OHQyU0tBTm1kcGZFaTM3S3owdVJjSXU4R1NYdWZJMGRVWjdzUnJyTFhGL2RU?=
 =?utf-8?B?Y3dURjJ6Ylg4NE1SSlhDb3JEL3BWSXJWUHY0NFRBOTRWbmVmbld1ZG5yYU0y?=
 =?utf-8?B?MFlJMXVOamllaG1yeFMxRWdEQ20yMENOdkZlc2laN3JSY0J3Mk5tUWEzVzZw?=
 =?utf-8?B?TWJ6S0x2dDRoY09DY3dyQ0VvTzJ2alAvYjFwcTV2V0FBL1BvNWNEMW5NWkx1?=
 =?utf-8?B?VS9FeVpoY21GY1RRRGhnazhDaExxR1pHM2FhaEFsK3ZTSmNXa3AyMHdQTnI3?=
 =?utf-8?B?K3pEUGNMc3FKM3hYeUh3R3FuT2E0V0pzVWppS1cwbElybGdTbzVqL0xObG5Y?=
 =?utf-8?B?OVlFanI4RCtLL29qZmR3UzFHR1c4RGp2aDAzRmRyQ0NKMXJqbUtPRW1lSlVz?=
 =?utf-8?B?Z3Z1bDhUUEFmVERFMjhuanlPMS94VXlrOGtiU3FpRUZBcThwanB5ZFZQMHJJ?=
 =?utf-8?B?bjQyL3ZpQXZ1V1krbmtsZG1yU0labFBGeEhjblMzVmNGbVgwS0pNOFh2ZVhL?=
 =?utf-8?B?c2hUY2dSTnlSNFprOUhBZXlPVGwvR2FnTFE3TFVuc0dBVTZqdlRSWXY4Lzlk?=
 =?utf-8?B?Q2dIMmFYMGc0LzNrZXh0ZzNvVkRwR0JaYmhSTFBkSzU1TG1BQ0dzZ3ltUGJl?=
 =?utf-8?B?MTBBV0FaV3pjSkExU2tKeUxuUmJpdHRZUkExc3RJOStZd3hmUkNPczJIRkhz?=
 =?utf-8?B?OFVIckhHSzIzNXk4dTMvOENxY2EyZ2RHOS9lUFZsN1FFRjZ2RHpDU0w2b3lM?=
 =?utf-8?B?MmJqekFuNjJsaWdxaWxwWmhnUi9wcTJReUpPcWo1YmY3VEcxL0xCOXlwaHFY?=
 =?utf-8?B?bndTTVdKY0RiT245RjY4Umt5em9iSW14SVlqU0ZSYnIweVFoeDN0SFRrVTJa?=
 =?utf-8?B?Z3k3ZldqUjdhY3l1dXlQa2dDZmh5REVuTlhyS0dnSEZqcGp6bFZpdGhIMTBh?=
 =?utf-8?B?Q21NZzc3WjJDT3dpTUhuTSt6ckVjbGNLbk84TUhocnNnazBKaXNIVnRxZ3lz?=
 =?utf-8?B?Sy9SN0JMb3JxWlNoTGJ2TkVuNEZXTTIzbEoyYjRYc1poV0F3eUNPeFFUUndW?=
 =?utf-8?B?YXcycnRFa3kyYzVsaTU2aVNLeU1xVXF2OFh4cGxYNG5WdzJSbVRsL2tFK1Br?=
 =?utf-8?B?bThNUXNKSXZRdXA2OUN0ZjlVeU9vMWhJL3IzSnZBWjFrMlpvaWhFZEcxQ2JZ?=
 =?utf-8?B?M2xmaEJPbzdxU3lrVVJBblBFTDBFWk5TRE40Q1ZDa1MxSzFFMHVGVG5wMHJl?=
 =?utf-8?B?SjhGc3FGeVNQUTRBNzVqVExiVXkxbmxGRTNSRmE1ZmZRYk8rRVF4dk9YQjVw?=
 =?utf-8?B?YXY5OENHY1RJcVVDeTJqRy9XYlMxR2tBVE9UQXc0L3NTVFVRdElmNTUwSWd4?=
 =?utf-8?B?SjFPUUduWjh4SGpjRUh1TmJ2VldPMEpFNmNMclI4eWIvcU9VcWhTMDlpMHhH?=
 =?utf-8?B?ZFdkNWt3N0JiaWVaRVI0MUxZTWgwVTdsc0hqalhLWFRReWwrT1RhTlF4Qy82?=
 =?utf-8?B?aDFEZXgrM2sxaDl3OXlnemk2TklOeXlKY00vK1E1N3AxWWt6RGpOU2ZnV3NV?=
 =?utf-8?B?UnZxUi9kSkNURlNXRk5DaG5Zck9GMXZBMXdjTXlXMExiU0lsL3FXTzhYK3M2?=
 =?utf-8?B?Tm9sSEdzZHBBZ3RwOHN6R1ZNVkVvS0xOTTJkUjlhMVNWTE5PSTJDVjNKWmFu?=
 =?utf-8?Q?47spkkslqGXyf31XyQjYoVk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VKcItD9FDDnPZXJIgHB8w0NgNdj8jzo58jbH+EuIlbqcO42U6tvdTEn+aedNf+AyB+4omDTipTuwZLyFH4+9eJuEfBdwRlCX+lxm5LGBdzFMWAMEiJDTJx2WItOaMaZbKnxUFaVc16/Trm0nbE/gLzJ/SOlmVcfs+PsbWayrAxLx72ZuzOcXzJcJ3vCjM8Y4CnQ3mZSAGkfykngYAJWvQl2UCrIIFLviYRLomTMSrPwdlw3mWO5vxaJIUxVf5qljOHNWPN0gASK2W33+iOv3ricySfuaRFy2lLX6+pMi030zY95pyh92JtJv4ryn7YpW4LTC4ZxwEyAG0b4YmWpJ1AA2CDd/zNFgARIO/lCDPIVirnmF1e3O/5OWeo+LuBPUrTIHmIwFNNSXyCDkNuUJcHI5jdILQIRbtz5nG3UH5saF+bJh1KcEFGnbj5gtLtkVh/Fd0kRVskecEa4tz3s/U9WI/sp+DOqP0tN7U62rTPY3Nr7BC724FFdX9HxY0GYcOR7PWsAxU+ve7AeB7ZF6Skr31J225fT7onHP64J8nhqvHs8UNHbN7PlcPGK+U7vwr+DucM2OtKzLnnEmHOTMNue/mx364D4oBQi90TDG+/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8107a8f-4cc5-4efe-89a5-08dd464b1998
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 01:10:52.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmrMexjSLwJMkYeRcXtZC4Bj5XIjHjdcKKT74i5rhEPJA0dg/Q03bnAxWeWgwhB6JQHT5KfChogWaDRDtMm1Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060006
X-Proofpoint-GUID: iYSJAA0XQ7nfRUa-gzebmEii-xW-qgBC
X-Proofpoint-ORIG-GUID: iYSJAA0XQ7nfRUa-gzebmEii-xW-qgBC

On 2/4/25 4:57 PM, Josh Poimboeuf wrote:
> On Thu, Jan 30, 2025 at 01:39:52PM -0800, Indu Bhagat wrote:
>> On 1/28/25 6:02 PM, Josh Poimboeuf wrote:
>>> However, if we're going that route, we might want to even consider a
>>> completely revamped data layout.  For example:
>>>
>>> One insight is that the vast majority of (cfa, fp, ra) tuples aren't
>>> unique.  They could be deduped by storing the unique tuples in a
>>> standalone 'fre_data' array which is referenced by another
>>> address-specific array.
>>>
>>>     struct fre_data {
>>> 	s8|s16|s32 cfa, fp, ra;
>>> 	u8 info;
>>>     };
>>>     struct fre_data fre_data[num_fre_data];
>>>
>>
>> We had the same observation at the time of SFrame V1.  And this method of
>> compaction (deduped tuples) was brain-stormed a bit.  Back then, the costs
>> were thought to be:
>>    - more work at build time.
>>    - an additional data access once the FRE is found (as there is
>> indirection).
>>
>> So it was really compaction at the costs above.  We did steer towards
>> simplicity and the SFrame FRE is what it stands today.
>>
>> The difference in the pros and cons now from then:
>>    - pros: helps mitigate unaligned accesses
>>    - cons: interferes slightly with the design goal of efficient addition and
>> removal of stack trace information per function for JIT. Think "removal" as
>> the set of actions necessary for addressing fragmentation in SFrame section
>> data in JIT usecase.
> 
> If fre_data[] is allowed to have duplicates then the deduping could be
> optional.
> 
>>> Note FDEs aren't even needed here as the unwinder doesn't need to know
>>> when a function begins/ends.  The only info needed by the unwinder is
>>> just the fre_data struct.  So a simple binary search of fres[] is all
>>> that's really needed.
>>
>> Splitting out information (start_address) to an FDE (as done in V1/V2) has
>> the benefit that a job like relocating information is proportional to
>> O(NumFunctions).
>>
>> In the case above, IIUC, where the proposal puts start_address in the FRE,
>> these costs will be (much) higher.
> 
> I'm not sure I follow, is this referring to the link-time work of
> sorting things?
> 

I meant the work of tracking the start address of each function.  This 
could be done at link-time as is done in most cases.

But also depending on the case : e.g., kernel module loader will need to 
apply these relocations in the .rela.sframe section...

If the granularity is finer than a function, more number of relocations 
will need to be applied.

>> In addition, not being able to identify stack trace information per function
>> will affect the JIT usecase.  We need to able to mark stack trace
>> information stale for functions in JIT environment.
> 
> Maybe, though it's hard to really say how any of these changes would
> affect JIT without knowing what those interfaces are going to look like.
> 

