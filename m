Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67141FA25D;
	Fri,  3 Jan 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915545; cv=fail; b=fHY8LGkUYQwr3IJZKH2otoqOiyjr8+qM8f1hbWM9V/0QwXFwSxAszJF1lrFWmFdoTw7Py7ytxbKdWu6yK5pbSK4OSeVjO+IgaEdHa1eB6lRE8+roMSss9FtjnorE3UlDlul8jIXC3XL5XyE25or7EgQdN9asRY29C8zpnVRAZTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915545; c=relaxed/simple;
	bh=1kbgUrQbIEQMugO5FDvuAWPaQgo3d6jKZGfyqbwg+CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eN8bx1iNkPvLfNxOnjvY+EYbz47xXLZfg/NIaYs7yAhCG7CW82tUrktjC+qGhLJH7p/i8DqZA3uJrdILbhsJPvLBroL1tkoS/qFAHPqfV9VB55y9tRPSBbvIohGrtKz8C1Q9PaXDnaPRJL5o3NHdLVmhW4oMR4EoW236rOru4LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nhhNCDwA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nVwp5mhH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhhNCDwA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nVwp5mhH"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503DfwcX004767;
	Fri, 3 Jan 2025 14:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wG3Fxoy4pQdIlmVv00
	JKemgi/oZKO56ffDo4r/b76tM=; b=nhhNCDwAEUdwcuE4d1ZeQz2XfagdKzCj1A
	gN7JXJTqtFoUKprojGxS+LOqisi4mRgkaiT372KHE7h9w4+17rPW2CGneWBltu1j
	7n1T2VbKejRvO42oHZVULX5dTpx9vxrxEZ16PE0UbMhYpRKs9t6XbDB4x77dl/EM
	7pup5K/GHXgKZ0a/tjwDg4/tlP1SNWLnIxGZX7q/Zv4la105hGi8Xg/l6gI49yfK
	Ny7r/xiCpDFRZQrXyAzBD5Gsv2x/w64icOgUbazq8NGq/MHK/N7aL0EqmvSHYGxl
	5pxgMUP/PIYAMU+xmAn9H+EECHHYEoQUS58rfexnndBMGYIPB+Yg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t84207ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 14:45:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503CtvlD009521;
	Fri, 3 Jan 2025 14:45:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s9rbtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 14:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiWxhSHAmwHTbiVSmHbB+TER2INdXJg4x1S1gtXVx6XpYIfzCu81vnZF59ziWj1uHKyPoYqOyMz10ncjjsRXd2nlWTKjk2XQt1QhRWhgPh88zq3uDifn6Lvg7FdWeu0b7ghO79X2ltxHk3FmU73jTh+8U8YoukGVAVYN2uuYGlVzx/6yaUr3plKnM94EBM+/jYg1J9Yne9AwWEMfLKOSIWV1wcly1h3s6dp7r8awQZB1BvqkCpCs0pc2muEIn7f6boQ+w7jtrEDujtaRI8hsPayq9NDbxQUTb/esWf8wBaGh/0T+lM/WeqNGoTg10RM9LQTlQSrR+S1Jo9WPnkDH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG3Fxoy4pQdIlmVv00JKemgi/oZKO56ffDo4r/b76tM=;
 b=ZSCGA4k0V2vuUFL6W9xy364w8D3PcTItABHcqPn3eM17wHMUnBgokZEtSA2OP+DpTAxyKwqckPaVCjFFXS/4a5wBWDf2LO9LKy45m0oDEY6SC3tTZoFU2v3GbaTHoxCnwc02xo5zTPp49P1VUHHSfr7BX/+0rCKSl04U7JkUppvJi+GPvIIKhvVcv11X4wbTz4MlXEUXeS8E3bR/C6wpV/SdCZyHojxW3nyW4Vfvr9N+ZrRsJFKbpnTwlkxdm4WfwdR9TzwOGQrEqPuxzTZS4szYtkA3lKtTZRH2WewUAZENA4pNplQUHEgykJLsvlJAPum88LbP/iBDPBmS2lZGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG3Fxoy4pQdIlmVv00JKemgi/oZKO56ffDo4r/b76tM=;
 b=nVwp5mhHHgsNEAqbCrS+3Fcwi3mDDvBdKfKLd+cvYrf/WEbPUVXS7Fcw1GTMwhPbtVuqvQsz59yleAEDLJ/vT6NZ9DAPpVpomknIEj5XiuRz9KAVhAV0GRF5mzwgoOBCYlHutFEQctxqlfdrrWDVhTSNkO4YudFimcv1yUA/+UA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 14:45:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 14:45:05 +0000
Date: Fri, 3 Jan 2025 14:45:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Chen, Zide" <zide.chen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <0d99b80e-0ae1-4d74-97b9-68fdc0029fb5@lucifer.local>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
 <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
 <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
 <ebaa9d2e-c5f3-4a93-9def-caadae92acc6@redhat.com>
 <e489e48d-f9ef-453d-9b88-91368b9534d7@redhat.com>
 <f4299bff-3448-4095-b573-243f1fca834c@lucifer.local>
 <2cb3d067-fe92-4bdf-ae79-b24810a4bc2e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb3d067-fe92-4bdf-ae79-b24810a4bc2e@redhat.com>
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb7a571-4058-44c1-8c93-08dd2c0535e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TnlVAWOeDqa8pEcYPTJ6fqVVRFMkILmb1oBq+xWTUl3JEmCJzKrWjZp6IQbX?=
 =?us-ascii?Q?cxucIeVpYAOEK69tOLzvdItSOWslckF3i9cjLPgcs+0eFeaG2ry5BfZGhrdx?=
 =?us-ascii?Q?t0cquJqMvDKQSk0uItJtAg3F4OXpzul45okypQSMSRbEFqLfjap63iMi6hxL?=
 =?us-ascii?Q?8WrbpmhRCmkoUoT3Q2mqcGEczlxlhjT5TmpC1b1GZ20JZ9Cn52pnOjgb9A6u?=
 =?us-ascii?Q?g8SHzd7/kJuaXALaYk05KeQI0MMNv693fNYCrHVZtGNQWDTJA3VmoR7Bwbb7?=
 =?us-ascii?Q?MHRKl7FAgg4tP01s8EhP4kjZ6KotXUpz7I3xYO+ycy2ztxd0s8vABh2ZLDzv?=
 =?us-ascii?Q?QXPWoIWs1O66uPlU7j+mA9+2lSXWr1Lsr828LiVZw2Md6fxHaUEQn52hU1PH?=
 =?us-ascii?Q?h7CJtGUkxjQSrJkcjV1Ne3TN/kLiUumS55zUVZ6ByCR6VybTXGfbscZNON0q?=
 =?us-ascii?Q?SuvZUmeqGv4V11dC9WUKv+iJdIk/XKoQi2Tat3MObgwUOun4VpffPH36LAtE?=
 =?us-ascii?Q?B9OkeGuAh7m4fmd+fbxZPoTml3o4BI4StP2RH4iFfEDQThoS2SmPWK7Kwxv/?=
 =?us-ascii?Q?i+1890ABlPbt6i7eYeJiy5d2YB5UAvJjgr1cH+13dyf38JJyjnQd8QW45Yl1?=
 =?us-ascii?Q?mHlTkU8lxNC+lhNarI7SUXCC15am6yf3xcN7mIBDZKZV2FBoiqxY4o+JZWil?=
 =?us-ascii?Q?wnJj1a1c8L0b4QDdpIpfYFG4uG3MH+q5O0zhGpl382mRhghvAR4mzTLhsMj/?=
 =?us-ascii?Q?myx6xfU+QgHEScEpzBF00gbYjVPEvWWhHYiUwxerWAc7hlstOry168zYkQjp?=
 =?us-ascii?Q?5PcTW2QrfCIDxYYHXzNMKft8c3zYYml6wJj3vewfMUyVKCdrjV7wi47pLTQT?=
 =?us-ascii?Q?QvDVxJP8ytFFe057K/9sABVRd23GLmapg5u3z+Rf7b2Wp0Y3dYE/R6jh5ANu?=
 =?us-ascii?Q?gqhG1h+Ix9nKSuu4JMNGRz+6guyL6F+b3Zo3y/ZqCOiLAQUfZJqXuCQTYQst?=
 =?us-ascii?Q?VzZsabmn9lO06vl3hkLKGLunSSdffXQ5UV/ZIZydW0ve8xYRvpPMsl2SME0q?=
 =?us-ascii?Q?T+FCuKP4Icxf0S8LSr8Xli7qEpberX+smppE+UM2SOkNYKU9hnDk9nq94T49?=
 =?us-ascii?Q?7o0xwa4OluK6+j+B+O1KxsJ1G+1ayHqVp0uhp0iu5d4qAUtg9P6AXcVQ+pX2?=
 =?us-ascii?Q?SNvC3eNvN/v7PawcM2kd/XzxT9EZw/45Is+iHQ/SEGX8ykP//FRyGyo2sWgA?=
 =?us-ascii?Q?rJCQ+IvBCIPW8XEpJOtUO+D53X8lEt388oUBTBF5igpScBG3vd4OOAbthn+Q?=
 =?us-ascii?Q?J/wlKk/+7Ga8FGrzU5ZjNvNlGPSmYY4Dj3CG43g+bJhvZaE/9g5nmcRNRESA?=
 =?us-ascii?Q?X0MD/Hl0lnePgL8qhEzAnTkFpqVy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+In/xup3Ic+Lcd0s8gsVkHwNiwZlYEs454FCH79cn1LcSK7PW/fi8yzJQZX1?=
 =?us-ascii?Q?+42RE3nBsxlAioOrTQvXkKyFVYOc2xD29wNcnfy6XYvvstJSJt3d6LC35ZG9?=
 =?us-ascii?Q?LN620NU2yL2gTX55RSBNa/Hejnm7R6eOWX2lTU/iqN11m7nmwnai+iBBvZo2?=
 =?us-ascii?Q?mUK1pE44Mo5nOkFcSRXc6BUdseBf4ozblL3RgAo0pcpeE5DlPgwYzYSeMJ/U?=
 =?us-ascii?Q?Kxz5hThUyCioCKew8GuAA+IIgXNHpLb20/0kCcWVhnQ6/c20eAkv/AXq7xaC?=
 =?us-ascii?Q?SObbOaKuNzXjYDUYWhGyUC9Lh8uylxCqmEgjKNM7Vpe0oZ6BBbu7gbGwaMpP?=
 =?us-ascii?Q?0HdwSJT+h4l+7s3I28qBLh8VJF3RQzvrb4NBCQ8BtdlVdm0kXf/C1i0AdjhA?=
 =?us-ascii?Q?J7PtZiZONQ11LtqOKiGTThzy7a0GL5xsEL8IhHd40KCumizG+ontpaRvjbwk?=
 =?us-ascii?Q?YQ1zsIOl/eUw1OrZuTDd4O1AoNhQGQPXvuLgsUfNTMSMyOvuB6S3YFeplMsb?=
 =?us-ascii?Q?CX64s5BQfbpeNb8F8LYhSxCq4x/mRrrkrMpQbSAMVPiRnvX/TePovQAclCKA?=
 =?us-ascii?Q?kee2JnB7OfpgMZo+lfqFGLDpTOt8n73IEJfw/RGDgEC5cnlXqw9oSMhhg0J9?=
 =?us-ascii?Q?9rCY+CDBPgbpsvsdZb8fWAh6Y4DVEl8d+A0oED9ZzxosD6IsKdB2XF0d0BdD?=
 =?us-ascii?Q?WGZGdjKAZMWoVpgY42Nj9C69NyXW/rxhgrVtBOK6mysfTPuqdapRZFeiiZtc?=
 =?us-ascii?Q?pGXZzxMCPNTTQNOIoh7Fn/V9Vm8q7geQfc4kWWi/8XEP/vUgPSnI8NMqb/Ka?=
 =?us-ascii?Q?WmTG86xsRPYw43xNhPWYV2zZSx393P6RuPV++vE/v8dnb3SLUKfEyil2QjK5?=
 =?us-ascii?Q?uIUNFdLIK04xrnahxsvalKfz1GiARkPnfaNHNyK3h5LPBdCMr4S1ahXZRaiU?=
 =?us-ascii?Q?hWpGEuqCvo4RqHB9r7GJ8XV+zfWrKud/4Kbu1dWOZQNHg2ydDo5xI1kVnjnL?=
 =?us-ascii?Q?ARWjiqhkSOzp7yF/4Xm9RKLntTXyO5ELVPufj8RnR+KoFMN0h6BEXJiSEvgQ?=
 =?us-ascii?Q?R/X/uWqnjcMOmcmkV4mlUmY76gaaj2wEQMa/mAMIKnkN3aNdppDz8NjMDP6D?=
 =?us-ascii?Q?WxgjtAAWY9Ee/9ybBrlbfyBMkIlAUsTp+sbKxOW7bkdG6VP9+MR7M6d0KF7m?=
 =?us-ascii?Q?h3hg6UaMI4YQOe6OhoGEKg3fKv4f7NWrzjY97Uvd0M9RZufDuGC6R1+dVGC2?=
 =?us-ascii?Q?ugPk/ndmJb3DqtGBBEZL6q+bwk1Kr3V1C7cRVDhZ1DEY4PsBMEL5wiy8Skb8?=
 =?us-ascii?Q?PvMEai5JtiLbXPmn/vdzZrSUKQVof4SqeFrW27rhraiscv17s4Krmqn1FN4c?=
 =?us-ascii?Q?uGZjVCyW2s7P55mn4JXRPBmJRzcaVMKPWCmX7cs9w5rg6YXxgSylxQ/uQi3m?=
 =?us-ascii?Q?yD51mnYfJDWR4YH/rfjdVUrFetlj6dltLBPPZ5YhHdZ4BsQGNhoamlLv21Xr?=
 =?us-ascii?Q?NZM6oF++c8BOpMZNPF7nbE2AeZBa+xmvCd2bFsyVNc1W+lQOgAThmCE1Mx1/?=
 =?us-ascii?Q?wa+AGrpchTszeunjgSIS9vuu/Wh6ihHW05hOOykuAMmcBSW/jdfs9dGJqGEF?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ub3ggSye0Y8DTWItJ4/rjAHRtTmt7bD0nO6C/G1EI+o83vCYlN6lb9zgdDGPET5Jo0K9rsMnxyW7HYVcpF+FB5YhEUYJAPbrdYkT/O6+8aZLYb4rabXf/RYkCswWTEtSvWeieGwKxLyQ2TbfOA8EEygpovsJq5BdhtJnxSa+haWQ1DAVFusZVmxtq9+oqBa2mjKGxlcVJreSm0a3lo+7yZ/6/lZnJ5XKKgHBrN6/mMMf2j9dAd74GIBf1PFdCB704k9K/5m8RpxesYptMmJGjoc1ToPQ0LnDYY8fSs8kKYKfNt65BW3Cb1t9M1G/fWStWlU1asX2WcLb6RSyqwvVu4sYrDHj7NKDZmWpQpufMzudUAaEDG0Fc84JNM6nIkzaLdxR3aB602Sm5PR/6GtF1SfUdXsDlgqrNI4MKaCOZWlHL34usDjhC245QM386bnPI5AkkNVwAWU0AYPRSq1O5uiza/GK50Uess6CRY4QuXxMr4uNZJpVI7LfU6D5DObkTaV2gYlBwLm76+74F9kedJiDaQn5Cfe6rwbN+Eew95TvY7zgXqjeMOjhiPn7zKqkZXOwc9z7Of2QFO59JVLjdhn88f/If26K67NA/jwRgcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb7a571-4058-44c1-8c93-08dd2c0535e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 14:45:04.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GhqwPdTOrLzpupcGn8bzvknjl0xilSkfjNYwihnh8dpIHKFjHtQGf3b4WqRwfSLWuLb2kbiUZBmVRn38c5AHw85Nwj3TI0jdwc1o4Et94E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030130
X-Proofpoint-ORIG-GUID: K9iw4udZjNaR5x6db0EoSi-HfM_tmDw0
X-Proofpoint-GUID: K9iw4udZjNaR5x6db0EoSi-HfM_tmDw0

On Mon, Dec 23, 2024 at 10:12:42PM +0100, David Hildenbrand wrote:
> On 23.12.24 12:10, Lorenzo Stoakes wrote:
> > Peter - could you drop this patch for now until I have a chance to take a
> > look at this issue on my return on 2nd Jan?
> >
> > On Fri, Dec 20, 2024 at 10:53:14PM +0100, David Hildenbrand wrote:
> > > On 20.12.24 22:29, David Hildenbrand wrote:
> > > > On 20.12.24 20:36, Chen, Zide wrote:
> > > > >
> > > > >
> > > > > On 12/20/2024 1:56 AM, David Hildenbrand wrote:
> > > > > > On 20.12.24 10:31, Lorenzo Stoakes wrote:
> > > > > > > On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
> > > > > > >
> > > > > > > > With this patch, it seems perf tool has some problems in capturing the
> > > > > > > > kernel data with Intel PT.
> > > > > > > >
> > > > > > > > Running the following commands, the size of perf.data is very small, and
> > > > > > > > perf script can't find any valid records.
> > > > > > > >
> > > > > > > > perf record -e intel_pt//u -- /bin/ls
> > > > > > > > perf script --insn-trace
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > I'm on leave (and should really go back to relaxing :>), returning on 2nd
> > > > > > > Jan so can't really dig into this.
> > > > > > >
> > > > > > > But I tried it on my intel box and it 'works on my machine' with and
> > > > > > > without patch with commands provided, so I'm not sure this is actually a
> > > > > > > product of this change (which shouldn't impact this).
> > > > > >
> > > > > > Zide Chen, can you try with and without this patch to see if it
> > > > > > introduces the issue?
> > > > >
> > > > > Yes, I re-did the test on a SPR server, and the result is same. Without
> > > > > the patch, it went well; But with it, "perf script --insn-trace" doesn't
> > > > > show valid records.
> > > > >
> > > > > This time I tested it on the clean 6.13-rc1 tag, base commit
> > > > > 40384c840ea1944d7c5a392e8975ed088ecf0b37
> > > > >
> > > > > Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:
> > > > >
> > > > > Error:
> > > > > The - data has no samples!
> > > >
> > > > I just tested it on 6.13-rc1  vs. 6.13-rc1  with this patch.
> > > >
> > > > Indeed, there is quite difference. Below are the main parts that changed, only.
> > > >
> > > > We seem to be recording data, but maybe what we record gets corrupted somehow?
> > >
> > > Huge parts of the new file are full of 0s. Either we are mapping the wrong
> > > pages, or reading from the pages (via PFNMAP) does not work as expected.
> > >
> >
> > Thanks David, and apologies Zide, appears there is an issue here clearly.
> >
> > Could you try this with sudo operations? I was doing this locally and I
> > wonder if there is now a permissioning error?
>
> I ran it under root.
>
> >
> > I'd be surprised if pfn map would cause an issue here as it should just
> > directly map the kernel memory, however if the PT code assumes there will
> > be faults there could be an issue. I did take a brief look at this last
> > week and it seems the PT stuff relies on the aux functionality, so that
> > could also be a source of problems here.
>
> I started a bit at that code, no clue yet what's happening.
>
> I was wondering if we end up mapping the wrong pages, meaning: the pages at
> mmap time end up being different to the pages later at fault time. The code
> is a bit confusing, but I thought we cannot change the effective event/pages
> while we have an active mmap. Maybe there is some corner case ...

OK I figured it out... it's a very silly mistake on my part (oh how this is so
often the case :).

When we map the pages, we do not offset by vma->vm_pgoff when looking up the
page, so if you map with an offset (as presumably the intel pt stuff is), it is
then retrieving the wrong pages).

This also resolves the apparent need for sudo...

Very silly mistake. Apologies :>)

I will send a v4 in a second.

Zide - could you give v4 a test when I send it out just to confirm it resolves
your issue? I will cc- you on this.

Thanks again for your report, and apologies for the noise!

>
> Nothing else really jumped at me ... moving the mapping og pages after the
> event_mapped() callback also didn't change anything.
>
> >
> > I am on leave at the moment returning on 2nd Jan, I will look at this as a
> > priority when I return, as you can see above I've asked Peter to drop this
> > for now.
>
> Enjoy your time off an Happy Holidays!
>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo
