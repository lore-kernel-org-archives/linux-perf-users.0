Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790321DB94E;
	Fri, 13 Sep 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235830; cv=fail; b=ZWE7uCJ1Ff/pWrgrQyji9GPeplLrIqOYn0+tWNkLe9kAhSfUo5jlrp4ELQ0VMzQcT26dW/S6HVqvoJwMx1lAPduiwzaIiYYYpHUk3jpikVbLS+mD/yMkGHci08qArmJIfZqFQcJ4C8xHdF6cCZxxX5b45kKMQtnkIMJ0n00Dy/E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235830; c=relaxed/simple;
	bh=e+HOShqtDiOlYehlDUWJaEqWM17mPylSlz6NaN8jdMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Va0Q3AWwgRpnjpT2PVDgBqoADhpp0fLzvDjBP/braqmSiRVg+pJ3ruOKf5/9PG14lt3SRETvIxWRFS7v0RFFCGqCi3ta4rVdxLA1CtzzK91xkPQk1pvieUWzp8INk0B628vUL9MzOlMDF+V5e1zrp8RYRl9saHRYqz1b23d6CVc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DHDyLHfm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DHDyLHfm; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DHDyLHfm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DHDyLHfm"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=it47iXy60hDlrDpUN74hlxOVmHUnppsdYVt5+Q/9vZlaEYUMLXOc2DvouLfZRQOLpiWY0PQQUC4K4dg3Z1s7OQDgL84mDUhxoY1eaoTg1j5Q/ArFDZJ95WJz00z1z5MIE2i2inoI+hOd1DRMIVPsGNcYDwZWxeJ+Y2jJXigD4iYw6Ygx0672IRHDFSLixPgIIMOSIkroi4oalZnF+WD0Stz6tuRnnoefD568TTpvnAVSGCT/9ltVBmynD8xH13YQle1J9s1o9xKoYFxZtuP8Ik8T/i7ZreC0O0yi1n1AGxTUv8AwhBBDVcG6W7828lJktY+iswHtn5JHFhQO6ecxxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRDANWvS6bsZIGOlkmdEgjbpBsStU+/ywsZSGQMSBxI=;
 b=gJ83F0IcqUR1RZyW8PJfWC/ABluA1CCz7/czGQ2ZVMJnfoLtuipSSqN0EtzB5Da3tq4zBDeDHL7xbAQw0DVB/nURApu8MJl+V69YPJ9bjS2L2pk3yuqBDbqavlBdK15h7ckW8k1rzuVaELKPQapADN72ySPN34Ms4dZcEU/hHh7Dn3oKDwF3VkvKggHiZnSgnM4iFe2goyUFBIR9yUrN7Vf9tzXgUwMFxfhHMYEU9q0uGXIls3WtZjv1hwwUTfq3nM6YmoqdWTHn8rPBqH/ZXMADbj5EknL520U7Bn9lOwdUssPPlYY7eYqr2arSjt+GxrQSZH6VLlsKSLFaJyvaGg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRDANWvS6bsZIGOlkmdEgjbpBsStU+/ywsZSGQMSBxI=;
 b=DHDyLHfmUHyf85kNOLOAHVOQ7ys0jB6O5XbioO2RkUT/Tf7DlqSmUAdUWL9Mq5VVprU+OC1lBJajsgo85smej9qRTQ4aJ8A0zOqXa1XpSbgtoC+nOHs6S0EHis0bUJ+2intId/FrWAkfUHWMnlPMJwDf0Jcd7ystGw65NXvrso0=
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by FRZPR08MB10926.eurprd08.prod.outlook.com
 (2603:10a6:d10:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:57:02 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::45) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.28 via Frontend
 Transport; Fri, 13 Sep 2024 13:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 13 Sep 2024 13:57:00 +0000
Received: ("Tessian outbound ee7a81b3b7b9:v441"); Fri, 13 Sep 2024 13:57:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8ed6480f738502d2
X-CR-MTA-TID: 64aa7808
Received: from L469d82fbbcbd.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 80BC5E13-3A2B-4905-8CA2-0C5B39B02F38.1;
	Fri, 13 Sep 2024 13:56:49 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L469d82fbbcbd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 13 Sep 2024 13:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7NMaBr51Ph5Si8wv8dTcz0PlI5lYlDMJd1n5Ks24nveCCh7K8mmDK6IZODmoVe9heRRpXb8FaxzW+liip8GvRSNwwJqiqOZE5fkx/pdCb3qOFIT0zqcuLgk2ZjII3K7y0SeI3fXFChL226NBrUgQZEsdtass7SatM6qMBQYlLeYDXxh3KPsWZIUVROiIFIp3zfcF8/3Ei4vSIT6peJwGUBg64MMAYpGMqAeBCDtU8iTRh/bOU5X20uuEGf+dCDcYP6i08taJ8HOum8XO+mlknFiqHzISXJC/x1xTW6NHY36gJZ6MIv0XSlxWrM/7LEg/80uQ0O/nnuJWeMS18we5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRDANWvS6bsZIGOlkmdEgjbpBsStU+/ywsZSGQMSBxI=;
 b=oeFpx+BEtPr+3Zk66tAmCZjtuhxVhU2TJK6naOubH0CTIR8HnxYU/1F/JA4TqQgWd8mt81irQ4iIEofHKtnZmebWljqF5/kx4mtOeQuAQ4p00kamH5zqTN8wiQ8zEK4A9Bp3D+vWqua/Njs5WidQQhKwXsI+mJ5zrT/OkPluVEPnFPdGJd6Lj/izqOy/WBq7TfjJdTR5FppDcPTRhcLRd5Mqus6N2HJkdgwaMxOGsaDryc++9NtrhxxqYqLXDDMwd1JuNcs7obW3GdfyPUFLtCEk6LdG3nHGP5lYh0RCU0JSM1Dfk2p9WoUC1gKN3Xlt9gEMNIrKtoM+83njMPx+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRDANWvS6bsZIGOlkmdEgjbpBsStU+/ywsZSGQMSBxI=;
 b=DHDyLHfmUHyf85kNOLOAHVOQ7ys0jB6O5XbioO2RkUT/Tf7DlqSmUAdUWL9Mq5VVprU+OC1lBJajsgo85smej9qRTQ4aJ8A0zOqXa1XpSbgtoC+nOHs6S0EHis0bUJ+2intId/FrWAkfUHWMnlPMJwDf0Jcd7ystGw65NXvrso0=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB8334.eurprd08.prod.outlook.com
 (2603:10a6:20b:556::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:56:46 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 13:56:46 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "asmadeus@codewreck.org"
	<asmadeus@codewreck.org>
Subject: Re: [PATCH v3 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
Thread-Topic: [PATCH v3 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
Thread-Index: AQHbBcXPrXd5KHXgFU2xJGLIVnOm67JVu/AAgAAB8I8=
Date: Fri, 13 Sep 2024 13:56:46 +0000
Message-ID:
 <GV1PR08MB10521E382B62E14F8EF4BF5BEFB652@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240913101456.633819-1-yeoreum.yun@arm.com>
 <20240913101456.633819-3-yeoreum.yun@arm.com>
 <d6df6edd-688d-403d-8006-491e302fd042@linaro.org>
In-Reply-To: <d6df6edd-688d-403d-8006-491e302fd042@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB8334:EE_|DB5PEPF00014B92:EE_|FRZPR08MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ca7812-868d-4e4e-ef3a-08dcd3fbf094
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?DocTJF5ayB8PCGUafszn7kFXJzicm3cb33STNy/2990Nz569wgP8YHgVCuh7?=
 =?us-ascii?Q?RDPzbAwARSkNraIVVCPV/zFFOx2GnvkmPPRdOfCFI3T1Wu7dmshOkKPFar0M?=
 =?us-ascii?Q?YJ4eubc91EQaqOS02BUtZ5KbcpwUp6tJiNr9MWKiNiTd0XtSkjT+PVQy4s1u?=
 =?us-ascii?Q?nySwpFQWnFwsmsFkEAW1gd+WdhEDKIaz7YurFqbS0ybubV6iSlK/3bhNgIdz?=
 =?us-ascii?Q?J9/IGRs7sCMXvslSny6mXWAxTzYwafnIBKhr0MfxNETaYMos38N0/2aAOdqh?=
 =?us-ascii?Q?ITQ6BKtDWt31iZChi6hw2q6AQ2v80rLDHYNNGq9cmLvB5oDpzB8UpuCa1X+3?=
 =?us-ascii?Q?MXmYzICOm+JKO2eVgkxOmCtC139ypfRb++ikH4niroDDXszcR6HIKiOiqt/P?=
 =?us-ascii?Q?VfP8fdiOSvf4rPrPL550D2MDsHBolb1Ew9kzlRQ8DbjDjIOrCQe3UCN6g1TQ?=
 =?us-ascii?Q?T5VZo1crSDu+vPgLs8WjLghj4ikxZH2moXWZmp4p07QABuhbLXVmDMgKOv5V?=
 =?us-ascii?Q?R/lsYayoqFfNHcpMcsYfuq5Ugxz5R9BbygH0AF7QBcgy7ND4D7tsi/prJ9L/?=
 =?us-ascii?Q?1HwjSKl05WD9G1a1Syuw/keWwlJ0xFxwfsUVfFCffXOrz4wKW21/wjkfYE/G?=
 =?us-ascii?Q?OCCAbQDo/8wsve4902n/yzbsdQOGGg3OwyyScMtszG42BJ5MhW19uda0qgHx?=
 =?us-ascii?Q?iAJ4Cowk/F8+/qfLjZ3CZH2mzmLFqBo3sa5NHcSfE0/+8FYPOrh3Qdcm2wqb?=
 =?us-ascii?Q?PhpWNQ+F0GDiruarCS25i2FEb6lmC7SaWiC+yWEqfPBXhSP2h2OdAdgo2SCO?=
 =?us-ascii?Q?TEpVTB8yWAmfwOdpGEfXCPHFZl+V+aN0N/U4uBAyD7PS0+oQSy7GujNYPzYf?=
 =?us-ascii?Q?dfhoyz3Acp92dN2qWrg7ATVQnWc7xFdqOqwEEXEfOFkPwYxjy7fM6QGw9NCN?=
 =?us-ascii?Q?GfthRwbMTxs484keRnqCMmVZdAvXY0YgU3Lgy9m2rJR2eVU4F5bc2m4g065z?=
 =?us-ascii?Q?hTBNFSBbDVG/ymKXpfGRPXBmC5yph1LWSNlhoovvDMeEeakZKGjTfGm0AcP5?=
 =?us-ascii?Q?9EEZsmXW34+OoKkvEOB3oO1QZnxEjHnsbMYVHn+h3YdE8OMbrBlpGM1HtQTA?=
 =?us-ascii?Q?BeM6SAGdRm4vtBzO/9THhfY5zX9KGFyus4ecre47brXkmGfS7CKdfpZQb6kb?=
 =?us-ascii?Q?GKfKMxlIpsljRvfUv+mFjHeMIJ0HnZJI1YY26UycLfNG0CoVRmTAUzYnlLdk?=
 =?us-ascii?Q?vk12bqaKJDl92aFf5cc4g7ug0Ik13wd3aTSWS6uCgRdoLbmBI30u7l9aG1+m?=
 =?us-ascii?Q?Xbjly6yhW1NBFMRmKQbl+JRteUKTozQvsUd2mZjrjKu8nMTQct22iBXRrKXk?=
 =?us-ascii?Q?phuMkOqsZ+MPGpOg1n0L5Xhka8/ebk6VDFr0JOfWbL+ZNEoDnQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8334
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	02910e7a-418f-4aad-c8bd-08dcd3fbe7e6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?th9CPCACu/AZr/uSAHV1G5GBFAIfWF8GaiL2RozywOw00guKz8Yc7boupLYJ?=
 =?us-ascii?Q?ixaYpOBthRvaslgd6wRS2Y4AhnLtN8v5XcyBMPfyS3+RBUUS85RvgBLtrdWu?=
 =?us-ascii?Q?kysxFf5bWqPL6bGBPD3mjtNUoi95Pl5rjny3BfdM0sZOSqMWzrNJMs9bD2Xq?=
 =?us-ascii?Q?8mq1ywOyuc3F3oGoraOSc8LP8OhPV+3rYqkvRNFNrOpdezUfo6PdsKOBIxsB?=
 =?us-ascii?Q?13g9Ltrw5T2u7yYOPUkrrrJInsJ1zqhQ36PyYCv7cbIaGSuxf3Whz91WYn+V?=
 =?us-ascii?Q?kE89JY2aSRs/HxHfDsFb3D2nAv4To1WG6spKvnsmP0rRm5+zC+a+HpwtP+M6?=
 =?us-ascii?Q?uBG/2xgveIYISBPpMCKchNCRg0SIqPoWfxjSirjzhCU304WjBqTf/poRh0gv?=
 =?us-ascii?Q?wJf7f6QtTuuJbzDpwm48dhfMNuWxIrC0QqBbIB+37cjBr4QgmguUOi0yE18z?=
 =?us-ascii?Q?e2vzlh00jMOc6QdhVdK2Nyb0REBI0JCl8noKM/+pLw+fZfwcRTtUNy6SK8Qv?=
 =?us-ascii?Q?/WKL8d/aQevkwb7aisUQQPesOF7Rx7tNBy5xnfY5N+3oUTS966Y/zfEdRrOt?=
 =?us-ascii?Q?7uVmsmlH6w3vqDJUDT3udR/+GsNyIMscT8hLcsgpZ9o0c/nZmJoO0tpMcnDw?=
 =?us-ascii?Q?RkMosy/UNr6gMZkV36ewyQcDdWvEMUSDRW3yC9PchE77PKoK+t/lGBd/Ti04?=
 =?us-ascii?Q?/ppq9x6g1krY88n2e9AUSZ1cpO8/fHI1LqWHuHOH4WKvwJ07cGOzcNjZFWqf?=
 =?us-ascii?Q?vHOiqtbBI1erEz7zqwV0oZnJ9q6b5XZxogDUFc23sGB75mqfaMOahoQaCwiC?=
 =?us-ascii?Q?v6pc2iLm7cx/yE+orJB2SG1/FXhWInGULf1CtxOPj6LdmnEZ4OecjA2r3Ntf?=
 =?us-ascii?Q?Dcx+G5TJWtJpP1EOsvkMwfSMiLqb14YbZ/1OmccyXTnLrXLBlEEywpH0gFnt?=
 =?us-ascii?Q?IeTm071o86D3z5R8N6DSDxKRxkHZfqrgsDpxGbjKRCljVBFziYi8myzAUEQd?=
 =?us-ascii?Q?1at7t80ZI0xpwudQ392R6TzHon1CIOYsWhIW/xPuWu3xYvXaF87zkX9dohKP?=
 =?us-ascii?Q?OoIg3ryCNsHaHltb0WB2aoRWDqCptSnO3224LtyFCZ/HwJ2LhSC0YFQFhLSU?=
 =?us-ascii?Q?Z7I5Ys6VpxY2XqXFbhNYZKWdImSm0X+UQzBX4gRV48LgglvcpScfcKvfc8Gv?=
 =?us-ascii?Q?1NLtb+/WOoqahvewxnJTV7z9mkAkLgGE+c+zID4JiqlU549SoL5k2rLFgpbA?=
 =?us-ascii?Q?OL7AoaDEt4IFe12b0G3c1m0N54OkWz/SohMKo4RLdPIc3077Lg3jntjAkOym?=
 =?us-ascii?Q?ppLf0TJksfIZAr+ZHZYRV9TdeI2ybvE4wQ9JGN9lJ842HFSQ6IdvIAFCy54l?=
 =?us-ascii?Q?rQMN1it16t0E3M4774+FjMaMMhsYNUZjWNxe6UMHi6wxeGDm2klabny32ghl?=
 =?us-ascii?Q?VoGg25+hr/Jt31Zo1/WVYXsLh4jeYRFy?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:57:00.5843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ca7812-868d-4e4e-ef3a-08dcd3fbf094
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10926

> I meant this to be a function doc above the run_perf_stat() function.
> Usually what a function returns would be documented there, in case there
> end up being multiple callers.

Ah. okay. okay. I'll move to this to funciton.

Thanks.

________________________________________
From: James Clark <james.clark@linaro.org>
Sent: 13 September 2024 14:49
To: Yeo Reum Yun
Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; nd; pet=
erz@infradead.org; mingo@redhat.com; acme@kernel.org; namhyung@kernel.org; =
Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; irogers=
@google.com; asmadeus@codewreck.org
Subject: Re: [PATCH v3 2/2] perf stat: Stop repeating when ref_perf_stat() =
returns -1



On 13/09/2024 11:14, Levi Yun wrote:
> Exit when run_perf_stat() returns an error to avoid continuously
> repeating the same error message. It's not expected that COUNTER_FATAL
> or internal errors are recoverable so there's no point in retrying.
>
> This fixes the following flood of error messages for permission issues,
> for example when perf_event_paranoid=3D=3D3:
>    perf stat -r 1044 -- false
>
>    Error:
>    Access to performance monitoring and observability operations is limit=
ed.
>    ...
>    Error:
>    Access to performance monitoring and observability operations is limit=
ed.
>    ...
>    (repeating for 1044 times).
>
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
>   tools/perf/builtin-stat.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 954eb37ce7b8..d25528ea7e40 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2875,7 +2875,19 @@ int cmd_stat(int argc, const char **argv)
>                       evlist__reset_prev_raw_counts(evsel_list);
>
>               status =3D run_perf_stat(argc, argv, run_idx);
> -             if (forever && status !=3D -1 && !interval) {
> +
> +             /*
> +              * Returns -1 for fatal errors which signifies to not conti=
nue
> +              * when in repeat mode.
> +              *
> +              * Returns < -1 error codes when stat record is used. These
> +              * result in the stat information being displayed, but writ=
ing
> +              * to the file fails and is non fatal.
> +              */

I meant this to be a function doc above the run_perf_stat() function.
Usually what a function returns would be documented there, in case there
end up being multiple callers.

With that change:

Reviewed-by: James Clark <james.clark@linaro.org>

Also I think something happened with the cover letter as well, it's
marked as V2.
