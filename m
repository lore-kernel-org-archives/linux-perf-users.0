Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF301E2853;
	Thu, 30 Jan 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249693; cv=fail; b=XooGAxtvz6eXXNElwTAJViy2U8XBOVqvIcKNsXHBhvOnZ9yRwgEO+aTd2hGpiMTL3rIMXH7yDXqd/Js7RoRwxumppOxMspLK++amc0BlfkW73i2AkDB5ukoPepPQYSCi7dn+ktTQNoP0yZ6zgMwfooCI3oTSd+OsbEY5GjxLMTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249693; c=relaxed/simple;
	bh=Ip2J5ZOmUJeqUNlpgYBWPMRwCwWWUgEo7vdnlmd6nY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nOomEJLkdXPH9VC/Y8xCrtiukAXpGV3hOya5va5/SoOywSSrO+2p0PjG/Eg3M+hcUZDEhAod2hfSbHChztvNoYsZ6YtnvWJS97s+dCRiTAkwEm3BdL3yKqgsy+vHy9Okw3VVc5EIypsJ2NbALMymgjl4QZBRXlEskcSGnFEv1tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jJixTdEb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JWPX/S++; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jJixTdEb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JWPX/S++"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UF7WOp027537;
	Thu, 30 Jan 2025 15:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LjKx43knP4QA6mfZMSz9st5k+Nm/064qB0CEig3iPzk=; b=
	jJixTdEbjHgfHpJBAF90AxZ6h6qPu4FJwwut+PpY2lBW5QYBf5VmnX0hiPvYo11T
	yxkwCVrSnNswmcRm/8JZk7bcMJ44Vvgyahs18yWF6KfBPEKhR33NGomQd6+zAtRq
	SJA4I4FzlRpnr4WLVrLL6Whbym5TfwXQrnye2mfypIGtklD9ykXZa62SqPxGam0E
	j+ww24tG8OdErYxjdgs8K4vHWE4ingfWdZC36Fgs4q2I35f/+3FTfIePBWpRAQTT
	v0BeZW6b+jNdwqIJb7KvQfvEpzctQn0M89NwUWQf91XiaGCET3la+dL+E62iat7O
	ezBi/iR7bZzU26SxQXMC0w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gbsdr00m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 15:07:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UESSX5021640;
	Thu, 30 Jan 2025 15:07:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44g0vb5sk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 15:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unfBTy042V9z2gjj30Ajf1S79233Cl1Xq69rxREiexdZSXW34I3dGZQI7DbCmEr+m2V3rtrrrWQ+9U9OvHXWD7c+HgC1cc8yqvgr5Z+YfV9rvD6NI79VFtXsLbM9iNPmYyfhyVvZUr75xxGIs07k3/0kvARbctOmlo5zeiSflWqOa6exLgqeGmQJPR91Uyrmf1hNnJRiju5QljNikkgGCD+bAKg9zmfFteHFkb5RUJqDViQRVwlB6v1SMLG+kGwq6W83DfakKoG/VvKordqxTsJ8h315OmtpY3ozC3VFjJeAFtiTLAaqKsd/IR14tb9mEbOL1ym3MJ99dDxWPy3bMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjKx43knP4QA6mfZMSz9st5k+Nm/064qB0CEig3iPzk=;
 b=KqrKV+Nm35QUYU9CEKz8FSsY+vVEogpCNkB8Xjzal6hoFcdUuLO1lfpQFJppO854vAzFoNUMIemuCgLvGG46CKkAQdEtQCFC1UgW83s7w+5RY5dlL+dUxz3Pchvk2+6FeDsnOSnXzAebOHr7GY1Sr1cKcjLJHjTRmdE/9mDiYQ8Vsx2MIQlNU9OLtD5ExX3/9jJuCk2iDI+3U8nGKE4IgSedYJZD22MaV8V9PnPmvHFE2N5gptqBsCV2ZhkjDl8euucFgnWrgWnROrC+BhreV7xiaK2O5QwGONwLS6qlp2nreBfU35gTpczjyJgFVy2QjlVFh+CvCUke1+6bOdyOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjKx43knP4QA6mfZMSz9st5k+Nm/064qB0CEig3iPzk=;
 b=JWPX/S++5ph8k7XOXilk8t2urydq4fPbunSJTdJo+Hr4tf8z08w285588zC0n37x40mWuYfg/zhBNXg5r2Sd9zmw5H9btAgyxqQBYswBIfeJc4enWTAOQnbhfB+qsGmPoJY4seyGj83FCPowwMY0EYWOhQ8YU/KnKql8+KjG338=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by SJ0PR10MB4430.namprd10.prod.outlook.com (2603:10b6:a03:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 15:07:38 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 15:07:37 +0000
Message-ID: <3f890bd0-b883-4bd1-a0f1-4cf78db42857@oracle.com>
Date: Thu, 30 Jan 2025 07:07:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:303:dd::28) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|SJ0PR10MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bc1dde-e962-44c4-c77a-08dd413fd541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUpZVEdxT1o0c2FwKyswTXFZK0dUbEJkOWxzOVRKVC9SaDdHNTZPbExXQVg1?=
 =?utf-8?B?ZE9QOURQN2tUWjc2amNTa0t4ZTBsakdGTFVGc0hPa04vUjEyK0wvbGtXc1N6?=
 =?utf-8?B?a3VlMjROT0ZPK0NqTTQzTHRpNy9ZQ0pNSzZWSm50akl6cFVUSXAyVHdERG10?=
 =?utf-8?B?WHlTRkt3Q2RvMzFzZDg3T2hmVWVuMVV5bUNhVlhRWEp0UmV4ZGFRTElUekRE?=
 =?utf-8?B?Z1VWazlWNG0vVGdab3p6ZFk0L2txRDdlSElKeHA2MGdIQ2U4dUlUY0I1eU5r?=
 =?utf-8?B?SGl3ZzhXMWRJYWpQdmJJZmE2U1dBMFgxT09rYVo3ek5SOEtVMkZmazhxT1lD?=
 =?utf-8?B?M2NXc2ZsQWMzQ2dxTmJjWVUySGJwL1p5alErYlpiY2pLQzZrZ1Q5amNjMlVN?=
 =?utf-8?B?c3RNcE5yMDd3NC9tOWF6Zlc3OEV1WDlzdk1uN3grL1gzRGRPSkQ2WXZqWDNj?=
 =?utf-8?B?L1RvR1YyQjZVTDg1YlZHeWpvblYvNTkzbVBSL1BXU0ZxeUovTlNnaW01WllT?=
 =?utf-8?B?WkFiUDdHdUUvd1NnT3JFVEVJTE1sZGRpZVNNOG1RMml2SFhadTFWMFdwc3VD?=
 =?utf-8?B?eXFwU1dXbzdJQTUwRGNzVXdaZm93OVREODBuZkxyajNBZlkxZVdLNDZ1WVlK?=
 =?utf-8?B?bEgxOHdCK29yV1ovQ0Y3SlNubGR5aWw0d1VZODdmMzh2dUd4ZW1qeHVpVmpV?=
 =?utf-8?B?N2FlcVJYSVlJbWdmR1ZjcUxUSHRoTVNkWkdRVy9sV2JBY0FnendjVGhPd25T?=
 =?utf-8?B?UDdrU2FVV2VpMFVER1VKdmlMOUpLMVVtbXZVQ3BBVVhya1hVLzZKR3lyeGNV?=
 =?utf-8?B?cytRUVFqa3BTQXoxZFpnQXNpZUdncUE5ZE9pTVQzS2p3bXBMMmpRd1dBT0ZO?=
 =?utf-8?B?OElrUzBobkZDNmRGVklKSEdzcTRTUmxYNlBuUUlDUm9CU0RBSFpLcDhKd2l6?=
 =?utf-8?B?TjFHeUhiVkE5MFJlZTBDbDRoU2luWHVVa3RycGRiS0xEbElSN2tvcFdOOTdK?=
 =?utf-8?B?QWtLS2JITWFnQUswQWhCUXBOOHRGc09ua3BiM0hSektwU3hXWXJZL0JOL3Zy?=
 =?utf-8?B?bGNvUmJ5QzhZU055UmZNd2ZkMVgxZEVuUzZXQnBUTEFNS0VpTWVTZnpZWkNt?=
 =?utf-8?B?NTI5WEgvbkpGTWRuZlB3MmNncW1LdFMxSFJIZFdyVFZKV09QNHNvOFBwWjJy?=
 =?utf-8?B?YmxsZE9zSldiT24wdEpxa0RnSzRPZENYOVdSQlVDS054NlI3eU44bWxHVEdS?=
 =?utf-8?B?QzM2TDVaYkhmdUYvanlJWlNBdTNIaUVRMThmOFRzWDVFSGdZQURRYWRkRm5Z?=
 =?utf-8?B?SlEvSHA4TUFIMzhYYkJBaWlBZCtxQnJoclFFMnI0ODlNaXdtUm0raHpWZXlr?=
 =?utf-8?B?d084NENrdm9wU0k5MGY2NUpva0oyTHVKdFFCZGFjYXFiZjFBNHFMRGx6R2hG?=
 =?utf-8?B?ZzBNanFUMHhub3grQVZOZUwzOGZRQ3U1emtEbHE2ZWkyUmYraFk2azdkdTZH?=
 =?utf-8?B?Mlc3RGt4WDFuS1ZUcnovMXEzdmprcFJJQW4zazM5WVlKNjNHTUtoK2F0Qmwy?=
 =?utf-8?B?ZHlrTUdNMkZMVkpiQm84RGlVZUh2SmpwODR4ZEtqWHV0Z0l0elFWVGszZ3py?=
 =?utf-8?B?VW82M0RWcHRmVit6MGF1NGRydjQ5V1BteUZxQVd4dGpRZWs3a0xPc3FmUlVB?=
 =?utf-8?B?ZXg2dklyZkdmR0xqTlcxZXVNVFJoWk0weDV3L2xWQ0F6RUd4MmF2MWpPS3Jl?=
 =?utf-8?B?eGppYTFITzhqcDhrTlhVYXdHazRqeGYwTTZJY1lEUnZBaXU1WmZ5bGNNUER1?=
 =?utf-8?B?b2hMcXErc2FEVVVjZFhTMGhRREZReW84MEc1Wnd2NG5JREl0bkxlQnZ6VjFM?=
 =?utf-8?Q?llc+JcRYMR1Jn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0tiSXZ1VXlIRG5uK3RzWGJJSytkRkdqTEFGRzh5M3poTGhjTDU2WWg3anpV?=
 =?utf-8?B?SG1ROGM1UjhMYWcraTFRVERsTWtWaS9BbW5HanIyRDNtY3V3SHpRUUdoV3c2?=
 =?utf-8?B?bG9aKzI3NVBQMTBINGhqVUtaa1RUSWNyR0RpU2EyaXdvcm5OemswYnZ2WXJL?=
 =?utf-8?B?UlBWMGNtdUJ5R0k5dWhKWUlpbDR2SUVzNmhqemtmdmhaeVpLY1lmL1BXSEl6?=
 =?utf-8?B?WkxCcGtJT0JFV2Q3dG0rVXVJYnJtaU9TbE56bmNGUnlnNHFlU2NCSHZBWGZ1?=
 =?utf-8?B?aFF3bVVGemNpZnR4RDQvT1BaTmF1TWxxaTVrd01kY3RQNlZGVlZNNUFhMVFC?=
 =?utf-8?B?UnNaS0xMNGxSdDBNeitPc2dyK1RINnE3NTBRc3NTTDZRUGo4L1R0V3MrbG1V?=
 =?utf-8?B?T0hETTFBZWg3RFBaeVFrZEx0WG1MRXN3YldJVUNZSFNjTkZSWlBpd0hPYi9n?=
 =?utf-8?B?Yzhxa242VjhoY0hHT1JEMCtUaW1BMS82RFU2cDlwZ2ZFUXdaVjlTL2w1T1dS?=
 =?utf-8?B?aW9KeVhJVVpZZ2xZRHhsa2xjZEZ0Ym1aM3NTbkVzaUkvYVdPd1NwcGllOGN3?=
 =?utf-8?B?SXo0d1R5QlR2WnpkN3pQU2hUT20xRDFCaUZUb1FMd1I4WmZENHc4ZHp3cUpB?=
 =?utf-8?B?MEh0a2xrUUZSTDNjUWt1eDdqamZ3RGRCZS9TSHdHWUdJTXQwOXd5YUhKODlw?=
 =?utf-8?B?U0RZdU5ya3lXZUpmMXNtZXFiTHhOSktFNDVYQjhGZlBwUEE2MWZ3T0tCZjI5?=
 =?utf-8?B?QmhIdVhqSlNWSDdlTWhyUmFmK2cwVURDcEh1UUE2VlB5a3pnVGRpOXNBUnBI?=
 =?utf-8?B?VDA3VEhreW9ObjVOTjIzTEt0MGsxY3pwekhWQ0lLWloyYzZFam15ZGlmeVFX?=
 =?utf-8?B?TlRMRE8wZTBRZkQyWjZBVlFMS3VmdnNpajluUmIwT0g3U2RCcTNuQU1NbGdi?=
 =?utf-8?B?UmVkTFRlMXgwZ0x1K0E2dlZWS3VxYUxxR2tJRlhUU3hCRTJVUGNwbk1RWHNq?=
 =?utf-8?B?SVptNGd3TkxPcFUxNGx5enlBYUVBNi9nbXhjRlhHTXA0SHZTKzd5Mmp6bGRs?=
 =?utf-8?B?Uktzejkrc3dBM0RHQm8xSjRPaDV6Rzh2ZElvSGMzdDcrSFEvNm5WcDJ5OG0y?=
 =?utf-8?B?dThiUk0rdi9iMXZKby9NSmNsaEFUaldRY0ZodlJiazZyMVhFOUd1ZGN5Q1Ft?=
 =?utf-8?B?dUV0Y0p3VGE3dDljZ0dYSmhrdEVHRHV0R2hOVVp6Z0gzNlUxV3hiWkoyMzFo?=
 =?utf-8?B?RHJnZTFyK2o1WFNiUG51aEROM2dqTlM1dlBWYnNGSmx0NUlNSFhsK0JzUlhr?=
 =?utf-8?B?R0lodXZaTzJGUSsvTm9PUGlyN1o4ckd2STZ0R2tGMmZrRzNnK0JEZy9CcVRD?=
 =?utf-8?B?dmtvcXdvRHJYQXBremdwdWNhUE84UGFRN29kdkV1aXdTaDhwMnprS3VvZ05r?=
 =?utf-8?B?T0Nid3hMb1FpVHVHM3c1SFBSWi9rMDc5Qm9IdjVBODZXaU5kYkdBRW8yWkhN?=
 =?utf-8?B?WDV2NEpjeExyZ2Q0ajg2dCtjZ1kyQmt5ajNCdWk5THgvNGRGRHNXT28rdXZZ?=
 =?utf-8?B?TG5kZnk3dVd5YUVGdlhPNWszdTRmYldKaXQ3Sk95ODVOWGt2THE4ek5BTVdm?=
 =?utf-8?B?RFBydVQ2RlZiQzlIdTA2V2FueDhHMHNNYVRNSkpoa0Z2R0QzNFJxSkU0a0dG?=
 =?utf-8?B?Q29GaU9YUTh2aVBoVGpzUnJoRFZVQ2VpRXRnd3dJRkUybzFENHBaZStnUThN?=
 =?utf-8?B?NU95dmlnVDllQUNrUW11djJmUUx0ZkNISzZFQjRsN01vVVFDTFJqK094RzhS?=
 =?utf-8?B?ZERpTFRpeC9admZrYXZUYWFzRWYrd3pBSzdFNUljYWxjZXFacko1ZG9wNnJw?=
 =?utf-8?B?Z2k1czVuaU84NnlsZHRkMzJBeU5MY2hLcFY5SGMvYTl2WVEvdDRDdHFhdTYr?=
 =?utf-8?B?eElNWmtZdnNMUEFqNzZ6T25XeWNRVGMwdnkweDhxb2hjcTE5TkMrVVNyY0Yw?=
 =?utf-8?B?Tm1jQ05mdnJobzZnVVcrZkZWSlB0YjFYMGl0MTZlSHkxRkNDb3l6cmdrK1Zi?=
 =?utf-8?B?bDYrTy90S3h0ZE9aNTR5UTFsc05EUnk0MHVyZWZOYnFGVzZwR2UwQmJrVkl6?=
 =?utf-8?B?bVYwWStDN0lheHNvdnVLZFZ0bTRkQVNjanZZN3h5d3krTmlxUE03cjh0Rk92?=
 =?utf-8?Q?d/0E+inE3/LLoqmi7jk+eOc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+nmExTBbRJjpBLuOZcOBsa0rzrTtcUEf585b5FfBk6KNm2EmLTIIlbmum54TJhMNT4KnQKsJivx2PnjbIyjx0xm106g/1CUp+AXfaudtCcUmVh90iimCEuDMrZN1QAfCmao4lsjOfq7RX025ep2iy133DeCwhk9x6sVnnvckzC2otaiULCSYqSAh5cI7EkOY+3rd8Jc9ZywbLw1vvlbUb0biDF/FjL35qfgGx5RU/rLW9f6xJ8CS1qbIwGg3Etq8FnbOJ/8IAb4EH1ya08jbZNExwJrxZZP1IZzpCWFZCsON8prbqC97HhGelso8qmJwTT1rrDcPM2bL0FkQv+XO1zisxTsHAx+KHGyZ31u7O/ngcsOoDNDxMF19V+as3DhWrQd9IYQkWEE5yJc4pspoyCKcuxUSFCzs76zKEo2GnaTd15IdlWR8Ig7tMQI/M2MOiJVinUR1e3J3sOG+dzN4G3+cGDqA7OPJPhYLswhwuzMZkwrRNcdJeGvFzefiHoHtVfFYWQwp5DQtKO9WqDBlAAX0B+XgE3HC45TL9QAvwzQpP3G9iiLJ5ORE7EiXj+ei2Wu0vP9GgyN76EpIfTYfZzFBL1ZbzeUQJ2hxaHA5eXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc1dde-e962-44c4-c77a-08dd413fd541
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 15:07:37.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Npa+cYLEtTcnRRD2/fdFqgWfbghjcic7hhW++Xheoitf4XwUrPnHqu4DhOKRugqCM35Xe9S6swRZfyRGs5CDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300114
X-Proofpoint-ORIG-GUID: w7W1mpK3yLUOxAcrRKn-6TaKGAb8eq7M
X-Proofpoint-GUID: w7W1mpK3yLUOxAcrRKn-6TaKGAb8eq7M

On 1/21/25 6:31 PM, Josh Poimboeuf wrote:
> In preparation for using sframe to unwind user space stacks, add an
> sframe_find() interface for finding the sframe information associated
> with a given text address.
> 
> For performance, use user_read_access_begin() and the corresponding
> unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
> regions would break noinstr validation, so there aren't any debug
> messages yet.  That will be added in a subsequent commit.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   include/linux/sframe.h       |   5 +
>   kernel/unwind/sframe.c       | 295 ++++++++++++++++++++++++++++++++++-
>   kernel/unwind/sframe_debug.h |  35 +++++
>   3 files changed, 331 insertions(+), 4 deletions(-)
>   create mode 100644 kernel/unwind/sframe_debug.h
> 
> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> index ff4b9d1dbd00..2e70085a1e89 100644
> --- a/include/linux/sframe.h
> +++ b/include/linux/sframe.h
> @@ -3,11 +3,14 @@
>   #define _LINUX_SFRAME_H
>   
>   #include <linux/mm_types.h>
> +#include <linux/srcu.h>
>   #include <linux/unwind_user_types.h>
>   
>   #ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
>   
>   struct sframe_section {
> +	struct rcu_head	rcu;
> +
>   	unsigned long	sframe_start;
>   	unsigned long	sframe_end;
>   	unsigned long	text_start;
> @@ -28,6 +31,7 @@ extern void sframe_free_mm(struct mm_struct *mm);
>   extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>   			      unsigned long text_start, unsigned long text_end);
>   extern int sframe_remove_section(unsigned long sframe_addr);
> +extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame);
>   
>   static inline bool current_has_sframe(void)
>   {
> @@ -42,6 +46,7 @@ static inline bool current_has_sframe(void)
>   static inline void sframe_free_mm(struct mm_struct *mm) {}
>   static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end, unsigned long text_start, unsigned long text_end) { return -ENOSYS; }
>   static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
> +static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame) { return -ENOSYS; }
>   static inline bool current_has_sframe(void) { return false; }
>   
>   #endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index fa7d87ffd00a..1a35615a361e 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -15,9 +15,287 @@
>   #include <linux/unwind_user_types.h>
>   
>   #include "sframe.h"
> +#include "sframe_debug.h"
>   
> -#define dbg(fmt, ...)							\
> -	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
> +struct sframe_fre {
> +	unsigned int	size;
> +	s32		ip_off;
> +	s32		cfa_off;
> +	s32		ra_off;
> +	s32		fp_off;
> +	u8		info;
> +};
> +
> +DEFINE_STATIC_SRCU(sframe_srcu);
> +
> +static __always_inline unsigned char fre_type_to_size(unsigned char fre_type)
> +{
> +	if (fre_type > 2)
> +		return 0;
> +	return 1 << fre_type;
> +}
> +
> +static __always_inline unsigned char offset_size_enum_to_size(unsigned char off_size)
> +{
> +	if (off_size > 2)
> +		return 0;
> +	return 1 << off_size;
> +}
> +
> +static __always_inline int __read_fde(struct sframe_section *sec,
> +				      unsigned int fde_num,
> +				      struct sframe_fde *fde)
> +{
> +	unsigned long fde_addr, ip;
> +
> +	fde_addr = sec->fdes_start + (fde_num * sizeof(struct sframe_fde));
> +	unsafe_copy_from_user(fde, (void __user *)fde_addr,
> +			      sizeof(struct sframe_fde), Efault);
> +
> +	ip = sec->sframe_start + fde->start_addr;
> +	if (ip < sec->text_start || ip > sec->text_end)
> +		return -EINVAL;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}
> +
> +static __always_inline int __find_fde(struct sframe_section *sec,
> +				      unsigned long ip,
> +				      struct sframe_fde *fde)
> +{
> +	s32 ip_off, func_off_low = S32_MIN, func_off_high = S32_MAX;
> +	struct sframe_fde __user *first, *low, *high, *found = NULL;
> +	int ret;
> +
> +	ip_off = ip - sec->sframe_start;
> +
> +	first = (void __user *)sec->fdes_start;
> +	low = first;
> +	high = first + sec->num_fdes - 1;
> +
> +	while (low <= high) {
> +		struct sframe_fde __user *mid;
> +		s32 func_off;
> +
> +		mid = low + ((high - low) / 2);
> +
> +		unsafe_get_user(func_off, (s32 __user *)mid, Efault);
> +
> +		if (ip_off >= func_off) {
> +			if (func_off < func_off_low)
> +				return -EFAULT;
> +
> +			func_off_low = func_off;
> +
> +			found = mid;
> +			low = mid + 1;
> +		} else {
> +			if (func_off > func_off_high)
> +				return -EFAULT;
> +
> +			func_off_high = func_off;
> +
> +			high = mid - 1;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	ret = __read_fde(sec, found - first, fde);
> +	if (ret)
> +		return ret;
> +
> +	/* make sure it's not in a gap */
> +	if (ip_off < fde->start_addr || ip_off >= fde->start_addr + fde->func_size)
> +		return -EINVAL;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}
> +
> +#define __UNSAFE_GET_USER_INC(to, from, type, label)			\
> +({									\
> +	type __to;							\
> +	unsafe_get_user(__to, (type __user *)from, label);		\
> +	from += sizeof(__to);						\
> +	to = (typeof(to))__to;							\
> +})
> +
> +#define UNSAFE_GET_USER_INC(to, from, size, label)			\
> +({									\
> +	switch (size) {							\
> +	case 1:								\
> +		__UNSAFE_GET_USER_INC(to, from, u8, label);		\
> +		break;							\
> +	case 2:								\
> +		__UNSAFE_GET_USER_INC(to, from, u16, label);		\
> +		break;							\
> +	case 4:								\
> +		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
> +		break;							\
> +	default:							\
> +		return -EFAULT;						\
> +	}								\
> +})
> +
> +static __always_inline int __read_fre(struct sframe_section *sec,
> +				      struct sframe_fde *fde,
> +				      unsigned long fre_addr,
> +				      struct sframe_fre *fre)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	unsigned char fre_type = SFRAME_FUNC_FRE_TYPE(fde->info);
> +	unsigned char offset_count, offset_size;
> +	s32 ip_off, cfa_off, ra_off, fp_off;
> +	unsigned long cur = fre_addr;
> +	unsigned char addr_size;
> +	u8 info;
> +
> +	addr_size = fre_type_to_size(fre_type);
> +	if (!addr_size)
> +		return -EFAULT;
> +
> +	if (fre_addr + addr_size + 1 > sec->fres_end)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
> +	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size)
> +		return -EFAULT;
> +
> +	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
> +	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
> +	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
> +	if (!offset_count || !offset_size)
> +		return -EFAULT;
> +
> +	if (cur + (offset_count * offset_size) > sec->fres_end)
> +		return -EFAULT;
> +
> +	fre->size = addr_size + 1 + (offset_count * offset_size);
> +
> +	UNSAFE_GET_USER_INC(cfa_off, cur, offset_size, Efault);
> +	offset_count--;
> +
> +	ra_off = sec->ra_off;
> +	if (!ra_off) {
> +		if (!offset_count--)
> +			return -EFAULT;
> +
> +		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
> +	}
> +
> +	fp_off = sec->fp_off;
> +	if (!fp_off && offset_count) {
> +		offset_count--;
> +		UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);
> +	}
> +
> +	if (offset_count)
> +		return -EFAULT;
> +
> +	fre->ip_off		= ip_off;
> +	fre->cfa_off		= cfa_off;
> +	fre->ra_off		= ra_off;
> +	fre->fp_off		= fp_off;
> +	fre->info		= info;
> +
> +	return 0;
> +
> +Efault:
> +	return -EFAULT;
> +}
> +
> +static __always_inline int __find_fre(struct sframe_section *sec,
> +				      struct sframe_fde *fde, unsigned long ip,
> +				      struct unwind_user_frame *frame)
> +{
> +	unsigned char fde_type = SFRAME_FUNC_FDE_TYPE(fde->info);
> +	struct sframe_fre *fre, *prev_fre = NULL;
> +	struct sframe_fre fres[2];
> +	unsigned long fre_addr;
> +	bool which = false;
> +	unsigned int i;
> +	s32 ip_off;
> +
> +	ip_off = (s32)(ip - sec->sframe_start) - fde->start_addr;
> +
> +	if (fde_type == SFRAME_FDE_TYPE_PCMASK)
> +		ip_off %= fde->rep_size;
> +
> +	fre_addr = sec->fres_start + fde->fres_off;
> +
> +	for (i = 0; i < fde->fres_num; i++) {
> +		int ret;
> +
> +		/*
> +		 * Alternate between the two fre_addr[] entries for 'fre' and
> +		 * 'prev_fre'.
> +		 */
> +		fre = which ? fres : fres + 1;
> +		which = !which;
> +
> +		ret = __read_fre(sec, fde, fre_addr, fre);
> +		if (ret)
> +			return ret;
> +

It should be possible to only read the ip_off and info from FRE and 
defer the reading of offsets (as done in __read_fre) until later when 
you do need the offsets. See below.

We can find the relevant FRE with the following pieces of information:
   - ip_off
   - fre_size (this will mean we need to read the uin8_t info in the FRE)

> +		fre_addr += fre->size;
> +
> +		if (prev_fre && fre->ip_off <= prev_fre->ip_off)
> +			return -EFAULT;
> +
> +		if (fre->ip_off > ip_off)
> +			break;
> +
> +		prev_fre = fre;
> +	}
> +
> +	if (!prev_fre)
> +		return -EINVAL;
> +	fre = prev_fre;
> +

(Invoke the __read_fre here as we know now that this FRE is what we are 
looking for.)

> +	frame->cfa_off = fre->cfa_off;
> +	frame->ra_off  = fre->ra_off;
> +	frame->fp_off  = fre->fp_off;
> +	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
> +
> +	return 0;
> +}
