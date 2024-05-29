Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B215B562
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006399; cv=fail; b=TFgOKEsibU/jJjoC+MSrqLTl8UiNBSh2bqUUAv+ajw//1T+LfbS6msPIievN++gYZTppSkd3YSgPQWHpZg2/Uu28TJP2IhtLh79arJR4lTVWRHVl1YLSy/6uFZLUVZV8hIAxtQKEEUlpeLUvPO+6ddEfkuDsXm1Kr6mhCHgJmD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006399; c=relaxed/simple;
	bh=aZjBJ01CLeg8AzKSzwmPlhAaLEvyKlfpLBC+/i20QWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVxwYqoeft20mgwih7vu4teXlgWg9cKDtePT1p2gprA7K94EUWkUPPgYpyKPOYoxolh2yv5xXeNFrgrm+pDxuHWmx7a/w8anIPcT8g77166LQ27031UjjKMhd8QEjFgzN44ebUBka3TJ7v0fWkxgBqLzS3Q03HjAupM+mz5KRqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/x3974j; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/x3974j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717006398; x=1748542398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aZjBJ01CLeg8AzKSzwmPlhAaLEvyKlfpLBC+/i20QWs=;
  b=P/x3974j8LVp47zf7Lk3TttpM8443JwadLtp0i057MeAZZFB1UGMJVRb
   r12tYdQiTM3IKiKvgKmBhw1S4Bq96f7itirkvrEne3mHACqauGLvNOhRL
   Y8kbl0/xGATfXOG5k4O9Wdzro+xSVZ0fla5Zp84p9gswhCEgqogR7pRhC
   /Xp9651/9YGg4dL3qLpYXYrW8JRvULw+rBT2xyI6j6AESsHuU+hrUlDKj
   JtvYtsH1estzRfh4BYY/UPQOOuW9fuE1sVGNGTuZsah1RQVxVQQcV1e+4
   07L48xQxmfPevL2QaR8KHGuTjviTBP6YCR+9SEkkFRgm/2urd3Sa1ZSAo
   Q==;
X-CSE-ConnectionGUID: U+UgbeWMSfKEPgUKXHGn3g==
X-CSE-MsgGUID: SZBjqywrRKSYVaKicQ5DGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13661496"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13661496"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 11:13:17 -0700
X-CSE-ConnectionGUID: wyhJt5TAQJucXEkyDbVhIQ==
X-CSE-MsgGUID: TSjKIKHuToGC4OPDBIZiYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40424241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 11:13:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:13:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:13:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 11:13:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 11:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kifCgZp8/TS2HPRJm31F6oviIRwllsRgcNl4i3LsrMNlMHjgfNc+GbGoIonBPRUxKgBfw5wJRXlUNO80QybDdx/JsYoeKdg+W+/Up3qVb+iDOoVaYLUfIuVO6D2MAzBTqFtEzF6Ku0xCYrSAwoCwZFQdPqeAb1nhYmiyzFpnxOkXoJDNcZm88KEzeo7Fl1ehsk1pKAMRDe820fUdOC/ChSkQpAnelGn2lkx4lTwPzMYp2ju9DMF15NCgK82mFBjpmXSj9UqAAQiD1KVn8DpHfCLfoqYbEwdNXFeB/6mQQ6r9EqZW5+/oXoHaUEdbsxLuRPO3dIR3B9RQJsDn3aglkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZjBJ01CLeg8AzKSzwmPlhAaLEvyKlfpLBC+/i20QWs=;
 b=nsip7bXzDvpncQ2TsLoN3k9Yq/kc/8nWkot0jeR7sinNJn7U0D/OP1MlicrAkCs47FALaxnz0Rpc8p1OwhOQosc/R8P9Wun7kO5dAIgA71FEUfExIgGUQg7wu97tQ+vy6SZ+Lv/E0dVWXEFzweoNJDVr8s1sVu0zMWwYVVRctpz3Vebo5MadjQUYihdsUYqIKDTiXLj1t9ByBTLENGJrglfo3GDi4U5X6gCqAjjVp1wPefglDBwb7/nGr6cR//NJTvwxMxxwxCcVh2iIUuCnsuack4YziO0Fu+h6t2hRT8ESpswWQVM3en0aCR+vCquvj+8njxotxtMWg8/IfKiY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) by
 MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.30; Wed, 29 May 2024 18:13:13 +0000
Received: from DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::7b2a:697f:e19a:9bbe]) by DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::7b2a:697f:e19a:9bbe%4]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 18:13:13 +0000
From: "Taylor, Perry" <perry.taylor@intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>, Michael Petlan
	<mpetlan@redhat.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
CC: "irogers@google.com" <irogers@google.com>, "vmolnaro@redhat.com"
	<vmolnaro@redhat.com>, "Baker, Edward" <edward.baker@intel.com>, "Alt,
 Samantha" <samantha.alt@intel.com>, "Wang, Weilin" <weilin.wang@intel.com>,
	"acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>
Subject: RE: Intel Sapphire Rapids uncore: umask too big
Thread-Topic: Intel Sapphire Rapids uncore: umask too big
Thread-Index: AQHaU1QQGOlAsCwkv0eDo59Wn4z5/rGuwOYAgAAqY4CAAFSjEA==
Date: Wed, 29 May 2024 18:13:06 +0000
Deferred-Delivery: Wed, 29 May 2024 18:12:33 +0000
Message-ID: <DM3PR11MB8714A4D1122F2ED878A13BBF90F22@DM3PR11MB8714.namprd11.prod.outlook.com>
References: <alpine.LRH.2.20.2401300733310.11354@Diego>
 <alpine.LRH.2.20.2405281153210.4040@Diego>
 <4cc8c681-2ad6-4f38-8050-ad44fa592890@linux.intel.com>
In-Reply-To: <4cc8c681-2ad6-4f38-8050-ad44fa592890@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8714:EE_|MW4PR11MB8289:EE_
x-ms-office365-filtering-correlation-id: 24937e7f-3716-4ed0-92e7-08dc800b0155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VmdjSlIveUcxeXRZQ1JnS25QaEJ1R0JzVEhidlFkNTgyZ3lwd0tvWGJZQUZG?=
 =?utf-8?B?SkNQRFN5bmtNb2NoOWRraXlabDMvZTg4UTU4dTIwd2U0M3dxMEFHdlhSejM3?=
 =?utf-8?B?SmUxTEtrTVdCUFhkRlVnTnhWcGhtTHg4di8xZGRqSGtrMzc4elFJZjhOdmJX?=
 =?utf-8?B?MUVSRUpFeTl5T1V4cloxQ2xiTVl2Zk50TUJtZEVuMnBpcCt4eUFXeTQ5cTBk?=
 =?utf-8?B?TWhVRkdjWlNpaSt6cVluN2dac1dvdVBSZTRNZ3lxcUU3ZlJsVE9RdkJ2aE5U?=
 =?utf-8?B?V0VTVXRDZC9XM2FKNXVEcndvek9PNDJsVWxzRGowMXdGMmxUa1NLcC9SSFZr?=
 =?utf-8?B?WmZEeFNHZzhSNWpsR1ZmellZQmZUMVVsT0pYV3BCakFXTENIUUl2R2pWaHcz?=
 =?utf-8?B?U1FpWFFLTDUxOHFEa2RiM3VGZGkvRnVYVVJNVS80SEdYV0prcEtuY1NDREIw?=
 =?utf-8?B?bVJoa2tJZmJFdHdOam5mVmc2NDluZSt1dmdVeGtUQURBdU5jV1phYSsyOVE1?=
 =?utf-8?B?OEpLQ29DdmpsMHArUWFLK2JrZk5JdXFlK0o2Wm1xR2lzR1d1Z01HNlRtZktt?=
 =?utf-8?B?QkdyYVlvb2kxWEd2RXRRbE9HQWp3L1VsVmxnTys2Tit0TDlZY0RmN25Ec0VQ?=
 =?utf-8?B?NWZGejBYMENDQ3ltYjV3MmVENS9QbWIxcWxaRVJvSzhkME5PU3g4Y1RpOEZ3?=
 =?utf-8?B?SDl2Ly9kaEt0MHBjbXBMbDNZNk9zdFNrS1czU2hpbml4UnV0RFJEZU9UQU92?=
 =?utf-8?B?bXJrYzFGY0lOckJEV1F0Q1dyaVBPV0tZc3d1WHpTWUc2N04yYXR6a0R0MmMy?=
 =?utf-8?B?Q2pOK1lkQ2ZaMmc0S1pUZTBsU0FVSzZ3UUlNMkhMTHoxUy9MbmZHSmRYWjVS?=
 =?utf-8?B?TWN0MTN4aC9SL0xKZ0xFZ29MNmJZeVlyNCtRQTFKQ1kydFRFb3NIV3ZwaSsx?=
 =?utf-8?B?WFlkbFlmLzVDZ0lFRjJZdjBYV1ZidEt3d3Y0d0V5WXYrMWorQUViYVduS3NZ?=
 =?utf-8?B?cG1BeERBQlJXS2V1NHJ3SnRGcW5hRWxhZzYzRWlKKzBnYkJ3VzY3SEo4VUVm?=
 =?utf-8?B?TnpxRWsrY2J3b3p0Wmhnc095dDBvVW01QzdVa3lteXlLWDhQRlBmNll5ZlNI?=
 =?utf-8?B?c3RsTmRtZ3dPb3Q3UmI0anV2VkVKY2ZUNEtSY2RqbjlkeEFQdVBGNHY2SGFw?=
 =?utf-8?B?UEQ4bjJuYVIrTHdkbkpOcGxjU0tZcTZyQldPRlVwUkhISEtoSHZOSURTWThF?=
 =?utf-8?B?aDFvRFpGYzNMZFdhUkhRR25PSDU4MFNoTExCazBrZGZsZ2w5Vm1WSVR2d00w?=
 =?utf-8?B?T0U1cmdmWkRmNHJKZmFPVHRWL0Y3T0N6YWp0ZTVvZ3hlcnJIbEZyMlhEMjBl?=
 =?utf-8?B?cjdTUlZJb21NSFl2K0licGlKUkdFSjdGZ2l5OU9hZkd1K3BvOEUwTmc0MlMw?=
 =?utf-8?B?ZnVQai9qZDBYcnQ4Y3JyUEx1cm9pQWt6ZEM2M0FZQU1IL2dDa2xzQ25aTWds?=
 =?utf-8?B?ckY2VGZHVG1vYzhCTlU0SVZuaDhxTHFyVXhqQmJBNDY2ZHNGUit1djY4K0hQ?=
 =?utf-8?B?K0JBMHFZY3NxRFhxK2JIZU1LQ2RwUE9lMGhJbUxZUzJuV0hIQTJLUG9CbG42?=
 =?utf-8?B?bk5XeHoxSHNPTmh4VCtPdDh5YjFBNUNMQWQ0NU15bkhtbHNWeU02M2kxUlNi?=
 =?utf-8?B?OXNCSU1hUHFrR29YeW9YbnRYbmZXeldmcVExenora0xxaUtmMHBJTmJTZUwr?=
 =?utf-8?Q?momiYtvJqoJunbULGQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2dBeFoyT2lTbUFKWXk5S25jb3BoVEQ5MGpaYmVhUzhBb0xsUE4xdG5ZUy85?=
 =?utf-8?B?LzJ0bUw1VHpKeEt0K016Y1VMRDUxQmgzNWduVzFqOXVmK01oSXNlK2NsQmRh?=
 =?utf-8?B?YS9xWWtZSDhIS2I3cU9WNHN1Y1BoRmFsM1draHIxcGN4TG5aSC9TN21oR0VC?=
 =?utf-8?B?K3VsYlY3UkVFSXBuQWFEMVJkRkdaY3RmMXE0TjRVc2Q2R1J1U1pXd1J1YUZn?=
 =?utf-8?B?TG95Q3kwQjRybzJybm1zNzF0YjlaVldnczRGNEZpMnczMmRwdGNlK29Qb2Nx?=
 =?utf-8?B?YkpMYWd4UGNiYzd4aU5OUWlUR3ByM3ZIdkdDeExKeVF1TlVKRnFYZVBicWdw?=
 =?utf-8?B?VnorWUJBaVZIOXpneFZHUEZHcUlocERVc0R6ZUVNMUdVdXdDUHNSeER4NGtr?=
 =?utf-8?B?U3JmU3pmVVJ5b0Z4WE9uVStoaytub21XTCtHYVFuVFo1VjRyaWc4Q1k3QzVy?=
 =?utf-8?B?SzNXUk5RTXZoZStBaEFBTkZkdTVyVHdSU1o2M2lneHhaWE1GeEVXSDdIdjlV?=
 =?utf-8?B?Vzh6NVcxaDRzYWt3WDFkTlozZTMvWnlPcDFSVVgya3VMSjNwR3hoQ281Yjhr?=
 =?utf-8?B?SmZDdkdPZHVQci9Qall4dTZwVWhWNmEyUXIrcHRCbGY1UG5ucVZzTk1QZGYr?=
 =?utf-8?B?S214bk5DZm9ZUFg2SDk4T3h5ZC8yNWJCcEQrVDUxTkZDSnM5akFSMnlDZElQ?=
 =?utf-8?B?VjZZSmh0cHRHS2dMQ3N4YkdVWWNIYUdWRkk3MTRvQ3Y2SEc3NzRQcWp2cVhD?=
 =?utf-8?B?Q3l4RUwzSGdzSGJhUkZLT2E0NEJrcHNiN0JnOHIyV1dKakRLRHE5M2J0bmQ1?=
 =?utf-8?B?emhDb2lHWDNnbW4vTDJPQzRmRWJlTGk5cFFZZFNXa3RVQ0p6OGpuUVBuVkdk?=
 =?utf-8?B?N3lMTkNsU3V3VFMxSnF6Znkvd1VRZ3R5bHJZeU5jVGhKYlpYUkVCU2xqUW1j?=
 =?utf-8?B?ZVZuSnhQNzBGVlRnaVRaU2ZUdmYxMXZSWStEOWlydENLNXhlK2xvczdsWXh0?=
 =?utf-8?B?V0syZlZUSXUxekM4WEF2aDFjWnpYclEwU2FUS2VCTDIxcnNWYVdLNW5uaTZB?=
 =?utf-8?B?S2xveDZQbndmdmxaWHR4aXZITkNNRnV4N1Bhc0pzU1JaMlBGVWl6Z0dQNGhv?=
 =?utf-8?B?dWphQ0NMa3NVeERuZFBmaEZsYUtWbWRnSXVxV3VrYUU3QUJRQnE1eXBsM1NO?=
 =?utf-8?B?S1p2SHBJZDVkM3FNRWVld2MzZ2UxWWhUWFFnNUdvTnRJckRhRTh4d0ozc1dO?=
 =?utf-8?B?c2dPMWtQNldrbnVQVFdoSGUrVEhsZGltUmVHbithM205emV4YzM0VnNyUnE5?=
 =?utf-8?B?Y1k0NWxveUk0M0pmaGRKakNHQWJ1bnB0YWZGT2pyelo5NGcyU2xBa1hyM2lF?=
 =?utf-8?B?OFNwd0tnbHl1WFNhUjhPRnR0c0F5RUtMbDkvWENoWktnQTBLQUZ2SkdraFVx?=
 =?utf-8?B?dXIwNTB0cERrN3hlSzFFZWhEeFdXU0g2TjVQOWJscHNydDFyRDhXdXNOSjdp?=
 =?utf-8?B?WFRwWnArZW1VckVBY0c2TXd3TlJxT09xWW9aTzVFQlRtK1JlQ0dZZTBGSTB5?=
 =?utf-8?B?WEhCNnRyNWRXN2RNaE1kVWlqek1YMndaS3JycFc4cktRUTZvaUwwYXNFSldW?=
 =?utf-8?B?UE5ib05ud2tQZnZGa2ZsL0NvRDNMTDFPeXJyNXFZVlZQSmV1dTcwWkZOcWtJ?=
 =?utf-8?B?cnNrZkN6ZWc3cXg4d1RtVVZSc0t5Yk8wRVR4QVJhb2JNWDhqMGpvaElDdDI4?=
 =?utf-8?B?V0J6SVQzR2J3ZGYyT0oxb3B6SlZRN2I4UXE4Sm1kVGtKTXZNWWkyVkl3WGwv?=
 =?utf-8?B?Vm84Q0txaWRlZ2dKMWY2WitFSnREREtweXRqMTRYYWJRNVFHZGtjamhTc2d4?=
 =?utf-8?B?d3MzUXc1UTI2bFkrZTc2YVRzNC9EOWNMYTJvdm1VRE1EaFBrdGFtWUdKc21s?=
 =?utf-8?B?TjJXT3JFTVlzd2svWUJrSWJUSzEvNWNLUlRmOUpnVWhmRisrbDFZakhNdzNK?=
 =?utf-8?B?N0oyUWE4YTYyNU9ZY293U0JHU05tWHBHZUpVczNWV1krejRPa2ZkYzc1SGc4?=
 =?utf-8?B?L09zVnNWOVpIV1JCNk0vVzUvS01EdnZlTi91NjJvREwvb1hlRktNSFNxM3NV?=
 =?utf-8?Q?VOHSkM78LHzZBwR8QqUJpg4UJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8714.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24937e7f-3716-4ed0-92e7-08dc800b0155
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 18:13:13.5003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdL0rz8lFr717tSlu/eWG4I+d43rwX/dem0F2UXCu9Btx1T9kwhBQrNT5xaaCMC6VNQTDEXVmGqdclvZv1V6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8289
X-OriginatorOrg: intel.com

UGxlYXNlIG5vdGUgdGhlIFNQUiBkb2N1bWVudGF0aW9uIHVwZGF0ZSBhdDogaHR0cHM6Ly9jZHJk
djIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNjM5NjY3DQoNClRoZSBTUFIgQ0hBIGNvdW50
ZXIgY29udHJvbCByZWdpc3RlciBleHRlbmRlZCB1bWFzayBiaXRzIGFyZSBkZWZpbmVkIGFzIFs2
MzozMl0uIA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaWFuZywgS2Fu
IDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgTWF5IDI5LCAy
MDI0IDY6MDYgQU0NClRvOiBNaWNoYWVsIFBldGxhbiA8bXBldGxhbkByZWRoYXQuY29tPjsgbGlu
dXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmcNCkNjOiBpcm9nZXJzQGdvb2dsZS5jb207IHZt
b2xuYXJvQHJlZGhhdC5jb207IEJha2VyLCBFZHdhcmQgPGVkd2FyZC5iYWtlckBpbnRlbC5jb20+
OyBUYXlsb3IsIFBlcnJ5IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8
c2FtYW50aGEuYWx0QGludGVsLmNvbT47IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwu
Y29tPjsgYWNtZUBrZXJuZWwub3JnOyBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29t
DQpTdWJqZWN0OiBSZTogSW50ZWwgU2FwcGhpcmUgUmFwaWRzIHVuY29yZTogdW1hc2sgdG9vIGJp
Zw0KDQoNCg0KT24gMjAyNC0wNS0yOSA2OjM0IGEubS4sIE1pY2hhZWwgUGV0bGFuIHdyb3RlOg0K
PiBIZWxsby4NCj4gDQo+IEFsdGhvdWdoIHNvbWV0aGluZyBoYXMgY2hhbmdlZCBzbyBmYXIsIHRo
ZSBkaXNjcmVwYWN5IGJldHdlZW4gZXZlbnQgDQo+IGZvcm1hdCBhY2NlcHRlZCBieSB0aGUga2Vy
bmVsICggL3N5cy9kZXZpY2VzL2ludGVsX2NoYSovZm9ybWF0LyogKSBhbmQgDQo+IHdoYXQgaXMg
aW4gdGhlIEpTT05zIHN0aWxsIGFwcGxpZXMgZm9yIFNhcHBoaXJlIExha2UuDQo+IA0KPiBUaGlz
IGlzIGZvdW5kIGJ5IHJ1bm5pbmcgdGhlICJhbGwgUE1VIiB0ZXN0IG9yIGEgInBlcmZfc3RhdCA6
OiB0ZXN0X2ludGVsX3VuY29yZSINCj4gZnJvbSBwZXJmdG9vbC10ZXN0c3VpdGUgb24gYSBTUFIg
Ym94LiBUaGUgZmlyc3Qgc2VlbSB0byBzdG9wIG9uIGZpcnN0IA0KPiBicm9rZW4gZXZlbnQsIHRo
ZSBzZWNvbmQgcHJvdmlkZXMgYSBmdWxsIGxpc3Qgb2YgZmFpbGVkIGV2ZW50cy4NCg0KVGhlIGtl
cm5lbCBwYXRjaCBzZWVtcyBoYXMgbm90IGJlZW4gbWVyZ2VkIHlldC4NCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyNDA0MTYxODAxNDUuMjMwOTkxMy0xLWthbi5saWFuZ0BsaW51eC5p
bnRlbC5jb20vDQoNCkknbGwgcGluZyBpdCBhZ2Fpbi4NCg0KVGhhbmtzLA0KS2FuDQoNCj4gDQo+
IE91ciB0ZXN0aW5nIHNob3dzIHRoYXQgfjExMiBldmVudHMgYXJlIHN0aWxsIGJyb2tlbjoNCj4g
DQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfaGl0X2N4bF9hY2MNCj4gdW5jX2NoYV90b3JfaW5z
ZXJ0cy5pYV9oaXRfY3hsX2FjY19sb2NhbA0KPiB1bmNfY2hhX3Rvcl9pbnNlcnRzLmlhX21pc3Nf
Y3JkbW9ycGhfY3hsX2FjYw0KPiB1bmNfY2hhX3Rvcl9pbnNlcnRzLmlhX21pc3NfY3hsX2FjYw0K
PiB1bmNfY2hhX3Rvcl9pbnNlcnRzLmlhX21pc3NfY3hsX2FjY19sb2NhbA0KPiB1bmNfY2hhX3Rv
cl9pbnNlcnRzLmlhX21pc3NfZHJkX2N4bF9hY2MNCj4gdW5jX2NoYV90b3JfaW5zZXJ0cy5pYV9t
aXNzX2RyZF9jeGxfYWNjX2xvY2FsDQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19kcmRt
b3JwaF9jeGxfYWNjDQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19kcmRfb3B0X2N4bF9h
Y2NfbG9jYWwNCj4gdW5jX2NoYV90b3JfaW5zZXJ0cy5pYV9taXNzX2RyZF9vcHRfcHJlZl9jeGxf
YWNjX2xvY2FsDQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19kcmRfcHJlZl9jeGxfYWNj
DQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19kcmRfcHJlZl9jeGxfYWNjX2xvY2FsDQo+
IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19sbGNwcmVmY29kZV9jeGxfYWNjDQo+IHVuY19j
aGFfdG9yX2luc2VydHMuaWFfbWlzc19sbGNwcmVmZGF0YV9jeGxfYWNjDQo+IHVuY19jaGFfdG9y
X2luc2VydHMuaWFfbWlzc19sbGNwcmVmZGF0YV9jeGxfYWNjX2xvY2FsDQo+IHVuY19jaGFfdG9y
X2luc2VydHMuaWFfbWlzc19sbGNwcmVmcmZvX2N4bF9hY2MNCj4gdW5jX2NoYV90b3JfaW5zZXJ0
cy5pYV9taXNzX2xsY3ByZWZyZm9fY3hsX2FjY19sb2NhbA0KPiB1bmNfY2hhX3Rvcl9pbnNlcnRz
LmlhX21pc3NfcmZvX2N4bF9hY2MNCj4gdW5jX2NoYV90b3JfaW5zZXJ0cy5pYV9taXNzX3Jmb19j
eGxfYWNjX2xvY2FsDQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19yZm9tb3JwaF9jeGxf
YWNjDQo+IHVuY19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19yZm9fcHJlZl9jeGxfYWNjDQo+IHVu
Y19jaGFfdG9yX2luc2VydHMuaWFfbWlzc19yZm9fcHJlZl9jeGxfYWNjX2xvY2FsDQo+IHVuY19j
aGFfdG9yX29jY3VwYW5jeS5pYV9oaXRfY3hsX2FjYw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFuY3ku
aWFfaGl0X2N4bF9hY2NfbG9jYWwNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX21pc3NfY3Jk
bW9ycGhfY3hsX2FjYw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFuY3kuaWFfbWlzc19jeGxfYWNjDQo+
IHVuY19jaGFfdG9yX29jY3VwYW5jeS5pYV9taXNzX2N4bF9hY2NfbG9jYWwNCj4gdW5jX2NoYV90
b3Jfb2NjdXBhbmN5LmlhX21pc3NfZHJkX2N4bF9hY2MNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5
LmlhX21pc3NfZHJkX2N4bF9hY2NfbG9jYWwNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX21p
c3NfZHJkbW9ycGhfY3hsX2FjYw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFuY3kuaWFfbWlzc19kcmRf
b3B0X2N4bF9hY2NfbG9jYWwNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX21pc3NfZHJkX29w
dF9wcmVmX2N4bF9hY2NfbG9jYWwNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX21pc3NfZHJk
X3ByZWZfY3hsX2FjYw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFuY3kuaWFfbWlzc19kcmRfcHJlZl9j
eGxfYWNjX2xvY2FsDQo+IHVuY19jaGFfdG9yX29jY3VwYW5jeS5pYV9taXNzX2xsY3ByZWZjb2Rl
X2N4bF9hY2MNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX21pc3NfbGxjcHJlZmRhdGFfY3hs
X2FjYw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFuY3kuaWFfbWlzc19sbGNwcmVmZGF0YV9jeGxfYWNj
X2xvY2FsDQo+IHVuY19jaGFfdG9yX29jY3VwYW5jeS5pYV9taXNzX2xsY3ByZWZyZm9fY3hsX2Fj
Yw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFuY3kuaWFfbWlzc19sbGNwcmVmcmZvX2N4bF9hY2NfbG9j
YWwNCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX21pc3NfcmZvX2N4bF9hY2MNCj4gdW5jX2No
YV90b3Jfb2NjdXBhbmN5LmlhX21pc3NfcmZvX2N4bF9hY2NfbG9jYWwNCj4gdW5jX2NoYV90b3Jf
b2NjdXBhbmN5LmlhX21pc3NfcmZvbW9ycGhfY3hsX2FjYw0KPiB1bmNfY2hhX3Rvcl9vY2N1cGFu
Y3kuaWFfbWlzc19yZm9fcHJlZl9jeGxfYWNjDQo+IHVuY19jaGFfdG9yX29jY3VwYW5jeS5pYV9t
aXNzX3Jmb19wcmVmX2N4bF9hY2NfbG9jYWwNCj4gdW5jX2lpb19jb21wX2J1Zl9pbnNlcnRzLmNt
cGQucGFydDANCj4gdW5jX2lpb19jb21wX2J1Zl9pbnNlcnRzLmNtcGQucGFydDENCj4gdW5jX2lp
b19jb21wX2J1Zl9pbnNlcnRzLmNtcGQucGFydDINCj4gdW5jX2lpb19jb21wX2J1Zl9pbnNlcnRz
LmNtcGQucGFydDMNCj4gdW5jX2lpb19jb21wX2J1Zl9pbnNlcnRzLmNtcGQucGFydDQNCj4gdW5j
X2lpb19jb21wX2J1Zl9pbnNlcnRzLmNtcGQucGFydDUNCj4gdW5jX2lpb19jb21wX2J1Zl9pbnNl
cnRzLmNtcGQucGFydDYNCj4gdW5jX2lpb19jb21wX2J1Zl9pbnNlcnRzLmNtcGQucGFydDcNCj4g
dW5jX2lpb19jb21wX2J1Zl9vY2N1cGFuY3kuY21wZC5wYXJ0MA0KPiB1bmNfaWlvX2NvbXBfYnVm
X29jY3VwYW5jeS5jbXBkLnBhcnQxDQo+IHVuY19paW9fY29tcF9idWZfb2NjdXBhbmN5LmNtcGQu
cGFydDINCj4gdW5jX2lpb19jb21wX2J1Zl9vY2N1cGFuY3kuY21wZC5wYXJ0Mw0KPiB1bmNfaWlv
X2NvbXBfYnVmX29jY3VwYW5jeS5jbXBkLnBhcnQ0DQo+IHVuY19paW9fY29tcF9idWZfb2NjdXBh
bmN5LmNtcGQucGFydDUNCj4gdW5jX2lpb19jb21wX2J1Zl9vY2N1cGFuY3kuY21wZC5wYXJ0Ng0K
PiB1bmNfaWlvX2NvbXBfYnVmX29jY3VwYW5jeS5jbXBkLnBhcnQ3DQo+IHVuY19paW9fZGF0YV9y
ZXFfYnlfY3B1Lm1lbV9yZWFkLnBhcnQwDQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1Lm1lbV9y
ZWFkLnBhcnQxDQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1Lm1lbV9yZWFkLnBhcnQyDQo+IHVu
Y19paW9fZGF0YV9yZXFfYnlfY3B1Lm1lbV9yZWFkLnBhcnQzDQo+IHVuY19paW9fZGF0YV9yZXFf
YnlfY3B1Lm1lbV9yZWFkLnBhcnQ0DQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1Lm1lbV9yZWFk
LnBhcnQ1DQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1Lm1lbV9yZWFkLnBhcnQ2DQo+IHVuY19p
aW9fZGF0YV9yZXFfYnlfY3B1Lm1lbV9yZWFkLnBhcnQ3DQo+IHVuY19paW9fZGF0YV9yZXFfYnlf
Y3B1LnBlZXJfcmVhZC5wYXJ0MA0KPiB1bmNfaWlvX2RhdGFfcmVxX2J5X2NwdS5wZWVyX3JlYWQu
cGFydDENCj4gdW5jX2lpb19kYXRhX3JlcV9ieV9jcHUucGVlcl9yZWFkLnBhcnQyDQo+IHVuY19p
aW9fZGF0YV9yZXFfYnlfY3B1LnBlZXJfcmVhZC5wYXJ0Mw0KPiB1bmNfaWlvX2RhdGFfcmVxX2J5
X2NwdS5wZWVyX3JlYWQucGFydDQNCj4gdW5jX2lpb19kYXRhX3JlcV9ieV9jcHUucGVlcl9yZWFk
LnBhcnQ1DQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1LnBlZXJfcmVhZC5wYXJ0Ng0KPiB1bmNf
aWlvX2RhdGFfcmVxX2J5X2NwdS5wZWVyX3JlYWQucGFydDcNCj4gdW5jX2lpb19kYXRhX3JlcV9i
eV9jcHUucGVlcl93cml0ZS5wYXJ0MA0KPiB1bmNfaWlvX2RhdGFfcmVxX2J5X2NwdS5wZWVyX3dy
aXRlLnBhcnQxDQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1LnBlZXJfd3JpdGUucGFydDINCj4g
dW5jX2lpb19kYXRhX3JlcV9ieV9jcHUucGVlcl93cml0ZS5wYXJ0Mw0KPiB1bmNfaWlvX2RhdGFf
cmVxX2J5X2NwdS5wZWVyX3dyaXRlLnBhcnQ0DQo+IHVuY19paW9fZGF0YV9yZXFfYnlfY3B1LnBl
ZXJfd3JpdGUucGFydDUNCj4gdW5jX2lpb19kYXRhX3JlcV9ieV9jcHUucGVlcl93cml0ZS5wYXJ0
Ng0KPiB1bmNfaWlvX2RhdGFfcmVxX2J5X2NwdS5wZWVyX3dyaXRlLnBhcnQ3DQo+IHVuY19paW9f
aW5ib3VuZF9hcmJfcmVxLmRhdGENCj4gdW5jX2lpb19pbmJvdW5kX2FyYl9yZXEucmVxX293bg0K
PiB1bmNfaWlvX2luYm91bmRfYXJiX3JlcS53cg0KPiB1bmNfaWlvX2luYm91bmRfYXJiX3dvbi5k
YXRhDQo+IHVuY19paW9faW5ib3VuZF9hcmJfd29uLmZpbmFsX3JkX3dyDQo+IHVuY19paW9faW5i
b3VuZF9hcmJfd29uLmlvbW11X2hpdA0KPiB1bmNfaWlvX2luYm91bmRfYXJiX3dvbi5pb21tdV9y
ZXENCj4gdW5jX2lpb19pbmJvdW5kX2FyYl93b24ucmVxX293bg0KPiB1bmNfaWlvX2luYm91bmRf
YXJiX3dvbi53cg0KPiB1bmNfaWlvX3JlcV9mcm9tX3BjaWVfY2xfY21wbC5kYXRhDQo+IHVuY19p
aW9fcmVxX2Zyb21fcGNpZV9jbF9jbXBsLmZpbmFsX3JkX3dyDQo+IHVuY19paW9fcmVxX2Zyb21f
cGNpZV9jbF9jbXBsLnJlcV9vd24NCj4gdW5jX2lpb19yZXFfZnJvbV9wY2llX2NsX2NtcGwud3IN
Cj4gdW5jX2lpb19yZXFfZnJvbV9wY2llX2NtcGwuZmluYWxfcmRfd3INCj4gdW5jX2lpb19yZXFf
ZnJvbV9wY2llX2NtcGwuaW9tbXVfaGl0DQo+IHVuY19paW9fcmVxX2Zyb21fcGNpZV9jbXBsLmlv
bW11X3JlcQ0KPiB1bmNfaWlvX3JlcV9mcm9tX3BjaWVfY21wbC5yZXFfb3duDQo+IHVuY19paW9f
cmVxX2Zyb21fcGNpZV9wYXNzX2NtcGwuZGF0YQ0KPiB1bmNfaWlvX3JlcV9mcm9tX3BjaWVfcGFz
c19jbXBsLnJlcV9vd24NCj4gdW5jX2lpb19yZXFfZnJvbV9wY2llX3Bhc3NfY21wbC53cg0KPiB1
bmNfaWlvX3R4bl9yZXFfYnlfY3B1LnBlZXJfd3JpdGUucGFydDANCj4gdW5jX2lpb190eG5fcmVx
X2J5X2NwdS5wZWVyX3dyaXRlLnBhcnQxDQo+IHVuY19paW9fdHhuX3JlcV9ieV9jcHUucGVlcl93
cml0ZS5wYXJ0Mg0KPiB1bmNfaWlvX3R4bl9yZXFfYnlfY3B1LnBlZXJfd3JpdGUucGFydDMNCj4g
dW5jX2lpb190eG5fcmVxX2J5X2NwdS5wZWVyX3dyaXRlLnBhcnQ0DQo+IHVuY19paW9fdHhuX3Jl
cV9ieV9jcHUucGVlcl93cml0ZS5wYXJ0NQ0KPiB1bmNfaWlvX3R4bl9yZXFfYnlfY3B1LnBlZXJf
d3JpdGUucGFydDYNCj4gdW5jX2lpb190eG5fcmVxX2J5X2NwdS5wZWVyX3dyaXRlLnBhcnQ3DQo+
IA0KPiBUaGFua3MuDQo+IA0KPiBNaWNoYWVsDQo+IA0KPiBPbiBUdWUsIDMwIEphbiAyMDI0LCBN
aWNoYWVsIFBldGxhbiB3cm90ZToNCj4+IEhlbGxvIElhbiBhbmQgb3RoZXJzLA0KPj4NCj4+IHdl
IGhhdmUgZW5jb3VudGVyZWQgc29tZSBpc3N1ZXMgd2l0aCB1bmNvcmUgZXZlbnRzIG9uIFNhcHBo
aXJlIA0KPj4gUmFwaWRzLiBUaGVyZSBhcmUgYSBjb3VwbGUgdHlwZXMgb2YgcHJvYmxlbXMuIE9u
ZSBvZiB0aGVtIGlzIHRoZSBmb2xsb3dpbmc6DQo+Pg0KPj4gICAgICMgcGVyZiBzdGF0IC1lIHVu
Y29yZV9jaGFfNTUvZXZlbnQ9MHgzNSx1bWFzaz0weDEwYzAwMDgxMDEvIC1hIC0tIGxzIA0KPj4g
ICAgIGV2ZW50IHN5bnRheCBlcnJvcjogJy4uMHgzNSx1bWFzaz0weDEwYzAwMDgxMDEvJw0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcX19fIEJhZCBldmVudCBvciBQ
TVUNCj4+ICAgICANCj4+ICAgICBVbmFibGUgdG8gZmluZCBQTVUgb3IgZXZlbnQgb24gYSBQTVUg
b2YgJ3VuY29yZV9jaGFfNTUnDQo+PiAgICAgDQo+PiAgICAgSW5pdGlhbCBlcnJvcjoNCj4+ICAg
ICBldmVudCBzeW50YXggZXJyb3I6ICcuLjB4MzUsdW1hc2s9MHgxMGMwMDA4MTAxLycNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXF9fXyB2YWx1ZSB0b28gYmlnIGZv
ciBmb3JtYXQsIG1heGltdW0gaXMgNDI5NDk2NzI5NQ0KPj4gICAgIFJ1biAncGVyZiBsaXN0JyBm
b3IgYSBsaXN0IG9mIHZhbGlkIGV2ZW50cw0KPj4NCj4+IFRoZXJlIGlzIGEgMzRiaXQgdW1hc2sg
dGhhdCBjYW4gaGFuZGxlIGl0LCBuYW1lbHkgdW1hc2tfZXh0MiwgYnV0IGl0IA0KPj4gaXMgbm90
IHVzZWQgZm9yIHNhcHBoaXJlIHJhcGlkczoNCj4+DQo+PiB1bmNvcmVfc25iZXAuYzo1OTU4OnN0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpzcHJfdW5jb3JlX2NoYV9mb3JtYXRzX2F0dHJbXSA9IHsN
Cj4+IHVuY29yZV9zbmJlcC5jLTU5NTktICAgICZmb3JtYXRfYXR0cl9ldmVudC5hdHRyLA0KPj4g
dW5jb3JlX3NuYmVwLmMtNTk2MC0gICAgJmZvcm1hdF9hdHRyX3VtYXNrX2V4dDQuYXR0ciwNCj4+
IHVuY29yZV9zbmJlcC5jLTU5NjEtICAgICZmb3JtYXRfYXR0cl90aWRfZW4yLmF0dHIsDQo+PiB1
bmNvcmVfc25iZXAuYy01OTYyLSAgICAmZm9ybWF0X2F0dHJfZWRnZS5hdHRyLA0KPj4gdW5jb3Jl
X3NuYmVwLmMtNTk2My0gICAgJmZvcm1hdF9hdHRyX2ludi5hdHRyLA0KPj4gdW5jb3JlX3NuYmVw
LmMtNTk2NC0gICAgJmZvcm1hdF9hdHRyX3RocmVzaDguYXR0ciwNCj4+IHVuY29yZV9zbmJlcC5j
LTU5NjUtICAgICZmb3JtYXRfYXR0cl9maWx0ZXJfdGlkNS5hdHRyLA0KPj4gdW5jb3JlX3NuYmVw
LmMtNTk2Ni0gICAgTlVMTCwNCj4+IHVuY29yZV9zbmJlcC5jLTU5NjctfTsNCj4+DQo+PiAoSSBz
ZWUgdW1hc2tfZXh0NCB0aGVyZSBhbmQgbWVhbnMgMzJiaXQ6DQo+PiB1bmNvcmVfc25iZXAuYzo0
Nzk6REVGSU5FX1VOQ09SRV9GT1JNQVRfQVRUUih1bWFza19leHQ0LCB1bWFzaywgDQo+PiAiY29u
ZmlnOjgtMTUsMzItNTUiKTsNCj4+ICkNCj4+DQo+PiBXaGF0IGlzIHdyb25nPyBUaGUganNvbiBm
aWxlcyBzcGVjaWZ5aW5nIHVtYXNrPTB4MTBjMDAwODEwMSBmb3IgdGhlIA0KPj4gZXZlbnQsIG9y
IHRoZSBzdHJ1Y3R1cmUgdGhhdCBzaG91bGQgcmF0aGVyIHN1cHBvcnQgdW1hc2tfZXh0MiA/DQo+
Pg0KPj4gVGhlcmUgYXJlIGEgZmV3IG1vcmUgaXNzdWVzLCBJIHdpbGwgdXBkYXRlIHdoZW4gYW5h
bHl6aW5nIHRoZW0gZGVlcGVyLg0KPj4NCj4+IFRoYW5rcy4NCj4+IE1pY2hhZWwNCj4+DQo+Pg0K
Pj4NCj4gDQo=
