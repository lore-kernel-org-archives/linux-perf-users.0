Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298A3149DF0;
	Tue,  6 Aug 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926223; cv=fail; b=MRMEvyCXaM8eOawm7sbjvFI0NHoqRdAal8wX0HZek2xINkgKVnRP1OlkL2gbyyMouFzcPFSzJFohRsggPmpWb8aLVxHbmNqm4qAZtZ6tKOe+ZzlR9MPEptcqwAGKejuhf9MNDJSplNXPE53p23VganbkY3EGh+Oz1D1T5rs/2NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926223; c=relaxed/simple;
	bh=Nyy2Kq8TfpxVC3EGup7dnTPfvN6bcidcKiFzHHn+ZU4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WdyfMPjlXDWwH3NHJWvcurX2gSobavZ0J/xuST/NG9FRS6qmIyIfQzJEf0zTp+2q3hd3TEzl9X3vgWGsGDsB6/esAa6BYeHbBMIaeWds3C6wO7FXwR01qdI0AcWErI65FCpJr6lTUU5Ax45f2aXBusmeXlUe6kosoRfgxgycn5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=I857BLfl; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Iy0lrAc6; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="I857BLfl";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Iy0lrAc6"
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475Lgubu015460;
	Mon, 5 Aug 2024 23:19:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=Wl+dJeiPrdKn8
	yu72/ZZPdC5Q4l+H07BNyGrIcgVcRI=; b=I857BLfl7wB0znWTG6hGgWgct92iL
	OsFannE0EdzCBtUbQCjUn+kjdM6AriYZ95cdk5RklgFtqp155Flh80mFbt4jP5B5
	U2KYicjTirk/ShbYJWxOD7XLh69KjMlkglPkBKY07t/GowNd0frNZErBnzaCqTL/
	8GBsR8yDHd6xxz/d59eqZxGkUtXBLA2E+dcgUZNOvUP2bzE1RIbm+F2RmTvLlriP
	UDsSPjc43a2+1nHe0hrezfLXTkFeGEfw1MUY7yAmkWbKeEVAqkuCkIFLjsLLkdzz
	60y2tGzEBQXmgKZNnArwNMz4fSSSXAFDPLZSIyqCLQ+I8cIt/H0dCeXhQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40sj36w1s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 23:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nphtYPWyJg6BhkXtgJbr0J2i+DHlM1mHdc7Aknpwwg1+ljsbD3p3jwyw/KxZPYY1vAQRnX6Brkd3IxaO8rsyWymHpLxC8WclrQrkWEmiOkjABR7cJA5fQ167Xjivt16TU2Z0dBQ/HFBfVgmY/M7I964ftZrtWDe7AfcwZI4KkmMGS6OVKWT5DJb/yHXOcylUOwwPNIisQrNY9tc7sniN9EhciKNU+fnclmEYLliAVkOOo3S9oG2rZiL6LCvZuakwEalMcK+jDRz1XyGpYJeZcWaz69TVdH/pn6ZBaUau5H+Iz+nrdaG6GJp1ZMA2/ECCCHEd2zIUqTQtN6eYA3lXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl+dJeiPrdKn8yu72/ZZPdC5Q4l+H07BNyGrIcgVcRI=;
 b=CWBzAQlUT2kIDd4o8xi2r2VRKKDa6VRPnqWrBLcLhb+/azqUzWBA5jHvpovxYOuu08yll21GjW138cj6CfS+iUOwgEsZX4t+mBAvtxQ5KWxVq80u9W7DV09EEr/rFVts7hUhERnnA1WvmCs1/+DRcq9iZFHKFL5IStJLPwCUtuHdOuvByOr5t0UGpMSJgwK6PJZN4wluAFeTDlpre4cBDMRHDUK8v12DntQwMUFxsPQ8NaM4fDNd8wWLxZPivKW+bzsZMiyCrrgW6zaPRAbfQcOu/+zopoSfOpGJJTqj+EJW0zotYAi4MetydXEBdZpe+jpd+h6ZpoiMFypd6U3S8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl+dJeiPrdKn8yu72/ZZPdC5Q4l+H07BNyGrIcgVcRI=;
 b=Iy0lrAc6qVX+ut9HXQBMt57a1YYpGSzE+nor10DhLIUcM7JhcnE4VBYApmrcdXW6zpIyE9RzpgXIpvwT6fAnbzyF7lUtuRFnrYszfXl+b9mTdpQBjw2pFRLLxpC7EDYS21ZGz0DpsRnExKkTrEM7M7StcWtv97C0sfnxQmDasjAn9f8E1FwmpYJZNyVLXogHd05YNY1P/8jqKpMcFwyYpNSUREwgfseEwDFA+ORXsNSqIH+1Qoh+lOplGjO5Db3ymmQK9kYp9SUswC3pa92RtdLJC9Mxmldlw9Tq31rgjPC7FNqZPs98IconEYuRAa+46M34sgRT3qkX6NLfEDHHNg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MN2PR02MB6719.namprd02.prod.outlook.com (2603:10b6:208:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 06:18:59 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:18:58 +0000
From: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@linaro.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with -O0
Date: Tue,  6 Aug 2024 06:17:49 +0000
Message-Id: <20240806061749.143072-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|MN2PR02MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: a35d9db7-371d-4a9f-fbd7-08dcb5dfa83d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HetKKmJ6d2v9NYwmFt1fboxiOoeK6XVoThz+Yr+BxcPWLVOpUsGsOWfT8An/?=
 =?us-ascii?Q?5EPJOuNS/RuMsnYa41j91XWLKzZpHn53bfab4bKRkylQSd00qP9mUq4BqzeW?=
 =?us-ascii?Q?QDxffAq+Z4KAOJny1y82MlUdB+M22j9OmqHxBYu4q7kQNLagxuI+6n6msY11?=
 =?us-ascii?Q?MoIVQft08RxWpHFqUIzCbNN5lM+Bes892p6Kp5SdBkUzu1Y/ZNs3RAJFvc0B?=
 =?us-ascii?Q?fR/GoTUbT5D68R/4UXQbmxylxI2znk32+B8zO52qDM9vq830Cp+6Oik+gUVf?=
 =?us-ascii?Q?V7yo4h2HvFcVXBuucmrc3VVkpCida2W+AwU4QVQ8dxts72LDZHZntdhs1ls+?=
 =?us-ascii?Q?uSVsO44Ib8Mvb2NtWydiHZZEstBDEHLSaNT2olM3TIND5i2STlrFBpyAXOFa?=
 =?us-ascii?Q?36i4AisMmst88E99QVpdWVP4RcT/BCtD2KsrQtZi2QAwKTHBdjiB0pOtllQz?=
 =?us-ascii?Q?+8VxySlsqNnP5IRUNA69gL7AohXSDTQgKZHLjnvD2WshX7bfzv2CaCKOikPs?=
 =?us-ascii?Q?NN/apTXjAU26IjtZMa2mj0cAJemZWtmb9OWHBEeCIj75YmPGwNivr4UdZzQo?=
 =?us-ascii?Q?0Txlcub3S5tvkLeq/B+baLAozaY8TEBJkUIIaoWW97g2ccDjKEr5jO5odNe4?=
 =?us-ascii?Q?tfUk+/5qNUw/J9Ij3/GFDikOV7car/6Rh9PdJfVcevgMMJFxMwmF+Hta5Kk7?=
 =?us-ascii?Q?l1ghFSO66BPWiJux9nP2PbJlPY5SeSnomRMd0z0BIpZ+xGaUho58c+E8wcT+?=
 =?us-ascii?Q?FtmKIOVZUSoe1ifTNxAR1Ixd/L/nMJQxnuvgh8gu0BFHv3yQa5RbOgwT1A8p?=
 =?us-ascii?Q?kPQJxJn8radH2s6RCAG1khoAuVG2oAuaMrWsPC8on9YgUOzUi5r1QT7U+J3G?=
 =?us-ascii?Q?jAXgQOUScuK10yEAXFa5QDlC4/zdBT1DMQsvn7MQYaWl4VIDkJn1/JEvGMfB?=
 =?us-ascii?Q?ATzUEPeR11UAg43g0B7/1Yc4pIL8/5+37+Dsb6lwiiZowpZtGtTIAJlQgmui?=
 =?us-ascii?Q?nckOHJ6UuKwMFbYicX3RZtmgqjEag8Oyt/t/ESCQVFZMizjd8PO0xMqRpSuE?=
 =?us-ascii?Q?b1JNwTrA+0w6MJZUWdtYy6fbu6Px9kUipk98uZVjB205qPPkk2gX98MH6+Hr?=
 =?us-ascii?Q?9OrX7lBo/3uQg110Kq6pL8Bh528MDcxMOyx9feurveB+tjyJ/WdnBzJKtBu8?=
 =?us-ascii?Q?6+fb/LYDA5DzcBtt6ISf3k3vEh2307Txs0OdbrYF/aJxaOuHBz0mcZRw/pr1?=
 =?us-ascii?Q?Aa1gZ3G9RQSbPgzqgO/jbLCBsceIy5FqDmDqaVU2xJgl1PT2DHBA0Vt6hd6G?=
 =?us-ascii?Q?hWdF4os40GGFLhFMWCey8anbO6V0zyJAnW7I4pOHbyhd2SjUfeGyNYRsN6r5?=
 =?us-ascii?Q?jbQH5qZnTsz9HrBt5h/8ZyhiaFFGzQRuOhQuPB/wmUQ1fy4v7vK29ir4K1iK?=
 =?us-ascii?Q?atft6tDH67Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CDk7xqehiU5rr2A2J4CiaritU4OfVD51pFG3RNCBDu1g4n2CprwFNyOua3M?=
 =?us-ascii?Q?LqONgJHpzJPmuYVt0AnrNxm7F9bw8JMVpkJuz3z3UPPh0gWpxJFCT6WO4JUt?=
 =?us-ascii?Q?dknlS0RklFHa4N0IMydCOWzSFU4BQ79OlGWEwNeAHFhc97yr8f7Juyg0tdpp?=
 =?us-ascii?Q?0VWHRP2VXa0ZrU8/FR0r/oKmw7BpZUJfNrvAgdaRCs9Lj5ndfH7HYWcWl8yj?=
 =?us-ascii?Q?Rfs9x+1Ynwnj3ikL9xFOFGK5G8necWitZ/jSTkqzoVADrm3/VTIlT/V4FpXa?=
 =?us-ascii?Q?oKz9EtUe1Zn5kqTfuRLrSP9FWUX7XRekr0wSk+Gx1eGxrCvpHzQ9atXOW0Hp?=
 =?us-ascii?Q?BJvbA05VOcYKvZWLAAVYL7cSBOTyztH4+bnykUnn2R99TndPi+NcWIo2d4Z6?=
 =?us-ascii?Q?Wtpuqmh6BNuCl4X5dCdRlR0yiyeeAyXAYkCZy0M68w/wkZQSC8SFqAiuz07D?=
 =?us-ascii?Q?nD2nsSekBbuyvjapDRYfdnTLBvRJgQHps5J5QHHmNuAas/N0+7gmR+lgRO0A?=
 =?us-ascii?Q?n+zyXUUFqV2NF4vxIIYtOte2EpojyLzYjFUNpDcLTH7IY981S3GBB4WH0TwX?=
 =?us-ascii?Q?J+7m8veSQEYlGKU9V3+4/pQRTZieAD+fQ8UB2wzXbDNDUOTgiqtKGUzl7bRf?=
 =?us-ascii?Q?4GQIU156rjezs2nAUpdE/Z9uxKjKlBD5+PeGx6IVI/pmvM7QLMH3IxZXNhgt?=
 =?us-ascii?Q?BP8y1ZR1g4K0iifZpS2crrtTzMLodDxsZ6qesIWgFsyTCEE16rvnZjpSfmWk?=
 =?us-ascii?Q?/XVoPISOC35q091NUS27mdYbuHZpOZEWtNEQmBfH3sJKA4W7QRetqBCseIiU?=
 =?us-ascii?Q?rUYARdu/3ix3kceVYTFRExVHS5btFh4YM0kA7wm5Cdz1gLby38m4jv2iNhjt?=
 =?us-ascii?Q?01vOLV6I/SXpP7QhLgFsIufa+/bQzdy9izsN4LcvRf/aZsg0Hs+vH5V3k6AW?=
 =?us-ascii?Q?YzsU7+xlpEUPi9nrwnO8c8bhlroujld25hiMAxuCF8j+SbUKjmAoyLGxPHmq?=
 =?us-ascii?Q?TJlIvbMhFMjmDcuHtg0XMlZ6vYo/4q/VdCtffWC4+NbpwFm329j/VJH1hkbU?=
 =?us-ascii?Q?9yfdx15ys5umcz4BqfOgckPjvXtHK2Ucan/E4U84sF+RV4O77av/3K9OmeWc?=
 =?us-ascii?Q?+WyLLm2vYW9UuvqvjzwwwYAz5PCbDFAzKQAhHkf8m2Bi225e3eiBg6N0dChJ?=
 =?us-ascii?Q?l0uZkswdx3gXmjFWMYLJST+KuhEWJD5jSEeieXz+WA35uJMqhAIxe6D8tnV1?=
 =?us-ascii?Q?TS/TuNhEGkV8LSBijvMKK2JjrwZYwFwqfTEwfqpPfIrJkEuOkUBMW753/mfp?=
 =?us-ascii?Q?J9+gXqOdpQO4ug5yOGCveiScRsezfiE2WqTeCBnODLm1GrLWbXZbXCpp8GZm?=
 =?us-ascii?Q?IbHxR8GXrZsFSMVDANWmVIFvthjI8jh/r8tS0wEd/KTyeR6hFhi8n9cDQyHF?=
 =?us-ascii?Q?kp+B+xe75mXO+DMxeNxoxLVJPpjM2ZbCh10WESx7fZLS9OafZgrNkdzE3clE?=
 =?us-ascii?Q?5s0HLvKWt7gcSz16cmPmOzcvZ4Z/yJuohW1o4+l8lPoIF6aGKgpSV3tgDg38?=
 =?us-ascii?Q?Mq++E135ipfAybq9uUPYLWkKUhgFgfDAmTzn7BxM+GR107fWnQNGutMoH8T6?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35d9db7-371d-4a9f-fbd7-08dcb5dfa83d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:18:58.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHMQsrjUmbF8Qz8cqWj6hFZNlHpCJvkg7MQQW79Y/N0pBLbxLqBnIwxowJ3zlX3ij9pV3JPHrsYdgP65cmD8nRYtL6PqKxfI/wkcpLSstdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6719
X-Proofpoint-GUID: 3XSBwNl2K5CFlhfUB3JRoZUe5daseaQs
X-Proofpoint-ORIG-GUID: 3XSBwNl2K5CFlhfUB3JRoZUe5daseaQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_05,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

If EXTRA_CFLAGS has "-Wp,-D_FORTIFY_SOURCE=2", the build fails with:

  error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]

Use "-Wp,-U_FORTIFY_SOURCE" instead of "-U_FORTIFY_SOURCE" for tests
built with -O0.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 tools/perf/tests/workloads/Build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 48bf0d3b0f3d..ec36c21e375e 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -7,7 +7,7 @@ perf-test-y += sqrtloop.o
 perf-test-y += brstack.o
 perf-test-y += datasym.o
 
-CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
-CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
-CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
-CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
+CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -Wp,-U_FORTIFY_SOURCE
+CFLAGS_brstack.o          = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
+CFLAGS_datasym.o          = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
-- 
2.45.2

