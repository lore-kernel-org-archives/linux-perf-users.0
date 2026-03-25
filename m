Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494A34E762;
	Wed, 25 Mar 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472367; cv=fail; b=d/GrBi0jqEaLvvvQlGwG7yth0SQ5RwIdqT8JUFqZxMcEep0jM8fvNMe0NV74bxCYUQpiPxITOLmkaZT8Ect+i4DNITo1PzKI6z9XaP9x5moqbvM0DgQON4JllI77QDSORLmj2DJjHVGwyAa1RtI2o1p1gDgYnKIFVwJFtf+OKsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472367; c=relaxed/simple;
	bh=IvIVkKMbzYLMImQ/Lg7nG5asLpNChpnBnj/HzvoZQi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1uNnD/lxwNkxQRGdH0WgZjrsxZ8ZxQPzJsovRRGBWMbCAq7IxwfIKDYvEPwyvh590l/xS29pEkmWdiwdXNVoBndZkpGGzWyD2PH1sFMUovQPa0rDxCBlV3jmtc5tpXglkxoN1cTIzVSitjYHySfOk6Qx7KNOJiRS8itFWbYuG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLgfzilI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLgfzilI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774472367; x=1806008367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IvIVkKMbzYLMImQ/Lg7nG5asLpNChpnBnj/HzvoZQi4=;
  b=XLgfzilIhc3hksFsFo/Gj1vw9gWvHvvMESzr3aSg4dTkGbuaNBZG+jf0
   7NNJBvh1pcKYlCsoZIAXo1e+telDfcEuf1VbTuyHHX+5LC2gbvo8Opb/t
   vP4q125UevUmuMvOwHgPq5EDEaOfSKCuuV/Qf2T7dP3yBKub/b9nRXEoP
   UwsuWIIDP1eo13m+2gU5mQzIGKYQ80aP+7NIvhmDcGNYQsraSKlAtLPcc
   ogbmT6E+XEqfEls2HND+5Z/nkWzRUmfv5ODnxD60A69kBNGzkCUoHni/Z
   raN0tI0ixXp89ABKNGk3zjbKbU3svlr/wXwu1TYrSMYtqFa410nXwVzUJ
   A==;
X-CSE-ConnectionGUID: yAb1lDaGQFy6R/M/e5hD5Q==
X-CSE-MsgGUID: mzLn1EAsQ9mdiUncP04DjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="63071483"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="63071483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:59:25 -0700
X-CSE-ConnectionGUID: As7my73ZQBKUwyGaZJ4JEQ==
X-CSE-MsgGUID: I8T2eRnoSUeNuAIfwG0O+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="225053773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:59:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 13:59:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 13:59:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 13:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5d6Kja1WNAr1+sLlsRcpgbhxB6ZOS0hsEV3Cj14e2YVukfnoraHndoJBKcxXz8rVrnfsKeJH/VxdMoIsHgvlFHt5oULm8ST1pOQp5/cI2NjLHlvH8znobAxCuFIXvr08hVWiQiie/d0IERR2WKw01J5btGawBIR/uiz46hfQAr4b2bJLETSKhU78dnQivW1drwXczirFgnvHAEeHN3EIHJskgweV5gJqnPDQn+jvxpRHqe9vyRlgb/uJ/7Nwlsm5ebliXzuG/11cdmQhfEWx7W3muAkJ0gRnNsVva2KJhRnrYlWVBtksMuI7wsdo2D1DtkE4oJsxOazSOGVGt64SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvIVkKMbzYLMImQ/Lg7nG5asLpNChpnBnj/HzvoZQi4=;
 b=Ty4TxMfhx+J2XPwJgtGPPVQEaGVsffylijx9oC++402Vd3B5hhHzKdLZ3MHm7/yKNaeLKF9DxJBE4DCGafxglqYQB0Gf0kmVwPu8s3rzW7pvUT+4Zyl/DQCJ+UsFIMnVQr+nRTpXPYNYxPg0262GNpPN/nuC//vLwAtC7GIwIM1Q7dvMC8krPMerW7RP4dj8ekm0iPM90jm1V6SkFgw5Kk96YIems5eEHSKSdhidOZTcjA1VBR3nHySYAFN+njXDb4rtH96jzFSTnGdI1Q4UcIibj1zhM2gjc0hdfstDn2wRjUp1DH+uCUh+BC7e+T4/BkjM2aBvUOLCZe29+Qm+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH3PPFD9B78DE02.namprd11.prod.outlook.com (2603:10b6:518:1::d53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 20:59:14 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 20:59:14 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH] tools/perf: Fix ratio_to_prev event parsing test
Thread-Topic: [PATCH] tools/perf: Fix ratio_to_prev event parsing test
Thread-Index: AQHcu90kFo6fDchJVUekOuo0aa+vjbW+kqKAgAEqFwA=
Date: Wed, 25 Mar 2026 20:59:13 +0000
Message-ID: <1fe2ac2d57eea129017cb292c804a33f232ae0ea.camel@intel.com>
References: <20260324222517.18848-1-thomas.falcon@intel.com>
	 <997b6291-7429-4eaa-8467-1fd88e100616@linux.intel.com>
In-Reply-To: <997b6291-7429-4eaa-8467-1fd88e100616@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH3PPFD9B78DE02:EE_
x-ms-office365-filtering-correlation-id: 3260b25d-15a1-41fc-dbe7-08de8ab15eee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 2SePCZZp1qrAVuNoFTU5tqLmJaFc81tc1WdDuqi2zSUMIDH9VicaZ4D4CLQb6Oh+hMM0KkznGOdT1WY33WpFZEtJlXwSXh350q1PMt9EHxJsRY0/oT+u5HVi/E8+q54k4088mO1sDH1v4RhffXF5G356atOlNyMe0mXnZivxncB9Rw3C6RGjINuSQvwXPSzzrWv+H7j/EIqMbJ4rvyvQeNPaQ4dF+GAoP612qMZp1YIKJti/Gsiaxcyc5Xr8X0uQmeiph5AMGtqX85jKScEHkE3zwxgVT6GXJ314edTeV2htGbiI+TK5/07uRyI1OBu/6W9G5XLIhNzsH7RipU7BuC7Dacvy4VbfK6u3KOudsGNNRkMVe3x5uzV9JveYJ9wtfw1Wk/YjLiG+VH2HILIXxGTzu0yY9itLuykLOfZ8Jw0w1DrEWcTO9j4Rk+obRW0lxyNCnVQ5D76k6N9c7Vr5eY5Snt62hR3ViPR9bdYpsu4MNaxe3XKP4kJm6VjlkFx/GjtD/cTzHkdIWHAvmkoM6WEQGDP3vnZGEO2k6S3I6a1+HXFmaQfpaBz+keteHm8MOWn1oXdr9ZFsr/e+d0QffMsYMhjQ56MCcwk6okkAPhJ9M/vZTpqnityJknkWek+jV/I839asuTWWHWx1MMrAEtXRLyyyzyUKoW/298s6Ph/OSyt68Hcj5OmXRNuC960VczTQ2o6NREort2mVi3qw2cniMET1otz6QtjNcY2Jh5UT5VXpnSii9N6L8Nf7cWE/2g+bLrVSzliNEPWyg6J5OWbT9sfcE7GID5OsKI8j9Fw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2Z3QlFtTzg5UGorV1ZTbVc0Yzh1VjAwa1ZYRXVBSExlNWJoWWp4dm1uWW94?=
 =?utf-8?B?V1A0QjhIQ3dEdmF1elF5SlZRaUJ3NU1zNTRwbmUwczNpaysvS0hUQitQR0Ex?=
 =?utf-8?B?WmxUcDZvOGZ0a0hXQ0NSN3Y4bVBwTUZMaXlTMEozU3JTdzQydTR0SXFNR0x6?=
 =?utf-8?B?b0FNYU5WUnlNWFFkVm5KZE5xaWNMMVFXMkdDYkIzbExudGsyZEtJQTlHNUdX?=
 =?utf-8?B?TGQxZ0c4Z2JJOXhJNytmb0ViQnN5QnE0akp1T3crSTR3anBGK0R0bzBzNDZH?=
 =?utf-8?B?ZGk2UnpTYW5kUm9ncW9TZ3pITHpuRDJLOGhKMjlkVUdXSzhTZlo2WkZkN2Zz?=
 =?utf-8?B?Rk9ERDJyVEN1aXZieisrajRLaEdWQnhiZ2MrdkVNWjFHdjdXU1Ayd1V0ZkdZ?=
 =?utf-8?B?QUs1NTN1UVN4T09tY1JPVlVZM3duNkRoUjlQTXZKMDlNZlI4SVJKVnFHdW0w?=
 =?utf-8?B?Q3Z5eUtva3Z1SUM3V0tGdEwxRjhlWXppNkZIdkZVeFV6V1FGYXYvUFFXaW1N?=
 =?utf-8?B?WkRsVEFYTCtkRkNsUDFya0RDMmtlN2xsZi91RlRQVlBoSzl4b2pBMGh0VFVI?=
 =?utf-8?B?SjRFdjY4YWtwd1ZZV0lJVzdHQW1UcXN4QlZLZDZXU3RCNmhTTDhlQjlxbjBU?=
 =?utf-8?B?Q0ZpY1pYZzE5SFgyMUtBQ09vdGxNNGs1Mi8vR2hpOXpPS2x1cW01TlRMSDVt?=
 =?utf-8?B?ZFk5VXgrREMvdGJwcXZEUDhOK0dyKzd1THFDRnhyTExJeWNKWVEvbmI5d09x?=
 =?utf-8?B?bmZnTmFRcGRLUXlOV0pna3h1NWZwekFpc2dUQ2tpbE8yem8zbm4rSXU3bDkw?=
 =?utf-8?B?UjdGb2V0YWRPblk5enFTSHNyWm1FM1dOKzhpOThZZ0lQRWVEYzY0bHdabGFy?=
 =?utf-8?B?RWRNMHhHajZoa2RXT0haazdCU2FETTFKTFR3MEZMZENXLzRVM04za2FxTzVE?=
 =?utf-8?B?ZDNmZmc4V0h6cHBtSkZwVGxUZkNBVWVXaDgrOXN5VlFkeWE1M3lFNERFTko5?=
 =?utf-8?B?T0pMU3dYcVNuWEZyR3RwWGZ6Zk5pTXR0QlVYdTc2ZVlKV1UxNTVOcjRBWkgw?=
 =?utf-8?B?WnJsanJLTGhFb1VhN3ZERjVYdUhveVRnZ0o2VEt3cjh3a3BxeDZGS0NYZkVB?=
 =?utf-8?B?YndvSVU1bi9PTjIyTFNyVGQyTGFnVzF3VzBycURQNzY5bEFCMUtmb0tlRmpB?=
 =?utf-8?B?YnhySytIK29nYmpENkVMbmNnOVVraEVJeGFhbFBlYTdGZ1Y5NFYwR0c5UFNm?=
 =?utf-8?B?S29QWG5nMjltbnVlSThiRDBCRjAwN0Y1cW4zbVU4QzNqSUVqMlBlcVdBdVR0?=
 =?utf-8?B?NDFqNVJkN1V4aEdCekFmNmo3Q3NXVVFrWWpZN3hwbFFjLytia1lSNU1HdzB4?=
 =?utf-8?B?M0VFWlIra1NZVDJHZ2pGcE1qWG9YbGh5V25QZnVoTkRsMllXcXMrT3NTVnM5?=
 =?utf-8?B?T0FlTEdUaHdsajhjQTQ4SGZ2NlphcWRmNkxDQnlUS3NoeDhZS01XeC9ieW5U?=
 =?utf-8?B?SE5UY0FKV2pzYncrT0FMdzhlZTdHT280TzJsMmFYRktzTU9OY0xtWXVDTjhn?=
 =?utf-8?B?N3k3dkFzTEhkOW1tSG80TXZYZVVjQ0o4VDVLYnNFbEF6VEM0M0hKSmdwS0Ri?=
 =?utf-8?B?Ly9lcW5ISWtBNWpyTGFQRkl5eXAwY3dLdTMyWnd6a1JZdko5N1pYcTJoOENx?=
 =?utf-8?B?dWpxK2hjMmpMNzFwQTdjNE9EdWpRS2E3ODB1dDRWNU1va1FYcEVBWDlMSHho?=
 =?utf-8?B?dDBPVkZ4YVNqT2lnMStOSXpaRFlJM0FlczdYVS8zYVQ3RlRRUkY3Vzhob1py?=
 =?utf-8?B?L1c1NUF6andlekpudnc3UkhyazgwLzU3U2o1eThVeXlWMzQ1M0p6VjYzTmpT?=
 =?utf-8?B?akFjd3VaSm1BUHFTZlhYMlNZbXNMY05Mc2lUcU5JRzdTa1ZGYUxXYzQydG15?=
 =?utf-8?B?b1VMV1R3dWZyQTRzSm4vYUMyenpOcmZSWEVWRWd4bkMzNzdOdm9EWlFjRG5K?=
 =?utf-8?B?UmoyUks4c0wxc1RLTmt6MHFoZHhzN2xHV2pOYnVJT25sT0Q4SW4zNERvTWJH?=
 =?utf-8?B?czVLNUF6alZHUXg5dUtqMk5KOHpxYS9RckRVb214QXIyL3pyaEx4SVk4MXNk?=
 =?utf-8?B?UC9tblBncFhtWkd0NGVqSFhBa1RXS3FqRGVWa2psSGRQSHJyd0NYRzhRMkwx?=
 =?utf-8?B?OVlINE1mSWdrZ1NZQ05EdUNFZHE2Rm9hNEZ0SlpFYlZPdkt5QWM3NFcxU0Rw?=
 =?utf-8?B?QXZMMk9Vd1JIdkpFTXN2c0pMZG1KZXNHZnRSeFVFbWhrRUc4ajVTZlRhblBh?=
 =?utf-8?B?SHBzZnVZek5NRFd2SUIxaWdid3hlbFNPUzN1bjRXZ2k4cWx2Y3gyWWlwWGdz?=
 =?utf-8?Q?DDhm4mxBpurdURVGEKNLe3f7cJEny248ZEj5tNytSujwn?=
x-ms-exchange-antispam-messagedata-1: oMYn9VKGGal57ICgDBspfrtXfQ5fmK7Zee0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E00C2EE49811C04A99B3766EFF49D1E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B6tJzhwSYE1EtX7WutqDpp4MWZL4TAfIufzKQUeccgIkTLEpj7dQK3VHizfXiSlBDu/tb9EeG1dZqchT4rzD/5acAq0Udkz53H1KjlWpW3fgzTrxkGMUSQ7yffY166vgw7620cHXRIKRdZ6jE+s6DNqD4V36mWN4WoNAEkY6pD6yN1Yi7JC8NZ+/W+0LrazUpzXmaoKRu5Ep+jRrNXoBTe8vnat2u6NRhr7x/Lnd6p24M8cnpiIJWKO+nNVzO96wXg1ANjGuOTuOrD9hxJCJws6ZfUUpe2FigBwXa3K2+U8bl6NHpG8MAYFc6Gp/JCmEYvdzl71EAp1H9Ga6q1O/GA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3260b25d-15a1-41fc-dbe7-08de8ab15eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 20:59:13.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1bGJUSX62xqA/+5eVG0b8dtShbXzesz+sN4tJ2FGnFxcSQ7fPzafour87d11iCh1DVCqU2ubg1kenPif1dVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD9B78DE02
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAzLTI1IGF0IDExOjEyICswODAwLCBNaSwgRGFwZW5nIHdyb3RlOg0KPiAN
Cj4gT24gMy8yNS8yMDI2IDY6MjUgQU0sIHRob21hcy5mYWxjb25AaW50ZWwuY29twqB3cm90ZToN
Cj4gPiBGcm9tOiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCj4gPiAN
Cj4gPiB0ZXN0X19yYXRpb190b19wcmV2KCkgYXNzdW1lZCB0aGUgZmlyc3QgZXZlbnQgaW4gYSBn
cm91cCBpcyB0aGUNCj4gPiBsZWFkZXIsDQo+ID4gd2hpY2ggaXMgbm90IHRoZSBjYXNlIHdoZW4g
dGhlIGV2ZW50IGlzIGV4cGFuZGVkIGludG8gdHdvIGV2ZW50DQo+ID4gZ3JvdXBzDQo+ID4gb24g
aHlicmlkIFBNVSdzIHdpdGggYXV0byBjb3VudGVyIHJlbG9hZCBzdXBwb3J0LiBUaGlzIHBhdGNo
DQo+ID4gdXBkYXRlcyB0aGUNCj4gPiB0ZXN0IHRvIGl0ZXJhdGUgb3ZlciB0aGUgZXZlbnQgZ3Jv
dXAgZ2VuZXJhdGVkIGZvciBlYWNoIGNvcmUgUE1VLg0KPiA+IEFsc28NCj4gPiB1cGRhdGUgIndy
b25nIGxlYWRlciIgdGVzdCB0byBjaGVjayB0aGF0IHRoZSBzdWJvcmRpbmF0ZSBldmVudCBoYXMN
Cj4gPiB0aGUNCj4gPiBjb3JyZWN0IGxlYWRlciBpbnN0ZWFkIG9mIGNoZWNraW5nIHRoYXQgaXQg
aXMgbm90IHRoZSBncm91cCBsZWFkZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVGhvbWFz
IEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQo+ID4gRml4ZXM6IDU2YmUwZmU1ZjYy
YyAoInBlcmYgcmVjb3JkOiBBZGQgYXV0byBjb3VudGVyIHJlbG9hZCBwYXJzZQ0KPiA+IGFuZCBy
ZWdyZXNzaW9uIHRlc3RzIikNCj4gPiAtLS0NCj4gPiDCoHRvb2xzL3BlcmYvdGVzdHMvcGFyc2Ut
ZXZlbnRzLmMgfCA0NSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+IC0tLS0NCj4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9wYXJzZS1ldmVudHMuYw0KPiA+
IGIvdG9vbHMvcGVyZi90ZXN0cy9wYXJzZS1ldmVudHMuYw0KPiA+IGluZGV4IDFkM2NjMjI0ZmJj
Mi4uY2Q0OGU2YjJiYjU3IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvcGFyc2Ut
ZXZlbnRzLmMNCj4gPiArKysgYi90b29scy9wZXJmL3Rlc3RzL3BhcnNlLWV2ZW50cy5jDQo+ID4g
QEAgLTE3OTYsMzEgKzE3OTYsMzggQEAgc3RhdGljIGJvb2wgdGVzdF9fYWNyX3ZhbGlkKHZvaWQp
DQo+ID4gwqANCj4gPiDCoHN0YXRpYyBpbnQgdGVzdF9fcmF0aW9fdG9fcHJldihzdHJ1Y3QgZXZs
aXN0ICpldmxpc3QpDQo+ID4gwqB7DQo+ID4gLQlzdHJ1Y3QgZXZzZWwgKmV2c2VsOw0KPiA+ICsJ
c3RydWN0IGV2c2VsICpldnNlbCwgKmxlYWRlcjsNCj4gPiDCoA0KPiA+IMKgCVRFU1RfQVNTRVJU
X1ZBTCgid3JvbmcgbnVtYmVyIG9mIGVudHJpZXMiLCAyICoNCj4gPiBwZXJmX3BtdXNfX251bV9j
b3JlX3BtdXMoKSA9PSBldmxpc3QtPmNvcmUubnJfZW50cmllcyk7DQo+ID4gwqANCj4gPiAtCSBl
dmxpc3RfX2Zvcl9lYWNoX2VudHJ5KGV2bGlzdCwgZXZzZWwpIHsNCj4gPiArCWZvciAoaW50IGkg
PSAwOyBpIDwgbnVtX2NvcmVfZW50cmllcyhldmxpc3QpOyBpKyspIHsNCj4gPiArCQlldnNlbCA9
IGxlYWRlciA9IChpID09IDAgPyBldmxpc3RfX2ZpcnN0KGV2bGlzdCkgOg0KPiA+IGV2c2VsX19u
ZXh0KGV2c2VsKSk7DQo+IA0KPiBjb3VsZCB3ZSB1c2UgdGhlICJsZWFkZXIiIHRvIHJlcGxhY2Ug
ImV2c2VsIiBmb3IgYWxsIHRoZQ0KPiAiVEVTVF9BU1NFUlRfVkFMIg0KPiBvZiBjeWNsZXMgZXZl
bnQ/IFRoYXQgbWFrZSBjb2RlIGxvb2sgbW9yZSBjbGVhcmVyLiBUaGVuIHRoZSBhYm92ZQ0KPiBz
ZW50ZW5jZQ0KPiBjYW4gYmUgc2ltcGxpZmllZCB0byB0aGlzLA0KPiANCj4gYGBgDQo+IGxlYWRl
ciA9IChpID09IDAgPyBldmxpc3RfX2ZpcnN0KGV2bGlzdCkgOiBldnNlbF9fbmV4dChldnNlbCkp
Ow0KPiANCj4gYGBgDQo+IA0KDQpIaSBEYXBlbmcsIHRoZSBjdXJyZW50IHBhdGNoIGZvbGxvd3Mg
YSBzdHlsZSBzaW1pbGFyIHRvIHNvbWUgb2YgdGhlDQpvdGhlciBldmVudCBwYXJzaW5nIHRlc3Rz
LCB0aG91Z2ggSSBkb24ndCBzZWUgd2h5IGl0IGNvdWxkbid0IGJlDQpzaW1wbGlmaWVkIGluIHRo
aXMgd2F5LiBJIHdpbGwgc3VibWl0IGEgdjIgd2l0aCB0aGUgY2hhbmdlcyBzb29uLg0KDQpUaGFu
a3MsDQpUb20NCg0KPiANCj4gPiDCoAkJaWYgKCFwZXJmX3BtdV9faGFzX2Zvcm1hdChldnNlbC0+
cG11LCAiYWNyX21hc2siKSkNCj4gPiDCoAkJCXJldHVybiBURVNUX09LOw0KPiA+IMKgDQo+ID4g
LQkJaWYgKGV2c2VsID09IGV2bGlzdF9fZmlyc3QoZXZsaXN0KSkgew0KPiA+IC0JCQlURVNUX0FT
U0VSVF9WQUwoIndyb25nIGNvbmZpZzIiLCAwID09DQo+ID4gZXZzZWwtPmNvcmUuYXR0ci5jb25m
aWcyKTsNCj4gPiAtCQkJVEVTVF9BU1NFUlRfVkFMKCJ3cm9uZyBsZWFkZXIiLA0KPiA+IGV2c2Vs
X19pc19ncm91cF9sZWFkZXIoZXZzZWwpKTsNCj4gPiAtCQkJVEVTVF9BU1NFUlRfVkFMKCJ3cm9u
ZyBjb3JlLm5yX21lbWJlcnMiLA0KPiA+IGV2c2VsLT5jb3JlLm5yX21lbWJlcnMgPT0gMik7DQo+
ID4gLQkJCVRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgZ3JvdXBfaWR4IiwNCj4gPiBldnNlbF9fZ3Jv
dXBfaWR4KGV2c2VsKSA9PSAwKTsNCj4gPiAtCQkJVEVTVF9BU1NFUlRfRVZTRUwoInVuZXhwZWN0
ZWQgZXZlbnQiLA0KPiA+IC0JCQkJCWV2c2VsX19tYXRjaChldnNlbCwNCj4gPiBIQVJEV0FSRSwg
SFdfQ1BVX0NZQ0xFUyksDQo+ID4gLQkJCQkJZXZzZWwpOw0KPiA+IC0JCX0gZWxzZSB7DQo+ID4g
LQkJCVRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgY29uZmlnMiIsIDAgPT0NCj4gPiBldnNlbC0+Y29y
ZS5hdHRyLmNvbmZpZzIpOw0KPiA+IC0JCQlURVNUX0FTU0VSVF9WQUwoIndyb25nIGxlYWRlciIs
DQo+ID4gIWV2c2VsX19pc19ncm91cF9sZWFkZXIoZXZzZWwpKTsNCj4gPiAtCQkJVEVTVF9BU1NF
UlRfVkFMKCJ3cm9uZyBjb3JlLm5yX21lbWJlcnMiLA0KPiA+IGV2c2VsLT5jb3JlLm5yX21lbWJl
cnMgPT0gMCk7DQo+ID4gLQkJCVRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgZ3JvdXBfaWR4IiwNCj4g
PiBldnNlbF9fZ3JvdXBfaWR4KGV2c2VsKSA9PSAxKTsNCj4gPiAtCQkJVEVTVF9BU1NFUlRfRVZT
RUwoInVuZXhwZWN0ZWQgZXZlbnQiLA0KPiA+IC0JCQkJCWV2c2VsX19tYXRjaChldnNlbCwNCj4g
PiBIQVJEV0FSRSwgSFdfSU5TVFJVQ1RJT05TKSwNCj4gPiAtCQkJCQlldnNlbCk7DQo+ID4gLQkJ
fQ0KPiA+ICsJCS8qIGN5Y2xlcyAqLw0KPiA+ICsJCVRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgY29u
ZmlnMiIsIDAgPT0gZXZzZWwtDQo+ID4gPmNvcmUuYXR0ci5jb25maWcyKTsNCj4gPiArCQlURVNU
X0FTU0VSVF9WQUwoIndyb25nIGxlYWRlciIsDQo+ID4gZXZzZWxfX2lzX2dyb3VwX2xlYWRlcihl
dnNlbCkpOw0KPiA+ICsJCVRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgY29yZS5ucl9tZW1iZXJzIiwg
ZXZzZWwtDQo+ID4gPmNvcmUubnJfbWVtYmVycyA9PSAyKTsNCj4gPiArCQlURVNUX0FTU0VSVF9W
QUwoIndyb25nIGdyb3VwX2lkeCIsDQo+ID4gZXZzZWxfX2dyb3VwX2lkeChldnNlbCkgPT0gMCk7
DQo+ID4gKwkJVEVTVF9BU1NFUlRfRVZTRUwoInVuZXhwZWN0ZWQgZXZlbnQiLA0KPiA+ICsJCQkJ
wqAgZXZzZWxfX21hdGNoKGV2c2VsLCBIQVJEV0FSRSwNCj4gPiBIV19DUFVfQ1lDTEVTKSwNCj4g
PiArCQkJCcKgIGV2c2VsKTsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFRoZSBwZXJpb2QgdmFsdWUg
Z2V0cyBjb25maWd1cmVkIHdpdGhpbg0KPiA+IGV2bGlzdF9fY29uZmlnLA0KPiA+ICsJCSAqIHdo
aWxlIHRoaXMgdGVzdCBleGVjdXRlcyBvbmx5IHBhcnNlIGV2ZW50cw0KPiA+IG1ldGhvZC4NCj4g
PiArCQkgKi8NCj4gPiArCQlURVNUX0FTU0VSVF9WQUwoIndyb25nIHBlcmlvZCIsIDAgPT0gZXZz
ZWwtDQo+ID4gPmNvcmUuYXR0ci5zYW1wbGVfcGVyaW9kKTsNCj4gPiArDQo+ID4gKwkJIC8qIGlu
c3RydWN0aW9ucy9wZXJpb2Q9MjAwMDAwLHJhdGlvLXRvLXByZXY9Mi4wLw0KPiA+ICovDQo+ID4g
KwkJZXZzZWwgPSBldnNlbF9fbmV4dChldnNlbCk7DQo+IA0KPiBhbmQgaGVyZSwgdGhlIGNvZGUg
bmVlZHMgdG8gYmUgY2hhbmdlZCB0bw0KPiANCj4gYGBgDQo+IA0KPiBldnNlbCA9IGV2c2VsX19u
ZXh0KGxlYWRlcik7DQo+IA0KPiBgYGANCj4gDQo+IA0KPiA+ICsJCVRFU1RfQVNTRVJUX1ZBTCgi
d3JvbmcgY29uZmlnMiIsIDAgPT0gZXZzZWwtDQo+ID4gPmNvcmUuYXR0ci5jb25maWcyKTsNCj4g
PiArCQlURVNUX0FTU0VSVF9WQUwoIndyb25nIGxlYWRlciIsDQo+ID4gZXZzZWxfX2hhc19sZWFk
ZXIoZXZzZWwsIGxlYWRlcikpOw0KPiA+ICsJCVRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgY29yZS5u
cl9tZW1iZXJzIiwgZXZzZWwtDQo+ID4gPmNvcmUubnJfbWVtYmVycyA9PSAwKTsNCj4gPiArCQlU
RVNUX0FTU0VSVF9WQUwoIndyb25nIGdyb3VwX2lkeCIsDQo+ID4gZXZzZWxfX2dyb3VwX2lkeChl
dnNlbCkgPT0gMSk7DQo+ID4gKwkJVEVTVF9BU1NFUlRfRVZTRUwoInVuZXhwZWN0ZWQgZXZlbnQi
LA0KPiA+ICsJCQkJwqAgZXZzZWxfX21hdGNoKGV2c2VsLCBIQVJEV0FSRSwNCj4gPiBIV19JTlNU
UlVDVElPTlMpLA0KPiA+ICsJCQkJwqAgZXZzZWwpOw0KPiA+IMKgCQkvKg0KPiA+IMKgCQkgKiBU
aGUgcGVyaW9kIHZhbHVlIGdldHMgY29uZmlndXJlZCB3aXRoaW4NCj4gPiBldmxpc3RfX2NvbmZp
ZywNCj4gPiDCoAkJICogd2hpbGUgdGhpcyB0ZXN0IGV4ZWN1dGVzIG9ubHkgcGFyc2UgZXZlbnRz
DQo+ID4gbWV0aG9kLg0KDQo=
