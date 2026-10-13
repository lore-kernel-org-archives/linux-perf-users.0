Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1865158B1;
	Tue, 13 Oct 2026 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.218.115.239
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918888; cv=fail; b=eC7QZu2dWdBygRrvrYpYYXfhac49CFpwlLRzg515JUAZ/6xc33Y/eErOmemySS/edHmzR5E0xreUy4CEhw7EJfLsQu9GL22lFNuVfcShiv1BnTIJoPG5gYlyUEVdM/DQdVEFU9ZkBEEwuTdym6zII1c72zbvkdgKJ//W8dX5xN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918888; c=relaxed/simple;
	bh=ibLJH08Azr/IUAqs+Kg1ev/suSlPNne2ovKEQ9l7Mt4=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fjW7psPGJuJmcMVf046bBBRGiOyYaCdNq+d05pNfE9z5dsIbt0UFykwWTWSyYb7xKe1em4jaSYXVSNuLBlP3CiPAOT4y2rZ7Zy1DDelqtHI9nUq43WQ2pKkPyvnegick2CbhbLVBG+4aSy4Bs1dFmIL7UtsqBR6o6Df7muqIOoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KxFaWHKZ; arc=fail smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KxFaWHKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791918887; x=1823454887;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=m4BzgO4Xqc1/8iNtlEfyjCS0ZCE7vZVouWm+WmlA3ms=;
  b=KxFaWHKZW8jjP9y1+6QnIIwcDDzf08GrKkFfXQXcduaS4S6mXat8MfT+
   uJpWAdU/5wTLGlO8oqy5M1L3nEqDdDBv91kienaa3nFGk3WA2wwb5Ev/H
   dYIKc0JZD6xKb1GeA6VdFVlbslBJi7lzoE8rRBrZ4pMTubyFG/+k18UnJ
   SQQzfkJjMaNGBNJMLjAAhIiA47ZR0v8zvwLOFXfTQv8yx+ufl/D8y7UsO
   +w8tjYzmuNS7Cyd0YzOb4owCPtqQ6o0OK2Rm5rcBsXIR3BNqr6dw6hnlC
   Xp6Yh2HiWch/jIz/yZjM4+4KnMURf/iVWB9/sCB8SQK6EPHwVXK1PgGb2
   w==;
X-CSE-ConnectionGUID: NTc5OJTJQIqK+VnxjuNgPw==
X-CSE-MsgGUID: GD/iqb1sQgiwfs7tiQf3Ew==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="30941274"
Subject: Re: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
Thread-Topic: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 19:14:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:14956]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.91:2525] with esmtp (Farcaster)
 id 478c8355-849d-4cdd-abda-ee5b590be2c4; Tue, 13 Oct 2026 19:14:47 +0000 (UTC)
X-Farcaster-Flow-ID: 478c8355-849d-4cdd-abda-ee5b590be2c4
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 19:14:46 +0000
Received: from CO1PR07CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49
 via Frontend Transport; Tue, 13 Oct 2026 19:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fqi33eZ4dd1Ths1Fo6x7TzBgKAsVzrSVnSVr36QUaD01p0CRrj2J4E9tdVcql1wCS04etQxAPyXexn95s8c9IUb7nedSIlbqBgaBVIRaSEQr2cbI8ueKVBdXLdcr5H5sv790bvQTnCa/2Mv4LqUldzOgcWXjV/FSSm12X+Q5LS0diE3duFwRc+6GTmiLxqaxG8n3/Ix02EJiYQsnJSK5VNsQuOobaq3weg+s0m92B1IVjXLPmKqZYQJ330uxDFmwPd7nDgGDu5+ue4JvHeJuXWoXGV9Lh6TsVXsxAtRbghmykh4LY1AI4k9dCM8c0v+v6nLvk+VQEFYPUd4UY90O0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4BzgO4Xqc1/8iNtlEfyjCS0ZCE7vZVouWm+WmlA3ms=;
 b=dWgBjLgpDM8oGQ5LNFvGuemQKl+fVGCU12W/UraaUYPmijyKEmyMkeD7gaEjYwEiszVoyZk8kZKWuXndaRgzmFeJlRJWlB/6CTsQY99/aDQkgtgpSjT0CBKeBo2hBAl37kyHrQ8+S/ppsOb5mGWNVLLMs6eoYvb8I3if9RA3i2+W71dUQjhp+N5rdHYIa4vbgKgU+0yHb22g3OkkbkzUUrnXlzhRGxxE1aUbYa1ZtowcwMrKC1Zphh6uTukLPy9StG4NH6U5oHWU4R0esVuuNqZ2Q/vF0wArFzd3PtUZ6EpXLUIylqOC/TBmbckCmddj97XBIfiWfpFmMTr9RsYs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN7PR18MB660231.namprd18.prod.outlook.com
 (2603:10b6:208:5f3::23) by SA1PR18MB6065.namprd18.prod.outlook.com
 (2603:10b6:806:3e2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 19:14:44 +0000
Received: from MN7PR18MB660231.namprd18.prod.outlook.com
 ([fe80::97fe:4c12:b98c:3b70]) by MN7PR18MB660231.namprd18.prod.outlook.com
 ([fe80::97fe:4c12:b98c:3b70%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 19:14:42 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "will@kernel.org" <will@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHdURIAJvo3yua2RUmC2W5fD5s0e7bqeAkAgBFzzds=
Date: Tue, 13 Oct 2026 19:14:42 +0000
Message-ID: <MN7PR18MB66023148440D0477B7D384A16BA89E2@MN7PR18MB660231.namprd18.prod.outlook.com>
References: <20260929223244.2411400-1-harisokn@amazon.com>
 <b782f893-e3ab-40f7-a7c5-ce19660be2c1@arm.com>
 <CY2PR18MB8432185386B28FBC1DA23F3333A88B2@CY2PR18MB843218.namprd18.prod.outlook.com>
 <2d70be7b-12c0-46e0-b308-744a3159388a@arm.com>
In-Reply-To: <2d70be7b-12c0-46e0-b308-744a3159388a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN7PR18MB660231:EE_|SA1PR18MB6065:EE_
x-ms-office365-filtering-correlation-id: 196d8f17-a852-4f00-ce14-08df295e3c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: hkHmy4nU3BzoElPnjkGwSl08k58AoBh6xu+KsZQiZpTv34uRqrP8iWwFncpaf5eH5m3OGAuoEU+L09YjcLzFBwpSsgs5qs9xXEFpSNbLyymOFu9EjIhxdddiCbwOnsc07foyG7nhqIoEjWHc8qD5CKWMVXuWDhzOZ/lnpyV0U/F/YE4mzfZgZ+cdZn8yBOIdKkZ0fn82BBvfmLC0A6TL/ICWyYsdWHoegQxBl9tzNg2EK+aK5EBjIggjsE/GZslidx5cahVNY6VK50lMRBAsYxTgsu+rv3SbO6+rNYr2OLQ73XRIETjWiQLXAjx1IVlBbjAPbjRnp8ykBn5KSVjcqJCzX8zdhSZ6q2XdRv2BhjCGppJyCtYPuQUfJAkAwWP/b1XmR41bZcmSkZCrTh3FiujaS8f+iyXj4PhMfKpwWyQb4fnuAxj8LI5B3aRpQlZH22MyiZdSXRbB3eyNaSoAUNAnNDkp64T8h3rdxx9iv7VHkF3MCMche88Dvsu+HekGZweqTmfqGmIn4L/QXFb84OaWZ+tZ/1r+AyIoZH9Z2w5Z6I89ckUPNOseNY2MwxgfLOzBJJOuVuVKIlHjXV9yYgSLqpc+mC/5fRuju1lklCncSCEjMPqtpjIGHWXm0TOkDSq94yYNOtfAUbWGli0OCXYdZ8txe8eAOmiikFzT7Mw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN7PR18MB660231.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wWMwaqJC4Cuko+26oJvi8bp5NDAqzwV3nFsjYD0DGv4kJuY3eYvXYBXCSS?=
 =?iso-8859-1?Q?ZqsvGicyUUR1MtlpHXcUwjYSpZ2eC71ze8R1wk1gM9yoMvWctmhErG5Fdw?=
 =?iso-8859-1?Q?bCVWzf6m4NvdJSZbVyqoUpPSmjVADI5h5QHJJvwQHBJTGwXSOCLQwXrOZI?=
 =?iso-8859-1?Q?XgtyGoDim/6vwnGDLAepeF6vPQmUnZeSw/B9D2F++R/VxHmuXPQiOBWIaG?=
 =?iso-8859-1?Q?Cbgir0R1fzOIXGcSH81S+li60sdEnZzTjG7RZshlM+PgDrk/YufbG4vh1S?=
 =?iso-8859-1?Q?YpxTxbe/q9mveN0CavQ4/9BaOVRXdVwTgmgmne6dRjes0GV7R1bQkACGOI?=
 =?iso-8859-1?Q?YT96WRUuVTUXo/btV7aEx4YX7atj7QZjSPDsQOMp78m+1I8KThHbXn9anZ?=
 =?iso-8859-1?Q?549usl8WLBPRJ6ZIxjE6p1KCSIsNBI01gn0wgXVz/Y5lqyxUu+TE9lVqAp?=
 =?iso-8859-1?Q?XHRweZbjVLcXve75FrG3X0Sv7W47BaNObE03UvpYcm27+e/9E+SsTYcg3g?=
 =?iso-8859-1?Q?JgwWH73qFbG6HSml1AWBWxWC1umDn5xfrC8px86sD1oAZzYQjF+U9Q0N/l?=
 =?iso-8859-1?Q?85RhM5F0Bi1OGzBF8LzY/RI7cew45d2dG3RmVGaC8iNnarsuVuYNghCCBb?=
 =?iso-8859-1?Q?7JcgOec74hivDFpq3wLhmvakEI3lZD9AfQf565NKu+Ty2CvDwj/IN/Rein?=
 =?iso-8859-1?Q?zsOd2WxAfsnGSFDc/NjaBpvJvyjtGCuFutHvuw4g/5Y/y+/KJ0IW/Ak6gf?=
 =?iso-8859-1?Q?q4KK+1kccWsDyPr+9M3mTXYCFPHF7HetqSdVIBgs9Pa7VfP/cfnKnd19M0?=
 =?iso-8859-1?Q?EMxcKYDUaAKGY/GuYKOD6YFqmeiD8SoFGgdXI3HY72tZGRIVm4miyJzHig?=
 =?iso-8859-1?Q?i+s60mMEwnFujnDLRyhYtMNVo5rn9+4BztSJTUMrjzfjcv6dSh01vqXD8v?=
 =?iso-8859-1?Q?ppquWtjrJYS6pO34WhGb6PYCbggBsgC7ToyxpWfhWhDbQ7jF37sx0d3hzv?=
 =?iso-8859-1?Q?+dc32dMFxD5u44ICB3RsJri9QbbrIpjDdD+slFRzIJMjSxIi9vnKlFQz1n?=
 =?iso-8859-1?Q?2R5HMesG1M3MSd9vmRthZKOB0PRJk0jrbcrB4o3GdEECHnMYZzsXu+7nRt?=
 =?iso-8859-1?Q?/Ic8Z6AvcXvprKRi+OsF71rlljWP1exE+LPDSL88BeKKSX7KHLc9kDUcOc?=
 =?iso-8859-1?Q?Kxj1o3QjlEmV/PlH7S85i6ZUYWuuKsT95exCEINiCnCt1nuzS9kFI1xcf8?=
 =?iso-8859-1?Q?L758xS3oTQ96vUQjxsFqbePjec6TcBTQUBtI68Lw0WnwDzc3q13NmnA6yc?=
 =?iso-8859-1?Q?2GbR5HYkcqIcp8ght0QRnFf+Ai4uj3eyZb9EF8D2ohb6w1sDWkwxutADaP?=
 =?iso-8859-1?Q?Qqt0DHGZ20UuckSDPJQP8edq8sChwWaW7yRxZRsdUXxzwD8MbnyliH7byR?=
 =?iso-8859-1?Q?Kn9Vr/uXb4fo9hdnLzb7C+pmqDiM68G507kcAyUD7Btr2ara0hO3FuPEWK?=
 =?iso-8859-1?Q?8bJJGb5P5SSpzlyw1GqgpzkRQEzliGhl+FZGDlhJyTXFwxKj8f6/lJ5kNw?=
 =?iso-8859-1?Q?pvDtWpVMiir1iuOKmpVaXJ9Fmx2+Im3+TDxuKQqK6jl1rg0M6vbCJInTCY?=
 =?iso-8859-1?Q?RI04Gv6ti219NODMUUPoRRL8Pp6hXubhi1gs808LIik1H2igriuNEoAerd?=
 =?iso-8859-1?Q?gm4ogAVuNMN6PPptTYrp9ye6kOX5Q44SsHh8pa7vccc398fyJKBQMHLOCx?=
 =?iso-8859-1?Q?NxR6jikUxes0mU4GcRblVdclZakuUoy9SpldsAxLO58YXm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u10kkG+cEpx4JpK0szQMITDdk6pWlaX1RHz5//JmpBatu7ERACsblUQpJ2Ra3Ihi48Kd4PC//SdUBg6KQUW9XsyCFg6QqbgsOEybIoMQFPxBnpI+NvCzsvyda7+W6cGmifmYQF2dZK9cKI1NkIb3VEDy247q5r0iUm6vK35Clzhr/ioynCJMKZuqfYIPPXsqp7X4ZQukKN+yAgoJ3LSs6tpbKxyMcSRcA+fn2jELophUbhXdHIMtAZHdXK9045/1GVIr8AcN9Qe2BbYE3JuQNWBFAvP6ZGqXQHMovf1PMxgKgwWmOh/K7TKVxuB8vZ/7AsjRN5SC7LvTbQoqSuzHWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN7PR18MB660231.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196d8f17-a852-4f00-ce14-08df295e3c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 19:14:42.5370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uij0UEY/2I8ns/bpK7/FcdBBuWwfym4LV0NZ9HCJxw9nGIo8i+609iu/121JgWdZy86akMnFyTcJF0jumCzDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6065
X-OriginatorOrg: amazon.com

On 2026-10-02 17:43, Robin Murphy wrote:=0A=
> why do the dozens of other drivers which also pick an arbitrary CPU=0A=
> not also need fixing?=0A=
=0A=
Fair point, I understand the scope better now. I counted 25 drivers=0A=
doing this, each with its own copy of roughly the same logic.=0A=
=0A=
> I don't see this being practical without first generalising the notion=0A=
> of CPU affinity so that it can at least be dealt with from a single=0A=
> place in the perf core.=0A=
=0A=
That is what I have done instead of the original patch:=0A=
=0A=
  https://lore.kernel.org/linux-arm-kernel/20261013185603.1347265-1-harisok=
n@amazon.com/=0A=
=0A=
Only arm-cmn is converted there; the other 24 are prototyped locally and=0A=
will follow if the approach looks right.=0A=
=0A=
Please let me know your thoughts.=0A=
=0A=
-- =0A=
Haris Okanovic=0A=
AWS Graviton=0A=
