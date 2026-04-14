Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022097.outbound.protection.outlook.com [52.101.96.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640F396D1F;
	Tue, 14 Apr 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177746; cv=fail; b=C1TzXQM0sCBZnIqdL/g3jjlr2kJYd0A17ageWJU3ccYtBjt9vBd4c65QuqMNKV0+uUyvqBEtQPXGSprTrDNmXcHvZPLGWwP47sivlStN6qF9IZZgLHEwCenYgakglhaEBlB0Na4uzxYKWvfh0wFoaUm8BQq/ImSbeOVkvy6xNrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177746; c=relaxed/simple;
	bh=pWNLgvW1qNMq0etXkUNVCoIBBPXSYDDltWNbv07vcJ4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SJiyNZBcE5qc5s14G7TOxf78Nok7LRqXkP4oYiKZrMGMkZkCBsNQarB8NUiLV8fDQ4rdCCLZ1OEG+ODRZZpOvCjimlo0HPPmjvBxTY7tFEU2sJy+83jwtpV8mPlJ8nWQuejVQ6R4cbDOSOEuNWgN54CAQPKYwTUDhVYG1Q4P5F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=W2VCd5Dl; arc=fail smtp.client-ip=52.101.96.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="W2VCd5Dl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMmVdkQ0ggeQhVv2uVGeQ6IK20NKZI16ezNlv6vcIXtENifgiZbMUOSnQ1+4RUsKHS/AET9z26IgXA4vCmyMY0/PNzjRayinVrpPhnki9BUYWae2XQ1r0vNTYiQipwT7L0L2iQhpuqCC4OX31rKS8SkMSmDIN7/Gx4JOzVae06wWjHc9joYkElqnjjpigRCuQpCXp0NRIcoqYJJiShCQ8nOb9qDM46dPlaucuoeC4yULJdCDA7JGAHyW7TJjWvpwMPRzCyGDpLxLyJa2cRPwqgDQCIHHLL8rr9v3m86WcggzxZHXlh+keqMXI5VctDioCQ1M3DVGT+NWvhB116Z4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2xN+Pt4vFrmY6NYqiXWTOLj3UPsTxNFBNM3RH9vghw=;
 b=SQ+9Ymk1DpJ9Aeh9zPjDFz3SL2UcdSj+llFRL0joHE3IgQoJoRzJPI6IiCTKlRKzZCRq0dzUA64/YDrpnRv+8H+1AO8tdOQp9RCs+VO1/hnFd+0XYkAo3cVB1lEaAJUprm42g77sYqrQNE64Kq2etSvE4n3ZgdXLMHL33NRbLvH10f93DUUHTHyoc5SMuh59Q//S4CZIWbfj4jjPguC08xwUhI/tX+Wez0UA7M90yqUTGkjmq8QN5aqoNHeCWBHWt+S/tqx0o1vqnAMsZFcY3HEf0aeVDEebj9/80coEhxIxVCMU/zE92NhhmdSphUBuWv7WLYdFz3zk95sy7BuTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2xN+Pt4vFrmY6NYqiXWTOLj3UPsTxNFBNM3RH9vghw=;
 b=W2VCd5DlYfF02xwgyiPS8caDD0iY8LDqT55LzUOAOAUPoTfWnPKQdH8H3gVv0VGpkHNr1SssLofF3BzNmQcqjb0XuPEA+ViLPtS19KscvJ9L9YdZWgKhk0l+HoQWfCigOgCr+v1OR2CAxA9+pIB6IEBcWEkdu0/kHYpa/BEeycc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5894.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:42:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:42:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 15:42:19 +0100
Message-Id: <DHSYGL2DY5IU.19MOS6TI1QNOC@garyguo.net>
Cc: "Ian Rogers" <irogers@google.com>, <miguel.ojeda.sandonis@gmail.com>,
 <a.hindborg@kernel.org>, <acme@kernel.org>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>, <dakr@kernel.org>,
 <gary@garyguo.net>, <linux-kernel@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, <tmgross@umich.edu>
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
From: "Gary Guo" <gary@garyguo.net>
To: "Dmitry Dolgov" <9erthalion6@gmail.com>, "Namhyung Kim"
 <namhyung@kernel.org>
X-Mailer: aerc 0.21.0
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz> <20260302235821.588686-1-irogers@google.com> <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y> <kr2bfp43sqatdssmhzpmogs2h27ddbmegvaknxb6by24n2t64h@hv4m5myvswpa> <acts0fXgsuirBp9G@google.com> <wqmqx6rnqrociriliyojihkxi3llractltkfcwznzu2g5gbieb@y7eaaiee5x2o>
In-Reply-To: <wqmqx6rnqrociriliyojihkxi3llractltkfcwznzu2g5gbieb@y7eaaiee5x2o>
X-ClientProxiedBy: LO4P123CA0239.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: a348da9e-9f03-43aa-894e-08de9a34084e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EnT3HrCQvtnTFCmiDGTpTQqYGxSjjMX2DOMy6hCXmIW5NEZLzFcd8WwPfkbCU/XBLOIBZoaJoj+xpKANmjhVo3PmX4SXrlIaI0xOIi0pkEJ0N1dE9mOdY2SOIhdX4xXZKRdp86VvN65m+LT6tjcwgFmlflys0xDYmE/99FeeJklYvNtDThKm3L0KRnQ/gmyKb9DHNDXu4JIF4VvKW9nCr5LLl4hpm9zKPlfjnRMwhpKZNBQOiqS7Rj+hPFEoV1WvUHIIJnUDKbbEyqmgunYo0vx0MuxqXuUHULCSgKCtz2hsuUJPRdsgtV87H3+O4JafE8Ah1da0gimoW9HcERamMCba+I3vsiKTZBd7XUtCFdDrr4u3K02Its/Qsar3ouCg7oksGe/syWYpaZvraJQrQEpu5A7wiW+UbmeguJi31NhD3Ss2od6+T8pMru8ZrrRnvEtBTaHWcqXQaeAzXSPz8P2KkQ35kUIsAnQiVFeXW2TtVuW3PO9qritZtqsyj9GXvQd9mqqO9IzKvFkJ/hchpV9dt/GX1qjkkHgr1dHnMoKI8xxL9+9Oz0PbDSMv1edbiW5jITt/ZOrVcjl1O4Hw04z9z58sAhhuyCQc5MX4167RvTrBGaDWILhkPTg7i9SdKhw9AuXR9X7uOD/ZFTZEkC2VyIk8D4PgkBeWaXQ4Nggqirzi3RPHFVJDqXgukep7xlMMwTFIgdd6L+zy3XJDRButZ1c4LHbFTCQuIEvR4wU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmpidFNrUm9DY2FwUUI2dnRjcmF5aExielZtTmRnZm1QTVkwdkZsNmR1ZDNP?=
 =?utf-8?B?bWx0RkZSNTFuQUFnRWZBSzJwclNCRXZod2FqRFVxUHFEVGtQNTNJaEJtWUZ1?=
 =?utf-8?B?d0xuUkE3bGhZTy9CVWJQczVBU01iZ2lxU0V0eDVYSHp2ZXc3dGRGOE1OYjdn?=
 =?utf-8?B?UzdCRjhUL0lFYWlhYk91M3VjMkpzUk9saVpwUHViV0w0ZlJ2a2tPdGdpeGFy?=
 =?utf-8?B?S0Vlb0lsaDlCU00zV0RwWitGd2FOdGF6TGhQM2dkRmx2ZTRIMlZFd0o3dkgy?=
 =?utf-8?B?ZklTRldrUGczRlFNcXFCd2lUVnkvaVpuWVlOaHZvQjdPcGVPdlMzcnN0MDZz?=
 =?utf-8?B?Q0w4clFZZjZXcWg3M1l2dUtRSk5yTUdMNy9yUzdUQjdSeFFqSE5KdmMxK3Bk?=
 =?utf-8?B?cHpBelc0cXZabjVCYmNhWkxHNTM3MzJhSWFManptVzFoMFQ4T3hJbnhqSi9I?=
 =?utf-8?B?bUdoVXZxV0JTNU41MzZJaWYwamJHZ1JjaHQyWFVqcWhvelZ0aDI3QkFZdW9P?=
 =?utf-8?B?NysrM3FvRUNMR2krVlhqdityek05SW5WemkwdUxjTDFLZ3BOSkdlaWhFMHFx?=
 =?utf-8?B?Q0NwZloyNVg1SXdrajd3SkEyN2I3SUhPWm1YWVMxL2twRFNnQ0ZJbmJNV1Vx?=
 =?utf-8?B?UmxvMnFaMThXSG9iR0Rka3kvYllaWG93SlFVN0RmUXBSZ0cyQm5nR2lyK1FU?=
 =?utf-8?B?K3hPWWNDUlljM2kxd0VveVlKYUZnTFl0dFk0ZmJWOXc1ekdKOUNTU3VWWUxJ?=
 =?utf-8?B?Slo1QTZmRW43WTFuTE4vOXJ4bktkOWMvYUUydUlYL2JtVWM3Q1VuWGlJdnM1?=
 =?utf-8?B?ODhHNWJ0cXZlR1BnWkZUeE9mQTlaSTlrbXFWemtlbHE2c3E3eEJBWTRveE5R?=
 =?utf-8?B?RWhib3o5d3liZ3djemMxWXFvM0lpeDVENkszS2VuWXRiM0Y3VnhKRkdlaFZ3?=
 =?utf-8?B?cXgxMHpFYzd4MkMyUExRK2FncnJEVjRyOW1TNHdhRnhEWkxwT2NmMUZBNWw5?=
 =?utf-8?B?bDM2Uk5MM0tVakRPbzVMRndRcXc3b1V6UjZkS0F4ZGY3andZYmc2R1R6SlR2?=
 =?utf-8?B?bzcyTm1HdDdPdVlLNzJQNHJxbGVLd1piQWRmUWdQUDB0NFhDT3lQeUdXOHJJ?=
 =?utf-8?B?N1VxeHpKWHN1ampZZzVBU0c1YkhLbjF5L25PVVlTeFBJVmJTQkVCN3NkNm1w?=
 =?utf-8?B?c0kyaFhWdTc4ZkhaMTdxSXlIbk1SeURIeVY5Q1lvc252TkZ0N1pxZEdJaDdt?=
 =?utf-8?B?eVVxWForM2I3bCtNVVMvQnNLTHZ1bEpibXc0NVdUWGdWNHkxWjlEd2JuYW9B?=
 =?utf-8?B?eGhSQXZsd0VMSU1DZ0lVT3lqZ3JlNURUL09uUEkweWJSMXovNjJvSjZEcWlT?=
 =?utf-8?B?cDZ6SmZjVDNlVWE4QTU0aFdvM2l5eVdHZVU3STJCTXNXZ1pYMkVPdGZBSUpi?=
 =?utf-8?B?Uk9BbC84dnhaZW1TVkt3cVBjQXdieUFhRVhCeGdkSFIwd2dCeC9YMHZKMDFz?=
 =?utf-8?B?N3FEUkE5U3Y2WlZkc1dKM3hxNlh4QUlZWlczaHNWRVc4ZVQ1WDFMZWlCV05v?=
 =?utf-8?B?aTg0dGRFTkZYSDg2NXdUVGhZczRDNSs5MklqWTlFWU5RdVR0UExSOUQ3Y1Nx?=
 =?utf-8?B?OHRTdWtKZTdZKzRITnFlQlVSTFRDMktROThkM2FFSVBoVzNabzltM01MeUpv?=
 =?utf-8?B?a0ZwTkg0Kzd3cHRVeHdzL3RoV0ozOVVjdkhTeVgvZE52ZnpKMzhBMG8zQ3pQ?=
 =?utf-8?B?SFVzeEJsRWh0eVB5S0tmcXJPZFFSNFZEN0JMMXd6bE5oWHBCSmdpQW1KZFVW?=
 =?utf-8?B?OWFjdklMeEVxYUh6SzJFTnhyUjVjejBid2dpei8ySks3UHlldlZETVZ1WXZF?=
 =?utf-8?B?SDhRby9oR3hpRnlDdHAzcFJCNFUrQThPLzdEd0E0Q01ybzJ4cUNTTU0xcVBh?=
 =?utf-8?B?MGJoUTJ1ekduMzk1ZHJaaVYzWndiWmhKRVN1eWZJemcydFhWSUJQbS91cE1Q?=
 =?utf-8?B?Y2JieU9IVGVuWUc0VTRNK2tyRHRYUFh3TERIUU9ZbmJZTm1ZYS9iVnNSeld1?=
 =?utf-8?B?NncxQVJPUHlpa3RnWXd5QU9CTEtsaHFrQVVwL1QrVUgxakVZSGlhbWprdnMx?=
 =?utf-8?B?T1p2cUlXSnh1UXhSV0l5cHg5OHo4QlUyczkrblBrWnB0SENUWUNSbHRXaDBw?=
 =?utf-8?B?ODNlTVJKK1dEejA5NUlGVXZUdzY5d1QyR0FodGJOdkF6RDJBaytuRUVBL3pH?=
 =?utf-8?B?a2xpSVMyR3dMU3pYN1hQckUyL0dsZzJ5aUI4NllmT3FQQWRBT2JXc2tlOHZT?=
 =?utf-8?B?TzR3R2dLVWVGaUNnRVVGYmtTbU5rdkpPanNiQUlUN3FsYjgxQTh5dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a348da9e-9f03-43aa-894e-08de9a34084e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:42:20.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9I75EtFpyvHYwFSI8WNRjYC69O3qupVzt1ID1UXQTm8c75wyGVMzA9VsBz0QlC7Wd9e0zTZwWcz+e7PvH15Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5894

On Tue Mar 31, 2026 at 8:22 PM BST, Dmitry Dolgov wrote:
>> On Mon, Mar 30, 2026 at 11:42:25PM -0700, Namhyung Kim wrote:
>>
>> We have this:
>>=20
>>   Dwarf_Die *die_get_real_type(Dwarf_Die *vr_die, Dwarf_Die *die_mem)
>>   {
>>       do {
>>           vr_die =3D __die_get_real_type(vr_die, die_mem);
>>       } while (vr_die && dwarf_tag(vr_die) =3D=3D DW_TAG_typedef);
>> =20
>>       return vr_die;
>>   }
>
> Indeed, I didn't finish the analysis, fooled that the diff was solving
> the issue. Adding DW_TAG_typedef into __die_get_real_type still fixes
> the problem, but due to different reasons:
>
> * check_variable calls __die_get_real_type directly at the beginning and
>   stores the result in type_die, which is the result of the function.
>
> * if it doesn't resolve DW_TAG_typedef, the flow goes into the
>   die_get_real_type, which stores the result in the local variable
>   sized_type. But it never copied into the type_die, and never returned
>   as a result of the check_variable.
>
> Hence we either need to add DW_TAG_typedef into __die_get_real_type, or
> copy sized_type into type_die. After some testing both seems to be
> achieving the goal.

Why is the code in `check_variable` resolving typedefs itself instead of us=
ing
`die_get_real_type` instead?

Best,
Gary
