Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9A287504;
	Wed, 16 Jul 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696280; cv=fail; b=D43I6kOmP5NZpXyP4AQbbylGakTIKJJa+fRZ9QcWPw33xfriRuYhV4gDghvrNKMel8iGL7kEcJFdakI9wQdBQvCePKzU6K5tKMR6gLZG152g1eYFMT3DfD4OkYt10aZqFDYX0Y5wKA7pA2OKhmjvebRy3K8U95fsize+ymlf2TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696280; c=relaxed/simple;
	bh=rOeD4lm4HDCmO2Dl+bcHcqZpJBL1HcqlrpNns+QzWgE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pslrITa3gBWe18shTjt5RLQfP0kQ/77DSzKAYZErvsc/96xu4M7DA3Pe5Nc8PYPCVf+JiCLS5Fo/dw7s9a2qBuuziXO+0hTkA/DfubBLUYk41/1ezTjaHVLSQIb0hR+eNNDqu8HzuhOJNonFgazGp2Mnoc0TItIVg49OobgDdk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdR4c4wE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdR4c4wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752696278; x=1784232278;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=rOeD4lm4HDCmO2Dl+bcHcqZpJBL1HcqlrpNns+QzWgE=;
  b=cdR4c4wEi6k3VwqXnJCgV8h3IpIZeDDShmUR8JAAbZ51FX1LHizAWaCa
   TOZnZPLBdgS5I5y0kImNqCUIM7c9XMCDpNGhwVwhcs3ekUSkVc2EJaTTS
   XMiH6uzB4PZtJt62ZoiyJqtehdeonu1XGlI8z5HjEaBz7UZbqHNFyonzE
   zG8OKSuScQy5iT4XU47YpbuA7rSXR9+exUOid4eYBlBGc83vu4RiyGdZN
   uiG90AIwZgR+pBIhAwc5Nycv/tB3QugMHSpWhC9sa+w8grBC4l7mlsfyN
   5n1Tppni9sk9BMFydLX+o8jUuGe2l/Fqro12ikHEqwgBoabXsOCHAaxfW
   w==;
X-CSE-ConnectionGUID: 0UOr/zNoT1KMqXxHFCDSlQ==
X-CSE-MsgGUID: UHxF/n8HTD+8hANQQTQhyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80405595"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="80405595"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:04:37 -0700
X-CSE-ConnectionGUID: VXoyYHKtSxuyGZiM8RmGcQ==
X-CSE-MsgGUID: 6MvRDT//R46EByL4WmhZdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="161894663"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 13:04:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 13:04:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 13:04:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 13:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9Viu2SbGPLpoRPiUJRsxCKE+IFkfGQbVL6hX+V+EdiFEjDn3mBkUzDCak3LAu7EGmrlbXzwr9xn2DcUD1STK/v6ymCoJ996d6enbzAdlQdotfExfCaAmk2I0OmlaGFdDL7BtG6k9IEqbpKgbf2atQdq+MOxQyTs1tiS3OnKyHa6aXLoxJQFnu+Cq/Tdj3L+eWGwecWB0HsWTsQ+HzjtPrO1VC+I95yzW4rVQPn3Oi9qY6nKefJMokQz2PEDbNCjSFZokx+ws4USa0LOmgtM+uVyvDBQnwYFui/L3BEQmEX3aguBDsawoAFFxB5AWRMfZNnMdsF/26w3g8JtPy52Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOeD4lm4HDCmO2Dl+bcHcqZpJBL1HcqlrpNns+QzWgE=;
 b=B7Z1TVTuBfV1LySru0wGG+5mtYf5/cjR4VScSew39ah1/4XiXv5oqn4dQAFxouEQ0PpQ0FoBgIJelEYbf08VwaOoD5Cc3M7GIFQNK2pPooCrmhPVs0i/8Vci4KPL+f9deounB7NsF2CMyGTNm2x0cBLI+GPN5Ljiqxx7hrMMR4vcmRC6iv/mQ6iUN2nPG17dls4W7JrORUPgecNz/b8HQKn3ZXg3Gh6gfGoCVJjT4eqwbLzlnCgjp8sHcO1h/Wn54fKx5LmrI5icUuGLjbBSOxivhviCK07vJvHdb6dtDWNsY8dtFF42rbONyb58ABJnXuGNA+tjL33JneqjuC8G2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10)
 by IA3PR11MB9376.namprd11.prod.outlook.com (2603:10b6:208:570::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 20:03:50 +0000
Received: from MW6PR11MB8389.namprd11.prod.outlook.com
 ([fe80::f7a1:a0a4:d33:539c]) by MW6PR11MB8389.namprd11.prod.outlook.com
 ([fe80::f7a1:a0a4:d33:539c%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:03:50 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "ben.gainey@arm.com" <ben.gainey@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"blakejones@google.com" <blakejones@google.com>, "tmricht@linux.ibm.com"
	<tmricht@linux.ibm.com>, "song@kernel.org" <song@kernel.org>,
	"howardchu95@gmail.com" <howardchu95@gmail.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "jean-philippe.romain@foss.st.com"
	<jean-philippe.romain@foss.st.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "ashelat@redhat.com"
	<ashelat@redhat.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux@treblig.org"
	<linux@treblig.org>, "yeoreum.yun@arm.com" <yeoreum.yun@arm.com>, "Wang,
 Weilin" <weilin.wang@intel.com>, "acme@kernel.org" <acme@kernel.org>,
	"yangyicong@hisilicon.com" <yangyicong@hisilicon.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"quic_zhonhan@quicinc.com" <quic_zhonhan@quicinc.com>
Subject: Re: [PATCH v1 00/12] CPU mask improvements/fixes particularly for
 hybrid
Thread-Topic: [PATCH v1 00/12] CPU mask improvements/fixes particularly for
 hybrid
Thread-Index: AQHb55kamO4N70cQXky6Vh+0Yz1iorQztbWAgAGUlYA=
Date: Wed, 16 Jul 2025 20:03:50 +0000
Message-ID: <9c9d0fc0e37425961f539f8aac6ff09a8da8b503.camel@intel.com>
References: <20250627192417.1157736-1-irogers@google.com>
	 <CAP-5=fUu6_gOD8=5pNc2XbWc6ueHR_FpM6XF51=mdf9L0V0X2w@mail.gmail.com>
In-Reply-To: <CAP-5=fUu6_gOD8=5pNc2XbWc6ueHR_FpM6XF51=mdf9L0V0X2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR11MB8389:EE_|IA3PR11MB9376:EE_
x-ms-office365-filtering-correlation-id: d8cb352a-ca32-4432-f836-08ddc4a3e1f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?SEJOcHdocnIyR3pBQ2FBY1RyOUpyc29FYVlMWVBVMm1PSlphMmlNZW13YWZw?=
 =?utf-8?B?dWtzaFEvYkRoQjR0bXJDSlBrMTYwMzdWN3BYZmpzUlNZYW5JblJUUHFDbTdp?=
 =?utf-8?B?ZmlVYk1qZHJMS2VxYWllVWhDc0N1OWhtV1k2QlM2elQxeFpGSzcrUXV4aDZE?=
 =?utf-8?B?QldkOXVEWXdncHROOHVrS015RTYwSHZ0R2xhZVF0VW5nVml3aGpCVlg4c2xw?=
 =?utf-8?B?c0hmSmxTUnJ0VTJzSGlvUkFDM1lFZWpGTmd4UWpIUzZ6cGs2d2JsMVVYbmhT?=
 =?utf-8?B?bmRGci8zeU1kMDlJcGh0ZlZ3TVNoKzIzeTdyOUdzYjhBZTRjMmNSci9wYnFi?=
 =?utf-8?B?cFozL3pEZmJhSHMwZ3YydFhFdmZPYVZFazhBYkFadkQyNFVLUnF3YXFJVUlo?=
 =?utf-8?B?RVV5WmliTkI5Z2gxSXpKNnV3TlZUN3hPMGFjOUU3ZGpnRmlNT2RVMlpkOU5p?=
 =?utf-8?B?a3JsUTRxVFBFZUpOUFc4anA5cnY2OThPVDNUR3BpK0JhWWVjc0RnenlDb1Jk?=
 =?utf-8?B?dzdwazRZVUR4dGl5V2Q4UjluRVFBcFl3TjlNQkttdTFrL0J4M0lFUWIrQ0ty?=
 =?utf-8?B?V2dpNmlXN2JHc0F5ekxGZkw3Y2pZTHpUT2EyUDRLVXlRMm05aWVZcitlNG9r?=
 =?utf-8?B?Y3BBUVZTYUZMdjlkS2t4N3JZMFRFT2Rmc0JUa0tBMWwvbEtjVU9rdjUzdzhL?=
 =?utf-8?B?cWhwYU9qOEJrWnRMUWVkMjhTUW1jUGV4SEFlZFpPSTZud0lzMFQrTmlVVko4?=
 =?utf-8?B?VU10bHAxbkZ5cjE2L0UyNnlCenFKcmFpNkVzZXZ0UzQ0QWVIZnI4QmNlSVgr?=
 =?utf-8?B?UE9udytYWmNKQ2ZGOHlRUUpUM1RJUHY5dkR6TlFrQnRWYnMxcUtEQmhuL0R1?=
 =?utf-8?B?NlFtcTY0TFZJZURpREVPZ0M3djhMUzJTN2lPa3JhdWR0TzFKcllycUQzWGU5?=
 =?utf-8?B?TDc1dXlUK1pXTWxsYlN2ajZCK1dPNHpJcHJzS2hlY2ROcUEvMS9IZFdLYWx6?=
 =?utf-8?B?a2lINW5mKzlSbGtNYkYxOEpvQ1NMcUxYdmdDYTVRMUtPUzFQeDh2aGFVQWxs?=
 =?utf-8?B?VzlBSTZNcVl1Z2JpanhsQXhOc1VJVmo0N3N0ckh5RVJQU0lWTmlteFk3UWJX?=
 =?utf-8?B?eFlnREZlVDhtU0U2U1NndEo1TlhJQ3FtVWgwRTlGc1hCeUZLSk96eFFFbGlR?=
 =?utf-8?B?b2k2MXJTRjNrbUdTVzBPaHV4a2UvcHFVZlhIN3p2UThNQndWN3RqTzdTbVNp?=
 =?utf-8?B?ZEQ3ck9ibElQTC9Ec2xhSkdudDIzS1E5Tk1WV2RNTXp0T3JRNzJDVDRQbm9z?=
 =?utf-8?B?ejRZV2NCZTZGaXp3TzdpNWYxUUtXS0p1WDArRWFhc04wcW1KbUhlK0JyYm5N?=
 =?utf-8?B?eW1HRk9NNXR3QW0vRHNJTVFibjFEaVRRUmRLUXNPL2FuRC9ZUE5vYWc5Z1dX?=
 =?utf-8?B?Qm0zcWVMenVvNEtxNnJ1N3YzSWdSUVRwK0pmQjVCQ0NpR1RRVUpvaWZVZjlP?=
 =?utf-8?B?OG9hRHQrMUxadHFpcTBWdkVJdmlRQW0xZ0huVUF3SXRvT0NtV2tpSi9wemJB?=
 =?utf-8?B?US9PRDlrVlRrb3duRXQ5blJGN3FkaGozU0p4NWcydWo0RkllcnpMT3hnajJ1?=
 =?utf-8?B?b0cwOTdqWUtQdHFzTW5PT3ZiL1FFL3lkaG92WTlaQ2hDUmxLUnZqUHRjc3Ri?=
 =?utf-8?B?WnVpdmVlRlFZRUxkOWtLZzZON3hYVGdyT3FGWnFvYUszLytXcFlPaVFuSkZF?=
 =?utf-8?B?c2hMTklrcytCcEZDSnA1VkFpTFd2VVZoa21BYm54N0JCOHJFRDJ0WVh6cDBH?=
 =?utf-8?B?MERsNnl2eDBJczVpd0tHWFJTOVNTN2k3TGhjeFBlVVNzVkxEYXNvVzhvK0ZT?=
 =?utf-8?B?elFhV3JXaURWZG1Qa3MwRTZwanVKak5oRlM2d20yZGZ0RXRFNlRZTENQeWdY?=
 =?utf-8?B?TzFBYUZpV2Y0TUNBVG1BNE02WDIzQ2FBWXdiRUVhSEZSUWhsbE0zQTgxSGd1?=
 =?utf-8?Q?wyBDlGfpvxYQCymVZ12g90v/YIO1QQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR11MB8389.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODVVZE9LUnlEMlUvL012VExGMzVGaVJlZTh1RzlQMmZnK08yTmRMNC95Sjdr?=
 =?utf-8?B?NGdUTStCYjBLQVhQSThUL2hKVk5jQWZZTTNHUWhFeDNxRjNpaTBlYjJwWmZ0?=
 =?utf-8?B?MXRsdHgyODgxK094SzEydm9mRVJEUitiL0FVb0d5VGVtbkdrNk5NejRCVTJi?=
 =?utf-8?B?ZGNZajlHaDNBUHFBYWEwa293dzNtZ0w0NTI3ODQ0dzhOd2tlUUp4WkxXK3N1?=
 =?utf-8?B?SVVacWxUUTNYbm1VU3FtNFY2SVdPZzllR2tZUkV6MWY0OHlCUlVxSG52SVpu?=
 =?utf-8?B?OWpFYmRhUUhhNDRzOFBlL0Vzb2tjRyt2Q2pPNFcrSGlObmhzNGhzU21zYkN2?=
 =?utf-8?B?cS9kZlljdTBqZkhad210QnlCWE9VZnhra3RFWnlsTHVSQkg0Q1NDOTgzWVh0?=
 =?utf-8?B?NXdkeVovMzN5WUJuSFR1UVpPQ21WY0hDdzgyc3RudjNCU09xZjBqNWV5TFJ5?=
 =?utf-8?B?SjlTZFFQYlhFMC9USE52UklXNWFiRFJSWGZLR0VYc05HMkd6Vkp4MEU0Qlpr?=
 =?utf-8?B?eE1jTmVncGxOeWZkc1NsblcwVm53TnVpVy9KM1M1MnFSOUxQbmZzOHllWVJP?=
 =?utf-8?B?eXdvZEsvNzZXYkI4Vkxtd3JMYmpwcUk1MXplSVpvTHovZDBQMHFob2pNenl3?=
 =?utf-8?B?VGdEUFdReXRIMGZ4UXRMRGlYZVMwUmJKeFpKMmNzdFo4QTdzUG5rdGtrSTgv?=
 =?utf-8?B?Y2x0ckd2N3gyR3pZUHdxaStYVUxGOWFlaGZPYll3VGRvVCtGLytuS09oMUlV?=
 =?utf-8?B?dzVUUDdRTXJZZVZtdzRXbXdyS1pMUWxnRTQzdFNWeDQzdEljaDhGTDRIdWxD?=
 =?utf-8?B?QXVFc2NnMVYvUEhVYS9DWW1xREZ1OTZnVzJOOVhncmhxY2wyaE1kWjQ1QnJq?=
 =?utf-8?B?NENRd0JudSs3eEtCUmZiVHBiNURUODVkaHJxUkdramV6T1piUVlVc0QwbXh6?=
 =?utf-8?B?dWtRMWg2ajlpVDhlWnVFaXZGMm1PelYvREovUGxEeHNsUGlDbitjdDhWZXJS?=
 =?utf-8?B?VkEzdVp4ZTVOQ2JNZmd3NStHQUZjeCtCR2t1cHNBWndvSUFCRS9nY3NSN1Fn?=
 =?utf-8?B?RlF6Zm4wWWtqQ0VLTXJZSmNUcEd3UWo5MVE2R1ZTY053VjBwRGorcnNiUzM0?=
 =?utf-8?B?VU5RaHE5TGdXekM5bklURFM1WlhldTZJN05USi9tZ3A2bVk4dWo2K1hXaUhJ?=
 =?utf-8?B?MlpIeDZKSDNTNitZVUJaanBRdVVhMkZvTk8yN01IKy8vc25HSkVLaWdiSjdl?=
 =?utf-8?B?L2hHMUVudlVBa0piWlllNCtxTzdGL1NqdmVSQTRPbTRNZHJGVmg4eDBpUGtG?=
 =?utf-8?B?UENLcVR1ZkpBMFRYV3ZBWklEbmtDY28yOElIR2J0TG1SeHo4YzFHQ1pqeGh1?=
 =?utf-8?B?dFJmM21aQkdtMVREUWpPd2poMjY5S2xRYndaWjdsRVdNNXNmZllwY0R4VlZN?=
 =?utf-8?B?aURQWSsvQzM5ZlR2TVphb3RnOG5odW9Scld6Z0RCdkdjNkpuRHY3TkxRSEk4?=
 =?utf-8?B?Z2xGd1M3TlZIYXJCcm1Ydno5akZqQmZueU5GQlpIdXRDeldKdnlicUN3dEsz?=
 =?utf-8?B?TSs4VTZUWWpKRHJLTWdWd21Dc3hGemZKM2cxM3dSWlhsUjhzYUdkdEdrTUls?=
 =?utf-8?B?UjBtdDhaeUNzc0czOXQzZHA0OGVTTkNocW1qYnlrR0ljWXVQSjVZMlJuak8z?=
 =?utf-8?B?QUN2cTBlZXd4VGxuT3krRjc3WFVpdmRKVEVaazdFRjVmWGVHQnlhSkZ3Z2VX?=
 =?utf-8?B?VkNnNTJqWENFSjlKMjBGbUpkT2JINjJMeSsxbTNTLzdoZDl1enF2SUlzQ1Rz?=
 =?utf-8?B?eFdObXI0VExtcEVXTWJuTGR3SzBOT0x1MnBCSmpKSzVPeGJreit5Tk1JY1ls?=
 =?utf-8?B?MTNaQXN5ZE5lL1ZITlcrTGFZYTlQU2dYSkQrWTBkdHRQUVBBdEtMd292M291?=
 =?utf-8?B?SkF0aUx6enI0WUdNalFqSzI1dE1RNHNHb2V2U3JwMVVRY2VyeWZSQVpJU3hk?=
 =?utf-8?B?S1ZmY0JMY1hrcWRoU3JmVGZlOVVGMUxsakpLZjFNcERTZEt0dDJ2eERzSXJT?=
 =?utf-8?B?NjZSUFpZS29vZ1QwZnBXT3JKU0pRWDMzUGNxWmE1R2p0UzZTMjluU085S0Fv?=
 =?utf-8?B?UEFVMTRncWhwb0RIUE92eXBRa3d2akNUdWRxZjlkMWdMNk5LYzY2dlJpRXVv?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36F96D4F8B532443A4BB66AAF2DEF425@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR11MB8389.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cb352a-ca32-4432-f836-08ddc4a3e1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 20:03:50.5875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgRMMXpS9q7GZavpJ8wA0T6COLLc163AOTUAGVQtiRX7fG1A+Shej5cBHAykXUHoVOzEoIvjmewHWjER8cWB7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9376
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTE1IGF0IDEyOjU1IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBGcmksIEp1biAyNywgMjAyNSBhdCAxMjoyNOKAr1BNIElhbiBSb2dlcnMgPGlyb2dlcnNAZ29v
Z2xlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gaHlicmlkIHN5c3RlbXMgc29tZSBQTVVzIGFw
cGx5IHRvIGFsbCBjb3JlIHR5cGVzLCBwYXJ0aWN1bGFybHkgZm9yDQo+ID4gbWV0cmljcyB0aGUg
bXNyIFBNVSBhbmQgdGhlIHRzYyBldmVudC4gVGhlIG1ldHJpY3Mgb2Z0ZW4gb25seSB3YW50IHRo
ZQ0KPiA+IHZhbHVlcyBvZiB0aGUgY291bnRlciBmb3IgdGhlaXIgc3BlY2lmaWMgY29yZSB0eXBl
LiBUaGVzZSBwYXRjaGVzDQo+ID4gYWxsb3cgdGhlIGNwdSB0ZXJtIGluIGFuIGV2ZW50IHRvIGdp
dmUgYSBQTVUgbmFtZSB0byB0YWtlIHRoZSBjcHVtYXNrDQo+ID4gZnJvbS4gRm9yIGV4YW1wbGU6
DQo+ID4gDQo+ID4gICAkIHBlcmYgc3RhdCAtZSBtc3IvdHNjLGNwdT1jcHVfYXRvbS8gLi4uDQo+
ID4gDQo+ID4gd2lsbCBhZ2dyZWdhdGUgdGhlIG1zci90c2MvIHZhbHVlIGJ1dCBvbmx5IGZvciBh
dG9tIGNvcmVzLiBJbiBkb2luZw0KPiA+IHRoaXMgcHJvYmxlbXMgd2VyZSBpZGVudGlmaWVkIGlu
IGhvdyBjcHVtYXNrcyBhcmUgaGFuZGxlZCBieSBwYXJzaW5nDQo+ID4gYW5kIGV2ZW50IHNldHVw
IHdoZW4gY3B1bWFza3MgYXJlIHNwZWNpZmllZCBhbG9uZyB3aXRoIGEgdGFzayB0bw0KPiA+IHBy
b2ZpbGUuIFRoZSBldmVudCBwYXJzaW5nLCBjcHVtYXNrIGV2bGlzdCBwcm9wYWdhdGlvbiBjb2Rl
IGFuZCBwZXJmDQo+ID4gc3RhdCBjb2RlIGFyZSB1cGRhdGVkIGFjY29yZGluZ2x5Lg0KPiA+IA0K
PiA+IFRoZSBmaW5hbCByZXN1bHQgb2YgdGhlIHBhdGNoIHNlcmllcyBpcyB0byBiZSBhYmxlIHRv
IHJ1bjoNCj4gPiBgYGANCj4gPiAkIHBlcmYgc3RhdCAtLW5vLXNjYWxlIC1lICdtc3IvdHNjLyxt
c3IvdHNjLGNwdT1jcHVfY29yZS8sbXNyL3RzYyxjcHU9Y3B1X2F0b20vJyBwZXJmIHRlc3QgLUYg
MTANCj4gPiAgMTAuMTogQmFzaWMgcGFyc2luZyB0ZXN0ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA6IE9rDQo+ID4gIDEwLjI6IFBhcnNpbmcgd2l0aG91dCBQTVUg
bmFtZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBPaw0KPiA+ICAxMC4z
OiBQYXJzaW5nIHdpdGggUE1VIG5hbWUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDogT2sNCj4gPiANCj4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3Bl
cmYgdGVzdCAtRiAxMCc6DQo+ID4gDQo+ID4gICAgICAgICA2Myw3MDQsOTc1ICAgICAgbXNyL3Rz
Yy8NCj4gPiAgICAgICAgIDQ3LDA2MCw3MDQgICAgICBtc3IvdHNjLGNwdT1jcHVfY29yZS8gICAg
ICAgICAgICAgICAgICAgICAgICAoNC42MiUpDQo+ID4gICAgICAgICAxNiw2NDAsNTkxICAgICAg
bXNyL3RzYyxjcHU9Y3B1X2F0b20vICAgICAgICAgICAgICAgICAgICAgICAgKDIuMTglKQ0KPiA+
IGBgYA0KPiA+IA0KPiA+IFRoaXMgaGFzIChmdXJ0aGVyKSBpZGVudGlmaWVkIGEga2VybmVsIGJ1
ZyBmb3IgdGFzayBldmVudHMgYXJvdW5kIHRoZQ0KPiA+IGVuYWJsZWQgdGltZSBiZWluZyB0b28g
bGFyZ2UgbGVhZGluZyB0byBpbnZhbGlkIHNjYWxpbmcgKGhlbmNlIHRoZQ0KPiA+ICAtLW5vLXNj
YWxlIGluIHRoZSBjb21tYW5kIGxpbmUgYWJvdmUpLg0KPiA+IA0KPiA+IElhbiBSb2dlcnMgKDEy
KToNCj4gPiAgIHBlcmYgcGFyc2UtZXZlbnRzOiBXYXJuIGlmIGEgY3B1IHRlcm0gaXMgdW5zdXBw
b3J0ZWQgYnkgYSBDUFUNCj4gPiAgIHBlcmYgc3RhdDogQXZvaWQgYnVmZmVyIG92ZXJmbG93IHRv
IHRoZSBhZ2dyZWdhdGlvbiBtYXANCj4gPiAgIHBlcmYgc3RhdDogRG9uJ3Qgc2l6ZSBhZ2dyZWdh
dGlvbiBpZHMgZnJvbSB1c2VyX3JlcXVlc3RlZF9jcHVzDQo+ID4gICBwZXJmIHBhcnNlLWV2ZW50
czogQWxsb3cgdGhlIGNwdSB0ZXJtIHRvIGJlIGEgUE1VDQo+ID4gICBwZXJmIHRvb2xfcG11OiBB
bGxvdyBudW1fY3B1cyhfb25saW5lKSB0byBiZSBzcGVjaWZpYyB0byBhIGNwdW1hc2sNCj4gPiAg
IGxpYnBlcmYgZXZzZWw6IFJlbmFtZSBvd25fY3B1cyB0byBwbXVfY3B1cw0KPiA+ICAgbGlicGVy
ZiBldnNlbDogRmFjdG9yIHBlcmZfZXZzZWxfX2V4aXQgb3V0IG9mIHBlcmZfZXZzZWxfX2RlbGV0
ZQ0KPiA+ICAgcGVyZiBldnNlbDogVXNlIGxpYnBlcmYgcGVyZl9ldnNlbF9fZXhpdA0KPiA+ICAg
cGVyZiBwbXVzOiBGYWN0b3IgcGVyZl9wbXVzX19maW5kX2J5X2F0dHIgb3V0IG9mIGV2c2VsX19m
aW5kX3BtdQ0KPiA+ICAgcGVyZiBwYXJzZS1ldmVudHM6IE1pbm9yIF9fYWRkX2V2ZW50IHJlZmFj
dG9yaW5nDQo+ID4gICBwZXJmIGV2c2VsOiBBZGQgZXZzZWxfX29wZW5fcGVyX2NwdV9hbmRfdGhy
ZWFkDQo+ID4gICBwZXJmIHBhcnNlLWV2ZW50czogU3VwcG9ydCB1c2VyIENQVXMgbWl4ZWQgd2l0
aCB0aHJlYWRzL3Byb2Nlc3Nlcw0KPiANCj4gUGluZy4NCg0KSGkgSWFuLA0KDQpMb29rcyBnb29k
IHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRl
bC5jb20+DQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBUaGFua3MsDQo+IElhbg0KPiANCj4gPiAg
dG9vbHMvbGliL3BlcmYvZXZsaXN0LmMgICAgICAgICAgICAgICAgIHwgMTE4ICsrKysrKysrKysr
KysrKystLS0tLS0tLQ0KPiA+ICB0b29scy9saWIvcGVyZi9ldnNlbC5jICAgICAgICAgICAgICAg
ICAgfCAgIDkgKy0NCj4gPiAgdG9vbHMvbGliL3BlcmYvaW5jbHVkZS9pbnRlcm5hbC9ldnNlbC5o
IHwgICAzICstDQo+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgICAgICAgICAgICAgICB8
ICAgOSArLQ0KPiA+ICB0b29scy9wZXJmL3Rlc3RzL2V2ZW50X3VwZGF0ZS5jICAgICAgICAgfCAg
IDQgKy0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL2V2bGlzdC5jICAgICAgICAgICAgICAgIHwgIDE1
ICstLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvZXZzZWwuYyAgICAgICAgICAgICAgICAgfCAgNTUg
KysrKysrKysrLS0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL2V2c2VsLmggICAgICAgICAgICAgICAg
IHwgICA1ICsNCj4gPiAgdG9vbHMvcGVyZi91dGlsL2V4cHIuYyAgICAgICAgICAgICAgICAgIHwg
ICAyICstDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9oZWFkZXIuYyAgICAgICAgICAgICAgICB8ICAg
NCArLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmMgICAgICAgICAgfCAxMDIg
KysrKysrKysrKysrKystLS0tLS0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL3BtdXMuYyAgICAgICAg
ICAgICAgICAgIHwgIDI5ICsrKy0tLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvcG11cy5oICAgICAg
ICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvc3RhdC5jICAgICAgICAg
ICAgICAgICAgfCAgIDYgKy0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL3N5bnRoZXRpYy1ldmVudHMu
YyAgICAgIHwgICA0ICstDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC90b29sX3BtdS5jICAgICAgICAg
ICAgICB8ICA1NiArKysrKysrKystLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvdG9vbF9wbXUuaCAg
ICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgMTcgZmlsZXMgY2hhbmdlZCwgMjk3IGluc2VydGlv
bnMoKyksIDEyOCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLQ0KPiA+IDIuNTAuMC43MjcuZ2Jm
N2RjMThmZjQtZ29vZw0KPiA+IA0KDQo=
