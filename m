Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B46279DAA;
	Tue,  9 Sep 2025 03:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389378; cv=fail; b=cYf1DYtXPzLU2yvYfqmyNAYleItQk+YT2a7bTGVBOXCn6wjhAELsVsbT4dQ+JZcPkuJZIaGNN1gnKeLFHISDPKZ2mBK7SqnsdfT5DCzR0VptFpf5LE23tusJSboyET4VWLZlMW7hKZciv5LDQDPH0El0ZgiibSM/HD40g9oyjAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389378; c=relaxed/simple;
	bh=GHq5b8Z7n1jenA6IKZVfuJMbpkJhWqfogMpY8bEaE8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZobsLLfA7qep8Z6yXUFimlTikuaMvxale7FnLUefIw5vB4FeeMFaoZbNim9iLeXJW/sXNsZJ5LBViOLCR4E7SJudVzPRj+L5PmSg19qzmjjNSPtZ33u/lqC9DtOhKrX8rg/F2QQxEVQ+v4gDjdwAx8Sk/0gl5jpqpCVpC7mxDUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=F5jvefPm; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="F5jvefPm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757389375; x=1788925375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GHq5b8Z7n1jenA6IKZVfuJMbpkJhWqfogMpY8bEaE8g=;
  b=F5jvefPm9sZKxvC9mVSAKyenPtiCoTC3dIerxH8anhWKlY9A73Jzfuow
   YlGH1BwTYBJ+kW4A/7bkMOrOWFt5F7o/2RilRcIQxkHfWwiow64ByM1vo
   Z9ZrE7I8EfiPiCPZNSk+UIIVdwur6waHdw7VLJoqjOmNMncCfSFjRGXzB
   bsJKaotR0G9Mv0cERqDERImq5Psp/7yN4IGjHOivKKkQkKANap3M5IFw5
   9FR02D5Dhi1qJd9yXxZZtESzZOWlfuuuFxBebVq11lhoYXvHa5dG52qgC
   QNINfGLfrjPMAFKepufk6wABRQERpPnOqIL+e9tzkAKizWM4jvLkH8OuM
   Q==;
X-CSE-ConnectionGUID: bczKdM1ZQUyzSAunJzb8Mg==
X-CSE-MsgGUID: mWvkvpfzSBiPSdXD0G33Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="167152208"
X-IronPort-AV: E=Sophos;i="6.18,250,1751209200"; 
   d="scan'208";a="167152208"
Received: from mail-japanwestazon11011009.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.9])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 12:41:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0MlzlFW+nTXrBT4zuiRWTaCMX7wd0/jOFS0ntsoKNsvmjAQX0RnBlrIs8NUo3GRLnidgW6Dn0ZLXVzMocRNw6gTN0Rj9VHxxIC7Raa2lUYTD/VbkbIkS8Cdg020LjQ/N9IIBSL33vC7GdxvVQRCnBHOpeahbt0LZJWz6kqI7VYlFBUkiE7pHKKlXxvjON8Y4hPw1ZgneoDZjKxuiHC/a31BtkM+ckuAAi2Y5KM3K3GM/0d6hafIQyj3RAA8sLW//W+Xy+xcOfg8/EeZkONu/z7fWXbk1Xyt18lpyuxOEesDNO8TnXYuXaJ8FPLX5/0Z3yMQhYqDpHtvrnMATVUBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MURo53XLvtwzyWzHgDOrh1HEKVAoCGBxpc2SF3OqJ68=;
 b=uY1sCFniKlDNUT3oJf1D5sJzp7WIkUOi3jGUfg/rAAU4yp5ZB5GyQEuFVsWd3CbF/UzdMnVAznm50h04xgh+7HNV6OtjB7/qfA1JlG/whFV7ZRv9XgoLpq5+O6tWJQCJj99uA81K4ZVISTC212AESQj3pJiB2KVmbLYMD75pai2XwxwQ4zB/SBbooRyEggZYYSO4bJMjiF0c4h7HaG7vXEnuzl/gmNTBMTwqD99OkyB3Z5N/1lPczzwnBvmuzF+Y+kikNmIYCTz9XBZYyVaJCxDijBNGJwN67zdbIKvCMxOq3Qz6vbmu+m07sIvP/2UI/RlF4/rS92C9LEJmKs0gJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com (2603:1096:604:33a::9)
 by TYRPR01MB15471.jpnprd01.prod.outlook.com (2603:1096:405:286::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 03:41:36 +0000
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d]) by OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:41:36 +0000
From: "Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
To: 'Yicong Yang' <yangyicong@huawei.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Gowthami Thiagarajan
	<gthiagarajan@marvell.com>, Linu Cherian <lcherian@marvell.com>, Robin Murphy
	<robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Besar Wicaksono <bwicaksono@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Koichi Okuno (Fujitsu)"
	<fj2767dz@fujitsu.com>
Subject: RE: [PATCH v8] perf: Fujitsu: Add the Uncore PMU driver
Thread-Topic: [PATCH v8] perf: Fujitsu: Add the Uncore PMU driver
Thread-Index: AQHcHUGP7RtT6WtaOkC37v0ZeFfEPbSCoHiAgAeTNxA=
Date: Tue, 9 Sep 2025 03:41:36 +0000
Message-ID:
 <OSCPR01MB128199F2DBFDB4079408FFA7BC10FA@OSCPR01MB12819.jpnprd01.prod.outlook.com>
References: <20250904021315.353541-1-fj2767dz@fujitsu.com>
 <421261dc-e24d-7000-8ed3-27ed4b2f5df6@huawei.com>
In-Reply-To: <421261dc-e24d-7000-8ed3-27ed4b2f5df6@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=239f8648-1c47-4ab5-9a18-f1d7aa7249e1;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-09-09T03:09:11Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12819:EE_|TYRPR01MB15471:EE_
x-ms-office365-filtering-correlation-id: f7c31e75-1e48-4e9a-f4aa-08ddef52c758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?dVVremVZY2RIbHpCK3BwNGVHNnprMUpvNzBZSm9EZDdzK3kxM1JzQVdw?=
 =?iso-2022-jp?B?UCtvNDM0dzZRNExmc2h0REE2MDUxQ1JZV2FtakNPTUUzaDBGMzlDVXp4?=
 =?iso-2022-jp?B?TlZTeFc2NmJJY1VWSzVQSFFOdXdnV1RaaFlkdDY2WVZTUkZQTGtYT0tz?=
 =?iso-2022-jp?B?Y2I4SFB0RjRYRWRXeW5TVkxqSlVac3pDbXBCV2dlVlRoYXJMUi8rV1lp?=
 =?iso-2022-jp?B?cGpMWjVHV3ZWcTdXQmQ2blE3c2ZDS1dGb0VyM05JeHZPcXFFSEE1clN4?=
 =?iso-2022-jp?B?QUxQTndDempsZVlGbm5kQVhVOUJEOE8yajkxS2R2aGhtcGIzdGJ4dlcv?=
 =?iso-2022-jp?B?dG5waElUQkViRnlIS2dwaVV1VzhJSlJzT09XM3didlZ0YkxxcmloV2c2?=
 =?iso-2022-jp?B?dXFpZFcxbmlTV2ZDSU5oNkNXaG44aitMS3BWeEhWR3NHTWQ4ZlJJa1Ay?=
 =?iso-2022-jp?B?WUlITHl2a1Q1RTFBRE8yeURkNUVtcjlkb2NnSW8xYWZ5UC9SaUJORzlz?=
 =?iso-2022-jp?B?R2RhejNVblJWVVlhNzFhRFlYSWJFK1F3THJHNFRXK1pDL21WYU01cjV3?=
 =?iso-2022-jp?B?OHR2VDl5R2xDeHhlL0FHa0VhRUFiM1ZNYzZ6UkxleEhQL29pUldFSTNp?=
 =?iso-2022-jp?B?SW1QNmUydXptd0VheDMrdWNhdVNYMGRRM0cxTE1VS2E1c1RXdlhFRWRQ?=
 =?iso-2022-jp?B?NXI0R1lIUURtZXFqMlZZdFJ1NnhuS0hwQkZJRG9CaVM3SVBlNGhuVmU2?=
 =?iso-2022-jp?B?UmJTYU1MQnVXcGFwa0hVQm8xMGxrcDR2YjRET0lXK3lZZEZ2Z25JVmYv?=
 =?iso-2022-jp?B?ZWlablhVQzNsZmljd2RhRGpRSllpNzJQVzl0djBoc0JXMjVBcjZFYlBq?=
 =?iso-2022-jp?B?RTd5NkFSYWNPeGtiZUNoVmM0Yk15NmxnU0VjM0lVaXNtTDVKcVdlcjhD?=
 =?iso-2022-jp?B?Z2JDaHMwZHk2K2dxeWhadGR5WG1xNFNZVDdRdk8wRHFNS20wZzVua3Vj?=
 =?iso-2022-jp?B?OHhISGhLTGV6akJ0Ym1oNnc4Mm1QZUR6c0VNbURnYTEwREl3eXBUb0Ns?=
 =?iso-2022-jp?B?Z1VicnVqa0FwNmN5U01rcUd4ckMxcVJTSU1tQmExd0xIS3VVaTUzT254?=
 =?iso-2022-jp?B?Vno0Tkx2V05oU3pkdVY1dWwwZHpwaUpqbUhPeThjbGgva1psYkJndTZX?=
 =?iso-2022-jp?B?T3l6Umt6QklveTdUQyt6aWFra0tvTFBJWXkwMjJ6R2l2Rmw1QjBXejNH?=
 =?iso-2022-jp?B?eFh3OXp4bGYwQ2VnODVDY2JqQ2xNb2U1dVkrc2J3QTBITHNITmJ0SjEv?=
 =?iso-2022-jp?B?K1c5ejd0cnd0eFBMMy9zVGV3WHNWQUg1cStHelBxMkVBaFMxRVo0ZjFJ?=
 =?iso-2022-jp?B?bHpEZjFUOTBDSTBqUk1iSDJqTmMvaUdkYmtSeFRXNWpRRkM3dDlvalNE?=
 =?iso-2022-jp?B?RmNuYS9MRHkzU1NPTTJ5eTBzS0pTUXJUMXBva1FlMXFnMTA2WGJrdVNM?=
 =?iso-2022-jp?B?MHNKdEdpRVJGWlBRb2IzQ05kNXcxSUQvM1hnTzVSL2oyeFpEdUlaaG5F?=
 =?iso-2022-jp?B?L0pUMHR2ZnpISGRxZGJEcm5yb3hsQjZKNnR0NlJjZEFKVE0zRWNjM0Jk?=
 =?iso-2022-jp?B?QlVJUmhyU2xKUzZaRlB2cmZ0TE13T3AxbWpJeG8xK2szZTNjRE94ZnUw?=
 =?iso-2022-jp?B?czRkNEg5eVBEWnNoUDVQQ2JLbTJIcjRaSVYwUHl2VkFocG5SOEtLcUU5?=
 =?iso-2022-jp?B?eVJDU3FyM09RWU5xenNtQ25LYkZVVnQ5RUU1S0ZqQXZTSUVoQkhhc3J2?=
 =?iso-2022-jp?B?dVhmYklRdzEzZVBpVzd3SjgvZC9jYkRmOWE1QldFT21YL2JhUyt5bS9O?=
 =?iso-2022-jp?B?VUVCVHdEeFByVlVmcnRpWC9IQTE0SlRvT0taeHcwM2VaMkZUNGxRRWJo?=
 =?iso-2022-jp?B?V0NYcXF3OXF1Y2doaG5leU1LckF3MTl1cndIUHVyQXhPUlVwTkJsbCtB?=
 =?iso-2022-jp?B?WldhMmZnUitIKzMwc0t1MWoyeERaTnRFeTZndm9OOTNYVGxTbGtpYkJD?=
 =?iso-2022-jp?B?RnF4anVxL1dmYlAxb0hMT3RiODY3RHpESFVDLytzS1oyaUNoV2tFbXBH?=
 =?iso-2022-jp?B?aE0xQy9TdlU5VTNHSk5jSHhaVVhGQ3VZcnB5RUtVQTRWa05wLzhHSHYz?=
 =?iso-2022-jp?B?MHJzWGFpUUtrSWgwNExjYlNFL09kM0R2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12819.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?bTFGWkhMbVh2cnFnK1ZDUVRUMkxFMEM2dEEzSGc5c25IVHBGM0NYd2x3?=
 =?iso-2022-jp?B?SmFUTTFIZDNuWUNQTG1aOGdsWGNoNWlRVmc0eVFrc0kzaGlIblQrNndM?=
 =?iso-2022-jp?B?bmRMdVRMOTBCTmNGK3VHSGNwM0gxWHoySjZUZkE2VUFYUFJheVNTUVQ1?=
 =?iso-2022-jp?B?VUs1ZFIxOG4vYkZFdGd3UHIzOUJMVFpJSGZMTFQ1VElVdXZQaFFoWTRO?=
 =?iso-2022-jp?B?MWNJL0JCcktYYW9IbFc3aEYyYkhBeFV2YUMzSjUreUxTUlE5ZEdWRVlo?=
 =?iso-2022-jp?B?c2hVcEVxckowOXNrdzh6QmxOdEh1cXhvaUQ2ZmdJVnlLTDZnUmpDY0Jw?=
 =?iso-2022-jp?B?bFdlVzNqMmdOZjMvWjQ1bCtKaXJKSnZCck1jSVpHZ3RwdTBHR0o2aHFj?=
 =?iso-2022-jp?B?N25lcmM3SUhGLzZtZGxNNkNoQXdxU1ZGVHJsazcyc3F3bnlYOTNndWxu?=
 =?iso-2022-jp?B?Y0ZUSjhTZVJ3dmVPUlJ3ZVlZVFBiRFUzMitjS3VCTjFoaUwxNk03MHV4?=
 =?iso-2022-jp?B?eGFZMXZZZzJmejVoZmRlMzJCQk5LaGlSaW9rRW5EaGJCc0dhVVp3T2Ja?=
 =?iso-2022-jp?B?eUhLVGF0NzFUbys0SXAyUkpBK3lEU1RhVVVrVWZZTGpObFQrRmZiNmIz?=
 =?iso-2022-jp?B?ajZqVnJLWFdmSlE3RjFIb05VdXpPTk05cll3eE4yNUhtSzFLZS9HbDJh?=
 =?iso-2022-jp?B?R2psVHJYZ0o2dGxwRzRZbUdVYUdxazE5NkdZT05iNGExK2ViT3ZhYjhi?=
 =?iso-2022-jp?B?SFVEcHR1eXc1ai9pWnR2TWpOdTdPSW0xV0xJSjFSKy9xZWQzTzRTTE55?=
 =?iso-2022-jp?B?MllTY24xNnk1NmdiWklqY0tqYnZsdWRXYlYxRzkyRFNlTjNCRENGeWlv?=
 =?iso-2022-jp?B?Qzg5cmJsUUJiTlJRSHBRWWZFZ3BmQmRrVnowakROOTBDZXZhNFVZUTMv?=
 =?iso-2022-jp?B?Z3cwRkdwUk1WajkvZU9IZXhRbFlmNzVrckxQc3RNVjZrZ2RwTGZPYjlj?=
 =?iso-2022-jp?B?bDJvMEpjdHhLK3RzYk1zUTJhaGVGTUx3azdid1ZYdjNia3VqOWVYRXBN?=
 =?iso-2022-jp?B?TUQrVUZOZ21TK0V1T0hOZzMzcTJCNDZSUERnM0RFRGVmSEJCZkppckRN?=
 =?iso-2022-jp?B?ODBaSEUxTEVTaFordk5JbW9rWERIRDJkOHdicnRWbDh2Q2tKdjZoZ0JT?=
 =?iso-2022-jp?B?cFBJWjA3d1R2SnEvcTl5dkR3K09pWjRpN3pXN05TSWVSZXVhY2ZBbWxh?=
 =?iso-2022-jp?B?Z25lc3lXS0VMbk8rbnpNY2dhT1BBYkF1aHJyVUkvbTAyVzlmYmVwUVpu?=
 =?iso-2022-jp?B?NUxWQmRESlowdEZ1K2xvcTFHWHNBV1JENHROM1ZZdisxNFZPa0FjNnJX?=
 =?iso-2022-jp?B?SkRQSVppbEwrZ0pVMllRM0laZ2ZJSnB6NHhPcTNjZklCYWxmNVVydEJY?=
 =?iso-2022-jp?B?V0tRRnoyemU1UVdveDEzUmphMUszT1g5clNjUm9wVkRaVi9JY2lBYXVI?=
 =?iso-2022-jp?B?OU5LM0d4L2I4cE5yVi93elBkT21ZSVZteU5TZXI0Q2trR2dDSXkrNytN?=
 =?iso-2022-jp?B?Qzl0SnA3bVl2azIwSkp5ZGtDeUwzQ0FJamM4RmNEQWVqajlQSE1Ldm16?=
 =?iso-2022-jp?B?MHl5LzA0OVU4UWo5cVNaaGRMdDY5VmFWWWNTSFlWVHBIVExUdGtDelFj?=
 =?iso-2022-jp?B?SE1VQjVBQ0pNVnNzRm5OTlZGVGVSVzNkQm9LcnBzT1pLQWg0aHZYTHBF?=
 =?iso-2022-jp?B?MVkrSWk4dWgxeWtDR3hYcHNhZytwK1ljVFVhWDRnNzJUdXQzZDZZaGpE?=
 =?iso-2022-jp?B?c3VoSmxybmM1N2ZBOVo0ZGFUOTREd1pmaEthZzVqZ2ZlTTRtdmNYQXdC?=
 =?iso-2022-jp?B?alRxaUM1di8zVU85a1ZJSmR2QkpMYzluUWNJL2QwVTBOcFhkY09IZWpo?=
 =?iso-2022-jp?B?MndZbDFreS94VXFNaUQ3S0ZMS2hWa1VycnFSRkFnTFd4ZnRmeFJvK0tm?=
 =?iso-2022-jp?B?SDNXc3Z5NjM1QnhzZjB4UkZzbzYrUHRzb205Ri9RbmtPaHYxaG9yK0x4?=
 =?iso-2022-jp?B?Wk9Sa3NMTTVHdTNXeXMxNmJIV3ZmL09PTXcrVVNPekRoL1E0T1dSazRw?=
 =?iso-2022-jp?B?UEhrV1h5RHlTaG1WM3hFS1Jlb1Bjc29QUkV0cjJNbVZBaEI1RFFQdDRl?=
 =?iso-2022-jp?B?Z3NEYWs3YTJSdEdSR0pTK2IxRmlmc2ZGYjZuemVEM21HV2U2NVFobkVa?=
 =?iso-2022-jp?B?K0gvOVlzeTduckdQM3pXVVlxdDdLQUdpU29KaURORDZHdWpBSE10SzdO?=
 =?iso-2022-jp?B?ZUJGdm4rbS9pZlJCUy9nckRrbFF0L3FyNUE9PQ==?=
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
	XnJuhPnvYFUTiBG9jQQvE11k75mHspzL9L11sCEdwwOcMeRrsUlkU9w7Xb2QqPLBNdfDCSqN8wE0CROqaukzVhjj+HFXYMVkchCbPk1CGkhyQNz9OvWDqUebMUNwrRA69mu9gFU/vkj4Hp/wKL88KCiktYr/C3MJzihQSft90ym1q+8cqMO8LhKbSKM1XIWK6w4n1RskRrph2rbUJUPW5uUYEJ7I0trgX1jk4+4N/aJT7tmen5eLBsReQbYs1egcacmrqs8DH8L46myXk8HPh90wAZabuGv6DxA2+49DeoWQeIIOIt7TnlHxFX1dYDXJYxSkZFFcC6W98utK1FJMcFgOSETH/LZUFPUeuSgCJWoaUX6EM9bDHA37hZdHMxW2RNAwI1h3efwtBYAEeI/9PVTngM43TwUqR3pP5Ci/8n8UW4TSLaFhFcSvAx6veSxoAAdTUHhF/Xjio2K1U7IqXcp1By/b3qUAtGvr5tJ4X2g+J9pTUfY4lVkr8Br0HRZUTFj57rbS28o8EA+fGUKDlK2kPfZJd54y45JYDvMvmSHVOL29/177q1yx3rimupNiAch9fVIkVvIDGbbFmtPwqtuohiKH1zMDc7KqxAR4sAfra6LuFNHjDmfh95OQMIiX
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12819.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c31e75-1e48-4e9a-f4aa-08ddef52c758
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:41:36.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fr7GslcOzAPsWhzFis4jTTjZxl0er/JvyX7tj6FhBLVErvnQVoKcFh9I5pcc3amb1RmMAj7VwNtGVE9RHBGvHEJEiYSh1pnqQl0XeXAfmzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15471

Hi, Yang

> > This adds a new dynamic PMU to the Perf Events framework to program and
> > control the Uncore PMUs in Fujitsu chips.
> >
> > This driver exports formatting and event information to sysfs so it can
> > be used by the perf user space tools with the syntaxes:
> >
> > perf stat -e pci_iod0_pci0/ea-pci/ ls
> > perf stat -e pci_iod0_pci0/event=3D0x80/ ls
> > perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> > perf stat -e mac_iod0_mac0_ch0/event=3D0x80/ ls
> >
> > FUJITSU-MONAKA PMU Events Specification v1.1 URL:
> > https://github.com/fujitsu/FUJITSU-MONAKA
> >
> > Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
>=20
> one issue about the irq flag, otherwise looks good. if fixed/clarified:
>=20
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Thank you for your review.
I have addressed the irq flag issue in v9 and included your Reviewed-by: ta=
g.

> > ---
> > Changes in v8:
> > - Modify the code as suggested.
> >   - This driver has been modularized.
> >   - The MAC PMU driver and PCI PMU driver have been integrated into a s=
ingle driver.
> >   - Adding irq_set_affinity() Calls.
> >   - I have addressed the other feedback.
> > - Link to v7: https://lore.kernel.org/all/20250815034751.3726963-1-fj27=
67dz@fujitsu.com/
> >
> >  .../admin-guide/perf/fujitsu_uncore_pmu.rst   | 110 ++++
> >  Documentation/admin-guide/perf/index.rst      |   1 +
> >  drivers/perf/Kconfig                          |   9 +
> >  drivers/perf/Makefile                         |   1 +
> >  drivers/perf/fujitsu_uncore_pmu.c             | 611 ++++++++++++++++++
> >  5 files changed, 732 insertions(+)
> >  create mode 100644 Documentation/admin-guide/perf/fujitsu_uncore_pmu.r=
st
> >  create mode 100644 drivers/perf/fujitsu_uncore_pmu.c
> >
> > diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Do=
cumentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> > new file mode 100644
> > index 000000000000..46595b788d3a
> > --- /dev/null
> > +++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> > @@ -0,0 +1,110 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Fujitsu Uncore Performance Monitoring Unit (PMU)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This driver supports the Uncore MAC PMUs and the Uncore PCI PMUs found
> > +in Fujitsu chips.
> > +Each MAC PMU on these chips is exposed as a uncore perf PMU with devic=
e name
> > +mac_iod<iod>_mac<mac>_ch<ch>.
> > +And each PCI PMU on these chips is exposed as a uncore perf PMU with d=
evice name
> > +pci_iod<iod>_pci<pci>.
> > +
> > +The driver provides a description of its available events and configur=
ation
> > +options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<=
mac>_ch<ch>/
> > +and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
> > +This driver exports:
> > +- formats, used by perf user space and other tools to configure events
> > +- events, used by perf user space and other tools to create events
> > +  symbolically, e.g.:
> > +    perf stat -a -e mac_iod0_mac0_ch0/event=3D0x21/ ls
> > +    perf stat -a -e pci_iod0_pci0/event=3D0x24/ ls
> > +- cpumask, used by perf user space and other tools to know on which CP=
Us
> > +  to open the events
> > +
> > +This driver supports the following events for MAC:
> > +- cycles
> > +  This event counts MAC cycles at MAC frequency.
> > +- read-count
> > +  This event counts the number of read requests to MAC.
> > +- read-count-request
> > +  This event counts the number of read requests including retry to MAC=
.
> > +- read-count-return
> > +  This event counts the number of responses to read requests to MAC.
> > +- read-count-request-pftgt
> > +  This event counts the number of read requests including retry with P=
FTGT
> > +  flag.
> > +- read-count-request-normal
> > +  This event counts the number of read requests including retry withou=
t PFTGT
> > +  flag.
> > +- read-count-return-pftgt-hit
> > +  This event counts the number of responses to read requests which hit=
 the
> > +  PFTGT buffer.
> > +- read-count-return-pftgt-miss
> > +  This event counts the number of responses to read requests which mis=
s the
> > +  PFTGT buffer.
> > +- read-wait
> > +  This event counts outstanding read requests issued by DDR memory con=
troller
> > +  per cycle.
> > +- write-count
> > +  This event counts the number of write requests to MAC (including zer=
o write,
> > +  full write, partial write, write cancel).
> > +- write-count-write
> > +  This event counts the number of full write requests to MAC (not incl=
uding
> > +  zero write).
> > +- write-count-pwrite
> > +  This event counts the number of partial write requests to MAC.
> > +- memory-read-count
> > +  This event counts the number of read requests from MAC to memory.
> > +- memory-write-count
> > +  This event counts the number of full write requests from MAC to memo=
ry.
> > +- memory-pwrite-count
> > +  This event counts the number of partial write requests from MAC to m=
emory.
> > +- ea-mac
> > +  This event counts energy consumption of MAC.
> > +- ea-memory
> > +  This event counts energy consumption of memory.
> > +- ea-memory-mac-write
> > +  This event counts the number of write requests from MAC to memory.
> > +- ea-ha
> > +  This event counts energy consumption of HA.
> > +
> > +  'ea' is the abbreviation for 'Energy Analyzer'.
> > +
> > +Examples for use with perf::
> > +
> > +  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> > +
> > +And, this driver supports the following events for PCI:
> > +- pci-port0-cycles
> > +  This event counts PCI cycles at PCI frequency in port0.
> > +- pci-port0-read-count
> > +  This event counts read transactions for data transfer in port0.
> > +- pci-port0-read-count-bus
> > +  This event counts read transactions for bus usage in port0.
> > +- pci-port0-write-count
> > +  This event counts write transactions for data transfer in port0.
> > +- pci-port0-write-count-bus
> > +  This event counts write transactions for bus usage in port0.
> > +- pci-port1-cycles
> > +  This event counts PCI cycles at PCI frequency in port1.
> > +- pci-port1-read-count
> > +  This event counts read transactions for data transfer in port1.
> > +- pci-port1-read-count-bus
> > +  This event counts read transactions for bus usage in port1.
> > +- pci-port1-write-count
> > +  This event counts write transactions for data transfer in port1.
> > +- pci-port1-write-count-bus
> > +  This event counts write transactions for bus usage in port1.
> > +- ea-pci
> > +  This event counts energy consumption of PCI.
> > +
> > +  'ea' is the abbreviation for 'Energy Analyzer'.
> > +
> > +Examples for use with perf::
> > +
> > +  perf stat -e pci_iod0_pci0/ea-pci/ ls
> > +
> > +Given that these are uncore PMUs the driver does not support sampling,=
 therefore
> > +"perf record" will not work. Per-task perf sessions are not supported.
> > diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/a=
dmin-guide/perf/index.rst
> > index 072b510385c4..47d9a3df6329 100644
> > --- a/Documentation/admin-guide/perf/index.rst
> > +++ b/Documentation/admin-guide/perf/index.rst
> > @@ -29,3 +29,4 @@ Performance monitor support
> >     cxl
> >     ampere_cspmu
> >     mrvl-pem-pmu
> > +   fujitsu_uncore_pmu
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index a9188dec36fe..638321fc9800 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
> >        can give information about memory throughput and other related
> >        events.
> >
> > +config FUJITSU_UNCORE_PMU
> > +     tristate "Fujitsu Uncore PMU"
> > +     depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
> > +      help
> > +      Provides support for the Uncore performance monitor unit (PMU)
> > +      in Fujitsu processors.
> > +      Adds the Uncore PMU into the perf events subsystem for
> > +      monitoring Uncore events.
> > +
> >  config QCOM_L2_PMU
> >       bool "Qualcomm Technologies L2-cache PMU"
> >       depends on ARCH_QCOM && ARM64 && ACPI
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index 192fc8b16204..ea52711a87e3 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_ARM_XSCALE_PMU) +=3D arm_xscale_pmu.o
> >  obj-$(CONFIG_ARM_SMMU_V3_PMU) +=3D arm_smmuv3_pmu.o
> >  obj-$(CONFIG_FSL_IMX8_DDR_PMU) +=3D fsl_imx8_ddr_perf.o
> >  obj-$(CONFIG_FSL_IMX9_DDR_PMU) +=3D fsl_imx9_ddr_perf.o
> > +obj-$(CONFIG_FUJITSU_UNCORE_PMU) +=3D fujitsu_uncore_pmu.o
> >  obj-$(CONFIG_HISI_PMU) +=3D hisilicon/
> >  obj-$(CONFIG_QCOM_L2_PMU)    +=3D qcom_l2_pmu.o
> >  obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_u=
ncore_pmu.c
> > new file mode 100644
> > index 000000000000..e0ea9f4cd82d
> > --- /dev/null
> > +++ b/drivers/perf/fujitsu_uncore_pmu.c
> > @@ -0,0 +1,611 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for the Uncore PMUs in Fujitsu chips.
> > + *
> > + * See Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst for more =
details.
> > + *
> > + * Copyright (c) 2025 Fujitsu. All rights reserved.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/list.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* Number of counters on each PMU */
> > +#define MAC_NUM_COUNTERS  8
> > +#define PCI_NUM_COUNTERS  8
> > +/* Mask for the event type field within perf_event_attr.config and EVT=
YPE reg */
> > +#define UNCORE_EVTYPE_MASK   0xFF
> > +
> > +/* Perfmon registers */
> > +#define PM_EVCNTR(__cntr)           (0x000 + (__cntr) * 8)
> > +#define PM_CNTCTL(__cntr)           (0x100 + (__cntr) * 8)
> > +#define PM_CNTCTL_RESET             0
> > +#define PM_EVTYPE(__cntr)           (0x200 + (__cntr) * 8)
> > +#define PM_EVTYPE_EVSEL(__val)      FIELD_GET(UNCORE_EVTYPE_MASK, __va=
l)
> > +#define PM_CR                       0x400
> > +#define PM_CR_RESET                 BIT(1)
> > +#define PM_CR_ENABLE                BIT(0)
> > +#define PM_CNTENSET                 0x410
> > +#define PM_CNTENSET_IDX(__cntr)     BIT(__cntr)
> > +#define PM_CNTENCLR                 0x418
> > +#define PM_CNTENCLR_IDX(__cntr)     BIT(__cntr)
> > +#define PM_CNTENCLR_RESET           0xFF
> > +#define PM_INTENSET                 0x420
> > +#define PM_INTENSET_IDX(__cntr)     BIT(__cntr)
> > +#define PM_INTENCLR                 0x428
> > +#define PM_INTENCLR_IDX(__cntr)     BIT(__cntr)
> > +#define PM_INTENCLR_RESET           0xFF
> > +#define PM_OVSR                     0x440
> > +#define PM_OVSR_OVSRCLR_RESET       0xFF
> > +
> > +enum fujitsu_uncore_pmu {
> > +     FUJITSU_UNCORE_PMU_MAC =3D 1,
> > +     FUJITSU_UNCORE_PMU_PCI =3D 2,
> > +};
> > +
> > +struct uncore_pmu {
> > +     int                     num_counters;
> > +     struct pmu              pmu;
> > +     struct hlist_node       node;
> > +     void __iomem            *regs;
> > +     struct perf_event       **events;
> > +     unsigned long           *used_mask;
> > +     int                     cpu;
> > +     int                     irq;
> > +     struct device           *dev;
> > +};
> > +
> > +#define to_uncore_pmu(p) (container_of(p, struct uncore_pmu, pmu))
> > +
> > +static int uncore_pmu_cpuhp_state;
> > +
> > +static void fujitsu_uncore_counter_start(struct perf_event *event)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     int idx =3D event->hw.idx;
> > +
> > +     /* Initialize the hardware counter and reset prev_count*/
> > +     local64_set(&event->hw.prev_count, 0);
> > +     writeq_relaxed(0, uncorepmu->regs + PM_EVCNTR(idx));
> > +
> > +     /* Set the event type */
> > +     writeq_relaxed(PM_EVTYPE_EVSEL(event->attr.config), uncorepmu->re=
gs + PM_EVTYPE(idx));
> > +
> > +     /* Enable interrupt generation by this counter */
> > +     writeq_relaxed(PM_INTENSET_IDX(idx), uncorepmu->regs + PM_INTENSE=
T);
> > +
> > +     /* Finally, enable the counter */
> > +     writeq_relaxed(PM_CNTCTL_RESET, uncorepmu->regs + PM_CNTCTL(idx))=
;
> > +     writeq_relaxed(PM_CNTENSET_IDX(idx), uncorepmu->regs + PM_CNTENSE=
T);
> > +}
> > +
> > +static void fujitsu_uncore_counter_stop(struct perf_event *event)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     int idx =3D event->hw.idx;
> > +
> > +     /* Disable the counter */
> > +     writeq_relaxed(PM_CNTENCLR_IDX(idx), uncorepmu->regs + PM_CNTENCL=
R);
> > +
> > +     /* Disable interrupt generation by this counter */
> > +     writeq_relaxed(PM_INTENCLR_IDX(idx), uncorepmu->regs + PM_INTENCL=
R);
> > +}
> > +
> > +static void fujitsu_uncore_counter_update(struct perf_event *event)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     int idx =3D event->hw.idx;
> > +     u64 prev, new;
> > +
> > +     do {
> > +             prev =3D local64_read(&event->hw.prev_count);
> > +             new =3D readq_relaxed(uncorepmu->regs + PM_EVCNTR(idx));
> > +     } while (local64_cmpxchg(&event->hw.prev_count, prev, new) !=3D p=
rev);
> > +
> > +     local64_add(new - prev, &event->count);
> > +}
> > +
> > +static inline void fujitsu_uncore_init(struct uncore_pmu *uncorepmu)
> > +{
> > +     int i;
> > +
> > +     writeq_relaxed(PM_CR_RESET, uncorepmu->regs + PM_CR);
> > +
> > +     writeq_relaxed(PM_CNTENCLR_RESET, uncorepmu->regs + PM_CNTENCLR);
> > +     writeq_relaxed(PM_INTENCLR_RESET, uncorepmu->regs + PM_INTENCLR);
> > +     writeq_relaxed(PM_OVSR_OVSRCLR_RESET, uncorepmu->regs + PM_OVSR);
> > +
> > +     for (i =3D 0; i < uncorepmu->num_counters; ++i) {
> > +             writeq_relaxed(PM_CNTCTL_RESET, uncorepmu->regs + PM_CNTC=
TL(i));
> > +             writeq_relaxed(PM_EVTYPE_EVSEL(0), uncorepmu->regs + PM_E=
VTYPE(i));
> > +     }
> > +}
> > +
> > +static irqreturn_t fujitsu_uncore_handle_irq(int irq_num, void *data)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D data;
> > +     /* Read the overflow status register */
> > +     long status =3D readq_relaxed(uncorepmu->regs + PM_OVSR);
> > +     int idx;
> > +
> > +     if (status =3D=3D 0)
> > +             return IRQ_NONE;
> > +
> > +     /* Clear the bits we read on the overflow status register */
> > +     writeq_relaxed(status, uncorepmu->regs + PM_OVSR);
> > +
> > +     for_each_set_bit(idx, &status, uncorepmu->num_counters) {
> > +             struct perf_event *event;
> > +
> > +             event =3D uncorepmu->events[idx];
> > +             if (!event)
> > +                     continue;
> > +
> > +             fujitsu_uncore_counter_update(event);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void fujitsu_uncore_pmu_enable(struct pmu *pmu)
> > +{
> > +     writeq_relaxed(PM_CR_ENABLE, to_uncore_pmu(pmu)->regs + PM_CR);
> > +}
> > +
> > +static void fujitsu_uncore_pmu_disable(struct pmu *pmu)
> > +{
> > +     writeq_relaxed(0, to_uncore_pmu(pmu)->regs + PM_CR);
> > +}
> > +
> > +static bool fujitsu_uncore_validate_event_group(struct perf_event *eve=
nt)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     struct perf_event *leader =3D event->group_leader;
> > +     struct perf_event *sibling;
> > +     int counters =3D 1;
> > +
> > +     if (leader =3D=3D event)
> > +             return true;
> > +
> > +     if (leader->pmu =3D=3D event->pmu)
> > +             counters++;
> > +
> > +     for_each_sibling_event(sibling, leader) {
> > +             if (sibling->pmu =3D=3D event->pmu)
> > +                     counters++;
> > +     }
> > +
> > +     /*
> > +      * If the group requires more counters than the HW has, it
> > +      * cannot ever be scheduled.
> > +      */
> > +     return counters <=3D uncorepmu->num_counters;
> > +}
> > +
> > +static int fujitsu_uncore_event_init(struct perf_event *event)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     /* Is the event for this PMU? */
> > +     if (event->attr.type !=3D event->pmu->type)
> > +             return -ENOENT;
> > +
> > +     /*
> > +      * Sampling not supported since these events are not
> > +      * core-attributable.
> > +      */
> > +     if (hwc->sample_period)
> > +             return -EINVAL;
>=20
> can use is_sampling_event() wrapper.

Fixed in v9.

> the uncore pmu usually doesn't support per-task counting so you may
> also need to check PERF_ATTACH_TASK.

This case will not be checked here because perf_event_alloc() will
return -EINVAL.

> > +
> > +     /*
> > +      * Task mode not available, we run the counters as socket counter=
s,
> > +      * not attributable to any CPU and therefore cannot attribute per=
-task.
> > +      */
> > +     if (event->cpu < 0)
> > +             return -EINVAL;
> > +
> > +     /* Validate the group */
> > +     if (!fujitsu_uncore_validate_event_group(event))
> > +             return -EINVAL;
> > +
> > +     hwc->idx =3D -1;
> > +
> > +     event->cpu =3D uncorepmu->cpu;
> > +
> > +     return 0;
> > +}
> > +
> > +static void fujitsu_uncore_event_start(struct perf_event *event, int f=
lags)
> > +{
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     hwc->state =3D 0;
> > +     fujitsu_uncore_counter_start(event);
> > +}
> > +
> > +static void fujitsu_uncore_event_stop(struct perf_event *event, int fl=
ags)
> > +{
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     if (hwc->state & PERF_HES_STOPPED)
> > +             return;
> > +
> > +     fujitsu_uncore_counter_stop(event);
> > +     if (flags & PERF_EF_UPDATE)
> > +             fujitsu_uncore_counter_update(event);
> > +     hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +}
> > +
> > +static int fujitsu_uncore_event_add(struct perf_event *event, int flag=
s)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     int idx;
> > +
> > +     /* Try to allocate a counter. */
> > +     idx =3D bitmap_find_free_region(uncorepmu->used_mask, uncorepmu->=
num_counters, 0);
> > +     if (idx < 0)
> > +             /* The counters are all in use. */
> > +             return -EAGAIN;
> > +
> > +     hwc->idx =3D idx;
> > +     hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +     uncorepmu->events[idx] =3D event;
> > +
> > +     if (flags & PERF_EF_START)
> > +             fujitsu_uncore_event_start(event, 0);
> > +
> > +     /* Propagate changes to the userspace mapping. */
> > +     perf_event_update_userpage(event);
> > +
> > +     return 0;
> > +}
> > +
> > +static void fujitsu_uncore_event_del(struct perf_event *event, int fla=
gs)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     /* Stop and clean up */
> > +     fujitsu_uncore_event_stop(event, flags | PERF_EF_UPDATE);
> > +     uncorepmu->events[hwc->idx] =3D NULL;
> > +     bitmap_release_region(uncorepmu->used_mask, hwc->idx, 0);
> > +
> > +     /* Propagate changes to the userspace mapping. */
> > +     perf_event_update_userpage(event);
> > +}
> > +
> > +static void fujitsu_uncore_event_read(struct perf_event *event)
> > +{
> > +     fujitsu_uncore_counter_update(event);
> > +}
> > +
> > +#define UNCORE_PMU_FORMAT_ATTR(_name, _config)                        =
             \
> > +     (&((struct dev_ext_attribute[]) {                                =
     \
> > +             { .attr =3D __ATTR(_name, 0444, device_show_string, NULL)=
,      \
> > +               .var =3D (void *)_config, }                            =
       \
> > +     })[0].attr.attr)
> > +
> > +static struct attribute *fujitsu_uncore_pmu_formats[] =3D {
> > +     UNCORE_PMU_FORMAT_ATTR(event, "config:0-7"),
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group fujitsu_uncore_pmu_format_group =
=3D {
> > +     .name =3D "format",
> > +     .attrs =3D fujitsu_uncore_pmu_formats,
> > +};
> > +
> > +static ssize_t fujitsu_uncore_pmu_event_show(struct device *dev,
> > +                                          struct device_attribute *att=
r, char *page)
> > +{
> > +     struct perf_pmu_events_attr *pmu_attr;
> > +
> > +     pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr=
);
> > +     return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> > +}
> > +
> > +#define MAC_EVENT_ATTR(_name, _id)                                    =
    \
> > +     PMU_EVENT_ATTR_ID(_name, fujitsu_uncore_pmu_event_show, _id)
> > +
> > +static struct attribute *fujitsu_uncore_mac_pmu_events[] =3D {
> > +     MAC_EVENT_ATTR(cycles,                          0x00),
> > +     MAC_EVENT_ATTR(read-count,                      0x10),
> > +     MAC_EVENT_ATTR(read-count-request,              0x11),
> > +     MAC_EVENT_ATTR(read-count-return,               0x12),
> > +     MAC_EVENT_ATTR(read-count-request-pftgt,        0x13),
> > +     MAC_EVENT_ATTR(read-count-request-normal,       0x14),
> > +     MAC_EVENT_ATTR(read-count-return-pftgt-hit,     0x15),
> > +     MAC_EVENT_ATTR(read-count-return-pftgt-miss,    0x16),
> > +     MAC_EVENT_ATTR(read-wait,                       0x17),
> > +     MAC_EVENT_ATTR(write-count,                     0x20),
> > +     MAC_EVENT_ATTR(write-count-write,               0x21),
> > +     MAC_EVENT_ATTR(write-count-pwrite,              0x22),
> > +     MAC_EVENT_ATTR(memory-read-count,               0x40),
> > +     MAC_EVENT_ATTR(memory-write-count,              0x50),
> > +     MAC_EVENT_ATTR(memory-pwrite-count,             0x60),
> > +     MAC_EVENT_ATTR(ea-mac,                          0x80),
> > +     MAC_EVENT_ATTR(ea-memory,                       0x90),
> > +     MAC_EVENT_ATTR(ea-memory-mac-write,             0x92),
> > +     MAC_EVENT_ATTR(ea-ha,                           0xa0),
> > +     NULL
> > +};
> > +
> > +#define PCI_EVENT_ATTR(_name, _id)                                    =
    \
> > +     PMU_EVENT_ATTR_ID(_name, fujitsu_uncore_pmu_event_show, _id)
> > +
> > +static struct attribute *fujitsu_uncore_pci_pmu_events[] =3D {
> > +     PCI_EVENT_ATTR(pci-port0-cycles,                0x00),
> > +     PCI_EVENT_ATTR(pci-port0-read-count,            0x10),
> > +     PCI_EVENT_ATTR(pci-port0-read-count-bus,        0x14),
> > +     PCI_EVENT_ATTR(pci-port0-write-count,           0x20),
> > +     PCI_EVENT_ATTR(pci-port0-write-count-bus,       0x24),
> > +     PCI_EVENT_ATTR(pci-port1-cycles,                0x40),
> > +     PCI_EVENT_ATTR(pci-port1-read-count,            0x50),
> > +     PCI_EVENT_ATTR(pci-port1-read-count-bus,        0x54),
> > +     PCI_EVENT_ATTR(pci-port1-write-count,           0x60),
> > +     PCI_EVENT_ATTR(pci-port1-write-count-bus,       0x64),
> > +     PCI_EVENT_ATTR(ea-pci,                          0x80),
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group fujitsu_uncore_mac_pmu_events_grou=
p =3D {
> > +     .name =3D "events",
> > +     .attrs =3D fujitsu_uncore_mac_pmu_events,
> > +};
> > +
> > +static const struct attribute_group fujitsu_uncore_pci_pmu_events_grou=
p =3D {
> > +     .name =3D "events",
> > +     .attrs =3D fujitsu_uncore_pci_pmu_events,
> > +};
> > +
> > +static ssize_t cpumask_show(struct device *dev,
> > +                         struct device_attribute *attr, char *buf)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D to_uncore_pmu(dev_get_drvdata(de=
v));
> > +
> > +     return cpumap_print_to_pagebuf(true, buf, cpumask_of(uncorepmu->c=
pu));
> > +}
> > +static DEVICE_ATTR_RO(cpumask);
> > +
> > +static struct attribute *fujitsu_uncore_pmu_cpumask_attrs[] =3D {
> > +     &dev_attr_cpumask.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group fujitsu_uncore_pmu_cpumask_attr_gr=
oup =3D {
> > +     .attrs =3D fujitsu_uncore_pmu_cpumask_attrs,
> > +};
> > +
> > +static const struct attribute_group *fujitsu_uncore_mac_pmu_attr_grps[=
] =3D {
> > +     &fujitsu_uncore_pmu_format_group,
> > +     &fujitsu_uncore_mac_pmu_events_group,
> > +     &fujitsu_uncore_pmu_cpumask_attr_group,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group *fujitsu_uncore_pci_pmu_attr_grps[=
] =3D {
> > +     &fujitsu_uncore_pmu_format_group,
> > +     &fujitsu_uncore_pci_pmu_events_group,
> > +     &fujitsu_uncore_pmu_cpumask_attr_group,
> > +     NULL
> > +};
> > +
> > +static void fujitsu_uncore_pmu_migrate(struct uncore_pmu *uncorepmu, u=
nsigned int cpu)
> > +{
> > +     perf_pmu_migrate_context(&uncorepmu->pmu, uncorepmu->cpu, cpu);
> > +     irq_set_affinity(uncorepmu->irq, cpumask_of(cpu));
> > +     uncorepmu->cpu =3D cpu;
> > +}
> > +
> > +static int fujitsu_uncore_pmu_online_cpu(unsigned int cpu, struct hlis=
t_node *cpuhp_node)
> > +{
> > +     struct uncore_pmu *uncorepmu;
> > +     int node;
> > +
> > +     uncorepmu =3D hlist_entry_safe(cpuhp_node, struct uncore_pmu, nod=
e);
> > +     node =3D dev_to_node(uncorepmu->dev);
> > +     if (cpu_to_node(uncorepmu->cpu) !=3D node && cpu_to_node(cpu) =3D=
=3D node)
> > +             fujitsu_uncore_pmu_migrate(uncorepmu, cpu);
> > +
> > +     return 0;
> > +}
> > +
> > +static int fujitsu_uncore_pmu_offline_cpu(unsigned int cpu, struct hli=
st_node *cpuhp_node)
> > +{
> > +     struct uncore_pmu *uncorepmu;
> > +     unsigned int target;
> > +     int node;
> > +
> > +     uncorepmu =3D hlist_entry_safe(cpuhp_node, struct uncore_pmu, nod=
e);
> > +     if (cpu !=3D uncorepmu->cpu)
> > +             return 0;
> > +
> > +     node =3D dev_to_node(uncorepmu->dev);
> > +     target =3D cpumask_any_and_but(cpumask_of_node(node), cpu_online_=
mask, cpu);
> > +     if (target >=3D nr_cpu_ids)
> > +             target =3D cpumask_any_but(cpu_online_mask, cpu);
> > +
> > +     if (target < nr_cpu_ids)
> > +             fujitsu_uncore_pmu_migrate(uncorepmu, target);
> > +
> > +     return 0;
> > +}
> > +
> > +static int fujitsu_uncore_pmu_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     unsigned long device_type =3D (unsigned long)device_get_match_dat=
a(dev);
> > +     const struct attribute_group **attr_groups;
> > +     struct uncore_pmu *uncorepmu;
> > +     struct resource *memrc;
> > +     size_t alloc_size;
> > +     char *name;
> > +     int ret;
> > +     int irq;
> > +     u64 uid;
> > +
> > +     ret =3D acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "unable to read ACPI uid\n=
");
> > +
> > +     uncorepmu =3D devm_kzalloc(dev, sizeof(*uncorepmu), GFP_KERNEL);
> > +     if (!uncorepmu)
> > +             return -ENOMEM;
> > +     uncorepmu->dev =3D dev;
> > +     uncorepmu->cpu =3D cpumask_local_spread(0, dev_to_node(dev));
> > +     platform_set_drvdata(pdev, uncorepmu);
> > +
> > +     switch (device_type) {
> > +     case FUJITSU_UNCORE_PMU_MAC:
> > +             uncorepmu->num_counters =3D MAC_NUM_COUNTERS;
> > +             attr_groups =3D fujitsu_uncore_mac_pmu_attr_grps;
> > +             name =3D devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac=
%llu_ch%llu",
> > +                                   (uid >> 8) & 0xF, (uid >> 4) & 0xF,=
 uid & 0xF);
> > +             break;
> > +     case FUJITSU_UNCORE_PMU_PCI:
> > +             uncorepmu->num_counters =3D PCI_NUM_COUNTERS;
> > +             attr_groups =3D fujitsu_uncore_pci_pmu_attr_grps;
> > +             name =3D devm_kasprintf(dev, GFP_KERNEL, "pci_iod%llu_pci=
%llu",
> > +                                   (uid >> 4) & 0xF, uid & 0xF);
> > +             break;
> > +     default:
> > +             return dev_err_probe(dev, -EINVAL, "illegal device type: =
%lu\n", device_type);
> > +     }
> > +     if (!name)
> > +             return -ENOMEM;
> > +
> > +     uncorepmu->pmu =3D (struct pmu) {
> > +             .parent         =3D dev,
> > +             .task_ctx_nr    =3D perf_invalid_context,
> > +
> > +             .attr_groups    =3D attr_groups,
> > +
> > +             .pmu_enable     =3D fujitsu_uncore_pmu_enable,
> > +             .pmu_disable    =3D fujitsu_uncore_pmu_disable,
> > +             .event_init     =3D fujitsu_uncore_event_init,
> > +             .add            =3D fujitsu_uncore_event_add,
> > +             .del            =3D fujitsu_uncore_event_del,
> > +             .start          =3D fujitsu_uncore_event_start,
> > +             .stop           =3D fujitsu_uncore_event_stop,
> > +             .read           =3D fujitsu_uncore_event_read,
> > +
> > +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CA=
P_NO_INTERRUPT,
> > +     };
> > +
> > +     alloc_size =3D sizeof(uncorepmu->events[0]) * uncorepmu->num_coun=
ters;
> > +     uncorepmu->events =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL);
> > +     if (!uncorepmu->events)
> > +             return -ENOMEM;
> > +
> > +     alloc_size =3D sizeof(uncorepmu->used_mask[0]) * BITS_TO_LONGS(un=
corepmu->num_counters);
> > +     uncorepmu->used_mask =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL=
);
> > +     if (!uncorepmu->used_mask)
> > +             return -ENOMEM;
> > +
> > +     uncorepmu->regs =3D devm_platform_get_and_ioremap_resource(pdev, =
0, &memrc);
> > +     if (IS_ERR(uncorepmu->regs))
> > +             return PTR_ERR(uncorepmu->regs);
> > +
> > +     fujitsu_uncore_init(uncorepmu);
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     ret =3D devm_request_irq(dev, irq, fujitsu_uncore_handle_irq, 0,
> > +                            name, uncorepmu);
>=20
> IRQF_NOBALANCING | IRQF_NO_THREAD is needed to ensure the interrupt won't=
 be threaded and
> is handled on the same cpu where the event starts, which is required by t=
he events framework
> for synchronisation. see a previous fix 0811ef7e2f54 (bus: arm-ccn: fix P=
MU interrupt flags).

Fixed in v9.

> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to request IRQ:%d\=
n", irq);
> > +
> > +     ret =3D irq_set_affinity(irq, cpumask_of(uncorepmu->cpu));
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to set irq affinit=
y:%d\n", irq);
> > +
> > +     uncorepmu->irq =3D irq;
> > +
> > +     /* Add this instance to the list used by the offline callback */
> > +     ret =3D cpuhp_state_add_instance(uncore_pmu_cpuhp_state, &uncorep=
mu->node);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Error registering hotplug=
");
> > +
> > +     ret =3D perf_pmu_register(&uncorepmu->pmu, name, -1);
> > +     if (ret < 0) {
> > +             cpuhp_state_remove_instance_nocalls(uncore_pmu_cpuhp_stat=
e, &uncorepmu->node);
> > +             return dev_err_probe(dev, ret, "Failed to register %s PMU=
\n", name);
> > +     }
> > +
> > +     dev_dbg(dev, "Registered %s, type: %d\n", name, uncorepmu->pmu.ty=
pe);
> > +
> > +     return 0;
> > +}
> > +
> > +static void fujitsu_uncore_pmu_remove(struct platform_device *pdev)
> > +{
> > +     struct uncore_pmu *uncorepmu =3D platform_get_drvdata(pdev);
> > +
> > +     writeq_relaxed(0, uncorepmu->regs + PM_CR);
>=20
> the pmu's already disable in pmu::pmu_disable(), is it redundant here or =
any reason to
> explicitly do it here?

I believe perf state is always enabled except when perf register is accesse=
d.
So, we disable it in the remove() handler.

>=20
> thanks.
>=20
> > +
> > +     perf_pmu_unregister(&uncorepmu->pmu);
> > +     cpuhp_state_remove_instance_nocalls(uncore_pmu_cpuhp_state, &unco=
repmu->node);
> > +}
> > +
> > +static const struct acpi_device_id fujitsu_uncore_pmu_acpi_match[] =3D=
 {
> > +     { "FUJI200C", FUJITSU_UNCORE_PMU_MAC },
> > +     { "FUJI200D", FUJITSU_UNCORE_PMU_PCI },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, fujitsu_uncore_pmu_acpi_match);
> > +
> > +static struct platform_driver fujitsu_uncore_pmu_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "fujitsu-uncore-pmu",
> > +             .acpi_match_table =3D fujitsu_uncore_pmu_acpi_match,
> > +             .suppress_bind_attrs =3D true,
> > +     },
> > +     .probe =3D fujitsu_uncore_pmu_probe,
> > +     .remove =3D fujitsu_uncore_pmu_remove,
> > +};
> > +
> > +static int __init fujitsu_uncore_pmu_init(void)
> > +{
> > +     int ret;
> > +
> > +     /* Install a hook to update the reader CPU in case it goes offlin=
e */
> > +     ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > +                                   "perf/fujitsu/uncore:online",
> > +                                   fujitsu_uncore_pmu_online_cpu,
> > +                                   fujitsu_uncore_pmu_offline_cpu);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     uncore_pmu_cpuhp_state =3D ret;
> > +
> > +     ret =3D platform_driver_register(&fujitsu_uncore_pmu_driver);
> > +     if (ret)
> > +             cpuhp_remove_multi_state(uncore_pmu_cpuhp_state);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit fujitsu_uncore_pmu_exit(void)
> > +{
> > +     platform_driver_unregister(&fujitsu_uncore_pmu_driver);
> > +     cpuhp_remove_multi_state(uncore_pmu_cpuhp_state);
> > +}
> > +
> > +module_init(fujitsu_uncore_pmu_init);
> > +module_exit(fujitsu_uncore_pmu_exit);
> > +
> > +MODULE_AUTHOR("Koichi Okuno <fj2767dz@fujitsu.com>");
> > +MODULE_DESCRIPTION("Fujitsu Uncore PMU driver");
> > +MODULE_LICENSE("GPL");

Best Regards,
Koichi Okuno
