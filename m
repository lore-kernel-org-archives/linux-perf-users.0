Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022085.outbound.protection.outlook.com [40.93.195.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753C15B12F
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860106; cv=fail; b=gDEa132ZyeW9RaYLcbrAPENrdPYqG7a0/dF8qTJBpspGquH7kp3fXr3NufPw/HtBhPt4/6Svx4Ao/cmGV7GtP7nkyjHVAR6JLCOhLvtf3blRoMTGeJqpx5WvM0gtjkeKkIsyekuu6FZJmbS+tKcz3ZtcoNZJAii67htT4SMOYro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860106; c=relaxed/simple;
	bh=P8iNmVxJK3/0eBaYiVD+yp5/HSy4SqnjWDv4JFrjY4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kA75hmGnAHwO+EOiKjNhpEqIyG4ZUizvukbpInZAPQSKE7Fm3dAADG2MxctwrD8ThhBUgbKTbdYdR+f+QbN/yl7oF6tQrUoxrCmx/g1Tjf1ytreI5Ps+9BsBGhxUAiGU/afT5Uis6ZcSiFiUgp0h/6LEa7vLgiu8qwySMMa/vwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Jbgy0Jv9; arc=fail smtp.client-ip=40.93.195.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Jbgy0Jv9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEC9LnitnWrkuzvTa+pf9I26kBNYGEoGGjVjlNd2eBaXCk3XpuNngymDMViWfFFa5h8FFODib38SmzfHkcGv+aj8Lpx4uEtuk5l1+UoNiJvQliP+RYVbIfcMFX5EbJqKEG4ENN38wzOzNs2LPG/mUN9fJzda+hVUVEMfTZIzIb72/42dIP2YWjJg90oWXQD74QUD121T9myTaw3caGVoH/AoaTAU0deJdbIwWeHiL4glSNr/r1GiBG1kY9An/MsjfsJLb/TiIzUjaQKKaFMtp1J7lxpHJXnhl/nGnuuP2+TKWeG+tBHdOCvL2Xpqr3KtbSX0U901CQTL8T7bwUG+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK33KWdzMGc7n9/2AtjOXAXMsmtaWcD0I4xDeDE27dA=;
 b=CT9OHO79rivItzYKz1x5O4C45wPcZ9pSEqh8x4Rd5T1rmAw2aJDm6FVftdZOcbiochaQTGN5uQjYhOXYuG0TGE7FRyv91WNjUSV/wcp+G6jtn1/It+CQrxw0iykqDah5yxCOk9jRrMFq73xme3/44voc+UvkOF1j6yGst9n2IOklKDc6aK/mLn36cUl6fsp01Th0MxivgFqH91pNjxr9NyctXnzt2iC+G69As2+853kxEUl42kSZZd4GTPriPW7jvMwV/fnHuloyCoP+21y7EewoTwuLrJeSCvFMGjlGvzmPCAzIpHj4gmBwPvG2u2fzq9mBYLP33WiX2PwcV5jUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK33KWdzMGc7n9/2AtjOXAXMsmtaWcD0I4xDeDE27dA=;
 b=Jbgy0Jv9OWE7eGNz3Kh4qO4Jx19MhaDvbsMuF1UoNgZZoOypusQGy5SEt+nS4RWYlhsKyDJPnkxVhpp17SDxeYu2GzVPQOZpc2H68wqmCFuRrC5+c7cZfltxNwgYMrqZLWa+tfvoZPFKUxq3NkyKEt544zTvatVK1ALDWf7PfBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SJ2PR01MB7983.prod.exchangelabs.com (2603:10b6:a03:4d1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Wed, 28 Aug 2024 15:48:03 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 15:48:03 +0000
Message-ID: <ce98443a-e79d-4f92-b0cf-4e6603928bbc@os.amperecomputing.com>
Date: Wed, 28 Aug 2024 08:48:00 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V4 1/4] Add dso__is_pie call to identify ELF PIE
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <ee7a0b4944093db90a589040be39ef3e7e747f63.1724820993.git.scclevenger@os.amperecomputing.com>
 <1a58ddcd-c386-49b5-a540-4369a1f1469b@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <1a58ddcd-c386-49b5-a540-4369a1f1469b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SJ2PR01MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: b37f562e-71df-4769-adb7-08dcc778cd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkJWNVhQUW1EelJrWlZ2dFkvcFdLSk5wL1oyOThPVjQrQWxvRDc5VkFwN0d3?=
 =?utf-8?B?YjJGY1BHYzFRbEFQUVVlVW54SlROeUwzRWZvQlVQemlnckp6VHYwSzBwa2E5?=
 =?utf-8?B?eGpuTDBYMlFodDBEOFlkcStGWXNYNWdIeS8yUnhscWJhMTdSYTc5R1ozd21M?=
 =?utf-8?B?V0s5NGlrT2ZrSGlPbHBXNTdGVDZ4ZUhsanRWMC8vZUlwcHFLRm9xcUNRV1Vn?=
 =?utf-8?B?RURDaGdjMXpvOGt0Q21zOVl5cFVEUGpTc2FaSlp0cE1oOHpuNTNWeG4yTjJS?=
 =?utf-8?B?M1dUbUdWb0o5OGVxbUJ0eEdlRTFKOU51dnBZY3lMdUlIMzZ2L3pqNW5xN0FN?=
 =?utf-8?B?YWxaU2k3cmQ1SU51aGltWjZFOEN1a1UvSmI1YzJVWWtXOXpxc0tqSDluOXJ1?=
 =?utf-8?B?Sy9CUnBYdlJqemM2Y21QdzdCRC9NYjBxTVlla1BGTnZKMEpqUHNDTzM5djZp?=
 =?utf-8?B?SFQrTjBoTHJSdGFlbkRyRVMrWHUyeG5DUEZhZ0xScW9OL1lCZjQ0aWQ3Mmg0?=
 =?utf-8?B?eHZoaEVWMVBpWFYyNk02bUU4dWlzRU9jbHdtaVZUSnpoMG0xbFFyVGJBMkMz?=
 =?utf-8?B?OUpaa0ppSCtDRWl5UUhJOXdCWXNhUnFLZGNRemo0dkNqOS9qTmZZMjRtQ0RU?=
 =?utf-8?B?WllKWHJWbHVoc2J6bUcwVS9sOVhucXovYURmUStiSWdFMHhGeGFDc0xVUHBp?=
 =?utf-8?B?bCsrNXdYQk5RUVluQkIxZVpHMU9Ndi82U1crRzhUMjVwVmhETVFIakJqV1Nh?=
 =?utf-8?B?dFZlZ2VJdHhDbmw4d2lKeFhuamxPcTcyQWNydWVkU3pmMUgvaTVNNS9JOFdP?=
 =?utf-8?B?Q3Q4a2RsUU16N2N1T0JWZ040V0lJaW44SENvOW1BTGsvYS8rYjZwTHhhbHli?=
 =?utf-8?B?dXFaTlErT2pSTTNiSWI1VEJvY1pOcUhZczF2NUJqaFd6Yjd4N1paQU9TdU1I?=
 =?utf-8?B?SEp6ZlZzRnNyTlhPeDU4S3BCbjVMcjhIRCs4SXZvUlp5bXl4VkMwUkd3TC9J?=
 =?utf-8?B?UWdmMGp1YjQ0dlN3a256RmZHQVVBWkR0S2FsdDVwRGpPNElaS0d0NTdPK0cz?=
 =?utf-8?B?Q0V2QW4rWWxjQ24wd2V1ZFk1Z0lsd0tuUUpWdytXT2wxNDMxY1dXYndoTGUy?=
 =?utf-8?B?T2VBL09sYWNvUkd2WlZ0NjVpaGtoRmczMUM4VGNReHc1aG05cW5xeEhGTzBh?=
 =?utf-8?B?MUp6eUNPcVJiQ1M5QmowVTFqN1dQT0dsVy9rVTF2SWVDaXg1T1JDOElGcWpJ?=
 =?utf-8?B?bXNtMWIrSWpBUDRtTllBOWkvZTJJV2c4SzR0MzJSNTFxMm45VGprNlA2SEw5?=
 =?utf-8?B?Zk9SdmFMNTk2LzNORUtEZ0pVYTFqTjZ5T0dQR042anpaOUs1QUZVcmFuZlZp?=
 =?utf-8?B?OExkOU0vODV4S0l5dSs0SEtHd3FrN0ptaU5Ba0lxNE1pQjZ2Ly9Ra01VTjVQ?=
 =?utf-8?B?cHBlb0dlOFVGV3JDc05ITS91b0s2ZUo4U1JlcnpJeFBqRXIzY21uK1VIazlI?=
 =?utf-8?B?WXNzNGlpMTZVYzZsdnJuQTRNNWlnaDhneloyZitkWVJZdmVHUldnVDhCMVE5?=
 =?utf-8?B?K3VKUFZrSGc5OHprcWEwOGlhTFdObHF0Rkp5ZndObDhwTEdXUWxuaVdhOUdY?=
 =?utf-8?B?dlJEQzlGUjRHUjZCVWE1MEFwMWNqUFpMOTBOeGJhWHYwZXpjSGNSVlVZQWFG?=
 =?utf-8?B?OThmY09QbWF4N2lSNlBWUEoyWmVGcEMxM3crcG94eWpFVTJFOGNxMS9PMlV0?=
 =?utf-8?B?K3NOaDZZWmE4bnhqR0tFRE0zcG9xVWx3OFZyT1BrUFlCSzUyWHVYSi9vbU1I?=
 =?utf-8?B?TFpaV09zUW15TUZkVklLdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzU2a0d0TEp6YlhQekk0Q1VyblNoZnhyV25CY1IrbnNqeWk4YjF5WjVWYTN0?=
 =?utf-8?B?Uy9odUwwUWNqYTBMbFVIeXZmWjlJWlJaZGVWOFYyQ2dpN0psdVlWcjFsQTB2?=
 =?utf-8?B?VG8wN1dQUGkzeU1UT1NRczZYazcvMFpmWnFlY1pVdG43Ny9EZlREUVlLNHFw?=
 =?utf-8?B?VlFIeHlZMmpXRHVBemR0aTQ0bkRaWmgxYjB6RGdCc2liQkRaN1NRMDJKTXJy?=
 =?utf-8?B?U0owQ3crZFBtbWVraGJ2R2tYNWtZcnJlZGVxWFJhNWRTVklEL0RtT0I2b0Zz?=
 =?utf-8?B?WWk3eUxVYkc5b0NHTXVwNFB1TDlIT3o3STlxbEQ5QXdvZ0RDa3JheXNYTmgx?=
 =?utf-8?B?Tjg1dXloY09qdmxSNEI1ajNBTnRMM3VYOUJteTlqVEtqdXpNSWVBWFNqKzJI?=
 =?utf-8?B?Q1BDdmZZQm9KZmZTVkYyc0RLSERxSWRhZis1MG14ZndCc0FBcDd4L3BNTElX?=
 =?utf-8?B?Mm8vRTMzZ0tHbDQyek5xSWlBSUN1TzBIaURtdk10cFVXWFdmZkRKRXJoRVcw?=
 =?utf-8?B?WDdTcFRKZWlWWHBlZmhaUnViWXVMbzNNVHRtd3hFL0FzM1pQSUN0c2RhclV0?=
 =?utf-8?B?ZGgzaFN0RFZpTWx3U215VlZsUWlhaU43dVJnTUNBSUxydWNFWlE3Mk9yK0w4?=
 =?utf-8?B?NExzS0NqVzhRTXlxNmp6MWY0ckRaNVJUdk00ekxoMHplZ3FVdTZQakU4SkJT?=
 =?utf-8?B?YTgvcTB2TG9aSnVHeGU0Qzczd2VEMzNFaDVGYXFla3dqVUtFenZTK3A5akgr?=
 =?utf-8?B?bk84a0dGZjR4ZG96L1FyTUw4TkZZNmI0U3pnd285aHBEWUtIQXQrRmdSRHJz?=
 =?utf-8?B?MWE5eENhRkpKcWQ5cGROTER6LyszQkJJTFR6YWd1b2JNeUNrUG80RXpSWE9L?=
 =?utf-8?B?M0VEWU8xTC9VTUpJbTN6YTdHODdZaU80STRhR2N3d2srREdIUnZIR0pkOFVR?=
 =?utf-8?B?enRJeUJMRHYwSVFFZXhCWlg0Um5JbUx6RjNqYk5TYWhmRVNjQmFWTHU0MnRR?=
 =?utf-8?B?UUZEUUR2VTdSMWZDWUZKTjUwQXVUc0pqSjFuV0dpWmpkTzlrUXA2Tmp2ZG5F?=
 =?utf-8?B?RnZTSHJ0MHIxN25KYnBOVGtzbCtheGhiV1FzTXJUSGhSb2FoQlZ1RHBibEFp?=
 =?utf-8?B?eGUzZWFFUkx4NXE2b3BZTlZOOFEzWWY0WHVRaUxxZDhvbkM1azUwSTYrdzB5?=
 =?utf-8?B?b0hiWWROZXBKdWdTTWRCQ0I2cXM1VkNiVHBoaWltV3Z2T0F4ck9LZHZMMlBi?=
 =?utf-8?B?V1l4Sm9zc3N2R3kzcjdHalNzVndzQlJDY0J4UHlRMzFaRTM3UUlialM1NDh2?=
 =?utf-8?B?WVd6RE4zdGg1K2tkUUw2WjhNNnEyZWRjNSt1WXl2UzBOVURlcTBwSFFPOGg4?=
 =?utf-8?B?OGZVMFQ2clZiT1RiYllsVi9taDI4TlN3ajFkbk16d3VaTWVBeFNEbDF5S2lN?=
 =?utf-8?B?bG9iWXlyUkM2VEhkdkIraGJLZm1rSWYyeDZrR3dsd1VJbEQ5MlBXcHR1dE5w?=
 =?utf-8?B?WGFYRFM5MVdwYU8vU21oNEtyYVVoNmtVYU9kY2NwKy9KR2pWK09LSTI5bXBG?=
 =?utf-8?B?anl0OWppVDJpTU8zdjVkZC9wQlFkclNtYlZjRU15TWVPaWtFR3ZkUWVHaGVS?=
 =?utf-8?B?T0padW1lWXpzTndHN0hsSnBXcXN6R0JTc0h2WVJpTVVBRjhkNTgvbzV6byt5?=
 =?utf-8?B?cEJaRDNLdExvdjVOT1g4cUtQczQ3bGN5K0JDZGZnUlY5bDVZNkNxS0FKek5i?=
 =?utf-8?B?YXNEbFJxa09xejlrVHpHb000aUFsdjVzM1BtVFk4aEZLY1JaR1RnUVo0WER3?=
 =?utf-8?B?K3Y3cGs5NGJGZ3U2Mi9jeXZxRmZwdk5tOWkyVWJMU3ZxQkJLMWgrSkc3WGQ1?=
 =?utf-8?B?TUswNXU3STd2ZXhaaVNMWjRTN0ptVndiZEgzY2plN3hWZkN0T25UZU9EZUNU?=
 =?utf-8?B?dWoveXRQSmJNbnZodVpnbHJzV3BQWWdVRi9tc0tmSVlWQ1JCMVpib1J5bldI?=
 =?utf-8?B?RVh0SlB0K2JzcDgvakNVYTBhbDhwRGsyRjhzRGVZQVlYSSsxZTM3K1V2UUlD?=
 =?utf-8?B?bkc1OENid2VRVDROZzIrMTVEa2d3dEpPRisrSE5Cd3NGUzh0N0lVYzg1WDll?=
 =?utf-8?B?SFBZSkdsU3dCNy9CamdiUlhWNElmUTlLSGMvRGJWakw1SDNPNW02K2hicXEw?=
 =?utf-8?Q?AqGZ8Ml2LzmLALvZ6d+wE+t+5+ic6eP1WMSKsVFnx7Gy?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37f562e-71df-4769-adb7-08dcc778cd12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:48:03.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW1qMazNmJmS1OVcCeBZ92skeErzOlfTzZg8qLv/Zp9j44beGO0HgJdYV8i6HnXMOH3epfk4BU4M5vuCeDsPZhx3TfsPBMFaYksirwAbhNN9e1WQVy/ZGQjSbBCj2qXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7983



On 8/28/2024 1:23 AM, Leo Yan wrote:
> On 8/28/2024 6:09 AM, Steve Clevenger wrote:
>>
>> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
>> the DF_1_PIE flag. This identifies position executable code.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> ---
>>  tools/perf/util/symbol-elf.c | 60 ++++++++++++++++++++++++++++++++++++
>>  tools/perf/util/symbol.h     |  1 +
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index e398abfd13a0..0e49c1345a67 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -662,6 +662,66 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>>         return err;
>>  }
>>
>> +/*
>> + * Check dynamic section DT_FLAGS_1 for a Position Independent
>> + * Executable (PIE).
>> + */
>> +bool dso__is_pie(struct dso *dso)
>> +{
>> +       Elf *elf = NULL;
>> +       Elf_Scn *scn = NULL;
>> +       GElf_Ehdr ehdr;
>> +       GElf_Shdr shdr;
>> +       bool is_pie = false;
>> +       char dso_path[PATH_MAX];
>> +       int fd = -1;
>> +
>> +       if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
>> +               goto exit;      // false
>> +
>> +       dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
>> +
>> +       fd = open(dso_path, O_RDONLY);
>> +
>> +       if (fd < 0) {
>> +               pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
>> +               goto exit;      // false
>> +       }
>> +
>> +       elf = elf_begin(fd, ELF_C_READ, NULL);
>> +       gelf_getehdr(elf, &ehdr);
>> +
>> +       if (ehdr.e_type == ET_DYN) {
>> +               Elf_Data *data;
>> +               GElf_Dyn *entry;
>> +               int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
>> +
>> +               scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
>> +               if (!scn)
>> +                       goto exit;      // false
> 
> It should goto a new tag (e.g. exit_failed) so can invoke elf_end(elf) and
> close(fd).
> 
>> +
>> +               data = (Elf_Data *) elf_getdata(scn, NULL);
>> +               if (!data || !data->d_buf)
>> +                       goto exit;      // false
> 
> Ditto.
> 
>> +
>> +               // check DT_FLAGS_1
>> +               for (int i = 0; i < n_entries; i++) {
>> +                       entry = ((GElf_Dyn *) data->d_buf) + i;
>> +                       if (entry->d_tag == DT_FLAGS_1) {
>> +                               if ((entry->d_un.d_val & DF_1_PIE) != 0) {
>> +                                       is_pie = true;
>> +                                       break;
>> +                               }
>> +                       }
>> +               } // end for
>> +       }
>> +
> 
> Put 'exit_failed' tag at here.
> 
> With the changes:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
>> +       elf_end(elf);
>> +       close(fd);
>> +exit:
>> +       return is_pie;
>> +}
>> +

Hi Leo,

It's been a long time since I've seen goto's used as a rule rather than
an exception. I see it introduced the problem you've mentioned. Is it ok
to simply update the cover letter (patch 0), and this one (patch 1) as
V5? If I don't hear from you, I'll resubmit all.

Thanks,
Steve

>>  /*
>>   * We need to check if we have a .dynsym, so that we can handle the
>>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
>> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
>> index 3fb5d146d9b1..33ea2596ce31 100644
>> --- a/tools/perf/util/symbol.h
>> +++ b/tools/perf/util/symbol.h
>> @@ -127,6 +127,7 @@ void dso__insert_symbol(struct dso *dso,
>>                         struct symbol *sym);
>>  void dso__delete_symbol(struct dso *dso,
>>                         struct symbol *sym);
>> +bool dso__is_pie(struct dso *dso);
>>
>>  struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
>>  struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
>> --
>> 2.25.1
>>

