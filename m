Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D651B218D;
	Wed,  4 Dec 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315708; cv=fail; b=DVLeXrnoX/zl3mhyC6k3u7FOQdh5Rnrcu/8/mr8K9t2DPVuQt+g7rhAlDs+XuQMNQC5CrvTNdwmPCmQTGsrLIGbMsw1tNy81V3jrTLzRijZPuUtdyuf0Nu4/SX77CSGf/NViEGOWmh0QCGKw1s/c0n44gB3jKY55P1rFohLNB/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315708; c=relaxed/simple;
	bh=mHotFvAI2S9rmYZmZqADFcRm78u8LaaoPwJ41LRxmOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWwne0t04A9DDOl3gRhWmJiSXp4XYRnTXac4kWre9xjvUMu/xlZImBF9GbfyhcCn012Fm1i2JMv3z7+Jl/GTfq4CI3up/aDRXX4e7Chxx4uCkqy4TxkMEjnEFhwFu1h/L6oUUyA97xRkX4NeHaFCC9vK/4FZNLlFh1ymUtwCyuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=EHcWo80I; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="EHcWo80I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msetTvEvdpxaT443NiQEj3e9DwSGG2RkSzC3H0ltulOou5OeR+uE/37U2OMaozW+spmf65OcBJll5JFrsg43W5BNOIRpNlDF/1+xJHOGh1dvjZG/CoaP4vfi9MftF/7LqjD6zefJGakn40llWj9+WMXAKiLAXH3CJGtCqYb6KSI01lZpJP4XCHVKMr2eCXyMcHed6lR137ox0y7pCcO7OWKGl76atuPdy+WchvPMrycG5O1109UPONFpk0mh6Jp8QNb6MnOd+Pk8kPbC0eHucJeIQID19X3vFFXQZLY7p8JpM45kEA7aU6jMR88kG/1SgO0fQTK4z2FgMo/U2gMcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18W6p2x3QNuSJr4LMl8OL5JG5ggnYJ1HKcJ5qImAYj4=;
 b=dkuIYMokTh/EADJrfpk/hmyntvVjJ2ghtrzEBf8NXwHj4wUEtSLu4U2wdwgj1qkfx++HIQFxkV97c2x2nKTlI/QgeZIeZS+xkyMGNGjF5/Xp88qYbRg9ALwSaOoqXgNLIebCWb7fGp+ICTJhMrpfsjw9lbkEhl8hJKwap+dlzJNsvMAlKPrvo0UUzjtatKQs3iQkOYt+GC4ON4AJ0YA5ukZrOQAUpHz6Jq1esteu1uGVt74LcU/+3GXPDBg6Mlqz1hzcvCWasUS+16nxWzdGQeP98B5egQb89STm1z413dJCddTcHSbYNUdff6uBTi4S+lrpHYEvJgCOo8uc9/LAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18W6p2x3QNuSJr4LMl8OL5JG5ggnYJ1HKcJ5qImAYj4=;
 b=EHcWo80IoYXrt0rhZVfvGwSvSxk9kK4Jw5/YGAevR9TKmcvmlUVhwMPEnJi0gMbkhKTFeY09/YZ5GlS+rXG1q3wIti5shszOGi/ShIaUcO4HPhC1Gih7+/uqgEwKJted3KujF9NuWvjpm9If0cJlsB1Q997iVC1Oq25N1tbopwFiN3T2sbCl7eOkyMLN7LQakPv+7fcrA7pkMRwWdhNwwFCrQo3WvIjdOcxwLCHkZBrTCYyK00FfbtQmn5pTAunU9TyBd0fAxLX0M9UxDGlfCr5MFK2d26pWbMYOqbJ9nT+SGxL/V5zOv7aTEt8Wu73WlRzrd9PLwtvtkyhRydQbrQ==
Received: from DM4PR08MB8723.namprd08.prod.outlook.com (2603:10b6:8:18e::7) by
 SJ0PR08MB7813.namprd08.prod.outlook.com (2603:10b6:a03:3d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 12:35:01 +0000
Received: from DM4PR08MB8723.namprd08.prod.outlook.com
 ([fe80::1b43:5e75:d80a:b44c]) by DM4PR08MB8723.namprd08.prod.outlook.com
 ([fe80::1b43:5e75:d80a:b44c%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 12:35:00 +0000
From: Ajay Joshi <ajayjoshi@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>
CC: "tongtiangen@huawei.com" <tongtiangen@huawei.com>, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>, Vandana Salve
	<vsalve@micron.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gregory Price
	<gourry@gourry.net>, Huang Ying <ying.huang@intel.com>, Vanshika Gupta
	<vanshikag@micron.com>, Vishal Tanna <vtanna@micron.com>, Aravind Ramesh
	<arramesh@micron.com>
Subject: RE: [EXT] Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Thread-Topic: [EXT] Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf
 driver
Thread-Index: AQHbQOpOgtfqyDqMokmqioKvHHv0ELLWDzqg
Date: Wed, 4 Dec 2024 12:35:00 +0000
Message-ID:
 <DM4PR08MB872376D462954B3C3BF1052AC5372@DM4PR08MB8723.namprd08.prod.outlook.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
 <20241127163426.00004a65@huawei.com>
In-Reply-To: <20241127163426.00004a65@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=bfac8381-3407-4923-9ce8-4fedc6ef6fa6;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-12-04T12:32:05Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR08MB8723:EE_|SJ0PR08MB7813:EE_
x-ms-office365-filtering-correlation-id: ecd994ef-3a47-420c-e09c-08dd14601208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?dDRObkpySmkwVEFKQWV1b3FVT1FmRExnQWxzWmtrYUJxd0VpMWdpSkdnUnhh?=
 =?utf-7?B?Vlh4TUVDb3RIMzRUNHNjMnZmZlVUQnIvVWY5WEt1R0MyVUE4bHlFS1RlSjlz?=
 =?utf-7?B?MzNFUEdtS3VPTHIrLU5KbjJjRFFzSystWUp3NjF4QS9ldmNYdEgwelc4Z3Z6?=
 =?utf-7?B?SVFxOVBtMm9wMEswcWtNQUZzN0h6eU1HdDBXU0VncUhHbGl3dmFKaTBEaUZy?=
 =?utf-7?B?QkhaZHRqUHV4ak5IdFdIQ2ZVTHU2NWR4TEd2OUxxZVVKbkZJTVZXM3FISzhn?=
 =?utf-7?B?RmNtM3grLVJHdSstL3pXQmk5OGlzRlVoei9YNXVIT2drQ0xCUHBQRnc1Y3hk?=
 =?utf-7?B?WnliU3pQTG9yTlVrTXlJdkNBZk5HalByQU15c0NxQnVCandJQWxrVE9VNUhQ?=
 =?utf-7?B?MmRzNzAxcEtUMzJxd25ab1ptMWFZVEpXVW1ib0QxTWZwV3NHSkRuYkpmVkpr?=
 =?utf-7?B?aFNpWjZadzVUdWNsRGg1c2ZaZjdGTjFrUHo5WU1KeDZWSkkzb1BvQklpb29z?=
 =?utf-7?B?T2kxbGNqVUl4cXQwTzMyMy9SL3J4SG1ybHc1UjhBS0pSa2NNWHJDR1lEamE1?=
 =?utf-7?B?VFBDdzlvdElrKy1Lcmk4U3hDV1J2dDljaEJHeHNXWm5xeTg5TkVXRTJBaUI0?=
 =?utf-7?B?Yy9LencwTnAzZFRMVVY0c2NzZC81eldGdjFTQmg3cHVyQ0NjTTE4ZUplQXkz?=
 =?utf-7?B?eDF1bDFhUUE1Y2J0UEJ5Y2RKY253YlVTRG9PYm5Sd092NWlyKy13M1dzN2t4?=
 =?utf-7?B?NUxqWEpMU0xNZkxwVG0zenlJWkpXeVhtaUNLeWs3TGJMWmZZQng0UXlLcEdD?=
 =?utf-7?B?RUVsSEdjSHd5Y2sySkM1M2VyS1JiaUVFcDg2Q3JPci9SQmY4MkR1NGw3OXMv?=
 =?utf-7?B?MzlFQk5pZ3pQYTRQbFV5Y054UlRUY2I3TWtpbHpWWVRSUkt3SS9BKy1PSFJu?=
 =?utf-7?B?TEp4V2dhKy02ZlRVREJCd0FDQmQ4RHV1QTdCNnE4U09lSUJmZWtMbE8vek5h?=
 =?utf-7?B?d010T1c3MFQ5MlA2bG9IOFoxbWdPRFlVQWhvQ0FCRkpVOVpUeDJLM0NaQ1I0?=
 =?utf-7?B?b3BEMGxkeWlNSURXei9zdjFTL1ZFRmEwVVkxSE5mZFVURGRlamxzemJST0dv?=
 =?utf-7?B?bTV5TDUydEVvcnk2WHdMUDRIQVdtQ21VYVBaU2g1bDVTVE5KMnJYb24xL3Nn?=
 =?utf-7?B?L0tuMGtQWkxZd3c1a3lzNXZlTzUxZWVXZFByUjFrQmRxaDlobXZ1Q3dCZ0ZX?=
 =?utf-7?B?YzJOcGZ3cUxibnlhUDJrdnBUekMrLVpWdXJNUTB5b1hxREFCV3Ryc0NabFRn?=
 =?utf-7?B?czVPODBOOU83MEdjOFBXRW1oR1QzSDl5WXJ1elZNYzl5cmhEamFhSmNwb1dv?=
 =?utf-7?B?VXNoNVN6N2JPald0RFdXL0t6WUZWc0haYTRGVGR4NmVEaHJ5eEliYzFkWVZQ?=
 =?utf-7?B?cDNibGlSNEljemgyRHVxcU5KbSstZWhzZWh5a0ZnSFJVL0VRMXhldWtOa0ZQ?=
 =?utf-7?B?dThxd1MyeHd5MnJ3S2IzKy13YlYyUkFINWlGOFRhd0d5eVFtNmt0VER5V1Ri?=
 =?utf-7?B?dldmZEgvVjBkVHhjOUtlKy1vdFVucnlrbnNqazk4ZVN0SVNuUkdCWlVRV1dO?=
 =?utf-7?B?NnFWaUxQQVZrNWhRM2JWa1lrUERHUGNvZjNHL3FpWXJkeEROZEpkekVQL0x4?=
 =?utf-7?B?blhvYzAxM3h6dzJsSGU0NndUSGNVSTArLTc1Z3dIL09qNHg3Vi9uSXhuZ1JC?=
 =?utf-7?B?b0ZObjRZd3ZZQ01IWlhERFVqbjRkc3FQSXJESlZBL0V4cWRXUUdVWm5SaVd2?=
 =?utf-7?B?d091ZkFMWWE5NUJwNXdGV1EzNHRvU1QrLSstUURabzdDVXUxQTJuNnZ5Y0xV?=
 =?utf-7?B?UkwrLURpUXc4WFkvKy1LazJmQ2VmMjd1OXRhaTRXQ2xtRnFNSzQwcm53eGw=?=
 =?utf-7?B?RystQWorLXRLdytBRDBBUFEt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR08MB8723.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?NXVMdlBKYUJqSFFmUCstYWtlMENBckZ5UU9hbUFaaWJFOWZBY01XdFhHOTI1?=
 =?utf-7?B?VnpmeDdmWDE1eVcrLUZycXFwQ2RZcDVCclhZZGsrLXppNGJqY0NjdmE5eDl1?=
 =?utf-7?B?ZEVFR0FSZ2NQWnp3Z1o2MHFZMystQTZmMzhyS0lVa3p4TmdwY2ErLWVsdGdy?=
 =?utf-7?B?blJXNmwrLTh6U29KdjVYT1NHMVFtVkhJendJWEhLYzFZMEQ1cXR1dCstUXJs?=
 =?utf-7?B?UWI5RDVhTUJZaystN2VZYUlyTlgrLXBLajhBSi9uNGhiN2M1NkJzVDRCUUxp?=
 =?utf-7?B?cjNndGMxby9HQzZDWGJqTFZReXd2R2w4RDJ6NEhmMFlGUkpRaVIwKy1GUXZT?=
 =?utf-7?B?VER2bmpQYW9aOG5yS0FZMkgwS3lDTy9QKy1KMnJCRystODlsYlVINEd4eXFE?=
 =?utf-7?B?MXczclZDU3FMVlJJY1NNcnFtUFNMN2t2ZXBwQUF1M1BMWkljRXdsa0ErLVBH?=
 =?utf-7?B?SklMSGJQNUFTOHJFY0RqWHpIeVo3ZW0zaGw1djB4TjdsVFJuRzNhKy1SaUVz?=
 =?utf-7?B?WWpYOUszZDA1RE9ZOE5ZTHM5Y2lNcGRieFIyTkF3SGJBbjRFNms5VlRIeXo0?=
 =?utf-7?B?bkRLeHhJNzJuZlRycWgwZG5kRVpZR1RQdWR1MnFDYVJ3TWNQdG01a0RnYk1P?=
 =?utf-7?B?M2RYQk5jVXgxa2t4RnlsWDZSZEgyaHNkVHQ1VlVNVXcvUzFSKy1uUCstQmh1?=
 =?utf-7?B?cW5wTUg2bUlPS3dHZE9sTUVOU1JUbUZ1M2MwWXdWYkNGWDFTUEo3RTY2Ky03?=
 =?utf-7?B?TTZwTHBWbDlmd2JPZG1jMGFXaHNKdFVsd1gwWFdzMWsvNXlnbFRnZGd6VmtI?=
 =?utf-7?B?TWg2L3h6QTQ3MU5FRS9OLzRiazFLdlZXd2JtNWk1Z2RHNGRlS1Y3Wjd0T1hs?=
 =?utf-7?B?YXltREVRYjMrLWROOUNTZDJ5c0FSUVF2SUtDcUZUZUg4RDVGRDlYWnJzdFNk?=
 =?utf-7?B?S2NWS2tRYU1FbGp6b0hNOFFpb2JBQ1RNL1JzaXB3S0Jid1Jkd2dPWHJXeXZo?=
 =?utf-7?B?bzU0eE5lbnNkMWxzTXpWbXBkN1EzUEZsTS9HNmdiNTZVU3lWaVFFeXJzZ0pT?=
 =?utf-7?B?cEFZNEJIT0pveGxUaFU2VkZUbXBQc0I0cDJPN1VxOWNVSDZ5MUVLT0ZlOTdV?=
 =?utf-7?B?UjBFSmtHemtIbThFdlRGZFQ5akpSZTJkSDh4WkpueE93OEtoRHIrLTE4bTAv?=
 =?utf-7?B?L1FxR0lId3duUlhHS3JhTzZ1UDBvZUtVbXZKNEZsN0t0ZEc5NTd5b3Rjangx?=
 =?utf-7?B?aThIQlJJZWhBWWVJZlRneEFJaEI2emJ5SG4yMUZsY29PWG1IVFQ4MENuMW5l?=
 =?utf-7?B?V0s0czlXelR2TEJaZWRBa2JsSDhOR2dGVDJld2ozb1o2RVlRdUw3R0N0SUpp?=
 =?utf-7?B?YS9Mbm1ESVVOVGZ1U3BRNEIrLUcvWlBGT0dadms5Q0ZBNFlTalJYRWU0ZFNC?=
 =?utf-7?B?QnAvTE9MbXIzTEUxZjBKZHZvZnVmNVo5aWFYNVczazcwMjBVaUtwQU4zM3d6?=
 =?utf-7?B?L2ZaUnUwR2VKMHZzd0xsNW5kaFN3UWJuUXFHem92RWVubGJvelFvWHFKZGNu?=
 =?utf-7?B?NHhZUVp6c0hFSnNyd1RDOTFsbkRQODArLWgzbmRrTTFybW5ISDJSS2RnS0tr?=
 =?utf-7?B?Nzk5MW8xUGloRkdtSmV0MzkyZVZCcXhTaUFORENZdEl1eklRWlFXVHh3Mm9W?=
 =?utf-7?B?UnlBMHNJRnB3ay9PMThMc0hiM3F3QUtJVkg1TU5WUzJMdUNhZHMva09jQ0Fs?=
 =?utf-7?B?SXYyNTZLVkFCUUI3b1o1SThKZnJhd25yWlkrLWN6UEI4WEozT1p3bXc5Lyst?=
 =?utf-7?B?bUkvQTNMSzVzWk5LSSstUmxHNlVINDJLL015Nk16RWd4S0JvQzV6eEpTU2tR?=
 =?utf-7?B?eUF3UE1jbEFKRmdWc3VWWVFsQkJWdmprZjJ6d3NFV0hWQWNxaDMxYXN3enZG?=
 =?utf-7?B?aEIxSjZYeFlqVEFtV0dpVzIvWTFDQVhjTEsxQ0hCbHhzUlcrLVNqdnFqb0dT?=
 =?utf-7?B?RlpXWjR2VmFWR3h5bkdNQWNBRGljM2NYVGpNNVN3U2VyOCstN3NsQnhrOHVC?=
 =?utf-7?B?c0FMVXpIVnF5QjhUZFRZWldBWG9Ib0docDRYVGt0OXcyWXRNQ2k5SUJwOHU0?=
 =?utf-7?B?T1B4OUpkMlM4TGN2V2JPcWUzUjZveTdHNystZG1KYUdEZldhMDlveWtValdW?=
 =?utf-7?B?SGwvTnhaWg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR08MB8723.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd994ef-3a47-420c-e09c-08dd14601208
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 12:35:00.8043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GR/L5SHWxVmGADqm3j9oLK1GFIfxLVr8w6Wm1vxXAjiAVTxiEtCONwyUOTh1K25L5AjOXHs+7ntZJ3uCu8KOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7813

Micron Confidential


Micron Confidential
+AD4- From: Jonathan Cameron +ADw-Jonathan.Cameron+AEA-huawei.com+AD4-
+AD4- Sent: Wednesday, November 27, 2024 10:05 PM
+AD4-
+AD4-
+AD4- On Thu, 21 Nov 2024 10:18:41 +-0000
+AD4- Jonathan Cameron +ADw-Jonathan.Cameron+AEA-huawei.com+AD4- wrote:
+AD4-
+AD4- +AD4- The CXL specification release 3.2 is now available under a clic=
k
+AD4- +AD4- through at
+AD4- +AD4-
+AD4- https://nam10.safelinks.protection.outlook.com/?url+AD0-https+ACU-3A+=
ACU-2F+ACU-2Fcom
+AD4- p
+AD4- +AD4- uteexpresslink.org+ACU-2Fcxl-
+AD4- specification+ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Cajayjoshi+ACU-40m=
icron.com+ACU-7Ce59092c
+AD4- 80eed4878d9cc08dd0f016a78+ACU-7Cf38a5ecd28134862b11bac1d563c806f+ACU-
+AD4- 7C0+ACU-7C0+ACU-7C638683221020661525+ACU-7CUnknown+ACU-7CTWFpbGZsb3d8=
eyJF
+AD4- bXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
+AD4- WFpbCIsIldUIjoyfQ+ACU-3D+ACU-3D+ACU-7C0+ACU-7C+ACU-7C+ACU-7C+ACY-sdat=
a+AD0-A6OYPhky94PnkzYn
+AD4- 4bfB1usIFDQzR1GlY1QFK3hBVtY+ACU-3D+ACY-reserved+AD0-0 and it brings n=
ew shiny
+AD4- toys.
+AD4-
+AD4- If anyone wants to play, basic emulation on my CXL QEMU staging tree
+AD4- https://nam10.safelinks.protection.outlook.com/?url+AD0-https+ACU-3A+=
ACU-2F+ACU-2Fgitla
+AD4- b.com+ACU-2Fjic23+ACU-2Fqemu+ACU-2F-
+AD4- +ACU-2Fcommit+ACU-2Fe89b35d264c1bcc04807e7afab1254f35ffc8cb9+ACY-data=
+AD0-05+ACU-7
+AD4- C02+ACU-7Cajayjoshi+ACU-40micron.com+ACU-7Ce59092c80eed4878d9cc08dd0f=
016a7
+AD4- 8+ACU-7Cf38a5ecd28134862b11bac1d563c806f+ACU-7C0+ACU-7C0+ACU-7C638683=
221020
+AD4- 676260+ACU-7CUnknown+ACU-7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
+AD4- OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ+ACU-3D+ACU=
-3D
+AD4- +ACU-7C0+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-Un0fB5v+ACU-2BBKTnQPldKKo=
RwOpw9GrGdDwBrXm
+AD4- JamKEIvA+ACU-3D+ACY-reserved+AD0-0

This is interesting. We are definitely trying this and let you know how it =
goes.

+AD4-
+AD4- Branch with a few other things on top is:
+AD4- https://nam10.safelinks.protection.outlook.com/?url+AD0-https+ACU-3A+=
ACU-2F+ACU-2Fgitla
+AD4- b.com+ACU-2Fjic23+ACU-2Fqemu+ACU-2F-+ACU-2Fcommits+ACU-2Fcxl-2024-11-
+AD4- 27+ACY-data+AD0-05+ACU-7C02+ACU-7Cajayjoshi+ACU-40micron.com+ACU-7Ce5=
9092c80eed4878d9
+AD4- cc08dd0f016a78+ACU-7Cf38a5ecd28134862b11bac1d563c806f+ACU-7C0+ACU-7C0=
+ACU-7C
+AD4- 638683221020684284+ACU-7CUnknown+ACU-7CTWFpbGZsb3d8eyJFbXB0eU1hcGk
+AD4- iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj
+AD4- oyfQ+ACU-3D+ACU-3D+ACU-7C0+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-V451+AC=
U-2BM9UKiC0RfBUviNTY3fZH
+AD4- UGHdjJEgGuR0DowJZM+ACU-3D+ACY-reserved+AD0-0
+AD4-
+AD4- Note that this currently doesn't produce real data.  I have a plan / =
initial PoC /
+AD4- hack to hook that up via an addition to the QEMU cache plugin and an
+AD4- external tool to emulate the hotness tracker counting hardware. Will =
be a little
+AD4- while before I get that finished, so in a meantime the above exercise=
s the
+AD4- driver.
+AD4-
+AD4- Jonathan
+AD4-
+AD4- +AD4-
+AD4- +AD4- RFC reason
+AD4- +AD4- - Whilst trace capture with a particular configuration is poten=
tially useful
+AD4- +AD4-   the intent is that CXL HMU units will be used to drive variou=
s forms of
+AD4- +AD4-   hotpage migration for memory tiering setups. This driver does=
n't do this
+AD4- +AD4-   (yet), but rather provides data capture etc for experimentati=
on and
+AD4- +AD4-   for working out how to mostly put the allocations in the righ=
t place to
+AD4- +AD4-   start with by tuning applications.
+AD4- +AD4-
+AD4- +AD4- CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. T=
he
+AD4- +AD4- intent of this is to provide a way to establish which units of =
memory
+AD4- +AD4- (typically pages or larger) in CXL attached memory are hot. The
+AD4- +AD4- implementation details and algorithm are all implementation def=
ined.
+AD4- +AD4- The specification simply describes the 'interface' which takes =
the
+AD4- +AD4- form of ring buffer of hotness records in a PCI BAR and defined
+AD4- +AD4- capability, configuration and status registers.
+AD4- +AD4-
+AD4- +AD4- The hardware may have constraints on what it can track, granula=
rity
+AD4- +AD4- etc and on how accurately it tracks (e.g. counter exhaustion,
+AD4- +AD4- inaccurate trackers). Some of these constraints are discoverabl=
e from
+AD4- +AD4- the hardware registers, others such as loss of accuracy have no
+AD4- +AD4- universally accepted measures as they are typically access patt=
ern
+AD4- +AD4- dependent. Sadly it is very unlikely any hardware will implemen=
t a
+AD4- +AD4- truly precise tracker given the large resource requirements for=
 tracking at a
+AD4- useful granularity.
+AD4- +AD4-
+AD4- +AD4- There are two fundamental operation modes:
+AD4- +AD4-
+AD4- +AD4- +ACo- Epoch based. Counters are checked after a period of time =
(Epoch) and
+AD4- +AD4-   if over a threshold added to the hotlist.
+AD4- +AD4- +ACo- Always on. Counters run until a threshold is reached, aft=
er that the
+AD4- +AD4-   hot unit is added to the hotlist and the counter released.
+AD4- +AD4-
+AD4- +AD4- Counting can be filtered on:
+AD4- +AD4-
+AD4- +AD4- +ACo- Region of CXL DPA space (256MiB per bit in a bitmap).
+AD4- +AD4- +ACo- Type of access - Trusted and non trusted or non trusted o=
nly, R/W/RW
+AD4- +AD4-
+AD4- +AD4- Sampling can be modified by:
+AD4- +AD4-
+AD4- +AD4- +ACo- Downsampling including potentially randomized downsamplin=
g.
+AD4- +AD4-
+AD4- +AD4- The driver presented here is intended to be useful in its own r=
ight
+AD4- +AD4- but also to act as the first step of a possible path towards ho=
tness
+AD4- +AD4- monitoring based hot page migration. Those steps might look lik=
e.
+AD4- +AD4-
+AD4- +AD4- 1. Gather data - drivers provide telemetry like solutions to ge=
t that
+AD4- +AD4-    data. May be enhanced, for example in this driver by providi=
ng the
+AD4- +AD4-    HPA address rather than DPA Unit Address. Userspace can acce=
ss enough
+AD4- +AD4-    information to do this so maybe not.
+AD4- +AD4- 2. Userspace algorithm development, possibly combined with user=
space
+AD4- +AD4-    triggered migration by PA. Working out how to use different =
levels
+AD4- +AD4-    of constrained hardware resources will be challenging.
+AD4- +AD4- 3. Move those algorithms in kernel. Will require generalization=
 across
+AD4- +AD4-    different hotpage trackers etc.
+AD4- +AD4-
+AD4- +AD4- So far this driver just gives access to the raw data. I will pr=
obably
+AD4- +AD4- kick of a longer discussion on how to do adaptive sampling need=
ed to
+AD4- +AD4- actually use these units for tiering etc, sometime soon (if no =
one one
+AD4- +AD4- else beats me too it).  There is a follow up topic of how to
+AD4- +AD4- virtualize this stuff for memory stranding cases (VM gets a fix=
ed
+AD4- +AD4- mixture of fast and slow memory and should do it's own tiering)=
.
+AD4- +AD4-
+AD4- +AD4- More details in the Documentation patch but typical commands ar=
e:
+AD4- +AD4-
+AD4- +AD4- +ACQ-perf record -a  -e cxl+AF8-hmu+AF8-mem0.0.0/epoch+AF8-type=
+AD0-0,access+AF8-type+AD0-6,+AFw-
+AD4- +AD4-
+AD4- +AD4-
+AD4- hotness+AF8-threshold+AD0-1024,epoch+AF8-multiplier+AD0-4,epoch+AF8-s=
cale+AD0-4,range+AF8-base+AD0-0,+AFw-
+AD4- +AD4-  range+AF8-size+AD0-1024,randomized+AF8-downsampling+AD0-0,down=
sampling+AF8-factor+AD0-32,+AFw-
+AD4- +AD4-  hotness+AF8-granual+AD0-12
+AD4- +AD4-
+AD4- +AD4- +ACQ-perf report --dump-raw-traces
+AD4- +AD4-
+AD4- +AD4- Example output.  With a counter+AF8-width of 16 (0x10) the leas=
t
+AD4- +AD4- significant
+AD4- +AD4- 4 bytes are the counter value and the unit index is bits 16-63.
+AD4- +AD4- Here all units are over the threshold and the indexes are 0,1,2=
 etc.
+AD4- +AD4-
+AD4- +AD4- . ... CXL+AF8-HMU data: size 33512 bytes
+AD4- +AD4- Header 0: units: 29c counter+AF8-width 10
+AD4- +AD4- Header 1 : deadbeef
+AD4- +AD4- 0000000000000283
+AD4- +AD4- 0000000000010364
+AD4- +AD4- 0000000000020366
+AD4- +AD4- 000000000003033c
+AD4- +AD4- 0000000000040343
+AD4- +AD4- 00000000000502ff
+AD4- +AD4- 000000000006030d
+AD4- +AD4- 000000000007031a
+AD4- +AD4-
+AD4- +AD4- Which will produce a list of hotness entries.
+AD4- +AD4- Bits+AFs-N-1:0+AF0- counter value
+AD4- +AD4- Bits+AFs-63:N+AF0- Unit ID (combine with unit size and DPA base=
 +- HDM decoder
+AD4- +AD4-   config to get to a Host Physical Address)
+AD4- +AD4-
+AD4- +AD4- Specific RFC questions.
+AD4- +AD4- - What should be in the header added to the aux buffer.
+AD4- +AD4-   Currently just the minimum is provided. Number of records
+AD4- +AD4-   and the counter width needed to decode them.
+AD4- +AD4- - Should we reset the counters when doing sampling +ACI--F X+AC=
I-
+AD4- +AD4-   If the frequency is higher than the epoch we never see any ho=
t units.
+AD4- +AD4-   If so, when should we reset them?
+AD4- +AD4-
+AD4- +AD4- Note testing has been light and on emulation only +- as perf to=
ol is a
+AD4- +AD4- pain to build on a striped back VM,  build testing has all be o=
n
+AD4- +AD4- arm64 so far.  The driver loads though on both arm64 and x86 so=
 any
+AD4- +AD4- problems are likely in the perf tool arch specific code which i=
s build
+AD4- +AD4- tested (on wrong machine)
+AD4- +AD4-
+AD4- +AD4- The QEMU emulation needs some cleanup, but I should be able to =
post
+AD4- +AD4- that shortly to let people actually play with this.  There are =
lots of
+AD4- +AD4- open questions there on how 'right' we want the emulation to be=
 and
+AD4- +AD4- what counting uarch to emulate.
+AD4- +AD4-
+AD4- +AD4- Jonathan Cameron (4):
+AD4- +AD4-   cxl: Register devices for CXL Hotness Monitoring Units (CHMU)
+AD4- +AD4-   cxl: Hotness Monitoring Unit via a Perf AUX Buffer.
+AD4- +AD4-   perf: Add support for CXL Hotness Monitoring Units (CHMU)
+AD4- +AD4-   hwtrace: Document CXL Hotness Monitoring Unit driver
+AD4- +AD4-
+AD4- +AD4-  Documentation/trace/cxl-hmu.rst     +AHw- 197 +-+-+-+-+-+-+-
+AD4- +AD4-  Documentation/trace/index.rst       +AHw-   1 +-
+AD4- +AD4-  drivers/cxl/Kconfig                 +AHw-   6 +-
+AD4- +AD4-  drivers/cxl/Makefile                +AHw-   3 +-
+AD4- +AD4-  drivers/cxl/core/Makefile           +AHw-   1 +-
+AD4- +AD4-  drivers/cxl/core/core.h             +AHw-   1 +-
+AD4- +AD4-  drivers/cxl/core/hmu.c              +AHw-  64 +-+-
+AD4- +AD4-  drivers/cxl/core/port.c             +AHw-   2 +-
+AD4- +AD4-  drivers/cxl/core/regs.c             +AHw-  14 +-
+AD4- +AD4-  drivers/cxl/cxl.h                   +AHw-   5 +-
+AD4- +AD4-  drivers/cxl/cxlpci.h                +AHw-   1 +-
+AD4- +AD4-  drivers/cxl/hmu.c                   +AHw- 880 +-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AD4- +AD4-  drivers/cxl/hmu.h                   +AHw-  23 +-
+AD4- +AD4-  drivers/cxl/pci.c                   +AHw-  26 +--
+AD4- +AD4-  tools/perf/arch/arm/util/auxtrace.c +AHw-  58 +-+-
+AD4- +AD4- tools/perf/arch/x86/util/auxtrace.c +AHw-  76 +-+-+-
+AD4- +AD4-  tools/perf/util/Build               +AHw-   1 +-
+AD4- +AD4-  tools/perf/util/auxtrace.c          +AHw-   4 +-
+AD4- +AD4-  tools/perf/util/auxtrace.h          +AHw-   1 +-
+AD4- +AD4-  tools/perf/util/cxl-hmu.c           +AHw- 367 +-+-+-+-+-+-+-+-=
+-+-+-+-
+AD4- +AD4-  tools/perf/util/cxl-hmu.h           +AHw-  18 +-
+AD4- +AD4-  21 files changed, 1748 insertions(+-), 1 deletion(-)  create m=
ode
+AD4- +AD4- 100644 Documentation/trace/cxl-hmu.rst  create mode 100644
+AD4- +AD4- drivers/cxl/core/hmu.c  create mode 100644 drivers/cxl/hmu.c  c=
reate
+AD4- +AD4- mode 100644 drivers/cxl/hmu.h  create mode 100644
+AD4- +AD4- tools/perf/util/cxl-hmu.c  create mode 100644
+AD4- +AD4- tools/perf/util/cxl-hmu.h
+AD4- +AD4-

