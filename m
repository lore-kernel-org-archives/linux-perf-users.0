Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73422068B;
	Mon,  2 Jun 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870397; cv=fail; b=l4lvBJ1He2icF92W1BnZgyJ7/Q/tc15H+o1qE3G8IW6Fx8L4cnTj1+abghWugGB6N9JTSGbRszrSpzX1n50k5Pl2czgFK0SG4uivxKM+JJoxUGxNbOhyL2uMzqZxRSLKHA5XwZXCWqMuw4OlCpXMcsL/IZsYdk2xrEfIxYxNBKc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870397; c=relaxed/simple;
	bh=8QeubmOel3V/DxfnMlmFuYx9xW2j8ioKFwfF6p6RN90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtP/ekzoMTGl97XpTxL1X2NKJPEZ/SK/1voobFjTGnTYEqzMBsMUnBibleb1I4SzULpk0fL2XnS690jhZDUwsc/JZht0mMJHPwHScQ8FCKOpqxJpY98yGXUfAHWK4RAOMZDZXy1sKjHZLq14bf+T322ZbplMVcestxBNCH0B36g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lI8hDk6E; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lI8hDk6E; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lI8hDk6E";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lI8hDk6E"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aV59xXTIp4WSl9KepeolZWUbwOoDFc5O6vbL99aqI2R3TwDFv2T8A+bHscRD5pkg5U3QzexRPNLNXzEfdLLpNwFNbZPTsTroef9XeDLjfHBa7w3y/+PtwTzZcpfq9lSIUer/0UJk4iEz2pXAe2Mv7MHgI+6sfWeGX9JfPJlJhs3z7HvgUrGlohzmwOUSaF7JdoW0BuIamn18j8lAWYYR04p6Zxj2JIGbOOY1a6zkEvctP3z1G5zEt9EAkiiKxHT8M0yCdBtsPIpwrYCA25khNAxnmTpblQ73MspR967N7AP0BN84LifpkVs4fuGVU3bwVslP18+eYthipb0BOoXMRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EktyI5oQKlaqpX31sR9QJiuWzbNHiV2XArD7wOq0KWI=;
 b=GpZ/Tfd0k++WqqVskWHiOC+p62dNO75Z7IlYx0BwCxy7YQigW8aHBh8mrvqeMlCUh+hhM3nP/o8WUH3Qlx3rG0duhBG3DDdn1eYhgQwyecJqvXMMleUMUMvpZWs9NtOm1KdUoMXeCM4wEESfxTJb1vFG2hC4qVgzwhT42MlDeXBHSKu7auDic5AM9J4pIfr2txYRGOZ0kok0i+zlxa7FHoahoajrW0JXD6TRI2vTwMIejVB3fUkLL032KzszTHqNDUZZr5lafEL7D45CbQwgBuZou/XC5vAlVAfHmsClEpxU7SzGyvANDjYBztjobk+c+2Z5TRAIaQUVlbS68WbhUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=163.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EktyI5oQKlaqpX31sR9QJiuWzbNHiV2XArD7wOq0KWI=;
 b=lI8hDk6EpErpMgdABYfyrYevvmfW/aGFJoxWajIj2J+bvKA/fHs5BRutkSnmyVi0j18DtKFFMpWrOm1oCciaQfja7EXEr5KlI2SWljxs44qXufR6PRcLggZvFOm8y/lBUUPNJj5vCy70nFFTr2nHUobEj9FfHhu9+LzGb1F23gE=
Received: from AM8P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::18)
 by DB9PR08MB7583.eurprd08.prod.outlook.com (2603:10a6:10:307::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:19:48 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a::4) by AM8P191CA0013.outlook.office365.com
 (2603:10a6:20b:21a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Mon,
 2 Jun 2025 13:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 13:19:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVjHPBWwTPIe4tPk1N/Ilk3DlufRNftvSE4kxn344dzw664x3XyLz4XtpncW6hRvijYhbav72Kndm1zXXvDwnujdaETS4nrkiH5kOh4R0OhltCr9E2rBdxYEwK+TZRXjtOKefCPkmDbEMDyLDOR+2TB9MWvBnVPsjUToukr9eZJTA7vg3XhklEyYFDi6hA4RozuEVNCea0XECqeBrokq+J0ByiIUdRx5UScb/t3Lg6evcwLZZbsSfz+lGsKTd6rbdA6X/Cw1uIL6tjimwL+NEsnG+A+KM7RhLmy3HeMgWrCB/IMeX1r+Ven5y/pbGaFT7RTSgTQUjNyCM/4Wdu/U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EktyI5oQKlaqpX31sR9QJiuWzbNHiV2XArD7wOq0KWI=;
 b=ZQuu/ejoVsb9vVFKt/3kOrThotYf4pUpu/FoVl5FCeNthjqjXSusKQVjQLLvoXarq3+MqgIaQD8c72rQMILrO9rG7brTS6v4Vn0spp99aGaVbSZVwWN5GB/iNpWVK5+XjqCAkBsDfXJGKigzBcf8xBQnBJxNw2cXsZwHAz5+bnuy+hwwePtQNbHsywOdBTeGNRRvaS0g6mChDq6E1FSQXbeo+yLd+IviqfNaEoGguQFU2zHc1rq/Sjfg5Ltz4ahzb+6S+sjugPC4wbbMZwnSyeNSY6V+XG9VohdWsWGRI5wOilQUqp9rR77St4Rsm9W4pvSKqZ2GXqi7LJ90RfEJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EktyI5oQKlaqpX31sR9QJiuWzbNHiV2XArD7wOq0KWI=;
 b=lI8hDk6EpErpMgdABYfyrYevvmfW/aGFJoxWajIj2J+bvKA/fHs5BRutkSnmyVi0j18DtKFFMpWrOm1oCciaQfja7EXEr5KlI2SWljxs44qXufR6PRcLggZvFOm8y/lBUUPNJj5vCy70nFFTr2nHUobEj9FfHhu9+LzGb1F23gE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB10892.eurprd08.prod.outlook.com
 (2603:10a6:150:1fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 2 Jun
 2025 13:19:14 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Mon, 2 Jun 2025
 13:19:14 +0000
Date: Mon, 2 Jun 2025 14:19:11 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: 83b4d26.3362.19730a21115.Coremail.00107082@163.com
Cc: 00107082@163.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mingo@kernel.org,
	leo.yan@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG][6.15][perf] Kernel panic not syncing: Fatal exception in
 interrupt
Message-ID: <aD2kz52p5NHpuXk3@e129823.arm.com>
References: <aD2TspKH/7yvfYoO@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD2TspKH/7yvfYoO@e129823.arm.com>
X-ClientProxiedBy: LO4P123CA0393.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB10892:EE_|AMS0EPF000001B3:EE_|DB9PR08MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: f850b5f8-1400-423e-1546-08dda1d82552
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?iIoJg65VmvaUbPLd4dRwZrQXxNBFr/vINsxBquZ7WyDmFbiyUuZWAuitu5C7?=
 =?us-ascii?Q?Z2f8uuIisGD2X2zefkTHL4nxj1TOZHw98GmFOFH0lxk9zYvlu+4J6d0YpMvi?=
 =?us-ascii?Q?Uju+AkDxcltqhhmBIlxKeDQNqrRKpo9guEIg5sgw2PCeoKgfr2v7FXYlveCI?=
 =?us-ascii?Q?d8KQLJiiAgJwF9fvhcd0bv3fcxq3+OMfV2bZ8ZPvGFJWCyADfv+wgzo/im8a?=
 =?us-ascii?Q?LFx22I/rj2alSKX3JlCrz8ie+MJcDC8aE+/FilsabyT1h8c+4Q4v57PuEiRz?=
 =?us-ascii?Q?OOxyfB9/oD6qSNn/sgChwIBZ/t1mgBQc4XWQby85IEXn2exNlmUvEAXXigBF?=
 =?us-ascii?Q?WKoOHeG+It0d20orSZp39kIIK4+z1Rw+4uMXXGfa2egwNHUB/KRwLKj5r33C?=
 =?us-ascii?Q?bKuadY0J7lzpGDtgtQW5DlswhVl18i/uyxZw9qU+QBKC1zrj4buE5KBtAPgw?=
 =?us-ascii?Q?OAuqgKp4BsDikmAnEe0Oe/DBZEBw5/6zfJ+UbLwp8lb5dHWW/HQXeCR8tZl5?=
 =?us-ascii?Q?pBJ8VmY90BA84yfTye7pYAuC5dJXCqWBf5ic/rk6WDjLDZQkNewVi508po2c?=
 =?us-ascii?Q?U0Ge3xNQ3H8gWGjust9iWAV3JvP2yPwpIys+hWklpc9oIV+jFGjR3KCcSXLp?=
 =?us-ascii?Q?ObuGHATM3heWH3pvTERV6msWL06v6KvxpsSVZ6exINLVCzfj4kmVLETySIxk?=
 =?us-ascii?Q?lB+ZuIg5P/ruQA6GUOTGG8ODkyB/RoHYscpwHw5AtZ5WBHBV5fVDo42SeZ0S?=
 =?us-ascii?Q?gwRY08VOp2s6EBzyqD5lv3Fk+2Z8OrGOXSSqinvVwaY2VmvAkTlNG3aMcZ3g?=
 =?us-ascii?Q?jAfdEyBgHOeOQamtZnf5Qy7kcK0gJC++1n1pnDtjnMcv+Ck3ONTtnIFuTSCl?=
 =?us-ascii?Q?92oRa2PVZ93odTZ4/LApCCaPdgZVKYH3HnvczxStnA/PcmibakwHNopZKcPG?=
 =?us-ascii?Q?tG3uYkpYccxaYtv9pskoXg6Slcx9c17GAJ7vMsdQW09BFvJDpofMkq5af2qe?=
 =?us-ascii?Q?Sm0+HY+wma11LupKgiFyYcpYXf+zskfqgQdpT53tGxRN5aJfAs2vfP94P44f?=
 =?us-ascii?Q?RDUb9PyEgHi6oWSZ3KIbJ75Y4fX2a7CC0jEdbLz+JxRaeyuhXFqD1iJko8f2?=
 =?us-ascii?Q?3QP0t4DY0kqQnQau6NOcQiHayfaxj/AgHJxOng7nedKWHLeHunfDEvwyLhYo?=
 =?us-ascii?Q?D/+zO0n5IlgO8/scPeQSt1z6d4/Mgkrb9JixfUbgIAuB+hbqgyr8+us7dTkj?=
 =?us-ascii?Q?hR94nhDUmZeWLy2eOlo8KfP1XiDDwr+VA/nca+zXK9Fp/zZEYsuD/wLRVJlx?=
 =?us-ascii?Q?8pMM+gekw3Um0vYX0Nc8a1Mt50EoF9+yoTYM0yy9/EfrTqpYtk56P0lmse8k?=
 =?us-ascii?Q?Q4G9D9No2oCbxhyvDnDogkYXrVqm1JsCN1wRRiuJVTQ5h5JuDvp1l/Z14cbo?=
 =?us-ascii?Q?mkRQsI7YULI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10892
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b3b94d9-8a17-428f-93be-08dda1d811a1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UkSEqbOn8ltsskstCN2ZH8J+W+s/wqlfUkSAvdaW2+lZW8yrrtRcpXovy8u?=
 =?us-ascii?Q?E3eA4HKSxPTrLrTHMJZdmfE7DZiK2AXNWa+ib6kAQ316vw7iiSqFflucolAC?=
 =?us-ascii?Q?iciViUhyOGpTOgdPFcrKilAT3QWFs5lA1/k8yL6YBBYJypXESQk4Y5y/Sw37?=
 =?us-ascii?Q?FAwf1hsV2j3KuMc2sKAj2VePAka4XvDeQMY3M+mVXpjhvesY5sActJQn/ARa?=
 =?us-ascii?Q?pBid1IkSxTTX6edrXKe/UkSsT+43ZMz3MPjRtvVFhqLyGKQmvXBtPFzsX2Vy?=
 =?us-ascii?Q?5LSZtNT/NTNQH5zJy3I6oT9JTLDhFOIUayNtKsrVeqE35iAqzPTb4CRvyn3Y?=
 =?us-ascii?Q?cFZzlP7VbsJ6P7ma4PFh1z6XnswL25RQ5j4OY5Fc6rxaVM8SDlJM6Ecf6ylb?=
 =?us-ascii?Q?Ynilwb3wb7ICL3RxbOBVZvBTSylrsgGXECdb5kbTMe7kQZZamBIUcjig9QjV?=
 =?us-ascii?Q?6kWV7cgfzvCnkDF9sjxKV+N1KEv+vpHiYebRMRxcJkXXykStZHDIAcTPWN0L?=
 =?us-ascii?Q?pLbHCMAuVsXg3AsjoVYuf7rhUz0N6ygAT4WjMBmVKxpeXysgs8nTgpmFYYhW?=
 =?us-ascii?Q?7ZWqlr8n0TRlrKGr5OYvSGoZoLQj5C2O0sR/Armg+G8FXZ6ob/8wnuIrCopY?=
 =?us-ascii?Q?Z7YrsXHXliLgWj7PoIItjUuviLZ7xyq3Y8NSwiIAvUtEMyqKJF4mI8KXOxUG?=
 =?us-ascii?Q?lqotWXNLfoXGTJ2S6pextGADvgZTb05kyLTwjJcRVBNh8XtpNeC6KVCnTr33?=
 =?us-ascii?Q?V0BYZTO7StL6mUlyvBxGyYvR+zhFoXdJjJEShKL7/7wPjTwBvcCOV//aXa6P?=
 =?us-ascii?Q?UxhM2KlCUe6O1MYvTjJerO/vGp7JLSlPUbjZ4VBC99jWrFySGm0pWhB+9lPM?=
 =?us-ascii?Q?5lyfsAPaw5dWtUREmjVQtrX8Vz1kVKBIrdm/C00Esytaglndtv90ih3GlIo1?=
 =?us-ascii?Q?NckVhah5QB9ajDegSdEhegNBvAbqpMOKtZk8zZYQnLqwQ2zde7ZywfoeDbkN?=
 =?us-ascii?Q?e5g5VL+vtTa68K7O2MqrairS8dCJHxSq8Qp0h9QUQeC80tWl066laqZv5dlp?=
 =?us-ascii?Q?ZQ+60OseXUX8suZ+L4VAzobAXeX1o7t+0fWN3ZkeRsNZKBTOISi0QoOSjSfw?=
 =?us-ascii?Q?UUmMJWALXMuc8MTQa5dKM0wVjWGM6H59xMrI1XLBAzSsUsJ16zMHXt2vEeRS?=
 =?us-ascii?Q?b+VwZaMLmxKgerX0AdWLfSPbMEdeeyvMfPR4m/WPdqF53fajjhpow/7JYO09?=
 =?us-ascii?Q?/0vbtn00WWAT/2cWEKsFbebsi5U0mAnrLlRQ21Lib+P8/NdvnjpSQTEeNtcj?=
 =?us-ascii?Q?BfVhnRXF2Te8hrUEACmWQTkb6WtLS3aIxxo9QWUHhZRJul/N9oN6+bSYkXjo?=
 =?us-ascii?Q?mLsRsofFCtf+3tI4A3WGVqUVGvb4rm92UDBf1w72Ia8nehy0bdhK2GyRqi1u?=
 =?us-ascii?Q?RRMXIzqCubJINp3gwuq84paETcdjjP/mruf+2y56MOqv1E03BJkg9FzSZaLz?=
 =?us-ascii?Q?Spo0H4EWIsxN66Ebuustc4YfdIeQ1X5RzqVh?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:19:46.6775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f850b5f8-1400-423e-1546-08dda1d82552
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7583

Hi David,

> Before I start testing, I feel concerned about following chain:
>
> ./kernel/fork.c:
> bad_fork_cleanup_perf:
>     perf_event_free_task()
>         perf_free_event()
>             list_del_event()
>
> This patch seems changes the behavior in this callchain.
> Would this have other side-effect?

What behavior is changed you're worry about?
both error patch is handled by __perf_remove_from_context(),
There wouldn't be no problem since this patch just move the
time of disabling cgroup before changing event state.

also, the cgroup event is for only cpuctx not added in taskctx.
So, there's no effect for event attached in taskctx.

Thanks.

--
Sincerely,
Yeoreum Yun
