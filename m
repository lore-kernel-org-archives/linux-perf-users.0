Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965A199FB0
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708180; cv=fail; b=SBIeF2LIcW2+EryEykkFj80zihVOFv23dwW0DqShSpJE25xkD0Va8AOijAeekGDz79nraCX45Drzlt6saOQOI2rs4Ozd0QP4T/LMi4jH5T3Q+EwCjOZrLhdpmmmlJNUmYY9NdeOzkPOWnMSS4jMm1NSmGUm31t+b4IohRr/4+C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708180; c=relaxed/simple;
	bh=b1B648dt/ZYoaK2UJZwtq672AkKzilyG33CX1sxp5y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLMnFb9Pqw5OvEytIEf/2FPEz6/0zvvh8gsHnR/z/hemUiE5c0yaOXD5oPs+oE6d6JVGWOPcDnY5c+8p0TThy2BQcSFqKDrc398ROPQOXcilGCCp9Qh8zq23HvZUIf9MrLm9OfByeJNIbDA5KKtct/2KkGSMAWBHJo6B56ZcAF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SQOoDXKT; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SQOoDXKT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbAAnIBred+LohYXuP2aDjR+Atakde1rH0ggUQI/edveZXHwCjaQzsZDfvDhKvMD88z93ZIMDSwiqhTFe5YCEd9tCT8m9R7k79X4nLxx/p0ISXuPFKjq9gnb5vEm2sPTpE3CI483uu0KDl5/oeMeS+Dc3osiIZVt2j9+GIpJmVrNbPlUmdvug+r0ZwreLjWTC6RpkZfZI5h7EdtTASoLMhh6hl8hv9spFjJiEvQaiB4C9e7trvmGx/2GD5QVuzpBP9Uu9ceq9l8bTmJlXm6jinDFjFP4Gkmy9w/ICyKz7ORkueTRn9X6LtgLb7h31OMGfUv1gBChaVBtTO4L2XsCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km8og+hiPSrPx2C2G04skv78Rnp+hmQlSQWFlkL0/rI=;
 b=jiaslaN/BPb+rVO8sh5ZjaRPV1woyzaOxwVg0mw5jVqmOV3KYP2vLn3Qz+1CbDrsvj1ei7Nt26/31lFvOJ4TcwU4V2YWWWA1xF6t9P/S/uxtmCZuSpldVczWRuJ3vBEQR/OgQkcl6OBtvCM2laS32a0WzaxSmp76+VZPozQ2NiBN1nsDLYZ2S7C792CL+dTPMJ/pWtWZ+sZ3tbFjUZwWsA/bsYIKiO+zEhIf32j6P6bwXiINx2PjyGwfhEmuSPpRpekQZe/ZWC6ZlQbuMv3/ae8FQX8/xdPJMBA+bkJd15MT4FsvCJTDUS8Qr9syAVZwK2g24sjKG3wBGbwjUSaenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km8og+hiPSrPx2C2G04skv78Rnp+hmQlSQWFlkL0/rI=;
 b=SQOoDXKTuK8QWZcYbfJg3omebHXWPon9jE4EOS7VWz+NhzfOrB98aqPQWRjkF/JLQkPTtqzhMeKcSlfFJ5xcwN+58cW1TrVpImDKDg4a4U0nGi9bHAaWxzPYeRf3HfT2cZQ7yMbPSBoUJ5QmTrmgYRn2uQoiCh6VX1hLWGpGJfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:36:14 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:36:14 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 5/5] Adjust objdump start/end range per map pgoff parameter
Date: Mon, 26 Aug 2024 15:35:52 -0600
Message-Id: <7bbd5ca482b052d1c52efc52742f5c2713d5c26c.1724698250.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 965ce373-0d56-4f32-d6e6-08dcc6171c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEIyWll2bW5VK0U4SzFMRjFOYitNYW11Z25ZVzlCakI4TVREaGprUFErR201?=
 =?utf-8?B?c0MyOTRSTGdEeDVYeVE0NTRhT05YWVNEUEx6RVM4NWR5Mml1bUZlUjUzb0NX?=
 =?utf-8?B?K0Z3SVZqeE9RcCtwekxBN09WOU9WNkQwMUpZeXB3ZHpRVHdnd3JxUHdIRVZ6?=
 =?utf-8?B?K1JqdE5abjFId2cxdnRoQUJXNVR1cWk1b3NiL0cvQXRSaEJ4WklOa25iUG50?=
 =?utf-8?B?aFAvTlRqOWtRRHZLVDBxck9OUjdtYnNINGhWNGtpdnpHRDg2Z0RINWxHQTh1?=
 =?utf-8?B?ZXVDN2ZPbnBGTytmYlpGMzFCTGJ0YmdQOFBSWUpxRjJEaTRBREJxaHBoRG0y?=
 =?utf-8?B?NFNTVk45alBVZmo2R3M2ckNnTFFZSW5mNklqdHJTQnl3Rm9QZ2NsdE94VHdS?=
 =?utf-8?B?YmJEYmhpV2YzeG51Z3VzSFlLL216TjNWSFUzbDcyQk1odERDNGxNMVpvTk1N?=
 =?utf-8?B?RUcrM0dxdnpONjFVdUhIcXM1bjFOL1haSmFyODFwbDhwYWZ2VHNzUkZCM1dM?=
 =?utf-8?B?dzF0cWZ3cnRvRDY1WFQ3bWEyaGJrbHI2YnpYTFBpZ0FXL3IreHpOT0VXcDZl?=
 =?utf-8?B?Nk5KZlpMVklIeTNjejByaEpzSUJoTW9YUWZMRWNxdXFnU2UyaVZ6VEhPTW9x?=
 =?utf-8?B?R2NOaklJaGtVQ1BmMW12cStSQzRRaFpFUTdrL2xlNlUvMi9LUFpxZDdmakNJ?=
 =?utf-8?B?R1dkWk5SSko4dWUva1k2dFJkYWRMVnFzNG9LY0orRDNwRUZYU0lNS2NIbjI1?=
 =?utf-8?B?eWoyeXpmblAvODh0WW9VY2lLaHJ2K2xiSndDWlZqMy84akYwQjJ3aFNTYVJ4?=
 =?utf-8?B?V2dheEthNlY2SS9nZjVjbmh5VkZndTBqYUF5YUowR3hGRDQvOG0vUnJKcVZ1?=
 =?utf-8?B?QnducElSdWhlOW5ISDRYNlhzWEtQNmZOeDR2eWxjaWZMc0JIMlJtVVpPbk12?=
 =?utf-8?B?MlJXdTljdS8zdldPODZZZHovUzJYVHBYeEtQZGUwaGlFVGhDVTVCNkU4bmh1?=
 =?utf-8?B?VnFRSElacURDZk9oVU9kWjRqd29SRFBzYU5ITzBiQmMxU1EvWnlSOXRValRO?=
 =?utf-8?B?TVpsK3pTdkhYQ0JCYUU5Zk81OVYvSEkwWEZiZWtwcW16ekI0SitVQjQrQ2sr?=
 =?utf-8?B?VUdsNHNNL0twREx1Y2U3NkZrWWtCcTJmZEErcjlJMk1GNjFqbHllZTg4STcz?=
 =?utf-8?B?b1lkL1l1NzlMZVlqTmQ2SXdsb29lWUxUcFA5aUV2RDZ5VENWbjd0UGUwdlRD?=
 =?utf-8?B?NDBINVJsMnlyMTZGeXArbjBZdWRqMDlkR3dnQ0NvS3BPTmcyZDNlZm55WVFm?=
 =?utf-8?B?WGwrT0dMZWZWcGRYMTMxdlU5dGtEcmVHT2M1ZGRlSmNiS25oS2lrcXB1QjY4?=
 =?utf-8?B?OVRtcVFqdjJ4dGl6QmJka3MwWWFZa0NudGVKdThoNlVLaVo1bktsQkM0MDFn?=
 =?utf-8?B?b05iaUkwT0MzSCtpaHFqYmMxNlNYYkxzR05PQnMyQmlyK0p5em5ZcGhJS1Ux?=
 =?utf-8?B?bkhPeUxVUm8xVUpjblBwUWp3QVFEdGxXQS94WEM0UUwwVlBSQWxaRUxnWVVo?=
 =?utf-8?B?MFB0dFhSbDF1RlBnaGZlM2E1b05uWm1uWVMzNXJqUFp2RzB0anp1bVB1OExR?=
 =?utf-8?B?cW5QbGlpZHliTnBxaGxsS1ljZS8rdEd5S3lGWkMveXA5UGF2WUhDcFIrR1JO?=
 =?utf-8?B?VDg4U1RJSTZkRVZhTTBwUGhFQmJZSWp6TzZQSlFvSnRJaHVLdjU0ME5PamJ5?=
 =?utf-8?B?ajRyS0dMcWorUzRmV00zSncyMHB2ajBLWlB5MlRuSWZKYTlYcFl4ajVjTWpo?=
 =?utf-8?B?UFZqWndmdEpSMXZEUUhkSGh6YkxmQ2FGTGd5VVVOYTAyaTdlNS9HbGFTUkFh?=
 =?utf-8?B?dzl2RTBOQjBlRzNtbllXU3N0dmJiU294TE9LcW5IWVoyenc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBxdUcvbFQzek1mZmJ4VnprelZrVi9aOEdaVEVLZ0NaVytXcnZWbXlqTk9N?=
 =?utf-8?B?UnFtK0hOcUE1WDhRSTBZUFhLekxBcVkrT0xrSlBMRTNEZk9BemlqamJUemJG?=
 =?utf-8?B?Y0VqMGVmVkl3YlFoRmdFYW9LRnBQYytmTUZWOHBPVjBpTXBhTXhJME5JUkdn?=
 =?utf-8?B?MURrK283NERkUUFvc1RMUk9YcjQ5SWNwYU1CS3U1S2ZFMGQ0b3VyYlBnT0Ji?=
 =?utf-8?B?SkVKc243TkpSVlVjbGNRblJBZk9Mb0crVjlZRXAzZENweXVsTFdRK1R5QUIy?=
 =?utf-8?B?amxFTHpxRk9BeDhWYkt0YXpQSDJkYmFITVZaTlo3ZGpwMmhLRFZWN2I0QkZl?=
 =?utf-8?B?aTYzZE84T20rVHFub3lJZmVJRHpMY3I2bndjc0VJNjZlVXYxVWk5M3dYTUpq?=
 =?utf-8?B?N1ZvMWpFL3J3TmpGOW1ZanE3ZUhnZ3UzOEpzWXlqVUlsREFSZ0t3YzJXeUdy?=
 =?utf-8?B?b2JJSmxMK1c0blNORFN4QnpoVnNwS1JvZThZbXo1MkpHSUVHbmtXOTliL1NW?=
 =?utf-8?B?RVF0ZnRad3haSVhjcjFEWEtUbDk3RVA4d2grV29HVmtROFJiTUczWVhyNkVq?=
 =?utf-8?B?QzFwemM3MEpVWnh4SmhOWkdDUExxbmVNa3Z2YlIxMnhLLzNibG5xejE4VFVv?=
 =?utf-8?B?VmMyU0pBZklaeFNkRGs4TVFTNmhVZ0RxWTR6N3ZjQ3RGZjZ0SW1oYUwwQXlv?=
 =?utf-8?B?ZHBnSzJLZnEyd2NIQzR5NnhoVndlT3RhcnEwQ2NUM3F4eTQxaUJLZmVIRXAy?=
 =?utf-8?B?TTI1YVJPcHBGRE1adnl4aVB3VEFnN2VSRHBBUTEyOUx6d2I5S2lRa1ZJYXdI?=
 =?utf-8?B?YVdIN0NIV1Iybml5aU5GYWNjanFhRmFjcmJZdHdmZWdRWXRGMXdjZ0RSOXNs?=
 =?utf-8?B?S2RWYWNpL2tnazFmSm5NQlFQbncvMTV5RnBabUtCU1V5OEJMa210N1pqRFU2?=
 =?utf-8?B?RmZaczBzUkl5MXhEMHZobVBDMGFkL1Z4RmVxT3dPdW91enlRdzZ3TGdoRWhp?=
 =?utf-8?B?T3R6Q013Tkg2Lyt6Q3BhMTFEUkxMMlkwQ2U2eWdKWUl0QjhWdkYwb1RVc1V6?=
 =?utf-8?B?OEFTT1Y2MUhnL3huUEZiYTlrNkhkYTRqR3Q0ZDYwcEdqOXdUNm5JdVhmblpz?=
 =?utf-8?B?TUJ0K2VUVXo3cGZ5L0pSdmZJQjU4bmpBNzlDWFVIK0VwV1BXVTlxMG02cXR0?=
 =?utf-8?B?SVM3YUFLMzlSWUF3cTB2VTliN2hLNVVpWmhxZ3NoVXFaOS9GamZDQ1BPL3My?=
 =?utf-8?B?ajduczBHT1hoa3ZrYmJoS1J3TEZJam1oTlFta3NjaEs4K00xdFNnTXpVamdG?=
 =?utf-8?B?TUVFNjgrVUFvRUlsMzQ3MWQ0OUJ0cFZBYW1peUVEZjhxS2NibDJWZGc1a1RM?=
 =?utf-8?B?b2IrOXA3UXI5WXgxSENOOVB0Y0xDeTZaZnBhSUk4aEhCNzQzdzhQMkE5SUx3?=
 =?utf-8?B?OFhCejh5Q3dOdW51eERwbWdYMFVSSXI1M2d0MmR5UTh3TTRWclFhRlQwc2k1?=
 =?utf-8?B?cU9DM0FtR0xYMU93dzhmbTVneFRHYlZrbCtoY0trZ3V2REtkTFdFK2FYbWRC?=
 =?utf-8?B?MzF0V1FHaTR4NERRSUpybEgxMkdnaFZTQ3VzN3Rlc29OZ0tZRGxTVndXaU90?=
 =?utf-8?B?dHU4VkRXUmVaN3pLeUpTMzBPeDNZYjVHbko3RFZTTlo2U0s2bDE0RUlieUg0?=
 =?utf-8?B?cUFSMkxSbnpNaEpvbFMvMWxlRU5OaExGVFFtSnVndlcyWmJPakNNdVlnWnBq?=
 =?utf-8?B?RGxWdVNSM2QvbnVDODhDSE1sdTNzMXVhT1hwNGRRM0xENDhQMkM2elNBdGNP?=
 =?utf-8?B?S1gxcUk1Q2w2eFpGZUp0em9IZmxtdG9FZkNzUnRzalZIbjg2SkhDSlpLaVFC?=
 =?utf-8?B?cTkwMStDb3REb1E2OC9nckdyUTIvb2ZqWHkyRjQrTTNZREp5d0JvSlRHMW9C?=
 =?utf-8?B?bkd1d29XNmFBMWl1MGVucktCQ3IrdC9jbVRzdW53VUNtRzlJRXRvYW5mWGo5?=
 =?utf-8?B?OWcvY1F1MXJXL2w2WncyazBDdzQxb1FBV0JmTUczcDRabDlFL05RT0RzUVdR?=
 =?utf-8?B?RXBoVjd1ZUIzSEZiL1BGbUJXUDU1aXhCdEtzUTdWekJMS2pvTzVPelZBTVlu?=
 =?utf-8?B?eGd1WmtOVUhqWkM0VGt4MGZKblNnaGcraTNHSmxHMzdFeHphbVZwajZ6Yk5k?=
 =?utf-8?Q?PIBjO3EHMtESuZRIj0S8BEeG/Ac0NwuxA3jqfe7uBKvw?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965ce373-0d56-4f32-d6e6-08dcc6171c76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:36:14.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHjxdtH/iXuwn5VnOy0aEJLRC3G8EtmME4WloGckAt+rD0JGJmbC7pr2pdcXqdEYCZTQbyfKrXx+B5n2yEcomjGUAbadoXYsvdChk1YE5mFNaEM/lsed9BUZPX49WiP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Changes in V2:
  - Updated mailing list distribution

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

The start_addr/stop_addr address checks are changed to print a warning
only if verbose == True. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 .../perf/scripts/python/arm-cs-trace-disasm.py  | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..6bf806078f9a 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,7 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -250,13 +251,25 @@ def process_event(param_dict):
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
-		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
-		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
+	if map_pgoff != None and map_pgoff != '[unknown]':
+		if (dso == "[kernel.kallsyms]"):
+			dso_vm_start = 0
+			map_pgoff = '[unknown]'
+		else:
+			dso_vm_start = int(dso_start)
+			start_addr += map_pgoff
+			stop_addr += map_pgoff
+			map_pgoff = '[unknown]'
+
 	if (options.objdump_name != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
 		# for kernel dso and executable file dso, so in this case we set
-- 
2.25.1

