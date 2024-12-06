Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69631E871;
	Fri,  6 Dec 2024 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450083; cv=fail; b=a7cxT+52IYKK5bI3OxUnszsU9uL7CCoVQcOfAYpDBRrrtytFLExSE5Lj42ghLDwp6qUkfMcqLjO2BRIyzVn28ZZaFZ7sp1qXiwf874jZXrhy3fmcl105eIkgOex9aIN74/nfMa+F5jtVt2NWHWQ5PnX2yXq7gTXyGjXQ/8sKZwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450083; c=relaxed/simple;
	bh=6bMS1Wf5G1AY2ljfwL/dTfHjOJ4Xg8kz8mShvyhiivI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cuEnmZBxTLN+F/ETvg+NUme5D321E6g7e0c44+w4CFTwQceFeYuIuOyBqHeNtk28qzAUy5pfK9vRoX3Jqa/0AfbC6/GSI141rvSRTkxILwbbEjG0rNJyqT91fLeidkliL1HkIkwv03MaRr+OYWdsyJsf74JyYk/K9Vfcje5zMlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=yHmRbq5L; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="yHmRbq5L"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733450077; x=1764986077;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6bMS1Wf5G1AY2ljfwL/dTfHjOJ4Xg8kz8mShvyhiivI=;
  b=yHmRbq5LS9hq2FrQbAez9KlJBW4kJ+XTJpbDz9P0mv7/wS8JpC4UUKwA
   o5P7kCG/J4aOrVHz44Cr6cG5/U07uFlkG1TEVxPwW4SrjQGV7do1KtdNI
   NG6aQZ9TZ38JsueiNX6xc3eVmxbw8MGHqC/JOyde1KrDYVc2HCjokz2QD
   O4rVlG3AZNQUAYPBhVetlFME7bQQl9sbSQholk1shReUp9p5FYpyXAqjP
   5UW8bH2WRt3YN6Tmiuq3K0KcqONWqJ98hyHaXCLHR3TqpnuEMkIziEDPo
   akWdCKqWbA3zXL2qQFwmlGhnvIQ0XfeVQXVwhticTW8+D2EOvPgF2wMMM
   w==;
X-CSE-ConnectionGUID: pBP6wXJTQwG0IasNcU1lNg==
X-CSE-MsgGUID: vY2Pw1okR3Wk5yqMLEAY2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="138871352"
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="138871352"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 10:53:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFYtdYYvWkrpZnH2IKh/EYZm4jjfURIvYhoEggNhXTKo+TPjnxTKUKJ2IZ68NUiN4Z5+GDlUTj+cPAn0XRLit3ChBxfotjGYHv4qbodELR1jCfhUYdPgyZTVLrPWNJtW3fka3iuJpkg6m9PqwA0IZeI+zjYl6Zw/Zr44RlOeFWMdEyhlw/Dd+3ef3LNnGSTlowvWUjRcw/P6USW2hyMfU4595KWAmM8/mddoZOBPnbp3qdG1Q88O+g9Yoe3dfqHwdWPytj1JWe767GVzmE5Kb9Hbee6HoNWHUT+XA2dDkbjAFgvvmsLjAUHyHJ7DeO+iqp3vYHsvs6ZeQQBeBtA7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfhfdB3RDGKxFg3Jm/9yJ7Cig2HXdJrPbp9kHUKMC0I=;
 b=EiVTu7rXNAnpZbuJ9T77Sho+Y7jajGTTc0j/Q4L3CUnj30pWZhhma9n0aMEHygXI20Xa7aReeONm5mDRFHeZrxoy2hGgHnkTBUT+pgoqvutg7166xJsXHM4zxiKxmGx85qRUuksGbeq5qAV70dLEJhFpnVBjkPAlIvquKY1ywAhO3x+RvxIXAB+GmQe3PTFyXfLjKsyfalEoVvFY+ZT4VPADZxbtTjJBPL0D40OkYcOMY3J+Z1jcufWhlyGGBxJ63wE+angGO0UdaVKtyI6lT2Vnan+bpdDEbPx2m/Ogaj3W69vYRWzzx5UkmUGMG6umTmtuz1so83Guuz7dB+jJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com (2603:1096:604:12c::9)
 by TYAPR01MB6476.jpnprd01.prod.outlook.com (2603:1096:400:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 01:53:13 +0000
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe]) by OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe%7]) with mapi id 15.20.8230.008; Fri, 6 Dec 2024
 01:53:12 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
To: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>, John Garry
	<john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James Clark
	<james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
	<leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Xu Yang <xu.yang_2@nxp.com>, Jing Zhang
	<renyu.zj@linux.alibaba.com>, Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>
Subject: RE: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu event
Thread-Topic: [PATCH v2] perf vendor events arm64: Add FUJITSU-MONAKA pmu
 event
Thread-Index: AQHbNAXE9up773d9C0m6SoSVyIeLDbLYmAkw
Date: Fri, 6 Dec 2024 01:53:12 +0000
Message-ID:
 <OS3PR01MB6903435F80EB02030CFD34BAD4312@OS3PR01MB6903.jpnprd01.prod.outlook.com>
References: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
In-Reply-To: <20241111064843.3003093-1-fj5100bi@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=e5073187-4353-496e-b2f8-02122d66a187;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-12-06T01:50:22Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6903:EE_|TYAPR01MB6476:EE_
x-ms-office365-filtering-correlation-id: 86976cc4-bee8-42d8-a543-08dd1598bde4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dGlzSWxuMEk5V3BvSm9UL0lHZThFUDUvWDBEM2R6SGJDT1R5YVJXc1Na?=
 =?iso-2022-jp?B?TUVTdWtsMUFERUFubm0vckFsZC9ld3RRMVk0eWxPNDczeXhmdlRkU0xi?=
 =?iso-2022-jp?B?bTNlRWNhbE12QzRjYlZIcTZSUnFDTkNDVTlvbkNZbTFROG9VNUpLZXFx?=
 =?iso-2022-jp?B?K0ZRYktERm5DWU1ydm1WMXRDYXlXVWk2YnhzZEUzSW9xZ3hHNW1vbTR4?=
 =?iso-2022-jp?B?Z2ppRW1BeGdkR1JzbjBNQ0xkK3NYY2QvVGRveXEyTEV4aEpxcTJncTgv?=
 =?iso-2022-jp?B?YzMxQlVGbmFVQy9hQUZsM2YzWXJyU09DbC9BajZOeWtmSFBTY1FKZGNE?=
 =?iso-2022-jp?B?cThjalBvc3pUWDNZQ0YwQ2lsT0IyKzNMOXpPTEN1RVp4WHAxYi83SDk0?=
 =?iso-2022-jp?B?YlNhMkQ5RmdDQkwwS3YvV21WVmRnTmdSL0NxZU1zR3kxS3Y4NW9PVHpN?=
 =?iso-2022-jp?B?V3ZvR0s3aUJaZDRUV1BmRDVkRzhTYTNLSjRmTmZXUmo3eG5sY0liWVZH?=
 =?iso-2022-jp?B?clcxa0NkdWx6TW12ZStiT2Zrb05XbEV5cDZMcDNlSmxKOStEamRaMFZJ?=
 =?iso-2022-jp?B?VDlNeno4WGpvdGZnMGNXSEtMNHFVa3k0VTZJVUF4bE9tR21vK09IWUt2?=
 =?iso-2022-jp?B?VVZpZ3RheVJ5UGVVSnlBWWs2Q1VObWxreFhRWkJlakR6clBtTGNrWlBC?=
 =?iso-2022-jp?B?MWpxdXRTUmJibDZXbllvSkxSOUpiTmF1dUFScURscFl6eEFRd2JKbHR4?=
 =?iso-2022-jp?B?RExTQWNhMkFTRXJlazlGU0t1RTQrUmJVWVhoeWJwNHUvRnU3ZG0wb3JU?=
 =?iso-2022-jp?B?OU1zYkNZZmVHdzhTT3RhcHZ0ZnVtSDl6ajdJSlhkbnpPSWEzZk1UamF0?=
 =?iso-2022-jp?B?cjhRbko1TzBZVVcyeVN0UklOVFhzdlQxY3BXSjlESlFQbm9CSlJBYzdB?=
 =?iso-2022-jp?B?bHVLSGkvM2xOaktjOGdvN2dOdG1JcXE5YWFHV0t4SkNBTUliTkFDbnhN?=
 =?iso-2022-jp?B?YTdSYUpGMzNJMEJGMnp0dDR4ckdvam5rdFNPb1lPQkNGTHRtY042Z3pU?=
 =?iso-2022-jp?B?dkpZeVN0WmF5d3F6V2Nab0NhdjB1QzZjWGhjODNhS3pUaGFKUkNrUU45?=
 =?iso-2022-jp?B?N2dZaE40dE4ydmdNOFdrZlIvamN2anB2RllUclRaRGl3emo2bU9XKzB4?=
 =?iso-2022-jp?B?RTN1SnJ5dSthU2FnVjhWTlRUTTN5YzJEQit0V1Qrc3lDQ1JMQyt2emRL?=
 =?iso-2022-jp?B?RnZPUDQ3ZlRZdWl1cm5TVWE5elYrc21YVDJXZWphSmlMdi9xejJ0R3hK?=
 =?iso-2022-jp?B?dWxMeFlsa3V0NW44ZkFKSnRUUEF4cTljUXlCNXNTMms2NmtJWkV3N1JF?=
 =?iso-2022-jp?B?TW1ZMkZ3NWtUbTkyUkVoaVdNcVZyQ2NBZ21PNFBFM2YrbnczUDJjclF3?=
 =?iso-2022-jp?B?SjIzUlFnVHJWZUhabEI1TzNISGprclU3dFZwQUx6REZNWGp5VFJ5QUZD?=
 =?iso-2022-jp?B?UG5rWmlCNnpra1NKR0VLRnZWRUFZUzd0aG5ub2VDa1M2b2NZcEIyZUNo?=
 =?iso-2022-jp?B?WlA1VkNpWitZLzkxcFd1cTc0QmhZSFQ0dFZ5SUlpOUpGdTZOY0FQb0FZ?=
 =?iso-2022-jp?B?bjBCQUYwZ3JzMFp5WWdndjhMMXZyaTlyVE04SWtKejBEdTM4dTFDOE5l?=
 =?iso-2022-jp?B?Ky9BNHN4ZXpNczMxVzFQYXo2aVJzbHFUV2tMNjYvUlM4a0dTWDJxVTY4?=
 =?iso-2022-jp?B?elhFOEtDZEhCZUo4aFN4N0t3UERCWVNjaStjZ2FkL2ZrMk9JSnV4YzZX?=
 =?iso-2022-jp?B?RXBwUHZIRGNvRXorUzhuK2FBV3A0eDlod2c1SklPRzJ3TFNpR0syTGp6?=
 =?iso-2022-jp?B?UXNzeEtlYkJFcERKdGM3a2dsM0I5VGo0K3FLYm05eXQrQXlBSDdzdUlV?=
 =?iso-2022-jp?B?LzZWcFJsMW1EMFFnY2V3alRRVkgrZy9GUEVNSTFQRFRQem5WaFJPWExq?=
 =?iso-2022-jp?B?YThSSHVDdVVUbzJsbS9sUUV5bjA4bzZKOVIzV1cxVWNsYksya0ZGVGZk?=
 =?iso-2022-jp?B?a3RpQlpUM2JBY0dua1ZyckNWQm1yaTJTRkhick5QMitMQ0VHZEx3TERz?=
 =?iso-2022-jp?B?K1ZRdU9tR1VPaEl5ckJJYlB1WXYyMVZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6903.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?V3Brcit3YmZXYXdkZkVEUlhuczM3RTFHRjNhS3hNblRQWlpwRGczRitp?=
 =?iso-2022-jp?B?SzBuL21UMlRBa3RFSU9QUEhTbnpRSmNRcElsem94a29mMmVEYlVwSUht?=
 =?iso-2022-jp?B?WUdYdUJEZ2VZUmJmWENSTjJyYnZrMEtZZWluV1NFcVlmUllqM3VZOVY1?=
 =?iso-2022-jp?B?TkVXNThSL05OZ2pwc3ZXY3FYaWEreUJNTU9xWnphcjFoSEVPOEF1R3dO?=
 =?iso-2022-jp?B?cVdianFEOTRQSDlyMmVIRzR4OGYrTDY1THVVUGJ4YkxEZVB1NXlxVER1?=
 =?iso-2022-jp?B?eEdHVE9TTXN0ZUNnUENSdVFobXhVZXd5UmZPcnpwTWlYOFRRK0VUaFZP?=
 =?iso-2022-jp?B?amlDT3A2KzZzVkhVdG0zcHltNWFlWVQwLzU3SzY3NUsxVEJaSVZCU1Ix?=
 =?iso-2022-jp?B?UzduUlEyeHFWemU1WjlEb09pVUE5VkV6eEhDUG93dzJMcklmcVhxVmR0?=
 =?iso-2022-jp?B?R0RLbE81L2JCclJxL3dQYXVJUm5rOEs1UTlBbW9SS3RWakRkbkNhdVBT?=
 =?iso-2022-jp?B?MWo1dHR1REdBbGcyMHJCaGVNdzR4RFpHUjI0SldXUkhrZDF5bFAyUCtZ?=
 =?iso-2022-jp?B?NGphOHNYeTUzNDRJZm1LN1RHeHJPZGFsRTM0M0lBc1FEUWpFMU9jVXNG?=
 =?iso-2022-jp?B?UnYzU1BoYVZ3Q1hXd0JvKzFXbnY2TE5lR3JWTTl4S2c5aUJLVllYdC94?=
 =?iso-2022-jp?B?MFlxWmptWTlsTFhPVGxBQVFtYVlNZ2hWbStMYm5tOXYwbTl4clFIVVJr?=
 =?iso-2022-jp?B?NGNUWXEvRnIyRDJNVXNpZnNUZ2dtWWdzMlRvMVQ2UEFPVnh4OExaaW5D?=
 =?iso-2022-jp?B?S0pZellEQzFnaERiZEJTMjhCVzZSd1c5bG9kMExrOWJzb3RtcFdncit2?=
 =?iso-2022-jp?B?ZlpscVU3dnNhSnZEV0FGWHYzKzlydmNaclhWL0FVNU9vcXhEUXZqOVll?=
 =?iso-2022-jp?B?dUVONUQwZkdiUXk5bFRRaVEwd01rM2h0SlB1U2NEOUlOUE8rbEZsNWk1?=
 =?iso-2022-jp?B?VXAzQm1NeW9pUHhGVk9wNlZRTTVYQU1hVVBPUUJIY1daSFlidEh1Sndi?=
 =?iso-2022-jp?B?MW56NXhZaG5SNk96ZWNlREpmNE1SZW10TlFnL2dWVW45dGc2bVZzWXZM?=
 =?iso-2022-jp?B?dXhIYTYxUUFwWloza1FEbkhkODVzNnRMdDdIVXloZVNtcTg2Znp4TDkr?=
 =?iso-2022-jp?B?bWRPNUVOOG5QYVllRlYvK2VPSEdyWVhvamN5elFzY1pLSzNFUnd2YWkv?=
 =?iso-2022-jp?B?K2dmdmFLcUFlOS9NK2Q2U1FiT0phNjJzTEVWNE9zVUpIa0VDYWxPTWlJ?=
 =?iso-2022-jp?B?eXdGQkh4U2IrRXV5NmV6L2E5bUpKTm1NbTNTSDdxRE0wSnhRNTltcUdx?=
 =?iso-2022-jp?B?cDR3VGppZ0ZGNHdPV2R2WmlzcUU5bGhrV0lGVnB6OGdJQVh1WHVkR1Jt?=
 =?iso-2022-jp?B?cURMb053a2dQaUkzbW5tamZSUFFsTVBFQ0hxOTdZWHRHQVZJZ3JKOE1a?=
 =?iso-2022-jp?B?VjU4TzQwcUJwdTJWTnZnUkxzZk1VVzRMWThmWHdOSDc4a1NNQVVxSVlS?=
 =?iso-2022-jp?B?NTdLM2Q1MHhZaWZTODFsVmc2NkxvUmM3OGlxVTU4anRPbnMreXFCYWcy?=
 =?iso-2022-jp?B?T2FnL21YMXZQOHRvYUZNODFscUJrNXJOYmlybUNDbE1JWXUvaFd1cVl0?=
 =?iso-2022-jp?B?MGFCYTZqVE11U3lhUDhVUnJlTmdjaExRNCt1V2k4YWlqeXhRRGRJc3lH?=
 =?iso-2022-jp?B?cnZYNVA2WVVadUM5WnFhT1k2aytDcWh0WVpQeFdQZGpXdEhtYWo2ald6?=
 =?iso-2022-jp?B?QTBSak9lb090cmthckFSejlzekxIT1VwK2ZpS3lyeVZhV0RGR1hsUkF3?=
 =?iso-2022-jp?B?WE1TT0p5Y1Q2NHNYSlNmS2FxeDFmTzVGNXovT0g3ZGthb1N3dVhXZ2lv?=
 =?iso-2022-jp?B?bElBWWFoeDdYeVFjbkllRy9CVktLVDBrbGNlTUtkZmJZUzd6eVhDZW4v?=
 =?iso-2022-jp?B?T3FFa2swTzRHUWI3UHNJQXdteTJUaEFEWUhicDhKU2Vub291RVFWQjN3?=
 =?iso-2022-jp?B?djg1SVNQMHJhYVcvaklCU3BVM1c3OEl1WkdZbnpOWjFZSjVLUnhMaGhR?=
 =?iso-2022-jp?B?bWhrWm4zZUo1di9uVXJta2dCWmI5VFptMVFpU0ZmM1NxVW9VYmE5MW5q?=
 =?iso-2022-jp?B?TnpWc0RJQWRDdFJUdmFPYmZkaUFCUDJoYXlYWGo3Q2dvWFkyMW1oLzF6?=
 =?iso-2022-jp?B?bE5EcXRrSFNYaE1qUWdsMFBOUkFUWDB2aWhZRTNuM29kbllJck1jR2dP?=
 =?iso-2022-jp?B?VktQRg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hWiBQSSABrhqDFUuGclEgDomRvP1WrHJkaYf8cYTFg9NmidoLZISdrwz3IYP+ZiSCXw+92ceJzV/M1MrkYCdiQXRKCUqnsC2Dkf2PSTmB9vVwovxsxLrZJcRsmkHJ5hs5Z4Jy93sZwvfV8Ks55+6d/xhHUfQm16lA8RTb8PHgZy2r8o8BxGENxHOxTO/6GegbwvKjotp8Ci8KZYUOFQ7Iee9VIUPm4NAdk6p6YQpM4L63qbCymH3JhSWT2Pjled2A2KDd//sNn1/GQ5IzUsGZxp01doDmQNGOki+agMDE5H6WC4d5a9ikRL7ojXC7aiRdtWL44eUgRVks/FHlNjIfcw48DQWl03bOAn8Zs5/y0knJtOveqkYKEwOgOusABAcdO60NuZZTL+D9sNhgRuof5aJjNrFrvBgi/BHMRRvruVg2dvdhyeh97r/TstlQxTXddW5mNKFlSidttqbtuOcFZP4Uxry9wBk9dXbDsiEQSr68xE/OJMZXEGZMHvlsZdAiWQ37xSUVqj+4CwrI0+rbKGYnh85IkOCHtzsAiU8n5JTmq5XLDx5ZwYQEFkpJhNL56qfpLbNDo4fbz2vfSxiVTjR0Z3QoREKkR3VapvnuD/UsND+yc9aypjcr8yTUbuF
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6903.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86976cc4-bee8-42d8-a543-08dd1598bde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:53:12.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVC50x9ZMuUiYT1ojXK1e34bvBZNfrWCSpw+BqNpyoUkZ30DvBLolp9I6rfzKaf5paIdaX8aVG/nR+E2IJGCYO27F6MCvX6h+QaLRv/th+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6476

>     Add pmu events for FUJITSU-MONAKA.
>     And, also updated common-and-microarch.json and recommended.json.
>=20
>     FUJITSU-MONAKA Specification URL:
>     https://github.com/fujitsu/FUJITSU-MONAKA
>=20
> Signed-off-by: Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
> Changes in v2:
> - Change "SVE_INT64_DIV_SPEC" to "SVE_INT_DIV64_SPEC" in
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json.
> - Link to v1:
> https://lore.kernel.org/all/20241111024529.2985894-1-fj5100bi@fujitsu.com=
/
>=20
>  .../arch/arm64/common-and-microarch.json      | 858
> ++++++++++++++++++
>  .../fujitsu/monaka/cycle_accounting.json      | 146 +++
>  .../arch/arm64/fujitsu/monaka/energy.json     |  20 +
>  .../arch/arm64/fujitsu/monaka/exception.json  |  32 +
>  .../arm64/fujitsu/monaka/fp_operation.json    | 194 ++++
>  .../arch/arm64/fujitsu/monaka/gcycle.json     | 116 +++
>  .../arch/arm64/fujitsu/monaka/general.json    |   8 +
>  .../arch/arm64/fujitsu/monaka/hwpf.json       |  62 ++
>  .../arch/arm64/fujitsu/monaka/l1d_cache.json  | 101 +++
>  .../arch/arm64/fujitsu/monaka/l1i_cache.json  |  47 +
>  .../arch/arm64/fujitsu/monaka/l2_cache.json   | 146 +++
>  .../arch/arm64/fujitsu/monaka/l3_cache.json   | 185 ++++
>  .../arch/arm64/fujitsu/monaka/ll_cache.json   |   8 +
>  .../arch/arm64/fujitsu/monaka/memory.json     |   8 +
>  .../arch/arm64/fujitsu/monaka/pipeline.json   | 230 +++++
>  .../arch/arm64/fujitsu/monaka/retired.json    |  29 +
>  .../arm64/fujitsu/monaka/spec_operation.json  | 158 ++++
>  .../arch/arm64/fujitsu/monaka/stall.json      |  83 ++
>  .../arch/arm64/fujitsu/monaka/sve.json        | 146 +++
>  .../arch/arm64/fujitsu/monaka/tlb.json        | 404 +++++++++
>  .../arch/arm64/fujitsu/monaka/trace.json      |  20 +
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>  .../pmu-events/arch/arm64/recommended.json    |   6 +
>  23 files changed, 3008 insertions(+)
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
>  create mode 100644
> tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
>=20
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index 492083b99256..50fc4b2df361 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -533,6 +533,12 @@
>          "EventName": "SVE_INST_SPEC",
>          "BriefDescription": "SVE operations speculatively executed"
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE operations.",
> +        "EventCode": "0x8007",
> +        "EventName": "ASE_SVE_INST_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE operations."
> +    },
>      {
>          "PublicDescription": "Microarchitectural operation, Operations
> speculatively executed.",
>          "EventCode": "0x8008",
> @@ -551,48 +557,462 @@
>          "EventName": "FP_SPEC",
>          "BriefDescription": "Floating-point Operations speculatively exe=
cuted."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point operation.",
> +        "EventCode": "0x8011",
> +        "EventName": "ASE_FP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point operation.",
> +        "EventCode": "0x8012",
> +        "EventName": "SVE_FP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point operations.",
> +        "EventCode": "0x8013",
> +        "EventName": "ASE_SVE_FP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point operations."
> +    },
>      {
>          "PublicDescription": "Floating-point half-precision operations
> speculatively executed",
>          "EventCode": "0x8014",
>          "EventName": "FP_HP_SPEC",
>          "BriefDescription": "Floating-point half-precision operations
> speculatively executed"
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD half-precision floating-point operation.",
> +        "EventCode": "0x8015",
> +        "EventName": "ASE_FP_HP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD half-precision floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> half-precision floating-point operation.",
> +        "EventCode": "0x8016",
> +        "EventName": "SVE_FP_HP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> half-precision floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE half-precision floating-point operations.",
> +        "EventCode": "0x8017",
> +        "EventName": "ASE_SVE_FP_HP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE half-precision floating-point operations."
> +    },
>      {
>          "PublicDescription": "Floating-point single-precision operations
> speculatively executed",
>          "EventCode": "0x8018",
>          "EventName": "FP_SP_SPEC",
>          "BriefDescription": "Floating-point single-precision operations
> speculatively executed"
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD single-precision floating-point operation.",
> +        "EventCode": "0x8019",
> +        "EventName": "ASE_FP_SP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD single-precision floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> single-precision floating-point operation.",
> +        "EventCode": "0x801A",
> +        "EventName": "SVE_FP_SP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> single-precision floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE single-precision floating-point operations.",
> +        "EventCode": "0x801B",
> +        "EventName": "ASE_SVE_FP_SP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE single-precision floating-point operations."
> +    },
>      {
>          "PublicDescription": "Floating-point double-precision operations
> speculatively executed",
>          "EventCode": "0x801C",
>          "EventName": "FP_DP_SPEC",
>          "BriefDescription": "Floating-point double-precision operations
> speculatively executed"
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD double-precision floating-point operation.",
> +        "EventCode": "0x801D",
> +        "EventName": "ASE_FP_DP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD double-precision floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> double-precision floating-point operation.",
> +        "EventCode": "0x801E",
> +        "EventName": "SVE_FP_DP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> double-precision floating-point operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE double-precision floating-point operations.",
> +        "EventCode": "0x801F",
> +        "EventName": "ASE_SVE_FP_DP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE double-precision floating-point operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> floating-point divide operation.",
> +        "EventCode": "0x8020",
> +        "EventName": "FP_DIV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> floating-point divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point divide operation.",
> +        "EventCode": "0x8021",
> +        "EventName": "ASE_FP_DIV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point divide operation.",
> +        "EventCode": "0x8022",
> +        "EventName": "SVE_FP_DIV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point divide operations.",
> +        "EventCode": "0x8023",
> +        "EventName": "ASE_SVE_FP_DIV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point divide operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> floating-point square root operation.",
> +        "EventCode": "0x8024",
> +        "EventName": "FP_SQRT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> floating-point square root operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point square root operation.",
> +        "EventCode": "0x8025",
> +        "EventName": "ASE_FP_SQRT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point square root operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point square root operation.",
> +        "EventCode": "0x8026",
> +        "EventName": "SVE_FP_SQRT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point square root operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point square root operations.",
> +        "EventCode": "0x8027",
> +        "EventName": "ASE_SVE_FP_SQRT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point square root operations."
> +    },
>      {
>          "PublicDescription": "Floating-point FMA Operations speculativel=
y
> executed.",
>          "EventCode": "0x8028",
>          "EventName": "FP_FMA_SPEC",
>          "BriefDescription": "Floating-point FMA Operations speculatively
> executed."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point FMA operation.",
> +        "EventCode": "0x8029",
> +        "EventName": "ASE_FP_FMA_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point FMA operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point FMA operation.",
> +        "EventCode": "0x802A",
> +        "EventName": "SVE_FP_FMA_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point FMA operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point FMA operations.",
> +        "EventCode": "0x802B",
> +        "EventName": "ASE_SVE_FP_FMA_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point FMA operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> floating-point multiply operations.",
> +        "EventCode": "0x802C",
> +        "EventName": "FP_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> floating-point multiply operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point multiply operation.",
> +        "EventCode": "0x802D",
> +        "EventName": "ASE_FP_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point multiply operation.",
> +        "EventCode": "0x802E",
> +        "EventName": "SVE_FP_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point multiply operations.",
> +        "EventCode": "0x802F",
> +        "EventName": "ASE_SVE_FP_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point multiply operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> floating-point add or subtract operations.",
> +        "EventCode": "0x8030",
> +        "EventName": "FP_ADDSUB_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> floating-point add or subtract operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point add or subtract operation.",
> +        "EventCode": "0x8031",
> +        "EventName": "ASE_FP_ADDSUB_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point add or subtract operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point add or subtract operation.",
> +        "EventCode": "0x8032",
> +        "EventName": "SVE_FP_ADDSUB_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point add or subtract operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point add or subtract operations.",
> +        "EventCode": "0x8033",
> +        "EventName": "ASE_SVE_FP_ADDSUB_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point add or subtract operations."
> +    },
>      {
>          "PublicDescription": "Floating-point reciprocal estimate Operati=
ons
> speculatively executed.",
>          "EventCode": "0x8034",
>          "EventName": "FP_RECPE_SPEC",
>          "BriefDescription": "Floating-point reciprocal estimate Operatio=
ns
> speculatively executed."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point reciprocal estimate operations.",
> +        "EventCode": "0x8035",
> +        "EventName": "ASE_FP_RECPE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point reciprocal estimate operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point reciprocal estimate operations.",
> +        "EventCode": "0x8036",
> +        "EventName": "SVE_FP_RECPE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point reciprocal estimate operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point reciprocal estimate operations.",
> +        "EventCode": "0x8037",
> +        "EventName": "ASE_SVE_FP_RECPE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point reciprocal estimate operations."
> +    },
>      {
>          "PublicDescription": "floating-point convert Operations speculat=
ively
> executed.",
>          "EventCode": "0x8038",
>          "EventName": "FP_CVT_SPEC",
>          "BriefDescription": "floating-point convert Operations speculati=
vely
> executed."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point convert operation.",
> +        "EventCode": "0x8039",
> +        "EventName": "ASE_FP_CVT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point convert operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point convert operation.",
> +        "EventCode": "0x803A",
> +        "EventName": "SVE_FP_CVT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point convert operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point convert operations.",
> +        "EventCode": "0x803B",
> +        "EventName": "ASE_SVE_FP_CVT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point convert operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point accumulating reduction operations.",
> +        "EventCode": "0x803C",
> +        "EventName": "SVE_FP_AREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point accumulating reduction operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD floating-point pairwise add step operations.",
> +        "EventCode": "0x803D",
> +        "EventName": "ASE_FP_PREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD floating-point pairwise add step operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> floating-point vector reduction operation.",
> +        "EventCode": "0x803E",
> +        "EventName": "SVE_FP_VREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> floating-point vector reduction operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point vector reduction operations.",
> +        "EventCode": "0x803F",
> +        "EventName": "ASE_SVE_FP_VREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE floating-point vector reduction operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operations due to scalar, Advanced SIMD, and SVE instructions listed in I=
nteger
> instructions section of ARMv9 Reference Manual.",
> +        "EventCode": "0x8040",
> +        "EventName": "INT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operations due to scalar, Advanced SIMD, and SVE instructions listed in I=
nteger
> instructions section of ARMv9 Reference Manual."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD integer operations.",
> +        "EventCode": "0x8041",
> +        "EventName": "ASE_INT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD integer operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> integer operations.",
> +        "EventCode": "0x8042",
> +        "EventName": "SVE_INT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> integer operations."
> +    },
>      {
>          "PublicDescription": "Advanced SIMD and SVE integer Operations
> speculatively executed.",
>          "EventCode": "0x8043",
>          "EventName": "ASE_SVE_INT_SPEC",
>          "BriefDescription": "Advanced SIMD and SVE integer Operations
> speculatively executed."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> integer divide operation.",
> +        "EventCode": "0x8044",
> +        "EventName": "INT_DIV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
integer
> divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 64-bit
> integer divide operation.",
> +        "EventCode": "0x8045",
> +        "EventName": "INT_DIV64_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
64-bit
> integer divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> integer divide operation.",
> +        "EventCode": "0x8046",
> +        "EventName": "SVE_INT_DIV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> integer divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> 64-bit integer divide operation.",
> +        "EventCode": "0x8047",
> +        "EventName": "SVE_INT_DIV64_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> 64-bit integer divide operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> integer multiply operation.",
> +        "EventCode": "0x8048",
> +        "EventName": "INT_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
integer
> multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD integer multiply operation.",
> +        "EventCode": "0x8049",
> +        "EventName": "ASE_INT_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD integer multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> integer multiply operation.",
> +        "EventCode": "0x804A",
> +        "EventName": "SVE_INT_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> integer multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE integer multiply operations.",
> +        "EventCode": "0x804B",
> +        "EventName": "ASE_SVE_INT_MUL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE integer multiply operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> integer 64-bit x 64-bit multiply operation.",
> +        "EventCode": "0x804C",
> +        "EventName": "INT_MUL64_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
integer
> 64-bit x 64-bit multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> integer 64-bit x 64-bit multiply operation.",
> +        "EventCode": "0x804D",
> +        "EventName": "SVE_INT_MUL64_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> integer 64-bit x 64-bit multiply operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> integer 64-bit x 64-bit multiply returning high part operation.",
> +        "EventCode": "0x804E",
> +        "EventName": "INT_MULH64_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
integer
> 64-bit x 64-bit multiply returning high part operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> integer 64-bit x 64-bit multiply returning high part operations.",
> +        "EventCode": "0x804F",
> +        "EventName": "SVE_INT_MULH64_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> integer 64-bit x 64-bit multiply returning high part operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> non-floating-point operations.",
> +        "EventCode": "0x8058",
> +        "EventName": "NONFP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> non-floating-point operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD non-floating-point operations.",
> +        "EventCode": "0x8059",
> +        "EventName": "ASE_NONFP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD non-floating-point operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> non-floating-point operations.",
> +        "EventCode": "0x805A",
> +        "EventName": "SVE_NONFP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> non-floating-point operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE non-floating-point operations.",
> +        "EventCode": "0x805B",
> +        "EventName": "ASE_SVE_NONFP_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE non-floating-point operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD integer reduction operation.",
> +        "EventCode": "0x805D",
> +        "EventName": "ASE_INT_VREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD integer reduction operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SVE
> integer reduction operation.",
> +        "EventCode": "0x805E",
> +        "EventName": "SVE_INT_VREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SVE
> integer reduction operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> Advanced SIMD and SVE integer reduction operations.",
> +        "EventCode": "0x805F",
> +        "EventName": "ASE_SVE_INT_VREDUCE_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> Advanced SIMD and SVE integer reduction operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 vector
> or predicate permute operation.",
> +        "EventCode": "0x8060",
> +        "EventName": "SVE_PERM_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
vector
> or predicate permute operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 vector
> to general-purpose scalar cross-pipeline transfer operation.",
> +        "EventCode": "0x8065",
> +        "EventName": "SVE_XPIPE_Z2R_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
vector
> to general-purpose scalar cross-pipeline transfer operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> general-purpose scalar to vector cross-pipeline transfer operation.",
> +        "EventCode": "0x8066",
> +        "EventName": "SVE_XPIPE_R2Z_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> general-purpose scalar to vector cross-pipeline transfer operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> predicate-generating operation.",
> +        "EventCode": "0x8068",
> +        "EventName": "SVE_PGEN_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> predicate-generating operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> predicate-generating operation that sets condition flags.",
> +        "EventCode": "0x8069",
> +        "EventName": "SVE_PGEN_FLG_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> predicate-generating operation that sets condition flags."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> predicate permute operation.",
> +        "EventCode": "0x806D",
> +        "EventName": "SVE_PPERM_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> predicate permute operation."
> +    },
>      {
>          "PublicDescription": "SVE predicated Operations speculatively
> executed.",
>          "EventCode": "0x8074",
> @@ -629,6 +1049,18 @@
>          "EventName": "SVE_MOVPRFX_SPEC",
>          "BriefDescription": "SVE MOVPRFX Operations speculatively
> executed."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operation counted by SVE_MOVPRFX_SPEC where the operation uses zeroing
> predication.",
> +        "EventCode": "0x807D",
> +        "EventName": "SVE_MOVPRFX_Z_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operation counted by SVE_MOVPRFX_SPEC where the operation uses zeroing
> predication."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operation counted by SVE_MOVPRFX_SPEC where the operation uses merging
> predication.",
> +        "EventCode": "0x807E",
> +        "EventName": "SVE_MOVPRFX_M_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operation counted by SVE_MOVPRFX_SPEC where the operation uses merging
> predication."
> +    },
>      {
>          "PublicDescription": "SVE MOVPRFX unfused Operations speculative=
ly
> executed.",
>          "EventCode": "0x807F",
> @@ -695,6 +1127,18 @@
>          "EventName": "SVE_PRF_CONTIG_SPEC",
>          "BriefDescription": "SVE contiguous prefetch element Operations
> speculatively executed."
>      },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operation that reads from memory with a non-temporal hint due to an SVE
> non-temporal contiguous element load instruction.",
> +        "EventCode": "0x80A1",
> +        "EventName": "SVE_LDNT_CONTIG_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operation that reads from memory with a non-temporal hint due to an SVE
> non-temporal contiguous element load instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operation that writes to memory with a non-temporal hint due to an SVE
> non-temporal contiguous element store instruction.",
> +        "EventCode": "0x80A2",
> +        "EventName": "SVE_STNT_CONTIG_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operation that writes to memory with a non-temporal hint due to an SVE
> non-temporal contiguous element store instruction."
> +    },
>      {
>          "PublicDescription": "Advanced SIMD and SVE contiguous load mult=
iple
> vector Operations speculatively executed.",
>          "EventCode": "0x80A5",
> @@ -785,6 +1229,18 @@
>          "EventName": "FP_DP_FIXED_OPS_SPEC",
>          "BriefDescription": "Non-scalable double-precision floating-poin=
t
> element Operations speculatively executed."
>      },
> +    {
> +        "PublicDescription": "This event counts each integer ALU operati=
on
> counted by SVE_INT_SPEC. See ALU operation counts section of ARMv9
> Reference Manual for information on the counter increment for different t=
ypes of
> instruction.",
> +        "EventCode": "0x80C8",
> +        "EventName": "INT_SCALE_OPS_SPEC",
> +        "BriefDescription": "This event counts each integer ALU operatio=
n
> counted by SVE_INT_SPEC. See ALU operation counts section of ARMv9
> Reference Manual for information on the counter increment for different t=
ypes of
> instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts each integer ALU operati=
on
> counted by INT_SPEC that is not counted by SVE_INT_SPEC. See ALU operatio=
n
> counts section of ARMv9 Reference Manual for information on the counter
> increment for different types of instruction.",
> +        "EventCode": "0x80C9",
> +        "EventName": "INT_FIXED_OPS_SPEC",
> +        "BriefDescription": "This event counts each integer ALU operatio=
n
> counted by INT_SPEC that is not counted by SVE_INT_SPEC. See ALU operatio=
n
> counts section of ARMv9 Reference Manual for information on the counter
> increment for different types of instruction."
> +    },
>      {
>          "PublicDescription": "Advanced SIMD and SVE 8-bit integer operat=
ions
> speculatively executed",
>          "EventCode": "0x80E3",
> @@ -808,5 +1264,407 @@
>          "EventCode": "0x80EF",
>          "EventName": "ASE_SVE_INT64_SPEC",
>          "BriefDescription": "Advanced SIMD and SVE 64-bit integer operat=
ions
> speculatively executed"
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE floating-point dot-product operat=
ion.",
> +        "EventCode": "0x80F3",
> +        "EventName": "ASE_SVE_FP_DOT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE floating-point dot-product operat=
ion."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE floating-point matrix multiply
> operation.",
> +        "EventCode": "0x80F7",
> +        "EventName": "ASE_SVE_FP_MMLA_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE floating-point matrix multiply
> operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE integer dot-product operation.",
> +        "EventCode": "0x80FB",
> +        "EventName": "ASE_SVE_INT_DOT_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE integer dot-product operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE integer matrix multiply operation=
.",
> +        "EventCode": "0x80FF",
> +        "EventName": "ASE_SVE_INT_MMLA_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> microarchitectural Advanced SIMD or SVE integer matrix multiply operation=
."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of DTLB_WALK
> events in progress on each Processor cycle.",
> +        "EventCode": "0x8128",
> +        "EventName": "DTLB_WALK_PERCYC",
> +        "BriefDescription": "This event counts the number of DTLB_WALK
> events in progress on each Processor cycle."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of ITLB_WALK
> events in progress on each Processor cycle.",
> +        "EventCode": "0x8129",
> +        "EventName": "ITLB_WALK_PERCYC",
> +        "BriefDescription": "This event counts the number of ITLB_WALK
> events in progress on each Processor cycle."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk a=
ccess
> made by a refill of the data TLB.",
> +        "EventCode": "0x8136",
> +        "EventName": "DTLB_STEP",
> +        "BriefDescription": "This event counts translation table walk ac=
cess
> made by a refill of the data TLB."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk a=
ccess
> made by a refill of the instruction TLB.",
> +        "EventCode": "0x8137",
> +        "EventName": "ITLB_STEP",
> +        "BriefDescription": "This event counts translation table walk ac=
cess
> made by a refill of the instruction TLB."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by DTLB_WALK where the result of the walk yields a large page size.",
> +        "EventCode": "0x8138",
> +        "EventName": "DTLB_WALK_LARGE",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> DTLB_WALK where the result of the walk yields a large page size."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by ITLB_WALK where the result of the walk yields a large page size.",
> +        "EventCode": "0x8139",
> +        "EventName": "ITLB_WALK_LARGE",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> ITLB_WALK where the result of the walk yields a large page size."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by DTLB_WALK where the result of the walk yields a small page size.",
> +        "EventCode": "0x813A",
> +        "EventName": "DTLB_WALK_SMALL",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> DTLB_WALK where the result of the walk yields a small page size."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by ITLB_WALK where the result of the walk yields a small page size.",
> +        "EventCode": "0x813B",
> +        "EventName": "ITLB_WALK_SMALL",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> ITLB_WALK where the result of the walk yields a small page size."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access that misse=
s in
> the Level 1 data cache, causing an access to outside of the Level 1 cache=
s of this
> PE.",
> +        "EventCode": "0x8144",
> +        "EventName": "L1D_CACHE_MISS",
> +        "BriefDescription": "This event counts demand access that misses=
 in
> the Level 1 data cache, causing an access to outside of the Level 1 cache=
s of this
> PE."
> +    },
> +    {
> +        "PublicDescription": "This event counts access counted by L1I_CA=
CHE
> that is due to a hardware prefetch.",
> +        "EventCode": "0x8145",
> +        "EventName": "L1I_CACHE_HWPRF",
> +        "BriefDescription": "This event counts access counted by L1I_CAC=
HE
> that is due to a hardware prefetch."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access that misse=
s in
> the Level 1 data and Level 2 caches, causing an access to outside of the =
Level 1
> and Level 2 caches of this PE.",
> +        "EventCode": "0x814C",
> +        "EventName": "L2D_CACHE_MISS",
> +        "BriefDescription": "This event counts demand access that misses=
 in
> the Level 1 data and Level 2 caches, causing an access to outside of the =
Level 1
> and Level 2 caches of this PE."
> +    },
> +    {
> +        "PublicDescription": "This event counts access counted by L1D_CA=
CHE
> that is due to a hardware prefetch.",
> +        "EventCode": "0x8154",
> +        "EventName": "L1D_CACHE_HWPRF",
> +        "BriefDescription": "This event counts access counted by L1D_CAC=
HE
> that is due to a hardware prefetch."
> +    },
> +    {
> +        "PublicDescription": "This event counts access counted by L2D_CA=
CHE
> that is due to a hardware prefetch.",
> +        "EventCode": "0x8155",
> +        "EventName": "L2D_CACHE_HWPRF",
> +        "BriefDescription": "This event counts access counted by L2D_CAC=
HE
> that is due to a hardware prefetch."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND when no instructions are delivered from the memory
> system.",
> +        "EventCode": "0x8158",
> +        "EventName": "STALL_FRONTEND_MEMBOUND",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND when no instructions are delivered from the memory system.=
"
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> first level of instruction cache.",
> +        "EventCode": "0x8159",
> +        "EventName": "STALL_FRONTEND_L1I",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> first level of instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> second level of instruction cache.",
> +        "EventCode": "0x815A",
> +        "EventName": "STALL_FRONTEND_L2I",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> second level of instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> last level of instruction cache within the PE clock domain or a non-cache=
able
> instruction fetch in progress.",
> +        "EventCode": "0x815B",
> +        "EventName": "STALL_FRONTEND_MEM",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> last level of instruction cache within the PE clock domain or a non-cache=
able
> instruction fetch in progress."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> instruction TLB.",
> +        "EventCode": "0x815C",
> +        "EventName": "STALL_FRONTEND_TLB",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_MEMBOUND when there is a demand instruction miss in the
> instruction TLB."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND when the frontend is stalled on a frontend processor resou=
rce,
> not including memory.",
> +        "EventCode": "0x8160",
> +        "EventName": "STALL_FRONTEND_CPUBOUND",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND when the frontend is stalled on a frontend processor resou=
rce,
> not including memory."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_CPUBOUND when the frontend is stalled on unavailability of
> prediction flow resources.",
> +        "EventCode": "0x8161",
> +        "EventName": "STALL_FRONTEND_FLOW",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_CPUBOUND when the frontend is stalled on unavailability of
> prediction flow resources."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_CPUBOUND when the frontend is recovering from a pipeline
> flush.",
> +        "EventCode": "0x8162",
> +        "EventName": "STALL_FRONTEND_FLUSH",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_CPUBOUND when the frontend is recovering from a pipeline
> flush."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_FRONTEND_CPUBOUND when operations are available from the
> frontend but at least one is not ready to be sent to the backend because =
no rename
> register is available.",
> +        "EventCode": "0x8163",
> +        "EventName": "STALL_FRONTEND_RENAME",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_FRONTEND_CPUBOUND when operations are available from the
> frontend but at least one is not ready to be sent to the backend because =
no rename
> register is available."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND when the backend is waiting for a memory access to
> complete.",
> +        "EventCode": "0x8164",
> +        "EventName": "STALL_BACKEND_MEMBOUND",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND when the backend is waiting for a memory access to
> complete."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when there is a demand data miss in L1D
> cache.",
> +        "EventCode": "0x8165",
> +        "EventName": "STALL_BACKEND_L1D",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when there is a demand data miss in L1D
> cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when there is a demand data miss in L2D
> cache.",
> +        "EventCode": "0x8166",
> +        "EventName": "STALL_BACKEND_L2D",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when there is a demand data miss in L2D
> cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when there is a demand data miss in the data
> TLB.",
> +        "EventCode": "0x8167",
> +        "EventName": "STALL_BACKEND_TLB",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when there is a demand data miss in the data
> TLB."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when the backend is stalled waiting for a store.",
> +        "EventCode": "0x8168",
> +        "EventName": "STALL_BACKEND_ST",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when the backend is stalled waiting for a store."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND when the backend is stalled on a processor resource, not
> including memory.",
> +        "EventCode": "0x816A",
> +        "EventName": "STALL_BACKEND_CPUBOUND",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND when the backend is stalled on a processor resource, not
> including memory."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND when operations are available from the frontend but the
> backend is not able to accept an operation because an execution unit is b=
usy.",
> +        "EventCode": "0x816B",
> +        "EventName": "STALL_BACKEND_BUSY",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND when operations are available from the frontend but the
> backend is not able to accept an operation because an execution unit is b=
usy."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND when operations are available from the frontend but at leas=
t
> one is not ready to be sent to the backend because of an input dependency=
.",
> +        "EventCode": "0x816C",
> +        "EventName": "STALL_BACKEND_ILOCK",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND when operations are available from the frontend but at leas=
t
> one is not ready to be sent to the backend because of an input dependency=
."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_CPUBOUND when operations are available from the frontend
> but at least one is not ready to be sent to the backend because no rename=
 register
> is available.",
> +        "EventCode": "0x816D",
> +        "EventName": "STALL_BACKEND_RENAME",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_CPUBOUND when operations are available from the frontend
> but at least one is not ready to be sent to the backend because no rename=
 register
> is available."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when the backend is processing an Atomic
> operation.",
> +        "EventCode": "0x816E",
> +        "EventName": "STALL_BACKEND_ATOMIC",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when the backend is processing an Atomic
> operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when the backend is processing a Memory Copy
> or Set instruction.",
> +        "EventCode": "0x816F",
> +        "EventName": "STALL_BACKEND_MEMCPYSET",
> +        "BriefDescription": "This event counts every cycle counted by
> STALL_BACKEND_MEMBOUND when the backend is processing a Memory Copy
> or Set instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts micro-operation that wou=
ld be
> executed in a Simple sequential execution of the program.",
> +        "EventCode": "0x8186",
> +        "EventName": "UOP_RETIRED",
> +        "BriefDescription": "This event counts micro-operation that woul=
d be
> executed in a Simple sequential execution of the program."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by DTLB_WALK where the result of the walk yields a Block.",
> +        "EventCode": "0x8188",
> +        "EventName": "DTLB_WALK_BLOCK",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> DTLB_WALK where the result of the walk yields a Block."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by ITLB_WALK where the result of the walk yields a Block.",
> +        "EventCode": "0x8189",
> +        "EventName": "ITLB_WALK_BLOCK",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> ITLB_WALK where the result of the walk yields a Block."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by DTLB_WALK where the result of the walk yields a Page.",
> +        "EventCode": "0x818A",
> +        "EventName": "DTLB_WALK_PAGE",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> DTLB_WALK where the result of the walk yields a Page."
> +    },
> +    {
> +        "PublicDescription": "This event counts translation table walk c=
ounted
> by ITLB_WALK where the result of the walk yields a Page.",
> +        "EventCode": "0x818B",
> +        "EventName": "ITLB_WALK_PAGE",
> +        "BriefDescription": "This event counts translation table walk co=
unted by
> ITLB_WALK where the result of the walk yields a Page."
> +    },
> +    {
> +        "PublicDescription": "This event counts hardware prefetch counte=
d by
> L1I_CACHE_HWPRF that causes a refill of the Level 1 instruction cache fro=
m
> outside of the Level 1 instruction cache.",
> +        "EventCode": "0x81B8",
> +        "EventName": "L1I_CACHE_REFILL_HWPRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by
> L1I_CACHE_HWPRF that causes a refill of the Level 1 instruction cache fro=
m
> outside of the Level 1 instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts hardware prefetch counte=
d by
> L1D_CACHE_HWPRF that causes a refill of the Level 1 data cache from outsi=
de of
> the Level 1 data cache.",
> +        "EventCode": "0x81BC",
> +        "EventName": "L1D_CACHE_REFILL_HWPRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by
> L1D_CACHE_HWPRF that causes a refill of the Level 1 data cache from outsi=
de of
> the Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts hardware prefetch counte=
d by
> L2D_CACHE_HWPRF that causes a refill of the Level 2 cache, or any Level 1=
 data
> and instruction cache of this PE, from outside of those caches.",
> +        "EventCode": "0x81BD",
> +        "EventName": "L2D_CACHE_REFILL_HWPRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by
> L2D_CACHE_HWPRF that causes a refill of the Level 2 cache, or any Level 1=
 data
> and instruction cache of this PE, from outside of those caches."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand fetch counted by
> L1I_CACHE_DM_RD that hits in the Level 1 instruction cache.",
> +        "EventCode": "0x81C0",
> +        "EventName": "L1I_CACHE_HIT_RD",
> +        "BriefDescription": "This event counts demand fetch counted by
> L1I_CACHE_DM_RD that hits in the Level 1 instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand read counted by
> L1D_CACHE_RD that hits in the Level 1 data cache.",
> +        "EventCode": "0x81C4",
> +        "EventName": "L1D_CACHE_HIT_RD",
> +        "BriefDescription": "This event counts demand read counted by
> L1D_CACHE_RD that hits in the Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand read counted by
> L2D_CACHE_RD that hits in the Level 2 data cache.",
> +        "EventCode": "0x81C5",
> +        "EventName": "L2D_CACHE_HIT_RD",
> +        "BriefDescription": "This event counts demand read counted by
> L2D_CACHE_RD that hits in the Level 2 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand write counted by
> L1D_CACHE_WR that hits in the Level 1 data cache.",
> +        "EventCode": "0x81C8",
> +        "EventName": "L1D_CACHE_HIT_WR",
> +        "BriefDescription": "This event counts demand write counted by
> L1D_CACHE_WR that hits in the Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand write counted by
> L2D_CACHE_WR that hits in the Level 2 data cache.",
> +        "EventCode": "0x81C9",
> +        "EventName": "L2D_CACHE_HIT_WR",
> +        "BriefDescription": "This event counts demand write counted by
> L2D_CACHE_WR that hits in the Level 2 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts access counted by L1I_CA=
CHE
> that hits in the Level 1 instruction cache.",
> +        "EventCode": "0x8200",
> +        "EventName": "L1I_CACHE_HIT",
> +        "BriefDescription": "This event counts access counted by L1I_CAC=
HE
> that hits in the Level 1 instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts access counted by L1D_CA=
CHE
> that hits in the Level 1 data cache.",
> +        "EventCode": "0x8204",
> +        "EventName": "L1D_CACHE_HIT",
> +        "BriefDescription": "This event counts access counted by L1D_CAC=
HE
> that hits in the Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts access counted by L2D_CA=
CHE
> that hits in the Level 2 data cache.",
> +        "EventCode": "0x8205",
> +        "EventName": "L2D_CACHE_HIT",
> +        "BriefDescription": "This event counts access counted by L2D_CAC=
HE
> that hits in the Level 2 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access counted by
> L1I_CACHE_HIT_RD that hits a cache line that is in the process of being l=
oaded
> into the Level 1 instruction cache.",
> +        "EventCode": "0x8240",
> +        "EventName": "L1I_LFB_HIT_RD",
> +        "BriefDescription": "This event counts demand access counted by
> L1I_CACHE_HIT_RD that hits a cache line that is in the process of being l=
oaded
> into the Level 1 instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access counted by
> L1D_CACHE_HIT_RD that hits a cache line that is in the process of being l=
oaded
> into the Level 1 data cache.",
> +        "EventCode": "0x8244",
> +        "EventName": "L1D_LFB_HIT_RD",
> +        "BriefDescription": "This event counts demand access counted by
> L1D_CACHE_HIT_RD that hits a cache line that is in the process of being l=
oaded
> into the Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access counted by
> L2D_CACHE_HIT_RD that hits a recently fetched line in the Level 2 cache."=
,
> +        "EventCode": "0x8245",
> +        "EventName": "L2D_LFB_HIT_RD",
> +        "BriefDescription": "This event counts demand access counted by
> L2D_CACHE_HIT_RD that hits a recently fetched line in the Level 2 cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access counted by
> L1D_CACHE_HIT_WR that hits a cache line that is in the process of being l=
oaded
> into the Level 1 data cache.",
> +        "EventCode": "0x8248",
> +        "EventName": "L1D_LFB_HIT_WR",
> +        "BriefDescription": "This event counts demand access counted by
> L1D_CACHE_HIT_WR that hits a cache line that is in the process of being l=
oaded
> into the Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access counted by
> L2D_CACHE_HIT_WR that hits a recently fetched line in the Level 2 cache."=
,
> +        "EventCode": "0x8249",
> +        "EventName": "L2D_LFB_HIT_WR",
> +        "BriefDescription": "This event counts demand access counted by
> L2D_CACHE_HIT_WR that hits a recently fetched line in the Level 2 cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts fetch counted by either =
Level 1
> instruction hardware prefetch or Level 1 instruction software prefetch.",
> +        "EventCode": "0x8280",
> +        "EventName": "L1I_CACHE_PRF",
> +        "BriefDescription": "This event counts fetch counted by either L=
evel 1
> instruction hardware prefetch or Level 1 instruction software prefetch."
> +    },
> +    {
> +        "PublicDescription": "This event counts fetch counted by either =
Level 1
> data hardware prefetch or Level 1 data software prefetch.",
> +        "EventCode": "0x8284",
> +        "EventName": "L1D_CACHE_PRF",
> +        "BriefDescription": "This event counts fetch counted by either L=
evel 1
> data hardware prefetch or Level 1 data software prefetch."
> +    },
> +    {
> +        "PublicDescription": "This event counts fetch counted by either =
Level 2
> data hardware prefetch or Level 2 data software prefetch.",
> +        "EventCode": "0x8285",
> +        "EventName": "L2D_CACHE_PRF",
> +        "BriefDescription": "This event counts fetch counted by either L=
evel 2
> data hardware prefetch or Level 2 data software prefetch."
> +    },
> +    {
> +        "PublicDescription": "This event counts hardware prefetch counte=
d by
> L1I_CACHE_PRF that causes a refill of the Level 1 instruction cache from =
outside
> of the Level 1 instruction cache.",
> +        "EventCode": "0x8288",
> +        "EventName": "L1I_CACHE_REFILL_PRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by
> L1I_CACHE_PRF that causes a refill of the Level 1 instruction cache from =
outside
> of the Level 1 instruction cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts hardware prefetch counte=
d by
> L1D_CACHE_PRF that causes a refill of the Level 1 data cache from outside=
 of the
> Level 1 data cache.",
> +        "EventCode": "0x828C",
> +        "EventName": "L1D_CACHE_REFILL_PRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by
> L1D_CACHE_PRF that causes a refill of the Level 1 data cache from outside=
 of the
> Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts hardware prefetch counte=
d by
> L2D_CACHE_PRF that causes a refill of the Level 2 data cache from outside=
 of the
> Level 1 data cache.",
> +        "EventCode": "0x828D",
> +        "EventName": "L2D_CACHE_REFILL_PRF",
> +        "BriefDescription": "This event counts hardware prefetch counted=
 by
> L2D_CACHE_PRF that causes a refill of the Level 2 data cache from outside=
 of the
> Level 1 data cache."
> +    },
> +    {
> +        "PublicDescription": "The counter counts by the number of cache =
refills
> counted by L1D_CACHE_REFILL in progress on each Processor cycle.",
> +        "EventCode": "0x8320",
> +        "EventName": "L1D_CACHE_REFILL_PERCYC",
> +        "BriefDescription": "The counter counts by the number of cache r=
efills
> counted by L1D_CACHE_REFILL in progress on each Processor cycle."
> +    },
> +    {
> +        "PublicDescription": "The counter counts by the number of cache =
refills
> counted by L2D_CACHE_REFILL in progress on each Processor cycle.",
> +        "EventCode": "0x8321",
> +        "EventName": "L2D_CACHE_REFILL_PERCYC",
> +        "BriefDescription": "The counter counts by the number of cache r=
efills
> counted by L2D_CACHE_REFILL in progress on each Processor cycle."
> +    },
> +    {
> +        "PublicDescription": "The counter counts by the number of cache =
refills
> counted by L1I_CACHE_REFILL in progress on each Processor cycle.",
> +        "EventCode": "0x8324",
> +        "EventName": "L1I_CACHE_REFILL_PERCYC",
> +        "BriefDescription": "The counter counts by the number of cache r=
efills
> counted by L1I_CACHE_REFILL in progress on each Processor cycle."
>      }
>  ]
> diff --git
> a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
> new file mode 100644
> index 000000000000..d871dabd5385
> --- /dev/null
> +++
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
> @@ -0,0 +1,146 @@
> +[
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the oldest and uncommitted load/store/prefetch
> operation waits for L2 cache miss.",
> +        "EventCode": "0x019C",
> +        "EventName": "LD_COMP_WAIT_L2_MISS",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the oldest and uncommitted load/store/prefetch
> operation waits for L2 cache miss."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the oldest and uncommitted integer load operation w=
aits
> for L2 cache miss.",
> +        "EventCode": "0x019D",
> +        "EventName": "LD_COMP_WAIT_L2_MISS_EX",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the oldest and uncommitted integer load operation w=
aits
> for L2 cache miss."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the oldest and uncommitted load/store/prefetch
> operation waits for L2 cache access.",
> +        "EventCode": "0x0182",
> +        "EventName": "LD_COMP_WAIT_L1_MISS",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the oldest and uncommitted load/store/prefetch
> operation waits for L2 cache access."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the oldest and uncommitted integer load operation w=
aits
> for L2 cache access.",
> +        "EventCode": "0x0183",
> +        "EventName": "LD_COMP_WAIT_L1_MISS_EX",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the oldest and uncommitted integer load operation w=
aits
> for L2 cache access."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the oldest and uncommitted load/store/prefetch
> operation waits for L1D cache, L2 cache and memory access.",
> +        "EventCode": "0x0184",
> +        "EventName": "LD_COMP_WAIT",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the oldest and uncommitted load/store/prefetch
> operation waits for L1D cache, L2 cache and memory access."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the oldest and uncommitted integer load operation w=
aits
> for L1D cache, L2 cache and memory access.",
> +        "EventCode": "0x0185",
> +        "EventName": "LD_COMP_WAIT_EX",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the oldest and uncommitted integer load operation w=
aits
> for L1D cache, L2 cache and memory access."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed due to the lack of an available prefetch port.",
> +        "EventCode": "0x0186",
> +        "EventName": "LD_COMP_WAIT_PFP_BUSY",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed due to the lack of an available prefetch port."
> +    },
> +    {
> +        "PublicDescription": "This event counts the
> LD_COMP_WAIT_PFP_BUSY caused by an integer load operation.",
> +        "EventCode": "0x0187",
> +        "EventName": "LD_COMP_WAIT_PFP_BUSY_EX",
> +        "BriefDescription": "This event counts the
> LD_COMP_WAIT_PFP_BUSY caused by an integer load operation."
> +    },
> +    {
> +        "PublicDescription": "This event counts the
> LD_COMP_WAIT_PFP_BUSY caused by a software prefetch instruction.",
> +        "EventCode": "0x0188",
> +        "EventName": "LD_COMP_WAIT_PFP_BUSY_SWPF",
> +        "BriefDescription": "This event counts the
> LD_COMP_WAIT_PFP_BUSY caused by a software prefetch instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed and the oldest and uncommitted instruction is an integer or
> floating-point/SIMD instruction.",
> +        "EventCode": "0x0189",
> +        "EventName": "EU_COMP_WAIT",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed and the oldest and uncommitted instruction is an integer or
> floating-point/SIMD instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed and the oldest and uncommitted instruction is a
> floating-point/SIMD instruction.",
> +        "EventCode": "0x018A",
> +        "EventName": "FL_COMP_WAIT",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed and the oldest and uncommitted instruction is a
> floating-point/SIMD instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed and the oldest and uncommitted instruction is a branch
> instruction.",
> +        "EventCode": "0x018B",
> +        "EventName": "BR_COMP_WAIT",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed and the oldest and uncommitted instruction is a branch
> instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the CSE is empty.",
> +        "EventCode": "0x018C",
> +        "EventName": "ROB_EMPTY",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the CSE is empty."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed because the CSE is empty and the store port (SP) is full.",
> +        "EventCode": "0x018D",
> +        "EventName": "ROB_EMPTY_STQ_BUSY",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed because the CSE is empty and the store port (SP) is full."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that the ins=
truction
> unit is halted by the WFE/WFI instruction.",
> +        "EventCode": "0x018E",
> +        "EventName": "WFE_WFI_CYCLE",
> +        "BriefDescription": "This event counts every cycle that the inst=
ruction
> unit is halted by the WFE/WFI instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that the ins=
truction
> unit is halted by the RETENTION state.",
> +        "EventCode": "0x018F",
> +        "EventName": "RETENTION_CYCLE",
> +        "BriefDescription": "This event counts every cycle that the inst=
ruction
> unit is halted by the RETENTION state."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that no inst=
ruction
> was committed, but counts at the time when commits MOVPRFX only.",
> +        "EventCode": "0x0190",
> +        "EventName": "_0INST_COMMIT",
> +        "BriefDescription": "This event counts every cycle that no instr=
uction
> was committed, but counts at the time when commits MOVPRFX only."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that one ins=
truction
> is committed.",
> +        "EventCode": "0x0191",
> +        "EventName": "_1INST_COMMIT",
> +        "BriefDescription": "This event counts every cycle that one inst=
ruction
> is committed."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that two
> instructions are committed.",
> +        "EventCode": "0x0192",
> +        "EventName": "_2INST_COMMIT",
> +        "BriefDescription": "This event counts every cycle that two inst=
ructions
> are committed."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that three
> instructions are committed.",
> +        "EventCode": "0x0193",
> +        "EventName": "_3INST_COMMIT",
> +        "BriefDescription": "This event counts every cycle that three
> instructions are committed."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that four
> instructions are committed.",
> +        "EventCode": "0x0194",
> +        "EventName": "_4INST_COMMIT",
> +        "BriefDescription": "This event counts every cycle that four ins=
tructions
> are committed."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that five
> instructions are committed.",
> +        "EventCode": "0x0195",
> +        "EventName": "_5INST_COMMIT",
> +        "BriefDescription": "This event counts every cycle that five ins=
tructions
> are committed."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that only an=
y
> micro-operations are committed.",
> +        "EventCode": "0x0198",
> +        "EventName": "UOP_ONLY_COMMIT",
> +        "BriefDescription": "This event counts every cycle that only any
> micro-operations are committed."
> +    },
> +    {
> +        "PublicDescription": "This event counts every cycle that only th=
e
> MOVPRFX instruction is committed.",
> +        "EventCode": "0x0199",
> +        "EventName": "SINGLE_MOVPRFX_COMMIT",
> +        "BriefDescription": "This event counts every cycle that only the
> MOVPRFX instruction is committed."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
> new file mode 100644
> index 000000000000..8ea3baf2d610
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
> @@ -0,0 +1,20 @@
> +[
> +    {
> +        "PublicDescription": "This event counts energy consumption of co=
re.",
> +        "EventCode": "0x01F0",
> +        "EventName": "EA_CORE",
> +        "BriefDescription": "This event counts energy consumption of cor=
e."
> +    },
> +    {
> +        "PublicDescription": "This event counts energy consumption of L3
> cache.",
> +        "EventCode": "0x03F0",
> +        "EventName": "EA_L3",
> +        "BriefDescription": "This event counts energy consumption of L3
> cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts energy consumption of LD=
O
> loss.",
> +        "EventCode": "0x03F1",
> +        "EventName": "EA_LDO_LOSS",
> +        "BriefDescription": "This event counts energy consumption of LDO
> loss."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.js=
on
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
> new file mode 100644
> index 000000000000..89f3206f8621
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
> @@ -0,0 +1,32 @@
> +[
> +    {
> +        "ArchStdEvent": "EXC_TAKEN"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_RETURN"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_UNDEF"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SVC"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_PABORT"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_DABORT"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SMC"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_HVC"
> +    }
> +]
> diff --git
> a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> new file mode 100644
> index 000000000000..1385bf183d73
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> @@ -0,0 +1,194 @@
> +[
> +    {
> +        "ArchStdEvent": "FP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_HP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_HP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_HP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_HP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_SP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_SP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_SP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_SP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_DP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_DP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_DP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_DP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_DIV_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_DIV_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_DIV_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_DIV_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_SQRT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_SQRT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_SQRT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_SQRT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_FMA_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_FMA_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_FMA_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_FMA_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_ADDSUB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_ADDSUB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_ADDSUB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_ADDSUB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_RECPE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_RECPE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_RECPE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_RECPE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_CVT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_CVT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_CVT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_CVT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_AREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_FP_PREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_FP_VREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_VREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_SCALE_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_FIXED_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_HP_SCALE_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_HP_FIXED_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_SP_SCALE_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_SP_FIXED_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_DP_SCALE_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_DP_FIXED_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_DOT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_FP_MMLA_SPEC"
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> floating-point move operations.",
> +        "EventCode": "0x0105",
> +        "EventName": "FP_MV_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> floating-point move operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> NOSIMD load operations that using SIMD&FP registers.",
> +        "EventCode": "0x0112",
> +        "EventName": "FP_LD_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> NOSIMD load operations that using SIMD&FP registers."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> NOSIMD store operations that using SIMD&FP registers.",
> +        "EventCode": "0x0113",
> +        "EventName": "FP_ST_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> NOSIMD store operations that using SIMD&FP registers."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
> new file mode 100644
> index 000000000000..7c55cc25bcc4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
> @@ -0,0 +1,116 @@
> +[
> +    {
> +        "PublicDescription": "This event counts the number of cycles at
> 100MHz.",
> +        "EventCode": "0x0880",
> +        "EventName": "GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles at
> 100MHz."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 0.",
> +        "EventCode": "0x0890",
> +        "EventName": "FL0_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 0."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 1.",
> +        "EventCode": "0x0891",
> +        "EventName": "FL1_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 2.",
> +        "EventCode": "0x0892",
> +        "EventName": "FL2_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 2."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 3.",
> +        "EventCode": "0x0893",
> +        "EventName": "FL3_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 3."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 4.",
> +        "EventCode": "0x0894",
> +        "EventName": "FL4_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 4."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 5.",
> +        "EventCode": "0x0895",
> +        "EventName": "FL5_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 5."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 6.",
> +        "EventCode": "0x0896",
> +        "EventName": "FL6_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 6."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 7.",
> +        "EventCode": "0x0897",
> +        "EventName": "FL7_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 7."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 8.",
> +        "EventCode": "0x0898",
> +        "EventName": "FL8_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 8."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 9.",
> +        "EventCode": "0x0899",
> +        "EventName": "FL9_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 9."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 10.",
> +        "EventCode": "0x089A",
> +        "EventName": "FL10_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 10."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 11.",
> +        "EventCode": "0x089B",
> +        "EventName": "FL11_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 11."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 12.",
> +        "EventCode": "0x089C",
> +        "EventName": "FL12_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 12."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 13.",
> +        "EventCode": "0x089D",
> +        "EventName": "FL13_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 13."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 14.",
> +        "EventCode": "0x089E",
> +        "EventName": "FL14_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 14."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the Frequency Level 15.",
> +        "EventCode": "0x089F",
> +        "EventName": "FL15_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the Frequency Level 15."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of cycles whe=
re the
> measured core is staying in the RETENTION state.",
> +        "EventCode": "0x08A0",
> +        "EventName": "RETENTION_GCYCLES",
> +        "BriefDescription": "This event counts the number of cycles wher=
e the
> measured core is staying in the RETENTION state."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of changes fr=
om the
> normal state to the RETENTION state.",
> +        "EventCode": "0x08A1",
> +        "EventName": "RETENTION_COUNT",
> +        "BriefDescription": "This event counts the number of changes fro=
m the
> normal state to the RETENTION state."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> new file mode 100644
> index 000000000000..80bf17fb8f4c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES"
> +    },
> +    {
> +        "ArchStdEvent": "CNT_CYCLES"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
> new file mode 100644
> index 000000000000..9c595c7f6c63
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "PublicDescription": "This event counts streaming prefetch reque=
sts to
> L1D cache generated by hardware prefetcher.",
> +        "EventCode": "0x0230",
> +        "EventName": "L1HWPF_STREAM_PF",
> +        "BriefDescription": "This event counts streaming prefetch reques=
ts to
> L1D cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts stride prefetch requests=
 to L1D
> cache generated by hardware prefetcher.",
> +        "EventCode": "0x0231",
> +        "EventName": "L1HWPF_STRIDE_PF",
> +        "BriefDescription": "This event counts stride prefetch requests =
to L1D
> cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts LDS prefetch requests to=
 L1D
> cache generated by hardware prefetcher.",
> +        "EventCode": "0x0232",
> +        "EventName": "L1HWPF_PFTGT_PF",
> +        "BriefDescription": "This event counts LDS prefetch requests to =
L1D
> cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts streaming prefetch reque=
sts to
> L2 cache generated by hardware prefetcher.",
> +        "EventCode": "0x0234",
> +        "EventName": "L2HWPF_STREAM_PF",
> +        "BriefDescription": "This event counts streaming prefetch reques=
ts to
> L2 cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts stride prefetch requests=
 to L2
> cache generated by hardware prefetcher.",
> +        "EventCode": "0x0235",
> +        "EventName": "L2HWPF_STRIDE_PF",
> +        "BriefDescription": "This event counts stride prefetch requests =
to L2
> cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts prefetch requests to L2 =
cache
> generated by the other causes.",
> +        "EventCode": "0x0237",
> +        "EventName": "L2HWPF_OTHER",
> +        "BriefDescription": "This event counts prefetch requests to L2 c=
ache
> generated by the other causes."
> +    },
> +    {
> +        "PublicDescription": "This event counts streaming prefetch reque=
sts to
> L3 cache generated by hardware prefetcher.",
> +        "EventCode": "0x0238",
> +        "EventName": "L3HWPF_STREAM_PF",
> +        "BriefDescription": "This event counts streaming prefetch reques=
ts to
> L3 cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts stride prefetch requests=
 to L3
> cache generated by hardware prefetcher.",
> +        "EventCode": "0x0239",
> +        "EventName": "L3HWPF_STRIDE_PF",
> +        "BriefDescription": "This event counts stride prefetch requests =
to L3
> cache generated by hardware prefetcher."
> +    },
> +    {
> +        "PublicDescription": "This event counts prefetch requests to L3 =
cache
> generated by the other causes.",
> +        "EventCode": "0x023B",
> +        "EventName": "L3HWPF_OTHER",
> +        "BriefDescription": "This event counts prefetch requests to L3 c=
ache
> generated by the other causes."
> +    },
> +    {
> +        "PublicDescription": "This event counts next line's prefetch req=
uests to
> L1I cache generated by hardware prefetcher.",
> +        "EventCode": "0x023C",
> +        "EventName": "L1IHWPF_NEXTLINE_PF",
> +        "BriefDescription": "This event counts next line's prefetch requ=
ests to
> L1I cache generated by hardware prefetcher."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.js=
on
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
> new file mode 100644
> index 000000000000..aa8aaf9a854b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
> @@ -0,0 +1,101 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_CACHE"
> +    },
> +    {
> +        "PublicDescription": "This event counts L1D_CACHE caused by dema=
nd
> access.",
> +        "EventCode": "0x0200",
> +        "EventName": "L1D_CACHE_DM",
> +        "BriefDescription": "This event counts L1D_CACHE caused by deman=
d
> access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L1D_CACHE caused by dema=
nd
> read access.",
> +        "EventCode": "0x0201",
> +        "EventName": "L1D_CACHE_DM_RD",
> +        "BriefDescription": "This event counts L1D_CACHE caused by deman=
d
> read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L1D_CACHE caused by dema=
nd
> write access.",
> +        "EventCode": "0x0202",
> +        "EventName": "L1D_CACHE_DM_WR",
> +        "BriefDescription": "This event counts L1D_CACHE caused by deman=
d
> write access."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_PRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_HWPRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_MISS"
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access that hits =
cache
> line with shared status and requests exclusive access in the Level 1 data=
 cache,
> causing a coherence access to outside of the Level 1 caches of this PE.",
> +        "EventCode": "0x020D",
> +        "EventName": "L1D_CACHE_BTC",
> +        "BriefDescription": "This event counts demand access that hits c=
ache
> line with shared status and requests exclusive access in the Level 1 data=
 cache,
> causing a coherence access to outside of the Level 1 caches of this PE."
> +    },
> +    {
> +        "PublicDescription": "This event counts L1D_CACHE_REFILL caused =
by
> demand access.",
> +        "EventCode": "0x0208",
> +        "EventName": "L1D_CACHE_REFILL_DM",
> +        "BriefDescription": "This event counts L1D_CACHE_REFILL caused b=
y
> demand access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L1D_CACHE_REFILL caused =
by
> demand read access.",
> +        "EventCode": "0x0209",
> +        "EventName": "L1D_CACHE_REFILL_DM_RD",
> +        "BriefDescription": "This event counts L1D_CACHE_REFILL caused b=
y
> demand read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L1D_CACHE_REFILL caused =
by
> demand write access.",
> +        "EventCode": "0x020A",
> +        "EventName": "L1D_CACHE_REFILL_DM_WR",
> +        "BriefDescription": "This event counts L1D_CACHE_REFILL caused b=
y
> demand write access."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_PRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_HWPRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_HIT"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_HIT_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_HIT_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_LFB_HIT_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_LFB_HIT_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_PERCYC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.js=
on
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
> new file mode 100644
> index 000000000000..345abfe370a1
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
> @@ -0,0 +1,47 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_CACHE"
> +    },
> +    {
> +        "PublicDescription": "This event counts L1I_CACHE caused by dema=
nd
> read access.",
> +        "EventCode": "0x0207",
> +        "EventName": "L1I_CACHE_DM_RD",
> +        "BriefDescription": "This event counts L1I_CACHE caused by deman=
d
> read access."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_PRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_HWPRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL"
> +    },
> +    {
> +        "PublicDescription": "This event counts L1I_CACHE_REFILL caused =
by
> demand read access.",
> +        "EventCode": "0x020F",
> +        "EventName": "L1I_CACHE_REFILL_DM_RD",
> +        "BriefDescription": "This event counts L1I_CACHE_REFILL caused b=
y
> demand read access."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL_PRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL_HWPRF"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_LMISS"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_HIT"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_HIT_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_LFB_HIT_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL_PERCYC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.jso=
n
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
> new file mode 100644
> index 000000000000..0e77c5bcadaa
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
> @@ -0,0 +1,146 @@
> +[
> +    {
> +        "ArchStdEvent": "L2D_CACHE"
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE caused by dema=
nd
> access.",
> +        "EventCode": "0x0300",
> +        "EventName": "L2D_CACHE_DM",
> +        "BriefDescription": "This event counts L2D_CACHE caused by deman=
d
> access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE caused by dema=
nd
> read access.",
> +        "EventCode": "0x0301",
> +        "EventName": "L2D_CACHE_DM_RD",
> +        "BriefDescription": "This event counts L2D_CACHE caused by deman=
d
> read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE caused by dema=
nd
> write access.",
> +        "EventCode": "0x0302",
> +        "EventName": "L2D_CACHE_DM_WR",
> +        "BriefDescription": "This event counts L2D_CACHE caused by deman=
d
> write access."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_PRF"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_HWPRF"
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE caused by
> hardware adjacent prefetch access.",
> +        "EventCode": "0x0305",
> +        "EventName": "L2D_CACHE_HWPRF_ADJACENT",
> +        "BriefDescription": "This event counts L2D_CACHE caused by
> hardware adjacent prefetch access."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_MISS"
> +    },
> +    {
> +        "PublicDescription": "This event counts demand access that hits =
cache
> line with shared status and requests exclusive access in the Level 1 data=
 and
> Level 2 caches, causing a coherence access to outside of the Level 1 and =
Level 2
> caches of this PE.",
> +        "EventCode": "0x030D",
> +        "EventName": "L2D_CACHE_BTC",
> +        "BriefDescription": "This event counts demand access that hits c=
ache
> line with shared status and requests exclusive access in the Level 1 data=
 and
> Level 2 caches, causing a coherence access to outside of the Level 1 and =
Level 2
> caches of this PE."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused =
by
> demand access.",
> +        "EventCode": "0x0308",
> +        "EventName": "L2D_CACHE_REFILL_DM",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused b=
y
> demand access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused =
by
> demand read access.",
> +        "EventCode": "0x0309",
> +        "EventName": "L2D_CACHE_REFILL_DM_RD",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused b=
y
> demand read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused =
by
> demand write access.",
> +        "EventCode": "0x030A",
> +        "EventName": "L2D_CACHE_REFILL_DM_WR",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused b=
y
> demand write access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused =
by
> demand write exclusive access.",
> +        "EventCode": "0x030B",
> +        "EventName": "L2D_CACHE_REFILL_DM_WR_EXCL",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused b=
y
> demand write exclusive access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL caused =
by
> demand write atomic access.",
> +        "EventCode": "0x030C",
> +        "EventName": "L2D_CACHE_REFILL_DM_WR_ATOM",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL caused b=
y
> demand write atomic access."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_PRF"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_HWPRF"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_HIT"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_HIT_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_HIT_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_LFB_HIT_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_LFB_HIT_WR"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
> +    },
> +    {
> +        "PublicDescription": "This event counts every write-back of data=
 from
> the L2 cache caused by L2 replace where the data is clean. In this case, =
the data
> will usually be written to L3 cache.",
> +        "EventCode": "0x03B0",
> +        "EventName": "L2D_CACHE_WB_VICTIM_CLEAN",
> +        "BriefDescription": "This event counts every write-back of data =
from
> the L2 cache caused by L2 replace where the data is clean. In this case, =
the data
> will usually be written to L3 cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts every write-back of data=
 from
> the L2 cache caused by non-temporal-store.",
> +        "EventCode": "0x03B1",
> +        "EventName": "L2D_CACHE_WB_NT",
> +        "BriefDescription": "This event counts every write-back of data =
from
> the L2 cache caused by non-temporal-store."
> +    },
> +    {
> +        "PublicDescription": "This event counts every write-back of data=
 from
> the L2 cache caused by DC ZVA.",
> +        "EventCode": "0x03B2",
> +        "EventName": "L2D_CACHE_WB_DCZVA",
> +        "BriefDescription": "This event counts every write-back of data =
from
> the L2 cache caused by DC ZVA."
> +    },
> +    {
> +        "PublicDescription": "This event counts every flush-back (drop) =
of data
> from the L2 cache.",
> +        "EventCode": "0x03B3",
> +        "EventName": "L2D_CACHE_FB",
> +        "BriefDescription": "This event counts every flush-back (drop) o=
f data
> from the L2 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_PERCYC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.jso=
n
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
> new file mode 100644
> index 000000000000..aaf129bc0608
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
> @@ -0,0 +1,185 @@
> +[
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
cache
> access to the L3 cache.",
> +        "EventCode": "0x0390",
> +        "EventName": "L2D_CACHE_REFILL_L3D_CACHE",
> +        "BriefDescription": "This event counts operations that cause a c=
ache
> access to the L3 cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by demand access.",
> +        "EventCode": "0x0391",
> +        "EventName": "L2D_CACHE_REFILL_L3D_CACHE_DM",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by demand access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by demand read access.",
> +        "EventCode": "0x0392",
> +        "EventName": "L2D_CACHE_REFILL_L3D_CACHE_DM_RD",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by demand read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by demand write access.",
> +        "EventCode": "0x0393",
> +        "EventName": "L2D_CACHE_REFILL_L3D_CACHE_DM_WR",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by demand write access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by prefetch access.",
> +        "EventCode": "0x0394",
> +        "EventName": "L2D_CACHE_REFILL_L3D_CACHE_PRF",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by prefetch access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch access.",
> +        "EventCode": "0x0395",
> +        "EventName": "L2D_CACHE_REFILL_L3D_CACHE_HWPRF",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch access."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
miss of
> the L3 cache.",
> +        "EventCode": "0x0396",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS",
> +        "BriefDescription": "This event counts operations that cause a m=
iss of
> the L3 cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS caused by demand access.",
> +        "EventCode": "0x0397",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS
> caused by demand access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS caused by demand read access.",
> +        "EventCode": "0x0398",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_RD",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS
> caused by demand read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS caused by demand write access.",
> +        "EventCode": "0x0399",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_WR",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS
> caused by demand write access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS caused by prefetch access.",
> +        "EventCode": "0x039A",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PRF",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS
> caused by prefetch access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS caused by hardware prefetch access.",
> +        "EventCode": "0x039B",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_HWPRF",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS
> caused by hardware prefetch access."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
hit of
> the L3 cache.",
> +        "EventCode": "0x039C",
> +        "EventName": "L2D_CACHE_REFILL_L3D_HIT",
> +        "BriefDescription": "This event counts operations that cause a h=
it of the
> L3 cache."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by demand access.",
> +        "EventCode": "0x039D",
> +        "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by demand access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by demand read access.",
> +        "EventCode": "0x039E",
> +        "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM_RD",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by demand read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by demand write access.",
> +        "EventCode": "0x039F",
> +        "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM_WR",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by demand write access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by prefetch access.",
> +        "EventCode": "0x03A0",
> +        "EventName": "L2D_CACHE_REFILL_L3D_HIT_PRF",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by prefetch access."
> +    },
> +    {
> +        "PublicDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by hardware prefetch access.",
> +        "EventCode": "0x03A1",
> +        "EventName": "L2D_CACHE_REFILL_L3D_HIT_HWPRF",
> +        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT
> caused by hardware prefetch access."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests hit the PFTGT buffer.",
> +        "EventCode": "0x03A2",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests hit the PFTGT buffer."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand access.",
> +        "EventCode": "0x03A3",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT_DM",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand read access.",
> +        "EventCode": "0x03A4",
> +        "EventName":
> "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT_DM_RD",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand read access."
> +    },
> +    {
> +        "PublicDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand write access.",
> +        "EventCode": "0x03A5",
> +        "EventName":
> "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT_DM_WR",
> +        "BriefDescription": "This event counts
> L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT caused by demand write access."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access the memory in the same socket as the requests."=
,
> +        "EventCode": "0x03A6",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_L_MEM",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access the memory in the same socket as the requests."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access the memory in the different socket from the req=
uests.",
> +        "EventCode": "0x03A7",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_MEM",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access the memory in the different socket from the req=
uests."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access the different L2 cache from the requests in the=
 same
> Numa nodes as the requests.",
> +        "EventCode": "0x03A8",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_L_L2",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access the different L2 cache from the requests in the=
 same
> Numa nodes as the requests."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access L2 cache in the different Numa nodes from the
> requests in the same socket as the requests.",
> +        "EventCode": "0x03A9",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_NR_L2",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access L2 cache in the different Numa nodes from the
> requests in the same socket as the requests."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access L3 cache in the different Numa nodes from the
> requests in the same socket as the requests.",
> +        "EventCode": "0x03AA",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_NR_L3",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access L3 cache in the different Numa nodes from the
> requests in the same socket as the requests."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access L2 cache in the different socket from the reque=
sts.",
> +        "EventCode": "0x03AB",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_L2",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access L2 cache in the different socket from the reque=
sts."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of L3 cache m=
isses
> where the requests access L3 cache in the different socket from the reque=
sts.",
> +        "EventCode": "0x03AC",
> +        "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_L3",
> +        "BriefDescription": "This event counts the number of L3 cache mi=
sses
> where the requests access L3 cache in the different socket from the reque=
sts."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_LMISS_RD"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.jso=
n
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
> new file mode 100644
> index 000000000000..6bfe4d4768a2
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "ArchStdEvent": "LL_CACHE_RD"
> +    },
> +    {
> +        "ArchStdEvent": "LL_CACHE_MISS_RD"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
> new file mode 100644
> index 000000000000..7542c82181e3
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
> @@ -0,0 +1,8 @@
> +[
> +    {
> +        "ArchStdEvent": "MEM_ACCESS"
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.jso=
n
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
> new file mode 100644
> index 000000000000..a021f31141ab
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
> @@ -0,0 +1,230 @@
> +[
> +    {
> +        "PublicDescription": "This event counts valid cycles of EAGA pip=
eline.",
> +        "EventCode": "0x01A0",
> +        "EventName": "EAGA_VAL",
> +        "BriefDescription": "This event counts valid cycles of EAGA pipe=
line."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of EAGB pip=
eline.",
> +        "EventCode": "0x01A1",
> +        "EventName": "EAGB_VAL",
> +        "BriefDescription": "This event counts valid cycles of EAGB pipe=
line."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of PRX pipe=
line.",
> +        "EventCode": "0x01A3",
> +        "EventName": "PRX_VAL",
> +        "BriefDescription": "This event counts valid cycles of PRX pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of EXA pipe=
line.",
> +        "EventCode": "0x01A4",
> +        "EventName": "EXA_VAL",
> +        "BriefDescription": "This event counts valid cycles of EXA pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of EXB pipe=
line.",
> +        "EventCode": "0x01A5",
> +        "EventName": "EXB_VAL",
> +        "BriefDescription": "This event counts valid cycles of EXB pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of EXC pipe=
line.",
> +        "EventCode": "0x01A6",
> +        "EventName": "EXC_VAL",
> +        "BriefDescription": "This event counts valid cycles of EXC pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of EXD pipe=
line.",
> +        "EventCode": "0x01A7",
> +        "EventName": "EXD_VAL",
> +        "BriefDescription": "This event counts valid cycles of EXD pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of FLA pipe=
line.",
> +        "EventCode": "0x01A8",
> +        "EventName": "FLA_VAL",
> +        "BriefDescription": "This event counts valid cycles of FLA pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of FLB pipe=
line.",
> +        "EventCode": "0x01A9",
> +        "EventName": "FLB_VAL",
> +        "BriefDescription": "This event counts valid cycles of FLB pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of STEA pip=
eline.",
> +        "EventCode": "0x01AA",
> +        "EventName": "STEA_VAL",
> +        "BriefDescription": "This event counts valid cycles of STEA pipe=
line."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of STEB pip=
eline.",
> +        "EventCode": "0x01AB",
> +        "EventName": "STEB_VAL",
> +        "BriefDescription": "This event counts valid cycles of STEB pipe=
line."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of STFL pip=
eline.",
> +        "EventCode": "0x01AC",
> +        "EventName": "STFL_VAL",
> +        "BriefDescription": "This event counts valid cycles of STFL pipe=
line."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of STPX pip=
eline.",
> +        "EventCode": "0x01AD",
> +        "EventName": "STPX_VAL",
> +        "BriefDescription": "This event counts valid cycles of STPX pipe=
line."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of 1's in the
> predicate bits of request in FLA pipeline, where it is corrected so that =
it becomes
> 32 when all bits are 1.",
> +        "EventCode": "0x01B0",
> +        "EventName": "FLA_VAL_PRD_CNT",
> +        "BriefDescription": "This event counts the number of 1's in the
> predicate bits of request in FLA pipeline, where it is corrected so that =
it becomes
> 32 when all bits are 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of 1's in the
> predicate bits of request in FLB pipeline, where it is corrected so that =
it becomes
> 32 when all bits are 1.",
> +        "EventCode": "0x01B1",
> +        "EventName": "FLB_VAL_PRD_CNT",
> +        "BriefDescription": "This event counts the number of 1's in the
> predicate bits of request in FLB pipeline, where it is corrected so that =
it becomes
> 32 when all bits are 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of FLA pipe=
line.",
> +        "EventCode": "0x01B2",
> +        "EventName": "FLA_VAL_FOR_PRD",
> +        "BriefDescription": "This event counts valid cycles of FLA pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of FLB pipe=
line.",
> +        "EventCode": "0x01B3",
> +        "EventName": "FLB_VAL_FOR_PRD",
> +        "BriefDescription": "This event counts valid cycles of FLB pipel=
ine."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of L1D cach=
e
> pipeline#0.",
> +        "EventCode": "0x0240",
> +        "EventName": "L1_PIPE0_VAL",
> +        "BriefDescription": "This event counts valid cycles of L1D cache
> pipeline#0."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of L1D cach=
e
> pipeline#1.",
> +        "EventCode": "0x0241",
> +        "EventName": "L1_PIPE1_VAL",
> +        "BriefDescription": "This event counts valid cycles of L1D cache
> pipeline#1."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of L1D cach=
e
> pipeline#2.",
> +        "EventCode": "0x0242",
> +        "EventName": "L1_PIPE2_VAL",
> +        "BriefDescription": "This event counts valid cycles of L1D cache
> pipeline#2."
> +    },
> +    {
> +        "PublicDescription": "This event counts requests in L1D cache
> pipeline#0 that its sce bit of tagged address is 1.",
> +        "EventCode": "0x0278",
> +        "EventName": "L1_PIPE0_VAL_IU_TAG_ADRS_SCE",
> +        "BriefDescription": "This event counts requests in L1D cache
> pipeline#0 that its sce bit of tagged address is 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts requests in L1D cache
> pipeline#0 that its sector cache ID is not 0.",
> +        "EventCode": "0x02A0",
> +        "EventName": "L1_PIPE0_VAL_IU_NOT_SEC0",
> +        "BriefDescription": "This event counts requests in L1D cache
> pipeline#0 that its sector cache ID is not 0."
> +    },
> +    {
> +        "PublicDescription": "This event counts requests in L1D cache
> pipeline#1 that its sector cache ID is not 0.",
> +        "EventCode": "0x02A1",
> +        "EventName": "L1_PIPE1_VAL_IU_NOT_SEC0",
> +        "BriefDescription": "This event counts requests in L1D cache
> pipeline#1 that its sector cache ID is not 0."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of times wher=
e 2
> elements of the gather instructions became 2 flows because 2 elements cou=
ld not
> be combined.",
> +        "EventCode": "0x02B0",
> +        "EventName": "L1_PIPE_COMP_GATHER_2FLOW",
> +        "BriefDescription": "This event counts the number of times where=
 2
> elements of the gather instructions became 2 flows because 2 elements cou=
ld not
> be combined."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of times wher=
e 2
> elements of the gather instructions became 1 flow because 2 elements coul=
d be
> combined.",
> +        "EventCode": "0x02B1",
> +        "EventName": "L1_PIPE_COMP_GATHER_1FLOW",
> +        "BriefDescription": "This event counts the number of times where=
 2
> elements of the gather instructions became 1 flow because 2 elements coul=
d be
> combined."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of times wher=
e 2
> elements of the gather instructions became 0 flow because both predicate =
values
> are 0.",
> +        "EventCode": "0x02B2",
> +        "EventName": "L1_PIPE_COMP_GATHER_0FLOW",
> +        "BriefDescription": "This event counts the number of times where=
 2
> elements of the gather instructions became 0 flow because both predicate =
values
> are 0."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of flows of t=
he
> scatter instructions.",
> +        "EventCode": "0x02B3",
> +        "EventName": "L1_PIPE_COMP_SCATTER_1FLOW",
> +        "BriefDescription": "This event counts the number of flows of th=
e
> scatter instructions."
> +    },
> +    {
> +        "PublicDescription": "This event counts completed requests in L1=
D
> cache pipeline#0.",
> +        "EventCode": "0x0250",
> +        "EventName": "L1_PIPE0_COMP",
> +        "BriefDescription": "This event counts completed requests in L1D
> cache pipeline#0."
> +    },
> +    {
> +        "PublicDescription": "This event counts completed requests in L1=
D
> cache pipeline#1.",
> +        "EventCode": "0x0251",
> +        "EventName": "L1_PIPE1_COMP",
> +        "BriefDescription": "This event counts completed requests in L1D
> cache pipeline#1."
> +    },
> +    {
> +        "PublicDescription": "This event counts completed requests in L1=
I
> cache pipeline.",
> +        "EventCode": "0x026C",
> +        "EventName": "L1I_PIPE_COMP",
> +        "BriefDescription": "This event counts completed requests in L1I=
 cache
> pipeline."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of L1I cach=
e
> pipeline.",
> +        "EventCode": "0x026D",
> +        "EventName": "L1I_PIPE_VAL",
> +        "BriefDescription": "This event counts valid cycles of L1I cache
> pipeline."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of 1's in the
> predicate bits of request in L1D cache pipeline#0, where it is corrected =
so that it
> becomes 64 when all bits are 1.",
> +        "EventCode": "0x02B8",
> +        "EventName": "L1_PIPE0_COMP_PRD_CNT",
> +        "BriefDescription": "This event counts the number of 1's in the
> predicate bits of request in L1D cache pipeline#0, where it is corrected =
so that it
> becomes 64 when all bits are 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts the number of 1's in the
> predicate bits of request in L1D cache pipeline#1, where it is corrected =
so that it
> becomes 64 when all bits are 1.",
> +        "EventCode": "0x02B9",
> +        "EventName": "L1_PIPE1_COMP_PRD_CNT",
> +        "BriefDescription": "This event counts the number of 1's in the
> predicate bits of request in L1D cache pipeline#1, where it is corrected =
so that it
> becomes 64 when all bits are 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts valid cycles of L2 cache
> pipeline.",
> +        "EventCode": "0x0330",
> +        "EventName": "L2_PIPE_VAL",
> +        "BriefDescription": "This event counts valid cycles of L2 cache
> pipeline."
> +    },
> +    {
> +        "PublicDescription": "This event counts completed requests in L2=
 cache
> pipeline.",
> +        "EventCode": "0x0350",
> +        "EventName": "L2_PIPE_COMP_ALL",
> +        "BriefDescription": "This event counts completed requests in L2 =
cache
> pipeline."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations where softwar=
e or
> hardware prefetch hits an L2 cache refill buffer allocated by demand acce=
ss.",
> +        "EventCode": "0x0370",
> +        "EventName": "L2_PIPE_COMP_PF_L2MIB_MCH",
> +        "BriefDescription": "This event counts operations where software=
 or
> hardware prefetch hits an L2 cache refill buffer allocated by demand acce=
ss."
> +    },
> +    {
> +        "PublicDescription": "This event counts requests in L1D cache
> pipeline#1 that its sce bit of tagged address is 1.",
> +        "EventCode": "0x0279",
> +        "EventName": "L1_PIPE1_VAL_IU_TAG_ADRS_SCE",
> +        "BriefDescription": "This event counts requests in L1D cache
> pipeline#1 that its sce bit of tagged address is 1."
> +    },
> +    {
> +        "PublicDescription": "This event counts aborted requests in L1D
> pipelines that due to store-load interlock.",
> +        "EventCode": "0x025A",
> +        "EventName": "L1_PIPE_ABORT_STLD_INTLK",
> +        "BriefDescription": "This event counts aborted requests in L1D
> pipelines that due to store-load interlock."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
> new file mode 100644
> index 000000000000..88aeb03da683
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
> @@ -0,0 +1,29 @@
> +[
> +    {
> +        "ArchStdEvent": "SW_INCR"
> +    },
> +    {
> +        "ArchStdEvent": "INST_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "OP_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "UOP_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "SIMD_INST_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INST_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "CID_WRITE_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETIRED"
> +    },
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
> +    }
> +]
> diff --git
> a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
> new file mode 100644
> index 000000000000..fdd604cb5d5f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
> @@ -0,0 +1,158 @@
> +[
> +    {
> +        "ArchStdEvent": "INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "OP_SPEC"
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operations that uses \"pre-index\" as its addressing mode.",
> +        "EventCode": "0x0123",
> +        "EventName": "PRE_INDEX_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operations that uses \"pre-index\" as its addressing mode."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operations that uses \"post-index\" as its addressing mode.",
> +        "EventCode": "0x0124",
> +        "EventName": "POST_INDEX_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operations that uses \"post-index\" as its addressing mode."
> +    },
> +    {
> +        "ArchStdEvent": "UOP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_DIV_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_DIV64_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_MUL64_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_MULH64_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "NONFP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "PRF_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "BASE_LD_REG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "BASE_ST_REG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_SCALE_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "INT_FIXED_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "LDREX_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "STREX_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "LD_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "LDST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "DP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "VFP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "CRYPTO_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ISB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "DSB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "DMB_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "CSDB_SPEC"
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> operations that using predicate register.",
> +        "EventCode": "0x0108",
> +        "EventName": "PRD_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> operations that using predicate register."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> inter-element manipulation operations.",
> +        "EventCode": "0x0109",
> +        "EventName": "IEL_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> inter-element manipulation operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> inter-register manipulation operations.",
> +        "EventCode": "0x010A",
> +        "EventName": "IREG_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> inter-register manipulation operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 SIMD
> broadcast floating-point load operations.",
> +        "EventCode": "0x011A",
> +        "EventName": "BC_LD_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
SIMD
> broadcast floating-point load operations."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed=
 zero
> blocking operations due to the \"DC ZVA\" instruction.",
> +        "EventCode": "0x011B",
> +        "EventName": "DCZVA_SPEC",
> +        "BriefDescription": "This event counts architecturally executed =
zero
> blocking operations due to the \"DC ZVA\" instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts architecturally executed
> instructions, excluding the MOVPRFX instruction.",
> +        "EventCode": "0x0121",
> +        "EventName": "EFFECTIVE_INST_SPEC",
> +        "BriefDescription": "This event counts architecturally executed
> instructions, excluding the MOVPRFX instruction."
> +    },
> +    {
> +        "PublicDescription": "This event counts the occurrence count of =
the
> micro-operation split.",
> +        "EventCode": "0x0139",
> +        "EventName": "UOP_SPLIT",
> +        "BriefDescription": "This event counts the occurrence count of t=
he
> micro-operation split."
> +    },
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED"
> +    },
> +    {
> +        "ArchStdEvent": "BR_PRED"
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
> new file mode 100644
> index 000000000000..9fa1e736b964
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
> @@ -0,0 +1,83 @@
> +[
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT_BACKEND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT_FRONTEND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_MEM"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_MEMBOUND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_L1I"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_L2I"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_MEM"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_CPUBOUND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_FLOW"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_FLUSH"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND_RENAME"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_MEMBOUND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_L1D"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_L2D"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_ST"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_CPUBOUND"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_BUSY"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_ILOCK"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_RENAME"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_ATOMIC"
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_MEMCPYSET"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
> new file mode 100644
> index 000000000000..b26f842356a4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
> @@ -0,0 +1,146 @@
> +[
> +    {
> +        "ArchStdEvent": "ASE_INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_MATH_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_INT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_DIV_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_DIV64_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_INT_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT_MUL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_MUL64_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_MULH64_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_NONFP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_NONFP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_NONFP_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_INT_VREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INT_VREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT_VREDUCE_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PERM_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_XPIPE_Z2R_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_XPIPE_R2Z_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PGEN_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PGEN_FLG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PPERM_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_MOVPRFX_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_MOVPRFX_Z_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_MOVPRFX_M_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_MOVPRFX_U_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_LD_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_ST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDR_REG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_STR_REG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDR_PREG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_STR_PREG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRF_CONTIG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDNT_CONTIG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_STNT_CONTIG_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_LD_MULTI_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_ST_MULTI_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LD_GATHER_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_ST_SCATTER_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRF_GATHER_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDFF_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT_DOT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT_MMLA_SPEC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
> new file mode 100644
> index 000000000000..0cc37bc8e177
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
> @@ -0,0 +1,404 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2I_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB"
> +    },
> +    {
> +        "ArchStdEvent": "L2I_TLB_REFILL"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL"
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 4KB page.",
> +        "EventCode": "0x0C00",
> +        "EventName": "L1I_TLB_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 64KB page.",
> +        "EventCode": "0x0C01",
> +        "EventName": "L1I_TLB_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 2MB page.",
> +        "EventCode": "0x0C02",
> +        "EventName": "L1I_TLB_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 32MB page.",
> +        "EventCode": "0x0C03",
> +        "EventName": "L1I_TLB_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 512MB page.",
> +        "EventCode": "0x0C04",
> +        "EventName": "L1I_TLB_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 1GB page.",
> +        "EventCode": "0x0C05",
> +        "EventName": "L1I_TLB_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1I in 16GB page.",
> +        "EventCode": "0x0C06",
> +        "EventName": "L1I_TLB_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1I in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 4KB page.",
> +        "EventCode": "0x0C08",
> +        "EventName": "L1D_TLB_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 64KB page.",
> +        "EventCode": "0x0C09",
> +        "EventName": "L1D_TLB_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 2MB page.",
> +        "EventCode": "0x0C0A",
> +        "EventName": "L1D_TLB_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 32MB page.",
> +        "EventCode": "0x0C0B",
> +        "EventName": "L1D_TLB_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 512MB page.",
> +        "EventCode": "0x0C0C",
> +        "EventName": "L1D_TLB_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 1GB page.",
> +        "EventCode": "0x0C0D",
> +        "EventName": "L1D_TLB_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L1D in 16GB page.",
> +        "EventCode": "0x0C0E",
> +        "EventName": "L1D_TLB_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L1D in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 4KB page.",
> +        "EventCode": "0x0C10",
> +        "EventName": "L1I_TLB_REFILL_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 64KB page.",
> +        "EventCode": "0x0C11",
> +        "EventName": "L1I_TLB_REFILL_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 2MB page.",
> +        "EventCode": "0x0C12",
> +        "EventName": "L1I_TLB_REFILL_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 32MB page.",
> +        "EventCode": "0x0C13",
> +        "EventName": "L1I_TLB_REFILL_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 512MB page.",
> +        "EventCode": "0x0C14",
> +        "EventName": "L1I_TLB_REFILL_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 1GB page.",
> +        "EventCode": "0x0C15",
> +        "EventName": "L1I_TLB_REFILL_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1I in 16GB page.",
> +        "EventCode": "0x0C16",
> +        "EventName": "L1I_TLB_REFILL_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1I in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 4KB page.",
> +        "EventCode": "0x0C18",
> +        "EventName": "L1D_TLB_REFILL_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 64KB page.",
> +        "EventCode": "0x0C19",
> +        "EventName": "L1D_TLB_REFILL_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 2MB page.",
> +        "EventCode": "0x0C1A",
> +        "EventName": "L1D_TLB_REFILL_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 32MB page.",
> +        "EventCode": "0x0C1B",
> +        "EventName": "L1D_TLB_REFILL_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 512MB page.",
> +        "EventCode": "0x0C1C",
> +        "EventName": "L1D_TLB_REFILL_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 1GB page.",
> +        "EventCode": "0x0C1D",
> +        "EventName": "L1D_TLB_REFILL_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L1D in 16GB page.",
> +        "EventCode": "0x0C1E",
> +        "EventName": "L1D_TLB_REFILL_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L1D in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 4KB page.",
> +        "EventCode": "0x0C20",
> +        "EventName": "L2I_TLB_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 64KB page.",
> +        "EventCode": "0x0C21",
> +        "EventName": "L2I_TLB_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 2MB page.",
> +        "EventCode": "0x0C22",
> +        "EventName": "L2I_TLB_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 32MB page.",
> +        "EventCode": "0x0C23",
> +        "EventName": "L2I_TLB_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 512MB page.",
> +        "EventCode": "0x0C24",
> +        "EventName": "L2I_TLB_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 1GB page.",
> +        "EventCode": "0x0C25",
> +        "EventName": "L2I_TLB_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2I in 16GB page.",
> +        "EventCode": "0x0C26",
> +        "EventName": "L2I_TLB_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2I in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 4KB page.",
> +        "EventCode": "0x0C28",
> +        "EventName": "L2D_TLB_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 64KB page.",
> +        "EventCode": "0x0C29",
> +        "EventName": "L2D_TLB_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 2MB page.",
> +        "EventCode": "0x0C2A",
> +        "EventName": "L2D_TLB_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 32MB page.",
> +        "EventCode": "0x0C2B",
> +        "EventName": "L2D_TLB_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 512MB page.",
> +        "EventCode": "0x0C2C",
> +        "EventName": "L2D_TLB_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 1GB page.",
> +        "EventCode": "0x0C2D",
> +        "EventName": "L2D_TLB_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> access to the L2D in 16GB page.",
> +        "EventCode": "0x0C2E",
> +        "EventName": "L2D_TLB_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> access to the L2D in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 4KB page.",
> +        "EventCode": "0x0C30",
> +        "EventName": "L2I_TLB_REFILL_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 64KB page.",
> +        "EventCode": "0x0C31",
> +        "EventName": "L2I_TLB_REFILL_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 2MB page.",
> +        "EventCode": "0x0C32",
> +        "EventName": "L2I_TLB_REFILL_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 32MB page.",
> +        "EventCode": "0x0C33",
> +        "EventName": "L2I_TLB_REFILL_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 512MB page.",
> +        "EventCode": "0x0C34",
> +        "EventName": "L2I_TLB_REFILL_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 1GB page.",
> +        "EventCode": "0x0C35",
> +        "EventName": "L2I_TLB_REFILL_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2I in 16GB page.",
> +        "EventCode": "0x0C36",
> +        "EventName": "L2I_TLB_REFILL_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2I in 16GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 4KB page.",
> +        "EventCode": "0x0C38",
> +        "EventName": "L2D_TLB_REFILL_4K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 4KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 64KB page.",
> +        "EventCode": "0x0C39",
> +        "EventName": "L2D_TLB_REFILL_64K",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 64KB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 2MB page.",
> +        "EventCode": "0x0C3A",
> +        "EventName": "L2D_TLB_REFILL_2M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 2MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 32MB page.",
> +        "EventCode": "0x0C3B",
> +        "EventName": "L2D_TLB_REFILL_32M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 32MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 512MB page.",
> +        "EventCode": "0x0C3C",
> +        "EventName": "L2D_TLB_REFILL_512M",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 512MB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 1GB page.",
> +        "EventCode": "0x0C3D",
> +        "EventName": "L2D_TLB_REFILL_1G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 1GB page."
> +    },
> +    {
> +        "PublicDescription": "This event counts operations that cause a =
TLB
> refill to the L2D in 16GB page.",
> +        "EventCode": "0x0C3E",
> +        "EventName": "L2D_TLB_REFILL_16G",
> +        "BriefDescription": "This event counts operations that cause a T=
LB
> refill to the L2D in 16GB page."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_PERCYC"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_PERCYC"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_STEP"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_STEP"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_LARGE"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_LARGE"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_SMALL"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_SMALL"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_BLOCK"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_BLOCK"
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK_PAGE"
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK_PAGE"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
> b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
> new file mode 100644
> index 000000000000..4e6e71a03e46
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
> @@ -0,0 +1,20 @@
> +[
> +    {
> +        "ArchStdEvent": "PMU_OVFS"
> +    },
> +    {
> +        "ArchStdEvent": "PMU_HOVFS"
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT0"
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT4"
> +    },
> +    {
> +        "ArchStdEvent": "TRB_WRAP"
> +    },
> +    {
> +        "ArchStdEvent": "TRB_TRIG"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index f4d1ca4d1493..5c846fe90513 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -39,6 +39,7 @@
>  0x00000000420f5160,v1,cavium/thunderx2,core
>  0x00000000430f0af0,v1,cavium/thunderx2,core
>  0x00000000460f0010,v1,fujitsu/a64fx,core
> +0x00000000460f0030,v1,fujitsu/monaka,core
>  0x00000000480fd010,v1,hisilicon/hip08,core
>  0x00000000500f0000,v1,ampere/emag,core
>  0x00000000c00fac30,v1,ampere/ampereone,core
> diff --git a/tools/perf/pmu-events/arch/arm64/recommended.json
> b/tools/perf/pmu-events/arch/arm64/recommended.json
> index 210afa856091..33671b743999 100644
> --- a/tools/perf/pmu-events/arch/arm64/recommended.json
> +++ b/tools/perf/pmu-events/arch/arm64/recommended.json
> @@ -317,6 +317,12 @@
>          "EventName": "DMB_SPEC",
>          "BriefDescription": "Barrier speculatively executed, DMB"
>      },
> +    {
> +        "PublicDescription": "This event counts speculatively executed c=
ontrol
> speculation barrier instructions.",
> +        "EventCode": "0x7F",
> +        "EventName": "CSDB_SPEC",
> +        "BriefDescription": "This event counts speculatively executed co=
ntrol
> speculation barrier instructions."
> +    },
>      {
>          "PublicDescription": "Exception taken, Other synchronous",
>          "EventCode": "0x81",
> --
> 2.34.1

Hi,
A very gentle ping on this patch.

Best regards,
Yoshihiro Furudera
