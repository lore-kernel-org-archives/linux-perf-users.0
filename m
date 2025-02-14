Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BE21CA1F
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533647; cv=fail; b=XbFVlIwgcJKHed2fM78iE6sdc41oIZCgFlq3QCtRJELCEjGfui6MuHafiwR1p3ZXxMmAsfm/yqVsx7brbIP3fhAqPCxudXWKHTfSUbff7Xn9XDofTOSqeJogJWmtUqa2WDkckzGXqB23jeU2R+n1mFXjIJveBWGs8kJqmzt3Ab4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533647; c=relaxed/simple;
	bh=jZQbN8l4HanXJ8nA0eXFh4rMb7H0fQGBofAFxN77i8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L47rQWYGPi0yoKkeMxOVSHDGrB7CE6JuMY8rvO0eJV0JHaUUv3EfA8C98GArVQKRKR8yVtzuvT6DLqFuoXLsU8B5tn6daBskA5Jbaukzy//fx3kVm5CRJaVXY/E2RbgOhwKiL07RS0wmqOQiwgG9vPDgCdJSFd5uzBmfP7LpOAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/E/t8YC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zh2VG880; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/E/t8YC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zh2VG880"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBfcHE016001;
	Fri, 14 Feb 2025 11:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=7MU3tuYIrHCms9m5
	VNmsBK/KOAmhh8GmprLePNvwTUk=; b=T/E/t8YCwmD/SHQHCsmNgK9MDRyTaA3z
	r3gq7npsWbLl+cnIcfPlBzGLWZYE5lx0REIcN9RXJpSMnUzrguz/H4DYg6nHSf5L
	VtexWxbUyl+Q7tHr0MftdALmIIhhZCbDOYDT5byITVZqbflZsXw/eIIl4Q7Z4VCw
	/RDK+jeW19xMAMDDksjPkMS0iqMSgwCTITb0RJhoToN4VyWB96JWaphAbhbQ63c8
	AVMEQAzaKcAhYQXmNtWxDRlZpkITV5HYkiiHJR2j2eG0AxJ9Gi5+fSwx1b3CDxwS
	35HKPbUnZ+0t/niUPq500VAFGFMv/zpJXcC4IEGpeDUUtzSE0eRR9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnbeyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 11:47:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51E9u3XK001148;
	Fri, 14 Feb 2025 11:47:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p633gam6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 11:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO0ZhiVMRFsxPMF4gxWw0fbziw3eDk01gG4csSTKqbLXbeGFqvVxnmHDR6elwDu3OhNFrP/4uzhNj9WR/hpN9bmPO2Zd7ZNAjPQnFTJ37/cQVlSpxxChxvWjdRfbO88Y0xsEPStVT3a/INfYsWiZNcXRXo62g/k0q0JDrY6I+BVOqnY0DuP1VLybFJHEEpDdCRdWVkeeorO3Ku9BmZZPZWLA5FpzLOhMPAnxrWchK8dRad2nNJGej2jRUl0Ihki98xCr9OcOVf3fXMJdqgx6ABIVm1OA0xdoyZsAv7xi26MTQAML1XFHzidbd+Mo/2rDBn1DeMIuiiIXAnyk7C95VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MU3tuYIrHCms9m5VNmsBK/KOAmhh8GmprLePNvwTUk=;
 b=WrAOLnOCXNjdB0y4VUNuXr/NI2domO22hcBdFarKko16bNK+UtkZPARRdNBi50I7udgmFN0yWfEkYc5I8FB/Xze7qCgio95hosyuKKS+etaS9sX+dky1HVpnkouz82gLhVC0PzkkkQrFsTDND1KdiNo1/4H9qsTDgg9Ul0VA5YbL28sv5oY6fBT2gGb16kCxWljntBB7esXhmJbENQSXXWd9IvorWaFvdpZPY8Gr2ZYcYixcy4Iu+4Ksp2npXQKhKQOTsOwEFR2MRImjshM/c//JbqQwa0qG4AFDAR5xZcmLS79z9YPiVnzKHdQG+SE/0I7ix+iHdCRljWU5zmYveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MU3tuYIrHCms9m5VNmsBK/KOAmhh8GmprLePNvwTUk=;
 b=zh2VG880sD9+pDOig2hZSXbLbJPd8v9Q4p9aNnEuIU7R1fdEnTdfcmD+J7lCzugYFodDkU8l9v0/r6qfT2AEIx/ed5FdiWUnsdQ1gAGUisz84cqBeIUDrwWzjZf57HWZSnyNhTZoaRvYoz55nrE2kaz5TvCg500FJI/9u8gm3NY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 11:47:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 11:47:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-perf-users@vger.kernel.org, irogers@google.com, acme@kernel.org,
        namhyung@kernel.org
Cc: will@kernel.org, james.clark@linaro.org, mike.leach@linaro.org,
        leo.yan@linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] MAINTAINERS: Remove John Garry from arm64 perf tools
Date: Fri, 14 Feb 2025 11:46:46 +0000
Message-Id: <20250214114646.1444305-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c562567-fa52-4dd4-4547-08dd4ced4fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aY4Uoj3Kbba8Hmi5qBiTva3oNgzijbik+gpEi73H9OKDqWx6nKtvZGH6LVwA?=
 =?us-ascii?Q?n/zVu9b+UnuciMTcBIQ233dOEwv/dadVSM2CAcKPs+oM+OZrY1Fl5VHVpb0W?=
 =?us-ascii?Q?077cAKvDoT9Gw2VHKV2579LQ42bx8LXM/7YLAdqVaBEOLdq9SYpK8ByprHLc?=
 =?us-ascii?Q?jEMNbFwI0okn3evz+6OCvyGI0X9hr6JnYLYmONvuGFho0i6vUP7RzrfLOVG1?=
 =?us-ascii?Q?zarEBkUnJXGHa58Bi1/Vurr80zcwORRdssnp9+LTGAKiiJxFKdZHB30qgDKN?=
 =?us-ascii?Q?m1VnP609OHsH2wFg4uxpN91zTcnhFle/EFqOwZ+BpT+ek+ued4E+aA78/fby?=
 =?us-ascii?Q?zzQvMXG+aWe6PENX2j3RkiPNooA1Jzr6YNOARSvyK6IKCulXJfyL+vkLfr4y?=
 =?us-ascii?Q?zmHIhoDccYtSYRGYLvyPhGBLAy9LOroOpWL+lhvFvZbl+nyWIyVai0lTYdkl?=
 =?us-ascii?Q?PXhe40JMiCiG/NrxocluUTV10HFY1RM2RkzAT7FGsNDzrpdzZkno9ZaNie1Q?=
 =?us-ascii?Q?62LhWPE2kXiA4Kud57IuTcvFyxaQwegxXxEQS9LH/uEpYs1HMD+lsHmGuNC0?=
 =?us-ascii?Q?cnb5FyuuXffprj/LqKzepQA79i1FcnMAEuVwXf1Vi33NQSLL81tlCyWwFhKR?=
 =?us-ascii?Q?zTabD2SvUzIlYUoRh/t3aCiu2cOQdPlg1hzHhqOEgUWmXOIgcjbm6v+QgCUP?=
 =?us-ascii?Q?4Gypegr/MHfNCdA6M+qS7yqp3NqIkmj/+o6DWC5YK1R6aYRBx6CsFlTa/ZuT?=
 =?us-ascii?Q?UCY+rTK1U08lkDDIcVTUhahsVj8aIaaTUq1ycW+pJd0HsnOAox/LshoiZQYb?=
 =?us-ascii?Q?AV1b8+fj78IIj0+sDxYmzl97crnoQtfjgCM6l8WF9sEe7r3u4wYmqlV+xjQh?=
 =?us-ascii?Q?dxvujcOYXcVXV975zmLzEZWRLHuwMloWHWfF0bpUoNrCIg/vICGtzoxD1I2P?=
 =?us-ascii?Q?buF/Rk0FXfw124jOTo0n5V0UkNtPYKKugJtLLb5eeVyZbSysajpbnNWDXdOv?=
 =?us-ascii?Q?Xvkyvw5Lp9hajt1q1iTGMPQVAvB3QA7BPmIur4/l0muKPufnZAB6vfOKQ1aG?=
 =?us-ascii?Q?Or1PQat5KOhd8ztfh5xrapy6LzT81rXIrmvDXRzFcSXYr0epZe66TCPN5iD6?=
 =?us-ascii?Q?/fZV2UY37B3TZZbs8BWiiGWyhplrZEveuElIrRWGpiwA75rDlBs+7uzIBH5w?=
 =?us-ascii?Q?+cE3VCq7Gs+0ZxokZfkwpi/quC5iif1nbXL2SyxsYfSzpcXACp8GupylHBEx?=
 =?us-ascii?Q?Nyxhgv3vte4su7mPqy4shzkTEHOZOZrsId1BBxJKBWwa+5gMJUtrN2zAQdrW?=
 =?us-ascii?Q?cQcWgrA8USZFTsr53typu8v2fMQSs+tUxWbcHJjfpokqsRfzrsjUg9WCaV/4?=
 =?us-ascii?Q?PLoEse4xY+G0V7oZxY798pZGfKph?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxy+8psAGUxlqAqKYx/ZhrbYLJfnNlKlOdfocw6Hq7ZU9j9PC4sWllNCGJ3k?=
 =?us-ascii?Q?+/oCox9ZENoJ3zAGfqgAXV3EpM22zKgcZr6/+NctylEqJbFJUuYsqvhp1fJc?=
 =?us-ascii?Q?26xM9WMD3vGaaJCKFgoim8etpytO7cuC9WcXsC6nF/VK9Bx+z/CV1ug0y89v?=
 =?us-ascii?Q?C2cXlcJccpArO2rhKdHI96jvEALTusxtl02lDBf8mdwOXdJRY/SS4dROM7vT?=
 =?us-ascii?Q?vagRCrf+g303Y630ZyPH0L0vEUVxjuA6mYwpDFHJAZj/1hfjM7pYrpRXxRyM?=
 =?us-ascii?Q?ZT8Dd3I9adA6QF3Ro9uLvS8EfdM2aOFLtDoKsAARsbspoaskMdhK1ilC/C7L?=
 =?us-ascii?Q?e6u06KjhvCZXy/SAMGFOcSpQPiLb4Cpr+09kPgusRFAZwA0JRzYZS040YE4q?=
 =?us-ascii?Q?e0UaIy2hLa77eKb/N9kZqdF4R4cgJnYbDPI0OmZQ1nSFA8YUjIM+M3UPF5J3?=
 =?us-ascii?Q?rAKdWcoRQbQ0snVA940zqCAQ4wvL2IMlyDohY7oUvnPwbEr0klB7xZtEgrw7?=
 =?us-ascii?Q?ActZ9hVUv8s/urWushMUrEpqGV9CEoFtkxUDt9QhMpPjOcb4I/SM6FnGaDjL?=
 =?us-ascii?Q?eWNTQ8rpIjMDw8n7FX3TKsHIH+LP+3+X9RPup55IJbENUET7RAsOgb3dEXyG?=
 =?us-ascii?Q?UKgOu8XxUCCW0MhkAxkRpgbtTugt8RRcpqk7BzlcdVd0LVqCWWYKIsBIGwIW?=
 =?us-ascii?Q?NaM43en1PZlRjtOXAUJvjNdB2SCXzQgGM1ufD/qF9LTy7E49BOqk6ITPK3gX?=
 =?us-ascii?Q?Hj/SGX+MR2hW/hUgRWvJGC6pWP3EPtaKAxjjnQBV1gaWQ9cggsMwR2nFTne8?=
 =?us-ascii?Q?Tpf5yaUjh6mUFDnv4AU2WpIb/+4zOBT+Yj0YD+oGUgslVO69Q5Ac88E0llUO?=
 =?us-ascii?Q?fa1nqDmjNJIVBSL8tjdjjCVgn5wP0BIXv6QedZpIMcu3f8wF5yXKwSJURfYn?=
 =?us-ascii?Q?TZeYP2Z9EyHfl9Ala1MP5YmGw88mFik0S0250qVYvmFNZdR5ag1Hj9vBARD6?=
 =?us-ascii?Q?2LfsQI/M5QncLfoI4qyynlJfSDcpDPlQsN2sUvjRvehHRUyHzJriA8+EzFnu?=
 =?us-ascii?Q?lkJQm5mSvzwg+99aetKSw3kXWkNdWHzBfj8mc/ztwjKILwg8MwUamPcWy6kf?=
 =?us-ascii?Q?Ov+G8rFtgmpg6lk+yt+ajmZH5y3OP0epOEt0EgtsqSHWLPN2lf4c6d9aRXQK?=
 =?us-ascii?Q?S4fbI0Qowie5PP9AgEJLiingZQcz8gtlCFBaGL7JhjJ+oM5VaIZzHGYYlMY8?=
 =?us-ascii?Q?6qoMqqwKw03n0qtWPxGjWsa/kXkSh2n/uefxOk/V3CQuq1PaGKX/Vm98Tr9O?=
 =?us-ascii?Q?I7xHkQwZKoPbUeAWPxZz6/iz1A+PqNta4JDB6lFFIe4Rb2gYK8Mo18345XwP?=
 =?us-ascii?Q?lSo7XVmzRG5bCCGxcYy5aiq/sKjBcA1VgwiwM/IZ8cPZTjgDP56QPGf0jvBx?=
 =?us-ascii?Q?2RBGHMewQK6Hh4KuG2Pth8vKf01ITYp744sgyUZXHhMO2FB7O4oB6V0RD1Dg?=
 =?us-ascii?Q?07dj4aD2dkXI1XV9oQ9GrYmhbsC2gnnu1bdDS9QNoEs3LzHfjYFLH4pUhobd?=
 =?us-ascii?Q?nILJKmxoPE6nGaTR2fEHPFicIhmg9DrhYICyt3iMiyXtOjnIXsfyR9rBYz0V?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vg8qAEUwrRlM1FOR2IDyzlpc8WkJhTfk0KMHub/Wki9AKZ4+KppaHswitaUmQQqTXk/1Py8LPrxBpTjLm/8GzIPTZV1IRbvEhLbDAFkFf5rWA5Cpbs54etTUcawZLyM6cMY61uXYWkuPDYqTeeV8TwUZmlAVkh05mLc5FHyHyaEvNaZAL3RMEmCUhxeEMk3WY5wQ5jF7iTHmb9FUyf4eoVE1UmLSF50LhVTopDEzneKMy05h6Oj754TepUHV5Czuy98asOk58reRbbZgVgA7OsVssVUf5boIwpwbAJfBZcD87806xbhwXJZl0vt3rd/by9EXUsVSKfMc2uUI64gtsLSMDSYhEelOnXZ1chrCXRH5T43uWxQUknWKfxyqiMlOPupKPcmuDIA8jHZZy9/XFv4c4PfZ//kfm9PPCovq4cjMtoi5XXGxt0POumLbs/glHZ1BcaO8QgcjAcU1PlfjbLwUl2I5czOPIWE5HB2hseyHMaEIp3JJSsEug1AGpRdQBwt0+xsSyDJfePgKBuH2u6+7G/yYX9MgbARADj9zSgTf+Xji1yyLb7nCHIwsY66xZg8/gsNfGA0e0oNcfOh+r6k4Poa2hORzIBE0StGD4BU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c562567-fa52-4dd4-4547-08dd4ced4fc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:47:08.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DxU7VdoBYrorvVlIE5JlaPMYPMZH8uoTjL87dg6gaSKposap22+XTS/5irBXRZpCSUO9MWUHAKES4gBSHYFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140086
X-Proofpoint-GUID: U7hpNw8AyUV_TrgN4_I0FY0AlmZxgQcP
X-Proofpoint-ORIG-GUID: U7hpNw8AyUV_TrgN4_I0FY0AlmZxgQcP

Unfortunately I don't have time to help review these days, but
hopefully will have in future.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..9e1e906014c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18539,7 +18539,6 @@ F:	tools/lib/perf/
 F:	tools/perf/
 
 PERFORMANCE EVENTS TOOLING ARM64
-R:	John Garry <john.g.garry@oracle.com>
 R:	Will Deacon <will@kernel.org>
 R:	James Clark <james.clark@linaro.org>
 R:	Mike Leach <mike.leach@linaro.org>
-- 
2.31.1

