Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850D291E;
	Wed, 18 Sep 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658607; cv=fail; b=LDCkLl453ka8gOZqiuEnp+s7mdOEXaiE1Lbh6/53rIoHvbudvYhkYxLsKU07bYW5FVT71+PZv5AjVez6KC+4b86eH0WFKbrslbfBzZxhkRP72d/WGdzWooNtGGH5ugxoCbT8Hm2VQj3ZiMD5FgExNubGnHBjC0kKdTy0M/MxEdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658607; c=relaxed/simple;
	bh=6FcM5Ya/X2OVRaFY5R+FfTE/MG/FPt07+Euw2Qme20E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUbS6Z/zRD+bl3LzaVxMdiw0/Kmnww0yXcX4rmVWu8CenYPtpdYlkttQVc4QCXX45+8jg986/VrFvFl38hplATPKEtBGmabxRp6/xI0cOhFi+/4i6kmnsnYRFwDJIxef827mhvvdjMaRbAWz98Yq3HzvmgzKupNtpKkBRpk4+TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ja+Ou3nM; arc=fail smtp.client-ip=40.107.244.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ja+Ou3nM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niXvx+K7krQolo3nnTqwiPNsvZyOPcb97oKNhi8eIfIVW5uJN/9fEmWgjbsqtAsQvM0BY6tPA8JjbJ+VZ2Kps2qun4Ix+PYEfdOst8fknr+SCgpL3DUQZaCQdImYdzH+XQPpdino5po3tLoFB+ClvU9HxCvFN3ekq8MqV8ZPykOKFB1CHIkvTKapWus6Hg1zUugo7MLNIWW7xE5FY77e813KMaY7uPb4g4aFp9utEyz/LBUrMuFaY6ftz3cJDTA8+yf9DUKCk8/UBdXlaedOawAAxSCFSch8dLSpNPXyHANyOjZfmjWsklRaBh7c1zPMe7LCHn7VSsvNKdFiJ4EUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSal9a1oitGtp6ELVhC0uFCm1iVVDk28hu0mzcBk3Qo=;
 b=V7RYLcEr0ujRAzzUK4b9Y6KufYZv+2wzXTNevR1H6JDuNBHqHPRzbr27lec05PnfP6I3s25+l9xhLdrFl/1EBAwSj3iQQbSEULNje49uqDdwjmIPQpb5RHTFs/p1FEWD1cmn/bdORLnbaHqhO0nlwp/13S0shlfQ7V6Xy64RJLQPQFSozoSP8UbvGMNpQGk6ClDkJs218CD5pJZbzzPxOVUgY8SeN+HLNgDmr5sqbCw6SCx2dkl8Jh1/IS8omDgvFWnb5Duii89X4lOyn7J+mtzkKMHGvCG4JKSSXgxgdzInaEKO7SlkXZvOUa7ol/nZbjiix74n9slc2FRKt24BZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSal9a1oitGtp6ELVhC0uFCm1iVVDk28hu0mzcBk3Qo=;
 b=ja+Ou3nMkvW7aKJn5QwHYsqRxrmCpQJMgBEUAZB3syKy5AiizW5JGk8Fbc8EJepsCjuqEfmc6DEY7VZdPFYxBdqzWu6KC9oNeX1QOZPe6Iw3gq0JC9rVsi6IT+191CuVK0hoJN0v5XQ97KTxfm5CVysUo5fbEhz5mE9I5wWP1Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CO1PR01MB7291.prod.exchangelabs.com (2603:10b6:303:156::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.17; Wed, 18 Sep 2024 11:23:19 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 11:23:19 +0000
Message-ID: <24e24324-cb41-4ae7-9584-e97684b12585@os.amperecomputing.com>
Date: Wed, 18 Sep 2024 16:53:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf: cs-etm: Coresight decode and disassembly
 improvements
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, leo.yan@arm.com,
 scclevenger@os.amperecomputing.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>
References: <20240916135743.1490403-1-james.clark@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CO1PR01MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 35398373-3dcb-4dce-c6e9-08dcd7d44c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG9uMlEvN0hiUjJEN2h1M0wwNXh2V3FkalJmYWVZWTJ2Si9TUjJSTjZLTVZh?=
 =?utf-8?B?c2dDUnVNOXNTMFR6QmxKZTRIMEVJaFU4KytLc0QxWjVhcDFOek5PeklONXhO?=
 =?utf-8?B?dDlTUnZtbTBSUnB0QXBKZ1hHWloxUVlRc2luMnR5Q2xYR3p2WGhxaUVTOTAx?=
 =?utf-8?B?dUhuZzFNczZNZGFiZkJNaXlUTms5NFQ4VGVKblNJUXdtUFgrWjRvdittTWZX?=
 =?utf-8?B?RXlCYkY1NzFjSmxyUHFjSmFhZEx6QVZqNEdkaHVQUU9OTG1rOWVNRkdFM2Uy?=
 =?utf-8?B?c0d2a1pFZm9nUjdwTnpGbVpTeWtNRkdHcTRlMlVTanRtMHFhMnRaNjJZc09k?=
 =?utf-8?B?RjR3TEN5QS9BbUFaR0RnMGJ6N0ZIWHZEMDN6a3Z4VFoxRDc0TmZHNzZzdzBv?=
 =?utf-8?B?am9ucE9GRVY5WmNqaGFXNGZ3RTRmZ0luYWUzVnZRcm9yNEZ5S3JyVEtkTEVL?=
 =?utf-8?B?SzN6THFxNUdhQnJHMDd1MTRwK3pvN1hCTklvRi84ZUdJelp2NGxNZ2JWQVJ3?=
 =?utf-8?B?b3lBM0phOGdVN3JhVEZiWk1EWVBLSlAvbTM2c2FTQ1lGcHdoeHc3MjBBU0E5?=
 =?utf-8?B?OTNJc3RkTmtoUFZTbXhTS3Z6M01MbWNBL2NwTDEyZk93YmVVcGdTTTNoU0F2?=
 =?utf-8?B?WUVMcllDVHVic0p5VDhla0gxUlJsUlhlOUcvQlVOekM2bS9UL1p6czArTExD?=
 =?utf-8?B?UDczYlFueUIyU285MGtETnhMWUJ4OVpvRjJ3K1ZaTUlFVXZLNWdiSi9hd2lI?=
 =?utf-8?B?WnNqSEFyZkpHSDd3MkMyMkg5Z054ZzdqLzFWQ1lkRWhZTERNSkxvM2Ntdm1s?=
 =?utf-8?B?MTgzZnJaU1A0ZEhQTEhTdjlvTXkzSllpR2xxNkMvS0puYkNtUzBmSWVUYzZh?=
 =?utf-8?B?TC9EY2V5MVZWSmRxVXZMTGhmdXhtelpROHdoQ3R0elNzYUp1TTdQRUNpWWdM?=
 =?utf-8?B?UTc5c2JZbDBzOU5ldlU1dFJWQ1dtazdjUzk4emprY0VQVmllaVRvYkFZdGhW?=
 =?utf-8?B?UGdWL3lKR0JQTk9FZk01THlSQW5DSWJPMFZUSEVzZnNlM0xPRndlMkdtVzVR?=
 =?utf-8?B?MEk5TTBWc2RhQldDQjZlWkpZazAwRWRLK0N3ZnFmQ0ZRbktRYU5tTHc0TmJr?=
 =?utf-8?B?cTBxZjdGRmJDN3FsVWtsTHBxY1NJSE02bXVRWHJFV2JGcVEySjBpdU82Qmwy?=
 =?utf-8?B?T1BzYnd6QmZlY1BYdHhyRUFoaDNJNndmcGpWNlJ2aDJSMWlyU0Q3WFhDbDRp?=
 =?utf-8?B?WVdKd3Fadzk4TitBS0RMT1Brd2dKT0JIZ2k5UlcvSUhNaVpiUnQvekRGT3Nh?=
 =?utf-8?B?UDlEMGtRTXdienB2SUU5cmlRT2xsNUtLM09SN3JLaXl5bWsyaUNqRVhQZmw0?=
 =?utf-8?B?cmhqS05WUW1EODR0VDR6V1ZtVFk0VzZuMHUrOFNSakVkTFdiaGRMeUVsdDJE?=
 =?utf-8?B?TmpLN3VTV1B1SWlFQlRyeTBnMmdJTlJXb3krR0czRXNqcHFtNVFsbFJyQ05D?=
 =?utf-8?B?dDZDS3ZvWkw5M1FFSi9Da00rcWpQdGVMbnREeHQySVFvVXR6Mll4Zm9yWG8w?=
 =?utf-8?B?VlVreUI1NUJqTHUwK2xIbUpUV01aUStuL1ZiUTgwNE5EbWtOWGNjZEpMZFN5?=
 =?utf-8?B?MHpXK3Qza2IvNkpkSWoyY20yR0c2ZEYrKzdVRTlwMFVkOCtybFY0dDIya3F4?=
 =?utf-8?B?UU1Mbk9MSFRLOFl1WmhhYUx3LzNhMzIrQWJPVkRrS2IwK29kU0RkMDFYVTg4?=
 =?utf-8?B?ZW9VRUo4amlZbEpNSUlrckJveTJEZXJValFoS1FtN2RrT2c1ejVYeXllNmF6?=
 =?utf-8?Q?H2cfG7bMS4ofei0Vcpl6CDxZ/r2qQb9oWb6Fg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2luSkhySGpXZCtEcnJHenVEUFh6eDNtS1E1UVFxS3R4Y0NZNkhjQ0FrSXJS?=
 =?utf-8?B?Q3NCV1NGcktVaGI2REFPakZabTllRUJpNnFxSHp4bWMvSUE3ZHlNMWdUcXgw?=
 =?utf-8?B?cU9OMEdqSnVNUUNUdVVycnRJR2NZUDV6QTVSSkRUdm1wTitIWmJEVUduTHJq?=
 =?utf-8?B?cWtOazhMZnJNSGFzTzRBZW4yM1M2ZEE5NzY4VUF1WmxsTlNIbEh0M1k3VUpv?=
 =?utf-8?B?MndYSVUySHBtL01PZDl5Q3pyWHpWVXJJTDhlREZ5My9HbElNR0toYkxueXBn?=
 =?utf-8?B?dnlqUnE1TXVKRzE2ZE5KV2kyMXVMZzZhMmdBSzNscmlyYlo0YWl2RWd0TCtw?=
 =?utf-8?B?TklZSzc1bmEwclM3U0JpSkdVcWpML3Z1aElLNW9aeWJURVVDUGxvNktIMjJM?=
 =?utf-8?B?UXBiZ0Y2VU9pbVRtTVQ3Q0duTUVXTlgwNEJMQnpnbnpKMTRKQmNvQ2NXay8x?=
 =?utf-8?B?MEs3RDlqdEpsazV1UVFYUGkwdGcrVXdhWGRpQ1VHR01kenN1cEdzeDExd0xX?=
 =?utf-8?B?SGhyS2dLbEhRdERML1hBT1RKVXR0U1N1UVFBOTFJcldNdjJLZm0wVWNJTjNp?=
 =?utf-8?B?MEpYZ2NnWTZublNSVXI4REhkM2JFR285ZFZnNktzMVk5cHB3a0dURnRrdUdk?=
 =?utf-8?B?UnlGRDQrWVhFYjNBRjJVa2JCQXNNTnlWRURBY0haTTlSREJ4RzBXQkNCdW1K?=
 =?utf-8?B?KzdFTnRpbU1WUWw4dUNrMnhsS1RacFV6ZHNxcnp5MVN0UlpuZXQ1clJEVzRI?=
 =?utf-8?B?Sy9EU3BMK09Pd0JJMytwNlIzdUF2R1M4TDd0emN0eUc3SmR6bm55WFE3eHdt?=
 =?utf-8?B?OU9jZ3hIQVF0TVVVeXMyV2UwZ1FiZFd3YTF5ZU02bU0veXV3Y0NnditsTzli?=
 =?utf-8?B?a3Z0NStvaTErdU5MeUN2UDA2eDR5WTgwd3dUMWE3TUpxK2hUc040RGFtYlFu?=
 =?utf-8?B?YjFEVnRNcXZVWU1pSW1pa1lHenY3dHNDUDN4aC9wZDY4TDJiNnRNejhFRExQ?=
 =?utf-8?B?aHA4ZnVFc3hmdnh6T3d4cnp3enMzLy9xSi9VTGk5c2FhT0dpYlRwZEtWTDY0?=
 =?utf-8?B?YW1KYnc1bkJhdWhPQ0FsZTB2MTZXb3JTMUR6YWdoQmZIdnVhdTQ2dHNmK29j?=
 =?utf-8?B?c01sczhEZ1hLR0hDa25kZndGQ0JJRmIrQjFtSzNDK0JLNlgvamNDNlk4WkRv?=
 =?utf-8?B?Y3BzOFhKcGk1MGt6elc4M2N6bUNGU0NKTHJLam1iV3VYaGVNZFY3azliOEVO?=
 =?utf-8?B?cmdXMjR2SkpMM0xoZ1VRN3luQTA5bEVCR2FKRTh4UlNwV1lVdXJ4MnRJcTdv?=
 =?utf-8?B?bFROTlorL2o1aDE0dkp4WTBhNHRUSkl6RXI3bVBvVElvRFNIUWZiWHI5MDFy?=
 =?utf-8?B?R2gxUThrTDR6N0JsdFBXR1hCVXpodUxIU2JWZjRUNDB0dks3Z3dVQVVWRndi?=
 =?utf-8?B?RmJpNjZOMVRVUWIzSFAyeW92SWZiRzlDQVRyWE43bzBpV3VjNjEwZWhKZDlH?=
 =?utf-8?B?bzJQOEcxZkV1ZGNOd0U3TFlhYmZ0NXZnVmluS0lUTmNTa2NVTGJsN1NqV1V2?=
 =?utf-8?B?elpzVk1QSGU3RnBtK1I2bStvSjR5QW84QytnSGgvcGFqN3kzZWZJTEtreDIz?=
 =?utf-8?B?ckhnRlUyRlFPSUVLVW5laTBUcnhpM2VzblVmWXQ0emJueWNyRllkNmgvUXRr?=
 =?utf-8?B?eEFGSXdrZS9LaXNubHViOTFvQTdHVXB6NmNxNm5hN1hxL3ErRW9PUzFYVndL?=
 =?utf-8?B?T2h4dERyRllQSE9LNVVzSUNOMmZxckJwMHg0M3loWmF3cGhTRVBybnhNaWo5?=
 =?utf-8?B?aUdYQlBFNXdIZVFPdnJrcU5CeE1XN0FVZ1B0VnIzcHRnM2U1N3B1SlNyQlBZ?=
 =?utf-8?B?OGVkajZHK0pMZUxHeUNMRTdUdkRrd1ZIdVN6azJoRURHL3NERGMxWFRubjl3?=
 =?utf-8?B?cndsWmVSVi9hN3NRVkdMeFhSZEk4VUNlem1mbEhINEdmUmN0cllLSERWTThu?=
 =?utf-8?B?YlMvVTFraFBnenU4MllPYnlScDVIMVNvN1NSUGdPV2hzekVwdkNOb3U3cU5w?=
 =?utf-8?B?ZmVLaVRGdjlrTnVoNnNqcUYrTlZaS1BKVm5lcmJVOGR6a2tUZmZoUkt6S2w3?=
 =?utf-8?B?bjZBS1NaOVVOd0hKMDgrVnJjZEZqemZpUWhneDVmZ0tRdk0yVmc2bktOZG8v?=
 =?utf-8?Q?1igwa6TUPsSFJWyN+KYGL8U=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35398373-3dcb-4dce-c6e9-08dcd7d44c48
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 11:23:19.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9/1127R3QpTcNpkkk8Q0jHhIbBFFnj3pL9YLrmHY94U+1jyC3UXhQnQ6Z0SuGp0S+pTMD68SSF4eP2/At3HXjA6CPrR7vyklmgsUA2TnjjhvtfFjLvTvOh2M57J3Ni5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7291


Hi James,

On 16-09-2024 07:27 pm, James Clark wrote:
> A set of changes that came out of the issues reported here [1].
> 
>   * First 2 patches fix a decode bug in Perf and add support for new
>     consistency checks in OpenCSD
>   * The remaining ones make the disassembly script easier to test
>     and use. This also involves adding a new Python binding to
>     Perf to get a config value (perf_config_get())
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
> 

Tried this series with below commands and issue is not seen as reported 
in [1].

record:
timeout 8s ./perf record -e cs_etm// -C 1 -o kcore --kcore dd 
if=/dev/zero of=/dev/null

decode:
./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -- -d 
objdump -k kcore/kcore_dir/kcore

./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -F 
cpu,event,ip,addr,sym -- -d objdump -k kcore/kcore_dir/kcore

Feel free to add for 1/7 and 2/7.
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>

> Changes since V2:
>    * Check validity of start stop arguments
>    * Make test work if Perf was installed
>    * Document that start and stop time are monotonic clock values
> 
> Changes since V1:
>    * Keep the flush function for discontinuities
>    * Still remove the flush when the buffer fills, but now add
>      cs_etm__end_block() for the end trace. That way we won't drop
>      the last branch stack if the instruction sample period wasn't
>      hit at the very end.
> 
> James Clark (7):
>    perf cs-etm: Don't flush when packet_queue fills up
>    perf cs-etm: Use new OpenCSD consistency checks
>    perf scripting python: Add function to get a config value
>    perf scripts python cs-etm: Update to use argparse
>    perf scripts python cs-etm: Improve arguments
>    perf scripts python cs-etm: Add start and stop arguments
>    perf test: cs-etm: Test Coresight disassembly script
> 
>   .../perf/Documentation/perf-script-python.txt |   2 +-
>   .../scripts/python/Perf-Trace-Util/Context.c  |  11 ++
>   .../scripts/python/arm-cs-trace-disasm.py     | 127 ++++++++++++++----
>   .../tests/shell/test_arm_coresight_disasm.sh  |  65 +++++++++
>   tools/perf/util/config.c                      |  22 +++
>   tools/perf/util/config.h                      |   1 +
>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +-
>   tools/perf/util/cs-etm.c                      |  25 +++-
>   8 files changed, 225 insertions(+), 35 deletions(-)
>   create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh
> 

-- 
Thanks,
Ganapat/GK
