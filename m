Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABE1990CD;
	Thu, 28 Nov 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793871; cv=fail; b=r0/jrYoS8errPd4SpKmVxUDKMPPAi3aiOiKnHY5dQlTYRowR9OtBve+zG1X0RC9dXAisgyPZgwC1QFFJokaalQlH5r0/qRODQ5OpH4X+MNJnuEApTYGhkmasOdO+oIgUwo4QUf5hwXtHPMlyn0XVeTODJNqAsVWZkii5cPEwgvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793871; c=relaxed/simple;
	bh=bx10O0gCGVRIi/sR30pf1mTY2tFfUFI5RBBPGCY72pc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pswYoH3eyo1+Z1y9i2VHsQiUySUXmBqOIHzJ7lwslzxtJXPnAXX9NzPQd5BMYYjUAU7Tjmhv34Vf8flBhszaayoKf5XsSZEOxZjh1IDU0NoOJmKZWIxGQdKNAExiMjG6V4YUxHriHVxFe8mqbWMVjMmUdUn12sDXbPxWbgksa90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AA7wcMkH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kxOYqtjo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AA7wcMkH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kxOYqtjo"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS3thB1027535;
	Thu, 28 Nov 2024 11:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Bz4o8lxrezFtawmh
	1FzMWrNtgUynmFS1bW/ByXlc1LE=; b=AA7wcMkHTDvgeHp0Yu9K+7yWxaC8AcrW
	YVOV7841T/d6x3xH+ZT4n+hILFlqWkrhi5NO97zoB1os7zyO/bcacT4FboOS01dY
	FcaQsa5Q9vQ1esijoA1OVs+OQjnhk0JSv1Kh4NUYMgwlXd6yjM2PsJ+Wbw257Z5g
	xOFHqx4mzOyQERJWQRRLFZEksErOohVbkZEpUGuw9jswr2qjZEIsUyHWbOToGjpt
	0rveqHpfm5z54WhhtU6smgOVX6ytOb9BCjyRSU7pqfw/1YXX0ewBCG6lMMC2jxkd
	er32gQ9EoMtGMiABrJDa3J3iou0i2Zq1OlAXaxMvCLIaoi/lLebreQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xw9qqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 11:37:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS9jU8i014263;
	Thu, 28 Nov 2024 11:37:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4366yygxnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 11:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVk5jYmxVZYPmLmB3yGvY5ySgp3mn1+NdrLWviVo+b4hdyYUcJ2GtGkkA4Jjs2efT5YWDE8AuQSU0zKlYGE7G1h1SanWykRNyziyT+uwV/hahszcC+tLMITnA70O0xs8r+SFJeaf1TBV6CXMJ434Ew+DKDBwSO3iL4ldzxVCNSXpWUPvhYk2AV3Wybo3P18yFHXLJposcImzbTul6HS/cJal29mmxRvBPH02SK3CuC6ichaHG0sIafp1RglCtr0b7Y2YXyqYIy5BOPhHpWmhyNPvVctcC5LzLJYOnkTpa15UN0q41up8GQAJL8F7x/j3TQIUPoN5T8A0oShyJiw85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz4o8lxrezFtawmh1FzMWrNtgUynmFS1bW/ByXlc1LE=;
 b=s9HfdHOJ58aZwopZOgbDURG4rv4lJlTu5gkxBx3rVIGqqsYKwAY+RS0dXQWqoLNAQo44RqD91/BKScWGD+VhEeB1UnLVoMGkykU8gxYe9ThkWJdKqUGym1x3cWkvS1cIwC/G6kGaQCAHEFUc/fWals2fNZ/qo3ihwZz6oxgESO9Bg8ZZ/gKGMRsBfmhPP6RsYr1S8ziRH+L5LNWnXiPJFhMsYYUQ8wdK/1q5ADL0x/jK9Z/tgx4FrsgUs0m/ZZX/tr4/MAGIml2ruiyayxEJnr93/Yy6QIOM1Uom1KyeDjAOHbJCxfk0dhjKC+PpQc6JfdEuFRd/w+3wMkL6q7Bpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz4o8lxrezFtawmh1FzMWrNtgUynmFS1bW/ByXlc1LE=;
 b=kxOYqtjod+XBGd2Wnk+H5jJAuelKJhz9RCZL1VJSIJF/LF45KG5vtKd/9S6EUkAOb1nVcEEsR8HjyhSPbRiTU9XY74uZr/gtZvN+N/JacTO0hJqkok7cVPoAH3C70VLGoU1hS8npfhUCWJi6pkRM+E2J3iGOLTRx435x++mrjZA=
Received: from MN2PR10MB3374.namprd10.prod.outlook.com (2603:10b6:208:12b::29)
 by DS0PR10MB8104.namprd10.prod.outlook.com (2603:10b6:8:1f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 11:37:22 +0000
Received: from MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348]) by MN2PR10MB3374.namprd10.prod.outlook.com
 ([fe80::eab5:3c8c:1b35:4348%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:37:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] perf: map pages in advance
Date: Thu, 28 Nov 2024 11:37:14 +0000
Message-ID: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3374:EE_|DS0PR10MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 878543cd-2fc3-463e-f4b8-08dd0fa1059d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e1go6UCuCmg8WTUaj6pBgGlRJJaIt+yxhQDRxWQ92vGhgK2m58tzmcXack/P?=
 =?us-ascii?Q?y1nD4Nr9vDHV/uNmCr2HslJetmv9LRDajrDgDrr9FyVAHJhoQeEAXdBJPSAD?=
 =?us-ascii?Q?sPciMpO84SR1n4QvGS6fEOa648P77X8TkYdlQxRfWAIOnRkKmAOx/YXjqyKi?=
 =?us-ascii?Q?iYR8BqtdHYmAeuDoXDqqOYWNH1RFVG2lZm77/FiLz5ZkcJ3xF6/VGRUSh2cg?=
 =?us-ascii?Q?zpkufvd1cZeq6cJ0dOj1mhrRl9K+93PVQLss8BxnDoYwPZsrdGB8zb1jJRQI?=
 =?us-ascii?Q?2dWAMy/mJ6F6IAz4fJ6k4JPEEYW7iTA3JBI8scHmPWYxuzim85GSZvZECdww?=
 =?us-ascii?Q?SS7FOmQ16XCmg3aX17uy5HAv6nTVWEZojDx0cXL2hOZEWe3JCkYvDGJouNa3?=
 =?us-ascii?Q?wZPIrSMC2oUJ66y93vjdDapW2DpSRzZHR982jiyVmEK1NzMc6o1GA/krNxeV?=
 =?us-ascii?Q?n2XTwYXi9vUycEkhqYnwV8awCfJ4gLkfD3wXTk4z8mskoQyCE67Nl9aP7cPI?=
 =?us-ascii?Q?RixVEW57pOMYFRLlf4ee++JwkvrvlEP3rYXCdzSmJtU0VIoUgV1vsBWpVMQ1?=
 =?us-ascii?Q?xXTUaihl/tI7rul6r+ZClSnprdYR/SymFSdRqOzghLYktUTbKMfbUL/kXTDs?=
 =?us-ascii?Q?t0MO1XoVVjbvSIvfC+L6SeDmiL8hMB0WR6MeUDnHMYjCX6BuiPTvkhhb1UDT?=
 =?us-ascii?Q?S6L5x6M9CSPn9bKrfJk5Z5GEYFNujrlAbgnBr+heOMCtXXVCLNXTN+VcrwKo?=
 =?us-ascii?Q?1dwPADlzzOE0gFOkjDcfjrHumcfSGUiIfRc1jvX7fLKEfH6OdNqrYPeoVw/U?=
 =?us-ascii?Q?3p8WCoOrXOTSddkEURzCKhAIE4b4Do5NxjRrAv2M1MCRDxVsp4orSdDl7wxI?=
 =?us-ascii?Q?bKQXLoicj5R9BXgxnqJLH5Uo9RbzihOi+Ry0IcfUP0yzN89bsg98sFxGnwlg?=
 =?us-ascii?Q?rA42S7s9Dg6I86f0y6LCM88woycnqHIS6YNO94Buk5hSIEm6ZeHb2x9jhTnd?=
 =?us-ascii?Q?C+h0UrE/0WDXs+vg7UPIOjmrTbRB5ZMF8qwhgwDMTUt6YwYLayhpCPLdtbkz?=
 =?us-ascii?Q?bSbWmoXCsmsCw1BWkFUhFjtPcwRdsR0GprzeI5efSPJkDLm3R+sMa8FnfN55?=
 =?us-ascii?Q?XR+scih6aYGJTGAqEKk0yD2/1JAk49KQXR1kWnM3ncppyycTLX8RTDRAGMn1?=
 =?us-ascii?Q?sIVxIK9UKtmpWs4ScRkPy5QBatbfpzZbNucIyuPtgrsJbOH/WvATpRkc+KKx?=
 =?us-ascii?Q?MgpHfwIrTPtq2ztJNknep+cCDn4/6VXpQJbrV/4s6LDsOswX3Zuf95lthT5I?=
 =?us-ascii?Q?rWYu9X301dcextOP7auz8XwbTtnK0lmV7WMGDlQSOFJNWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3374.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cRsQxlW0eVy7I70M+CEZuL5h5QIDmq10ee7cwV7RWfsVNXuFU/UXzHq+Iy6P?=
 =?us-ascii?Q?auRM4HmvyqyAu6tAx5rSu8NgX6sDGRv7DeBcj1A9BwSvawT6M1WSmAB5/dry?=
 =?us-ascii?Q?YMPa2YsxV/uWVbqjwrG0+sq7SQdG3XU1oM7G6vIec/2ItnEJU0wcT0YcZmus?=
 =?us-ascii?Q?Hhtj4/yLvRuy+VPrPB8mt+BMN7gp5b6al5nuG5uaBOlVOFbUnIeX2sFP+nOF?=
 =?us-ascii?Q?1S2aXfcTo8uqBNZVkLU0EhP6ofkqDtML+A3AUXon9OU/ilUHqSEkPggtNUkb?=
 =?us-ascii?Q?HZAM4YOkZZs6l5Y7E6nnlosyX3NHINwTTocAOGw3Un8uiG6T1WKFyUtXGB8P?=
 =?us-ascii?Q?0KBI9Os3p3pehzJeN48ve2Uot+VJy6bjDGzKklRPS5g6o/2fvqNre0mxGLHP?=
 =?us-ascii?Q?hvd10mHD9lxTKkpq0IwTec7F/OBBP/90mS4LBJWi6B0hd8gkl2R3O/C/Z/Tr?=
 =?us-ascii?Q?LKGDk4M9VCDpQppQ6+QEnPC4TzgIIdL1Pigl+tcuQxpJFogRXVb8kj5LMsNa?=
 =?us-ascii?Q?xizit4SsefTv8ZASXw+hmtzb41YaYxrEcAY6EIKBQNcKtBUuPUh5xi4VcF3g?=
 =?us-ascii?Q?LfL1Vl+cYaYFk4fI53sst7n/0FCTg6ydFcDP9XWinQbbQKBNcqwewTsPq1jW?=
 =?us-ascii?Q?orTyaAc3jlWu0PSdLn/EFggwJTKA3FOcvAz/ho+TZZpU1xr4iBaR21HMx6M0?=
 =?us-ascii?Q?pc2DVkIygNkRik9oiOt7tbrDLW33Di/JxiSC1aFMPHW39ATT9GcGl/SkT+MK?=
 =?us-ascii?Q?S42zJmuGUD5OuuVfOLxgEbnmYajWkL8bHTvdEiZ2wP+AF9LRrwvY5DPpakxm?=
 =?us-ascii?Q?ppzMn1Vzc1odXb146SbyT65jB7xaeQURU1gVOksZf0TnrvjYF2FcVJMRgpO/?=
 =?us-ascii?Q?q476LYQbyOKDW5o+bM15KSGTJ3PaoQba37AS+14LQpP2bP9DhqfymUXHvumA?=
 =?us-ascii?Q?ILz4JR86+po2dqxHA5k6oAcyBudHEm0BbsLOYCD8yBq9agmkUZMwpR4AW/ZA?=
 =?us-ascii?Q?BIzb5pIh8MHTTiSlXmpSWUP8R2ohZBD5Xjqy+0hOrsg3fKFbI9EY7mscAg4B?=
 =?us-ascii?Q?jnEQjZ7JZ3uwGDK4ynHtzVK8RevkZzxNdOGsxhKt/4eqmKQsQAcidHLaA6Jp?=
 =?us-ascii?Q?vQNzOofGi5LWdyQo6sv5viqXfPaK1IGz36rYU7Ae2317ox9lmXgq+g/r6JkX?=
 =?us-ascii?Q?H/0wrUvHEQpv4QgNtrKl+vvjj9jGF+fnlPg8YeIT5BXPYlgKwLL99abfbN96?=
 =?us-ascii?Q?eB3fwJUWc2JVX3U6Wte9OhiIBonsCNovXzMRkr3XLUwQ3KQpYZ4sgAk17NDY?=
 =?us-ascii?Q?mHvmArPTLJW1YHbLJVNTYYYoXF2BytjLEOb78v66bQ8eVvry9rUd7qOg7HkJ?=
 =?us-ascii?Q?YuRnSTBXzvqA09Wcm7B+SKewCC0dCGkJcvu/eYA3azi4UKLXSL+Da+AUhGNl?=
 =?us-ascii?Q?Yl51MdAe8vn8Emhbl0m1CBbuwQ1OrviUbSXPfVl/MIyEjx3t7JN6OARGpz5M?=
 =?us-ascii?Q?64YHwKFxq1+E3Ep9kptzqgiXqrneh5zru313mGMKy5wwi8EO+yXXirmYAQfH?=
 =?us-ascii?Q?ibB3DcxubKbLm1Hp+mP+dRJ118G18HRnsiYiEgH4JebgBEVSgiA6Upi22Gvg?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mEuPSLsoDzJ7w5l8WJBFhPcDQLszDvJmZHB7kB+JRtu0ne3Lmp6HCxIDyMdzFMZt1U2YXNXjsoTMqlZXO1saO4lQwh8oHF2A3kSwbvhdSGvUwdbYKntlZCLGXW5nBEeAtMVuqe84WtThU/lahiUgD6TMLxX688pMWKXBb789B0Hvs08yCmyI6wbt+vhu4/cA4w6oGYxWmD3h14pEDeMj5CIChgoxLd00ti9HydS/ggHSRAZdxHjZltOParRfw20By7wVF2v7lC7BSeBo6kSbwN9mr3oQ07l2lFiR0VGiXseFMCc1VJhI2JMu4JpedDXRChJClPf2uA9X/KYwTh7fM+9f0qnyxVvm1QJ2iYT5mJ4YiyZybwaDAtdCPyFRP3AqEE5ebwS8I+hv/GcEejgcZ9UawxULxN2zOiOkBGE6JaeDTUSVCeAVAtbcuJsr6V3PQKZqInHWI19iIkzdyGmkgqr5zqdP4h413GTAXg5DtBqpOnHwZG4c62HlzjsUTnKvxfkLGCmF1aoDG6ftt6bG074h540G3IKjrxVGtyOt55CHhGKaxhB2tXRZigYVgdAxI7pON6OAq089xb92GlZzjWhVmNd9WQq/u8uiBZCx/Is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878543cd-2fc3-463e-f4b8-08dd0fa1059d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:37:21.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUYxwjVYBFOCW9GkQa7HdOYVJdqBkfZ8pmeDTGwKHd/VqgCalsh5O21hPrRPZ0qwYWPdKFPQYiZB6XPcfhfz8VXX4RCse+1L+KdEwpVApc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_10,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280091
X-Proofpoint-GUID: RK2dz1GIdFwwK2mZrgu57Hyamu3HADvj
X-Proofpoint-ORIG-GUID: RK2dz1GIdFwwK2mZrgu57Hyamu3HADvj

We are current refactoring struct page to make it smaller, removing
unneeded fields that correctly belong to struct folio.

Two of those fields are page->index and page->mapping. Perf is currently
making use of both of these, so this patch removes this usage as it turns
out it is unnecessary.

Perf establishes its own internally controlled memory-mapped pages using
vm_ops hooks. The first page in the mapping is the read/write user control
page, and the rest of the mapping consists of read-only pages.

The VMA is backed by kernel memory either from the buddy allocator or
vmalloc depending on configuration. It is intended to be mapped read/write,
but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
that it should be mapped read-only.

When a write fault occurs, the provided page_mkwrite() hook,
perf_mmap_fault() (doing double duty handing faults as well) uses the
vmf->pgoff field to determine if this is the first page, allowing for the
desired read/write first page, read-only rest mapping.

For this to work the implementation has to carefully work around faulting
logic. When a page is write-faulted, the fault() hook is called first, then
its page_mkwrite() hook is called (to allow for dirty tracking in file
systems).

On fault we set the folio's mapping in perf_mmap_fault(), this is because
when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
as an indicator that the fault should be retried.

We also set the folio's index so, given the folio is being treated as faux
user memory, it correctly references its offset within the VMA.

This explains why the mapping and index fields are used - but it's not
necessary.

We preallocate pages when perf_mmap() is called for the first time via
rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
needed if the mapping requires it.

This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
and so we can instead simply map all the memory right away here - there's
no point in handling (read) page faults when we don't demand page nor need
to be notified about them (perf does not).

This patch therefore changes this logic to map everything when the mmap()
hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
to provide the required read/write vs. read-only behaviour, which does not
require the previously implemented workarounds.

It makes sense semantically to establish a PFN map too - we are managing
the pages internally and so it is appropriate to mark this as a special
mapping.

There should be no change to actual functionality as a result of this
change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/events/core.c        | 76 +++++++++++++++++++------------------
 kernel/events/ring_buffer.c | 19 +---------
 2 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d4a54f50826..0754b070497f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6284,41 +6284,6 @@ void perf_event_update_userpage(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
-static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
-{
-	struct perf_event *event = vmf->vma->vm_file->private_data;
-	struct perf_buffer *rb;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-
-	if (vmf->flags & FAULT_FLAG_MKWRITE) {
-		if (vmf->pgoff == 0)
-			ret = 0;
-		return ret;
-	}
-
-	rcu_read_lock();
-	rb = rcu_dereference(event->rb);
-	if (!rb)
-		goto unlock;
-
-	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
-		goto unlock;
-
-	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
-	if (!vmf->page)
-		goto unlock;
-
-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
-
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static void ring_buffer_attach(struct perf_event *event,
 			       struct perf_buffer *rb)
 {
@@ -6558,13 +6523,47 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }
 
+static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
+{
+	/* The first page is the user control page, others are read-only. */
+	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
-	.fault		= perf_mmap_fault,
-	.page_mkwrite	= perf_mmap_fault,
+	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
 };
 
+static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
+{
+	unsigned long nr_pages = vma_pages(vma);
+	int err = 0;
+	unsigned long pgoff;
+
+	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
+		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
+		struct page *page = perf_mmap_to_page(rb, pgoff);
+
+		if (page == NULL) {
+			err = -EINVAL;
+			break;
+		}
+
+		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
+		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
+				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
+		if (err)
+			break;
+	}
+
+	/* Clear any partial mappings on error. */
+	if (err)
+		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
+
+	return err;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
@@ -6783,6 +6782,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &perf_mmap_vmops;
 
+	if (!ret)
+		ret = map_range(rb, vma);
+
 	if (event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f688d0d4..180509132d4b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -643,7 +643,6 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 	struct page *page = virt_to_page(rb->aux_pages[idx]);
 
 	ClearPagePrivate(page);
-	page->mapping = NULL;
 	__free_page(page);
 }
 
@@ -819,7 +818,6 @@ static void perf_mmap_free_page(void *addr)
 {
 	struct page *page = virt_to_page(addr);
 
-	page->mapping = NULL;
 	__free_page(page);
 }
 
@@ -890,28 +888,13 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 	return vmalloc_to_page((void *)rb->user_page + pgoff * PAGE_SIZE);
 }
 
-static void perf_mmap_unmark_page(void *addr)
-{
-	struct page *page = vmalloc_to_page(addr);
-
-	page->mapping = NULL;
-}
-
 static void rb_free_work(struct work_struct *work)
 {
 	struct perf_buffer *rb;
-	void *base;
-	int i, nr;
 
 	rb = container_of(work, struct perf_buffer, work);
-	nr = data_page_nr(rb);
-
-	base = rb->user_page;
-	/* The '<=' counts in the user page. */
-	for (i = 0; i <= nr; i++)
-		perf_mmap_unmark_page(base + (i * PAGE_SIZE));
 
-	vfree(base);
+	vfree(rb->user_page);
 	kfree(rb);
 }
 
-- 
2.47.0

