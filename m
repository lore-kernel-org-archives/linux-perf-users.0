Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27466184556;
	Wed, 18 Dec 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522798; cv=fail; b=sb7AsKIzrQfXghJNsFwIPodin5r89LcZ/wf8Obj8w7AEwOfwgJWq/i7+ZoN0YiWailwDgxsKkLzSPnn/VfBBOtZbblex0Cp019wawLpI9Nw5/3zh1Ln4C+KQJ8V+2fJscX+ql/887ehTX569XIhnUwTur2t1E7kyf27+KrIEbzY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522798; c=relaxed/simple;
	bh=vNotbS5zu1tZTClm95fZp8ceSlbk59ReA6d7wTOYVvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxEO7kedeTfl9XSj8GlcUzAy5GpakSncLl5rNgU25K3QPJegIwsxxJ83+SmQ/+DWhrgR8VDDBt2ZgygcDSmf4y2ZlC1n1B6TgYDWkRSG07SOAXV5Rtf7+lXJQNYMdPISQZ9M6VwCGGG6FQqluhlLZJ1UpQkuRy8c3exn9yjduaw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZU5B+CiP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZU5B+CiP; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZU5B+CiP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZU5B+CiP"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TlY/qyV38ZKceaKFqJYKgZGpzTjJOshbLpwznWUUyJbztCy7C1SRo/H7t9bHy9Tbt0UHeFukc8B7fAhPoGA3m3wDQ+nHkMuSrjIq9uSZN1mGejT++bMCSvwySwYi29qYYxnIMy6KE6Cb9jljBnGk7jSorJnZ89q9p0m8m8U5wM/Tdj3RqEFjRWMOoOvyhsAXvwMKo4e1i68w69XjWarMzwz3okArji8v2N9gswL82sUZfIdduoHgwK21ALBZmpolAmRSBwElZZzPf7QQkMrZxSaJIRCdGLuW728Da2GvfX5ps0cHf6l9YxXNZKFuUpM5Lg9a5xHkNCgPUk6vWuRwfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I5rHXQknUkLg0Pax1XpMEEh93Y5I/Qr1SwjMfaK8zI=;
 b=psJ/MErQp19D7yu2Ms4QGO725jN8uwbGvzVsBwOIo+kBwJNeM+dRCsgnTbUCGgopy9VXY5I54YsQlg2nGI8gE7Bzn4vNmpw54lDtsI8JMHnAiytbzdza9kdFxp3ypQCuBBvxpR7GXo5OVZfnA0GRtfgdqYtU328kDPJFdj4t/XJrknhkN/DAckqQ38UD+QnBxVD3QLC9Pa9eLy7UVRjNkx3ODS/3IkV3Fa7nhTo5LZ3ZcPbj9a3QP50BbH9bYN5mx6ZwPuI+7zAX1jqM6NQKXsTkWufp+5Q8JszIhAMrKJx6GK54DDSwa4QGUCdwgdyS5OE4vjSykKJZR7tYP9kJmg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I5rHXQknUkLg0Pax1XpMEEh93Y5I/Qr1SwjMfaK8zI=;
 b=ZU5B+CiPTK3InT6001x0E0z+P8IS4XIUgqOf2A6XbXGsGr5vrGOhbZH7dB0q1vxuggGuaTy75jezLlJ4VaPol+BxYPT8+8sh9wS+4SL2gxMjg2zaRtl8cAGZji9Kfdn9zimGHCQWkMgj9jMRifL5TeDwPrG16moSKCP0gLb6KSc=
Received: from AM6P192CA0038.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::15)
 by VI0PR08MB10390.eurprd08.prod.outlook.com (2603:10a6:800:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 11:53:07 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:209:82:cafe::83) by AM6P192CA0038.outlook.office365.com
 (2603:10a6:209:82::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 11:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 18 Dec 2024 11:53:06 +0000
Received: ("Tessian outbound a83af2b57fa1:v528"); Wed, 18 Dec 2024 11:53:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7e98e71552c6355c
X-TessianGatewayMetadata: J9uP99beyPPEtHcx8nRLUwNRtRUUCR/Du09JqM09PyEb5a2gfos2vkbTejLE/6cjmi0+1sEPbih8J8uiFO4hoRDH/vhSnFzPWjHBsuF8jyar9jOTLrrJi/WhSRJl/Ykq/VBgsd3W/oA4t7ZQZO/uqQ==
X-CR-MTA-TID: 64aa7808
Received: from L64ae4970007f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7539C4B5-438E-4D46-A469-78AC4FCEFC48.1;
	Wed, 18 Dec 2024 11:52:54 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L64ae4970007f.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 18 Dec 2024 11:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFDFM2dqhfIJrl5ozICxtcO9BfEZSEpujjlSIZoVC5dEU7wj+4k2D/EJbCCS+SCsm3k4HQwucoA8S2zJ9OOk5wL7cQqLwlLlDHtedFQ5RU5PQ7m2BClzl7JfJ2gTczJMDYkpYkSdmecWEFJgP7qYf7Vcyu264xaLLAWaKxU25igwbYXr9Bs1/dKiyDwB3gM3H2CNmDtRrh4NCrup5X+zkoBrCxlKPV0DrAqWQQiqK73uNfQBCcqZLIA3UtN9gF2nBl4vS/icr1pCPVEUopeLS3VxaSCC6abxUDI26gm/cNShgX+PU7QolKrfwpUmpxASUpJMXdVH3I9hZiIyjRltiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I5rHXQknUkLg0Pax1XpMEEh93Y5I/Qr1SwjMfaK8zI=;
 b=fpeUnOJrmqx61P1GMwpEGnGmTHTX2d4eLxzDtJQgOlbdi4Wlh934w/8rfqWn/OcYZLsJB1QDsJlR/qZREBTwLumME9LXKl5IiIJonUBB/2QUgRtscEekdbEpqoCTmn0vW7pf//yVjWz2W8mS9oSSIMiRQxBNuddYIhfsONhL+E2ujJTeKz3XuVClQmxPQ1DdtZEvquXBLQd2iUcMQy8qv2fxK1OvBNyA1GwUq9qPqaRGGX0T0E+ZU7HEq/EVQi6PAIuj85VOcn6yex81GLOuWbEJuzMyjv4/RnJvcaekWSHfLERjzTpLU6SYXPa9FLSI+FXeAGHw2/3sOCaaWvYSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I5rHXQknUkLg0Pax1XpMEEh93Y5I/Qr1SwjMfaK8zI=;
 b=ZU5B+CiPTK3InT6001x0E0z+P8IS4XIUgqOf2A6XbXGsGr5vrGOhbZH7dB0q1vxuggGuaTy75jezLlJ4VaPol+BxYPT8+8sh9wS+4SL2gxMjg2zaRtl8cAGZji9Kfdn9zimGHCQWkMgj9jMRifL5TeDwPrG16moSKCP0gLb6KSc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI1PR08MB5390.eurprd08.prod.outlook.com
 (2603:10a6:803:13d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 11:52:52 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 11:52:52 +0000
Date: Wed, 18 Dec 2024 11:52:49 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	acme@kernel.org, amhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH 1/1] events/core: fix error run/enable ratio display
Message-ID: <Z2K3kaKAucu1ln1H@e129823.arm.com>
References: <20241218084656.609764-1-yeoreum.yun@arm.com>
 <20241218104255.GE2484@noisy.programming.kicks-ass.net>
 <Z2KzB_xQb7-DQ_Js@J2N7QTR9R3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2KzB_xQb7-DQ_Js@J2N7QTR9R3>
X-ClientProxiedBy: LO2P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::25) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI1PR08MB5390:EE_|AM3PEPF0000A78E:EE_|VI0PR08MB10390:EE_
X-MS-Office365-Filtering-Correlation-Id: 7507a0de-64fb-4a36-bc00-08dd1f5a8951
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?LAS3uk+IJrdtoC7oHwKQQ7JslGXmXc6QiwuQ35W/yuWGmwVQbmazeVavcBWw?=
 =?us-ascii?Q?Ob9Gz4FC+oQx//toQ2Hb8e12hTEmA/5BdrkAhaWD4lX4WNinBmM2NvBkT1i/?=
 =?us-ascii?Q?IeDdpSSutEJFMMRapE5axyoTYrVPQKUok3urlQCzOSDSaNWI6SI3rh1uWOo2?=
 =?us-ascii?Q?MQaombtjy/z3D5dcLSxyVJZTVth959FSbdiwSyZ6tTUtqTZg8B65avb+YiVv?=
 =?us-ascii?Q?7Lct3uMDFmaN0mhOZCg+1iick6giQQCxziR4hRbv95Eo0D7YSHiAGHj/VnOc?=
 =?us-ascii?Q?vCcpLmrPhn8QKXPyahljClDxPMnB4AAgksp1j5Q331BmYSxmaM4QpideRv/T?=
 =?us-ascii?Q?97/NXkjpQd0TKoqXR5z/j9WMq4ewV1zhiu+cTQkoAbM7kuO1PekVAmJTO/W1?=
 =?us-ascii?Q?PHdLKFLKvWKW6i6/SOMYcLBjExfh08j7Pns7Q4ovWjYugD7bhrazDYl3+RUF?=
 =?us-ascii?Q?9ThMY1cAjSj4/4fyNlgBfcI8cbt/v0ChjUspB9hrHuG1AUNtFddd6gxq9aJb?=
 =?us-ascii?Q?zBvVa3cyNhNPI0/ph96fQnJ8qpjr1OoC/LIiDXEoZ9q3VvET/Et+zyJYVmNN?=
 =?us-ascii?Q?4gzTpQ941j2CE3Zu+6lSKCyjCSfT4t+MxXdppGWwcNwLPNUWhMe/tMSjtuIk?=
 =?us-ascii?Q?yXsBEfYaHdBH8peH0BfrWnxeSbO7kLxs4ZRb5nX/bGHszLmvrquGDbY08aqT?=
 =?us-ascii?Q?PJ4GX0HYkHfqm2n5fu29Aq8Ow6iPayx07sYdTCgc5nd2HvPhGAthtB4qQPT0?=
 =?us-ascii?Q?lnF3q0jGtf58DdKfzndI9nbIlyr4WX50hLoR2WL+MrWAoD5GqkBROXQRHn4U?=
 =?us-ascii?Q?EhKJZ30edR3sIkPRKTc0a6BPwANXIq0NVHNtA3bTvgoEGWFKZMi5w82KlZhU?=
 =?us-ascii?Q?xllEUkmbMOAmD3UGyJXcglV3/SNi/wSqJC+h8G2pcMPwqAk3SaYvrHqvfaKh?=
 =?us-ascii?Q?g10k3j5dRue2mbShbsrBEOCCVP810WLzxcVClAqGSEumdAYMGkfZvw++dkSb?=
 =?us-ascii?Q?VsEa1ypI2gHezhZMA+dFM3MIHbEWx5X1lKVhXzZ95Oy1N2ewACVADms3uOyE?=
 =?us-ascii?Q?JdMOZ14JKaHKlZoYsAqSB3qY6xU0iUDY6vKhGcjcWIR1F18LoUgsRwhTBkr4?=
 =?us-ascii?Q?XL93lfFF/3xuHsB9R2cSUQGN+feiN5uXmvdD0f/41PikahvEpa9gzh+7ZyhR?=
 =?us-ascii?Q?NCggiuGj2b3PlYCwg09JXgC4Qam4w2sQfMhV772deHaYYGx/YJ8+nyjpbDEu?=
 =?us-ascii?Q?DXZtSPA7D8Zo8PJNy/Q0faLXTT/1u2ZEbLa+lgthKIIAilTmbL4c7LHS9+wY?=
 =?us-ascii?Q?T4ZLExq6rkZRCGbRP0aG2PE0BJSPJjDYQr+pwZR7ZV1AtX/ju5fDurQMLDXq?=
 =?us-ascii?Q?MlrkU5BKbgkC/hV8pB8Tl6cNlTrU?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5390
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	12375647-e13a-49a1-7611-08dd1f5a80b6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uG3zlcp+4LK98S5L1WaLGP7cOWHXImxX3V0+ylKGApaPT//ztNcBVyqeakDQ?=
 =?us-ascii?Q?CoU1T46fubXGjvVYIYF3mLolRhaadVvKN7euk1+uWs2Aw6bdPQQArSwZda0q?=
 =?us-ascii?Q?PU/l4nUB+WTpmlRl0mf5bETQQYejN7u0eqhgusk1ofLFLyaufTIaltOTrcBj?=
 =?us-ascii?Q?FqcaIloJWNQZnMv3wZO29ydTcbp6gx55ihHVgLWjqaLEo+dNMvYR5GTmupDs?=
 =?us-ascii?Q?zcnm8vpNn3BDeqlD5fnLpJ0y3dWA17qlw+dbRXk3Pl85B8LtrcY2Ejvd+TKk?=
 =?us-ascii?Q?OtaIPBsEogZLNOyRNyl6MHM7f27w7QnlaRF9lBfjlj1l4qKZRjstBpWUdwqz?=
 =?us-ascii?Q?wJvaPQcfD69uRrG9fugM4LQJ2ZreUw8OnnrX3AQlrnNp0e+aCOFOsH64gzbH?=
 =?us-ascii?Q?vONX/dxLBCnQ2g77rnvCI+S0RCamkxg1UzMNxlM7MHX+WRSHwIqqvrQeRTDU?=
 =?us-ascii?Q?IAlk0XGaTzRmOl3N0HWsFrcFHiJ1IE9fh4Wvm1lv6P21n7h4cTGweJaRxBnG?=
 =?us-ascii?Q?o6oe7gBFDtufxrJCRi9M8HEE99UGQDv5tpQRzmmYTo968x9iT+z7yT9NTYAN?=
 =?us-ascii?Q?otM0vEqv6DNmVGLVrmZYdAoZWYiHeJy8FdfzQXY31yEQ04+LE51vRdSg6FtH?=
 =?us-ascii?Q?fQxzm3fCG3npvv7r0Ov9+ulCxV818SMq7BG52T6MBkO6fpB6rJALXk2uBUQc?=
 =?us-ascii?Q?WJlckYE1BCTUVO/zBj/22iGgJcn/AnaPFFKSNjquVtgcNd3ciNaRO4X2VVUg?=
 =?us-ascii?Q?YlmNlddbQLz9wzTNo2sy6htoWIK4O32uTGfe8SxJ81F16D2oPuNwcjfF5J7B?=
 =?us-ascii?Q?/34g/XO1eAxstHkprlD+Y2cDZMIDePH8i9zjUSAfUVsnF4beVVw16uQX2OHK?=
 =?us-ascii?Q?y47uBIAASdD7aHwKR5UCAZ5XWKJNfYi+54YXLd5i+EJIcv9BJ5sAsi4AnzAo?=
 =?us-ascii?Q?bjf+8+vOcgsWJ+c7VinQDEgrdVhgP/qAXGEDcaN6bdQXV2HTpaL4VhzTD60F?=
 =?us-ascii?Q?AyEccmYkhsIcuMRXRprbdwutMLWswmS+GBufJu1Q5K7B+QOkIXoy9MNt9HzM?=
 =?us-ascii?Q?66Uf2zzomo+ACFljcnumSzuSE89HL1So5m/HZXgQ1iYvRuPBG1xfoftx8/hu?=
 =?us-ascii?Q?hGxxhx8jFmg2iFxJIeYTSTCl7Lifa2163xlsIZrtmGs0IuS0CqGWJpDV2B47?=
 =?us-ascii?Q?5ZuNnq498Is7PCiQMIEyGir0CKS4Ks2Enk83faCvLu7ALFm3DVGUJHpYwwPJ?=
 =?us-ascii?Q?sRGzMHJl3+TZ1VTIizjGD/km9B0J6gLBhnyAO8Ks28IOpljuLrR4yErlazV6?=
 =?us-ascii?Q?2936B2yOEXN4kkzUnb33CTkz8lqyuLBcCGKWt5zyqsKjIUYq/EgPiucg2kdY?=
 =?us-ascii?Q?GyhQzmHKNwmjljI8sa2NOI2g9wSvSbr+6Yz1D0NUZHOIJKLhxrOZthbcvkvk?=
 =?us-ascii?Q?BzQqdMR0RHFs2bIhMniCiZeHVHHN6svx2c4vUqloNZ2xJyFc+3X6S7edGPIa?=
 =?us-ascii?Q?cZH8aBrrvvaNIa8=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 11:53:06.7050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7507a0de-64fb-4a36-bc00-08dd1f5a8951
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10390

Hi Mark.

> Hi Peter, Levi,
>
> On Wed, Dec 18, 2024 at 11:42:55AM +0100, Peter Zijlstra wrote:
> >
> > git log --oneline kernel/events/core.c
> >
> > Compare result with your subject.
> >
> > On Wed, Dec 18, 2024 at 08:46:56AM +0000, Yeoreum Yun wrote:
> > > when runs below command (with core pmu) sometime perf prints error
> > > ratio for each perf.
> > >
> > > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> > > ...
> > > armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
> > > armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
> > > armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> > > armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
> > >
> > >  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> > >
> > >      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
> > >      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
> >
> > At this point I've no idea what the error is. You start by saying there
> > is an error, but then give no clue.
>
> I *think* what this was trying to say is along the lines of:
>
>   The perf core code fails to account for some time that an event is
>   inactive. This can be seen by opening two mutually-exclusive events,
>   whose active ratios should add to at most 100%, e.g.
>
>   | sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
>   |   ...
>   |   armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
>   |   armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
>   |   armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
>   |   armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
>   |
>   |    Performance counter stats for 'stress-ng --pthread=2 -t 2s':
>   |
>   |        1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
>   |        1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
>   |
>   | ... where the active ratios add to 138.46%, which is clearly wrong.
>   |
>   | [ explanation of the reason for this, etc ]
>
> Note: I haven't looked into the code in detail, so the above might be
> wrong.
>
> Levi, how about we have a chat offline about how to make this a bit
> clearer? I'll be in the office later today.

Thanks. I'll be also in the office later today..!

> > > This happens because of missing total_enable_time of inactivate event.
> > > it's enabled time doesn't update at the event_sched_out() because state
> > > isn't PERF_EVENT_STATE_ACTIVE but PERF_EVENT_STATE_INACTIVE.
> >
> > time tracking doesn't happen at sched calls -- you'll find a grand total
> > of 0 perf_event_update_time() calls in them.
> >
> > Also, things like group_sched_out() don't even call into
> > event_sched_out() when !ACTIVE.
> >
> > So why is event_sched_out() the right place to change here?
> >
> > Also, I've still no clue under what condition all this is supposed to
> > have happened :/
> >
> > > For example, Suppose there're two events:
> > >     e0: with pmu0 which supports only cpu0
> > >     e1: with pmu1 which supports only cpu1.
> > > then
> > >
> > >                CPU0                  CPU1                     CPU0
> > >           |  in | out |       | in | out     |       | in      | out (exit)   |
> > > ------------------------------------------------------------------------------
> > > ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
> > > ------------------------------------------------------------------------------
> > > e0->ena   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t2 + t3 |
> > > ------------------------------------------------------------------------------
> > > e0->run   |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t3      |
> > > ------------------------------------------------------------------------------
> > > e1->ena   |  0  | 0   |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2      |
> > > ------------------------------------------------------------------------------
> > > e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
> > > ------------------------------------------------------------------------------
> > >
> > > at the CPU0, state of e1 is PERF_EVENT_STATE_INACTIVE since it doesn't
> > > support on CPU0. So when event_sched_out() it failed to update its
> > > total_enable_time and it makes error print of run/ena ratio.
> >
> > Sorry, I have no idea what you're saying. I can't relate the table to
> > the text in any meaningful way.
> >
