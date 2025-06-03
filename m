Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2F611E;
	Tue,  3 Jun 2025 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926009; cv=fail; b=FGOhJ9agYnsaRmMJRwEMLff+vOkdYA8NpHMyb+sm59feydr2URQrohrS7FRMO1ilWQ9WcS5WbarluuTRKX3F/QQj4l4HJFNRoHEgkxe3+ReO06uh+rRuFbeqUuJNrYKSBH5TxVfdNBkLOV1zSOx2l7v3hK41yPFd9J6JSduqcdI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926009; c=relaxed/simple;
	bh=B1FdIhZqPiyqnjYGRRk/8rRtAUvQuhGbzagcXIVzBag=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q0WyYmyatxfk5tTMBRuLHEF8W1aXTnsqzD58wf81stJpg57De+Cvqi9yGoAKYyPeSZftBoo2kWjlDtJrdi9DSjmrko7mRRFkB6poSKtkxK0nEEELiuGm9G3u0BYO2opMVZwNJGSdtGl+jlFiRRfe025aZ9V3Hklcw7nwe540MeI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YnGlarTv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YnGlarTv; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YnGlarTv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YnGlarTv"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iZLvbN2//IR0Thb56tdVDJpAJ0G/5BOJK6sF2z4SEBeSIkeQfraY+1PS7HScoku0VUiUHokewfM5wff/qWqiiNsrT6FcnNK+kMdTxX35lSdWuqP7FHCHqJmIoIOLMVYMIHBhSstblsjaGY2Qv/R2KDmJ0CAd1+A+vy4DZYeg783BONa+g70MsKMTveJEorKi1B7B+A/ay8uQAW5aUbiyGjSA1IedyZFKlHlfz4J7xLDaDZkGoe/Kd21ezCNA50o2+yRoSwq+uhA+eHrEdUFe9LjBba1zUQwepy8HAsakjeZuelPmrjMlBHSTJXrYXA++qB0gUnfExUnezD0qXStwtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj9sl4bvtuH60i52WjutoB1K9IYEY0yPxrvdau3orFY=;
 b=UHTDbTW7l3F3zwvoYVvxEDLTUS3W+HuKBZHUZz9S9WhaN8HLLIBB+yV9CY72ItRO/TkIwwetsv3dytv5d98ejQzrvgYSQX4X+mgJk2K89jlk5KKJ3LWH6zXBoH2aPRE9QBjixeVUyrooaVl8EkG/uFc1EiwkxBuV59UmZIOi4Tp+84DDXkytX5Nf/+7DFwO+RlwkvEt6dXMJjjfdLMAVuTVSBxJjUbI4m9se2H/vR54bcpmjxAl2fq4+Ixdqgd7beMTARZiynl4I30o43HvznLDExr6BtdPKz84M9fIZzkZJGznCIS+mk8Vo5edXLuJc7xBSzKWfOhzWYhXVT2OqHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj9sl4bvtuH60i52WjutoB1K9IYEY0yPxrvdau3orFY=;
 b=YnGlarTvO7sWA3oZP/JaYKLN8+7CKsGSyW2tDrpT0Wo3JtGXv2Y8s+a3bQnMkItpItzzAKBIyjV1mBhoFIfyeoEr1wnTyGCXWFJzGfbCwbphXJFI67x1b0/YyEOkEMWH+QrA4xuxWMgiTZiiGTHOfOqR4g2EgFO0+qzTG1dEGwc=
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by DBBPR08MB6283.eurprd08.prod.outlook.com (2603:10a6:10:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 04:46:42 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::b7) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 04:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 04:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrVOJ8BInPomzhBm4sYPAaQ+4bc0H294qhPZcnEaag+Frgm61Va3BydgjkXMKYmFvpGXPV9lofrUTmpzPrmY7r8dGGJdfU4FnSvS7ivejQ9r/H+TN8LhcKJLfYE2p/B0FcizuT+xfNds+rLFCjP4Vf/zK8xxllWSlsC4+8polPupw5lb6mJVuVyPCjg1MELl4527QzBoBtFceI+WdjUrE7WXVVkGxEmeXjLWlywNvhFUCK2+/O5nWLpdMIO12woGW2xIju0CN5guoU60orFWXgIqXfmAaKBHPHtEL7VD3jnnon0WfQg3chjBjSEUJxb0lxbi90nkw6GcxbZFDqBlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj9sl4bvtuH60i52WjutoB1K9IYEY0yPxrvdau3orFY=;
 b=HMFUfruPsVW+n66M4nIMRtSNkYrTnxXTJlSgLdXPbTN2nvICyFC4li7B+oFmUvjfyD+YJjD7TZp9P4TT3v5AwqGLPwvBUlu+efEeHrwQ2gKT9aDjYNaf84XN+NraJbnAysXmrSsEGnQBxaozPsD4pYIbDelAEcgJf8EZ9UTVkY7KaXjeqV/Z7VeAyaGUSpX2rLTdqly7DaWbVr70zM9g0YKlVprP6nxc7fhj2epbmXMvFrjgQDfLhPaGRYPj7BFFtG74M8cjLQbHNk0Xb07OXjZWmEReeUp9utfbV1gDVDcVzYyp2DS3FEtR7fdZc8TpARNjtqmy3tot201NHmhzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj9sl4bvtuH60i52WjutoB1K9IYEY0yPxrvdau3orFY=;
 b=YnGlarTvO7sWA3oZP/JaYKLN8+7CKsGSyW2tDrpT0Wo3JtGXv2Y8s+a3bQnMkItpItzzAKBIyjV1mBhoFIfyeoEr1wnTyGCXWFJzGfbCwbphXJFI67x1b0/YyEOkEMWH+QrA4xuxWMgiTZiiGTHOfOqR4g2EgFO0+qzTG1dEGwc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB7703.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 04:46:06 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 04:46:06 +0000
Date: Tue, 3 Jun 2025 05:46:03 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD5+C41dsjvu9ZNP@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3842c9a5.20ee.1973385e209.Coremail.00107082@163.com>
X-ClientProxiedBy: LO2P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB7703:EE_|AM4PEPF00027A69:EE_|DBBPR08MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: c2586703-0234-406d-b8df-08dda259a2b2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?fXFmCOXfdcBInduGwVafKHyO56XSEvOHr+i2LGF58hbelvmw7//6Y3+Fp0qo?=
 =?us-ascii?Q?V4RmfZLewWlsI8P8iKV7pCv5bKCmovlsPd16wR830YwPfPRQzU+LjDKW9rTf?=
 =?us-ascii?Q?uXhuNwQPTe9kmO/p4/V6+QB8a9gwwyimU+a0IKaJ13t4dzX4u2fJj+hulrkL?=
 =?us-ascii?Q?KK8sRMoh7VF/zgjyY6SJeCBDF6jH5KSLwpa4+s3QVFJfTC4g1Nxzpq+/ReWr?=
 =?us-ascii?Q?aDMQ1li+k3ncr4kIC2pGZ68DAVdA3NdOGYpmGa4sHMqryQFbiNZj9uFX8C37?=
 =?us-ascii?Q?SYtNmdxVPepRdgMaRf/eeUfSf0Aw4kK7/vk5reM0WrhhC49cv1wH7iivGKcy?=
 =?us-ascii?Q?YQI/g+r4lTbjjS9XUwTN8sTEItBdM+beDLpXGEOla4eQ6AaEOYykmxuqW3Tg?=
 =?us-ascii?Q?QsIKvGTqhz3XZZ7tRMfmYpYWmfkpqBeVLj7u02IVXlAWWYL+9K4pqOlsVfp+?=
 =?us-ascii?Q?KUbq+gDLFoEdotNsOi5z2HJB8HDgWejRddPlRIX2pjxMqsbffFQdUIolEgmu?=
 =?us-ascii?Q?ydAr7+RW3hf18Rv7CdSPS3Wi81UAbX4qZOUqDbY9AqvIk8s3K3Ks8hIWFP98?=
 =?us-ascii?Q?rDcmdxGZUylKo2nFp/5qtL+RJUVAjyRA6zkwQ0HIRWB3fwZ3zNzQvm3tfpkn?=
 =?us-ascii?Q?xy8KvsBjr9LtfLTT9vd9AGyoA5YYPMM7h6givKB3S90pALlO0vJpNlDwAEIf?=
 =?us-ascii?Q?xscnia8eaMPFoAzG7VURqJaU2q5ePt54tOjUOxjxy/WV9wkrfyVPJGC7tYMa?=
 =?us-ascii?Q?z9p9tQEKEWxaqMVwBJ4IE8qGzQdFZvjkqbfuLG3LevP/3uSEIHPM9TMjQO/O?=
 =?us-ascii?Q?PM4sHQ3xse4iknKUGP+xTziahpKhceVmH9wq0iOYVuBccfng0Ud3N8qwsd20?=
 =?us-ascii?Q?c80RpB317n1QhVmUN/hm1bhvZunfAYF/iu6kv3/JYiBlHWpDf7O//G/5mbb6?=
 =?us-ascii?Q?424eU6BiXjVf+OpYrajlIuNncsoQUHqoAyhiHdyHf7TrrnTObVVzn5FG1ZQM?=
 =?us-ascii?Q?UshQ2pcUYdVCkcAD9EqMLQWARUmp7Aj2+Y8cNwYLEQcN44Uha+awy62SjmWR?=
 =?us-ascii?Q?gR1MUUDA/CSsJkahGFImuIF6i/KMmvD4N9UKySc737vcsMEAfzUWpX6Og3s1?=
 =?us-ascii?Q?yqMcqhwZeqAuFckvcFnp7/lupSBzZLtqG4yOhCJuRKtEEAUEAxfsrx3ZO/TR?=
 =?us-ascii?Q?H/AvqCa5JN+2rLqtw1zjMi+T8xmZ4KzvvKpE3z1yzRytA7AE9pBqLLjYVW2Y?=
 =?us-ascii?Q?uWD2G0vxnQ7UOEfePCbnka7MTZ50DPBJs6EQm+gn3bdYP9/rLWWl0/6x0sPW?=
 =?us-ascii?Q?BIT+55uQK5KRAvpi/fBP2LrqqQ57Icr3QhpEbDLKCymtfgSQlFNTDliy/dx/?=
 =?us-ascii?Q?6CjFUcnCGpt5HRb92Dq0tnpNaL9grnaaJgAcZHYMKHkt/0DPMcCxKJxd6VGz?=
 =?us-ascii?Q?RrjNhtbowoLDBTkq9/9lD9KsbTD8PHFMq1LZ9Yyu6rCmMWqP6LG4Gw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7703
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	05000918-b469-4d54-05a4-08dda2598d38
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|35042699022|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBucEe/xPwX7AGqBGW9OTImM4zEsxKTjsl54MR1gd8q57Je8OMohczpe3vbc?=
 =?us-ascii?Q?XXiLWxJ0xM/k7l44aDdhl9V+JZMAVLAZTUm+C6x5HVMAR0BCiz32ckgLZz+f?=
 =?us-ascii?Q?eecxEgmKXcJEPwrAeChTYpRsG/71Mnyu/HYSSKqDbDtL6pUKz4JKw0h14Ute?=
 =?us-ascii?Q?wMJCtNLC4YMCezxSktGHPqlgttuSVpSjH+BGbby9tWElw+WWWZUW/Hj43jZr?=
 =?us-ascii?Q?XA+eXBntRPAUhprCYROnoEgo/8PaO9bOyslvHvoqJLpjnKenk9m12uasd4Os?=
 =?us-ascii?Q?a9ghLHySXPdAjqf+cUnraR1tC3VIjJds8gPwvZC2JNnRKvSwBUCUNDn1fDEk?=
 =?us-ascii?Q?oe3GIKzaSEHa2kLz7u4+lBYrklXXv1vUEPs/C1k4hjj1Y3VeYs9YXnRALLS0?=
 =?us-ascii?Q?NX/g1aVwuNhf3ckkKC0RSfPTXHTh4ilBAPBn1rq8FiGv2WoWBaQgYzJzGarD?=
 =?us-ascii?Q?U73x1cs92e0fQ+D0/tsu6DNbKTBQ0ZqF4P0l9z5b2zIbfGKm/cAP7o8zo3wr?=
 =?us-ascii?Q?wxiBQwBrwVWffN4VvjymfsYxJGDFIzI7XPpokutZtybTUrDoTIZzfjiyWwWL?=
 =?us-ascii?Q?NT1eeXYiFmrvI0wVPpKbBEDTyejxW5UpJtkjV3RELCfbKH1OOpWXneGPscV8?=
 =?us-ascii?Q?GqUmcq8TXooBa1ZUXFKiSan/z6DD5qFRTfrADpx7V7jb++9DUod+WQymD4uX?=
 =?us-ascii?Q?qci//yw6fOwOmxP3vpC5ukLbRg8ISGVcHNGJ1E3X0rqihfNxX6XUtqsiz4ei?=
 =?us-ascii?Q?hkw+yki8+ICIJDMJBKbY+v7bS50JqKD6E3vrWpVW6KEPqXt3mjus3gAtXTOZ?=
 =?us-ascii?Q?uT8miNNt7A5C4lCXhz+wyVCPhFSWTt87cCADfEe7NzTmD3G+In2Zha3oOAP8?=
 =?us-ascii?Q?UKeObt/hX0VXr/YyA95Skqhp/imTKcb8U93/u5LWRER4QK1SydW+cd3cdNhz?=
 =?us-ascii?Q?wyjYe/jnHQujSSqzIC35cLxscXAmcu8mGsfN/qjPFK/6Rddd5DG8H1l6F6gf?=
 =?us-ascii?Q?xVKt/zHS3vbwvatlRxg8OywrB9/Yf3Mx15NKU+4T2/SE0HnIW+zbkIeVduOQ?=
 =?us-ascii?Q?EHVUf1tWsnDzSSHjV/dnjYtAYPaG4hBo8ijMpYzOHmwXQo2VDlrsqTeCXMDf?=
 =?us-ascii?Q?ewRFqAXappr8udEz3krTooX7gNkvOuBGz7yHqlItqN/0KYwpLqt9A3JeBm3s?=
 =?us-ascii?Q?ekxNVHw3zTE52k/XDeJig+dWzdyVUnDiSRlQr1TPtwroUjRjBCE1ER9YqWHd?=
 =?us-ascii?Q?a+xUTwe55jTdDGsiM9UxFBjyC/vnCWmBatQNDfsNDSWdKT5M5YArnJyZeiHp?=
 =?us-ascii?Q?N8my78DyjMdP16DVUYyXPD5JJ3MwcM56+wL9fTNRFTIUw1Go3Rw0nvZN4yci?=
 =?us-ascii?Q?DVPZYGqX1SV7qyVdTIj3EA8MjsVLpSzFBcjVPSMwDFNW7BWORg2KsLaC5z3Y?=
 =?us-ascii?Q?U5ciclOjhSjseTHASMOcAjan7VAxd2ZS1a8yJ+ZYtfeE3/9kfY9CSgFxCFa2?=
 =?us-ascii?Q?gT/eiiGV6oHoGaayLoxQUtPcUjX4bOIT9TPW9xN7jUd6FupCr2Uj7ZSNSA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(35042699022)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 04:46:42.0924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2586703-0234-406d-b8df-08dda259a2b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6283

Hi Davia,

> I think this patch is no better than my patch in the original report
> https://lore.kernel.org/all/20250601173603.3920-1-00107082@163.com/
>
> This patch is more aggressive,  it add more changes to original logic, same practice
> as in the offending commit.  would raise more concerns about hidden side-effect.
>
> For example, this code  in list_del_event should raise concern about this patch
> 2099          * We can have double detach due to exit/hot-unplug + close.
>  2100          */
>  2101         if (!(event->attach_state & PERF_ATTACH_CONTEXT))
>  2102                 return;

attach_state doesn't related for event->state change.
if one event already cleared PERF_ATTACH_CONTEXT, that event is called
via list_del_event()

Also, your patch couldn't solve a problem describe in
commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
for INCATIVE event's total_enable_time.

Thanks.

--
Sincerely,
Yeoreum Yun
