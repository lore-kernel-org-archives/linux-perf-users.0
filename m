Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7123A260;
	Tue,  2 Jul 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894433; cv=fail; b=pLreso9W2GwyRQoVRyTJslH0l4snMg1A5pFxs6ZNLB2HbxVwsCft9XOtXzmbblAKzGFu8HuMG10xhV25LCw4ONuvaQSKPfmcO8wFn08SkX/ATvOvKC4SJpkUwOopMMHbYwx46LgMPr6NIaasr1RJNIPvCwmJkqf9Al79afsfVjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894433; c=relaxed/simple;
	bh=rBuzoxmHgIgzS9c6ug/tnngBMqmsM7KgmksJBfo5DTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKxbZ3l04pY3P7mnxu7O+jOHNtuJ+NyPOSme8g59qy/diw2woPFoa1xNGnf83ctg7d1lJUjm3+WRUYs1tkYwdff+DtMbpvVPrmURNV30cHLHWIA6eDiXPCsWlxIW+oudbVqbPr0Sn9qoIHCYc80pNi+6juKJhNYl9PtXAJdOxFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBIvHRJv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBIvHRJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719894432; x=1751430432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rBuzoxmHgIgzS9c6ug/tnngBMqmsM7KgmksJBfo5DTo=;
  b=bBIvHRJvDcwH5kAXyiil9lmAB7UQN/HNceeJHPBEOw6fD9bIHgBlaw0Q
   8HBj12fALX8V8YMtm3RvC6Vlzw04epgrEKCv4neeKb8wipn4P3xDv7PK+
   JMDOGjcYh7NZ5XI7ng2+ZjinuJd8jZEbttsPHGVnBuk6RHNi0FPqGsL4E
   vmCfK0wIeu2H7MfPidQPO6mnswk/qyioUhHPFCEI7YbI2xGyAbTS+wY1X
   79yOvpDrVx5/ot0hZsgiluEXR4fcRqtnB2/QTiXfrzcnhBLTSmWasYej4
   WZZZToPtyt27fBR1U+J8HBebNyq/ZV16uT9vmePaXVYgRJwRoaYFLYXyb
   A==;
X-CSE-ConnectionGUID: pP/l+wjoRMmmPAOTC5VXuw==
X-CSE-MsgGUID: vLlkSWeCQouVX8gnHYL7Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17264109"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17264109"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:27:11 -0700
X-CSE-ConnectionGUID: l2KzY4tjQj2S3uO8wojK2g==
X-CSE-MsgGUID: 4E4djqGPRd+wT91y3JWWiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76479474"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 21:27:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 21:27:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 21:27:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 21:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXZe0WScv2grvggP81MJG8qZNM9CDq6ajPO8k7DUl8m8aYXSpEedIjmoRqvy1LhkHfX8FGQpuQI49Sg3Z54JCSgO0n4gk9czeIeWusQK5pPTuliy2umMphmt35PpK0DXI2qL3sL5VFMGOONf16A0iKkigSweh3+dHfFBgWSZvFjcDjOHZKgeVTvKfL9hciQosUjf/rm4QeS9QXswXSJTbdjuvtl+3GHKVCfbayvR3eKRzt/KF5Q4YfyftuVBrNK9G1+a8HDGGeFcoaKycuE5tt5XVKxCIF9xt2VJ6FH89cLyO6VrEvqZ1C7AtVLHCm7Yr3Wo45Dp0s7rKJLKEAeXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBuzoxmHgIgzS9c6ug/tnngBMqmsM7KgmksJBfo5DTo=;
 b=IqmJgPkVudhTnXAk4eNS83tTXv2DhJ/rh+NaKZclTYkb12CTlswl1HzrSkXsuzMx3cpig0Gt4y/FXo5vULNNs8VnefzQ8EIt6MJJJmp7wZy2nEJQ1pJz0pcgroRtKZITDB/K/EVtqWlVSRfERM0ttYHlIWn1zWWi8tY0//6nD1HUYnvDnQgSbFFSMQmSPWYH9VobBy3KAQD8sakqW/H7rPYzm0QWRBu2cthD9GWSUsCJdqK01ivql+CMHADEpSXeXzkFW4BLaNi9LBULQoM4P67KSqX+8r2lP5fmEOuQg7CLEqAvuQ3JemeA16V/i5aB9eHJjON+IZXWZmMT0vqnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 04:27:08 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::8ee7:3d97:35d6:d1e7]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::8ee7:3d97:35d6:d1e7%7]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 04:27:08 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v14 0/8] TPEBS counting mode support
Thread-Topic: [RFC PATCH v14 0/8] TPEBS counting mode support
Thread-Index: AQHaxoTINfG478XFb02KWQ/J2kybpbHaV/8AgAAEcrCAAbjAgIADtR3AgAMYUGA=
Date: Tue, 2 Jul 2024 04:27:08 +0000
Message-ID: <DM8PR11MB56372A51C1D0D2EEDDA95E31EEDC2@DM8PR11MB5637.namprd11.prod.outlook.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
 <ZnxW4u_TB5agiFJT@google.com>
 <CO6PR11MB563505F0D97C0E2D5949F583EED62@CO6PR11MB5635.namprd11.prod.outlook.com>
 <Zn3MV8lCSHLEEXDG@google.com>
 <CO6PR11MB5635353A7B7A010FB727C5A5EED22@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635353A7B7A010FB727C5A5EED22@CO6PR11MB5635.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5637:EE_|CH0PR11MB8236:EE_
x-ms-office365-filtering-correlation-id: ed6750c8-3cb5-4ccc-dd1f-08dc9a4f3c29
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHcwbmt2bWFTS3JtWWJ0QjhYZGhKdWEwa04vUFhmMDQ1OG51V08wOVpaQmJi?=
 =?utf-8?B?SHdobDIvT2dRM3RLMy82ekhHa2N0VVVyS2wvOEdyWHIyTGFPbHJNcFZZK3FS?=
 =?utf-8?B?VHlNTDBZWUlWclpCaXBGbVFaOWRWSzZWb1Vmb2NPWTVET3MzYnFZUk84M1A1?=
 =?utf-8?B?R3o5a0s0bXk1YmpWb1hEaSsrMXVRcDhDdzQrelE1RFYveW9vYWFJMUtwUlll?=
 =?utf-8?B?NFJLbVRlNjhsa0RiemVNUkJnT1BRNThPenNab3paY3dkSGkrTEZybjdSV0JQ?=
 =?utf-8?B?L3htcFdpNW5TN0tVYk5VY25xSTllQlVXR2RScTVLdldJdlJya3pseU1EeVZD?=
 =?utf-8?B?ZjRKNGpDZTNMajludlFFK29zU2Z3dTI2VWxZczRzS2UrYmdvWCszNEJVRjFC?=
 =?utf-8?B?S3NDSGlGNHpXazlJL1dqMlp0Umw2SGk5YS96Y2Q4U3pKZ1VDcXdNRUlUK0FX?=
 =?utf-8?B?NFBvUVVtOG1DdnlRbTdzaTN4VDZEVzhCdE5vVEwxekViaUNiTVVXRkFPR2hT?=
 =?utf-8?B?SmUyMjNXTkhxVmxDOFl4Q25KNTkzWk52VXk5Vldzd016TWpHR2kzcG4zbCt5?=
 =?utf-8?B?WWZFM1Vac3l2UXpZb0krdWpYNlE4S2xDemdTaWpkbTg2WlV6QStVTUdzaytu?=
 =?utf-8?B?b1VKcG9nNnV1b09tNG9pUGhKaXNDWVhMci9YSjI5RklqdEZPRjc4emVQUWVu?=
 =?utf-8?B?czcrMzFTTStNd1V5K3ZldUNORkNjQnJVMmd4SGxBSlgybU5FY1U4UU8xamlF?=
 =?utf-8?B?QVZlWlRBWkh0dzRLNUkvdzBDcDVZZExNeXpnKzQ1cWNIbDM4NTE0a1o0V1VB?=
 =?utf-8?B?ZjhMclVOZUxsUXlkZU5aRjNUdk41VjN5TVRYNmhWeVp6TnFlSE1kZWpMaCtD?=
 =?utf-8?B?blVyWXZiQnp2TUxoNW10WnVJdEhjeUk2NklmdDJ0V055Uy9IcWNGck9VTzFl?=
 =?utf-8?B?TzdhUnVPWXJwQWJDdFQ3UkU1YVFmeG1XbFUrdEhSa2lrQmcvZU8reHlQWUky?=
 =?utf-8?B?akd0Wkh1Z1VZcElPWUhKZHRMZXRsUDBrUGJnYnArdXp1UnBxWWJEakpJZnFt?=
 =?utf-8?B?Q2dNUE5FLzRITUxaSjhYVmFESmVCbURsYnl2c0hKek40ek9QaG9VaEwxUFls?=
 =?utf-8?B?YjZ6M3ZvRlFGQWM1VHE4RXdhN0lZZVhDdHJUZE12MVgrS0RVcVRkQjRIaHVj?=
 =?utf-8?B?anR0UlNjR3IraG1TbVdiY25sYmQyMG5DQXROam5RMk1LUlFRbWxvZGdidEtx?=
 =?utf-8?B?ZmYwNUMwdndwOTZzU3JXVFNwYTF0QUNtUGhyZng3L2JGZjBpVThNM3BESU1C?=
 =?utf-8?B?QzNYTndVZWpyRXFzT2FhTnZrcGNTc0dqa0R0ZEpENW5iWG9XakFBYWhkVE96?=
 =?utf-8?B?QlBGYXBKNVVoUmp5MmFGdno3MXF5RVZBcThleERYcUpMbVE5aEU4bWQwUVN1?=
 =?utf-8?B?b0NZUEZEbFBGSDdQRjFKZ3h5bnFTdG1FQWxBOVlsdFRXbGZIak50K2VJK0RL?=
 =?utf-8?B?cGJUOFR3MFRwUW1IQXFXdno3K2txYVNtb2dhekpYS3V2U0ZDNnBsOVRPVXBr?=
 =?utf-8?B?UEdBcmwySS9IOHZBM21ZNWxuWHdlT2hYRnpGeUFrbHBlRDFqS0JqSXNsL1RW?=
 =?utf-8?B?OHIxVXlTMUwwZTZaUktZNVdPRkw1M1d6cGVhODFQb29aMUMvYThpMHZWaFV0?=
 =?utf-8?B?Q2FkaVFOZzhxWGtxMCt5ZUxLZjRUejFmZ2VxV2dQelNXdHg3RnNKM2c0RXJn?=
 =?utf-8?B?cEZ0ZFJTbDNIeDNDZmU2VUQwYmgzVEtaNEd3WHcva0MwOVJGTXB1ZkR4VmEz?=
 =?utf-8?Q?KjDlEygnz/GByEcSPN3NphwoEZd03PrX+AwQg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVVZTk1kQmZlOE5Ec1pNZ2U3cEtTeWs2RTlDQ3Mra2hkZDR5TW5PbXYyRVpX?=
 =?utf-8?B?RFF4eU96ejh2eGxxVStqNFhWZGl6NllQcmtYUE5yWGZ0ZjFJdGx3L2IzR3Fs?=
 =?utf-8?B?MktDZTVKUFVZYyt5ZlVPR1NqMnZqTzZlc1dsQnRMblphVElrQ2VadGVGNVFy?=
 =?utf-8?B?cTRwa1JpWTBPV1ZmeEhYWG1lQ2JHV0JzTU1CK2d0cmFLOTlUNnRodkV4L3JI?=
 =?utf-8?B?dGxIdWNyUWMwMTB5MytyV01Rd3dudFR6dldLWlJmL3BMZmw5RmozdDZWc3dh?=
 =?utf-8?B?YzJQelRUZnBaRFFNQnN1ZW5KY3FJd3VSbWpQV2RNNzNUTFE0VzNPZ0ZTeFB2?=
 =?utf-8?B?STVNaFc3QWY2VWpYQmNXTzVwSElpQlBJUksrUFdlZkNsTDVvcGhha2J5SkUz?=
 =?utf-8?B?Zi84cHBtRUs4Z01DTUpKUzZXZGsyYmtBOG1qRWJEWjBSd1MzL3dFUGhVbXFl?=
 =?utf-8?B?Vzd6ZFk0VW0xUnBiTzVwT1NOWisxQ1pwdzZjZElNNkRwY1AvZ3BkZERiUWts?=
 =?utf-8?B?VWo2bnN1YVRKRG5UUnQ4VFJsNHh0VE1VejBtVk1NQnVMWSthc3g5amJDNGdx?=
 =?utf-8?B?OWhXV0N0blBKcEdxOERMd0l0VDF2RWJFSUtmaTBqazBjZGVvNnUxUnJKdHpY?=
 =?utf-8?B?YjJlcXJreThUVmI1L3dyakRmeWRzYkZnQS9jVWV1cHVUZENqSHN3YTkzUHJr?=
 =?utf-8?B?bGtUYTZHZENyenBnM1ZUUTRXV0txeC9FUUhZenFiOTJ3djFROXd5ZlRZclFR?=
 =?utf-8?B?REtsWk1UYkpYdVBiM1NoWE5qMXJpcnRuZ0NHSWdDWm5vUnNRSnhHQmNkeUdG?=
 =?utf-8?B?SlROSVN5SzR5eDRwTktxMGExdUNJR0wxdEY4aFdPelVYRE51cE9YVThxKzFn?=
 =?utf-8?B?VjZuWEFaV1NUQjFPMXJvQW5MbVQxNkRXc0hUYklLVGJwZU5LNTdBMWZjVlBO?=
 =?utf-8?B?Uy8rRm5QL2tzYXpUMlovT0hYdTZjeFhuem5BRmJzRU5CdTNlaGF4QXJqeG9H?=
 =?utf-8?B?Q1FxQ2VxZGIzUFZvZno0djJuck8vZnZjODVlZHNuOGJvaXFkY0d1cEovWUpO?=
 =?utf-8?B?NkRZYU9jZ1Awemh2MkErY01MNXFlbHI2cGUxb1J2eDhjREQwbzZQdCsvUnlR?=
 =?utf-8?B?YzlCdm0xbzdRQkNtUXdEUDEydlZYbmtLaFVCV05KMCtJZU8zejB3dUZvK01L?=
 =?utf-8?B?TytaVUpPZm9BVFpSQjdnNlpwT2JFQkJZNVJxaGdSdDU5N2Y2bGZRYTVRVVpI?=
 =?utf-8?B?cGw5SWpGMmEwTTRheFJjM1NjZ1AwOWkrbkI2TDBkdmZ0cks1YmlvMThGNmV3?=
 =?utf-8?B?eTBjampVTjIwZUo5VlpuUWpUYlNsNkh6VFBOV2dhdzEwaHpZcTRHVm4raFBz?=
 =?utf-8?B?V3ZUWG5nYmxsSG93UGJkUEJ3NklVNzFEbXFwL3VWTDBONzBFaVV2K3dySURI?=
 =?utf-8?B?dVVJV1NkMStrVU9qcmRJYWVZLzdtQWMvd0FoVTZGZGRqRDNMTUdqbXo4NVhj?=
 =?utf-8?B?Z09GZTh6V3cvUFhZcVNCeVZaN0tLR21BRjhFZm9QcVRkMkpRYVh4clZtaWdz?=
 =?utf-8?B?NkJScGxjQUJQSkdaQm5WUE16ZzM2MGJ6cWJoR1pNTnJSVStySEdxemNwcHFp?=
 =?utf-8?B?VnhPNXlYN081WHBXSWpya1A1MklGRG4wbGFrUmw1cm8wUThkUTE1M0JEZzBm?=
 =?utf-8?B?Yit6OTZoL2lHdFp6S2FxelVqNzBwZStYNnVOMUFzUlBwZmpsSWRFOUhFQ3RJ?=
 =?utf-8?B?Q00yTEsvallmdW5ERjBYZk9OSnhNanV4cmd0MDhtWG43dFJpQ1RsVVBjU0pi?=
 =?utf-8?B?OTZ5dVIrdy9lNG5HV2o4WUNEa25Bb3hZS2lJTmFmTHUrQ2JKaWIzRnkweTVD?=
 =?utf-8?B?ODVsOTJoNVpkYkhmRy8yaEFnOEpYWk83NzRXVlJuOEQ4MUVHS0FpVXNCeW9Y?=
 =?utf-8?B?N0lnME1NTHlSWjhzOTg1M2RBdlhlWEpxWnJ3MFVPOUlPMkpJaDBDcHNQcENp?=
 =?utf-8?B?YzZVSk5iNFBMSTRFODFIc3poM2NnYlVqNjBhcmEwK01wZWtLV1lGRmprQmRG?=
 =?utf-8?B?U2xJOGJSbURnemZFTkVMT3FvYUdWQUpwaVlsbHIwdjdOMUNjSS9lZGtiUUpS?=
 =?utf-8?Q?CYiqZO9EnPzetgvgTNTUeysPt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6750c8-3cb5-4ccc-dd1f-08dc9a4f3c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 04:27:08.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ox4NU8mJ+hACtKMv/Ua7AUoZ0/xtZDjnTUhGRALlEjY2CMN6DXqOK0NrkUngYnUWiP6nq+gjog/lAZh/tWMyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2FuZywgV2VpbGluDQo+
IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDI5LCAyMDI0IDEwOjEzIFBNDQo+IFRvOiBOYW1oeXVuZyBL
aW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQo+IENjOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2ds
ZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gPGFjbWVAa2VybmVsLm9yZz47IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFyDQo+IDxtaW5n
b0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+IDxhbGV4YW5kZXIuc2hpc2hraW5A
bGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgSHVudGVyLA0K
PiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgS2FuIExpYW5nIDxrYW4ubGlhbmdA
bGludXguaW50ZWwuY29tPjsNCj4gbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwgUGVycnkNCj4gPHBlcnJ5LnRheWxv
ckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29tPjsgQmln
Z2VycywNCj4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTog
W1JGQyBQQVRDSCB2MTQgMC84XSBUUEVCUyBjb3VudGluZyBtb2RlIHN1cHBvcnQNCj4gDQo+IA0K
PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IE5hbWh5dW5nIEtp
bSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyNywgMjAy
NCAxOjMyIFBNDQo+ID4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0K
PiA+IENjOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhv
IGRlIE1lbG8NCj4gPiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXINCj4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhh
bmRlciBTaGlzaGtpbg0KPiA+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsg
SmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgSHVudGVyLA0KPiA+IEFkcmlhbiA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+
Ow0KPiA+IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBUYXlsb3IsIFBlcnJ5DQo+ID4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+
OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29tPjsNCj4gQmlnZ2VycywNCj4g
PiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggdjE0IDAvOF0gVFBFQlMgY291bnRpbmcgbW9kZSBzdXBwb3J0DQo+ID4NCj4gPiBPbiBX
ZWQsIEp1biAyNiwgMjAyNCBhdCAwNjoxNzoyMlBNICswMDAwLCBXYW5nLCBXZWlsaW4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiA+ID4gPiBTZW50
OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIwMjQgMTA6NTkgQU0NCj4gPiA+ID4gVG86IFdhbmcsIFdl
aWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+ID4gPiA+IDxhY21l
QGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdv
IE1vbG5hcg0KPiA+ID4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA+ID4gPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8
am9sc2FAa2VybmVsLm9yZz47DQo+IEh1bnRlciwNCj4gPiA+ID4gQWRyaWFuIDxhZHJpYW4uaHVu
dGVyQGludGVsLmNvbT47IEthbiBMaWFuZw0KPiA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47
DQo+ID4gPiA+IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBUYXlsb3IsDQo+ID4gUGVycnkNCj4gPiA+ID4gPHBlcnJ5LnRheWxv
ckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29tPjsNCj4g
PiBCaWdnZXJzLA0KPiA+ID4gPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5jb20+DQo+ID4g
PiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxNCAwLzhdIFRQRUJTIGNvdW50aW5nIG1vZGUg
c3VwcG9ydA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBNb24sIEp1biAyNCwgMjAyNCBhdCAwNjoyMDox
NlBNIC0wNDAwLCB3ZWlsaW4ud2FuZ0BpbnRlbC5jb20NCj4gPiB3cm90ZToNCj4gPiA+ID4gPiBG
cm9tOiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gQ2hhbmdlcyBpbiB2MTQ6DQo+ID4gPiA+ID4gIC0gRml4IHRoZSBweXRob24gaW1wb3J0
IHRlc3QgZmFpbHVyZS4gV2UgY2Fubm90IHN1cHBvcnQgUFlUSE9OX1BFUkYNCj4gPiA+ID4gYmVj
YXVzZSBpdA0KPiA+ID4gPiA+ICB3aWxsIHRyaWdnZXIgYSBjaGFpbiBvZiBkZXBlbmRlbmN5IGlz
c3VlcyBpZiB3ZSBhZGQgaW50ZWwtdHBlYnMuYyB0byBpdC4NCj4gU28sDQo+ID4gPiA+ID4gIG9u
bHkgZW5hYmxlIHRwZWJzIGZ1bmN0aW9ucyBpbiBldnNlbCBhbmQgZXZsaXN0IHdoZW4gUFlUSE9O
X1BFUkYgaXMNCj4gbm90DQo+ID4gPiA+ID4gIGRlZmluZWQuDQo+ID4gPiA+DQo+ID4gPiA+IEkg
dGhpbmsgaXQncyBlYXNpZXIgaWYgd2UgaGF2ZSBJYW4ncyBweXRob24gYnVpbGQgY2xlYW51cCBm
aXJzdC4NCj4gPiA+ID4NCj4gPiA+ID4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1w
ZXJmLXVzZXJzLzIwMjQwNjI1MjE0MTE3Ljk1Mzc3Ny0xLQ0KPiA+ID4gPiBpcm9nZXJzQGdvb2ds
ZS5jb20NCj4gPiA+ID4NCj4gPiA+ID4gTGV0IG1lIHRha2UgYSBsb29rIGF0IGl0Li4NCj4gPiA+
DQo+ID4gPiBPaywgSSB3aWxsIGhvbGQgdGhlIGNtZCBvcHRpb24gbmFtZSB1cGRhdGUgdW50aWwg
d2UgY29uY2x1ZGUgb24gdGhpcyBvbmUuDQo+ID4gPiBUaGFua3MgYSBsb3QhDQo+ID4NCj4gPiBQ
bGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIGN1cnJlbnQgcGVyZi10b29scy1uZXh0IGJyYW5jaC4N
Cj4gDQo+IEhpIE5hbWh5dW5nLA0KPiANCj4gVGhlIHB5dGhvbiBpbXBvcnQgdGVzdCB3b3JrcyBj
b3JyZWN0bHkgd2l0aCB0aGUgbGF0ZXN0IHBlcmYtdG9vbHMtbmV4dCBicmFuY2gNCj4gd2l0aG91
dCB0aGUgY2hhbmdlIEkgYWRkZWQgaW4gdjE0LiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHRo
YXQgcmV2ZXJ0cyB0aGlzDQo+IGNoYW5nZSBhbmQgdXBkYXRlIHRoZSBjb21tYW5kIGxpbmUgb3B0
aW9uLiBJcyB0aGVyZSBhbnkgb3RoZXIgY2hhbmdlcw0KPiB5b3UnZA0KPiBsaWtlIG1lIHRvIGFk
ZD8NCg0KSGkgTmFtaHl1bmcsDQoNCkknbSBwbGFubmluZyB0byBzdWJtaXQgdGhlIG5ldyB2ZXJz
aW9uIGJlZm9yZSBXZWRuZXNkYXkuIFBsZWFzZSBsZXQgbWUga25vdyBpZg0KeW91IGhhdmUgYW55
IG5ldyBjb21tZW50IG9uIHRoaXMuDQoNClRoYW5rcywNCldlaWxpbg0KDQo+IA0KPiBUaGFua3Ms
DQo+IFdlaWxpbg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBOYW1oeXVuZw0KPiA+DQoNCg==
