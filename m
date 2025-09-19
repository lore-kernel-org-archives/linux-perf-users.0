Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503801FAC37;
	Fri, 19 Sep 2025 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260785; cv=fail; b=Ij/riJtLw3JpY89+LcnEdKyRdR7ixMIgzG0rPxXWDMBOj4AvtQIP3xojvE1vVDAj2/O9VJ7MEREWlu991wsgmg4/1Rj0tJzKoCF9CnBVFGJIhBgDmbIS5e26bKubF9ISdpOSTpFPrDAShPnQzHCKjgAln0idTPfUDUlGCakGySg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260785; c=relaxed/simple;
	bh=KGnTFsP3AvYIfhnvXCp3DgdSPMcMFe21vXpWp5+6ASY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R8tc6pe0fDWUfkvfyzaGX2n18euvipm9bj8ke2NKO0E2o2zw8gaeL3tH7780aNeymKXdF8TZnWLNrRwthT4xgORwrd8YTEPbBkTZhXTcEbKDykrqtWu0CUT7s4V3OlyrB8S2WN2riax7i5Cu635U+PplcjqFtoWyOxtsamCphf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OiOEdF/K; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GrilPNWm; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OiOEdF/K";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GrilPNWm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1758260782; x=1789796782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KGnTFsP3AvYIfhnvXCp3DgdSPMcMFe21vXpWp5+6ASY=;
  b=OiOEdF/K7Zx/vDjoQFrf27A86+ZV8SwZXTxV2sLAEnMd4sMDf636zWfv
   jkTyuRVuA2JlXtE5Ia1lkkDpOwxWhjBq0ktqjNfPM2aVr+Zh0rE2s5dGO
   8jaxlcrb/TtS8ehkMp4nE0h6wYHwyeOMJ5N2ucfjKbv3yHKvYFdp5EwoB
   KOnaZG+W7JSNaaUoBhNoY/sj5+LkgePdzbpTi8MTuNZvncor3iCQNM/u+
   7M7u4BRbZOSaHfC/bZ5SZmghH0eJWqSnsIGGny5gRplptglJMlA/wn0y6
   5rjnsLSw8zLnoI9T+Wgolxd0hn8JuZAYWY1DJ9auFP/1s//F5YJ4cnHVw
   w==;
X-CSE-ConnectionGUID: +U/ZW5jESTmgfGgLFpI60Q==
X-CSE-MsgGUID: HFEO2TprT4mQFaHFep2P/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="168231688"
X-IronPort-AV: E=Sophos;i="6.18,277,1751209200"; 
   d="scan'208";a="168231688"
Received: from mail-japaneastazon11011048.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.48])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:45:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbw1+t3zb/Gx6oZ5FNtf0EXFf59s5sLIjT57DkroHGIF0ghKT3AyLz2c4qqLGmfbKTfRjRMXAEHEdQxHkaoibn/bt4vxBdzpHzU7jrVMh5vS/F8/9L/Jok4C6yRCZYibkaW7IuHy6Kz6LVxS1FuGtuZ63DmOG9N1I+2uXFN4FTDekoF5z/zQlgu1JOs2mZhA6Fi6qCtcbVS7t7/2zCJxnfWPCITwbciAgqMQ1pptZSH2tmyp/y7jZv/rtd+LkLZvBl78b+/wbw/csS94RGMjiMvfE2anG6EZn8rrcGGqVqPkNzH2LQygzsKotT/o7eDqMHyBqt+r68CLGZSAluM/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agnQ8d1Pg8n/ej+PQgWXPLSp0ig0pEwuphfRpHQrnnw=;
 b=PExed/wyWRDjdUZ/VrZo6Pv+RCtJLg4lXlr0HKvLb2JPzIoLCRbm6D82daZru7vtKNqkmHctgm4CLpKFRfXEcDnqdfMRdlib6HS9jfWvHtnaT1McLRauG+NNsSIlldM8jQI9QV0nHT144UBcA5rqAzg+3JJoUzT5BTmiqoTJmxpsRo6O87tjxsVPclbaP2DRBDy0+vRBwCnugUV6kBLMrIxpa/UtE5+VQYgjLBpjMZIfujc3jmx/klxIzQThqilKyfG3LZ2ZRrq8ysqOB+Oa4KObiDQY+cNDId72+DUvCK7ecDViC1VhUavGqkB2Ur2HSszXV9/9zbXLBxj8rI203g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agnQ8d1Pg8n/ej+PQgWXPLSp0ig0pEwuphfRpHQrnnw=;
 b=GrilPNWmm6oMaK+U7Ky5kFaLjErFaiV18GHRLwIBqUYOthObJuido/lrR2KC8giEvfmYK53Tgk98lhvv7OUcC7jMMjKZRANSa2sV3XWdbT9VrGfjQX6iE/XE0Sfg6zfi4VuBA5rH1ol2an32iuv3HO1U7TsxCqElbPaQtH3JgVZ2nvaa4GqUhTQJujpd2xsBPfFcuf8p6d2WqxLVZJQzVxNwGQjLZ04ThAbxH3BspbxXIUiuDQQR1rK3G8e+95Y5c5SUdF045KiN2VY6WfKPfM+0QOCqB1yaiLolZNlcG99jSKixEYl11HlYhp6MRK9le2Kh3mByYtIx7VFh7l4fZg==
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com (2603:1096:604:33a::9)
 by OS9PR01MB14674.jpnprd01.prod.outlook.com (2603:1096:604:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 05:44:59 +0000
Received: from OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d]) by OSCPR01MB12819.jpnprd01.prod.outlook.com
 ([fe80::2809:3a6d:2dd0:ea9d%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 05:44:59 +0000
From: "Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: Jonathan Corbet <corbet@lwn.net>, Gowthami Thiagarajan
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
Subject: RE: [PATCH v9] perf: Fujitsu: Add the Uncore PMU driver
Thread-Topic: [PATCH v9] perf: Fujitsu: Add the Uncore PMU driver
Thread-Index: AQHcITZXoXvUadajkkmQqw8sH0I54LSaDEVw
Date: Fri, 19 Sep 2025 05:44:59 +0000
Message-ID:
 <OSCPR01MB12819CB5AEB76723636F22214C111A@OSCPR01MB12819.jpnprd01.prod.outlook.com>
References: <20250909030259.2313226-1-fj2767dz@fujitsu.com>
In-Reply-To: <20250909030259.2313226-1-fj2767dz@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=6c944d34-1565-4cdc-9d0e-fe47d61e1109;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-09-19T05:37:46Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12819:EE_|OS9PR01MB14674:EE_
x-ms-office365-filtering-correlation-id: 4f93d8fd-5440-49c7-0bfe-08ddf73fabec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TU5jOXNGd1pzVXBnOHA4NHZZRGR4NHdJV0prcHovdDl1VFFlNzV3MHdQ?=
 =?iso-2022-jp?B?UkwyVlhXRmNEKzlEWG5uazkyMDBYTmZHdVIrZmlIbU9jc1RvK3k5ZW1O?=
 =?iso-2022-jp?B?VmMxbGthNmF4VTN6MXdQbmNBUDI4UzlEU3NOU3FiVEdhMUt5LzNmUTV6?=
 =?iso-2022-jp?B?NVRYYmFxelcrS1pXL0thOTBxclN1V0M5ZjhnSTV4VkdzL0M2SEQ0YkJ1?=
 =?iso-2022-jp?B?d01LWitCb2tXdi9ydFprTUlEWFZkVS9nU1JyT3NPRlBIbHM5ZmxQbmxD?=
 =?iso-2022-jp?B?WmZRYisvOU9Qb1V2ZTgrR3lRUDVjVUVtUmgyZHRRaEJzODlWWWJrbG1s?=
 =?iso-2022-jp?B?bngvOWxEUEtvc0xCOFNLbDlpUlRiVnViZHBZdXJ0R28xN1F1M0JacEQv?=
 =?iso-2022-jp?B?T1RJNm5kV2Rtc2IzekRKeFdEZzhaWlh2TkZydCtZVHkrVFVFbGd6am9K?=
 =?iso-2022-jp?B?YzJkQTV5d05xR0xwN044Q0Ixa2VzQURCOW9QVVptWWtXaE94UVl6MzJ6?=
 =?iso-2022-jp?B?dmMzdlpWcDBMNk9wYTg5MFFmQ2tZeEZHSCtQQ2lZbWhYYUNiUzZmbGRk?=
 =?iso-2022-jp?B?ME8xK0NWUzVsV0dhMXFSSWU0VjJ6dk84bjh5SUgwQW1yOVl2Umx4Syt1?=
 =?iso-2022-jp?B?bkFna3VFdWZiNlgyd3ZKVnRsdEdBT0J2WGFtOHhqY2E3cjdPYk1pQ0V6?=
 =?iso-2022-jp?B?SUw0SGtFU3FSVmRlc3ZFU2hDOU1td1J0c04ybU5pdFlScGtUalBvN21H?=
 =?iso-2022-jp?B?eWx0VTVTV1VkSlJxYmRFcTdFQTBvWXdlNWxUY2NVNGhYMFZlWkV6RS91?=
 =?iso-2022-jp?B?WW5MUDFKMkNPNFIreXIrZEs2MWszSVlaZkZJOTFrRUZEcHNWNFN2dkg0?=
 =?iso-2022-jp?B?SmRPU2pJVFZTdUFNRUx1RjluenFkemVwdE5MZ0JoN1g0WFBhL2xaTm5Q?=
 =?iso-2022-jp?B?YVFvZk5udjBrL0lIWkkyTDhCcFMyelh5Tm9BUGhwYmgwd1ZxR2tZRUdN?=
 =?iso-2022-jp?B?K1BVZHZSemQvWm1yd25qLzFHWFBnSVZMQUtzbG1VYkhid2xVRGlnbFVU?=
 =?iso-2022-jp?B?b1BnNHl6MThpa0hDaUszbENzZG1OKzExTnhnQ3VwVWwybjhzdkRVcUVQ?=
 =?iso-2022-jp?B?VXRGTWNqN09qZFdhRExpWlhvMHRRblQyQjFXeWVHWjNqTkphL0xPNFdt?=
 =?iso-2022-jp?B?c2FkTlQrLzZmdWorMHZERnR0bkZ1Z2docjFubENHOUZrc2kwVlI2VlQ2?=
 =?iso-2022-jp?B?ZE9HNUYwazNPYXRRdU9yNHlqSGNPUVI1Mm1JZnl5SlJsZFJoQy8zcmwx?=
 =?iso-2022-jp?B?NThqSWRxYTNCWXlWNnBWNmo5L0MvdG5UWkx6WURjbDdMeXpHOW0zNmly?=
 =?iso-2022-jp?B?TmlVMFp4ck15amFJNGJMcmRnb3o4dW53dmtSVS9Qd2ZVeEgvTmhjc3FO?=
 =?iso-2022-jp?B?V3hUZS8vei9PV0k3U3Y1NGU5ZFc2WEVzMWd4T1JlQ3B2Z0dzVFZ1R3VV?=
 =?iso-2022-jp?B?SFh2MFhqdm9yWXM4VXJ4RkpnMk4zVWhGUERoYlgrbUJVRlZQUmJZSzV3?=
 =?iso-2022-jp?B?SWFTa1RhVHNTcjRFUCtMRmdmdXNoSGpxRGx2Tmk3TUhuMkxlY0k3QlZm?=
 =?iso-2022-jp?B?L1luanIrWmszM0dQNlM1M0o3bnpsV0FqSTRCZlRTOHZZNXNhZTlGaSs2?=
 =?iso-2022-jp?B?TCtpTnlUM05Lenk0Y29vdndlczZzbGw1N1p6djU5SVZYMUozVGxEcEZC?=
 =?iso-2022-jp?B?amFHd0ovdHRqUC84NGlxN1M4RkVWK0x3Q3RXS2wrNlMvVmp4a2FOK3dm?=
 =?iso-2022-jp?B?ZUtQV1UwdUxvNFpZS1dzUG9Yb1pka0xJd2UvQzRXRXo1SjhDNVBXVVB3?=
 =?iso-2022-jp?B?NWx1QVpmcm1XcVVmZnArY25UV09KclhXZUJ0dVFhbUdqcnExS1lqQ0VW?=
 =?iso-2022-jp?B?OUsrbzR4MjAxZ1c1Szh1NVN4YnpNZm5POWZhUmZUOGVwaEMxUzE3Ny90?=
 =?iso-2022-jp?B?SDMvcUVSVlBobzlJSXJ4ZUdlclRKRmhFSnNrUVdoZ1dYeDlDUUFKSEZI?=
 =?iso-2022-jp?B?eURMUnFUZythNzY0b0FCMWhkZEw2dGxwNVNQS1lEQVI2ZUhvZ0xsUGhU?=
 =?iso-2022-jp?B?SGJyRzRjNnhjUkllczA4dDRLVGdMbldRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12819.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MHFXRG02bGhmRDlBWDNtVG1GQTZlbWRWWXkvZFN1bkVtc1dtZC9PQXBk?=
 =?iso-2022-jp?B?Skd4OE5KczlTSXpOdkdrNHNWaGJ4QkRaUFE1V2hjdmVkWFVJU05VMkxX?=
 =?iso-2022-jp?B?djhSZG9TdXhLK0ZOdkFwQThDaVZndjNhNy9BUzdsVk91WjJ3eUg2aFM3?=
 =?iso-2022-jp?B?NkNsTTBPL0VBcEhsLzJlT0Znay9TRDJ0QVRIczBUWmhhd0xRdjRFSkJE?=
 =?iso-2022-jp?B?N21yZGM2QVRYMXdMbVB0T3NKZ0FsOXFKM3QvN3R6OHJ3ejNmakpaQnhk?=
 =?iso-2022-jp?B?UGdJSldYdy83OEJaalNJNTdzVEpTQllxdDE4bk1FNS9ObE10THN0MHhs?=
 =?iso-2022-jp?B?TzJJQWhzUEpZdlduU3pWaTl6MDVGTlVVdDhzQ1FodGJVTXQrZ3Q3YWg2?=
 =?iso-2022-jp?B?UThZdDltSC8xdVJHcEpkbWU1SDRSbWpsQW5HcmhwdW4zQUc3UjM0SmJR?=
 =?iso-2022-jp?B?clkydlI5RUI5SFdNSmQ5dGx3ek15bndHa2ViU210Z2NVRHVzVXplZTZs?=
 =?iso-2022-jp?B?WTJJZld1b3pZVU5DbFRkcSsxbGROMzBoWmVQaEJ3SkJxZGFrVEhPYStI?=
 =?iso-2022-jp?B?MFdhWmdNZnRhcHF1Q25xMmdVNmh4SG9CN2hQNnRMdyt0dHpEYXczMDB5?=
 =?iso-2022-jp?B?dS9VWi9adExKOEdoZ0VxeGxiRHl4bm95aWhXQXQwRjd2RFkwNmJGUVJF?=
 =?iso-2022-jp?B?anpuWWJmcDFlR1R2YWtRQUJHUTJpVkhSS3E5WWthTWFYdEx1b3RDVkdE?=
 =?iso-2022-jp?B?ZExJKzZidkk3ZmxocmNnQWszOHlSS1Jvd1BoN2xLRk5ZZFlKSHl6YllT?=
 =?iso-2022-jp?B?akVzQWJZVS9MeFI4OXNBaVcrRDJqN2pLaUF6amdJUlVHclYyZVRwcS8y?=
 =?iso-2022-jp?B?VlNHQm03ODhvOWZETDh1TCs5aVUrZnRDUmdxN015TUZPK2QxSjd1TGRq?=
 =?iso-2022-jp?B?YXJFQW83SllpTlMrejV5TTllQkFpQ1JQS2dhTmN4aWhjUEJyMWZSSlp4?=
 =?iso-2022-jp?B?b0FaQkp0WDJEdUdFbnJvWUFvTVpmTGEwRjA3RnpobkJGZysxWUVFNE1r?=
 =?iso-2022-jp?B?aVN5aHg4UnZjL0wzaUR4dTF4NWtYOUVkdkFDVHJuS09HZlV1WXRpV0dj?=
 =?iso-2022-jp?B?ZmxpNkZLSDdkVkxCVDBIaVBWSlIyNmlIYXo5eWszTFlsNFdCRnp4NmZp?=
 =?iso-2022-jp?B?ZFpzNFloSzI5UVVsS2o5dHRYcDBGOW1qLzZvUUx4WXZtaTN3aVFQL213?=
 =?iso-2022-jp?B?MjAwTXpCeHhkMUF0RERmaHlEVFRZcWc5bm84QkpxdGVLS01pSmdhVkM0?=
 =?iso-2022-jp?B?N2h6Tk9FcjVCUkd3dGkybFZsR1hkMys1OWxjeFhHQXZFQUZtN3c4TVJB?=
 =?iso-2022-jp?B?ckp1WXlwTmw3b0ZVZUQ4UGlncDU4TjNGeFZzcGNXWkZZVXcvOW5yRmlF?=
 =?iso-2022-jp?B?R0I2bk9tYmhpZm9BWWkzUHorYUV2dTJLblczNENjWW9EL3B3WTBoMkk5?=
 =?iso-2022-jp?B?aEVZTmdtc012aHdaMGo1WXgzVEpzRmtLVVpqRTAxcTNqdEV0MWFLZW9W?=
 =?iso-2022-jp?B?UkZ4cTdhSHkwSjJTd0hiUWJRZ2VOZE1tVGV4UkxhWDl1VHVDT1o0QXZH?=
 =?iso-2022-jp?B?aUx2aDVrUmp5YmFCRmN5ZUJ4ZkEwZm5WNFhDeWtvRkplT0wxRjQzcFcx?=
 =?iso-2022-jp?B?RnNORWY3eTV6ZjV0SGxSdXk2QVJTd21Hcmk2ODcwMzI1RXlMaGVMTDZ0?=
 =?iso-2022-jp?B?UXhFQjR3cUp6OGdHWmJqKy9yS1BHQloxNlRaRmZxV3k5M1llSGNsSFNS?=
 =?iso-2022-jp?B?Sm5ic1d2SzU4eTMxcnlDaW9FWlBOVENrVGp4WEp2VE9PSkZ4QVFxbUlU?=
 =?iso-2022-jp?B?aDhJY1ZZanZEQVlnOG1iWVd2dmVGU3dnaFJ1TUhGZXRFcCswVkdBL3JK?=
 =?iso-2022-jp?B?eG8wNVUxVm1rdzF6N0hTY2V2Y1dwdGNHNjVJcmtGVVBwZFVlc3hOVVN6?=
 =?iso-2022-jp?B?TUN5VVJaV0piLzVOLzRnYnplSmtOQllibVdDRW42RCtZWFdQcGVLUnA5?=
 =?iso-2022-jp?B?aVErRkl2RFZieDdvTEF1dzd1ZVpjTlVTSG5UT1R6TWQzZWRRaTQ5aVJj?=
 =?iso-2022-jp?B?THljZ0pPamFTNkdZR2dUaDZ0M1NzVTQyYzA5ZlRhN0lUT2lsd2pxMEI1?=
 =?iso-2022-jp?B?dFprMVUyNVRidU14RFVYMlhueXFZcXVoaDNRVUJaTlVWQUNlUlY1T3hY?=
 =?iso-2022-jp?B?dXRabkkzcEZNMEVMcGx4emRXK05ObW8zeUVyaHdEbm40VGJMbnVZREN2?=
 =?iso-2022-jp?B?UVJPWkpRbndrdEZnUDRkOFRxa0xROGhTVWc9PQ==?=
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
	lrwk/W9gkXV++BL5MkeBz63OzGgaBWgrkzyBil9kTQZ1bjjYyfBeixdtaOQRIIJXZQr2OUsGMk4BSNtHdCohj/+ApvhNy/xH6frqW50vviwywHUMnXoGasK5cC+BL3nJYBEYWnNyNaNuayY5DU3BLzYbIKqzZZzrrA69Ulv9GVz7o0k5EUnTjwPn+dcINhG1jUt0cro8Filtmk9Qf7VMtKERoJynkrLVmv+cDqcISZ+VRwIIjWcSNxJceefowb2oCWbzD4rvj9IAmUUXttYKjMIih76Dw3YAiDcj+EaKphFqru6BvqdYcMZs4FEhONYJPiar1LAKyTG/u4dNfuACGQnxafsERhcsLmxlxB41a/wW84IyCzk28ZdZrg/CSyKb5x5kFE64UB2IZFy325kdLKLeb1s3RjupORDczzzI10jSJzdwiE0lz6bkz//U9+KqwSH/1v4M0XO/jnj3yD1OZTsYnA5uPySU6SIexkJyqHN9icHr9yoUuXS6PsY5Lx7LachGry/c0NfUUQfsoTlXZbihHMXYTud873HSLzyHz/xraUO7woO3vjbQ6XNV79w86SgC3giL9ggHnJ0IrJRfpsQscm5HrfbTpO25AKCsNLC9t/Ll7AUsb7LDW6xyMjBi
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12819.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f93d8fd-5440-49c7-0bfe-08ddf73fabec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 05:44:59.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+Kf7jNWUDoIHp+WrrOkyDgsD09NYZLZbG/dKC/Ch1p3/E7xCBtnauIc+JET9on2qzsqjAIvzIHsMTWVXPcrSJMq02I4W2nCQloKaQuJoKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14674

Hi Will and Mark,
A very gentle ping on this patch.
Best regards,
Koichi Okuno

> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore PMUs in Fujitsu chips.
>=20
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
>=20
> perf stat -e pci_iod0_pci0/ea-pci/ ls
> perf stat -e pci_iod0_pci0/event=3D0x80/ ls
> perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> perf stat -e mac_iod0_mac0_ch0/event=3D0x80/ ls
>=20
> FUJITSU-MONAKA PMU Events Specification v1.1 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
>=20
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
> ---
> Changes in v9:
> - Fix v8 issues.
>   - Changed to use is_sampling_event()
>   - Changed request_irq flag
>   - Undo the deletion of set PM_CR.ENABLE in fujitsu_uncore_init()
>   - Added Yicong Yang's Reviewed-by:.
>   - Jonathan Cameron provided a Reviewed-by: for v7, but due to significa=
nt
>     changes in v8, it's not included in this v9.
> - Link to v8: https://lore.kernel.org/all/20250904021315.353541-1-fj2767d=
z@fujitsu.com/
>=20
>  .../admin-guide/perf/fujitsu_uncore_pmu.rst   | 110 ++++
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  drivers/perf/Kconfig                          |   9 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/fujitsu_uncore_pmu.c             | 613 ++++++++++++++++++
>  5 files changed, 734 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
>  create mode 100644 drivers/perf/fujitsu_uncore_pmu.c
>=20
> diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Docu=
mentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> new file mode 100644
> index 000000000000..46595b788d3a
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> @@ -0,0 +1,110 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Fujitsu Uncore Performance Monitoring Unit (PMU)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports the Uncore MAC PMUs and the Uncore PCI PMUs found
> +in Fujitsu chips.
> +Each MAC PMU on these chips is exposed as a uncore perf PMU with device =
name
> +mac_iod<iod>_mac<mac>_ch<ch>.
> +And each PCI PMU on these chips is exposed as a uncore perf PMU with dev=
ice name
> +pci_iod<iod>_pci<pci>.
> +
> +The driver provides a description of its available events and configurat=
ion
> +options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<ma=
c>_ch<ch>/
> +and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
> +This driver exports:
> +- formats, used by perf user space and other tools to configure events
> +- events, used by perf user space and other tools to create events
> +  symbolically, e.g.:
> +    perf stat -a -e mac_iod0_mac0_ch0/event=3D0x21/ ls
> +    perf stat -a -e pci_iod0_pci0/event=3D0x24/ ls
> +- cpumask, used by perf user space and other tools to know on which CPUs
> +  to open the events
> +
> +This driver supports the following events for MAC:
> +- cycles
> +  This event counts MAC cycles at MAC frequency.
> +- read-count
> +  This event counts the number of read requests to MAC.
> +- read-count-request
> +  This event counts the number of read requests including retry to MAC.
> +- read-count-return
> +  This event counts the number of responses to read requests to MAC.
> +- read-count-request-pftgt
> +  This event counts the number of read requests including retry with PFT=
GT
> +  flag.
> +- read-count-request-normal
> +  This event counts the number of read requests including retry without =
PFTGT
> +  flag.
> +- read-count-return-pftgt-hit
> +  This event counts the number of responses to read requests which hit t=
he
> +  PFTGT buffer.
> +- read-count-return-pftgt-miss
> +  This event counts the number of responses to read requests which miss =
the
> +  PFTGT buffer.
> +- read-wait
> +  This event counts outstanding read requests issued by DDR memory contr=
oller
> +  per cycle.
> +- write-count
> +  This event counts the number of write requests to MAC (including zero =
write,
> +  full write, partial write, write cancel).
> +- write-count-write
> +  This event counts the number of full write requests to MAC (not includ=
ing
> +  zero write).
> +- write-count-pwrite
> +  This event counts the number of partial write requests to MAC.
> +- memory-read-count
> +  This event counts the number of read requests from MAC to memory.
> +- memory-write-count
> +  This event counts the number of full write requests from MAC to memory=
.
> +- memory-pwrite-count
> +  This event counts the number of partial write requests from MAC to mem=
ory.
> +- ea-mac
> +  This event counts energy consumption of MAC.
> +- ea-memory
> +  This event counts energy consumption of memory.
> +- ea-memory-mac-write
> +  This event counts the number of write requests from MAC to memory.
> +- ea-ha
> +  This event counts energy consumption of HA.
> +
> +  'ea' is the abbreviation for 'Energy Analyzer'.
> +
> +Examples for use with perf::
> +
> +  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> +
> +And, this driver supports the following events for PCI:
> +- pci-port0-cycles
> +  This event counts PCI cycles at PCI frequency in port0.
> +- pci-port0-read-count
> +  This event counts read transactions for data transfer in port0.
> +- pci-port0-read-count-bus
> +  This event counts read transactions for bus usage in port0.
> +- pci-port0-write-count
> +  This event counts write transactions for data transfer in port0.
> +- pci-port0-write-count-bus
> +  This event counts write transactions for bus usage in port0.
> +- pci-port1-cycles
> +  This event counts PCI cycles at PCI frequency in port1.
> +- pci-port1-read-count
> +  This event counts read transactions for data transfer in port1.
> +- pci-port1-read-count-bus
> +  This event counts read transactions for bus usage in port1.
> +- pci-port1-write-count
> +  This event counts write transactions for data transfer in port1.
> +- pci-port1-write-count-bus
> +  This event counts write transactions for bus usage in port1.
> +- ea-pci
> +  This event counts energy consumption of PCI.
> +
> +  'ea' is the abbreviation for 'Energy Analyzer'.
> +
> +Examples for use with perf::
> +
> +  perf stat -e pci_iod0_pci0/ea-pci/ ls
> +
> +Given that these are uncore PMUs the driver does not support sampling, t=
herefore
> +"perf record" will not work. Per-task perf sessions are not supported.
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/adm=
in-guide/perf/index.rst
> index 072b510385c4..47d9a3df6329 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -29,3 +29,4 @@ Performance monitor support
>     cxl
>     ampere_cspmu
>     mrvl-pem-pmu
> +   fujitsu_uncore_pmu
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index a9188dec36fe..638321fc9800 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
>  	 can give information about memory throughput and other related
>  	 events.
> =20
> +config FUJITSU_UNCORE_PMU
> +	tristate "Fujitsu Uncore PMU"
> +	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
> +	 help
> +	 Provides support for the Uncore performance monitor unit (PMU)
> +	 in Fujitsu processors.
> +	 Adds the Uncore PMU into the perf events subsystem for
> +	 monitoring Uncore events.
> +
>  config QCOM_L2_PMU
>  	bool "Qualcomm Technologies L2-cache PMU"
>  	depends on ARCH_QCOM && ARM64 && ACPI
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 192fc8b16204..ea52711a87e3 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_ARM_XSCALE_PMU) +=3D arm_xscale_pmu.o
>  obj-$(CONFIG_ARM_SMMU_V3_PMU) +=3D arm_smmuv3_pmu.o
>  obj-$(CONFIG_FSL_IMX8_DDR_PMU) +=3D fsl_imx8_ddr_perf.o
>  obj-$(CONFIG_FSL_IMX9_DDR_PMU) +=3D fsl_imx9_ddr_perf.o
> +obj-$(CONFIG_FUJITSU_UNCORE_PMU) +=3D fujitsu_uncore_pmu.o
>  obj-$(CONFIG_HISI_PMU) +=3D hisilicon/
>  obj-$(CONFIG_QCOM_L2_PMU)	+=3D qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_unc=
ore_pmu.c
> new file mode 100644
> index 000000000000..c3c6f56474ad
> --- /dev/null
> +++ b/drivers/perf/fujitsu_uncore_pmu.c
> @@ -0,0 +1,613 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the Uncore PMUs in Fujitsu chips.
> + *
> + * See Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst for more de=
tails.
> + *
> + * Copyright (c) 2025 Fujitsu. All rights reserved.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/* Number of counters on each PMU */
> +#define MAC_NUM_COUNTERS  8
> +#define PCI_NUM_COUNTERS  8
> +/* Mask for the event type field within perf_event_attr.config and EVTYP=
E reg */
> +#define UNCORE_EVTYPE_MASK   0xFF
> +
> +/* Perfmon registers */
> +#define PM_EVCNTR(__cntr)           (0x000 + (__cntr) * 8)
> +#define PM_CNTCTL(__cntr)           (0x100 + (__cntr) * 8)
> +#define PM_CNTCTL_RESET             0
> +#define PM_EVTYPE(__cntr)           (0x200 + (__cntr) * 8)
> +#define PM_EVTYPE_EVSEL(__val)      FIELD_GET(UNCORE_EVTYPE_MASK, __val)
> +#define PM_CR                       0x400
> +#define PM_CR_RESET                 BIT(1)
> +#define PM_CR_ENABLE                BIT(0)
> +#define PM_CNTENSET                 0x410
> +#define PM_CNTENSET_IDX(__cntr)     BIT(__cntr)
> +#define PM_CNTENCLR                 0x418
> +#define PM_CNTENCLR_IDX(__cntr)     BIT(__cntr)
> +#define PM_CNTENCLR_RESET           0xFF
> +#define PM_INTENSET                 0x420
> +#define PM_INTENSET_IDX(__cntr)     BIT(__cntr)
> +#define PM_INTENCLR                 0x428
> +#define PM_INTENCLR_IDX(__cntr)     BIT(__cntr)
> +#define PM_INTENCLR_RESET           0xFF
> +#define PM_OVSR                     0x440
> +#define PM_OVSR_OVSRCLR_RESET       0xFF
> +
> +enum fujitsu_uncore_pmu {
> +	FUJITSU_UNCORE_PMU_MAC =3D 1,
> +	FUJITSU_UNCORE_PMU_PCI =3D 2,
> +};
> +
> +struct uncore_pmu {
> +	int			num_counters;
> +	struct pmu		pmu;
> +	struct hlist_node	node;
> +	void __iomem		*regs;
> +	struct perf_event	**events;
> +	unsigned long		*used_mask;
> +	int			cpu;
> +	int			irq;
> +	struct device		*dev;
> +};
> +
> +#define to_uncore_pmu(p) (container_of(p, struct uncore_pmu, pmu))
> +
> +static int uncore_pmu_cpuhp_state;
> +
> +static void fujitsu_uncore_counter_start(struct perf_event *event)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	int idx =3D event->hw.idx;
> +
> +	/* Initialize the hardware counter and reset prev_count*/
> +	local64_set(&event->hw.prev_count, 0);
> +	writeq_relaxed(0, uncorepmu->regs + PM_EVCNTR(idx));
> +
> +	/* Set the event type */
> +	writeq_relaxed(PM_EVTYPE_EVSEL(event->attr.config), uncorepmu->regs + P=
M_EVTYPE(idx));
> +
> +	/* Enable interrupt generation by this counter */
> +	writeq_relaxed(PM_INTENSET_IDX(idx), uncorepmu->regs + PM_INTENSET);
> +
> +	/* Finally, enable the counter */
> +	writeq_relaxed(PM_CNTCTL_RESET, uncorepmu->regs + PM_CNTCTL(idx));
> +	writeq_relaxed(PM_CNTENSET_IDX(idx), uncorepmu->regs + PM_CNTENSET);
> +}
> +
> +static void fujitsu_uncore_counter_stop(struct perf_event *event)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	int idx =3D event->hw.idx;
> +
> +	/* Disable the counter */
> +	writeq_relaxed(PM_CNTENCLR_IDX(idx), uncorepmu->regs + PM_CNTENCLR);
> +
> +	/* Disable interrupt generation by this counter */
> +	writeq_relaxed(PM_INTENCLR_IDX(idx), uncorepmu->regs + PM_INTENCLR);
> +}
> +
> +static void fujitsu_uncore_counter_update(struct perf_event *event)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	int idx =3D event->hw.idx;
> +	u64 prev, new;
> +
> +	do {
> +		prev =3D local64_read(&event->hw.prev_count);
> +		new =3D readq_relaxed(uncorepmu->regs + PM_EVCNTR(idx));
> +	} while (local64_cmpxchg(&event->hw.prev_count, prev, new) !=3D prev);
> +
> +	local64_add(new - prev, &event->count);
> +}
> +
> +static inline void fujitsu_uncore_init(struct uncore_pmu *uncorepmu)
> +{
> +	int i;
> +
> +	writeq_relaxed(PM_CR_RESET, uncorepmu->regs + PM_CR);
> +
> +	writeq_relaxed(PM_CNTENCLR_RESET, uncorepmu->regs + PM_CNTENCLR);
> +	writeq_relaxed(PM_INTENCLR_RESET, uncorepmu->regs + PM_INTENCLR);
> +	writeq_relaxed(PM_OVSR_OVSRCLR_RESET, uncorepmu->regs + PM_OVSR);
> +
> +	for (i =3D 0; i < uncorepmu->num_counters; ++i) {
> +		writeq_relaxed(PM_CNTCTL_RESET, uncorepmu->regs + PM_CNTCTL(i));
> +		writeq_relaxed(PM_EVTYPE_EVSEL(0), uncorepmu->regs + PM_EVTYPE(i));
> +	}
> +	writeq_relaxed(PM_CR_ENABLE, uncorepmu->regs + PM_CR);
> +}
> +
> +static irqreturn_t fujitsu_uncore_handle_irq(int irq_num, void *data)
> +{
> +	struct uncore_pmu *uncorepmu =3D data;
> +	/* Read the overflow status register */
> +	long status =3D readq_relaxed(uncorepmu->regs + PM_OVSR);
> +	int idx;
> +
> +	if (status =3D=3D 0)
> +		return IRQ_NONE;
> +
> +	/* Clear the bits we read on the overflow status register */
> +	writeq_relaxed(status, uncorepmu->regs + PM_OVSR);
> +
> +	for_each_set_bit(idx, &status, uncorepmu->num_counters) {
> +		struct perf_event *event;
> +
> +		event =3D uncorepmu->events[idx];
> +		if (!event)
> +			continue;
> +
> +		fujitsu_uncore_counter_update(event);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void fujitsu_uncore_pmu_enable(struct pmu *pmu)
> +{
> +	writeq_relaxed(PM_CR_ENABLE, to_uncore_pmu(pmu)->regs + PM_CR);
> +}
> +
> +static void fujitsu_uncore_pmu_disable(struct pmu *pmu)
> +{
> +	writeq_relaxed(0, to_uncore_pmu(pmu)->regs + PM_CR);
> +}
> +
> +static bool fujitsu_uncore_validate_event_group(struct perf_event *event=
)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	struct perf_event *leader =3D event->group_leader;
> +	struct perf_event *sibling;
> +	int counters =3D 1;
> +
> +	if (leader =3D=3D event)
> +		return true;
> +
> +	if (leader->pmu =3D=3D event->pmu)
> +		counters++;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (sibling->pmu =3D=3D event->pmu)
> +			counters++;
> +	}
> +
> +	/*
> +	 * If the group requires more counters than the HW has, it
> +	 * cannot ever be scheduled.
> +	 */
> +	return counters <=3D uncorepmu->num_counters;
> +}
> +
> +static int fujitsu_uncore_event_init(struct perf_event *event)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	/* Is the event for this PMU? */
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * Sampling not supported since these events are not
> +	 * core-attributable.
> +	 */
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	/*
> +	 * Task mode not available, we run the counters as socket counters,
> +	 * not attributable to any CPU and therefore cannot attribute per-task.
> +	 */
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	/* Validate the group */
> +	if (!fujitsu_uncore_validate_event_group(event))
> +		return -EINVAL;
> +
> +	hwc->idx =3D -1;
> +
> +	event->cpu =3D uncorepmu->cpu;
> +
> +	return 0;
> +}
> +
> +static void fujitsu_uncore_event_start(struct perf_event *event, int fla=
gs)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	hwc->state =3D 0;
> +	fujitsu_uncore_counter_start(event);
> +}
> +
> +static void fujitsu_uncore_event_stop(struct perf_event *event, int flag=
s)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	fujitsu_uncore_counter_stop(event);
> +	if (flags & PERF_EF_UPDATE)
> +		fujitsu_uncore_counter_update(event);
> +	hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +}
> +
> +static int fujitsu_uncore_event_add(struct perf_event *event, int flags)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx;
> +
> +	/* Try to allocate a counter. */
> +	idx =3D bitmap_find_free_region(uncorepmu->used_mask, uncorepmu->num_co=
unters, 0);
> +	if (idx < 0)
> +		/* The counters are all in use. */
> +		return -EAGAIN;
> +
> +	hwc->idx =3D idx;
> +	hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	uncorepmu->events[idx] =3D event;
> +
> +	if (flags & PERF_EF_START)
> +		fujitsu_uncore_event_start(event, 0);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void fujitsu_uncore_event_del(struct perf_event *event, int flags=
)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	/* Stop and clean up */
> +	fujitsu_uncore_event_stop(event, flags | PERF_EF_UPDATE);
> +	uncorepmu->events[hwc->idx] =3D NULL;
> +	bitmap_release_region(uncorepmu->used_mask, hwc->idx, 0);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +}
> +
> +static void fujitsu_uncore_event_read(struct perf_event *event)
> +{
> +	fujitsu_uncore_counter_update(event);
> +}
> +
> +#define UNCORE_PMU_FORMAT_ATTR(_name, _config)				      \
> +	(&((struct dev_ext_attribute[]) {				      \
> +		{ .attr =3D __ATTR(_name, 0444, device_show_string, NULL),      \
> +		  .var =3D (void *)_config, }				      \
> +	})[0].attr.attr)
> +
> +static struct attribute *fujitsu_uncore_pmu_formats[] =3D {
> +	UNCORE_PMU_FORMAT_ATTR(event, "config:0-7"),
> +	NULL
> +};
> +
> +static const struct attribute_group fujitsu_uncore_pmu_format_group =3D =
{
> +	.name =3D "format",
> +	.attrs =3D fujitsu_uncore_pmu_formats,
> +};
> +
> +static ssize_t fujitsu_uncore_pmu_event_show(struct device *dev,
> +					     struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define MAC_EVENT_ATTR(_name, _id)					     \
> +	PMU_EVENT_ATTR_ID(_name, fujitsu_uncore_pmu_event_show, _id)
> +
> +static struct attribute *fujitsu_uncore_mac_pmu_events[] =3D {
> +	MAC_EVENT_ATTR(cycles,				0x00),
> +	MAC_EVENT_ATTR(read-count,			0x10),
> +	MAC_EVENT_ATTR(read-count-request,		0x11),
> +	MAC_EVENT_ATTR(read-count-return,		0x12),
> +	MAC_EVENT_ATTR(read-count-request-pftgt,	0x13),
> +	MAC_EVENT_ATTR(read-count-request-normal,	0x14),
> +	MAC_EVENT_ATTR(read-count-return-pftgt-hit,	0x15),
> +	MAC_EVENT_ATTR(read-count-return-pftgt-miss,	0x16),
> +	MAC_EVENT_ATTR(read-wait,			0x17),
> +	MAC_EVENT_ATTR(write-count,			0x20),
> +	MAC_EVENT_ATTR(write-count-write,		0x21),
> +	MAC_EVENT_ATTR(write-count-pwrite,		0x22),
> +	MAC_EVENT_ATTR(memory-read-count,		0x40),
> +	MAC_EVENT_ATTR(memory-write-count,		0x50),
> +	MAC_EVENT_ATTR(memory-pwrite-count,		0x60),
> +	MAC_EVENT_ATTR(ea-mac,				0x80),
> +	MAC_EVENT_ATTR(ea-memory,			0x90),
> +	MAC_EVENT_ATTR(ea-memory-mac-write,		0x92),
> +	MAC_EVENT_ATTR(ea-ha,				0xa0),
> +	NULL
> +};
> +
> +#define PCI_EVENT_ATTR(_name, _id)					     \
> +	PMU_EVENT_ATTR_ID(_name, fujitsu_uncore_pmu_event_show, _id)
> +
> +static struct attribute *fujitsu_uncore_pci_pmu_events[] =3D {
> +	PCI_EVENT_ATTR(pci-port0-cycles,		0x00),
> +	PCI_EVENT_ATTR(pci-port0-read-count,		0x10),
> +	PCI_EVENT_ATTR(pci-port0-read-count-bus,	0x14),
> +	PCI_EVENT_ATTR(pci-port0-write-count,		0x20),
> +	PCI_EVENT_ATTR(pci-port0-write-count-bus,	0x24),
> +	PCI_EVENT_ATTR(pci-port1-cycles,		0x40),
> +	PCI_EVENT_ATTR(pci-port1-read-count,		0x50),
> +	PCI_EVENT_ATTR(pci-port1-read-count-bus,	0x54),
> +	PCI_EVENT_ATTR(pci-port1-write-count,		0x60),
> +	PCI_EVENT_ATTR(pci-port1-write-count-bus,	0x64),
> +	PCI_EVENT_ATTR(ea-pci,				0x80),
> +	NULL
> +};
> +
> +static const struct attribute_group fujitsu_uncore_mac_pmu_events_group =
=3D {
> +	.name =3D "events",
> +	.attrs =3D fujitsu_uncore_mac_pmu_events,
> +};
> +
> +static const struct attribute_group fujitsu_uncore_pci_pmu_events_group =
=3D {
> +	.name =3D "events",
> +	.attrs =3D fujitsu_uncore_pci_pmu_events,
> +};
> +
> +static ssize_t cpumask_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct uncore_pmu *uncorepmu =3D to_uncore_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(uncorepmu->cpu));
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *fujitsu_uncore_pmu_cpumask_attrs[] =3D {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group fujitsu_uncore_pmu_cpumask_attr_grou=
p =3D {
> +	.attrs =3D fujitsu_uncore_pmu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *fujitsu_uncore_mac_pmu_attr_grps[] =
=3D {
> +	&fujitsu_uncore_pmu_format_group,
> +	&fujitsu_uncore_mac_pmu_events_group,
> +	&fujitsu_uncore_pmu_cpumask_attr_group,
> +	NULL
> +};
> +
> +static const struct attribute_group *fujitsu_uncore_pci_pmu_attr_grps[] =
=3D {
> +	&fujitsu_uncore_pmu_format_group,
> +	&fujitsu_uncore_pci_pmu_events_group,
> +	&fujitsu_uncore_pmu_cpumask_attr_group,
> +	NULL
> +};
> +
> +static void fujitsu_uncore_pmu_migrate(struct uncore_pmu *uncorepmu, uns=
igned int cpu)
> +{
> +	perf_pmu_migrate_context(&uncorepmu->pmu, uncorepmu->cpu, cpu);
> +	irq_set_affinity(uncorepmu->irq, cpumask_of(cpu));
> +	uncorepmu->cpu =3D cpu;
> +}
> +
> +static int fujitsu_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_=
node *cpuhp_node)
> +{
> +	struct uncore_pmu *uncorepmu;
> +	int node;
> +
> +	uncorepmu =3D hlist_entry_safe(cpuhp_node, struct uncore_pmu, node);
> +	node =3D dev_to_node(uncorepmu->dev);
> +	if (cpu_to_node(uncorepmu->cpu) !=3D node && cpu_to_node(cpu) =3D=3D no=
de)
> +		fujitsu_uncore_pmu_migrate(uncorepmu, cpu);
> +
> +	return 0;
> +}
> +
> +static int fujitsu_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist=
_node *cpuhp_node)
> +{
> +	struct uncore_pmu *uncorepmu;
> +	unsigned int target;
> +	int node;
> +
> +	uncorepmu =3D hlist_entry_safe(cpuhp_node, struct uncore_pmu, node);
> +	if (cpu !=3D uncorepmu->cpu)
> +		return 0;
> +
> +	node =3D dev_to_node(uncorepmu->dev);
> +	target =3D cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, =
cpu);
> +	if (target >=3D nr_cpu_ids)
> +		target =3D cpumask_any_but(cpu_online_mask, cpu);
> +
> +	if (target < nr_cpu_ids)
> +		fujitsu_uncore_pmu_migrate(uncorepmu, target);
> +
> +	return 0;
> +}
> +
> +static int fujitsu_uncore_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	unsigned long device_type =3D (unsigned long)device_get_match_data(dev)=
;
> +	const struct attribute_group **attr_groups;
> +	struct uncore_pmu *uncorepmu;
> +	struct resource *memrc;
> +	size_t alloc_size;
> +	char *name;
> +	int ret;
> +	int irq;
> +	u64 uid;
> +
> +	ret =3D acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to read ACPI uid\n");
> +
> +	uncorepmu =3D devm_kzalloc(dev, sizeof(*uncorepmu), GFP_KERNEL);
> +	if (!uncorepmu)
> +		return -ENOMEM;
> +	uncorepmu->dev =3D dev;
> +	uncorepmu->cpu =3D cpumask_local_spread(0, dev_to_node(dev));
> +	platform_set_drvdata(pdev, uncorepmu);
> +
> +	switch (device_type) {
> +	case FUJITSU_UNCORE_PMU_MAC:
> +		uncorepmu->num_counters =3D MAC_NUM_COUNTERS;
> +		attr_groups =3D fujitsu_uncore_mac_pmu_attr_grps;
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
> +				      (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
> +		break;
> +	case FUJITSU_UNCORE_PMU_PCI:
> +		uncorepmu->num_counters =3D PCI_NUM_COUNTERS;
> +		attr_groups =3D fujitsu_uncore_pci_pmu_attr_grps;
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "pci_iod%llu_pci%llu",
> +				      (uid >> 4) & 0xF, uid & 0xF);
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "illegal device type: %lu\n", devic=
e_type);
> +	}
> +	if (!name)
> +		return -ENOMEM;
> +
> +	uncorepmu->pmu =3D (struct pmu) {
> +		.parent		=3D dev,
> +		.task_ctx_nr	=3D perf_invalid_context,
> +
> +		.attr_groups	=3D attr_groups,
> +
> +		.pmu_enable	=3D fujitsu_uncore_pmu_enable,
> +		.pmu_disable	=3D fujitsu_uncore_pmu_disable,
> +		.event_init	=3D fujitsu_uncore_event_init,
> +		.add		=3D fujitsu_uncore_event_add,
> +		.del		=3D fujitsu_uncore_event_del,
> +		.start		=3D fujitsu_uncore_event_start,
> +		.stop		=3D fujitsu_uncore_event_stop,
> +		.read		=3D fujitsu_uncore_event_read,
> +
> +		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> +	};
> +
> +	alloc_size =3D sizeof(uncorepmu->events[0]) * uncorepmu->num_counters;
> +	uncorepmu->events =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL);
> +	if (!uncorepmu->events)
> +		return -ENOMEM;
> +
> +	alloc_size =3D sizeof(uncorepmu->used_mask[0]) * BITS_TO_LONGS(uncorepm=
u->num_counters);
> +	uncorepmu->used_mask =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL);
> +	if (!uncorepmu->used_mask)
> +		return -ENOMEM;
> +
> +	uncorepmu->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &me=
mrc);
> +	if (IS_ERR(uncorepmu->regs))
> +		return PTR_ERR(uncorepmu->regs);
> +
> +	fujitsu_uncore_init(uncorepmu);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, fujitsu_uncore_handle_irq,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			       name, uncorepmu);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ:%d\n", irq);
> +
> +	ret =3D irq_set_affinity(irq, cpumask_of(uncorepmu->cpu));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set irq affinity:%d\n", irq)=
;
> +
> +	uncorepmu->irq =3D irq;
> +
> +	/* Add this instance to the list used by the offline callback */
> +	ret =3D cpuhp_state_add_instance(uncore_pmu_cpuhp_state, &uncorepmu->no=
de);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error registering hotplug");
> +
> +	ret =3D perf_pmu_register(&uncorepmu->pmu, name, -1);
> +	if (ret < 0) {
> +		cpuhp_state_remove_instance_nocalls(uncore_pmu_cpuhp_state, &uncorepmu=
->node);
> +		return dev_err_probe(dev, ret, "Failed to register %s PMU\n", name);
> +	}
> +
> +	dev_dbg(dev, "Registered %s, type: %d\n", name, uncorepmu->pmu.type);
> +
> +	return 0;
> +}
> +
> +static void fujitsu_uncore_pmu_remove(struct platform_device *pdev)
> +{
> +	struct uncore_pmu *uncorepmu =3D platform_get_drvdata(pdev);
> +
> +	writeq_relaxed(0, uncorepmu->regs + PM_CR);
> +
> +	perf_pmu_unregister(&uncorepmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(uncore_pmu_cpuhp_state, &uncorepmu-=
>node);
> +}
> +
> +static const struct acpi_device_id fujitsu_uncore_pmu_acpi_match[] =3D {
> +	{ "FUJI200C", FUJITSU_UNCORE_PMU_MAC },
> +	{ "FUJI200D", FUJITSU_UNCORE_PMU_PCI },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, fujitsu_uncore_pmu_acpi_match);
> +
> +static struct platform_driver fujitsu_uncore_pmu_driver =3D {
> +	.driver =3D {
> +		.name =3D "fujitsu-uncore-pmu",
> +		.acpi_match_table =3D fujitsu_uncore_pmu_acpi_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe =3D fujitsu_uncore_pmu_probe,
> +	.remove =3D fujitsu_uncore_pmu_remove,
> +};
> +
> +static int __init fujitsu_uncore_pmu_init(void)
> +{
> +	int ret;
> +
> +	/* Install a hook to update the reader CPU in case it goes offline */
> +	ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "perf/fujitsu/uncore:online",
> +				      fujitsu_uncore_pmu_online_cpu,
> +				      fujitsu_uncore_pmu_offline_cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	uncore_pmu_cpuhp_state =3D ret;
> +
> +	ret =3D platform_driver_register(&fujitsu_uncore_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(uncore_pmu_cpuhp_state);
> +
> +	return ret;
> +}
> +
> +static void __exit fujitsu_uncore_pmu_exit(void)
> +{
> +	platform_driver_unregister(&fujitsu_uncore_pmu_driver);
> +	cpuhp_remove_multi_state(uncore_pmu_cpuhp_state);
> +}
> +
> +module_init(fujitsu_uncore_pmu_init);
> +module_exit(fujitsu_uncore_pmu_exit);
> +
> +MODULE_AUTHOR("Koichi Okuno <fj2767dz@fujitsu.com>");
> +MODULE_DESCRIPTION("Fujitsu Uncore PMU driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.43.0
