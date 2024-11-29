Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80919D88D;
	Fri, 29 Nov 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885376; cv=fail; b=KMmDM7ytHhqQ/hL6BetvSk0GjH2TNYg3yoZDuaSGZDE4belyGkphUfMTPaxO6zYEUoAi1JHoFLWyKt0iArU5x1CrTRmcDmdBfEpjgDai0VFrQ6AiArObmXKcMe/FdChEqEiLDMC50mU7Icd7U517FjxGS/eQ3/M1H/K7qhN3t2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885376; c=relaxed/simple;
	bh=hip2uotBIRXnYeOKa4j2gBFSMqSbfwQy8YHjl49hjA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3dRYWGLxKwFSpYNROgLU4wq553XqaHJRF87YYRksk1Ji109r2DzygB9jz16at/gem42UVvgygdX1Hi91oai0PCF1whxIoSKZteu1MG998QEteb55dixnWm+LrWRUsqeUm9FlW7yOEDyraOf8yPZhf9GyGoSVYBsi9W1vTFDkM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h80Mgqcj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=arMwzykM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h80Mgqcj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="arMwzykM"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fnTl031897;
	Fri, 29 Nov 2024 13:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IyO+s7dhdPgUJl7ASQ
	9FAKFDwy12aeExzSCS6oAgtgw=; b=h80MgqcjNrW2Ts0vEieTQiWWzvhYu8hJtR
	l9FihHfYednjZUYhf1AL5zCx72rmp89WNRVViqfjBLQiLT4nnb6GP7tfOstej7G/
	kJ4dLeSB3/1sjyHRRGZcCn8/xEe/9Ocng12SO+dFWXlZ5f2Yq2gayjUOzkVGV+RR
	lbEjuON+CAhUCecQGviHpmG50wOFloZQFQYFeuU+EEexZF3DZPp3B6JTTQnXjdJy
	HPKl6wuJvC/IzjcUDjb3lZ0B3cVK2EWeqghFLskI0bB3KfEXJDCwois4JIyDByaX
	Ttow29qYMZXhhOs0SbbIrNaYyykQbcY0efQtcM7Qi5Bl6j3WEPJQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyu9wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:02:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATB9Vet014317;
	Fri, 29 Nov 2024 13:02:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436700nsa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQKjUOjgn8T+vh7qJrqDSjfTb0JSFs6NakbxFtKJd14Dc4XDDfNm7kb2bzuxk1qpRSt9YogGsWX48RtFCQXvxveXN56Dtg7r6cvvlwSOAq4ac5GTVoWvMJFU+dQNTtDDrGh0iAFk0ab1nI8eC1rVJwdABrtmyz9CnfUgrRrTwREvwBtgscFzKR28iSPRZ0ldfyCjIsugBsQNBuiclhfb5/9NdQ8N0wNLI2Q+LSxrnHPdgUyWsmhYGtgRf/huuxVWOLbZ8x1PGGDpzWe++P23cKXHjyb511bSR0+7ZdnO7LFYCdP19oWXIVm2E2oCOMGKXtPoFH0YP/lF73h/txivpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyO+s7dhdPgUJl7ASQ9FAKFDwy12aeExzSCS6oAgtgw=;
 b=MHIdZdAlOunoleD1FEatjbPrEXAfYNUzHOIavFVN58dmmn8hZyihI8/9iiB1qnWAdGz0fEtGB9Y+MVWqKX7dQ5xQaQ4CzLEs3hEM60sh7KsvlX7PJUuA4Tuc7HrmdbpdGZuXL8BzIdCnQfi1BIVB9yAQQWBl/QEAmqI79YuooQH7W8SVJNhngP4rD8G7sKsc6I9Npat6XvexxwoCIlFt2OHvJ1M0wvwGwWWsJRRCQ0MAcmQhzoE5jB4G6V1WjHvB271e89Vwu9AlHyndaFsCWvOao5/bph9DgzgJEFhLxoq+PGYflYxBLm78TskoJFnTpZ6olKFvNa5uXl5zEhbxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyO+s7dhdPgUJl7ASQ9FAKFDwy12aeExzSCS6oAgtgw=;
 b=arMwzykMbklC4oksYCEkTSIU4o8u26tiSddZnoC3F+eRJYwjxWF0fIQhmzvoMFPbosR8tLTBIOGsYU2JKdo3OqFNF7mYQREbxKay0yDsPxeFBOfuGxMQw1BIxsDffbRLNaNlwnFnQDOKj9N4v+YseZYSLWfhb8j1hm0JO0BvY0c=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 13:02:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 13:02:33 +0000
Date: Fri, 29 Nov 2024 13:02:30 +0000
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
Message-ID: <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
X-ClientProxiedBy: LO2P265CA0395.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 11abaff7-f186-4a23-b714-08dd107616d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UucaEAcOWuuHHsUXgAhhUXOwoKbq2wZ04yxDZdrRNmkFl92lrk6xSDZq+tW?=
 =?us-ascii?Q?yb6Oroucd6ZxIMzQ76a2n3du/AYf2/S6qq0Yo5/jy/Kn3FZBLtBt3VXjFxly?=
 =?us-ascii?Q?hic/27zK7y81mN+/FAGffLc+S6E5DSj6iSYBeGtQIbOKdPmYZ5c5J893q6vu?=
 =?us-ascii?Q?OWZVkV9tqfw1Vizew7esLNoiwrWIQnEj9kLBiAmJrtJc/8siXNu2m56Cc34x?=
 =?us-ascii?Q?vLcr5MxRBWXYsVj7DsmV6KEF80NxvkntJSRe7ZmLvw8C+PZ/qkBUT2TJ9c+9?=
 =?us-ascii?Q?auuQlqKub3R7XI5tRTcbaLcK9yilhAmINlToITGxtnzoDf4LwScn/ua6HYsF?=
 =?us-ascii?Q?XcjuO11WQkSe4hQkX++B/6IW6hEO6hheRMf9x49/EtvHJAgO9x0OrkiQwph+?=
 =?us-ascii?Q?ZHGh4YPJOwrg8ObQb3sED252+pGle8vcxyAT0dc3rvxxFanHWaR8tWGV6sQ0?=
 =?us-ascii?Q?0qRij0sCAlHrp9YbNLprPriisVQWhmYrREVI2TxUggVSfDEZGpMW3iVQqlWe?=
 =?us-ascii?Q?qxno6JeR8hO0o4N3M6L1BrGrUzJMqfIs/aeWAkuMiZzGJdJRAx4eTa1xuXoZ?=
 =?us-ascii?Q?uAyIXrOJuwc3mRBoU7R0FH4aHU6+AHGVxwE9Tz9Kh9RScC2/efXuuukr5Ykc?=
 =?us-ascii?Q?Y1I5NXNklNI2tGIRCLGR8iVqVfsZm8BcWRhy3eRJtZA0dd4TBvCPSMQ314JO?=
 =?us-ascii?Q?x5lw9JsGMtMY5IaDpYyG1CR3yqd0Otimi96vjI2IwHTBSuC6rFDSxyF2xc+q?=
 =?us-ascii?Q?Nlr0ASpLSdMXy/WxTIRkkt+C+pPoeKpx2zYvfncvmNUYm1y+Mdgbb4o6RE4P?=
 =?us-ascii?Q?jgnGNaeBOCGR6HNMP5QtMOEtzsBqIUltA+22LfmgIkAGVyNgnCEoxtMPrCI5?=
 =?us-ascii?Q?eRqpEpInmGBL7Pmari0rNQ0sKPTosFaYIXg7R8XwqnkebI25KYq5eT8HQ8Mx?=
 =?us-ascii?Q?ozPFmI+xmTTQGkKPyFUMOaAMG74NjxNeu483jPxBGMvSYfrb3ip2sBO4gHq0?=
 =?us-ascii?Q?r/EyZJs1JsZfhqNPr852iqPu1BxncXo79cmx8IivF0lk/hDFCOQA34LO78va?=
 =?us-ascii?Q?ZtpvqCvg34tHTK7YPUb7+y25Ad7pp2m/fzT1y6fCTPMxGZHJJSkvCIemc5v0?=
 =?us-ascii?Q?V6RgjujwZKAPSvbzRIB/F94hTNDNJeGj16MaL0WFLo7/x851gd5w8zN4Lieb?=
 =?us-ascii?Q?QOxjxGKLvCvCfXkz/LQMelCaey/fo6qU8VKru6Y4nBTaMDPZIfC9fSOYckGp?=
 =?us-ascii?Q?6ZXIBigA9BwYTntveI+uYT3qY/wvuMRkRnIi8j44txabY3uLrV6c96y1VjwB?=
 =?us-ascii?Q?ZBlT7GLN/e6wwdnLceWnmtKqWcyYKO9eMT3xkpw48cMgBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?++7TlqoHfGqyRuGU4phAHwDb+Xg+K4cS81lDVCnZXvghoFgNdfInvABAvGli?=
 =?us-ascii?Q?UJtbDLeyUlGDzDyYFlKVSWGlJha2hJ6OBPrnJLg0NE5IvHRrzMgjIWHgUqI/?=
 =?us-ascii?Q?R2MaSUd0gc4lZlVEpKZYe9DhKR6UWzADQGKEcPExZsvZ4FozAGiKxfRk4BDW?=
 =?us-ascii?Q?wY8sCvYgvKlrNYpkw6zo63v5dnMN75//90BJOObpDczxQpzi6vxkleD+Swqi?=
 =?us-ascii?Q?MfFQbWyQCxn1HLXeKDcDR7ZdOsncwra6DT1sP1LZcsey3AkyrUUadwABqGQq?=
 =?us-ascii?Q?ORpJ2ZDMBrMjPBNavps+M6HrzG42tjT/kbxbqPwZ5IZ28R2abes0GEBgUdOi?=
 =?us-ascii?Q?VBpk6tdokbk84vi+md0EUBcIBKJuYUBXWX0HWh55Xp2ma4sSnoA1qGgbBswT?=
 =?us-ascii?Q?QlJSNqZqS2ki3dq8nug1ZDRtChF9mdMuxo2Z2oyWOrYxeTN+9YI2h22Pa8J4?=
 =?us-ascii?Q?/K7QCoamiTd2zjxW+dsQB4z67vi606ne+dwMlVjJ6O+EQJRyJkihin5pCf8g?=
 =?us-ascii?Q?gE2Ix8wsEVtmIAebMuFZhPu6Eitd1o+74jKfoMQ8YymMjC1F0MW8+MQh6ER2?=
 =?us-ascii?Q?gVHx0U2yYaT4krpdr43dXM9l/dFl7fXSDcqO/GlOunHySyaAV8IcKtgI78la?=
 =?us-ascii?Q?w52i+8yk/dc2StC9T1EP9HwAibKOeYPYGR5TCJZwpnNAAvRGyjlNdoVBrZ8o?=
 =?us-ascii?Q?NWgI3rmd/xmTupOS2/36S7P+B0AgQlHzJWDjcxcJv5epJu2GhJosCuzS94uK?=
 =?us-ascii?Q?3bsJ63SyPwMKjDIxg0elxB7Tm9fL8p0F1yaoLjauQpptc00UC0LtD1hwwHh0?=
 =?us-ascii?Q?YxbCr9/EfRin4EqnbqJIUpo4iuKzY9ets0zkxTMyh5Byg4wBBmfUdhjERS9u?=
 =?us-ascii?Q?dsZVpWSuIlD6eAi2Cb5fFMnlz5MZaGpqrVYu1YU41PQJBjCI0X+lsM15D4sT?=
 =?us-ascii?Q?M3mHBJCarkmnec5jhyLOIymsQmrO4yKIMcHKmx83MadEPA30sBn/44UdCdvO?=
 =?us-ascii?Q?05stiz8hdSveoOgp4fr8PljGO6j0PV3E5QCIpI7LROillFJvRJYwgSiVj92Z?=
 =?us-ascii?Q?KhfOY1LJ928ataD46OhU2gRLpJxG1NJ09A3Zelp0T1Oc5gcLgEmMTjwMuDuH?=
 =?us-ascii?Q?JesCDqXUcPNnYmwycao4ePl8ppVudVIySEsp4HYVQVOsKR7ND+9zFnHFF93y?=
 =?us-ascii?Q?5r23xNd55hOvUBdZb+uKOiUn+RLqP561OL5lRU2YnY3TrOM9AYaOSoIKdWnO?=
 =?us-ascii?Q?g78l5SF4xcaKG7dZAUU3LBd9aOlskEMLOG1ifa96/kH5W/ZuRVISLjlThPAc?=
 =?us-ascii?Q?biKbT7pPp74Sc5gr9P9zhO+obvESj1Wg8ZjXiB9mvKSC0380vOv5Kam6YX0o?=
 =?us-ascii?Q?uQqc0KRB03f6fNswIKrYAgcJYt80G51/wPzt7kW2LllaW+mgdtN58ZjvSfk3?=
 =?us-ascii?Q?+Z9QVrnW01Upq/nXLRobUKkSoTA2D95DT7F0GNMK5oeffw8e16jBDW4x++AU?=
 =?us-ascii?Q?Udq214A/ylz9/yfiLR0MXkZSyRDarjWu+tQ3AiMzqSp0Fn4hOO+sNwOc/iXw?=
 =?us-ascii?Q?Dkq4je5ta22mEULmDXNvsadyvCuKXkw5ki5oW3V/6W0LRxsPay/Jre1BTj/U?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eIx4MBdI6U7FZb6aIcmwcGTkUx6kAf2HyCM9Fhv68zQt7FDBM3YGOCAmyoG/lXnbmSjk1RZZ87NWgcygPH1bPiQaVUlBozMgCbBjuFdufPzUt6+XCoDpYWVkLkSUh2maZnxcw0R1Shgj1enj/b+yMLgigOeLdL35TBECf/9Q4OgNyU5F44FOW2tFhXfZqbKvxHMRCvP9VdPk1XmwerZtmQkYHxRWm+A6GCLm7pVnKc+bpDnpQnHn+ejpWK4zJ4kf4dAtWLKJ37XI/XDgrWxaUx0JLyCN6YMNicVlcDmnraivrxflop6ssmehS6Czc5YPL5V/mywQaMYqz7lfGrTqf7XUG3P7tMoIE/A4okEIg6tFTBS8tjeuycmvsPirSdd5gHuA6YpBxD8fBc8U4L7q/yrazRGZhSL8/wLGQedRfX3qK9QWUt9OOe/AsSAw/04AwL/7GOpngNftz2axt0udqUqpc0wyy7hWLJkPRO9vg8FLvY1+v8rul2jdOUtpjciFadS/pOwQs0rH/Br31Swwm43mu51kCNBEc/Qx6X1qCe2ech6vKsWMtULafobGtVTUZegUVKrwpcSIcxnRKtouUMPMbzq/nUE3YzE5PCdq/W8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11abaff7-f186-4a23-b714-08dd107616d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 13:02:33.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/Wx7CRrrll2LOK8Md+iwDjPkDo6Vj0E7iNi1PDy+vy2DRaBJu9eaFB0gyrXsATuM9CQekXDViAFptr0TfT4aFydCqeLr1IXWaVMPEruAgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_12,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290106
X-Proofpoint-ORIG-GUID: Hq3_TZajzDj-oAz8xJ5OHfijb4A9We3i
X-Proofpoint-GUID: Hq3_TZajzDj-oAz8xJ5OHfijb4A9We3i

On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
> On 29.11.24 13:55, Lorenzo Stoakes wrote:
> > On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
> > > On 29.11.24 13:26, Peter Zijlstra wrote:
> > > > On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> > > >
> > > > > Well, I think we simply will want vm_insert_pages_prot() that stops treating
> > > > > these things like folios :) . *likely*  we'd want a distinct memdesc/type.
> > > > >
> > > > > We could start that work right now by making some user (iouring,
> > > > > ring_buffer) set a new page->_type, and checking that in
> > > > > vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> > > > > and the mapcount.
> > > > >
> > > > > Because then, we can just make all the relevant drivers set the type, refuse
> > > > > in vm_insert_pages_prot() anything that doesn't have the type set, and
> > > > > refuse in vm_normal_page() any pages with this memdesc.
> > > > >
> > > > > Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> > > > > these things will stop working, I hope that is not a problem.
> > > >
> > > > Well... perf-tool likes to call write() upon these pages in order to
> > > > write out the data from the mmap() into a file.
> >
> > I'm confused about what you mean, write() using the fd should work fine, how
> > would they interact with the mmap? I mean be making a silly mistake here
>
> write() to file from the mmap()'ed address range to *some* file.
>

Yeah sorry my brain melted down briefly, for some reason was thinking of read()
writing into the buffer...

> This will GUP the pages you inserted.
>
> GUP does not work on PFNMAP.

Well it _does_ if struct page **pages is set to NULL :)

Anyway let me go try this and see what happens...

>
> --
> Cheers,
>
> David / dhildenb
>
