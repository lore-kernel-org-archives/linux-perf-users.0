Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6942C327A;
	Tue,  3 Jun 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942450; cv=fail; b=YxcbNJihl90/02dJTB4FF8cMFbu9m/nNVIRhdAP1uzAaMH4qqgSgMhnPCWGDNDQfAW89fXq0WP0BZrcEgZZbEJUqzAoA1QoQnOP+7g1ZBzVGebtKBc1Ki6KZpifujGE6WNuIc8T1Mpdh4uu6fIFGwwfrUVS9W/Jz8vduusgui4o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942450; c=relaxed/simple;
	bh=9AKOcbIhlKXRwpN8KkOorjP2FGhoeAoVBU5BfZMZOHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eH7aacdjGgx75TKhy/p4hCyjaePUeCQtEIhAcAgjxazVuODZAcgjU+NvfJjhO+aI2LKsAL8mrclxzNjnoUJsmVAFibK4BDiZxTtWefzxl6SBZqOzNymDyuZ6fK49242F4sgdCIlWP/RWEdWCAtC7dBtHSZFdx+ChOdEN9Shoroo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fRO2mrUt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fRO2mrUt; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fRO2mrUt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fRO2mrUt"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IBc/IJcAW140xXzpFUxs11f5eCwJDt/tRx4QxmaLthCvwmS1RNdZUnbIBxjDbCq3L1Fn65WIvT8miy8ARVhbJoLty7siySInCk+4ehS5tfOW25YbS7OpqE9AxPAOYng7uEFp7CC7iET7CPD7NuT+CTOMpueYyddZkJ+EzOTsFf952Hmp5wgS3BRiX6g7K15gzOr81kwUt91xSX3pbMp6nxCAlr10GuUm29MrcAon7QSdE5rYyE6DAz9fQPRsvbRQ1aSvbvIOqms7xFsmyhI1mWYPDI9bhpb0AmAyrjJOZ9vfWpUNfa/e6pXpdAhP1lcdpYbhyfnevVsjw41sj8Vvhg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ghKWsE/SfAsRFxxVZYv3b6ZSDB5cWUyWCdW1LMeL24=;
 b=Ntmn0P6bBP+dgEEKKU8+iBlNPBJnYQU5ioernWIDWsPKciiywsi9tQ639zzG0w9d/37TkRtOURraLXAR+UBQ5RFT8EDNWPP9nwrJuAM8BiNU8gI0jWMiT626BvlpPcmx4XjH7iC3UGCDttHPl7wuLxHS5VJv25jieTO7HWF8jBxzocWWqr/IE1h+DRuHmPRBwwss+biFOKPA8w16WC8Cv+gaQA3zu9cE7gprc0K+22KK924AsisZGXEFdSdq3XZLUNG1Gq8Yd4DQM5V5XkOHSgnwm90zrCPO5CcfePcPzfgmDACtWFFVXrxyZX8Wd2Ed+rQZio4k+LB90BDoaSmvzA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ghKWsE/SfAsRFxxVZYv3b6ZSDB5cWUyWCdW1LMeL24=;
 b=fRO2mrUtwF0411tFXLp51489Gb1cphubiP4/pd3DNxPMxm4RDYCXaMHlJktqCkXjDa8+syA8aGFZ8GGxt93AiI5zcQZt4GCNBpaoPT07zUqbf3i+xMbOZI3fF11ggi0hZCxcCnSFpkOHP6anNfS8arMrWtIAPlMXBDvjYQUlZMc=
Received: from CWLP265CA0543.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::8)
 by GV2PR08MB9349.eurprd08.prod.outlook.com (2603:10a6:150:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 3 Jun
 2025 09:20:43 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:400:18d:cafe::c8) by CWLP265CA0543.outlook.office365.com
 (2603:10a6:400:18d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.31 via Frontend Transport; Tue,
 3 Jun 2025 09:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 09:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQAZiFzb4EozP1fR49BUb51NODSha2FtYwQCbJAn7wJUW3eNI4bYPhwK9lO9Swop4yGDbGzmKcBxpn5WcxKjcvwAABCO4mDwHPp4bWseOYnlJ+h2T54sPoHKqhEayMldj1ZOQ5D8GQiu2hKilqpu93CEdqTkPVR883vajd7QHR9lwmnUYs8Of4XdL+Eu3f0A5Qsjx+n7DKEOMhhZcY5cWtYlOJ6svLPHTL0DB4CP4YGvCD7BovNsSrI87LoKn3PFq9joBFMlvumcuugmVDnM8p0mf9cjOlOsUcUUARqy/bpN1nIPRigaq9k/g+PvRXL7PkPkAL1zEpHSpXU7xw45UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ghKWsE/SfAsRFxxVZYv3b6ZSDB5cWUyWCdW1LMeL24=;
 b=GlkQKdefjdPET0TVjD5ieqcLOukHm2CTMFEc+3owxgF8I1OqPIFY6fhPzCyMUJUGAUzFKvka+nGs4ND2ENe+cfFJlr86wDNqZYsaiCYuETlwzgU9HxXkK9rPW1ns9VWp76iE/+Ugpt+6FhDeVJZFdsUGtdNCUXvrXXvg6rDsFpgGywf2HSijPWjDMew2eFf1dwvyP8u067ORJc9iSJSDdg2Fno4mIGNUxgvFCvYr65ksSXgTGLqW6wLzA9UkpY61EwKlca7Bv9Gk80yYNkD9fBLqPuV7lK7xCpSwDSdC5YkRv+6ukWrBlA2MGrlLNyLKaW3teyUi9EWYq24rMmM0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ghKWsE/SfAsRFxxVZYv3b6ZSDB5cWUyWCdW1LMeL24=;
 b=fRO2mrUtwF0411tFXLp51489Gb1cphubiP4/pd3DNxPMxm4RDYCXaMHlJktqCkXjDa8+syA8aGFZ8GGxt93AiI5zcQZt4GCNBpaoPT07zUqbf3i+xMbOZI3fF11ggi0hZCxcCnSFpkOHP6anNfS8arMrWtIAPlMXBDvjYQUlZMc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB8PR08MB5402.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 09:20:08 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 09:20:08 +0000
Date: Tue, 3 Jun 2025 10:20:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD6+RGnAOyIS+tik@e129823.arm.com>
References: <19514ed5.5692.19734522326.Coremail.00107082@163.com>
 <aD6Xk2rdBjnVy6DA@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD6Xk2rdBjnVy6DA@e129823.arm.com>
X-ClientProxiedBy: LO4P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB8PR08MB5402:EE_|AM2PEPF0001C713:EE_|GV2PR08MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ec1221-f666-4226-96bb-08dda27fe97d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?yHv8KqD3SIxblauYJ3meD+6Y5xJw0OzXeUFenhXZMHAxNFLkmlqjwOnvQcsj?=
 =?us-ascii?Q?JDeeV2+k0AWrVB+iaYwbkQu24HoJa3qmF+JgpdONfIpIA6dv7B0O2qR+Jk4i?=
 =?us-ascii?Q?fVVFE6LWRncJ8WmzmX4Sfrfm9ZKHTtMcnlAgp9cRQvx8fVQEHfz7UIrg8Mzd?=
 =?us-ascii?Q?UzXI3KG496JkMopRDYWRXa3wWEoHQzep+d8ZDCLyc7mnTlNGOwHCl7JNBR1C?=
 =?us-ascii?Q?14aEnybjTrP0H9NbLD8f0iIFuA0bxZSzFzq/171Iquo0g40sCKRLZ39a45Ek?=
 =?us-ascii?Q?FDqtxlVdWAO1Zzxkljw7hDy0rHbsCJPU5a01jwgIaGl9PP3ebgFe7iZr1GWp?=
 =?us-ascii?Q?karAlZzB9H4wid56J8ei1Zu86I1FheztG1NUhCPrmFHj/DMbubkdLjjejXMA?=
 =?us-ascii?Q?pZVVrxkQNQ8l8Qi6+M/D1b/ZtLaD7qZCqjB9cofckMiop5mYZ0ZoO+QCMf7J?=
 =?us-ascii?Q?6D9fA3uF7csb8MfwvuETc/OKX7iJOybdVP+H+FWzmvRsrddtcy4H0mZEoXJG?=
 =?us-ascii?Q?cRoINSFihIZW5ah04BszhJ8+yDUBroJ98yIg5WzE4wc547TyPxS+RsqUw/u1?=
 =?us-ascii?Q?kymVbGGy0LqPKb2Pyk6ATIhuN8LKd/3/O8XQGCI1b6VFwegfa7L/murQyUhI?=
 =?us-ascii?Q?35G+xJ/7YLKp8zNw+wYMI+2tUKqUrKqF6BWO/cYppgqzB/O6dBAwUcPisVE0?=
 =?us-ascii?Q?3GN7EAjUAbYYFXldNgjPiElNyd6Zj/VjbwhxgtuOJAj8FN43Q4UI6ycgDSb2?=
 =?us-ascii?Q?dR1g3a+bzR5ZXkjrj6kk5FR8g+oROkIYKp9SZqi8sYkQNQfSshFJA1CVJd90?=
 =?us-ascii?Q?jyg8zp+48KeRK3DNAmuTXr0NCVotp009aeN8EI4bChGjojPu8LNJ1Ix2z0oT?=
 =?us-ascii?Q?1z6ZONXFvR78I43YG609TEHI9vuJ2bCXjtCdtnyYzKWdZ0+vDIO4R8Bl++0w?=
 =?us-ascii?Q?USAY5sdNIUK9JjbQowj7pxsqrbfCWgIIDrMLpDlbCAV42784vyZrG+VwN3rT?=
 =?us-ascii?Q?OyCJDWIn2+WVLKIgfVh15af5AmpcNdvBiXFfqgsbEXWB35t+/aZGOXC8HcxN?=
 =?us-ascii?Q?OnTz409vq/w9oT925GX5Y+GPrFzz4FiCQDjWzWGZIiRSbudKBTmYPbjAbLgM?=
 =?us-ascii?Q?LID8G0RTuNOgy/rcyn5k1qxTxPvkoBsJWRBjnY3Ses88Lqv2oL9ZOeJkYqDJ?=
 =?us-ascii?Q?h4LQZ5j9yfFZPJozr5I4kdryVVP4RAAxQHKe1WTAkoUHNyrLw3jIJ6l2ox26?=
 =?us-ascii?Q?6hLMQZnfmdAowf7e0os3S5CJ3Mhq7vgdgRQ1PHbNhaHQR8WcwpKWcFINRrfO?=
 =?us-ascii?Q?YbNq8XU4s90oNcDfvcZTxFoC7z61u03IeHpLtzGa3UE4wNKcQQyfJUofCM+U?=
 =?us-ascii?Q?TPFDTZO9hFllCKWxXW3t0jtPGGJ/KR94bnr6MlKAEX0vUDqLyaSflpbDuhO2?=
 =?us-ascii?Q?50wnYoTjO3aSuPgzYVVJ5MO5dNOlMxEK2j4IU/RUBlcLyvSRDlgEVA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5402
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	564c8389-b843-4fa2-d0e4-08dda27fd547
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|82310400026|14060799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ync0RGO4679iBxTeM+MzyUxm/fSzdnGvzFnteBTtpB242yK7jFbQ/FNjpUD?=
 =?us-ascii?Q?zhm6izW84QA1AsbMWHACJraO+4Lu0lvXQK1Ghz4KpBGcIDRl+/QRjoUVRS/k?=
 =?us-ascii?Q?aRVVM19D6fqXkcqbsHLROFUz4oGqWMZpzWpYgHzBfInxyGcN2GEWU1VEmebc?=
 =?us-ascii?Q?DkuVRaO+7G1oH6SVMOF7VuwJ+zk+JuujeK7fRqjqdmLoFTwWslUiHFK5jZTM?=
 =?us-ascii?Q?XWrw+lFBz3TP6sSikmwy95L/Q0k1RjzZUNc4flSqLlXCVU4svspTJJi4Auit?=
 =?us-ascii?Q?EKBKImG74cg8waB+dBuJRVIroX3YqlBKATPP7b5d4cv0drvbejq09wscGqWG?=
 =?us-ascii?Q?DEwP/mkvEj7d4t95iIPf2MBIoq3nREeAfJd54KaHe2oSTLM6Zml6I7tjQkzl?=
 =?us-ascii?Q?c4ej14nJiqKKhYrAlf2lbSHzAnwDRVrdqjzV6jZgZqx6yGXF94vei26rr5v3?=
 =?us-ascii?Q?q8JZMfwskHYZ3NTik/AjX5f87SWCWzeQoo8l7RgxvRMt7SbNy3idUkH5aK8l?=
 =?us-ascii?Q?OoK/UXlufVlc7PGfrlqWTP1sFf1VLiDVSZCSCUanGnWD25oT25kF+aw50cmP?=
 =?us-ascii?Q?x92JNSVM3HnNQ29c/g1wITOL/2pMLURm1ewXYSj5FiMB5mvRaOVEiR2H1rIe?=
 =?us-ascii?Q?6pA4gKIPqL4IvnDViLNSYB2s1I8LHGk0JTxEzxBpL+V7uh39O8xpGe5ltE/e?=
 =?us-ascii?Q?54q1LAobAB7K91GoRNAftlQ4zguuiIZskfSX45GrghEAWg8t/JLphyOAIfFq?=
 =?us-ascii?Q?rDJawIie8iH6q7fHiUcLHALobI8uYyMbKMaOrDsTlk2m7lHtUHzhML/GkfcB?=
 =?us-ascii?Q?6bs6fT6WWZuRbAZTwYNR7dxsRzlEhgH3TT0QwYW2qsMs5XX+W2RhyOSH5lDk?=
 =?us-ascii?Q?Ifk+fBn8fIE+IXo4pONOnfCerjUYk/hDmOGt7zQjclzDPAxyr45QDHH46HK2?=
 =?us-ascii?Q?wwUf865bXpMR2B0U4tUDNhcGUspNzG1H1XSB3UnWQmxAiFStjByNB7a7uUd1?=
 =?us-ascii?Q?vsfYjz2mZx8TQoS6hnbOAFmjtN1MMSqBlrGHU75umtIM+xgHWbXhmXtx5V1i?=
 =?us-ascii?Q?SjzjxKgda0Sjg907oT0UHvFe4SWPHxRFouOMaWGeq8Hk968Ep+mGMg/lRlnM?=
 =?us-ascii?Q?gWfsuXdUIG2v1YoE9N2KVGf9b6IaQ1q6Lv/ENiM8k+CqsEmLYv3QVi8S/etS?=
 =?us-ascii?Q?ztELaPfQlIoik7uqd3MINO2Tl2Qc5IADpBfWQGallyaugSyBdWFyZqrdMagn?=
 =?us-ascii?Q?3akLj3OkyScsCkbWk5oPmTC1OpW8VEqgZLJJ6JLIDjO/s3E+D9kjZSB3uEQH?=
 =?us-ascii?Q?TWTHV/XncHfIty5NLiujZvjfWZO627rUn9I/QZpnRVM2ye4gxjDB9TsBPALr?=
 =?us-ascii?Q?CPJLWx3fUsrTBS1b8t4VfT15AV5S3ULK5+ya3PhWOT4tJ3BKwAKDaohZCq++?=
 =?us-ascii?Q?LHrJ/2ERyAeNnks1JzBO/SYtx2wzmUxPF/9sZM7XB8GQbV+xP4v9Ssk60+66?=
 =?us-ascii?Q?g0GvtiuyAkxUVj8pzvnaXEBJi4wNDGcpfi/+3RdG8IgrOiWPWghChi2Tiw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(82310400026)(14060799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:20:41.7540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ec1221-f666-4226-96bb-08dda27fe97d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9349

Hi David,

> > > > >
> > > > > Also, your patch couldn't solve a problem describe in
> > > > > commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> > > > > for INCATIVE event's total_enable_time.
> > > >
> > > > I do not think so.
> > > > Correct me if I am making silly  mistakes,
> > > > The patch, https://lore.kernel.org/lkml/20250603032651.3988-1-00107082@163.com/
> > > > calls perf_event_set_state() based on DETACH_EXIT flag, which cover the INACTIVE state, right?
> > > > If DETACH_EXIT is not used for this purpose? Then why should it exist at the first place?
> > > > I think I does not revert the purpose of commit a3c3c6667.....But I could be wrong
> > > > Would you show a call path where DETACH_EXIT is not set, but the changes in commit a3c3c6667 is still needed?
> > > >
> > > > Sorry for my bad explaination without detail.
> > > > Think about cpu specific event and closed by task.
> > > > If there is specific child cpu event specified in cpu 0.
> > > > 1. cpu 0 -> active
> > > > 2. scheulded to cpu1 -> inactive
> > > > 3. close the cpu event from parent -> inactive close
> > > >
> > > > Can be failed to count total_enable_time.
> > >
> > > Is this explaining the purpose of commit a3c3c6667 ?
> > > I am not arguing with it. And I also not suggest reverting it. (it is just that reverting it can fix the kernel panic.)
> >
> > In commit a3c3c6667, I explain the specific case but not with above
> > case. But the commit's purpose is "account total_enable_time" properly.
> >
> > > > And also, considering the your patch, for DETACH_EXIT case,
> > > > If it changes the state before list_del_event() that wouldn't disable
> > > > related to the cgroup. So it would make cpuctx->cgrp pointer could be dangled
> > > > as patch describe...
> > > No, I don't think so.
> > > change state before list_del_event(), this is the same behavior before commit a3c3c6667, right?
> > > And no such kernel panic happened  before commit a3c3c6667.
>
> Oh! I was wrong, before commit a3c3c6667, "change state" happened *after* list_del_event()
> >
> > That's why list_del_event() handle the perf_cgroup_disable() before the
> > commit a3c3c6667. However because of *my mistake*, I've forget to
> > perf_cgroup_disable() properly before change the event state.
> > Yes, your patch can make avoid the panic since as soon as exit,
> > the event->cgrp switched.
>
> I cannot agree with the reasoning,
> The panic dose not happened when exit, it happened when reboot/shutdown.
> (I close perf_event_open before reboot)
> >
> > However, as I said, the INACTIVE event could be failed to count
> >total_enable_time.
> >
> > So, set event should be occured before list_del_event().
> >And since it's event->state change on remove.
> >It shouldn't have any side effect the state change isn't cause of your
> > panic. But missed perf_cgroup_disable().
>
> Any procedure to bring out the impact of this missed perf_cgroup_disable()?
> My system seems all normal, where should I check it?

Here is possible senario:
  1. perf event open with cgroup.
  2. perf event open with cpu event (no cgroup).
  3. above task sets the cpuctx->cgrp the same to (1).
  3. close (1) events.
     here, perf_cgroup_event_disable() isn't called,
     cpuctx->cgrp still point the cgroup.
  4. by other task, the cgroup and is destroied.
  5. close (2) events.
     here, it is last event, in __perf_remove_from_context()
     and last event, it calls update_cgrp_time_from_cpuctx(),
     And this refers invalid pointer.

> But to fix it,  isn't following change less aggressive?
>         event_sched_out(event, ctx);
> -       perf_event_set_state(event, min(event->state, state));
>         if (flags & DETACH_GROUP)
>                 perf_group_detach(event);
>         if (flags & DETACH_CHILD)
>                perf_child_detach(event);
>         list_del_event(event, ctx);
> +       perf_event_set_state(event, min(event->state, state));

If perf_child_detach() is called first and perf_event_set_state() call,
since the parent is removed in perf_child_detatced,
It would be failed to account the total_enable_time which caculating
child_event's enable_time too.

Thanks

--
Sincerely,
Yeoreum Yun
