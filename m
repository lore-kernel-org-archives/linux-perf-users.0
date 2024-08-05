Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BD1422D3;
	Mon,  5 Aug 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890082; cv=fail; b=XyUD5mh/cOb7rzUmw5R4QNDtzTdp8DQsUC/36hQRwuTpR+0uWiY21GwyLVBwG6vj6TUE1Vq/8RucoFtfU/u68s4ooMxgDO9X2XvlZ+IwQMIPW4Kvrxr9MOZsDTyr4+8PvmQMXhwZn4VKX3wIz7a6lhFnCcMz6aHqzStxIwKTxno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890082; c=relaxed/simple;
	bh=kr1Fm/pVB2kC2kiGA5T32B88kUmydnK4pkwI0kM4Xj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcoxXsSMLNYwmZGNXdqoFV1kCBdFwH0XCxk76wOHaN50HhorHTZ8FXp+tMc4cxhqQrMBnEPOZLubj/mHsASvC6aT+eA7ZX4ecHkA67VFkw3ojLxl+D2am59lLAhw6nzI94fOnObouDTPCZW0rXNdnDo7B8ruheZSd4uLRs5wFew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itgmlbV3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itgmlbV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722890080; x=1754426080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kr1Fm/pVB2kC2kiGA5T32B88kUmydnK4pkwI0kM4Xj4=;
  b=itgmlbV3uEMED+uSOOUKWHPbqIJvaKltpLYWZTMNMnbDtDm/pJH3zTjW
   iFgQnlLE+tV+6M4vYcEgepv620aHVtOmKC1WLYFaSLR8zlA7x/Fb/XoWZ
   360yN9jFX9S5+Ykpyn6Zdy/FbrQ+p5vDqM8e/Gbouq+NYGzCICmMoYpUF
   SucB1R2S1CG9JAJ+4GsAKaDcvnrX30Cc10hkE8ZDP2gvVxMmnCxV452RL
   AJyOk/JdQSrSKdahCghuv+QvwGBlSG26cVFA2RhgXViI/WD/3xDAlJKyb
   527BvOAZhZ3hvyqzP7rRxT0IuUVWxj0B1suYNoPHJcEaUw3P8U73eQUhe
   Q==;
X-CSE-ConnectionGUID: hDGzv68dTpSkHCO1TIU6yA==
X-CSE-MsgGUID: JVUWmS5URkGGYEkBgkpzvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="23790567"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="23790567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:34:39 -0700
X-CSE-ConnectionGUID: HnsG2MWJQkaZ4dywow2GZg==
X-CSE-MsgGUID: faSyZzw8S/eMcbfajWGX7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="93814141"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 13:34:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 13:34:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 13:34:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 13:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtlbIA1TOOj8ufwEzbtUz/cgZmL1fYU9fRu5u3+ewlvjaIg0Kny7P1LSy+IMsv2tK03EtXhk8ApAPL0bcmqu24oTWdYFWNHmeYpHEwtLoy0iFYa9yFfgd2ceNE+cQ6ZDoECCNsTmPKRzg4CtFk1eCjks5g+n1NotvzStJBybIGD11Sr/AI91Vp6ooqD332y6KZeSKStDP++Jc90elud3BcRl5uW807rhDwdEfTlgyMFhaWRa1wuYOW61N01gX4Uolul44pkHgnwgfgOCvAH7K1/vmV6lEe/Qtq9VcXWhmIrSvJahS3b/xwNmNu3Z9oLIDUMEI+Z8MpgwmrZZu+5ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr1Fm/pVB2kC2kiGA5T32B88kUmydnK4pkwI0kM4Xj4=;
 b=PwSF0Y/vA+q2fCyEIddtynQosUfOKabYZokWGURbGJmMkocBxfBKe335li4QlqFcyqV5aJg+nbSviVwzTt36TAImoP+2zS+3RyogNizeBKh49Qr3Lrzjw2kyqhcIoPHUAoRSEjrZz5sohfUB8o+g5dunmls+PNeslq18J6OVYIqPymk3DPS6bShSgwxGrs+bGtdEBLY1q0pKGBclDPx+foWnA8iAxQKDoGo6uX+m/gqL11yvLCfDIYRd5/t1jHBnCldU40IfoZdHM9nPmshHKfN9mXuYSF2EtsOW1dWbzNEjSmuvCxXlb3+n95Ibe9ECkAdaL0UPKZunguYU1K9yiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 20:34:35 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 20:34:35 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHa2m0RzlLGrVs/lUq8Aq20b+fv/7IZKc+AgAAAuQCAAApuAIAAAl5A
Date: Mon, 5 Aug 2024 20:34:35 +0000
Message-ID: <CO6PR11MB56359A3DB82A00F383CF5769EEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-4-weilin.wang@intel.com> <ZrEqr36sukDW66uV@x1>
 <ZrErSvqHMvzw3dm2@x1> <ZrE0CtHsDOS7vUw9@x1>
In-Reply-To: <ZrE0CtHsDOS7vUw9@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DM6PR11MB4516:EE_
x-ms-office365-filtering-correlation-id: c189eec9-78a4-493d-9a64-08dcb58e04de
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWZKcTNRRytTWHJPd3lqUGpaRlNiOU00dzBmUE1HN2JTQlU0andZU2M3NmMw?=
 =?utf-8?B?bmxLZ0x6ZytvdThjZFAvT3JnaTZVOHhFY0NBTWY4V01IazhFYklPTWlMd2th?=
 =?utf-8?B?OG5sdmFhSmo1WUdKSUNPUWovVFlyNG9yNFdudzVMbjdvaTRwWGk1NlBiajhT?=
 =?utf-8?B?ZGFGOGxCN0R4LzNZQVRjVitXMGhqdzdmV1N1V1p0am92bjE5eFpleXMzaE9M?=
 =?utf-8?B?WnBSMkI4ZS9QK2FvTGF6QXhuMDkzT2VYMldYaHNja0ZGbnRPUTM0b0pPeFVZ?=
 =?utf-8?B?aVFlbDZJYTZoSUlBSVNpQzg1MjRJb1htWlY4TzhVNzJQeVJQSWY0ZUwzOFBX?=
 =?utf-8?B?ZUlja2NZY0lNeVRNTkNLb3FkWkFuWEc2OWplNGJyK2RPRFZjb0lFaS8xeFVY?=
 =?utf-8?B?M3ZDdTlOYVB4eTZUeUpxTGFuMS93V3lvMSsvNUlTTjZtSDB1Q1dWbkFLWm1r?=
 =?utf-8?B?aGJwRnE3UEtMR2FkZVRHV1BFaFZhc2czRXMyR3NwZ1pBWk1PUHNLeFdYRkJ6?=
 =?utf-8?B?TVh3SlVVaUpPWmZmR0JEVTYyVWN2UWhtSlFTNGY4a2VWbGgxclVMdnh1Z0FP?=
 =?utf-8?B?MnpSLzk0c1lKaWc4Yno0TkJKSFhGZ3hzSENJaUdOMUVUWUpvUit1SW42c29Z?=
 =?utf-8?B?bXVFSVZ4UTFudXRTTnNybXFEa2o2TUtpZllFWW0rWmtYeHFsZ2FMSVVQekZo?=
 =?utf-8?B?L0JHeldRU3JtUGpReFRFOXpXR0dFR09rSml3b25CQlFYc2NXYitnZk8yZndJ?=
 =?utf-8?B?OExzK0MrVllpUDZ3bHVpVWthWmppc3lyOElERWtoME9rWkJLR0UzQ3FhQktk?=
 =?utf-8?B?ajdPemlsaTZtVm40MkVOVG41WWd5a3dJd3FSTUthSGVkYlpIVElOMGlCN091?=
 =?utf-8?B?SmFiWE5qM1QydCtWWm1lbSt1Si96WUJnV2VTc3ovUmVudUlQRUw0ZXgwVGRL?=
 =?utf-8?B?QzNGQ1pBTjIvQlFIcVhBZlVWSUVFZFZVSmtjUjZsU0JTb1Fsa2UrbDBEcnlV?=
 =?utf-8?B?aS9zUnplUFQ2Z3MwZk4wSW1PSUpVUlZ3SzJBdC9nMmFteGNrdnJxUkN0c0dC?=
 =?utf-8?B?bzhBSFloK3Zrd3prU2N1MlpMbGloYWRGeHZpWmhqdUJCZS9RdzF4VzJqN00x?=
 =?utf-8?B?OGNXdWJXSDFvL1hVNzF5UTZoMU8vbk9GWnBkeHhkV0RHL29Hd1hmL2JHTUwr?=
 =?utf-8?B?eVU3SnNxUmE1RHROTFhwTkZTRDg1NTJmTE9mS1NsL1IvMzlGQk1sTzUzd2U0?=
 =?utf-8?B?bk9YdmlRVTF5TTUxallkd0YvRU5kc2JsMnA1bWQ2aUN2TXd0T0RtTm4vUHFi?=
 =?utf-8?B?QVV2Y01jTnFSZFRTR05TS1I3Nm5LNitGdFY2QkxMVTBraGh4UmZVeE5xUG4y?=
 =?utf-8?B?SmhCTXpLbjRORml5U3djeS9raVU2TWI2T3lWdTRraDBTR3cwTERJTElCTGZ3?=
 =?utf-8?B?VFlsSzhGczRXajk2M0pyVEhOcDlwcnVGc0QrMTFkTzdYQ2ZJSUlTdGdQeCti?=
 =?utf-8?B?MjlvclRCQXFNUnluMm5VNWNya2VFNVYxQW9oQzdTQTVPdno3TjZ6bS9oRzBZ?=
 =?utf-8?B?Ulh4WG4yNk9XcDlua0wvL1l6VHZ5VzB2M2V1OUdFL1hjZ0svMXcxTjlUbTJ1?=
 =?utf-8?B?d3FJSFhIeG1MdkIwSTA1WVo1OU42azNSTk9rVUR2cVJIT2JPZHpLZGlHTnVM?=
 =?utf-8?B?TUVWQjY3Y21Bcmg2WVRvS0pOVkNheHFYYjJZbkFoRUhjelZtdDZ1U3hQaW96?=
 =?utf-8?B?WUdNQ0VYZm1LdDc4akhyZzVaSmRXaWw4SEVXckdhZktSK1VNYlRFeWFzVFI3?=
 =?utf-8?Q?M0FHbzfApRtRwVVATpPLkp9dgHGqwqf+FlA90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1ZbHBpYjA0b2JBN0hhWEV1YURjTlp5dzFsUDNrNS9tU3QrL0lTbDlheERI?=
 =?utf-8?B?d2xoQWhxNFRNdldOWExmVHZIVVdTZTNzVVJrS1pwUmg3RWdSZVdLWDY1Z1pH?=
 =?utf-8?B?Yk5tUjBNVkM1aEpqVCt3UzZDT0hRTjZpcEUzTXA5M1NXNi8rNVIrbGJyL2dC?=
 =?utf-8?B?YlVDTFpsM2RwODVBeTNKaDRWOGg3UnhDMUQvYUhFNVFqZS9TWWRBZ0FSOGtK?=
 =?utf-8?B?eEpTVXhic2dRWmNCQ3Y3NEFMUnF4eXpLSmtjK0IzTlJWaDAwSXpRVFplMERE?=
 =?utf-8?B?RVBYTHFzd21KNjZ4TWtadG04NFVPT0I1ZldYcjhMQnpCUEo3MXQzbmVNT3ZS?=
 =?utf-8?B?NlBMQ1FBdk84ZWQrNW1teXcrKzhrQUQxRytvRXVpWFRvZGI3a3AwL3pSakph?=
 =?utf-8?B?ZlpVdVFKOEtPNVdtZEhYeC94UXNVTnJGNXJka3cyN2cwN0tFOURwanVKZDlK?=
 =?utf-8?B?L0EwRzlqQnhWNFhHYTZQRTRaTFpPeVQ5SC9lUXBiY2FGY2ljdGFyMUJsaDJL?=
 =?utf-8?B?VlcySWdBUGNrL0Vya21mVVJmR1VycHJwaDgzWHhVM2E1R2RCeHRUbk8rZW1D?=
 =?utf-8?B?S3JuRjRmeG15UnNYY01rUHNldHF6dDhsMVo4VzdHemRQTjQ2dzJ5VnczNjhq?=
 =?utf-8?B?ODI2cFVSdFo0dnZwN2xLbWF4c0ZXNXgvd0pXT3BONDRVVzkwbXBKRDR2TXZu?=
 =?utf-8?B?bGtGbldyci9YeEVoR3hIZ0Y4UGRWaVlxdVViL3QzN280Q2g1OWFheFpLdDYz?=
 =?utf-8?B?cksvd0hIampSY0NGQXRrd1o3QWRJandmYjFvRzdrK1RiZGdVZW9TUXlwTEl1?=
 =?utf-8?B?NDhNM2tkQWs4Vlo5Q09SNW5NbjNhVW1qUUVMRHBUMElDdmVDNG9HSWxXVitS?=
 =?utf-8?B?aE5BSzJyQndSYnpxem1rVW01a0t6U2taelNielNmZ0h6UXkwWVdGdkpVMjNE?=
 =?utf-8?B?bldYS2xuaElQLzd4aWFqK2ZTWEVIMGQyTUVoT21rNUp3MklpYTExV3V3b0tr?=
 =?utf-8?B?R2dmeVpCaVNEVytGQWhtT3NYU04vNXdlNm1QV3F5LzdVNTNaVkhQVlRsajRw?=
 =?utf-8?B?YkY3a2doVXZESC9RalhNMUZrVzBYRGEvZ3NCbnk0cGdzdWwvTmhoT0JVQ3JI?=
 =?utf-8?B?ejBlUFBMZW9GVjNOZXh2VGpqNGViT0JoTWlZdGFZOWdtQXhTd1ZtWVBjRXdS?=
 =?utf-8?B?T2V0aXZGbGpXTFlsNkdsN05adlRTUDNYWUJ5Q04yZGxLOGpsRlp5NzBkMXNQ?=
 =?utf-8?B?ays2Sm44NXdVYXJhdmdJalRXQnJzdmx0MkEzM2NUdDJ0bXl5eFlTMkt3L3Az?=
 =?utf-8?B?YlgvTGJPUjRmeTBoZWx4RVRXMHRTTVY5WUZrQWZXRFVkeTFIMjJmc0JSU2Vo?=
 =?utf-8?B?bHVXekNDS0Jrb1ljcVVkcHA3N3hzU25OZTRJTHl4cHdWenZ0UEYvUm5NNC82?=
 =?utf-8?B?WGFzVzlieG90VlpqanljUWJ5MGNNbU9zVTRYaGZOam83Sk84aGc5cmFSTEdw?=
 =?utf-8?B?QUQ1Sk5PUDIxQnQ3TkJVejE5S1hkTi9pNXB2OTNKQnpndVRrd0xWNVdhL0Rk?=
 =?utf-8?B?dWtSM0xFZWMvcGlMenE0WXVZd1BHcFdxTFIzNFNnWDlEYjJmMnhyczU4UVNl?=
 =?utf-8?B?Y1dtWHIrWTJuYi9HanJaRkJldS9mZFdBYXdiaHhzVTRJUDhYNW5mOTc1OFc4?=
 =?utf-8?B?WjU0MytxdG5DNU5GbHg2ZlhXMnVRZnB1bkZYc21yQ2FKVXhaZm8wV0NWVi9a?=
 =?utf-8?B?Zlp3NTA1VTA1bFJsUFk0OHdDUVc0MFRWMGRlb05uYzRqUm83NzJzczFnQmgz?=
 =?utf-8?B?MGlKaHJyYUxVY3BWbU1DY1p4d2tLNjJXL3FiWFBEd1NuYnRwakxGWm85VXND?=
 =?utf-8?B?QXh0OS9DUGVUMEVwa3piRm95ak5GQzlia2ltUWw0TVkxS1VZRU1lRUJ5SDl3?=
 =?utf-8?B?cmFqbGNpamNtZC9WWWlLSHVVMVZ5aitBWFBxZkJNOGNrZll5blhRM2JjM1da?=
 =?utf-8?B?elhSb2RtNFFhRHdqSENhWG5KU2N5N28yMkU5MUFlem43d3M4cVY1UlpSeEE4?=
 =?utf-8?B?dElFZkd3R1F4VDByZ3pFTXoyZk8rZ2puNXNPQnI2QUxUNnVOR1I4OEdoTGVl?=
 =?utf-8?Q?lG/FjNunHAQVAbNRQcp5Z/qYs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c189eec9-78a4-493d-9a64-08dcb58e04de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 20:34:35.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UFCu9qEwvVTQRD1dzDjwz5vC3H2oDftu9frJORqFDToPeXGRWNp48hKg7IIqOTSJ8wpFkg6MXG9ALQ+In/YhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuYWxkbyBDYXJ2YWxo
byBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDUsIDIw
MjQgMToyMCBQTQ0KPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+
IENjOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+OyBJYW4gUm9nZXJzDQo+IDxp
cm9nZXJzQGdvb2dsZS5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNl
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3Is
IFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50
aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjE4IDMvOF0gcGVyZiBzdGF0OiBGb3Jr
IGFuZCBsYXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJl
dGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gDQo+IE9uIE1vbiwgQXVnIDA1LCAy
MDI0IGF0IDA0OjQzOjA2UE0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiB3cm90
ZToNCj4gPiBPbiBNb24sIEF1ZyAwNSwgMjAyNCBhdCAwNDo0MDozN1BNIC0wMzAwLCBBcm5hbGRv
IENhcnZhbGhvIGRlIE1lbG8NCj4gd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEp1bCAyMCwgMjAyNCBh
dCAwMjoyMDo1NkFNIC0wNDAwLCB3ZWlsaW4ud2FuZ0BpbnRlbC5jb20gd3JvdGU6DQo+ID4gPiA+
IEZyb206IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiA+DQo+ID4g
PiA+IFdoZW4gcmV0aXJlX2xhdGVuY3kgdmFsdWUgaXMgdXNlZCBpbiBhIG1ldHJpYyBmb3JtdWxh
LCBldnNlbCB3b3VsZCBmb3JrIGENCj4gcGVyZg0KPiA+ID4gPiByZWNvcmQgcHJvY2VzcyB3aXRo
ICItZSIgYW5kICItVyIgb3B0aW9ucy4gUGVyZiByZWNvcmQgd2lsbCBjb2xsZWN0DQo+IHJlcXVp
cmVkDQo+ID4gPiA+IHJldGlyZV9sYXRlbmN5IHZhbHVlcyBpbiBwYXJhbGxlbCB3aGlsZSBwZXJm
IHN0YXQgaXMgY29sbGVjdGluZyBjb3VudGluZw0KPiB2YWx1ZXMuDQo+ID4gPiA+DQo+ID4gPiA+
IEF0IHRoZSBwb2ludCBvZiB0aW1lIHRoYXQgcGVyZiBzdGF0IHN0b3BzIGNvdW50aW5nLCBldnNl
bCB3b3VsZCBzdG9wIHBlcmYNCj4gcmVjb3JkDQo+ID4gPiA+IGJ5IHNlbmRpbmcgc2lndGVybSBz
aWduYWwgdG8gcGVyZiByZWNvcmQgcHJvY2Vzcy4gU2FtcGxlZCBkYXRhIHdpbGwgYmUNCj4gcHJv
Y2Vzcw0KPiA+ID4gPiB0byBnZXQgcmV0aXJlIGxhdGVuY3kgdmFsdWUuIEFub3RoZXIgdGhyZWFk
IGlzIHJlcXVpcmVkIHRvIHN5bmNocm9uaXplDQo+IGJldHdlZW4NCj4gPiA+ID4gcGVyZiBzdGF0
IGFuZCBwZXJmIHJlY29yZCB3aGVuIHdlIHBhc3MgZGF0YSB0aHJvdWdoIHBpcGUuDQo+ID4gPiA+
DQo+ID4gPiA+IFJldGlyZV9sYXRlbmN5IGV2c2VsIGlzIG5vdCBvcGVuZWQgZm9yIHBlcmYgc3Rh
dCBzbyB0aGF0IHRoZXJlIGlzIG5vIGNvdW50ZXINCj4gPiA+ID4gd2FzdGVkIG9uIGl0LiBUaGlz
IGNvbW1pdCBpbmNsdWRlcyBjb2RlIHN1Z2dlc3RlZCBieSBOYW1oeXVuZyB0bw0KPiBhZGp1c3Qg
cmVhZGluZw0KPiA+ID4gPiBzaXplIGZvciBncm91cHMgdGhhdCBpbmNsdWRlIHJldGlyZV9sYXRl
bmN5IGV2c2Vscy4NCj4gPiA+DQo+ID4gPiBGYWlsaW5nIGF0IHRoaXMgcG9pbnQ6DQo+ID4gPg0K
PiA+ID4g4qyiW2FjbWVAdG9vbGJveCBwZXJmLXRvb2xzLW5leHRdJCBnaXQgbG9nIC0tb25lbGlu
ZSAtNQ0KPiA+ID4gMTM0MzAxMzFhY2M0Zjg4YiAoSEVBRCkgcGVyZiBzdGF0OiBGb3JrIGFuZCBs
YXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJldGlyZSBs
YXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gPiA+IGI3YjlhZGVmYjVkNTdhYWYgcGVyZiBk
YXRhOiBBbGxvdyB0byB1c2UgZ2l2ZW4gZmQgaW4gZGF0YS0+ZmlsZS5mZA0KPiA+ID4gM2E0NDJi
ZjI2NmQxZjNjNyBwZXJmIHBhcnNlLWV2ZW50czogQWRkIGEgcmV0aXJlbWVudCBsYXRlbmN5IG1v
ZGlmaWVyDQo+ID4gPiBjZTUzM2M5YmM2ZGViMTI1IChwZXJmLXRvb2xzLW5leHQua29yZy90bXAu
cGVyZi10b29scy1uZXh0LA0KPiBhY21lLmtvcmcvdG1wLnBlcmYtdG9vbHMtbmV4dCkgcGVyZiBh
bm5vdGF0ZTogQWRkIC0tc2tpcC1lbXB0eSBvcHRpb24NCj4gPiA+IGJiNTg4ZTM4MjkwZmI3MjMg
cGVyZiBhbm5vdGF0ZTogU2V0IGFsLT5kYXRhX25yIHVzaW5nIHRoZSBub3Rlcy0+c3JjLQ0KPiA+
bnJfZXZlbnRzDQo+ID4gPiDirKJbYWNtZUB0b29sYm94IHBlcmYtdG9vbHMtbmV4dF0kDQo+ID4g
Pg0KPiA+ID4gSSdsbCBzZWUgaWYgd2hlbiBhIGZvbGxvd3VwIHBhdGNoIGdldHMgYXBwbGllZCB0
aGlzIGdldHMgc29sdmVkLCBpZiBzbw0KPiA+ID4gd2lsbCB0cnkgdG8gZml4dXAgdGhpbmdzIG9y
IGFzayBmb3IgaGVscCwgc2luY2UgdGhpcyBzZWVtcyB0byBiZQ0KPiA+ID4gYnJlYWtpbmcgJ2dp
dCBiaXNlY3QnIGZvciB0aGlzIGNvZGViYXNlLg0KPiA+DQo+ID4gSW5kZWVkLCB3aGVuIHRoZSBu
ZXh0IHBhdGNoIGdldHMgYXBwbGllZCBpdCBidWlsZHMgd2l0aG91dCBwcm9ibGVtcy4NCj4gPiBJ
LmUuIHBhdGNoICA0LzggZml4ZXMgcHJvYmxlbXMgaW4gcGF0Y2ggMy84LCBtYXliZSBqdXN0IGNv
bWJpbmUgdGhlbQ0KPiA+IGludG8gb25lIHNpbmdsZSBwYXRjaD8NCj4gDQo+IEkgaGF2ZSBldmVy
eXRoaW5nIGluIHRoZSB0bXAucGVyZi10b29scy1uZXh0IGJyYW5jaCBhdDoNCj4gDQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BlcmYvcGVyZi10b29s
cy1uZXh0LmdpdA0KPiANCj4gSSdsbCBjaGVjayBsYXRlciBvciB0b21vcnJvdyBpZiBJIGNhbiBm
aXh1cCB0aGUgYmlzZWN0aW9uIGJyZWFrYWdlDQo+IGRlc2NyaWJlZCBhYm92ZSBvciBpZiBqdXN0
IHNxYXNoaW5nIHRvZ2V0aGVyIDMvOCB3aXRoIDQvOCBpcyBiZXR0ZXIsDQo+IHBsZWFzZSBhZHZp
c2UuDQo+IA0KU3F1YXNoaW5nIDMvOCBhbmQgNC84IGxvb2tzIGdvb2QgdG8gbWUuIFdlIHdvdWxk
IHRoZW4gaGF2ZSBhbGwgdGhlIG1ham9yIGZ1bmN0aW9ucw0KaW4gb25lIHBhdGNoLg0KDQpUaGFu
a3MsDQpXZWlsaW4NCg0KPiBUaGVuIEknbGwgbW92ZSBpdCB0byB0aGUgcGVyZi10b29scy1uZXh0
IGJyYW5jaC4NCj4gDQo+IC0gQXJuYWxkbw0K
