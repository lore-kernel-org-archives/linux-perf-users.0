Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51029154425;
	Fri, 13 Mar 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439122; cv=fail; b=C1j41U7EoZs4wYVFSNRI1VnbTqm7g/PosFlZKZK87YZdm+yNBqu7eBn22pB4VC4Su+W/1eFUZmzmu/2CKpYvBXxu7wBXW8EViqgy0l2lwc/V9WfomnOIaI3Q5CXVleR+g1cd0Y0SPRiqYtFNY3YsEoNLZJpouFyy/Luz4hOJcjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439122; c=relaxed/simple;
	bh=vdsGqtYN7Rbj9OVUIt6VNty2mHQk50ATelLtyTXJs/Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPuu0cbdLSK7SRKs8W4/QE/6wvy9Gp1qHFdi8e59IjRmX5YCQFEFNrzxWHT7u37KAe6thQeweGU5I+uYf+ySnJNuX3aNoACFrxOejzyu9Lq02Qv38cG3S1Ej+MawkGN779EMu8CjtVrwkQ4aLah8ktF+UtvxCF7B7HxgoXuSZxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcfN1h26; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcfN1h26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773439121; x=1804975121;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=vdsGqtYN7Rbj9OVUIt6VNty2mHQk50ATelLtyTXJs/Y=;
  b=OcfN1h26+uxaRvRwdv1g3qzRtD3do/wP9Lf50YT74TzUZFm97VlKX8kL
   s7N+e4BfRvUTmxOGvNdaWtbiZxJNSBReba8HFu4Ly1TI+MLLjZF/PkZWt
   dLbyLhJ99ZXPXYiruWwPq9GFJv7XfJn0HaOfQAnxFfTAJP9zghTfEwWlR
   Om3ORvtO8IXCsjqdDdHfyiIACljsZqdQwS47llgAtqz18KQn/2MKW6FE8
   eZRE7LDFPMMxOSqukuAk/g+7sx2NfeyJMSqxeYTcGroLJjqyPN6+IBBxh
   puyp/wfKUkJXDy8SMeOZASe3lItfPIUM2P72GD3iBziZM7GG16cbK/NtC
   A==;
X-CSE-ConnectionGUID: AP1wVA6wQVGmWdOu2PTa+g==
X-CSE-MsgGUID: 45gbDwlMScaFXhaCFKN/iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="73568936"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="73568936"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 14:58:40 -0700
X-CSE-ConnectionGUID: 18M3j2dJSKSyUCZRKggzeQ==
X-CSE-MsgGUID: /2webqOvS9mI8kVJcbzjVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251801338"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 14:58:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 14:58:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 14:58:39 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 14:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPQa74h2h3S8u2TtYEbp3FgklR7H/0E8VPW3T8llu9HT9PQGeMHQyhTfFw7yh3JPpXlL/91bhtmyTfY+IZh84QF40FRbDz5FkTI7Osg5M1IQcTXPOiZqJuNhJq6k+gahs4jPRjRhzeMf3B8G5VQx6U3kc2xmXufqj/bxZIaROFqv8bytQmoR5g6cp7TqqpZXN/imFlaZ4EtbQhBOv3cUq2B5EXNZ5JVqymOsvczWBWMK3RNMwwwv8OtaiRNh9pzPaqsLQvHHmvYNRUtW5NXUpCsJ+LOxFNIfeUeMVJPc3s90hceegIlX3O5OKS2u0yNJEa+vqS++UN8W3rEyWARswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdsGqtYN7Rbj9OVUIt6VNty2mHQk50ATelLtyTXJs/Y=;
 b=ZtB8azEJP2DbnazoLGfNQj+DErz6j08w8ctbClNY7++J+o4gt3yU8DlHXzj4Ob8HYFG3MI/0szRTB43Jdz4OXmSsfD+aAO2foDrDJvOE020ST8/s5pokrPahcyLfzlJ0NcB9VpOQVpq5kG/ytXNBzFxjEKapULzJa1DuHX7Mok0h7q8aey8cJY7/wLD6pBldQxPjDmyy58RTQfktkH13ExKUXkM/uoenK4zR+/J5WWvZ4H68wGhXiras1dWaPUTfO91HPZJyGhAo3D5XymVtGjaBHIRV7uWPNg+hUO7/4bSr8tw6TrqEuzSPo9VcUdNfnsvqehoavjNca9MPg89vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 21:58:37 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 21:58:36 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Rogers, Ian" <irogers@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v1] perf/x86: Fix potential bad container_of in
 intel_pmu_hw_config
Thread-Topic: [PATCH v1] perf/x86: Fix potential bad container_of in
 intel_pmu_hw_config
Thread-Index: AQHcslimD0a84gJZ8Uy7UzQgggiGjrWrTIsAgAG314A=
Date: Fri, 13 Mar 2026 21:58:36 +0000
Message-ID: <5127277867b8f73c15613f4c05427d90cac2b77f.camel@intel.com>
References: <20260312194305.1834035-1-irogers@google.com>
	 <CAP-5=fWSsnwMPOokv75Bzs06ohkX3JSZhHRqRP82NVdq=F9HFw@mail.gmail.com>
In-Reply-To: <CAP-5=fWSsnwMPOokv75Bzs06ohkX3JSZhHRqRP82NVdq=F9HFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|MW4PR11MB7150:EE_
x-ms-office365-filtering-correlation-id: b1fc9bad-f40d-40ea-8730-08de814bada1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: HEvC1xLf8qQEDvVm3HaRFiF0Ra582ByIWP7+M19WJ1ds+cfcRILrPwti32oMHQJbRUVCBImuDp6HcFYa7I2I+zl2VofUBGrHT01y/0G9tXB9xTGHQaxkhpAbq5B05MrfR10YYkWxwq/Bqh7vW4Oe/7To6p0eCBragjD65ewlwf7DFEcQmIF94eG+nSBSOCJxFzvlQJqpX1p+rMZHWwxIK7EzlieAsAdaDoCTsVXBhjYdFqP+t4a24FB9JGKHDbmZeZZrHP/haJSUtyXhTILz4AAJBBZrnQUwd6jy9zfhlZXdiy6OPh5fmg6wHcdtk8jAcPYktL2dqwuEmGSP+5oVXPsrIKlVB5yHyHkNB5fneNimvC21igi4AmyoFpkUZvz8NObSXDKBCnXysczA8hLmkD1WtlwJwHcCaSyTzRPFk0A1DxDRvJ7/Sbed87j4/xe+hKUOUAPJsVamwCqSsZy/PxtSbay8deb1vTcNE5pDNzPZodZReANekjV1oUhghzh6cS/mf4BJJdAF1SEErfsDX01zeCsMnviEo7fDsx9Xyz+MeQOd8JuuJezlqSr0bckHGNfdws1WaW0iPxjkxyMW84UNl0/Yv9eIwGVewUkd7VMS5vxPRE3/6YtT9DjgHDIKJuUeSSBnjUo0eWb5phR0XUPKDPoA/OWdendmU40VZ+O5qySsSo+v0PvO4ROi2tMU3qvUjQtFBkLZeFi5NSJZaueswYsQz5sgdl7cDujg1fO/tEAkyJ/GKP74Ow9KQ1mOMteT7zRO115+KyYAYyZi2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V003ZjhEaDlxdXgzeTR5TTMzTmVHQWU1eVZGRnFXQVBOTHByeXJsUVpoTzUv?=
 =?utf-8?B?Rm0rQnZSM0JwYllYWXBZVHpjZVRxMHVxWFFEVVBkZDdtTVVxcDBhYnBYdjB0?=
 =?utf-8?B?Y04vS2hCKzVBSmRjQ1ZrTjN2T3dLMUNzcWZSaW1kMElRY2gvMFlCOVY5YVp4?=
 =?utf-8?B?dG1raFRoZDBBdFYxVWsyOHRTMnZaMmRsMnNZY2dEeVNOUnRoaXlKa2t0T2tJ?=
 =?utf-8?B?ZEphOTBhejJxdU1MUW80ZVY2azRGMFRhMStRQnJsT2lvblZKZ3Q4K1o2TXgv?=
 =?utf-8?B?SnJyOWpROHJud2tVM29VaHRQY3Vwdm1OelpxWDJCTFhXRmxpU0tRUWhYTktS?=
 =?utf-8?B?dzRMUS95dFQvWWZ0aFVnT1hmcDRvUWNMSlhHeE9MN2FYYzB1UVQ2bDRaMGRB?=
 =?utf-8?B?cmdEcHRzWEVoU3RmYXVtZ29XRHJ6Si9YbU94SlVFMDdWbjJQbDBvVFNJVUJ6?=
 =?utf-8?B?YmkyN2MrMnZmTE1yVzJFRmhHMXdEZ1QrS3JJNzRzb0N0WG5OaGd5dVF6dExi?=
 =?utf-8?B?UFVzZG9lN3NGL0JJbWN5bUhpakxVL21DN3MrR2J5ZFpsWHJxOFR2V1ovcVYv?=
 =?utf-8?B?QnBhbU9SeXpKVlZHVTVBMytwaWVzVDNvd09HdWhhRVNrdEZiMXA0eFhxbnd2?=
 =?utf-8?B?T3EzRVJrU3J1MEVsbnlCbzJoYk1Kd3h3VWEwbVhvY05uSnRvcTNYU3UxWEVH?=
 =?utf-8?B?RlJTT29IQVAvamtrc1YrTDEzNkpYdE1PYmxVTkpsb09ZUTIxSVNpdHhkdXdW?=
 =?utf-8?B?dzhvcnJXVVJ0bStJWmxQR2J4b2FwbjlDM3pjdFN5cUcwK2dkbGhONGVZNmxt?=
 =?utf-8?B?RG13cVY3cis3Z0FXOUdDOWRXc3A4eUY0RzZVQlhyeGZVTFlwaytsclV1aFNy?=
 =?utf-8?B?Z2hTblRiSHRHaGdEZzVucDd5WE1sZVh2MnpNQ2xTVTY4a25DZExJTHd3OGYz?=
 =?utf-8?B?QXh2c3BWNnNCY0dVdy9QK1ZZOGcwRmtqWUQwM3ZZRldMSGlLSVF5cStNdUc4?=
 =?utf-8?B?MTAxZHdXWmVVejRVZHMzSUplVEdqYUlzTk14dFBxazlDWjFrYjc1d0xLMDJP?=
 =?utf-8?B?Nm82T2JUUG1IRFRDN1IxMlBGSlRVck9HQWsyTkhzNUd1cXBxTHh4bldnU2p2?=
 =?utf-8?B?OXJ6NXZkR2R2b0hPeGUxb0ZBeDNmVUVmYjVVMjBuVHpkMzJ3dk9rZzlOL0JH?=
 =?utf-8?B?dVNneXEyRFRmZHQwSWZrWFBZRjFrU2IrR2Y5N05XK3ZLRWNzVHV1bzVkTlBh?=
 =?utf-8?B?TXMzUmFFWXFmZForekswVDREejZ4RVZ1R2o5REM0djlFU1NVMStUT25zTG16?=
 =?utf-8?B?ZjRla0VTNkx1cmI2VnJEbi9BUDk4VmdrUS9qWFdmN3FwRXFIeGZNT2Vxayt5?=
 =?utf-8?B?OVRYVEZHUVd5Wmk5bCtTZ1c3aEwwKzhyQ3psRFFpaU5HbHNTY2FlWGl0UmRC?=
 =?utf-8?B?Q2VDeHc5b1hCSUVGTk10L0dDc0pVZmViR3RzUmNkS0VOMlBHSmlydjBNd01O?=
 =?utf-8?B?WmlMclZTL3RKN1lLSWpYRTJ5SzZsRnI5endhQWVjQWdMMnJtZndwNU0yTFBU?=
 =?utf-8?B?UEFoa3o0Qy83d0FxQlFpa0J0Sko1dFJ0YlRPTVh6S0p4SXZvR05HWVkxUHlJ?=
 =?utf-8?B?eXBLY1RlZ1AzSEQwK3FRUkxLTXNLaDgyRkQzZUJwK1l1M0d2alI2RTVyOFgy?=
 =?utf-8?B?RTJSczAzOFk2cjNaSEVnMzFMc2h6NVplSzVlNktBaHRxRkRISDlOR251enlw?=
 =?utf-8?B?K1ZRWlAzbWZXbkdPbG1wQXo5b081OEZmNWRKM1A4ZUw5UlRZc1lmQk5McGNL?=
 =?utf-8?B?SUZnYTBUVGU5T0hScTFENmxWUEdJSmxKRW5zMVJ1OEUyTUZOVGN4WEpqYzJj?=
 =?utf-8?B?N3F2d1ZMcHFyNGFhWG16WkIwMDg0bmdnNTVLblAweW9zWUhFWWVZSHRMSzJU?=
 =?utf-8?B?L29LRytMT3JHOGNvWkQyMzhKN21OUXNHSTBaMllzOWFsTHFqTFFyU09oTVNK?=
 =?utf-8?B?VUh5Q2J2KzFGWW8xYTFPN0dCYndiTkI3bldCcVcwcVZNL1A0a3diT2FNaWtk?=
 =?utf-8?B?UUcxcVJEL0dtUWsxSFlEbmF6eGRXREs1VzhTL2daN3hQUE1OSmU4NnU3RVVM?=
 =?utf-8?B?ejhsWTRNd2YySGZOc2tSd2hQdzIrVDZWWlVsYllQYUYzbzFuTXJiT2gwVEtp?=
 =?utf-8?B?SmJBWGdvOWxTNUhKR2xQRU8yZ3ZOWk9HYzZIMU14eHJzQy9OekN4WDRYa1Zq?=
 =?utf-8?B?bWpReVRBZVgxSVE3eDBTYUdlc0R0S3BFQlFuVVA3eEM5bTZBdDBtL09wRDQz?=
 =?utf-8?B?SDh4cWRld3daeGpIV0dMSXNLK29YS1FTYk55QkU5bW5XUjRMT00yYTBmOWFO?=
 =?utf-8?Q?Y4I4dv2yLDfQOjBXawG62CXFLrfmKo3vtfmndsZ9NgB2c?=
x-ms-exchange-antispam-messagedata-1: XBRzIYarA9dW6l4ZSba9mrYsuDLe4wgWDAE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E387171F127D4A874467217E97E948@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wrb+wqo3bQCI+C8KQksEi8PALJAClowpBqZ+b8uIMjIJRUOdkiWROkBLcuZYcS1e922jSzkTI0SeRCbIHsPbzW3ISp8AwJZiRdeA3NJqoIVVlV282LZTvtkPBZyiPX7KiCcGDFA9O0IxT+d3DzwtK0gI7SBYD1g8zeYFVl0VJqfr0uVuTCHsyeNdmHDChxtDsOtUm8g7VBusg6Cbk22z/MM7x/J16y2sA5Wf1w+2Sn6Q1YAPqk0emT9g+xxGZw4NVSvv/ZiZsU11F7j8t2lKYsVKxN6X6YYwtjNrYDGE1kUrbZ+cXeU81chwUWsDDFdBDg8OKPhMWn0G5MBkviOoHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fc9bad-f40d-40ea-8730-08de814bada1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 21:58:36.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVwStT4kGa1QuK4eXdeeXCiIf7sx0WfOh3f7E4W3mnUtrPlS2/eP/330rSAx3kpSnCc5R17XQ0re1nZIntqkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEyOjQ0IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBUaHUsIE1hciAxMiwgMjAyNiBhdCAxMjo0M+KAr1BNIElhbiBSb2dlcnMgPGlyb2dlcnNAZ29v
Z2xlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQXV0byBjb3VudGVyIHJlbG9hZCBtYXkgaGF2ZSBh
IGdyb3VwIG9mIGV2ZW50cyB3aXRoIHNvZnR3YXJlIGV2ZW50cw0KPiA+IHByZXNlbnQgd2l0aGlu
IGl0LiBUaGUgc29mdHdhcmUgZXZlbnQgUE1VIGlzbid0IHRoZSB4ODZfaHlicmlkX3BtdSBhbmQN
Cj4gPiBhIGNvbnRhaW5lcl9vZiBvcGVyYXRpb24gaW4gaW50ZWxfcG11X3NldF9hY3JfY2F1c2Vk
X2NvbnN0ciAodmlhIHRoZQ0KPiA+IGh5YnJpZCBoZWxwZXIpIGNvdWxkIGNhdXNlIG91dCBvZiBi
b3VuZCBtZW1vcnkgcmVhZHMuIEF2b2lkIHRoaXMgYnkNCj4gPiBndWFyZGluZyB0aGUgY2FsbCB0
byBpbnRlbF9wbXVfc2V0X2Fjcl9jYXVzZWRfY29uc3RyIHdpdGggYW4NCj4gPiBpc194ODZfZXZl
bnQgY2hlY2suDQo+ID4gDQo+ID4gRml4ZXM6IGVjOTgwZTRmYWNlZiAoInBlcmYveDg2L2ludGVs
OiBTdXBwb3J0IGF1dG8gY291bnRlciByZWxvYWQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IElhbiBS
b2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gDQo+ICtUaG9tYXMgRmFsY29uDQo+IA0KPiBU
aGFua3MsDQo+IElhbg0KPiANCj4gPiAtLS0NCj4gPiBUaGlzIGZpeCB3YXMgcHJvbXB0ZWQgYnkg
ZmFpbHVyZSB0byBnZXQgYSBCVUdfT04gaW4gdGhpcyBzZXJpZXM6DQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC9hNjFlYWU2ZC03YTZkLTQwYmQtODNlYy1iZDRlYTc2NTdiOWRAbGlu
dXguaW50ZWwuY29tLw0KPiA+IGFuZCBzbyBJIHJhbiBhbiBBSSBhbmFseXNpcyB0byBzZWUgaWYg
dGhlcmUgd2VyZSBzaW1pbGFyIGJhZCBjYXN0cyBhcw0KPiA+IHNwb3R0ZWQgaW46DQo+ID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI2MDMxMTA3NTIwMS4yOTUxMDczLTItZGFwZW5n
MS5taUBsaW51eC5pbnRlbC5jb20vDQo+ID4gVGhlIEFJIGFuYWx5c2lzIGZvdW5kIHRoaXMgaXNz
dWUgYW5kIGl0cyBtdWNoIG1vcmUgdmVyYm9zZQ0KPiA+IGRlc2NyaXB0aW9uIGlzIGJlbG93Og0K
PiA+IA0KPiA+IEkgaGF2ZSBldmFsdWF0ZWQgYWxsIGNhbGxlcnMgb2YgdGhlIGh5YnJpZF9wbXUg
ZnVuY3Rpb24gd2l0aGluIHRoZQ0KPiA+IGFyY2gveDg2L2V2ZW50cyBkaXJlY3RvcnkuIFRoZSB2
YXN0IG1ham9yaXR5IG9mIHVzYWdlcyBhcmUgc2FmZQ0KPiA+IGJlY2F1c2UgdGhleSBvcGVyYXRl
IG9uIGFuIGV2ZW50IHRoYXQgaXMgY3VycmVudGx5IGJlaW5nIGluaXRpYWxpemVkDQo+ID4gYnkg
dGhlIHg4NiBQTVUgc3Vic3lzdGVtLCB3aGljaCBndWFyYW50ZWVzIHRoYXQgZXZlbnQtPnBtdSBp
cw0KPiA+IGluaGVyZW50bHkgYW4geDg2IFBNVS4NCj4gPiANCj4gPiBIb3dldmVyLCB0aGVyZSBp
cyBhIGRpc3RpbmN0IGJ1ZyB3aGVyZSBhIG5vbi14ODYgUE1VIChlLmcuLCBhIHNvZnR3YXJlDQo+
ID4gUE1VKSBjYW4gYmUgaW5hZHZlcnRlbnRseSBwYXNzZWQgaW50byB0aGUgaHlicmlkX3BtdSBm
dW5jdGlvbi4NCj4gPiANCj4gPiBUaGlzIGlzc3VlIG9jY3VycyBkdXJpbmcgZ3JvdXAgZXZlbnQg
dmFsaWRhdGlvbiBhbmQgY29uZmlndXJhdGlvbiBpbg0KPiA+IGludGVsX3BtdV9od19jb25maWcu
DQo+ID4gDQo+ID4gVGhlIFZ1bG5lcmFiaWxpdHkgRmxvdw0KPiA+IA0KPiA+IMKgMS4gVGhlIENv
bnRleHQ6DQo+ID4gDQo+ID4gSW5zaWRlIGludGVsX3BtdV9od19jb25maWcgKGxvY2F0ZWQgaW4g
YXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYyksDQo+ID4gdGhlcmUgaXMgbG9naWMgdG8gaGFu
ZGxlIEF1dG9tYXRpYyBDb3VudGVyIFJlbG9hZCAoQUNSKSBjYXBhYmlsaXRpZXMNCj4gPiBmb3Ig
ZXZlbnQgZ3JvdXBzLiBUaGUgY29kZSBuZWVkcyB0byBpZGVudGlmeSBzaWJsaW5ncyB0aGF0IGNh
dXNlIG90aGVyDQo+ID4gZXZlbnRzIHRvIHJlbG9hZCBhbmQgYXBwbHkgY29uc3RyYWludHMgdG8g
dGhlbS4NCj4gPiANCj4gPiDCoDIuIFRoZSBNaXNzaW5nIENoZWNrOg0KPiA+IA0KPiA+IEluIHRo
ZSBmaXJzdCBwYXNzIHRocm91Z2ggdGhlIHNpYmxpbmcgZXZlbnRzLCB0aGUgY29kZSBjb3JyZWN0
bHkNCj4gPiBjaGVja3MgaWYgZWFjaCBzaWJsaW5nIGlzIGFuIHg4NiBldmVudCB2aWEgIWlzX3g4
Nl9ldmVudChzaWJsaW5nKQ0KPiA+IGJlZm9yZSBidWlsZGluZyBhIGNhdXNlX21hc2suwqAgSG93
ZXZlciwgaW4gdGhlIHNlY29uZCBwYXNzIHRvIGFwcGx5DQo+ID4gdGhlIGNvbnN0cmFpbnRzLCB0
aGUgY29kZSBpdGVyYXRlcyBvdmVyIGFsbCBzaWJsaW5ncyBhZ2FpbiBidXQgb21pdHMNCj4gPiB0
aGUgaXNfeDg2X2V2ZW50KHNpYmxpbmcpIGNoZWNrOiBhcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29y
ZS5jI240ODQ3DQo+ID4gKGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3Jl
LmMjbjQ4NDcpDQo+ID4gDQo+ID4gwqAxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobGVhZGVy
LT5ucl9zaWJsaW5ncykgew0KPiA+IMKgMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
b3JfZWFjaF9zaWJsaW5nX2V2ZW50KHNpYmxpbmcsIGxlYWRlcikNCj4gPiDCoDPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlbF9wbXVfc2V0X2Fjcl9jYXVzZWRfY29u
c3RyKHNpYmxpbmcsIGlkeCsrLCBjYXVzZV9tYXNrKTsgLy8gPC0tIE1pc3NpbmcgaXNfeDg2X2V2
ZW50KCkgY2hlY2shDQo+ID4gwqA0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gDQoNCkhp
IElhbiwgdGhhbmtzIGZvciBjYydpbmcgbWUuIFRoZSBmaXggbG9va3MgZ29vZCB0byBtZS4gSSB3
YXMgY29uZnVzZWQgaW5pdGlhbGx5IGJlY2F1c2UgZmlyc3QgcGFzcyBkZXNjcmliZWQgYWJvdmUg
bG9va3MgbGlrZSBpdCBpcyBjaGVja2luZyBmb3Igbm9uLXg4NiBldmVudHMgYW5kIGJhaWxpbmcs
IGJ1dCByZWFsbHkgaXMgb25seSBjaGVja2luZyBmb3IgdGhlc2UgZXZlbnRzIGluIGJldHdlZW4g
QUNSIGV2ZW50cyBiZWNhdXNlICJBQ1IgZXZlbnRzIG11c3QgYmUgY29udGlndW91cy4iIFNvZnR3
YXJlIGV2ZW50cyBpbnNlcnRlZCBvdXRzaWRlIG9mIHRoZXNlIGV2ZW50cyBzaG91bGQgYmUgdmFs
aWQgdGhvdWdoLCBzbyB0aGUgaXNfeDg2X2V2ZW50KCkgY2hlY2sgaW4gdGhlIHNlY29uZCBwYXNz
IGlzIG5lZWRlZC4NCg0KVGhhbmtzLA0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIEZhbGNvbiA8dGhv
bWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNCj4gPiDCoDMuIFRoZSBJbnZhbGlkIENhc3Q6DQo+ID4g
DQo+ID4gVGhlIGludGVsX3BtdV9zZXRfYWNyX2NhdXNlZF9jb25zdHIgZnVuY3Rpb24gdGFrZXMg
dGhpcyBzaWJsaW5nIGV2ZW50DQo+ID4gKHdoaWNoIGNvdWxkIGJlIGEgc29mdHdhcmUgZXZlbnQp
IGFuZCBleGVjdXRlcyB0aGUgaHlicmlkIG1hY3JvIG92ZXINCj4gPiBpdHMgcG11IHBvaW50ZXI6
IGFyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMjbjQ2MjQNCj4gPiAoaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
YXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYyNuNDYyNCkNCj4gPiANCj4gPiDCoDHCoMKgwqAg
c3RhdGljIGlubGluZSB2b2lkIGludGVsX3BtdV9zZXRfYWNyX2NhdXNlZF9jb25zdHIoc3RydWN0
IHBlcmZfZXZlbnQgKmV2ZW50LA0KPiA+IMKgMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaWR4LCB1NjQgY2F1c2VfbWFzaykN
Cj4gPiDCoDPCoMKgwqAgew0KPiA+IMKgNMKgwqDCoMKgwqDCoMKgIGlmICh0ZXN0X2JpdChpZHgs
ICh1bnNpZ25lZCBsb25nICopJmNhdXNlX21hc2spKQ0KPiA+IMKgNcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZXZlbnQtPmh3LmR5bl9jb25zdHJhaW50ICY9IGh5YnJpZChldmVudC0+cG11LCBhY3Jf
Y2F1c2VfbWFzazY0KTsNCj4gPiDCoDbCoMKgwqAgfQ0KPiA+IA0KPiA+IMKgNC4gVGhlIFJvb3Qg
Q2F1c2U6DQo+ID4gDQo+ID4gVGhlIGh5YnJpZCBtYWNybyBleHBhbmRzIGFuZCBwYXNzZXMgdGhl
IGV2ZW50LT5wbXUgdG8gaHlicmlkX3BtdToNCj4gPiBhcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVu
dC5oI243ODgNCj4gPiAoaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQu
aCNuNzg4KQ0KPiA+IA0KPiA+IMKgMcKgwqDCoCAjZGVmaW5lIGh5YnJpZChfcG11LCBfZmllbGQp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gPiDCoDLCoMKgwqAgLi4uDQo+ID4g
wqAzwqDCoMKgwqDCoMKgwqAgaWYgKGlzX2h5YnJpZCgpICYmIChfcG11KSnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwNCj4gPiDCoDTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fRnAgPSAmaHlicmlk
X3BtdShfcG11KS0+X2ZpZWxkO8KgwqDCoCBcDQo+ID4gDQo+ID4gV2hpY2ggc3Vic2VxdWVudGx5
IHJlc3VsdHMgaW4gYSBibGluZCBjb250YWluZXJfb2Ygb24gYSBub24teDg2IFBNVQ0KPiA+IHBv
aW50ZXI6IGFyY2gveDg2L2V2ZW50cy9wZXJmX2V2ZW50Lmgjbjc4MA0KPiA+IChodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9hcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5oI243ODApDQo+ID4gDQo+ID4gwqAxwqDC
oMKgIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgc3RydWN0IHg4Nl9oeWJyaWRfcG11ICpoeWJyaWRf
cG11KHN0cnVjdCBwbXUgKnBtdSkNCj4gPiDCoDLCoMKgwqAgew0KPiA+IMKgM8KgwqDCoMKgwqDC
oMKgIHJldHVybiBjb250YWluZXJfb2YocG11LCBzdHJ1Y3QgeDg2X2h5YnJpZF9wbXUsIHBtdSk7
DQo+ID4gwqA0wqDCoMKgIH0NCj4gPiANCj4gPiDCoENvbmNsdXNpb24NCj4gPiANCj4gPiBJZiBh
IHVzZXIgY3JlYXRlcyBhbiBldmVudCBncm91cCBsZWQgYnkgYW4geDg2IEFDUiBldmVudCBidXQg
aW5jbHVkZXMNCj4gPiBhIG5vbi14ODYgc2libGluZyBldmVudCAobGlrZSBhIHNvZnR3YXJlIGV2
ZW50KSwgdGhlIHNlY29uZCB0cmF2ZXJzYWwNCj4gPiBpbiBpbnRlbF9wbXVfaHdfY29uZmlnIHdp
bGwgYmxpbmRseSBwYXNzIHRoZSBzb2Z0d2FyZSBQTVUgdG8NCj4gPiBoeWJyaWRfcG11LiBCZWNh
dXNlIGNvbnRhaW5lcl9vZiBhc3N1bWVzIHRoZSBQTVUgaXMgZW1iZWRkZWQgaW5zaWRlIGFuDQo+
ID4geDg2X2h5YnJpZF9wbXUgc3RydWN0LCB0aGUgcmVzdWx0aW5nIHBvaW50ZXIgYmVjb21lcyBp
bnZhbGlkLCBsZWFkaW5nDQo+ID4gdG8gbWVtb3J5IGNvcnJ1cHRpb24gb3IgYW4gb3V0LW9mLWJv
dW5kcyBhY2Nlc3Mgd2hlbiBhdHRlbXB0aW5nIHRvDQo+ID4gcmVhZCB0aGUgYWNyX2NhdXNlX21h
c2s2NCBwcm9wZXJ0eS4NCj4gPiAtLS0NCj4gPiDCoGFyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3Jl
LmMgfCA2ICsrKystLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL2ludGVs
L2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gPiBpbmRleCBjZjNhNGZl
MDZmZjIuLjI2ZTgyOWI4YTg4MiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvaW50
ZWwvY29yZS5jDQo+ID4gKysrIGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KPiA+IEBA
IC00ODQ0LDggKzQ4NDQsMTAgQEAgc3RhdGljIGludCBpbnRlbF9wbXVfaHdfY29uZmlnKHN0cnVj
dCBwZXJmX2V2ZW50ICpldmVudCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50ZWxfcG11X3NldF9hY3JfY2F1c2VkX2NvbnN0cihsZWFkZXIsIGlkeCsrLCBjYXVzZV9tYXNr
KTsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxlYWRlci0+
bnJfc2libGluZ3MpIHsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZm9yX2VhY2hfc2libGluZ19ldmVudChzaWJsaW5nLCBsZWFkZXIpDQo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbnRlbF9wbXVfc2V0X2Fjcl9jYXVzZWRfY29uc3RyKHNpYmxpbmcsIGlkeCsrLCBjYXVzZV9t
YXNrKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Zm9yX2VhY2hfc2libGluZ19ldmVudChzaWJsaW5nLCBsZWFkZXIpIHsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChp
c194ODZfZXZlbnQoc2libGluZykpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ZWxfcG11
X3NldF9hY3JfY2F1c2VkX2NvbnN0cihzaWJsaW5nLCBpZHgrKywgY2F1c2VfbWFzayk7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAobGVhZGVyICE9IGV2ZW50KQ0KPiA+IC0tDQo+ID4gMi41My4wLjg1
MS5nYTUzN2UzZTZlOS1nb29nDQo+ID4gDQoNCg==
