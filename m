Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021126.outbound.protection.outlook.com [52.101.57.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887A33CF1
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725131972; cv=fail; b=l+5W5ViuFvzUPS9oNFhpgHPTDwIoOW62bObRLiGtTQNAC5X0oPJEZLXq3O3jQh/e1FMBqMsioMS/guQO0WPHF9Xl8oS84LWmJGOZflGuQZLrSheIy/auvDWl3bWtjVWRmSwQxhG4e+0r9NG30GIEpSvImEYI0Aq228zm/wCEOhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725131972; c=relaxed/simple;
	bh=5qmApuUEf3BgAqE4CPXEllbekxRNr2IYTgq+REjU9No=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jX6yi1U2iBoRIorgHrdoHFsZwtUW9X6Yz9qugsOUs4ufSNBE2I64J5cu/hZwyZfE4BF5/UfkbynHBNzaUc0PwQqu1N2s/l4b5Mu4Y9N1vwo2grpmEsfKa5MlU5BZDx1H3bYGVvPDiVrHY3VukipxZt+ZyGt2r+L93axKGCXpL1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nd7HMX+s; arc=fail smtp.client-ip=52.101.57.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nd7HMX+s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xja6i3QW1WYx37greRLP72IQ3oxPjETgoLfbWwCodfWJCs5L4PyEfNgYtb3qq4sdxHWl/OnDZE4ibI/Rh/M4x0a1p2WNFomMyVlT37F9rJESplk0w64VZAquuAXUeSLgupdSBOsQBfU9ht7qKDHc+6GE0t5USmYf5/uPpg4Fe4vn7YAju5BIVU3gYqHq2r8qhd/wvgJoWF50Is121nnNamMegqSyusGhleUOgqpHDtLcGmYdkqKsScVvlZQg5QPGo/GihF0S9RJ6yUrJs+2XFz87UHVkZRSHpsCdYxh1gMbEOutNYUMOFRPokURMh76A1T2ho7g+Ak9KH6k5myKCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez+RwYNPS30WEFml/uh5Gy9GyBWehMKRqNCcAwwBk3k=;
 b=akcs2OEq7YsdCUdT7P8xOiWRBcNWJZbciuuVNsJzTOYfCtZ50MeFIH7RCyrX65zDhOnT3Xi9rZK95ZKeWeyQRKtEI2pPuFqMwH8gkRa3it/DEgAfPwfSToEWUGEuYMlTmgIP+tbADV/ffFxcPpYLdixwFgSpj9xLVT8sGJhsQRBoBKu/jfjckSYu9XPaCSgQn4+PmVj6BjTbSOaScBNHyJ75W7s7dcCllKaXbrmpbPPEh7dvyEEzAcOqGLthuYPBvYADvaUUDXQKHET19tXhlpLQ2is2WGOUZ5TE6Pjhvz8TcKjhYpmlmFYrwsHpR4Ibd6BUr7fkn8N7jNFOMuWQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez+RwYNPS30WEFml/uh5Gy9GyBWehMKRqNCcAwwBk3k=;
 b=nd7HMX+skZ5nmCvtz7ZbZrNidPcZfNcEft8wgzNtZkK/5wclSVBW91FA5AE0hgM7dnkrLtqhGfgIPcvJGeAY6zjyf58lOnSsYHRI6TCllP/OTcnZiqH14qK+Tb52M+qgrHZxjmuRhExfFMgCgpmpLeWubvTj8IOGmovTsuHMZaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MW6PR01MB8341.prod.exchangelabs.com (2603:10b6:303:239::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sat, 31 Aug 2024 19:19:13 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 19:19:13 +0000
Message-ID: <7a2c53c0-0bac-4a53-824d-6efdff8ed3ce@os.amperecomputing.com>
Date: Sat, 31 Aug 2024 12:19:09 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V5 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <35c19a0f-580a-4d97-b0d4-b8708a4dbdb4@arm.com>
 <01419593-056b-41e9-a3d2-6ac490f7734a@os.amperecomputing.com>
 <9822c444-69d6-436d-b1dd-6d9c910678ee@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <9822c444-69d6-436d-b1dd-6d9c910678ee@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|MW6PR01MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: d877deeb-3b7a-4b64-712d-08dcc9f1cc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MENtSzRFZnNTdmMyamVEUmNSVXJ0OFhzQlZSZnZ0R1BiZVBtbzF6eUxyWml0?=
 =?utf-8?B?Q0pVUVBRUWlzbjd2c3BEODlBQ2ZXV2plZXJDS3BqSUhzNnUxQU1uOGc1Qkp0?=
 =?utf-8?B?K0tvMVJsa3dqUTRUdjAyOXBqNDZiN0pMRzZmV21JZXJMbDB1ZlJyUnp4Qkwy?=
 =?utf-8?B?Rk9yNHl0UXMyTFZnbFV2ZXdOUmlTL1hkbHhxanoxeWk0WCtWRlNGeGxuZjhp?=
 =?utf-8?B?eFMzV3BQcXh0aWlTNWZsUUNsK09RQVBLd2Y0Q0IrNVl1ZURjK0ZRTlNkY1RE?=
 =?utf-8?B?WkJzODR0QVA2bzNhYzFLdktPdkhLK0VuOE5UMHVldEpkcnV4LzREa2dJa1ds?=
 =?utf-8?B?c2hwK3hhZWVNODM0b0lDbWFySDdzdWFFQ2RIZVJlVVVOYTk0dXA0a2JHTEpK?=
 =?utf-8?B?cHF6Y21heUtDRUVZZXdKUnNIYkx6WHpFUUw4cWpFYmpFZUJPNjNaRS9OalRL?=
 =?utf-8?B?Y0hsYTlubzZwc2xLUDNzK29DTmdFeS9PdXhTOW93ZkgydHFFSUlQbkUxV3Jp?=
 =?utf-8?B?NmZ2bExpTmhMdi9pTytadlA4UCtXanFtb1kwWGxScFRqVEZ6R3ZqalplNE1w?=
 =?utf-8?B?RDZob3lOTUhzSXJkUFRjbklIa0RRQk5nUlZFYXJLb1B3ZWx6cmVzWnZ6U3RI?=
 =?utf-8?B?TUU1clZZdnI3MUlkTUZ2dDRCMnYxZUVCamtrQWlqQTlDSWR4bThYUE14RE42?=
 =?utf-8?B?cVB2RlUzdjJmOE5Ob2FQVDg2cmZUQTBBdHlIQlUyTUQ2MU5Sb1ZaZ0JTSjVw?=
 =?utf-8?B?Tk9mZUx6VkozKzV4VFM0U2kwRkhBTjV1dnB6d2pTM1FtbDNSTzJvYm9PQUF2?=
 =?utf-8?B?aGtHU2hGM3FsNGZQZk9yTkhKNi9YY0JKZVJ6N0lsejF6SW1WTTQxR29Dakxp?=
 =?utf-8?B?dENKNkJGMExYWmdrNStRZzRyQ2NteXQ3YitrSHRlbnlmcTljWmZLUDJmTHZJ?=
 =?utf-8?B?RWVYbVpOVzBDL0NnRitvdFo4aERia3NTM2pVSjU1UHZlQ1pqSlhFdVhHajFr?=
 =?utf-8?B?dG5iZURpcnE4R0ZHMW1XRTFnSFU0UmdRK2lHUTZDUE1PY2RJQ3N5bEhZOThG?=
 =?utf-8?B?UElwc3RxS0NKemRxQWw5MTArY1JId3lBdHhwalZsU2hWMFRKM0psOVVjd3RT?=
 =?utf-8?B?d0NETVl4eFVKRGFIOWVRWkFDVEdTMDB6WXdnL2o4ZEk5Q2YydGhiM3N5cFc0?=
 =?utf-8?B?NmxvL0N0b3NIMjhIaFFIbkxGVzYyWnZlcEh6SzJMcWFoUS9UZnlVbDFLNFRO?=
 =?utf-8?B?dUwwS1lkTFRxcTE5NzJBb05xWDdhWG9pemVEemZGMWVyTUljUU5kVHZNd0lx?=
 =?utf-8?B?RE1BM1BrVWtDc0UxaDlNL2k4SWlzb0pEbkI0MlZBclNSUnJoNWZROXVjMFRY?=
 =?utf-8?B?LzFTTG14MjNWZ0JyQ1NROFloUm1TYW16K21YbThidHBIYzg2V0pTTHhyK0lD?=
 =?utf-8?B?V21PcjRuTXVpWjBMeG9sblRveTNYblF5bXZRS3g5VFNCa3hIL2JtTERSM2l0?=
 =?utf-8?B?Y0JERG9wbUFHN0ZudWpOZHIvT3UxWGtwNXl5ZVlwY0NscnFGc3B6UzhiRWtn?=
 =?utf-8?B?WEptdGdDd1JhK1Izc1dNNmJhZTFGZFprVEg0VjdjYXpZQUZqMUZUYTZOazhn?=
 =?utf-8?B?K1B4TkZ0Q3A3RVpPUkNOTzdEckpFb1IyMDZnaUh4M2NlNm8xQU5lbkdlZHZF?=
 =?utf-8?B?aTFOcFl2eGNWcW1JQmlsdmdUeVB1OU9QbTlHYlNVUmR5eG5nOWd3alVlVW11?=
 =?utf-8?Q?u/FmvjVKGjwu5tqF+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emdaN053UVZneDRudkNlRGlCSFQ4dlJkS2Evai9hK0RVQXBRYmNDT0NJdnJj?=
 =?utf-8?B?cGp4SXo1WWdINjE4blY4SjNnSjB5R1RNQU5vQlFER2dIUGg5SFpnZm9QKzJm?=
 =?utf-8?B?Sm4vamxGNTFEbElzUURBdXFUV3RHWmFTd2VQSmk1a2hiS0lFbnhIMjVKeFEr?=
 =?utf-8?B?UUpNdTZvWURxZ2ZuMWpWT0dYUGhoT1JaWmhnTDl5YnA5S0ExRm1ndUNnd0lQ?=
 =?utf-8?B?a3NlQWhjaGdHOExac0hYeDB4MEhUNlkzdzJVbnRwcGV6c0lKdVVDT1AyNlM0?=
 =?utf-8?B?VGVQUWdjK1ZmN0xFendsT0dMTkNDS0xxeDdFN0hMYysyc0hyNGluNDByTXpL?=
 =?utf-8?B?emdsbVR0MmVDako4TWdhVnd6UDgwSndCR1VWZHpScnB3bFZXeFJPZEJjZGNy?=
 =?utf-8?B?dndUSWdYcHJTa2U3UjJNRkJ2RXVPQ2J4YWVkYWEwTXpwV1BKUEthZTFYR1BT?=
 =?utf-8?B?alNsZ2txbzVnR3R0MzRpM0dzOXkraVlDd0hHVVVBdk5obXlhZWdZSjNzdmhm?=
 =?utf-8?B?U2M0N2s0bWFrQ24zaGs2Vy9HWGU5Z0lIc09Zd0tvWHNOeG9UTTlhTWhWWGRU?=
 =?utf-8?B?MHRqT29BR20xeEhzN1czcmZmcDVmZ1B3S0EyN09idEZ1QnRrM0UrYmRTeFJL?=
 =?utf-8?B?emk0TzBWOHBBVGtGMFF4THp1bFpEUnBVZjNLZWxBRFRLQjF2M1hlUlZKcEli?=
 =?utf-8?B?clB1QnVoUFcrQ2xNeXBvWmRLMnBEM044eHM5RFkxWE1DYjBJWWFIZm1VV01X?=
 =?utf-8?B?REpSRDR5aHk0eUw3eTRxZ2l6eU8ydnY4QVh2S3FZbGxZeEN6bVV0NUhTZSsz?=
 =?utf-8?B?LzduQ3VPSC9lMnF4WjZBYm40WnByT3BJWWFnRUwwczJOTUIvZGw4S1FPS2V5?=
 =?utf-8?B?TG8rV0R0RGVaNUhoaE5WOFJwaDlyUHBlT0wwNjZtTUhrQ0JoZElnby95bTYy?=
 =?utf-8?B?Y1RIb0VnRHZ4cG8zZW5QNUJmWTRUY0pqMEQvSXo4dUlsZTJ2a2xGSXJPSExT?=
 =?utf-8?B?L0o2WlppbGU1WVVMaHF3UndkQjhITEkrWHY0TmRUSlNLRVNuTTB0ZzdkS2JU?=
 =?utf-8?B?QkRJRTBLZGVNVGFkOE4vdnJiRmZtZGRmbUZ4ejJhZzNVWm45Rzl5SEtpMkJ2?=
 =?utf-8?B?MzhkcEE0MEUybDJrNCs2QUtKOVBvMUc2MElaMW5rR0F0aUFlc3ZFNlFpV0ly?=
 =?utf-8?B?TDZJa1o2TzRKN002bU91bVdlZkJoNzFsK1diWDRCZDJnK2lvZHhBM3hKek5o?=
 =?utf-8?B?TmxLV3BqR042bFFkMXoxWnJ3WEVJU21hRzBzb205RUYzc1pMSXRQRi9ZYjVr?=
 =?utf-8?B?RHJrelpoSTNHamRwQ3NHN3pxYk5ycWhJSkpjM0RndWZaZ3RZaDBDcTdmNDR1?=
 =?utf-8?B?R3JITmpOcnFtQ1NqaTBwb2ZrNWltT2VTL0FMdEQ1bVlXdW9XalJRUFJaekpq?=
 =?utf-8?B?eUptZGdKZHdkemJvVUFlMUhvQlA3Vi83T1VGTXplTWM3akpOdnh3R0JlWjR2?=
 =?utf-8?B?ZVp0Vmtsc2ExdHl3RDZUMGF1emo5UjQwM0pyV3RGcXRUQTExR0hRNHNqNHB3?=
 =?utf-8?B?MXB5Z3c2VlFrZlVtalRZOU5KMW02cUU0VU9jVjJXdldnVUJtaWM0NHZNUE5H?=
 =?utf-8?B?WkoycnM2anpmOTBkMFhJalpwQlZkbmljUHAvOG5ubi9RN3FEMDBWMkFKZ3pu?=
 =?utf-8?B?c0w0ajlxdDZFaHkzZHgxWnFLZFE0UUlkZUw4NmNlYXgrTlk1bXI0djBQUXRF?=
 =?utf-8?B?R1huOGJMc3prQTUrNlhPdzZOOG1waEkrbEFLYlJITHVUZ0hkV0Z4TE9Ja295?=
 =?utf-8?B?QUdnOER3NWhpSWF5eEZER01XbUV2M2pOWkFDVFFMWmw0TlN4Q1EwWjVOZW9R?=
 =?utf-8?B?OTV6VEtPRXFRM0Q5cFlaQ1Y2TFl4enc0NzhEbEtVM2pwMmp1OVZaZGpoTFJF?=
 =?utf-8?B?N0U1bU9lYm0vb1Z4dDB4OUdlaTVwaE5Wdnl1emRJQ3ZSL0R4V0p6NllyK29H?=
 =?utf-8?B?NHAzVE9kMTlpRnFYalgxeG95VjdZeWxlSEhiMVZPVys2aFdEcllnSjZIUkhF?=
 =?utf-8?B?bmYrZkxSaGl1RDN2YTRFdE5zTTJOSHpGVTNWM294K0s2NFd2dEZ3ODFZQkdx?=
 =?utf-8?B?eEk0cmRmbDZKdGFkZTM5MFRWaTI1YlR6TnNJcW0wV0hWb1lNaHV2cnQ4T0p2?=
 =?utf-8?Q?ciz9Ob0j8ECCW8sqFTX1TXt+nr6kyf42KSOIyLEj4GPg?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d877deeb-3b7a-4b64-712d-08dcc9f1cc2c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 19:19:13.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bpgk05wEcFweDyOVKUNbGbm4eu0uWRTtArhksw8nGTiZFf+rCmo9hQLago8HvHaXTUAZ/gUbmrYsow9k6zdeLmYB1z4wiHLGRLKTGVTN21KSa5XGN6sTKmdOHLc+Mh8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8341



On 8/30/2024 12:20 AM, Leo Yan wrote:
> On 8/29/24 18:39, Steve Clevenger wrote:>
>> On 8/29/2024 12:55 AM, Leo Yan wrote:
>>> On 8/29/2024 12:17 AM, Steve Clevenger wrote:
>>>>
>>>> Changes in V5:
>>>>    - In symbol-elf.c, branch to exit_close label if open file.
>>>>    - In trace_event_python.c, correct indentation. set_sym_in_dict
>>>>      call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>>>>      match local naming.
>>>
>>> For the series:
>>>
>>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>>
>>> Hi Steve,
>>>
>>> Later when you respin a new version patches, it is better to amend
>>> the review
>>> and ACK tags you have received. (Just remind, b4 is your friend for
>>> helping do
>>> these things).
>>>
>>> Thanks,
>>> Leo
>>
>> Got it. Thanks, Leo. By the way, I noticed when I rebased to
>> perf-tools-next the kernel version was 6.11-rc3. Is there any chance
>> this patch gets into 6.11?
> 
> Linus' master branch now is 6.11-rc5, it is not far away from the 6.11.
> 
> I think we still have much chance to get it done before it. Added
> maintainers
> in case any missing.
> 
> Thanks,
> Leo

Hi Leo,

That's great. Unfortuantely, I need to submit a V6 for patch 4/4, which
is the arm-cs-trace-disasm.py script. Kernel instruction trace requires
zeroing map_pgoff. perf makes most offset decisions, but this one is in
the script. It's a one liner.

I know you're a b4 fan, but I've never used it. If I'm able to make
progress with it I'll use it to resubmit. Otherwise more of the same.

Steve

Steve

