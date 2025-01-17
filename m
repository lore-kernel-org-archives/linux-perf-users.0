Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9421531C0;
	Fri, 17 Jan 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145865; cv=fail; b=nyWZQGsjmQXm3eNJb82Ao28x0lYCJA1BpCP8xrQFXhKiIYlLMW7fca6O1NjhK9FD3twYV4qqTIG1vcvccXMjE2JznK1PztVmmNj9o2Let+0r2fTHp6kiRwmkssGf9nYhvfrGRc86LR1P8lOX87T2FCoHfQ4E+T9gCS+3oFnDUU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145865; c=relaxed/simple;
	bh=CRcWI41YWPg+e5SKqy6+GnRCk9PO0yZAlReGs7oT0U4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9nEEr5DBRqR7XwB6TmDwfaLbAHA6aqUn00isiKX8IdU2nJKuxJOdyYLH2Jn3m6KNfXkICil1/ELEzHEwbuqYfwZWC44vIzflxUCuB+r5kdbvRu35SQdXkQ6NApsb0XyEHvedrE2dSr0rgmjwo7QW2hmTJvdkmOAc5XfwcPgXS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMWP9xJy; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMWP9xJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737145863; x=1768681863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CRcWI41YWPg+e5SKqy6+GnRCk9PO0yZAlReGs7oT0U4=;
  b=CMWP9xJyYiBx/ZuZSRjeUyWR99VbD3amNU4wwnVcizFm368Cz3osPUT2
   BzUtw1p733+8LwbdGOUzMIhiQH8tqXr9QZ6Rl5LSUQKHzmblMFEchZC35
   JzxlAeoh+JOJgEtq1G+SSRlJR4UcUhJ+5KLyduBDpEATPbS2Cd3QhTjo5
   Nm00is2rY0H0ndJlcCbmo/1V8h0abVM24qfzxwkZUK3veOYoeLLUByt21
   rFL2EfuPy+8Y+5+ms580kGTLlVRjFZbA1QAHv79qzNrDMr753zCfz/FxY
   az8bFMaZTO0lVSS0VGLRWN0wi0gdTBPtuf6pp5Wf/Xop+wd3mm846HTSQ
   A==;
X-CSE-ConnectionGUID: rO+5qoVyTTiriLxTB7xWBg==
X-CSE-MsgGUID: 7xPqVsX7Q/K6jGGIVJKnIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="40400435"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="40400435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:31:02 -0800
X-CSE-ConnectionGUID: oGVqbRpUTPuzb0JhQ22lJg==
X-CSE-MsgGUID: iFooPbHnQC+mVGR/c0I9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="106079622"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 12:31:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 12:31:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 12:31:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 12:31:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvzBHfpDq/VySd36LFw8gRC5SHYsMYGcCeddJP8zxj/DOqNJCPgbiAtLSrl35ggyQzcfhQ1mT8ya+fScj2lV/mlB4ezVfdZTn41QZH6Nvz+iFNfiGIi0R4L6FdszYTvtuaKoDVHuN05gsMyE0AFWtHztJbjYaWrs1sJQ9rE5vE2MGDL4jdwluxF3iHKhkNrK680cZowi0vjO7k/ruBkXSbAyNVSI+rgrsCzQ1uB+aLt7pAkKV7dcmwswl+Eu0TORMyoTdL5KOjHIvr5bXlwPQfHfLKjyTTk/qMpvqXJQQYkC8jUQd5/mqyffaWVxpdYdPxA6ohogh0bdlRppqq+CSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRcWI41YWPg+e5SKqy6+GnRCk9PO0yZAlReGs7oT0U4=;
 b=ZuGs5v/7JLyZdpoVP0IUING5b0JVlnIE9KkGmLVGiqFSi9Atyr9fMiaN1twmxc91zxZXftoFkh4zg9xr8+82qkhIQX4yPmxEZ50b/9Eqxm5l8h8ta8Zrn7Aq6wxCCX+ApyqX/F8mI1cEm+GFwICN4AHfllJw4pSAmpohirlJ3gVeZO7TZmEIs5CodZm30ySbV8tlueSSJIWkS29Zj194VYHpY+wLlWQkavF5t82gnO+LiOrALayzrdiFwXxe6ZAKCdapgRxV3a9rEGWNau+TjWsl7dg5NR+QrG6QIK1pUNbk0VeL4rikyDzi1uaQAHpVueE0POIwh3csd5cX5rRjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CY5PR11MB6512.namprd11.prod.outlook.com (2603:10b6:930:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 20:30:12 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 20:30:12 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "Biggers, Caleb" <caleb.biggers@intel.com>, "irogers@google.com"
	<irogers@google.com>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"mpetlan@redhat.com" <mpetlan@redhat.com>, "Taylor, Perry"
	<perry.taylor@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "Alt, Samantha" <samantha.alt@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Wang, Weilin"
	<weilin.wang@intel.com>, "Baker, Edward" <edward.baker@intel.com>,
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 00/23] Intel vendor events and TMA 5.01 metrics
Thread-Topic: [PATCH v2 00/23] Intel vendor events and TMA 5.01 metrics
Thread-Index: AQHbZ+ISi/utFA4LU06vzV9r+KOfsbMbIvKAgAA0VYCAAAj9gIAADS6A
Date: Fri, 17 Jan 2025 20:30:12 +0000
Message-ID: <b5821a8375372fddd16ee6b53bf4cd218bdf9a8b.camel@intel.com>
References: <20250116064355.344245-1-irogers@google.com>
	 <10984553-bf84-4bff-9129-4b31815e38d6@linux.intel.com>
	 <3d87d244-a47b-4b70-90cd-710a38aa2431@linux.intel.com>
	 <CAP-5=fWzoxFDqEvVzTWoj0RRTDCuHxmENAyWqshQu2NQZYoJZg@mail.gmail.com>
In-Reply-To: <CAP-5=fWzoxFDqEvVzTWoj0RRTDCuHxmENAyWqshQu2NQZYoJZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CY5PR11MB6512:EE_
x-ms-office365-filtering-correlation-id: 79b2b9b1-9eba-4c32-5147-08dd3735be86
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Wks0aXQ3dExZTG5GNEczMzNlSk9SUlVJQjdlbnBvOXN4RUtRb0dsemR1S3Bn?=
 =?utf-8?B?MzVjOTdoc003Y3BjL3JnSTF4WjR5Y2RodjR5aUUwaHQ2Y2hXajNqS0xUbDIx?=
 =?utf-8?B?MzJ3dkZMaFk1bzkvVEJwVlkyUG9pVUQyZEozeGtLYk5vdG40L29lRGVuQkl1?=
 =?utf-8?B?TjVBNkQydSs5NjBlM3hzYlFFeXNub1puSVN0c1VBdUZHRkk0OU5GbWVkNlcr?=
 =?utf-8?B?NkhXY1Zya1VQZjFTMkdZaFZlSVFrMkxoa2F2bWY5Q0Q1R2djeFBLTHIvZFVN?=
 =?utf-8?B?c2dQbU1aSmZRMWxQMStFTi9QSm5uaUxscTM5Uk5YcUNoNS96YXpXRmN0S0FQ?=
 =?utf-8?B?cUxvZ0pYL3lnWUYwMmFRem4rY3ZWSEJpNUFYK2dPbzFuTzdIUW9ld09OZTlj?=
 =?utf-8?B?Rk0yeHpDTVgzTTM2RnNXU1JvMHNKNnBPM3ByZ3ZWWlQzcU5iVmJSUWJ1TGFB?=
 =?utf-8?B?YlFkSVNRalFoOWQxT2t5QmxoVDVOL2YwWEExa0FmRUw2enFqblllZno3a0NT?=
 =?utf-8?B?eWR4YVlDaFNzZ1ZCRHBwa0Z4b05HOW9KSDNIKzVNUUx1UWpQSUdVZlZPWHZX?=
 =?utf-8?B?d2lRZ3grTysvSktKcXVUU25KV1A0M2QzeGJJbHp2SmtiYXdUNFV2ZkkyRG5I?=
 =?utf-8?B?THVheGRrdjZzSlR6VXRkY0hUOVA5b1B1bDRaVWRHb3F6NFlaeUEzT0w4ZmQr?=
 =?utf-8?B?dkxqalRZcG05WDMzWVZ6TnVZbmRHeUU2WmlnMVArZWlKbWt3TThDZ3htNEps?=
 =?utf-8?B?MmxDMUVVeXEyWHQ5OGFqSmV4dG5JTnF5TFRSNVM2Ky9iY3UrWmIwSWF4Zyt4?=
 =?utf-8?B?SlZOVm1tNnU1STk3VkhIQTlUS1lrbkU2WmRQbjR5UUREVEgwOVRydldJbTh1?=
 =?utf-8?B?bkYyQzZTYTgybjNzOHRyYTBXTTFqcVZPVXdnZDE3elJ3T0ZZZTNYTHVhUkl5?=
 =?utf-8?B?R2dHT09CVDBsSHgxZDkwTGt5NXBCYlFwTGFucnJudFZRWVlNajgrbHUrUThC?=
 =?utf-8?B?VEpQWms2bDhBY0xGcEV3djNiMllndzE4QTFxbFFvOTVVZVVobEhQV2xBTkx1?=
 =?utf-8?B?ejJrTnVobTk1dkRaSjEyam5DS0J0eXBEQ2dibUNVY09Rc1FWck5hQVNRY3NY?=
 =?utf-8?B?RWJGUzduRHRRWWgzd3luSDExSDVkTXFkVjkxYm12RHorMllNWTNSZDVJWWhD?=
 =?utf-8?B?OStrSUc2djlKdmZyd3ZSZGd0OWJKY002RDZYU0J4MFcvREpuUGVyOFZqNy9N?=
 =?utf-8?B?WGw1LzZPMUI0ZFQwSk1Tb0JzbmZ2MlZtUmswNnJaK1V0QTU0MTYrZWMzenFG?=
 =?utf-8?B?UVNGbVEyM3h2RDd0SUZWaXgwZG1aSjJvTVN0TjF5UGlRc2ZIZXgvVFFSSEZD?=
 =?utf-8?B?UzVpVkRZUE1TSU1lbU4vQnpNaW96TGN5ZFVEWTB1b2pwTXdPUEZqbnkvRytk?=
 =?utf-8?B?QmU4cUN3bWxRSzljZ0h6a3dlSDNMcE9IWEVCNy9LUSsySXV3RXZ2UDVkdlFh?=
 =?utf-8?B?OTlxclFMQmdRMEVsYlU4Rmc0L0VJUkdQUmkzUFo1Y3M0MHFEUVFrV2dkSms0?=
 =?utf-8?B?eVdMd2FmQmw0VkN1TVY3UUFHMjNTWkV5dUdnOWxxS09UN0VqbmQ5SEJ1NTJ2?=
 =?utf-8?B?SmZmYTUzTGJrbnBVS2RRQVRsS0d5bVBqTGdLZkFidEx2QXZCUHk2UjFxTWND?=
 =?utf-8?B?bW8zMzU1M2lPdFYyN0JmUmhGZU5Mekowd0tkaGRuT3Bld3Zwa3FzRGlKQUVs?=
 =?utf-8?B?NmxXdTBTcWJVVU1pSWF4WU9tZ1p1MGRtKzB6empoOFUxSEY1dFNwS3J4OTRI?=
 =?utf-8?B?SjJVSDhvWjNmNkxUZmc2QWFrbEtxSVNxb0ttdmpyV2kyUjE1SlFXbVJ0SWVZ?=
 =?utf-8?B?WXpvcWphT1plMDlncm96TE1VTnJhcnhheVJsM1V5SVFFWkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkNoVHBnUmgzMUxYL0IzT00xSm5CblVXSDIvZXhKWE5XZ1JGaWF3dVpDVGRy?=
 =?utf-8?B?VGN0K0x5V2dhTUZCeXBEVWRZQkVnOGFMa0xvc1V5ZU03S084ODA3WHJzVnBo?=
 =?utf-8?B?Y2tEaXJiQ0dIWjg0RUpHSndhTTgrRWpkMm5DNWdUdW5mdHRjTFVob2RKakJY?=
 =?utf-8?B?TVg4OXVpcUdESXNJVHBEb1dvaHlDY1VJenZycFNpRjdJMjQ5azEreXl3bDhU?=
 =?utf-8?B?YjNjdjdEUGQzOUhxbTdVZThjaGl6YTFWM1lqUldRc1NEcjQvWnh1S2g2S2Vq?=
 =?utf-8?B?S0RZUlYwTXg2T2Uya3BZUjJFQkJuSFZ5bWwwS3o1VXoyM2NDNC9oRzNYNWs4?=
 =?utf-8?B?RHFrT2tPMEpZL1pFdWY1bkt3aDRiL0RobjlVWE1tYjV0bHhvZ0phc3JsdkUw?=
 =?utf-8?B?ZDdDUm4vYXhRRTQrYkhIVkZFVVgvWnM2ZDMyUjZxT0FkUVBXV1VyVXdpWjNO?=
 =?utf-8?B?YjROZWJYY0tndWVkdTE5dUdON2svT1U3VFJwbjEyU3ROQ0QvSnpyUXpOOUpo?=
 =?utf-8?B?bnA3WmJ0UnpaT2ZTeEZna1V3T0pYSk9xSTB2K1BjaDRYMVpCSUc4YXZKVGJm?=
 =?utf-8?B?RHFWRnZ6WGtvU3dqL0VjMm5mUXJmbDVvUHdZaFdXcTU5aFpjNVlNK21FU2hB?=
 =?utf-8?B?R01CYjN2NjB0cWlnV3ZwSnNSMDYrK281U1MzSE5CL01wUG5jR2J4TXZxV3Aw?=
 =?utf-8?B?d0N6d3k0SWJNZkZmZ21rT2hwU2xzMDdIaWwwY2haMldvcUdoTmVhMW1TcG55?=
 =?utf-8?B?aGV3a2NEKzIycWh0RU1JZ29KZ0ZDVncyckR0SWxtbFRkRmlwcm9RVnFHMXRr?=
 =?utf-8?B?SDE0KzFwOG5RS0p2UU1qcXhnczYzOTAwbjZma3FnZXE2SE1kb1pNSndTMUd5?=
 =?utf-8?B?bU9TeHFEVS9nMzNqSHhZWkptTGR3OFJFMnE1TGFwTlJBcWo5UDl4cFVHNlE0?=
 =?utf-8?B?VWswSVovWWUzWUVKdVNlSk1ESGQ3OVFUNWNzN1N3dU1jUW1Od0NDUkhuYmRW?=
 =?utf-8?B?NkgxSDVXQkU5NmdBVXRMb0VIWXlOaW8zOEdsdVNTZzZxclMrMXp3RzJZeU1v?=
 =?utf-8?B?Q3UrajdqRklQQ1luRlhpVVcvckJWUDVtZk5DT3ZvZTNuQUlFVGkvMWxPTVFJ?=
 =?utf-8?B?QWM4aG8yZzdWZlhVMUtrNVlJTzhsYzl2OUFrZ3BlWCtUaytJS2pwRUJ2ekF0?=
 =?utf-8?B?WS9SZzV1YWcwUkZLSUlFTlcxbzdTOVVvWGZNTmwwWkdSTkhyeUtkdUp2eERi?=
 =?utf-8?B?alBXZ25qdFhrc2crTGQ3VzJPdmNWZGpFeDdWL1hYK1gyVXdUTGdvd0Z2Ritz?=
 =?utf-8?B?ZzduQjNKZHRGZmJWeTlseFdwQWswWDBUNFNmQlgyc2VwMHhBWW84cVVJYm9R?=
 =?utf-8?B?Z1dBbWMrcHR5OFZnM2U0Z3pZMXRvT0ZRc0xVWWtyV0JhTEVPSDhsMTBheU9M?=
 =?utf-8?B?aXVzNGZ4WitCVU1TelkwSTNEVWZXNE5ZeCtMckw4OXNQQ0tZZVRpb3hNY2Va?=
 =?utf-8?B?UndZaVdYa0JwZVNGZ0hkQU1XMy9mcGF0M2N1VnZJOVJzazNTUHc3Mm00WGNE?=
 =?utf-8?B?ekhQa0FMY1VFNU1RcVlQeUtUVmZYRmhueTMzaDBQMC9kRzh4YTZKeTVVczRT?=
 =?utf-8?B?aEZ6S0R4VlNjbXJ0UXVYcWJ5Q2JhaitCZUFoU1hRd2p2Mjk5QXpoWkxSZW05?=
 =?utf-8?B?enA2Wld0WkNXRU9sSFM4YXpwQ2xFaU5oamhLeHRLZUVwSXQ4cXBlUlBKVEhM?=
 =?utf-8?B?cFVzUnFnUWhUZE12TDNZWDBPanY5YkZ6QldZMlVjcldUdVdBdXJpQnJaaHF5?=
 =?utf-8?B?Q253ckV3NGhnUDFqeTBaTFBoS0NVMHh6b01XVXVkTHlYV0xYVWMrVzRzVk13?=
 =?utf-8?B?OG9TTEs5ZEYrbEF5S2ZZU3JJSDRUaXl4eFJYUENjaHkyZys2UEJ4UlphK25U?=
 =?utf-8?B?QzBHNTY5STUvT3VCekt2V2ZHK3JzUkNKYlcxNWE4UC9idFJBSUd1SktPVFJX?=
 =?utf-8?B?S09Ga1Z0cmFWbURQV1dVUFZCd1d5dVVyb0JhOHBwd3AzMnBUU3hXVzVBRitO?=
 =?utf-8?B?WG82NnQvVElZTC9mWmJBRURCa0xkN1pjc0x0SjNxN2J1TlU2RjBIeXBQRVJn?=
 =?utf-8?B?QmRUZVhMSU1TcHNIYnhVTXdGUmJYSXFOSG5NYnBEbU4wYlZLOWZlTXUzWGx4?=
 =?utf-8?Q?RkRJXRAnpKkYiLg8+2oDqlg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3F482FEC1311A4986E097487B06443D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b2b9b1-9eba-4c32-5147-08dd3735be86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 20:30:12.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdytGUNSZVFjwwd9mK+MZabiDh3+90DU6eaFKY4OOA31zswhM9IcDYPlIvxLoW/U0x78aB0RII7V7+dFNKEORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAxLTE3IGF0IDExOjQzIC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBGcmksIEphbiAxNywgMjAyNSBhdCAxMToxMOKAr0FNIExpYW5nLCBLYW4NCj4gPGthbi5saWFu
Z0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IE9uIDIwMjUt
MDEtMTcgMTE6MDMgYS5tLiwgTGlhbmcsIEthbiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiBPbiAyMDI1LTAxLTE2IDE6NDMgYS5tLiwgSWFuIFJvZ2VycyB3cm90ZToNCj4gPiA+ID4gVXBk
YXRlIHRoZSBJbnRlbCB2ZW5kb3IgZXZlbnRzIHRvIHRoZSBsYXRlc3QuDQo+ID4gPiA+IFVwZGF0
ZSB0aGUgbWV0cmljcyB0byBUTUEgNS4wMS4NCj4gPiA+ID4gQWRkIEFycm93bGFrZSBhbmQgQ2xl
YXJ3YXRlcmZvcmVzdCBzdXBwb3J0Lg0KPiA+ID4gPiBBZGQgbWV0cmljcyBmb3IgTE5MIGFuZCBH
TlIuDQo+ID4gPiA+IEFkZHJlc3MgSUlPIHVuY29yZSBpc3N1ZSBzcG90dGVkIG9uIEVNUiwgR1JS
LCBHTlIsIFNQUiBhbmQgU1JGLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHBlcmYganNvbiB3YXMg
Z2VuZXJhdGVkIHVzaW5nIHRoZSBzY3JpcHQ6DQo+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9p
bnRlbC9wZXJmbW9uL2Jsb2IvbWFpbi9zY3JpcHRzL2NyZWF0ZV9wZXJmX2pzb24ucHkNCj4gPiA+
ID4gd2l0aCB0aGUgZ2VuZXJhdGVkIGpzb24gYmVpbmcgaW46DQo+ID4gPiA+IGh0dHBzOi8vZ2l0
aHViLmNvbS9pbnRlbC9wZXJmbW9uL3RyZWUvbWFpbi9zY3JpcHRzL3BlcmYNCj4gPiA+ID4gDQo+
ID4gPiA+IFRoYW5rcyB0byBQZXJyeSBUYXlsb3IgPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+LCBD
YWxlYiBCaWdnZXJzDQo+ID4gPiA+IDxjYWxlYi5iaWdnZXJzQGludGVsLmNvbT4sIEVkd2FyZCBC
YWtlcg0KPiA+ID4gPiA8ZWR3YXJkLmJha2VyQGludGVsLmNvbT4gYW5kDQo+ID4gPiA+IFdlaWxp
biBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IGZvciBoZWxwaW5nIGdldCB0aGlzIHBhdGNo
DQo+ID4gPiA+IHNlcmllcw0KPiA+ID4gPiB0b2dldGhlci4NCj4gPiA+ID4gDQo+ID4gPiA+IHYy
OiBGaXggaHlicmlkIGFuZCBDby1hdXRob3JlZC1ieSB0YWcgaXNzdWVzIHJlcG9ydGVkIGJ5DQo+
ID4gPiA+IMKgwqDCoCBBcm5hbGRvLiBVcGRhdGVzIHRvIEx1bmFybGFrZSBhbmQgTWV0ZW9ybGFr
ZSBldmVudHMuDQo+ID4gPiA+IEFkZGl0aW9uIG9mDQo+ID4gPiA+IMKgwqDCoCBDbGVhcndhdGVy
Zm9yZXN0Lg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgSWFuIQ0KPiA+ID4gDQo+ID4gPiBBY2tlZC1i
eTogS2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPg0KPiA+ID4gDQo+ID4gDQo+
ID4gVGhhbmtzIFRob21hcyB0byBkbyBtb3JlIHRlc3RzIGZvciB0aGUgc2VyaWVzLg0KPiA+IA0K
PiA+IFRoZXJlIGlzIGFuIGlzc3VlIGZvciB0aGUgRlBfQVJJVEgqIHJlbGF0ZWQgbWV0cmljcyBv
biBoeWJyaWQNCj4gPiBwbGF0Zm9ybXMuDQo+ID4gSSBoYXZlIHRvIHRha2UgdGhlIGFja2VkLWJ5
IGJhY2suIFNvcnJ5IGZvciB0aGUgbm9pc2UuDQo+ID4gDQo+ID4gSGVyZSBpcyB0aGUgaXNzdWUg
b24gQURMIGFuZCBBUkwuDQo+ID4gDQo+ID4gJCBzdWRvIC4vcGVyZiBzdGF0IC1NIHRtYV9pbmZv
X2luc3RfbWl4X2lwYXJpdGggLWEgc2xlZXAgMQ0KPiA+IENhbm5vdCByZXNvbHZlIElEcyBmb3Ig
dG1hX2luZm9faW5zdF9taXhfaXBhcml0aDogSU5TVF9SRVRJUkVELkFOWQ0KPiA+IC8NCj4gPiAo
RlBfQVJJVEhfSU5TVF9SRVRJUkVELlNDQUxBUiArIEZQX0FSSVRIX0lOU1RfUkVUSVJFRC5WRUNU
T1IpDQo+ID4gDQo+ID4gDQo+ID4gVGhlIHBhdGNoIHNldCBhZGQgdGhlIHRtYV9pbmZvX2luc3Rf
bWl4X2lwYXJpdGggZm9yIGNwdV9hdG9tLg0KPiA+IA0KPiA+ICvCoMKgwqAgew0KPiA+ICvCoMKg
wqDCoMKgwqDCoCAiQnJpZWZEZXNjcmlwdGlvbiI6ICJJbnN0cnVjdGlvbnMgcGVyIEZQIEFyaXRo
bWV0aWMNCj4gPiBpbnN0cnVjdGlvbg0KPiA+IChsb3dlciBudW1iZXIgbWVhbnMgaGlnaGVyIG9j
Y3VycmVuY2UgcmF0ZSkiLA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAiTWV0cmljRXhwciI6ICJJTlNU
X1JFVElSRUQuQU5ZIC8NCj4gPiAoRlBfQVJJVEhfSU5TVF9SRVRJUkVELlNDQUxBUg0KPiA+ICsg
RlBfQVJJVEhfSU5TVF9SRVRJUkVELlZFQ1RPUikiLA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAiTWV0
cmljR3JvdXAiOiAiRmxvcHM7SW5zVHlwZTtJbnN0X01ldHJpYyIsDQo+ID4gK8KgwqDCoMKgwqDC
oMKgICJNZXRyaWNOYW1lIjogInRtYV9pbmZvX2luc3RfbWl4X2lwYXJpdGgiLA0KPiA+ICvCoMKg
wqDCoMKgwqDCoCAiTWV0cmljVGhyZXNob2xkIjogInRtYV9pbmZvX2luc3RfbWl4X2lwYXJpdGgg
PCAxMCIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgICJQdWJsaWNEZXNjcmlwdGlvbiI6ICJJbnN0cnVj
dGlvbnMgcGVyIEZQIEFyaXRobWV0aWMNCj4gPiBpbnN0cnVjdGlvbiAobG93ZXIgbnVtYmVyIG1l
YW5zIGhpZ2hlciBvY2N1cnJlbmNlIHJhdGUpLiBWYWx1ZXMgPCAxDQo+ID4gYXJlDQo+ID4gcG9z
c2libGUgZHVlIHRvIGludGVudGlvbmFsIEZNQSBkb3VibGUgY291bnRpbmcuIEFwcHJveGltYXRl
ZCBwcmlvcg0KPiA+IHRvIEJEVyIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgICJVbml0IjogImNwdV9h
dG9tIg0KPiA+ICvCoMKgwqAgfSwNCj4gPiANCj4gPiBIb3dldmVyLCB0aGUgRlBfQVJJVEhfSU5T
VF9SRVRJUkVELlNDQUxBUiBhbmQNCj4gPiBGUF9BUklUSF9JTlNUX1JFVElSRUQuVkVDVE9SIGV2
ZW50IGFyZSBvbmx5IGF2YWlsYWJsZSBmb3IgY3B1X2NvcmUuDQo+ID4gDQo+ID4gc3VkbyAuL3Bl
cmYgc3RhdCAtZSBGUF9BUklUSF9JTlNUX1JFVElSRUQuU0NBTEFSIC1hIHNsZWVwIDENCj4gPiAN
Cj4gPiDCoFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6DQo+ID4g
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqAgY3B1X2Nv
cmUvRlBfQVJJVEhfSU5TVF9SRVRJUkVELlNDQUxBUi8NCj4gPiANCj4gPiBUaGVyZSBzaG91bGQg
YmUgbm8gc3VjaCBtZXRyaWMgZm9yIGNwdV9hdG9tLg0KPiANCj4gVGhhbmtzIFRob21hcyBhbmQg
S2FuIQ0KPiANCj4gVGhlIG1ldHJpYyBjYW1lIGZyb20gaGVyZToNCj4gaHR0cHM6Ly9naXRodWIu
Y29tL2ludGVsL3BlcmZtb24vYmxvYi9tYWluL0FETC9tZXRyaWNzL3BlcmYvYWxkZXJsYWtlX21l
dHJpY3NfZ29sZGVuY292ZV9jb3JlX3BlcmYuanNvbiNMMTI0Mw0KPiBhbmQgdGhlIGV2ZW50IGJl
aW5nIGluIHRoZSBjcHVfY29yZSB3aWxsIGV4cGxhaW4gd2h5IGl0IHBhc3NlZCB0aGUNCj4gc2Fu
aXR5IGNoZWNrIHRoYXQgYWxsIGV2ZW50cyBhcmUgaW4gdGhlIGV2ZW50IGpzb24uDQo+IA0KPiBJ
IGJlbGlldmUgQ2FsZWIgY2FuIGFkZHJlc3MgdGhlIGlzc3VlLiBJIHRoaW5rIGFsbCB0aGUgZXZl
bnRzIG5lZWQNCj4gUE1VDQo+IHByZWZpeGVzIGFzIGhhcHBlbmVkIHByZXZpb3VzbHkgaGVyZToN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL3BlcmZtb24vYmxvYi9tYWluL3NjcmlwdHMvY3Jl
YXRlX3BlcmZfanNvbi5weSNMMTUzNQ0KPiANCj4gQSBmZXcgbW9yZSBraW5rcyB0byByZXNvbHZl
IGluIHRoZSBuZXcgVE1BIHJlbGVhc2UgcHJvY2VzcywgdGhhbmtzDQo+IGZvcg0KPiB0aGUgdGVz
dGluZyENCj4gSWFuDQoNCg0KVGhhbmtzLCBJJ20gYWxzbyBzZWVpbmcgc29tZSB3ZWlyZG5lc3Mg
aW4gdGhlIHBlcmYgYWxsIG1ldHJpY3MgYW5kDQptZXRyaWNzZ3JvdXBzIHRlc3RzIHdpdGggdmVy
Ym9zZSBvdXRwdXQ6DQoNCi4uLi9wZXJmLXRvb2xzLW5leHQvdG9vbHMvcGVyZiMgLi9wZXJmIHRl
c3QgOTUNCiA5NTogcGVyZiBhbGwgbWV0cmljcyB0ZXN0ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDoNClNraXANCi4uLi9wZXJmLXRvb2xzLW5leHQvdG9vbHMvcGVy
ZiMgLi9wZXJmIHRlc3QgOTUgLXZ2dg0KIDk1OiBwZXJmIGFsbCBtZXRyaWNzIHRlc3Q6DQotLS0g
c3RhcnQgLS0tDQp0ZXN0IGNoaWxkIGZvcmtlZCwgcGlkIDEzNTUwMg0KVGVzdGluZyB0bWFfY29y
ZV9ib3VuZA0KDQouLi4NCg0KVGVzdGluZyB0bWFfZnBfc2NhbGFyDQpGUCBpc3N1ZXMNCkNhbm5v
dCByZXNvbHZlIElEcyBmb3IgdG1hX2ZwX3NjYWxhcjogRlBfQVJJVEhfSU5TVF9SRVRJUkVELlND
QUxBUiAvDQoodG1hX3JldGlyaW5nIGFyY2ggYmVuY2ggQnVpbGQgYnVpbHRpbi1hbm5vdGF0ZS5j
IGJ1aWx0aW4tYW5ub3RhdGUubw0KYnVpbHRpbi1iZW5jaC5jIGJ1aWx0aW4tYmVuY2gubyBidWls
dGluLWJ1aWxkaWQtY2FjaGUuYyBidWlsdGluLQ0KYnVpbGRpZC1jYWNoZS5vIGJ1aWx0aW4tYnVp
bGRpZC1saXN0LmMgYnVpbHRpbi1idWlsZGlkLWxpc3QubyBidWlsdGluLQ0KYzJjLmMgYnVpbHRp
bi1jMmMubyBidWlsdGluLWNoZWNrLmMgYnVpbHRpbi1jaGVjay5vIGJ1aWx0aW4tY29uZmlnLmMN
CmJ1aWx0aW4tY29uZmlnLm8gYnVpbHRpbi1kYWVtb24uYyBidWlsdGluLWRhZW1vbi5vIGJ1aWx0
aW4tZGF0YS5jDQpidWlsdGluLWRhdGEubyBidWlsdGluLWRpZmYuYyBidWlsdGluLWRpZmYubyBi
dWlsdGluLWV2bGlzdC5jIGJ1aWx0aW4tDQpldmxpc3QubyBidWlsdGluLWZ0cmFjZS5jIGJ1aWx0
aW4tZnRyYWNlLm8gYnVpbHRpbi5oIGJ1aWx0aW4taGVscC5jDQpidWlsdGluLWhlbHAubyBidWls
dGluLWluamVjdC5jIGJ1aWx0aW4taW5qZWN0Lm8gYnVpbHRpbi1rYWxsc3ltcy5jDQpidWlsdGlu
LWthbGxzeW1zLm8gYnVpbHRpbi1rbWVtLmMgYnVpbHRpbi1rbWVtLm8gYnVpbHRpbi1rdm0uYyBi
dWlsdGluLQ0Ka3ZtLm8gYnVpbHRpbi1rd29yay5jIGJ1aWx0aW4ta3dvcmsubyBidWlsdGluLWxp
c3QuYyBidWlsdGluLWxpc3Qubw0KYnVpbHRpbi1sb2NrLmMgYnVpbHRpbi1sb2NrLm8gYnVpbHRp
bi1tZW0uYyBidWlsdGluLW1lbS5vIGJ1aWx0aW4tDQpwcm9iZS5jIGJ1aWx0aW4tcHJvYmUubyBi
dWlsdGluLXJlY29yZC5jIGJ1aWx0aW4tcmVjb3JkLm8gYnVpbHRpbi0NCnJlcG9ydC5jIGJ1aWx0
aW4tcmVwb3J0Lm8gYnVpbHRpbi1zY2hlZC5jIGJ1aWx0aW4tc2NoZWQubyBidWlsdGluLQ0Kc2Ny
aXB0LmMgYnVpbHRpbi1zY3JpcHQubyBidWlsdGluLXN0YXQuYyBidWlsdGluLXN0YXQubyBidWls
dGluLQ0KdGltZWNoYXJ0LmMgYnVpbHRpbi10aW1lY2hhcnQubyBidWlsdGluLXRvcC5jIGJ1aWx0
aW4tdG9wLm8gYnVpbHRpbi0NCnRyYWNlLmMgYnVpbHRpbi10cmFjZS5vIGJ1aWx0aW4tdmVyc2lv
bi5jIGJ1aWx0aW4tdmVyc2lvbi5vIGNoZWNrLQ0KaGVhZGVyX2lnbm9yZV9odW5rcyBjaGVjay1o
ZWFkZXJzLnNoIGNoZWNrLWhlYWRlcnMuc2guc2hlbGxjaGVja19sb2cNCmNvbW1hbmQtbGlzdC50
eHQgY29tbW9uLWNtZHMuaCBDUkVESVRTIGRlc2lnbi50eHQgZGxmaWx0ZXJzDQpEb2N1bWVudGF0
aW9uIEZFQVRVUkUtRFVNUCBpbmNsdWRlIGp2bXRpIGxpYmFwaSBsaWJicGYgbGlicGVyZiBsaWJw
ZXJmLQ0KYmVuY2guYSBsaWJwZXJmLWp2bXRpLnNvIGxpYnBlcmYtdGVzdC5hIGxpYnBlcmYtdWku
YSBsaWJwZXJmLXV0aWwuYQ0KbGlicG11LWV2ZW50cy5hIGxpYnN1YmNtZCBsaWJzeW1ib2wgTWFr
ZWZpbGUgTWFrZWZpbGUuY29uZmlnDQpNYWtlZmlsZS5wZXJmIE1BTklGRVNUIHBlcmYgcGVyZi1h
cmNoaXZlIHBlcmYtYXJjaGl2ZS5zaCBwZXJmLQ0KYXJjaGl2ZS5zaC5zaGVsbGNoZWNrX2xvZyBw
ZXJmLWJlbmNoLWluLm8gcGVyZi5jIHBlcmYtY29tcGxldGlvbi5zaA0KcGVyZi1jb21wbGV0aW9u
LnNoLnNoZWxsY2hlY2tfbG9nIHBlcmYuaCBwZXJmLWluLm8gcGVyZi1pb3N0YXQgcGVyZi0NCmlv
c3RhdC5zaCBwZXJmLWlvc3RhdC5zaC5zaGVsbGNoZWNrX2xvZyBwZXJmLm8gcGVyZi1yZWFkLXZk
c28zMiBwZXJmLQ0KcmVhZC12ZHNvLmMgcGVyZi1zeXMuaCBwZXJmLXRlc3QtaW4ubyBwZXJmLXVp
LWluLm8gcGVyZi11dGlsLWluLm8gUEVSRi0NClZFUlNJT04tRklMRSBwbXUtZXZlbnRzIHB5dGhv
biBweXRob25fZXh0X2J1aWxkIHNjcmlwdHMgdGVzdHMgdHJhY2UgdWkNCnV0aWwgdG1hX2luZm9f
dGhyZWFkX3Nsb3RzKQ0KDQouLi4NCg0KLS0tLSBlbmQoLTIpIC0tLS0NCiA5NTogcGVyZiBhbGwg
bWV0cmljcyB0ZXN0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoN
ClNraXANCg0KVGhlICogaXMgZ2V0dGluZyByZXBsYWNlZCB3aXRoIHRoZSBmaWxlcyBpbiBteSB3
b3JraW5nIGRpcmVjdG9yeSwgd2hpY2gNCmlzIHRvb2xzL3BlcmYsIGJ1dCBvbmx5IHdoZW4gcnVu
bmluZyAncGVyZiB0ZXN0JywgcnVubmluZyAncGVyZiBzdGF0Jw0KanVzdCBwcmludHMgdGhlIGVy
cm9yIG5vcm1hbGx5Og0KDQouLi4vcGVyZi10b29scy1uZXh0L3Rvb2xzL3BlcmYjIC4vcGVyZiBz
dGF0IC1NIHRtYV9mcF9zY2FsYXIgc2xlZXAgMQ0KQ2Fubm90IHJlc29sdmUgSURzIGZvciB0bWFf
ZnBfc2NhbGFyOiBGUF9BUklUSF9JTlNUX1JFVElSRUQuU0NBTEFSIC8NCih0bWFfcmV0aXJpbmcg
KiB0bWFfaW5mb190aHJlYWRfc2xvdHMpDQoNClRvbQ0K
