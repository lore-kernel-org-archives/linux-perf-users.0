Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.149.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793653922;
	b=wy0n2ZvSTigf2mEWVePkhgFe4uMxSqrEAwX3XSxd2e7z0DR/FlBAWMpZKkhtimg9mKed
	 rZOL/816D3DCJrVKCjcJGzl5+xeiq2av+r0vhCPNjdzr/ugXMWoTcuyDy2M/SR8Zc3Ld+
	 ZA1/jzvXjyOnZ+aOp4pm6UCTNFDOZRdprjLvh4XaqPhjMBrjbvNULfjLtCFx6J/P4/ehV
	 cqufLDpabpRqNOWAafPiMvxPMz8saTm01QwpQuLMly2wsnqfaY4J7CeKxJVBKfX7G86oV
	 tsZG69tnoXBuuzH0cdI5D6rHH3TDx91OGz9GAk6PK0DQ0c4qKp0G3jhFl0klx715OlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653922;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:x-exchange-routingpolicychecked:
	 x-ms-exchange-crosstenant-authas:x-ms-exchange-crosstenant-authsource:
	 x-ms-exchange-crosstenant-network-message-id:
	 x-ms-exchange-crosstenant-originalarrivaltime:
	 x-ms-exchange-crosstenant-fromentityheader:
	 x-ms-exchange-crosstenant-id:x-ms-exchange-crosstenant-mailboxtype:
	 x-ms-exchange-crosstenant-userprincipalname:
	 x-ms-exchange-transport-crosstenantheadersstamped:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9gRkDAR4P745xdOdqlNq6LnLO97jRROQjqKP4sjMyi8=;
	b=qEYiagPV4dxwhKJiD+jIqm5EUzWiVvTeOX5umoOAJt1wz7GfTFJ3X7A2DXvspM4Hbwps
	 buOr2ZtIrYqPCApiaaHKZ/AcXSe/V1UOpxWAEspOlUscWXFsITDcvbtAG2Z6VbzNNgtYy
	 Bt+z6dRGZ1EXbv634XMMP7FLPUPDhCs+ahz101W7vG0J59Y+LoiPC6mUZpW1t4nXw+87h
	 dBCx0UYN637LQi1w6K/dmTY5zXTYUHNVKDigEtWRMyaeZMbdp+tuEuKia45p7E3R0/H3m
	 7m40YAARHn61EC5GQ7cSQSC2IO3IYzWLkwzQwpJ+s1wClQtbv8qmp3gZLl0+lguWj+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=akamai.com;
	spf=pass smtp.mailfrom=akamai.com;
	dkim=pass header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b=Z2GOV3mW;
	arc=fail smtp.remote-ip=67.231.149.131
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56394606D837;
	Mon,  2 Nov 2026 21:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56394606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b=Z2GOV3mW
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2IWvZV1423830;
	Mon, 2 Nov 2026 21:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=apr2026.eng;
	 bh=9gRkDAR4P745xdOdqlNq6LnLO97jRROQjqKP4sjMyi8=; b=Z2GOV3mWMPlI
	33BFUSl/b/Z/u+sl7VCsjZL4/m3DKw/tVTtqw3DXoD+V2mZytw5y7qWHaiDD1mbp
	G6dxjSpnWLFQZbmtFfBbBYcSYpYZl9TMMLMKwgRWTmGqDPkI8abz/BGvDqzM0wnM
	o0p+5z/+Sa5S7/4wDVLtc6zwnzPCXyhzX5pYEohyk+bJdnNJPNkQ08T60TwDmhZZ
	UJYoU2/IHFZykqcnCLE9dP+CNEe3cKhjz+65xovb52v8KWpfeaAkUD/Myss1hCID
	T7VrH38csuWCji9JPii+x3dweTT1W6SIMdEzuAT8vUHsmbFQXFV9zewDTtts8bK/
	KvrEZzilNw==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4hpyw59d1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 21:11:22 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 6A2L39ii017549;
	Mon, 2 Nov 2026 16:11:21 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4hnbnty2g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 16:11:21 -0500 (EST)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 2 Nov 2026 13:11:20 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 2 Nov 2026 13:11:20 -0800
Received: from CO1PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 2 Nov 2026 15:11:20 -0600
Received: from MN2PR17MB3311.namprd17.prod.outlook.com (2603:10b6:208:136::19)
 by IA3PR17MB546087.namprd17.prod.outlook.com (2603:10b6:208:60e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:19 +0000
Received: from MN2PR17MB3311.namprd17.prod.outlook.com
 ([fe80::3af9:49e5:e04:1b1e]) by MN2PR17MB3311.namprd17.prod.outlook.com
 ([fe80::3af9:49e5:e04:1b1e%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:11:19 +0000
From: "Lefkowitz, Jacob" <jlefkowi@akamai.com>
To: Ian Rogers <irogers@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
	<james.clark@linaro.org>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Chaney, Ben" <bchaney@akamai.com>,
        "Pelland,
 Matt" <mpelland@akamai.com>
Subject: Re: [PATCH 0/2] perf jevents: Add IOMMU PTW & device entry metrics
Thread-Topic: [PATCH 0/2] perf jevents: Add IOMMU PTW & device entry metrics
Thread-Index: AQHdZ9iUvzKHn7cTZkC+w6l9JTKu1LcU9AUAgAZWzt8=
Date: Mon, 2 Nov 2026 21:11:18 +0000
Message-ID: <MN2PR17MB3311B8E5114EAF3B0F25FA76A46A2@MN2PR17MB3311.namprd17.prod.outlook.com>
References: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
 <CAP-5=fU=rb5f0X0ArWj3JRZDwrwM2Q341RPG-UJmYX2tUSpUbw@mail.gmail.com>
In-Reply-To: <CAP-5=fU=rb5f0X0ArWj3JRZDwrwM2Q341RPG-UJmYX2tUSpUbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=akamai.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR17MB3311:EE_|IA3PR17MB546087:EE_
x-ms-office365-filtering-correlation-id: 0e0b8faa-26de-41e9-f81f-08df3925d6d1
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261102123227099003|38070700021|261021121427099003|4143699003|56012099006|261009223027099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 2mSqj61oPfdkXmaU2NTgaosWD68N1jkS+dRj7aAdE+kMVsu9a2lNMLyRbuu9+TQRAHEvYwzwjNDzddLdFfiJ/L7Ssb24HbLJQy9fzgNZvHQNLqFBw/8ni/gtr5Joew8Y82am7mY3TQCf/AydWQjw+6bcF4eaWLAUqxHpWWBTtpxHd1m6Ndz8BShHSDkW+i1lVKiYGxZJhdEVBQiehG0427ZIYCpEnCl7dXpnNECmfgBS/H66tuBMhgacQT0jgKsNJQAFG4OR1Dt0cm7NoFrBjVN2itxfrcoUa2hlb/W7VeN6McrIGKcDTnd3kj9161ZIQ/ZWkBaVG4en8qHNrPfPSct/EnyGOfLeeI6rXL6sAAkuuhM9mJYZUrglzo9DIdiAWKDhpq0rnN5LjArCZVlOvg2BH5mpx/WhUd5YVZLkIk3lmvXY+0+mkWhYZeN2KinDTbUYpYX7iKhIotH7xrBTXVx16VevX2q7Ib3PBaYeBm12bfgoDiXzCYlmEXf1sliiV9zJXJhULoyq1FsG2YbEkgfvnv5im1jQaYRZpcYtWCJCYijgFpHcL5LssyWsm/NMkYoFg3DfxVfdoE3ZhDjOuwxXo0bxIScsTJomdrDKaHrQZT651jLPhx/ws2mELPmBQ4h4b9tyu/SBsG+lYzgn6eseyLajcgtuVe750Yxklr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR17MB3311.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261102123227099003)(38070700021)(261021121427099003)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1nsxxcI90b1pSnl2cnePH9HaSwm3H63SibdSQT3Eicvw+5d901WRxylIfO?=
 =?iso-8859-1?Q?8kts8CXb/wh7RuRuaoUZ+qDZzgeLgwk4jn92SdOIF2wes0ZnjnvFD3B3NM?=
 =?iso-8859-1?Q?D68w3/Qy3dcZC9iegs3RI1wb9XZjdysewwnAciy4XZb27Vgx6aYqPVh4J2?=
 =?iso-8859-1?Q?kJqM3C+N4vtFDg1AwnCARzggVCa4X4MO54heA/wl05uQ0a+6GquDJCYir4?=
 =?iso-8859-1?Q?jUcwr1Cb49k005kFrmya1E2vP74Rj67AYtgT9G5HOmM7ZTES4JRw/HLKoL?=
 =?iso-8859-1?Q?Nz6SxxIwC8ULwReVxZnNLZOtl5GEEFu3gUaTo3OQS8mxzWRJax3mzyvFcC?=
 =?iso-8859-1?Q?xxnq+fXRkP2Yw1y4Zl9NIydVYQe4uIhmqCNJzGOmjphatLlZHg2Q+Wxbqo?=
 =?iso-8859-1?Q?76Fd7NhYwuNEh6K9LuFJyely41/jGajC1Z08fEZPJmf1sh/9xgPznXqQce?=
 =?iso-8859-1?Q?AheU6t5oAqjDORwb3WSau9jg9i7BUs68Vzt4frAEIvXl6aQDHaOEO3OVvx?=
 =?iso-8859-1?Q?4cea7lHTNlA0vEUZO1LOHMUi2pOUIQS6cwissLVyzECjK8l9vtBZKi+eva?=
 =?iso-8859-1?Q?dP2NP35FOvjMCUvXpqPAsoRMp+nhs9pfxMXnDYFmPoQ/2ud5+hyA4c/qDS?=
 =?iso-8859-1?Q?7YChQYER0DfyDHIhf/0AITEC+q/edEQtPXx/ApfADkq8WUc5rrUHnw3GYs?=
 =?iso-8859-1?Q?2hSda1/9p4YKeocNJER3k14osX8blWyjWl6XfZSsEskF4Cf5XEyJB+ZQ0M?=
 =?iso-8859-1?Q?es2L6fkFNoJR1jjtp163nTNZfem4Hpt9cjRT3lyGJaTgym8B1MxVot8O1l?=
 =?iso-8859-1?Q?pNlrNum5ufuOV3jTXKqSiYrfgZg2BTs3gekdR8kzX4dmO7nJWWFDC2Y+22?=
 =?iso-8859-1?Q?gTNwwzzUJQP1sqvyqG5ppbOIXI5qQkoOfrHxdnKPJSC8GynRnOresrxm0p?=
 =?iso-8859-1?Q?Jpd8l3Apo/9TtdE54EQfO9rqLmYsYM/ufkCOd9brmEONTtvPCA934PnNdK?=
 =?iso-8859-1?Q?Ry9nfYkXGqicY6u2bGbPxbR/5jHaIksJAfhOJ5UsnpN78YTtLcxJvKQm2Z?=
 =?iso-8859-1?Q?oRC2vidT6nwyXPmTott6JPJXoJi4TQu2sKQdme+pbiVGwUjxOyaW+ziajc?=
 =?iso-8859-1?Q?p96SzMC0A+qxcT43md0lLQa2lpGPkGip2ucDSkTOERErccW/IwuBDBqiiB?=
 =?iso-8859-1?Q?KkmHGeZRQ4Wna04THO+NDWG1zz8mOhFPimjENyiLWtsZXuwMwWui1MHOxm?=
 =?iso-8859-1?Q?mq80NEF3SUaGbudcj4knhV1eilIQP6dUsaYTw+owyjgL/bpj2vAjQmz9bQ?=
 =?iso-8859-1?Q?vu4qJlzOoLzO7rWqYovCLrk0Obzz68uA+MucPcZNLG71Hz8JzUyUnBsNwd?=
 =?iso-8859-1?Q?ZjrrmQiqSgQVjKGkzZOu4463JLEEIme+vf2TxLfIcjVQDjuT0DnnRB9DBp?=
 =?iso-8859-1?Q?+P9ugAGsu5lCypG3X4k4bUAjfTK9b+M3z4xA6aBm1m6sbUAIYLwISj7gHm?=
 =?iso-8859-1?Q?lKupI9v+RBLOPcQbwBBIQlJX7ufueyG85ihYdR5rLI2TRHd7WE5gIYNNgh?=
 =?iso-8859-1?Q?F+UY8PvH6mlkGWPTM2M0LKYQjovnsu/I5MRi7Eierig61ViXGN+eVM1CtP?=
 =?iso-8859-1?Q?NyThQPBdUwdLwl0h2B7aAGBm+L0EJrx2lltyrBlNx5Q6ij07WxFUAWQOrW?=
 =?iso-8859-1?Q?4TsdrHreHOr0tiU5wVcFgR1fLuRqqFlW3En4h0KzhOfggfQC5i3StfcC6u?=
 =?iso-8859-1?Q?tLMrsM9wtllt3KEoH/IOSeup/3Wgnp1cSq768Fi/XzMs3l?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=firl4/yboVm3bhKq1ISO9Yoyb2szo0/S9L3WoUgasjSTgTUjV0ajVnLlETRKOp2C0X+ic0S+mz0lIX0zXMdi7XEabOk9ve16AY+lRfiLPRVDstIx1EkkAxkI163zPfCXdpspL2Eq9cFGEAofGjx4ZtzFL8T1TLakluZatOUmrcHgMxiS5tJXD1cWkH7+egKrqaZ2ZnKFM0FXRW4VlPnAG7ZxsI5INPWZDAM4M/hf5sl08RXK3bCgk1JjWh8oY9+CMkZnvf8VvV5kID3rlKB+Vt0awvwwtqO328wewmreYGNebIecMMEm+WlZWYS5NLLfmiiVmbeBKtMvaomIS+wbWw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6E7SvqtPUMs3YDGafmSZoj9nrU7ilECkt33ehhv+yk=;
 b=AE+eoU7tpFuQO33GdQ8ARoQU6snC9ldzRudwKIBzIOx6qgUa9qaJzIMam/uLgBQTW5TJ3fLnkYtcH+LYjEN/ySW3bKymHzYbQfGeckBmzPBGFYOhV0n0sRx+M7ewLRIcEloiIj/DmAvGF92OYV0w39m0VDcKBNPien+dPHerje/cj9Bm7gGsBGLokiW+gREGEz+Q0laVMQQ0t3XiEpWjG/HSRNAJK0OJCJegHFqet+4F2i3AcENLNjUA5Wf2z0Pt187Lhd/aBoQRAtcllJdAk5Mylikqs5RuX3sgA4tfwLXrKrq/tPwTLNvN5S8eE6HsXVlqaBOiRGaYSGjgL0fgGw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: bgST4xJZLsGYAdI77YNXuXa2lrSzdkIlxGk1P+2Pt8k3eJauqkg67tQZyVIaZx+s0UQUKBr050SsMLTyzmWeWDnZx3uXFCpKA4YBv+S1JngUex+9j5UWZb3Wae6pNG71iHhLM/6u1EoNht72lvxSZQJzZkBByp0Imhz9bpWwVZo3t8tJjnxrwcQ6W5/zq+7T/F7Bn41xImMezYzewMSuekeQVKIptM4aWX6uymWBR8vK6pxHzCSog0l2L545++bC5DofMzPRIzXWHR/cbDiciQfIF02SjYbsXzuyJvcmhENvuB6iiPKK4Z/DdvGEOya83MYMbsaisf/FNTjKGXynsg==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MN2PR17MB3311.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 0e0b8faa-26de-41e9-f81f-08df3925d6d1
x-ms-exchange-crosstenant-originalarrivaltime: 02 Nov 2026 21:11:19.0059 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: O+xL8iTqpP+pCJ9MukPpSE1DAlGhXhzT+Yoz1bwyzdRbcuo1zadFo800bKSLwUulvkCiwZd7+EHoCOyc0oZn+Q==
x-ms-exchange-transport-crosstenantheadersstamped: IA3PR17MB546087
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2610300000
 definitions=main-2611020083
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NCBTYWx0ZWRfX+qb+ymp0AiJ1
 +3yCTnlkq+hEHoVYhUU9uhtx6dMFtSFbNdIB/eyeXVcAJ9Tog1CXp/cGa7GNDG1y7gPJxSxqI8e
 Jgaqk58LqEqzcAvMQJSLyYZgtPQTsZc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NCBTYWx0ZWRfX49+HvEf+Wk0R
 Oi7mqCXi9xfHGxG/MEYaPyI+0gs79bWHf44xvBNPXl2k9dTPYd3kp3/RB0DWrVqNeG8VOUykwyG
 zXzNA/+9pWOOZ5pkmeb7UIp6vJ1EeifQTUW30pBnuE1NqfMgW2kXptlanbdeLGhObbXqU74czPz
 s4IJ0PiWvWHwXLOov8xN2Kfy5qGxkGqhniaMB+Vc6PiO4e142ZsOhfCpn1UlifkI8lAhBCD7Gud
 7vyXGPca27T4lbw6BOiYWRsYHVAi+HkE5sySslj3ZrLd0tN2UfTxpSwNzy/B1Oi4b0UXz/t2GEJ
 ZSxwctC4gycAf4Ec7GQgdqljJ8gV83xCG0WfdIQ6dc9cVzLStlzsKCPAwjbnl9VneUvoEdHS5r8
 dRrrIAO3d7Vj3TGHFtBGtmpO8HbEOH3edvoZjRW4A04utUWLiwyxK1cVZgXUbMMau5AvfMuG795
 uRdgs246CVgB6fwO0UA==
X-Proofpoint-ORIG-GUID: -o9H0NdFSDkqcf97kXkjkWzoea0K2n-X
X-Authority-Analysis: v=2.4 cv=ZJ1CCn7b c=1 sm=1 tr=0 ts=6ae8fc7a cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=5uIk5skAYop0meUMGpPt:22 a=VwQbUJbxAAAA:8 a=n-XPC6oxVOClqLEJTiIA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: -o9H0NdFSDkqcf97kXkjkWzoea0K2n-X
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020084

On 10/29/26 16:12, Ian Rogers wrote:
>On Thu, Oct 29, 2026 at 12:06 PM Jacob Lefkowitz via B4 Relay
< >devnull+jlefkowi.akamai.com@kernel.org> wrote:
>> They have been tested with a benchmark C program that
>> purposefully thrashed the TLB as well as with 'sleep 10'; both of
>> which work as expected.
>
>Cool, perhaps consider contributing them as test workloads:
>https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools next.g=
it/tree/tools/perf/tests/workloads

Thanks for the suggestion! After reviewing the workload I wrote, I
realized it thrashes the CPU TLB rather than the IOMMU TLB, since it
doesn't perform any device-side DMA, so it doesn't actually exercise
these metrics in the way I thought it did.

For now, I will leave this series as is. Down the line I may write a worklo=
ad that
thrashes the IOMMU TLB (likely implementing fio-like functionality in C) so=
 perf
has a proper IOMMU workload; if I do, I'll send it as a separate patch.

Thanks,
Jacob
