Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0C23DEB6;
	Wed, 19 Feb 2025 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002271; cv=fail; b=mf1TluWOq9nzP9VrM60jqTpLvtWGmcCbBF8+PZvF37Lc1cVVaxQxGk/udyduPf70ZbHvBOqp4b9yNmXtni977HxaOHEXAbzbhhvi2tpR5LnPmhaOZrmrBJSiDK8f7EEQaKfUtBZn/BHVJY3aCEE3CkWdW2YQHAjFUtkXVLqfl9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002271; c=relaxed/simple;
	bh=jKDV0/pG9vtkNUsrvJbJUTDa1IvDkkYkI9DGGWDJf0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LZJePnG7Vw3txQn5OyhqI8KEtYS4V/GYllkxziTzNi7nYJgETUIVyprUmuKz5Di6/eucaTupuXuED4aN1CqLiwg1Y72OEITGY1mTL+FZUvKg7fGg62s3fOvnaIEdP2Y6FDfgQWnQdrnJt271ZejVaSTYS6UnoucQ/uG0N14fJLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hZ31M027; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XjoFKoTB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZ31M027";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XjoFKoTB"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JLXa1V000838;
	Wed, 19 Feb 2025 21:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2r/fL2plpswNJ0J0Om
	oB/sXdeQZd8PCWF6JpfBsF0xc=; b=hZ31M027sA8Jwd3DTYZHKofwav2f0xiKva
	dzHhMpzG0TevHmTyukaXH2l66RziomWHB7YxT5fvedaSFomAjE/fiGbRrSg4qCVU
	pozB5UKyeM+UfUHXAWn4cnfTCBC49tmEcwODpssRvxxGnXy6eOPrbpgDVZ/MZHWg
	yUGHnVzJ1SQXgLJ7/Hy7loNb4b5I0Qnb/bl+Cu+Pgoum8nf8Dl+cE37gntz8AdjV
	4DiEIbBqDvhExohm4puXKWHvW2huQUcdXNtBSre4RiIIqaOALdjuql7nRVReEs0K
	o+61LfAEyPmQwJXDzqAlPIJ09atvfFQDZh6Dc/DMtkZ3gmT7A7bw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ptsgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:57:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JL0eKD002174;
	Wed, 19 Feb 2025 21:57:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tmb53p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxZWdnYLSGcNz5LLOvTf3MH8cwrGsWXkFgdQqj1mvlKD2WgZLRgFYT6SMRZH8+L6tkI3DJTDY6hJ6aq5EGY3a8EAuUaK9Lw0ms6Jt4/SW0a/dwMEaT4lLSQgqB3lxTF3Ie8Zv0vmNzB+fUMbGnm8Ls7lPaqyVg/IsyShV0H98eiKwfxXMabPkQfNeoz1U66hbz/LZ3TjK+B27gBg7kSyw1QAOWkVUAK8+iWK6uqIX9Zz/trcm2k4xtvT2HkYtfKBC/YAVwqxu1c1JFR0UWOxal+vz72UcHfx9LvQOhfUzaJN1wrsH9nPUTHvvlJriYbmc4NRgc1lSyhMardNR6mIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r/fL2plpswNJ0J0OmoB/sXdeQZd8PCWF6JpfBsF0xc=;
 b=haqReUHnm2AouzdFfl4iU7ZBuJC2t3KxAoMeyuoQPA2pikYfBxBMLSPHj1hFWV4QRrnG1g8SVFEXgKS89SG3u1eLFHsB0tnTdYJPgZQ+e5OMZ9jlmh34KuhkIQWQ2A8PqzY3SJRW6hNqKmLvv7iD7JkuyXc566+V3nmTNIk26wwcZWRCepzaVIznrhnAoCSLs+LALMQOPoTCtbkTg6oed2XIP8SqB2ZnZvpOJ5QKNhJZ/QoQ4urCwzwX5Y6HHzGeD0o3EZ1XeUVyxLNsoXnV5bEjreOKb6ONj2wXvFhmjS0eo4ySw2xEWPfSjTts+gxW/0HGLiLN/o9Pv7YWzzwdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r/fL2plpswNJ0J0OmoB/sXdeQZd8PCWF6JpfBsF0xc=;
 b=XjoFKoTB0jZaCxHsdBIJGSSd61RwdcfMhvhFXjKbYdxACTq/cNduLZHZSo0yUlQTuobYtwV/bpNSfFRI7W1htbEbsA66TXIRiVhbn0dt6FhtZZvdCHapIS+0L7Fb3ePLR8BElpzTplnQzvm6B0UsZ0b1lg+V6bbpV6bXGbhXU9c=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH3PR10MB7861.namprd10.prod.outlook.com (2603:10b6:610:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 21:57:30 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:57:27 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        James Clark
 <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
        Chaitanya S
 Prakash <chaitanyas.prakash@arm.com>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1] tools: perf: support .gnu_debugdata for symbols
In-Reply-To: <Z7ZKAYutejOOoBbQ@google.com>
References: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
 <20250213190542.3249050-2-stephen.s.brennan@oracle.com>
 <871pw0gw8d.fsf@linux.intel.com> <Z7ZKAYutejOOoBbQ@google.com>
Date: Wed, 19 Feb 2025 13:57:25 -0800
Message-ID: <87zfihbnsq.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::14) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH3PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9e2009-6929-4a0e-835e-08dd51306600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2c0z3kbVbB+rT1AqrGhbsCpxuTyeUtiOZGf5Cj4saLEY0VmyjNPMpEljDw7q?=
 =?us-ascii?Q?BK8esdbzuxoWDALglbxJX4NUpekxmKyqikYhGwhtSCRjAINZYUYxdq5s5GWG?=
 =?us-ascii?Q?kkfgklgTVyThaz/I6qXxUtq6L6uoRyVONYRhZf4GxOYpobbTCupAi7Gwy6/d?=
 =?us-ascii?Q?N8AisPQyUb/4sFIfaAVs7eomUogend3xdJ/w4/a3ksXwlBjlKlkJBNYl/7Ti?=
 =?us-ascii?Q?3lSgprtJ0E7Jdh4wJV4Ymk0DwojdqVfqEK1ttHS9jHVCQW57RQ5hkHKzExuh?=
 =?us-ascii?Q?/8D8Q/XJ3hLboKJNnNt5Uw2jFHkZtpj80MBTsAYQbKDseI8/L66rgoHtcDRb?=
 =?us-ascii?Q?GrVbnxRvYcnzs6k9MClsMZ6lD94LndShHb5q09t9cGj7BsbjjLeqk9xBJC2q?=
 =?us-ascii?Q?ttXBZE8XhYCRTGoLp346xFLq/YrOIcM1oijoK8CWfeKfVtX/kwJ6Oj1IXEuD?=
 =?us-ascii?Q?Q6oPHc3bCZKDPqhzQqOR292RFmaq95ruVsn9hX31nc9uHpM8F8yTlYzNowbF?=
 =?us-ascii?Q?nXSRbQfoEGMFHTVsG6ki5z4h7yJ+aGMlc87w+yyt5FIkedeiYnrzGobGCNZU?=
 =?us-ascii?Q?bFOS+32+Xagri8fe2HTGWbR6b/WsirFxlocUmNoEgjb8zuYwkTNlbivHNJeg?=
 =?us-ascii?Q?MHNA2UjmYZyF98JWCaX4kRexp0dzdBeqnGQUv9xUbMuzXvNwyX6G/hmtUwDW?=
 =?us-ascii?Q?lvqITojFRC4m/kln333FDt5AFtiBv4NZxAdJBtDVjfUZCuW70fulOX55FMOI?=
 =?us-ascii?Q?l0Pm9lN6Pc3HzcCOakWBC81mXm9ShqH1C/Tar4VMCZFerWH3qCSTPtnp1QAj?=
 =?us-ascii?Q?BH7Cuc8Tnf8UT0Px3GKwStuTtZDtu5sH+CAx8YLAfjlh6AaBGODNzLgmNBN0?=
 =?us-ascii?Q?k8Yf8+shQeNsXCpkW6OIcSiyHtii9pfOd04/SInK4gLeybqZFI4U9Ka0ew1H?=
 =?us-ascii?Q?XYW5m+zJ7wMLK5PSIvPag7PfaPJ0tRY9F+U4Mmdyl8U2NgudKzmY1dHq1V7F?=
 =?us-ascii?Q?fYnAOSKdWKfBKn4VfHjKuYv9fsleqWMT0Q9rBM+roOmuyhzQon6X9dFozWS9?=
 =?us-ascii?Q?obqD4xb8lz86+HleVfcAy6IaQEtR02s7JAx9g8N8mUuiC+koCvExST95sPc0?=
 =?us-ascii?Q?eHzTJpYbufxf7fgT3c7b34/eiRc4FuyR5fK7iicgd4kiAmPnT7YZb6DahTp2?=
 =?us-ascii?Q?ru7McIqyCe1vbev7B6aLYC/+JRvYfu5nGF2Pk0+SR7ISnx4A2ie+wzf5js9M?=
 =?us-ascii?Q?erZturSSQI0+6tOSFkCU+gnOyohn1ePaCybRuHOzqI5EpS6rnIho+R9JYJE2?=
 =?us-ascii?Q?Xf3bs54gd4pDtf/o3WWJsTXlX8RMvlM8xPTq/bXqwyKo/52jBTpsT7PwoL5u?=
 =?us-ascii?Q?a94Eeu49xdhyJTiAtOeuJaA0s95c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8l4xIIP+iWckLBAUygYqaErpMzysLwk0+fXZjxR5TprNXkWqnuw2ATk1624A?=
 =?us-ascii?Q?PeUPUW/QjpFEfLmj6lEA1TjkBJA09wEL2iiCIQC5/np3//kHDj5ThV4no+8/?=
 =?us-ascii?Q?LrKKQrMsqtUAp+BnE05QkLCjk27kA8s9IgxlMuk7HJAtxFhDCd0egqyxZegZ?=
 =?us-ascii?Q?MysJIeoJ5HKYLSIQZ6k4fzFepfhcHvGh7vyyeXlRTAAhUsOr5E1UXKubynpc?=
 =?us-ascii?Q?WZoLfy6lE0xqUkBEscg4bdDgkRfqMSKes3LVGQ7Vdm4cJ1DmAJoJSkmht6Tm?=
 =?us-ascii?Q?i+M97EXPzR+quXnayQ7vigVxcIOnMXoG3SIdrVuIJk3yeiImpXAg/jOa9WqJ?=
 =?us-ascii?Q?DGUsRQADvHtS2ls4mi3JUfQ3iikP7CP5k6mlJL8bf4r+3PXl0ZcaolVpIsn8?=
 =?us-ascii?Q?fbN7Jb8yIUmj5mIJGgFAtifHu2Rf68ZXaWiMslEMeZ0rRuPTvfq0mAxDC5od?=
 =?us-ascii?Q?I2j3UXTslSq4JcNLyRdNM+lC+dlGk0EDEcEhVhrxNlcO09ImEClVe9Aat+wp?=
 =?us-ascii?Q?FCfBgrCJDCBmJO9j5BYLtR7APTn6O9FT9fgV2Rmy/hR87M6yzQKlPqeCiJZ0?=
 =?us-ascii?Q?yetoE/u3uYDC641wA7lee9GPfa/qcrnCQmXt5o7bmlzU65I+RzH3hJK3iwr5?=
 =?us-ascii?Q?r1qZVzng8Hp6jBOJ3cETFYK6ZkPZ1lKlzYxITOrdpzsR/Xvr87jY/gHkxJRp?=
 =?us-ascii?Q?igUQWh4dzW1Vc6kWb335k8suHJQLUQgZFNnIbQHPecsHcygX92spQFAcmciT?=
 =?us-ascii?Q?vO0y22I2rWjUVeOYFBT5KYlCCtKJpN39QcZ+3Rv0mTtW3pNuTRcoIWXTCrdT?=
 =?us-ascii?Q?jTGhkoXPtgEqf8bYTFfRwdXW0Jmz0AOxU0PxMTWJUKYrgpW55TVQVefsCF4o?=
 =?us-ascii?Q?Y3ZrIjhCFFxruKtewDlmCBWLg5lGQPDjxhxxpj6nP9bNNNpwpfEYXIDvvaHh?=
 =?us-ascii?Q?BWSqAkGQKFGvdWohbSQKSGb3UnAFkxobHXJ/T7xjQubgYAXRhXWJHqVrAwLX?=
 =?us-ascii?Q?tmf55us7gm9LlmWfYODd/WaxvfPHBqBa2QH5sXOnbfs7acDrMYTzZZBT3MiM?=
 =?us-ascii?Q?OZWYrrHNRIaP48JlYTFq/jpVh7swcq7ybNjlgE0UVebFNcey4/mfwgItjGbe?=
 =?us-ascii?Q?f5Yy3xwI5gBhfMth56qtFudv7Bnl7++ikXhcOPzW97VNqlyWyCHiWEEYUFH/?=
 =?us-ascii?Q?aqgwWy9OKQhf556CH8fNqUhcb+qiRW5mWBvgQiRRGc2GuTEt4qo4TwPaKnam?=
 =?us-ascii?Q?Ehcv078T4Gz1rw9U2nDkfLIy/AC9zAMWQYcxlVUM0k0FmGsWA125C1X8W5xC?=
 =?us-ascii?Q?Igikkk8GjVynfpj+9jsfK9hJ/wTYzUQ/YxHrbw8gy1aS3CkdqxoFRAg/4954?=
 =?us-ascii?Q?DHaNzgjoHwIKbmRFdKkREthou5qSnhATyXTI/iSt1shKGlNohUeHFw80dPYd?=
 =?us-ascii?Q?lwCyC4S5xzOsCedOYs3J0UR5bVtw3PpOBgTblXHCvKk1vn4Nq8TNnNL8Rs7l?=
 =?us-ascii?Q?wSRcqyeRUh4Fj8EDPJHDeimLb7as8IkmvDsC8dxbrbXla9kTGVoZ2Y1l+JtD?=
 =?us-ascii?Q?qhnjd99jH7JVJNSdovEPgPT00sDfOhZXx+Ja8Bm/Y/WlEyiGIdCOCCZpZSmK?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KJO2oARnJWswbimp8PScYGVmSvcSVlIZ5KVIxKnrdlu3CfR+P3nvFVJU3PzmALQivsNpzlL7718V2KGRYSXfkeh+DTAIvD66vWhZgXX1VLSBOsmYk4hJIsAGt/MDqR++K/nhyJEdZKdhNBTxyDmThpdzM//GFqZ624DLZsbH1LGS2XtIYc+cy9WK6wArWtQfRQpiGWKqC01rygfkiKCzQMDSE5UC0+sVW3k4+4lYras1vXsWsvNlAtL9X4xaPdGFA2Umwah7WWWshDtV6O0uSdc2jH2DEftrsdgaHQ+GqObyr/uhWP1KmM7jdDaoJv5FDbv0ucRJ9yHfBKs9WBnRmyX0bIMTzl2z7OPqeDPyz+8pzR3jbjqxgti5YHCWAEJVtRmHu4nFKzX6PNTdxThmI5e60qumqEVjUCQ1bLRTPElc6VeJs2TpDXk6GRXQvaOdEbUroRjcSUrpwNcQnYV63xfPp599r2iIuTuDj9OdtX0mYfC3/CjDpBzwupEeug3Rthy68Hj/igmmc70IX3dha85LKpJu2Xr9JlMiQkHhsJzoDOVYdShH/KkTJeVjkAiiNHLYl6QynLK5t9WxZc1wu3eePs49j5SI3gV6M6gdOok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e2009-6929-4a0e-835e-08dd51306600
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:57:27.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIeGd7XhlsWdENc1fh+jU4+nyclgABXOtHSLHD/Z6JFB5ov+xIhqacvjR2wVDEA8E1SsqkCCbm9if/MALKOeI62kslA7xIw66J8D7Ojs//E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190163
X-Proofpoint-ORIG-GUID: RrdbNlFRKnhjdDHosuJD_86GkJBgbZLg
X-Proofpoint-GUID: RrdbNlFRKnhjdDHosuJD_86GkJBgbZLg

Namhyung Kim <namhyung@kernel.org> writes:
> Hello,
>
> On Fri, Feb 14, 2025 at 11:30:26AM -0800, Andi Kleen wrote:
>> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
>> >  	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
>> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> > index 66fd1249660a3..e578b7d406a69 100644
>> > --- a/tools/perf/util/symbol-elf.c
>> > +++ b/tools/perf/util/symbol-elf.c
>> > @@ -6,6 +6,7 @@
>> >  #include <string.h>
>> >  #include <unistd.h>
>> >  #include <inttypes.h>
>> > +#include <lzma.h>
>> 
>> This needs some ifdefs in case lzma.h is not available?
>
> Right, should be guarded by HAVE_LZMA_SUPPORT.

Thank you both. Do you happen to have a preference on whether to do this
inline with the HAVE_LZMA_SUPPORT guards, or whether to use a helper
like lzma_decompress_to_file() with a temporary file (presumably one
which is already unlinked...)?

I suppose the more I ask the question, the more it feels obvious that an
unlinked temporary file would require less new code. Both because I
could use the existing helper, and also because there would be no need
to free() the data which we decompressed into memory. So unless you have
strong opinions I guess I'll switch it over :)

Thanks,
Stephen
