Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5334A935;
	Sat, 29 Mar 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743247901; cv=fail; b=nvQ28XiSmi9swfVpeCLo/aFDWuxtyCIpX65mBLZOpLZgB+/+SfCpDws7uuBZT1RHLyE12BlwJJqIK8dTnyfk4n+K7ygjQ4LEjG6QZQlFOOWgYKehuMZauJMEhSOW87LwTY+ugFdZv6ZyupW2sz2zn1+SGAZ9nuc6zda7BbmAgvw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743247901; c=relaxed/simple;
	bh=39rq80eaBHcEC3VFDB7Nknj+5yv4W3Ep9aZMDUA+4BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YUbfmmsWAJso3DfExqUoNwtDyr9Fx4OUaHXlMThNw73aooowVSlgYdCwll5OSTzPhpEh/XMB/IYheImQSnzz46P2OyKSQ6CLJAOOE5RqGNmjE4OErV2mgGX+p4u1Znp/CF5yD6kUL3ReIgw1QiMYSVpYW1RPLBoyggTBsegN7Ug=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PxiWCMDB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PxiWCMDB; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PxiWCMDB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PxiWCMDB"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vZdzojafkWlR26CV7aWojTp6/w0PeDsRewevtCy8CBJOQ8s0B9n8sz6FfnkjX2eWI/ubkZE6VYTF16vRPrzybMnUZPTx4kwmWIOq63nANd33dbUFyBviwy1+lNepgzt8bpRaIijgFXPTqL9YojdVbmlzQ7FQ7wwU0prU2Qny0W3HlGVnYDnomPmq21fmFnLjb5U50X8PBFZNYUmAlGFmogKS7NHyjDkWNIVoWWSsUiPKyVfJUUGDR1DlUtp1cSu7BawW6IsVHELvdq1LuO4C5fo1XlcIag/pciDXjYOvw8lnoPitWytf3FZGS+LlVUIYe82iaDPa/BPUWITyl04hfA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPhVG+DAXdY1vOd2yH4eUhHtVN5IauB3wgfygbcIi2k=;
 b=Vm8Zp+pmjItIU+RCnP/VjohP1JhUNZb96nFn0+NSs+z00VOkPts0UitFAJyBI+td7NwjiD8HdP2hE0MPoOQ9cPeJjuSERU8MGDh3O4zS7Y7njPVrDgepTtJuU1Ytb4Phe8uWDH6AGp4AxpwgaWVw3/QqseJoFuc6w6yySv7oJypNAyjL9MI+Tmj32jVUvA9wJ2Z2JvLr+ImfEWdKQSSMHEmxWt8q+sjASu4Up5u8EuL2zPxq338Iw6+2cYRlDGZp9lEn/1c83Fb5txwlkZtSsOyZ43KLH55EcYlLrZg6Altxq5ZRj/M36oDLV8I4/xq+/fvWHbXsfn9PRljvKe0yDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPhVG+DAXdY1vOd2yH4eUhHtVN5IauB3wgfygbcIi2k=;
 b=PxiWCMDBzQ/2g2jKwmN765dNnmwlEHiBVYkYzZjRd7z8GucnAikeSSgug/48iBkN5usM0jkynrOoFI3ta9ZQg762QbBJeAiaqRf7jL3nOyvrGcX5mF2LrVCD2YKCZCI5ZiHNSCJs5goKdlOqgUgWzpqA8c3rc0HmbjSF/6gCbU8=
Received: from DU7P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::9) by
 DB3PR08MB8962.eurprd08.prod.outlook.com (2603:10a6:10:43f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Sat, 29 Mar 2025 11:31:33 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::59) by DU7P195CA0002.outlook.office365.com
 (2603:10a6:10:54d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.50 via Frontend Transport; Sat,
 29 Mar 2025 11:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sat, 29 Mar 2025 11:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afp3T6lWV7oPaYL2yhjFZkjjkCZbvFoq/QoedBfEtAnPExZTV7rgr0qzBht76awaFFL38TryoEV+cNoanpO4guD45xuBanjva6JMe7H6ug3xtYaCvYads+GX5wnedKOTylzDdLpfL0kGuZ6GJipXFl/6Sfu8OjJRZ7IOc51B1ff0RqAo8ypgtjmz2s5f1cdksGSzI5YE9RUdVSRvDF2osa3X6338yWo01PJsHnlU0MY/gvTN3yyKdq/ZBOZlefiQAFjz5W0T3XXU+RLbJg7+B3t35LDh975ieRxiJCrBvmzlkPK0UR3qyfmAlBQrEF21ZTv3d7F0L3xBtArr70sMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPhVG+DAXdY1vOd2yH4eUhHtVN5IauB3wgfygbcIi2k=;
 b=Gqlzc+Mbw3Wm7krrxD8/s4H83sJM3GDt92oRNybAKdWXhswEcXRXGMRE+4tK5k6iLTV+/uByBYFwWv83QXS+ptNi3dNXEkKYwQFVsnRmgfeViXrwyo/1f2ngvXYkOs26P6QuJsJwBkGUcFHiCWSF8HqHTsUxP+rqdxMueGuO+edveJolYjgckeNiAttYA6MJxilbz3zZh0KOspqYcxZq/BpWmWUy76b0skHdYJ+PFfKlr6l50MliqbVBqkTuVsV4PG93zNzm1s7QSP/PB4bYJ8Hxf8BgW9FafIoSfGPTjy0Exshu1V5CJYI5OGTSWaKof9qZUolCmRW8ywjZAlDrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPhVG+DAXdY1vOd2yH4eUhHtVN5IauB3wgfygbcIi2k=;
 b=PxiWCMDBzQ/2g2jKwmN765dNnmwlEHiBVYkYzZjRd7z8GucnAikeSSgug/48iBkN5usM0jkynrOoFI3ta9ZQg762QbBJeAiaqRf7jL3nOyvrGcX5mF2LrVCD2YKCZCI5ZiHNSCJs5goKdlOqgUgWzpqA8c3rc0HmbjSF/6gCbU8=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6680.eurprd08.prod.outlook.com
 (2603:10a6:20b:397::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sat, 29 Mar
 2025 11:31:01 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.043; Sat, 29 Mar 2025
 11:31:01 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Leo Yan <Leo.Yan@arm.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "mingo@kernel.org" <mingo@kernel.org>, "acme@kernel.org"
	<acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "elver@google.com" <elver@google.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, Mike Leach <Mike.Leach@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: Re: [PATCH v5 1/1] events/core: fix failure case for accounting
 child_total_enable_time at task exit
Thread-Topic: [PATCH v5 1/1] events/core: fix failure case for accounting
 child_total_enable_time at task exit
Thread-Index: AQHbnifn4Y+QHPjlaU6FB+nrUzLeXbOG02GAgAMsKAI=
Date: Sat, 29 Mar 2025 11:31:01 +0000
Message-ID:
 <GV1PR08MB10521F51BE098C4711407B5C7FBA32@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250326082003.1630986-1-yeoreum.yun@arm.com>
 <20250327110319.GE604566@e132581.arm.com>
In-Reply-To: <20250327110319.GE604566@e132581.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6680:EE_|DU2PEPF00028CFE:EE_|DB3PR08MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: ace42789-c9c8-4343-0a81-08dd6eb54223
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?iS606OeY3nK0mUCY+uU9tB8f+WNbW/gX3CqqFC98ha9y0228KsfmgTIRIyZG?=
 =?us-ascii?Q?unem2sSdy7u5dNm0N6LoxPlK1PCsE4e8NGoeNbyVZo9nV0t1FPloTihN++t1?=
 =?us-ascii?Q?j9gB9jzZNYbxAc/yokSK9w1OXKheoKwtktHKex9tzNyfKVY3zXjN6IhyWnYO?=
 =?us-ascii?Q?tx3V5a71F7P/PGn5N8R1c0uiYCzSNPaOVRo0LNOtYtR6AMqshoYmq1pNSJW+?=
 =?us-ascii?Q?Tz8EDNDsExSbr3fGmkTSuiaScvbNZJNqd0LXI7Ug7xk39ncO+iAQg7zCJupZ?=
 =?us-ascii?Q?SVz6UPrV6aW4FhksjUXIrTGOO/4XVczWckIGQjwo8r5vWevqTHdAfkXGnV+i?=
 =?us-ascii?Q?8SMDfJeTYfMK5QzE6CIYwrLtuLh+v3CDzQfDzrV4cH6gDdFem8qwgeRalAxd?=
 =?us-ascii?Q?g50oH70ybTQ6eIBqyYhj0i7QfoqyRLFBDjVOtbSLsVzEUYwvd4Ji8AQZ5kA2?=
 =?us-ascii?Q?qHtU6narPQDNkSc0pyPzWSIhf8IxZ5XOds9f2oRoUD31lGrcTLiVTXzI/akF?=
 =?us-ascii?Q?ctiDZW/sDVQ7K57jhM+UDj0VErRnjir9nRfZSZReeKTP+z+LYxajiyybmeWv?=
 =?us-ascii?Q?beuOpQRi6K98tHQ27iWt/sanHBFnBEjPYZjh8kAIZcsbsv5o7oxcZsWAnOQQ?=
 =?us-ascii?Q?HesYY8Qj/TOBAid2p4enMV/prh414tkqJCLDu2dd+i3+7HEU8ElZJM+aKme6?=
 =?us-ascii?Q?B6+ycmynVWdaJLeWywdT/A5qbj5Lwbo3/ccdQxCDkGFEIGBB0cu92t2n7n4L?=
 =?us-ascii?Q?n2uBBIFpwa89FNlxFx+JN71oTIcnXnufLzbcdlOx/sg1MfKd4F72y94vNgzb?=
 =?us-ascii?Q?dwNQGizHUojYuphpGlFO3yMDEgVwBSMxbL8uH5hAvMtsEemyrQ4U+T7GvlFh?=
 =?us-ascii?Q?/re1gbhGt9ukIFt+Gs1NkXVS7mBOwb7py8M7rtX0vQsxz7/GVfLayIOSIlHN?=
 =?us-ascii?Q?rDOEgfCKejOLOxazjCai819XleEs6LiD+IwpiLd/TMByl3SOa+igIT3MgsFt?=
 =?us-ascii?Q?0+W8c0beWpkoJ7hUoaaABlHFyVaHuzsaSrSi11rLIEKwjuJCMP7HjuOv/3iD?=
 =?us-ascii?Q?ZWOfOm8ih6tRhjqX9Fv8HJmHKOEJX4IfprB5Q4/lgYyifisKYly9xGjQa8Ow?=
 =?us-ascii?Q?K3pYYHZQxci2yKItyViBkL5gQzUDI83ph+n/Pr04yyzIz4HMYAF0k94iwoSg?=
 =?us-ascii?Q?HOs8/ckdkxXzzVtckJFJlM34oukV4vsXfxBQL097GkVHhEctEK2+QRdRZx9F?=
 =?us-ascii?Q?jdVNAxVPAQTZ6+mbgCO6/Y/r4Z/57kru3zRzX7+cVYkEEAub9IZ96J0msZ14?=
 =?us-ascii?Q?8e3OLfVcMbCbmFgbspDUblRnzKyevy1fyEnQh9XgYqcso+CGsL3QAop/1l9J?=
 =?us-ascii?Q?2DcwJ+cxTrg7IygEk0u9tq66scvmR4iTLRUpbZHvN+ZQrpUqn1sPn6otivMb?=
 =?us-ascii?Q?mUo3I8FjF7o=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6680
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6273c439-f5e0-4e41-2319-08dd6eb52f00
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|14060799003|36860700013|1800799024|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M4R9vthUzWKxxLl1K9ezGEFdxtfZytDeD58RnoFgOuoPXiWRaKbCU2PDPXP7?=
 =?us-ascii?Q?PQ5+itvrT6+kHHJneaHJuPuQDOPGoPw7Yu+iF8IxHGWFfRKyM4Rdc8ly72kn?=
 =?us-ascii?Q?V7RQ54wbI+KWnwhBNN0Kvhx56MNv75QMeZg4ctAndg8MYmwdYka7Y2zeZQoT?=
 =?us-ascii?Q?XlV6/6V4XRXG7pMQq3N0a+K3dTeuXseZYnx2x6VlUNXggpa7lfYqjwWdLwYh?=
 =?us-ascii?Q?l88P92Hp7BAQafE5dZluEzjQV+pNl/4+s+pIbwKDVhPqAqUZpZftvG87ifr6?=
 =?us-ascii?Q?4cn0wd/B3N41A36mEKIgLQop2xOAXBAUvaLz9RY+D+wxsakHXB61s3/fPTRC?=
 =?us-ascii?Q?2LhqAzI6TGH0zOaaNIaEQfN2oI6GhBlzAY7PGqWMzhURwDvkTHa7+Z0C5lF/?=
 =?us-ascii?Q?YOf2C2eZAXFbL1+GqRyu7ISISCjZuY/KCMzfdu0Um1NbSmJISmQYHkt0DKz+?=
 =?us-ascii?Q?u8ciEj2VaCVLKjnBIY9KkWiVjMg09jwVNxgehQx+Zj/OMhzxousXpjRtHjUc?=
 =?us-ascii?Q?JNECPBRfai6zHojE2B+sxM8V8cJG7gGSE6RhfQBMx8mY5t79cqmhvPOT73MW?=
 =?us-ascii?Q?6jC0vyPlSlcXdPcXhFedoXo98L5q5OP3qpP1OG7Us74Ojnz5InjOldJU34B+?=
 =?us-ascii?Q?A6LHwJcldi2QngO5gIN1A7SnzebOcujHBKlQOHR+FmboTrBp9zbOPp4389j4?=
 =?us-ascii?Q?7KBmJb75rL8dgzjBihOhK/1zA7cKKIIooEdgw7UdVz/psIDBTT+rTH+hxX87?=
 =?us-ascii?Q?J2g/9C1LGopFn1WMfDAGeZFqFwo1qTW7aoGEnQ3RTwO8gLcuk+smh3+RRHht?=
 =?us-ascii?Q?63jN21JPtMEn0EvdTpSYjLhkTFNo+E0ItgJRdFWTDydWB8cgbMKwWwH6Wugs?=
 =?us-ascii?Q?y3SPw/9LjIPwmTHUHWzecYZA+SiPJfjEld8EMFL91J4ZONHWw5HwAVOJnCr5?=
 =?us-ascii?Q?Oq7mAp8kju1TJzyxpitGYYr8M3ELjbiVmzzeDNgAwP/2GtGokH0Hly4rH2Vr?=
 =?us-ascii?Q?Dt+sB8Y2qddPteoMUAPla6XD3SR7mqg794tra0zuenKGpaB3WGlGsaFCzbLc?=
 =?us-ascii?Q?Ip5lRFgP4tUKo0NtoqnNwsXfHEHVlRk9mltGxZRXJVpmz4k78czXm9inq3wV?=
 =?us-ascii?Q?wsJbeeDCJ3mLdVXbKVxY6QtXl3WE8667u9AvMa+2IdIg43SlgAxJUkyueqfd?=
 =?us-ascii?Q?ULiIuLN3FCYXfs6pvJV/tYREppmAhcRYG5dN87Nfqd/2+Dg9cGmA9/43QUR2?=
 =?us-ascii?Q?+3Iqt7/jXAwdoaJilgytTn+c6v6bSQYBji0ah43/z+f0uaJPCTSItOsiea6x?=
 =?us-ascii?Q?+5CaxeFm7J0Ig2+SkIAE/Ze/2KwyO4M+Sz+xjVgPrDiBt4GTfHYkMk69iWHl?=
 =?us-ascii?Q?5klqmX1QpIR+Kh9qtAwOKBtnrzCOECvyyQgBY3jN7C5LeOMOrBoQhdfVbbU+?=
 =?us-ascii?Q?ca/1BZU7hJEqoK3CL/dsmHfz41UxhaEE3eGfaNk+nEPp+J4oA+fSrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(14060799003)(36860700013)(1800799024)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2025 11:31:33.3269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace42789-c9c8-4343-0a81-08dd6eb54223
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8962

Hi @Peter and @Ingo.

Could you apply this simple bug fix unless there's no problem please?

Thanks.

________________________________________
From: Leo Yan <leo.yan@arm.com>
Sent: 27 March 2025 11:03
To: Yeo Reum Yun
Cc: peterz@infradead.org; mingo@redhat.com; mingo@kernel.org; acme@kernel.o=
rg; namhyung@kernel.org; Mark Rutland; alexander.shishkin@linux.intel.com; =
jolsa@kernel.org; irogers@google.com; adrian.hunter@intel.com; kan.liang@li=
nux.intel.com; elver@google.com; james.clark@linaro.org; Suzuki Poulose; Mi=
ke Leach; linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] events/core: fix failure case for accounting ch=
ild_total_enable_time at task exit

On Wed, Mar 26, 2025 at 08:20:03AM +0000, Yeoreum Yun wrote:

[...]

> After this patch, this problem is gone like:
>
> sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/eve=
nt=3D0x08/ -- stress-ng --pthread=3D2 -t 10s
> ...
> armv8_pmuv3_0/event=3D0x08/: 15396770398 32157963940 21898169000
> armv8_pmuv3_1/event=3D0x08/: 22428964974 32157963940 10259794940
>
>  Performance counter stats for 'stress-ng --pthread=3D2 -t 10s':
>
>     15,396,770,398      armv8_pmuv3_0/event=3D0x08/                      =
                         (68.10%)
>     22,428,964,974      armv8_pmuv3_1/event=3D0x08/                      =
                         (31.90%)
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: ef54c1a476aef ("perf: Rework perf_event_exit_event()")

Tested-by: Leo Yan <leo.yan@arm.com>
