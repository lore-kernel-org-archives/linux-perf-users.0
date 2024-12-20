Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CD19F42F;
	Fri, 20 Dec 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687113; cv=fail; b=id/y1p0McBJK/3w0WDtJHvIyAB/F14PKlEYKpb18DsBLH7rI9gwenS/HyflKq0trFIp9heLQVWb1Je3rRunjJi0Ady+296bErOwebkdJh/H2IO2RKvKT4kQNfqxpftwy7TnsHMb2dCDXOEe3wwYuHsLotbn0gKcPvfuNL2NCvIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687113; c=relaxed/simple;
	bh=iUnEjgni/q3vii0lIE9ZhBm73bkhmpGYgsefjNIbZ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEXraVl8sqmiayRG9vE4oR+cI/PgklBJ6UWZa/XydJLks3HpQQZOONNwL7A0E094Ll3kTM/wo/Cq85Tj06VZJqG78nf2Y57igSMOzcuxuJzp1cFAtL4OMvnQZo6f6c+tIgW54z2Tisqq1Hrbaxe6V6sIzTI+AphUpLtXrB3z8y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ItrvzxNS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A6IZO6xe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ItrvzxNS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6IZO6xe"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK3u22f010442;
	Fri, 20 Dec 2024 09:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=iUnEjgni/q3vii0lIE
	9ZhBm73bkhmpGYgsefjNIbZ3Y=; b=ItrvzxNSX4hrCOWST4LWhKAdkYLPzTx+Zo
	lxFgxepkHRj+9XaPOllQ0eJfosIDJbzugMZVRQU3Se4om4KWW2jANUWzcn1cg+fJ
	n710wukPHOe5fyUREmy0yBSQuC0NN9Zg5zQQWp4Q3S/8RyzOfaXfF3m6gcLFDqiD
	u2x4op/jQrj/umkMUBRjhSVIHRcIlSSz3W/3mkVMRaEXBv6bqS8DurQuJvfa8rfC
	X+YEK45zUXZ6k+axEE1+6oRmpenANkTk3D1otAoHQoitnuL1LzlYevfyNO95jbdi
	Zj/gSXLcu9siUN0gGDsOXvt8Bw2kU5i9RjtzbRfxIVeakr0auX0g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jtd0sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 09:31:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK7FtJT035494;
	Fri, 20 Dec 2024 09:31:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fc9h2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 09:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbo9a2CSS02cbzOOjegsAsLeWmJS9b5GJy3F7Y6Sj6u/8Wz/XAH6nsV4BJH8BVg948h4ChyVj1GBZN1LOKQtQpBvTjYJgAYLDsPom6m2GvewaxvlIpkdY5QY5305UegmgiSCb2PA1Ri3abIqwg6/HxMyY3fHhvnR+gJVZFTkPrBU/6Fq7C8qqYyJcG7Azpwd35WIxER+vNj7QSlK8EfW1/X7lLlWDVKsvg1m3eRe3YZmeWSQrLxMQlXjYRQ8AwkvO4kX1jCJksozkoMMakd1Pwc2JF19FOueVSNPORdiM34QDWNLzGSebrGWhxMVxHIpjrEvXaIOBrZLsor4ZcPnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUnEjgni/q3vii0lIE9ZhBm73bkhmpGYgsefjNIbZ3Y=;
 b=udyF06secyFSV2f4rfTvY7s79lT/l7Q8EvnCJMAGLHvG20L3mARRsPBDCuxmUUyCKleuGovCjucUbLgzwlYX+Wn1FHR3n4pYaoJt04xEO2EySraJf1Z/+Hn+nC8IyTDI+Tza4RC26BkPEaeVwZcKXUqIDNbnZQkVwIvKUWc+0VJPn6cojKCccwyj2P3h01ME7vTCPkgXE+SAliNd4qzEvprFz+bzS/bRSz7uzCdu4YR+j/euze59hX8VsFbdEe5Cnf3Z8TZcizfKPUszYjjy97F8PODzch3x0kSWVcWPv2LHE7PqQtzw9aO3VqxEakQst1eneiWYiErOaynFlBiKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUnEjgni/q3vii0lIE9ZhBm73bkhmpGYgsefjNIbZ3Y=;
 b=A6IZO6xegu5V2sv3hH2XSW+akb8+2u4BCYu5n3pOYBAvOwTHGbYimG1Tpsym6neydOrHt/dMK8vKQHtfdXCthFcRZ+U5SKvotshaIrc0rl1PZutJ8FaDTyDxUWol8+gkP8gO+GY4nEQqRLqP4GTrY2A5jho4hbwSG7+Y5BlG4V4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 09:31:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 09:31:13 +0000
Date: Fri, 20 Dec 2024 09:31:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH v3] perf: map pages in advance
Message-ID: <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
X-ClientProxiedBy: LO2P265CA0368.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 94231f2b-4da5-49b9-9928-08dd20d90bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2yy6qv8CCmfw4oybGO05nFIIZkOm7+La+LuWx00C1tjXmms4nj5hYc2co+lP?=
 =?us-ascii?Q?MHyka07SfwUKKGOvtiusSbN79Nt4UI8zfc6coCIms5PWd1zt/PDmm4OXwoTK?=
 =?us-ascii?Q?KE5bZAo8ORBgTNr2ImFP33vE1YrYqlF0JKyyQTt8cm/cQOUUvZMsTKI5ckOZ?=
 =?us-ascii?Q?W3279N/06G1faoXHrHWgZLmIagp41vePd6AzSyh49trw0b+jqgbvZUzu+RZ1?=
 =?us-ascii?Q?04BsmHsBueHzdbcjasNEmJL7Ivmeq8FFBbFF/jmU3huLP5/h3R5IZpcnl1SE?=
 =?us-ascii?Q?SXC7PZh0cFeGWOlQ9kJB/nHEZGPM+aZ/x0FR2Se1a3aewzevV4cJOkJgeScC?=
 =?us-ascii?Q?5ZtuIYs7gdgcOozdqSiOorktjvLyXsCOYKullrKGx8bZ2WLcI3pK1plTiGfv?=
 =?us-ascii?Q?sw6swHjJSl645fqreUw2TZo3sf25yE3n0fohvQx6o+weSPatVGkS/HEdRWmP?=
 =?us-ascii?Q?cmEb7/MF4s/KWfq0lU/CZNXoRqkYgEnhVXD8nO1Ok9j1w7eLVFVuRqFiQwzh?=
 =?us-ascii?Q?HbAhYpERJ9hPOFZvcWCHtvqN5TdaZqSYRmy6fByNm5lkTD2OBnsZX4diOcda?=
 =?us-ascii?Q?ch05rkaZ8+mk2UldlEcORGdm0jpJ9OxBe6Q7mRx0q6K1DpgT1xk0OYrYJ1gP?=
 =?us-ascii?Q?p6q8U6HyUmOE7h+5H0nxItO4E7x9EYdQm1sEwS2L4AfR+7LTz9BclLvgWdFO?=
 =?us-ascii?Q?xHQW9VoujI/glYhePyTL2cBAmtSJfeTn9XpiIj+eLxd8HFsAsKvSpZF4MgkF?=
 =?us-ascii?Q?A4bZty2SP5/gW/5TgA5uB/OkH5+ISenQgdY70YZxMYxdnWG0SO4Rd28b6OtN?=
 =?us-ascii?Q?GsbKBtmnoJaCHvsCsXt1tB2J2M3fqaES0mbSStdtCg43CRvnGECdmxYFBc4S?=
 =?us-ascii?Q?tQ+TqYzWAEPhKupKdGCmblBXALkwym5wnIwdWAfgiQnZXina6d4T5LtUunc1?=
 =?us-ascii?Q?6y3PZrrsUkIOJEFWx6hxOdoD1Yf6YQ8piIN+6iShxGs5K7TImVFG+/giqIgU?=
 =?us-ascii?Q?aRFRqPCN50RYaYXwOuJNHelWQtWmLzOVM+RhV5apyJwWZIe/UOlKttrLqDsu?=
 =?us-ascii?Q?oT5dFXyfnwujo+GsjKF8Y7TywouqjWpvpiuTp730+Ox+HeQcqldJxQD7eDtg?=
 =?us-ascii?Q?+dy2tqgCyIaHZfma1xcciXrFMLIy726mWjtVxazqGB9fKbAt90amAOs54Ov7?=
 =?us-ascii?Q?5VNd51V2N28KV0eBjVJLdugfS7ziaZkmw90EHiRplONO1y1zOoxZ0jU1CZuL?=
 =?us-ascii?Q?8tVeYQ0ydUyxespao+vBV/9BI3X7AojO7CXHEcD48DqiPUf2G6LaFw6ZOzTO?=
 =?us-ascii?Q?oAjiRC2RvLunl5fMqPOeXFXlnf7jnrZHW2mpx76rvV68ogDjVvE3Zv/zPS09?=
 =?us-ascii?Q?VAp1GH1gkSpmu8ClhxkGY8b1cohJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kd6nGaf17ZkOkIY/SVqCUStYqkMJ1wT3T9CJOcaUFqFFQ8iThE2qt/l+hss7?=
 =?us-ascii?Q?m0cczOLthl/tRoFuSC90mixf2uDbNnYyyLe5xMC1Jlkh0xce/StxFSvZMc4h?=
 =?us-ascii?Q?kUL97qry9oNod8opFBU3kfZ4BTtctZz3jDYA2gOSPy/ROmB8Mra2U09G+vWF?=
 =?us-ascii?Q?l78+F/ZWQ0fgEL1p5I/Nvmhp9z5OPueYFd2+OEd5Hx2ZXB8ygkvQQQusoELl?=
 =?us-ascii?Q?CbQ+EE8d/o4MkooSVfTpK6cgaTabxUOmOoVcDj7B7o1gSzWs9DxINqhek2SU?=
 =?us-ascii?Q?Pw2TKwzLAUBryFPg0VKQwnVtfbNnoagYTH8YK8eEadkOih5aMOtvuPeZ46J9?=
 =?us-ascii?Q?RrXEO2ied8+wEqEd8LQ5nREvSaUS1gLhjwd3NdXoTvPvmVVeRUa8KjwDTtmL?=
 =?us-ascii?Q?6/D+X+XHOLQOvXdwB05OnB3ZvJWGgmtE6TPiYwWL1QUtRFYgGmDfzHC4fPpi?=
 =?us-ascii?Q?sFtgAuzbHPUob4n0H4m+m33Dc9jVgbvmBP3CWr7sUC6W7PQpeLxgRz3ghF5P?=
 =?us-ascii?Q?48ZEY9BdIVqz1PjGNZqCVdIFn6fzkPwSu+vzuWDmb5UpQPM1QutgzM6KEgRL?=
 =?us-ascii?Q?PdgTsb/JALt/Zilm3HwFKzq02+dF7Aa7i5JRf5loGd6OIAKkyRwBmzrsfqpb?=
 =?us-ascii?Q?32lWkhN2iHKwMbu43lPD5yw5hsss5eisMAEWOKCDs9gINXCT0CyThpUfQBSY?=
 =?us-ascii?Q?/PXQExYT2lkcLeQfOXg132FdjMhp3Wb1XH3Tb2sLqOnFPZrFG6QArJIKeewl?=
 =?us-ascii?Q?JWvrqnlZfsQivkrXJjCUYOhBFKInT4g1muXDkcOuo9gmDpxpkawk4iJekt/v?=
 =?us-ascii?Q?0VlSOQygEJQ6L5oDNILvyTpVSFGQFB9DcR2vupL19M4yKVR1tAv6RqLY5CXQ?=
 =?us-ascii?Q?K0sfGNRit204LhLAcmzM3jE7jq2oou2VW7UoCI/L1O1hGBgFIiBaeOLArZmD?=
 =?us-ascii?Q?eTfw+jsqz4PJMiKmBXSMBxqaPbxIcBBJsozkeAM0nYmMeo2HARlBCfmTcaOo?=
 =?us-ascii?Q?QqIrl5/RPXbIdpXZ5T3J5w+BZPJmwJ9yvHkI6xuFOvtL5k60jN+3l6izsC1C?=
 =?us-ascii?Q?obIMOOHwLGHKQgZALB+gxQOxq1cteTdJbAGk+eYNcxRpSl2Q36zq7/rxFBnt?=
 =?us-ascii?Q?vC9kk0wmy8n0HBrNpJCYmwX7ZFbVXmLAqntk1KQYy4mOJn693qxaZKuaM3jk?=
 =?us-ascii?Q?wuHT+oC2m50dtIT9wcyPUPo/UTjpSPl7JQmvJZfJroLwI8sTytBYxk9ID4ad?=
 =?us-ascii?Q?FgtGLtOGfIlvr+wGUaiLlpm0A7AJuAi+aMSCcOnTOuaAugxEFXGjU/qL75iq?=
 =?us-ascii?Q?w17rDKx1l0ujWFpwCyy7fr0qV8taQPqESSdsmzcfLhitEf8DU44X+RE3CmnI?=
 =?us-ascii?Q?XVs/VMAqxTbyp5B1I19HIiww+6gtOL/y/N46mM12EK4apNO9LXlfXCHVdRDg?=
 =?us-ascii?Q?2r3BgdWbkVk6uvmPeO2yKip3WTu/T1AEaAREeuhgRmMjF6PQTG3t5DuyT3Qv?=
 =?us-ascii?Q?AJA6cU6EPJW+LGC3lxKS6KagWxrNSxQBzfUCMvz+km1xEsAQz1NjclXpieWB?=
 =?us-ascii?Q?n4bNIw0A81Ix/nZ1r7cclbP3NfdJhJ4pwzpgudTH4l2pbKk8MtfN012Akx/e?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S10aXBWhUgZYmRJXxrDc6i155AWVdxFIUhi3lfu1OAlzyxN2CCCVCszf4DRQfuyzOw0WqNv3zUGKgEAMw0oX+dDMajm4vyIU3XxJR5wSbSmC1jFMYk22ZlwNl6PODZvDLu2trD1Ii/2/fJlJQOi+lSRO3GIUvofrLHCs5KcilpzwD+dwjhKyJcqKv9l1TyaIv2lwygsd/Q52/ywoNDRRv/C/kD5UBCAJjVCyhje9vbLCm6GGqNWV0HhR8xASiui6ugRu3jMmzwhm+EoxLuSiD9C9mGL8EgX8+F7xOQie7iphAYv9nyCmgrmqJC+h5q/34svp9t0jYc1wkugnEBQU1W5ZRLJ6WIYgkxDFg3HDavrmDNgMpSWIWMEk+OsIk5ENgWuga6HuPiuklTKgJccB9k85uAtU3/gt0nvse53BnIgWNAcXTyGAxCB5HngYduhiY65063s8M/L8/0RKneZW6/vSe2xoJiE5hraGyxbDhXvRovquddm6F9YDpjGFDHHQptubgG6IXdjQv2XWn171RPJDi45GxWqSE7Jg5LYyF1/lNPN7ngDJouZciso2qvqRwpXCPxbkerMT1IkPnd7XvUVWNkQz8oeXysXMGpclGE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94231f2b-4da5-49b9-9928-08dd20d90bf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 09:31:13.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXFuAyCB3vojsEq7C2BBezTrvMznfXauFcy9ELJm6LdZKcyDlkZhd+d/QAKbx5/uPrN0iVy4GaCVnbQtbTsYi+GzFbnPBqDfEJ22VSQaLxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-20_03,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412200078
X-Proofpoint-GUID: 3e-GjztJABItLRyeqPMntp1ELKDB_Ya7
X-Proofpoint-ORIG-GUID: 3e-GjztJABItLRyeqPMntp1ELKDB_Ya7

On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:

> With this patch, it seems perf tool has some problems in capturing the
> kernel data with Intel PT.
>
> Running the following commands, the size of perf.data is very small, and
> perf script can't find any valid records.
>
> perf record -e intel_pt//u -- /bin/ls
> perf script --insn-trace
>
>

Hi,

I'm on leave (and should really go back to relaxing :>), returning on 2nd
Jan so can't really dig into this.

But I tried it on my intel box and it 'works on my machine' with and
without patch with commands provided, so I'm not sure this is actually a
product of this change (which shouldn't impact this).

I'm afraid I can't really reply any further until the new year, however (I
really shouldn't even be replying here ;).

Happy holidays, Lorenzo
