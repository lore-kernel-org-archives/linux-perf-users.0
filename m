Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D41C84B1;
	Mon,  2 Jun 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866020; cv=fail; b=g8YbsFfAvJr0DeUSB1TyNDcLB2D0IESag2UCYN+niq1FqBWZ1q6atqsdBw7pNJof+DL73Z9JrhIOFxf2eKqFdxT4k4EPKqSTQEiEWNFQUcfVy4EMG6+PpLO6a+ivDcVG2X8t5ZLkH2wwgUnTCCV67ZN45PWEVAZUIhYpB1xxU8g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866020; c=relaxed/simple;
	bh=3ckay4deScr7G+gd7TGqAhztEful8vIMcieir9MddCc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=s8N3BMcRmV6PQAgIf4Lg+UXFeZk60uSSl1ZJ0m4kZIO1N65ZHjatGe5vClyVirwzBMYSjXJxek7ogTBZFFehwawxuyWsjjFfrra0U0Kzh9dx9OSib7/DDi5q23ngB+R42fqfzsAqjk/64h65bgEgipKY+V9pAB9iqJ/TE8Fiq68=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MolKCeJX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MolKCeJX; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MolKCeJX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MolKCeJX"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hgquoXX4jfdW7J4UIrjVVKx4xoXJN191tst52icaJpJZ5nCLldxxKPx33xnn5a0eIwiYPIgAmBfm65/u+l/fz5aZBYIPe3ArkXKku7G9I1aAVioZGZhj9S6iXXuuW1QX6eHqy4L3nCyJRG/0P58JVrYhncHcYtCSLgUddd18R0KyxyjbwOL6Pg9KX48YxfcynW9lHrfCVhMotePpWnC3hRx5Yq0BG+MMgkXC61Lx5OEFHI/rk3L4WLWaQV+hXWbZSUTnBnDD+sNiinj9LIyb2hCMwGguXbeIfVaJQQRhFlXQYBb28eIOxUD1EXUUShXx0FBBSjCbWAlVoFVgSBKqRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDMR/3wBQt5VowmiG9MGegdhPlz+pBAcagcOdECTMCw=;
 b=hxWo5kCFNkojeeq2xVi7mkKgiKAi4VV1+hgbhN1dtA/vEzXleEt3qV3oYTycEwL09BQUzTEvRaUsIIuHRnRvg8zwqCVMs+yWONALg3ZsNBKzjTMmpz5Afo+icaJ+tLfsmMjxeCSnDTSa+uDAU9HvwOA2MfbPJ4zMxHJFDSXrr3wJErVQeKKuVBGNuBoUv49r4OfUlh0rcYXGuPG/pDyA3gr0+lAg1/9EYEKoBOTRpNufVFUrsZcoI0vR0gqhuOff9b0LKPUw9+PT0c2mxx1BIP3sTWNsMlvndCgmJG0M1x6Zgwn6j9f1MZdjqZNHAWohYRkFZIgQKXZfwejYxcpijw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=163.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDMR/3wBQt5VowmiG9MGegdhPlz+pBAcagcOdECTMCw=;
 b=MolKCeJX0QqSPoFjYBcQmbFVIith5q5EOoKe43uWdHOEPUz1CUcdZklRCOpVL6QwOxCd1EYPv6gyACR7mAu6cVvKUKp6kQuEsdvogb1liu0ADk5njVsvmrLuaNthBCmX0j7tx4npbwoP7LGxw3d+rmnCiMhUpsi0Lx0GFari38w=
Received: from AM8P251CA0006.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::11)
 by GV1PR08MB8743.eurprd08.prod.outlook.com (2603:10a6:150:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 2 Jun
 2025 12:06:49 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:21b:cafe::8b) by AM8P251CA0006.outlook.office365.com
 (2603:10a6:20b:21b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Mon,
 2 Jun 2025 12:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 12:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJn14MN5fgxOOqmUZVQ89p3h9tzop7UiIMOY3mQdPRBDMFi4o/Jhcrahvy3VbssNLiphbe8X1Magym4wYAXSYFrF7b2FwqlbAi4F7fr1cSlsloYG3uKxZCXLOIayepKfPjfYox4W1nPxJDWGRY+W2mOfTl3XOd6mbuXnWNFGKHnBa8bBm4kZlTgwrH5PQ7sfesVerS26TCV4FWSnxZezNwJmFJK2md7llCTGPjG1mKtB0lD+4MHGXOHT132l590o5tDSmWPIV+a32u5BqQ7e3rTWVTT0pxlBId73fk1Cf+ltqUabf/idNoi+N5ns6rNjuuGhN4NI/CRtEB7H29WMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDMR/3wBQt5VowmiG9MGegdhPlz+pBAcagcOdECTMCw=;
 b=dYOy23iYxxjWg8gwvFqmTI8BimswtyVvu2oD57K2+flwoOUgp/TFtB5zkhXSjpEEkElUxMnRd1fOyDKPw8lZOqPEutRV5Zh/wksO4VWajAR7c3oYHeCL4WHhxc0yJpqEOKihO33qqoLckXRKEGkGrzT1Cl1g8zytHwMVoQHlgrep9rOL7zyTvK0a4ibfHZzMwNoBczGmdhU3MkLK6iOl2mJj8jd8XsBFiqynIiZy6YAWfmT7fmrO4nC3cbv2t3fekz8ovz9VR/zrnzbICTd/un1Fqdokg/aOw8jLrvyjm1lteBIPuWiDcuH51Qz9R5wndOKUck2OJNz2RTDoB8kqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDMR/3wBQt5VowmiG9MGegdhPlz+pBAcagcOdECTMCw=;
 b=MolKCeJX0QqSPoFjYBcQmbFVIith5q5EOoKe43uWdHOEPUz1CUcdZklRCOpVL6QwOxCd1EYPv6gyACR7mAu6cVvKUKp6kQuEsdvogb1liu0ADk5njVsvmrLuaNthBCmX0j7tx4npbwoP7LGxw3d+rmnCiMhUpsi0Lx0GFari38w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA4PR08MB7667.eurprd08.prod.outlook.com
 (2603:10a6:102:264::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 2 Jun
 2025 12:06:14 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Mon, 2 Jun 2025
 12:06:13 +0000
Date: Mon, 2 Jun 2025 13:06:10 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: 00107082@163.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mingo@kernel.org, yeoreum.yun@arm.com,
	leo.yan@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG][6.15][perf] Kernel panic not syncing: Fatal exception in
 interrupt
Message-ID: <aD2TspKH/7yvfYoO@e129823.arm.com>
Reply-To: 20250601173603.3920-1-00107082@163.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA4PR08MB7667:EE_|AM3PEPF0000A792:EE_|GV1PR08MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c740bbd-f2d1-4bb0-da56-08dda1cdf318
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Cp9FW83hmG1N5X7aQbV0mT5CPlkx9ZXgrHWMYGUNNFBH6r8+9nA0Dbdzd8r1?=
 =?us-ascii?Q?P4sIqve8n5BPAZ2hcnUNIsGYE2fGWxmnlLRQyv+XoRV6GxnaL9rYxH1eIBAk?=
 =?us-ascii?Q?EN5Md+YtV3m+A7laNm+zqF4VzoGVB1M+an+cS9nZG3h6BqdKi6jhPWUiU1Lj?=
 =?us-ascii?Q?HQwrcFV6ZgZmfdbf/XZpHjVtGbL74DfTIepwGsudIYD8H8eYuYf6Qrh5/J4N?=
 =?us-ascii?Q?hkJYP68dIeDpNAZwzk92dyHwrXKhLGoapMdtvaJEOLhMX5A3cccVOnfMYxF+?=
 =?us-ascii?Q?eu/RshwhUgIpTwGLSwC0tC+bW5q2r8QoXY+vJJpjj7eXtTIzQ7DOqtXa0jY+?=
 =?us-ascii?Q?bxOqmeclAHY4phUiMZBFXauf0tZREKYzixKcvWe+3P1WZrNdKmtBV3A1GINP?=
 =?us-ascii?Q?6HDjeGXr8XAki/nMiqALKfVAkxSUk2/Lc8NFzkMSHhMJB8JM/vArH33GU1lK?=
 =?us-ascii?Q?18kKM5o3la/YVwtbxGWVGFLua7MNLRIPejEenJZz3EL7AX6lOsT/dCgZLDoM?=
 =?us-ascii?Q?kJWlUf58mi5YnSSuGcpEAA6sjX7YmmA3o4lsMg1ig3rgkVA5qVKFbVe13Odd?=
 =?us-ascii?Q?tZS/V/6T0H0XTrjscKiXchffdmpuxGUd1w9SmpyLgp2wC91fxLC0PdSqFueR?=
 =?us-ascii?Q?G52IL0Q7aR2dvGemqTkY6kOTYPXPx6GBStrxpx5Nj5FdatMYZExITVKjwYK5?=
 =?us-ascii?Q?3md03KM6YYrRaxIFhs5mz4vz0R5wZkQiHkEG222C+g2zASqwejpEAjIESMdq?=
 =?us-ascii?Q?dT4KjnGxvH+b6Lwtus9u7SLwq2ryTbAfGGaQdYiC+P8lHt9SI8/8ULMYg53A?=
 =?us-ascii?Q?+EXlC9xdfEMsQVEB6az8yoaH6Eqv+vSA+CxZA+lhv3MuLsqIU8RNyTyxdS6W?=
 =?us-ascii?Q?sqVlK2+TIeBDSrQY2NTcftP+9ORtYqrI/wT9wg2Ul1DlJgk9jKnZtCPm3en0?=
 =?us-ascii?Q?KRXZvypZwCBdTmadWiAc9NC1OpBgYG2b0PJHglltw73NJs9E7u+RC7P3jqmw?=
 =?us-ascii?Q?RmWLwsZ0+6ZhGLjw7TwRzqy7oOAxpNTLdSyfmUVMD7A6JqnlTYZOgFELGg+m?=
 =?us-ascii?Q?tp05mo5fML7v8CbqOwAHtKFr+kFj/1ghtfIkWS93iGKWPzZp+pa4cGaF4jnU?=
 =?us-ascii?Q?DQSrcDQpWsORln20iHCAiDwt9zL6Do0+xS8ZCXPl2gb4p9BdixDGL8z5XEdY?=
 =?us-ascii?Q?2exdr1bkZu4QujbMNUyNnvknQMXVoOQaCcJOzoD0jE+CAnnORo+Eru2QOwTm?=
 =?us-ascii?Q?2TGWGLG9cV1p08jICAdDR9O0APP1A2TtbDoPB+whOQ01sW+n4ekJ8N/e0isz?=
 =?us-ascii?Q?Hf+kI+tIw0U1/L96hZAo6pUOrr9lxDZBesyXy8ssXjlBq8HCdbIi7r6v0JVi?=
 =?us-ascii?Q?fOOiTPFoanoIiyrup3+BabE4g+YFCiRHBSsvq6IJUl4aFe67ebXtqYywqrpp?=
 =?us-ascii?Q?lTkB5ZWDuVU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7667
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7fbb84e4-c920-4278-c859-08dda1cdde5a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OXpY7t25FzmpqHwiqgHcjXQQzMmpbQBeP6/Swzw56kH2016L2vHvp7DoKZfx?=
 =?us-ascii?Q?j1dUkAMrTOkhcOTNjFjCB2jofowL8b6Lfwd1JRLS619wUi8Mz+yWJXjDd+ik?=
 =?us-ascii?Q?At7tVTW4kjg6bhuawxV65GOQ2iHMlFhSfXElmtqn43wl8JnF+O8S/dSTIwuo?=
 =?us-ascii?Q?3OUflMw1F1WEvRRGzx0Y1Z4Cw3vwmT0lZOupof6Wf0Hi7Kdw0mRh2A1DBSKd?=
 =?us-ascii?Q?MlhxmjIv8QthmOMirHqAjW6JfdoKLAbJVJPPKlgsojOhvcWsEhHI7GjKHQpq?=
 =?us-ascii?Q?w5e3webgDSfjz2EQFKmKY9uNAv6d1dONuGQmP6L5q7XwHP+DL6ZNDFJ4hk0F?=
 =?us-ascii?Q?LFA27kYVgSYDNs4wyA1TyIQ2fpwH3Lw0kEvJabPTY8fN0HL0GctusdwKDvEX?=
 =?us-ascii?Q?o24g9Ov1nIv04HBm+0RiVwVO5IKpy6XcFOarHnTXerUYYGOJK8KL23mTh6iP?=
 =?us-ascii?Q?2pWQdBzudT+3K3B+UHwYpajCxEJStKNcmEPqD0y/Sf1aTVbnLVSHjrHJTCh9?=
 =?us-ascii?Q?JAIe7LEcsgnXcB5Yd9ai7h13AayvwQhAIE3evtMnqSSG/GvET7itUOkSaPZp?=
 =?us-ascii?Q?UlRT5PaXDqraYxMH0JyV23iLUINCMFFvobto8IvTYMdvNRfv4cGX5d2XRPis?=
 =?us-ascii?Q?u1A4mJb15Q2UNWF61KSZZT1IEwrSlNu4URWZIQHYgOs9hvWfJWJHWVMQFfWr?=
 =?us-ascii?Q?dURDSjkY2fBNv6NLtfNa5vohj1HzHV68RXiDQCA35AVkI64HkZIQf8LtV/E+?=
 =?us-ascii?Q?fBDhZ1H1qJGrUWcySzN4ABUgtHLuu6vzoyKzyUgAGQ31dD7FgsaxudLpNcCc?=
 =?us-ascii?Q?jG3ZLZoptK6P+9AuKDFTj9hhasB52iS1GkQt/uCJXOodhvlPaNcK3g5kS9hT?=
 =?us-ascii?Q?iJUyOBuj5ezoYNJkMN90ISNnhtHMXAyEv+b/nMCwFObt+F7OiDLqsYRNdl4R?=
 =?us-ascii?Q?g5Ki0RkdNx+cjHbH1KeB8K3cNnp0fHNFYq/Y4aES5NrIHEsTcRxCrwdpAlWs?=
 =?us-ascii?Q?zhJvJVl1xI5szNpen7w3Vfsly0CCEWcJGZhROSzvJrZVZm4j5YSQfyQU2+7o?=
 =?us-ascii?Q?5FuiKvQFD/qRXds6GSs0beQjbTjIJw6/dlFJtgWMRZthfvvEJCnXsSCh2dAN?=
 =?us-ascii?Q?l2GpguhsW2QhxT3SAvZMbBR3KSbW+8U3azWESPUd1jH7JqplT6piLj5FzdEp?=
 =?us-ascii?Q?Q+of4yGpzKTojd46PGcPrv6UElo/Wx6lCxEgWXIQZGgKeddSqwUbnheptcaY?=
 =?us-ascii?Q?ULJ1l+0+o62bd+I/713TQCj6gdcP+APIg7JTe44leDiaABOgoFjg4pAXYEmB?=
 =?us-ascii?Q?c0WpJh4kyWwGolALWv5eze6JpMY0VNBMDHTVhrzfbZ1bwqmvqm0ZjbomcdQW?=
 =?us-ascii?Q?yd0usGBZHQ3H7ToZKzw8T7FoxRX0gz+la+xDGSLhR7ZfF18x2xoMAD1ZYAsO?=
 =?us-ascii?Q?6oaTvSvCuvIE+S99C2SG+gjgKTJPRJ/epGbTO/SAHP+Hzg359kv2IdAsR37I?=
 =?us-ascii?Q?E6INrK0jV0H7yPLDlRYegZdpknszyuWVD54r?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:06:47.4395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c740bbd-f2d1-4bb0-da56-08dda1cdf318
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743

Sorry to make noise all.
I've forgotten to cc mailing list.
If you receive duplicate mail, Sorry again...

====================================================
Hi David,

> Hi,
>
> Caught a kernel panic when rebooting, system stuck until pressing power button.
> I have only a screenshot when it happens, following logs were extracted from a
> captured picture.
>
> 863.881960] sysved_call_function_sing le+0x4c/0xc0
> 863.881301] asm_sysvec_call_function_single+0x16/0x20
> 869.881344] RIP: 0633:0x7f9alcea3367
> 663.681373] Code: 00 66 99 b8 ff ff ff ff c3 66 ....
> 863.881524] RSP: 002b:00007fffa526fcf8 EFLAGS: 00000246
> 869.881567] RAX: 0000562060c962d0 RBX: 0000000000000002 RCX: 00007f9a1cff1c60
> 863.881625] RDX: 00007f9a0c000030 RSI: 00007f9alcff1c60 RDI: 00007f9a1ca91c20
> 863.081682] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007f9a1d6217a0
> 869.881740] R10: 00007f9alca91c10 R11: 0000000000000246 R12: 00007f9a1d70c020
> 869.881798] R13: 00007fffa5270030 R14: 00007fffa526fd00 R15: 0000000000000000
> 863.881860] </TASK>
> 863.881876) Modules linked in: snd_seq_dummy (E) snd_hrtimer (E)...
> ...
> 863.887142] button (E)
> 863.912127] CR2: ffffe4afcc079650
> 863.914593] --- [ end trace 0000000000000000 1--
> 864.042750] RIP: 0010:ctx_sched_out+0x1ce/0x210
> 864.045214] Code: 89 c6 4c 8b b9 de 00 00 00 48 ...
> 864.050343] RSP: 0000:ffffaa4ec0f3fe60 EFLAGS: 00010086
> 864.052929] RAX: 0000000000000002 RBX: ffff8e8eeed2a580 RCX: ffff8e8bded9bf00
> 864.055518] RDX: 000000c92340b051 RSI: 000000c92340b051 RDI: ffff
> 864.058093] RBP: 0000000000000000 R08: 0000000000000002 R09: 00
> 864.060654] R10: 0000000000000000 R11: 0000000000000000 R12: 000
> 864.063183] R13: ffff8e8eeed2a580 R14: 0000000000000007 R15: ffffe4afcc079650
> 864.065729] FS: 00007f9a1ca91940 (0000) GS:ffff8e8f6b1c3000(0000) knIGS:0000000000000000
> 864.068312] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
> 864.070898] CR2: ffffe4afcc079650 CR3: 00000001136d8000 CR4: 0000000000350ef0
> 864.673523] Kernel panic - not syncing: Fatal exception in interrupt
> 864.076410] Kernel Offset: 0xc00000 from 0xffffffff81000000 (relocation range: 0xff
> 864.205401] --- [ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> This happens ever since 6.15-rc1, from time to time, I would get kernel panic when
> reboot; it is only recently that I figured out a precedure reproducing
> this with *high* probability:
>
> 1. create a cgroup.
> 2. perf_event_open(PERF_FLAG_FD_CLOEXEC|PERF_FLAG_PID_CGROUP) for each cpu with following attrs:
> 	attr.type = PERF_TYPE_SOFTWARE;
> 	attr.size = sizeof(attr);
> 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
> 	attr.sample_freq = 9999;
> 	attr.freq = 1;
> 	attr.wakeup_events = 16;
> 	attr.sample_type = PERF_SAMPLE_CALLCHAIN;
> 	attr.sample_max_stack = 32;
> 	attr.exclude_callchain_user = 1;
> 3. close all perf_event_open after several minutes
> 4. reboot
>
> And after an exhausting bisect on events/core.c, (I need 5 rounds to conclude a good bisect)
> I think I reach the conclusion, with very high probability, that this is caused by
>
> commit a3c3c66670cee11eb13aa43905904bf29cb92d32
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> Date:   Wed Mar 26 08:20:03 2025 +0000
>
>    perf/core: Fix child_total_time_enabled accounting bug at task exit
>
> Reverting this can fix it: I run the test 10 rounds, no kernel panic observed.
>
> The changes made to __perf_remove_from_context by commit a3c3c6667("perf/core:
> Fix child_total_time_enabled accounting bug at task exit") has wider effect
> than the callchain mentioned in commit message, and I think an esay fix would
> be just restricting the effect to that callchain only, and restore other changes back.
>
> I have test the patch below several rounds, and so far so good, and I will have
> more tests on it.
>
> Signed-off-by: David Wang <00107082@163.com>

Thanks for your reporting and Sorry for my bad.
By my change, the tracking nr_cgorups is broken which could make a dangling
pointer for cpuctx->cgrp.

Could you test with below change please?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 95e703891b24..d0a9096735b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2116,18 +2116,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
        if (event->group_leader == event)
                del_event_from_groups(event, ctx);

-       /*
-        * If event was in error state, then keep it
-        * that way, otherwise bogus counts will be
-        * returned on read(). The only way to get out
-        * of error state is by explicit re-enabling
-        * of the event
-        */
-       if (event->state > PERF_EVENT_STATE_OFF) {
-               perf_cgroup_event_disable(event, ctx);
-               perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-       }
-
        ctx->generation++;
        event->pmu_ctx->nr_events--;
 }
@@ -2471,6 +2459,16 @@ __perf_remove_from_context(struct perf_event *event,

        ctx_time_update(cpuctx, ctx);

+       /*
+        * If event was in error state, then keep it
+        * that way, otherwise bogus counts will be
+        * returned on read(). The only way to get out
+        * of error state is by explicit re-enabling
+        * of the event
+        */
+       if (event->state > PERF_EVENT_STATE_OFF)
+               perf_cgroup_event_disable(event, ctx);
+
        /*
         * Ensure event_sched_out() switches to OFF, at the very least
         * this avoids raising perf_pending_task() at this time.

Thanks


--
Sincerely,
Yeoreum Yun
