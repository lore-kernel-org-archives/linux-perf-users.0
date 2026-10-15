Received: from smarthost3.eviden.com (smarthost3.eviden.com [80.78.11.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F41517BA7;
	Thu, 15 Oct 2026 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067773; cv=fail; b=cMn2rj2ntFMxXJ7ouZF+fEJDJ2dqXefeZ9Ukx0NajMK6W1N7F1BvdyY3WO48ucSIxTP2koo1XbXWH0M5FhH+BoO1kkokmQQGtfGe8+AoFcJQen/sA4sXsTWuP0jow9SI0FWz8k/uqjfOhlNAURSw5IMwJosXeWJd2ZwyvZeZb6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067773; c=relaxed/simple;
	bh=0Kd+y906ah9igCpwKWfRZkAE2DPXmFQ4h9unLQ2y3DY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P+KlS6KQqLvosKkIRg1JX6AC+B9voAQlR377gbs/1L4OvCE2Iivs1mYhTwXtFW1lJrDzeT/Oiv5cDOfZVpMg8GZ90WCefIheb0nshVgrWpta9ynzDDw+GgsAVHYzCrEyXpJm7JDJVyexOTDYkeKhLEF5KHW+NGoUa6gEAKpKYDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=wkvR+Yln; arc=fail smtp.client-ip=80.78.11.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="wkvR+Yln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1792067770; x=1823603770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Kd+y906ah9igCpwKWfRZkAE2DPXmFQ4h9unLQ2y3DY=;
  b=wkvR+YlnOwx6lTGNS751hgcyWnGxk//W5ngINbO+taslNBQ4xDjDgPIp
   ZSBjOz9QbbPUqW32SFLAfZZM7jwIIfj3AokJFpJBELGHeKgW5dEibFSWz
   xfgm8OhGf/6YTvKfZ0JX2LKEW+07uNDe0puOMZyMOukBogUYYjwNSBn6V
   xf0v6xMPXvpaQs9j0z0nMn5PWhzWmBjDNGGSe6+UjngOHGduFKH/VIRc9
   pVc1WCZmaZ4WhMsPdFH4dQq+2+dCfj241cM5g0ShSuV7PHvmrMkKOZIUB
   27tYXnI8+Moq5zOtAVwdfyUidWtLqtRBsgM++EJvJMgDtq0a6sxzKfESW
   w==;
X-CSE-ConnectionGUID: 8dnXBcs8SK+k+5IGhYPfZw==
X-CSE-MsgGUID: 5+u4fDPHT9KivRPHSUFjqg==
IronPort-SDR: 6ad0c781_rTcuznBReY/V7a6VlCcb09Tqyivpysf9KsuCYfm1nlnrCcf
 8PeT7h4+hj2CvcCeE4fA+DA4FB4Wm4A77lLUL7w==
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="48945334"
X-MGA-submission: =?us-ascii?q?MDGncPpHHLWv8WLInC2KrmRzFfE+vkmMrlR8Z/?=
 =?us-ascii?q?Vp88DTKuJzHPD3ItP31KxrQ3vakNSHQdA9QEOaUxL5o7lIPP4D6Xq4Ak?=
 =?us-ascii?q?JySxoS/E3bMrTByfpEndjIu9CnZ7QYa37BiNqz68B5y4QZordF6cDDpr?=
 =?us-ascii?q?W7UzW0eaKJSTGJfNESMGP1oQ=3D=3D?=
Received: from mail-francecentralazon11013029.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.29])
  by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Oct 2026 14:30:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzPhJ+3YXSHG+AoA7RraOij00IVTXjB5bPCudcLY6XOM4/yWrb6/LCjM310e5HjTGpV4nSpwh+QuY6N6kfQwrCUQnRYzcLlCZWvKzm3KOvyDaQfBQ5i2JEtVVL7pOrdxVBArxPjY34ZcSbHg0Ew0h7EUfw7+jEhn52zqf2MS1A0iVmi4VacmWXVQsBZSwFwL9ZTgsTZ8Y79EMgQJMewu6r+06OHXJMZC0nz1sVf52cTIFBD+zDq0jpjY2ZKReH8+jQJPvS5qNLv5edGxBeD9/r1UMPJTAmMl10efpzUMova0zkjBg1KPzOfvXXnfTZneSQM/AlhMPISZv0qRbw7nmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kd+y906ah9igCpwKWfRZkAE2DPXmFQ4h9unLQ2y3DY=;
 b=cgIgUNCfPpfAGhhOBHUPpgH7nCFS4GAts7sGfk10LDsDj1OIiW+qu9n61Iluc5HgKnn1EzniBsF2S0CbekhuI6gr9XM7wlePsIO4ZXbNdx1lFwcqLHckjNNLQMWYJ3ROl1DFty2Xx6Ot0jF9NX+Gij5LdQ2n3ug9R75NSLPpKGa3TzUWj8dovsJgfaKObMoKXmM4KCl9YQmiQ9LnNKp9u48WQMaVXXNQEAc7csOu+0SyYW8A2dI2+YFXmuh84iOK/wteMRgSolCmiCuM5GLPTPDebRh+HE+RGLlsM5xOveSRNPbW6Fha8RPj2D0CaK4JO/zBt2ZpJIgoezmzoCdviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from PR3PR07MB6922.eurprd07.prod.outlook.com (2603:10a6:102:7e::12)
 by DU4PR07MB10181.eurprd07.prod.outlook.com (2603:10a6:10:585::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 12:30:55 +0000
Received: from PR3PR07MB6922.eurprd07.prod.outlook.com
 ([fe80::5fc9:82a2:51f0:97af]) by PR3PR07MB6922.eurprd07.prod.outlook.com
 ([fe80::5fc9:82a2:51f0:97af%3]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:30:55 +0000
From: Antoine HURET <antoine.huret@bull.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] perf: Rewrite core context handling breaks
 multiplexed cgroup events
Thread-Topic: [REGRESSION] perf: Rewrite core context handling breaks
 multiplexed cgroup events
Thread-Index: AQHdXIPxt9V+Q2OG/EWPpW1q1Q1eEbb+c1IAgAATSA8=
Date: Thu, 15 Oct 2026 12:30:55 +0000
Message-ID:
 <PR3PR07MB692235BC98DAB96E30E4AB8D849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
References:
 <PR3PR07MB69223331EED5BEBE150375B7849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
 <20261015111316.GJ4121339@noisy.programming.kicks-ass.net>
In-Reply-To: <20261015111316.GJ4121339@noisy.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_Enabled=True;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_SetDate=2026-10-15T12:30:54.670Z;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_Name=Public;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_ContentBits=1;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_Method=Privileged;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR07MB6922:EE_|DU4PR07MB10181:EE_
x-ms-office365-filtering-correlation-id: 08a4cd2b-783f-465e-6965-08df2ab82884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|4143699003|11063799006|38070700021|22082099003|56012099006|10067099003;
x-microsoft-antispam-message-info:
 HMleewrA3gkzpUb+s9Je/w3DFdmKc2umi7dA29t4ld3Vfjcy9awenewCMcZ7Jv8AaU674TSbus5jPkLOjRXcULgGGwwFf5C77AmSmRcGFG0jv0PjTaozupVl/0GDJpL0h/XtvYwQW8ZdXjzf88xcmjNsR+B6kkk1u8+icC3nsCI/H40NN6HgEZUPTeZX32mt94W19Shg2NcvpwO2q+6M+rOhMkPbgl5ASS/0oakjz9gd6E4wdsNq8BB7JJ/E865esB9lk+avZ9dd2fz0mDNTZbf/wBaGHauo8BnweAp/zj7es3cjxDCKEujcBJNQbYmuOJTlJvmdRxLGk/1WyWoCTHeUM8gWa8HF88JHqPxELovdEirIDub7s8VvnPHZk+fUxJA60lD9QHi4OYIDVGoJcwlLg747Cqmq+4CFQ/WNQso0gT2Glux4Mul69shBWy8usH/V9ZBrtbWFCkem/Tcx3Gimz1YazjEqawZGADEq3YkWSPq5b9WZSLrvolatAu5VCbhNUdsKI0zQvWx5I0qOLJ3es+yp0XgxlDDhHZ+x8UsLuuex1Ra+Apzas3b3VANqrxAXnoZLsmmV1mFUnuuwymvEmtm9Plv1NJPqMBG01o4xRIWS/ioTwkTghtZPoGgqo/uIHtODS8n1Th38SNxZ3iv14gpKLBLYgi3jVPH8NMCK4NGTxrzxSHShbAI02vF+dnQDJd996j4NoMFqitprX0AUFf8H/MtV57TtJu1Lmgs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR07MB6922.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(4143699003)(11063799006)(38070700021)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JBf/zto4kK8ONHC2hZdVAga5uX2PWhpbH0FYIgzbEqIh1Y2+ZpxZLi99lS?=
 =?iso-8859-1?Q?XPAYDLuqTMS4hWa+AbwL1fEQn7ewZW1BhLjlQ2TYbtJPNJLEaN0XNjAGIY?=
 =?iso-8859-1?Q?9fVfPEcPIW7bpD27plszNX8HLRvcf++tuAhfAQkoL8m1dOt5XvpXMTSKwe?=
 =?iso-8859-1?Q?v9X7LlwGEan1Q1WP4kfIuPTRK6JDMiO4RWoFSKBPEevUYas4OYBDdehZML?=
 =?iso-8859-1?Q?GAGZMS8xNnQiOPeVPVhaDluvPst4ycD1DfcYDRMhV/cs4QILFFpEpZ04rR?=
 =?iso-8859-1?Q?ws3E4FFtrtKga0URBUnOjDjdbCCYcN9uv7vb3fl1wUxLwHcE6jpnoQvWe5?=
 =?iso-8859-1?Q?c0khikqLlskV2v5Zb1wTP07eaGWA0cGNbTUmqSJ5ZPNXu3ipzogrT1cNvm?=
 =?iso-8859-1?Q?X7tZHcCTqMOIoxRZgRaQ1sI9UlNW2YmwlsOb1goHwiJbo++6pwiZZa78ET?=
 =?iso-8859-1?Q?o+5KmFMr8S3GFAl93K3yGSz/tocJ4a/l3f1IWWM3e8IrfhbeK+Cq4EDAJd?=
 =?iso-8859-1?Q?Ho8Z5fPxD8Xqc3Zl09yWIcIKqaNSljkxY+HL8wgFeyVvyjetchCEVCLeVo?=
 =?iso-8859-1?Q?wpS9iTiCzxc8x75qF2t3oWd8xpUzA53BSll9G9sMBAdVOQYUGNvd2ArJzU?=
 =?iso-8859-1?Q?gp5a7SZ++p89WSxR8dojX06LFcyTFEUMBkX5P63jyqb77a+od/luxlu/N8?=
 =?iso-8859-1?Q?eUKpyzQWOxCDECezGY8fxMYpq8JgjgFeR3MUxJrcHUe6bKcyfwfRFQyf2F?=
 =?iso-8859-1?Q?T5ypVN26p+fuD+LHbV689HWiH68R4oRs3ZogJVUar3xFEkQDji3nghElUJ?=
 =?iso-8859-1?Q?bd/Kt4NAsJXbMIIRYZzHVGt1wq//XpLVln7FhjGwaeW92YlZ1HON4QY8ff?=
 =?iso-8859-1?Q?bMZ3PVITbYrxRScz4KubZTiiQiHg/M+a4/39ekrx4oZ+J3OM4R4AIniHkJ?=
 =?iso-8859-1?Q?1KqSTTPr5Lxo0bSbPDrf/ujMZKoFQgOixGF7zVyCgnEo1Zok7LXPvTJZtn?=
 =?iso-8859-1?Q?XBziYQ50LNbksjTaIs72FiCy4GX8gDgtQFDT7xHSfoVzYGgfpGObrwoqrR?=
 =?iso-8859-1?Q?NKgfNDH5lS7yySYP8q8ea9hFhiDhgUm/Ijw0c53T5LvOV4SQAWlhldCiRv?=
 =?iso-8859-1?Q?xCoR0heQukeLj24RaRYW0+uSiRJ3MAxRFhr6CbbhQjPx+wYe4wNEhPy0ko?=
 =?iso-8859-1?Q?fZ0gOSFBPEbBmVGC97kmb2RXXW97b5byH85HPNsxnTEYKHlHtzD+DlQ6my?=
 =?iso-8859-1?Q?MUqgWcUdbFaPLUA2iUYrweA/3/mOVstVoa6c5FN1L/jyDue15V0kjAyADb?=
 =?iso-8859-1?Q?qprRvzJusxKWCKUp/4MZwjjKaOJzfX/6+1jF75ucWs0gfCG+GUpFQBlaPS?=
 =?iso-8859-1?Q?MmemHVD8bX0spIsvxLceX4Vx622fR7rhHv86/tIU0ptoJm50phDtIFARdg?=
 =?iso-8859-1?Q?SvP1TijI/9Q5+2LJ5A7iubK6WhE9LS3DYhZwCuRGh7Bp/W/1opyg0OpPy9?=
 =?iso-8859-1?Q?lwCfvCJz5fZzApKcHmrLjyhQoH9zxvmFcbrCdWFfve1viUO6DqBeyWNZpt?=
 =?iso-8859-1?Q?dfs17Hfg8V1A41wZCYdmrorCD10VHzyZ4C0z7qXFDCRznFf7qBlLqvKCuJ?=
 =?iso-8859-1?Q?7gAB1xqmy7vacGZnEl7TdcWVkeh7Y1YpQRKPsEnHtUZyxp50nhKvAYkW5i?=
 =?iso-8859-1?Q?4daCBTlBBdDWCqm1K55MjJHti6+JY4vVsZUlVqTFQ8BWmjYBsUTUqEdfHZ?=
 =?iso-8859-1?Q?MltaUBIoaSvWE7QEUhvaEWIpxFcCmwNSed0sFPHsqEewc55dwM0b1ZwwjF?=
 =?iso-8859-1?Q?NQ9ssk4bUw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	demIvuMoUQ04BDdWFVP1LZMI543+4C2vaMeLHuKWfqgTKkDU8bEv35/SvTVfevHCoMBm+eDdpzUGvwXWQPSDaIYpEwIoXRW9cCwz4tRcsduWYw8NOzr5i+DW0v30Ik2f1X/iB95UsEz8ccU/PZ3Lnfz8GSD1JBHxddYFe3AWY72+P7ul5vg8QqRbfxgrkNknVuS0W1iJ5mVoqd3xY87/ySQyapdg63ceDOBc/rXtHrtTr8XZPeQJ5olhmnJHOkqZCZUdYKt6saIein3/YMXDDbjpW8A8lLge2ZJP7ZovwcP2JdltN8Y9IGBc/mFWbA2aICKqVSeICoUch3t1NhuvCg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR07MB6922.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a4cd2b-783f-465e-6965-08df2ab82884
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 12:30:55.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rf5N33mzjs7sRGkKJeWO3+jnsJY/K6C3dxa2pB842Z471NyUqt/RibGNwAaNnum7WvcO/C6jNZcyD/NGKJx8EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10181

On Thu, Oct 15, 2026 at 11:13 UTC, Peter Zijlstra wrote:=0A=
> /me mutters something about having to go install and learn docker and=0A=
> what's wrong with simple shells scripts that poke about in /cgroup=0A=
> filesystems :-)=0A=
=0A=
Fair enough, sorry about that! Next time I'll do plain cgroupfs,=0A=
promised :-)=0A=
=0A=
> Yes, I think this is right.=0A=
>=0A=
> That said; while looking at this, I wonder if we should write this like=
=0A=
> so instead. Although perhaps we should do this on top, your patch is=0A=
> trivial, correct and more convenient for backport.=0A=
=0A=
Thanks for the quick review ! I'll send my patch.=0A=
=0A=
FYI, I also tested your variant on top of v7.3-rc7 with the same=0A=
reproducer and it fixes the issue too (case 4: 4.367 - 4.388 G over=0A=
20 runs).=0A=
=0A=
Thanks,=0A=
Antoine=
