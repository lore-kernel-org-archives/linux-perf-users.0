Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47D28EC;
	Fri, 29 Nov 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890962; cv=fail; b=ZHRBkdae9DKqDDZh7bYFD7Q2hdrdZbksPuoz7RjfFKqKRXdxQ9btG3yYPBWKDTAXHzx0RBYDvrMOrPpaYqL+S6BRvPYwm0ARuyDT1nO390FyEre0xGKzf1WDaN09uG30lh8Za8FzGN32fGsq1Oo5Ezm7pdV8/XAOD1dS81014u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890962; c=relaxed/simple;
	bh=4AnlPfTldyqpTSYOo8h0ktDE1d/Pf0i4sYYYiT8Jn7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DQYPaLlKaYrnYzeRuPHlIzbIr1oWGHHCXv6n0uNOhrCorHBAkUkMOyv2q+IGbKnrOyyiNjOMGxbKTN9WiuSiFj//Flb595XrXjCn+iCylMTbpxi8Q37Xrttn3MvkYHZGFk6rTvhYNVET+WxPk8Q/+YuXfPv72L2yVIyRiR8k67c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYMgFHVT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zZE7UClv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYMgFHVT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zZE7UClv"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATEMmmv029060;
	Fri, 29 Nov 2024 14:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=aOetC6zdqKargyWmzM
	EfohKhC/e8ziibchXaEwsCeoQ=; b=EYMgFHVTn/ZsXoWIZvsFyLfy9aKfoZpVWn
	g7JbQZ23vO5jMAjvcLvurtyVFkgz9ex1bN5jkp2d3ERRvmH1fLNYUiXzy07B/+DF
	6sHwP+ij4HN5wSf7/wYpFy6duxO3E8pDMZfbVoyxrU0btSH5MgY4xR+GUdHpTW3L
	EgMosTO4cuwwoFm0GBVEF01wIfUopUnEBxUUOCUIGw4WhaJkbOiDfFTMMbfEcDgV
	4mTX9OHoLnrLVIUvlfqAdom1TkbFLvfpcItqNb0TNsdVQnG1I+cpEzpoEB8HgNYf
	E26sW/UTGnp5uACvM5HffZs3BQhnfBpZo54iV79ep+eEQOQQLSFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xy3ep8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 14:35:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDfKsK001474;
	Fri, 29 Nov 2024 14:35:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436701g301-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 14:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA7H5fDw+Hl5B7WEreRdT+V9zCGlV281oROpt8D3xgXcgy/wxAh5qaQGxDE/fYnXuhHEh02xi9Gg0ywAs2sDaSUKX2FSeQFseyik0ATJLiL/a04RLhvGyBKsJ5vFOS1a5w9reoAJMqrT+k6bz80UG84WUAZHcwRv3H9S2CTWc1gXcbv7UfyVU1wv86DqOcHgi7R5A6hjbo4XGn2XLs22YvF5sBpC/2206Ib1fjaSY6aBV/p9DKykugLCuD/+arzPhHyghcAM8o0zxcf07XcIXsq+vqPOSfl6zynHUAEgXTRk3U5xt8hpeYOIVlaaNd1m+sBqBi/Q5uZLVQx1Ou4KCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOetC6zdqKargyWmzMEfohKhC/e8ziibchXaEwsCeoQ=;
 b=S1rZpYmqubys1r7wFQhwmFa7ysSbXBahEuYb5jHgEuBMzCAWt8CFAVIiIKpmo5CbgHSsaJ+GbJJ93/TOUbd912GIP7hq8lW8KUo21n85xpD1mSXICTTtezpgBfnV1lf1VU0Dj0OeT6+J/pFHePJ9P6fesLcxQ5rm6Z0VSKkJBygRGnOFyA6QkRJENE3t5fc8jLRCw6q4idonjG3TigAp6aIcwnMPftiYrpzKCDbFP8DUfintKA6jDMdNT9cTVrSDZeVMhb1dkxEibVLtZ98sgYVof8gidw7EN88uyzGR3piU8aNfJAAtPREziXPJKjdz+ht/UiO4GNT26PRFrpdZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOetC6zdqKargyWmzMEfohKhC/e8ziibchXaEwsCeoQ=;
 b=zZE7UClvSZ/80OlFbdBxC2VZPXKHJz4MCR3rzOqHPxq3fyH/zBvzhUmb4z9o6zz3gHFODz54TbpE2vKCe94zv8LgiW7E03z4WQHtAdgE+LVvhy2RqALmvGzeDjtWEqgPrei8qhWJppEMgGXbZ4sG0xSzob36Cm44RNjq3j9CNCU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5042.namprd10.prod.outlook.com (2603:10b6:208:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 14:35:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:35:40 +0000
Date: Fri, 29 Nov 2024 14:35:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <be33a685-f6e0-41b0-ba3b-d1d7c2d743b8@lucifer.local>
References: <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
 <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
 <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
 <14895682-a013-419f-bee8-1476540ddedd@lucifer.local>
 <f637de06-41de-44be-8e1f-6a5d429e0ec9@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f637de06-41de-44be-8e1f-6a5d429e0ec9@redhat.com>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 710b9a46-d1e4-450e-bf0d-08dd108318c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+Fb0MsXswzdP63KkTwYyxmRecp69uH7y775T/pOhgVhAziqwHX632uSFMMS?=
 =?us-ascii?Q?D07Z+RTLK7SsRrLI47y8uhwWWKxWlyMKmTu7N5IgUXyVnLhZ+HDwyNQKjFSX?=
 =?us-ascii?Q?IZU6SSJldhKID/VNmF/ccvyKAyV78T5SVGA2aa57e+6m/PoOK6sDGOJ9cXol?=
 =?us-ascii?Q?VLpWpjvZ2e1ZdqHOvT/UrEqRcWRhSxE2uP55wEsnny4bt510q/8799mKqnhS?=
 =?us-ascii?Q?KTodorJsfsj52huXEvt3Bs7U++VgV2YDoQUDWkhe3Mp9nKgD5znBSVgVgJ1O?=
 =?us-ascii?Q?lqBkZzd53c4Ma7qJt6fDS0Jagyn/Q6NN6W8N6SIbl0fk8XOJBs6CZXd2I+A8?=
 =?us-ascii?Q?ecwPeYUHXoQeQpuVWPfE55GeM6Gc5uMRZse1pLvAWZ6bqwHGHgSWqnbe+CmW?=
 =?us-ascii?Q?aUVrPQTEnLRK9J00/tmcD+O/2cxrnRc5M2DMSCKM7Ku2t5LRwg7QFcW7zcOT?=
 =?us-ascii?Q?3MIzKn0F6DFiyge7sExIGh+43K/uC0hUc2WYj/eFHN5G7SJo/x4V3ySKktO4?=
 =?us-ascii?Q?FLdRyeiTWhS/+czlPJYlGK1VbGj/0vxbZ/tsQ5dNQGfsmTGppTlALBk9Frvx?=
 =?us-ascii?Q?10SXXiXhjolXAVlQ6oxT3uae5xOKoAdVQEs6KHLoCywkdzDmlOJCE54I6mPJ?=
 =?us-ascii?Q?Ex1cvhee3+2t1CwZrDJOjzOMULfUS5H06qpUSpTTWGM/mUo2tCvd+XIVJ4CA?=
 =?us-ascii?Q?N5c6EA9BYfsaYyZmwwBUCOFZ2BL0wIeWMmloYIHrmyqeoAKc8u4QSfWOlCHU?=
 =?us-ascii?Q?8qnlefd0A57wU3P5INE58z8SfS8j/ZNAalpMW7hK/xIhHK/fPlojDFnO1m9D?=
 =?us-ascii?Q?QUvWRqNCM/1IHNxWUIaLKbjJG1xfdE38Lz6dv/9tKSxTBL7XbOxMGNv8AU5K?=
 =?us-ascii?Q?PhBRIYkfdTxhDWf6qGgtf6hKas2GONsXRBuqcy0usQQP2J73zz6/QnuHy4Zd?=
 =?us-ascii?Q?O0pAMibxH2G7lDQMSb6tnjW8YskOhpyMjanvP2fAt3nTPfMZJNv6bSjpRDRr?=
 =?us-ascii?Q?SUXXPnFP0R9aErusDI0CaEWm/izaRLOeUwSHim5+RwvOsmQBfCKKlFmndFAd?=
 =?us-ascii?Q?ufoPl+7CFH6iFqEKCO1piGS0FnFZ7xzHRXWoFQsApwqX619nSM5Q8DLXcgIF?=
 =?us-ascii?Q?gKgRZfQdQ4T00Rp8Hw5IkVPdursh4qMo4SWq8eg0yLVKzdGwT3TARaBnRB52?=
 =?us-ascii?Q?MSXjtNFvvsAo4aJEeolGPDtEHJnS4ILqSG9KPP6AqkNkvssPAEYXKpmtnSKm?=
 =?us-ascii?Q?NWjHZ5oJmilBWy1/cAgUpMD6dhEyTdpBVZrdnVKtDDLAxuLER9C6VnB334Bu?=
 =?us-ascii?Q?NCRN0Unj3+LNMTO3PXJ7tRqZukjAT2QzuHARiwGJ5B+y5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6hKZOURxwkUMq6IGzHRQjwXysK2oYO7BXgEG8EDHoIsdJyTXJ3RMPVlvHK7?=
 =?us-ascii?Q?ZISVZLOclJjI64nI5y+5WsYjweMYMFWQRDKRNqTywLLhQT2iNG5iozVYXNS1?=
 =?us-ascii?Q?E7fM3rqBzlYtM2qvQCFl9emFE75tflET8d1fjgr1Vs9NAw7kZZpmSVH8Jfag?=
 =?us-ascii?Q?JGsOWMDC8f1T9QjFTV65CtqSLCMhM4CGfxYpDD7KzU9IZ3U6lF5UwNMalKT3?=
 =?us-ascii?Q?cULGeMvGvfqYSKzFu/lyhSvYKIAEtSFyi1MEwB6W8IA+DrqfKZwmIhml3RJ5?=
 =?us-ascii?Q?bnN6uNsDIP0QyKhRp/61m0/H5xgqeWXES/xl0MxzsEhjcOH2ba1wqNbVf10j?=
 =?us-ascii?Q?66dHX/CkrUN56EUkY/6lSG08jaOVaTfxNoUsduVTn/KSJcK6IXloKRXjMkTZ?=
 =?us-ascii?Q?FP+a9GhuHoM9v0pxggdWVkK+63QhY4xysyex4YWgTEdxi5/B0MebT0VTj2YZ?=
 =?us-ascii?Q?M7RvC0onWWDZSABvO8s7RQXNnLTGG2Lj98AapCQH0hZ30EIgCLpZbIltDIpB?=
 =?us-ascii?Q?rRN8WyDwK4rPWODegqH419nGlcEFOZhUPtqOBuz0nJmGTmEaiEgFuo5IsRp4?=
 =?us-ascii?Q?/oVgh7DWX7UVQ4dXdT8xW9+I9fjxpb4pSZ1AFult16oDo560XOQZ1MjDEoeS?=
 =?us-ascii?Q?8pTKU3wEOvfWJRWjAj+0kFqm4GKEW6CX1Jk8vOR253qAjGD3jTPyt+iREz5R?=
 =?us-ascii?Q?vj+7kfxcDTYI4sZaTi/x8uiFUpsqkIcizWXvKnDATWkGRQ3tDQLXvSOqGsXX?=
 =?us-ascii?Q?TTUcOirReAgVlmL4xrSFzoO5OrUJp4HGfDQe+VG0AtTm0jbl6Y//SulIbzy9?=
 =?us-ascii?Q?g8PzFHcM361xxiV/pn51JBD6/hh8Yf0XarB1DCMX3/3WOpcl3F/WqfHq49MJ?=
 =?us-ascii?Q?ss+RQVJBEcRb9/RYicS9ogU6VStl1OJgDrsg+rI9T31luTKhKc+2o8Gu0LZQ?=
 =?us-ascii?Q?u+S7pnd0qnQB14OyjpLogv3XVdGO7vwCuHBB3VaJLv5aMpGxJsC3MrsWolpL?=
 =?us-ascii?Q?3xAB4wkljVJipqePy6Y+fjXq8sLQYW6WH2dq3mUmS92UX7FbsZ/lim3rNjD3?=
 =?us-ascii?Q?Eco5R2NyI0//qgbmQRtkftju8+ylWZ0U/RYRziRfb69OzpW+9QbXav0aJm0K?=
 =?us-ascii?Q?pnCS9Oe+cjAK1eHD+tOQWWU5BEJ2dUEe2muwvxf+UkCzH8QcG/TV+KsEiIO2?=
 =?us-ascii?Q?JysFuSL2g5m0cI1mWBXCBjB9+a3TMJU8FQar72u8xQEBwt2TPSjmb9bJzB4l?=
 =?us-ascii?Q?nySBXeNISyXpTVd38rzmnNSPwEmoZ9GnQb6XXykIb6nJiTqVYw4L+K2bLKU8?=
 =?us-ascii?Q?ntoFbbQhK/38ZqvVtw/ioHBSGihPZbvrbg6qS5dvHHWbq8AQwli0bmAMtY2W?=
 =?us-ascii?Q?ej/9/RZDnb4iTPTB/E4iudfcVzFaLTQ+PGmQ0jlqcbS7FIefCuKZW681RGLw?=
 =?us-ascii?Q?F3FGw3qqEtbF6JQk6Lmgb7ml3ZboaL8CMC6wEe/MchpTYyQaypxWXekyAwzm?=
 =?us-ascii?Q?s4yHzM7FoB07uGeZE9KxBQmbf4rI0hGiwZMQnthsDXANH7fwvJYni9bbXn1U?=
 =?us-ascii?Q?KbQ6oMk+nq+gr7qocdaHJtyBQgWwbQ0MDY6ieduMXaaaG1GP2Azto9QIN7TX?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2cDGpNdrmYYUCUo6HSb9ZEfCUlHlhBanFJOxYuD77yaOBKBGWwUt/wRw0yWezugDNYv9qyeB8Nb3YHa9b5c5ICExqM3f6LueU8zZ0yaTR7FIt9zKBXFByhagH2sJEMpxygVKdjA6mbEOuBr79KKLPrFdLK7iPmuKnOaww3sQMn4/AbeGnmqyS8Rsef7UKCojhp/7Lk9JkQbaiJM9JoQWaOy78QZp3QcHYp36UKhisIV20QJmCbSPdVaikxPFbf9StQZ/uSMnWjCnPFOeHOrhtEojKmzLZUmJSKhgsQifx9RuU4SEGyyJMgXEnhNID+FpmfpqsOU4teZXP/ExPTvx76/1cwYXmlkia5+dom2X3e66y3PzSHoYUKQmpTS+jkWdaf8t+xgRa5l9BTUrRFfOewqq3k9lNMU3N7fxTnV7uPuLbEhjUDhlreMtfOOUp3Dj8Zp5/PfCTZHMKC+AeBvAZKR86VfhZ88KzsHRxgtm0SNmQ9hIo3NcYesam2RrLYWpzeZPQyowbO71+EoW3OMSojPJyxPS/ZVlWsS76KL+lc213hDkr8Hc6WizftCr0BimaxlhS1+W29WLHmsPaXPWmXYi29RXKjSeTip376uo0lA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710b9a46-d1e4-450e-bf0d-08dd108318c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:35:40.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 974v8Wf8b0WKPzE6gndNuCjHXvL5SR8BqfzcAVLbRgzYgZ+4ttAOP8p8zMYO5gZvUnTJLDbmBwFcFRQ6yCCmIw3kqUfZB1I0OQw5s5GCUr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_13,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411290119
X-Proofpoint-GUID: kQxFfUtlBZFhuWaQ-KdPArVu9dCeI27c
X-Proofpoint-ORIG-GUID: kQxFfUtlBZFhuWaQ-KdPArVu9dCeI27c

On Fri, Nov 29, 2024 at 03:09:49PM +0100, David Hildenbrand wrote:
> > > > I just tested it and write() works fine, it uses uaccess afaict as part of the
> > > > lib/iov_iter.c code:
> > > >
> > > > generic_perform_write()
> > > > -> copy_folio_from_iter_atomic()
> > > > -> copy_page_from_iter_atomic()
> > > > -> __copy_from_iter()
> > > > -> copy_from_user_iter()
> > > > -> raw_copy_from_user()
> > > > -> copy_user_generic()
> > > > -> [uaccess asm]
> > > >
> > >
> > > Ah yes. O_DIRECT is the problematic bit I suspect, which will use GUP.
> > >
> > > Ptrace access and friends should also no longer work on these pages, likely
> > > that's tolerable.
> >
> > Yeah Peter can interject if not, but I'd be _very_ surprised if anybody expects
> > to be able to ptrace perf counter mappings in another process (it'd be kind of
> > totally insane to do that anyway since it's a ring buffer that needs special
> > handing anyway).
>
> I think so as well. Disallowing GUP has some side effects, like not getting
> these pages included in a coredump etc ... at least I hope nobody uses
> O_DIRECT on them.

We set VM_DONTDUMP anyway (set by remap_pfn_range() also) so this part won't be
a problem, and I can't see anybody using O_DIRECT on them, sensibly.

>
> >
> > >
> > > > > >
> > > > > > If we can't do pfnmap, and we definitely can't do mixedmap (because it's
> > > > > > basically entirely equivalent in every way to just faulting in the pages as
> > > > > > before and requires the same hacks) then I will have to go back to the drawing
> > > > > > board or somehow change the faulting code.
> > > > > >
> > > > > > This really sucks.
> > > > > >
> > > > > > I'm not quite sure I even understand why we don't allow GUP used _just for
> > > > > > pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
> > > > > > whatever mapped it will maintain the lifetime.
> > > > > >
> > > > > > What a mess...
> > > > >
> > > > > Because VM_PFNMAP is dangerous as hell. To get a feeling for that (and also why I
> > > > > raised my refcounting comment earlier) just read recent:
> > > > >
> > > > > commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
> > > > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Date:   Wed Sep 11 17:11:23 2024 -0700
> > > > >
> > > > >       mm: avoid leaving partial pfn mappings around in error case
> > > > >       As Jann points out, PFN mappings are special, because unlike normal
> > > > >       memory mappings, there is no lifetime information associated with the
> > > > >       mapping - it is just a raw mapping of PFNs with no reference counting of
> > > > >       a 'struct page'.
> > > > >
> > > >
> > > > I'm _very_ aware of this, having worked extensively on things around this kind
> > > > of issue recently (was a little bit involved with the above one too :), and
> > > > explicitly zap on error in this patch to ensure we leave no broken code paths.
> > > >
> > > > I agree it's horrible, but we need to have a way of mapping this memory without
> > > > having to 'trick' the faulting mechanism to behave correctly.
> > >
> > > What's completely "surprising" to me is, if there is no page_mkwrite, but
> > > the VMA is writable, then just map the PTE writable ...
> >
> > I've had a number of surprises on this journey :)
> >
> > To make sure I understand what you mean do you mean the whole:
> >
> > do_wp_page()
> > -> wp_page_shared()
> > -> if (page_mkwrite) { ... } else { wp_page_reuse(); }
> > -> wp_page_reuse()
> > -> maybe_mkwrite() [hey VM_WRITE is set, so yes make writable!]
> >
> > Path?
>
> Yes. I can see how it might be relevant (mprotect(PROT_READ) +
> mprotect(READ|WRITE)), but it's a bit counter-intuitive ... to default to
> "writable".

Yeah, no this whole thing very much resembles a labyrinth with a minotaur at the
end, whose name is VM_PFNMAP :>)

>
> [...]
>
> > >
> >
> > So overall - given all the above and the fact that the alternatives are _even
> > worse_ (having to spuriously folio lock if that'll even work, totally
> > unnecessary and semantically incorrect folio-fication or a complete rework of
> > mapping) - while you might be sicked by this use of the VM_PFNMAP - are you ok
> > with the patch, all things considered? :)
>
> It hurts my eyes, and feels like a step into the wrong direction. But I
> don't really see how to do it differently right now.

Yeah I agree totally.

>
> Can we add a comment/TODO in there that using remap_pfn_range this to map a
> kernel allocation really is suboptimal and we should switch to something
> better once we figured the details out?

Sure, let me do a v2 then to make Peter's life easier, can do the nommu fixup in
there too.

>
>
> BTW, I think the whole reason vm_insert_pages() touches the mapcount is
> because we didn't really have a way to identify during unmap that we must
> not adjust it either. A page->type will be able to sort that out (while
> still allowing to refcount them for now).

Yeah. I think not being able to differentiate between different cases is the
problem here...

>
> Actually, the whole thing is on my todo list, because messing with the RMAP
> with vm_insert_pages() doesn't make any sense (whereby the refcount might!).
> See the TODO I added in __folio_rmap_sanity_checks().

How long is your TODO list I wonder? :)) I imagine it requires a huge page to
map at this point..

>
> --
> Cheers,
>
> David / dhildenb
>

Cool will respin and send out shortly with an appropriately 'forgive us father
for we have sinned' comment.

Thanks for taking the time to discuss this! Much appreciated.
