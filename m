Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82613AD29
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592446; cv=fail; b=VimffjXLZbbsKrGxK7crdRUAKYdEUk28YaoimFqbw/G32PLl8mjq6PSwR/OuEauPj1dKxws3vjTRy/gNa0eh2f9oa4WQeWstf7tYzLeqrnDoDUe4ondz0aqqZhuRKTLSJ6ghLtH+03hvaswGLHTfFrKfaovucUHjgfsrRY0rxlI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592446; c=relaxed/simple;
	bh=y097dIt+R3PoJVwamnpb88flncZOUzpSXAyEOCV8Ly0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PphhKoFL/HGPiqk/xetslqwFq7UgDQaiOQd8aeLSwtELoCb6TY6gNBLbmxGrz4vyxUt0z/JfKmTZtonYB4xCB+Ff8INEm8Pn3H9SfeOoGPecZS2akFFUMElSiWecrKXCpx3zesshSwUwhp0Ubv6RTrPWgzUWS6cdou/JXKPhdjc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DKPcaB+g; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DKPcaB+g; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DKPcaB+g";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DKPcaB+g"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=jfaBbnIz5fCEBSv1vNndxT108rrvlU/NHJBauSvCLSka51uz9/J/BSNmHz3hR5BJzeLGnQwQOWQrI7NWfmngaZeBIwrqQtAdJu8CAvVLF8R8dF0G02Y4CiDf5zJQ2IedM/5XP+7U1DwhmfdWUpBRGJsbYZgZFx83A885KmczG9sWZ7TqT4muf2a/xVC6D+MCprT+EUOZqM0EMpXDO12ratHaEohQ3TYhLiTKTRclMuErPLO+CGzKr93kz7/eLN4AGu5uaKZWEE9t0nHSIzH6/qfUgQawinHnfjztu3E8r+nsMFg373HXWwBXV72xj/bh/kzuxxVR32kOL0KRLoPCYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y097dIt+R3PoJVwamnpb88flncZOUzpSXAyEOCV8Ly0=;
 b=CYGa5IaXzCAPXmnIwTDQn6hRZIXtbj7FVQjZSKi4TStdNyW/mi2WU5Aores3mkFZFjdmN9Kz80R938EqDSky3p0KLuMEl3f6NLgY+0wgOg3a3T32a2E13KG5GOwNfPH2G+wCUCaVifrmulTHNzuFB/yZZ8C+0uXnhqO+CZRK908J6a+7qeg0aTADOa5Ge/PpNEA9V/VxmfDOXxN0cnNPRRHzkgsSvjwDMsAmQ5ppQ/sxbS/R+usb+ihpCI/B/75kI5mvN2TUVQF1DfddEM0rT9wQ4nWUm/UEvbWmms1tjXT/HHAvf/a1WfwWSoS2cvtO5eOpLZftnhlRwUny3dMOzA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y097dIt+R3PoJVwamnpb88flncZOUzpSXAyEOCV8Ly0=;
 b=DKPcaB+gJjmzsdvmInFZ/GgeYeXghb5/DG6qaxE8XyPV1V8DrPKNHZS2Md9LKqPWNG0okO7n28eXsuxjZMF3i2ab2ws7ObIsGRpr8UUlCQUM9Nu5XE2b/plbGV01p3Ntr6TIMBEHtgBd6DSzSJwyjp5pegnKzMgI22BHaDoftX4=
Received: from DUZPR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::14) by AM9PR08MB6708.eurprd08.prod.outlook.com
 (2603:10a6:20b:30e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 13:00:39 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::88) by DUZPR01CA0139.outlook.office365.com
 (2603:10a6:10:4bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 13:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 5 Jun 2024 13:00:38 +0000
Received: ("Tessian outbound d79ebeff6a2c:v327"); Wed, 05 Jun 2024 13:00:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: aa64a11d2265ab80
X-CR-MTA-TID: 64aa7808
Received: from 4edd1b850974.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 66B71D6E-FB34-4924-B503-AEB1EC838DFC.1;
	Wed, 05 Jun 2024 13:00:30 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4edd1b850974.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 05 Jun 2024 13:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc/l7bGv3beiaH53etpj5DwFR7jQcstl3nFDIB28OTEovGq27sR0bt+dzqi2Ulall8POBmaenfg0Spg6NJHU2OnolvwrGjlnT+UJi3yQG6ItWEg63Yb6p1jzeAYYUMBIdpM4QN3DbzbwIKz5xKJpQTpNAJg5dqnDmw1nITGCPjXfPES6MxzN74Y2CtLDugUwEIypK+7+0WO/QM0rLWxvIxea9+yE3/LtMcXcry+WdZ949zgN/ZIBwmN0muN70Y7Ak464lN0wTQ3ENS3V+MbUmIay8zC0Rj7uLw32TM97LUtI8WFAtUhjk23H8XA0YQysd4vh4CB/Z4PO5aH/byVGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y097dIt+R3PoJVwamnpb88flncZOUzpSXAyEOCV8Ly0=;
 b=PMPTmYMJQdDv2BdeMQAUtn2za/YsmRdMTJuyi7/IOVkKpq0otXfXTw7tNbGqb2iOUZ0MlOd4GcHmkQaQ0ip1vwFfC81AOolR+Mg27CovEMoHU7gqGqoLJ+wLF0yp4LuSV/3CPfMKapmFJYiI5oeQgmsAvPB9cVv6YTcwZAUYMc+6cQbiAfpuRyulX0AUhFt7RaED6N17jWs5BU890WRegqK+isyghDW3nDnwGBuuhJwB4XlSrXqTGqPoiMWIk2+ai50MlyGK7AJNBvdzai6p3LvAoDDbqbWmyhw9gWtgx7T49vGtXJdNpFU6VKwTq07MVhK9qJ/rs9zABlqYd7d6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y097dIt+R3PoJVwamnpb88flncZOUzpSXAyEOCV8Ly0=;
 b=DKPcaB+gJjmzsdvmInFZ/GgeYeXghb5/DG6qaxE8XyPV1V8DrPKNHZS2Md9LKqPWNG0okO7n28eXsuxjZMF3i2ab2ws7ObIsGRpr8UUlCQUM9Nu5XE2b/plbGV01p3Ntr6TIMBEHtgBd6DSzSJwyjp5pegnKzMgI22BHaDoftX4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13)
 by GVXPR08MB8235.eurprd08.prod.outlook.com (2603:10a6:150:16::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 5 Jun
 2024 13:00:29 +0000
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad]) by PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 13:00:29 +0000
Message-ID: <7ffd3a6c-9021-4701-b22c-678da1d1653d@arm.com>
Date: Wed, 5 Jun 2024 14:00:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Why does libtracevent pkg-config detection wipe
 PKG_CONFIG_PATH?
To: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>,
 Leo Yan <niayan01@foss.arm.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
 <f34d5d79-5d44-4a54-8e36-2720f4b25d4e@foss.arm.com>
 <1d63aa77-4809-45f1-8827-cb1ed6613f23@app.fastmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <1d63aa77-4809-45f1-8827-cb1ed6613f23@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To PAXPR08MB6591.eurprd08.prod.outlook.com
 (2603:10a6:102:150::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR08MB6591:EE_|GVXPR08MB8235:EE_|DB1PEPF000509F3:EE_|AM9PR08MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a15a31b-caf2-4bf1-76b9-08dc855f7f8d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MVJmS0ZyT0d3S0ZEWGp2ankxWGx3TEZkaGxZY1VoWTJVVE1MUG93YmExek85?=
 =?utf-8?B?OEpEa205aUdqWHVFcG9XNVFURS9KM3F5VjI1djFrd0J5ZjJXcm1hbGpCQUlp?=
 =?utf-8?B?ejZPdzNoZzNNUEhEcm5lQ0JTb29MYmF5ZkQrMjdOYW1CRS9Ia0kzc1pUS3hD?=
 =?utf-8?B?QmxRazhDRzZxVG93ck1TOUFKUFNkZ29SUUxMMVFGOGhRNWZ4bmxmd0Q5THBp?=
 =?utf-8?B?L2VMb1ErMUNMRTVVekNnaW1QU2ZUZzBkSUgrdE4rdU1oZnp2dkJJRDdQM0FD?=
 =?utf-8?B?bUorZ0M5YTBnWTZhRmZHMXN2dkQzeVFTZmJ6Rzg0ZWVoMEE3bDBzdkZuQklD?=
 =?utf-8?B?UDgxejVXTFdCc2hjcWgxamM4dm9INnlha0VpU2FnL0lFK0htQWNSVlBwdWF5?=
 =?utf-8?B?NWp6Vm91UWZ0cEpHaXRKK2I5aGFob2NzUmM2Um55TmRFdG1lejhTSnJxYVJl?=
 =?utf-8?B?YlZ4VVAvYXFiTDM0L0VhOUM4U2R6cGJWTTdmSzRmNkZaWXNERVRWQVg1RmMv?=
 =?utf-8?B?YzhrY1NiakJRNlVIUHovL2RCOTMyTlZpYkViV2o3bldKbHFGRnlKODlZczhm?=
 =?utf-8?B?SG5jVUY0RDRCeVdyZWtqclZLZWRpeUxONis2bDQwbCt6cEREMUlZNHgwdnFS?=
 =?utf-8?B?c25EUzBhMDl0a1lhNng3TkUwbHdsVDlvSE9qZG1YR3NMT2ZWejM0ZmhZdlJY?=
 =?utf-8?B?eDhCSm9TTm9pQVVuMUFtNkN1Kzh6anNjb25nZndNOStzYklqZHYyZG1WUnk4?=
 =?utf-8?B?aGVVTEZONk9hbGpsMERmR2ZGNmZmSW5QbXdtakpxMGt5eTZzNmo1ODZaYzJJ?=
 =?utf-8?B?SXg1OThKenB3LzZGWEZkMjE0MGNKSEtkZFBXL1NpRDlQVkFiTWhvQ0V2RE9v?=
 =?utf-8?B?eUltejJabXl3Qzc1MmNmQi9HU2x3SXVSWm0yMzFsZHRKMTI2QVVrejNOM1ox?=
 =?utf-8?B?d3BEMER5bDEwQnpnekQ5ZUNkN2FGVXJsMXhQa1NJbjlqS3VNazlwOEFwSEIw?=
 =?utf-8?B?WmtiNVpHeEliOUVZSk5jVkNzYmdGMGkyYXhWalZQUEdRU1FpdFp1WitxNVBY?=
 =?utf-8?B?Nm1ra0U1dXRwaXZkSE1IbzFNM0xsai9uUWdnWG9OdXVBRkE5ZW1qS1RIWFZ2?=
 =?utf-8?B?UXdGemhjZzhBSHZIMXdCMnFsNGpYSVRVa2tnTC96dlJIcTVtSTB5UzI1cnRr?=
 =?utf-8?B?U0pRR3RTaW1MQVp0SXdjL1dhamJvaXl1d1ZzR0xseno4Vi9pSUVYSnBudzBY?=
 =?utf-8?B?YjRDUnd0K1htTFVGSW11cjJqR3NoSC81eVlNOGQ4R3ZuMkZGQXRXOHpvYmVt?=
 =?utf-8?B?enNMeGVVNzkxUHc4SjFKQmhsT3g1ajd3YkczTUVyZHhZN3RhRTFZa3dIUWU3?=
 =?utf-8?B?Q1J4d2U5TTdtdkZtaWl0WHF6RWJVUTY3bGI1TEM3SHI4M29mRkhwcGdnQ05v?=
 =?utf-8?B?U1JsbkF6cmpjb2VzY2hNM1VTMkdHZFp3enpCYVdSb3I2WXZ3cFBUbXE2bkZL?=
 =?utf-8?B?OFFHZEUvK0tvMWtlUm45NlBmNVFyYlZwUFl3RU1aNEFYZE5KYzJ2TDVCK1VB?=
 =?utf-8?B?ZEZiL2VKL0NMWlRvb2xUT245VytVcVBILzBaK3ZRMytDWW1WZmwwV292OTdH?=
 =?utf-8?B?cHpDUEhTRzFkZHJjemNuQlIzNVp0OE1YUC92N1ZpWGhWbEcwQ01vWFYxNm5L?=
 =?utf-8?Q?Cp4s2O/JdVHFBybevKLl?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6591.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB8235
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cde2ed1c-dafc-4cf8-5809-08dc855f79a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|35042699013|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0x0ZXh3TDkwNmtkOC9vNzZHUlJ4Qmx2L0RqRyszTkh1RWRvQVdwTXZmS0Zv?=
 =?utf-8?B?SjJXNVdsVjVFQjB2ZlJON3BhRmxhL2RqSE9Wb3ROZDFmem8rZmpOR0hkeDJm?=
 =?utf-8?B?d0tCb0NBUmtXeFc4L1QxaEp0OWhVYVZ3cnBYbVMzOVZ1ZUpjWTdNYUVIRCti?=
 =?utf-8?B?NlRxbS9PL1ByTGxhdE5tVmgwRkJKamRwUFdHMHMrcmxsS2MxUEVoYUhwQy9J?=
 =?utf-8?B?dGlMYnZ5UGZoM3Z1bmhncFVXT1RPRE44aEwyNGtxRmpLMFIyUXBteWF0OHgy?=
 =?utf-8?B?TGZua3RvMXNUL2kxc3R5K25ka2tFNlBqQTQ0V0c4NytTeUZNek1abElYUnhN?=
 =?utf-8?B?V0ppUkxPc0xTNjdXR2hDaVRmUG9IREJWdlIwaFNhdzJVZXpMVHJkMlhjOUlo?=
 =?utf-8?B?WnZ3Sk0yTjdSQ2ZLS3JXZnBETWNuN1F0NmNZZms1NDFYWkZnVmFNUjlXVFJj?=
 =?utf-8?B?akxQdUxxeStuNy9tTjFtbkw3UytqS2FnNGpxQklidkU2SGF3L2IrUzBWdExr?=
 =?utf-8?B?cXg0NSszR3ljOXBEZUxoVmlsTU5rTnF6ckhueThOUHhpNXZncTZOa0xKNm1j?=
 =?utf-8?B?U01kYUs3Y2N6bHFLOU5rVHNFK2hPbUlUMHRmYTd3WmdjOWhKc3N5TEFsb0FU?=
 =?utf-8?B?ZnVwR3dkWml2dldOWkVUUnVmVnpvYnZyNDV5YW1zT1BhUW45MWFwdEFHQjhX?=
 =?utf-8?B?K05OU3dJbVNReHdWeGpZSHUrT2dhUisvU1REWXpOZC9ubFVvbkhvNFBWR0xS?=
 =?utf-8?B?bGlCdUdtaHoxN2ozaGwvYjI1WmFnMzZNRXZJUlduZlpFSHU4ZCtzalh1Q3hP?=
 =?utf-8?B?eFg2N0JzdUlaT0djY1hKRkRlNDBVVjV4YnRFWG5lejhNQml2andvZVVvZ2pr?=
 =?utf-8?B?NFkzQytKaCtZQzl1ZU95NnVCQmc2QmpJaEQ5WE5vbXJEYmhKRGRwSGloK0NP?=
 =?utf-8?B?aEh6Z05YeE1GZGxnMXUxVDAzeUFYUW9rT1prQzdCaWwrVk5uUXRyOFdYRTU3?=
 =?utf-8?B?WlZ5Tjl4MkF1ajBUMUlPRjAyRkxkWXc1VitlZWE1NEhBNGNsN2hzZ0E2eGFy?=
 =?utf-8?B?SGQ1aWsrck01UHdnQUJXd3c5UFYyelBFVnlMVEpiRmFVSW5ETHA0cDVhVlhC?=
 =?utf-8?B?WFZuc3doZU1DUWkzczllbmFVdjVlWHFSZ3BLSmlVRTdFeW01YUx0ek9BRlBZ?=
 =?utf-8?B?MnBGcFdKdzRCa2tYRGtoMThkT0RiTHY2NG5mVXhPbllVWUI5dUVrNDA5WjdO?=
 =?utf-8?B?L2pTU0VQODVRRzUxUnJnellYbnNMZEpjZFN5Vlc2OW9ZMG94QnJKWkl4dGRW?=
 =?utf-8?B?NkdUK3loejhtd3VrcW9FSnNDbVhUK1R6bXpSV3IyZE9lY213aE5JZXBMb05p?=
 =?utf-8?B?a0dKOXJ2UnFZK25KeFAzUWkwY0k5SFViSklTZUpkeFhDb1dHZ2lYakkyYTdh?=
 =?utf-8?B?SDNaU2dudk1jRHFBanphNmtLYVhWN2N4bUtNLy85M2oyaDBacEVJL1IwMWph?=
 =?utf-8?B?QjFQOWEwQU9lUXdXOGJpcHJ4Z054d0RnQ0tqck1OS3FvREtNQTFrc29nT3F3?=
 =?utf-8?B?dFczZGlsYnM3dTYvZ05EbW4zbFNpSzdIOVVZOThCZ05WZ2k3VUxGMEUvSHFM?=
 =?utf-8?B?RTZkL1hTZmJOYWVaWFR1UmYwTDE3amdWcXZTRTA2MmdsdnFXclg4ZjNFMnhJ?=
 =?utf-8?B?OUZjK05YZHp3ekFURUtvL2FkR1pIUnlPNmZyVWdwcitQRmVzVDhubzR3RGlE?=
 =?utf-8?Q?UewzrAcsQtV2CJA1NUtaASbAwxjiEnMI534VeXk?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400017)(35042699013)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 13:00:38.7976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a15a31b-caf2-4bf1-76b9-08dc855f7f8d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6708

On 6/5/24 00:53, Mateusz Kowalczyk wrote:

[...]

>> It will be appreciated if you could check if the patch [1] can fix your
>> reported issue or not.
>
> Hi Leo,
>
> I applied the linked patch on top of latest kernel tree checkout and I ca=
n confirm that it fixes the issue for me, thank you!

Thanks a lot for the testing, Mateusz!

Leo
>> [1] https://lore.kernel.org/linux-perf-users/20240604093223.1934236-3-le=
o.yan@arm.com/T/#u
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
