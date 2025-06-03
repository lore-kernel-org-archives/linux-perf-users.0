Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48813AA2A;
	Tue,  3 Jun 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957002; cv=fail; b=ElzvjNkZm8uKJYvlGtmYvD4TMSI6EcpAPFpTUL/pVgFp0i4n98eGiKCbBDTpmDGq75DEHn7wySu18ElE7YCkl0Izm9RXz/Vx33IpfdmsG2oc38uP5W65NnkcL/mGrL4qu2bHMShkKXFN+qArfBFA9cHEt7K9/2dgmshr3iDP3AI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957002; c=relaxed/simple;
	bh=WdrNePLrKqzI8/98CMQYJyvL1y18hSsAS6y6Bt73Dxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uuq1/2vWQV7Ddv1+zcJ1kIBBve9BuYJavM2zdSJiFSzdbZZH5KTsWJetpkTUAf6nm8qWJuvh9hgnrFLLYetKj7AprEUzdQrj8iM4C+b84189YZuvCis8O6TgnXpEedmvjnSKTXy3DKStcl8MVeic1zLlJrSpF/l2eowE+Tm7bko=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fcXEHNN1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fcXEHNN1; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fcXEHNN1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fcXEHNN1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kLHZemROGt004fkUM9ciVC8ZJzi2Gt2KwjC2nNAjLYGgrIWBHpcU7Qw3bP+di34QdHyBNhFdOLq5pdrfMq0UYY/J7Wjm5qUaxtLFXymltabnEZqr15gThMikHcw6uoYdvyXKAhNFCGIrU45uHagjj5e6a1++K5IWmtdRDJIEVOxvznn2t6gN1KyWDKm5LRYJD/xX4DasjfcMFvVOVP1Vr1VHEhjmBgT5bawwjdpO5GjQK0+v/xpZJtJhukoMKNxo1YlXJ01DahnE34BmYu0JhruDJT7SsqCp5WFDgJXQsH4q6qoQQz6O/itHcXpdPYEHCzW6gZDkCYUdtRqQgiD9FA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBkw5cE77WCGNf4zvOY5wnHFLNPvFuO/76zYa2k/bOY=;
 b=au5USjMZQZduIlB7xT7/GyCsB9LtpSBrDKphy3uOP6illPGzy/ziKv7GwWVg+7CKNHxol/Af89IQSP6NWB2+CaPj+CJ6z0zrq3ju9bzGs7Euq7pzPtKI/Hh5DOVd15qsdtfYVFWilpCEQ5+B+ZdOX6YaK+MM/2odLW/8u4hB0IkVxM0ROprguTJwtm+l7hceNaHNQNkBdrNIZrHaFGeDQNACdDTjUDs+dx6F7nZLskbf5tniTqadn6BR+MZwuSbX0XupfdlO7BW2MUcrifW5/yJ3z5bbSR3fIzfkuxBPsmZeVG3WR1KmNs4u3pd1eAgKB39OxkibKLJVJbVeTY5b7Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBkw5cE77WCGNf4zvOY5wnHFLNPvFuO/76zYa2k/bOY=;
 b=fcXEHNN1dzu2mhiZl18oY4ZC8TILSLN8khxZ8kppNKpdWP6IpSYMBZpS3ifeUxCE/il89yspICJkuZhyn61eXeR/hlSaj49xrjyBWHrnKTX60a/hx6VbC1rHXYAEvQ9oTCXw5PpegA4WBIwTyl/niILmA247UBsmopu7EeuY2m8=
Received: from AM0PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:208:3e::31)
 by DB9PR08MB9444.eurprd08.prod.outlook.com (2603:10a6:10:45a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:23:16 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:208:3e:cafe::10) by AM0PR02CA0018.outlook.office365.com
 (2603:10a6:208:3e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Tue,
 3 Jun 2025 13:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 13:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1OQiyQRC4giP3SQvtlHRbHyewoTHupFvOvSO02ZCFvmeJlJm9Ub3BQ8+ffuDQan8i11OQ72ZAeG+Y/2hjAk+lBGqMv6g75FXyOh7EGgtLqwbozW+qtIUCPdBy3nRNRnqJqSdiuKSyJxifIlUvCzW9cFlQW5OlmdQ5sio221FKhSq3RUuoqkkXvWVlSpA381j+drYEKmXB3FRon7LNSZgs/JrJgVP21+jQOi+WKRA5jk3K+tzkxDVdwzhnAQTwflBtIe5BaajkAwQFOIcNdfD2Q+83iycc1sRy8GPM+byFfhTooVAnm1wqF1blfZBHZQQf2hCV7WGEXI90U6GkGCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBkw5cE77WCGNf4zvOY5wnHFLNPvFuO/76zYa2k/bOY=;
 b=DEvaKDFt6cMo/oEYsE8vF772sb9Q8xDBwpN0X3gpWUm6Rlxoks0vEkZ6GPunjQfBXXNiPxzQI7gpJaiHgudDoCDW2Lmq/s6KS5esbUV+bKBusrolH7tTGimNuDizwH50OqRYUHdtdDFhZyc8lhTYmtTqeIDhpXZUhFnCk85FFCWqwEX/J2y7ou3+/awD632VDDz9Uu6Ra9Q82nsdkPvNWo+ySN00z0cwygy2Ydp0QsGNxdx49Tn81Xt/7yrN5QwJtBoYPAkRSAmRnewaIbMKARrmA8ohwUkFPyOqj1MbX3bHmU2EQasMporhKFtkD7mGUV3K3ty6uB6bYv7zEx8yDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBkw5cE77WCGNf4zvOY5wnHFLNPvFuO/76zYa2k/bOY=;
 b=fcXEHNN1dzu2mhiZl18oY4ZC8TILSLN8khxZ8kppNKpdWP6IpSYMBZpS3ifeUxCE/il89yspICJkuZhyn61eXeR/hlSaj49xrjyBWHrnKTX60a/hx6VbC1rHXYAEvQ9oTCXw5PpegA4WBIwTyl/niILmA247UBsmopu7EeuY2m8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VE1PR08MB5678.eurprd08.prod.outlook.com
 (2603:10a6:800:1a0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:22:41 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 13:22:41 +0000
Date: Tue, 3 Jun 2025 14:22:37 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Wang <00107082@163.com>, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mingo@kernel.org, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: restore __perf_remove_from_context when
 DETACH_EXIT not set
Message-ID: <aD73Hf6Q7rjfCFAC@e129823.arm.com>
References: <20250603032651.3988-1-00107082@163.com>
 <20250603083304.34132-1-00107082@163.com>
 <20250603091352.GJ21197@noisy.programming.kicks-ass.net>
 <2633d43d.ae30.1973564f5e5.Coremail.00107082@163.com>
 <20250603125056.GI39944@noisy.programming.kicks-ass.net>
 <20250603125440.GA35970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603125440.GA35970@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: PA7P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VE1PR08MB5678:EE_|AM1PEPF000252DF:EE_|DB9PR08MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 424ad594-ef57-48f1-515f-08dda2a1cb24
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?nbvzaB6tti4RJTnEUvdEzJpLhwVF5ohtJoddwKbde+LNXP25cTuBYENtEAad?=
 =?us-ascii?Q?uOToXGgutPFFW31LHl+1F1So6qEP7nA7HDAYFoI+mtAlPGF9fNhrRdZNGpGC?=
 =?us-ascii?Q?4RfDCpsFMvo7vuCE5sUESfLrb9RZIAiyEgBmYvu+sOBHYkG5/bAHNmwwqIvg?=
 =?us-ascii?Q?HKmkUueMnPadpB3hcWtmN4cjyMffKjyvRRy6lGXZB65Zm2+LCUG237Rq4h0A?=
 =?us-ascii?Q?4xZthgTcQKcAtJxf5k21AHF+fY5VFe8fikLfheAZ8mxtpXBdHJz74T1q05WB?=
 =?us-ascii?Q?KX6Fm9y9stOMYsevMngkl5hIvOHBUJi1YJkzOkXgX+ta4Bozb+JIQht2Mu8o?=
 =?us-ascii?Q?XWsyiBucFs2ZA+TWu74ywXsYCx1ns7+7fPuc717DhLcpQms9jgkwSugSLhuR?=
 =?us-ascii?Q?zAz9lVjmo//eQeLxK3o68b7MnvcTj7BMUV9M6TqK12g9LCz8f7l2bvhSiQHR?=
 =?us-ascii?Q?P5Km2B3GFQl5TmSRsjb2uCfGKIP8IreQUTitDlwh9jkR4V4r0O7BFlud1k9n?=
 =?us-ascii?Q?z/x2tar6nxbXjUHQZixUYmaZGjYVTAJKYQdxLIBJO679h1k28rzVX9vFJoQ0?=
 =?us-ascii?Q?6MKwowM8BNos8J8vHW6Hsho/2KWxfPX2xBiTPqsDo2N7f9tHA3rY4QCkZIf5?=
 =?us-ascii?Q?duSSecRNUEeW8+avvIyErgsMFLcXG+lqGqq77YlHXxd4FjrQc+yW/g823FiD?=
 =?us-ascii?Q?TU+82nTbmI5MvB3SvbFwFdd/OEid5ZyqsgfJ7JDjdnGH7hsx4z0+ejS/GP30?=
 =?us-ascii?Q?82N4rFN0O5KHuag20IRG9N5ZPYfjsHoQvkiALQtXCGtKn8K9bOmVlIcWFWVk?=
 =?us-ascii?Q?ciHtUiuw31ZBu0v6R3WIHb82w0ANYOAUv8laYXiUhF6403AQY16NmNBeWhEe?=
 =?us-ascii?Q?kSW3QSd/puji+19d3K1DnCq4Y54IY+B1qjGhenaB0KvhHiAjnxHLHRwvzp7z?=
 =?us-ascii?Q?r558VdBDgxlH51Hs1UGZOq+6ixhfo8V41Apu4RBHpbrCN9X5jXefCRQeZx73?=
 =?us-ascii?Q?YKXsFbspv/7ppRekd7yzMpjFfskWsbxdQOuw6akGrrJ5UQoA4NgpSL8oeuDt?=
 =?us-ascii?Q?w3ZVVSSuADjp5txRijSvMqkWk7FA2/kzSnL8NZoqIxgMztmWydePmDr9rQt8?=
 =?us-ascii?Q?2Ors5+rix/UGWGzP0vea/qFVys+9IduSHcmsEhugdRdPCHt2npDiSwAr1AQ5?=
 =?us-ascii?Q?GQQVU8jX2Fbc9LyEAKx3U7dP7ySBbgPFIVIVIA97xmlxTYY4BmCtSTdUmzUC?=
 =?us-ascii?Q?ZjbNVPsRuhKSvS3G+FI5rGr/f1tPaxh6zSvMt+gIeXqxQsigBjxd7elKwI61?=
 =?us-ascii?Q?Zp6E2vL+AzoWEMitAEf2jDTzmTPfWl7naOELmYY+hNEONwlYJ91wQS+iqjDG?=
 =?us-ascii?Q?V+JwnBK+cVZRIvRUG24Ag7h4vuqdpFQtCcW4DRmmUXGqNZ3C/xs0zIVHZBAN?=
 =?us-ascii?Q?U+7Xu6j99WE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5678
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	568b53be-f9d3-4f25-efd5-08dda2a1b7c4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|1800799024|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zy/sWiZ+XCVtf3x3152BXX6Xe1qUWIe0JfTt/ztV1kOSNjcrgUgdwkVcFQ9r?=
 =?us-ascii?Q?tA81sVO5rzEgPwSQ0Ez4pnI6mQmxoPeEk/fXQq2qibehRblOc4hpn6S7JpcS?=
 =?us-ascii?Q?CdvXMVbgG7s8lj2VN2i3vR2TMCJlucl+IT2mTj/c6dktNnbG6mypXXQ69adt?=
 =?us-ascii?Q?v6q/+1bES4BBC78Yeb3vDO/J2PUapMId4kVxSh5Gdlafkf8CspKohER15q9K?=
 =?us-ascii?Q?hbOoVFucwTHqMU4CtUBFnfbvP1IvBDKe8BFg75Sc79OeaLDvQ240zM1cCKS5?=
 =?us-ascii?Q?QDVyzy/2/QTrRDSZpx4iKtoLEPgLG8GfryNTCMyzAegGmdyH8UWxXwvVwoyg?=
 =?us-ascii?Q?a4J1XMhcNv7YjNUhb4/Ondm3u4Yd532f9vNtaO9h3gmdNtnU9SEMR+E+Ufc3?=
 =?us-ascii?Q?cQR0beWQI6UCOWGIQpo6vO/sOz9dGQ77x/LpTdHsszNGpwkVXZbGt+ekZCU2?=
 =?us-ascii?Q?hDQgd6N1Yc+7EEyzRu1Bo4Q+Bx56n/DaH26v1G3rvV2ZhsiDgETwSxw78Czn?=
 =?us-ascii?Q?w6ptVTVcbwb1VS0z5YYvUVXJfElStnPGMtqh3swky6Q98EZBm2fyx4u/oUD/?=
 =?us-ascii?Q?heyogLiOOM9yKwUl6HizO/CUbhBrRlRGwboypJd+R8MC5qYYuXYBre/NjuJn?=
 =?us-ascii?Q?HQWpW8wpxcCmpMhQVp8buix8NyjzgaBQXblZdmkxoEDwkaERI+gYNzfkZMjn?=
 =?us-ascii?Q?jWOHymOElPggxjiReJgDelq2VXD62GrrzF/2kg47FYAkFyrwMwDvzTQTP1KL?=
 =?us-ascii?Q?2GpaylXqhdqYg2Pz0G30i1H4HBKAgOfyR1YFgbXr0gLj9uWJjm95nwmDaJHR?=
 =?us-ascii?Q?27qSLTbH032Hfnj0Y54ScxCj7btXy3Uk0ZBaJxVQF3j8joJGS2+NbB8TE1QV?=
 =?us-ascii?Q?N8LslyIQ4J97m26Q47ryGUWobJNtwlsx+yNp4Nvi7vbIC29b6DuyKwgPThZ0?=
 =?us-ascii?Q?yi+FiNvxgYteSwBYRRm6JyNR2URta/JQNYO3djKGP9Y7ylywNY8uJoSTPUwb?=
 =?us-ascii?Q?8e8EMnd6zpeNrPW849qFx5SKRTaqFcmKCA6Y3bD7PWeeHWu6ohOHl0yfYFHb?=
 =?us-ascii?Q?LFBfN4b8HDzSpmmkkKg4Vgc0X05PeLfN6nxRttmytGCE+6Ryf+EZSDjDBXGN?=
 =?us-ascii?Q?JVP3hQHR6hEv+tshyiTpSg1zGExchEnfB6YzbLyZ5G6LuEeeqKLiWUWH3xGl?=
 =?us-ascii?Q?kouYN8AZdeX8iNn7S+lwcXOlrqVrMHSnYX8rUKV1Z/F1qKTmLN1hpBETqlwJ?=
 =?us-ascii?Q?Ss6yZ2MPBRW9xOA4x2uP7cFuDgFHrZjB5TQ3BpahteqLLCJwqI/SbOtkRHfE?=
 =?us-ascii?Q?vnFjkUll9VO4hyfhJekf6AAL3wF1y+/xUNNz8zRof4DDUqiwEFAbzHoEJEhP?=
 =?us-ascii?Q?ixno3ThOByyXQeq/76drwZ9LaWtwUOzD5nFCt8tjddSavNtXU8J3h/P8ENyA?=
 =?us-ascii?Q?4Pbz7oehI4ObHGkXcdjE5Lbwyor8w2IjXrxvZHcSO4YC1EZDRp195IC/DS9r?=
 =?us-ascii?Q?kYSuNm45wYcA4n0wC4utRh/iDvqkJ5egMIB2vJZhJEGZpgnOHPH3wBT3fg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(1800799024)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:23:13.7151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424ad594-ef57-48f1-515f-08dda2a1cb24
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9444

Hi Peter,

> On Tue, Jun 03, 2025 at 02:50:56PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 03, 2025 at 06:44:58PM +0800, David Wang wrote:
> >
> >
> > > (As yeoreum.yun@arm.com pointed out,  the change in perf_remove_from_context() made
> > > perf_event_set_state() happened before list_del_event(), resulting in perf_cgroup_event_disable()
> > > not called.)
> >
> > Aah, d'0h. Let me see what we should do there.
>
> Does this help? This way event_sched_out() will call
> perf_cgroup_event_disable().
>
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..adbb0372825f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2494,9 +2494,9 @@ __perf_remove_from_context(struct perf_event *event,
>  	if (flags & DETACH_REVOKE)
>  		state = PERF_EVENT_STATE_REVOKED;
>  	if (flags & DETACH_DEAD) {
> -		event->pending_disable = 1;
>  		state = PERF_EVENT_STATE_DEAD;
>  	}
> +	event->pending_disable = 1;

I think it would break if event->state is "PERF_EVENT_STATE_ERROR".

TBH, there is the patch to solve this problem:
  https://lore.kernel.org/all/20250602184049.4010919-1-yeoreum.yun@arm.com/

Does it have a problem?

Thanks.

--
Sincerely,
Yeoreum Yun
