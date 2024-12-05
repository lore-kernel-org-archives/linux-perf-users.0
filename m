Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A07193064;
	Thu,  5 Dec 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384920; cv=fail; b=iI+FLJSb1jZ5wajhDMPJUVL0EwgeGv9BgG6MJ7iaF+dDT/5A1swWYHUr11NGNW2xVCttxPRSeo8XLCr91JnS5twroWeZFllbXWH5Ij/XRHkg+KV2X6q+ZMif2D+J24wDOD5gRFXZamzdG6jiNryQjOAdtYL1Wyo7ANjZjMoINJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384920; c=relaxed/simple;
	bh=nFU82S6ShHHPjgVa7WO5d1dian2kWUIwDkhJw46gsoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJwSYZnsQDzC4t74lIdJuDTkkqr74Wg8TGUuJHyDiUx4ccApzaEds7OyCinfnueN+exx1wMWLP5kc71vzLlowqJb6zIE6EwfyNBfxtIc7iPXpWoHAEBlEH1jkAP3cnIA65foSmwLAGU2TOy/d8NXngmoqTWCDPlbHG0ykNztiX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aTCOT2SQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BrTmxGT4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aTCOT2SQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BrTmxGT4"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57NEPZ028393;
	Thu, 5 Dec 2024 07:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tqz16Bkk57pzuoBc3n
	w/oQ17dT3ulubzGHKGSaS42G8=; b=aTCOT2SQH/f309mYsiRp8jatLu0O7XPSot
	02EJfldYOSJuOu7MT/lFZHQcbNVH9AH4s0esfEuccVNyksbqmGNayFvdr/5CH9UV
	4+hk7iS/N7Txai4roAu7zFmyv82iAo2kVEU7crfN+hJKE2woVS9TwHvOoahjwjZg
	co2vRs8vRmWfgcKfbJViHtam4M6dv2L9+XmjENRI6EgKD/yK48JpsEzYthqF/RNb
	o6s490HBGoGtxTV15CAGV6LckjbJpMXnoFQN7vmetB+0quLebe/vUAn8OAPrl6Yi
	Q7vvfDhmVcVxrUlhF/5fNQkrNcXn/Ga7aqT7aps4LfGvhdr0cxSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2a8ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:48:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55W0TH036934;
	Thu, 5 Dec 2024 07:48:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5b1sma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 07:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDsp/qte7eWxBBJTJQVunkXU/WpaaZzUWUbureDdq9xVJNdqTu8a9K9cO6EdlxYzNWyue5MLmje019O75D1LGUSEDDlcSp/9ksRu2rh64sDvEB2q+5QCjtcjYLIz2x5zLUarlfcYi3W0GQNJAMVQWcKk0T3yv0XfGO4gZe7XIw8EG4MCib4hJk/MQiNjyymdVrN6gscaC7M7Jp9MyDiGQglclPb51j1SXZRWeppsemIjz5Pa52Bhkvob+7B9ZSnjvzBKGqacfFvqamqfbf4cVgPYgqNdYauywjvthkIyO/QCWqtRo+gFvNOQxozmky9XtKBPmh9IEVFqrVs5t7Ve7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqz16Bkk57pzuoBc3nw/oQ17dT3ulubzGHKGSaS42G8=;
 b=FiCt8Z6UmwURiDZujIohOHT5Jt9i1pkUdxvemssZ8WT03qvuLynbPrGo7JcQ7XI023eet+LJciejBnFZ2NuBXBON4mdQjoBa5HFAFRd9uj5W8B9K65JHoBEpXFV+0eOQu0TzepTzFJz5bxHZd7iexZh+WaEZEsdRK4/sqZ1DOfVfzUnBmf5B53QO2W/Jwe+l20gcIivF6iSZDDMP4iP282WD8nC5QK18J0QB+n6ieBKxx6GgQzL5vkaFU+F0Co4GaO/tCbzr7T3u4gTtxTRVj494z6asqSyWGLGUc+H6+FIccpcFl5Mfu2CaPL1hQjhbHTOxzwS0njKUAe06NY5E/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqz16Bkk57pzuoBc3nw/oQ17dT3ulubzGHKGSaS42G8=;
 b=BrTmxGT4PEMksKMPP342BDHcPL+GF+BRp/lwiPMQ6LzccKg/N6hjCIQG6XIjZUYBA0yW/yqkNYnvaZQ2sD/oweQgFjSa6c8NroJ/9ks1WDMVLsMqe+H79Skh1oP2CagAupj8lV3DvE20EpOi1fioU4LEwPnKzLN89UMnxMke1M4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 07:48:12 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 07:48:12 +0000
Date: Thu, 5 Dec 2024 07:48:10 +0000
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
Message-ID: <37aa2b6e-02ab-414d-8443-42bbd214ed6a@lucifer.local>
References: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
 <Z1ENEwafY7g/rzeo@ly-workstation>
 <e8f1d095-d5e7-43e6-9878-eaf37ec975f2@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f1d095-d5e7-43e6-9878-eaf37ec975f2@lucifer.local>
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f99c5a9-6c82-4e12-f3a7-08dd15012b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KW9tCHzvyiPVFzliQ4z3dNLsCOVUAFa78qEVeiZ29+OUKoyYh7BlwXf3x16A?=
 =?us-ascii?Q?zlpsBzd0la9U7lL0fZ59ObQ1joYQEVk6bt5BfNOxPNCFmkHPndWcCa0JX/3O?=
 =?us-ascii?Q?X5nYCmH6wLxeD5MpxawpH2K357MoLHFNEIhReld3FSEb/8m8c5s93419cObB?=
 =?us-ascii?Q?NhuDjPTmCdeccM4SQsQemIk7LP3/v8OXwvjWMZs+nEs1ATOMxAvE4aykKaOR?=
 =?us-ascii?Q?mWfZ3rPBOpZljOyH5FuIwCuZUN+v7cknMyW1cc7tmXvSjaW4QwuSz2O1wvJc?=
 =?us-ascii?Q?8ZqV9pryFZnoIt5CjhjArgQtVO/vOBNQlGLlyrIpgtpJdwh8iLmaMZUtlyAt?=
 =?us-ascii?Q?eXa0sUVXd49OhwOClrvuMRX1bFCSyeb4pX+RxKtw/tYbOSNr4BhQCedvLRxQ?=
 =?us-ascii?Q?mhrN41SFs0jl7qKF40CUFO+CQcC11bS6z97SZlRE55cLtegOwtHoN+dZ55S+?=
 =?us-ascii?Q?8YWWPbzxy2Qd4rlEyoYcW+WCawiZlrqp+x85XEoUw02cfuV5xrqraPPIrycB?=
 =?us-ascii?Q?8D5vO0sJQeF+bX+I3d7pOOm6OiV6+OzJzxhLzSuYIYgxtyi6uapViQ7cFJXw?=
 =?us-ascii?Q?JQP0J7CUF3LQLayNr4+dwW5ScIBLo6dfICaIBl8bF6slnUfX5tpveEnSFx1t?=
 =?us-ascii?Q?KnOAzpR8lpQxQsQ5Cm6zOvHAoVBij5G8Y9WmniF2q+mGjNJQq+80gu4aOeC2?=
 =?us-ascii?Q?VIwy8ensARKpLD3rTv2JcCyDv0W307bXOrUtM9c7+IxZCnalvXLFHRgavkhi?=
 =?us-ascii?Q?Gq2H/CdDmBkPULEPHXL+/FIphQGfojh3HbCvwJ9WTE90omcK1d2cDDgDq5LE?=
 =?us-ascii?Q?vLKNqwZGzQe1p7D9C9uyyz5tQWIiakRB2t9wrIVdQowK2Fr3C9l4Yr0K9xmb?=
 =?us-ascii?Q?9efmyX6NG8gEPYuZ4xNnzAzIW+RMQAGiMTmnDzSQJcJj0UCZngrsU9Io7ZT8?=
 =?us-ascii?Q?j6X+Cd0X7GRLRQ5ql60bbYlylwtnLR38N7/Fk/JwFZhvdtbCsgPW6+TU9b5Z?=
 =?us-ascii?Q?7ROAxYKoihoidAUhImBJKV+nuD8oSE8NaC19zDJNDMXuvCr8UGoUAY+1vMa6?=
 =?us-ascii?Q?9GU3d1hv0/wNCthLNGKm2NqF8Dh+7q84xFFMtP/CDb3pH5Cub32IU0+M7ao3?=
 =?us-ascii?Q?TDuBh/nMMZtOt8VemELFACbOBZStCFh/+Lxtps/Z2Ihvz4/aXbTM6xHh0Zm9?=
 =?us-ascii?Q?57l81LPYY70Y1BzIuPqxcEXBATjvZrVUaMhvDXmjA53EP1+GnerGoqnJiKLs?=
 =?us-ascii?Q?8twNosWKZC0Of/U43SjDniL5oWmCMgkjCMgfJAvPxniMznCe08DC5U4rgNde?=
 =?us-ascii?Q?tHF4/aJO6fCQhsy31FjS4ae6a1houjDOl25w+WGeWS0+3yXgGXlZWedcp9i5?=
 =?us-ascii?Q?OsJb9wg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ij6sjVe2zmlgm2+YPo53e97X8BDFjKcDNBPAq0VEn7cw9R7qwOyBD1U3oSD2?=
 =?us-ascii?Q?XPhFqhPwAivb5uN7QwDvwxtErWsm++Yc3trU6b3kfm8LRYPrv0m5YzOt9V6y?=
 =?us-ascii?Q?fz0l8lC7szlwP3u9VcuwbDphmYvSn07i4ER1rq9YBqFbmXASdkoK0gpquyGP?=
 =?us-ascii?Q?GISX5byRxnp2H3jj6l2TbyAt4BiCBDh0mpYFT5POwG0lBSlZI340DMrRSnOR?=
 =?us-ascii?Q?OXmLuDgZ1wMldKRayjjcE0Fk37No9TA/415HOgp9IOvsTyvQyCTUrKcPUl/i?=
 =?us-ascii?Q?vf948NWKJG4yKz9AGw9ixiceqhoT0J3s66cG4IjRgw2bQ/FYmXIovrZLcZRx?=
 =?us-ascii?Q?leNZdGv624Ge4EtXaWEn6KNwNPTWdav0UCyYMIFuthT9kkiSAziuu22D/6Ns?=
 =?us-ascii?Q?u3LjZ8717eEzeBmoduE+BaMotgXdt/Ku577TccBHVfNeN3+ZH68DAJToCDqN?=
 =?us-ascii?Q?d8HM2+ckmMfLQ3ave3TGiotVLyrVpohaEG3MfVou9L3ifAPvlAVHZnT5VlM0?=
 =?us-ascii?Q?FE9ZwWjTzwTi18ETZy5VFPP3ed+/AEFwTtBX6FoJhpZil8v36bsL1uCnunTd?=
 =?us-ascii?Q?irDjTHTsxStTY8mlRQ8Bv5/gpmFfu69f9Z0PedUdsIpxCziT7294ow26ik5b?=
 =?us-ascii?Q?NGj2TxAaJSxmOMj86rQC/biKRG6vMvZpCAfMMN5oIhDKtBs+JlJM4P9SWKGu?=
 =?us-ascii?Q?dtiUbdsjvKTj1eBTUyaA5XrjDqH38RxPc+EvTbn9zxSgKfIahWGx8rijsQKt?=
 =?us-ascii?Q?nR1uX/Nh2v4ai3tLIyBJ5+kCpKWo1vGOdmspovZRpAFemHWhsEFadqbOfRDd?=
 =?us-ascii?Q?+0V+1R+dc914Oook6M/ZueqvcheEJEtuUleil6p+eX4/3vhcJgVdV+4NDQpw?=
 =?us-ascii?Q?ofv4hzuNtkcsG+9rIf+0KTqlBAbgcdVk6u0Hjcfk9kEvAWlJb/D5Y/9IB2z2?=
 =?us-ascii?Q?qJaulrHCaRtjMzoe6Es7T3K0jfl3uwk/2uCnlBwdpTxqAx1YSQxSaBy7s+GI?=
 =?us-ascii?Q?7R1elXMYbKbKWFPNmQerHg5xwRcAgfLU6rwGY/5Te8YRGh5IPcN3uDVltH0/?=
 =?us-ascii?Q?JbqzusevtEnflsSDLhkQHJq9Q7RQEzooZr6lFx8n55cvMVFIi5/6FxzGYt0C?=
 =?us-ascii?Q?Z6pmWvAKiyxFjRcF7TPykICqnBpXE+GhNNtklgsSp5YNBmoNcnty1HGfFCOQ?=
 =?us-ascii?Q?2XqueW7mmZVqoBQXpWyIvZM7QLVE9vFbxpDTDPMinpCMAh1ouXKFJ7G763rx?=
 =?us-ascii?Q?qfH0oXOEx0oB+hPZwzd35QvPWRVCDIHQHNJTUOjh27J5R1PvHwgX0U/qkEU8?=
 =?us-ascii?Q?wUO9Lj/3LF1q+31SIJMO1DfVEpa7rbrCNEzhvtycyPtIdGpZOzCwvZ9ssLpk?=
 =?us-ascii?Q?l+oPEKT41I/PvVJ3E3xJLj+IIjlv8O6OyyjKlND1cvOl4rx8ac29hFQqKIWe?=
 =?us-ascii?Q?KdmFn33uY0aQWuQ62RIkgGh87wU9/S5y+MNRoNCIgX74dgItIV03Mz/aMPLD?=
 =?us-ascii?Q?YQFUMu30gVMj/5awU1gV2GfjFDGFxnJOmBshQvfZI5I0XeOPxkUKa6uOTh89?=
 =?us-ascii?Q?W0wUfobAQ3s1uZVGG+ihC7PR9ebNSBJMmnf3trHDAljUuiANmqgTJO8Ulm+5?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yPCpR5ZxvGVubaApFeMevOMrWkRSrz5OakE/izFy+hpMqAGqve7dBCYYuHj2ylOylYtHOvBjrVGhFULvmLjR+z3SpYZuxE7kEnYsi1NofWPYTLsIoI95gWVDyAGBJBWJpUy9qAhQorRiBgc27aPZrq2dj8S9zczYGGuzSMJ6R9jFS057g+C0o17d75IN09XWYeYJqIzNvbH9fMVrU7FRX5lG/E7HQa4BqbQT2OFMLfp8WjAp+Zr7REtucU6TvqEjFj+1JYMWbCq0GnGpqDGdY33PvNVyz6QCdH4ddgsq+jtAH4/TuWoEw0ni8+90zHWOYungqY4IS9xBz8IsSxwW7jT+tyNCqdcukOjeaRTiZb16VX18GFntfPORpCS4L8izw3c8q8ZpSUcy9QSfZE4s/ZQTvMU9EubIOdv1vEM8ZEYqrKhLzIjpsaBCV2PhVHRLyzTfQo9VqdWNlzJOr9fs5Iq0tYoIpUlqPNOxTH3ntFk1kfm0zZPzEAz7Qz4nPnOBBvzj8DDpJOzCoDU9kO/COh9ZSzAxaBK/vDTuOfzxLKbBbh3H96Z0YVQLdE3AzU7R3AIuBm7vtkpe34iK1yOKRehr6hUDAHWxeQLU4yY6nkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f99c5a9-6c82-4e12-f3a7-08dd15012b91
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 07:48:12.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaAzSFa0HeFAeOMGDs324xKVWJlqUimqJd+h1RvLL85xRxLZw+4MODlWS9XTM/+XYRNgqbLFoCOAiirP1FFvD3K48zkHFgyUEGQCOKKckp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_04,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050057
X-Proofpoint-ORIG-GUID: DRktEyykqD2oT9wlEQatHU3t_hrIrPib
X-Proofpoint-GUID: DRktEyykqD2oT9wlEQatHU3t_hrIrPib

On Thu, Dec 05, 2024 at 07:09:18AM +0000, Lorenzo Stoakes wrote:
> On Thu, Dec 05, 2024 at 10:16:51AM +0800, Lai, Yi wrote:
> [snip]
> > > --
> > > 2.47.1
> >
> > Hi Lorenzo Stoakes,
> >
> > Greetings!
> >
> > I used Syzkaller and found that there is general protection fault in perf_mmap_to_page in linux-next next-20241203.
> >
> > After bisection and the first bad commit is:
> > "
> > eca51ce01d49 perf: Map pages in advance
>
> Thanks, I can repro locally.
>
> Will investigate and address as a priority.

So this is because the 'rb' local variable is being used for something
other than just being a handy alias for event->rb, for some reason...

There is a specific code path where ret == 0 _and_ rb == NULL, which
obviously means we null ptr deref.

Specifically in this case it's because vma->vm_pgoff == 0, so we don't
assign rb, then after the again label it's:

again:
	mutex_lock(&event->mmap_mutex);
	if (event->rb) {
		if (...) {
			...
		}

		if (...) {
			...
		}

		goto unlock; <- ret == 0, rb == NULL
	}

I had assumed, clearly mistakenly, that we would not reach the end of the
function with ret == 0 _and_ rb == NULL, since we need rb, or rather
event->rb to do anything.

I think the correct thing to do here, since we assign rb with rb_alloc()
but do an rcu assignment to event->rb for some reason (possibly now not
necessary actually), is to just add an rb = event->rb here.

Will send a v3.

Thanks!

>
> > "
> >
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_084442_perf_mmap_to_page/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241204_084442_perf_mmap_to_page/bzImage_c245a7a79602ccbee780c004c1e4abcda66aec32
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/241204_084442_perf_mmap_to_page/c245a7a79602ccbee780c004c1e4abcda66aec32_dmesg.log
> >
> > "
> > [   22.133358] KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
> > [   22.133907] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.13.0-rc1-next-20241203-c245a7a79602 #1
> > [   22.134557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   22.135371] RIP: 0010:perf_mmap_to_page+0x39/0x500
> > [   22.135763] Code: 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 3f 5f c2 ff 48 8d bb 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e9 03 00 00 4c 63 ab 78 01 00
> > [   22.137075] RSP: 0018:ffff888020f0f798 EFLAGS: 00010202
> > [   22.137465] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
> > [   22.137980] RDX: 000000000000002f RSI: ffffffff81a5ccf1 RDI: 0000000000000178
> > [   22.138495] RBP: ffff888020f0f7c0 R08: 0000000000000001 R09: ffffed10025fbdb0
> > [   22.139012] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> > [   22.139530] R13: 0000000000000000 R14: 0000000020002000 R15: ffff888011cce3c0
> > [   22.140047] FS:  00007f7f57f30600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
> > [   22.140630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   22.141052] CR2: 00000000200000c0 CR3: 0000000014e10004 CR4: 0000000000770ef0
> > [   22.141570] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   22.142088] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [   22.142606] PKRU: 55555554
> > [   22.142815] Call Trace:
> > [   22.143005]  <TASK>
> > [   22.143173]  ? show_regs+0x6d/0x80
> > [   22.143455]  ? die_addr+0x45/0xb0
> > [   22.143720]  ? exc_general_protection+0x1ae/0x340
> > [   22.144102]  ? asm_exc_general_protection+0x2b/0x30
> > [   22.144486]  ? perf_mmap_to_page+0x21/0x500
> > [   22.144810]  ? perf_mmap_to_page+0x39/0x500
> > [   22.145130]  ? perf_mmap_to_page+0x21/0x500
> > [   22.145448]  perf_mmap+0xbd9/0x1ce0
> > [   22.145729]  __mmap_region+0x10e7/0x25a0
> > [   22.146038]  ? __pfx___mmap_region+0x10/0x10
> > [   22.146376]  ? mark_lock.part.0+0xf3/0x17b0
> > [   22.146712]  ? __pfx_mark_lock.part.0+0x10/0x10
> > [   22.147071]  ? __kasan_check_read+0x15/0x20
> > [   22.147403]  ? mark_lock.part.0+0xf3/0x17b0
> > [   22.147744]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> > [   22.148162]  ? trace_cap_capable+0x78/0x1e0
> > [   22.148500]  ? cap_capable+0xa4/0x250
> > [   22.148792]  mmap_region+0x248/0x2f0
> > [   22.149086]  do_mmap+0xb29/0x12a0
> > [   22.149355]  ? __pfx_do_mmap+0x10/0x10
> > [   22.149651]  ? __pfx_down_write_killable+0x10/0x10
> > [   22.150027]  ? __this_cpu_preempt_check+0x21/0x30
> > [   22.150393]  vm_mmap_pgoff+0x235/0x3e0
> > [   22.150699]  ? __pfx_vm_mmap_pgoff+0x10/0x10
> > [   22.151037]  ? __fget_files+0x1fb/0x3a0
> > [   22.151352]  ksys_mmap_pgoff+0x3dc/0x520
> > [   22.151664]  __x64_sys_mmap+0x139/0x1d0
> > [   22.151975]  x64_sys_call+0x2001/0x2140
> > [   22.152283]  do_syscall_64+0x6d/0x140
> > [   22.152572]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   22.152960] RIP: 0033:0x7f7f57c3ee5d
> > [   22.153251] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> > [   22.154593] RSP: 002b:00007ffd805489f8 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
> > [   22.155156] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f57c3ee5d
> > [   22.155683] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000020002000
> > [   22.156210] RBP: 00007ffd80548a20 R08: 0000000000000003 R09: 0000000000000000
> > [   22.156739] R10: 0000000000006053 R11: 0000000000000212 R12: 00007ffd80548b38
> > [   22.157263] R13: 0000000000401126 R14: 0000000000403e08 R15: 00007f7f57f77000
> > [   22.157799]  </TASK>
> > [   22.157975] Modules linked in:
> > [   22.158322] ---[ end trace 0000000000000000 ]---
> > [   22.158694] RIP: 0010:perf_mmap_to_page+0x39/0x500
> > [   22.159061] Code: 41 56 41 55 41 54 49 89 f4 53 48 89 fb e8 3f 5f c2 ff 48 8d bb 78 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e e9 03 00 00 4c 63 ab 78 01 00
> > [   22.160388] RSP: 0018:ffff888020f0f798 EFLAGS: 00010202
> > [   22.160782] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
> > [   22.161304] RDX: 000000000000002f RSI: ffffffff81a5ccf1 RDI: 0000000000000178
> > [   22.161824] RBP: ffff888020f0f7c0 R08: 0000000000000001 R09: ffffed10025fbdb0
> > [   22.162344] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> > [   22.162877] R13: 0000000000000000 R14: 0000000020002000 R15: ffff888011cce3c0
> > [   22.163403] FS:  00007f7f57f30600(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
> > [   22.163988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   22.164417] CR2: 00000000200000c0 CR3: 0000000014e10004 CR4: 0000000000770ef0
> > [   22.165409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   22.165956] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [   22.166918] PKRU: 55555554
> > "
> >
> > I hope you find it useful.
> >
> > Regards,
> > Yi Lai
> >
> > ---
> >
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> >
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> >
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> >
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> >
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> >
> >
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install
> >
