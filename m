Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C51537B5
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917420; cv=fail; b=PkBJqP1kY0nMpJa9Nd4y3aVpOe9V2jeoe5ZqWADrtuM+BYSLLKTVQ7xebd5aqJ06t0smP4uum9XQA4QtlIH7p467LQwEAF0b6g8cLu3iWC4hqXmxrTL7gr/CG4N1qG4pFyIigR9sQ1RfVYQu/k/XDt+esV3iTSEBJUcwlYO+gVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917420; c=relaxed/simple;
	bh=cxFyv0fRUixBKLUQ1a+TAvI9ZiACR0/ErJa56dCjUqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dm9z1U7xwkmqHbfAGOyMMNpmEFyEVGcdvfYwV+CWx8RcLCVLUWVfvJ6qooaUPdcUktzC2Oca4OYhRKxFirMkM/IiogV05CAhsMBPaCTyeRunHizxXORvL1c87tj8u9ophwOE7vbox7ackqKYxnaE134Wdvj9k2rAOPTFxoiSSD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=I9jBADTk; arc=fail smtp.client-ip=40.107.93.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="I9jBADTk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmDW6ZPFf/L98xkr79ycWNYlNpycbP6Jzou0X7/19NnAkVMbKbTZlAI2mpR3vFwZyVfsZY8Y65voRCrkLJeK+hNUlxg4ZLqdqn/9yh2KxPpN7V8BMR20jZhKK7tgDT65MIsWoa1H2wXUlXYCSd4Pz27P8gL1f1H6cNaaO/CHbJik7/dY+646HUQMedjd0Irgg6vlJfa/23oz7MISSiqecr4iuZSRC5w780v4BDiF9oleLY3IyLR7JbCfYnUoRLpjnlJjBQDUH9Vd078HoYwDgGDAwzxLPpv19YttHandlgzNgG4Cbn6jkbc4E83pRH+FBCSWqmFVHzGFM9CMV02S3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DspkEFSv57JVf2Naez3yZOfaGnypSIhtJnIVYOHXKU=;
 b=l2OFXObYJYeuRB3C8AjPI5vVaEFJYwfP9FS4ISWeLByg2etOpKvkDNrisI4YSagR66lV7ItICMva6B1nEjYVRwhDOucAni3RchnbW/2uLJPfIggbyekEUwtoPXTt2ZTj3WyU4VVCn/F80nKFwtgxTvROunae9QT/Uv9ZSBejB3YSgvPAAZePhJ/xYCyHLfkG1QyTW/0yT3oPMnRtpoCzqtGf0kHPDl96BY3/eMVOIQuQeevLjyX07kQCEyGni/P2viXda4Kt1098WvKC8XFDaAb1ObN/vGO4lbcF1PK7R+rGxpN6RUcVZLQJ0gOAHiCZ5Sv2kIll33beld+1Uhq4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DspkEFSv57JVf2Naez3yZOfaGnypSIhtJnIVYOHXKU=;
 b=I9jBADTk2WrT2912iV+RFPZmATzP4rjIIrGjNZNSLrVlPHPih0VCEa6gE2qg8NG+C9Jx8h2Pf6325FOWfIh9J5wl3JvuLpd+VMD/YQKYj8rSC6TG7JJWt2j3CbVRS+XvT51z4cvRM25aQXtW/DB2iCjQZN4I1Y0iIxpKV1LiFP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DM8PR01MB6919.prod.exchangelabs.com (2603:10b6:8:14::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Mon, 9 Sep 2024 21:30:15 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 21:30:15 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V8 4/4] Adjust objdump start/end range per map pgoff parameter
Date: Mon,  9 Sep 2024 15:29:58 -0600
Message-Id: <6013572cde82955faf0d3a7ef7dcd415ce843c84.1725667397.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DM8PR01MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 765df24b-9fc8-42a3-0960-08dcd1169839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFR1ZEpUUnd6OE9TS0ptZWpzbkRsVEkrcC9uaHVtb3FaZnF5ZnZCdlhzRnAw?=
 =?utf-8?B?VXZqTCthVndqNlhrY2JYWXcxdlVCSVVZc3ZMbUJ5enpVS2ZzNVRHWWVYY2dJ?=
 =?utf-8?B?RTRFcTRzVGZXaDhvelFDSDlmRlFGdWlyMkhoY2p2Qzh0SXgyUFVKOVFVWDZK?=
 =?utf-8?B?WEpvQXpzY3FyN1FmU01FMFczaFR4ajZOaHNlaktDREVScXFKSEpUeGVrL2ZP?=
 =?utf-8?B?eHo0d0M4SmhUVHJGcjFOcnNrK3E5NzBHT3NheUxHMlZRY2R6RWc5TUNhalp6?=
 =?utf-8?B?YmcwaXhzQUNMSEN1VGJ4N3UvN1pVRjZHV0tNM3k3NkJaYnZVaDdIWlpVY2Vk?=
 =?utf-8?B?dy8reWlhYmM1a1IxK1BoNnJXNXI4emtxR3R3ZTMvOC9SZDV5RUpqZzlKL0V5?=
 =?utf-8?B?TjNWTjhsUU42KzdYaGhSSG14S3ZNUHdiR2RsdG1pcGo2REdGdWFoMk9HbGt4?=
 =?utf-8?B?OWxVT3J2NnM1R3NNZm85SVZDR1ZFczVxM29RNVJoUHU5V0R5akwyVndteHlK?=
 =?utf-8?B?T3VQeXFnQzFQR1dsT3RRR1RGZHpoYVF4Z0pMUE1CTUFrV1lxVUVMK2Y0blZn?=
 =?utf-8?B?RElrd01pZHZ5Qmg4UnJsNHZveUlla0lJbCtnYUk4U0NZVEFCM3hvUDhLcWV1?=
 =?utf-8?B?a091ZDNva1ZyOWRTcUhVeE9nMXdvazlxWFZOWU50VFRhVWpVV3kwMXgzUjZm?=
 =?utf-8?B?MHVmY3IzdjMzaFZJNm9vL3k1V0FDTnYwUWpBUytsckZ1MzV1T3lSQ01HdEFW?=
 =?utf-8?B?OEJzQVRmQWpqZVJ1SW1lWjYrVm9ESTgzZzBkS2lCcUhmSXR3ZERjZ0lyNjRr?=
 =?utf-8?B?UEc1dmVqMnZZdksyenllbUNzZnI3bkNJRTNVUlI4WUQ1WDJ3aldjYzVQSTRZ?=
 =?utf-8?B?ZldEZkl1UFp1ek1DR0gzR1lJTzZWdHIxU1Uvc3Z1cU54OWwwQzBvTWdHZnVI?=
 =?utf-8?B?UCtidE1URzlGOHlZc2Y3V0lDTHFyNmpubGlYZk9kWXJTOTY2YW9oaUdkcXFX?=
 =?utf-8?B?bjBBb3hlc2dFVDhTdzBkYzV3UitVVUN1OGI3cUNTeDNlR3d6ejFmaGU0VFJs?=
 =?utf-8?B?eWR3d0lUekVXWnc4M1hSU3Z3NTN3UFBWMmhPaFBodjJ4UytBb08ycytLbWp2?=
 =?utf-8?B?S2ZyTVpwQmFjVXE5bGUweEZBRk5UbnNUbGpKRzZCS3czWWhjeE1UY2t4dnJq?=
 =?utf-8?B?VitMdWNTVWRFa3hUdFZWUGIrZE9NdlRkenQyaVVvMjJNSDNCQUpEUEZobGxT?=
 =?utf-8?B?VWYxejYyQitZb3pHSDFCR2NFVWJxV3o3aWY5Y2l5QldKanF0WFd2RlFOTnNS?=
 =?utf-8?B?L3pVcGtsUnZnWkVKeTVqSHd3czJiMFlmZUZuS0NnK0NleHp4bUlvLzJzTlF2?=
 =?utf-8?B?VlltZjJwaUtia29VdlFGbDZKV20yOUxaTWIxVDc2SGdOeXBtYWdrQ2J6YXNm?=
 =?utf-8?B?MFpmK2RLUnpLRU8zOWtDVjlZR1NDaFBUczVRYVpqVzJiV2VTdTJQSGt1U2k0?=
 =?utf-8?B?dU1MMkJDQVhoZTdUSkFjQUVTMmo1WW1yMTJlbVpjdGk2dHhBeU90U0dmTU9t?=
 =?utf-8?B?RzlrMXNScGlOT0xrUHlwUVIwUUJZYmticzBhTGdJaXY3bmJSN3ppZDFoVFJs?=
 =?utf-8?B?dXBnTWFjNHVXNkczYi9GZUZFTzNRQlRxZENqQ3FKZVRRaksraFI4cEFYYjZU?=
 =?utf-8?B?T08xbENBZ1Fpd2pwK2FOK0VmR1IwcGtNRHBaWUY2R3orVDdxb0hUWnk1T3BD?=
 =?utf-8?B?OTlrRUFLSFpyS3Rmb2VraGpCMjAweFdLMVdnemE4QnpmalMrbEhLZTRMcXRP?=
 =?utf-8?B?MHFWemFkWmh2VHRMRzc0UzBlaHU0ZlJhVmZXRnVsa21MS21PeXljL2hrSHNk?=
 =?utf-8?B?akR1eVc2Skh2VUFvbmlGVUMwRHgwWXA4dTlQM0hKK1MrekE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZXWmgxUjdldmJpN250Yk5HN05HRG1yK1VJYmU1bkxKdUpsRFVzY2k4OHFj?=
 =?utf-8?B?OXRodVFqRmJyeDdnbW9IZW04NUZQRENDdmlJbi95TGhpbkRFOHlaQS9VbDVt?=
 =?utf-8?B?ZE1YdDlrcktaeHcvNVhCcElHUm13aHNuNG1ZZkd5eUxCaXBINStuYmMwcDJ2?=
 =?utf-8?B?WjBCQ0RWT0JHZkNWb1oreE94Y2JuQ3lKdS8zK1Bkc0R1S0cwUm05L3pZdTVz?=
 =?utf-8?B?c0RJaFF0S294MTEvUTFIaWZQOEo2akdmWUh3UjNRMTBablBoTnNMMmI5eDVV?=
 =?utf-8?B?cUdzUGZPdzl5TFhDMis4RHZQZitISDZlM20yeGVXL1R5czhxeFJzQnptTXpR?=
 =?utf-8?B?VVFjeWNGd2c2c05MNXRLMzZmR3luY28wWTUwT1RzeWVRRkxWdVp0U2xWbm4z?=
 =?utf-8?B?OUFWeHZaSHhNMFQ3L3gvVWZaWjVOZmt0a3BCM29VYzNLVEVPT1AyNEUzeG1N?=
 =?utf-8?B?elFmVm5CanVRTm8vaUc1QXZEMkx1THRyYXg3Tko1YUZKTW4zNUkwYkdIY3Fl?=
 =?utf-8?B?OXlUUEYvM2UxbnpEb0tLRlhtRjMrNFloSHpiZHprVjRsQ2UxT1pMNFd4U1V1?=
 =?utf-8?B?Y0NaQ0FKWVJPMFRLbW51UG4vS2lzemJlYWhqTkF3L01ja2VIL3FHTlNMRE9W?=
 =?utf-8?B?ZWJ2dGFmWTMrT3A1Zm82UFhEMWQ2M1BMWXZ3L2swRlUyV3FsWEdsaENuRmxs?=
 =?utf-8?B?amw3N3Y5K0NJc0hGTWJ6Ulh4QldyaFdqaUZ5L1NyOGROYVMybEgzUmhRZWJ4?=
 =?utf-8?B?bHlKQ1lHeDdyZm5MVTFFU0lLOTA0dTR0WWpYTFlBY0dXbEdtazFMaTQ4Nzc3?=
 =?utf-8?B?OFNyZ1Bzc1lUUDhRZ3drM0h6ZDZ0NlNCRUdOaEl3U1dLWGltYm5nL3JaRnF1?=
 =?utf-8?B?eUpQQ2hJYlRLL0lJaUppVnlWcUFPbkZVb2Q4bmVmdVRHYnc0VXRqcS91Tmls?=
 =?utf-8?B?d25qd0duYnVjUGJZMkNMbkxwWDd3UmtoVTA3K3NRdU9UVU84T2duR3orbzVy?=
 =?utf-8?B?MnhSWmxQNFZXRFZ4alZHZk80NUFRelRoQ3d5dzVyUnFCODJTaUJpUTl2VG0z?=
 =?utf-8?B?bE1RZGllZExrakNTQnVYS1JHZGRvTmlOeUpzV290ZUNLYUFDZzlPMkM1cnJh?=
 =?utf-8?B?OFRDYW1FQ09CZm9hUmRKRW9hcVZzdFhycG8vTFdpL3VNZVhMTFhxQmQ4Q3dC?=
 =?utf-8?B?ajNMcDQyYUNuTE1xaUJZQkw0bUpRMWQwSWhESlhzdDFxc2hScE5SY2RjbHp1?=
 =?utf-8?B?Q2doS2N1aDBDYS96d2huWUxtWjRUeUc1NzB2Uy84YmpUSmpNdkNoSi9aMXNZ?=
 =?utf-8?B?cGRPcDdwcXl2azF2R3B4KzFpaURQQVBzQWUrQ0tzNDgrMVdEcDZ0SUU3MXNH?=
 =?utf-8?B?d2FaTkxyZmZxUkpVU2ErK1U1cm1SSXpPbWFzZkRwL21FWWQ0aXRXN2N1eWJC?=
 =?utf-8?B?ZWo5K3B6eENZSFRyWWhETzV4c0hGa2x1N3FaTlZkbkN6MnU4VzVmZG14MTQy?=
 =?utf-8?B?VW1rdVJXS3kyRzZWVlcrSlltbG9kRFZJR3RRdzl1THhxbUo2VEVJSFFaNTBw?=
 =?utf-8?B?eGl4NWp4UnNRUzQyYU8yTjFSNUNVa0ZySi9JUHJsbjR6U1pXbG1yV0lESFV0?=
 =?utf-8?B?aWczUkJOSlJXZGZnYkNyZUY3YnRUbEhGVUtiTlFSU2gzbFRRbzlaVWFhMWl2?=
 =?utf-8?B?dWNlQWdOcW1rRFFLaVIwZG1GV1VHd1JpQjZ0TVhta2hSTjBueDREQUcyNXk0?=
 =?utf-8?B?NkNkeXliWWFtSEhsSW9tQStsV3ltQWFHZ05Bck5SSXdWR1N3VEx6RU9sYm1k?=
 =?utf-8?B?VWg1b3VBbW1hcTBwLzZONnlmNFJHZnNkbE8yMk9uUytGNkVPVU1OZG5KZ3o3?=
 =?utf-8?B?MHpsNlZUUzI4cHJna29xZlgrbk9VZ2N6M1Z4RlRET0pOVFhTK1ZMMHZucDRo?=
 =?utf-8?B?ME5LeERYaWsxcUc4R2JqaGE1S0tXb1RWWjJUZVlqaG13SVpmc050b2pMejNW?=
 =?utf-8?B?Vlk4VFpRQjNSdDkvQ2NiVzBLeTB6ZzVRU295b2N0OUs5djhyZVhZVTFCR2Jm?=
 =?utf-8?B?cktaZTdGc0V6dEpIQVF4b0MrYUZzQUZJd3JPb010WFZOalV2NHhMYWtRL2pn?=
 =?utf-8?B?Z3V0ek1RYnBxNGVzMHYrWVFFbHdYclhJYVlkbC84NkhycTg4RFZFNHRjbFd4?=
 =?utf-8?Q?dq+FMOtzxBHqlstv8cRHvTq09l+AEpwD/B0zNGpLpJZu?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765df24b-9fc8-42a3-0960-08dcd1169839
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:30:15.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Htl05bYsXN3ElLS1pwNLcytADFavW5fw8AxQ4MUdNPzKLq/8WOTKePTG5Nhi0JBw5aYr0hpXkiT5XDmPSGl/gAqQY4cpJKbYkvBjQo6pKYuFiqjwPz0vk8pFw0CDLQTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6919

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
 .../perf/scripts/python/arm-cs-trace-disasm.py  | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..0d97fcf51b91 100755
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
@@ -243,9 +247,11 @@ def process_event(param_dict):
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
@@ -262,13 +268,14 @@ def process_event(param_dict):
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

