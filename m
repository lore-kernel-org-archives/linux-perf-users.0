Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA5195390;
	Thu,  5 Dec 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382587; cv=fail; b=Mklurt6uYtfR8tdx7fkG5UTKNvrG0yHWhvDHTmksHx2/TsRHWLnYV6BsFVfxb+mbq/8l5zNQy8Q9XpOt7vKyGmgmbwnX7eiiMgHTRFs9ivJlMEbURfEZpqSSOPHY13Z5IsK9bGw3oypzVAdwzhPuqzsiNv18KyZJnix8M94rhtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382587; c=relaxed/simple;
	bh=N5QoRx7n9CO0U/nhiIYIjBk6WlyuvTzxjPr7FWgO0II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwoUD6bkAp28EhgbDcgi430Xfwp/npG+L9yGzKXTTr2m9N2QwNMpmhZ5OIONv2/FbHQwgv8K7UxaBEXAtW7eGWdNgjANfgb5V5EcenATaHmEf6s8adArX7fEix5QDwYseqhURbdZfAfy7ba9Mv1atVvrHU1thdaGqg6AweV/cPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hiOaEhOI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MgWSkGoC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hiOaEhOI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MgWSkGoC"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B52MvtU009791;
	Thu, 5 Dec 2024 07:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=loymbydG0tBm9VaIzC
	XePZ7FY6UxVaJdQjQDGkjivX4=; b=hiOaEhOIQ6a7hGagY5UKs5dJ6jWbYTprWk
	r1MMgopQeiD2+GLGOxoIPy8d7XcCibvmBlX3eHFa9xPD2kTO0L4IWNx3DSnq77QR
	9dbhWs/pSy02wF4xygPMc6etvmtbehBGYDuqbi2BWlZCU5nKU7BSRd85jBJyMbFm
	5YYTDn5YHsk8Yqn0XjWIVIsngp1BohfN46PR2web4wwbG/YDnuYhPZSS+Qsj2Tw0
	wXY9XgLdzRv2GPCpr4uiMJLu9rne9EF0dnrKF5CJ0aAjPz53jLvdQeqnU/G3gpLc
	wttym/Z17q+nKrvj9Li8CDG23R3hRBdcVvXCuiqDA2nqyEPq5/AQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2a6r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:09:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55dj08001409;
	Thu, 5 Dec 2024 07:09:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5ag60j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RARVyIpZtgIwoR6mOqTmBpJZlY4XWnhx3BzFt1p18Nxy+3g8hhXKI/hAtyDEVGSThHAmfOm5vNIgfsBB5njURxrDslN/aG++dxzph+GzrfFc2tcm6/iqzJ66jlO1USkG6VDoq9AVKW5poSywg6e8ko1uQ2UkQMIdk0kOfwLfB85Er7mOUEi6b4SGl9mhOFZVXGEKbm9GNwa/l1mPyMNKhs+NU9Wt7oxUZ0AnWyYABYDr8Ji12x9Dfw/0UI7nvJWEQvkUtL802HWphtiTBwH0bUmtahwrtYiQJdload1oysXkEGBwjGwGI6SNXg2JVRMLtbyUkCCjVBS7mTDovUQwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loymbydG0tBm9VaIzCXePZ7FY6UxVaJdQjQDGkjivX4=;
 b=vPc98csV3EVM58j4PDOvf8IGSUdXTaRtW18h8mcwWc0AhhtdWD6UnB1EiAIk+5/Sdy9xQgUxEOy2Whu3k6sa6xhucQBupJtkHm64HQ+VqaYGwTlNjk0tFSEdTu+1MaSjZLfJsEgdZY6EPNjxWVjkWNFxwTTUd6xNWcqKzm2dGbuFN/HJrc8rBft7BvZvBjelTyG6xYrOf8OCLeprqKwyxvldwYXQIuYuTvQkYnNhGb+VEcY8uycsmJkWa3teGjHh2zB1P2VRSvVRQk229y4uw21RjfXXo1OF3qpp46W6sfOPSq9kjeyoZGhwrRt0eOF9yLEsSkoJhZ9Dq4KQI2v0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loymbydG0tBm9VaIzCXePZ7FY6UxVaJdQjQDGkjivX4=;
 b=MgWSkGoCR/qjyikqX+lk3VhLyaC2yKvw+Z/kTKyuQ2KrxTuM7yo/PbcOUD5sb35ocCRl2L3QaKnFWcx1oS8S9ExNLsWv1Fw0b9pRUSWrJOcmhpIOBcrguOcgGT7W1ug1eHtOdp0RF8gDwY0zOyt0j7lGFnDdoyKb2dkjd2qA1ZA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB7724.namprd10.prod.outlook.com (2603:10b6:408:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 07:09:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:09:20 +0000
Date: Thu, 5 Dec 2024 07:09:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
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
        David Hildenbrand <david@redhat.com>, yi1.lai@intel.com
Subject: Re: [PATCH v2] perf: map pages in advance
Message-ID: <e8f1d095-d5e7-43e6-9878-eaf37ec975f2@lucifer.local>
References: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
 <Z1ENEwafY7g/rzeo@ly-workstation>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1ENEwafY7g/rzeo@ly-workstation>
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e273fd-9075-4de1-2328-08dd14fbbd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXTV0Gu3CRITmFd0FgoWGr9AQIo1h+XKtcXJZvzxKqRYaq6HXpdAXHIbG/7C?=
 =?us-ascii?Q?PeOx07HDb235vdbKuD7ohIxZxkQd3QNqv91UIMQPNGQnxIga3I28gys7JP81?=
 =?us-ascii?Q?3ZjTGmhUi68IBfRGf0yoTq2iBp1ff0fxn3HRhwu7RLPfF14OqC8dy9zA2pfL?=
 =?us-ascii?Q?uZOeECewk+sXNL3JDouyE89tS/X4Ouiag+GF0lr4PLkSIl+FRz4Uup0jvN3C?=
 =?us-ascii?Q?EKHt82Xn8x+uzBkX+wIVFw1PM55c11taGWg2qjP5lBoZaW5RvagQ1GPY9cb8?=
 =?us-ascii?Q?kG2YwXhjvZmYNhSI0ezLS+iqp1vm3YDXB89b6zdkQ4+L8djtFX9slGQtphn4?=
 =?us-ascii?Q?+YtQr/nKM9wwq6FoDkhxkcmNrGSFOHpsJnYOgtFQI5zsKR6szRpzW9GuEHQh?=
 =?us-ascii?Q?38dABjvhpR52PVS3QgLyeiFFZqM/hzo2OzhsHIw9SB19PHkotVgkjXyNlyvy?=
 =?us-ascii?Q?cOnN+dP3dojI7FZPUAgwqA7lJI5/oCJ3E/YgMJk+S5tGXQbXYab/mb9/44pX?=
 =?us-ascii?Q?oSK69LF4MYHmQKyjAzuDy/GY7kpydIAYQrSHAlLxI09WzAw4oBtRSqtwMDU2?=
 =?us-ascii?Q?p7w4o5pTGX1Oq8BH8Ie+lHlP4Vhi9+Os/CD+8cbgSzMsy704u6N/WmnGon8R?=
 =?us-ascii?Q?w3daHylOVF2T7/Tm90ySi+pjWqivBy8TJ/lp4Y4ELRzQtILQJffRRlTYuhhy?=
 =?us-ascii?Q?fGKVY0CniT3R8ipgmF3suRzuCQVS48DFQgzrTY8bemTunbW8Wxi7IPAOic1k?=
 =?us-ascii?Q?4YxgDmNz2i9oHRIMfQafaNxUmvgp4EsPM40Ui5PWdQ0TzEbmGdPk0Eq8GYnY?=
 =?us-ascii?Q?pYnGnXfn5m2tgNP5JTdov0HJ3B15irYPpAuZC8wVEV5dKdamfU8hj+sTd2us?=
 =?us-ascii?Q?vevpEnsERBMZRAXLWGNQi9wMq3EDb9lZ6dGsIZiBFiTWP+sZMtCWf2PIvpjX?=
 =?us-ascii?Q?+ZRZlptKx83VvWkLgGfPIBn0FqV72MXqWe6tWnnWEV1+2xRbXSw5ZPtQlbPX?=
 =?us-ascii?Q?4dLYBX9qPr+AiKeGUuJDUMUg/XxynGYzWG+6m3Wm0ixH3cpHWZpfm7Ws8gOI?=
 =?us-ascii?Q?DiE2XngnEHBH79Rl5hSc9iV3IIW5gGXlX3kmPUzr7gjTvYhyhC2T92VU8hGl?=
 =?us-ascii?Q?+uG0NUcyvtoXRCpOUCKhQdAxwgZtabXj/elZjhpq73lsFEs99dQ/KoNfkFXd?=
 =?us-ascii?Q?sMr2Yb69ZXHUGJUFD+pjhO+cu5PzrKl2SpyWojIkxmrHPLN1c6TVPzPV4uq3?=
 =?us-ascii?Q?fowpPF4UkmH0ec9Gv4WP47f3sQiu6E5LgVqqCJHTsh6bUNNmTQCHygdC6Jnp?=
 =?us-ascii?Q?AT6WCb5axgiX6wlq3cot9bEEpWTRBzMmlVrqTiCregifQhCjmUXzLAnGqHpf?=
 =?us-ascii?Q?UxxIAOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTWvDrFmmHWr3bRrmr0FfeLh5CJOYPdNDXKbl+VKxZ9J91s8soblOIzaBQCZ?=
 =?us-ascii?Q?rkQ+A0WnaNRUagnnLgsgZIwG1EACojnGgfFbgfLk8eQ3hWueyUi5QNwwdiwj?=
 =?us-ascii?Q?vEsSbYorh7FtQZhk5pOkCD8Njk6qlVUorH3cqixNDun23vDIF0n5VYKb+vC/?=
 =?us-ascii?Q?rK2zHgHc7xmewolTvGqZF5NP6zfRg/VBnbRSN8eN/IX1wzIb7SaltyDaR3oO?=
 =?us-ascii?Q?osECr5pitcNdNb8aT8I9ThTNEmY5ifOrfU/v9zey6SNbtdbkVHGClCfejUwg?=
 =?us-ascii?Q?k3oCbkJkYlH1AiYEjnWXl16+yPqPcA/w/tLUIZR7sir3zm9aIxdJ4M9wM1eU?=
 =?us-ascii?Q?CFnpzMQ8xicRGydZOiKdE+Qt80ki1m3tW9f+OI/dNbKLPSYCjj/fSEgJPQ01?=
 =?us-ascii?Q?jCLpXG41bfQqxAX7unmsiXndMirSHxrSXH8UcL9XY73ADos0XHJBMynCVrov?=
 =?us-ascii?Q?jzXp4Sup+UtugJ8iUO0bkEwNNEU1RgYN/dF6AKu15iDxzGnyhd6tMVY4FWSB?=
 =?us-ascii?Q?Jk9tuhIZri2zInNwT3jMQ2sNBlx0N1mJnpPmaIlhs5BDZoSya/nysVNqzeyB?=
 =?us-ascii?Q?5TncHkJWzZpbAo/gX4IK8xc5I1sv5oeSLykNmOcm9V/uOWFom/eSJhjUkqHW?=
 =?us-ascii?Q?nxWQgWCd/ahvdEazaxIutotaRh4a5nwyiQHblI264UKD/bY71fe+Tjgvxdt1?=
 =?us-ascii?Q?aWrM45HzedfAl/cEB+/iC7VqluYB4YqIRJeYzFP1OOkHmx27aDlmJ2ybK7dV?=
 =?us-ascii?Q?DqHl8i3lkq7EGJoLrreSRkC5DYwN1S09FtQMzBXOd/RsO6RGS5yx6rKM6TD/?=
 =?us-ascii?Q?Y2BA1jVC10bh3BcvHG+EEIJwUkpGCzLkPk268MfEswBem6zXAOTtyHZVRj5X?=
 =?us-ascii?Q?XzisiCTQe8dKjMHMX692p+T6UoO3DX43QAXjrPoED0G0bRxUCXBCXSs9jygA?=
 =?us-ascii?Q?6U3NWeep9+DjLN7UNiSuSyQwJVQLATG5iPW8ZTsXR9iIEpPjghTpk8b39khr?=
 =?us-ascii?Q?U+Fz2fUxS1Vcbb3HQGE65qgr9QiM79t+0if4stzP/cL9rwW1eDe7YETZgfDu?=
 =?us-ascii?Q?L8X5PzIi2jIv7033XWAnlG3MlE5kKi9E0tuCJaMEVhrYgPQaswkFy7SA8Opy?=
 =?us-ascii?Q?MRT1HCGY6aDLlBy4Xmu37Zg0KEPx3Np82rV2usEN3UYXwjFJszhQSGEXaHF5?=
 =?us-ascii?Q?ehahatUCiarJZlwlLPFVmNKT7ZmoZkP6L7TyjdRqPRxK/FeyHO0IABmCSaLj?=
 =?us-ascii?Q?2STCi1ca9eKis5TbtP9HoKS5RFruIoBtJAt0nwrU/f1xLvrbOg3hg06BnxUV?=
 =?us-ascii?Q?SCfA6Mf6jY+PftSyfCBwOm2whFdKskeeDBssnl4rGAPZVYtXBTW+Osq8eYnZ?=
 =?us-ascii?Q?pl6yuWIOYGOR/BkobFSgF5BvkfYe4soXCPJ8hI7tzYoTYAbQjwR+bV+Tir+w?=
 =?us-ascii?Q?AM5Xfzd4FuuG7jDMQz0hi9GQ9YNzBmWI3dCAF0Jv1nfPQpdfaj/ZNhXPNkRQ?=
 =?us-ascii?Q?BRkeGIGvynkFAfnC8kVJTX72qhyyZpGo+2gOJweRguuTKUjd1ifxpx97SH5S?=
 =?us-ascii?Q?wSTwrXUkAFT0lWF6e412j+lXQ4M75IxYFkx2qe7Bwxvz8/58BSovju1xtIVZ?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wR5EZEDeDy4eHOeuybbSbwNjJA0XfPNZKw1fIAdBzb9vkCrCVdjV7WYdjmNbBjscwbvR6h2L1hvfWmlWfNlo9XgIzBWt8NlA0mDJu7MfFCgGWycR/ymEN+YVR6XQK+L8Lkr0xUxwPieXtXS4Y70Um7F8X+d4kiYFG8YSTP/gYTzSADsvuG+QpaNRChtX/XbkW0uvHqmRAYb/aJtNmNw+pFJRrTIJFqf+O/P7i5jRJnbQgvxMfyI4wYOhOQ9dzUa29DykmjV6WIwMFAMS9FEs1eDbO3NMnBm3GUztJmwIzFIWfYct0DN1a1BOXPiztKWQ5Dx+KoQAelLy4Xkm3MTdFidu52DSJlr5rcX65GzKjMevKc13/6cFJ66X5bDtFZN57of1DfdsH/PVbFHPOrBEX63gUa4Mod7kpenDhkdoq7Wc1xNel3xrdtDwMuPS/arUgfL8r/pqbU9EbaIs4RboIC43gMctQo7Q8FAYPZRWHwiseNEtFu+G/YdwuS0XyF+JTuiFrHFVlYUr3JgRfxo79SVasha2YCczqfGCkbAPSaHOvylyKdMD3DpY2DsqtMFeRrNGxW6ThAJg6RgIt6CPqVnTmrn+0R9hfwKYxI5dlEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e273fd-9075-4de1-2328-08dd14fbbd95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:09:20.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0+LGLoH+t78ePYWMwYtz+2PhFfND4DJSkQ5r0wTjmTRBMeP93bgCaD7IUnOpQKteQtTIbtf/SkDlm+g/Z0Z4aVMfH/yhMKYhxkAuObg5TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_04,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050053
X-Proofpoint-ORIG-GUID: QhfI4C5wfso84RJ7gK0JxKvfDONX-aCj
X-Proofpoint-GUID: QhfI4C5wfso84RJ7gK0JxKvfDONX-aCj

On Thu, Dec 05, 2024 at 10:16:51AM +0800, Lai, Yi wrote:
[snip]
> > --
> > 2.47.1
>
> Hi Lorenzo Stoakes,
>
> Greetings!
>
> I used Syzkaller and found that there is general protection fault in perf_mmap_to_page in linux-next next-20241203.
>
> After bisection and the first bad commit is:
> "
> eca51ce01d49 perf: Map pages in advance

Thanks, I can repro locally.

Will investigate and address as a priority.

> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241204_084442_perf_mmap_to_page/bzImage_c245a7a79602ccbee780c004c1e4abcda66aec32
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241204_084442_perf_mmap_to_page/c245a7a79602ccbee780c004c1e4abcda66aec32_dmesg.log
>
> "
> [   22.133358] KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
> [   22.133907] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.13.0-rc1-next-20241203-c245a7a79602 #1
> [   22.134557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   22.135371] RIP: 0010:perf_mmap_to_page+0x39/0x500
> [   22.135763] Code: 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 3f 5f c2 ff 48 8d bb 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e9 03 00 00 4c 63 ab 78 01 00
> [   22.137075] RSP: 0018:ffff888020f0f798 EFLAGS: 00010202
> [   22.137465] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
> [   22.137980] RDX: 000000000000002f RSI: ffffffff81a5ccf1 RDI: 0000000000000178
> [   22.138495] RBP: ffff888020f0f7c0 R08: 0000000000000001 R09: ffffed10025fbdb0
> [   22.139012] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [   22.139530] R13: 0000000000000000 R14: 0000000020002000 R15: ffff888011cce3c0
> [   22.140047] FS:  00007f7f57f30600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
> [   22.140630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.141052] CR2: 00000000200000c0 CR3: 0000000014e10004 CR4: 0000000000770ef0
> [   22.141570] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   22.142088] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [   22.142606] PKRU: 55555554
> [   22.142815] Call Trace:
> [   22.143005]  <TASK>
> [   22.143173]  ? show_regs+0x6d/0x80
> [   22.143455]  ? die_addr+0x45/0xb0
> [   22.143720]  ? exc_general_protection+0x1ae/0x340
> [   22.144102]  ? asm_exc_general_protection+0x2b/0x30
> [   22.144486]  ? perf_mmap_to_page+0x21/0x500
> [   22.144810]  ? perf_mmap_to_page+0x39/0x500
> [   22.145130]  ? perf_mmap_to_page+0x21/0x500
> [   22.145448]  perf_mmap+0xbd9/0x1ce0
> [   22.145729]  __mmap_region+0x10e7/0x25a0
> [   22.146038]  ? __pfx___mmap_region+0x10/0x10
> [   22.146376]  ? mark_lock.part.0+0xf3/0x17b0
> [   22.146712]  ? __pfx_mark_lock.part.0+0x10/0x10
> [   22.147071]  ? __kasan_check_read+0x15/0x20
> [   22.147403]  ? mark_lock.part.0+0xf3/0x17b0
> [   22.147744]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   22.148162]  ? trace_cap_capable+0x78/0x1e0
> [   22.148500]  ? cap_capable+0xa4/0x250
> [   22.148792]  mmap_region+0x248/0x2f0
> [   22.149086]  do_mmap+0xb29/0x12a0
> [   22.149355]  ? __pfx_do_mmap+0x10/0x10
> [   22.149651]  ? __pfx_down_write_killable+0x10/0x10
> [   22.150027]  ? __this_cpu_preempt_check+0x21/0x30
> [   22.150393]  vm_mmap_pgoff+0x235/0x3e0
> [   22.150699]  ? __pfx_vm_mmap_pgoff+0x10/0x10
> [   22.151037]  ? __fget_files+0x1fb/0x3a0
> [   22.151352]  ksys_mmap_pgoff+0x3dc/0x520
> [   22.151664]  __x64_sys_mmap+0x139/0x1d0
> [   22.151975]  x64_sys_call+0x2001/0x2140
> [   22.152283]  do_syscall_64+0x6d/0x140
> [   22.152572]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   22.152960] RIP: 0033:0x7f7f57c3ee5d
> [   22.153251] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   22.154593] RSP: 002b:00007ffd805489f8 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
> [   22.155156] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f57c3ee5d
> [   22.155683] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000020002000
> [   22.156210] RBP: 00007ffd80548a20 R08: 0000000000000003 R09: 0000000000000000
> [   22.156739] R10: 0000000000006053 R11: 0000000000000212 R12: 00007ffd80548b38
> [   22.157263] R13: 0000000000401126 R14: 0000000000403e08 R15: 00007f7f57f77000
> [   22.157799]  </TASK>
> [   22.157975] Modules linked in:
> [   22.158322] ---[ end trace 0000000000000000 ]---
> [   22.158694] RIP: 0010:perf_mmap_to_page+0x39/0x500
> [   22.159061] Code: 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 3f 5f c2 ff 48 8d bb 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e9 03 00 00 4c 63 ab 78 01 00
> [   22.160388] RSP: 0018:ffff888020f0f798 EFLAGS: 00010202
> [   22.160782] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
> [   22.161304] RDX: 000000000000002f RSI: ffffffff81a5ccf1 RDI: 0000000000000178
> [   22.161824] RBP: ffff888020f0f7c0 R08: 0000000000000001 R09: ffffed10025fbdb0
> [   22.162344] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [   22.162877] R13: 0000000000000000 R14: 0000000020002000 R15: ffff888011cce3c0
> [   22.163403] FS:  00007f7f57f30600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
> [   22.163988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.164417] CR2: 00000000200000c0 CR3: 0000000014e10004 CR4: 0000000000770ef0
> [   22.165409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   22.165956] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [   22.166918] PKRU: 55555554
> "
>
> I hope you find it useful.
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
>
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
