Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2098.outbound.protection.outlook.com [40.107.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394A6AA7
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667051; cv=fail; b=VhjhHol76QsitLJSAnGL85nbKDs7uOgsU4AZUOxtdRA6GkUuqaWAxsNziELEdjG55/Q7+iydeQMcYKrKzszTI5ODD4hIcqcGrFgVg+p7vPacRzIIbMhKT0u5+gCnOVxl2OmkN/1LN/RTAPZjrTMb4M+ClgM58Crt3EQDDsuOtUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667051; c=relaxed/simple;
	bh=W87ca3/c0lQSY2gxK0Cmvih2UnCmujEyMJCgDGV0Eyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leYJfwS1eecZnj1bni93u1YztGkeXO3S+6YUsMERhidQ3BVZ0sCYQFpwhF4WPfLGEF6A3YAsDa76dyzfQhgb/XQZMDytBSB8zr5qyYOSRL/rAM5RCTIubKCPxRx56PoUMxurZbMHUfP2dQanPgKGr9e4jwWBaJ++ozDRPfRGJFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pytecQ6p; arc=fail smtp.client-ip=40.107.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pytecQ6p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw8O7kpUYL2e0MHKLoIzkjN4FEAVKjYwCXaeKB2Mjh9BfsSDDk7MYiGOiRTU/c1ZIFFGc/7NPJOhjo+3Nk33eIcOg5liPwDjj1pX7NP/k/69eXKr2oULMLKhThn53eBIzzqF9FNnINViBbjfYKWWJK7nKBRfBXM40N3f7WUucW1xz89U6MTRGl3nV7Uj6moDR59MAeGgfjWIVEnGiLl5h8tocOnHmwyzT7i4bhCn18RZmIColbVnZ8I5ukBuD10ecq5FW2/E+OCOd+tgoLKO8oEuXZSZc9NWsDAHCxnK3wNDiX6s+r+MToB2MDJwh7KCxCgYeszE6S+iWM0Gk9xCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQnNZ+I3g95NNJ4SUN9rbdBCuCteFSAu09Vh2oyqlZE=;
 b=SCewjhlV8fnlam3UapvKoWeN8+bE/uAjaulxpxLMpytWumL7BQLHfWImQGdqqSjomYnnJ61JogO/bNcFlBxWL5kSFvmbRk8jaSy++MpJmyScwQjXkEftalwRLHNwEKirTph3r0zO40uRk1sGO6evWuHhusadrrq8WmNAoTf0Mb0Z6ms6rnkpZkr2ADosnQMu5MERB/KyOqCDFfX32wiK/6hOfd481TfaDD+AhYoeObFrla8NTDZBd5X4tkR7tltgYNP48Px5QMwU+RB6RvgzQfUY6ZriKKVLTLfFyRgnpRsAk1lH0YAir8C7xpR3nhKgRqzwyk3sgsq2uPuWnWBwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQnNZ+I3g95NNJ4SUN9rbdBCuCteFSAu09Vh2oyqlZE=;
 b=pytecQ6ppqKrogunm6z3f55av7tXWgm18IWztB7r1QnCHNfEW7aKG/ck4huN07KHkASHtpBU3qo5aucXo//cAm7VRh9nwC3zandbHHskFmTOX1HtEYqT1fKCM8wX0oVdD2nubbtnI6hyruhnbBB22/NMwN4wES3dYmwzADPneCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA3PR01MB8451.prod.exchangelabs.com (2603:10b6:806:394::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 11 Oct 2024 17:17:26 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.031; Fri, 11 Oct 2024
 17:17:25 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V9 2/2] Adjust objdump start/end range per map pgoff parameter
Date: Fri, 11 Oct 2024 11:17:08 -0600
Message-Id: <6107521c4fb1d4ba2da57a6d81c17b54f259feac.1728599785.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:610:118::13) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA3PR01MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfe851c-621a-47a0-df9c-08dcea189395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG1Db1JkL2dyOTRxaTJlU09VMHgxR2xGRVR4ejVvTUJyUVA0T0IxRklydXJN?=
 =?utf-8?B?b25sc2lBeWJ2VVVnS3MrWXpQS2VCVVdQZGF1dlAwNi8wS2dMempEZ0hSOFJv?=
 =?utf-8?B?MnI0ZEhWdG8wcFlySjFDY1FqWkxiaVZxdDgyRDhLSW1TKzNGMHhORG94dWFp?=
 =?utf-8?B?VWFUYUxSbDFOSkRBYWZHdndTVWJPZnNWcDJWcGFCd3czRUJ0SXJmVG1qbFVu?=
 =?utf-8?B?WjNPa3JCZDNhcnlaWTFqM0EyUWVSb2lvU3RpNGQrSC90eW5lS0NmY2piOGN2?=
 =?utf-8?B?N3kxT05QY1pIR3FZRGJnRzdRcHFXQVRLVDBMcTRJZjBrRU8zY0QxWEMxc3B0?=
 =?utf-8?B?MEtOeWo5Z1E0ZGdRbDkrM1BHWEFTSXhiL3d4cENHT3dFZUExdHgya3hEckda?=
 =?utf-8?B?N0E0S1Y3VGc3VUs1cFRNN2ZKc2hkTDVDdWxYUTIwVG02KzdOUTdCU1VacVdJ?=
 =?utf-8?B?T1JwclNSWlVzbStBM254Y2c0TlBRQnBkYWRIbU5BZ3JjL1ZhenBLaW11QjF3?=
 =?utf-8?B?TjJtM1BRN0h0Q3ZORTZYbC9HdVprbDU1SHRMRDdiN1lPVW4zNmVucGY4eG9t?=
 =?utf-8?B?RGlrTXlJWGJTZkgxUVFtRXM0TVFzbEN4cXVXd0xRZElaQ242cVRDODF6ZW8v?=
 =?utf-8?B?MWNweW5IRHBtejNtcUV0Uk9oaWdZT0J0SmtON3BEdERFbFBoLy9yYzZnOVJK?=
 =?utf-8?B?VTlrNHVjZFdGSEpscjNXclozc1Yrd29xeWNyd3ZtYTRINWlBeXI2MmtUcGhI?=
 =?utf-8?B?QkdvWkhHNmdaZk84cnlTVzdUR3dDNi9Hby8wVUphWDB6eWowdjRscDQ1cEJ4?=
 =?utf-8?B?YUVEVzFEdDNDcjZlN2FHZzBRR2ZjNjFNMmNGazFEZmYwd3lpSU5meGQvQTYy?=
 =?utf-8?B?a0gvZEtIdHVOV3llYUpuYnRwSkdRYnVUTTN0SXNtek80OUxScGszNkswY0tr?=
 =?utf-8?B?bmNxQ1g0MnNMQ2FJNjJxTWcwc1hxZGd6MFpyenErT0RZcTI2M3hYdUhSa1pI?=
 =?utf-8?B?aXFVZlBoTUhSWForMXhLN3RHT0hoYUhSZUdOMGh0VUZrRFh3N3FXbnFVa0JL?=
 =?utf-8?B?SFNNeUhMaURJZFRSQWN6cVNpeUIxcmthdm9nQ0dqdVZFRzViWkxBVE9SOWR3?=
 =?utf-8?B?Qk5tWmJzaVVlMmtaRjlBMDlUcDBZcTZScHM4c0lPNlQwN29mOVRiVVN6eXhE?=
 =?utf-8?B?OXlBWEVpcTNzcUVocHdhVGhBcFNyTG05QWJqRHBQVk92eWxVSmNmMVMyVjhh?=
 =?utf-8?B?Mm1wNXJyZ0xUTmhkSTNIK1V4aWxMS0FHSEJwcUsxL0NJeDBiL1ZtVVZjMmN3?=
 =?utf-8?B?cUFmUG5qTVMzbWlENktXOUFyZGNteWtBOWN6Y0I2VDRwaFREOE1hVFo1TWlU?=
 =?utf-8?B?dy9uSWZtVDFWb0dKSElSTXpIS1RXZjllRHEyek5pbytlRC9PSGlvZklVSC9a?=
 =?utf-8?B?QksrUUVXYzJreFBEWHlHU2VjRU9nV0Q5OGxGNzFPMFNnd1g1Rkp4ODNUTWNN?=
 =?utf-8?B?RTcwUUtqM2g2SE9xQ1NMVFJIZi9iN3dZU0lzUGZOUmNTUFBtOEwxNWtuMG5J?=
 =?utf-8?B?d2ZhZjVWSy9LNnhzTk85d0ZRYWZqMUhMNUdqdWNpeGNTWG85WjJxRzJPM2tY?=
 =?utf-8?B?cWplOHVNcThDMTdLTnpNQmUxQytPQ0hqM0ZoSGhCYUFyV0RZN2RSZXl3RWl4?=
 =?utf-8?B?VXV6bk1aRktkRXhLc1BEZmdxd0pBVEVTWjl0WmY3NzdjWFREMXdFdW5zN1Bz?=
 =?utf-8?B?N3hFQStrclE5a3BLZHdIbVlEN2pPWnZKN3VGVkx0WldVMXV3LzhyREJ6cnlM?=
 =?utf-8?B?T3hGTUoyT2VwRTV1NzV5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3FnWWk3b2pXMi92K1V5a0ZtOHJad1Q3U0ZDeGsyaWxPTTQwZFFVQnZBQXNt?=
 =?utf-8?B?YnNMRFJncUo3cDhlT2pmWkdsUFpKUmUzWTlpNXVGaEFncFErb2ZzRXczYTlL?=
 =?utf-8?B?ZHhKMC9pMC9LU2VvYTk4Nzg0VUw3cFZHVXljT2tKUmRsd3RZTFlWQytGQlNW?=
 =?utf-8?B?dXoraGZid2FvbENuUG9lcmxGRWc5MEM0SHJZZmgrakVqTjIyWm0yNXlIc3pE?=
 =?utf-8?B?NExISndSd1UvclVXcWRISFJ6VW9qaGRqU0xUSzhDbUVCdHBLMnoyRGN1U2Yy?=
 =?utf-8?B?VWFqZzJLRDZpSVRNRjJsRFYrWUhQVWpNYlJLZVBxVkxtYWpFYmhJUGZvKzhn?=
 =?utf-8?B?QTlmZzNyV2RpQWVtU1IxL2RSa21QL25Jd3p1Zkx4SVNOMDRaOEp1YWFEaWho?=
 =?utf-8?B?MkgrdDZvU3IzdDlibTBEU1JyNnhxQktobWwrdVIxVEY2TkhaWFRQd0cvdWxH?=
 =?utf-8?B?a2lqQ3AzOFI4T0VEa1ZjT3VlWEZXNXRqTVFSNitVNkJBTEpCcDFRbHFmSXph?=
 =?utf-8?B?QWttdVIwQTlvSk1WcHIrNk8wRjhxN3hHMERROWFyZHZoemRjWXlOV05IQXBJ?=
 =?utf-8?B?eGlSdTRZUWxkUVpvcXdDMG5JaGpscTdmeEdYQWhXR05OeUJKVGFTN2VhKzdK?=
 =?utf-8?B?NVVHQVF6UmZMckozWGJ4NzI0LzBsY09NaDNaUE56ZUUxeWNvcEZuV1Z0blhQ?=
 =?utf-8?B?NnpzRGxObEFsUVJDYXdiQWZLOGlRSHdscFJlaW9QdlcwZjRsbU91ZmVWWmF5?=
 =?utf-8?B?NHUxVWJzekIzck0ranpLOS9Pd0ZGL0R0dzZLSDlvSktIeDNVODhMalRYNmwx?=
 =?utf-8?B?RXJyRjNXQVdqMmFhb3pqU0pHS2Nkdzg5dWMxZjlSQVJwMnpCYmF0OXZOK2lP?=
 =?utf-8?B?UlNac2J4bFU2SmRCRzBKaDRuQUc0S3E1ZVRLVHpBV1FQd1c3QWN3WkRQdjIz?=
 =?utf-8?B?Qm1zenl5dWQrNWNWeDlaVksxcDZ1TGZXVXRXMWg0SHBNNUNLbG5oZGlkdlNO?=
 =?utf-8?B?RzU1eFlZbExvVVBCWlhYa2VETXlvS1pWRm5EMVQ1MVNCUXZ4NFoyNXYzRWpr?=
 =?utf-8?B?TW5hbmdlT3diZU1JMXd3TW9vSUhvMzdRclo0cHR6L3VLSmRXbkFrVGFHOUFs?=
 =?utf-8?B?TEp1WU9WWEExZloyZGVkQTJLTjdBQ0lTaVpHRmY0VGxNVDBNcWh1RW56dUF3?=
 =?utf-8?B?M0dWZEUyZU8wRFo1SU1PNFFhelBrdnE2TlJENFBUNjFhelI2dllmaGNYbU1i?=
 =?utf-8?B?dWNCbm0vVXVCWnAyRmdrbHhJVzFMZmpLYnE5bEpTL2JHamtXcUNTRVpLMk8r?=
 =?utf-8?B?Nk1WN0VhcHcrMVNVNjhTdWpyYnpNYk1wZE1ZdWlONmVVMUJjWlYzQnBzTFhE?=
 =?utf-8?B?Si9sNEgyUW41enhzL2JrclB0OUNteVplVHhodElrZ0g1WVhUSG5OQktXa1ZY?=
 =?utf-8?B?WHNsTTQyZUV6UmF3UGJTWW91bmpqanE0TEVNbHE4SStsTG5WSlhWdTIxckxy?=
 =?utf-8?B?VWJVSC9Xby9PV1F0V0VDeUdPWFRUMUtDOWVTRUFERlVQQWZicGMzODJoYnBt?=
 =?utf-8?B?Yys5U0hJRGZ3K3A2SHU4QXFyeGpZKzg3ZWZmZ09Hd3dIaEgwVzVEbWswZzJB?=
 =?utf-8?B?OSt3ZVlBVGdxbUdzbkdsTmtjWG5oN3h5cDlQemVLWVQ3NlcyWHZWTnNBTzlF?=
 =?utf-8?B?djVsait5ckVpajJDc0hKL0tmNjlmVTVNeFprQVZVUjNlV0hHOHRSVENmcHRH?=
 =?utf-8?B?c284eFlZSlF1TWNhYS93TllwTmZWbmM1c09OSStMUjN4L3p2ZS9YRm00M0xt?=
 =?utf-8?B?S0JwUFdRcVVuUXEveExBc3hGcytIcVFnL3lrNWxJaENOT3diUys0ZGdTRDVR?=
 =?utf-8?B?R1h4ZUpoeDF3bmpKQ0o5MWdGMENWR21JYXg2dWFnT3BUZllZMi93amQ3QmJa?=
 =?utf-8?B?SnUrcFNXQUFrMkRyN2RoNW1qb2t1NWR4K0ZKd002eVpIQW5hYmdiNy9YbFRn?=
 =?utf-8?B?T2pJY2NmU2g0R0ZYSjdRUllsV0M4QlhzNnZTN3VBZkd6WW5vclpISEZjM0sv?=
 =?utf-8?B?dWhGdkNkS0lXTWs4RUtMNWNldFZaaC9KVUNSUlUyd3hwbktNbDRKMk1VZ3l5?=
 =?utf-8?B?VGExSms1L3NzVUhFMlp3elczUkx3QndVVVdKUHdvR2JEV0hmTUpkYUM2Ny9Z?=
 =?utf-8?Q?VCi/fNDckjUAY2aAqCQK+o0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfe851c-621a-47a0-df9c-08dcea189395
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:17:25.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9tJIim4by3XtK7sjouVZg8djayfsNYeXQZNWRBak8GSoZqNR65JYx6eBYWnFxzdSuB0fN6GAstxiHaeoIVa3B6jn5tfg9e/QBZa5EpA/KrRh/fhW71PN2+kHoO/DgWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8451

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

A zero start_addr is filtered to prevent output of dso address range
check failures. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..e29a4035723c 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,10 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
+	# check for valid map offset
+	if (str(map_pgoff) == '[unknown]'):
+	 	map_pgoff = 0
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -243,9 +247,10 @@ def process_event(param_dict):
 	# Record for previous sample packet
 	cpu_data[str(cpu) + 'addr'] = addr
 
-	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
-	if (start_addr == 0 and stop_addr == 4):
-		print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
+	# Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
+	if (start_addr == 0):
+		if ((stop_addr == 4) and (options.verbose == True)):
+			print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
@@ -262,13 +267,14 @@ def process_event(param_dict):
 		# vm_start to zero.
 		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
 			dso_vm_start = 0
+			map_pgoff = 0
 		else:
 			dso_vm_start = int(dso_start)
 
 		dso_fname = get_dso_file_path(dso, dso_bid)
 		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
 		else:
-			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
+			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
 
 	print_srccode(comm, param_dict, sample, symbol, dso)
-- 
2.44.0

