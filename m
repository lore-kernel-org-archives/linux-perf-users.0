Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD519342E;
	Mon, 23 Dec 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952292; cv=fail; b=X40JCUvcHtIceORbz8Ez/xbP6yh92k4RI1wmkKbYD27Kgxsf7X9tSgyiKB5l5D9MAaywy4L3hjXALZ1GFM9OVE+rWt7LELNWPfU9L7GddT93ZaqhrOT7s7MDlF0Fkat+/znio7yUu/N7mqYqrQo6zhG1SvV7ZQPs/y10+1JBWnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952292; c=relaxed/simple;
	bh=zDysUPGdyaxOosWZn/1kIwJle/7dVt/sHSyWhUjl+tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uYQVGutSPvDXms6iwDhss19EQTCOj5ASa7Dd9ZNkV1vl0K+mHruOU3Q2WE4rsImUi/NQFqOhtbFv63+LZQRfLHsf/MjMfW7//A9+XYLSK3kRpwrSVl83TF+TD32s70FDuSNpz1186nqZpIj0EF4rMNUwC+xU2x1ikzFhQX5diXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aXcxVU4Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=asYikbBg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXcxVU4Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="asYikbBg"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN8fk5n013466;
	Mon, 23 Dec 2024 11:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xb0EpUd+uZdk5DXbse
	/McbCebIwKormO7xmr9gZY/qg=; b=aXcxVU4Y3XRcFC7evR8NBOc8U+pZv0o0H8
	8meQ2RshyCgI88uZRxyHFpC+/ltsIQWca+hy8rjWCPJtRhuBol6elIIUYvnbfjy0
	JJb2MI77xN5uMxbm8IKvOIIcbkBUIzEhLnZ54ux6dgCbbVv8Z0Kithk+m/Cc1+Fi
	+GT7CGi5RBETr8Awngj8/62pbqmkuK/vi3ZfcfqtRCVe8MJSgp+6SuBOnO5bKD+y
	Q9eOja1WVOORSWBrET+5nu1hllf12rvrGy+I7oxKdcChGNDWiTJZguwdM3A8MMKf
	4bDWcg0qAFme3kyKzg4YqBuhz4Yks03icLPMsEbDNMevSTxUQ2XA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq74abrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 11:11:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNAXLcZ004479;
	Mon, 23 Dec 2024 11:11:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43nsdfnsmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 11:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIQGN+MWcYqE6SoKxMkZvv62SvwfSyjtIc49otsAQebBByLDdTbW2dVE3yzgdPmIAlYI5ZGRYAB70Y7VWKaJIxVdgVATJSmOnTtD6ipwACO6U4qTbj82XC7m5qtp0NhqdIA7BUZIshr+B/xXdgzHZanrt6Tf0G6otDdoCw1i4dcZEljAvAr7qK78SXMepU6As/GB6uK3SMPJyvFm/xN7Nue13dfiX1tbFPp5yq5qcRjdRXa5hO5FQnULkqCyB97NyeWeGAMtfecJg4wd+xmeBv41PfS0Ve1mhuUyruzh+vzZNx/n5SKpkOdUkbGyQRhj1qj5rCtBo4qKvoXpWI1aIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb0EpUd+uZdk5DXbse/McbCebIwKormO7xmr9gZY/qg=;
 b=CbDrbt75VUjPSKvR07uQBgO24oKt5nXqS6icj1FlZHqs/u4yk9/y+D22wTb8g0wha7EfUMw/t3pu4H3xWy1nmRCMwl8kNIuI/pJQxvSIks19hKbwU9PjrnCOorYNMNH9Faa+kWxmrZKCejbMxRkb8oO6qsK9UWofCZTenXmvn9m3IbBTzMTF1o2wdNbGyF0YoNWPBgKsKfUUTf50uQkdb7B2tYPgPI8h9mZUEGRvDts8NoKctGi8sbRo4xHCXCiRL7RF0AaEtjE8EIy3MqeMu06agrjTDYX6/PXuPq1FuKNoc8eEO92mXiIOqeIocTHkgBOOi/BcD8/FyWmqdIjncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb0EpUd+uZdk5DXbse/McbCebIwKormO7xmr9gZY/qg=;
 b=asYikbBgEuyC86XCqjBGwKMeiYLoMoBTqr8/PUC20dAwlinUx1VxYrRjOGS7vBFCCvPJumOJ/Xrz/ZhnS9mRmbqysuAGpzTQ3ryxtja6lUrEGwDRlObIKgRI2hcHglP9NfbI7sjHGPSxmwfVwysT3oigNDKoBXVJEQWjqm7BFyM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Mon, 23 Dec
 2024 11:10:55 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 11:10:55 +0000
Date: Mon, 23 Dec 2024 11:10:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH v3] perf: map pages in advance
Message-ID: <f4299bff-3448-4095-b573-243f1fca834c@lucifer.local>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
 <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
 <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
 <ebaa9d2e-c5f3-4a93-9def-caadae92acc6@redhat.com>
 <e489e48d-f9ef-453d-9b88-91368b9534d7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e489e48d-f9ef-453d-9b88-91368b9534d7@redhat.com>
X-ClientProxiedBy: LO2P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 131b0e80-653f-4528-4b98-08dd23427868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUjYwQqJ6ybkaboAv7rdWSUTyBuL2QDkv2Ww5+5sGWw5nSmrV5d81XWqTrOn?=
 =?us-ascii?Q?PXqify0iM1ASm7fktScVNacjhaDxkLmcedUdNgbffCetql1IbOq46FubDl1h?=
 =?us-ascii?Q?24g3I2z6rNsYFXRusulDt8MR51mqFlfFNYqsqB3INhaUK1PK1lVag28nNWWi?=
 =?us-ascii?Q?dxSGP86rE1kUZGe9UiW0aLPTw/9hKUtLQAg12tOGINq1IrV7gjKUyBBESaA+?=
 =?us-ascii?Q?QiYFyX8s9n9XZ8qOuX1mZ+XPmwktmI7BDJKDewmPD/6dxNKfz+Yf4BtreKKy?=
 =?us-ascii?Q?YjnqXheDHwc4GcmS6F49YkStyk6oVOdR2kbNEEhHXbRzEZdhgSmFN/B+EXo/?=
 =?us-ascii?Q?wOKFsuRKcmK0yEO8mVS1xBTw+K9uIpMz79CMXlUpy0o7Wz71P7+KLT7PQrsU?=
 =?us-ascii?Q?K+KjE1orVR1XIoT2HmR2Nf1xqQSIMxmpZ6QkDxFnVUcZwq4aoR176FZrJ2Ne?=
 =?us-ascii?Q?deymwtG4j+ud/Bhz1pV0eLJhj0tYzKXIpE8izvMJdyjDwexvOyKkbMtIqzZA?=
 =?us-ascii?Q?ooOb6CuW8M3uwGo8Xoch2v5LklGYCejj3YZrv5unQWa9/QuHOCHra9lC/B+Z?=
 =?us-ascii?Q?+Yne4QDbkQTfP7RPiimlGNqNl8p++JRoNX1g1eWw9+HG7U87DvrszmABdcqd?=
 =?us-ascii?Q?LOakFkRc2yvZfsL9CNkYq73lulkBaMsRokiAaAx3LeFd6odvlbRElxCoivLz?=
 =?us-ascii?Q?HB6r/BrH+n5UZ6+Grt4569Fi+GHxO6zylQsUNidwXqtmtTN/LVWKbN2+fL0w?=
 =?us-ascii?Q?15ohB+itNRZaw0w0of6wx3v19p91OI3CxoNSqHqzyOsuRUwukD9d2XBaemRu?=
 =?us-ascii?Q?6hueGuxwP7JELcQHFNAh+HSorRNXUjS3AhfzR48WXLdGrh2UcrgzDc6ZO9Tg?=
 =?us-ascii?Q?CJ7FnCH1GRdROtJ5WEohDe+iWrGGRIfLFIdVBDic+Ar9LU9YD+2qchSNylWd?=
 =?us-ascii?Q?OQQu0Qx1JOFrnf6AWLeftVvRwwIXfLfBdfYjnjVzM5QPuFCpwOqyshqsqTNM?=
 =?us-ascii?Q?/fR9U+8p0gPmPBM7LpWVClAxR/TzexB/HYwBOmu+ZpKnhxWkjAWP/OHKu27G?=
 =?us-ascii?Q?1quiequAwuR5q7qw4sKGpCIiIUKYXDCrbMzmTlpRftibAHSaQGDplUh2fnRd?=
 =?us-ascii?Q?c0R6aJwCEKJSpJlEesocqA2qCewMieaXKAkCk17FxgCnu8xSy0Hc/FcD31qM?=
 =?us-ascii?Q?eiGyqeNI4gtpZYsxkPaiFkpeKU0a5eMjzABwYlr6yIP7H75Xa5SqR+tgW2BK?=
 =?us-ascii?Q?6JfvMRUd/YD3Ro7b6XqEtuq+EhrDwFui0MPzXiGtTys+/zNvNJvG1Y+wd+6x?=
 =?us-ascii?Q?81rT5p8pcBwcSquXMHSUNr6DRyoVyMyNzl6JaMl7a/0KABXKBi1a3cBWkYFr?=
 =?us-ascii?Q?RU9n9wJbh20e+oboNACv056scLFC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAfxbm9D9cN8EFgETQdsB5UHt7g7tW3+vRhQY31Y3/YYs9yKY4JzfZnmVIIN?=
 =?us-ascii?Q?tB5hZL9BrRQ+BYWg4oaxXww5lGdrVa0two+Gm1u+r+iX+G7a/FD3f/AMsp2l?=
 =?us-ascii?Q?1+ryOFIrMtD2D3lww6BRwKHGTWlIn3ja+qYwSJS2QcIvTTTsNhAriCllOEXD?=
 =?us-ascii?Q?2MHRH9dKAMyw9qIqCBMjdK7o0ZsIxp/+9lHcTl9PQj+QzmQnueTFBJt4pqlN?=
 =?us-ascii?Q?xP0pf7NGavAO+QEDR+Se9hbexRhuB9oSz5t0MpnBLCWxasKy9tCA5BLJVAg6?=
 =?us-ascii?Q?XWDTPicGslB10MEo5okEdbPIeuR6OdFqtQCcgXILyya8v1mZoKyITL+seO+6?=
 =?us-ascii?Q?ew87gshB4ROJqYgyHBtXBd+HU85yz99vs+O3A0h04z2MRnxgs6KXK5/fdyE3?=
 =?us-ascii?Q?JrFlpRSRkszo9zDaDiEy0a1ZBJj2ZryB4BUu087kkeDOSnruDl/SBb1GF/8W?=
 =?us-ascii?Q?56GMIbLzAMNQjfBtBci5pBbSwZAgzcxBEXDUEN0sAhW8KKEsA0bEg1GmVAFo?=
 =?us-ascii?Q?BBdN5B2tWvKNC7RmmOrWkDENDN4gKCyhed0sYFUxbccK+ZN/3wzRff1KbIQx?=
 =?us-ascii?Q?x7Ikf/zLIi2Nk+c3Fc6qMAnKfCI2LXU9soVgBIQOa6FigieJDWtg96IOILPI?=
 =?us-ascii?Q?Vbu9uXBWEtR5AL9/WqbKaTvjsnsQVRq6lIW78MU7lD4Ui3pD833nkvKWFvS6?=
 =?us-ascii?Q?5StEpQ0gqvr2O2FGM6eVlsey7vMHLgCWQknrKGRyvXMDvG7q80pk+qvON5mg?=
 =?us-ascii?Q?wyI5aLOVP8OcvtJtu5FIMOO7eOhYR097+JfHL6l0z5CNZhobVctVjEVtFfr0?=
 =?us-ascii?Q?xuZdTlXIEWkL+rYqOCyv28mgcpP4PkJ5rsHRljgb9mFVtpqxtuNO3KtQQa8i?=
 =?us-ascii?Q?vUzZtKXYlbyoNjBpjjxEl/S9i+lR6LKsYiVdigt5kYdZs1MITpo/jZMc5tFL?=
 =?us-ascii?Q?6E0DK4wc0cNbhZ8wGI0YXqzCbf6+z59RU3fjdAtz1KM32fG9rS9DoUmLgsc8?=
 =?us-ascii?Q?XawumdpDibxJaJ26SS8SVROnax92reeCE6eZOcBKNNxTPPDrA7KmsvsABfbL?=
 =?us-ascii?Q?qfMQh0bbgYSeLrDtk6h3LCwwjNYQl7jQCeRsmNwePl13uAvmpfvnb9QvhSEH?=
 =?us-ascii?Q?zlqD9aLmjbtGOGoWOuB6I5fczl5p9+sl2quZogcGrANmPzt2Oo6zL+oyAPTe?=
 =?us-ascii?Q?Yo0wY94MJZukpUEYSduqbWxBTQRPqHnspup/9CC2Xd4UDy95C1S1jOCNO+6W?=
 =?us-ascii?Q?jsXm853MVYgxYO72/4YROcOZtG+JrjRARzhHe4nrjdhy5RDN8inITLRQklSE?=
 =?us-ascii?Q?ucj9yr/3XESfohYBgnKA/BeBu/0UKmzpbucKE3Gems6LDeu9r/UfobIvRPVz?=
 =?us-ascii?Q?+2GEI5Ry4eYVNOL90S1BaVgvvQF1bbTCCKsLmbnSLtw6PW+4xIUkzajaIjLY?=
 =?us-ascii?Q?CV895d8GWzF+PojMMMbWI9rGDbuyirZFacm1uoEqfHY6bHR7vO11Ue3yNE5s?=
 =?us-ascii?Q?Tyx2OnGvi4sRXHFAiUoi0a5zrrkN0jjU88iMDOovfXHWHZ1j7i7ZiKfYet/u?=
 =?us-ascii?Q?5mNg6eOJWsSP+ushHc7eVxIz/WSPXvRcbO3TOmMYouS+jrX+lH0nXlHcRG+o?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZXRuEfmGCLH6ORhDhJi5IUG/+gnn3ClSVyVBUOBUyuAtb1Od0AR1lzb541WHbUmAag98gs1ql4Jh6lFiBNAbXK94WArwbjq5QTOuzqu9Suh0SoMvH3/nRDQJHvu3MIWNFW1xh+lDWVSO2OAEtShw3fPgTplt8kgkjk0zxizEhFFwGrchiTDu5Vk+tE1knyZ10YNSX59P7Yv3OYvXcdBvRWoBjQWnCff2SK0GQ8RrmcUepVo0dWMK6i8XAck6n34ta5Y42r0xkHSgn8I1Bd3ONvfYs3wbIeCqW47bVynAZMzh22SGJM6/RdieXZNi/gJSbuQcrfw3jFhX7ie/ZIFlKMmli8/Fna+Hw7/DF4S565StNOzi9syaVJjOdaZVC11T7LOUhg3WOIAhU4ZXE4JxEcuEO4iCItisPXI7qEan2OMZdEARA2M6kSPgMmY66RUf5vLCul18HGZbjs42Wx/gSmKRTEp2hc9veRYFb4H1xXHssLIYz7+2zJiGplFxTOEbT7TVfZmIIUojxizpbyKzC4kwYs64sebeM+kFWiXJkddJS6m5aszm3r5x22OH/xSdhiOc/htEm7XwCj/MpLvuXetKXYV92O94so9+GbxHxjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131b0e80-653f-4528-4b98-08dd23427868
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 11:10:55.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfVqcB+YW+rVcxTjQHZaVj+ha+Z+n+TJTLL7OXiN6CR4MA7ItlPPUvaliL4e+I8ijryMKrYfTEuvlu+clOvxo2qovU1uAK6SJ+CeD0JgpZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_04,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412230100
X-Proofpoint-ORIG-GUID: uSJTHD3n3aoQL9U0tjY9v6AS65tx10VQ
X-Proofpoint-GUID: uSJTHD3n3aoQL9U0tjY9v6AS65tx10VQ

Peter - could you drop this patch for now until I have a chance to take a
look at this issue on my return on 2nd Jan?

On Fri, Dec 20, 2024 at 10:53:14PM +0100, David Hildenbrand wrote:
> On 20.12.24 22:29, David Hildenbrand wrote:
> > On 20.12.24 20:36, Chen, Zide wrote:
> > >
> > >
> > > On 12/20/2024 1:56 AM, David Hildenbrand wrote:
> > > > On 20.12.24 10:31, Lorenzo Stoakes wrote:
> > > > > On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
> > > > >
> > > > > > With this patch, it seems perf tool has some problems in capturing the
> > > > > > kernel data with Intel PT.
> > > > > >
> > > > > > Running the following commands, the size of perf.data is very small, and
> > > > > > perf script can't find any valid records.
> > > > > >
> > > > > > perf record -e intel_pt//u -- /bin/ls
> > > > > > perf script --insn-trace
> > > > > >
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > I'm on leave (and should really go back to relaxing :>), returning on 2nd
> > > > > Jan so can't really dig into this.
> > > > >
> > > > > But I tried it on my intel box and it 'works on my machine' with and
> > > > > without patch with commands provided, so I'm not sure this is actually a
> > > > > product of this change (which shouldn't impact this).
> > > >
> > > > Zide Chen, can you try with and without this patch to see if it
> > > > introduces the issue?
> > >
> > > Yes, I re-did the test on a SPR server, and the result is same. Without
> > > the patch, it went well; But with it, "perf script --insn-trace" doesn't
> > > show valid records.
> > >
> > > This time I tested it on the clean 6.13-rc1 tag, base commit
> > > 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > >
> > > Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:
> > >
> > > Error:
> > > The - data has no samples!
> >
> > I just tested it on 6.13-rc1  vs. 6.13-rc1  with this patch.
> >
> > Indeed, there is quite difference. Below are the main parts that changed, only.
> >
> > We seem to be recording data, but maybe what we record gets corrupted somehow?
>
> Huge parts of the new file are full of 0s. Either we are mapping the wrong
> pages, or reading from the pages (via PFNMAP) does not work as expected.
>

Thanks David, and apologies Zide, appears there is an issue here clearly.

Could you try this with sudo operations? I was doing this locally and I
wonder if there is now a permissioning error?

I'd be surprised if pfn map would cause an issue here as it should just
directly map the kernel memory, however if the PT code assumes there will
be faults there could be an issue. I did take a brief look at this last
week and it seems the PT stuff relies on the aux functionality, so that
could also be a source of problems here.

I am on leave at the moment returning on 2nd Jan, I will look at this as a
priority when I return, as you can see above I've asked Peter to drop this
for now.

Thank you very much for reporting!

And happy holidays to you both :)

> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo
