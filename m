Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB0393DE4;
	Tue, 26 Aug 2025 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167437; cv=fail; b=KzKe6+BK4Mudox4ptxT0H7PPAt/rRPwID7czunqLs+vysvHHzpDQhSfR5iJ0fjezMvCnbzbMyg4rQOjRRYGBvQiahi8iTVgkzT0RwCX5aTinmMPu3Ycwc0CX9Mhj331dn8wkEtg+k7YCFoSZCFlMxweQcjpYriGxrqrbHSGptQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167437; c=relaxed/simple;
	bh=1TF/myJ9Us7hdi7EeS76y1hm3BYdrQvPlcNdbEYp6XY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uRkvApJYUXKQYQ2JwTR3qrk4RrSrRD8lLiwPhrMsdc/WARfRTPeyV3hugN04+9To6yoI+mi6aIFgmWcyRK940RMRAbd1Eo/XjHcjgCAveYDji9CpXzgjyteETyTY+f1bROu9wGL+ZOvH73Ret8RkPJ5/CfKImwUpp4oM759nbGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P4vxC4Hq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EP40DTcM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4vxC4Hq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EP40DTcM"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMAne7011746;
	Tue, 26 Aug 2025 00:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=+ZM/a0dwXTN/ZpoH
	/DcgQF1a2wmswET1ImUDmF1oB5E=; b=P4vxC4HqnQFOxQ6oxmzitTUDnftVCw+Y
	JtmOB3sr9+5yyNg3C/SWBeniwun/FVi3yTv7narQCja7dpvbEVRtX6EHeBslr/Qz
	OnD4yTJ7sbFXpU5ClSkKZsc7qSqRQhyMYUUms6Gua7SJHV2ZkwjHdQPoGibo1M9K
	NKF2UFnpinhI/TetGwjR9eowpatB5oYawGb1m26qqoDpSakJM6rIsJ6Aa1zyCBom
	IzthFiMdVblkM5OqRtYg8mVHWARhHw1kq+XMATM7HyMRe96q9U+1NKKEFrv/lgS4
	DthlhDy0txNb1c48NSoD0XWwK5byC5qqmLlj9cUD8GbmybJwmhxKag==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt3e24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 00:16:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMepwG018982;
	Tue, 26 Aug 2025 00:16:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q438wqnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 00:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbE02TbMUEX1PXEwAElPRQNu2MMr3JYMatkRl14jmPRKGmL6fca1JRQj7fLR7dC+juEXYh7ZIHQkPrz39NAYVmlDDjVlrKZU2733YUaJFUVyVJFpnPbvj4t3PIu6PWPtbyzZr87NE+2etRgaAJdCDH2i921hsvV63NNa5Mf8VBL8xwp+ww6YeJYLMOl2GpDLPoF5NtCCRL/sBC8cgZysY/oSQFOTKJob05lysVjgOU5Jw2zHBl2Wnp/+SJW++T8j3Ue1mYiA9cUJRqKFzBWS9Z10du+isBM5a0W2kKScmN2boDySeZqkMrLKNz5AZROye+VwGKjgKaM6/Cwh/VnJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZM/a0dwXTN/ZpoH/DcgQF1a2wmswET1ImUDmF1oB5E=;
 b=eWGNA48gmRYzX1XG1tmaRTnKBvxLIpIES/CbKkISH8p5M4smFZizcqWKRliXTKQbOGVWWQDaRJpKPHS0evUm4yKIvCeTzU2dN4O21L2+FLQms0LfRhemlaULXwRd6gfX54Tgu8imgJb/vDW65VZJm2ph6XOHcu//4m9ENMckH09q4flZkS29XZj6exUeI95C4fdx2/KNt8VSI0J6O4wu7jIq6/rO5Pl4ecRJL0lgxCAvCkSI82Ng5cyatUp2SCrlJay1cRKLMQcrN8oa6gsZ8exeHlutDCs0QtyxOlj8DE+nhx/kgJuXL+vFrWuJAho7iRfDJioPLc4OWYWiwsu8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZM/a0dwXTN/ZpoH/DcgQF1a2wmswET1ImUDmF1oB5E=;
 b=EP40DTcMN0H0XxN/D/yvTgq3TONslMfA47bkSg/xPDmcFyRf3HVc24rjrLIagoYTlov8UrEKpLmQ9oUexbmZn/6698mtySD3i9x/iZZO84hdTLsnbjxG15wcRrnOhBP6Ht06mz8i+lurMN5FHwYP7p/5hbVd7UEPoCAxj31JR3k=
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9) by CY8PR10MB7123.namprd10.prod.outlook.com
 (2603:10b6:930:74::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 00:16:52 +0000
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::fbf2:dc4e:6bae:51f4]) by PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::fbf2:dc4e:6bae:51f4%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 00:16:52 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Blake Jones <blakejones@google.com>, Chun-Tse Shao <ctshao@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] tools: perf: session: avoid segfault on implicit stdin
Date: Mon, 25 Aug 2025 17:16:48 -0700
Message-ID: <20250826001651.299560-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF654CF2C22:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d48d7e-2c4c-4d33-0cf0-08dde435db4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7aGmdqcFqkjuvs/63nhzQFZntMMNqwFJ9JuKYn8yga9f5zmC1644vBCjRmf?=
 =?us-ascii?Q?M+pOXq8k6KVdDa151bAfwsAg38nLBu/GX9M9maMINNS1lYdvarnOd+ZE13Cu?=
 =?us-ascii?Q?PGt5mAtELiuam0OB8WJgRdBCckQHYwiRFJUdju3GYR1A8xL60ztxL7oGRm6k?=
 =?us-ascii?Q?lp77PeVeMKIlgLgYLyc2faUDwx/t6d8yCZDxvbFSuyAypwnJ+ZAehcDmMn86?=
 =?us-ascii?Q?iEB7lf1C9VQGILgiWPslc2MB1CbIBzqTmg15tvwW4yhcaIIbxWz/Mx9dRgFD?=
 =?us-ascii?Q?waJnDzEGOUwmsHxlvj9sREwYyA+kjJJvI6kH/9KsWk48mkLaDdxXIJbxL5LO?=
 =?us-ascii?Q?/s9DFlY4vjxvh8aT8XYttyWwP6LdMOZpHNb8z1pMXF+ap9PKMnJqSQO+SemQ?=
 =?us-ascii?Q?bqQylV7B1rarHs6YqNVdpoj0Ce6jXc86mNhRKiYEdKuQ+YuPV7V5kfSg+/ZV?=
 =?us-ascii?Q?bIUtY/Nb5tLBEX4fKoJhY0fSmzTQQAM2oaA570SviYuyB4W2cNtbNXLx2CfD?=
 =?us-ascii?Q?7gMcCEc4hS32ndRkL6SE/525i5Yasb+L5JpVGjqmvo2RUhgElm3q4I153YJ+?=
 =?us-ascii?Q?8xyIRXVLGtvxEgbFvNwoX+B4DdabSjsvxSp8NeorOp0LSLhC7hl5SCgTLWu9?=
 =?us-ascii?Q?CKSqijXntMnOZGd5hqfRKd33JhZNKySJQMrdUkHVTGgi2Ds8HOCaaxVhPlrl?=
 =?us-ascii?Q?JExOnK9qIRVPwENNX/iiBC8fcGCz8ldcU/Pw+9bxxJfu4kaDRQ96IM/JX/Hz?=
 =?us-ascii?Q?ndMGXlZlJGROYZRps0fpOQJj7WI2bzDXhnKfsUzNg6yBxEUFn3HmoedEdlFf?=
 =?us-ascii?Q?wQHsfZbH0G6we9cN/GdFSmGhc2Hy0itOdzD1YoDo0rDCCteJsiWy+CnJSByr?=
 =?us-ascii?Q?1r1Oj2eqAdMi25x+9OgtPTjpP0rKRcvMRlHGI+vLO5Z0wMR87k6132MNACl7?=
 =?us-ascii?Q?7ndhgbKcQVtK688cBzO2kpM7igo98CUyYgU3bF8jHEmHqrNTyb1JHhn+4NDm?=
 =?us-ascii?Q?V4Nt19yBRr7zqx5eK7N/XZN/gYTdnhr84Z4pkUeBbmztBpvfOsjw7cW90xtm?=
 =?us-ascii?Q?JFos0LnScvY5HTz3PSJaX4KupG7d6e35dxPPiCwV4G0iJvFYUkF1OH7X+ZAq?=
 =?us-ascii?Q?vGNAJF/547+0QqPhaPig20wv9ztXUqJI4DiF3h/f8AiaIgh6ggKngTzzVlGP?=
 =?us-ascii?Q?XP6I2Ww7ZSmXj7vfVQC5Jh7wSyuGb9CI9+FwLCD5HpB5PxXOpcqMKz855Szn?=
 =?us-ascii?Q?l9fzt3OxD6X6hRQILjxJu+hGWfvdVQnGl75LEzTzLrrwwQxvJsl7jTORubIK?=
 =?us-ascii?Q?Jziqke7mJD4f9Kf8OWr+lYrWboKlivMXObF4U+ZbONHSEeAnD0rPoyuEDiGG?=
 =?us-ascii?Q?/QuudYbI731zoaCd30zFq1xrcLJLM1IUZ9Hvch037DsS02aHaNdNux8b0Kw6?=
 =?us-ascii?Q?UWREPqbdpKM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF654CF2C22.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FrI4/ufMBcatyaBuwKuouJlprtJwPV85cF53r5wgFIHZP3wQM2RagdX2Nvws?=
 =?us-ascii?Q?rA/ZxGsFu9WRj2rziOHVmaIEpsGDoXsFJ3XEQBmTYB9s90k+HsNOtRh7Hhgq?=
 =?us-ascii?Q?VWGfeWcHyVLwttKAGGOXDLtVD6BT0pAilALh+sTqXbv8IRl9L9h4bKy3pGOQ?=
 =?us-ascii?Q?4U7h3ftJmAACduqbj0pTU3pT8EzrkeA95WBFhK+2GepwYWgsf4gASsdW3MRT?=
 =?us-ascii?Q?buEewfD4xbElPhfNbW+s6AAZdQIN0ItAlvPPLxruyXodSxqh0TNPEzsXXvXP?=
 =?us-ascii?Q?todz1JesJHGWedll6mw63ZHJUVYLkFw900j687NKsBbxmLFUAaMV59u4b2st?=
 =?us-ascii?Q?zlLcTv8VCvD8PH2nOSDQqECawSvP4eQ/VD4LlGR4Tr3u//RsD/ruNPvvd+yQ?=
 =?us-ascii?Q?P3s8FSgcH8A01RSKIZ1UW+6tkB+0R4JTeDmJgGK36rco3CIc3+pkdFKdjG9j?=
 =?us-ascii?Q?Ojz4O0FaVNdq2XyCxOhfcRaVHAqCF+HSxnDCzE7qerYD/3wduwNm9LqGaIJ2?=
 =?us-ascii?Q?xqG50SyOn51mh0LUb6MjQLlQvHnY/ClL1G4NNtYblxt5dvfAhpjnn0jWtCZs?=
 =?us-ascii?Q?BvjMGVEyXsmxAdRK6PvEXBUpAhtymuQznm9XhLWzEFNjNmMT+Z4zgKC6RdqB?=
 =?us-ascii?Q?rj8RUphTJUpni89AhH5fmDjsFwu8TFZJppM9lC+m+0hirHJNdAOAtYbtdkIx?=
 =?us-ascii?Q?klo7qeaJ83Lv2r/4NV1KzNyYSW43wyy8ymZ1HsOAH9bMK0Pso0ybCPooql2K?=
 =?us-ascii?Q?fzSdZvfRUWSyfQL9+I36igOgktMD4DANrQS/pkdXR4I0oXdQzAPpdl3RWQmz?=
 =?us-ascii?Q?qJCRXR5q4Xd0IAsjOF2Mk2E4kUY/VXtdlskXoIXuy5OeoDtwfHBVh5reKaYM?=
 =?us-ascii?Q?aNlZt7nB81Aj13c+znHwcSG67mitU4/fQPL0U3Fj/x/lBdFj3h3tRAB1zohF?=
 =?us-ascii?Q?kb4rT2oitLvUrCGyxQrmJpksSEWPDlGwOLx630fdJQBhC/D3LsM+uahQ8sxY?=
 =?us-ascii?Q?FEjo6iQB6DFgri6LOPK2BLKI+eQUMeuTuYiRo0IlgNr6ihrNj/AtURkm0tdX?=
 =?us-ascii?Q?3kocW6v+FNTnzVQjxAJ6XJ5EvGpgB0pJVLFJ1qMEtYLM4wJnTEqeIGQDPrMY?=
 =?us-ascii?Q?FaJR9R12Sp+puU96NWQZCj3F4b45kIe3i4KDNyu+AmQyyvW4Rff0eQ6EN++y?=
 =?us-ascii?Q?ibOpGpOuwpPT0reLMLH1CpUlWB9Vvnne7qTA4FZqZjeIl+g9zW8W/NFmTNwI?=
 =?us-ascii?Q?qIuJcQgJhqrQdXmKEPVUqQcJ6sxp1eIPJrgikzXCX7Izj0LCFjW7nYAMOxh0?=
 =?us-ascii?Q?OpFjvsQcdnApYSZ1QeaZAkZCIYQtQ1u2NkC9afNIGplDgs6Kgu6lR7IiEFLa?=
 =?us-ascii?Q?COUD6zwFyvH1jC00uDlLo8AWW5CUkzqwiGHCZwRIvdDpPz3EIRaBqYI8MDIZ?=
 =?us-ascii?Q?RMq7KJqmNbRqT25mi06gdpvg9RA9koiLQK7GYh58/ohAMFR50h3CtS+SBe+W?=
 =?us-ascii?Q?5ehrNaDmowznK01ZqqsZg3NNe1GhupLkVlANNi1mkSGRqzWmiXgsU2nOxUVT?=
 =?us-ascii?Q?0JOvygqWhtm2KGXO7/3wD80veUnsBkHjoPTVTJMcr8l2yJonn4ksrSF4BMKZ?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MsZwxjGWwvZSgqjvSacRDTOYjr1phQUWj0SsDxLM+j1Ef/bcqtIXcJ+vFbm8S1crMF00L7aJoHmCYs5BQPYF4yvZ4tistWVBiIApTUHJjveNsQRqa8hpev1VGX9hUCxGFNY0GkUghfBHpcFMjYymxEZkNHz11lWFFC78ymbBRUaK7MbP1xNztihc/JJUPlp4XaPS4QxtQbPFGisBh9Ui5gUgFxxDtea2uYquHGkvLNbV6362j6uG5tCmk71xCr8LgXfj4x18RUOhrMejCACAdFvFQOqWn/zwAYZnUDpMY5lVMblXwGnSt6t/gypsP5uUm7fz1dWIMeINviOAYkZiELLjvS62cChHk6/mT6amhGPHusKVoviR0PPhiAmYasqGx4pBWkLNqIAxEtV81nVPWtNZG2fm9fUxi0y42CGzWu+hwqycRQDkEer84qrgnWM3hIlFFgA3hy4kbcuUIjOEF5De0Sk+0NJ2f7TKwUWbCS2bbLo1itXjpOaP0yTLB1yzvIcNWfFqpnQqzKjP+dgDIjYVtLBAeFVkKi9KLokBRXRpUxYJtlyq4rzPhBepMs4egTXjtbrv9CbW1DzyYqf1tUbBSBPAQE8saZi1z3wGeL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d48d7e-2c4c-4d33-0cf0-08dde435db4d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF654CF2C22.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 00:16:52.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsCCaYXRbVPv0DoOw9m2HmPxwLfdmfWHAsdFrtirutoSW+fPX6HFUlzw15JDD1UoQBXpNtKhL2hdyOtxngb66L9E9XL65p7Bzi/sWQ3mJYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_11,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508250219
X-Proofpoint-ORIG-GUID: hdmjYyS8266ctLpuHpXmDjyml4jqX_12
X-Proofpoint-GUID: hdmjYyS8266ctLpuHpXmDjyml4jqX_12
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68acfcf8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=eDhrJ7ezxWXgbILTpW8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfXwt7MgSw9n2RI
 pIPkomeJnLtPvLjl+39o/MvW4RPbF4QMartFO6SNnLFf1Z1ZtelVtAXLzrd0vQ1g1ocUUojzFQw
 Y5yMBUPmISIrc1zH0hDXZlBRYXNsRRrFTkSNOx9wkjHBm7s5JVL1PqlQkzMq2cOSAPw7bVOt0Un
 7DkIuqhkFCymnWfBLAoffZAsWzIrtH57ehQx0yp6zTNJTTENX1MxT5d+U3T0W4Vlyu34/MOm2sF
 Z8Z+hlGZFtD0jgdcYLrRmpPFlcRiGF4PYyTXUo200JCr5Q2LbC6o/fLm18o9B9SkcnPwuDSPpLC
 5+ctfqQiZrUcq1fMgdnDZfhh1JiI846S/E7HPKjgztwSpWrbdRFE88nCE0cg1QvdVeYWTefb2/b
 0i5Uq0Qg

A user reported that running a command like:

    perf script flamegraph -ag -F99 -- sleep 10

Resulted in a segmentation fault. The reason is twofold. First, the
"flamegraph-report" script has a shebang line which ends with "--". This
disables option parsing, so that the exec'd "perf script report" command
does not see the option "-i -" which is appended to its command line.
Second, despite the unprocessed "-i -" option, the default behavior of
perf is to use stdin if it is a pipe -- and in this case, it is. Thus, the
report continues running, but segfaults on accessing the filename.

The fix for the second issue is a simple NULL check. Implement this
here.

Fixes: 4553c431e7dd2 ("perf report: Display pregress bar on redirected pipe data")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/session.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 26ae078278cd6..a9624505c0ca3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1854,9 +1854,11 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	/*
 	 * If it's from a file saving pipe data (by redirection), it would have
 	 * a file name other than "-".  Then we can get the total size and show
-	 * the progress.
+	 * the progress. However, be careful because path may be NULL if input
+	 * is coming from stdin.
 	 */
-	if (strcmp(session->data->path, "-") && session->data->file.size) {
+	if (session->data->path && strcmp(session->data->path, "-")
+	    && session->data->file.size) {
 		ui_progress__init_size(&prog, session->data->file.size,
 				       "Processing events...");
 		update_prog = true;
-- 
2.47.3

