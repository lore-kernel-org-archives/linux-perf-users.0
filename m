Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00419EEC8
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575331; cv=fail; b=aHuy5yAjGoqmyx8DzzKfBDvXLxUX0nV/O4PI4uuQZ7jnsGm/uLWN+EUhJgNynNpAntCcl4k94OBp9Y/188ntpYBayu8MPXCm7scLlCFtgFAZU0aVHR/cgdU8wKoWjTC2Ex9xPMlUrACwwwLgiXWrZBggzo5TXQC6Tfsk6O0zs4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575331; c=relaxed/simple;
	bh=iiLY0sauvDqFAiaUmp8w70uVu1wsxZcJcu4dlMftB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZXQ4opnNwz/y/rpvxUClJlPdpVv25Bm2qDoeOnMF3mOIEthfQBLOQzdNPV3K2qx+ZrsI3osV16elPCAWOEnKGymRxzoiU8xFd0O1Ti20+KqOa9dZedeQSoybAAjzFZDFol5XiiHfQaKpcJi2FgKU569kgmoMKKoBRbESWEhslk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AIIX/5ob; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AIIX/5ob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXrsrBOXc5D499vmFNkQxzaltlUMAEwsCbBJks7om09KIVyKzG/YUyQEOqwItnvCqBfqdYxhOP420BV8PAj1UJUJPq6Mixl9MxXFJfRJvaHcdQVey+1IYfDsOYSbAI5T0rcwzGOBklmUtqoOnw1IzoZkeYwqv9OwKJKU0gR3xcRrozTbL4PxwbNZGgrLqvfN3cdOOwJjJH42A2ecHa0mVeQRQEv5YYoc/OI/CA0bscTetwC4pw7X14AF/V34kvOtJwC+sSYULt15UiZPGOauKOpa9ntOuhhXm8X3Zux/pXr/Dcp3iJqPdQ1kwqIm1wx04FLA+tosU+lgekKf4lyoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cff4uCMC8cc4jDYyIiCXot/dKLhp7rkFHt5dIeaRS7c=;
 b=PXVHcvB8GdBVtTus9EBBZ4QpwyxDE9Y0YksNv57fggP/tu16RpYmpCodBc5V9SFnDG4OYX6OfqJGVPrOwTE5nMvfUNoIVj6fK0cFhzrX3IJ0z/WcZ6LQes9/UKaUzZTXXwXbD6CgDcekCdY0CWQ/LoiVuC9VkN7r5eUairvemjzcridLfHzaEj7WSSNan6HndH0JK3nN2HDOLdQQ4jQ/ZFMyey6nxTa/jY01EzZlk5Fs4rVuvxQ6PgY+0ayhkZ6ena479iPaWkIhWTUCaBIsnpgxRs3bgTGaKJoLsBNsZAkPUEVhx8po3XxmucdvJg/dT2Y1HyoN+W2F8v160taxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cff4uCMC8cc4jDYyIiCXot/dKLhp7rkFHt5dIeaRS7c=;
 b=AIIX/5obUcmjskOYbLBXJ7sVqH6eUC0eZ1PZMfmNJpMF2jKbYDqlkwjdI/fnBtg+vCWjdDIeGdqd/ioMd0Um16xeY6JYwo3HDU/N9nJUclxgAkfQ7pDl91Ppup0krI1HLZeX21/Uq92yrGK1pKOzQ0Nk4jzpIxid3TaVrb93c0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB6501.prod.exchangelabs.com (2603:10b6:510:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 22:28:42 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 22:28:42 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V7 4/4] Adjust objdump start/end range per map pgoff parameter
Date: Thu,  5 Sep 2024 16:28:25 -0600
Message-Id: <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:610:55::36) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 01649d40-1d00-447b-367c-08dccdfa1899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGR3VFJ6R0Q5ZDZ6Z1Q0OG8vMHhFMjh6K1RZRXdPcERDSGJKQjVHRXRMa2RJ?=
 =?utf-8?B?V2RsdDV4ZzJCQ3pLNWZBek1BcGt1OUJNQXh2QWROd2dqbitwbnVMb2pWa3hu?=
 =?utf-8?B?NWhZQXNVODlxcWhocURuS3F3L1V1bEdwVzFPYjF4NDhMODZiVWFGZElvakls?=
 =?utf-8?B?clp1Y3NDdmhJYkhReitFN01WQ3BRTnA1cWZMY3N2RHZ3T1lWMEdqOU5KcitO?=
 =?utf-8?B?ejkwMVd1dnNxKzlVUTVTMGV3aGZsNTdDTm9veE40U28yVGp4ZGZnZ1BNVkZ4?=
 =?utf-8?B?WHp1KzRZM2JMWVVlWmE1RTNST0FMYStDWlkzY09qcndRVUlwanhkWHpxeTcx?=
 =?utf-8?B?d1ZMc0xpM0Mra0h1SVl4UXI4VkhkK3gyVCtHRDREWERaQWxubml1b2U0NUQw?=
 =?utf-8?B?MkVUbi9hTWF2cmhkckRybytrakhlenRpQnFKZHovSDF5L2EvK1NGWEpDNTR5?=
 =?utf-8?B?RTQ2ak41UW9BV1UzaE1kQ2NUd0hpSWFlenZJaWd2MXlPbUN6RHNnTDFXTXo0?=
 =?utf-8?B?V0xrWkVNc3Bya2UvUElJbnRYeWYwNkYxKzdlSTdnZWYyQVI0S2ZMTHhHWHhy?=
 =?utf-8?B?S1BJOFgxK0tDb1J4WG9vZlQwdTlnMnlBNjh3MElXK3ZMZXhrWk05S2MrU0hV?=
 =?utf-8?B?M1JmamZlNjV5T2dsc2Q4UElHT3Y1YUJJb2V5bktSTzMrTTdMYTZUOWtkMFdB?=
 =?utf-8?B?WHlTTTZFcWpsRVVmUk5vUU10dWpBVWp4UzF6TDVocU0vTHRUeWhhVFdXSU9Y?=
 =?utf-8?B?azduTTJQZDlMOG1KZEJCYWRhWS9Ub2krdStLYi9nYklZNUY4ZlpWcVhVTzlX?=
 =?utf-8?B?QlFpV0RLSk1KYUV4eGc4VXgrZmZuZXd4UHRCN0ZwSVZsVDg5enpRRFVCNTNO?=
 =?utf-8?B?bE40emVqajNObG9wR3JiV1FkUTI1cFVNcm1IeDRzSXdaQUdCMEliQkFmTGxP?=
 =?utf-8?B?cE5KbW1pTzAxZnVhbThMSWo2cFBzQkJ5RjgyMGszeWk3MG5FNy8wREg1anFt?=
 =?utf-8?B?a0ExNFJoMVRONWZVSzBDWGs2aEpxalZnd2d0MUFTL0NTb2NvcHk2TmRSdzNl?=
 =?utf-8?B?WmJqVXIwSENkYXRXY1RYd2FZeS82bU90a3dPN0hMclNwQTMvT0R6SXZiNGti?=
 =?utf-8?B?eTExR3hUNHRwczZ1R0RLZlR1Sm1RcGNhZTdsR1oyQXhqNWtWVDVDbTRVRGNp?=
 =?utf-8?B?cVVTZExpQVVUUjVhS0FGZC9qcGovYnhUenFCQnlDVkhLS3hPNGZ0MVlKNFc3?=
 =?utf-8?B?NUZOdDNuY2ZCbjYxR1pzQWNIdHpGUzA0T0lKMitvWGc2dlMyQi9FRWpuZ0F4?=
 =?utf-8?B?cy9iTmFzYTRVdkNqOXhnWWlkQ1dqZ2d2L284RzZJL2QyVElucjUrTktldVRy?=
 =?utf-8?B?Y3g2dHg5UkExM2V0OXJZNUhaUitHOUdGR1pLREJ2eWtOQTE1UUU4RTVhMDRx?=
 =?utf-8?B?V2tzY2kwSkNOWkk3N3VPcnRJQUJjQjhZaUQyLzVLNWhwVjVrT1phamVERTZy?=
 =?utf-8?B?a09LVjJwclRLbTlEM2ZrTndBZm1ROXJwMlo3aG1rSjAxMHhTcUFpNytVQVdk?=
 =?utf-8?B?TGd4WHVSMzhzREZ5aHplTm8xVTVDLzJoaTBoUExaOXpFRDVLcnJ5SUVPelcv?=
 =?utf-8?B?cXYzeWkvRGt6R2JwT0JHY005aGdURDVZNnpDQUZ3VEIxakVkd2UyQit4R2NC?=
 =?utf-8?B?cUNNenJvS1RiMTJFMW9DM2wzdFRlVko3dFgyNDV6Zmc5N0RhUUZ5Nmt0dm03?=
 =?utf-8?B?Unh0UlFXNUxQLzRyRDBLZHIwbFhVUFpYRW9jc3V0L2k2TnFpZFVnVkRuTW5s?=
 =?utf-8?B?WlJ4eEJlc0FjaE1mbTBtQlRrc2tVN2pGMnFGYWxQYWt4N2JoazZZVTZWNTky?=
 =?utf-8?B?OGpsVHpkOHllT0lsVlBlQi82djN6dGUyWG40dDlNczdGUWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzdqZnV5Qms0SDgzemx5a1BjbEovRFEzYzB6QmtOSUUwSjNVenFpZTEwc25B?=
 =?utf-8?B?bFJad1RXQzVrRzRvd2ZIVk1hdnNPT3RSWjhmZVNjcVZMcWFxZFFJQW1XcDl3?=
 =?utf-8?B?eFdXdUNabEJSUE5BMW1paTJoc0preHdDdDlLUTlOZG9DZll4NGlqbURzSWQ1?=
 =?utf-8?B?SHByRHNkMlV4VjduajdnZTU5TlRhYUxJWXRwaVFHSmpFVDVmelBGOHhUT0Jy?=
 =?utf-8?B?S0lQbyt4dXpaS1kzTk1KWXFVTmNFNm50dTJxMmF4WVFBNDVieWVRUTkrL29G?=
 =?utf-8?B?VVpCOFg4aEtLcHFPclFnMVlWTDUrbkVBM09HUXlLTk1UWk81VU4wWGl6a3Zm?=
 =?utf-8?B?Uk1XZndiWi9FbmM5MFNyTXZoVTBmaWxsVzRXWVBCSkhZaG9vejJiNG4ybitU?=
 =?utf-8?B?UGJXWFNURGJSVk9jdkJkT3RIN0IyVFYyV3hJZDVvMUo4SjlwdHUxK1c1K3Vr?=
 =?utf-8?B?ZmhSb3JpdEphOFJTYksyTGxBdzBKNXlKSlJCYVY4N09EakpjVXFmY085bEFu?=
 =?utf-8?B?aVFibE93VU13YmxwcUM4eUlVV0xZemxtaDFrNW1rVyt0RndBaDQ5QUE4UXdt?=
 =?utf-8?B?V0UvVW1kT2kvVU9pd2VFUlZsRjVtSzQvYjdwR1JJdmUxS0U2MFloaDJDUks2?=
 =?utf-8?B?NGxPZzh6ZEZpSWNVYnRGTnJJVGQ3OUNKKy9ibDZFMkVadmwyOXNnUC9XUzl2?=
 =?utf-8?B?RS8zRDNGZUFLaW13QTFGdno3Y3huMU9STkgxTzd6bzRjVStySXlGVEsybnE4?=
 =?utf-8?B?a0VYSnhnRlNhaDhoS2krNzlTalpFamlpMVFHM1JTSkttcE1EK282NDZtTWhI?=
 =?utf-8?B?bmRjVGdUZW44STA4czB5M3UrMDV6NUNMR2FVUERLdXd3eGRUeGNwNnlXWTNC?=
 =?utf-8?B?bmlBMGllbHFmcFBIWGZ2cUl4QUhrb1ZsREFZYUYrN2RsZ3h3KzZtVkVCL1M4?=
 =?utf-8?B?T2hEOUJSdUs0ekFDSEkvR3RJSW13aFdoWXJqTXo5R3hidkJPdlhNSGpOWVpB?=
 =?utf-8?B?dElsOCt5SU9pZkVEZjVpejF4RTZreTZLTGJBcUhWaC85Ym1IQW5ZTUNRRzhZ?=
 =?utf-8?B?YUxKTEVCYktoTEhFbmlLcWxMN2FtTFN6WWNVNUpwUTFXN3FTTEFQcmFWMkNG?=
 =?utf-8?B?QU1wNTBrcFF0Nm9Bd2dVOTc4V1FsUkF3VTVGQmQ5SGM1S1JVRTFFSnBHeURr?=
 =?utf-8?B?dVBGZEFSYWFTVzhHMk0zV0hNM0tUaE9HMnBWT2MyVXRPa3pGd1RLM0RIS2dx?=
 =?utf-8?B?M01QeU9Vd1ZYM1FtVXRXa0tyQzZIM1ZVSDZNa0VsY2I3cUFrbTRqalhMK2hU?=
 =?utf-8?B?dkdaRjRFM3RTQWFMOUZCemR3OWtSblcxUlFGQ0pCYUllWHI2VjNMQ3pkTkVz?=
 =?utf-8?B?Qk1jeFZxejlvMDcyV3NuQk40eldPeSttMWRJM0NMZmFldng2VThmTHpaVEVH?=
 =?utf-8?B?eW54b2tCa2IycmRBZ0tDblVBbFIzRjR5ZGFGV3VxbDNXaVl2WFU3TGxOWkxz?=
 =?utf-8?B?R0N0WDZqTGNPdk0rVWN4d05scStpcFQyQVRqekJmcW5rczFrdmRIbmxMWit3?=
 =?utf-8?B?Z3BDNjJwdThkeEtZMDIrOUZ2WEpmSWhuODI1b2h4VVB0d0I4L2NpMVlUTTh5?=
 =?utf-8?B?TXFwL0hDcUtSVTR5azkzQ3FMdHpvTVlsU3hOcDczaXJwclJYb1FLbkNmbjh6?=
 =?utf-8?B?N1FySEtHckdVWVJNcis2UWZEZ1dETHB2dWhXWUhZclNFaEVhckJ6TldMZWlM?=
 =?utf-8?B?bGR1MzdMdStIeFJzbVR6ZVZMdDhjVS9NbmYwNlhFZkQwRVpJTFpSODFlTkFJ?=
 =?utf-8?B?amxlYzBjYzR2dmZRSWJzYjF2azZYOHhQRTYxSzg4aDNKb3FXRWpscDYyaDJW?=
 =?utf-8?B?NTY5QkdaTEY3cnFwcC85Sm1XSVU2eGNvbXZETFExcXF6MjhOOWJDem05YjFL?=
 =?utf-8?B?MGtlYnRYcFI3T0YxR1poRTMrVURWLy8zSjJPTHQyUzh1OXVXQWJzMzg3RTZl?=
 =?utf-8?B?cDFWbnh0aUpJYlV4M3hNYWxYN0ZkTktoSDN2MUt3dHduL0dQOVNGbHozZW1s?=
 =?utf-8?B?UTBZdGR6d205T0FCUzJCQ0VSWGlGZHhOVHpaeWxwcENqOGZYaVVOcktlR003?=
 =?utf-8?B?ZVFUeWN0WnRpVlZXMzRvdGFEZ1FRUjIwQmRLeGVLMEdFOEg5K1E3cGw3ZkNt?=
 =?utf-8?Q?Lb6RnBEHXbo5NSK8guucEkDIESvz6+l4n/4W2m6uhFPQ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01649d40-1d00-447b-367c-08dccdfa1899
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 22:28:41.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcFXkS9kJjW0gOMdn9D2eTNGzAs3kf31rgQCoWbMycMUsVBfoMdInSeDZuuWR0Rhspx9oukNbAvucqb4uEFmujQb2kPBBKPybQhxTpdlhQ3Rqg387EHZ1l3x6DLT1ieh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6501

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
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..a867e0db02b8 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,7 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -243,9 +244,11 @@ def process_event(param_dict):
 	# Record for previous sample packet
 	cpu_data[str(cpu) + 'addr'] = addr
 
-	# Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
-	if (start_addr == 0 and stop_addr == 4):
-		print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
+	# Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
+	# if start_addr=0 and stop_addr=4.
+	if (start_addr == 0):
+		if ((stop_addr == 4) and (options.verbose == True)):
+			print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
@@ -262,13 +265,14 @@ def process_event(param_dict):
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
+			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr + int(map_pgoff), stop_addr + int(map_pgoff)))
 
 	print_srccode(comm, param_dict, sample, symbol, dso)
-- 
2.44.0

