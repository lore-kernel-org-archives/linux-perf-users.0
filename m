Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C125771;
	Tue, 29 Sep 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708578; cv=fail; b=L2LpgFk0tlE6S+6VywjiVbxPPvMLdHGR72q4KKyaF30vuH9EJtHRh7WCgywx/J3w9Ao5z4WFX/YoYqkYPfVQWZcNhIv9sGXYJbDtbhXvwRhJbXIPhEF0N1EnTLFgsBKHj6IbBcVRF+cZ10/IXBtG/gp6ARrssI5ue0DH6/Z9oIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708578; c=relaxed/simple;
	bh=fjQIQJjJMDSDK8sG7uFBIB29i9Gy2QvQPG0+pCQdjLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D9KItRZsVH8qUN71bz0+U/RgTTwF8H2XiHoH8PIsItq5bFf31tX/4+SymbgXGmpq9/mrpEIRdrVRT5NENTk93NWf4penrSH24w08C6HecuJds83H86EKZ9OK3F4TMPnJXRJVGJI9AXeHwkYz/HyXpirpVeYHJFKm6bVIjT5aUWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBgLU5xi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBgLU5xi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790708576; x=1822244576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fjQIQJjJMDSDK8sG7uFBIB29i9Gy2QvQPG0+pCQdjLA=;
  b=kBgLU5xiKv6sS3hUkd3wu4cTcYeBKDQzhnQcoX5OOaW4u6VUgSixermr
   IniNLV7ffGuiAhKS+i5+6r/uFGQEdBtMEon73NL6uAdtQwWu0AxrkP9tV
   5lAEJJsvkJyW8BdD+1sG6VWTal1cORqfJpg7rN17EmYsR3KgQ+lBdeok7
   5B0BIFzZyhnfF6CbkSFqZgx1TjTaLKgC9W3LAlAVWYm+He28jD5oPGSmw
   e/5mv5rZn3lyFUqeEN7X2gGkjZe4bkS1VkZ2IiZRIL+cUDIRiO+ZJJBYU
   C09721tly1W0ZaYNADrtjvWxJyV04oQMSb0Hv4Cw7+hlKQbXX0zdwIRM3
   A==;
X-CSE-ConnectionGUID: nFvwLzktTxGbLZYW3Iwd+Q==
X-CSE-MsgGUID: s6H7WTMhRVqeJuddxrrecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90336424"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90336424"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:02:55 -0700
X-CSE-ConnectionGUID: y+oQ2ldsTri5zbvZ8hia4g==
X-CSE-MsgGUID: YatlkWhVSR+uKUS4Qf+kKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="273565647"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:02:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 12:02:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 12:02:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 12:02:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvzJ74aU3+WvIU+L81CV8d7T5GXxJCCTNUFeeiHN6piBwXdtvXI9zesPkJl0rAbLnNW9u++rGsllepDUMwTkTJQCPmPIexdNrEwgl0mgHqVp20aVYxLyZ7eRiLufWcWb8qskCpAYxf8n+30SvcGXgKI15dZgAFNhxDCyjItmT6frKB5AixDz/+zWZ2zdrF5A0ENQ4EF/+wZjQ91sklFVuSYF5gn62nMYa1tEQDh/lIm5yQYxHd060oKDqTRjk+iaSYOzGP4uPo/YGrlIzmZs3vEDAf2qCsTSOFFBk/PaYPMv99ooF1QvlMi81mEC2CXDQbB4Q3P6fiCUs9k2MD8+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjQIQJjJMDSDK8sG7uFBIB29i9Gy2QvQPG0+pCQdjLA=;
 b=mhSk3PbJiYYVSV08pAc0RPipgnMLzvswBW63intdkLOvp6V5NPIuh7NL9DkJrJo/PMgsmvFQfireqy2h3W2j/dbz/iCUFwsIMGL/R0FD/y34WMoWfO8lMevxO7CqPMKiBx80++lLbmeAp+4pwnFoXN8Gr4TdvwiNmXr6btqBLn7WS/CgFOqylzCR2A7IYH6X3nCwAf8a+m9GOKxNus9Bq++5wDAvGtOfbQZEdAuIuIUSkIn5Q3DBNGO3NW9F/caC5KikjY5dQeCsy++/IJ7MSwMw0s+p0bij9FLuKFSAdClqRE94lanDxCum+hk4fY9tIP1YlvfvQCMhCWCCIFiqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 19:02:52 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:02:51 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
CC: "Chen, Zide" <zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH 07/15] perf/x86/intel: Reject SAMPLE_READ for
 no-counter-snapshot ACR events
Thread-Topic: [PATCH 07/15] perf/x86/intel: Reject SAMPLE_READ for
 no-counter-snapshot ACR events
Thread-Index: AQHdTx4eJxobZL9Hkki3yDYLXWjOkbbl7AIA
Date: Tue, 29 Sep 2026 19:02:51 +0000
Message-ID: <98d9d6347bd0704e8fa773b458e12c7a850c49cb.camel@intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
	 <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|DS0PR11MB7880:EE_
x-ms-office365-filtering-correlation-id: 3f31375f-5351-4778-e22d-08df1e5c42e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|7416014|366016|10067099003|56012099006|11063799006|4143699003|921020|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: mDZl1XwuC4uziFKlCfj0V36ol/LT33yesM2ajxyOBoi6uMSQsu6Y6i2mTnPTKpIx6KUX69UAYUSgZyr9VaSixOoHfzm9RfDxT+vAkgSfCs+/eBUVHPx0YrcibqRLlcD/P8YKo61TdPU1iDFjRJu8MR7962bMZJlZnzxGFfuLWTE2weKhceK+wdSvthFHe4lj0VZHp1cKuxRn7lYmm/Hdo7upmt8GfDEqmdFXL8rRvEdSO8pG5WQkCQw3tVpSej5+NVCeSWHSHr9X+koxopN7Gs8EsK7xJx8Sv5pDuGd/zNb3MdX6oSd/dcXhzxMhR6ptOZDb5fXTIfMcd7YUr6IPCSvh5+VOejkq77KwbiLbOa4Is1IUBqa+62du25O4PJqTPAu3SHBC8Ew/J6WTlwREcX9LO0jQK6iJwccoDzr5LBCNnez7feGEL5XQTfPpl9tIso2J9IUoh6os5Ruf4IHb76Cpy+RZZCZ/fXhfXlllDa9an1VTNuCmyTetjzyf7XMUCQDddb0tdQMQHt4OVg+3KV0aTcPik6s/yK+h54aqDQWYKPcrVb00GfGeplIfHo/32PvkwcPvFvDosUTRmbG3wW8z0e7pl3C1I7QjB6f6Wlo8cv94Wy4TjYiaIghXhOjVwKLAmO/hFrGS9ZlBNB5oi858rykbXdb0U0xcDxUbx2PiMsKQMpmb+8XPkNhBg2dfasGKSCwt+eUSstgeB5CwZtbHMkeXhu0njA7tkW13uGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(3023799007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHV4UjF5Y2pjbGwwc1hxZHdVcXhDcjRXUDlYR08xaU5VZG9aYVNFUitNOXdI?=
 =?utf-8?B?UitIMDIxOGlxdHBxdENJTnl6c1EyeVpGQjl2aTNCbWlPT2RZZWFOWGhRSXpu?=
 =?utf-8?B?MWFFUDBZcVVOdk1VZC80MjhHVEZPRXoyOSsyUkhoZEVyNi9jU0J2cGYvc3Ro?=
 =?utf-8?B?L2dkQU01dzBUK3VyMVM2K3N0UEE5Uy90RDdrRGVtOXMzc1U5VjhyZklJaENn?=
 =?utf-8?B?UzNqWnVCdCtyZGRhWlZwYTBZSEhBbUE4cldYNkEybXFmbVZXZktPc0dOZmFz?=
 =?utf-8?B?ekVxRGs5MDJHd0RVRWNGQUtiSitjbVZEKzJpOTRpb002ODVHOHl4TXhaWnBN?=
 =?utf-8?B?UjRGa3lJc0dMTE9PczU2M3RWeVJOaS9lODE2TjVhbnpoYk5ST1ZhWTNQMVBx?=
 =?utf-8?B?ZWI1QlZOQUFyQ1NTb250aW1zOElSN1RtSm5DT0ZCa1RyVnZiK05ocy9kWjF6?=
 =?utf-8?B?L2JMSlY1RGowYW9xNzBZUEU5WVJRR0JhblNTcXBqR3NMRmNlMUhFNWpYR05l?=
 =?utf-8?B?Wng2UTRkMjZxTC9FaUg4a2NqSUhmV3RadVRXTVFua3Vxc2NOaFhualQwaTly?=
 =?utf-8?B?bkhlVHpQMFZ2OGlIYlR2aXhSMHh2TDVEZUR4QmxSS3Z5OFBEUHRyTldXaVNa?=
 =?utf-8?B?T0xVY2M1LzNJelcxUE15dlpyTnROMmFIM0V2VDJIK1dzRnlyUFBWKzMzSU9a?=
 =?utf-8?B?N0tscUNrRk54SU95ODBxNDl4M29HSzU2RDUxbDVsRlJhRWxsTUh4cm1xT3ZC?=
 =?utf-8?B?Wm1kMklNMCtSSDEwS0FSQVdoWmwvT3I5czl6UEh3dHd3UlB6cWFJZUhLbFRz?=
 =?utf-8?B?ZHRUWkYrelNFQjJVRmxUYWdaYllsL21TZ3Q5MG83QUhrZWZwdEhXK0RNTjV0?=
 =?utf-8?B?ZldLUTRyZDVvZGJTSXRHWjl1NDhlak5iM24wUWZwcGZYdkJmSHh1aGlqK0tY?=
 =?utf-8?B?TlVFckl4WGNqbGlPemV1LzhEdlVDaFk3RW9TejRrRGNRdXV0MkJFVmhTeWtL?=
 =?utf-8?B?YU1VODdIQ2N3OVFxbVVwZXYyazdnQytBemgrRWprNlZCT0hxYUtUTGFOWDdu?=
 =?utf-8?B?ME5Xc1VMY1lybGhDZmVsWXdybDQwTTJvd3dDb1NraFR6M2g4NG5CWEJUZ2Fv?=
 =?utf-8?B?OGc2YXowSTI4eWpCdURYQkdmNThpUG5UR2NnaFNlN1hFWVFSVnhZT3V1cDFO?=
 =?utf-8?B?T3JDay91VFRqSlVXMk51LzNROEdrZW9oMXRQY09MTTJhRVZNM045TXFGT1Jm?=
 =?utf-8?B?N25sT0NBQlpmQWFQZjZPZDB3Ym1yY0lRd3VmbURURlRQd2tZWFZvcTN3dlkr?=
 =?utf-8?B?MElZc0FrQW5NQkYwNWkzRDNQYllqQW9TT09vQUZnT25UWHhvYVFwT3Zlc3pL?=
 =?utf-8?B?RGwvOXlTMWYya2Y5NlBiZVJNWWJSYnJlTHJqRzhOREc2dUoreE1UWXBsekZq?=
 =?utf-8?B?NlAxRkVaVXpvczFPRVFnYTMvbEd1NFdzekFhZGI3ekRWS21mZFM5VUlQUW9J?=
 =?utf-8?B?ZGZhUVQ1WU5WeGN1b1NjeUdKbGVmWGFKRmd6MEVZTFQrOHVZekRPL0dWcDh6?=
 =?utf-8?B?eWFNdjVRWUNtMXhTeDl1OXJLaklIODU3YnRrQlVDOVdxSkRlTFg2cVduOWcv?=
 =?utf-8?B?TDh3ek9PcGpqKy9YNlA3a0RDOS9LZWZ0WFBpYVVMZC9IeFVUWmdmZGd5bmhO?=
 =?utf-8?B?NUs2eEg5Y0lQTTRVbnBIcjRNNGs4eXBMRjk0dzZmblRCVGlIUEhSUU5rZ2FD?=
 =?utf-8?B?QmRvZkRINXRoTUZNenJrV0ZZQmlOV0FPTTFHNWNrcHFYaW5EcEF2bDhTb29k?=
 =?utf-8?B?MFVkSmZiZjlUbXhWRnRvQ0R6NzJPVWJHN2xJUlBFdEdiN3h3STV3VFJVbEYr?=
 =?utf-8?B?Y2RQdTU2V3lLK2VVY3JOREN3M0FwOFk2SGtuR244dW41ZmlhcDFVdk1abm5x?=
 =?utf-8?B?VUQvcXRHd1AvR244Ty9vRDNkaTJKZWlaaTFvS2pGMXJiOCtqZlpSK2JBUHJT?=
 =?utf-8?B?NFdpUTJEcjlBQk9HQmVxRnlGN0pJcGZpK0lFM2Qyb2tmdUJOWG1FcXIyRGd4?=
 =?utf-8?B?RnNOWjZ4bTI3U0sxcUZORGtzdUZFUmJ5enlCM1gvVm5zemUvM1JoWUQrVkVt?=
 =?utf-8?B?b3F5WnNOM25pZXNEUTVFOXBhaklrRjJmbjE0TVg5RjZaVXdUd3o2Tm5hSXJD?=
 =?utf-8?B?R0NwVG1NVzZxTHNHTGNlWXA0TjZ3bk5lWmpXYXM3UnJnOTdvWHZDWDRRa0JV?=
 =?utf-8?B?dlRsTThPektoK2tJRGplSmFTS2dHYXdXREh2WVVuTUNFTHhWVEwwZVorK09S?=
 =?utf-8?B?dGhybjhtYlM5OHV3cStyTHU5cEZjQnJDNVFGVlZnbHFjTHN1S2NEUmdXSWEy?=
 =?utf-8?Q?Tsa6jZU8T9uFw3sh32l/fYtH5g5fGoR2641h/dZPhTHMF?=
x-ms-exchange-antispam-messagedata-1: 6hAJyRDpXc4WTaaldia0N23S9dEDbuj21Q0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1A02BFC30782D4997D1DD5DDF394798@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TjnzyonaRGTpMECRCnXrFgycnTag/X1tVjwjdcm8wSqan8xkWhFYWqyap16sUukyvd1qrN9QvsVNOK0gfh6JtT2uNkjQNjboXCDD4KVSyankgvf7l3ptrRpn8EP1M41TPOjuR3mjSweZ3laZrmJdaFAVwEJKc8l01OvuRLVGu1CdplJgmDIdoxHO3JGRAIiQOoWw16nUwinLN6lMNRlKmiP3WOkOM8m6SNyBgPNC9tX9S3fZTaFULAqIzg2TJRHG/54pRMJslvOIAg7I0IV8SIqkv1E+K7YgDbSfD3C0gTbK+snD+H2hpSCVjhy4zt72joOZ0QJHvroABzeQy5h/Zg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f31375f-5351-4778-e22d-08df1e5c42e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 19:02:51.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3HAAPxI37bdsu+rK6NFJJotsQVT98uBMwMvVpk1sDcqkJTptHRG4M4sRLxdPch8myLoF8Cs4bDMoieyxl4/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE1OjQzICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IEFD
UiBldmVudHMgY2Fubm90IGFsd2F5cyBwcm92aWRlIGEgcmVsaWFibGUgdmFsdWUgdGhyb3VnaCBT
QU1QTEVfUkVBRC4NCj4gRm9yIG5vbi1QRUJTIEFDUiBldmVudHMsIGFub3RoZXIgQUNSIG92ZXJm
bG93IGNhbiBhdXRvLXJlbG9hZCB0aGUgY291bnRlcg0KPiBiZWZvcmUgc29mdHdhcmUgcmVhZHMg
aXQsIHNvIHNvZnR3YXJlIGNhbm5vdCBzYW1wbGUgdGhlIGV4YWN0IGNvdW50IGJlZm9yZQ0KPiB0
aGUgaGFyZHdhcmUgcmVsb2FkLg0KPiANCj4gUEVCUy1iYWNrZWQgQUNSIGV2ZW50cyBhcmUgc2Fm
ZSBvbmx5IHdoZW4gY291bnRlciBzbmFwc2hvdCBzdXBwb3J0IGlzDQo+IGF2YWlsYWJsZSwgYmVj
YXVzZSB0aGUgdmFsdWUgaXMgY2FwdHVyZWQgaW4gdGhlIFBFQlMgcmVjb3JkIGJlZm9yZSB0aGUN
Cj4gY291bnRlciBpcyByZWxvYWRlZC4NCj4gDQo+IFJlamVjdCBTQU1QTEVfUkVBRCBmb3IgQUNS
IGV2ZW50IGdyb3VwcyB1bmxlc3MgdGhlIGV2ZW50IGhhcyBQRUJTDQo+IGNvdW50ZXIgc25hcHNo
b3Qgc3VwcG9ydCwgc28gcGVyZiBkb2VzIG5vdCByZXBvcnQgaW52YWxpZCBjb3VudHMuDQo+IA0K
PiBSZXBvcnRlZC1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KPiBGaXhlczog
ZWM5ODBlNGZhY2VmICgicGVyZi94ODYvaW50ZWw6IFN1cHBvcnQgYXV0byBjb3VudGVyIHJlbG9h
ZCIpDQo+IFNpZ25lZC1vZmYtYnk6IERhcGVuZyBNaSA8ZGFwZW5nMS5taUBsaW51eC5pbnRlbC5j
b20+DQo+IC0tLQ0KPiDCoGFyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMgfCA1OSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTkgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3Jl
LmMgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5jDQo+IGluZGV4IDM3N2ZmMzkxMjQyMC4u
M2ZjMzc5NTUzNGJmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5j
DQo+ICsrKyBiL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gQEAgLTQ5NzQsNiArNDk3
NCw1MyBAQCBzdGF0aWMgaW5saW5lIGludCBpbnRlbF9zZXRfYnJhbmNoX2NvdW50ZXJfY29uc3Ry
KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCwNCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0K
PiArc3RhdGljIGlubGluZSBib29sIGlzX2Fjcl9zYW1wbGVfcmVhZF9hbGxvd2VkKHN0cnVjdCBw
ZXJmX2V2ZW50ICpldmVudCwNCj4gKwkJCQkJwqDCoMKgwqDCoCBib29sIGdyb3VwX2hhc19zYW1w
bGVfcmVhZCkNCj4gK3sNCj4gKwkvKg0KPiArCSAqIEFDUiBldmVudHMgY2Fubm90IHJlcG9ydCBh
biBhY2N1cmF0ZSBjb3VudCBmb3Igbm9uLVBFQlMgZXZlbnRzDQo+ICsJICogb3IgZm9yIFBFQlMg
ZXZlbnRzIHdpdGhvdXQgY291bnRlciBzbmFwc2hvdHM6IGFub3RoZXIgQUNSIGV2ZW50DQo+ICsJ
ICogbWF5IG92ZXJmbG93IGFuZGF1dG8tcmVsb2FkIHRoZSBjb3VudGVyIGJlZm9yZSBzb2Z0d2Fy
ZSBjYW4gcmVhZA0KDQpKdXN0IHdhbnRlZCB0byBwb2ludCBvdXQgdGhlIHR5cG8gaGVyZS4gT3Ro
ZXIgdGhhbiB0aGF0LCB0aGlzIHBhdGNoIGFuZCB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzIGxvb2sg
Z29vZCB0byBtZS4uLg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNv
bkBpbnRlbC5jb20+DQoNCj4gKwkgKiB0aGUgcHJlY2lzZSB2YWx1ZS4NCj4gKwkgKg0KPiArCSAq
IFdlIGtlZXAgdGhlIGNoZWNrIHNpbXBsZSBhbmQgZG8gbm90IHZhbGlkYXRlIHRoZSBhY3JfbWFz
ayBwcmVjaXNlbHkNCj4gKwkgKiB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgU0FNUExFX1JFQUQg
ZXZlbnQgaXMgYWN0dWFsbHkgYXV0by1yZWxvYWRlZA0KPiArCSAqIGJ5IGFub3RoZXIgQUNSIGV2
ZW50LiBJZiBhIFNBTVBMRV9SRUFEIGV2ZW50IGlzIGluIHRoZSBncm91cCwgdGhlDQo+ICsJICog
QUNSIGV2ZW50IG11c3QgYmUgYSBQRUJTIGV2ZW50IHdpdGggY291bnRlciBzbmFwc2hvdHM7IG90
aGVyd2lzZSBpdA0KPiArCSAqIGlzIHJlamVjdGVkLg0KPiArCSAqLw0KPiArCWlmIChncm91cF9o
YXNfc2FtcGxlX3JlYWQgJiYgaXNfc2FtcGxpbmdfZXZlbnQoZXZlbnQpICYmDQo+ICsJwqDCoMKg
ICghZXZlbnQtPmF0dHIucHJlY2lzZV9pcCB8fCAhaXNfcGVic19jb3VudGVyX2V2ZW50X2dyb3Vw
KGV2ZW50KSkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCXJldHVybiB0cnVlOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgYm9vbCBpbnRlbF9wbXVfYWxsb3dfYWNyX3NhbXBsZV9yZWFkKHN0
cnVjdCBwZXJmX2V2ZW50ICpldmVudCwNCj4gKwkJCQkJwqDCoMKgIGJvb2wgZ3JvdXBfaGFzX3Nh
bXBsZV9yZWFkKQ0KPiArew0KPiArCXN0cnVjdCBwZXJmX2V2ZW50ICpsZWFkZXIgPSBldmVudC0+
Z3JvdXBfbGVhZGVyOw0KPiArCXN0cnVjdCBwZXJmX2V2ZW50ICpzaWJsaW5nOw0KPiArDQo+ICsJ
aWYgKCFpc19hY3Jfc2FtcGxlX3JlYWRfYWxsb3dlZChsZWFkZXIsIGdyb3VwX2hhc19zYW1wbGVf
cmVhZCkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCWlmIChsZWFkZXItPm5yX3NpYmxp
bmdzKSB7DQo+ICsJCWZvcl9lYWNoX3NpYmxpbmdfZXZlbnQoc2libGluZywgbGVhZGVyKSB7DQo+
ICsJCQlpZiAoIWlzX2Fjcl9zYW1wbGVfcmVhZF9hbGxvd2VkKHNpYmxpbmcsDQo+ICsJCQkJCQln
cm91cF9oYXNfc2FtcGxlX3JlYWQpKQ0KPiArCQkJCXJldHVybiBmYWxzZTsNCj4gKwkJfQ0KPiAr
CX0NCj4gKw0KPiArCS8qIGV2ZW50IGlzbid0IGluc3RhbGxlZCBhcyBhIHNpYmxpbmcgeWV0LiAq
Lw0KPiArCWlmICgoZXZlbnQgIT0gbGVhZGVyKSAmJg0KPiArCcKgwqDCoCAhaXNfYWNyX3NhbXBs
ZV9yZWFkX2FsbG93ZWQoZXZlbnQsIGdyb3VwX2hhc19zYW1wbGVfcmVhZCkpDQo+ICsJCXJldHVy
biBmYWxzZTsNCj4gKw0KPiArCXJldHVybiB0cnVlOw0KPiArfQ0KPiArDQo+IMKgc3RhdGljIGlu
dCBpbnRlbF9wbXVfaHdfY29uZmlnKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkNCj4gwqB7DQo+
IMKgCWludCByZXQgPSB4ODZfcG11X2h3X2NvbmZpZyhldmVudCk7DQo+IEBAIC01MTE3LDYgKzUx
NjQsNyBAQCBzdGF0aWMgaW50IGludGVsX3BtdV9od19jb25maWcoc3RydWN0IHBlcmZfZXZlbnQg
KmV2ZW50KQ0KPiDCoAkJc3RydWN0IHBlcmZfZXZlbnQgKnNpYmxpbmcsICpsZWFkZXIgPSBldmVu
dC0+Z3JvdXBfbGVhZGVyOw0KPiDCoAkJc3RydWN0IHBtdSAqcG11ID0gZXZlbnQtPnBtdTsNCj4g
wqAJCWJvb2wgaGFzX3N3X2V2ZW50ID0gZmFsc2U7DQo+ICsJCWJvb2wgaGFzX3NhbXBsZV9yZWFk
ID0gZmFsc2U7DQo+IMKgCQlpbnQgbnVtID0gMCwgaWR4ID0gMDsNCj4gwqAJCXU2NCBjYXVzZV9t
YXNrID0gMDsNCj4gwqANCj4gQEAgLTUxNjIsOCArNTIxMCwxNCBAQCBzdGF0aWMgaW50IGludGVs
X3BtdV9od19jb25maWcoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KQ0KPiDCoAkJaWYgKGxlYWRl
ci0+YXR0ci5jb25maWcyKQ0KPiDCoAkJCWludGVsX3BtdV9zZXRfYWNyX2NudHJfY29uc3RyKGxl
YWRlciwgJmNhdXNlX21hc2ssICZudW0pOw0KPiDCoA0KPiArCQlpZiAoKGxlYWRlci0+YXR0ci5z
YW1wbGVfdHlwZSAmIFBFUkZfU0FNUExFX1JFQUQpIHx8DQo+ICsJCcKgwqDCoCAoZXZlbnQtPmF0
dHIuc2FtcGxlX3R5cGUgJiBQRVJGX1NBTVBMRV9SRUFEKSkNCj4gKwkJCWhhc19zYW1wbGVfcmVh
ZCA9IHRydWU7DQo+ICsNCj4gwqAJCWlmIChsZWFkZXItPm5yX3NpYmxpbmdzKSB7DQo+IMKgCQkJ
Zm9yX2VhY2hfc2libGluZ19ldmVudChzaWJsaW5nLCBsZWFkZXIpIHsNCj4gKwkJCQlpZiAoc2li
bGluZy0+YXR0ci5zYW1wbGVfdHlwZSAmIFBFUkZfU0FNUExFX1JFQUQpDQo+ICsJCQkJCWhhc19z
YW1wbGVfcmVhZCA9IHRydWU7DQo+IMKgCQkJCWlmICghaXNfeDg2X2V2ZW50KHNpYmxpbmcpKSB7
DQo+IMKgCQkJCQloYXNfc3dfZXZlbnQgPSB0cnVlOw0KPiDCoAkJCQkJY29udGludWU7DQo+IEBA
IC01MTc1LDYgKzUyMjksNyBAQCBzdGF0aWMgaW50IGludGVsX3BtdV9od19jb25maWcoc3RydWN0
IHBlcmZfZXZlbnQgKmV2ZW50KQ0KPiDCoAkJCQlpbnRlbF9wbXVfc2V0X2Fjcl9jbnRyX2NvbnN0
cihzaWJsaW5nLCAmY2F1c2VfbWFzaywgJm51bSk7DQo+IMKgCQkJfQ0KPiDCoAkJfQ0KPiArDQo+
IMKgCQlpZiAobGVhZGVyICE9IGV2ZW50ICYmIGV2ZW50LT5hdHRyLmNvbmZpZzIpIHsNCj4gwqAJ
CQlpZiAoaGFzX3N3X2V2ZW50KQ0KPiDCoAkJCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTUxODQs
NiArNTIzOSwxMCBAQCBzdGF0aWMgaW50IGludGVsX3BtdV9od19jb25maWcoc3RydWN0IHBlcmZf
ZXZlbnQgKmV2ZW50KQ0KPiDCoAkJaWYgKGh3ZWlnaHQ2NChjYXVzZV9tYXNrKSA+IGh3ZWlnaHQ2
NChoeWJyaWQocG11LCBhY3JfY2F1c2VfbWFzazY0KSkgfHwNCj4gwqAJCcKgwqDCoCBudW0gPiBo
d2VpZ2h0NjQoaHlicmlkKGV2ZW50LT5wbXUsIGFjcl9jbnRyX21hc2s2NCkpKQ0KPiDCoAkJCXJl
dHVybiAtRUlOVkFMOw0KPiArDQo+ICsJCWlmICghaW50ZWxfcG11X2FsbG93X2Fjcl9zYW1wbGVf
cmVhZChldmVudCwgaGFzX3NhbXBsZV9yZWFkKSkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiAr
DQo+IMKgCQkvKg0KPiDCoAkJICogSW4gdGhlIHNlY29uZCByb3VuZCwgYXBwbHkgdGhlIGNvdW50
ZXItY29uc3RyYWludHMgZm9yDQo+IMKgCQkgKiB0aGUgZXZlbnRzIHdoaWNoIGNhbiBjYXVzZSBv
dGhlciBldmVudHMgcmVsb2FkLg0KDQo=
