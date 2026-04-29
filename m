Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16323ACA4B;
	Wed, 29 Apr 2026 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.38.203.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497158; cv=fail; b=lnuCQ8bNUxvL+K4IL4H1h6tLggVwYMt9TX0VbZlyyPUXqfHC/aQePScCMowAb3yW7jR0r/QsvcIBO9MJJpwRX81EKY418spA+2sG8Qj4ayIfJZyMoYxEh37tJMtPjHM7CSX+x4Oiu0V2YhfwiN12jEYjSYXVNtttyDrbKGgpras=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497158; c=relaxed/simple;
	bh=jBnZrijUkE6XA7UeizHCz2UuKEFQFMIk+EEsrJ2vRQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YZz4ZfFtSQzKMiWr1oSXQmQdyx/EvCQhlmgWM3PHUWfzJ2xF21G+VAP61mmA/SSc89QjKcYE6wbwVixBvassz29RsjQeBKTmrkawHV0BUJhwAIVKl6e5jvgmdliycl3kqrOL391EvSjkBHbKNlHEITZIZ8HCdX4O6ByTM0R8udg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=GxZrueTD; arc=fail smtp.client-ip=173.38.203.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="GxZrueTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=933; q=dns/txt;
  s=iport01; t=1777497155; x=1778706755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lz90VLojantPNg9Tng5YQ8XduYA787TGkRqKJZJDUrM=;
  b=GxZrueTD00O1eKVrtJ0/YyKeVcuWP9KSgLrjg3fOJwy34blIr9tw4kms
   sJjkaMdG/z0hqRiFK700lYvD0soupCsdqVxqTADjfRulEr6+n0z3HLfDz
   0vW0jfqvCq2GBCaIQ8GzG8SewRGeFupPjxGln46GwNSRp5tlgy5wnozek
   Jk5lxWzffbO9Q4C9YZmjZ7RcfZQ4k9kx/gJck4AXoJmyz3abwhXf8UnGM
   fvOKxgvJXeU6po+mRsSXUh/WujSxRZY1gi/gEFFy/L7EkvGRxS5p6NDJ4
   JFAohXYdDxwohUj4za7R60VK1kKy4HmKuhRPqwX3KT7xvw34MOcuHXVMa
   g==;
X-CSE-ConnectionGUID: l+Zl1MatQKqWscR2xx6E0g==
X-CSE-MsgGUID: +vJ47PMhQ8i7BLlyFSEnhA==
X-IPAS-Result: =?us-ascii?q?A0A0AQC1cvJp/9JK/pBaHQEBAQEJARIBBQUBZYEGEAkFA?=
 =?us-ascii?q?QsBgWlTghYSiGwDhSyGWIIkhXqMcY0uDwEBAQ0CUQQBAYUGAo0xAiY3Bg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXIZbAQEBAxIoP?=
 =?us-ascii?q?xACAQgYHhAQISUCBA4nhVQDAQKoPgGBPQKKKniBNIEBuhIVBYEzAYhXAYpwJ?=
 =?us-ascii?q?xuBSUSEPz6EQ4ZEBIIigQ6DDYwJUngcA1ksAUsKNQwzcEMDgSkPPAU3ZRI/I?=
 =?us-ascii?q?R0sHzkCOAcFEiERGW6BFHQhC1waDiEkEVlDOFQFgXACdoEoGV8jLANOMQN4P?=
 =?us-ascii?q?TcUGwSPWhOCXpNqgnOQRp9ZCoQcojiDcZQVklIumFikAIUWAgQCBAUCEAEBB?=
 =?us-ascii?q?oF+JoFZcBWDI1IZD9hDgTUCBwIHDQMLk2UBAQ?=
IronPort-PHdr: A9a23:BkvCAR+PMQg2Hf9uWBDoyV9kXcBvk6//MghQ7YIolPcTNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:gTuquKxisIZhtojss9R6t+cwxyrEfRIJ4+MujC+fZmUNrF6WrkUBy
 jcdCGmFb/iIZWOnetx0aI2zpxsBupTSyYUxS1Nr/lhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCKa/lHxYuaJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4iaT/H3Ygf/hWYoaDNMt8pvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu/Pz1JSGauNCq7FT5aHDWmeV+UmxuMthNkgp3KTkmG
 f0wIT0XKxTGjOWszffjG69nh98oK4/gO4Z3VnNIlG2FS6x7HdacH+OQvIcwMDQY3qiiGd7Sb
 swYZD5wZTzLYgZEPREcD5dWcOKA2yKgIm0D9A39SawfoHbxkFNJ9bjUYNuKUPiOVOtus0CYj
 zeTl4j+KlRAXDCF8hKB83SxlqrMkDn9VYY6CrK17LhpjUeVy2hVDwcZPXO/oP+kmgumVshRb
 lEP9zA1hbY9+VbtTdTnWRC85nmesXY0X9tWDv1/9BuEwaeR4AuDAGUAZiBOZcZgt8IsQzEuk
 FiTkLvU6SdHubCPDHbY/bCOoHbqaG4eLHQJYmkPSg5tD8TfnbzfRynnF75LOKW0ldbyXzr3x
 li3QOIW3N3/UeZjO32HwG36
IronPort-HdrOrdr: A9a23:JMsmXaE4ZLznscZ/pLqF1JLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhJk3I+ertBEGBKUmsk6KceeEqTPmftXrdyRqVxeZZnMrfKlzbamLDH4FmpN
 1dmsRFebnN5B1B/LnHCWqDYpYdKbu8gd2VbI7lph8HI3AJGsRdBkVCe3qm+yZNNXB77O8CZe
 GhD7181kKdkBosH6OG71A+Lpv+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pj9iLjjPM3W7a6Jpb3ODm1sZCA8K0jM0UICXHiwqjZohtMofy/wzdptvB1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6xmxLY0InEbQN/L/AEqZNScxPf5UZllsp7yr
 h302WQsIcSJQ/cnR76+8PDW3hR5w6JSDsZ4KkuZk5kINIjgYxq3NQiFYRuYcw99RfBmcYa+S
 9VfZvhDbhtAA6nhjvizxlSKZSXLwYO91G9Mwo/k/3Q9SRKl3ZkyEZd7skeknAcsK8ZcfB/lr
 j52mACrsARcifQBpgNW9spUI+5DHfATgnLN3/XKVP7FLsfM3aIsJLv5q4pjdvaMqDg4aFC0K
 gpamko/lIaagbrE4mDzZdL+hfCTCG0Wins0NhX49x8tqfnTLTmPCWfQBR2+vHQ78k3E4neQb
 K+KZhWC/jsIS/nHptIxRT3X91XJWMFWMMYt94nUxaFo97NKIftquvHGcyjaYbFAHIhQCfyE3
 EDVD/8KIFJ6V2qQGbxhFzLV3bkaiXEjNtN+Wjhjp4uIaQ2R/pxW1Iu+CGED+mwWEl/jpA=
X-Talos-CUID: =?us-ascii?q?9a23=3ATctIumjif/jZzXOsPq5FJmjUxzJudj7vyC71KlO?=
 =?us-ascii?q?BKn9WU7avE0+Apo48nJ87?=
X-Talos-MUID: 9a23:8chLkwYrmwpWAeBT9CHO2G5aEcdRs6XxImQJgLs9ls+EHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from aer-l-core-09.cisco.com ([144.254.74.210])
  by aer-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Apr 2026 21:11:21 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-09.cisco.com (Postfix) with ESMTPS id 9AD7C1800080C;
	Wed, 29 Apr 2026 21:11:20 +0000 (GMT)
X-CSE-ConnectionGUID: 4FrMuVk4TfSCrLwYXOxCKw==
X-CSE-MsgGUID: JRb56WxSTjyE+THCMNCHDg==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.23,206,1770595200"; 
   d="scan'208";a="54733073"
Received: from mail-dm2pr0701cu00104.outbound.protection.outlook.com (HELO DM2PR0701CU001.outbound.protection.outlook.com) ([40.93.13.68])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Apr 2026 21:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5gD/CVH3pfQNOfiHa4Knp6ov6PR2Xw8eDYuZhN0ZR5jsbYw0aWDt4clHRvtwCJWSDpXecib5h7t/oS7ZzWq8tvQnaF1PI1hidjmxRkwOH4FBaLfbRj64oHQAHDW3cy/dw9HAFY3X46yJkwsovwJMbx2JM0ZpnlJRkpbPzU/LPeMBmIZsvqho6vy1ITc2qDx1d0pBS6ETRwfyYw6Mp9lfMxM4of467VNQrox9h6nio2t2uK4r3Mupj/3Wtgx2w2vg4N2Nyw88oRN4t9DOAm4lg1r4zDTrwYSlq8IvcF49rP1wJ7DDvCRPlViK9vb4UTOfOIDdaTAzs5FQ9C96sRktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz90VLojantPNg9Tng5YQ8XduYA787TGkRqKJZJDUrM=;
 b=d0lEw3aZA9nDoGCSR4LWMCdDTmLFVQdPbzOIh5eXPk+bqUnggo6g+zHFpPrPpGiBmDunIFZsvD2nJYFelm7+g+sVKJi1q3ztISoA/8Ic6IoFex6wkAAljgKpUX3RsC8oZAYcDfutvYvVWGZRcu8jKoKym66NI0nYSNTsTSSvM/sJ7Bmk8jjpJbYQC0cATYANhNfXcKDbHPdpHuWAeW3gbkD1MituZ2GpaKIJVRRwbzUnn+gtAzJDW2nyQ1/WeYAnXz9LmqhA55xGUfwVtOjpXUhekkNUbxhlpOXtCMfuUm8ipiteUAgvMclhF44i1x5MkKdudjNdH8fgTKLVXKwTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 21:11:09 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::abf2:ab63:49c7:e31b]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::abf2:ab63:49c7:e31b%6]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 21:11:09 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: "David Hildenbrand (Arm)" <david@kernel.org>, "Darko Tominac -X (dtominac
 - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann
 Horn <jannh@google.com>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Thread-Topic: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Thread-Index: AQHc2ByyZsE/4mJZnUC+JXPldUxtUA==
Date: Wed, 29 Apr 2026 21:11:08 +0000
Message-ID: <afJz3l6435DHLorn@goliath>
References: <20260429131522.4049054-1-dtominac@cisco.com>
 <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com>
In-Reply-To: <afIiqR5CqYRId0N0@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|SA1PR11MB6917:EE_
x-ms-office365-filtering-correlation-id: 873f1286-b8c8-4a67-6915-08dea633d58f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 EavewLdqqm1BmYhzRadeRe7wiHIh3M+lp9hGQ2uwNQhekzObUtSZ9cD6xJLIRBmcCoF6kcPcWT23sHIpv2i1Xpw3o1vuY8arWFcBQ2qoZtJhKKd6tR6XPcfvd1WsuK7GTPkZUmhYcfOEotdkbgNc4jpFWmUbywsRsZLEdQOUDR7XQjOFdQQrnGOV7ak1ghFd4YBXS+tRIcZTjXFrjz69I6rhnmFDHStIGjSxdkYodaGHqTspI8IYEWRdcgSPyvlkw60mqYny+si0DrYaw9LBhRmZq0AwAWFHWeBDzccIeVT1XQCN5FQpjJjhn6BJibQWBzzDqFXAtZmcxI7X89EuQrWU5cHp4tX7KVk1ypBh8rgR8X+vR3Nf9pLg0ZyWivC3oiQv+xI2HKgf6+Ab4kaFeYQy0SPW09DRYkhJ1DF8maX9vBohtYZmNnr953Kt2J4TV7YUhiQIqMeq8RECJ8MTJU2r0p6dvNMXSOszpPxxS6S3IL2vQ69/4kVdxEDLRsXWHDqMVS9HaxbdMbAUnIztWI2aQj1ctAq+IUOsuiYF7wSuSmoI4O/C45grO58NbW1zN/rXOleJKMtvwTNF7ZmUb5KRc+1+yJC2onZwCQ92nKKPKSM9QUkL8/23RjZTKgpVQTUCxnYMn1DBNSjx4bFwkjmjlkbQksNRk8t/EVVAbykVzHdi1F0jzVaeDPg5qJSg9RWvDSsZ2kN5wvQuJdkisRAzzUoWGyClIOkIUeOvDqVQcazgOHlxPSk7plp5LmfXJrcf2Qm6XcjBfZBnaf6iPaxIjVK9PRE5E21cFjxIJyQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uAquIR9/TEhU5iz9d/mZqDCdmj9B2ycPhIBVeEnhgy+5tkizmBI0Xp0Uv+to?=
 =?us-ascii?Q?m0Q0WCJY/9BRRMz1wrfLF2HCsEQYMJfC5ObEZEXcP9+ISlJdom+wY0kpoM6w?=
 =?us-ascii?Q?4Dqxqu5puTRGmIwvVv2RyGMJ0tySBD5WPQsEgcS82DPKjsLeMyQPTRKi84Ab?=
 =?us-ascii?Q?9cGrs9tdr6uuu2C36EhTfZDPTB1C4vbejeFRzmrtjB7f+CeG2mqjoAXKDdn4?=
 =?us-ascii?Q?qfXFUUd56kNJKXZB7mCqBeW/hyExFqqwnaYzmXPzGPh5eM2LTp56Wjj69LQa?=
 =?us-ascii?Q?4/y7uPJ/BtTm0qy+aRCJqqfRxfc84YhVfOshHzFdkAp+0hDpsVQBUiUnKemr?=
 =?us-ascii?Q?2fEV/XEsDptkWQHyWoR4m7AHPMgJb7Rcg2egz6Q3JyZIaPLzRfMZZ9f0n9hx?=
 =?us-ascii?Q?O42LlWIKjBybGY3OSqtCenox6cVtrObv/Je3lBIwqmtjGzN405LpjN+UMI3F?=
 =?us-ascii?Q?jBsJwuRqKus5DU1jpnoV1RNMe7pc1Q1+U1J48+1hGg8oj7aRZubBFXmeJDcG?=
 =?us-ascii?Q?Jo2ZxGGWvjU+xb/GHckm3r6d/lfcp4AYf6IG9Ibf5Ysn514c3dvzReEz3d1q?=
 =?us-ascii?Q?W7YscBGlVrX3JA2erdCOh6NtBDYavOo/YJA4Ao7YDQ3TmETLwX76ZWi6yfNF?=
 =?us-ascii?Q?4NvBySgMALHFv2EQkT2XoD5E913O24iBIMffHUF2WRhE5doqL6ddES4lTr78?=
 =?us-ascii?Q?wgHtIVPE8UX2FySqLWz5eG3vJB3PE49h18Edh4DLoWawSApE4wXhdYVeZZMc?=
 =?us-ascii?Q?sBrxy+LyrW7bJBneFUwEtmvOLNlne/Vw70pDhOzgME3JFFwLpyMuqTDYC4ko?=
 =?us-ascii?Q?diGbN+UVBzFekMR2wS5CeofiNUP5DVOmZJY9RNSxoLlWBXCutrIA1x5beHYN?=
 =?us-ascii?Q?xUbFpl2g5217L8FjskgEa1NlwCf2MJ9hGCbk6eM4i0sKfP2LuQc/4j03634w?=
 =?us-ascii?Q?GBKaVZwsz54CxSxS43yCVjvAAmLn449Pg9Noxxg+/ciAeaNfe6Vwigdpi7Bs?=
 =?us-ascii?Q?5brFwDM0QUNYRYX7hGkyeIzkwwab0OAwEWgeuOFIcMVSZrfcDzXbVHNHYza5?=
 =?us-ascii?Q?BX87hIMW9JjaPoGTYYKKG5dYBmO/evw6C5ZlmWCPtoTQxgqV7MN8O0YpEhU6?=
 =?us-ascii?Q?53x+okT9Yy/7gLDVcNoeZGC20MZBkobTWKr4ItFwt4/5rndZZ1NPUzDCMq9Z?=
 =?us-ascii?Q?m1dySyFoHDI/PVq0e7qbAkb9LxCzNRq2STgdvk0hvbZTEkRLFE1wvAApPJuF?=
 =?us-ascii?Q?5tDbmhq4P9n1KEVyg9I6r4sZ/Ad+KVmlX3DxjYEGllHMfAi3iZbHSmbBjxo/?=
 =?us-ascii?Q?hLII/EJ47rRKORUH+1Z4IfWbkGE3/DeX9F1x/b30wsSSEvetntoyZvBZu3cg?=
 =?us-ascii?Q?yq+7HGxzsJGa9MqF5QrpJ+r+zPgwmewHeJHTuqQapxDquh8A3okA8prBa9VS?=
 =?us-ascii?Q?pofk6tHzBBmAfrJXIBFy6nVBdyUwSFsNKMN5lRXF5BUf5EwLA+sBbT2L0sqL?=
 =?us-ascii?Q?UIX7l/hg4HLro7iVtm3MGJFPDuTsc4llr13NHkxqD1SE9/VNfHf7Wa2Vbqc3?=
 =?us-ascii?Q?wnTzni8jRdDRQ3sX90JR2///1M3R2mkmOZ1btEvs7gBncygmnOihsA7wljlw?=
 =?us-ascii?Q?Dbyi3vVR8L/nHYC4KyPwow830FsrUeUATlaVZgi1T5djBWbzd4JBVI/YGgDS?=
 =?us-ascii?Q?b9w1VYOa8vq9/c9E0zuk9MftnKuUgfIPK/sOE32c3dL7cuQqndcdkbW1993k?=
 =?us-ascii?Q?cKQE5MAXCw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0820FBFD37C13A40820F7C47397E2063@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kJFGqiS7khpypLnDXSfk3K+3fdOMZW0wvZ6kFi2+tx0zIBpRlZPUg/VgwJXZpdiqJOUQJPVjid4sdZb9DiIa+NrXMsG//uygV8mNuyBEGOg5RJoBk8TJ/CcExAcj/+sx164f2ipFzPThQM9GzGyA154Bxd7zD+W2DTUwpnWDWMWc6Sye7SBJv6oe80hIiLaxRXpcj82BdOPb1gm1KR3pYrGETHEIjtw1Sdjcr7iySk928K9CmXcqtcND2Sz2B+FJ8RCFkRoFhKd1XuKJW0tGEEJ0in0ZACwmCen58v42bI5CG4H/Z9uJhkF41BK6ooSjTTt6LlsgFpeKwvtPZMSCwg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873f1286-b8c8-4a67-6915-08dea633d58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 21:11:08.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB9g6yjsYkN3hu7UlU0QkcKLWDJ9FwItlWG9y+Aea2CR3m1+VDrGO3Apz6qA7aJcCgTA8xeDsG91tvTmExmRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-5.cisco.com [72.163.7.169];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: aer-l-core-09.cisco.com

On Wed, Apr 29, 2026 at 05:24:25PM +0200, Oleg Nesterov wrote:
> On 04/29, David Hildenbrand (Arm) wrote:
> >
> > On 4/29/26 15:15, Darko Tominac wrote:
> >
> > > uprobe infrastructure does not re-instrument pages on individual page
> > > faults (uprobe_mmap() is only called during VMA creation, not on
> > > page-in), the breakpoints are silently lost once the discarded pages =
are
> > > re-read from the backing file.  The probes stop firing with no error
> > > indication, and the only recovery is to unregister and re-register th=
e
> > > affected uprobes.
> >
> > Right. Don't MADV_DONTNEED uprobes, just like you are not supposed to
> > MADV_DONTNEED debugger breakpoints/set data etc. :)
>=20
> Agreed, thanks.


Shouldn't there be some sort of compensation or notification for this, or i=
s each person that
hits this suppose to just scratch their head and send a patch that's reject=
ed?

Daniel=
