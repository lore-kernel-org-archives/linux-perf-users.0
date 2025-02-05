Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A12AF0E;
	Wed,  5 Feb 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738729704; cv=fail; b=HQcL+Pbs4jeqLv0a3BlTQQes4lOxcjhC8YUDBnO5QOnAI8h8CKc9f+GDxa6odUM5dXLWLnpI6jmzu5H61OH+MWIHuSDISmXpiyZi6KqTHtO03MEdHTfIaeNe5+7zsLCMnhj1B+VJu2Pf7naa8YklwYeHbcQHDLUSFF5iNrMAdfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738729704; c=relaxed/simple;
	bh=LDu8vwt4UNH6k+VkeXnO+N1S3kk1QEU6X8qbiiex8VY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hW/7g5mCStGE8DblrhI0g+ZSeriddPsPediw1w59sPdFjX+LLrb9onFAUUOwZtnNm81fcLdLej/iSp3ypkcQoNdELmQ2YcZSBZOTcyX1+7z6VqeyIwF/58zZhPPxfvttjfD57bpxb8ttm0eUeGyqaW4/IHN30Unl9HgO66pWu3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHhnb9Gt; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHhnb9Gt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738729702; x=1770265702;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LDu8vwt4UNH6k+VkeXnO+N1S3kk1QEU6X8qbiiex8VY=;
  b=lHhnb9GtQlYuk5/NqhfTborgWu29iZCsm+3KO5qM/l1VAJvpplbCt3ry
   VGjSvbg4wVEYX/c9ZzAD8WDL884ElR91hQ59XFGcmVEDTFXs5fpmTbP59
   NzAIl6n+hEm8BWag5Z7CskvLs5skT68OQ6OdRb6L5DA7wuwunqvaBnIl6
   ChFJHBEuXxBuV9lwM28Zi5lO37WbpdGtwwbqGbtU+fcyY/v2gG/0ACvYV
   0/4Vjr++fEQ46JbGLeVKzdXjqDBwQ5VGFl2yM1N1BC+f3TW4KaJsELlf6
   MXJxwDSlY1VYT/QdISS1XVpq+kM+9azZg3dh438rn9j1I3fK2dxdZZJcV
   w==;
X-CSE-ConnectionGUID: bCIaeBnWSGunjbubaaJDEA==
X-CSE-MsgGUID: /yUCoRgQQImjDnJQmh9OgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42118586"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="42118586"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 20:28:21 -0800
X-CSE-ConnectionGUID: f+h9uwgiQuK1yvvbKvcoVw==
X-CSE-MsgGUID: RN29mfoSSCWJan0AIJm4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111671855"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 20:28:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 20:28:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 20:28:20 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 20:28:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5F+U/PnSAA6T7KPDmHhtCFroDjIsG7e/yzOHZzGvD5nlcrpgs72vQ67yHSEkTiXmo9kLW1fOmh4VO6oBzoBiuv4uBv79KDNFJdyVzcj42RoIEX0v4l4O+7rMF26Xh1mOn+eMoBAT01gm1EBKTk500JvBkTAyVfuYwSdhcyYxtb6G6JHBazcHEEiAZz7xxGAWog9LgrMHq1BrHGdHfqQzzwfO/cX4n3keuFE2VWbVLMDis5k4jbuaC+pKoxBaPYFgf4yRUInau7pF2+jEeUvoxM5dAJrAvAzrhoZ4QJYu2+gIa+FAHAg1qBvBak+k8w33n8NQz0Rz4YypDkwSAcMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDu8vwt4UNH6k+VkeXnO+N1S3kk1QEU6X8qbiiex8VY=;
 b=V0dt8O/m6VAtug4JsS8N1b1A+bRkdw446F5a05fMC6WoFFm2L5icOxupo52rG83zx+t5nKf+qO5/zwT5xS+RmNpGBihP00NvOh3zc4aAkkV79jUTLjWI1LI4SX1q5N/r19hlmWZUrqhyPxuzz35o+zd5ZQfrzIefkeIaJwVycL+8jPSKsMlA306tF3Ut2YO9woA4Az32ZJPoJUnJg1WgxOwG33Df9UkyCrwAU3z8KPYjmglwO4tfc3eB7makkoaZ1UQRZsuwTtSuMY3pgzJGLYQ/B3RpN//UVOR+udLB8aYSkKCoPwLq8QfEokoRqUxSh5J6tkO2EquJGHGunGC4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.23; Wed, 5 Feb 2025 04:28:17 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 04:28:17 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "Baker, Edward" <edward.baker@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>, "mpetlan@redhat.com"
	<mpetlan@redhat.com>, "Taylor, Perry" <perry.taylor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Alt, Samantha" <samantha.alt@intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Wang, Weilin"
	<weilin.wang@intel.com>, "acme@kernel.org" <acme@kernel.org>,
	"afaerber@suse.de" <afaerber@suse.de>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 00/23] Intel vendor events and TMA 5.01 metrics
Thread-Topic: [PATCH v4 00/23] Intel vendor events and TMA 5.01 metrics
Thread-Index: AQHbd0xwhiq/GgV/4k6uxHhXgELPorM3qvaAgABzMQA=
Date: Wed, 5 Feb 2025 04:28:17 +0000
Message-ID: <d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com>
References: <20250204213259.127939-1-irogers@google.com>
	 <CAP-5=fXpuND+kNe16CJMETkMOW+__eQpB8No0ra5gyEcfqCCKQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXpuND+kNe16CJMETkMOW+__eQpB8No0ra5gyEcfqCCKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB6544:EE_
x-ms-office365-filtering-correlation-id: 7594ac77-2b82-4a33-1dae-08dd459d83be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SCtlc2lUMXRxa1ZJU1lhNGZETm1KQ28rVkUxc0N2eGozWGVzTlZVOWxwcDZW?=
 =?utf-8?B?a0xhRUZqQVJFMkFObHRSdW5DV3dzbjUrUm44bks5eFQ1aFB0QmF3RnZ3V0tx?=
 =?utf-8?B?bGpVVWYxcVJuN1ByWThoL0Rkdng4QlBaYThyR0d1MTd3Vzlkdkd4eFlSQVhj?=
 =?utf-8?B?MmtsOURpWXcySUZVTEY4R3BOK0FNWkZ6U3VwOEZpcDF6eXhJb3B1OExlKzNH?=
 =?utf-8?B?Z3c0QjhTQlhvQ3czWmg5anN6QUV4R1pmM0Y3Rmt4TldmeWxobktCOG9Qa2pV?=
 =?utf-8?B?bFBkcVZLZmxEY1pFYmxuRGc1by9ZTm5VckdZRTc1NDI3cHdTMmlWNHZwbzB3?=
 =?utf-8?B?MXVoclFQeHliOW1oOFc4d1ZrcFIyTHdxR1l1RVhjQ25ReDdhbjZELzZPUnE0?=
 =?utf-8?B?NEx2Tm0wV3pvZWxpRU5lVS8xamNTcFFUcDh0NHBveVp2RUtoaURrZFFIODFS?=
 =?utf-8?B?d3Vua2MyVTNsNVA0RjMyR2ZDSm1uN01aVmV6TGJvdnQ1UE5EdENkNnMydXky?=
 =?utf-8?B?VkpkZzhWZHVRaTEyTEcrazVsN1ZJUFFHRnROWGhFWlB2c1ZKTVBYY3J0YnNt?=
 =?utf-8?B?UWtNb1BjeTY0c21mRWg2NGVGZXB0ME5IYnNzaE50Ym5uSDQ0LzRLRTZKem1Y?=
 =?utf-8?B?ang4Nm8ydUNIWWhxTlhGSnJYWFI2b0tnT3pCTVlGUng2K0gvd041QVExZy85?=
 =?utf-8?B?MTY3eFg3dWw0K2ErMUtLMnRNUW1hZysxb1YxbG4zUVkzMUJxbjY5enVaYUtz?=
 =?utf-8?B?em9FSmNDWGpPNW9nRThZZlhkQW1DVGhNZ0tuT3VhRXZXL0RIMlhrZE9Jb3J5?=
 =?utf-8?B?ZHpOM3BIb0pZWHFEYWZqL20veFc2enVsVTV5WFgvZjRGYWFCaHROU3BtN2tp?=
 =?utf-8?B?S1hSNkhBc2d0dVZ5eFc3TjB4eEFKdi9uVDhyTWlNRVFiRGh3bkp1QzRDbDdZ?=
 =?utf-8?B?S2E3K2tZS013UVdKT0Z5dWZERFF2OXMyYjVsU052S1ZuWlRrSmczN0xyR0VL?=
 =?utf-8?B?YW1aMTU3RXdFRjBta0kycmZ5UUNQdnJxMmFXVFpic0ZlVjM4TjVubWpzTndy?=
 =?utf-8?B?ZEM1UDVVVkRSc2dhOUx4ZW9tdUlNbWErZHBFQWoxK3RSV1U1NEpOQldFSERW?=
 =?utf-8?B?QXhCMFZpMEUxVVRPdHg1enZtR2d1czMvRlBnWFhQU2N2cnpab3dpTzlNNm1h?=
 =?utf-8?B?aWE4NUN6NmU0aUJ5NEJKWjdrTHBGUjVXSmk2M1R1cW93SmdSVHdXTGt5N0s0?=
 =?utf-8?B?NDVQUkNtdk9ybzJ6S05hZlpkV0VaczlKMys0TmREZ2FtWWF3Y3IxWk44Nm44?=
 =?utf-8?B?dG0vdDNBYmRwZ2VkaitWL1lRTllST2tjZXkrY3lVUGlNc1JqNjc0MzVqR1cv?=
 =?utf-8?B?RXdFa2hnYlRoMjEvSlYrV0tJT250TU1QK0xleWg1OUdvYlJJUXArWEEyS3ZN?=
 =?utf-8?B?VkppT1liS05SOWY5cVRzY0E3L3JBQUxUTnlWcmlSNVFlY1dXMlFybGo4d1Z4?=
 =?utf-8?B?d0Vsb01zZThKZG9aOUMvM2FNMy80ZVRDOGo0Y0lmandXaUNRTXp3VVltcEt5?=
 =?utf-8?B?U2VybDJ0NE9sL01tYURtUXpvVFhUM3NZM3N5RUtDSVQybnNxdlJoejMzQkM4?=
 =?utf-8?B?SnpqZVdhS1IzWU52RlJFRVVBQXoyNW1iaU91eXFlM25SVjQ5UEtjdXFONW5l?=
 =?utf-8?B?SmxTVGNGVmxndUNaWjdhOTFLZjY3YS9XbERMdnRKdkZZVXlLSWpQUWJLamRL?=
 =?utf-8?B?b21yME5STU01a2ZWWmVwbk9zNmtyNlVzVlg1NVJnSVNUTGlIQyt1OW9ZcmM4?=
 =?utf-8?B?eEtkZi8ycStaU0lxU2lKeld1N1RpMHlDWGZtUjYwZnJCMkdpRFpFSUVuWkpO?=
 =?utf-8?B?QWpkT29lMERMMVAwemVQaVdOaldoNGt2Q3VGWHVLTGRYMGl6QWhuMk5QNGNK?=
 =?utf-8?B?aThRcE5uVk9FOGRCc1R5UHBwN2luNVlYeVBFcStiRURxVEFOeWxtRW9VWGVK?=
 =?utf-8?B?bE5kVVlYWk5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SERGUnpubGJySFJydVFKNGdNVGJXVEtBd0x6andnd2tPWWU5UVNHQUNhVzdm?=
 =?utf-8?B?VHFNbDRpbnZYWS9jekRZRFlCdzRnVUlCVE9ZWThhZ3Iydk43amlacWxOVmU4?=
 =?utf-8?B?RjhyVkZFSGhtWGlMZzNjYkU1Y0N5ZU5GU2s1cWtWajNqR1l4ZFVac0hQZmVl?=
 =?utf-8?B?SXRVQlVYNVgvMVpOZENUdkx2WEJ5NXpCZktEbkxMNWdEaDZpWEFzNDVTRk9Q?=
 =?utf-8?B?Q2tBU2JoYW1zaml1c0kxdU16Z1VCajV0RTdBUUk4ZVZNNmRnWHhIODBycCtk?=
 =?utf-8?B?WWIvRGt2WDBMeXpqemFUM041Z1d0MXN6anlsUk5ySjFoakVoVjRNWTRYdWhS?=
 =?utf-8?B?ZVBkVXRWT3ZnVGxlMVJjT1lPWWFyVU9yQ1diaVlGenZCd0o4Q0pUODUyRGZN?=
 =?utf-8?B?RmtXMnhGVlordkJCVStiRnRpM2xOeFZiUWlxWG0wZ3I2dVpmbHNvNXY4em9N?=
 =?utf-8?B?TE44VW9XTnVjMUZiVjhkaEY3N2h6eTZXaVk2b2ViYS82L0MyNUp3WWdGbDJj?=
 =?utf-8?B?cW5PZnNKcjVFT0g4NkxHWm1tYmJkZml5TlcreFQ5a0hBUEJqWUYzd055emNW?=
 =?utf-8?B?YldkaHdJWVJCcUh2cHFXdVpva09TUmNIaEcyTzAxYWxGMVdXM2ZWb0FnL2JC?=
 =?utf-8?B?K0o4a0hMQ3B4L3Y0V2xMRFdIMVFMSUdBNW85Y0IyUHVTcHJkam5xWUlNN20w?=
 =?utf-8?B?TmQrY3BEbERGUEpHRjByV0dJdzZMNmJkYllQTEJSUy9nYmhoQTJRVXlMV1Qr?=
 =?utf-8?B?TWRkMVVPOUdpUEpreGdFYjAwbXlQdm9VOFdGcEpiQlVFM1NCb2o3dlBHTHJS?=
 =?utf-8?B?cU15bFhmb3Jpbk15aFhwbE9sUEE0ZHQvL0xBbThqaklaY2tSK01lbjNMOGwv?=
 =?utf-8?B?elQ4OEt0UXdmU1RmaDBpakdudjVKT2VvbnhnMktNTzRJTkszTTRZRHhOS1lQ?=
 =?utf-8?B?QmFiR2FDNXk4aVMwVzhSdXJ3VE1tdkxPTXArMHUra3R0dDBPa3lqRlkzTitx?=
 =?utf-8?B?N0dhRXQwWjRuemVlbmxGWlR3UDFRYTNIWHJ5WExkV0oxdDB6SDVZWHVKK2RE?=
 =?utf-8?B?MTNZTUxhaUlXZXdZSElWeERrY0pBVlAyOHJrc05aVXF4UmMva0thOEM0LzRR?=
 =?utf-8?B?U1NFaExXOHJSYytwaEYrTjM5MUU1SDJGSTZLclFybDd1RWpqajByNW9kRkFq?=
 =?utf-8?B?bEhOV0Vnd0VZcjVFRDRaeE1OSTU2Um5RYy9GVk9IamtDNmM3eFFSUmtBZGJk?=
 =?utf-8?B?VDRyVldXNitJWFFYVEljbld2UVdRT3cySDRHVUhtOGxTSXRnR0dVRFpnekxa?=
 =?utf-8?B?amp6KzRUbW82MElaNHA0YVU1eE9SUE9zRkxLWEgwbU04SktwWklqais2Zkdh?=
 =?utf-8?B?ZVdsMUdZK3VpYitmdnFrVmFKZFVuY3YxWmNCOHVEbmZROW44ZjNKUzFaWXor?=
 =?utf-8?B?V2M4Z1BHV0NPaHIrczBXQUw1MzFML0xqR04wR0pUWFc5a2pZSjVvL0JYMWFR?=
 =?utf-8?B?QVFrRW9Gbnk5MjJITUJjeXFEZXUvNlVjUFJoZU9UNWJwWXdGTVovVjd1Szkz?=
 =?utf-8?B?djRzQ0xhTTVJbjFEa2tRTytiWnA1UjdORGJwMFZ3RkJHVllzVXVMRUZrQXhX?=
 =?utf-8?B?clU2Sk9QOGNaSitRZVV4TDdXdkxJcWkrYk9CTjRqTUhNRXNzL1E2STVoSU9Z?=
 =?utf-8?B?RDRWQS9iV20rL2J5Q0tGUUZLYzdObTdGRWRkbFZUVzVDK3hpemhkT1lzR0hr?=
 =?utf-8?B?R2JqL1dQUVhkdjF4UmFreTc0dUhCeHp6RjA3Y3ZzdXJNS08vRE1pVTdONGYr?=
 =?utf-8?B?N1BzclNPb2tCYlN1TlZxejc4cGowbmdEV3V3VVdiM1hSdkZwVVFPNmdXVG03?=
 =?utf-8?B?bXNZMVlTZ284ZjFnRUJ5d1hXbjduRGJ3VU1qOEtUamhOODRveTJPSEp4Lzkv?=
 =?utf-8?B?VkIyQ3lta2k2TnN5Zk1vS2pabzY5UHRweDR6S0pkUldoS09ObjNxdmxHYXdR?=
 =?utf-8?B?QlRQUW54by9YZ3Q2WitTL1Fhci9pdjFCMnF0eGFIOUhUUlV6R29sUU44Uk9U?=
 =?utf-8?B?R0VHZzlLTEJJTWFLSVhucTNvMEpmRVRncjZEVzVNMnFTeS9DNFVCSXBzTmZJ?=
 =?utf-8?B?UWxackMrbFIrbUVuZzdPeEJ1aWxSYmlpNVRweDR4WjBmV3JKeWhrSlVROFNN?=
 =?utf-8?Q?TCfxuAcZPrALNGq4iG5mj2c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6E5468B53172D42B53A027A65047132@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7594ac77-2b82-4a33-1dae-08dd459d83be
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 04:28:17.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynGTCvGFaSuwDUdMarHC55tfxsaycUswDpUdv/Xi8TGPIb+M3ybScZfHdsCy5YGx+HRZyzazc+RWysKZ9WZkbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAyLTA0IGF0IDEzOjM1IC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBUdWUsIEZlYiA0LCAyMDI1IGF0IDE6MzPigK9QTSBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2ds
ZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFVwZGF0ZSB0aGUgSW50ZWwgdmVuZG9yIGV2ZW50cyB0
byB0aGUgbGF0ZXN0Lg0KPiA+IFVwZGF0ZSB0aGUgbWV0cmljcyB0byBUTUEgNS4wMS4NCj4gPiBB
ZGQgQXJyb3dsYWtlIGFuZCBDbGVhcndhdGVyZm9yZXN0IHN1cHBvcnQuDQo+ID4gQWRkIG1ldHJp
Y3MgZm9yIExOTCBhbmQgR05SLg0KPiA+IEFkZHJlc3MgSUlPIHVuY29yZSBpc3N1ZSBzcG90dGVk
IG9uIEVNUiwgR1JSLCBHTlIsIFNQUiBhbmQgU1JGLg0KPiA+IA0KPiA+IFRoZSBwZXJmIGpzb24g
d2FzIGdlbmVyYXRlZCB1c2luZyB0aGUgc2NyaXB0Og0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9p
bnRlbC9wZXJmbW9uL2Jsb2IvbWFpbi9zY3JpcHRzL2NyZWF0ZV9wZXJmX2pzb24ucHkNCj4gPiB3
aXRoIHRoZSBnZW5lcmF0ZWQganNvbiBiZWluZyBpbjoNCj4gPiBodHRwczovL2dpdGh1Yi5jb20v
aW50ZWwvcGVyZm1vbi90cmVlL21haW4vc2NyaXB0cy9wZXJmDQo+ID4gDQo+ID4gVGhhbmtzIHRv
IFBlcnJ5IFRheWxvciA8cGVycnkudGF5bG9yQGludGVsLmNvbT4sIENhbGViIEJpZ2dlcnMNCj4g
PiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5jb20+LCBFZHdhcmQgQmFrZXIgPGVkd2FyZC5iYWtlckBp
bnRlbC5jb20+DQo+ID4gYW5kDQo+ID4gV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNv
bT4gZm9yIGhlbHBpbmcgZ2V0IHRoaXMgcGF0Y2gNCj4gPiBzZXJpZXMNCj4gPiB0b2dldGhlci4N
Cj4gPiANCj4gPiB2NDogRml4IFRTQyBldmVudHMgb24gaHlicmlkIG1pc3Rha2VubHkgc3BlY2lm
eWluZyB0aGUgY29yZSBQTVUNCj4gPiDCoMKgwqAgaW5oaWJpdGluZyB0aGUgdXNlIG9mIHRoZSBt
c3IgUE1VLg0KPiA+IHYzOiBGaXhlcyBmb3IgaHlicmlkIG1ldHJpY3MgdGhhdCB3ZXJlIG1pc3Np
bmcgUE1VLiBVcGRhdGUgdG8gdGhlDQo+ID4gwqDCoMKgIGxhdGVzdCBldmVudHMuDQo+ID4gdjI6
IEZpeCBoeWJyaWQgYW5kIENvLWF1dGhvcmVkLWJ5IHRhZyBpc3N1ZXMgcmVwb3J0ZWQgYnkNCj4g
PiDCoMKgwqAgQXJuYWxkby4gVXBkYXRlcyB0byBMdW5hcmxha2UgYW5kIE1ldGVvcmxha2UgZXZl
bnRzLiBBZGRpdGlvbg0KPiA+IG9mDQo+ID4gwqDCoMKgIENsZWFyd2F0ZXJmb3Jlc3QuDQo+IA0K
PiBTb3JyeSwgZm9yZ290IHRvIGFkZCBUaG9tYXMgYWdhaW4uDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyNTAyMDQyMTMyNTkuMTI3OTM5LTEtaXJvZ2Vyc0Bnb29nbGUuY29tLw0K
DQpIaSwgSSdtIHNlZWluZyBzb21lIHdhcm5pbmdzIGxpa2UgdGhpcyBhbmQgdGhlIGFsbCBtZXRy
aWNzIHRlc3QgaXMNCnNraXBwZWQ6DQoNClRlc3RpbmcgdG1hX2luZm9faW5zdF9taXhfaXBhcml0
aA0KRlAgaXNzdWVzDQpDYW5ub3QgcmVzb2x2ZSBJRHMgZm9yIHRtYV9pbmZvX2luc3RfbWl4X2lw
YXJpdGg6DQpjcHVfY29yZUBJTlNUX1JFVElSRUQuQU5ZQCAvIChjcHVfY29yZUBGUF9BUklUSF9J
TlNUX1JFVElSRUQuU0NBTEFSQCArDQpjcHVfY29yZUBGUF9BUklUSF9JTlNUX1JFVElSRUQuVkVD
VE9SQCkNClRlc3RpbmcgdG1hX2luZm9faW5zdF9taXhfaXBhcml0aF9hdngxMjgNCkZQIGlzc3Vl
cw0KQ2Fubm90IHJlc29sdmUgSURzIGZvciB0bWFfaW5mb19pbnN0X21peF9pcGFyaXRoX2F2eDEy
ODoNCmNwdV9jb3JlQElOU1RfUkVUSVJFRC5BTllAIC8NCihjcHVfY29yZUBGUF9BUklUSF9JTlNU
X1JFVElSRUQuMTI4Ql9QQUNLRURfRE9VQkxFQCArDQpjcHVfY29yZUBGUF9BUklUSF9JTlNUX1JF
VElSRUQuMTI4Ql9QQUNLRURfU0lOR0xFQCkNClRlc3RpbmcgdG1hX2luZm9faW5zdF9taXhfaXBh
cml0aF9hdngyNTYNCkZQIGlzc3Vlcw0KQ2Fubm90IHJlc29sdmUgSURzIGZvciB0bWFfaW5mb19p
bnN0X21peF9pcGFyaXRoX2F2eDI1NjoNCmNwdV9jb3JlQElOU1RfUkVUSVJFRC5BTllAIC8NCihj
cHVfY29yZUBGUF9BUklUSF9JTlNUX1JFVElSRUQuMjU2Ql9QQUNLRURfRE9VQkxFQCArDQpjcHVf
Y29yZUBGUF9BUklUSF9JTlNUX1JFVElSRUQuMjU2Ql9QQUNLRURfU0lOR0xFQCkNClRlc3Rpbmcg
dG1hX2luZm9faW5zdF9taXhfaXBhcml0aF9zY2FsYXJfZHANCkZQIGlzc3Vlcw0KQ2Fubm90IHJl
c29sdmUgSURzIGZvciB0bWFfaW5mb19pbnN0X21peF9pcGFyaXRoX3NjYWxhcl9kcDoNCmNwdV9j
b3JlQElOU1RfUkVUSVJFRC5BTllAIC8NCmNwdV9jb3JlQEZQX0FSSVRIX0lOU1RfUkVUSVJFRC5T
Q0FMQVJfRE9VQkxFQA0KVGVzdGluZyB0bWFfaW5mb19pbnN0X21peF9pcGFyaXRoX3NjYWxhcl9z
cA0KRlAgaXNzdWVzDQpDYW5ub3QgcmVzb2x2ZSBJRHMgZm9yIHRtYV9pbmZvX2luc3RfbWl4X2lw
YXJpdGhfc2NhbGFyX3NwOg0KY3B1X2NvcmVASU5TVF9SRVRJUkVELkFOWUAgLw0KY3B1X2NvcmVA
RlBfQVJJVEhfSU5TVF9SRVRJUkVELlNDQUxBUl9TSU5HTEVADQoNClRoYW5rcywNClRvbQ0KPiAN
Cj4gVGhhbmtzLA0KPiBJYW4NCg0K
