Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974625A2A7;
	Fri,  7 Mar 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389751; cv=fail; b=uMmraPas2a3LpdO+WJl7+ji7MAAGMNwqOPMfs9BqjpBBdQZEqYXA1Hde+DHZ0A5W/CyGqa9Xvy16LNhQV4UflusA/4e7V0lZPyRRm7QD6m7FcBp/doHCfftMhCMwQjJp0x4gGH7DYTl+blpFEf/8moAAxPx/9LanQun6JcJAAnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389751; c=relaxed/simple;
	bh=ACxDIzlyWKX/SCqt+4yCoyNVjV2JPvhv+c6Np3sdCUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWvz7zrUjdxAgyFfvS/LoMLf34BqL+3fRoBezX+kp6Ldkt7l62gx+8JO8vcfJVt0oxpnyBu/cFpn2Cy6hjbAOS2memxahT9xuG3ERZJQOE5Z5HKg0LOHepDNjMPLjjSRGYXN9A8BY3qAzoOqxR2a/vcHiZIr860+zfryns/Po1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fnMaoIiz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XsfHgqPV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnMaoIiz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XsfHgqPV"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527LJGat012269;
	Fri, 7 Mar 2025 23:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M/5/VgEZCijeurYxNwPAXZhUuis+hKZc9TPXfdPQtdY=; b=
	fnMaoIizqVEk0raTchFpvW6tMFGozZa+uyHZOZAFnOnhjPY8ERBpMhpqSqg/Fp4d
	0kuNpkHDKvvlGtHxaQB90Fjae4YWKKqpBOUzuZ8/lGbIwkligsSvciCafdeeD9nH
	pyUqSOfEAYzqBk0BeYQuuyIVtY/FXALPA5CJxnAJ1Dtbe5rg6NQrJLl/T0wWxhXE
	RHyKdmFhlhqGLNGpwvONtpcvjV7xZcmScyYxtqxRvaak0PKb5MerW7coWn/GKtxO
	yDOtABQeocwArS9vRd79AYg2WX6dGn8OyjMxdpb4Ow7pqXeY4+BwfdU7SqyPvAYQ
	BAnu4G2yWU8OUXLQoAu+cQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8ww1h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527LCVOD003191;
	Fri, 7 Mar 2025 23:22:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe547m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcqKT85vCube94o3cIIKexc/UH130NR7+qrl2pUi/KGK2uDaX0RfJI4tywPXnbEUkWwS+jTPbp0Q1CcjNpHA2OdaSZ/im5HD8oMj4qqmyvgq/Eigjt79RTvueQ9gg2CqS6ST3auqIRIHqdEkcOlX5E0F+WW9voAZzUNpbqXP/8jxOtt44+49QldaS9xgkXy0sxCWDrQT/2HkInx5Z+5hVyPcHUioU8LB3ZjG/PqKhnVaNlOHwNxNJGbsA1mNHi1ppYxa7+CfU08qIVMAhgralZW+lxrkw3av2TwwU/JtvVNPwDM4xCTU4XHt/LeGFKmUU/+lRPJGgHeIWeQWzUAbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/5/VgEZCijeurYxNwPAXZhUuis+hKZc9TPXfdPQtdY=;
 b=oVY96BYM6gQgh1TDXo49koYY8rqQwfMvmNvJbdHU9jgekOlzTv2MwvOe5snsddy4Wx++rNvjjaydey0XMXUxkTOYzPCJjQz1cYMgTKNqowRzPCccCPhNi+vCNzq7Py2jxYzS/4QRCs5fTFQew98KlwCSjxOUBrRLB+7utj4ORaWmoLIRKgLK/nQvQNXWVZQqc9ssmcJsgajgpyu+GcEnlX5O1UMkAqLM+KlEs3kTnDKjpBLl4P12S8HHQsoK+kHfITFrrvGYRtVp7LShDpPVkxz0MPacFKMZNIhp1JXGnJNpTedWMWcPeqOlu/MFKM49u4CFZmdbaERoXs0U6KXNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/5/VgEZCijeurYxNwPAXZhUuis+hKZc9TPXfdPQtdY=;
 b=XsfHgqPVgnr1gO4IM5uvV5+2lLm68hdoIcrPfueQZ5yqJRhpA2vGTaoCkhCweqtDjuDRHhVLSFeCpIvz6gTusATQIZcGSwLSlcBTFajXR3xuY01si+WgankQ8mRH9m9/Ie/ziboHlvSQRo/EcTuwyfQpu3oU3fX4llaovk3St00=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 23:22:10 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:22:10 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v3 2/3] tools: perf: add LZMA decompression from FILE
Date: Fri,  7 Mar 2025 15:22:02 -0800
Message-ID: <20250307232206.2102440-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
References: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:a03:80::26) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 68409b24-f746-42d9-a3a4-08dd5dcee280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmvPR3atsiAouBwEBg3RBjqgq49FtY+Uao1lu7Z801msrg2NWzjVEXcSegUa?=
 =?us-ascii?Q?G+ZgrNLx4HhV/0f0w91MH9ZnjX97qhNZVdzeot1XUOOP/uBpOfuG+f3arSsV?=
 =?us-ascii?Q?SHE/2kLz2/lBaCRFh0LkVWkA944fHUmg1m6WhXO/AOnnANAIuzKZaPCBuYq+?=
 =?us-ascii?Q?nrKU4JROfRsUklcCj/7gcsXnOQv2ksORyZ0zicm51Y4/Q+LiEKa8IbhfXrLv?=
 =?us-ascii?Q?qOfr2e5Nb1Xex7Y2iNk3LlHNlwr6CWFc4VzM/IAKYgECpNIKUB8mDmkpiYC1?=
 =?us-ascii?Q?BTOsomWy8httLEYFcXAfGT//a0MtR3Izxregw764+ESQWNcFXbPdm3LGtsKt?=
 =?us-ascii?Q?Re6O7oMnGgAB5yrK8G/ALiVxEYe1LiV6Wyo2HZFshi6JFhFVqZoXgOM8pQdv?=
 =?us-ascii?Q?qISfEp0/rpvNX+GUlBSA4awywD7VAyhxBTtv19Xdcw/FQqJxoQWMOo+TC3xI?=
 =?us-ascii?Q?xkm7AMEQTp+ntRSkXrqXi+6N50UOOxVCj1eoKkrKYwi2G32ndpWOw1C06+aJ?=
 =?us-ascii?Q?XtE0UhxA6svXxDpQhfo1r94og/jv+IodNdw/EIn7emo12qg35fc7sh41UtGk?=
 =?us-ascii?Q?AraWKKCBimCu0noTBe0D4ieSRsrkV9xMvgJjOTvoB+jv/Q/Uhf4SoytigZB+?=
 =?us-ascii?Q?/MRc1eRjHsyMxzm3HQRROc0IO32ibMKM9s4eQoKpMByYV9UIxYdrKorEMeZY?=
 =?us-ascii?Q?4piHln+TrRny2kdv5ziw/eCV2yj7c5cSuLxkJDm+DDApwKL0PwTSe0BNxZ3I?=
 =?us-ascii?Q?F2dhR9zInQzeKh0eEXMKzTx53SpUAAXfkBS+aeKeDDQ6YEg5qL6ZNIOybEwc?=
 =?us-ascii?Q?z4CivFWyhCYS7njqHoi/nTCZF3DVjBorOMjKkgm51IayXckfD42NWTm2V96Y?=
 =?us-ascii?Q?/34pDUX+GY7Bv00gT6HG3Y4XH+vig4psI/NFm3CgHju17tbulFqe154sAMY3?=
 =?us-ascii?Q?UmIv+iGNa6cIrsy3oVvmDVzo7eda+4Cr9VRi1tgZkm3pXOf5aSpMA7rIeXxI?=
 =?us-ascii?Q?Fj8qScb3l18VT6LTRhueHIfQhyrTs6IB+/6TMZ8rQ9pbOI3wXxS4tg/eSFE0?=
 =?us-ascii?Q?zWtQ1AestA54EZ/VRYBQ/NnY96iRHIm8Uo+3NEQRzvzMSj+fJuZae/7dvfR5?=
 =?us-ascii?Q?uir3yI101uSBc7r2A69/7kIGa5Qqe7Jh5ymV3bX4Wm9gQ9+l7d9P8syse3XW?=
 =?us-ascii?Q?lE4S9kVkSDsobYyR0Y0BGHiCTqcvPtsM5yuUNn6DeSP0fSmZhly5RBXo2uN8?=
 =?us-ascii?Q?rKn/Yosa6ucufJSYee1VZoGj3DQawJU0rF8RufGEv1GxBPwgXFxknlmGWkjT?=
 =?us-ascii?Q?PwCWDZ6on4ts2XP9Ug6FOd/49ui3UiDSeNN6xtyK0MQoWHrcM719AQnI+B6v?=
 =?us-ascii?Q?nScQYdPOnSBXxrzMNFOCo/jrYwJJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fhnBSOVu0QvT/3dnqbjWqB2BzlovWr/DxHM664r9R2YKKm99dX/yMQkZN9Mt?=
 =?us-ascii?Q?XF9HtoAvIsuNHMW2tHE2kBav9Q7Tq8+6VX3YYm9mv4KCUudkxjq2Ui8LF5TD?=
 =?us-ascii?Q?BLsNOqcN2YtA4T6TW7eBsHb0Z3uZCBKqy09RqSJT2oGniCErU0VzklMqXbIl?=
 =?us-ascii?Q?V/oOon92LU4e2IITuUnliBKGYGquSgYozIcLJHk+oJPUE+u0Pu2v31qEZZre?=
 =?us-ascii?Q?fYwK5P1xjHL57teqsZKxwKizWXJqe24osiFJhDQUGruM4UsglR2/hwfqe8sU?=
 =?us-ascii?Q?Q7uy1JhBXuVOJr7kyatqunElKK3uMjxjsWFV2MAc82+d3FJt9iCyq0dkMF2K?=
 =?us-ascii?Q?OdRkmehLz4yYqKfeKO4yHq9Svw0fXEvcn7/iIhkQ0LnA72FXHdQZxgYSPCU2?=
 =?us-ascii?Q?SNNkebBnxvbGoT89sYekjv9CwRzLoE3Iq9fP+GqLp3RaalQHyQOOrkwYsF7h?=
 =?us-ascii?Q?CJXX65j3MeM/dpgS1zsDiZ/c6du96BN7alf071KbdZYsQTvCg3nHpWF8QWDx?=
 =?us-ascii?Q?c7QzL4km2INn0SjJze5FUAjvW37YKe8GcuECNCEaUCgnwudLOFiKqCjqJr5t?=
 =?us-ascii?Q?gIX9GIKjQ57AVvCyCcyyH4ILlzc5csaHP3SHlt+fsf8mFNtrAEWVDpwem5VX?=
 =?us-ascii?Q?D4NpepbKJBWq9yXJ2GQeCwYgQURMhJAJJY+8d6+e+XaEpHa/bd7QpIhGX8P/?=
 =?us-ascii?Q?meB5WKpZ7eTwjJXQtsKsFcJRI3hbFq5mzXSVmJl8dA7NJKiKyqF7th0myBx4?=
 =?us-ascii?Q?KygdLJ2PBdAaKdpeffsesk23bsKiEvP0XkrIp0d9cgvr+nIgbdcNRxuLXzcV?=
 =?us-ascii?Q?fvtpcw2FxGcYYMLwTubZ9dNsdG6Jy8oKYyYoTBW360j1mNmUfKtnEH4BOOsw?=
 =?us-ascii?Q?LQf3LeWZDrlYpfXV9xj+2N/La0Y18qIfc8VT9fhk40pAQFDA4rZ8pXeWVieA?=
 =?us-ascii?Q?DaQ5h2N2habO03Rv5o2MP5+Owo5IXitQ1B6yd6RY4mZ70fm+PFxnYyKobr1D?=
 =?us-ascii?Q?FIWeR0ULSzd7GUjOfC78OAJxtFMbKymakeL9tsLIqQKujDDbyFq6r9GVFDy6?=
 =?us-ascii?Q?Ce3dh0P0vIUAZuEpXF/NPvo6tN+2KZI/1nQx3qq+1qLpzfCZ5meefvh1ZeRR?=
 =?us-ascii?Q?aLgtK5Cmni0QZtjQu+UnoWk0olhImOIV8SkkM9nc8pzUJ8hRTVBFVKFDXr12?=
 =?us-ascii?Q?DI6RaScXcTsYf9T+cWhNg7cNVKvw9Yjxzi8b5a1ivb1crCoS6LbuNxb36CoK?=
 =?us-ascii?Q?uvQ5K769xy7Mi8kfFVBd6cQt7F0rmWxTqWK4Dce7kHF7yNa7Jauu0E8gcL2Z?=
 =?us-ascii?Q?idYwCNSnBgNOmyLOa92AJJ7OPf7bqj5ty8IPbX0WJduf88fYUq32zcF31x/M?=
 =?us-ascii?Q?voyNx8HyQeLvAs5MAr8IE0375MRcMq4uzi0KtAZXYacc2btBTiNeazhIN8pU?=
 =?us-ascii?Q?vDngX9CjMs6DnjWknqxJlxbggtaGIMWOHhvhtA0IBIhaJoolKWSdnz1FHgIZ?=
 =?us-ascii?Q?CbJPZEHB9SE+zE/rSbIk3wPMRB3G624mxBwLkOXlY+iKQeE1seCYeyhvemEy?=
 =?us-ascii?Q?93cwUJUr+z45nKzK8wCfe39kLNLIjfZSwPsGqTCh7GAcsqeFDA3SZ4tfhl01?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NqdklG4VeFgne5P1cq7tjtvP9U1fL0GyUeQIk3kZjTNKuR61QY26CSNTyP+q18X9QCgmBRZkwr9S9hEdSRFzomL70v0JuvnBozSj8NEaWMY9dG5cm8qGqvO1w8fVO9MGqNHx8SkHvKFHc1HUh499b5lhd4UnUsYrDPt+EdOEEiewJ5BFUBtTZkBFGYoHSTosxeyPd/60zRUPgqZb9tZXGuRfop747dWOfnLGh9EWzypW46OCJeG8ARRi+WtWYhOTofKkiDO5GDx1mEzlUvBDmmYaKQkspaKcf7i/Hi0pPcXDv5J9ynYWcUrNIK01+FpjOMWf5tTvI0HwKmeOGvCxLxB2xtTvRFUZXFcF7K6edluk0J5daArcoFKh2roE4ZaaHC6Fha6vL8zpYx0OXgiDCDx86uspn2fqNcSXUHSgZB27rP58dwaMi1lmNGpxSnuhj0ZPTquN5bcl7hBwK5L2owTnIBq/IfXfrMeLpIJemEnrjfhoeCnHgBVIzXbshsar0hHVigaLqPP3XVQrmRLLnpR0H7kZ45a5wec0vUivUFelVJgJn78QLvAigA7hFxOfAfGN6jRa6PlFPP0twzgrctRTAsqVXbLPJmWmiptez/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68409b24-f746-42d9-a3a4-08dd5dcee280
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:22:10.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr5Dk63YEWG1ZGty9oxgaScm65aAq+M9o2zpipAeooewF8vGFw2WObzfCaGNUquo2UCkRp777C+s6+HzDT/FuSqDo9zxiPOBAoFGUfMVkLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070173
X-Proofpoint-ORIG-GUID: 7ZHnD0cJNSPTSkI2Vqm-f7wocPYt9mfO
X-Proofpoint-GUID: 7ZHnD0cJNSPTSkI2Vqm-f7wocPYt9mfO

Internally lzma_decompress_to_file() creates a FILE from the filename.
Add an API that takes an existing FILE directly. This allows
decompressing already-open files and even buffers opened by fmemopen().
It is necessary for supporting .gnu_debugdata in the next patch.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/compress.h |  8 ++++++++
 tools/perf/util/lzma.c     | 29 ++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index a7650353c6622..6cfecfca16f24 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdio.h>
 #include <sys/types.h>
 #include <linux/compiler.h>
 #ifdef HAVE_ZSTD_SUPPORT
@@ -16,10 +17,17 @@ bool gzip_is_compressed(const char *input);
 #endif
 
 #ifdef HAVE_LZMA_SUPPORT
+int lzma_decompress_stream_to_file(FILE *input, int output_fd);
 int lzma_decompress_to_file(const char *input, int output_fd);
 bool lzma_is_compressed(const char *input);
 #else
 static inline
+int lzma_decompress_stream_to_file(FILE *input __maybe_unused,
+				   int output_fd __maybe_unused)
+{
+	return -1;
+}
+static inline
 int lzma_decompress_to_file(const char *input __maybe_unused,
 			    int output_fd __maybe_unused)
 {
diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index af9a97612f9df..bbcd2ffcf4bd1 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -32,7 +32,7 @@ static const char *lzma_strerror(lzma_ret ret)
 	}
 }
 
-int lzma_decompress_to_file(const char *input, int output_fd)
+int lzma_decompress_stream_to_file(FILE *infile, int output_fd)
 {
 	lzma_action action = LZMA_RUN;
 	lzma_stream strm   = LZMA_STREAM_INIT;
@@ -41,18 +41,11 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 
 	u8 buf_in[BUFSIZE];
 	u8 buf_out[BUFSIZE];
-	FILE *infile;
-
-	infile = fopen(input, "rb");
-	if (!infile) {
-		pr_debug("lzma: fopen failed on %s: '%s'\n", input, strerror(errno));
-		return -1;
-	}
 
 	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
 	if (ret != LZMA_OK) {
 		pr_debug("lzma: lzma_stream_decoder failed %s (%d)\n", lzma_strerror(ret), ret);
-		goto err_fclose;
+		return err;
 	}
 
 	strm.next_in   = NULL;
@@ -100,11 +93,25 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 	err = 0;
 err_lzma_end:
 	lzma_end(&strm);
-err_fclose:
-	fclose(infile);
 	return err;
 }
 
+int lzma_decompress_to_file(const char *input, int output_fd)
+{
+	FILE *infile;
+	int ret;
+
+	infile = fopen(input, "rb");
+	if (!infile) {
+		pr_debug("lzma: fopen failed on %s: '%s'\n", input, strerror(errno));
+		return -1;
+	}
+
+	ret = lzma_decompress_stream_to_file(infile, output_fd);
+	fclose(infile);
+	return ret;
+}
+
 bool lzma_is_compressed(const char *input)
 {
 	int fd = open(input, O_RDONLY);
-- 
2.43.5

