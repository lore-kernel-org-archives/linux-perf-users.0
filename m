Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6A366078;
	Thu,  5 Mar 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734756; cv=fail; b=rnquvFBipdXldH+5A5P6/KsO3vxCxjGmVFrvXdp5IB9syYYsUUKZTJ34zKC9CxjyP0ZjBaiOxosRNT/OkPY0hQcCFwTlY2p/GBcCW8YDAYBdbQe1bxNh0gBMxR2z+1W7JS0G+4bXa0sy0DWxJgiQbbgfkDyLU1XwJ/+kbl5JycU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734756; c=relaxed/simple;
	bh=nwIcETwon2WtjQPf4kZsRKsoylMvD+JU6elifSCHO50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bQJzjgDVn3qeX0ju08Rqon19fOHGQClPhA7URD+Z5DlSwPLJvTrwuxCbB6ZpvCgBC1uNYbnMnrTgM01Lv9/Wzasix2+kFe8i9DULFiPVxx6QRDLTKA/jKMwy6uukPt9172N5qy6wwbTONJ81JUuNJQhKIRF4a9gxOl1GIJHv41w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKZN1b0E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LDjxigPU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKZN1b0E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LDjxigPU"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625HxYMG2827568;
	Thu, 5 Mar 2026 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ZmoTKQma5UEJPxnb
	Fo+ba69UtbTqbcJXe754Zt2iHQ4=; b=oKZN1b0EW8jaVJ/FIszG0saYll+IO+vy
	WnQ5eZs7YMojmrDv2fZeT4My9ka2mgt17bfG/rCTvsePL7t+EgXknnUFkrSPeVbJ
	osrInSbHgEIv2dA9WsdewLNg4UqChcbYgP26w9/ZlV6CMvb+lRoNxAB14z5GWiRs
	Xs2ZD3M5JbodMSrcqeLMB+ocZNj3PShzqHchwray27ZcDQ6umJiMMyRpHB8IIOcf
	km+Hj3St7h0q2cmHkkCLL8dKkwasW6sPKWH6Eqh8skv4qUVuuC/BxaL8FNhwr42t
	WI/Go1AVdoTTP75X5dKjwSUoxzbRCRY2wbJ2UOHJK+yr22ViwHqqhA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqek881hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 18:18:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625H3Hwr029888;
	Thu, 5 Mar 2026 18:18:54 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdjsvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 18:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IInzY1/jAquV/1yoErXsbNycawODIgWBdnhWFdex6OoA8DYel3cCUgyV/3trecOFRT9I2y2VUu4kK5XobAJAHvVXb1E6ePhBTXq1/2pHMmsDhywEad2B6I3HIhtzq9aaxyiuaSaKVETX5sYzGcS4qMbm+ORvGvdY5Kr3h5EjJZr3nKtlMh6GUlkQk9JHiEsfuLLtAwPIABJaopE917PUMSK0tKezVehmuZvnoJ9vk3ScIn6ekgPcYNnVkZ7ack1jvymL7cs7kdSXyCguCg6TStbtcblGsZ/b3c+EBTcd+0MWq2k9oD+Kodv8e9yDZw27PSaOe9tr7YVq56PF1N3Wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmoTKQma5UEJPxnbFo+ba69UtbTqbcJXe754Zt2iHQ4=;
 b=uFpn2cjFffNT8lEA13aAbutrDmcFrrd0SmUYTDD8257ubOoQ2Til9/oih49xFYaSoMsVYqA9fiIYi6SPItPmeiCDRejQjKbA06CSKPSvi5FHUhjUeT+izkjGEyvYV0dXIC/erSZAepkx8qg02nn4w9FYgN+vY/s+SmybUFinXyJcmmq78IjYmS5W55YFKBkpdGuJuf2VOHalG+mw6gGoFWqdLxuau255P1j/DAjTGWRkBHs0lJC+h6zHNkIVllPbFUWDWPTXC0C9NPxMlM0nYfOra1vnnvNweQdcdOX4Sqy1r61otBcAk0IYZF48XKxTOWh9MqUhfC2brKttrdvxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmoTKQma5UEJPxnbFo+ba69UtbTqbcJXe754Zt2iHQ4=;
 b=LDjxigPUVnrHt9dW+0aH46Qle2hp8ehCic7WJAu9IM+ePNipsUNdueKwhrZwPc5Q/RmMDq8xoLj6rsCy5F+Z/hKxRjviJotuZF9MUm3lLCP7UYyf2BPBB1gj+UL4BwD7/sUmSrqxsyZicS8Wekp1KIVwO0BTNT/wh5x8ukSJF74=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 18:18:50 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 18:18:50 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wangyang Guo <wangyang.guo@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Tianyou Li <tianyou.li@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] tools: perf: add comm_ignore_digit column
Date: Thu,  5 Mar 2026 10:18:47 -0800
Message-ID: <20260305181847.3249498-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::10) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ba5df4-9e7d-48be-6cb1-08de7ae3a6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	EPGuT9sFdBgrFYHZvqQSWP3Va6U8grms8srezF3MluqKVupwGZ15obfIKksslE5aptyx7Y6CRmkuL6R2LUn3fWw7f/2AlrjdXHcdjAXjqK4E3vE+zm4YbAlfHlXhkG8NV567Srd3J6dEQTBPzItSQ8eUl5vqfBKXbFVGZfYsMjlVbqZx6p2LbJ0xn0bag4z6ubq8gUTZ8TapyIPfM+8JPLcQSSynu5+sBgL2EwTeWTTP4bkvXZ3dLIBk8NnLxwFZp+k5l+5PR8GAqIFpds1MI1pftAqIa5aPF/IiLdTAuHHCZ+z8yWiLQzUb0n/sMEZEE1KtbaDqNMV0e+7VD8UjsHgRR21FpqAtO6QzGffMoqkV2lx4PRvQwANCY2qCEGDmTIysMU2k1zCVYpTB6ivN3vns41wM1bchvko9Mp1ByjOmvx2+LEo+pQpKb+jan7Sf0x5t60PuNJqZuHPKm6IX1YzVUleOB07K3sJSTQlRWXq2St3cg4OL0gs7n14xmEEqDDzg+mdFzCySXKIHaebgh8S1TGPeQCJUAFpWn8Vq4vJU8hTJPdg+LKstOUZ2Ex05H5b/ZAVf1qCZQJ9Wg1Io8xG2AjP5j/SC7u4E2UHgHlqjLJKuMAljSPeLyZx7TFron+PwjM+5UKMqoafJ2uOByu5kU2Mpmh0aPPHFDC8OJnWu/umyirVvi7QdzRO3DuYw7NQr/s20HXRGV5J3Ts8OyCY+D/dbNvuLKlb/mg0jqrk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbpCE2WUp1wC31io8I35YoJINJ8ex6znBiHqCGOdRiQyA+kJOEnnlHt3MNPy?=
 =?us-ascii?Q?IH1dWLq5aYiof4GqVIQMM1rshK7nuVr/5pmrXUYzDfPbLft1jEpO19gadHcV?=
 =?us-ascii?Q?VOGsBASJO0aGe5wU86/B2Vda1aT/ndUqIV9kYaH98dba9eE+4McUtEmB7LRH?=
 =?us-ascii?Q?zOvJ5YBB0/eGsVnj2usBzIHmR3m2TR8U06zuU1UKsSHJRLGQsVj7CblI8Vu4?=
 =?us-ascii?Q?khTkaQwjQYqGe5aM66Gq6lpwv+AzVtpgr0bPOM8DlQKlF22cNK4LRp1Kjjry?=
 =?us-ascii?Q?FUAgrkwJjlvp4RNFF2dDN2/5z/7C6lSI7yojiOrzt/q5DZJfpI1bbfYst4/k?=
 =?us-ascii?Q?ONdM2pOPqWXSVjqmj2nooegv6FPX8WmodzeTejA6PYw45ziiMaX/V5E+MUU/?=
 =?us-ascii?Q?fPRD0Z+vkAhY2RMZqL5FTgX2aDxK+3BbMln/+13XYIqvoQZelMPpoiG2n+ag?=
 =?us-ascii?Q?Pc//iF6rcHQUyHaEpdYzbReAb9HFylcbrmAevRjsH+QfTnyWMcf005n/wbhn?=
 =?us-ascii?Q?UFR3fT+IUQ8hxVmzk4B78hONDU+AmIp8BxiXqZVq9/4wAZWyKwx0mraNqtly?=
 =?us-ascii?Q?P7LTsveMvPthUOUdKMIwEkrfUPQtpnuYMu2K4H94dP+wNEmt2nxKnRIFyQww?=
 =?us-ascii?Q?8XsxOcW+XVzvhuQsnhqxhM93ERGlELFl9lP0gqpW0IHSybEYmqkE800AcK7x?=
 =?us-ascii?Q?fpiheIaPuW4638B8sP8pr0E6JmayQBv3cmyGMaLru/sHQvk7zOzM0pgXFw51?=
 =?us-ascii?Q?EN0aObbdRyPsx7bdCz0+HDvfj8Z03PhmIcLpo3ad4u6hoCXocjnOk6zpaGXG?=
 =?us-ascii?Q?bmaQz90PgmMMHEKqftUYEIhgyKVdQZ7XkpT+xFGC55dhTRWBkqQJEwpZ3QTs?=
 =?us-ascii?Q?BqzjjMivuYuqzp5MKE1VtiewTr5Cop4GbTaLejiqQrUXmX9hx36dr995jvOi?=
 =?us-ascii?Q?g3JXWPwHDKUftPLhQTWFlCBDJXl2d6vWndaYYTYMSBe9bE8AgZKe5fCIJY9u?=
 =?us-ascii?Q?wpaJBlgQDqitmoXmD2cXq4pvmpF3ELhE4A1qYEo+771Of7l5rK+rIwZLyIyO?=
 =?us-ascii?Q?oDmt4DfUPRFJa+JKh56/8znB4ru2HP39b5k0uYh9OVMVYUJuzefhD/qCLSPG?=
 =?us-ascii?Q?FrTdvlU5+jiMLjhnNbQDM+HAYfkngUpXGkHNRCAjt86mG5Ofp94Dlc5q4QNn?=
 =?us-ascii?Q?f3NnJSES/YWUDfgkUqwifAEVDgggby6HfQXSRxBEt6FLRZ+cvvGnsZsCBFXQ?=
 =?us-ascii?Q?mk6HYUeFqxEevntsfwSWATyfY/L8p3f7WplktbQchtaNu2f1rxvJcs8z/2Ln?=
 =?us-ascii?Q?3hm3LCLmTJAMkE+/3NIpD7VlHoSYaoi1tqAcEhWjxz+pQcWVLWCzJkrWxIXC?=
 =?us-ascii?Q?rHj5L2F6tx7mjCMkMW9ibPF9hMKz9L7aGtD8ta9Uzd+mx+1mbilivltSeh9D?=
 =?us-ascii?Q?ZiKMLEIHNwKWJQY3pRNXIg1kvdb+hgk/Ou3pH5F2MRNL4/JWn0eoP0Odnr1Z?=
 =?us-ascii?Q?tLEkq9Kxe6xgm4noFy8hXnv3KdwFxgn0WOMWnC6mRJYNY8OVdEtU01DqzM32?=
 =?us-ascii?Q?bLysR27NlojyCd7tVsd466h6R03OL/DTPaRCteAlTaeNATddS0SYTz/2c1Lu?=
 =?us-ascii?Q?0tdBEFu0P1x/tV8BxQJhiqcEvCvQeaBJ3kSX2OBG1VBcWCLjsNekpByRNzl5?=
 =?us-ascii?Q?0Gn8wNVdmH73s8xl5JHGUG7ZQHzyE57X+Jwanhm/EAnm55eEWRKMigUctnF2?=
 =?us-ascii?Q?4+1+LO20SrAXWgQMX9om4WzdV8/0xXQ=3D?=
X-Exchange-RoutingPolicyChecked:
	q0Z4IM3GHGWmPgPpBgUsUusd/fh8OGU6ghNMkxX5A/ypdsPdh3tjCQFf35+mP37bjP5IqB4kO5+0Kg4C8dvTt3l+bUXeZqao77/Zd1ACTVCxag3SUFPouS7BI1Q8hGtAqP86FdVmlBmPX49hKKT0nl63wKShjuF92stv6XqNe4y/w4mT4U1c6wmxPtOHwTeG84wzE9C1vZWRQLRmQsimitFUxdCcou3ns4UKGuTPSq+wEunsdbbafWFXrlQKaOkaQVKSOw6996fFCM7EvUaesyl5FS5WCfwyv92ze4Dwd7FfdU8VgpXtSTTv2FHfinEeHIO4Gx9WVJedpK5JTUf20Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+dhPU9IRYP5VQyxb4b4/pN35DgWhAIUS+b0FgVOR+Tgw9jNrKPToAxHPT5FvVznHp1cE8uvcrNb+xqIGyD2y5qpo6KmDu2kKTeckGXPfmPRxA74Sww5OAuF9mCC2d7sxcLBIpnlQ8T/FX+D67nuK0SxQS6K1MUOJC/VlsUWjddgVFuSnDth/j4gSPvPIwslpWxa4dbnSrizA1aRfPmWgzfLiaR65uuZbW8QK1xaqCDLJWr2o499ZZgdM3Iy5R2+4Icso36t4ithmtJ5uAXJhKsKMwIahD7sBp6WBYIJ5eOnvF4fS1D+XwPAY8UPT9K6CRLOJNxBrT7ywylEczn/zHvIkx8AWMgt8M6lHQo4YSyyLrqspDreiK2QfmbAn5PMmKWrmY7yyP0KptkFt6NCwaBok9uMkk3uUH806PPncR7iypO24QJ5EXk1CkWMfVQoMYyrSMDXV6Lhbi0iFVy8pe8AoXiaFuSDy1ENYr4iNnsb9BUUHA5/LHdDUYrFcvNEcg0B3RGCNgU0p5zGx0LI4iRMBVJrr5uPLoRxfzKgDxxQV97E0kr9mJX1eAp2FjwhzXs3ITu16HacFBjpgkJMi0N0pnElSV9T+4U51dVWKpA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ba5df4-9e7d-48be-6cb1-08de7ae3a6af
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 18:18:50.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pxNlaMY5+TGUyCK8ie/MWVhx5m8FSXh7nqJQFXku1GYs0Fk+kKm7QN8TI/Q226bhePYwn/0BiGdKrAjEIa3Cbz4t7y2JoqD/oiHexzqtME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603050151
X-Proofpoint-GUID: FbBQKvZLNIiYqXULAo-JW1vxlnwXI_8F
X-Proofpoint-ORIG-GUID: FbBQKvZLNIiYqXULAo-JW1vxlnwXI_8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE1MCBTYWx0ZWRfXxp0qzy2wTiq2
 fO7WHV5gcAg/MR4VzGJIs2HxspxI+GN3HUKOp490w2OEUZ011skSK3iAcnNt8783SfX3FFrtxT5
 UBrnsMxB/pX5+SXs4f/wnD7gEaehSkBEjEBEgNos/W/L6TxETfDmOFAwG0Wf81WhmlwGw2kDFBN
 n1bniICb2TzmXGTBr7JvznsdN4h9t4bLvEeesDdoamrIV0pobYBAb4ljYFqdEMzmk+VE1+gouIr
 xz+UGu3TZBbQUe9FaSEmr6eb9G4hri9TJuukSL8oABRw4ETEOC4p7xXKnPynfS/HxCscm18X75X
 3S7A8KmU4B2rVKnrh3Y8OK8FGqGOcmkY3h/Z9A3A7GnNwRlaFjQld+XmUWSAT7TKkNs6xHAt43o
 SrsNstFgK+hkYBT3K4BPdLnTjGMfphTer9mVsKWiWmT/dc6Q2ZDnaJ5O+TJLqYXOmJ14SqQewmF
 FXh8UR3j4oWXdVov9iA==
X-Authority-Analysis: v=2.4 cv=BKK+bVQG c=1 sm=1 tr=0 ts=69a9c90f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=bcPjUtRZAI3iUa6RJckA:9

The "comm" column allows grouping events by the process command. It is
intended to group like programs, despite having different PIDs. But some
workloads may adjust their own command, so that a unique identifier
(e.g. a PID or some other numeric value) is part of the command name.
This destroys the utility of "comm", forcing perf to place each unique
process name into its own bucket, which can contribute to a
combinatorial explosion of memory use in perf report.

Create a less strict version of this column, which ignores digits when
comparing command names. This allows "similar looking" processes to
again be placed in the same bucket.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/hist.c |  1 +
 tools/perf/util/hist.h |  1 +
 tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/sort.h |  1 +
 4 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index ef4b569f7df46..6759826be8344 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	len = thread__comm_len(h->thread);
 	if (hists__new_col_len(hists, HISTC_COMM, len))
 		hists__set_col_len(hists, HISTC_THREAD, len + 8);
+	hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
 
 	if (h->ms.map) {
 		len = dso__name_len(map__dso(h->ms.map));
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1d5ea632ca4e1..ae7e98bd9e46d 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -44,6 +44,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_TGID,
 	HISTC_COMM,
+	HISTC_COMM_IGNORE_DIGIT,
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
 	HISTC_PARENT,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f3a565b0e2307..e6012b2457c5d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
@@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
 	.se_width_idx	= HISTC_COMM,
 };
 
+/* --sort comm_ignore_digit */
+
+static int64_t strcmp_nodigit(const char *left, const char *right)
+{
+	for (;;) {
+		while (*left && isdigit(*left))
+			left++;
+		while (*right && isdigit(*right))
+			right++;
+		if (*left == *right && !*left) {
+			return 0;
+		} else if (*left == *right) {
+			left++;
+			right++;
+		} else {
+			return (int64_t)*left - (int64_t)*right;
+		}
+	}
+}
+
+static int64_t
+sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
+						size_t size, unsigned int width)
+{
+	int ret = 0;
+	unsigned int print_len, printed = 0, start = 0, end = 0;
+	bool in_digit;
+	const char *comm = comm__str(he->comm), *print;
+
+	while (printed < width && printed < size && comm[start]) {
+		in_digit = !!isdigit(comm[start]);
+		end = start + 1;
+		while (comm[end] && !!isdigit(comm[end]) == in_digit)
+			end++;
+		if (in_digit) {
+			print_len = 3; /* <N> */
+			print = "<N>";
+		} else {
+			print_len = end - start;
+			print = &comm[start];
+		}
+		print_len = min(print_len, width - printed);
+		ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
+					print_len, print);
+		if (ret < 0)
+			return ret;
+		start = end;
+		printed += ret;
+	}
+	/* Pad to width if necessary */
+	if (printed < width && printed < size) {
+		ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
+				       width - printed, width - printed, "");
+		if (ret < 0)
+			return ret;
+		printed += ret;
+	}
+	return printed;
+}
+
+struct sort_entry sort_comm_ignore_digit = {
+	.se_header	= "CommandIgnoreDigit",
+	.se_cmp		= sort__comm_ignore_digit_cmp,
+	.se_collapse	= sort__comm_ignore_digit_collapse,
+	.se_sort	= sort__comm_ignore_digit_sort,
+	.se_snprintf	= hist_entry__comm_ignore_digit_snprintf,
+	.se_filter	= hist_entry__thread_filter,
+	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
+};
+
 /* --sort dso */
 
 static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
@@ -2576,6 +2664,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_PID, "pid", sort_thread),
 	DIM(SORT_TGID, "tgid", sort_tgid),
 	DIM(SORT_COMM, "comm", sort_comm),
+	DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
 	DIM(SORT_DSO, "dso", sort_dso),
 	DIM(SORT_SYM, "symbol", sort_sym),
 	DIM(SORT_PARENT, "parent", sort_parent),
@@ -3675,7 +3764,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 			list->socket = 1;
 		} else if (sd->entry == &sort_thread) {
 			list->thread = 1;
-		} else if (sd->entry == &sort_comm) {
+		} else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
 			list->comm = 1;
 		} else if (sd->entry == &sort_type_offset) {
 			symbol_conf.annotate_data_member = true;
@@ -4022,6 +4111,7 @@ static bool get_elide(int idx, FILE *output)
 	case HISTC_DSO:
 		return __get_elide(symbol_conf.dso_list, "dso", output);
 	case HISTC_COMM:
+	case HISTC_COMM_IGNORE_DIGIT:
 		return __get_elide(symbol_conf.comm_list, "comm", output);
 	default:
 		break;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d7787958e06b9..6819934b4d48a 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -43,6 +43,7 @@ enum sort_type {
 	/* common sort keys */
 	SORT_PID,
 	SORT_COMM,
+	SORT_COMM_IGNORE_DIGIT,
 	SORT_DSO,
 	SORT_SYM,
 	SORT_PARENT,
-- 
2.47.3

