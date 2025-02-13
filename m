Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A539245011;
	Thu, 13 Feb 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473572; cv=fail; b=mx7iwkA00DPShJZofROouWVwX0xqUo/UsK1AMTjseP2Qz5O137qFfwP5f3P5MUS+/VeQXDexN7dqmk0nq5h1C236sZAEB24QhtHOyd5cn81PD9jLDbaySFyPjAwN7Nzi2uKtm5GLXj8nA3qbGlmg5f5jFQMt+FZWc8g9xNYmb40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473572; c=relaxed/simple;
	bh=Vasq6IAK+JHgkDiU5tMzy6R2F4e3KE4HYAVPzdxZIWg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sO9gSCOZsBM2aT042N+ZSVBNX1nP9StAiEKinOOa9pbaFYr2DqLrYOQhWSAyghMqEHzYRJvyYuap1rC06Jshgi0aAW+Qa8SzjfSYKC5pTMvMB5DHyand1QKGh/GbiM65BAYZc5xuGivSDy/AMw9YM45mN7/WIpaLPT4RuiFDjiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8FhzNkw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r7epziSc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8FhzNkw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r7epziSc"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfgfh008217;
	Thu, 13 Feb 2025 19:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=97cocwfhJE4yKsnm
	JUAP9Q4VL6dPOSHkW7YK9Nre1aY=; b=m8FhzNkwpRbj0UpbZGQNGNwVQ2nhI33J
	jYwtMI23TKNOCWrNLuzeJ4P7g6g0pJYui1moByBvEgMKqFfdyTDIp3aJFEKLtxBc
	g6X4Vy1AaHELD3X5q6qAAHy7sP78NLawKWAHLSytrAkWISxHnTB1CMJ2/HPL8BBj
	nmXeadgvOVdovOPzIziIWd1laR0Bd6C6+xK8E6BAFb21nLgMQVfzTwx+RHKRkPOt
	sSsUgpEQodE1asOT1tBSj7Tji77TS+rceFqdZ37B+x3mCfEoT/WMatF7p6LJDWra
	bKI5SsXljHw8L9FZc3Xs/310envxvqOmNLllyidrc5cxdT5HA0C7tA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s429ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:05:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIiqL6012300;
	Thu, 13 Feb 2025 19:05:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc54av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pczVcRnauLToMhJsbN4KLgwZ7murxFU1brWm+IEkLRpt0EA6lYC+52gzqsq8DCUEFt6Y+uGQKqrOLEojYevPbAWP7XV8SG5MyKQxqtEpJmcOGv7YYMQ3izgLAQkfOYAwj8fZyA0Fqw9mxacBoKN4GliUveh+NqGrE1eM70YbRXMpBPwtix8YJZNdbm8YcW+VUWQvxfJyjlTCkUIuUP375MxOs4Sp6OlhMrNfHjfB82Vot1kSXjKzosGRcxpVnUrPXTIm3ubGL5b9mAf7p7/bZtLs2cSQB3gTXcnmZACrX3I6YcWqxVA1O223ZbS2BjlVa4CrZgmAi0p8MMu0Yiv1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97cocwfhJE4yKsnmJUAP9Q4VL6dPOSHkW7YK9Nre1aY=;
 b=niq7S5tofIqfFKCpA7oUkWQRmgFR3UK2hcNaebf7guHLxWxucO1BKNAAyiOSkLimQzoLQCMb2DmwVNsY8Yk/kRmBZ70lndlqSiTFuTp04byY2gHtPERN45B+70tgVx4eEWvJrrRylBskscbPf6WNWielDDO47AzwYbrfX9NkRAjTQd2g0Qn/QagYpQcBsEIfVx+dbUAU7DAUW/Hjip/c4PI4+VFHqAFf0dKw4Ra9X0ZfNKVTz9xh9MEpqLy+2BY46PBT66JxgcAIfamZjM6itmN7vPiUkGLIeaoxGS+M5QjfdJCgt/E4vwtYxy88wdXdAcOs8i5alxKn4TQJag2IEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97cocwfhJE4yKsnmJUAP9Q4VL6dPOSHkW7YK9Nre1aY=;
 b=r7epziScgCMp7rQbInXgbb39ANnWQRnRqv3LVihzj41yZ2P2eTyeb+v88vhR/Ay9Sy1gOoLQdHbCzgTb9SgAeUL2+XJD+bjxnbr0lglKox86tKGZyQ87Vud2CPPqDU3uvENPU+VLdmREv3RRtRjhmllpANSMmNazMvbsmcyYRMk=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:05:44 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:05:43 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 0/1] Support .gnu_debugdata for symbols in perf
Date: Thu, 13 Feb 2025 11:05:37 -0800
Message-ID: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0e57b1-c364-4dd8-ebac-08dd4c616a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s1+HjykCZKGIMz1Xc0pIs8HVg65c8JEdH1SUnGiLQhILFpDXA6LA03dEdC97?=
 =?us-ascii?Q?rCXAUNLRF/ZJR7Nk1/NEfNTp5BhWbW7ktn6eGWEgT9j8BiI6hkWIuc0OHz5L?=
 =?us-ascii?Q?zgiigvJxazYqkBrL2GjjKk9FiCHcigG3dg1YI624AE4ySBpmzzpXKA4JsJAe?=
 =?us-ascii?Q?M+V62nejW/R+/b6RsSDojZ4CO597dJIsUJSMIAbzdpZn2IcIUMNZvCKt+KhI?=
 =?us-ascii?Q?pBNxiGi8JDxgW9zjYRed8jAlMRfGwoioVoC2nonQ/sHYs7txR0BBhQFhlqSS?=
 =?us-ascii?Q?Wx6Sk1eYVmg+zzChCKhYa0lp5XKiMan0TDK0lgzrXsSlCVtE/hgnWV/8dVEo?=
 =?us-ascii?Q?fh8qFxNGNvVpg51D+tVf/rGcPo1YYTTRKve89uILZJNqOBJ27Lzyrod76ivK?=
 =?us-ascii?Q?lrP3OwwFLckeAzjoKdGHsUtEL051nBTNjCXenrRuIsCSri03w8B9gItyGgJ9?=
 =?us-ascii?Q?DS2/h+PhWP6TJ/gN7MDT8ZLTL7yiMe6tSSldSmkZ5wO3Qr4exbafDktXS0mk?=
 =?us-ascii?Q?3YXkuXLY5HBu4OVlfuTcYWZZpe1ENOr/aYcavyyFDGWcWzV1LFg0ewflfWxI?=
 =?us-ascii?Q?sn6CsCvzWISm9u19RG92n9Hw8aGxTrdpZ/ptcsefpfFGYJATPYUCK8I2MR9Z?=
 =?us-ascii?Q?+5E+uGTLrRmqIKYc19CY1haLvg7Xd7SVy6AChXFranuzp+iiz8cn0/2lS3n/?=
 =?us-ascii?Q?PBDfSOMhTO1ZWs/+0/GBMSMJnf4jRFks4FftSp5kP1MDyDGjKOiLDWGqXMn6?=
 =?us-ascii?Q?3SPCTwo+5k7L9Iyfhebh+bkYwIZrn/mgHnPvDCv8OEsIQqpa08b+mmCI3j2P?=
 =?us-ascii?Q?plO1VCTn94Ws25Q5I52ss3YYgffveZHTls8nj9C0PJiUhrjWfs0EVHdahrcp?=
 =?us-ascii?Q?uU51jKIGG6twW1RFeJwyfYxM8Sgo0vE98+uUKo0lBZ7QHhA5M9ogseVCX/fz?=
 =?us-ascii?Q?6VVnq6/7xJuvZFXnGDE/fCrU4SaaKGfQG7GLxoT6oeqVMWVtntCN42S2IgR3?=
 =?us-ascii?Q?XL66nW7r6WWP6BaOjPQd8eU8HJNOGuWHtwhRm+m3/jwy3s2JOidfa0Er1VDO?=
 =?us-ascii?Q?qV7iNAFXz4oRcVlEl6I0ND1RwEWo7Mc5q+37rbIQqXlgXfCOB8ojCaUjzDFz?=
 =?us-ascii?Q?0tfZD5wXB+cBXtF6CUEg9IBftMbkdnSvRR6I+TleSRwDV6+EKqwn9RuRdkVe?=
 =?us-ascii?Q?Z3vo/tLoNcOeE2G8emk2QEUf9Tbl0EL95EIWm9Vhi9UpWJlmvXMB1nudF/lj?=
 =?us-ascii?Q?JTrbDKWFMyA6o8zXHjM4Oo5AfkPRoefRCuBc9nx1fcU7OSPeSHIhvYravaG5?=
 =?us-ascii?Q?GGhdO8Io0JLYZGCoIfkizhUjjBFukppTktq/ffOxs8xKjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTlh+T9me3Way7ZZPdZaUJj+eFp5xJlozXaiY9VwvXq/bDdhN1RAh+c4QCDV?=
 =?us-ascii?Q?FOqnc+kKBfBNtiRM6llSO87wmayOl2T0gIk19BxM3V+0zBUazW0O4oc1KnM4?=
 =?us-ascii?Q?mOt6zvvIumyrFgqqajGPHU1c+BQvvkIE/DGwApsRGTVsx8dXJgd+KraqJLjF?=
 =?us-ascii?Q?PPepAk1N8eKuSOklVm2DJHhWAtB2QCo5r7XGT3MobB50cyCWjY44W2oTcUL5?=
 =?us-ascii?Q?BCMiz8Lbshmv23zuOtgj8H5XshSDakQCxFOFk4/Mwf3qBcD4peHKcSNDWGSi?=
 =?us-ascii?Q?Crv2Ma+MTPvUoPIhJI0kMB8R+bh56rQWOi2CKY7VbCrs6XWTqMl2c9HpsnS2?=
 =?us-ascii?Q?z64HPLUzwdXK9mRWbvmMbZx7011hX0/PNwRvE3KtkqKJ9l5YVn/I1dgVAdf2?=
 =?us-ascii?Q?VtTkAchSIq4FYPAxWysR3y8MlkV/NqeE1p271qRX2ljSeYqB7WKGK4IW928o?=
 =?us-ascii?Q?7SBrWKf/Q3cHZyAlYUZaWJVfqMVKzsEJfi6C5l9GTz9LCkKSNScsJ9sXHm9E?=
 =?us-ascii?Q?rSjOXtyX2/66A+/AmIRMsNFKnWmqIRrXoa8U8G6gvvQvl6VbZafoMuvtvqpB?=
 =?us-ascii?Q?j2MI/ZXN/WqhT/IQtkFgC1kQ+hFEXCAl0OWCgRd5V7LSeCpH8CYZ/JuSaGPJ?=
 =?us-ascii?Q?97jvFUv9Gz0+7exEtH6t9+D4c5EY0xLadlmvHFStsks/VXxZsXumUv4tKlVU?=
 =?us-ascii?Q?/lXOvaQqYcGmJ2yeZaS2//yM9iSJKz+Jx6POhaouZOCUNo4mL8AOsncIVpOO?=
 =?us-ascii?Q?4eK3aGCeQ0HRoL5ewFiRs/Irg35DdchCncmTDbEkmyrSwprsuf37A2pkvUKk?=
 =?us-ascii?Q?mtHAj4SkbexPvJFQCaHZudKNvVPbl8EV7ezfEc7DyokwgYUJ5XAsnBAqPsnY?=
 =?us-ascii?Q?hf7s/aeCps0IX53kxku0vfnmmPYbzlRoHOlkq9TBv/UwRK4ASr1tCFkIcY6h?=
 =?us-ascii?Q?Yodu9+/YK1bqldxDcC6u0BFQoUz+1NIjrFHIIfhstlaegL+F+sjw0y/2plSo?=
 =?us-ascii?Q?YAnOL5MYxLu2JFlEqPk1s8hv6ZQSowcrppy+ADfilA8BdduFN2DouUfLV04X?=
 =?us-ascii?Q?mBty9UPAXD5WnBFDjt4Jb6xits/KE8G8ZvK9UXFlUfKFZtaMqlhtR0MAWaRa?=
 =?us-ascii?Q?/Z3h2NSN/VnWyenVK8HtF4qK51u2HZGn3HX40iIN9ZFjYbGE2q+I+OC0CQCm?=
 =?us-ascii?Q?I9khXvuywmh5liN+pXO2KTMoWMKMV4I4r7APWWE/+ysaGWxso2KoWOeKbHHM?=
 =?us-ascii?Q?NEqb+lRKXSgUX0Elag5TZ5uIQF/fYgVjhbEcWTj9YwGE45iD+I9+if03TbU9?=
 =?us-ascii?Q?CgWEekflAgLN1Uj0SqcD6bA0YzHchJeohYI23/WZut/oynmWKWB/XAQ595o3?=
 =?us-ascii?Q?ptFzbadYFEra7jFxpDgI3L+G+G6IVbG1MsnOC5ZHbrujxQorDfW577qW7axf?=
 =?us-ascii?Q?gNTLkn7l2BNwXCQtCMgKj005viTIAtNSZm9icBg26bYPeEFfHAvAOiD02Dgu?=
 =?us-ascii?Q?DltzTBl5U9aJ00zp8U744pKBtHA33jsekMeryG3WdfZbRsvcQkz/hRchSWIt?=
 =?us-ascii?Q?paHi/OdfK8nJpuetEq+ICWqKE4nG5DsGgm0t8F1/svmG8RDLv1ivuFDFOHl/?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JtfHzIsVKRHXBPcqFPf90IK/njBjXlWwHJFuoQHWc7ThjaifFnxVGZitSa+eJAlYV7nzqKbo2ZFpv8AKjd6iZ3TqUuUq5tzQtul5GWlY23Vq91NvtonCWrR1ICMLvVNQTSB7GyMB87YXztup0LOtg7JFlH7i+AFNLAvW5ByCMC8HbclNwcBwEeYwGxnrtW1i40cXiHH4ViJVVKc1ANtO3gezrJH1jXNAo8kvHfAqhh96gkngiIV08s20tRZV7UnKTHgld6lJUcPIIMoMnRJwR7D2Bv5+3lM/zSftCYeXdJMR8qaAfAJAqjBqkrDcaiHmZQ+PMp6rTIt2QvdkebkT1spO31i7zWa+r5dMzUHqWww9gbmuLGfAXmbbQVdCZLdZxvbMNUsyiGI5Q359i/JBFXRloS+O/GT6fjOZ3YEW198Xkk+0sTt7Z6633HL/tzflwxxn1PVRnGInQBdgQOihi1WYS2Lg/zi4angz4J3DPhTQyeFZzXPHJ2iUrjBOTaBpnEzJnwjhSeP1E/Cfg2cgmnRch+ucX1yTF0P3SSIL9M9yfvBruuArxrhtTP7Q2CjB907VIbjZyXcK3gM9U1PYkPMSE36LPUQ5G6EwHNe/HEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0e57b1-c364-4dd8-ebac-08dd4c616a5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:05:43.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOM4QhWxIdrU/ygReiffjT8NQq73XlHYUWtGyDLnsbh7s3ys7kAD4rOCvJg+u23eC952FiqSYJl87Mm1wR7o5Z1XpRkC/xwZyJYChcsi8Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130135
X-Proofpoint-GUID: 645rXIdzkqXTuSAJwabO82U-zbqcvZ5w
X-Proofpoint-ORIG-GUID: 645rXIdzkqXTuSAJwabO82U-zbqcvZ5w

Hello all,

A while back, Fedora implemented a "MiniDebugInfo" feature[1]. This allows the
full symbol table of a binary to be compressed into a fake ELF file and embedded
within the ".gnu_debugdata" section. The standard RPMs thus include the full
symbol information, at least enough to provide symbol names for stack traces. As
part of the project, support for .gnu_debugdata was implemented in GDB. However,
perf does not yet have support for it.

For Fedora, RHEL, and all the derivatives, there is already the ".eh_frame"
section in ELF files, which allows perf to unwind stacks with "--call-graph
dwarf", and in some cases, there may be frame pointers to make it even easier
and more efficient to gather stack traces.

But once the data is recorded, perf may still be missing the symbol names for
many functions, because it doesn't have support for .gnu_debugdata.

This patch is a first stab at implementing that support. To demonstrate, here is
a diff between a sample output by "perf script" before and after the change:

@@ -16,9 +16,9 @@
            55fdc45c837f rl_read_key+0x17f (/usr/bin/bash)
            55fdc45a744b readline_internal_char+0x6b (/usr/bin/bash)
            55fdc45a776c readline+0x4c (/usr/bin/bash)
-           55fdc4509dbe [unknown] (/usr/bin/bash)
-           55fdc450ce28 [unknown] (/usr/bin/bash)
-           55fdc450ebb9 [unknown] (/usr/bin/bash)
+           55fdc4509dbe yy_readline_get+0xae (/usr/bin/bash)
+           55fdc450ce28 shell_getc.lto_priv.0+0x278 (/usr/bin/bash)
+           55fdc450ebb9 read_token.part.0+0x49 (/usr/bin/bash)
            55fdc4512739 yyparse+0x3f9 (/usr/bin/bash)
            55fdc4515bbc parse_command+0x3c (/usr/bin/bash)
            55fdc4515d8c read_command+0x6c (/usr/bin/bash)

I believe this support will be even more important in the future, if and when
SFrame becomes supported: then we will have an efficient unwinder that doesn't
require debuginfo to be installed. But users won't be able to take full
advantage of their perf recordings without having the best symbol information
available.

My approach almost certainly can be improved: I'm not sure whether there is a
strong preference to decompress the ".gnu_debugdata" into a temporary file, or
if keeping it in-memory is good enough. I'd love feedback, since I know this
approach is a bit rough around the edges.

Thanks,
Stephen

[1]: https://fedoraproject.org/wiki/Features/MiniDebugInfo

Stephen Brennan (1):
  tools: perf: support .gnu_debugdata for symbols

 tools/perf/util/dso.c        |   2 +
 tools/perf/util/dso.h        |   1 +
 tools/perf/util/symbol-elf.c | 141 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.c     |   2 +
 tools/perf/util/symsrc.h     |   1 +
 5 files changed, 143 insertions(+), 4 deletions(-)

-- 
2.43.5

