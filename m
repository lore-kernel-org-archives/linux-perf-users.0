Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2106.outbound.protection.outlook.com [40.107.92.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA31C1F05
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093099; cv=fail; b=au96suZ3JWxBvk13o+sK3+7wDftmcmRY74zezfFP56n31HbQuAw1rb/ppf9LfDgK29rb94Voms+bLNFrgg4aG1llJTnh/p4osDPa3XQixpNCLCTl0PaXgqXGwZCy/0XLteOFvY6bXw3CLYEo/htNvk3FmyCNoxsg2Uj6uA+0x7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093099; c=relaxed/simple;
	bh=VYuptKM8LntPyImiZH19TTMPYez/e/yvElLIfcBxL7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifNCEPOMtNLt2851csiJSJVzLVgNsTh7P9zcdnsdees5Sv86ndELTRTqNQefDLvAhHiEGYGzTHjdVz0G6Cr0FmR4ROrPCz8i8HRZmtKWzbeFYLUsK1qeml/WWSHAeDUFSgbKOspAnIEDQDHOiWNiYPFO17GfXibvJMudxbZ5vs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u9n3T1kc; arc=fail smtp.client-ip=40.107.92.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u9n3T1kc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Olg1NCjfJJnErTC5Q+0d+bFHUXUrX4ONb9y7GzvS+AqSw/qqVSZJYhMNjVUs0MNxkAP7EXIHrepthhqBuwpzzA9lGuKTUbu9fjgoS7XaPvu6gXEv4QlSlHkojsRp1TKa9wm18ZHthLJG+41keD+3DsWiociIMPtAq7piHwzInVK/5e+vU9917NarVulbctKmH+13jIvSlG/5ZBPHm4b878EWcC6B+JsU/DpR+ULcLWjm278oGOvGw3ftJm/NGfJwCTCXJszZVRQCHG0w8G8C4OJYXPmgN9Tg3y1eqo6t3mzc5xCOHkQqrXf5zt1sJP7hbOKNjl1YUjn77eZ1aXdDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOO1qVYCues0e8+cZFU+gLopZinUMHkaTDINMMJjlRQ=;
 b=X6VP1sLu32trx6D7bKzMNe3XvwnQqCJL5Tf1/b0fS3t+LYN70UlL18NOVvHjVKkm5MiVKvpt2VOWoRJ2RzhnPZU+ipBc+DBwuyYnHPObaGCN4JDb9lFJp/xcs05rlYFWHpAyLDk7CayNJuMsB0opBOU4YfWU7q2ccPHs7zXD+5NFK8Prmd/W4206fDVgHJI51BRMISrygqTn/0iAxYOH1wFbQB4f1/bzSfZEuBGafK0CSOm3gVu4vmGhjLoswKVAkXwzAb7uXnEsAaaQevIbTaz/Xwh1/bUiDrXxoYVPx29RS7VOKvRWZjU8wqNaw4r0L0eFcyFABqCYFLJI4uqVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOO1qVYCues0e8+cZFU+gLopZinUMHkaTDINMMJjlRQ=;
 b=u9n3T1kcFK2/dcuc4VD7PMHE0CJ4Uf7ar11rHGmOEMmR+JhSgZh3sDFKIynl6ZLdWKAe/8qBz+OA2LalG5HK7uAO1oUhOrNi0QjZf7bdPw5GeDaIktvEEI3sGocyIglMwKjgqX2O/eIuRWbB7e/zyHnDjA8PVIlM4+z+G9D03Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 BY1PR01MB9089.prod.exchangelabs.com (2603:10b6:a03:5b5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.11; Fri, 8 Nov 2024 19:11:33 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8158.007; Fri, 8 Nov 2024
 19:11:33 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	namhyung@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V11 2/2] perf script python: Adjust objdump start/end per map pgoff parameter
Date: Fri,  8 Nov 2024 12:11:17 -0700
Message-Id: <21ccdd22e664bdeccb878672d4b2c0518873c1e5.1731027120.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
References: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::14) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|BY1PR01MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0edd92-bed4-4ba4-f316-08dd0029289a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW5EYmhSNXBFTXFPVmphSFJCeW9nM21qY2NMOVdxUW1QZTJwcGRDSGEwM2Rn?=
 =?utf-8?B?bGhWOHlyK21rbU9UWUw4WVBMdEtqMDhjakpTOUlpUWh6QmhadjZ6WENVWHcr?=
 =?utf-8?B?L0NuVTExSkV6cEZoU05qemVUV1NJdjhXUWdHV1RjOVViN0RuZHBtTXprT0NU?=
 =?utf-8?B?REdIc3hQQVJvcGZIMlI1dCtvWFExZ3E3d2s3c3F4cWNJblc5b2huS2Z1Sy9z?=
 =?utf-8?B?V0tFbkpLRGJzZllMd1l5UG5oVWFhNnp5V1lSaU00dGg1cjI1V0NMamdQS010?=
 =?utf-8?B?aFNUYTdHQ0FZK1I3VVpORUx5OWNRSkJxT1BSanBFTEluTHNBRUZ0bGpjZFZT?=
 =?utf-8?B?d2xoeFh4T1FGMWpmb3NwODJRRWk4bU85OG1oV0Z6TU5FK3FnN0lMQnFaRTc0?=
 =?utf-8?B?bDJ6Sk0xVmF6a0NWNXRncStMQ3F4bHN1VnJuS0Y4NFd0amVKK0JValE5Qnc2?=
 =?utf-8?B?UlVCRGZPdjJOY1BNR1RnRE9jU0hyWGQ5Z2hJVVE5d0plMGFwNHdpNy9pZVJm?=
 =?utf-8?B?SnRYVDg0MlFrdWlZdTVaK1ZPclkrK1FLSnZVMmNpaFFGWXlyeWdla29EdUdM?=
 =?utf-8?B?Vm5QQnhhME5LS3FSSVorZHppMjJmMnJ2MDAyc2VjRWZ4NmIrYyswWDh4bXo0?=
 =?utf-8?B?NVp4VE5DVElIZWdsOGxyaUVTclZxaFlkS3J3bzM1MUpVUlZ5bEhxZmdsWkI4?=
 =?utf-8?B?MnVjVmlHWmExdEs2Mlp6bG5Bd2hqTzVURnJIOHpqZHNMSzJNblRWUkk5RWxF?=
 =?utf-8?B?b0V0WVNmeExUK3AyMndYb2pVMGQrNm03RVVqVkJMODVwVXdmaFpXM0hWUVpH?=
 =?utf-8?B?SW9vRmcyakI4TmpVcE1xQnYyZEFQTll0cm9Uakkxbm5mVi8xelhVS1d6cTds?=
 =?utf-8?B?Slg0RnhzSzE0U1R3SXpDdmw3QUQ5cmMxNzh6QVRIZzNzZUI1RitLVXRqZUp3?=
 =?utf-8?B?eEJEZm5JUU4zTXp6STVyQ1lHdjRtWE1CeGxjZmo0cGNlL1JXa2ZGZ1hMTHVI?=
 =?utf-8?B?RkxGd0F4QUJOM05UMDJ3YXhVMjVMb29hWitwdUZaTWEzRStXdXpweGdrdCty?=
 =?utf-8?B?ZS9wWHZpcUI5anhWV1lJaHBrajk2NnVLQ0prQlhNOUJPOVJzLzRhMmp0ZU5s?=
 =?utf-8?B?UjRDbjdNejVOLzZtbitoNlhOelV6YTRNMXZKQ1kyR0VUSHFPdEt6L05wb09q?=
 =?utf-8?B?Z2lZRndMUk0xTTFMd293QVFENXk3TEUzVmI4MGcvOW5CSWJFdVNpVWY1MTlV?=
 =?utf-8?B?M01BalFKbFpPNWYraVRNcGVFOEQ1TEliRzBHblZVR211bFJSWEMyNWI1ZE15?=
 =?utf-8?B?cm1BSnowbWVPdzN1OVpvSEQrckIwWXdCWDc1aHV6MDhWVGVkbFNDWjlmSlJG?=
 =?utf-8?B?MWhyVEFWZEpUb3grSWpSNGxzc1VZVjRWVzVSSFU0UHJwVnFCOTZwaWhQNlc1?=
 =?utf-8?B?T2hxRVhEMnBKWDkwTFFyQUJYbFBlSHU0NDFrS3BCdmtlYWN6M3YvZnZnUHB1?=
 =?utf-8?B?VVJDdmU2Wkpjd2p0TXlkVTFOV1hLK2NwU2MvNDhZTUd3bEMyR2FnNlRYcnQz?=
 =?utf-8?B?eTdxMGpnbmYweExHVGVxNU9FemZPUHRQeERhVHcyMGFjVU9WTDlXaFNlUkRS?=
 =?utf-8?B?UjJmN3BkYytZbkE1RzR5TXJBNjlsSkpKMnpZR0JtVnF6aSt3c0Y3VkNkQVl5?=
 =?utf-8?B?QTg0ODI5eVpyVlBsRWJnWmlRSitlNlZQQlVZUmRjanBualFuN0tITm8rdFJh?=
 =?utf-8?B?MFdUU2h5elV3MjBJREJqZzRXTS8vSXJOQ3RGREtzbUJWYy9LTzgxWi8vMUVB?=
 =?utf-8?Q?VGWjHYtUPzAM/vcjepIhWBvn18pUBiYjYbkVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE9QTGFGKyt2L0g1K1BLTXNaR2pTZEVQQVhnaWV4R3F3Q3UycWxNNG0xa3o5?=
 =?utf-8?B?RDFRNkNaRGhiUnRIb0ZONHJoeXZ6ZUd5MVpRRkUrV1VMNjlySjlqdGJ4Nm05?=
 =?utf-8?B?blRlSURYYmlMYStzUlJtWm5Cckx2bjc4cUt2Z2V3c3diR2NZa2JHQUUyVzRr?=
 =?utf-8?B?L3VaN05iK1h1NEF4OEdZMDU2NmF2QnM2cDV5Q01hZjRycVR1NGxwRnNPcGFF?=
 =?utf-8?B?djVranE3OE4ycjJaTEhobXJQRzh0QkJORklUck13LzcwSDEva1B1Z21rdjh6?=
 =?utf-8?B?bmk1NEhZdlJVeHZYVE00emc0WkZVNDhmU0l1aEhCNzN1N1Vra3BkVzdEalFG?=
 =?utf-8?B?WlU5NjFxSHFPbzJiaVZzdzFHRk9vUy9JNEN2SzhuOC9MdVRoWjgrcXQ0Vm9L?=
 =?utf-8?B?dWFvTWhoODlId1dxVjR4ajBuOGtEWE12b0RSOTk1Sm5uVklRTlhBR0gvNGN6?=
 =?utf-8?B?YlpFTFNFZDBBQi9nVjlNSjluV0lZeHozUnlRNzUzRTFWNitSQmVoc3lUSEtO?=
 =?utf-8?B?VGplS0JMcW1JbGVWRFZmWXlQZWdKeXBia0JXWFdBZXBDM3lyK2RSazhZajky?=
 =?utf-8?B?UGdTM0plUGQ5NHUwQXRFRlM4OWRTQ2pnUXBwSU5rWDE2N1ZlMTFJbVpDWVJr?=
 =?utf-8?B?ejJxZTBTamtTeXl4b3crTWxpMUxBY0tpVGNmSXVya3JRZ2o1ZDZ1Uzh6Ym5q?=
 =?utf-8?B?UkNHODgyR1dNOU42bTF3OHBqVFcrU0xOaDRYSHU1N0pzdXRydW9pa1h0RlJ0?=
 =?utf-8?B?bGJUZVNTdnBBU1V0NDdQblRiRVVheFRoeThDQUlYTHRkYnBJQUlwTWRQVFlO?=
 =?utf-8?B?c2MzeEg0U2dxSW45V2doNStWZUVTeUJ3YTJMYWIzYTV2cjFqUXVVRHVsRWp2?=
 =?utf-8?B?OWcxSVN2ZDJkNlRvYzFoZXVlN3JZSmRkdHFqODRUd1BzR0p0WWFRUHF6OGdo?=
 =?utf-8?B?RzhmV25HMmFYMEZjaTM1VTZGbGYvTDVxV2xSS203aDB3VTJ6R3lGcnFlWld2?=
 =?utf-8?B?Z3duN1BRcWNPL0NOYzhXWVc2NFlSeWRMWTByR1grcUFjS0E2alVCSUhoOTJ4?=
 =?utf-8?B?RlpEcm13OVNVcXdRazNkSy9KVzdBd3RZSHRwR01SZ0JlQnZoM1hOdCs3YVZC?=
 =?utf-8?B?cC9zWVVBbnZsSjVyNnN1ZTNNR2lnTU44NGExV3UzVnZzUS9DK0dtc2RYenhL?=
 =?utf-8?B?M21xWlE5Nk8rQyt3cW1USW9iUWV2cGZkQW9YTm9ENDlUSXhvMVZtSWdMbmFT?=
 =?utf-8?B?N0VvenhES0dxbUxzSU9qeTlJL0JzOERsdUE5c1hMaDRpTVp4SEYxV0lkcjEz?=
 =?utf-8?B?Umg3ekFxTGU4NHpBQzkyaUJkaFk0M0JuMFdBR05DQXArRlBJcGduajRBK2VJ?=
 =?utf-8?B?NFNIRzRvWkY3RzJwYnJxODlYZmt6RkJSczUzMDlVZzZwdTVsOVdieFY2N1Zn?=
 =?utf-8?B?ZmJRTGZERjQwUGFwYWRlMFVnNzU2U0VRbFVhR01jbzNSc2xaYXpVK2lOZjdY?=
 =?utf-8?B?YlBSUkRiZXRvOWsvOFBnNlVJZEVqQkRZd050andMcllhNUtOKzMyMkV3NFR0?=
 =?utf-8?B?eG9TTm42ZWJYZWdKY09ZcnZ2NjlJSll0Ty8zVTNTZGJ3eldnWFVSNEhmK20r?=
 =?utf-8?B?UG9qbUpBcWliVmxnUERxVjJJWTZnNmF0RHN1TkQ0SkNGN2N0UzhTZnZLWm4w?=
 =?utf-8?B?Z2F2WGJud3p2ZW9NRytTS2RzZ0lTOU1FTzc2cFRkYVZZL1Z5a0NpS0NCRWdo?=
 =?utf-8?B?N1dqNnZ1TENycTI3UGFKMFpZMW9PMElGcTBDc2FOKzMwUVM2VUJHZkVFR1M0?=
 =?utf-8?B?MjFwcmZBSUhCNEFWaW9JaUF6UGJ0aGZkeDRQcjlvN3FmM0dSd1VNSkRaeURz?=
 =?utf-8?B?RVRwc2lvUTRQb3Y1bERyMnpEY01XWmUxOC8xcUh6MFRyeEk4eXg0SUJvMmFE?=
 =?utf-8?B?ejZFOWF1Z3VkdjkrVUJyUXVvRTJNU01COFRwRlNYb2l4R1JGNTU4Z1krM0FJ?=
 =?utf-8?B?TkFCckFQQ2lhQ1VXWlIvVWVpdmd6V2VYUFArcDFvUzdnTXJTQ0VtUDZEOTNz?=
 =?utf-8?B?amU3ajFwQkkxTmdreVlOcmVKTGprZ3RGTExaTUwrVmIwMlU4T3EvcHZ5MXBw?=
 =?utf-8?B?UU5uS055ai80V2NReUdRTEFKNUZJdThUM1YrdmVWVkRqMkhLK2tCRWlzdWJC?=
 =?utf-8?Q?7JHpI3/tb4La/G91Xy2eV1TYj/fT7KY1QM00k17+DiAo?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0edd92-bed4-4ba4-f316-08dd0029289a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:11:33.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiSAmFGd5IuzuYhCSXMGxBM4VbhuB4lcC0t7AK0PyPphj5doTFmu2zjgCgQEpO9cPUgVJiDLMEGa3LrP8r1YI7T4UWwXVaTrR1VmvdvYJla6Fklet2TFd5fEPS1qni2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB9089

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

A zero start_addr is filtered to prevent output of dso address range
check failures. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
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

