Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C323ED4B;
	Tue, 10 Dec 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851517; cv=fail; b=NOYYFuf/mKg95yB8tvtgsedC05UbR1btckWLzBqugaHajZ0M0yg5u6rbWRYOJDmPgsdgw/5owaDacQ2xYPQU9Bzbe/YiVuLuKj+fAyJCSVZPgHYIuTVMxk5hoaEUWNuGBusr9eTfx7HihzwNaCejJBc0sJPhvr6ObGt5taNgAkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851517; c=relaxed/simple;
	bh=L1yf3mDOSkAxDpihTwz33uHuECIvL+bPmluY9Q7ZfuA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U9TG2N5WcFymMFCK3QB3zQ6SBVDwC5ajaPoTuJPeABczKvDIzVigqiloIegFYDe0TJTsg0LCOmGZbMZOrJe6rD03SgOymqt4UPjuFjIVD6+TWfGk6O4EFnM5Umyj9+ceKivSckoQXwiExt1dLGyvCQuUVXaQbwTSS6feE0KC1Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E9ZTMsN9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bfUiUBi+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E9ZTMsN9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bfUiUBi+"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGR5Mp013054;
	Tue, 10 Dec 2024 17:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=tvNVIp5DhYo7XqlA
	YTXsgTiqH7w4F0QUxVAzhLMCAiA=; b=E9ZTMsN923mZlPduMsa5t4lGyWHaUX5B
	C+O2yZX3AazAvIfsO/KtbLm9cRQVC/6kYVG7dThwtPct6Ig8AuITddCTFynxDN4L
	er3pAjlgpDh5EDW9hXdPSVQnF9/1KP6xGXu0v8osc73Iyo4gysHqONR5vx/98EdR
	GUJo21mEow7ipDw+wgsqFXKpH6fsvcW/XpM9aOeMUS0IhefijT777BsaPY3pGlt4
	2GuVCf6MYZ6DfpPiJIyRGTxolVEz6sAzmPBjvPMe5+y0exETzfup01/Wv7YCGWN9
	DkmCyb6csVHPOeDQLpF71dV0dr38YHimzDOsRG+ksGGY7hFoyWGe9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy06ej0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 17:24:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGhO41037938;
	Tue, 10 Dec 2024 17:24:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctf6mf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 17:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUuQ5DRDGHn32v6mSabEQytPcPc5NWJGt8LyZJ5rLh4ZlKTRI9QngodWuDc1GCApKBp+iwj6n8LicBefs8N87oHQQ9MnaopP4zH1+LcQfnfePIPYLGFw+oyCGEb2M9769Vb3RgNXFFjsYRD5zhaBXaUiaANyVySEoNtEBUg2eVfGIOsZGdmcbi6KB9muygYV4DajmDjjkO3neMnAqyp3HH1x7Aqlm7OZQIGQwt1R1lTRj3j9wMpQnJyJK6FOWz+b/ce3isF8S8OoCAOrx+001poHdXZQMoZECVODQKbbRjtyYbQjd9amwhyWKcgZG/yVon+cwfThMuxwubJ4CeIWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvNVIp5DhYo7XqlAYTXsgTiqH7w4F0QUxVAzhLMCAiA=;
 b=Pn7rF04zsbx02pw5jKhsSwY7D04oKkCifuhLc9BsF/PjxXKGbQ3fgdq8ggksVDIksTCK5D4ygVz1ufavEpFjFTb2yyYrB8oYpdR7SlTdgb0KceoknAWwlU09bF7zXnXZNOpVs1mzp9+mnxsqU7SP/N47PPv2e+0yQvWSLqOAP4Jf1taZOBLd9nlrJ1zlSyx+s2NXlzQRujFPjiP1S/jTQ9g7o9MsEOvIS0DJhufhXKsqioSZsMVMrv84kEZ+a9y8r+aCOxTtEYtCf/BX7Vqc+dnb8q0BmRyP9TpQL9/Npwr0dwRuaTcQZ1y72keyreBQGPsZdIgxqAGGVFV3oiV9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvNVIp5DhYo7XqlAYTXsgTiqH7w4F0QUxVAzhLMCAiA=;
 b=bfUiUBi+kKJSIENTJDv/IMQRVmcRY4s18CM/3rEFvFFMo5RbuHZuTRDGWnXY78ml3C1InwTv9MXBLRqS5zpYewEmjKVq0J6qjtDWxkqrNUZwANYEENvcyiHaYtKRM7I3/3FdwLLmX+LBT9upD7YtPJZsbQZ5WMAjqIeXNvmt28E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6146.namprd10.prod.outlook.com (2603:10b6:208:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Tue, 10 Dec
 2024 17:24:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 17:24:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>,
        syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
Subject: [PATCH v2] fork: avoid inappropriate uprobe access to invalid mm
Date: Tue, 10 Dec 2024 17:24:12 +0000
Message-ID: <20241210172412.52995-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 469df768-66aa-4efe-8c43-08dd193f7f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUAH2l3kPhH48cIUwexVQFVIKGGIfZfVg09QGIm4h0TDZZLRJUUCNvrvpBfB?=
 =?us-ascii?Q?CFHK59NCadF8saLrkfnLT4WkxLX/+JH2ubnmyRAIeuKOH4+Ch1UKMUbc/bCd?=
 =?us-ascii?Q?z+p5bdxhWLQ+ko9f3UtDibqwwy+J2N79BahVocdxRo0mEdf0CvH5KnvAGpax?=
 =?us-ascii?Q?8iD4z10s/p9Fne1HWXrVU/BPaJIn6OEUeeV+K61d3T9okdiFqlQsikdHO8uQ?=
 =?us-ascii?Q?InXb3YjXFLF6MGYRFk+DWeqbD1KzevCGRFnrSOqiKn7vz8dwc/ODssoNW2rI?=
 =?us-ascii?Q?E9C8QUjUZJobG71ED+wBV0zYW/3JxOBZmNcw+Q8Z6SH4zz05ZBjH9sI8UsQB?=
 =?us-ascii?Q?RDgDTjBzDuRCWJT7Q2wFwcaNgX32pDIzqF8BITQfAA6zO+41+VqsCCrHhomL?=
 =?us-ascii?Q?RxmHkSNhsPUiNV1E+QEOe4F7rPjEbzdKMYsbeUY5EYjbb9lEDCWuyxgD5C7X?=
 =?us-ascii?Q?Bkba6T/m/eirCfLTgcX2JXSgQpOwpS/HXkmWiFHCF9z7BukHJI1C2L10LiJE?=
 =?us-ascii?Q?s9hJx/m7WRZIgl55IGtYMz7ev9LsunPBQJNmoJwvVw0GqQCdUwB4OJNz8UBy?=
 =?us-ascii?Q?kyLBO/l0piYocRTWJDApC9WGs2lLz8T0sumdlgIC9VZ6756QTR4jGKnYfwNc?=
 =?us-ascii?Q?XPEyhI2ojIOsGINdmBfKQPXXmiv6sbIUxrliNIyoSzYE7LqStzBrxkKNq6yq?=
 =?us-ascii?Q?TD6TyXMIXVXVe82hD9cV/5+VONq4lc07AXjk0ukieE6/5/xKEFCXb6/295CM?=
 =?us-ascii?Q?mgtBnm0la0WKFkt1PhtpmGwDQd6zPx8TQ5yx2vJHsunqjKdVpUVWv5UYinpp?=
 =?us-ascii?Q?QRaczaZZ83Hdd1aN31k1s9R3PeGrHWDvvBvKD8uMI6XQg679JeaRlWRinsS6?=
 =?us-ascii?Q?TGrOCgCBC4VBKYtuo0WdrTrP1H/dA79CwYFlB1aCer2v7MxfxnSCjMGS61sD?=
 =?us-ascii?Q?4Ou0GdyB00gZ5/zWQohQs3/6Nei9uLF7Mo7erU46yA1SbnQ/Dc9JEBeGF38p?=
 =?us-ascii?Q?Ep75xf7eyr7lMks6ayXU0JXNwNI9FqmPdlxsUYQbhQpiUwmuTL0rjlAJ5pFS?=
 =?us-ascii?Q?rUkAM7FdyqmXmGZMMLCOQ/pPjW7c3s0e/mt9f001hKz8Z28coQJ9L9UD1HdT?=
 =?us-ascii?Q?gPrxuRq1mJfuvQ1DcHwtunu49jftRuempmSRJteT79rRRZcoeKIGhKg0AUSM?=
 =?us-ascii?Q?OVqfUq2l16SvJoYW55Wq6EcJiwVA9rlbz8xA0JAGO2rXTesO31L1yPkF80Ex?=
 =?us-ascii?Q?epDoLIl7Gbg7Q/js+y/Sc7d384wq3TZttzW6AZ04rQNOyRhRYleRL+JSaXUg?=
 =?us-ascii?Q?yVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8eh6QAAs26AyF3sZYx8/w5lJvGHpeRpltsXbcL++jJeTqsTATnzH9eLgxL9l?=
 =?us-ascii?Q?p7CwVimfjpm3iD2Rz2Jd1gEg0/jrLN+BfsZAQpUqZ51yInr8Sjeo2CO7hxaT?=
 =?us-ascii?Q?Ov8LYu77LvBsIwrP/M1nnOETe0pLjciXB3HWdtpmBFvcAUB4NxHLSQBFyDrG?=
 =?us-ascii?Q?kg1SNUBICtqLiOL2n2whz4xEQjzny/3cbNKbE5hh6nLwkBOPcW+0v/ko1SWm?=
 =?us-ascii?Q?lfxTAbAWnqqT/LblPM1x5Lbm3y2Ihqz8CyFla2SE0wcr7k54EAODyKO5MkyO?=
 =?us-ascii?Q?48SeHgSRrITpdNnhUmFk6Z78PsHU0XQRfz8ne6kFPYWL+6t9IEAHrs11FUo+?=
 =?us-ascii?Q?giO2Mva31K+E/687EVC0ZE2IiEi2qATNvWebV5LaskiKW7BukHggIvQK2pI9?=
 =?us-ascii?Q?sp76W5HRoJX4/QIg0w/NnDiFr8QPlserl2TQLMWW758bUgJEiQjGTiC3UVtR?=
 =?us-ascii?Q?+qotSztvKqv6AAVwkhBo8INZRtN+/Kr/Fd+nZPVvZtPtqKpIFH0IE9ZV7aAM?=
 =?us-ascii?Q?ipQJ+eRXri6XyCxqAqOOiIvBzXHeBAg9+CT0uaQZKJPD51qMw6XG+nCZ+cDm?=
 =?us-ascii?Q?FAtd45GwbqLmE8fzF/nPo39WsMymyrk3gSNbIAvrkKKEul7mbbBynM6yPpHX?=
 =?us-ascii?Q?D0mNTXPU0TYuuSroeT6iNimchB6oR3SS+9x0HKkEW3uSUGcFo/38nWyHQxO8?=
 =?us-ascii?Q?Dg1V0MF08W/JjGr2DunwscOk07bSe3sZCsYp+h+CHDku397sEaQWAlEsicx9?=
 =?us-ascii?Q?2HyNz17cmULl/pWlhkXe+hZ7KIoF5gv++iveq8QZ0Nghy1lNF9ApbDAFVJun?=
 =?us-ascii?Q?D1nO95K/tpvwtUxw2XGj7De9aLcOx2sLqSjLcFKdTD4U635PmfmHOSZkU89E?=
 =?us-ascii?Q?Lc9V10Yt+pWlMHSaC5bm7q7VLk9IzXb7M0yC9oN2VBhB4rfKMSnB1rgIexAg?=
 =?us-ascii?Q?uaLjjKjlsgXcXzMpIlubh496YZr4oE6dxzeUgOvhSK6aSfz33M4NtoHTuVwS?=
 =?us-ascii?Q?P/yO6RHir8wHKVyGr4FAxQY/no6dxHonQCjaDgTn2LLlIuwEv8ZwNCGFz7eV?=
 =?us-ascii?Q?Hm4nKlZy/03BQr7q2acPfZBR6ID1q/+16zOppDPaLQnnEsfsnkGRgES/DATK?=
 =?us-ascii?Q?teqZsgcNuvJ+HjBpzgQO1KzEOUVSkoHDm/l1PtbFnxMjqrzN7NinUR2LwRZN?=
 =?us-ascii?Q?0lzHASjPQ5nmIqBkO3gJgcZf4xX4obm6pJ6CYshuBtPD+K21fczOF39rggWF?=
 =?us-ascii?Q?aGS+HHyU/wbGTTlujHeBkh/TN3Pn6pKH2LNcYvyMt4OjXxaggUZXRGZctLNZ?=
 =?us-ascii?Q?S5c9nY7j+aLdeLzVlMiqiBuyoXgSiaTJ4w2KMQKPh0yY83GjV+yrqVkOzPRI?=
 =?us-ascii?Q?pei1M9YYyvJv0NLB30qWkiDinV8ervVz/7P5RA013X8bS6yMWrX8ZDDZyIyo?=
 =?us-ascii?Q?VWN73kDq/OEMqQ6XsYjbQXKeUF3wOLNLMXUW74PFN8dRPg+5hi1h3qDLMmAH?=
 =?us-ascii?Q?25x/MVtP8pEdfApeAimtkQIMw1EJiUVtegq4MLpxrjVxwW6vxsr089IvJu5H?=
 =?us-ascii?Q?ztaa9RPn3okKhQcQn96E15yFShrjlvUy3sy3SW5ogt5dy3EDB9BWhDp1UqE+?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GAYhwkF0OMZTC6nWwAYmy1vGVwFGVCWRcedQuLSVRlI1yz7zWK5sHfamxgKCsUuCO0gGfo0wfMpigN8tCWxxbiOEkkk/ujSO8cfcf0d13inqzLHGh+H7NpmssZbCzxT71zC+JZkTEumNqGH4rdt1qLeNHaQm/rQD3XEH66LsY0kewZjAJB099oo2wqgTBvPKsAqZvQqVaHbZ29x+6m+5BdAn+Crc5z3ADMylf+tUHzTaTDVaW2Yy34zh/6Ebx3IqNf+euiVQNtZ5AfMDKu0dzCtiH7VCPWCoSsJ+oH7cSsUk6OBmWvba+PnzdHFyyeVEbY5vmYLSsgYjDIH1taGetP3NXV1FXc45p5jeopgJM41kBUB/tPXM3gFsDdLf/86QXU+jTH1bOu3L+uw7NLppae1PgrDUalpQ0KwAP54vccnXsbc8mEhhHNIa4goweLX9ULmNiKuoishfqA1nJJFO/yoIj/Z0ORP8aFLukoc1yRLgynTzLkqhoGXKX4a5cugbk1AEKWtCGUtnzA3C9Fn9u9CY3i/k8TVBGOcrkpd/d9SQxNW5EVvi28NEZZRntouGJU3zAwE43N7UqSVlY9IrahLpsjQ8oq+AysHGqN2nc50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469df768-66aa-4efe-8c43-08dd193f7f6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:24:27.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9c+SoGeiq5sooyNXVGpbujEK5jpXkY4fN8u5Tu+ITUFZQ9ZGBDKr9wtOkYSLLb1Y4ix8I/0aCPsNnOGBSPq487tOLyN1PeB6SZq7AN5gNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100129
X-Proofpoint-GUID: 6sF9i7GVTA9dA9eghgbmI78nBdhFaXYw
X-Proofpoint-ORIG-GUID: 6sF9i7GVTA9dA9eghgbmI78nBdhFaXYw

If dup_mmap() encounters an issue, currently uprobe is able to access the
relevant mm via the reverse mapping (in build_map_info()), and if we are
very unlucky with a race window, observe invalid XA_ZERO_ENTRY state which
we establish as part of the fork error path.

This occurs because uprobe_write_opcode() invokes anon_vma_prepare() which
in turn invokes find_mergeable_anon_vma() that uses a VMA iterator,
invoking vma_iter_load() which uses the advanced maple tree API and thus is
able to observe XA_ZERO_ENTRY entries added to dup_mmap() in commit
d24062914837 ("fork: use __mt_dup() to duplicate maple tree in
dup_mmap()").

This change was made on the assumption that only process tear-down code
would actually observe (and make use of) these values. However this very
unlikely but still possible edge case with uprobes exists and unfortunately
does make these observable.

The uprobe operation prevents races against the dup_mmap() operation via
the dup_mmap_sem semaphore, which is acquired via uprobe_start_dup_mmap()
and dropped via uprobe_end_dup_mmap(), and held across
register_for_each_vma() prior to invoking build_map_info() which does the
reverse mapping lookup.

Currently these are acquired and dropped within dup_mmap(), which exposes
the race window prior to error handling in the invoking dup_mm() which
tears down the mm.

We can avoid all this by just moving the invocation of
uprobe_start_dup_mmap() and uprobe_end_dup_mmap() up a level to dup_mm()
and only release this lock once the dup_mmap() operation succeeds or clean
up is done.

This means that the uprobe code can never observe an incompletely
constructed mm and resolves the issue in this case.

Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6756d273.050a0220.2477f.003d.GAE@google.com/
Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
v2:
* Quick fix for silly mistake in error handling in dup_mm() as pointed out by
  Oleg.

v1:
https://lore.kernel.org/linux-mm/20241210163104.55181-1-lorenzo.stoakes@oracle.com/

 kernel/fork.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d532f893e977..0bf377e2892b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -696,11 +696,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);

-	uprobe_start_dup_mmap();
-	if (mmap_write_lock_killable(oldmm)) {
-		retval = -EINTR;
-		goto fail_uprobe_end;
-	}
+	if (mmap_write_lock_killable(oldmm))
+		return -EINTR;
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -839,8 +836,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		dup_userfaultfd_complete(&uf);
 	else
 		dup_userfaultfd_fail(&uf);
-fail_uprobe_end:
-	uprobe_end_dup_mmap();
 	return retval;

 fail_nomem_anon_vma_fork:
@@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk, mm->user_ns))
 		goto fail_nomem;

+	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
 		goto free_pt;
+	uprobe_end_dup_mmap();

 	mm->hiwater_rss = get_mm_rss(mm);
 	mm->hiwater_vm = mm->total_vm;
@@ -1763,6 +1760,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
 	mmput(mm);
+	if (err)
+		uprobe_end_dup_mmap();

 fail_nomem:
 	return NULL;
--
2.47.0
