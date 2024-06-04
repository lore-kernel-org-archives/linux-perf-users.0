Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D34A11;
	Tue,  4 Jun 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531234; cv=fail; b=DShP/7xtN+zgfYez19buZ3UZ9D/+0swHCrcyYeK2xHN40hdnFpMbx2MB6n7fdEibUrP43zaZdJdaYaJo7JwiabejCZBfEm5aKvo7b+PF0R8pTEdSqpXTnNlQSav6kjYsLgUfIRN/g4kguU5zD2k8qTOZDKtujl993amKWZr5Q/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531234; c=relaxed/simple;
	bh=WYBHFMXT6zympAqchz3IxNflDQLgjt4uLAXS+SgnwbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h02CsgwvULZ0Q7BM4wJfAsQIkJAH+bHqB6gfsKb4hQeZ69ucmF3CfwEfMkgFMIDmcHsVO/3brJUzAPBpPOmYHqz0K96hMSM6yfgyOOTyeMkDAzCpFZNh+b48gu7A6QA1e6pVp+kQdNUvDoT9ZdBpRnWQiM19De1ytb38ji41p9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=draS+UEX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="draS+UEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717531230; x=1749067230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WYBHFMXT6zympAqchz3IxNflDQLgjt4uLAXS+SgnwbA=;
  b=draS+UEXeHukxdpcVhUNFf65+UXbbWNlrwXOgmkrGpkmmfREsHT9o6Vk
   Rp9D87tbta5rPHJxtQ5HSvgkmSCjkBPHJQMmK52yHr3e/d6EcerbwF/RR
   8/WaAX1WQ558rmPXtpYXBCwkwfRcIgO0fOKLns9/pnlUQgH3w3785FsIy
   6hnXquvV3gWd05uFuTiZKrjfWHGinQD4V94xNskcEZA2FnXYX7pVFiS7A
   uNEszVKbfc9YegokNyqqpGcyTS/H6OP66Ulxku1nvaopHaPRsDjVmFVGJ
   3cUxrnJoMhi59qNARMPYRkPCrepAgOlpbME9kmZDFts1Y9F/HvZtJvrd9
   A==;
X-CSE-ConnectionGUID: MyzmMnJETOmV93fuDs4Vgg==
X-CSE-MsgGUID: xiApLFKaTsa+Ric2An7ucw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17949849"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="17949849"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 13:00:30 -0700
X-CSE-ConnectionGUID: x8o1bPU7Tbef/DOz0XXn+A==
X-CSE-MsgGUID: Dx53J0YcR7qdL8rwVx5WhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37999285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 13:00:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 13:00:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 13:00:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 13:00:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 13:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu/VHsHBQtLQS/64OaFDhdiyV+4mgRQRz0C92T1SgJTEbYW65dXDOJkaSDUZ7VnjiAWAZ5FsWRzAKME+n5OaXwX2kzRAyGjltxof6LfVZ8e3ZVSUIsMp7PpwOA2y6jQH3ZV4k85D2kmK8IKkrI1pCTGkw9g/JiXwqWMRjZadWt8zR2/AHPOiGtt3usKjd7xXMgaM3fTd9H4i+Apgw9XXGBg77R/v6XLo5LghNtxLQoUvT8fZ1dq/OR68qDxUK/3ddfaHhFTkqtt70uu9waIZc+mKNWljEgggQviefrlaFLGwhEUspvP+zvZEmTAIGaGTSPC92dUHQw7g6Fecbot9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYBHFMXT6zympAqchz3IxNflDQLgjt4uLAXS+SgnwbA=;
 b=b2E1qN0NfW94pw+gIQJ3sBcjAhAA6miSEZzD7gBzQxUqk98w2M9aNMOz4JOP5lA2eqHmph/h3L223wXFQInJ4Tu4tjfP12o++IcXN035pLuOmI+MvqqYyWBPt54M0cqZDtJ4F0mBRYyZjoyeqSvBGB93xa5HzVGWeWSIF0ucHrme46aIT+HsCqWjLArboP5K2h31BhQpt1jevs+0Jc4hJKOAaExqHXUuNXVRt7YQFWtL5Y9Kgoajd4ejn60GjCqDgiQ0vxRUBjBEGYG1CYryZIPdKS8j2RVzkWxkEmbyIyMFzEkuEJe3CMhD3nnetDBE5BfDoJAhW5pOhnpgwRWn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 20:00:26 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:00:26 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHasZOLBmxpfW94l0mGq/Yp4ybyB7Gw59CAgAAAZpCAAPrEAIAGC9kQ
Date: Tue, 4 Jun 2024 20:00:26 +0000
Message-ID: <CO6PR11MB563511F1A6165F0F4B30C4DFEEF82@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com>
 <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
 <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SN7PR11MB7020:EE_
x-ms-office365-filtering-correlation-id: 632578ed-8f04-4665-f393-08dc84d0f9fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VittbGwxa3p2WEZ3QXcxVlhVUVdwenJ6eHZreWJ2YXQxZEJTS1p2NEpMaGRK?=
 =?utf-8?B?VmdYMDEvTHdKTXVTYUxaOXRZVEVTMFRITTYzOTdEU0xtMisxNzZtNCtDREw4?=
 =?utf-8?B?ZE9MaXUwTW1GWFY0ZzNxL3FVUTVyNkR1ckFrYjNyVkx2L3dHQVhkQ2M3VFlF?=
 =?utf-8?B?T01OclFncEhXS0RjSUp6UVcvVFBQV3daOXhIRit4RzRQV0kxWXE4RzlyOGx1?=
 =?utf-8?B?NGt6TzJrYlpGWmZINzRiTWMwdnlOS0pjN2d3T1dYL3FVWnlKZUd4UHpiMWR1?=
 =?utf-8?B?MVlHZUFaYjVEcmg0UHhPTzN3UjdBM1ZiT3VjMHB3N1RJT25IbjhmcFdHVjdL?=
 =?utf-8?B?Y0hmUVBTbjlpenlMMmtjVXV5RDF5RFplWGlUZ1BCa2RXUHNRVjM4MXRqV1pO?=
 =?utf-8?B?aTVPdlozeU9FVGJ2Z1c5eERrN0dhdFBHVWt3THlLcU9sK2RMcnRldjJMZkhQ?=
 =?utf-8?B?VHlDRlQ3Yk8xRHFldzNBWElmeHpxWE9pZEdxd29XM1hWUWQ3RitnRm9QRjh1?=
 =?utf-8?B?UlJUaTFQS3BKOEovYUczdE83dGRVTFMyR3UvZlNlbUpGRDRCNW0zbjNKeUN5?=
 =?utf-8?B?Y3EyYmpPTGFVU3FlZHZyS2dUVGppb0JQMTQ5Q1JSOWQ1ZmdCTkYvZ0tRNnh6?=
 =?utf-8?B?N211TStrUXBBRGZhTU53cUppMnZCa0dMMU90MmRqbnZqU3NxM2hndTl5Yjhz?=
 =?utf-8?B?czgxb2hWS3dEUytSWElKK1d4cmRldG5uUVVXKzhWaXFSaEdZRHd1cjBsMnJE?=
 =?utf-8?B?R01BUFVvbDVvSllEUlp4VWZoUGNib281ZjVWMTBObXl1RDEzWWRYUnpEU1pN?=
 =?utf-8?B?U1ZLekZicnNGMEFGc3ZFeG53enNkL3RQSVhya1VZMDNxaFAyWDFuSzdmWWl0?=
 =?utf-8?B?dHdFRVhBdHhiSlNhZk5BVFM1TVhEMVF5a0xVcXVqYm43cjBlbjlXczh4RTEx?=
 =?utf-8?B?aUU1UjBGNDMyMHVaNFZxSlo1QmhlQ3RFcmNtOXRTSUcyRkVqNm5HeEMvWjF3?=
 =?utf-8?B?NHhKaHdReC9ONWJsU2MwblIwdy9kdXUwYnFlTmdMb1c4WlhJWmczdGlyVVMy?=
 =?utf-8?B?aG9iVlBqQlorUnJ0UVNXYlpHRW1CdkJCdUE3TU0wemJ1cDVPUlVXRjVNV0Vs?=
 =?utf-8?B?OStjNDFPeWxIbFlDcWUrdy9vTGVGdVdJV0NXTXc5cncvYWREa2xOZTRrejFz?=
 =?utf-8?B?cmM4R1huTm1NTkdMeHAvckpmT1I5OVRVQmhJaFplTDdWUi9jN1NKZ2NPQWlq?=
 =?utf-8?B?UzBLeWNZUjNFTGNEd0YvQ2xmdFdoNlNkRDdEblNIQXhmRitpVXFRZk5RMlJG?=
 =?utf-8?B?TXpXVkh2UU5uekE1K1F5bHNjZlE2dUFTcnRNTmpMeU5kMTVFU2MrTWxLaFVG?=
 =?utf-8?B?ZDhMYnpCYWx1R3FRUmUvVzBLS2EvQ3hvM2t6KytlRXVPZURpN3FlR2FRc3Zj?=
 =?utf-8?B?U21zWlZjVktJTFRrMzFiZE9FaXMzbVIwNUJqR1pPb1B5emErMTVtUG9MeG14?=
 =?utf-8?B?NUVkRU5TcmRueHduanBWaithSzNpRmh0UE1KRjJwQ3paZXBNcXpwSGkyYzlG?=
 =?utf-8?B?ZnYyMlRza2VjN09HdG9MQTRpR29Qcm85Y3JMK3NWQVRKQkdOZ0xnb2pER2Fo?=
 =?utf-8?B?Zkl2ODdXTHpjaENvREdUcm10UHRwMmhMMGdyK01JbjNmUTluR0FCR3MwYlVi?=
 =?utf-8?B?Vm0rRFRKUDFEMzg0ZS90c05sNkpJQjg0TTk2aUdEL2M1bHhKM3NQMS9ZaFov?=
 =?utf-8?B?YzJoMmYzVk5GRjFkSXhJVGdTbzIyc3NwSWxqaEZ1Z3lpVi9ubHRJNHhzM1U2?=
 =?utf-8?B?Z1lnd2p3VUgwbHY4VElrQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5sblBsZXI1QmFTRXMzZXdBc2ZZMCtxdXR6ZGJSNnl0bDdjZHp0WEJ3cThF?=
 =?utf-8?B?cUJUSmxDWndlbFhGMFpuY3hKY2x6WlBXNjA2VjBLSVpvQU1hUlp5WDZlK0N5?=
 =?utf-8?B?aWdWcU5DMEN4YzMreTkyVk80ckpiZVhsRG9IWDFrcEpSMktNTGtrMThqZU83?=
 =?utf-8?B?SFI3OE56ZFVBWHhlQ1UyVGVBN2NkOWpvK0JKUFBjRzB2K1ZjTmdKczNzUXQ1?=
 =?utf-8?B?SzlDNFBOQksrSnNFN24xV2JjU3pvaytHbGtsLyttZDMwTE1rOTR3TjdGWjd3?=
 =?utf-8?B?Y1JwVEtGcmpZZVN5Smx6T05jOEUxY0h2TDExZFEvUU0rRXhFbVRodXd3cFVH?=
 =?utf-8?B?RS8wM1cvTHE0ckw1bUp2ZzBXWXRiL3d0L2Q3dlJaY3lEVTZUY1I0WFM4S1NE?=
 =?utf-8?B?ay92TjdrQzhvUEljR1hFN21uM2hrZVJzN1AzM25jcHpJaFA3UWpONXQrc2M1?=
 =?utf-8?B?bjdXSzQ1YzhpUzA2VE5BaS8yWkE4dTlVckVJR2tXWVh2MXJSUmg4dGdEWS9Z?=
 =?utf-8?B?TUpLZ2dmaU1OWmZEblZhcmp0QmdydlJidEtmUmpzUit1dE5uVi9OWGVoYW5G?=
 =?utf-8?B?NHNCL2owQkZESzRHQk5hWVdZVmkzcEx3TC9BUlUrWE93SmZiL2x0NU9EQXNJ?=
 =?utf-8?B?QmQwdzk4amtWZFoydkdVSWJSYjFnbGJEZCtuejEyT3hCd2J4WnVYRVdOS2RB?=
 =?utf-8?B?UHZwb2lGTG0vUUk2NUhiaVdSMThKU3RXTHFqcWVvQnA5NVZsdHJhdENybjdv?=
 =?utf-8?B?eTkxNC9Pb0MyY1IvdmIyaWx1RndtckdoZjMxNGIrVTNpQkxZWUowOEtDRkVU?=
 =?utf-8?B?NWd0ZENYU000bzJTTEs2WWFMcDhRQkZ1dFhtVm55YjVNS085SitPK09naWxn?=
 =?utf-8?B?YjBISU1zVXZBRnhLTTE5OWxhcldQUFcwWHBzeFlDUEs4MXdRYnIzYnYxSEcy?=
 =?utf-8?B?dzAyMDQvWkptTVlOVHF0U1U4MUVjejhDcDl5TVl0UTd1OHRCaDFGUG5GSmFx?=
 =?utf-8?B?V0tQR2JNeFRXY1dEM05udSswZ2h0d284WHpSRGhxcnpXR2QxYWhNMzljZTd5?=
 =?utf-8?B?SzIxKys4Vi82U0x2UVZVNUNTVWZIU0lwWURRQUVGam5JNXRKZWQrUjlTSG0x?=
 =?utf-8?B?MEptVXVJUUhFTXEyZjJsdWpycjd2dm5KTmtoZGlRMGJTOFBPeUUwc3AwaGh1?=
 =?utf-8?B?SGJTWVdmMlNqRGplcjdCRkdDZEN5V2VUUUhqSm53aGxubEw3NWZVYWdUcmox?=
 =?utf-8?B?bkFOTUZQdXREY3NTdlVVYVI3aW9oeHltZk0xUGM1Rks3aTZUVkV5UUpjTHRX?=
 =?utf-8?B?SDdKTnRVeEt4VDZRRDZrN0JCT1pkNjlHWG1iSEhhVUtja250MFVQbHVDa3M1?=
 =?utf-8?B?S1VKU0RiRXFpZkE0VCt2bW44VjlBOHFGUytkR2piejZBZVNtNTIzZE1SZ1gz?=
 =?utf-8?B?OHVuR2Z4REJHUFBnK0xjdEpEdkpENFBJdGl3bk8vWjRFeTBPVDUvNCt2MlVz?=
 =?utf-8?B?OUt4THZwOWRnaFlTYTB1Ry9BNGkzYThuV2kyWFBlYXpCMmVSR1dWdXc0L3dP?=
 =?utf-8?B?OFhTT2FkUVEzTWU2MXBTNm9PWGVjc2o0dlJZZXJPTXBVbFpzZ1ZMdVFoa1F3?=
 =?utf-8?B?MVlTODIrRHlTcEhtRENCalJYNkxxN2ovRDlzZWdrYzg4cE83TlVXNWJQWjFY?=
 =?utf-8?B?QXc5QjZzL2FEOVg2WlBLOUk5Wkhaam5yY2tQTmdVMFNWMmNvcjVaZklQaDYx?=
 =?utf-8?B?UVlaWVA2b0JPQzJSei9LRkN3OU9mZS9ySkowWE9jMU9haUcxNllVVytObVJE?=
 =?utf-8?B?Y2tSbGpGNGdYWTRUSHVQMENEbW5TckVWc0hvZWxyalJBTmJFTW9ZaERjRHF2?=
 =?utf-8?B?d0JYTjZoOWJiWFNqeXpZZHdQTUxXODNvaFNnVk1mWVhpRGlXN0RFUjZ2bUhr?=
 =?utf-8?B?RHJEUmNnMm5xelNxWXl1RFB0M3BhU1VSWG9XZ2RsblFmMVJiYVBoSnVYMG5E?=
 =?utf-8?B?ci83VHhZN0ZmNnBFTS8rRWtkUk93UkxKVkVwVUtkZTR0ZkJUYktlbVgxMHVW?=
 =?utf-8?B?NWhybEFtTkk4cUd0Q1RzOTFNWGlzckpoYk5ka2dzcTRSellpSFk2aC9sQUt0?=
 =?utf-8?Q?qO7Mnim2px7llApoJ1pLqISQ3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 632578ed-8f04-4665-f393-08dc84d0f9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 20:00:26.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7B0F+I6PeHET46ZWrfdJvKLred/VYrYwIzYQ18wELIxer0UGx/TREXZw+90Qha22ki7boScOVfbAJLd8n9JaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAzMSwgMjAyNCAyOjQwIFBN
DQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElhbiBS
b2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8
YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
SW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4g
PGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtl
cm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLCBQ
ZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFudGhh
LmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxMCAzLzhdIHBlcmYgc3RhdDogRm9yayBh
bmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdoZW4NCj4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCByZXRp
cmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBtZXRyaWMuDQo+IA0KPiBPbiBUaHUsIE1heSAzMCwgMjAy
NCBhdCAxMTo0NuKAr1BNIFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50
OiBUaHVyc2RheSwgTWF5IDMwLCAyMDI0IDExOjQxIFBNDQo+ID4gPiBUbzogV2FuZywgV2VpbGlu
IDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiBDYzogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bn
b29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+ID4gPiA8YWNtZUBrZXJuZWwu
b3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXIN
Cj4gPiA+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+ID4gPiA8YWxl
eGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2VybmVs
Lm9yZz47IEh1bnRlciwNCj4gPiA+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiA+ID4gbGludXgtcGVyZi11
c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxv
ciwNCj4gUGVycnkNCj4gPiA+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRo
YSA8c2FtYW50aGEuYWx0QGludGVsLmNvbT47DQo+IEJpZ2dlcnMsDQo+ID4gPiBDYWxlYiA8Y2Fs
ZWIuYmlnZ2Vyc0BpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MTAg
My84XSBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJlY29yZA0KPiB3aGVuDQo+ID4g
PiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJldGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJp
Yy4NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE1heSAyOCwgMjAyNCBhdCAxMTo0M+KAr1BNIDx3ZWls
aW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBXZWlsaW4g
V2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBXaGVuIHJldGly
ZV9sYXRlbmN5IHZhbHVlIGlzIHVzZWQgaW4gYSBtZXRyaWMgZm9ybXVsYSwgZXZzZWwgd291bGQg
Zm9yayBhDQo+IHBlcmYNCj4gPiA+ID4gcmVjb3JkIHByb2Nlc3Mgd2l0aCAiLWUiIGFuZCAiLVci
IG9wdGlvbnMuIFBlcmYgcmVjb3JkIHdpbGwgY29sbGVjdA0KPiByZXF1aXJlZA0KPiA+ID4gPiBy
ZXRpcmVfbGF0ZW5jeSB2YWx1ZXMgaW4gcGFyYWxsZWwgd2hpbGUgcGVyZiBzdGF0IGlzIGNvbGxl
Y3RpbmcgY291bnRpbmcNCj4gdmFsdWVzLg0KPiA+ID4gPg0KPiA+ID4gPiBBdCB0aGUgcG9pbnQg
b2YgdGltZSB0aGF0IHBlcmYgc3RhdCBzdG9wcyBjb3VudGluZywgZXZzZWwgd291bGQgc3RvcCBw
ZXJmDQo+ID4gPiByZWNvcmQNCj4gPiA+ID4gYnkgc2VuZGluZyBzaWd0ZXJtIHNpZ25hbCB0byBw
ZXJmIHJlY29yZCBwcm9jZXNzLiBTYW1wbGVkIGRhdGEgd2lsbCBiZQ0KPiA+ID4gcHJvY2Vzcw0K
PiA+ID4gPiB0byBnZXQgcmV0aXJlIGxhdGVuY3kgdmFsdWUuDQo+ID4gPiA+DQo+ID4gPiA+IEFu
b3RoZXIgdGhyZWFkIGlzIHJlcXVpcmVkIHRvIHN5bmNocm9uaXplIGJldHdlZW4gcGVyZiBzdGF0
IGFuZCBwZXJmDQo+IHJlY29yZA0KPiA+ID4gPiB3aGVuIHdlIHBhc3MgZGF0YSB0aHJvdWdoIHBp
cGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4u
d2FuZ0BpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gW1NOSVBdDQo+ID4gPiA+ICtpbnQg
dHBlYnNfc2V0X2V2c2VsKHN0cnVjdCBldnNlbCAqZXZzZWwsIGludCBjcHVfbWFwX2lkeCwgaW50
IHRocmVhZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGVyZl9jb3VudHNf
dmFsdWVzICpjb3VudDsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgdHBlYnNfcmV0aXJlX2xhdCAq
dDsNCj4gPiA+ID4gKyAgICAgICBib29sIGZvdW5kID0gZmFsc2U7DQo+ID4gPiA+ICsgICAgICAg
X191NjQgdmFsOw0KPiA+ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgICAvKiBOb24gcmVpdHJlX2xhdGVuY3kgZXZzZWwgc2hvdWxkIG5ldmVyIGVudGVyIHRo
aXMgZnVuY3Rpb24uICovDQo+ID4gPiA+ICsgICAgICAgaWYgKCFldnNlbF9faXNfcmV0aXJlX2xh
dChldnNlbCkpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICByZXQgPSB0cGVic19zdG9wKCk7DQo+ID4gPiA+ICsgICAgICAgaWYg
KHJldCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICBjb3VudCA9IHBlcmZfY291bnRzKGV2c2VsLT5jb3VudHMsIGNwdV9tYXBf
aWR4LCB0aHJlYWQpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeSh0LCAmdHBlYnNfcmVzdWx0cywgbmQpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlm
ICghc3RyY21wKHQtPnRwZWJzX25hbWUsIGV2c2VsLT5uYW1lKSB8fCAhc3RyY21wKHQtDQo+ID4g
PiA+dHBlYnNfbmFtZSwgZXZzZWwtPm1ldHJpY19pZCkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZm91bmQgPSB0cnVlOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gKyAgICAgICB9DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAvKiBTZXQgZW5hIGFuZCBydW4gdG8gbm9uLXplcm8g
Ki8NCj4gPiA+ID4gKyAgICAgICBjb3VudC0+ZW5hID0gY291bnQtPnJ1biA9IDE7DQo+ID4gPiA+
ICsgICAgICAgY291bnQtPmxvc3QgPSAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYg
KCFmb3VuZCkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgLyoNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAqIFNldCBkZWZhdWx0IHZhbHVlIG9yIDAgd2hlbiByZXRpcmVfbGF0ZW5jeSBmb3Ig
dGhpcyBldmVudCBpcw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICogbm90IGZvdW5kIGZyb20g
c2FtcGxpbmcgZGF0YSAoZW5hYmxlX3RwZWJzX3JlY29yZGluZyBub3QNCj4gc2V0DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgKiBvciAwIHNhbXBsZSByZWNvcmRlZCkuDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHZhbCA9IDA7DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiArICAgICAgICAqIE9ubHkgc2V0IHJldGlyZV9s
YXRlbmN5IHZhbHVlIHRvIHRoZSBmaXJzdCBDUFUgYW5kIHRocmVhZC4NCj4gPiA+ID4gKyAgICAg
ICAgKi8NCj4gPiA+ID4gKyAgICAgICBpZiAoY3B1X21hcF9pZHggPT0gMCAmJiB0aHJlYWQgPT0g
MCkgew0KPiA+ID4gPiArICAgICAgIC8qIExvc3QgcHJlY2lzaW9uIHdoZW4gY2FzdGluZyBmcm9t
IGRvdWJsZSB0byBfX3U2NC4gQW55DQo+ID4gPiBpbXByb3ZlbWVudD8gKi8NCj4gPiA+DQo+ID4g
PiBBcyBJIHNhaWQgYmVmb3JlIEkgdGhpbmsgeW91IGNhbiBzZXQgdC0+dmFsICogMTAwMCBhbmQg
dGhlbg0KPiA+ID4gc2V0IHRoZSBldnNlbC0+c2NhbGUgdG8gMWUzIG9yIDFlLTMuDQo+ID4NCj4g
PiBIaSBOYW1oeXVuZywNCj4gPg0KPiA+IFNvcnJ5IGlmIHRoaXMgaXMgYSByZXBlYXRlZCBtZXNz
YWdlLiBJIHRob3VnaHQgSSByZXBsaWVkIHRvIHlvdXIgc3VnZ2VzdGlvbg0KPiA+IG9uIHRoaXMg
bGFzdCB0aW1lLiBJJ20gdGhpbmtpbmcgd2Ugc2hvdWxkIGtlZXAgaXQgbGlrZSB0aGlzIGZvciBu
b3cgYW5kIG1ha2UNCj4gPiB0aGlzIGNoYW5nZSB1bmxlc3Mgd2UgZmluZCB0aGUgcHJlY2lzaW9u
IGxvc3MgaXMgY3JpdGljYWwuIEJlY2F1c2UgSSB0aG91Z2h0DQo+ID4gd2UgZG9uJ3Qgd2FudCB0
byBhZGQgc3BlY2lhbCBjb2RlIHRvIGhhbmRsZSB0aGUgY2FsY3VsYXRpb24gYW5kIGZpbmFsIHBy
aW50DQo+ID4gdG8ga2VlcCBjb2RlIHNpbXBsZS4NCj4gPg0KPiA+IEkga2VwdCB0aGlzIGNvbW1l
bnQgaGVyZSBzbyB0aGF0IHdlIGRvbid0IGZvcmdldCBhYm91dCBpdC4gUGxlYXNlIGxldCBtZQ0K
PiA+IGtub3cgaWYgeW91J2QgbGlrZSBtZSB0byByZW1vdmUgaXQuDQo+IA0KPiBQbGVhc2Ugc2Vl
IHByaW50X2NvdW50ZXJfYWdncmRhdGEoKS4gIEl0J3MgdGhlIGdlbmVyaWMgY29kZSB0byBwcmlu
dA0KPiB0aGUgZXZlbnQgdmFsdWUgYW5kIGl0J2xsIGRpc3BsYXkgdGhlIHZhbHVlIG11bHRpcGxp
ZWQgYnkgdGhlIHNjYWxlDQo+IChkZWZhdWx0IHRvIDEuMCkuICBTbyB5b3UgY2FuIGtlZXAgcHJl
Y2lzaW9uIGFzIGxvbmcgYXMgeW91IHNldCB0aGUNCj4gc2NhbGUgcHJvcGVybHkgKDFlLTMpLg0K
DQpJIGNvdWxkIHNlZSB0aGUgcmV0aXJlX2xhdGVuY3kgaXMgcHJpbnRlZCBjb3JyZWN0bHkgYWZ0
ZXIgc2V0IHRoZSBldnNlbC0+c2NhbGUgdG8gMWUtMw0KYW5kIG11bHRpcGx5IHRoZSB0LT52YWwg
KiAxMDAwLiBIb3dldmVyLCB0aGlzIHNjYWxlIGlzIG5vdCB1c2VkIGluIG1ldHJpYyBjYWxjdWxh
dGlvbnMuIA0KV2UgbmVlZCB0byBhZGQgY29kZSBpbiBtZXRyaWMgY2FsY3VsYXRpb24gb3IgZGlz
cGxheSBwYXJ0IHRvIHNjYWxlIGl0IGFzIHdlbGwuIElzIHRoYXQgDQphY2NlcHRhYmxlIG9yIGRv
IHlvdSBoYXZlIG90aGVyIHN1Z2dlc3Rpb25zPyANCg0KVGhhbmtzLA0KV2VpbGluDQoNCj4gDQo+
IFRoYW5rcywNCj4gTmFtaHl1bmcNCg==
