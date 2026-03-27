Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18172652AF;
	Fri, 27 Mar 2026 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571887; cv=fail; b=bttuoJQofVX7fRDNHU4Rx9jCdsTRUeVUzs9/eh+V8sdYV8FveXZq7MQ9EMqgW4zGOHnusuxltou2zdVoXkHDuWAMnSNpmTmJ1QF0oT0zdCKmuAdJef1Di0wqDi2ykqDPkJfgcXxejYnOdg1VaSKYobSqmd4o7n2jc7IEgPt9/Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571887; c=relaxed/simple;
	bh=i3sSPvR1XD09mUYNcQ+AsKnTXfMymRwhRKghUs0o0/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRuoVJZuuGhcRAN8qYd8gljlQA2vxc3lU50hi3/pyELZuCC7jK83BZ5a96EdAEAloWnsRn3g+pM0EmuZuX3Lz482st95N0edfIXWgb5FmXICrAPaaxup/HANAV/BrcTHNDcemMwuNaYNoi12gqB8k7z++d/8QWln/6Dn8d8Y9+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbUH1AU8; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbUH1AU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774571885; x=1806107885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i3sSPvR1XD09mUYNcQ+AsKnTXfMymRwhRKghUs0o0/c=;
  b=TbUH1AU8yUbuBIjfghtgf1ggDWJHKh+D/sfdRIMPfm98tv0cNpumcE9D
   HJXBUHAjIhFD4Z95ThomHcdG56NiOUFpqHT5NN72WfL2NJklTs7jYvuqZ
   w4Mcyedd1Lua8w9sHz6oJIkRi0XkTSD2ix6UEgklLY0pTjPj3NyYO4Y9k
   /jf4x6KOA62SbzUqiz4CZoB5O8nLPKmK21je98WSAaq73INRL5hswcxk+
   8YQ/a0rQcnTPcpK2ZA9ZEGsVH11jISP9MGPsmdl4zWILTw5yS94fG2Hy8
   Wo1GZDbHzqrfsT4RtFbRsgTTMt0TLwt9vh5P/0MuKNVjgoLfXNq4fr/O5
   w==;
X-CSE-ConnectionGUID: 1CGAlkmSTn+s42QThARVuQ==
X-CSE-MsgGUID: Yk+aAC19QtGKJ4qMP2YHEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79501965"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79501965"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 17:38:04 -0700
X-CSE-ConnectionGUID: qSvN73MISZOOoph1LpHtjQ==
X-CSE-MsgGUID: 9fqoKuI7QhypHQ0vDCj/aA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 17:38:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 17:38:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 17:38:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 17:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6yUJJSVFj6tXcA3l7uouOSkLiRWfjPz3DiSwB+RmwLy0Fv/zT+Kq6fos0LWrX4uqvvS8ThduGxDCZthW+JB2tStVEru1RTh8hd66pEpgVPbZXmitkQF34JklytJ92d8V/xmYXIL3NCqcSzysybmzpcfIz+IosfB7Xs7ONx9geoeQ5sVtkAuskRepuKsQFkoIrS09iRmgl02Epdb68ccIvHy0nvcV5mYxzB0qsq5AS59viwU34OWWxNIaZFPpopHn22WLNxYz5BwV92mpVh6dIgymBlhwqorwt6pWJt/DRhYxzoktOvPr2ov8GI2UVUOphFGaehjfeLy7cW3wKfe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3sSPvR1XD09mUYNcQ+AsKnTXfMymRwhRKghUs0o0/c=;
 b=oNuCX+VzEaa4w8/xSeZKPIfMRRajux6q3247rv1yqhVsTYv0GVEEQT14yT8CX5rftHl4MCyBfs7iOHcO5PuoP2/21adVZ9aTqOWShAMesQ/IWqBEpo/2W+s80KwyHblCv1lv5VcREFpaHRX0XFGlNLVxRA5mBwC3wcECRNTqQXIQX8uDvwxPJvBeCtiwS/aPSFbjvNBwGlHHNy6dT4kK9MNH+wKy+7lo6NagXNcM5acgkePnbh1mx0KfbZ5zTA3INaXddqN2X3RzU0VrmexCJbgnK9CfXClP5RFt8EB+rpjVVaQNBz6bgVrhXTtjKko6NuxE5/OlcOQbbn4ZEu4mzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA4PR11MB9034.namprd11.prod.outlook.com (2603:10b6:208:567::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 00:37:52 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 00:37:52 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "Rogers, Ian" <irogers@google.com>
CC: "james.clark@linaro.org" <james.clark@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "dapeng1.mi@linux.intel.com"
	<dapeng1.mi@linux.intel.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>
Subject: Re: [PATCH v2] tools/perf: Fix ratio_to_prev event parsing test
Thread-Topic: [PATCH v2] tools/perf: Fix ratio_to_prev event parsing test
Thread-Index: AQHcvUsWGxrSmP3/NE6XGG/iUuaW37XBVYuAgAAzwAA=
Date: Fri, 27 Mar 2026 00:37:52 +0000
Message-ID: <4df1ceeb31bf34c0858b4c7d88aaf3fb1467a567.camel@intel.com>
References: <20260326180125.168536-1-thomas.falcon@intel.com>
	 <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
In-Reply-To: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA4PR11MB9034:EE_
x-ms-office365-filtering-correlation-id: 08057b58-0972-4491-c4a3-08de8b99146d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: j9C/A97G4MfIXtLYkKrC1aIC28RPpoppXnd+qPJZkLVGQZoVJI8PsxE+VFR1o2N1jDHf5gnuIaqDYhneIAq8mOETLxy4XTYUQIRhoyatjgppnmEAfs0W/wxhWLxOTxd2Wrsa0wtE4/6iNql9YO5259F8/WftCskhUp0plPyJH03Cm5oy7/FyroQhInIxFJ/2Ry+XSdRaxo3D5wlzeGypTuE4IHuBqpGnS6K30rRBG/85vuhUR5C8Ez0mNg/4kWXa9ciRYJRJJsvQmOuFM0D3jv9QBnRPzjuPFxTM4vbo0NDtxXljPJPU/uRyAmO1S9/0L39VsPU1y/nrGQQv+szh0M3+sjhjRNy0WWwdC1bRpejfAlxzgVyLSS6aLRAgYRiqb7oud6sWe/aBude62LIoNBCUHr+73vsM/0GqIWUv89D9Pss9YJRAk1RqSgH6YWufoYl3AcsIz9n3uWewlwS7zvx7Q2W0cTm0Mw7CUS4F/sCSBhD7Ka7qv0uAOz4U9wDt4WTHv+S3BMPphOvyKv2QSTn2ADs1wdJYwP4SxxZd/THAJeOZU4XgXy+1Jv8td9e34kAK+/LVhME9OHoSHg/E9cojPpkJECgQT6bvwWRZNhkFVLiQXfy9B8BQqPXDA0Ae3wt9j0P4nnCdmyRHPHAQ6XTfJyN0Fic9+ivkBTD15u9QKir5OqTupvoyli4VXDzvcFi1dfcyoutTOjTk2eR7FiX7w33Mer3ncdYA6gQ0Gco=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzhWTm1JajU3QnlBRjkzNUliMEtKNVJOaytuaFBCdXVZQ1MrQktFY3QwRlhH?=
 =?utf-8?B?dXJ4NFI5amZkQ0ZJdkdSblMzVWtPb3cvbDNxVnRYS2Ntc0lpQUhuUDIxTUk2?=
 =?utf-8?B?SGZMSnJmRmJNRDg0cnZhRXNxNDhTWUhzcGJ4eE9vYzM2cXFaT0pyalliQ0RP?=
 =?utf-8?B?dXhiK3I1ckZRb2lGNEQ3K2tHeU1GSytNNldKUDFyV3J6d1hnMjZSTWpRdWlJ?=
 =?utf-8?B?SVB3NFNnVjgvQzhnSldwVWtWb3ZhakJ5eFBPeUQ2aUZFTlpiQ3pDeXhpRlNG?=
 =?utf-8?B?SHkvMmtpa21KY1BwTXBQZFFwY21SWDFOZUxRcWxWZ3Nsa2htV1BWeDJLWFpX?=
 =?utf-8?B?SG5BenVGMVJreEladWhpd25IYURuKzByQzY3eTJueHVaWHgxYXVPcXU3UFFh?=
 =?utf-8?B?WXhJU0FVcFo3Nk8xRmpxL0tKSUY2M0tzcjVUV3J5OWI3cVlsLzlsVk5nTzlL?=
 =?utf-8?B?bms2dnEzZnFka2pzN0VrZ3pucFNKSEtiQ2E4V2xSclF0YytGTStEQjRURmdY?=
 =?utf-8?B?anFTa2FwdkRYc2ozNm1hcHB3TFc1Tk9veXhjbHFZcVFKWTRJUE1QNWE5aHFT?=
 =?utf-8?B?VDhBWHgxK1NRYnNVMFNWWjZNUHk1a2VPUU0weW16Sm94cmJkOEFZTDJFRmxz?=
 =?utf-8?B?MUxSSXkwN0kwRDNrb2JSSnk4RE5BMHBFUzBpNXB5UkREWlp5VVRPcDM5Y082?=
 =?utf-8?B?cllaK1Z0eVg5YWZGQSs1STBLSFh5ZnBlYmRuakJhcjlDTE5WZGtxdkljYnZq?=
 =?utf-8?B?Y1ltZmNJOXRGZ2pOcmxEN2FUdEo1RkEzOHVQbDlmTU9FNlNwWEEyNFNFM3Bk?=
 =?utf-8?B?OCtONTFlaWxVbVFYcm8rZUt4NFU1RkdveVh3V2oyVVVDTldTdXNEV1pyR3o3?=
 =?utf-8?B?VmE4MGFnWCtjZnY1TDNxMXZyQ0VuR0EzWHB2ZHdmZ1hyTk15UVY3NXF3eTFF?=
 =?utf-8?B?UVVQOHU4K1B6R05OQzY4OThMUnpUc2QvYkg5aHgvRXpOZzdzMTlwRXgwQ0pi?=
 =?utf-8?B?RUczN3FYcXk4eTQ4K29VbzRUQW0rQkhsdkNuWnJ6TjdDT25MZVQvbUdMTENo?=
 =?utf-8?B?VWVVMWNNdkZEYWxsUmJmQWpTc0llVGo5akkrNDEyeWI4b3VCd01mK1dlWEtT?=
 =?utf-8?B?Ujdqbyt6a1JjTUpYaWxsZWk4dW14U2NZZ0pGamxtUVRoMyt6blJqWDJFN1ho?=
 =?utf-8?B?Q3NMMVpTM2dmVlA5dWJuRE1OVWFqdVNWNVUwOFJRcWJpaE5GVGlxUlNkNUlG?=
 =?utf-8?B?NDE4VmhVZjQvVk14SEtsdGx5cTlab3Rjdyt2ekQraXk0WVAzNUtzWXVDejZY?=
 =?utf-8?B?WXRnNUlNd0pFaTNlSkgrT09rclo2QThhdEVncnBscTBBU0ZHY05ZQzB3QzBB?=
 =?utf-8?B?dGprVGh1eitlM3NGa1NYdUJFZVdwWHh2eWFBRHJRUU00OGc3dGtuNFlQMnRH?=
 =?utf-8?B?V21jb25yczZsWWcvY0ZFRWRHTWd3WWtnNGVJdVlkV3g5OGtLa09KLzE1bGtk?=
 =?utf-8?B?UFJkL05KZXd4c3JjYTdDcEV2SkNCWUxHUlpHaE94ZjBEYi9WU21pdFB6UDQ0?=
 =?utf-8?B?b2Y2cGM4emQ2bWtyd3k4YVl2aVVIckxZcy8vbXJqYXZ5b2RJNEszb0Y3REpo?=
 =?utf-8?B?TU9PdFU4NE9BM2Y3blZUODVnN08xNFdYWDlYZjFQUU9jV3gxQ2VseE51b05z?=
 =?utf-8?B?S3RlMU01UVFFSXg1OE5sbnEzdWdyZmllcWxTU2NhdTg5R2VJbWJCS1ZDa0Ji?=
 =?utf-8?B?YWxHalphTE9FUWtLTmNqa3hSR0ZreldxcUJWY3JEMGQ5NGJWOHZGUnZ1RVMw?=
 =?utf-8?B?K3VTSDhQaGR1WDZBRWRkb2RHTy9yak83dDZ5aCsxZGhoVWJqdEozcHFvNnlL?=
 =?utf-8?B?U3dRYWtaci9HTU5kNVBRNU5KZzU5Y2NxRUNiMzRhOVpIVm1tbFJjNmR4VzRR?=
 =?utf-8?B?YUhTdTNFZTdUNnBpMWpqVU9MU1RGMGNGckFkcmdWNXpic3phK2NqWDJkbEF6?=
 =?utf-8?B?RitnaG9idENKVGM4V0xxSHJFVS9jWjZScVhxNlJiK2hjRFcreVB0NjdrbDdP?=
 =?utf-8?B?UXlvQkEvWXFzUjZ5cHRIT3FHd1VPVDkvNE44eVFuOTBxY2lMbEV1UldoT1dm?=
 =?utf-8?B?bEFDbUg1d1QvanBsdmdOdEFPaHBLRjFqMWVUK05UQlJTMVlWZ1gyRTBud3Zo?=
 =?utf-8?B?WXZiWXRwUHZjQVI4MjNPc3ZOakFjeStjcXg0cngweWNxOTJpZklUQ2NHTVdr?=
 =?utf-8?B?d2pjVWwrWjNGUUxRWlZoNUYzMTdtY21jcVhubUIxemlJT25wM2FCM3VrRGJT?=
 =?utf-8?B?RE1WYWc5cU9IdlZZVGo1OEFESkNEa1hueGRFRFdueG5HMEp0MkVwZTdWVHVZ?=
 =?utf-8?Q?BEk9DkjIWk8z/Uot9u3dYpqtvsN5KF44S2Tm1BDq3PI58?=
x-ms-exchange-antispam-messagedata-1: MA9+gQSEzxsNmvRbuSh221E0PcX1TKTULj0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A13C27A2C9444408B99CB65D1C19D83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PuA6AgTNObrXC1hvTOa4HQrfTm5x6MTQqDC9gx3gLTp2xapGfgR4Db48Twa/jr2AqLFIc9Di3vap2KkTA364ZjyWreF2TfIZMaolHlBFBU5p5YOW/ZN7MmPJek/cdxBvPjqj+YnRPnPa3itPOaRuh08Jck/qy5/rC8BJrjL4JK+ot5sDtiKWRQymzT1voa6p4IC2XnHLTPFcIG/GFh5M9OJmGwT9LzQrjk8fQPAwPDKs+3I9xyqrQ8xvs9LP6cmEOsFzVwELNjBpCT78C5eLonkDM7uQK9D3Zh+DTx4zWnj5f+fyMD7en+tHwc7NLSwBNkcfU9Gw+eBfEXDlE+bhQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08057b58-0972-4491-c4a3-08de8b99146d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 00:37:52.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBeu9SlpghpTfdgyuNujAo8w+JWhJvJpH4AoRIbj/eQvgIdS4O+/v5RsxKfB+Zs5uCkGEtZNPbOGbvWqnekxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9034
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTI2IGF0IDE0OjMyIC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOgo+IE9u
IFRodSwgTWFyIDI2LCAyMDI2IGF0IDExOjAx4oCvQU0gVGhvbWFzIEZhbGNvbgo+IDx0aG9tYXMu
ZmFsY29uQGludGVsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IHRlc3RfX3JhdGlvX3RvX3ByZXYoKSBh
c3N1bWVkIHRoZSBmaXJzdCBldmVudCBpbiBhIGdyb3VwIGlzIHRoZQo+ID4gbGVhZGVyLAo+ID4g
d2hpY2ggaXMgbm90IHRoZSBjYXNlIHdoZW4gdGhlIGV2ZW50IGlzIGV4cGFuZGVkIGludG8gdHdv
IGV2ZW50Cj4gPiBncm91cHMKPiA+IG9uIGh5YnJpZCBQTVUncyB3aXRoIGF1dG8gY291bnRlciBy
ZWxvYWQgc3VwcG9ydC4gVGhpcyBwYXRjaAo+ID4gdXBkYXRlcyB0aGUKPiA+IHRlc3QgdG8gaXRl
cmF0ZSBvdmVyIHRoZSBldmVudCBncm91cCBnZW5lcmF0ZWQgZm9yIGVhY2ggY29yZSBQTVUuCj4g
PiBBbHNvCj4gPiB1cGRhdGUgIndyb25nIGxlYWRlciIgdGVzdCB0byBjaGVjayB0aGF0IHRoZSBz
dWJvcmRpbmF0ZSBldmVudCBoYXMKPiA+IHRoZQo+ID4gY29ycmVjdCBsZWFkZXIgaW5zdGVhZCBv
ZiBjaGVja2luZyB0aGF0IGl0IGlzIG5vdCB0aGUgZ3JvdXAgbGVhZGVyLgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4KPiA+IEZp
eGVzOiA1NmJlMGZlNWY2MmMgKCJwZXJmIHJlY29yZDogQWRkIGF1dG8gY291bnRlciByZWxvYWQg
cGFyc2UKPiA+IGFuZCByZWdyZXNzaW9uIHRlc3RzIikKPiA+IC0tLQo+ID4gdjI6IG1hZGUgY2hh
bmdlcyBzdWdnZXN0ZWQgYnkgRGFwZW5nIE1pCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvOTk3YjYyOTEtNzQyOS00ZWFhLTg0NjctMWZkODhlMTAwNjE2QGxpbnV4LmludGVsLmNvbS8K
PiA+IC0tLQo+ID4gwqB0b29scy9wZXJmL3Rlc3RzL3BhcnNlLWV2ZW50cy5jIHwgNDcgKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0KPiA+IC0tLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvcGVyZi90ZXN0cy9wYXJzZS1ldmVudHMuYwo+ID4gYi90b29scy9wZXJmL3Rlc3RzL3BhcnNl
LWV2ZW50cy5jCj4gPiBpbmRleCAxZDNjYzIyNGZiYzIuLjQ0ODc1MDhjNTY1OCAxMDA2NDQKPiA+
IC0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvcGFyc2UtZXZlbnRzLmMKPiA+ICsrKyBiL3Rvb2xzL3Bl
cmYvdGVzdHMvcGFyc2UtZXZlbnRzLmMKPiA+IEBAIC0xNzk2LDMxICsxNzk2LDM4IEBAIHN0YXRp
YyBib29sIHRlc3RfX2Fjcl92YWxpZCh2b2lkKQo+ID4gCj4gPiDCoHN0YXRpYyBpbnQgdGVzdF9f
cmF0aW9fdG9fcHJldihzdHJ1Y3QgZXZsaXN0ICpldmxpc3QpCj4gPiDCoHsKPiA+IC3CoMKgwqDC
oMKgwqAgc3RydWN0IGV2c2VsICpldnNlbDsKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGV2c2Vs
ICpldnNlbCwgKmxlYWRlcjsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NFUlRfVkFM
KCJ3cm9uZyBudW1iZXIgb2YgZW50cmllcyIsIDIgKgo+ID4gcGVyZl9wbXVzX19udW1fY29yZV9w
bXVzKCkgPT0gZXZsaXN0LT5jb3JlLm5yX2VudHJpZXMpOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKg
wqAgZXZsaXN0X19mb3JfZWFjaF9lbnRyeShldmxpc3QsIGV2c2VsKSB7Cj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXBlcmZfcG11X19oYXNfZm9ybWF0KGV2c2VsLT5wbXUs
ICJhY3JfbWFzayIpKQo+ID4gK8KgwqDCoMKgwqDCoCBmb3IgKGludCBpID0gMDsgaSA8IG51bV9j
b3JlX2VudHJpZXMoZXZsaXN0KTsgaSsrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBsZWFkZXIgPSAoaSA9PSAwID8gZXZsaXN0X19maXJzdChldmxpc3QpIDoKPiA+IGV2c2Vs
X19uZXh0KGV2c2VsKSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXBl
cmZfcG11X19oYXNfZm9ybWF0KGxlYWRlci0+cG11LCAiYWNyX21hc2siKSkKPiAKPiBJZiB0aGUg
cC1jb3JlIG5vbi1BQ1Igc3VwcG9ydGluZyBldmVudHMgYXJlIGZpcnN0LCB3b24ndCB0aGlzIG1l
YW4KPiB0aGUKPiBsb29wIGltbWVkaWF0ZWx5IHRlcm1pbmF0ZXM/IEkgd29uZGVyIHRoZSBsb29w
IHNob3VsZCBiZToKPiBgYGAKPiBldmxpc3RfX2Zvcl9lYWNoX2VudHJ5KGV2bGlzdCwgZXZzZWwp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChldnNlbCAhPSBldnNlbF9fbGVh
ZGVyKGV2c2VsKSB8fAo+ICFwZXJmX3BtdV9faGFzX2Zvcm1hdChldnNlbC0+cG11LCAiYWNyX21h
c2siKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsg
LyogTm90IGEgZ3JvdXAgbGVhZGVyIG9yIHRoZSBldmVudCBpcwo+IGZvciBhIG5vbi1BQ1Igc3Vw
cG9ydGluZyBQTVUuICovCj4gYGBgCj4gdGhlbiB0aGUgcmVndWxhciB0ZXN0cyBvbiB0aGUgY29u
ZmlnMiwgZXRjLiBUaGVuIGV2c2VsX19uZXh0IHRvIGdldAo+IHRoZSBpbnN0cnVjdGlvbnMgZXZl
bnQsIGV0Yy4KCkhpIElhbiwgdGhhbmtzIGZvciBjYXRjaGluZyB0aGF0ISBJIHdpbGwgc2VuZCBh
IG5ldyB2ZXJzaW9uIHNvb24uCgpUaGFua3MsClRvbQoKPiAKPiBUaGFua3MsCj4gSWFuCj4gCj4g
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBURVNUX09LOwo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXZz
ZWwgPT0gZXZsaXN0X19maXJzdChldmxpc3QpKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NFUlRfVkFMKCJ3cm9uZyBjb25maWcyIiwg
MCA9PQo+ID4gZXZzZWwtPmNvcmUuYXR0ci5jb25maWcyKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBURVNUX0FTU0VSVF9WQUwoIndyb25nIGxlYWRl
ciIsCj4gPiBldnNlbF9faXNfZ3JvdXBfbGVhZGVyKGV2c2VsKSk7Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NFUlRfVkFMKCJ3cm9uZyBj
b3JlLm5yX21lbWJlcnMiLAo+ID4gZXZzZWwtPmNvcmUubnJfbWVtYmVycyA9PSAyKTsKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBURVNUX0FTU0VSVF9W
QUwoIndyb25nIGdyb3VwX2lkeCIsCj4gPiBldnNlbF9fZ3JvdXBfaWR4KGV2c2VsKSA9PSAwKTsK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBURVNUX0FT
U0VSVF9FVlNFTCgidW5leHBlY3RlZCBldmVudCIsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
dnNlbF9fbWF0Y2goZXZzZWwsCj4gPiBIQVJEV0FSRSwgSFdfQ1BVX0NZQ0xFUyksCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBldnNlbCk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9IGVsc2Ugewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgY29uZmlnMiIsIDAgPT0KPiA+IGV2c2VsLT5jb3Jl
LmF0dHIuY29uZmlnMik7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgVEVTVF9BU1NFUlRfVkFMKCJ3cm9uZyBsZWFkZXIiLAo+ID4gIWV2c2VsX19pc19n
cm91cF9sZWFkZXIoZXZzZWwpKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBURVNUX0FTU0VSVF9WQUwoIndyb25nIGNvcmUubnJfbWVtYmVycyIsCj4g
PiBldnNlbC0+Y29yZS5ucl9tZW1iZXJzID09IDApOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgZ3JvdXBfaWR4
IiwKPiA+IGV2c2VsX19ncm91cF9pZHgoZXZzZWwpID09IDEpOwo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRFU1RfQVNTRVJUX0VWU0VMKCJ1bmV4cGVj
dGVkIGV2ZW50IiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV2c2VsX19tYXRjaChldnNlbCwK
PiA+IEhBUkRXQVJFLCBIV19JTlNUUlVDVElPTlMpLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXZzZWwpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogY3ljbGVzICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBURVNUX0FTU0VSVF9WQUwoIndyb25nIGNvbmZpZzIiLCAwID09IGxlYWRlci0K
PiA+ID5jb3JlLmF0dHIuY29uZmlnMik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBURVNUX0FTU0VSVF9WQUwoIndyb25nIGxlYWRlciIsCj4gPiBldnNlbF9faXNfZ3JvdXBfbGVh
ZGVyKGxlYWRlcikpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NF
UlRfVkFMKCJ3cm9uZyBjb3JlLm5yX21lbWJlcnMiLCBsZWFkZXItCj4gPiA+Y29yZS5ucl9tZW1i
ZXJzID09IDIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NFUlRf
VkFMKCJ3cm9uZyBncm91cF9pZHgiLAo+ID4gZXZzZWxfX2dyb3VwX2lkeChsZWFkZXIpID09IDAp
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NFUlRfRVZTRUwoInVu
ZXhwZWN0ZWQgZXZlbnQiLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXZzZWxfX21hdGNoKGxlYWRlciwgSEFSRFdB
UkUsCj4gPiBIV19DUFVfQ1lDTEVTKSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlYWRlcik7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIFRoZSBwZXJpb2QgdmFsdWUgZ2V0cyBjb25maWd1cmVkIHdpdGhpbgo+ID4gZXZsaXN0
X19jb25maWcsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2hpbGUgdGhp
cyB0ZXN0IGV4ZWN1dGVzIG9ubHkgcGFyc2UgZXZlbnRzCj4gPiBtZXRob2QuCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBURVNUX0FTU0VSVF9WQUwoIndyb25nIHBlcmlvZCIsIDAgPT0gbGVhZGVyLQo+ID4gPmNv
cmUuYXR0ci5zYW1wbGVfcGVyaW9kKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogaW5zdHJ1Y3Rpb25zL3BlcmlvZD0yMDAwMDAscmF0aW8tdG8tcHJldj0yLjAv
Cj4gPiAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXZzZWwgPSBldnNlbF9f
bmV4dChsZWFkZXIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NF
UlRfVkFMKCJ3cm9uZyBjb25maWcyIiwgMCA9PSBldnNlbC0KPiA+ID5jb3JlLmF0dHIuY29uZmln
Mik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBURVNUX0FTU0VSVF9WQUwoIndy
b25nIGxlYWRlciIsCj4gPiBldnNlbF9faGFzX2xlYWRlcihldnNlbCwgbGVhZGVyKSk7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBURVNUX0FTU0VSVF9WQUwoIndyb25nIGNvcmUu
bnJfbWVtYmVycyIsIGV2c2VsLQo+ID4gPmNvcmUubnJfbWVtYmVycyA9PSAwKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRFU1RfQVNTRVJUX1ZBTCgid3JvbmcgZ3JvdXBfaWR4
IiwKPiA+IGV2c2VsX19ncm91cF9pZHgoZXZzZWwpID09IDEpOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgVEVTVF9BU1NFUlRfRVZTRUwoInVuZXhwZWN0ZWQgZXZlbnQiLAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZXZzZWxfX21hdGNoKGV2c2VsLCBIQVJEV0FSRSwKPiA+IEhXX0lOU1RSVUNUSU9O
UyksCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBldnNlbCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogVGhlIHBlcmlvZCB2
YWx1ZSBnZXRzIGNvbmZpZ3VyZWQgd2l0aGluCj4gPiBldmxpc3RfX2NvbmZpZywKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2hpbGUgdGhpcyB0ZXN0IGV4ZWN1dGVzIG9u
bHkgcGFyc2UgZXZlbnRzCj4gPiBtZXRob2QuCj4gPiAtLQo+ID4gMi40My4wCj4gPiAKPiAKCg==
