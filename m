Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5191E8823;
	Thu, 30 Jan 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265423; cv=fail; b=TwP06YDtKs6CyBJeIca2GH0u2/pwGoTrGQ0qeKZwzTohb4fIRZicEi3ziYSqEH+BPUqExTuBEpKd1/qcysPl/ev/8WoYPKw9mzhc851DbHg7e+BlGKcueNj3MoSr5JSq/imZ5isuFdL/ioDCiSlDEEwHDFaNQoDSH1XmBbMjQDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265423; c=relaxed/simple;
	bh=KjSiCE0Sv7cQZ7Fj0wNuiLQ7xNVS7stWnA7I4lQYwzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d6ZzCMI4iNtPK5d9mOQ2EP2CEY4DPs+OLtVdkkwLg0WQsr+C5KlfP2eSavPI82z5U6EoPslYxNZmigGIQuj8GK1ppuaX2jbBkEWynyvnRm+6CBmZC2MZLFqwcTaAumNoAd//JrOL8Qy3LP8XqThhlmfNCV5Xck1tO025EekyDoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSxEuemu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSxEuemu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738265421; x=1769801421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KjSiCE0Sv7cQZ7Fj0wNuiLQ7xNVS7stWnA7I4lQYwzk=;
  b=ZSxEuemuUgiT8uCemrzXZe7dBY9wn1r7BWgvmvj+yUJ1uM6gZrGPmG25
   TM/tu3CUscW4V+iDvRgtg27jBmaMSqmhk1Y9LRWfynbiUnFTLd7+yQaMS
   x2ZUYuh6D1GeXkmsALBDm6yzqhhoavk08JunAyabxTGSJImpZUbQl4waH
   krOo2ZyGWX4P8n9/E5ds6wQyuDsCwr/CAAvPLswkicvWT3zIHmlOObngr
   +Bg892JIqU6zYONk67kFWayyIpLEU8LYHivs0KJGskZrczEPzl2ymMWrS
   y+ujCziNtth8Gk9sf/rbQHFnlCUQreBEkd2/hEb+b1Ugn72PUgpBgbSjm
   A==;
X-CSE-ConnectionGUID: RzXIGt4qT1apLpExKbMERA==
X-CSE-MsgGUID: TXRVv4/2RvGPUPrZaFFYHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="49816794"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="49816794"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 11:30:20 -0800
X-CSE-ConnectionGUID: tnVh7kd+SsCcsjTR0khBYg==
X-CSE-MsgGUID: faVvoSR8SReJYwoc3LZQaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113442136"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 11:30:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 11:30:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 11:30:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 11:30:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbT541r2KpEOrCpIl6W9E7PIalZfDqucMKwE8xCV80bLzZwL0EEfq2aOFH8KBrXtJTXWFyYIU9oBTgDiblEfvpu5C3pwQyNIyKSZ8kaVFzkL4IePrd6fsu4WYCCdCxkXGm1tr5a00OLsCDBl+Pw5JrGAZMlh1uk4RMk2ZLwPVqEMaQjjKBsqJOwaMcZRZBb29XccfTdgHtpBagqSBFjfRA5cytpqYfuNODyVnWdmC6SfVQX/tLI2KGtaztkEr8HYm4hNNNZO04xqNdg08avUXbk7+epzF9lee/MaOT9VjpnPyLvrM4tjytrg1PpAKZXCU/pbehvyFfpqqXFPurDMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjSiCE0Sv7cQZ7Fj0wNuiLQ7xNVS7stWnA7I4lQYwzk=;
 b=kyTsOF+U3RJlLnY72IQlCgM4JPoTsAFjXaUXjPFbF0TrztngPuXpyKUeYkcmotqWGlU1y2h4OXanNTG3nlNZFwxAayGueH6nJRjiMrBl85VyWhvEMv4IMBIvM+JIzptttpE506NQ6JiCvPmes+LN67CR121rlXfvXppczNI1CP0cN81SgG4K557D9ljLauS4JzUwrlMklR48C/XC7oCtDjzkJ8UQCWDDcYaKQuzz5Sm4NNC1AE1WsBhAiKyOyPlZCvutut1sV/mOIvRIQ0ZJxrdVKmXzltipBgP5fZR1YShPTypgUaMA9V79IEkb1u2J1BzpfHza/iAJQGlAGOpIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 19:29:58 +0000
Received: from SA1PR11MB5921.namprd11.prod.outlook.com
 ([fe80::8e9b:65e0:d7a:e149]) by SA1PR11MB5921.namprd11.prod.outlook.com
 ([fe80::8e9b:65e0:d7a:e149%4]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 19:29:57 +0000
From: "Baker, Edward" <edward.baker@intel.com>
To: =?utf-8?B?Q2hhcmxlcyBIYW4o6Z+p5pil6LaFKQ==?= <hanchunchao@inspur.com>,
	"irogers@google.com" <irogers@google.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf vendor events: Fix double word in BriefDescription
Thread-Topic: [PATCH] perf vendor events: Fix double word in BriefDescription
Thread-Index: AQHbbhZ9279gf30ZZ0qIMgfUWOmRY7MldmSAgApGBKA=
Date: Thu, 30 Jan 2025 19:29:57 +0000
Message-ID: <SA1PR11MB5921ECBD44F3C8E8B91513CC9FE92@SA1PR11MB5921.namprd11.prod.outlook.com>
References: <a86efa823973af905ad349aeba28b3b024-1-25google.com@sslemail.net>
 <CAP-5=fXY8a1yv7DpYPcZ+TeO+_sxv0MNyh3RVMav2JEGyiCn1w@mail.gmail.com>
 <8d7019038b4e4448960233855c28d5e8@inspur.com>
In-Reply-To: <8d7019038b4e4448960233855c28d5e8@inspur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5921:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: f9a86243-d2cd-407e-bb6e-08dd41647b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEFLMHl6Nk9XanRHNW4ycUM3K2k2R1N2ZVI0cnVBTnhxNEwyaEJsSVEzSHBx?=
 =?utf-8?B?MUV2RUNLbFZjOVdKL0tZV2pKMDZNeDBubmZ3WGFibEVoYnB1TzJVelhsUElK?=
 =?utf-8?B?SXVEb2t5S1llZ1h6ZVpjL1BMb0FwVHlsTzNqOW52OUpzRkdJZEZLNTRZNDNB?=
 =?utf-8?B?bEhscFRUZUdQTGFDKzlmU0NLNEpRTDdWTTFmblJ2blpTaGtvKzhLWm8zVVY0?=
 =?utf-8?B?UU9ucGpSY2x0THFTUjc3SU93RjRXY2JBUk02Y2plYlo0bnd6UFhCdzFPSGc0?=
 =?utf-8?B?blhWWGFkL0RRMmhqaE9kZXNWQ1VlWkk4cW1qSlpFb0ZnRHhaUmYvNFNyem1y?=
 =?utf-8?B?NU1WTDBWNm91Q1h0eEFHck1jcGZZUHc5cjdmb0tJeFM2Y1doV1Zrbmp1bGZy?=
 =?utf-8?B?V0c2Tk5SclJrZUVpMG5sZDlEVk5VUGgwd1R0U3U2ZFV1U1pqYVZTNkMvQzBl?=
 =?utf-8?B?L09hd1NONzFKdDU0a0w1MEtqQlZBNGNheFdpN0tob0o0dm1WUDhpSGloNzZy?=
 =?utf-8?B?d2VaSElHUGI4Y2xuNkl1WnZWNFdCK1hqS2taOWxZQXRQQ3FrTm9kVnNhOFJt?=
 =?utf-8?B?enltTXp0YkIzZm1EZkt0bjVxaFpZQ2lXZ1p1QWpNY29Iaml2cHdGa2laM3pC?=
 =?utf-8?B?UW9QS2Rqblg4Sm1LbEVIQjczWTZiYUxlQTEzM2RWUWM0V0NiZFZPTEdtcTcz?=
 =?utf-8?B?TmxxNmw0aDhqOHZUVFFSam9haXl3elRBQlNYajZrL2FNemp3WXJhRXJlZUtz?=
 =?utf-8?B?cVU2a2s3U1ZjYXJrZlpqV1JmK21DS2FEZDUweHZrOHZSM1hGc3FBQ1ZyMGZD?=
 =?utf-8?B?aHQvanp3RS8vbS80c0R1UzR5VTBGZzlBTFVteU96VTljMHRsR3BxSmVocU5G?=
 =?utf-8?B?M0VPWHZFQ1UrZ00rSmg1YjBJRVlNTlFaMDgyN244ZmdBZ2Q3NWx5TVRVanBH?=
 =?utf-8?B?eFhCV0pwcEZUaW85OFpTanVoMXFhODZ6T1Y4VmRtK3IyMnIrYUpjci9sK3pX?=
 =?utf-8?B?TElnME52VXd3d0g5SnlCaldVY0VHOWVsWGRkcUJBTEh5cEI2WmhJSmpWMUhV?=
 =?utf-8?B?bk1JcGV1WEc4K3lQdC9oQzZWT0pPUFhtMnhWOFF1ZnpkLzFZY3U0TmR5WFEx?=
 =?utf-8?B?SFAyS3NFS0FWQ01SQmZ2ZDdGT3UrMUx6ZU55bWNLT3UrcEU0MVRIL1FiVStw?=
 =?utf-8?B?dnZOdHRzODF0VHVnOC9SOWhaemExVnBBNHdqL1Q5UkpHS2VuY2RHNEZJVDh6?=
 =?utf-8?B?bk5LaXdubXltT2Zyc09EWHl6M29wT2MrUCswS29rMm1uWmVxSHhseUJOcVhI?=
 =?utf-8?B?S2U2Z0k0U3NzK1d3bWYwZ05WcnY5RC9zT2x5Sko3Um50dHUyV3UzWmd1Q2VN?=
 =?utf-8?B?TjI2Qi92bHNSV2Vua1RXZEdvNW1pZ0g2czZTdzg3Y3d3RGE1aTlMRnd3bUxL?=
 =?utf-8?B?U25SWTZoNHplWDAya3BDOVE4Y2Y1RXpFQjJXSUkzUWFreEVrUE5saFFIbUsz?=
 =?utf-8?B?b3EvQnVzTzQ1dGJjMWp2azB1cnFRK0Y1U082NGp0ZDB5SGpiRlBlQWdKT3dX?=
 =?utf-8?B?SXVIUS9naXB5M1B2am1LcU0yaXQ5MXhwRFNVeUNNSzMvc0EzZ3o5eXdrelMw?=
 =?utf-8?B?d2orbXA3RWpmU0dDNFkxamVva1FjWm50YStWOGtMcnZ6ZUthV2FuQ0djM3BP?=
 =?utf-8?B?R3NrUlFOZEY3b1VHQUpjT1RNTVRQQnhOR2JBYnlscXRjY3V3LzRDUm9IZmxS?=
 =?utf-8?B?VFhFZGFaZllJdHlGNGlZS0JxeUF3dUl4c3prbFVRY2MrNE1kcTJYODUrNk9G?=
 =?utf-8?B?ZXJ0ZmI3U05rZTR0UzR2ZGx0R044YnliaXpheC9rRlQwSHRjZUlGSFlVV2Zt?=
 =?utf-8?B?OTNjUk5lU1A0d3U2Wlh5TGFjZGM1S1E3cytBRnhIUWg3dGlDRGJxMElITURF?=
 =?utf-8?Q?jM29PQvp9W0vWt+QnDK8rg04DPCmd5Tc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHhMRFBRcWxOcFBpMzNFNVlFaENJRy9PVUdRKzFFc1hXVWZnT1BWM1lEdVFx?=
 =?utf-8?B?OGtEbGZPWTMrejVBTjBUNlVYanpHclNRTWMxVW5qZFpKNWpkREc3UjF1U04y?=
 =?utf-8?B?UmxKSXI2TTJ6UHlQOUJiZ1hhd1dVczZmYVZCdFFsQlVaOFFVaEJrREM5TG1q?=
 =?utf-8?B?U2dmTjEzYkk3emZrUTZxanJ3ZTNhejFjTUFkZEJOSlVIVUJPaU5IOG85RVQ4?=
 =?utf-8?B?NSswc2RIYUs3aENEc21vbHR3VytxQWJGTmYrbTB5TVBidldIcTA0QTVBU2J0?=
 =?utf-8?B?UnM1bTIvMENaM1F0Y3UyRThINy9JVU5PWEFXbVMrak5YR0VEMGNEci9rOEZ1?=
 =?utf-8?B?NlI0VWcwRDR4aEg2SFdJTEpyOG5JdXRyQ2FweEZTWHdKOFR6K3BqclRKbEdM?=
 =?utf-8?B?Uis1NFdPcGdMUnJKaWdBY2xsZnJTSEEzTmQ3ZUd6REdNODJxS1EzdGlyMWxQ?=
 =?utf-8?B?VzFEMUljZzhtVHBFSVpHQzVTZ2ZIY1VERXByd2FCTDZ3NjdiYTEyMk9pcVRI?=
 =?utf-8?B?TzFqSTEvSS9IcHdCRHFEdGNRMUhteWhIU2F4STBzRjRLWmRmcENvSW00WmFI?=
 =?utf-8?B?S1Fkc1JybUMxenVhZm8zVVg5MWZxWHVtTFdjbXozdXRhZEtXUHdVdnUxVzdZ?=
 =?utf-8?B?eHZuMXN2VGduSDBjaTFrYjhvMW04UFNObys3d0JLQWhWQndTTWNqRXZhdlA4?=
 =?utf-8?B?ejQxei9KWWl6cnI5SThaU3FGMXhJTElaajNhUEVvb1I0SVlKYmF5a2RZUitH?=
 =?utf-8?B?Y3hDQ2dqeVdydGovMms1QXpyOFAvamtFWFRQYUFhMXBPeHJsWWt1Q3J2VGhp?=
 =?utf-8?B?N1VSL2p4cVpmd1NmeGpmcjltb1B4U1VTdHVqNkhEVldBdDJNNVNmTDhaeVU4?=
 =?utf-8?B?dDh4cjJ0cW5tWHFaUGVWL29RMHlLRTNLYkREdHc1WHF4TUZvWEMyaG1Fak4w?=
 =?utf-8?B?SmNHM1ZnV2JCWmlNUVVmandGNjlvT1V2My9WWlhDYkVDVTh3bTRlc0plTkJx?=
 =?utf-8?B?UHlZK3E5L0krSVNTSkdKNWw5OC8vM3c0bTFRQlNPYmZBVDRuYUpXdFduYzFW?=
 =?utf-8?B?bUtvYUtJMWhMd21tdW42YmVoTkdJbXJLS1NiOUZ0dExCYjNLMG1jeHZNaHBI?=
 =?utf-8?B?NTVJTlhoWDd6eFFoeHRGd3AvRGpQN2FWbzA4TTJSMmd6Y1NHRHArTFk5SFFV?=
 =?utf-8?B?Z3IydmZkSU1uT3h6dFRZdUQ4M3RBbVNMM3pIMi9qczlTNFIrbzZBaHFPVlhM?=
 =?utf-8?B?b2ZyY214Qm9UTy9CendIRHNTSjAxbnJUMEprM0poekc5WU1kd1AzSUprdjc2?=
 =?utf-8?B?d2ZuZFRVNDMyeE1Cd25GanRaa3JXRXREOFZTUHArS1l5cXpnV25rV1JrdWNt?=
 =?utf-8?B?VW8vNUNKSFVGYTRwdFZCbjNpc3Y0ZEJjenJsNDlzMjBQNGNLVDVILzhGNHMy?=
 =?utf-8?B?dTRIOVdQVnU0RElvWFZYVVNyNjVPbWRKVlhRSHlCNENmUWNEKzRwcXhrelE5?=
 =?utf-8?B?eDNmZ1Y0RktiRW5RU1RrbmtYcFRXQUNuSDg1Q3lmNmljSjM0WGdIVEllVDlO?=
 =?utf-8?B?V3J6TGY0MWVTRjAwazlwa0NlRGVRTld5alh4U0VoR1Bua0krdDBqV1NQeks3?=
 =?utf-8?B?R2RrdVBEc2NhTFN4cGFTV012TVNzOWVLdWl5QXE4Tms3RFlxWkhwWXlmREdR?=
 =?utf-8?B?cmRFRlZLNTBzN1lqVG5WR2xHa3hzMFIzQXlqN3UrQkRYUzhubktRUFVKcjEv?=
 =?utf-8?B?WElKcWdXcG53b1BpWmFqRG1oZkVGWnQ0cXlKQ0dKZXh5bGt2bmZPckx6TCs1?=
 =?utf-8?B?QzdvdFhpOWhBUlRFVmRLUXJWNUVFWHF1cXdpZG02L1IwNmRBazd5QWRPcDFW?=
 =?utf-8?B?QTM5dkNXcVBmK2R6Rkdob3NMZ0FSdWwva3FiOUJvSWtjN2N4SVJGWWRCQVkw?=
 =?utf-8?B?dktjWDZJRzJrVVBXZ2JtMm9DNmFNK1ZkR2JsZ2Q0M1hyQTFUa2Q2dXAxVkpC?=
 =?utf-8?B?SmpkQmFIUnpFNmE1ZGhlNGxSWE1LSmRWdmIzZVhIRDdEckw2dTNFOGtFM296?=
 =?utf-8?B?aFFnQXN2T2VIY1Q4cnlxRk1CYlhibkVycG5ENC93eCtGQzJTRnBOc3hHeTJ4?=
 =?utf-8?Q?ia11JDPaM/FYalcwUUTkD8BAV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a86243-d2cd-407e-bb6e-08dd41647b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 19:29:57.5941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X13G1hL+UfiOEPr2jL6OB1u1XnEGStRjpi3+didPXVc9k0311H6HFZGKzrWN+GddHdSS/FzkHkKbpBSQmRL+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

PiBIae+8jA0KPiBJIGNyZWF0ZWQgYSBwdWxsIHJlcXVlc3QgICBmaXggaXQgIG9uICBnaXRodWIu
DQo+IA0KDQpIaSBDaGFybGVzLA0KDQpUaGFua3MgZm9yIG9wZW5pbmcgYSBwdWxsIHJlcXVlc3Qu
IEV2ZW50IGZpbGVzIG9uIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9wZXJmbW9uIGFyZSBnZW5l
cmF0ZWQgZnJvbSBhIGRhdGFiYXNlLiBJJ3ZlIHVwZGF0ZWQgdGhlIGRhdGFiYXNlIHdpdGggeW91
ciBmaXhlcyBhbmQgdGhleSB3aWxsIGJlIGluY2x1ZGVkIGluIHRoZSBuZXh0IHJvdW5kIG9mIGV2
ZW50IGZpbGVzLg0KDQpUaGFua3MsDQpFZCANCg==
