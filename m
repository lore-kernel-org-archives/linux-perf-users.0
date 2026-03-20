Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF59317159;
	Fri, 20 Mar 2026 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044525; cv=fail; b=YD45xjmwBNFCSWw6HonXtQUR1gxvdm49SG+OSryPTrFd4mgCbV0r4g5KS53Uus/kgiLFf0Pl+kNlQnxYbieEuJOWwYmvuNwE4hsFtu9PJE2b9c7T+N5yqWnAEsCD+IFJSPTalVyAack91+z6yQa/H+yFv7Zzg9xpX7MCw4d3Crw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044525; c=relaxed/simple;
	bh=b5Gyk6sb9I+vDOCbZY+b1CdpaT3ym3GtfYcFd4p7rMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFuYYclK8+yIZpOP/iOnGQm6SV+S8KnVqhhK1cN+jMuR5KPi5ZIZO6VALbHcEUqEII7IWeaiogXHrG7p1H/uwYPQXRfsDfZ4YrXp0aZWpZOhu5CSC99xfF0PHN0PNfdVDF37n0kVoqPgTbP5Yt11V49B3Xq1b2AC/+vAeI6dCqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PHu9E86w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCqL9/+y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHu9E86w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCqL9/+y"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KIUnUv3323103;
	Fri, 20 Mar 2026 22:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qyhesEaUG2wbFovjsuLrkCuzaf5CT4YPPYwrZf7n1Pk=; b=
	PHu9E86wCrwR1hs647Qg0HQRcRoMweTwWi8rFH8q0A25PWUCZsOq1+cRG4VKb/lB
	YIQNIeI26OlASwZ5/EmnSqjbKUSho+akaix4SX7ZcvhFxZtmBbc2LiikguIEghYK
	BjSu/LDU86ex8i2LsoSZtrOX7VIZzbrgSgZP8BpqfOodlh62c+Pb+sqVkswB0Li5
	rrBzAK8I2MZPhPUTzXO5KiWKPJsmWSSAKxxFoyGYEEPPNiF8ewCSt0oYW+y7k8pl
	C7b7dbRCCELDOf8wSO7xZwXJgKo5PlGUi8UGpCgGg8pDfaA3BNEG/Ibym1oe/rMV
	L1s1VLo5TvvwNamLgEKIog==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8jgcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 22:08:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KKFto7031293;
	Fri, 20 Mar 2026 22:07:15 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4eshp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 22:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCzjadP0hC2J02yT9tdf5fktqCc/sqWVHuHt2TfjpxvpaeAgI7Y6YGbiOk9K89pfVz49bdm5uI+sbCCamwvL+haU80C/oITewRskKUhXMgAqAuVdEvz36YUeryT/cvJEySgslmka7PBpPq+Z6BVMsv/8zQRhE7ws2zRAMVW/v23DmzTcdLzteue0B/8aL3V8JBGko0Zt5+RhlORqEe7tI+S2mUqQT7kMGexylMF4KJnQPY5pDQjKIcjcNv3vcbMPlwS0fkuU+rBrOnUOGAfUIxXYA/UKJmBHTOKyeuyLgNXKJAiLLAzKdT/eWkeV+z70qP9pzd+EF5KWjp6Ib7okuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyhesEaUG2wbFovjsuLrkCuzaf5CT4YPPYwrZf7n1Pk=;
 b=DVFsBF+DVN5DDMzmPVVr64YNm7BhKTyduqzoMlQABCGWTENqRjA4A6eUoQWGdPiygOGkNcpjTQHCjdzod3gNK1Iif4WnmDPm0N9NyT/jCX4blIu45dCA/vJRztSmq2XErzdiHKExevaaMtsz7DI5diq3KD1/UAX/Q5lgLEWVj7CFg3HnJkqTjJAUHGVSlIeTOtqwRPxM64vTWReGpRmnQ6dWtH8nYSsZjd3kkJH6JbJcbmql9q1JDx1I3oLmKVPBDnuRtirF83wZyT6OqwG6aNnEujPn0A5/JDQqKuD2NQpU/ByiGNOr5BD+ZeHyuRKE+7APBlqf+BhDBoYtIk3VkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyhesEaUG2wbFovjsuLrkCuzaf5CT4YPPYwrZf7n1Pk=;
 b=cCqL9/+yT68C7OVgXbED1Xjb4i1twUrzH9FVsM05XhhZMqrjdj6kApd/QfQvOC2/1hZNV9fTfc4VOge4pX1tvkVn0X6s+QJf3Nyp3dkvi1ssIsJU5haTUJLxmHytNE9FrAIRzAYY62XEX7Ed7+OqMekKCGdto+y//0jbEHThH+c=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 22:07:11 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 22:07:11 +0000
Message-ID: <20104c5f-f22c-4980-84c9-22c97c0a1c2d@oracle.com>
Date: Fri, 20 Mar 2026 15:07:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: perf: add comm_ignore_digit column
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ricky Ringler <ricky.ringler@proton.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Tianyou Li <tianyou.li@intel.com>,
        James Clark <james.clark@linaro.org>
References: <20260316175631.3169955-1-stephen.s.brennan@oracle.com>
 <CAP-5=fWFrDaG7dCT2AcEAu28aAPKz6qMtpzmrG+4-vn1NLQ--Q@mail.gmail.com>
 <abxqz93jZSWcfdt8@google.com>
Content-Language: en-US
From: Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <abxqz93jZSWcfdt8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|SA2PR10MB4665:EE_
X-MS-Office365-Filtering-Correlation-Id: 896aa818-7611-453c-9e55-08de86cd092f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003|83080400003;
X-Microsoft-Antispam-Message-Info:
	jVn8gudkC08G7MeIYVX0Mg3lgyeifW8WasenqIM9kFeOfCmTdTjdsED3DPSz5L3VK3zH9y5DnnGAc6ryIE3EoFQQiC6rQGDZtxD0NuTHDMY0cnYzaj5nxuMIeI8jJi5Tf5AqtDxbC5/gmXzB26kEPzF+yzPP0WXwWMXDwNg+oYQrR95n+f5tusdlRFesM3/KaUspQwkz7SQrdBULoYhLrAl1b01CZ6plU/AdTXjQ5yhoXN3T+r3PH6+5TI/snEdxRqjN2tFkHHAUMMPFQWgLRwwQ/OC3y6zPep2oA9Vh29Eoj3DjXAnHBzWYeFPG9topyvGxm8lUL0KUIb3b3s0xPdrXKFO7Qt3d+zbK4RnxM/7+QlrLMnwWzDLZjNxxdjBUg57lc0955oCuXIhpWvmZxUg0OmvRRZ5nAczzYWvUeFU7/XP1hXm9YSAzgGZAEAbaC0wTzOcsi3Cz14nPiVNqwsv3fAkhyEj/IYq1ruTP4U7mhGDcyuAJDt0rI6oIEjlDO/AqqCjVFBlfW1R0HmzojSftiCgKu/q0+9+CaNu/aCPE6fs1a678wM+COqlWQyfKod1CclvU93qfoO6u1D4IzH3L1/K1MSIzKMw273eI/SusViE0zOVJjd7cGe6tqoKTEZgihmhgIYh0UjFWdHxFa6OSFmL2IEgylfkcbb/kDGcvyxnBN3oARQn4/7OIdf2DYe0PowJsXKqi5EBjrgJwFmATDjG9tPn+HiOEh424crIAxtJonbsLUWiwtu5vM1wf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(83080400003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0hjMXoyWDBkWSt0MDhUTGNvY2hVNzJ3cTA1M3JBUjVwcFpSZytPek1YK0RM?=
 =?utf-8?B?WWRCajdHZWJrRGZGeUt2T2RHUnRCTG54WUVTUEE5cFFOeWtaazhXYUR6YTdJ?=
 =?utf-8?B?d3VmRzNFNS9LOG90RTkvb2FBNUxuMmsyeVBYQ2haMTR5cHlnY0pnendIbkNH?=
 =?utf-8?B?YWc4Y2FycWN5SUdWMlZIdXdLRm43bWNOWWRCY0VQZkowWGZLRVdKbmlEYitH?=
 =?utf-8?B?YzdGQlhSY25qbG5rSk1iUlRtVXNpQndBODlXVENXUG1IN1JITDFDckJmS2ZM?=
 =?utf-8?B?NkFjN2V4Ymg4TVVRQ2JxSkc4aDU4Q3ZXYjloTUo5V2wzM21vY3NkNk1oaEYz?=
 =?utf-8?B?akpwVyt3eEFWSUIyUHJMVXRRaDlqUFZsM3hMOU0rc09qZmNTWnRodGpQajFL?=
 =?utf-8?B?TFpJdHpaeXJ0anM3b212a243Kzd2S3Z2R3luMElJeUh4dk9VeEJOL05ibnN3?=
 =?utf-8?B?S09CbGNPcDVwQmp3NmFVSFMrYWdRQzZyM2lCREFpSHl0NGc4eWFPcFV6Qkxz?=
 =?utf-8?B?VHh0MkxCVnU4d09CV2hrcXhDV2tGNVBvOGExYWd3NGF5VVdCZXRNbTdmaWRq?=
 =?utf-8?B?eFVpU2Q0TlkxMGJ5NlZtLzVUY3ZzOW9KUXRjcjYxSlJlSjhhOEFReGVWQU9h?=
 =?utf-8?B?U1dFWXl5am5XckV2ZEw1dlhyTkVvS3ZlYzBhQ0hZTWNFS2ZkRW1XaUd5THNG?=
 =?utf-8?B?djc4TU5zZUdBRzhBSndmU2o2Z0RhazZPMzBETDFlQkhpWkR6Y1ZjRUpua3VQ?=
 =?utf-8?B?WGxVZ1FtRC94VWkxRXpYMHhpY3NVTVVqdEREZkxWTTNTVVFnKzI1d1IxWXcz?=
 =?utf-8?B?RU15c1UzRTNHb2NPSXFyVEZFN1g5b3RZaU54VmFCNE1OV3BCSHh3cjBHcWs4?=
 =?utf-8?B?Q25SWmNOdTZEWWdZNVVNa2lQKzRJeWFCN3lFM2Q1MFlOZWtPRllnb1YwU1ls?=
 =?utf-8?B?Zmh4aldheHgxM3RMWmJ3OFd6eDJlT1lTZDVzTXB6TklmUGRoNWZKZmxJdm5W?=
 =?utf-8?B?bjkzOWtGU1VHT29WcytrR2xDVUg3bDNUY25IMTFkVCtFeDdBSzNEUkg4d21N?=
 =?utf-8?B?R1B4NkFlelZqK3JRL1lLM005Vzh3TVdJWkpNYzIwcEZ4QWo2Nkk4V2UyWFBw?=
 =?utf-8?B?Z1Bwc3NUL0kvVEVDU1FFanhYMnZ0Y0Z6Qmo4ZUVaQTY2VzBpNU1uZ1lxWWlZ?=
 =?utf-8?B?QkVQb1BXNC9VQXg5T1U5V0FXS3ZVTW52QnVaNnZPVm5tVDF4dkRBL1dQeUhi?=
 =?utf-8?B?eWFSVzBoRWkrUzI2R0U1WnZ2S2ZzNGZxT29LUkIvV1pHUkJYR1pLenRNN1pF?=
 =?utf-8?B?K2ZnaWZNd3pSYVdDbkVoaEo2UmhTTzB3a2JFRmdiYXRUdHJuZW8xSXBHVGVZ?=
 =?utf-8?B?L2RXMVNQZkFIZWlqY2hDQnNNeGQ3YXh6MFdjMldXajB2b2EzaEppeHVYR21s?=
 =?utf-8?B?R3FTZlhTeFVla2F6SnQ2dDVLd2F6OHcwdk0zVHZVa0Z6cHZSM1NuSXZKdzNB?=
 =?utf-8?B?ckYxWmNLRGQ0cWo0bTlSbTJIUW1uVVdGTStZcHBvQndSNGZUZkNqNHJVaVQy?=
 =?utf-8?B?MmU0ZnBRdWxxZGU1cnpCUEtVbWFZTXp0N1dHOHZZenMzMjFiTEQ0V1lqeTc5?=
 =?utf-8?B?S2pmeDFEdjlMMzV4OGx1NlBnS0JHM0F4TXp2czY5cXcvNzVJK3daRFJRWTI2?=
 =?utf-8?B?ZVhKY3BoemdoR2JQY2twL2Rva2dFVVlldlFFNGZNVkxPVElIaGxTQ1g0ZG9D?=
 =?utf-8?B?aktzMTJBUm9YMjNvT0k4TEIvSU9uSTNQOXVIdllVNVAxZDd0M1RoVFhERFZQ?=
 =?utf-8?B?M3hLTG55bE5JdVd3OUxBM0gxeTQvN29mWXZ6QjVmRFFNc09SREVqUkxpU2kx?=
 =?utf-8?B?WjRvbGlZQ1VtOXlkdHpudlE2SDJxMTlnc0ljdU1MaUpuSThSQVNURXp6SDUx?=
 =?utf-8?B?ZzhubXBVcUk5T3VhTjY4VGhnVnBNbEtzeXdhM2UvdjdSVWFCc1lheThFcG5s?=
 =?utf-8?B?QW4rcW5hdFJQL0oyaituTVRoUC9hMGRSUXZ3OG0xTjNoME92LzJpbGU4OHEv?=
 =?utf-8?B?ckQrdDNYKy9HZjlFTm5mN1czVzB5Vi9VbisrN01hQmswMm9YWkFoaE0zdFE1?=
 =?utf-8?B?bjE3UGprT2VQQXltM0ZxblNYc1g5b3ZQN1BuOWh4K3ZLQ2FBbDBsd3R0dDJm?=
 =?utf-8?B?eTltdlZ3b2w0OThUMEpCV2VBNm9HUXpVQWZMbExSbVRHQ2FtZ0RYM1JvTXJ6?=
 =?utf-8?B?V1pMelBZc2FDVXZYdlBkUG9Db21MaDlYOWFlKzJlL1lCeFF4Qm5lQ1c5S3Rs?=
 =?utf-8?B?Yy9sbTRGRko1Y1p5MTdSSUxHQUZucnZhNW1Ld3BxUnJBajJ0SGNXUFJyNURK?=
 =?utf-8?Q?gnkJ4l6NSUSUMJIw=3D?=
X-Exchange-RoutingPolicyChecked:
	di+V6pyO2iUuMWejRJqWtSjIBdaeO8czQHr4thQGp3Y/hDpG65I8Cy/Uvfpk6viojwkoaxHzKzudL4rfzmoSvpS5ou/umkZZWnGu+vRkGhfneDLIMNIsoA9+G8/fHpf+urpqiHFYt681H7VilIacKHDDv/EfQZXwySu1Z8iQ5Y6FiG+l8eXhuP/zzBkKtmycmRyAqa42BIL8mq+f5NJEI9dUOipnubVOYheq4M0z52td1gN7/1SDo8B4/jbGE+WR7urSqB/yeVipjtIwiFT0akdVG76nKopkvocPQag2j/HhI8wh3o7iYLaJ4d+/mr1Wx/HRR4lkMh4QCQtb3sTv1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mnoDKoI7dK3X/dYZG/Ag59hSGK823z3ytI8q59SOC0w/NVftFB7AGzPg4LlziSNFbaoApXUspbe+O3tMTxlZXrEq8515DvXVGz5/mHi6xnxAfu/viylPIeg2nVnFz4Re61Bd5f7arE3ZJKjx3u99mA3FHKftO7fwtTXJf3gNmjVZSgd6B/JQ9USEfAvCKgEpKHeiaPxaHmXBF6qRH6G5G8M4Ixhbj+Npv5FwdaZp8f94AwDkCyohYyJDbOfke2Vh0O6bKEk6EtUVryrjMzLgzZiqRJhFk8LjPuG1uesb2g0x0GQ4Ca2vRD11w1qKchRNhByJctvmdh3wLxAltUs+EP7yu1Fbp0p4Eudk/SFy2/Sv8MS7udVPJPGgSeQlAalSSanZ9bVCqroQI1hz88lOVhHznJRBQK9/gwcvqcxUfQQd26zxAO6bxsnWbHm0+vr0/BxPhH1SWyG21ztEBiorrjQWRJWa0zzr6ZxwLH9h8t/ITGb69pRYPlP2dqCxw49BQ10LnYwDpPxRluQwsZ/cTxVL7RHpzuHTVunwMGYCzfEsJgum5vsvD+wxOeD7bMhvgg/XEBcahbz2dRIiI5vta948OWDXQQvIu8A1NzFuruQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896aa818-7611-453c-9e55-08de86cd092f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 22:07:11.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9HvREIxFDCa6+a5WEXYlzldYDOLWYD38cI5s7tQttre8j+lyxYT+5M6fgq9wtfcS7BSm5JC/H8VuX9YJeE+QkIKp1yP5ebgJ8sjWjcRyJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE4MSBTYWx0ZWRfXyfJ8VO9LXmDx
 +2kB4XG2+YW98rAWKXhf1W666YKVDevF+/Yn/EChvTsOgNkqF58Ig11MRzuGQ1qMqsdEzc9UlHC
 hNlcaOyZFNKmmfa+wXwMfkCgJ3E2j6UdDNQ6ySw4m4GaWbbT6+mYODPJYQURhJeo6uOvReMr8Nd
 MxRL5lwDYWKAdlTeTk6hHyblZquv1gsaBQmV6GuPll40aYL+94dOENZwZpPo66CFA/GmBLpRgN4
 JH6z5yz/iK7aC4WolQ76WSgf92B2fezyX4E/C/XFRu8NGM4mmbK18ZdtGboelRqTEn8sXphGFIJ
 7WuC8eH95psS5ef9ask3x22JwNfRZlnrBQMewW20p1xoID/WQkq1D9W9SnKmVv/PqmB+b9bhf/j
 nBVFoT9/HZR1v9hc41HJvGkLG8yb+5nlbZl5ZCwBHoZBBAWmXL0GQteJlDVeoGcnexkd+OAdIwx
 lHF+C51poZjVWPJQGvg==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69bdc54f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=6gleDtDc1OYGXnTfaH4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: j7FxljDQipDq2Mbpyna91zHXT1E7-PfE
X-Proofpoint-ORIG-GUID: j7FxljDQipDq2Mbpyna91zHXT1E7-PfE



On 3/19/26 2:29 PM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Mar 17, 2026 at 09:14:50AM -0700, Ian Rogers wrote:
>> On Mon, Mar 16, 2026 at 10:56 AM Stephen Brennan
>> <stephen.s.brennan@oracle.com> wrote:
>>>
>>> The "comm" column allows grouping events by the process command. It is
>>> intended to group like programs, despite having different PIDs. But some
>>> workloads may adjust their own command, so that a unique identifier
>>> (e.g. a PID or some other numeric value) is part of the command name.
>>> This destroys the utility of "comm", forcing perf to place each unique
>>> process name into its own bucket, which can contribute to a
>>> combinatorial explosion of memory use in perf report.
>>>
>>> Create a less strict version of this column, which ignores digits when
>>> comparing command names. This allows "similar looking" processes to
>>> again be placed in the same bucket.
> 
> Can you please include an example of this change so that others can
> notice what's going on?
> 
> Actually I'm not happy with the name "comm_ignore_digit".  While it's
> intuitive, it would be nice if we have a shorter name.  But maybe we
> can just go with it unless someone has a better idea.

Hi Namhyung,

That's totally fair. Would "comm_nodigit" work for you? It's at least a
bit smaller and still clear. I wouldn't want to do something terribly
abbreviated like "comm_nd" or something, because I don't think it would
be very intuitive for readers unfamiliar with this patch.

Acknowledged on your other points, I'll send an update with these
changes. Worst case we can bikeshed on the name again on that revision :D

Thanks,
Stephen

>>>
>>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>>> ---
>>>
>>> Changes from v1:
>>> - Rebased on linux-tools-next. Resolved conflict with commit cbd41c6d4c26c
>>>   ("perf report: Update sort key state from -F option").
>>>
>>> v1: https://lore.kernel.org/linux-perf-users/20260305181847.3249498-1-stephen.s.brennan@oracle.com/
>>>
>>>  tools/perf/util/hist.c |  1 +
>>>  tools/perf/util/hist.h |  1 +
>>>  tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>>>  tools/perf/util/sort.h |  1 +
>>>  4 files changed, 94 insertions(+), 1 deletion(-)
> 
> Also please update the man page in the Documentation.
> 
>>>
>>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>>> index 7ffaa3d9851b4..a6e566dda3a15 100644
>>> --- a/tools/perf/util/hist.c
>>> +++ b/tools/perf/util/hist.c
>>> @@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>>>         len = thread__comm_len(h->thread);
>>>         if (hists__new_col_len(hists, HISTC_COMM, len))
>>>                 hists__set_col_len(hists, HISTC_THREAD, len + 8);
>>> +       hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
>>
>> Thanks for working on this! Sashiko is noting some nits in its review:
>> https://sashiko.dev/#/patchset/20260316175631.3169955-1-stephen.s.brennan%40oracle.com
>>
>> Because hist_entry__comm_ignore_digit_snprintf() replaces consecutive digits
>> with the 3-character string <N>, the formatted string is often longer than
>> the original string (e.g., a command named worker_1 expands from 8 to 10
>> characters: worker_<N>).
>>
>> Since the snprintf logic strictly bounds the output to the calculated width,
>> will the expanded output be prematurely truncated in reports?
> 
> Right.  You can add perf_hpp_list.comm_ignore_digit field and update it
> the column length properly only if it's set.
> 
> Thanks,
> Namhyung
> 
>>
>>>
>>>         if (h->ms.map) {
>>>                 len = dso__name_len(map__dso(h->ms.map));
>>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>>> index 1d5ea632ca4e1..ae7e98bd9e46d 100644
>>> --- a/tools/perf/util/hist.h
>>> +++ b/tools/perf/util/hist.h
>>> @@ -44,6 +44,7 @@ enum hist_column {
>>>         HISTC_THREAD,
>>>         HISTC_TGID,
>>>         HISTC_COMM,
>>> +       HISTC_COMM_IGNORE_DIGIT,
>>>         HISTC_CGROUP_ID,
>>>         HISTC_CGROUP,
>>>         HISTC_PARENT,
>>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>>> index 42d5cd7ef4e23..45662302ed5ba 100644
>>> --- a/tools/perf/util/sort.c
>>> +++ b/tools/perf/util/sort.c
>>> @@ -1,4 +1,5 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>> +#include <ctype.h>
>>>  #include <errno.h>
>>>  #include <inttypes.h>
>>>  #include <regex.h>
>>> @@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
>>>         .se_width_idx   = HISTC_COMM,
>>>  };
>>>
>>> +/* --sort comm_ignore_digit */
>>> +
>>> +static int64_t strcmp_nodigit(const char *left, const char *right)
>>> +{
>>> +       for (;;) {
>>> +               while (*left && isdigit(*left))
>>> +                       left++;
>>> +               while (*right && isdigit(*right))
>>> +                       right++;
>>> +               if (*left == *right && !*left) {
>>> +                       return 0;
>>> +               } else if (*left == *right) {
>>> +                       left++;
>>> +                       right++;
>>> +               } else {
>>> +                       return (int64_t)*left - (int64_t)*right;
>>> +               }
>>> +       }
>>> +}
>>
>> Sashiko also notes what's below, but I sent out a patch to make all
>> chars unsigned (like the kernel):
>> https://lore.kernel.org/lkml/20260306191908.2065682-1-irogers@google.com/
>> but it has no reviews.
>>
>> Process command strings can contain arbitrary non-ASCII bytes (e.g., UTF-8
>> characters). On architectures where char is signed, these bytes evaluate as
>> negative integers.
>>
>> Passing a negative value (other than EOF) to ctype.h's isdigit() causes
>> undefined behavior. In glibc, it results in an out-of-bounds read on the
>> __ctype_b_loc array, which can lead to a segmentation fault.
>>
>> Additionally, if char is signed, returning (int64_t)*left - (int64_t)*right
>> means non-ASCII characters will mathematically sort before ASCII characters.
>>
>> Does this code need to cast the characters to unsigned char before passing
>> them to isdigit() and subtracting them?
>>
>> Thanks,
>> Ian
>>
>>
>>> +
>>> +static int64_t
>>> +sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
>>> +{
>>> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>>> +}
>>> +
>>> +static int64_t
>>> +sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
>>> +{
>>> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>>> +}
>>> +
>>> +static int64_t
>>> +sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
>>> +{
>>> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>>> +}
>>> +
>>> +static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
>>> +                                               size_t size, unsigned int width)
>>> +{
>>> +       int ret = 0;
>>> +       unsigned int print_len, printed = 0, start = 0, end = 0;
>>> +       bool in_digit;
>>> +       const char *comm = comm__str(he->comm), *print;
>>> +
>>> +       while (printed < width && printed < size && comm[start]) {
>>> +               in_digit = !!isdigit(comm[start]);
>>> +               end = start + 1;
>>> +               while (comm[end] && !!isdigit(comm[end]) == in_digit)
>>> +                       end++;
>>> +               if (in_digit) {
>>> +                       print_len = 3; /* <N> */
>>> +                       print = "<N>";
>>> +               } else {
>>> +                       print_len = end - start;
>>> +                       print = &comm[start];
>>> +               }
>>> +               print_len = min(print_len, width - printed);
>>> +               ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
>>> +                                       print_len, print);
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +               start = end;
>>> +               printed += ret;
>>> +       }
>>> +       /* Pad to width if necessary */
>>> +       if (printed < width && printed < size) {
>>> +               ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
>>> +                                      width - printed, width - printed, "");
>>> +               if (ret < 0)
>>> +                       return ret;
>>> +               printed += ret;
>>> +       }
>>> +       return printed;
>>> +}
>>> +
>>> +struct sort_entry sort_comm_ignore_digit = {
>>> +       .se_header      = "CommandIgnoreDigit",
>>> +       .se_cmp         = sort__comm_ignore_digit_cmp,
>>> +       .se_collapse    = sort__comm_ignore_digit_collapse,
>>> +       .se_sort        = sort__comm_ignore_digit_sort,
>>> +       .se_snprintf    = hist_entry__comm_ignore_digit_snprintf,
>>> +       .se_filter      = hist_entry__thread_filter,
>>> +       .se_width_idx   = HISTC_COMM_IGNORE_DIGIT,
>>> +};
>>> +
>>>  /* --sort dso */
>>>
>>>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
>>> @@ -2583,6 +2671,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>>>         DIM(SORT_PID, "pid", sort_thread),
>>>         DIM(SORT_TGID, "tgid", sort_tgid),
>>>         DIM(SORT_COMM, "comm", sort_comm),
>>> +       DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
>>>         DIM(SORT_DSO, "dso", sort_dso),
>>>         DIM(SORT_SYM, "symbol", sort_sym),
>>>         DIM(SORT_PARENT, "parent", sort_parent),
>>> @@ -3577,7 +3666,7 @@ static int __sort_dimension__update(struct sort_dimension *sd,
>>>                 list->socket = 1;
>>>         } else if (sd->entry == &sort_thread) {
>>>                 list->thread = 1;
>>> -       } else if (sd->entry == &sort_comm) {
>>> +       } else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
>>>                 list->comm = 1;
>>>         } else if (sd->entry == &sort_type_offset) {
>>>                 symbol_conf.annotate_data_member = true;
>>> @@ -4040,6 +4129,7 @@ static bool get_elide(int idx, FILE *output)
>>>         case HISTC_DSO:
>>>                 return __get_elide(symbol_conf.dso_list, "dso", output);
>>>         case HISTC_COMM:
>>> +       case HISTC_COMM_IGNORE_DIGIT:
>>>                 return __get_elide(symbol_conf.comm_list, "comm", output);
>>>         default:
>>>                 break;
>>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>>> index d7787958e06b9..6819934b4d48a 100644
>>> --- a/tools/perf/util/sort.h
>>> +++ b/tools/perf/util/sort.h
>>> @@ -43,6 +43,7 @@ enum sort_type {
>>>         /* common sort keys */
>>>         SORT_PID,
>>>         SORT_COMM,
>>> +       SORT_COMM_IGNORE_DIGIT,
>>>         SORT_DSO,
>>>         SORT_SYM,
>>>         SORT_PARENT,
>>> --
>>> 2.47.3
>>>

