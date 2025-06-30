Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38061FDD;
	Mon, 30 Jun 2025 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751247396; cv=fail; b=DgS1jZNBfhCS1mWQZLrISjqXL/o9C3v/NLW4VLTasjqemT9f78y8r/QEh/fyl1jb1bSlJH3Rnc8EWNfB1MdnbSbCPExMaFd182ELTyxdVbBf6T1Zvw8i7dXhhoTtJvrAixpLoDs57zt7f9QGFcskxmfMXRTI3AFScXwyD5lUu6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751247396; c=relaxed/simple;
	bh=KUAdYLNHTRloiF4pr/Ht40rzP+v3v5t6pC/C0F/l/yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4fbOrDkxr4W9sAqKKZ37rWm24/A5VsnXkykKjcbBApfp7MqniONKj7hrT82u69TFuWhDS99ddaGylHpAY/ZzKUwa6yUlAUT9Ucv7nBkFrcRM8ZwIbAFUvEe+EtAw3yLfyniBJ7FwYoJFYKIbxrIMjaoJAhx+x4O8Xt2FIF9ueE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgkHaQgO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgkHaQgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751247394; x=1782783394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUAdYLNHTRloiF4pr/Ht40rzP+v3v5t6pC/C0F/l/yc=;
  b=UgkHaQgOob+JxuSUa2sUZskE4DEMM2pgE/rfseI9KwNdPK9pPFgDHDzr
   tdivOkerRmFiB+7ibJQaiTok/tkjuYwNKel9r2V5nJ73lw3iFVHuMJTpK
   3Vv1KNSsMwlopXJ6UGwbaeHHButAzTJZ6wmeW/vsavMAjPrEDw+263bwl
   FKInBbCvAL1ec8a5ZMbsGJHiTruUxrJJogXqv9EzpQtUwdW2EcrTsptFM
   vDU/FkiPQHCACEOvsff9b3e5Xd3mnSz8LeEYcytTmwrVTj9r3ZlnVLAeI
   uSKwVXXz15Zag71/jkd4mmKx8UU+uYawZ5B59V+XRxkerQMS4iCejFlg0
   A==;
X-CSE-ConnectionGUID: cFE+bkchQk6DTdOXf4v+rw==
X-CSE-MsgGUID: HPhUScTTQ26RRjvSD/VcNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="57242994"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="57242994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 18:36:34 -0700
X-CSE-ConnectionGUID: QU75gVFNTRKoxflZ6J+X2A==
X-CSE-MsgGUID: gQq8ba0wSWO0xYrWKU8o/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="157710850"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 18:36:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 18:36:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 18:36:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.76)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 18:36:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pwicrb4cwmhi+s4hCjKjfo2GapI4KdLD6UIt6uZNl5YOU8thz33JRXiKpmbk90gFgGsE7BHhuyOM0qQGmXlXNXOfZO4uKCR+FHU+/DeQK1eHSuLyO1Tx2jq0ku824xP6CzsmVsVmIaLzdi19jmW7thJqsTRUnb69FrA+SoCuqPsGWjKO5DcSWSOHIpyfQe/QVD6puJi8anEAVlEU7KsFxPE+9vzpx+/yIu4m9NcNOAQRZK8dSMFtDCgRDokL+Ny/WU3/p5HbcITUbdCuN3kSuvXzJq/TfrhVDt8lYrLdvGa62AgwtlvQWxtPcBGYwnwK37cx25MvUL+HjCrLqNm5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUAdYLNHTRloiF4pr/Ht40rzP+v3v5t6pC/C0F/l/yc=;
 b=l9DFI3RiYj2dO6KDbOoPuP8qU6+Ydm7AAwGjJdeMzPKTMFBqeAVreB/1FxUmX92t3cxlYc5/MVMQ5lLGvUehsBFcDCfgPMu7O5ucZ4hdsaRsV2D/M0N/MXRhstvoA0bJ7XHTNQPmkIv2ys1rf0D1AQFBWJguJ9rL8XXc9JD5VrXJNNgMK+uLOI9il61i1zuuJPQ/Eej/TsUEUC8KiPK6HO46YdE1fKpCXTefmnyvvT3ps2r5RvbiJXoS4aJKHKO0jIU9Vta2z7rZjn2/fyycfQTvF2vvHQxIp0E2QGIAQtfCapc0Yb+5vyq0n9SJTK4/xGzHW9lhp7+OWXYFU3Sr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 01:36:30 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%7]) with mapi id 15.20.8835.027; Mon, 30 Jun 2025
 01:36:30 +0000
From: "Li, Tianyou" <tianyou.li@intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "Guo, Wangyang" <wangyang.guo@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] tools/perf: Add --exclude-buildids option to perf
 archive command
Thread-Topic: [PATCH V2] tools/perf: Add --exclude-buildids option to perf
 archive command
Thread-Index: AQHb5eT1hhmy5KAh2k2Rl9B5zGwZ47QXXaaAgAOVICA=
Date: Mon, 30 Jun 2025 01:36:29 +0000
Message-ID: <MW4PR11MB828987AEE414C3858D23AE809546A@MW4PR11MB8289.namprd11.prod.outlook.com>
References: <aFrzSpvzzWeHdyJ5 () google ! com>
 <20250625161509.2599646-1-tianyou.li@intel.com>
 <175105038774.2492671.5711747632083820597.b4-ty@kernel.org>
In-Reply-To: <175105038774.2492671.5711747632083820597.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB8289:EE_|BL1PR11MB5956:EE_
x-ms-office365-filtering-correlation-id: e3f1f982-9d1a-4fb0-b6b0-08ddb77689b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3ZmNmNVRCsvUXlhc2txSG4wMURva3U4S3l1a2tjWDNaMXR1d3FkblVxenp2?=
 =?utf-8?B?a3J1Yy9hWG1yRlpTU2lsVGJnYmxSdmRveUFxU3ByelNMcnBQQTVEbWhOTlE5?=
 =?utf-8?B?VFhNNzZtY0VhOHFBZjV3OHZhazRPTFVSMVBlSDZJeDZHU2svZFNmTHVXbm5L?=
 =?utf-8?B?cWhkaHVLNysvM3FzN1pDS05wMlB0dHYxdnYwdkgxeFg2S0JRTTVLdEZtejRT?=
 =?utf-8?B?UmNGQkpHSzA5YzNkY2JrUi9NREZQL0VLcjhuOW5LR2V4T1N2UDhFUEx4bkVW?=
 =?utf-8?B?Q1pNM1AzbnVTTnBwYVcydWNWMjIvY0t5MUVJalZiSkFRUlROMFhNb0JDcnZV?=
 =?utf-8?B?MWZqVWg2dWI4aENsRGIxdG1UVWhYNGJhVVlQdU5va3RHa09za1V3QzhJWEpZ?=
 =?utf-8?B?Y3kyYktJUEh0eHJmN1phVkpJRGp4WXV1L1I0bkFIQzkzU0JVMVhtbnJuQTVK?=
 =?utf-8?B?OVN2V1BLenhLWWRMOXJQM1pFRVcvL29zUWhORnd3disrY2grYmIzNStKRXQ3?=
 =?utf-8?B?UnlaNWN2blNzYk5HK3hVN3JXb0RvOTd5SjJSTmVWbG5JODFJUzNjZG4xdTZi?=
 =?utf-8?B?SUpqSit0cytqQWRQemhUNTV6RzlaVm9zVHFkcHJ6Zy9FaVRwVWEyMnU1VVBY?=
 =?utf-8?B?VksrT1NRcTdlbVVwUkJyMHJaK2pMdTZocnVSdkdiYTRZU3VvZm85UmNaNFk5?=
 =?utf-8?B?cWh6WVZNaGRLSnd5czhvTWYrcWR1TjV2MkZuYkh6MnNpMmNKdUp6d3ZvcE5Y?=
 =?utf-8?B?ZGFRZlAvV3ptNEUwN085RjFPTnBsZlM5dHBLRVN3VExzQktKdFVBS2FUck90?=
 =?utf-8?B?ZExaZkM0a1pSKytETjdRMGVybTd1NjI5RFVHT1dwMzlsMlArRy9zaEZaL0Ro?=
 =?utf-8?B?STNvYlFDcVZNbEpUdnpVQkp3cThkRmRyT1kwdFJYb0ZnWDAyUktCSnVVdmVX?=
 =?utf-8?B?ckxvVWJoUDlLNVNNZFVxWXE4dzJ1dm5zQU0rWUpQdXFJbTN5Y1FoaGxtakhE?=
 =?utf-8?B?V3BBMzNzWFAxLzF4bTZGV0ZzaEsyRGdQcnVyd2c2cTRaVVF1UW15ajNBOVN5?=
 =?utf-8?B?OHIvamc0TlQ0OTh0dm95ZzlOOUJmTVlNWVkzUXVEZFUxVzBVV2hOM1RrckNn?=
 =?utf-8?B?czl0ODc0U0tncm50RzFJMGRiM3lLTEJUMElvdjJwd2lPTFdXcWNkQnd2SEhR?=
 =?utf-8?B?aXN3T2F3ZDZ4ZElEbzJ5d2pvMmdHL1F3ejg5VTN2aFlsMVdqUW1VdlZIWS9Q?=
 =?utf-8?B?RTZwaUJFZjJQYkhwYVYweVhUNmxBUkhCajFRYlRYVUNOZ0hvNDhEZDRmdjVH?=
 =?utf-8?B?UWpPbXl0YVpHS1lydTVheGlHVGFIZTlWQXlhbFFRdG5xaEtLdnR1cGg0R2ZG?=
 =?utf-8?B?SkNoY09mcm9zYXpiaEtTVFdJU2xLM2N2NlprcW9NdzlpZW1XRHVMS2wvS0Rr?=
 =?utf-8?B?WGFxVFFaWTNQYUxPd1JtTW96VWl1M09aRjQ1YUdzWmtmc1BpQTFPb1FqeHAw?=
 =?utf-8?B?YXpmTTFpZ0p5bHd3VjQ1aTFKd3EzZ3B6ZXdISlFRVGVLRUxBQ3RyR28yOFpp?=
 =?utf-8?B?TWd2SXF6RHVyMHU1QThRcU5QYXFmL1gwUUUzaVFJanAxT3hOL0huRUREY3dl?=
 =?utf-8?B?SzlRUzh5YkFxMUdKNjFCcFhwWS8yMWUyMmhhM1BRWHAzNEpOc2xDVnRGYkpT?=
 =?utf-8?B?a2E1K3lIblp4L0pSWElObTBSSnBRQWFhVDBBTUtkb0lzZmRodDhDUHVKUEVm?=
 =?utf-8?B?V2NOQTdPbkl0bHpaSnYwZi9RL05objNwNG0rY1Exb1NVU2p5NlJ6c0h6MHlo?=
 =?utf-8?B?ZlFvS3Ria0dHajcxUmZGQzk1dmFZY1ZWZjdDRFVVRloxK0tlM0F0azVUMjZy?=
 =?utf-8?B?ZlFjNVcvMXBQWG1RZUZSc2FNTFFDZFBST2tDMm9kWEM2SW9RNFJiL3Q4Tndx?=
 =?utf-8?B?SlRDN203Y2hza3pYaSswdU9jTkV5alJsY2Z0SEtnK1ZISE9NbHU3VTVOMmJq?=
 =?utf-8?B?anJ2WUJxSlhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUZObXVTcGRJRURSVEtZZzY1L0Y4SE9STFp4ekpHTzdnTlR3R081SERIQVhr?=
 =?utf-8?B?Z2VSZ1UyVXVYT1p2c2dRT1pTcjgzUllHdmpNMjNPUnlQck8yNVJWSXdKUDBt?=
 =?utf-8?B?QmpTeFhibTJIMnBGaW5VZnA3alcvbUEwNVBSR3h5U1JFakRRVFRxU251am9l?=
 =?utf-8?B?RUxJQ216azFncnB0WU9sbWllcjVncnpoTGtWUmxYcEFlYmVzaVZlZUFTWXJS?=
 =?utf-8?B?QTVkR1owYW9YamdEbDQxa0JyUGdQRnNyL3JIRktOajQrYW9KTnpyQzhENi9k?=
 =?utf-8?B?cHZKS3dOY3BYaStaYjJjbGord1dCa2ZFV3ZFWmhmK2tNSExadm1ZSVBFZ01G?=
 =?utf-8?B?RTd3WTdLcHdlOFdYcGdCd2x1U1cydTFrMkdCQVFnSFcxY0pLZkFFRzlKNml1?=
 =?utf-8?B?S3dJRlpoVVdpdDJNUGdqVUFhWmZrb0xWWjF4Wlp6YzllV1RjQVByTjNqNzNG?=
 =?utf-8?B?Y0pUbjFUR2RWemdXZEZTV2xBTjZpV2Uvd3VDWHpsRG9DZEV2RGJzWlpJK20w?=
 =?utf-8?B?dk91SkdSSFNCcExycnpKUzN6eHpVMFYvVlhIWTFQSC9FMUJ1b1pGTXRLaTkz?=
 =?utf-8?B?aDNXUGVOTlRXczJlaUZ5M2ttdlZaZzV4OTk3RW1HWmdWL1dhRG1nbEQ5Smpi?=
 =?utf-8?B?dWZIamkzemdqMkx3dHpKYi9oUnNnYWorV3lmOTkwaG8rKzNPeEdPRUI3Vkky?=
 =?utf-8?B?WEFHdC9zaFh5MVZWcEJjenlCRkFIaWFwamVHblJmbm9ESDZzQmxqM1RaQ3lY?=
 =?utf-8?B?bHV3YXR0ay9mTDM1WkVLakpDcGF1SXk4MUhUdjY5UDVPc1lsNmUzbnZKYXJn?=
 =?utf-8?B?ZFlHWmFGZWhsMGxJaklCWnhKRVUzMDJrT0cxb3JHSkphNnpEeGVmSHRUd3Rl?=
 =?utf-8?B?T25JYlZSZTRQRm9LUkx0Q1ZnV3E5ZEt6ZFJaTzg4RHNXbHhQTGRFYVN4RGdq?=
 =?utf-8?B?NFV5aFo0YzZSeDZnN21kTk5saW9oaDAyd2VZNDRDd0UzUW9vMkVzQnNBb1B0?=
 =?utf-8?B?UmZ4NDg4Rmc4ZG5KazFMczdwZTlkMnVFMVlwcGtvNXV3aG5RTVpORHNVOHZ4?=
 =?utf-8?B?NXUxNW85YVhSZnRxQ3Y4VGpzalRLVTg3MFRhQUx6Um95YUVPVnk5Yko1UC8w?=
 =?utf-8?B?TTB0R1o2TUhuaUlocUtHKzdYaWc1V2ErZ2tURzVZSXZCMWZYVjdodzFhc3lq?=
 =?utf-8?B?UmlnYzgzL09XYk5LcDlOL2lCZTdLK3RWckFOWlRqK3ZMcjdKMDh6VysxLzgv?=
 =?utf-8?B?RlRmNmRyZmk1TnZqdU1UMHZNVHRkWmZweEF6MWZ0T0pGRDdsZXo5Sm5LdFpC?=
 =?utf-8?B?WVkyKzFEZkNnTWszT0Fwbmt3eXRPaERESHhjZFJ5WEYvTTZjTFJuRjJZNU1F?=
 =?utf-8?B?RFJQTVV3aFJCMjJYaGJhU1dHMkFwUEo5Z0NKTnFzd2F1ak0zenBWOGcwMVFT?=
 =?utf-8?B?K2I5VXpQczcwTzB1WEJuRDBXZGw3WE1ZSUg5dE9uQjcweGtrRGovRWFOVWdD?=
 =?utf-8?B?a1FMTVgwOHN3UkNUK0c1ZHFQM2o4SFR5UzdwSnVkTlgvWFNjUnZkMHhyL0Zu?=
 =?utf-8?B?TVF2a0VVbnVHSVllWm5DMGdYaXBDVy9vVjVweU14Nyt6OHNYVzZ3cm9YWm9y?=
 =?utf-8?B?L0didjhlZUhhM2RlSFlpVURZSXFSM1NaaStQcmhNY2xZaTdOUEkzM2xhbGpu?=
 =?utf-8?B?MXpxYlVJYUVMeVIwRmhYNXVCYmk5UW5UakVUbWxEM09KczNmOUJhYWlsdXZJ?=
 =?utf-8?B?L3NNUE1hVmtQRGZnRmxaa3QzTnBjbXRoTitKUTBXQlIybEhXV1VXc0pjeVJX?=
 =?utf-8?B?TmdRTENZVnp0dEZLbm5jbERaT25Wb0w3OEgxbDdab1A0cUJOTlprSTBUZU94?=
 =?utf-8?B?d3RmMkNjTWU0VUlvWitkUDRYZzdkWmI1UWM2MGR4SnR5TU92bG5nWE9GdUl0?=
 =?utf-8?B?MmZvS1phYXZLdmJzdW5sQTRGSG1EajVrclUyVzJCQjlCcjZPb2FzdFE1Kzk3?=
 =?utf-8?B?R013T2hnK1FMWmZ3UzBWN0RhbzlYOEFCbEhWWk4yQ0Z0RTJubEJseDIwTXRx?=
 =?utf-8?B?cThGdjgwOXFTVjNFS2hPMTFQcC9QNGsrZ2tpNkEvQThoTjZHa015OHZ2MzAz?=
 =?utf-8?Q?27XhE5izUJWjhO7J8kZuQcIYp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f1f982-9d1a-4fb0-b6b0-08ddb77689b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 01:36:30.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVOrQ6frLDv/d5geDGdUMEl75VuXqFY/LDwjOftsNfI492ZTNeFKZ8FcrSpkUPbokWpYvOCX8lIYN9QRJrBWiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com

VGhhbmtzIE5hbWh5dW5nLCB2ZXJ5IGFwcHJlY2lhdGVkIGZvciB5b3VyIHJldmlldy4gDQoNClJl
Z2FyZHMsDQpUaWFueW91DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBOYW1o
eXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+IA0KU2VudDogU2F0dXJkYXksIEp1bmUgMjgs
IDIwMjUgMjo1MyBBTQ0KVG86IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
IDxhY21lQGtlcm5lbC5vcmc+OyBMaSwgVGlhbnlvdSA8dGlhbnlvdS5saUBpbnRlbC5jb20+DQpD
YzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFsZXhhbmRlciBTaGlzaGtp
biA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEh1bnRlciwgQWRy
aWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4
LmludGVsLmNvbT47IEd1bywgV2FuZ3lhbmcgPHdhbmd5YW5nLmd1b0BpbnRlbC5jb20+OyBsaW51
eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gdG9vbHMvcGVyZjogQWRkIC0tZXhjbHVkZS1idWls
ZGlkcyBvcHRpb24gdG8gcGVyZiBhcmNoaXZlIGNvbW1hbmQNCg0KT24gVGh1LCAyNiBKdW4gMjAy
NSAwMDoxNDowMSArMDgwMCwgVGlhbnlvdSBMaSB3cm90ZToNCj4gV2hlbiBtYWtlIGEgcGVyZiBh
cmNoaXZlLCBpdCBtYXkgY29udGFpbnMgdGhlIGJpbmFyaWVzIHRoYXQgdXNlciBkaWQgDQo+IG5v
dCB3YW50IHRvIHNoaXAgd2l0aCwgYWRkIC0tZXhjbHVkZS1idWlsZGlkcyBvcHRpb24gdG8gc3Bl
Y2lmeSBhIGZpbGUgDQo+IHdoaWNoIGNvbnRhaW5zIHRoZSBidWlsZGlkcyBuZWVkIHRvIGJlIGV4
Y2x1ZGVkLiBUaGUgZmlsZSBjYW4gYmUgZ2VuZXJhdGVkIGZyb20gY29tbWFuZDoNCj4gDQo+ICAg
ICBwZXJmIGJ1aWxkaWQtbGlzdCAtaSBwZXJmLmRhdGEgLS13aXRoLWhpdHMgfCBncmVwIC12ICJe
ICIgPiANCj4gZXhjbHVkZS1idWlsZGlkcy50eHQNCj4gDQo+IFRoZW4gcmVtb3ZlIHRoZSBsaW5l
cyBmcm9tIHRoZSBleGNsdWRlLWJ1aWxkaWRzLnR4dCBmb3IgYnVpbGRpZHMgc2hvdWxkIGJlIGlu
Y2x1ZGVkLg0KPiANCj4gWy4uLl0NCkFwcGxpZWQgdG8gcGVyZi10b29scy1uZXh0LCB0aGFua3Mh
DQoNCkJlc3QgcmVnYXJkcywNCk5hbWh5dW5nDQoNCg0K
