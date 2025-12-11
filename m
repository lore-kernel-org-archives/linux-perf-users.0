Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219028690;
	Thu, 11 Dec 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765415612; cv=fail; b=ngiF7HPLqdFgObux4nbK+B3gNqnMRLGyaKo9WlnN2mPI9wNtqiHzPmKQChcuAPvA25Kd/I/H2yJT11Dto4M042SBcWFF52GrWnNvp9fSJFJYl2B1Woa/C3BdGv+pKoAXu3UqTU/DmFcSSWesY3levZKvGRXq/eHH0dqtfWrUNx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765415612; c=relaxed/simple;
	bh=+hD08BapGrJk6NAIcjIE/2S78G8cvlx3R8CpJC9tt/o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/W0ze9M1kvUuXxcaKMLaSjZc6t48tb1I2vhb/pFztA0ZDs1Kcfcxj/I6FyA7k98vshHyjkHvrtx4Tstnp1oZyn9O0HE0i3GGu2CAOdVoo0Mqx3R589F+X+z+kEgQ2+qgi85T10ncC6HTVo9bF5KrOGBIKGc00mAoEY8yXOPWBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=SUsMS024; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=ap/4z0pb reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="SUsMS024";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="ap/4z0pb"
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB0N1xK3423084;
	Thu, 11 Dec 2025 01:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=uNSX68sjCkx/qB5RXwEThD5QGKcl4CBTbyLMatLxmPY=; b=SUsMS024im16
	8KIyhxdgz8swxWWr7CJr2qdyZ7RQKHbuDJBjKDzjjlomeBrskbqKRNBNb/t0AAnB
	2UYcFPv/2VcWAnftAJWP8t0epQBrGexEJ99aSAsbHzzzIYWYff07et7myvKn0H+H
	kUh35OUBxylBqD8n5dAVjvex5P2L3Omd6Qhc/hhX173BhlReRQhEwWKUsaJXixN7
	2t8+oYX5wbQTuELWtoNhrgGzZFb+xKEXS/edLmL8B317ZakBu5NBESmu15KCZ8w2
	yfEn3QPpSLcdiEPyqru2nvGi7wr5cmAFhTXsdGBTXX7BTu8q6OVTx8xhx/s4UdKn
	YNX61r54VQ==
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4axjx04t2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 01:12:38 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
	by prod-mail-ppoint4.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5BALDRPW011874;
	Wed, 10 Dec 2025 20:12:38 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4avgq1m3m9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 20:12:37 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 17:12:37 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 10 Dec 2025 17:12:37 -0800
Received: from DM2PR0701CU001.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 10 Dec 2025 19:12:37 -0600
Received: from BY3PR17MB5186.namprd17.prod.outlook.com (2603:10b6:a03:3b5::11)
 by CY5PR17MB6047.namprd17.prod.outlook.com (2603:10b6:930:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 01:12:34 +0000
Received: from BY3PR17MB5186.namprd17.prod.outlook.com
 ([fe80::2b1d:9322:c62e:6a19]) by BY3PR17MB5186.namprd17.prod.outlook.com
 ([fe80::2b1d:9322:c62e:6a19%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 01:12:34 +0000
From: "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To: Ian Rogers <irogers@google.com>, Guilherme Amadio <amadio@gentoo.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Adrian
 Hunter" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd
 names
Thread-Topic: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd
 names
Thread-Index: AQHcaGeQjBIAsudOk0WLoshV2AsVAbUbpROk
Date: Thu, 11 Dec 2025 01:12:34 +0000
Message-ID: <BY3PR17MB518624354091DB1B4FB7A7FCA5A1A@BY3PR17MB5186.namprd17.prod.outlook.com>
References: <20251208172339.1445817-1-irogers@google.com>
In-Reply-To: <20251208172339.1445817-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR17MB5186:EE_|CY5PR17MB6047:EE_
x-ms-office365-filtering-correlation-id: 3db7a2a9-21d6-461b-ff93-08de38525df9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ekXfQeLERSQ7uGLgGkFTmSUOghlESH8IoFyphXugqdONaYFbitVer9+uOP?=
 =?iso-8859-1?Q?yLK9r1LoISnqTFk9SagLBAH2tMA3sn75PXwY+6hcr80Wc0zTC5/ZNfcuDO?=
 =?iso-8859-1?Q?UzqA0Yidt8uNDVtv8SJ6CFwVtCoZ6ZxiawG+3xwz+bEwCHpxBAcZt/9Bwd?=
 =?iso-8859-1?Q?07ZRHvYkEre1lQm1iqDstz199UuQg6THfTg0i5NQht8KitFxkVRN+49mpx?=
 =?iso-8859-1?Q?VR8pygLaq8Ive6kZifXLO5k7uJjkrR6SfuCMHmubRQWl+C8mywaW8cbmoR?=
 =?iso-8859-1?Q?9o7YV1Pajm3N11iFB/yUEWMdfwh1eqx5/+dEJzLxkhB2OPZzi4CNt5hyKC?=
 =?iso-8859-1?Q?c9RAMUJpojhUoZS//iojIFKKAHEol8NzY25VXqLEzh08LSNnoLFIlxUuAR?=
 =?iso-8859-1?Q?ki4s9u6J4N2X5vHzzV3sUusleOZ8h5yt+3Zxjj2p4R2cH/hJQckHSSk2oR?=
 =?iso-8859-1?Q?neFni9VPTHf5t3qhgz7yeOwwUCN3894VytuVIaU9gsEwioxAbJkBh8MiuW?=
 =?iso-8859-1?Q?v3bv/zU/4cVtnvlK/nMXuPEAaA2l9DQjHizr2ak9kEDzk9Kdv+IGLT17H5?=
 =?iso-8859-1?Q?qoBFsJucalOpZfs44BU+vZAHtBE+Ghen78zSL84oOYUaBTGs04LIg6c9ew?=
 =?iso-8859-1?Q?dnwv/55oPvTyB2LCcHXVXV66by8Fwff6qcNvwi3Fy/3uLx9kv6aVUwlMrf?=
 =?iso-8859-1?Q?GAQx4xbsYy+64mrPcJvqjz1pkN9FakHI8AlLcSGAmR73xiBbjLPFwtqXXK?=
 =?iso-8859-1?Q?CgT2vhf39S/90vMAu/XYA2z9XE6GiOyM5fcGJsS35rNtWfa/Tig/WhzGj/?=
 =?iso-8859-1?Q?cLmgZR8NoM+drxTYhXeHCw6KEFCv+LYuZlee0Y17aeAgjQLrZBts/4tIWj?=
 =?iso-8859-1?Q?odRG1lLlu5Ii7/YRsssO+mD9Y1qq5U4NFmbDg6+O8bu+HNSSplPxRYxz2x?=
 =?iso-8859-1?Q?bSZ7m2/JvDYI6YLCb0Rvijs9bBsSM6/kRD8SEWkbryRiPUwmr26/igd/8X?=
 =?iso-8859-1?Q?DhCw1FVtamXZ0FA3J8i8zSOdYqTmqGyfBxXylrwCETOV4UNOmGMXGfHikT?=
 =?iso-8859-1?Q?HU9G5gGv2cfZtOrq1aUbVvyCx4dHRWqFsxrImQsjnnQbvkXi4ODT1/6cf/?=
 =?iso-8859-1?Q?i877llrflf7F2GVuusgyIQ8P+QOtVb5N54LStlohQ8Sftxy7o8O2ZVZM4m?=
 =?iso-8859-1?Q?6ChtIctEalQKPE87ebgo4UANngzOajsSWAcor1rRju40RgREDyPm5+3sYu?=
 =?iso-8859-1?Q?1CfUl+agdt5D2WvvLqRhf3chW7iAMBADw+S7oTvbSs4Xh45uLcBMsdEDjA?=
 =?iso-8859-1?Q?1HmnkXKPrgbcxJLUmxgpaGO3Is9HpdQPvUXpfR7zPRascsXtliEMLUVy/S?=
 =?iso-8859-1?Q?LioZPWUVnSvxlN5n+upVbRejRu4ynIOd9p98wsWyeTDa/u6rDfMy2+aX4a?=
 =?iso-8859-1?Q?9Ys4Z1n70EEYIK2FV40bRW676tYtBJ+eGVOiDc9dulTjVBytWZmI5OYzf4?=
 =?iso-8859-1?Q?0+JhBYsbmhVnZvWKcZ2VlMx2yvTlRedEwy9cAkKwDa/AbnA+xSRn3jM+um?=
 =?iso-8859-1?Q?EpPNj7m5ZxGtfOWKTK5b9xysDq6Ta4OhBC/nXhCRiJkbeqtPZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR17MB5186.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rNbuRuFMTT8IvOS1MFpDIn1diITkv0o4Hfbeumq6p1yUs1zET7j+d9QRb8?=
 =?iso-8859-1?Q?LJv8MXSVShhIe2elbcMw1SH+QRW45iQlpZW6EALQVOFrskb+ZmG2ulLBCr?=
 =?iso-8859-1?Q?+C8cdbpcfzGnJAthedWJ3+/9lkk2Wsj1xhVch2XZITF9Yg9B0gTKWFN6Qa?=
 =?iso-8859-1?Q?Mg4+oQUgZqvxVIW14jovs0L36Y+0tdxs5x1ohBANr/VuXFkykewTKK1EtF?=
 =?iso-8859-1?Q?LkPy75BZuDYOLx40JDDq0GaX6NuJ6oFGuFuTXKZkWQTUiZ1rVPXio4FGux?=
 =?iso-8859-1?Q?aWnxqpOfLtvw4u4IpM+hAuNyMlnrP9CTOnqcvw0G0e7ateBnCSTmPTtYuQ?=
 =?iso-8859-1?Q?IAS0RA7NHinTAFkykD+F/qfhfavHKEgJHjBM/uTpPbvak/o/TmXylBFWlK?=
 =?iso-8859-1?Q?ss+wP8znLKeKlLdywYIEKQrqmpQr8s5FdiTgvAaGyQCO6vfnjn4vSWSxQ+?=
 =?iso-8859-1?Q?CJZIJQn0IA99/fA77URtjC/b35I2NAOODAD0950AZA9YVZvCgpEejXvHdc?=
 =?iso-8859-1?Q?GvEkWUV2uSjE53vC2zentkOOawMYuWpAEy4qc1tmCSblvBb+6kacHDIqLC?=
 =?iso-8859-1?Q?SxQKubZ4a23to47h7U8++45CkhHyZDVFTsqMi/vPgp7xXK4x3Ybnif+i9b?=
 =?iso-8859-1?Q?h5iTHqBygveCsEGw3ERXfUvIKmZfFH82jvCnccjEkbSmsfSMupX9pNmkTC?=
 =?iso-8859-1?Q?xiHC83ef2V0lMKW7lolACJlVy4pDsn18nLPvyghDR/W8wp2Tn9CJn4jnMC?=
 =?iso-8859-1?Q?2hwQRIg9gXlOZdIfoL5/txuW+reiOF8TFL6nqUg1HBmEYbxPEVYjk8bRBY?=
 =?iso-8859-1?Q?vd2MYewgl1ZXUkpVxhvrEgSfYR9RrgAX1SKSwuoZdF/HMSzhgsQ6DDmUBt?=
 =?iso-8859-1?Q?fFCbi41gIPXNj0bAIYRgG0qSOAv2izITXRILhBMaphx1E6tVXx7U7qw590?=
 =?iso-8859-1?Q?QB4tGwUwEfBE1I6xL3t3bZ/RWDXoVd2DSqyGDsmcoRq4+drJ7ANyRLBApS?=
 =?iso-8859-1?Q?54NZGnCsdwPIzoHMueboQuvc4jx8gNUashxNtjqdjzEjrtEKY2+5UVCOlT?=
 =?iso-8859-1?Q?rRhaGbjjdT/rHm7/JFsenlpF4SAbmPN2ST2wLGHuxhZwOZpdfsy9jHwNDj?=
 =?iso-8859-1?Q?yNk5TAGydnvt2+1EFO3mSDG6+sWtNsF5SUUteIsS51FJtUCzAjWREk2xZD?=
 =?iso-8859-1?Q?s8haq0NWBUdi1TOU1I7S++Tz7beviZ4fKKQDQMi5KYuUjGoubZvhyoa94o?=
 =?iso-8859-1?Q?6vBCirAM9GGPerG99YnrW+wg+l6pjoAAUR75YLg/eKQKP2OwTHHbSvTy4F?=
 =?iso-8859-1?Q?HqYPjQbt7CEqDY7ijmUSgvDpKPU3vSque3YJ2iTPMfa5Nx722wE7hZ5xeB?=
 =?iso-8859-1?Q?DSGMYYOV7p78PloIt8RJZEZiAlk62CueAz5EMFRs7OobwglUOZchc1JI2I?=
 =?iso-8859-1?Q?FGm1asPHxmk5JmSyEdp8VqQC/msFfIKUqHU8Yf0Pu5eDoNmEJiBaGnI3w0?=
 =?iso-8859-1?Q?WBiXTBvvaRR3HhFdXeLlMicZE9nMK4VHhH5r0iEsrceqsBCwhNoiEbIPIp?=
 =?iso-8859-1?Q?qdhlegRT/Ko4o5iNzV/cXTib+9rYrBs8qa0k38W4lxYIQNOdsqDyQjN0M6?=
 =?iso-8859-1?Q?Js8Rsv3iL512XPEsw1FFpkwyBGciNZNm08adjMOsakvzi1uOucAcIRAkVy?=
 =?iso-8859-1?Q?cx7y/AnuWkAbG0vviuz9QFoQYy6jrQs6t3VxFe/K?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPpvn0BlOz7xpuSHR4sNo4vBq88Jw1lHNHc2dTJS04XEF4QAJRNOW9Edr2j45R/g8ooua+VTnR9MO/rsFslht9slKAGuauvaOYPkiXhQzSZlNvv1Wg7vpYa8uE/8bjWosqxWGK2l8mToH6rt6xQMcz8nixVBn4thdp9acPcgDcFjSuGlTiZWcKq8vKudU+xOKcoJ+026AsLqotxXY3PjYhz2jBIQ9V1TXUN7VibRh+tsGe3N2qzYbmFlztWKV/k4l+ARCAAa4YK/a3nVBc2S+RB36Mtv1mPaQrHSKsn8NVm157VEYI574aAW3cHG1dM9UCevKEPCt1flZ8ponJzbZQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkkDjIvaPSUO6JMcUONpDn13RUKrpSoZWU4knyFh7o8=;
 b=aVkwOu7TY3T8n74D4bkRRLGxCZdSyXgZOgmTyg1ZmHx+BlqFevsjH6kGeW1ruxsBtwa8GClrh2tuw8mjvpn3f+JGVBCQRakvWoWQEmTXjHK0mULpsmeam/XVeBa8I3sxILNn8Q59zNxL+PvxyDrn3tDXPbLdF7FK7jn8WXZyZDANzV1bnWX82ljuWtJRwlELuPjcC+wSAu7+tPnNim6dGIVVhwC+EveSO3RAt+ncPHVU43pgAaSf4KEV2hr+YDUsl8snhM1Zs63DvYSyZGl9Aq2eKYMsFXVKXliWj0KYRg21SZ21QZ3u/4wehOcWSc/fDQqSvR/fXdWW98UHSMK2Hg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkkDjIvaPSUO6JMcUONpDn13RUKrpSoZWU4knyFh7o8=;
 b=ap/4z0pb3yak4SqQKdKus2rOLdPyWaFaW8OUysjHut5Tw7crDYZLaHgLzXk1XzAQnNo+D/+SeTPwV7/p9STq+cHkuFOqWe235Lryog4V1CCvr6f8Yi8SrCCGNwOSlo2poC0wUjy7aHTnsuipyEqDJRg23I+QKfiJkEGZo2WB6x4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BY3PR17MB5186.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3db7a2a9-21d6-461b-ff93-08de38525df9
x-ms-exchange-crosstenant-originalarrivaltime: 11 Dec 2025 01:12:34.8093 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: khTl1p5YeFtwj3UCHEImJcdY83p9I+RPXbTWOTL9XE2cNN7neskryKb35t1CThcHx/WhycDLFnr2SBRduL0QNA==
x-ms-exchange-transport-crosstenantheadersstamped: CY5PR17MB6047
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110007
X-Proofpoint-ORIG-GUID: BmeWEsE8KRR2GX16ZnJq9F2OJssgoMiv
X-Proofpoint-GUID: BmeWEsE8KRR2GX16ZnJq9F2OJssgoMiv
X-Authority-Analysis: v=2.4 cv=DKKCIiNb c=1 sm=1 tr=0 ts=693a1a87 cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8 a=TdZc0imNeBY4IrykZUIA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAwNyBTYWx0ZWRfX1DY2vJAd9RhH
 Upm62p/vrVL714BsyvrNZQHQg6D4lBu3hKiETTQt3NI9LAxrOZJKVLEjinnre/g1nPRasGN87Ij
 fbMH+71YBwCs63LW5LEg18aKshM7QpXhKnFYyaA8YVJwgEoizi/0SzwOIHdVRE1z+RF5ELGf3UN
 kcoeyxz8TZNbiJ6Prh2NDEzO7p2QjaXoYwlvc2jwNUZaHIkpOBgWGecUwfzDl7RIjgCDqD3anOM
 ZT5lECQyoEHi59FZhRQi61lJmFAbJ+HXufJ+tiVizwGBk1QPyxWv/Y6tSUIDaycxlaEKy/35YUx
 OOs4n+sdPTnzVidpr9XkFYCIeWJaJVCwc/g8i1Nd7rBDc+ktBpXYrg3/iwt9fAxxWHgxJe8QbMq
 kQwCflML1n2qLEo3mB54m56I2hUsGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110007


________________________________________
From: Ian Rogers <irogers@google.com>
Sent: Monday, December 8, 2025 9:23 AM
To: Jayaramappa, Srilakshmi; Guilherme Amadio; Peter Zijlstra; Ingo Molnar;=
 Arnaldo Carvalho de Melo; Namhyung Kim; Alexander Shishkin; Jiri Olsa; Ian=
 Rogers; Adrian Hunter; linux-perf-users@vger.kernel.org; linux-kernel@vger=
.kernel.org
Subject: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd name=
s

!-------------------------------------------------------------------|
  This Message Is From an External Sender
  This message came from outside your organization.
|-------------------------------------------------------------------!

The test is based on an error/fix poseted to linux-perf-users.

Reported-by: Sri Jayaramappa <sjayaram@akamai.com>
Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-user=
s/20251202213632.2873731-1-sjayaram@akamai.com/__;!!GjvTz_vk!XehekKNUE4Ib_t=
vqIH6PMIIhly4X3BZ-Y40RC1HKMQ-6OdYEFvUPQhyWv_gk9vsRRN4_RcOLS2Bh0CQ$
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/subcmd-help.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.=
c
index 2280b4c0e5e7..9da96a16fd20 100644
--- a/tools/perf/tests/subcmd-help.c
+++ b/tools/perf/tests/subcmd-help.c
@@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct test_suite *te=
st __maybe_unused,
        return TEST_OK;
 }

+static int test__exclude_cmdnames_no_overlap(struct test_suite *test __may=
be_unused,
+                                            int subtest __maybe_unused)
+{
+       struct cmdnames cmds1 =3D {};
+       struct cmdnames cmds2 =3D {};
+
+       add_cmdname(&cmds1, "read-vdso32", 11);
+       add_cmdname(&cmds2, "archive", 7);
+
+       TEST_ASSERT_VAL("invalid original size", cmds1.cnt =3D=3D 1);
+       TEST_ASSERT_VAL("invalid original size", cmds2.cnt =3D=3D 1);
+
+       exclude_cmds(&cmds1, &cmds2);
+
+       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt =3D=3D 1);
+       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt =3D=3D 1);
+
+       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "read-vdso=
32") =3D=3D 1);
+       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") =3D=
=3D 0);
+
+       clean_cmdnames(&cmds1);
+       clean_cmdnames(&cmds2);
+       return TEST_OK;
+}
+
 static struct test_case tests__subcmd_help[] =3D {
        TEST_CASE("Load subcmd names", load_cmdnames),
        TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
        TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
+       TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_over=
lap),
        {       .name =3D NULL, }
 };

--
2.52.0.223.gf5cc29aaa4-goog


Reviewed-by: Sri Jayaramappa <sjayaram@akamai.com>

Looks good, thank you !
