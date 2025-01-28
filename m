Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE01953AD;
	Tue, 28 Jan 2025 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738051923; cv=fail; b=gKMZF/zCSkmrEToNXapY+IUc59mR+r/rzrRWnSBg2MEo9GQjb6YdfudVwjJyatZGnIr7w+NMoWQPru8nxR04CBWFo2ES8eGTJUnQQPLKT6GnNk+Z6T1U55Jdq772SSVjxDoh/C5nCDNW1/ibKuf1NJTcWN0AAhYvZ3cosjnGwNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738051923; c=relaxed/simple;
	bh=1SkYIdWFLgz21O5VSseaOC0+7blDfseb3Op7A6L3YrI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UlwVi/S48YrsOwcj3KrdQaAua7ALKxvmowWJbeuh6gxbe/RJWweub9evYaFXmxmuWJmkwHrN7gNqD5z4xBfw+X3NOwFLHSeALlfYzANyWk5T/8y/JejNgDvPEyOrtwbri5SEvIbjtA0uUEGZoXncYyVizfxhQbZ1qrb4IinUpes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GQQ5fi5u; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GQQ5fi5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hON6sQJTtclFZCtCi8Z31USHVcvFDlDCnp4ehX7RClbjPWjYKwNKgYoBAnAqKO8Hu3YAzhVgQoUZW9ueq3A9DkshjvfurFM+0XXnnd4egBqBMi6wQU8xMSa7VS00NlhIK9kCwhE3a1DKmmz54y96xVBgPBEAapRNrd3Y7Fzh+Ke3+Hnrrd7+plDhVbdPKP5hu6vSlwDhvvvn0QT4WcWBTUizI5Iy28XrfY+cJF3nMaiLeVSPonSN5hvQCdyX7aWDrXeLYwJnCkcDgoHigxd6IiEYlgkeE2vISDOpnwBStmH4ywU5MBPrxWAtUhgkGSKnJ3Jcu8l7vnE6/nuGCxlVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGP4jfnH8C9YMVCrO8JKQ8NEQuI+KpDbpbKRkCFN29Y=;
 b=Z7vEH40O4Es195GuPJ0CECGnAselbZ2c0L31XVTYhiFRfRBVc0Z4tiBdzZf+Z2Qote7XXhNkieUwdo70Iw7PBLdrqwvZfZfNh042nkjGxxD7sGNrD1Pg8p83yBdsmhghM/SH3eTs/1V779LyROfXr1l9EyTOClrze1n264KEr4NH7sVgbAvjxe5NslgBDctJ8MmtP2+U+ww+aTyVdk3ljHW6V7nbHgUJLrzyDEMnUCYycP7ylLWnh94z+qweTs77pdtOi0zBgHtGNEAcb8OvRDyi+i1NnTW6f6z214gt/482BLZVJVDeBscgRowf/nOUHouPPHDbpzSoFpdS3ah5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGP4jfnH8C9YMVCrO8JKQ8NEQuI+KpDbpbKRkCFN29Y=;
 b=GQQ5fi5ubdnNJQqvufgcHqh1xBkyUNhUH5tKLP44JazTyt9ntwpSl38x0Fow8ijSrAnrSBzrn+tt/2iMKfG9rAwwO8kRriQJ8vPPzXXi12tugVG6VG4nXJhZk6wtu2Czh13SZgq3lqEToSz11p5qxOxYP6u+T+ZqiRSOOvpOT1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 08:11:59 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 08:11:58 +0000
Message-ID: <73fbc810-6666-4997-8f0b-75d2eab8a943@amd.com>
Date: Tue, 28 Jan 2025 13:41:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
 irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.dei, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
 <98f6108a-3a4f-4ad1-8f0a-a03264f7a2d7@amd.com>
 <6ljdgok5zostmu4uxixwh3idgrrtodul4bjvujvwjfda427snu@3vxczriucb6m>
 <1276efa0-488c-448b-adf8-b002c77179f6@amd.com>
Content-Language: en-US
In-Reply-To: <1276efa0-488c-448b-adf8-b002c77179f6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::50) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a435af-7bcc-4ea8-a696-08dd3f736fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUk4R1hINUFncTVQcGpIWE9pRUFQT1RuV3h6aVZMQXRHNmpFMGJDWjNKdzRn?=
 =?utf-8?B?WDdRdk9jY1JzcFBaTFBtUVR1YXg0bSs0Q3FxU2ZlZHBQbUFESW01WW5LZCs3?=
 =?utf-8?B?dXR5NWIzRU1WU09XVFFvdDhFb3hBVGpzVDl4RVpBYWdrOEpnQmZWRFNEMllD?=
 =?utf-8?B?Vng2a0tiYlVnK3o5MkdSZVZGUDRJNVU3cytqZGM5VHB5bDhZUU9xYnpHSk1q?=
 =?utf-8?B?cmNoVUN5V1RCdllpM2N1ZzY0ZjFVeEFPRGRNQXdBRmlFa2lsZzdpa2EvMnM0?=
 =?utf-8?B?czZGZGRIRmVNbHEvS0tIU25LcHRjQ2ozNnhkQmV6Rzdad1J3R3N1aTAzeldQ?=
 =?utf-8?B?NW1zZGtQRGEvSXpVYlgvRFpNTGFUWTByYk44RVY0eGxKbURINVVHM1I4blVF?=
 =?utf-8?B?ckNsc0p3cW9vMG41TmozTUs2OUloMlV5VjFoajN0dC8xanUxOFR3ZlcrMkJ6?=
 =?utf-8?B?N3hEdjg0QXNwN25ETXdLRm56b1RsbjlOMm91NHJOQ2k4K2w2clIvUjlucUp1?=
 =?utf-8?B?bXlNT1ArdWZSaFRxRzJQa0lMOHZmaUFlK2lkaThud0FCRWN3a3J0V0dRK2ZQ?=
 =?utf-8?B?b0hDSXAxTkg2L3NzSVh2dE8zUVdkbDU5T0VKMC9JQ2NvMVIwSGE3WU9nUGpG?=
 =?utf-8?B?a0pLSjVsVUluNlJGQmVMMmJ5UXhxRC9nYVZXSmVPN2JOdCt3cDNUb3NmSjlw?=
 =?utf-8?B?M280MmF5Q3M2ZWltZWhDbU9iek1CeTNaRVhZVFZ4emdqWDhwZWlVMGV5am1J?=
 =?utf-8?B?eGZ4Q3B2dGdzRTVQVUZLeHl0UXBvdEMvNG51Q0taZTJERm02d1NYWExJcFdi?=
 =?utf-8?B?RzlKbExUQVRqT3hHV0lnNGhQaktiZFZvVHRTcXpFdjVOWnFQdUhLa0ZxUzB0?=
 =?utf-8?B?M3NranFtb2J3ZXp2UGduZTBmMGphNzljaGM4cS8zbGtEL3R0Mlp1YjZsNXdR?=
 =?utf-8?B?YnFKSXRJK0c5NVlsalRUZXkzMndyMVhrbkdxdkNGbGk5VjI4b0Z5dlE3VGxD?=
 =?utf-8?B?QlEzTGY3dXlzSDlrekEzVGVxUHlqN0pacnptM015SDVpQUVJbXd6QUpxN0wv?=
 =?utf-8?B?alNCcWtOcWN4MHBrVkJxMXZHU2hzVVROS2dLVzEyeGdvbkhlcEFyZlY0bHRF?=
 =?utf-8?B?d09nK2JWNEJaS2lXcHg0aUJZcThwaU5NKy9BUEhaK3dmRkpFdVFQTnlxdTd6?=
 =?utf-8?B?aEkwZk9nQU9yYk00am13U0Jud0graWhPWk8wa1RVcW1BcTBHcWw1NmE4STZZ?=
 =?utf-8?B?cmF3T2Zra3phdU5TSnp3dTFHQUxjWmhCY2JnbU8rWEs3TXlUUU00S2hnT21O?=
 =?utf-8?B?ZS9FTUxoN1BSbW9TR0pCTFloNk9mSGtRY0pyS2hMMklNY1V3NmRHaFRjSzhK?=
 =?utf-8?B?SEJxem9UT09YMkxST2k3OHVGbDRXN0xMa3dSVlBKNkQ2bmJ0UTdmSkdMZ3No?=
 =?utf-8?B?UUU1cmMzQVA2ekpZKy9mK2V6eW1tWWFRc3lsUFpvSWt5NkpNMlBqZ2RrczUx?=
 =?utf-8?B?cG4yVUZ3QnN3Y3o1cmpNV3NlWWRzcDlNUmJobnhnWjNBZmJENVJ1ZitFbHF2?=
 =?utf-8?B?R0hCTmplZUhLUkdybkhOb0pyTjBHRFVwUVlLVkFBRUpPekk3OW5nTE04V3hu?=
 =?utf-8?B?aW1OTThwY1hzakF1VzlWTE0zekVyVkZxNW1FWDM2amNaTDBsWE5xa2hpTDRu?=
 =?utf-8?B?NzBFcTcwR1VSdmMvTmZkaGV2bXJmRi9GS1pNSEdVbElDczJBNjRaWERZbE9W?=
 =?utf-8?B?SzV3NmMyTGdGS1pwWmRoWnZUYnNVSE1pakFUT21vaExNU2E4c2hJRFVoZUhU?=
 =?utf-8?B?VCsvZlNZWGt0UzRObVJoUlduM0NxcUp2ajRKYWlxRTMvVGR0M2NHMWpmelg4?=
 =?utf-8?Q?NQ+L0MBk+uCb1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0JSVG1rVkwwVXV0WDFxQ3p3bStkMUJBNWt3MnhoZnE2aCttdys2dHZxYXVy?=
 =?utf-8?B?NStYY2x1MVN3ZEl1Ykp4N0pRc3NSeDBRK2g3bnBtWG5zYjVkR2RZSVpVZHlX?=
 =?utf-8?B?WERuUDF4K2Q1Qy9wQkRsVCtOYVhaR1UxbTJqS3dnNzhUS2d5aVNITlZGVkVL?=
 =?utf-8?B?aC9iR3VTL0pNbncydUtBbUwyZHMwL09ENzZISFh3dXFmN0NyV1dhM1hlL3Nq?=
 =?utf-8?B?V0VjTHYwNUhqRGl6eU5pcWEzYWdYLzlLcEFscDVuRytVK3FEWG9ha3FLbTEz?=
 =?utf-8?B?bkI1aGdnM0RicTBJYm5zY3lQT0pwekd3MFZyRmoxbWZZZmtjcnM0N2ZZd1R5?=
 =?utf-8?B?YlY5TVBNT28zeFlRZVpKd2hoS3B1MnQ4QzFqUjd4KzY0QlkvZldNVTRtaFhR?=
 =?utf-8?B?T0xuY1BTYmUrZWZRUWV3WXhIbXpFV3Fqa1dMc2NNMUxURnFTM0dXMFRBQ2xH?=
 =?utf-8?B?SlJKTzc5aDU5S3ZMZGFjblNIWVNXTkM0dG9oTDR2YlFyT2daN01YcGZGQTR3?=
 =?utf-8?B?YlR6ZnVQc2JTTlJ5K2NUODZ3VUZGdDdDblZXZHMvdHlUSGpWZThSajVUbmJu?=
 =?utf-8?B?cDVXcjJ3OUExUnhEamFGa1lkeHE5NzAzV09rVWtYQ2kwRG5vc1FtNzllUTNT?=
 =?utf-8?B?Z2JhQkVhbWlxQ3FQRXlhbEkxYlgwUCtXSThtY0JqWkVCMllSVlNGNC85MTYw?=
 =?utf-8?B?amh1TjlLaXhkcWdpMUZQdDdjUHRaNFo2OE92WWxDOERUdWVKMmNic0doeTNY?=
 =?utf-8?B?cTdHcm1BTVZoOVFkcWk5TXVwMG8zTEFtQjlxbElQbGpmb0RqT3hHM2xlLzZX?=
 =?utf-8?B?YVZkcDR0VjRWT3V4M2VUa0JoK25Qckx0RzdsNWhWQ2cwYWYwQy83U2lNS1dD?=
 =?utf-8?B?NXg2bThjbXI0WDFJNDg4S3JuSWVoQmFsYTRyMXFtR2xsdmpka1I5S0Z0cmVT?=
 =?utf-8?B?R21XN1owd0JxR2hIb2FET3g2SmQ3azMyQlpCTHFuN0puV0lpWlM3bitNbnlu?=
 =?utf-8?B?eUlyL01XajFtd3pYMlVNYzJWNWRnTlFldEZWYVd3ZnoxbUtTU2Q3Wjg5Y2NW?=
 =?utf-8?B?RzRwSmhMckxzQ1Nkb1M5SlFLb0JpVVpqZkVwNC9IK1hJTkUxVThaL2RZTFdE?=
 =?utf-8?B?YWRVNVFnMU50ZDRxMTFQd013bWdkYmpTc3czWGg0bU4zNkZwWUZaSWl3c1Jt?=
 =?utf-8?B?VDZIQVFvWml4RHRDcWpZbE5uTERTR0I2L3lCVzNoOWhlQ0x5NFRxOUNybTBs?=
 =?utf-8?B?Qm1SWUdTUHRwUTNmTUkrV1VuY2RVOFhoUEp1YWVJVW11ZGlYZk8wa2FaNXI4?=
 =?utf-8?B?bmFuWlNBUmZCL1g5SmlpZjVXWnVyVmdUcnpsdzhiT21IamZuakZYL2hLaEM2?=
 =?utf-8?B?M2RaU3o0TXd3SGVDRkNIaVcvWWR0U0RtSVh0eWFuY1U2OXZoSGxubExlSkFS?=
 =?utf-8?B?UG1Qa3lsMnVLd0pFaFdBTE84eVZtK1p2SDh2aTQxVVB5REFncHBieSt1cmRj?=
 =?utf-8?B?RlpaZVNXV3pHNzRqVyt4TGZxVEt0SDdwWG9Ub0N0SFI5YmExazBXdCtwdjV5?=
 =?utf-8?B?Q0wwY0RsRFo2d3pQUUtYVFk3c0dUYS9CWmhaVi9iSzZBRmZWNTlSNk55OUNp?=
 =?utf-8?B?c3dZNDdXRVM0cG5ac0NRWW1nSmdlRlNCZGdoQlR3ak5Lek9SQWp4ajNiRmlP?=
 =?utf-8?B?bmtKc2lzU2U0YVkrWXV5WHVRZll0UWo4QjBoQ2FQTURpNHE1MTVYajR4S1kx?=
 =?utf-8?B?aXIzWUNacllXS2ZwYnJOV2lNK2dRdmtFTzNHdmRQVk9DOTd1QnlBL3JJc2JO?=
 =?utf-8?B?Q2hReHJaMEp2YWp3T0RBN1dPKzBWU21Ob3VEZjNlNVNNWnlGV1IrazN2bWRu?=
 =?utf-8?B?WmxDYkZuTnlOeDQ3T3JmdjFmRU9uQUtBYzI1Y3RQdzl6eHRKYlpGczkrNU41?=
 =?utf-8?B?enJoNTNhUnp0OVRjQ0hmZ1c0M25sUkdWc1pBNE9wRWptTkhmUWJ6ZUhmaDhL?=
 =?utf-8?B?dGM0czh4K1BCVUNncHphaWdCSml2UllCKzdsWCtEVzA1dXlrR3YxbGF0NUZx?=
 =?utf-8?B?WTcvN3FpeHpRQmVOeXZJUnZuT0lpM1BMQUpxN3RQUTJDcGM1b3BNOXBBUnda?=
 =?utf-8?Q?9vlmvRolCcvWVv/1aN0lDqpcV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a435af-7bcc-4ea8-a696-08dd3f736fa9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 08:11:58.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTLNijaRZM5SmBRGLs7ddvyIy84LUZLwmC7PAUj+hYC+OvstvheJ+FVhgw7l6ZhJbrPBzT+XJlXlNn6yoSjqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

On 1/20/2025 5:12 PM, Dhananjay Ugwekar wrote:
> On 1/15/2025 7:53 PM, Koichiro Den wrote:
>> On Mon, Jan 13, 2025 at 12:04:43PM GMT, Dhananjay Ugwekar wrote:
>>> On 1/12/2025 7:12 PM, Koichiro Den wrote:
>>>> On Fri, Nov 15, 2024 at 06:08:06AM GMT, Dhananjay Ugwekar wrote:
>>>>> Add a new "power_core" PMU and "energy-core" event for monitoring
>>>>> energy consumption by each individual core. The existing energy-cores
>>>>> event aggregates the energy consumption of CPU cores at the package level.
>>>>> This new event aligns with the AMD's per-core energy counters.
>>>>>
>>>>> Tested the package level and core level PMU counters with workloads
>>>>> pinned to different CPUs.
>>>>>
>>>>> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
>>>>> machine:
>>>>>
>>>>> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
>>>>> stress-ng: info:  [21250] setting to a 5 second run per stressor
>>>>> stress-ng: info:  [21250] dispatching hogs: 1 matrix
>>>>> stress-ng: info:  [21250] successful run completed in 5.00s
>>>>>
>>>>>  Performance counter stats for 'system wide':
>>>>>
>>>>> S0-D0-C0              1               0.00 Joules power_core/energy-core/
>>>>> S0-D0-C1              1               0.00 Joules power_core/energy-core/
>>>>> S0-D0-C2              1               0.00 Joules power_core/energy-core/
>>>>> S0-D0-C3              1               0.00 Joules power_core/energy-core/
>>>>> S0-D0-C4              1               8.43 Joules power_core/energy-core/
>>>>> S0-D0-C5              1               0.00 Joules power_core/energy-core/
>>>>> S0-D0-C6              1               0.00 Joules power_core/energy-core/
>>>>> S0-D0-C7              1               0.00 Joules power_core/energy-core/
>>>>> S0-D1-C8              1               0.00 Joules power_core/energy-core/
>>>>> S0-D1-C9              1               0.00 Joules power_core/energy-core/
>>>>> S0-D1-C10             1               0.00 Joules power_core/energy-core/
>>>>>
>>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>>> ---
>>>>>  arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 152 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>>>> index 6e51386ff91f..e9be1f31163d 100644
>>>>> --- a/arch/x86/events/rapl.c
>>>>> +++ b/arch/x86/events/rapl.c
>>>>> @@ -39,6 +39,10 @@
>>>>>   *	  event: rapl_energy_psys
>>>>>   *    perf code: 0x5
>>>>>   *
>>>>> + *  core counter: consumption of a single physical core
>>>>> + *	  event: rapl_energy_core (power_core PMU)
>>>>> + *    perf code: 0x1
>>>>> + *
>>>>>   * We manage those counters as free running (read-only). They may be
>>>>>   * use simultaneously by other tools, such as turbostat.
>>>>>   *
>>>>> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>>>>>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>>>>>  };
>>>>>  
>>>>> +#define PERF_RAPL_CORE			0		/* single core */
>>>>> +#define PERF_RAPL_CORE_EVENTS_MAX	1
>>>>> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
>>>>> +
>>>>>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>>>>>  	"pp0-core",
>>>>>  	"package",
>>>>> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>>>>>  	"psys",
>>>>>  };
>>>>>  
>>>>> +static const char *const rapl_core_domain_name __initconst = "core";
>>>>> +
>>>>>  /*
>>>>>   * event code: LSB 8 bits, passed in attr->config
>>>>>   * any other bit is reserved
>>>>> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
>>>>>  
>>>>>  struct rapl_model {
>>>>>  	struct perf_msr *rapl_pkg_msrs;
>>>>> +	struct perf_msr *rapl_core_msrs;
>>>>>  	unsigned long	pkg_events;
>>>>> +	unsigned long	core_events;
>>>>>  	unsigned int	msr_power_unit;
>>>>>  	enum rapl_unit_quirk	unit_quirk;
>>>>>  };
>>>>>  
>>>>>   /* 1/2^hw_unit Joule */
>>>>>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
>>>>> +static int rapl_core_hw_unit __read_mostly;
>>>>>  static struct rapl_pmus *rapl_pmus_pkg;
>>>>> +static struct rapl_pmus *rapl_pmus_core;
>>>>>  static u64 rapl_timer_ms;
>>>>>  static struct rapl_model *rapl_model;
>>>>>  
>>>>> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
>>>>>   * Helper function to get the correct topology id according to the
>>>>>   * RAPL PMU scope.
>>>>>   */
>>>>> -static inline unsigned int get_rapl_pmu_idx(int cpu)
>>>>> -{	/*
>>>>> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>>>>> +{
>>>>> +	/*
>>>>>  	 * Returns unsigned int, which converts the '-1' return value
>>>>>  	 * (for non-existent mappings in topology map) to UINT_MAX, so
>>>>>  	 * the error check in the caller is simplified.
>>>>>  	 */
>>>>> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>>>>> -					     topology_logical_die_id(cpu);
>>>>> +	switch (scope) {
>>>>> +	case PERF_PMU_SCOPE_PKG:
>>>>> +		return topology_logical_package_id(cpu);
>>>>> +	case PERF_PMU_SCOPE_DIE:
>>>>> +		return topology_logical_die_id(cpu);
>>>>> +	case PERF_PMU_SCOPE_CORE:
>>>>> +		return topology_logical_core_id(cpu);
>>>>> +	default:
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>>  }
>>>>>  
>>>>>  static inline u64 rapl_read_counter(struct perf_event *event)
>>>>> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>>>>>  	return raw;
>>>>>  }
>>>>>  
>>>>> -static inline u64 rapl_scale(u64 v, int cfg)
>>>>> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>>>>>  {
>>>>> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
>>>>> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
>>>>> -		return v;
>>>>> -	}
>>>>> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
>>>>> +
>>>>> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
>>>>> +		hw_unit = rapl_core_hw_unit;
>>>>> +
>>>>>  	/*
>>>>>  	 * scale delta to smallest unit (1/2^32)
>>>>>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>>>>>  	 * or use ldexp(count, -32).
>>>>>  	 * Watts = Joules/Time delta
>>>>>  	 */
>>>>> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
>>>>> +	return v << (32 - hw_unit);
>>>>>  }
>>>>>  
>>>>>  static u64 rapl_event_update(struct perf_event *event)
>>>>> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
>>>>>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>>>>>  	delta >>= shift;
>>>>>  
>>>>> -	sdelta = rapl_scale(delta, event->hw.config);
>>>>> +	sdelta = rapl_scale(delta, event);
>>>>>  
>>>>>  	local64_add(sdelta, &event->count);
>>>>>  
>>>>> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>>>>>  static int rapl_pmu_event_init(struct perf_event *event)
>>>>>  {
>>>>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>>>> -	int bit, ret = 0;
>>>>> +	int bit, rapl_pmus_scope, ret = 0;
>>>>>  	struct rapl_pmu *rapl_pmu;
>>>>>  	unsigned int rapl_pmu_idx;
>>>>> +	struct rapl_pmus *rapl_pmus;
>>>>>  
>>>>> -	/* only look at RAPL events */
>>>>> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
>>>>> -		return -ENOENT;
>>>>> +	/* unsupported modes and filters */
>>>>> +	if (event->attr.sample_period) /* no sampling */
>>>>> +		return -EINVAL;
>>>>
>>>> Hi Dhananjay,
>>>>
>>>> On linux-next, since this commit, it seems that simple sampling with 'perf
>>>> record -- <command>' (i.e. the default event), 'perf top' etc. can
>>>> unexpectedly fail because rapl_pmu_event_init() now returns -EINVAL instead
>>>> of -ENOENT even in such cases of a type mismatch. I observed that this
>>>> prevents evsel__fallback() from falling back to cpu-clock or task-clock.
>>>>
>>>> Should we reorder the checks in rapl_pmu_event_init() to allow an early
>>>> return with -ENOENT in such cases, as shown below? I'm not very familiar
>>>> with this area and I might be missing something. I'd appreciate it if you
>>>> could share your thoughts.
>>>>
>>>> --- a/arch/x86/events/rapl.c
>>>> +++ b/arch/x86/events/rapl.c
>>>> @@ -370,17 +370,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>>         unsigned int rapl_pmu_idx;
>>>>         struct rapl_pmus *rapl_pmus;
>>>>
>>>> -       /* unsupported modes and filters */
>>>> -       if (event->attr.sample_period) /* no sampling */
>>>> -               return -EINVAL;
>>>> -
>>>> -       /* check only supported bits are set */
>>>> -       if (event->attr.config & ~RAPL_EVENT_MASK)
>>>> -               return -EINVAL;
>>>> -
>>>> -       if (event->cpu < 0)
>>>> -               return -EINVAL;
>>>> -
>>>>         rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
>>>>         if (!rapl_pmus)
>>>>                 return -EINVAL;
>>>> @@ -411,6 +400,17 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>>         } else
>>>>                 return -EINVAL;
>>>>
>>>> +       /* unsupported modes and filters */
>>>> +       if (event->attr.sample_period) /* no sampling */
>>>> +               return -EINVAL;
>>>> +
>>>> +       /* check only supported bits are set */
>>>> +       if (event->attr.config & ~RAPL_EVENT_MASK)
>>>> +               return -EINVAL;
>>>> +
>>>> +       if (event->cpu < 0)
>>>> +               return -EINVAL;
>>>> +
>>>>         /* check event supported */
>>>>         if (!(rapl_pmus->cntr_mask & (1 << bit)))
>>>>                 return -EINVAL;
>>>>
>>>> Thanks.
>>>>
>>>> -Koichiro
>>>
>>> Hello Koichiro,
>>>
>>> I tried reproducing the issue you mentioned using "sudo perf record -- sleep 2" and 
>>> "sudo perf top" commands on an AMD EPYC system, the commands worked successfully. 
>>> Can you please mention which system and which exact commands you're 
>>> running that reproduced the issue?
>>>
>>> My analysis is, if we are running "perf record/top" with the default event, we would 
>>> not enter the rapl_pmu_event_init() function, which renders the reordering of the type 
>>> checks irrelevant. Regardless, please let me know how I can reproduce the issue.
>>>
>>> Thanks,
>>> Dhananjay
>>
>> Hi,
>>
>> Apologies for the delayed response, and thank you for your comment. I
>> confirmed that just running "perf top" on a qemu instance reproduces it.
>> The host CPU model is Intel Core i9-13900K, which is passed through to
>> the guest.
>>
>> In my case, no pmu for PERF_TYPE_RAW is registered, but the rapl pmu is
>> present. Then, perf_init_event() reaches the line marked "---->" below, and
>> rapl_pmu_event_init() run, which returns -EINVAL before the type check.
>>
>>   static struct pmu *perf_init_event(struct perf_event *event)
>>   {
>>           [...]
>>           if (pmu) {
>>                   [...]
>>                   goto unlock;
>>           }
>>     
>>           list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>>   ---->           ret = perf_try_init_event(pmu, event);
>>                   if (!ret)
>>                           goto unlock;
>>     
>>                   if (ret != -ENOENT) {
>>                           pmu = ERR_PTR(ret);
>>                           goto unlock;
>>                   }
>>           }
>>
>> I'll look into this a bit more on my side later and get back to you if
>> something becomes clear.
> 
> Sorry for the delayed response, can you please try the below diff and let me know 
> if it fixes the issue?

Hello Koichiro,

Gentle ping, please let me know once you try out the below fix.

Thanks,
Dhananjay

> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index d3bb3865c1b1..4952faf03e82 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -370,6 +370,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
>         unsigned int rapl_pmu_idx;
>         struct rapl_pmus *rapl_pmus;
> 
> +       /* only look at RAPL events */
> +       if (event->attr.type != event->pmu->type)
> +               return -ENOENT;
> +
>         /* unsupported modes and filters */
>         if (event->attr.sample_period) /* no sampling */
>                 return -EINVAL;
> @@ -387,10 +391,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>         rapl_pmus_scope = rapl_pmus->pmu.scope;
> 
>         if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
> -               /* only look at RAPL package events */
> -               if (event->attr.type != rapl_pmus_pkg->pmu.type)
> -                       return -ENOENT;
> -
>                 cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
>                 if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>                         return -EINVAL;
> @@ -398,10 +398,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>                 bit = cfg - 1;
>                 event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>         } else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
> -               /* only look at RAPL core events */
> -               if (event->attr.type != rapl_pmus_core->pmu.type)
> -                       return -ENOENT;
> -
>                 cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
>                 if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>                         return -EINVAL;
> 
>>
>> Thanks,
>>
>> -Koichiro
> 

