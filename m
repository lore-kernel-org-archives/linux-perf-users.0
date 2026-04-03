Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0D32C924;
	Fri,  3 Apr 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244057; cv=fail; b=hL5Ojxs/RH6y65A0qsbNoMKqtELwSw9sEl+BSBcu0ORN/X0Rqr5HSdhg+UGeeDSi9ewkziKeS3QuQ/c+SkRElVdZHH2xJA+Ysbp2aQMOxi5jeB/bZCAsNQoyd+WDoc4FmRQYz1iWsBhvsVRwzdO/5fTiUh0ldhBHr6pkcb18yEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244057; c=relaxed/simple;
	bh=+sY+iTU4aJFl/mG3DRRm+7uISDJ8NLlVZUZniqawrSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFqK9sO8ke/BoHD2ogBjtmCb9jiyQI9u8+XWC5OImEiPi+BnJfvRGZJL+hlnoJ9CKSa9N9Zz2lBI4/4pa2MCCanAT+u6ACR7Upz9Q+tp+lmYiqiscnO7juWUl00LfvEz9h1xufLvvzgLErw0CVv+2iIi2c54Nxl3SfqMAVOxys0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRfYmZ8u; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRfYmZ8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775244053; x=1806780053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+sY+iTU4aJFl/mG3DRRm+7uISDJ8NLlVZUZniqawrSI=;
  b=lRfYmZ8u92EWGGDCZ1aK8X5QrcEAfRTuqUUeEpx0Mvpqql7bZl+qgKwK
   od+/tAF6kgVeFw3Mwvml46yvZbCK2X2iXGittvnm8SNokvbsH1Z0rwIW+
   erK+nKnf45hmLIzMSrvz5J+PYhu4IemuiVsl0i/54mamJuR7ngJ0bSuHF
   9te0FvXFsU684eNJUhpZzCHzHrUUg+oHPzRcLIdNeSI8ZJnfOjyV7+vRs
   JOj1rYNMNUFrVGI7VSqG6qIKmyvljAfKM1yK96FhKCIqvnEhQ80COlO14
   bx5CRPyb1iq54Ff0QoXqXQOpn7W7I0CSAw/g82uRmYv8fMUtfhoD2Afhf
   A==;
X-CSE-ConnectionGUID: NT6IgLYISZaqjuRrJod1uQ==
X-CSE-MsgGUID: Ca8QuO5oT+yMRi4xmtJ53A==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="80161566"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="80161566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:20:53 -0700
X-CSE-ConnectionGUID: bYhVrTSsSA2mdZPxEpOVWA==
X-CSE-MsgGUID: bQvUSa4DQ0SUkQM5t9MMig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="226321389"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:20:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:20:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 12:20:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 12:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv5qvBZzOHu1PEYs2nISHVTrzg7UyUhXrJMg30tK+PH/j/TkEApLYG7zH1phxlUaiP096BjVTqmRsBDRXkmkEGEOOFTWl6TcpA4r4f8s2nPXb12vbNmatNIwRFzII2hmZuW6MoKYR5O7jalEKDO0FipIEkIi9h+9ElxrFPY4Lp7QcuXU01zjis1As2yizlVhliVbBT+UKNRPPNMpe/NurNdLGppzamZACl5o+EXwDYujMGR39Xt4hRUnwbAp3bzX+RhIqIlP4G64oWjKxnWYbDzRhp051JV4BlY9IYjqBqGnAx91b49ejMYk9toPt3DcZprFoimm7syT8TzsGuxkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sY+iTU4aJFl/mG3DRRm+7uISDJ8NLlVZUZniqawrSI=;
 b=YHlwuvuTz+sv74bjzeWdeVj0T07x0VZIv/H0332SGqhmpFE40QoBNSAarm2nAV6ucbjkhE4SfcgyaKY5eGEHzRO8+b9PEdrxdOHf9b1ZKz5AAYGJk7EOsgb8ObIqc9MvasSWyxrZKuuoG+IRXsE+gLpD4zTucT9RTksH8G0dxOB3+09eB1JlCgtLpVolJ7W2vZ9pGQFP/6DjJEu2kzeD7azLovn4LLOPK2vI/EjfqaA+nxzDsSYLW9scuuQfW5jGpe2ei6EB8OzTt4VVIcsJ0z5C3JLew2SriWVwWYipL5vV1xUnoBbJq1Lyhpe/C7vls/+qS2KyfWX62d0aKfS0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM4PR11MB7279.namprd11.prod.outlook.com (2603:10b6:8:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 19:20:49 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 19:20:49 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>
CC: "james.clark@linaro.org" <james.clark@linaro.org>, "mingo@kernel.org"
	<mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2] perf test: Fix perf stat --bpf-counters on hybrid
 machines
Thread-Topic: [PATCH v2] perf test: Fix perf stat --bpf-counters on hybrid
 machines
Thread-Index: AQHcvHv7awse+A0TekSBbpIx1YuFELXNxPqA
Date: Fri, 3 Apr 2026 19:20:48 +0000
Message-ID: <76987cb602dfb8959e2d2a3c31b59770cf9ac84f.camel@intel.com>
References: <acOI-3Rtjys7JPyl@google.com>
	 <20260325171653.1091337-1-irogers@google.com>
In-Reply-To: <20260325171653.1091337-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM4PR11MB7279:EE_
x-ms-office365-filtering-correlation-id: c9a25a60-a5fc-41bd-6030-08de91b61cd1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8UkvcYrgOxjpJdDPF6AU5XpjdQX0shSdNEqzXh3C4JTrKf9zNKnHjq/G7CKHRuVGex97TlV+IKe3QCNa1fG6UrsgVb6rC/qzTJBEvqbRFlZCOb8xty7YFS1N7RoH6quwuA/1oEbAsTl6K3J4Uo2Y+3DMm1p9QjahFEgDIj6NFsEo3KROM7urap2js1Rvju3MppedCA6oJBOb37FQXJ/hB3MgueTVGXVF5onMrZvBms6WYrS1+RW349PY1DdgO8FSB7hDtxyn8NSu6rWuxAnAXcrtY2O+P1sopzPvX7qWaN9GxNNR4twk8iuKbHpwLHQ1THVfywlnay4eN3oFmaOfx7m1ATio1iFZmlzz/rPEFOriLhzyCARMbr7d8OHiXrOSpT/aMiVnti8ZhdsthftZv5ILdjd7E4L56F0sgERGxXLEdqztkDkrvWGtiIpuu+zd2w7W9qu8Hj1s+ooAbvjMWlrtiuhrVKfbfsMB8p2wrAMZrPRqBX5dr7WUftfDEWFvtj+qwhzBqUq4qlotdu4zBcq0cj1bvID1NdYC3UUIL7fuMJ1CwD9wXWE7gwdDyQ2Hg0FyXdW35dMtcKJ4KM8dgCgMxLgL2h93jXolS7jvQFDkRPYgSK5jJ70DfSranoNZN3J03Y1PUTYvBOjDjhkTas16+IVUq2UB6KWcULOik/DL7oP8NX5lhlIrjJB7YFe0Dcz7avXSEA7A0WdMCqW6jhg96mDGZnVA7TPl+8NI6YtFYDEQ5d4e6kFbdj2iE1DSUyjf2F4Xeoa88Jr62GnweFkdfZka0uRN6jAnouP6vXSPD0m8YUSWwfw6SeOPqE4B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1g0b2M3Ri9tYjdsc2I2ZWlzZEZhK1kwL2hiVUNlMld6SnZWV0FiNU01Z3hL?=
 =?utf-8?B?NjRLK0J5OFJpb0pSZzllOEZjMU5DTS9IaERvY00xMHJjcTNySXF0M2VPQnZI?=
 =?utf-8?B?SGhtTzRHWXdzR05KckJYUGNnbUtGNzZZbVlKRU0wODgySE9OamFGTE5IRVV3?=
 =?utf-8?B?dGd5bXNVOTBjQ1pMMDl1dGZ3KzR5Ti9UMXVFQ2NZekFTU2t6RU84ZjRhck4w?=
 =?utf-8?B?Q3lkaUgwUytJeFp0a2loK2k2a2lWaW9PMktzWDF4cmRLSU9ya0RwMmhBU3l3?=
 =?utf-8?B?ZEFuRTM4aTNwSzdyNndoalNEK1YzMkljeDZqNlFjMEF6WHAxdFM4TjlKd3NB?=
 =?utf-8?B?S1c0Q2RUbXJkcW4wNEl0eG9Ud1JQZG5CckczWitIeDdpdFlGT2hqQ2sxdVRG?=
 =?utf-8?B?cWg3cjdJQzFucHFNM1ptTVpXOXNEMlBVb0l6dHd5bkxRdjROQ0ZiUjJvbDB2?=
 =?utf-8?B?R3ZlZGhudzd6WW1haG5hRFFveEdYSWNlNnk4aG5XSmd5VUZPV2JxRElVWGN4?=
 =?utf-8?B?Y0V0QytLdmp6Q3F5Z1BoVXBaOGxIdSsxTEZBWW9sRGIyZWdZcXZaZy85aGdl?=
 =?utf-8?B?OTdXRmFlUXFaWnVtbExKK3prVnBmSmFrcVFIL3ZEZWFlcGJCbDU4alcwQldV?=
 =?utf-8?B?UkJoVTM5RnJ0MnI3QVU2VlRDNTB0Y3VSTE16b3puTmtYRlRjUDFCcy94MHdE?=
 =?utf-8?B?M0NHUG9ESkcvZUljRzlBWE41WXpHa1JSRXYvMHpyeEdaazl0cXhjREhaMUJZ?=
 =?utf-8?B?WXh1V0xRdXV3aUpNRDFaQU5Ja3NTYzM0Qng0WDAvYjcvVVdVQ0tiaUtPaXIv?=
 =?utf-8?B?Q3FIdEd4bk42SHR3ZTgxNVhoSmt6cGNEZldCdXpUbWpQbEJhWnFkNTlob09X?=
 =?utf-8?B?cTlXZXBmNmVHcFF6OUJBNlZQSzRvQW9wUVA0YllmY2lPZFlKUHY0VXJuQ0lt?=
 =?utf-8?B?VDkvTjBSRmpTOEI4VDFJdkI5ZUxhcXdDRmlydlNHU052SldtRzZoRlJ6cTFH?=
 =?utf-8?B?R25jcEdXZ0ZGVDlUZ1FWZG9kTEc4KzduUmJ6bjZpZXIzR3NsdWFVNVVYZHVN?=
 =?utf-8?B?Yk15RVI0dlNNbGZWYTEzYXU4VmUxeTJMQXBFYmpQRVd0QmxsVEZtVmhjcE9l?=
 =?utf-8?B?SXFWWnQ1YlBZaEpzbWpYZHBzMWtNUVZqMVB3U1g2aWdhbjFDTDFQb3dTdkxo?=
 =?utf-8?B?WUkwam5wTU1jQW1jeFBqV3V5QmZrVkp5ajRTdjM1V1hrTVR3Wi9TSmhGM09O?=
 =?utf-8?B?a1NLakw1cVR0SmdjRnhFZkg0YTVrQkw1ZXZEYy93SUtsY1RGd090RHlVR0VE?=
 =?utf-8?B?TW52aW5seUd0WEkzUUkxbFpuMzl0MlB5azV4TXhrUFhqR0JZd2dGZ2Rwdk5p?=
 =?utf-8?B?TmM4SlV2YnhhU0g3UVNqSCtUa0tYZjdEdUcvTFR0ZmVsRTZPUXpVdzhZWUNI?=
 =?utf-8?B?RllLL1M2WGUyekRFWWMyT25PU1p2TlpWZzdqNTdlUHM5dWpGcU5SZ2ZDTWRW?=
 =?utf-8?B?dmZrL0RzaExsUi9ZMVpFdzhtNjJoSUl6WlViVmNpNE8zRG1qS2NDbVpXby9u?=
 =?utf-8?B?KzZMek40U2ZBZFJjYjl1dHdjaktZUExleEw1SE1hLzVhTWU0eXV5V0xQcU13?=
 =?utf-8?B?YXZ1RE45a3BpV1BMV3FUb0J6eUd0S21ZV0tOTUp3dzZmb2lFUUlSTjhRblhR?=
 =?utf-8?B?VnhlU0FkUktzaERBdVMrc0RIYi9WU1BYeU5tandhaVVSNUVqcmZtUUFnNDBD?=
 =?utf-8?B?cGF4NUxTaXBFYjBjbk9JbkwwTlRUVXNleW95QnZMd3VWbjBSUVBxYnczek9k?=
 =?utf-8?B?UWtkekFqdHp6SzhSWG5mZWZ0dmViODQxd2x0cXcwRTltdUlKY2FSY1BtcktD?=
 =?utf-8?B?eENacTNEeklQdGwrRGtUMWNKMk84Mmt6UXN1NmJmWGJoOHRtcFY3WURvOGk3?=
 =?utf-8?B?NG1jejNlcHg4N0Q0cWZzbmRvZi84VUlkYXM3bmtHUzFHeWhpaTFaUERWQmo0?=
 =?utf-8?B?K3RVMjZIekhIcE5ocWM3dFgxMzk3NGFGck9CanZzcjJKaUNmVzI0NUZXWFFr?=
 =?utf-8?B?bUZIUHQyQ0t2QXdZSXNwTmdSSlhucXBjUGpnd3Z1UkFNTXlHc1Fzd05UL0Ns?=
 =?utf-8?B?aHk0YlhNdi85ZmJHMC84RWMyc0tlMndrOXdnb1Q0ZkdGZXlxbVlORmZjZmx5?=
 =?utf-8?B?Z3kxS05FckFBYUZpMDJkTURzenZTVUNOU0YzQmhKaU1VZzRySXZhY0ZPSlNU?=
 =?utf-8?B?bHN5S2hzRlF1NlZic3RjV1ZaR2E4QmlrSzRUR3JPYzQyU1dna3hLbTNrZnhH?=
 =?utf-8?B?THFQK2RiQTVzRTQydjF1TGZITXMrc0FRRnFpaHlRNTl1VVJWcy94U2Roa2hU?=
 =?utf-8?Q?o9GQkk0wZYEYTAR1/rauZENim8D1OdvwTou8ycqQgICvT?=
x-ms-exchange-antispam-messagedata-1: Xmlne5aQLWltm6GXNS97K0QwIGZ4Suo2yzg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0DF7FEBEF97249B965A05CDF75EACD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l/oYFTh+wdIBtJwhguaJ+uIVXUzkY8DogEf/aC0XMVxyHdueCOkuMbNk9OEMigR+QSAml+wYDW7ji1goUrIK+ndbNlyhT1Lsz67ZccgkOvLiaoF/Dgvc8x60VHkmyyxekirRlWFwsFrRA6PtpIDWXjw4q/mi7CPl74s8moXUmD4vnDo99ZVM0w3AfeNpzjOtaV2xzo+Be+UFA4XtYzJLM0KXW05xQV0lq2IXSOBsb95aRmqEqmqotZYjbtnxxq9PI7FaTHlbNdY0yOZ2+WpRYvpa0W7eriLNU9nPCyU8AlIt2+eHn7yJepe+O5YhKQZjlGMdXG7QsYL/4IKd/F9OVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a25a60-a5fc-41bd-6030-08de91b61cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 19:20:48.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9nmUVMh8+2/e66HT9Fjg63j9ChqfVaG0I5vQt03ZE0JmS3N3xqPNx7bF1olyVU1DQ2fdDrmpxF7yf73bI84tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7279
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAzLTI1IGF0IDEwOjE2IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBF
dmVudHMgb24gaGFyZHdhcmUgUE1VcyBtYXkgb3BlbiBvbiA+MSBoYXJkd2FyZSBQTVUgb24gaHli
cmlkDQo+IG1hY2hpbmVzLiBVbmZvcnR1bmF0ZWx5IG11bHRpcGxleGluZyBpbnRyb2R1Y2VzIGEg
c2NhbGluZyBpc3N1ZSBhcw0KPiByZXBvcnRlZCBpbjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDI1MDcxNjIyMzkyNC44MjU3NzItMS1pcm9nZXJzQGdvb2dsZS5jb20vDQo+IA0K
PiBTd2l0Y2ggdG8gdXNpbmcgdGFzay1jbG9jayB3aGljaCBhcyBhIHNvZnR3YXJlIGV2ZW50IHJ1
bnMgb24gYWxsIENQVXMNCj4gYW5kIGhhcyBhIHNpbmdsZSBQTVUuDQo+IA0KPiBGb3Igd2hlbiBo
eWJyaWQgZXZlbnQgc2NhbGluZyBpcyBmaXhlZCwgaW5jb3Jwb3JhdGUgc3VwcG9ydCBmb3INCj4g
Y29tYmluaW5nIGh5YnJpZCBjb3VudHMgYXMgcG9zdGVkIGJ5IE5hbWh5dW5nIEtpbSBpbjoNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI2MDMxOTA2NDUxMy45MjY5LTEtbmFtaHl1
bmdAa2VybmVsLm9yZy8NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IElhbiBSb2dlcnMgPGlyb2dlcnNA
Z29vZ2xlLmNvbT4NCj4gQWNrZWQtYnk6IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9y
Zz4NCg0KJCBzdWRvIC4vcGVyZiB0ZXN0ICJwZXJmIHN0YXQgLS1icGYtY291bnRlcnMgdGVzdCIg
LXZ2dg0KDQpCZWZvcmU6DQoNCjE1MjogcGVyZiBzdGF0IC0tYnBmLWNvdW50ZXJzIHRlc3Q6DQot
LS0gc3RhcnQgLS0tDQp0ZXN0IGNoaWxkIGZvcmtlZCwgcGlkIDQ0NDQwNg0KVGVzdGluZyAtLWJw
Zi1jb3VudGVycyBUaGUgZGlmZmVyZW5jZSBiZXR3ZWVuIDQwMDQxODE2MyBhbmQgMTE4ODY4MDU5
NDcNCmFyZSBncmVhdGVyIHRoYW4gMjAlLg0KLS0tLSBlbmQoLTEpIC0tLS0NCjE1MjogcGVyZiBz
dGF0IC0tYnBmLWNvdW50ZXJzIHRlc3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDoNCkZBSUxFRCENCg0KQWZ0ZXI6DQoNCjE1MjogcGVyZiBzdGF0IC0tYnBmLWNvdW50ZXJzIHRl
c3Q6DQotLS0gc3RhcnQgLS0tDQp0ZXN0IGNoaWxkIGZvcmtlZCwgcGlkIDQ2Njg5Ng0KVGVzdGlu
ZyAtLWJwZi1jb3VudGVycyBbU3VjY2Vzc10NClRlc3RpbmcgYnBmIGV2ZW50IG1vZGlmaWVyIFtT
dWNjZXNzXQ0KLS0tLSBlbmQoMCkgLS0tLQ0KMTUyOiBwZXJmIHN0YXQgLS1icGYtY291bnRlcnMg
dGVzdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOg0KT2sNCg0KDQpUZXN0ZWQt
Ynk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0KDQpUaGFua3MsDQpU
b20NCg0KPiAtLS0NCj4gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjAz
MjMyMDI0MDkuMTk0MTIzLTEtaXJvZ2Vyc0Bnb29nbGUuY29tLw0KPiAtLS0NCj4gwqB0b29scy9w
ZXJmL3Rlc3RzL3NoZWxsL3N0YXRfYnBmX2NvdW50ZXJzLnNoIHwgNTUgKysrKysrKysrKysrKyst
LS0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXRf
YnBmX2NvdW50ZXJzLnNoDQo+IGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0X2JwZl9jb3Vu
dGVycy5zaA0KPiBpbmRleCBmNDNlMjhhMTM2ZDMuLmY4YzI0Y2NjNzgzMCAxMDA3NTUNCj4gLS0t
IGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0X2JwZl9jb3VudGVycy5zaA0KPiArKysgYi90
b29scy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXRfYnBmX2NvdW50ZXJzLnNoDQo+IEBAIC01LDYgKzUs
MjQgQEANCj4gwqBzZXQgLWUNCj4gwqANCj4gwqB3b3JrbG9hZD0icGVyZiB0ZXN0IC13IHNxcnRs
b29wIg0KPiArZXZlbnQ9dGFzay1jbG9jaw0KPiArDQo+ICtleHRyYWN0X2NvdW50KCkNCj4gK3sN
Cj4gKwlsb2NhbCB0YXJnZXRfZXZlbnQ9IiQxIg0KPiArDQo+ICsJYXdrIC12IHRhcmdldD0iJHRh
cmdldF9ldmVudCIgLXYgaT0wIC12IGM9MCAnDQo+ICsJJDAgfiB0YXJnZXQgew0KPiArCQlpKys7
DQo+ICsJCWMgKz0gJDENCj4gKwl9DQo+ICsJRU5EIHsNCj4gKwkJaWYgKGkgPiAwKQ0KPiArCQkJ
cHJpbnRmICIlLjBmXG4iLCBjOw0KPiArCQllbHNlDQo+ICsJCQlwcmludCAiPG5vdCBjb3VudGVk
PiINCj4gKwl9Jw0KPiArfQ0KPiDCoA0KPiDCoCMgY2hlY2sgd2hldGhlciAkMiBpcyB3aXRoaW4g
Ky8tIDIwJSBvZiAkMQ0KPiDCoGNvbXBhcmVfbnVtYmVyKCkNCj4gQEAgLTI1LDE1ICs0MywxNSBA
QCBjb21wYXJlX251bWJlcigpDQo+IMKgDQo+IMKgY2hlY2tfY291bnRzKCkNCj4gwqB7DQo+IC0J
YmFzZV9pbnN0cnVjdGlvbnM9JDENCj4gLQlicGZfaW5zdHJ1Y3Rpb25zPSQyDQo+ICsJYmFzZV9j
b3VudD0kMQ0KPiArCWJwZl9jb3VudD0kMg0KPiDCoA0KPiAtCWlmIFsgIiRiYXNlX2luc3RydWN0
aW9ucyIgPSAiPG5vdCIgXTsgdGhlbg0KPiAtCQllY2hvICJTa2lwcGluZzogaW5zdHJ1Y3Rpb25z
IGV2ZW50IG5vdCBjb3VudGVkIg0KPiArCWlmIFsgIiRiYXNlX2NvdW50IiA9ICI8bm90IGNvdW50
ZWQ+IiBdOyB0aGVuDQo+ICsJCWVjaG8gIlNraXBwaW5nOiAkZXZlbnQgZXZlbnQgbm90IGNvdW50
ZWQiDQo+IMKgCQlleGl0IDINCj4gwqAJZmkNCj4gLQlpZiBbICIkYnBmX2luc3RydWN0aW9ucyIg
PSAiPG5vdCIgXTsgdGhlbg0KPiAtCQllY2hvICJGYWlsZWQ6IGluc3RydWN0aW9ucyBub3QgY291
bnRlZCB3aXRoIC0tYnBmLQ0KPiBjb3VudGVycyINCj4gKwlpZiBbICIkYnBmX2NvdW50IiA9ICI8
bm90IGNvdW50ZWQ+IiBdOyB0aGVuDQo+ICsJCWVjaG8gIkZhaWxlZDogJGV2ZW50IG5vdCBjb3Vu
dGVkIHdpdGggLS1icGYtDQo+IGNvdW50ZXJzIg0KPiDCoAkJZXhpdCAxDQo+IMKgCWZpDQo+IMKg
fQ0KPiBAQCAtNDEsMjkgKzU5LDMyIEBAIGNoZWNrX2NvdW50cygpDQo+IMKgdGVzdF9icGZfY291
bnRlcnMoKQ0KPiDCoHsNCj4gwqAJcHJpbnRmICJUZXN0aW5nIC0tYnBmLWNvdW50ZXJzICINCj4g
LQliYXNlX2luc3RydWN0aW9ucz0kKHBlcmYgc3RhdCAtLW5vLWJpZy1udW0gLWUgaW5zdHJ1Y3Rp
b25zIC0NCj4gLSAkd29ya2xvYWQgMj4mMSB8IGF3ayAnL2luc3RydWN0aW9ucy8ge3ByaW50ICQx
fScpDQo+IC0JYnBmX2luc3RydWN0aW9ucz0kKHBlcmYgc3RhdCAtLW5vLWJpZy1udW0gLS1icGYt
Y291bnRlcnMgLWUNCj4gaW5zdHJ1Y3Rpb25zIC0tICR3b3JrbG9hZMKgIDI+JjEgfCBhd2sgJy9p
bnN0cnVjdGlvbnMvIHtwcmludCAkMX0nKQ0KPiAtCWNoZWNrX2NvdW50cyAkYmFzZV9pbnN0cnVj
dGlvbnMgJGJwZl9pbnN0cnVjdGlvbnMNCj4gLQljb21wYXJlX251bWJlciAkYmFzZV9pbnN0cnVj
dGlvbnMgJGJwZl9pbnN0cnVjdGlvbnMNCj4gKwliYXNlX2NvdW50PSQocGVyZiBzdGF0IC0tbm8t
YmlnLW51bSAtZSAiJGV2ZW50IiAtLSAkd29ya2xvYWQNCj4gMj4mMSBcDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqAgfCBleHRyYWN0X2NvdW50ICIkZXZlbnQiKQ0KPiArCWJwZl9jb3VudD0kKHBlcmYg
c3RhdCAtLW5vLWJpZy1udW0gLS1icGYtY291bnRlcnMgLWUNCj4gIiRldmVudCIgLS0gJHdvcmts
b2FkwqAgMj4mMSBcDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgfCBleHRyYWN0X2NvdW50ICIkZXZl
bnQiKQ0KPiArCWNoZWNrX2NvdW50cyAiJGJhc2VfY291bnQiICIkYnBmX2NvdW50Ig0KPiArCWNv
bXBhcmVfbnVtYmVyICIkYmFzZV9jb3VudCIgIiRicGZfY291bnQiDQo+IMKgCWVjaG8gIltTdWNj
ZXNzXSINCj4gwqB9DQo+IMKgDQo+IMKgdGVzdF9icGZfbW9kaWZpZXIoKQ0KPiDCoHsNCj4gwqAJ
cHJpbnRmICJUZXN0aW5nIGJwZiBldmVudCBtb2RpZmllciAiDQo+IC0Jc3RhdF9vdXRwdXQ9JChw
ZXJmIHN0YXQgLS1uby1iaWctbnVtIC1lDQo+IGluc3RydWN0aW9ucy9uYW1lPWJhc2VfaW5zdHJ1
Y3Rpb25zLyxpbnN0cnVjdGlvbnMvbmFtZT1icGZfaW5zdHJ1Y3Rpbw0KPiBucy9iIC0tICR3b3Jr
bG9hZCAyPiYxKQ0KPiAtCWJhc2VfaW5zdHJ1Y3Rpb25zPSQoZWNobyAiJHN0YXRfb3V0cHV0Inwg
YXdrDQo+ICcvYmFzZV9pbnN0cnVjdGlvbnMvIHtwcmludCAkMX0nKQ0KPiAtCWJwZl9pbnN0cnVj
dGlvbnM9JChlY2hvICIkc3RhdF9vdXRwdXQifCBhd2sNCj4gJy9icGZfaW5zdHJ1Y3Rpb25zLyB7
cHJpbnQgJDF9JykNCj4gLQljaGVja19jb3VudHMgJGJhc2VfaW5zdHJ1Y3Rpb25zICRicGZfaW5z
dHJ1Y3Rpb25zDQo+IC0JY29tcGFyZV9udW1iZXIgJGJhc2VfaW5zdHJ1Y3Rpb25zICRicGZfaW5z
dHJ1Y3Rpb25zDQo+ICsJc3RhdF9vdXRwdXQ9JChwZXJmIHN0YXQgLS1uby1iaWctbnVtIFwNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoCAtZSAiJGV2ZW50L25hbWU9YmFzZV8kZXZlbnQvLCRldmVudC9u
YW1lPWJwZl8kZXZlbnQvYiIgLS0NCj4gJHdvcmtsb2FkIDI+JjEpDQo+ICsJYmFzZV9jb3VudD0k
KGVjaG8gIiRzdGF0X291dHB1dCIgfCBleHRyYWN0X2NvdW50DQo+ICJiYXNlXyRldmVudCIpDQo+
ICsJYnBmX2NvdW50PSQoZWNobyAiJHN0YXRfb3V0cHV0InzCoCBleHRyYWN0X2NvdW50DQo+ICJi
cGZfJGV2ZW50IikNCj4gKwljaGVja19jb3VudHMgIiRiYXNlX2NvdW50IiAiJGJwZl9jb3VudCIN
Cj4gKwljb21wYXJlX251bWJlciAiJGJhc2VfY291bnQiICIkYnBmX2NvdW50Ig0KPiDCoAllY2hv
ICJbU3VjY2Vzc10iDQo+IMKgfQ0KPiDCoA0KPiDCoCMgc2tpcCBpZiAtLWJwZi1jb3VudGVycyBp
cyBub3Qgc3VwcG9ydGVkDQo+IC1pZiAhIHBlcmYgc3RhdCAtZSBpbnN0cnVjdGlvbnMgLS1icGYt
Y291bnRlcnMgdHJ1ZSA+IC9kZXYvbnVsbCAyPiYxOw0KPiB0aGVuDQo+ICtpZiAhIHBlcmYgc3Rh
dCAtZSAiJGV2ZW50IiAtLWJwZi1jb3VudGVycyB0cnVlID4gL2Rldi9udWxsIDI+JjE7DQo+IHRo
ZW4NCj4gwqAJaWYgWyAiJDEiID0gIi12IiBdOyB0aGVuDQo+IMKgCQllY2hvICJTa2lwcGluZzog
LS1icGYtY291bnRlcnMgbm90IHN1cHBvcnRlZCINCj4gLQkJcGVyZiAtLW5vLXBhZ2VyIHN0YXQg
LWUgaW5zdHJ1Y3Rpb25zIC0tYnBmLWNvdW50ZXJzDQo+IHRydWUgfHwgdHJ1ZQ0KPiArCQlwZXJm
IC0tbm8tcGFnZXIgc3RhdCAtZSAiJGV2ZW50IiAtLWJwZi1jb3VudGVycyB0cnVlDQo+IHx8IHRy
dWUNCj4gwqAJZmkNCj4gwqAJZXhpdCAyDQo+IMKgZmkNCg0K
