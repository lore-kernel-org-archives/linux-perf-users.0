Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4D3370EB;
	Tue, 16 Dec 2025 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868036; cv=fail; b=otMByYUKyNiGo6ENQX7Izlw2VRR+uE3olHPn+vq8IuYIlw/711DMl9NBkjTOwi+M7v6pMWFqM88PmycYDN8a6kA9kQL6sDsMwYbltCZge8Gj9o6OL2wy1HoH0oh1qVyb57DwWPdvBlwopwOXDuaBdDR8Q/3y/JdENZsP7vPhk9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868036; c=relaxed/simple;
	bh=hECVJjEY9OO2HsdYg4QIElx4fMVtvBGgLnttuzCy3t8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=eNLDZBiblGoyQYY026OHjTota+qA+M9ePemNeuSwe1lcAL99DWSSp2/OvFkTmsXKrhgr5yzUNQqEjuWH1wdURbRpAPJOdhI7RcseSMeNcw29kqK4VpFeXtFgTDLQZSHHoQCFLFK1JCuGWfORwAspSKqG+pUH6y7D2yldJI+NJB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kLbgOUdC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ipEUnrdU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kLbgOUdC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ipEUnrdU"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG1hIRE3443846;
	Tue, 16 Dec 2025 06:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2M3gnZbTGi8Fbb8NmF
	c4e3cDebmpbvluL+i+hEpQSes=; b=kLbgOUdClKnTCQ3HnPhKFu0LUYkYvTgo3t
	XoeZuJDXkAwoLY8MpE3D9QEQ0bubImk3yOb2KU6K8N1pGp5eCOhnoDFOSPNc3TY0
	A/kcWLL3E698KAgP3/AIbccSG7lBNO82actfBatLkwkSWD7yjYZMxG9bIbuof8xt
	ffunNyCGNzwVdAkgSPA9y27ajNfCa0BW4RBMXwB9vtKHHzuLHtiwe8lqdusaIVTm
	ebbevnsaB3rDQfZqKOdtbqsp0B1KX+CjFTK4uvCwqfhlAQmV7Y3ygqnJUvTLzz6Y
	PgUbNUSZnwmPGi7SY51wg14xFJfKU4juAbzVNR/rUH3Zk9xU1khw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja3dut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 06:53:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG4PONQ022444;
	Tue, 16 Dec 2025 06:53:35 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjweqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 06:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmdtt8lcJr32bQyO5T0fEUWvO443lOZijLM2Ln6ea16YoyjbN7SXiIaAR8jkMaCm99VXOGCu317y9zR5prt4suviOsakcnLuvayuZs5oH74Bbf/2IaawugIw5sSfJIqSsX8IlAoA13dKLTBRLUBb16Uote8e3yQrli5dsZFgjvv3j7FOKrHTUvUF2s2T+S4EDrhi5QfvUBKIOifZLtZ4mZkZIX4SH/5x+I9h8kw2EkgXqe3NsNhqPX2qGGa2GgfKw5mlCfzuyp+8Y1bQURRGawdEB07sA8u+DSzHyxpDLJDNNiX6vyRKU3OCVPDi1q+n/lIQKVeo9s9I5Jc8J3nxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M3gnZbTGi8Fbb8NmFc4e3cDebmpbvluL+i+hEpQSes=;
 b=CtWsKJhbYCTCq8XEz7+Exqr4DhhKBHGKWwEm7mWlG6zOBMDSA4peOpGoA9SRnN80icRfVez89abslx2fEY8+h7PtMxTVx0yPz2k8O5E6TpgqmF5iSxN2dC6thmb75M+UD5w6pYXtS2k4B0p+GjrSXPjkyfdCJ5sIshAQ0eqcpbN7nv8iWieINOPRJRYxpw2dXuN5ISvsOTH0UlCV+AQ5MHOWehYrYziaHgdi4T2az01OZ9krSpgYKadPA8sJVAYgqipOmI8OD6QmVsUFmuelZk7SJr1Rh690I0CHDEaEe8/SLIiVcyASbGEmW7UiDw6Ym3Cegamg8nF87mN7FcKAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M3gnZbTGi8Fbb8NmFc4e3cDebmpbvluL+i+hEpQSes=;
 b=ipEUnrdUkDHrzwbhQo0iJrPrrmr0h1gQ1O6dInpA+7f2CjBdsXDxK7U+h96tqeAan3lrAiWnQm5Vsu8WZPQI4sqcIJGk159IBkbI38zgyTVWpeQ1wX37mCesWmkzS03Cnr9tNY9U64HHKSCnIWj8qNqvxhPPsUQCqslDYrCHlLs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF92DC283F3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:53:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 06:53:31 +0000
References: <20251207085741.1388141-1-namhyung@kernel.org>
 <3c27128a-5cca-4c2f-a3f8-47b9a375bc7a@linaro.org>
 <aUD6yGZ2bSHsCb2e@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa
 <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Ankur
 Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] perf bench: Add -t/--threads option to perf bench mem mmap
In-reply-to: <aUD6yGZ2bSHsCb2e@google.com>
Date: Mon, 15 Dec 2025 22:53:30 -0800
Message-ID: <87qzsudij9.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF92DC283F3:EE_
X-MS-Office365-Filtering-Correlation-Id: 4007c734-82df-4802-b79e-08de3c6fd2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2CAxwYruQUIO3rZOtCLy3+BONn9JWbupAXVn4IehhuH+zKmegYKOev9VkJJD?=
 =?us-ascii?Q?FVxcxke59lU4vr1hUFdIV9TFAYKbGkfSN7sm/5MK4ZvjXoaA4di5drcKRvY2?=
 =?us-ascii?Q?0yWPt2WfCF9xlgezVaPmiUB+5B0W3aHIsAe2YboDMTBV0Td6yYcypqCoNHwI?=
 =?us-ascii?Q?2DN5r2EfvOO7kXuuiQXeCEamfCFCzCXj7lenJoKmaVlezzXhidL1eK0WF8Wb?=
 =?us-ascii?Q?6pBlDxErLNVG8lYGuoVk5lEsVKUZB5E4d8QJCixmCIaoibssunXntMSqIe5N?=
 =?us-ascii?Q?/+tVm5rrQsBM5ynSuZ3xEC+ULkvpGsq17xDNQwOx7F8AFMdZ5ft9PggxYbus?=
 =?us-ascii?Q?A6M92Z4hegJfDFiAjpMkH6jgEdx4ZNUIkcGqGqE1WoEogonpkOXWunIWfb+n?=
 =?us-ascii?Q?5W/54mrk9YZhKAnKqa/O77CR8OR5OYpz4ufhyvahePcmmN6Wjysvlqg8X7Y/?=
 =?us-ascii?Q?opka4hV+gbQ6Mj6G8ZnxpbAmcrkTI0iiPziK+lQEWY0WUE6RqiDKL6JBdE5R?=
 =?us-ascii?Q?p8xzPuhn/VOS+o1TEJSNvvMV/X2rxfnu+pYw3ezED96O3TH7DHjUWyNNkO9X?=
 =?us-ascii?Q?0FwRk4Q0yD2H2gIn1cAtmx88OqWislyqUwUwEnnysjQYODVQy6UkmmJgQB4q?=
 =?us-ascii?Q?pFohJN+jO/wlcdcWy4dPds8bXCBuPJgo8S2CxZxtN/21wZGLsjv/kN1RfXTQ?=
 =?us-ascii?Q?S4lnuOY6dEFKyqZmEBx2BZ6lrBwwU8GorzdEa1PR9NSZH/eVXdwUVf7rxKfP?=
 =?us-ascii?Q?itquIghClZRZ561IUzAaIiiGFoHspyLolRGNSgiEcNdcuEyTpFdUxUu0g0fV?=
 =?us-ascii?Q?7YlmGRdPEHD3wmIqGEFbPtM3skMEDAZc5j2eHSfxdGmWc4ZfQUPeRxLpU6ea?=
 =?us-ascii?Q?6PEjZjWt/QcZ7RqPyOgppZEDov4HKPQNP0iZgVFillKTVDheWLgHDOsPc/Mp?=
 =?us-ascii?Q?3mOn5yEDr3coPRhRbkC831v4Z3vgEY9CoBHaA4BHwqN4JYfoTD3fPrKTQNa+?=
 =?us-ascii?Q?93mpPlUaKoxYcVUnGg1b80TKAFnh7nkOBHw2hRfFvWCodpzC9kIYNXjOH/5T?=
 =?us-ascii?Q?I0pexFSLwCuufkc7xGmy8DFAxirJzkwAxbD2lKk/1FBta+YTBuAwOhK0J+Cy?=
 =?us-ascii?Q?5XT1H4fOBwQwJW6NqwnkHlmJWN7FQp+2flWv0c55wryjtpguyEk2McTw13uv?=
 =?us-ascii?Q?14FMxuBuEpMyZQpQPaeDousDkiIMSr9xKimVLoiLbXndQzzWW3PVV5FOgr5N?=
 =?us-ascii?Q?LSOS3v4Bo0sDvUCIVNq3QYepeWI0coisMWD7B/PGH7LUZRzEfgunpTipXvXJ?=
 =?us-ascii?Q?S2BAaGdK8gatfeGXDs1yEN3VPCVlV4h+Ac4zMzLrgoM3m/TZzMSwEXXZjK60?=
 =?us-ascii?Q?R1yQoAqb7+hOlVWdbcl13Syy/pfZsYKu3YC8ubFgIn5I70RRhf+dPK97Cdu0?=
 =?us-ascii?Q?8h97XHvZm/DOvqpkfBeuqYAzpkAGoZQx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Go8PuMCZUDihHK3VIb2ijYrnwA9U1RJT6O9GXsv5txdO4CaLJxqIwFPx7MH3?=
 =?us-ascii?Q?Yz9X4X6zKKOMnOkBHYckr19SI5RC4n6fn6Rapol2xO1JS1yzp4heH6pYpas6?=
 =?us-ascii?Q?380QAup2dlFhviO0Ao6HOrcNEzfcr0ugfg20mddfe8xGv1aXYJN8pD6P2oDJ?=
 =?us-ascii?Q?87D/suc9em9dhOth/XVJx7Csf3t+42zleQLavTw4s6RijgR1dOTbV7Q4BtYl?=
 =?us-ascii?Q?TA6nWSUTZn5vupcuJcCLRxad2Rlu9bu2MtKa7giYuCxAZyhOWFD3cw/Nq1he?=
 =?us-ascii?Q?kVUdQwP5Lo4Jrz+mWHyMfVGNzW+Tj7xyDSplSBn5jaXf+9Zi8UvgffrNCt0B?=
 =?us-ascii?Q?Uhh3siG8+vf48dabbKUSYsY0LJMYZxb6Q4ijIFHOWnkZXy3O9uKOrf11Rulo?=
 =?us-ascii?Q?XfkvZCxzMiqd5bD/uqWg6jizrIB7aBZ6YzFRUzMMOB2KlCFmqp6HZC7w0Et3?=
 =?us-ascii?Q?V1uXinnyEsfU8tc1oyEeMThCaC4q9g7lpvtMmEvAoHtQlaz7rc71lTv2ce5z?=
 =?us-ascii?Q?NyqVh5pOjhCR+3rZ8OEqLNKBiIbfRkq9Cp8Cn4mBX2cp+Uu47dT9PvECRlW/?=
 =?us-ascii?Q?plyNVCqyBEZFIhkE86H/to0iaETcZ0PYWeey7HKmlvBuvB8TSlV2YkyKg+xH?=
 =?us-ascii?Q?YE23wMVtfkNXCX7UtFjyKqogRnY68QImNkzcdeIqBdbr0vAn4662x1JdgNLK?=
 =?us-ascii?Q?MK6QTTAQZhSdtPQky5vJWobFBE5CUktTwgxrPnrtX+/PuuTX6rwmwqZun3no?=
 =?us-ascii?Q?UQl3hGtvA281SmLYatCXC6T2CteHimoVqsKjeMBFR5Z25gcpDWlB49H8A+e2?=
 =?us-ascii?Q?jgI8IdVQNeB00r5cKZy2E8IE0ZnaVRzSFIV5Bay+uVFB1VT01sLsVbc0EgHm?=
 =?us-ascii?Q?M+keiTYBTjmoNXOY9qyWzXAG6IGAgleUGMDcuwfI4YBgWo16A6305zba6gRY?=
 =?us-ascii?Q?AhQerFaJT+3+r06V/x+VdmUs5AgG23AEqPwhlRRp4DzyVQvim/g3bNa/z5G1?=
 =?us-ascii?Q?vnMNKxUsxdKQRcx//XlWLNo8pbN8igj11h/rs9oDCfV4z1sI5vOzTSL/ac3h?=
 =?us-ascii?Q?/y/6MDi/JYDVU6i0/D+GnA44GCALWDq+4pONhE1NlGWVMHn5arh2PQtd63TR?=
 =?us-ascii?Q?J2d3758Lgo+4Sv/AXgPpkgs0OMfZsN3NttVM54IZaEPoHkN70iiCnpNP9fK4?=
 =?us-ascii?Q?Qq01HyaS1wQS5FdQRmr/hV9sLU2CfH2CuP+VH6lwI3NSRI76SLaKmBVHXmk1?=
 =?us-ascii?Q?2MTFfxp0AFmRGNhY1Bz72D/Kr+od76BYohzCiRURU+OsFv7pcKo/cfY8U+Dr?=
 =?us-ascii?Q?smQE1SMnBhk8MANX9hEXJ3UzdKTlJ8VMh4DFpgKSDFjU05bQFxT1cTk5ReMf?=
 =?us-ascii?Q?G406kEWP0eEptLlyt7NKZGi/mUJ+J6Q+kcrpNdv0I+rbN1S8p7ZZlcW2LirG?=
 =?us-ascii?Q?+pDEmhSOOiEFzG0BRqJnrPixO3Zq942ZSnQo4Kh69CsPps5LljHXIH5SX0jW?=
 =?us-ascii?Q?r0b400fDmcoPVGw67zC1eqCAsizKBfiHeT2wUpxHBKIeJWr+xDHzIWRE0f8R?=
 =?us-ascii?Q?F/oEG/67/GtegaXGw83ZetnSaI2wpu2txpNV8vBBAe/BbwS7yiJ8pdEk08qY?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6p9njgyJSeteBpalanj1dzCss752P/+APU7hY16cPO0zZwGbIFkr+MRBSTYL/7jAeyWzCvzFHGLqB81VgNF8J8L1Z+Yr9pVGQvSyuq8BpZpCyYp5wEoj+nyIhd+alxmQV2pnUyuXfiEuW+azpaOuGk1CqlYgQ1pDj9O+5ifkzyBqvXN7TfnGdffwC6HaUvgsp2ti+dUCfDY+z2cxmfGULpUphrNiP407X/I2LArOzDYuT4D7ZGTdCfn93Fgvp5m/GqtvNwVaSowk1d978zquZ42ekSCb9BOQFdsMpTUZdUfnULQESAQQ+217or3Idd7N416yfuU4Ak6RineJLN4W0+FXW/tMJF+ook/YE6Q460XeGJwjhMbCFiPuAexcEdX1rftX0IiqLswW0P3U2Qu8DI+hiAvBhK5tf6gNvEudxveJpfH7HMyKXw3hxIAWqt5yaRd0PXUR2klAEkasm32JDD+qgqJ4nwtqMTDklHMJcwSVMuJcp+tkcncEOKVhLBP/6TWk0GF7LzEzKh7UCrjvcN6KlhXmYoVCpUdsKKhrp5/CWWGr/+hFAtOXHBN/VFThxdM7prXNuF8rDQozXdWJs9J7/MpEOgjd9avJztikPPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4007c734-82df-4802-b79e-08de3c6fd2ef
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:53:31.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvXraG+loDL/6B7FB1o1fN+0/9mVFboeZXhDqc8isgvRlrBANtr4Lvew2l9rK582dRsIAZjRcnV9rREDcDrd6f7mFIuqj8gBIDSRTXzCSuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF92DC283F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160055
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=694101f0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=OZkJzbrT2j6815B65MAA:9 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1NSBTYWx0ZWRfX8Qhf03WxpYcm
 c8TkGEctak6N04Ij+URiDr23SHORrXhIRqz6wRmTBRmcV2Gkp8oAXQ45TwYfa43vxYaBnARtVco
 +5ZPi47ewHtd4Us0Aaced66lo36Z+jkqh3ZbXIudvHFqX0TX+9wsBAI2ywAnxNkppFe2fjJ/U4O
 40tGrAfbbTQvxWYoOey6STEI/6VcJlPdB9vAqylhi/W+d0laBRGgV6WCTZCxGa7rhJHBWgwl+7d
 L/c/URWwXWyFlBEH1KJd2Bc4pE5fND3Gb4MHPmdl+fe75ap8MoaOxOgV9ZcZyVUIkTbJegv9/pH
 Mpm2X0i6DhsGZDDtkrJHNDYEoOcbNiDK/YS0cti7R/qFr6ODzEgBsfAy5MUWMwoqNtvqo+cCN7N
 pIkfcdi8snWMGwiQYLJ5t8fQoUSInrgadqHSwAX7t1Eeve7EoMo=
X-Proofpoint-ORIG-GUID: -EdT20Qbje9GRCYt9XlZ0Px6mRLwBOVT
X-Proofpoint-GUID: -EdT20Qbje9GRCYt9XlZ0Px6mRLwBOVT


Namhyung Kim <namhyung@kernel.org> writes:

> Hi James,
>
> On Tue, Dec 09, 2025 at 01:01:25PM +0000, James Clark wrote:
>>
>>
>> On 07/12/2025 8:57 am, Namhyung Kim wrote:
>> > So that it can measure overhead of mmap_lock and/or per-VMA lock
>> > contention.
>> >
>> >    $ perf bench mem mmap -f demand -l 1000 -t 1
>> >    # Running 'mem/mmap' benchmark:
>> >    # function 'demand' (Demand loaded mmap())
>> >    # Copying 1MB bytes ...
>> >
>> >           2.914503 GB/sec
>> >
>> >    $ perf bench mem mmap -f demand -l 1000 -t 2
>> >    # Running 'mem/mmap' benchmark:
>> >    # function 'demand' (Demand loaded mmap())
>> >    # Copying 1MB bytes ...
>> >
>> >         888.769991 MB/sec
>> >
>> >    $ perf bench mem mmap -f demand -l 1000 -t 3
>> >    # Running 'mem/mmap' benchmark:
>> >    # function 'demand' (Demand loaded mmap())
>> >    # Copying 1MB bytes ...
>> >
>> >         757.658220 MB/sec
>> >
>> >    $ perf bench mem mmap -f demand -l 1000 -t 4
>> >    # Running 'mem/mmap' benchmark:
>> >    # function 'demand' (Demand loaded mmap())
>> >    # Copying 1MB bytes ...
>> >
>> >         316.410713 MB/sec
>>
>> Should this now say "MB/sec per thread" for nr_threads > 1? I think it could
>> be interpreted either way without a label, but I see you divided by
>> nr_threads in timeval2double().
>
> Right, thanks for the review.  I think we can add it unconditionally.

Seconding the MB/sec per thread thing. But how about also adding some
kind of a variance indicator?

Maybe something like this:

   $ perf bench mem mmap -f demand -l 1000 -t 4
    # Running 'mem/mmap' benchmark:
    # function 'demand' (Demand loaded mmap())
    # Copying 1MB bytes ...

         316.410713 MB/sec/thread        ( +-  0.56% )

--
ankur
