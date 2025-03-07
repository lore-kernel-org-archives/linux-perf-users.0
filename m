Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81433259CB4;
	Fri,  7 Mar 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389751; cv=fail; b=SG72sZIAjWTkyBrj+EaFQHFqvJ6tCOxq4Epi32tCYmiygfj7QqxfXM9M4aov/6DqHT0D82wsbqIc3ai0wfrEdTQI3RhbpLI7zJ1yH0b63X0igc+Zmjp4pB7Uc2crqcywtuJcl7C/r8HLeDi7HUhQhkKVAmfI+Kes1RH0rGzOOEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389751; c=relaxed/simple;
	bh=lgAkZu8Y9I3XBJQC7HGfMFPPkoIFI9SERAwMcIDwCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttRqVSiMVngEohz6ficlewVSg2xsejwPIAVd+mgJIozdr3uhKMpyn3Ay4izuaBXXN/khSDsPW1kqJ/Rsj2hybUE3s/O3ve7Nr7u8AaTdACaJ6jxAVxgOsPIvPujoqGcB7YxJQxrH1VyzAzH/ofx681G1q5QeCO5zIDlHpYI/l6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QOAea93j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=da3FGXya; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QOAea93j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="da3FGXya"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527LIIgF005629;
	Fri, 7 Mar 2025 23:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qFFA7imQc2KpMM0GpAwts6DflnOl/2JTTizJggAM3ec=; b=
	QOAea93jBxzZ9MLsZ8lFluglOG7YiINhl/fzYwDQ76OL2I/ebGCrDssUFlVaQggw
	qeRyz0traCkxh/Jf4ChnebL/srg9M8cm06ARaYmU/Gr01Gey+hdsvUxJyFQdZSKU
	FwTLbX4I6kcb+Lw1O8KV/B//KUHKnq22+j/l5bXKNdJdw4s4BMkgdvoYWrG1My38
	1qHLS0lXMo3XWYZ1oKe6LuGSEZjognDMvV46+sOTk+W8FuaXw2aOSeGchcvXetUm
	AS2H5qQF1uNkS+nJTkABbUyx4aPKF+3DSOXNjPnvkPI4h2aaF1jfD+wx0KCCXCEY
	Vg7zpCGINmprQzoJim9MNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qnctn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527Lc5si022516;
	Fri, 7 Mar 2025 23:22:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rx13gvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUgZ6jtkdMj7/5cEy0cMjnpP5V/PhPCsjr7UnHM4/mX4J6txJjqsIu+9+9ic2oRgcla/16JbOEUhc/6vUm2LdETEUEwuBaWuM3Ob/SctOfiB8kjDMA63CLLp93I/4O4JTXctlTVZQx0ZqGabav8thgJjWCklrHMGuGk1K0JkdhsseqhF1ANsb/gFZsKUwFsGk1XDf9gtDxaWeSguHDVdQeDQUeX99olLMzdtXpS1wG7GmLjSKmGx9SoBs5bWQ+dermb/Sd35iK4TN9N2FCr3Uflz2XQZdenX+0wjLRoPQAMl2tGn5Mk5WZjNH+0alnJd0SnyFX6k/MgpGjqdie8g8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFFA7imQc2KpMM0GpAwts6DflnOl/2JTTizJggAM3ec=;
 b=T4ul8Dp2pSkv3ODLsp0B+GDUXu97dCcLEr2H1ZcYXAN/+ASoPmRxsowF6xv3hFNKUaJKuVz5fiF5sj+tKIzNN3L/S+AaDyVFxVkiozWQCKNu2NelY4D62rkLuvsETetkSBYfiQclVl9bsSl5ezMGHtsm35p0rPx/mFfQfheyVwFleqOVIAX0HCEeIgJZdgkw++eXrouDdJX+az2Ydu7SPa7d3MGsgq5p4DB85/MegOGIFaP4JWfySFKQPFTWe2P+406Qp6Lprjx7AaBoiVG2VSvonaBnRkHUWQr+DGGkNTaW1tG/4kY83dzxahKKU+2hGPxKvSUV9VDZoXpxfaO23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFFA7imQc2KpMM0GpAwts6DflnOl/2JTTizJggAM3ec=;
 b=da3FGXya68/v2oSCU5JeCTzXTsqoBw9Zo8XtjjjuwxwwHYhSx9idOAf4r3DMNQtagsxomYxpExpnGhnLe/oU/plJ8/BqCqFnnweU24tdhvK2Ggq5h6lb8VfPjM5oD0g4q/XvHZAUJJZ3s0g7R81+J+Be5CuMfhPZWABClrblICU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 23:22:11 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:22:11 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v3 3/3] tools: perf: support .gnu_debugdata for symbols
Date: Fri,  7 Mar 2025 15:22:03 -0800
Message-ID: <20250307232206.2102440-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
References: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 250c7af5-02da-4e6a-1b1a-08dd5dcee328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Moy1E0bFc2ISFZ2bmCx18wz43fk4ors4u03+fBYlZGTiHLsijm/ST+Hj9JSg?=
 =?us-ascii?Q?2nuDMgCJ775BTQ2InGloApTEZ3O8Y5EOwLONS5YK9ySM6oO7IikN3xP4gbjc?=
 =?us-ascii?Q?1z3DBywwhUfvyhAl3WfiQ3JEzRRHtic+1PO6wvcrmyPtMGTlL6b/9iy7K1dU?=
 =?us-ascii?Q?EDWSroI0dYjFgibMXNE1jLHq6+1EywAk2r4c+PdyQ6eltwWEBffWMGN7Pm9v?=
 =?us-ascii?Q?TeCNAldg0gYiQ9NgMf4KC3kWsIovhh8JwSi16oGrNf9ZWF32MVl6L1bkn0SJ?=
 =?us-ascii?Q?afAKvuJBL3TCO3xi380KIU+ope+JG03cgCRinmYSEQPEE8O8BItB+e+mNL6z?=
 =?us-ascii?Q?Io7/sh3YYqI2yzLgZMjh68nBttbKqMflUUUTedQCDoMj3hhHavoyTVMOOLKV?=
 =?us-ascii?Q?rZPpSJrwFwWEIc2GfFUxHzZ7nz/fD5xuD6mN6+6A++zYH3BYm7IDo2vWjgT2?=
 =?us-ascii?Q?LLu6ccplBoLvtyofbMk8kTkL7a726vfZ/l/xVHWSicumd30CXcp8uvI/41T2?=
 =?us-ascii?Q?+tlRWSKsvN2HAzI+YlRpoJS2PWrBHnpK9KDaiMWO3orEYhy32+USYxkogcdp?=
 =?us-ascii?Q?kGxKJ3kcxy9eUvS3zz2D3bQ200YOOBZZGZAgrpYg9Ys4LQw4KU7B3tutmF57?=
 =?us-ascii?Q?CTWstVJWwvegyKl0nyqQjHExGTVxyrC6jzeBNC5u6E/Ot0hYBvo99bgqqwmG?=
 =?us-ascii?Q?g9f4i6lDxQdBlHB0XTSmZ0+554bcrVyWbxp7jPiO0X6FNmuZhS3cx3eZFl0Q?=
 =?us-ascii?Q?rapMqBMKin3tG/wWXd54n1tCI1dyjVecH8+qAgfGz7V0YrkjwYQCioUT3Oje?=
 =?us-ascii?Q?x0hlkkt/hiMGDmQhg2n0ETVO3HXdfk19SoWofvS7mnZfpN11HlNonBpQoSqw?=
 =?us-ascii?Q?nIxajfa8ox/x/SVQTZMtJ5mpnNDArQqiCbVh4P0a7fpOINO5hfm5eqdkRyGj?=
 =?us-ascii?Q?DOtjYyPrz2ve/QY9Z3u8RPZT2CbgTWmtRUC7qiMV0WiVdXOoeuf24ASu/tkS?=
 =?us-ascii?Q?wxZyCrIp5F0ZVNoU5On5ZjZWah42TQwtoPjbjnJJKoF7s7JVU62F/sd57e/y?=
 =?us-ascii?Q?hjVeKuD7WM4MtwCXNJm+M98lPCuQw+VrLtr3BdqyeJmmxYd8Tb4Zohy5sBio?=
 =?us-ascii?Q?p/SNtVI80XfphyT6LCyKHovt3+t/f73XH7hcGZZJgCLDYjzJ+2eBegmd0lkf?=
 =?us-ascii?Q?5t5P6WgfiOdWAaCvbc1GeNttRdq2kCn6vwueD8N2OmLdhfOFMarOBMyk8QuF?=
 =?us-ascii?Q?bWPNqLj8d3a5WlHn3GAlrtY0bUuyvz/mn+Q0tngfphoTLjXPPj1qjfCMH1KD?=
 =?us-ascii?Q?MHHkumS7KnDl2C3Xwt7GUiFIqigd2P/eO9Z0DI5KBAQl2268GSXfb0t+hsXU?=
 =?us-ascii?Q?LoV9xsxT90dknziLZi7hSEOP1VUr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+C/EmTaz0ZSXz9WZCf3vXwuNRwM0vhGTyNeEuN0tgtRMvwHLqIOIPKTrwgru?=
 =?us-ascii?Q?gsXYh1zEfY2fLY5eOc1i983Dh0liTNrIcC8Cw/8VH7UGTjLDni1YJ5/tONjs?=
 =?us-ascii?Q?uJ1QXcjq8LKp/JRgm8QGMq8Xd8MYD1vfKz37c1sfBEqENOEcMjdnlQAMiyPY?=
 =?us-ascii?Q?U99yi6ciqjZhSTOZ9wcu8GSgDPisgkhEn6Hq5wcYxRv6weI8++B/MKtGrQ5Y?=
 =?us-ascii?Q?AnBcfpV/kDCYXr8gJUW6wQPapECOrBH2cWOjz1EiKsqF1NhsBzbq7y4sBe+e?=
 =?us-ascii?Q?fBDnNlyvuQDVmFWuQBINWJQyhXSdgLdbm4B0IMt3H0u8DVGVONuAHDLpIj2+?=
 =?us-ascii?Q?qzf2C+DEe7tjFYHTDQ9jwXrZ8q81lJZPm2XtrwWcfTjbznK7shpXdeBGWS72?=
 =?us-ascii?Q?dVEXApoCQlEwS6Fbd+2n6jIoJAoaUxMo1+tIpec02o8Un3EiRUYMZMfFeJpH?=
 =?us-ascii?Q?4odpVRLC4vmd1UqHc5yG38hhjlxxWLh1ZBrLhlnJok2UbIxakpaIOx2s+ATi?=
 =?us-ascii?Q?F8nj1Y/eW5M9iSJQGfMbm0CSQtebGyyQ93ai1dWTcduaNPNNiGC0vo27bi7U?=
 =?us-ascii?Q?kqr/YQkYWdX0NRZ266WWu5B7Gldc8dlNAma6X6LTac0XZb4lR/UodeNdZ04/?=
 =?us-ascii?Q?POyf/2KQ5IP4eJG2RKGoDiCPFkmOgsL+MNedlaaC/oj9ApLudoCr82zQlUWE?=
 =?us-ascii?Q?hNZHerWHQ3LhGN+KOMUvPmkPkGILEkLfe6VyJm2ADBfFrQwxvnEMzRkLYyIC?=
 =?us-ascii?Q?MWsxaBNLOXninHNyNN3pdTRCWMHzkRBVPos8wxmVpDjGd33m0dnua6345fyE?=
 =?us-ascii?Q?X3Pd+Atcc/OPkxSbOhElY/5g9nbgi7bM1+nbo1kDIucejTxVUdcRDFzfcIba?=
 =?us-ascii?Q?uxKq+Ts4WQKU9QDj35yLZVEK6wS6whE+cvQ7F+tI1/y5L82Jhb0V4tv0vaR6?=
 =?us-ascii?Q?QAlmp5wrIgumo1nlsTvohQFOX9fOTSOP3P3+u35h2bhh/ye58NfWD/zP36T6?=
 =?us-ascii?Q?TaVaHleL0Cw7FGgOCYIcw70LOO+sUbZ4huz3aX4uWbYfGXVsMB4c1/SuUZRE?=
 =?us-ascii?Q?reL9/LNCnJiGI0OJPUfA2CuZgURzW7Oy0c0/dObs94xMSgdb/622RbWy8ueM?=
 =?us-ascii?Q?Lc4kyazD3fEqvgXUYs/IBfukolSmPRkL+B0laOYn3I2UemCypWKxA/XE8w+0?=
 =?us-ascii?Q?9RI49m039v8tRNJwLavPUF7VVuEBU3azIoq8N6K1JuuxKfyOh2/mkyICCUNj?=
 =?us-ascii?Q?tUNMBPC4N/VJo5liRzYM+ksYGaRScTiYTpv5gHQVmimEjN9pxjuSMUHexm/p?=
 =?us-ascii?Q?EX/aZ5k9VDBuqVSEsiQ43uuivQveS6A8L8hzv/jVmXaBku6UBLgzHpNC1IGi?=
 =?us-ascii?Q?iyS6ErRKSVexfr5sL2P7OxUM90YjQAwdi0HxPz1tyunYDqzVRv7HVhTV4Bjx?=
 =?us-ascii?Q?qhSDOgZRRNBNu6NIIxo2OBXf1l+mCc9jCVTtPsTf/ogGTkmK8NraddPUyFfz?=
 =?us-ascii?Q?TkyS+RmwyhREgm3rhIBVptk55DDFCY+WsuqnR5xrl+hrznHZOAlD1OIM7kgf?=
 =?us-ascii?Q?PLpiKLXCeeYMeVesl6t+TeZhZh6tFlxiZRLo6YsMkHV2YXbuyU3U2xU2rhV4?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7oLvPCXXoJrMxO7RQU8uCIuWg+lfE1Gq3j5bokuSDhCI1M7RhLE6QACrYSJrxBuQc6bEzlXlg3d5y2q43wasdfdDiDR7ogLQOyE5x0IFanq1yx4vqELHlh3Z46F71yUSO/zdqWnWKXp7ns7GqNn08+4Ctip/c4UFYhv+136XDKwAgl6WtuClwvcCiZers6te+nVul/r7gMzNnSccmVTuY6HSRM46ImYwcYm9IaVQPdh+fPMgqFQMStH8EMTUwLftEHXboUYeZGv1fUhQ4f8HAaY+1T7Q7eaBp/+2Q+L21ltBfhKloRaUTxDWWEn/pLs7PPO0xB6l5ufKRaFySa4HnChVKqTL8F9r/a1sIe5bVHyExjMOIR1PeX+kT3GIHmcct2+UnPzQLUZ7G+zhj5gEajKPjiR45Flo8LgFRRrzMPeWJ8/AF4C8FktAHrVeuHKdB8MNMBqvGVphXD4WfXyXeYDdg8oOYvSGhmp/9sRVt1x43TKx7u+tMO4jdB9nUt9tJVWe/o2pSkvw5Q4vJPlJw7V/K/nAH97VwkXCoK59vufwONh9C61LmHJIP0Bo2eXcbN6NrnPvEmrzntgHKtLi1rTL+fcSBd90RbLKCNdylLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250c7af5-02da-4e6a-1b1a-08dd5dcee328
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:22:11.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Orvbkk3Kd1aINN7Cn4tR0lH5icLmhJ9t06nvDIw0T1fRl9Ar3iE25SZVPfjGQjfau7ybDoBu5umDg+KrkWplbBbWyVlOq0VFl8zoRzaVN4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503070173
X-Proofpoint-ORIG-GUID: Q-Gk7uSAFeTC2YUjmlXeZsbqtiVHMYl5
X-Proofpoint-GUID: Q-Gk7uSAFeTC2YUjmlXeZsbqtiVHMYl5

Fedora introduced a "MiniDebuginfo" feature, in which an LZMA-compressed
ELF file is placed inside a section named ".gnu_debugdata". This file
contains nothing but a symbol table, which can be used to supplement the
.dynsym section which only contains required symbols for runtime.

It is supported by GDB for stack traces, but it should be useful for
tracing as well. Implement support for loading symbols from
.gnu_debugdata.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/dso.c        |   3 +
 tools/perf/util/dso.h        |   1 +
 tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.c     |   2 +
 4 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5c6e85fdae0de..7576e8e248386 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -67,6 +67,7 @@ char dso__symtab_origin(const struct dso *dso)
 		[DSO_BINARY_TYPE__GUEST_KMODULE]		= 'G',
 		[DSO_BINARY_TYPE__GUEST_KMODULE_COMP]		= 'M',
 		[DSO_BINARY_TYPE__GUEST_VMLINUX]		= 'V',
+		[DSO_BINARY_TYPE__GNU_DEBUGDATA]		= 'n',
 	};
 
 	if (dso == NULL || dso__symtab_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
@@ -93,6 +94,7 @@ bool dso__is_object_file(const struct dso *dso)
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
 	case DSO_BINARY_TYPE__GUEST_KMODULE:
 	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
@@ -224,6 +226,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__VMLINUX:
 	case DSO_BINARY_TYPE__GUEST_VMLINUX:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 		__symbol__join_symfs(filename, size, dso__long_name(dso));
 		break;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb8e8f444054d..84d5aac666aa1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -33,6 +33,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__GNU_DEBUGDATA,
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 	DSO_BINARY_TYPE__GUEST_KMODULE,
 	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66fd1249660a3..3fa92697c457b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
+#include "compress.h"
 #include "dso.h"
 #include "map.h"
 #include "maps.h"
@@ -1228,6 +1229,81 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 	       ehdr.e_type == ET_DYN;
 }
 
+static Elf *read_gnu_debugdata(struct dso *dso, Elf *elf, const char *name, int *fd_ret)
+{
+	Elf *elf_embedded;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	Elf_Scn *scn;
+	Elf_Data *scn_data;
+	FILE *wrapped;
+	size_t shndx;
+	char temp_filename[] = "/tmp/perf.gnu_debugdata.elf.XXXXXX";
+	int ret, temp_fd;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL) {
+		pr_debug("%s: cannot read %s ELF file.\n", __func__, name);
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		return NULL;
+	}
+
+	scn = elf_section_by_name(elf, &ehdr, &shdr, ".gnu_debugdata", &shndx);
+	if (!scn) {
+		*dso__load_errno(dso) = -ENOENT;
+		return NULL;
+	}
+
+	if (shdr.sh_type == SHT_NOBITS) {
+		pr_debug("%s: .gnu_debugdata of ELF file %s has no data.\n", __func__, name);
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		return NULL;
+	}
+
+	scn_data = elf_rawdata(scn, NULL);
+	if (!scn_data) {
+		pr_debug("%s: error reading .gnu_debugdata of %s: %s\n", __func__,
+			 name, elf_errmsg(-1));
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		return NULL;
+	}
+
+	wrapped = fmemopen(scn_data->d_buf, scn_data->d_size, "r");
+	if (!wrapped) {
+		pr_debug("%s: fmemopen: %s\n", __func__, strerror(errno));
+		*dso__load_errno(dso) = -errno;
+		return NULL;
+	}
+
+	temp_fd = mkstemp(temp_filename);
+	if (temp_fd < 0) {
+		pr_debug("%s: mkstemp: %s\n", __func__, strerror(errno));
+		*dso__load_errno(dso) = -errno;
+		fclose(wrapped);
+		return NULL;
+	}
+	unlink(temp_filename);
+
+	ret = lzma_decompress_stream_to_file(wrapped, temp_fd);
+	fclose(wrapped);
+	if (ret < 0) {
+		*dso__load_errno(dso) = -errno;
+		close(temp_fd);
+		return NULL;
+	}
+
+	elf_embedded = elf_begin(temp_fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (!elf_embedded) {
+		pr_debug("%s: error reading .gnu_debugdata of %s: %s\n", __func__,
+			 name, elf_errmsg(-1));
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		close(temp_fd);
+		return NULL;
+	}
+	pr_debug("%s: using .gnu_debugdata of %s\n", __func__, name);
+	*fd_ret = temp_fd;
+	return elf_embedded;
+}
+
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		 enum dso_binary_type type)
 {
@@ -1256,6 +1332,19 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		goto out_close;
 	}
 
+	if (type == DSO_BINARY_TYPE__GNU_DEBUGDATA) {
+		int new_fd;
+		Elf *embedded = read_gnu_debugdata(dso, elf, name, &new_fd);
+
+		if (!embedded)
+			goto out_close;
+
+		elf_end(elf);
+		close(fd);
+		fd = new_fd;
+		elf = embedded;
+	}
+
 	if (gelf_getehdr(elf, &ehdr) == NULL) {
 		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
 		pr_debug("%s: cannot get elf header.\n", __func__);
@@ -1854,10 +1943,23 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 					     kmodule, 1);
 		if (err < 0)
 			return err;
-		err += nr;
+		nr += err;
 	}
 
-	return err;
+	/*
+	 * The .gnu_debugdata is a special situation: it contains a symbol
+	 * table, but the runtime file may also contain dynsym entries which are
+	 * not present there. We need to load both.
+	 */
+	if (syms_ss->type == DSO_BINARY_TYPE__GNU_DEBUGDATA && runtime_ss->dynsym) {
+		err = dso__load_sym_internal(dso, map, runtime_ss, runtime_ss,
+					     kmodule, 1);
+		if (err < 0)
+			return err;
+		nr += err;
+	}
+
+	return nr;
 }
 
 static int elf_read_maps(Elf *elf, bool exe, mapfn_t mapfn, void *data)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 49b08adc6ee34..a0767762d4d73 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -84,6 +84,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__GNU_DEBUGDATA,
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 	DSO_BINARY_TYPE__GUEST_KMODULE,
 	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
@@ -1716,6 +1717,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 		return !kmod && dso__kernel(dso) == DSO_SPACE__USER;
 
 	case DSO_BINARY_TYPE__KALLSYMS:
-- 
2.43.5

