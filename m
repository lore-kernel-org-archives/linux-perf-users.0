Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1084381AF
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033737; cv=fail; b=npZQR6aNowGIJOs/wxAhu0Sz35RbZqvGfOEFOeYHfOR20A/bLZIEoODnoSUn0NsD01xR/7j/Jk6T0cou1r49VcyHuqfwt1RnQKGLsbWVbJQlCcBgU3d0iRZHmVbYm+t8Rgh++dc0N7mqKBSUPdTDO3/k5K/H/UsjFPHqczDMpQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033737; c=relaxed/simple;
	bh=HDSHSQyNw2zZDMh1LnO4KFjA+sZbbueVhVmus63e/UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=moU7C53Syfdp5tef6Kh8u59n4w26moh0r7sQQezrU6GhqLlXgBv5/lhEL3dOhGTbsOYbP4oQuXC0JQxLugcOwjJeoAgK+K2VX9MxURQJZohP6PZPB/JsbLjgPm8PJnAnaqrmmYqKJFtHpmJ12fPNBOGaDXQ9v1L2MBkaIFFqx0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lA3YsU3Y; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lA3YsU3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFjR4c+mnqlG1M+d/AnlHU3oERVPGHjd+EanwujCV3bCV63XGq6UxSEkmy3Eaw3lO1OCkwiS0qBj0eKf7REXWjy32YQ5ZUeBeOgI7AAzM/v4DV4ynr29rrMr+8EJVXPdf3DWC9oVY7SIKq46r9bLWv/IwkOLFWqpYoQmCTdWzG5FVj5uB1BjIbtDHU5nSNfqpy8XYQGdVBonEp+SPu+IYwBadT3vLrSDdscn3kdrxR/rz8OzklmlUOIf+2s5yx15Ua9ezT87SSeswx2WfREwgDLdZvOvl4qZmTGUgcTr6/Nq8I2LX2/JQxz43jp/debS+eMVDUksyFlpVH5lNL0h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaWobpjw478szT7Gi/qrabvJ+6H/TIWAQDyxivIkeEs=;
 b=ongbCibNZU5IIEcznBVIudwckGp5+hLhWLhGjKGCOPuJ0EYeYgEN8M02VDDPxJXLG8yyZLcitt/YQXbPKRWvND7K5CNaQe2zH9XzJ4ZmcE5STcw/vNvUCFx9IoPskggOLqiB9UxdhlP/Pza5XMRskQ2Bvi6yevY6N08WRbYEu8S/J5qhjothF83mQpCGqYzzlq9SODbA5zKHTRIlYTMBgwod1GtOV7b3ZSXZHJ9fjBWIz7qe91mjxubBhCq18XIpzkNqxWBxEuaRcoa1ZLB3+0xTAb/UL+EQVS2/RQww1b8oRyVdAEgK6/8w3mXFDQ5OHOOq2cyBQzSa6rZqR8wwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaWobpjw478szT7Gi/qrabvJ+6H/TIWAQDyxivIkeEs=;
 b=lA3YsU3YOBwSK5DHgyCY0nZpywy74DIzYvdBaa+iGg4C0rkgH5nff5p3kVG7eEdjftrAOS6TXKUfRce9H8gSVrwu7AJRJIRvEw8CrLKC3XK5FALBH9UOWDMY+rihlTDKjMgVhxLwHFHR0zd1qJqEh5S1TPMWtUmT8lfm/Gok7YAAhMmCEasdjcyI5bD2agpSs/7GF1y7l+htJJbCsk4HQcAC7a0VQdf1AnzQ0xMEL13ygzKMNvMmjIb6JL83b3TBdBE/dRDYIfyCJgXyoo818E1eh9iA6IvwRpiJEWHryrKZ271htUtvWuO9VpvyW3i6vFGfuO8aepX/Ij/LcG8xYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 02:15:32 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 02:15:32 +0000
Date: Mon, 19 Aug 2024 10:14:42 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] perf kvm: move HAVE_KVM_STAT_SUPPORT down
Message-ID: <20240819021442.pq4qbfonn5vl4z3k@hippo>
References: <20240809115335.540947-1-xu.yang_2@nxp.com>
 <Zr-M-9mJyJ9G51sA@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr-M-9mJyJ9G51sA@google.com>
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: dfab19d1-c9b5-4580-19e1-08dcbff4cdbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck02Q0M3dkdiT3hWMDd5ZGszNEovdW1hSjhnSjYzM0xjZVJuYmJGcHhDdjVp?=
 =?utf-8?B?Z25QTTBNWFVJUjRQNnhGbC82VURhSjF1S3M1M0dtNGZuVnB1Z3JmYjc3ZmZs?=
 =?utf-8?B?Z2hrLzgwV1JZY0NlYmNnemNrTCtUeEJRUHZZNDdqTllQWVl6bnFZaG9IRE9P?=
 =?utf-8?B?VGFacWo4T2ZOK1p0OEZiZUdSOWtsOTNXemdTWEg0a1BvSHFuNjNaNWJwdFl0?=
 =?utf-8?B?T2pHMGtuaENqa2lFcWkvYmRMWnRwQysvNzQ1ajFPUGpJbXpnMUZaZFdxRDNq?=
 =?utf-8?B?bktRaEF1T1d6NWZodkIzU2RoM29rUnJvcDF4Y2F1UENEWlhxRFBTUDhyWk95?=
 =?utf-8?B?RmVSSU1NcWIrZm5qVEhueXE5TE5iTGpKNnY3TGh0RWFHTW5vTkNnYUhaT213?=
 =?utf-8?B?UVdiY3ZKYVF5d3prUDIzeTdqdEZMQi9EN0RPdFJqc0YwR0owUVVKUC81TG9t?=
 =?utf-8?B?dFJwTkFFaERUZUFReUwwNFhCa3ZuMDJONVV0TnYyUzBsbmtsdm84Wm9oZldJ?=
 =?utf-8?B?VWcwTFliaGpubjNpMzdhNDkxS0NwT1Q0NldGQVU5UExad1JwMnIzZnNyVDBY?=
 =?utf-8?B?Y081QkljUktscjJWN3dKVThSVXA5dTlpLzdDV2JXU1gySmN1ODNTM3dXZ1g4?=
 =?utf-8?B?TWVnakZsZE1NemJuKzMrK3FLNG1aRzFhZnVoOXBzNUw0RWsxdEJqUzd2cHh6?=
 =?utf-8?B?Zk94NFl1N0o2dm10ZjE5NG1Mc3ZGRWdUSXpqNjgzdVdrSkdtUWhzaG9PdnJj?=
 =?utf-8?B?dDZPWUlEU0YxUEVuSFl3N2gvT081eEtJYlNHVk5HK1V3a1hsWkVUT1ZXeTNp?=
 =?utf-8?B?Uk9HalNhRjJVb2VtVHpvejFyUmlCWmNaRjYvQXRxYlJQTE1hQ0QxTndPVmFa?=
 =?utf-8?B?NlBNSUozaVQ4Q05MT2VqK3RkMFNIZUZXZVk1RWphclJJVWtKMHdkNHFsTGdG?=
 =?utf-8?B?YW9rbzlzQzlFY3YrY3BwdHZvTW83UkFnaHdIWjNmSGVGZmk3K1A5OXFZNHEw?=
 =?utf-8?B?enh2UGhOZjBVZWwvVUJlRGpsM1ZzeFdEazZWY0dWNVhabVNoVDNOMGNEK0xi?=
 =?utf-8?B?dGE4cGJMcFAxZXJQMklwblFvSGVxZXhVcG5ZTDE2aWpUMXZYVjBaeDlBeTN0?=
 =?utf-8?B?MnFxQW9sUWNodFdqcVRNMVdDaVNjUlkvem43M3hnYTFWM1pPVXY2aHNEVVpM?=
 =?utf-8?B?d1IvbWlnQThFQVVqTTBBYlk4b3dRcnNoNjZRSnhTUHNWaE4vWjQ5SVEyZCtp?=
 =?utf-8?B?UjZ5M1d6RlpOSG9FQW1XZ3pBUmx1UDhGNGY1Vk5EeFNYbnlKbnl2SjdxMGdj?=
 =?utf-8?B?ZUxmQXlBRk11RDBTcGJCM2NxY0dEZ1VXajk5WENXRy9objdqMGZkZHJjTWYy?=
 =?utf-8?B?ZWx2QTBNaHZWSnBDMjF0b3VkWWh0b2p1Qmpyc05CMHRMSEFsc1UxWFhIck5r?=
 =?utf-8?B?SUZ5K3F6ZHI2ZEx5M0xZZTdXUTZjWTR1amV2U3FGUGE3QjByWVpYL0RpTXcx?=
 =?utf-8?B?Y0lNNzYvTmdwNTR1ckc0VThkVTB3dG9ZRzM1dW5sZ1IwVHV4clVlcEN0dm15?=
 =?utf-8?B?RFNqZ3lKb3FOa3YzRnlDd25yTUxLZW1naTVqczl4ZWhrMkZtNEFjSGQxTkJh?=
 =?utf-8?B?Rnk5S2dJOUZlb3A2ZUVqcEEvQ3B2VVQyTjIrMmhmck5ORmozZmwrTTN5V1Uw?=
 =?utf-8?B?S1QvcHcxOFhqNHdWdmJtclRpNlpCY0F3M25udjVVUzJydGVYbmRrRXowdFcz?=
 =?utf-8?B?QTA2UXBMMmxMdmttdnE2R2RaWmhwZUcyNERaZDVObFhHM2hycldZRnpFc2NG?=
 =?utf-8?B?bS9EUUk5QjdyczBvcmE3OG0xWEExQTNEZ1diU3BpN1BoRFZ4KzRGeHV5eDJN?=
 =?utf-8?B?MGowcCtBSmppSFlkRVJNQVV2UVZMc3ZPSmk5aXlCdzVkY0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1ZYkIvcWhVRlpmTUhmb3lhMFNRMjBWbXo0TW5ZdXJFay93cUdoSkQ5bktW?=
 =?utf-8?B?ZmRHSHU4NFVQZUh2WUFsQko1NG53VENGWG5rUlBSWnlSRVhZMS9KN0F0bWt4?=
 =?utf-8?B?c1gxazhhYVVZL2JDeGJrWGtFdzhDZXZWVUtkaE5CZGY3NzM4aStyV0IvOTMy?=
 =?utf-8?B?dm4zYWQxZ2g3NHErS0szVWRnRjU4aHF1anUvRENiamRQWVlXSklldnRZVjc5?=
 =?utf-8?B?ZHVKYy9hTmVFSlpUWGZ2ZjdOVFhGWTZGSzZtck1MUkNudmRQL0h5SWRTa3o0?=
 =?utf-8?B?aUgwZzVSd0paaGtSUGRYZHJLN2RvR09jd3FQd0RiQnd4M0hwT1BMM29MT3NB?=
 =?utf-8?B?R1ZQaWh1RDBOeEJmY001dGI4Q0tyUWl1RzhnVTNNa3RGd1d3SkpzODJtTFY1?=
 =?utf-8?B?aDV5REl0M3RuTDJMR0tWc3JiZjNBKytRNFZqZldzcXdiSlJXdEdsK2VEd1E1?=
 =?utf-8?B?d0VXSlBJL2sxb040U0FDZ3ZqdnZkUmRVUFBoU1R0REZwN1ZXZXhmOW9XZ0oy?=
 =?utf-8?B?ODRsdXM2Q1NhM203QVcrYkozaldLT2hXbGgzU0FITEIvV3preXVrYkRsUDVI?=
 =?utf-8?B?cDAwYXB1U3BIbGEzTGpqbExHbGlNSnIvZ1dZcnlyUzVyWEpVODBuZGpkUjE5?=
 =?utf-8?B?RGF1S3oxVmxzQVBjZXVSTmExU2dXb3EyWUw0ZkgrTTJFS3VkVkw1bkdMTmpj?=
 =?utf-8?B?TWZQVTZ0NkRmMFR6SUJMbnFVUDRpVlU0R3RMZDQ2WlgzK0U4aHUyVEc0a21K?=
 =?utf-8?B?U3VnM1NQcmJDWWh3SFdLSzB3b2VyWTBTQ1hRWHZYN0Flek5SRmhqWTlQbDd2?=
 =?utf-8?B?WDNINWZGWHlRMzBreE9IVE5HV2g4T0hHamM2eDZTMnN3WGpMc3RaTTBMSXNY?=
 =?utf-8?B?dnRHOGp2YmYzVWdmR1l5eVEzaGlUUWsyaWdNM2U2UGszWENBaUtOR0RtMktt?=
 =?utf-8?B?RkJrMG5pMlBOajZIamNNUS9VdTFJTkgrSVphZ1N5Ui95dHU2SHZ2VlVwUEkv?=
 =?utf-8?B?S0FtSTUrdzQ0UnZ5TkRTT3VNTS9OVUhNaG1CaVkxSllXVk44cE1GeDhKS1Zq?=
 =?utf-8?B?VkE3Wko2UktOVnBaamR5OE9IQWhMWUh2ZHRVUjhQK0RuSXExQ3B1WEx0ajQ3?=
 =?utf-8?B?TVA5V2daWlpTR3Urb2VLZWl4cHNGVDlXeGxVVkxRZzdjbElMN0EraVlITGtw?=
 =?utf-8?B?MDVqQTVQcFk3M3h1S0VteDA2cHVpUHRPS1FFU1UrU0htdlJpZGZjMWFzOEkv?=
 =?utf-8?B?R3Q4OG9EUjFtZDBMampwMEJtbXhQQkNjZk56TmFkYlRtZ3VyNGNXUUpHQ2p5?=
 =?utf-8?B?QlU0ZlNkKzA5bDNpUysvNXl5ZmljSFZkS1FQdEpZdW50THFycjdtOTdOTXRw?=
 =?utf-8?B?OVU2NDQxSERSeTNwSjd6M1NleWFHWllkSC9TcXppNjM1WFZySzVBa1JaV2F3?=
 =?utf-8?B?NXdaZU9ZMFZkWWM5SUNucHdteG9GeitiOFUwb0lESVRLQ1ROTmVHWXF6WFI1?=
 =?utf-8?B?STlzcEpuUm03c2dPaUZwWitYdnVzbDdoRm5yWUhJcm9UYThxZEpkeUswVDNr?=
 =?utf-8?B?SXNrZ2RKWmtKOVNGNy8xbHdmRzJPeFRZL3JqRnJjQ3k2S1pkWGwwTlBNVmsx?=
 =?utf-8?B?OUc0S0g1RVhiTm9IcHIvdFdmdXhhamZTdFZNWnR1QWFWRVZSTUpzMDI1ZnFX?=
 =?utf-8?B?TjVodzQrVHlNU1VCemJhNW1xL3NqeHh5MHVodjY3TkNWTm1jODZQZCszNmpJ?=
 =?utf-8?B?UnBrbWlyMUpvNVVOVDBDNnVKY1VsRjFHM0R5N2U5aWxNNzUvY3V2QXQ5V3FU?=
 =?utf-8?B?Zkk4emZFbjBRem9CeExCcDUvMDdLMHBPL3d4amoyNFBqa29CT2lnMGdKbzYv?=
 =?utf-8?B?M3RnS3ZYeW5kZjJmNXg0QWZMekJ0eG92dUhkRlBTZmNUVTNNekxqNDVnN3ZS?=
 =?utf-8?B?bUNQbmlDRDlmcURDNjY5cE5Pc0ZFZWZleXRiaGFKVTZSTUg5Q3N5S25BbHRC?=
 =?utf-8?B?VTVMQWxob0JWbGMrcFpaTnVyWEFlZEdjdVZBMWFQUmQ3Mzd2dGhHR0xzdnk0?=
 =?utf-8?B?SkJyRlhKT0lWN2I2VmxHRXEveE5mSlA1K1dqWVNQZGtyMHJOWTJPbXl4NEpS?=
 =?utf-8?Q?82zoiTDOhP6ampPSrM0VAOA/U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfab19d1-c9b5-4580-19e1-08dcbff4cdbf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 02:15:32.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f90sn7XXc9rZYEaeWDNFsR3ZIF4EMSrRFFtJ/+/2PXMpY4rCWX3dH1sHR4E54d4z6vqAGxkNWbA46xEU3aWvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718

On Fri, Aug 16, 2024 at 10:31:39AM -0700, Namhyung Kim wrote:
> On Fri, Aug 09, 2024 at 07:53:35PM +0800, Xu Yang wrote:
> > The 32-bit arm build system will complain:
> > 
> > tools/perf/util/python.c:75:28: error: field ‘sample’ has incomplete type
> >    75 |         struct perf_sample sample;
> > 
> > However, arm64 build system doesn't complain this.
> > 
> > The root cause is arm64 define "HAVE_KVM_STAT_SUPPORT := 1" in
> > tools/perf/arch/arm64/Makefile, but arm arch doesn't define this.
> > This will lead to kvm-stat.h include other header files on arm64 build
> > system, especially "sort.h" for util/python.c.
> 
> But it's not intuitive.  I think you can include "util/sample.h" in the
> util/python.c.

Sure. I'll send v2.

Thanks,
Xu Yang

> 
> Thanks,
> Namhyung
> 
> > 
> > This will try to move HAVE_KVM_STAT_SUPPORT down, so normal header files
> > can be exported to source files on other arch too.
> > 
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  tools/perf/util/kvm-stat.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> > index 3e9ac754c3d1..92f1191cd462 100644
> > --- a/tools/perf/util/kvm-stat.h
> > +++ b/tools/perf/util/kvm-stat.h
> > @@ -2,8 +2,6 @@
> >  #ifndef __PERF_KVM_STAT_H
> >  #define __PERF_KVM_STAT_H
> >  
> > -#ifdef HAVE_KVM_STAT_SUPPORT
> > -
> >  #include "tool.h"
> >  #include "sort.h"
> >  #include "stat.h"
> > @@ -13,6 +11,8 @@
> >  #include <stdlib.h>
> >  #include <linux/zalloc.h>
> >  
> > +#ifdef HAVE_KVM_STAT_SUPPORT
> > +
> >  #define KVM_EVENT_NAME_LEN	40
> >  
> >  struct evsel;
> > -- 
> > 2.34.1
> > 
