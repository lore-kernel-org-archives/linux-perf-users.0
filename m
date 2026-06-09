Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904836EAB0;
	Tue,  9 Jun 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986980; cv=fail; b=bQ2yxrK6mEw2tGKr5c0wdb30qoZtYCCvbkEt+x6mqSF4tHFBtZLocnFKvUOFU85wDJr9nx4bhudVoo/IYMq9R6VUOvRf9+hgCPCulShNUbuOZb4q4LphUaEaphHtWrMdSc8L8xeuvJwWCZMMIK/qdKKlwseQeBp16eRUyCZsIEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986980; c=relaxed/simple;
	bh=wXo+4GV9A3Of21PWQyk/V5GcGtCWYNvmKvhCmfUE6Zk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=myqgyYn8Rju7zgYWqAYy6T9edFrahyIgYurKYY929/esabyZ9gfk5lkKifslcol8PhCzH0NQkyGET8+y7YIGP6aiMpWNvfxKnDU4VLBlUrXFGCp2yuuLh2ibbUAM0qvyaJ6Qs02E5UCIkt+5mpL8VFBIxIfXv+lDWDa3a8h9gI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XguLaDOJ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XguLaDOJ"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65941mxv3963441;
	Mon, 8 Jun 2026 23:36:10 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022122.outbound.protection.outlook.com [40.107.200.122])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8ybn9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 23:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H48YE+ICIKF4Mof4OyJ1pCwuzr3JPGV7X8BsZYpcNxmopn4uYqivZ+oFSCF7roS2zFQURNa/fmYq/GNaQKlp1Rw8xUm2XsWFgdkJHaUobbqWp7M/2Kf1J7GNB6NPeLdrsBJIrk/PuXxzDL589owJveivfv+uCdEp2DtqAT20jC+l8rxcNhdNs6h5gsTFHXUTvpzInGJwG/GiQeALDOzkMYJzlCtsfE6t6NcuHgc6mZmwvu7rHtg507+eyP5GjG9cZmOfImJv35xd8dfrbtGXLwTZSZI2Veeow/NDvontEia7Z1zIUYcmRPU6n7/J3jgA/rz0wJhH3PvuyH3vIou1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgEbWah4UMJyGiyB1vdvYbOtfFLdvL6a30SUEJQSz08=;
 b=zEJiu3q/CjvvlKrDBCBYoZxdtd7UxbGjpMAtUD2jlvVNT3Spog3zsKN56oKs0KN5dxjzmQa0D8exbtoFGvJctdKlsKkBKdS+iWXeR3OrvEc4/siVK8LYOnjKVQ6c0Jekr991XELXRzoHAvfqPJ4DvOAFTaHx9NDAFZMtZb7gRPDXsSLtsKwxjHenn1qWz7OIgvC1ez3F1BLHta3q5E3d/MrThpOd7eU7oJTQFdlK5vPlGBRz5P3/reeMUU+doxykZ+Kn7BSU5HtUEJ5uZAry4VKif/kW7ANqSNRAn4FQ50NKiuAuM6j05mboe+i1Oua9cChaBF25mceaeoy2YYiQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgEbWah4UMJyGiyB1vdvYbOtfFLdvL6a30SUEJQSz08=;
 b=XguLaDOJNI2rVsMlDMKne6AYjC8ciCckT2U77j0iw3zhBB8kG0gmX5FdMhSSjoaPf2yJgL2jyYlt2tBxUdfLY276JGXA+cIcIBviNZ05JPouKYMbBDyM1KyeXkE12lzIHMV6opcrgpuDWJsSiEm4Hay3Bf3fUHPmRrEf8h9UI9s=
Received: from BN9PR18MB4347.namprd18.prod.outlook.com (2603:10b6:408:100::16)
 by MW4PR18MB5034.namprd18.prod.outlook.com (2603:10b6:303:1b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:36:07 +0000
Received: from BN9PR18MB4347.namprd18.prod.outlook.com
 ([fe80::6f35:8bfd:66d9:a66f]) by BN9PR18MB4347.namprd18.prod.outlook.com
 ([fe80::6f35:8bfd:66d9:a66f%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:36:07 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 3/3] dt-bindings: perf: marvell: Extend
 CN10K TAD PMU binding for CN20K
Thread-Topic: [EXTERNAL] Re: [PATCH 3/3] dt-bindings: perf: marvell: Extend
 CN10K TAD PMU binding for CN20K
Thread-Index: AQHc9nxVKpFHfClCgE2HIk2me1XzLbY07UUAgADWIEA=
Date: Tue, 9 Jun 2026 06:36:07 +0000
Message-ID:
 <BN9PR18MB4347AC88595BFFEF11EA503BCD1D2@BN9PR18MB4347.namprd18.prod.outlook.com>
References: <20260607125101.17778-1-gakula@marvell.com>
 <20260607125101.17778-4-gakula@marvell.com>
 <20260608-spiral-unsterile-66189c3241f8@spud>
In-Reply-To: <20260608-spiral-unsterile-66189c3241f8@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4347:EE_|MW4PR18MB5034:EE_
x-ms-office365-filtering-correlation-id: 466be811-1a7f-4201-2553-08dec5f16333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|6133799003|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 lvQ1c/gtzuAO4RHvIE2R1yLOypkcEfx28eTDnHiAqbFvaT9LsPBfsWt0T3ZhNSPhhaQwHzRGyM/cCfwUU/La5vJgq0/BCwBhIK9IS3yKV1V9NlvbUSY105exzCnOidiXigThh7atYcbLQifrAaaZhX2C5VgEmey8MyVtqO/85pA7K5CYwOKu2ic5DaDbTjuQoRax7QIIqLRJm91nQyQsrNh/kULn8PHVU0pFo7Iv+uxdK+z1nph+luIQSc2JMpF7bbKE0QR3v6pWg/DlF3DVHCnfmCMS5OYhTUqGYGNuLLo432tmt51oHBgvqf07/6RsG84AI1FMzRTAxy7atnktJ/cBUeCp1wgO7M3RDmIAKXiBcXKd71Ly6wM3AX2GVqcPSv7jIBaYjTFpLcEWNJuRRKFuy97l6h4GKihPMo6MCeMLeLFQf4oe/Q10u82IgaeoDzD6lyxyGcHWTqoCwsgyFkrYBion78H3sv4QLgCapPOWGMNk8BiuoRH5X7+svPBHjBy/sDy7mRGWOXPDga1FiQEL0hjBQjT6Qou6igtAOZ1PUttiggm3nnRNbqXJe0XA+TRmZRt1xQ3ajxCu0D6h1RlC51MsQ/eExP1DFbwm027HhcWb7sOBsWiJF/Xgqxh/mEKyr979VrEmi56oZm5GagUgqxGR7Lys+f5g4O+CQ2A1f9i3zQbkrA5KrsGygRU8qn78piqocd2mnPV0LVnm4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4347.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MKqxkFU8SAe9Bky5lBVIiMJGhhM7KFlq80+ctYIaVksSTD7Kj3nDmrQR0czS?=
 =?us-ascii?Q?ERdohvNVZQRlmzVDUg68pHsCK4TiKGPrY0vZTqSMna7zZB5MMQ9cleoLgUzo?=
 =?us-ascii?Q?ap7cz46Kk3x+kElVnHQYT1wdIC9ZvwJajxxZkbEIyTNPLQvLKG5C3JLR4wtr?=
 =?us-ascii?Q?2gWh084YbDFgWFbPPphaOoZYX3xtXNbvJMsacP3WY4n24TpCoBbMkbIqPpE/?=
 =?us-ascii?Q?pkX68UsVnARQBOi5o9QtyDFpEpkUf9KzpQCUIggSX95EzkW4Q4pNPh8/h3wc?=
 =?us-ascii?Q?Tl1p3zjfVigkGfZltZcMeDMbGKwGjbFNO8fOkloAMjjw9pOR4BHnlZy3+VIE?=
 =?us-ascii?Q?cdQvz5mloQaTzvV7uDyA6Yex3fOQfB1jMVEzMz2yAhgWtO32G7rD0q3vKR/j?=
 =?us-ascii?Q?cogu5e2/SjyFh3SsxbccjwbRe8W++teiBLa+L0re1Rj1Vr5n01aX4zLpGIX9?=
 =?us-ascii?Q?V6VuzUwUDlgirEfeGe1mhrWD3uJPWskg4T8A/qgl4R3jZk2oZwBMEcdAFb7e?=
 =?us-ascii?Q?5Tgz25bER04B/5m68RskGGnd9EIow66XdVIiMU1IF5zkToyJoPrZ0e9MG3la?=
 =?us-ascii?Q?rM5WupxzFX6OdFDF8KUKRMgTS+S9jrKNLCjyqh5wFuA6e3FgFbximrfouDmV?=
 =?us-ascii?Q?tnvTgQC+hO/6DtLsxViEWqHr3EubgvWpWhlvHUbAR/V72XDA71ejse0DJ6lo?=
 =?us-ascii?Q?KqO4pREWVrm88gD5PswljotDUMXeLjHIxgvJleUhk6VA3rebj73NAu43uhIE?=
 =?us-ascii?Q?YcFi8zDnRECbUeyUvBFoJyjlwQLl63SmoZns2kqeDjxrRS4Nz4z7KDsKvbF6?=
 =?us-ascii?Q?47Jn7j9ra0an08FgCOaVmHoDGfq7zz2VNsUITjmtvwksOrqiq2+5yzIv5sFN?=
 =?us-ascii?Q?zMcZkiNsi9X0UcbA5AJ/4fdQIgzf6uWegSxqShTsn6Qt2bnSkDDdTVLaVh7d?=
 =?us-ascii?Q?SuERcpw6UgLtO9ynwukn5loQ5MqMUK0KlssyhhAUrMvx3AdMA5vYjrUd2u6u?=
 =?us-ascii?Q?J7ZRqQmFtTQJ7Hl0mooe19PFDGXm3NeS02feCfLbwyyQHK2+UswlxbIL77YJ?=
 =?us-ascii?Q?dtTXr8y1Zt+TxKgp8RIE7wwY659sZ4Uwv3MNa8VpOET+NP0QVKYtk+efBkE4?=
 =?us-ascii?Q?3NgxE2+aUywZOb56Gk3DbafOL6bWR4Szlr4tcQcXUYVPykRYZOynfBeCfn8g?=
 =?us-ascii?Q?P4ER0c4UKPupsvH/e22o6EK/+40/Gkm9oWd3iWQcxj+ZTz1R75XL4qTVoeAf?=
 =?us-ascii?Q?BiJXN5i57jrcIH72D4EtTTbpLqNRG5JIwKO829V+6JGQQfV2LUgsxB+bv6es?=
 =?us-ascii?Q?4VYxK+FsGQV1l4Hj6W+bOqHW9yGjJMPsljPbeGdoaV2KZNI2XROhhepM5mDT?=
 =?us-ascii?Q?ZwqY8MpLtIPu6yEckBxhAlDnYvyWp4P+3Ilv1pHqyqwnMdBAtSWH0+nrI3Bd?=
 =?us-ascii?Q?+yYGq/jIf0mTb5ptu8AaCH6A2Ly1wNThjPeg+IKyWMu4a8NGELxGTTCVcbTQ?=
 =?us-ascii?Q?vjSsXwcWDmw4dtkXyg6Cye9RR67fS+0zEukBO9sgRUWKCV35p54IHjLJrwEa?=
 =?us-ascii?Q?av9dR2ihknnHQ3AkG7aFcBSB1o8UnlMuJjRXDTYtvHL2SH6vgTZ6GfOR4Kp+?=
 =?us-ascii?Q?RYm9dF++NHjGL1idG2jeOYnaNaTn7vhiSKgapdVpjlDMA6ZQEEHjPHY7Lc2g?=
 =?us-ascii?Q?4Ib9YpoaU96LtZbms4N6CkuHmegiKgCRmOph80mqaTOXZvMN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O5dNo67QPiRWVHPWDBeIeoat90hmxN5E0gBy25kQDQO1eZeL8Hvpn717uTbYkBkZHYhpAgLSP0fFDO9310lGEr1gNgveGgCjTbK2X9+Z3/8L/WK1HSp4ES8YVU+fV6TvnxWm43/FTLeNhT4BJtYU8uNMNUpvwVyRrwuOGjBxINsGdsTgHPTsL/Tw7WoQ7iAOCQGVvrpsDOcD9v11NMK+bv74284YXdXxkeR6c0h1sp/bTar8F19KeAB05keEvbvhv9+lBzuw2yDPjxayLy8dsHiJdQOXzWcrru7AE6B9qb27BDYDXiD3oQ2y/fPTwt3yhX1SJkgEucXvd3T6mD5x8w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4347.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466be811-1a7f-4201-2553-08dec5f16333
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 06:36:07.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KPUTiZVWOJOLyAnQWxCFgQ9wTGXtRG5JHbdtIBbDqQvB3cwkGxCXdlIgbucx2PeSLHP0CueRh901dWb7DENQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MCBTYWx0ZWRfX0+EM1pDiSz9Q
 TcRdIWTKZCiPd9GKuPHZtdU4VQeKur+ij+PCOn5AZs7PabRs1lLVBuVzKfCyq6wY4dZpp3ibd9y
 7A5pjts2Lnl1MSRgLj3PJ1OGZo1DI3Q8HNZdKi79IoUXsY2Tb1R7yf1hSH9TqTU1C29LIcy+ueJ
 sI+mI9vc+E4+WjTpRWHx0fyHDr96NxDE0CGCu4fgvDz7hl5MU0pY+U5A5BUaMx2+8clocSthIea
 vpCjHhg4UA3X9tL0u8/2Ms4ES4te4Txr4TGsv/JUCk2zpYBEFbMi7GM+BJABuXiXq+Iq+HfwBBx
 vVY6376hjCjO1XsflBSKIPCWmYU56qmfxyC6M/5sCm4U/t/IOjclDNOkeXJPw1x6osCLGihHQKb
 AYjjwJbVWf4ZEJRAzMjcQMKreUrvw1wSgLEWbDuCIlXGGAcjJ/Fu5WI+fVM6Ki8cldicAynxMF6
 nDDWR/LcLrV+IEoHKOA==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a27b45a cx=c_pps
 a=jsJx5cRpnMcsqjM19+T+dw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=gEfo2CItAAAA:8
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=R-9LmIZp8elx9UndyB4A:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: Al888XJVW6HkGmM-1nRFajrd16GFvPRJ
X-Proofpoint-GUID: Al888XJVW6HkGmM-1nRFajrd16GFvPRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01



>-----Original Message-----
>From: Conor Dooley <conor@kernel.org>
>Sent: Monday, June 8, 2026 11:05 PM
>To: Geethasowjanya Akula <gakula@marvell.com>
>Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; linux-=
arm-
>kernel@lists.infradead.org; devicetree@vger.kernel.org;
>mark.rutland@arm.com; will@kernel.org; krzk+dt@kernel.org
>Subject: [EXTERNAL] Re: [PATCH 3/3] dt-bindings: perf: marvell: Extend CN1=
0K
>TAD PMU binding for CN20K
>
>On Sun, Jun 07, 2026 at 06:21:01PM +0530, Geetha sowjanya wrote:
>> Allow marvell,cn20k-tad-pmu alongside marvell,cn10k-tad-pmu, document
>> CN20K in the title and description, add a maintainer, and include a
>> CN20K example node with the same required properties as CN10K.
>
>This is great and all, but is evident from the diff (other than the fact i=
t talks
>about an example that does not exist).
>What is missing is an explanation of why a fallback comaptible is not usab=
le.

CN20K requires a distinct compatible because the PFC/PRF register offsets r=
elative to each TAD base differ from CN10K, and these offsets are not descr=
ibed via DT properties.
In addition, CN20K introduces new events that are not supported on CN10K.
Due to these differences, using marvell,cn10k-tad-pmu as a fallback would r=
esult in incorrect configuration.
I will update the commit message in the next revision to clarify this.

Thanks,
Geetha
>pw-bot: changes-requested
>
>Thanks,
>Conor.
>
>>
>> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>> ---
>>  .../bindings/perf/marvell-cn10k-tad.yaml      | 20 +++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
>> b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
>> index 362142252667..1612052b59ae 100644
>> --- a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
>> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
>> @@ -4,23 +4,27 @@
>>  $id: http://devicetree.org/schemas/perf/marvell-cn10k-tad.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>> -title: Marvell CN10K LLC-TAD performance monitor
>> +title: Marvell CN10K / CN20K LLC-TAD performance monitor
>>
>>  maintainers:
>>    - Bhaskara Budiredla <bbudiredla@marvell.com>
>> +  - Geetha sowjanya <gakula@marvell.com>
>>
>>  description: |
>> -  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
>> -  shared on-chip last level cache (LLC). The tad pmu measures the
>> -  performance of last-level cache. Each tad pmu supports up to eight
>> -  counters.
>> +  The Tag-and-Data units (TADs) maintain coherence and contain the
>> + shared on-chip last level cache (LLC) on Marvell CN10K and CN20K SoCs.
>> +  The TAD PMU measures last-level cache performance. Each TAD PMU
>> + supports up to eight counters.
>>
>> -  The DT setup comprises of number of tad blocks, the sizes of pmu
>> -  regions, tad blocks and overall base address of the HW.
>> +  The DT setup describes the number of TAD blocks, the sizes of PMU
>> + regions and TAD pages, and the overall MMIO base of the hardware.
>>
>>  properties:
>>    compatible:
>> -    const: marvell,cn10k-tad-pmu
>> +    items:
>> +      - enum:
>> +          - marvell,cn10k-tad-pmu
>> +          - marvell,cn20k-tad-pmu
>>
>>    reg:
>>      maxItems: 1
>> --
>> 2.25.1
>>
>>
