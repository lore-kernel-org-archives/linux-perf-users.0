Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFE2135D0;
	Thu, 20 Feb 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077736; cv=fail; b=lxb/K0JcVxGO6CIWNclYpUiWQGohth37KpsxOzWSoTXXvT2KxnD3szTQDEDTCfaYA7AnAFwUHFaomZSHeLSVe1VAnDK5j8/lOQ8egD+BmfQOV0hGAe/I8A0Af/aK8MHjg1c66CliTLidUzsUdb4Np4mM5Kc3czpnmkg1j+pWRug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077736; c=relaxed/simple;
	bh=Va8TrLJTsKX3kNtYHIwRsTaPlSxH8+ziWI/i42K4LpA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aq3bOvE/Rt1NUxDjw6FP08msAXDZ8cG5zoRSqe+BORKMHcuHqmLAb8JBeHBn9esIyh3oNO1Ifb6S50dOa74xR2XN1RRGi3A7Uj1x0oOpgr4KbcmkIEsDfWneJXUzjri42YsPSNoTSNbBWrcBEC6kOlbK9RvAWXO6eSSg4Q0vEr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WY62kICV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oxLwI8qv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WY62kICV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxLwI8qv"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMX1u013674;
	Thu, 20 Feb 2025 18:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=n0EAwBOqfO5R2hrb
	fpWLSlCFEs2UNM+mmi3qSo6FRyw=; b=WY62kICVa2H+KZi0FplIdxBkvKYg5Ll6
	MwBFislHbxiD0UfG84V8YtUWiE5Ef2JhnirOmtEN42y7ZxqWdy+0YCG/CPpwlWSB
	8S0c7pDUPCHbajof96JzohIpidexvbhzP6ZJoefUaRXP0rJSd7INQ9MOHgB3SpC9
	MDCsjWQYY5OENqmZlqcVm2yvIO3pkiHcYoDeL9cQfhN+fJ/UM/TWypEiTfhykg17
	knJu7Qk6WtJ1j97ftHUTsLaL7p19r8s19sVkFX0elN+CGlkVDMtRzF0hPlfpbP6R
	p0/2wJPzfLLz1qT/LbeQwx69+0PCxdCekIDUBg0ojpH99IzTNxqKVQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kmv5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIjhww009796;
	Thu, 20 Feb 2025 18:55:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09ebabh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNGF+WbIk/9/oWnS+vX/dnOjJpHuXdVT6DRMrvHtBud+mh0Ms/FtcEhDye1X7hnToa/QfRXIge4nzA4gMfJH4E9frLItDiL5rfF7Xnwb872KWp2QYopFQcT0koK1yCHNqOHbgIG91lr1mIgC61OhTI4CYrJO91Fg+C0fLcpmyETrTO8cPDtjvUidoGJz99i3bZsY38i+KLJNe2XW0rZpBTo9qnQrjL6ZELjzHyZzMjvKdLPF2mO5r3xdS26ruJRVWWyhDRrpRRFiKWqpfssyEqm4+nbPoBqqmACAyCAStiXTP8TQFd2i8f2A0BFDoyBZpuooKy2X8XU8VaOyqeGrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0EAwBOqfO5R2hrbfpWLSlCFEs2UNM+mmi3qSo6FRyw=;
 b=soZZzS1enUokWPmK2DObWhSTJku5KwcriQlqE9phVhx3O39+B0OoCyzcISTmPnW2e2y5vXMY8C2xwxzzewDCQJGRC1u47OAld3EAAF6H9VTHYMxLnCZOj8NZZbxAgDYsRLo9qwxPaYaKg8+YQ7y5hqm7KSdfwDZeaG3yEUA+95vbH1sO3bM4DnJEGwPucIe77QrVN4pMwSk0A0WzOQSdnUGGLai4uxA1Pr0lvfj4LvWuDk3pqntdfaZGmrmBgdymVR/v46KMKVuV++prneDP5PdNv53GYZx3YgpAe9qsK4r92IXFVfOpcx+HySIjtbzvYxtCAYyBddft0T5Pj0EuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0EAwBOqfO5R2hrbfpWLSlCFEs2UNM+mmi3qSo6FRyw=;
 b=oxLwI8qvE7ak4Mj3mRXCnRQIVvXwHLwxXn1L2F7LQUKhqQHeuJMGwakEHjp2Jgox1TiiNZpjwk8nJ4bS65pOqsFAeLIB6ckqsSV/skhpPfRwcaBamm4qRgjwfkPbom7yKlevXnM7sur6guVJ2y+MBRuafBpyZhn0EL6zCCi7zkw=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:55:15 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:55:15 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 0/3] Support .gnu_debugdata for symbols in perf
Date: Thu, 20 Feb 2025 10:55:08 -0800
Message-ID: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:408:e5::13) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db67789-8da1-449d-3e1b-08dd51e01c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdOH3VMb9XRUVJRq0124YnOoiFdtydU++D1e+GW0npu3pYz0lUvDHPGRw7sH?=
 =?us-ascii?Q?uFK9Rz4KHfvJnMN0erL3w62Czv+ZfADBCCrtEa9A+9ED2Drks3H7n6C65MvZ?=
 =?us-ascii?Q?7ag45sfD/sApo9DwUicLSH8EGShSiB0dIl0cPO7K+tpFG3ZwUMQE07uGe16v?=
 =?us-ascii?Q?0VfZthgczDaqW+kI3xNzHxbaaw/Wd1ey8oNBAjgRZ6dYTaCGQaVUkWCu8Q+H?=
 =?us-ascii?Q?2/1jPmPXKbYpplTk6gvTYvAdU8Q/6L8LNMIU6C8b4aha9skE5SrN62ajqlSt?=
 =?us-ascii?Q?tTbDyqUWGHqsB87bAyGSrvUz6xNXcbLxMRocNHqk+PwTc9gpQ0J5lumqssGG?=
 =?us-ascii?Q?hz2OXhXB1D/XtN2fO96eWNnK+zpgU89AqNpmnxYFUImO+Gp6/Lfv73otz5ET?=
 =?us-ascii?Q?MOmP1zh/o5eU/HEHZTfOHP3NB4TipMTIP0swoA7MeATy655eAxVuoy65V3oy?=
 =?us-ascii?Q?AYsGIpksXeCNlamVojO0xtQkgztSAOTdjEYcuzYLkfPQvH59eajmU/C7JJoh?=
 =?us-ascii?Q?fBwAstQJuvCxdGcEyKZ+Gt+V2hsQ60Kk4EipIcVU/92LAzlcPb5l/1/mBi37?=
 =?us-ascii?Q?M7u1Y6DRsh80Ih5d2R4gLfn5Ly1bHVUfzFrmhivj0f6J2cEg3+qx3zkYx4U0?=
 =?us-ascii?Q?GR+4VzAFMoNdPaKPOtMhlj8yjHsgo8LhyIo4dkgKJVn0B9KUJ9m5zUh20ibK?=
 =?us-ascii?Q?xiEAcd8Zec7n+ppdXatFdgRV1aiWHAH+2Mb7YoITiDiEFrkHorB9HJBuuZUZ?=
 =?us-ascii?Q?yN7M/kp1HF0HBToWmCeadmtfYD8y32WLKywGzrOWY2PsntRfurJGRtiTCiW5?=
 =?us-ascii?Q?+i1d0N3m+qc3Kp9hHkEnXKWHzUK7aQeq1Ua3xh4zojz+aj/2JOeLoSLq9+j3?=
 =?us-ascii?Q?FrTqHnkbaZkdpDKpucly0hLS8qlknHMIwmFyw/LOPDbjyi8JqDf0iofXbvYk?=
 =?us-ascii?Q?Yph/fdE5ijui+3noXiidF7qTsmPFjTtaD6UAeL4o/tGcDVrceyO0BJnkCvbD?=
 =?us-ascii?Q?ZPrjeoaMcfZEsc1k0QCAZu4B44FAO7UDwHDtasLzNbcoNMWMG284UkfbR8Ll?=
 =?us-ascii?Q?1SNAyRtnUyOt79G1bROiBG4zQQO0m19nVyPTz5sBTthMbtWb5v0sznW1nqzX?=
 =?us-ascii?Q?xeklKwORzJT8NZHiHxemegMPEC/2Wluyg4FZoYX8SqclUOPXVeHkRfef6fsG?=
 =?us-ascii?Q?4KS5nx5gCAN1MG/0ilwxb9rQe42vNbisJ6Q4KoTEURo3TyuRPWRVUk8OUGI+?=
 =?us-ascii?Q?3jJTJ9W/3W4EjHyU9FNSO/N1lnHrtcbs4lh5o88OiNj4Ggq7eLEmxwalD1L5?=
 =?us-ascii?Q?AIxEu2t6DwggyCNM5GAK9Z04VrmSOMtwBJYwzQAbLPfv0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCQAB8MXBKV6uOMNMwPlaTBS9gnr8DQvYAH82WK3orB/333aGKOW9Tts5Y9o?=
 =?us-ascii?Q?UwbRN9M+5+LMJaDDey2Wa2F1gFWcILVidLSpAilMhd62ONuWGpdQCflmzgI1?=
 =?us-ascii?Q?04r1a8CvVRmFAENG9oipQMIlx582SNQHx8XjqLf/pvR8o9NXFZX875dt+5FS?=
 =?us-ascii?Q?9ETauarzH/8RAJDtuKLquVl1ocfCl/fE5Z2SnZkuFBnC9i4AK2n+p/RfPEBj?=
 =?us-ascii?Q?wTdWF+aIIkr/7+VeJgLMJ67XnrjWgBD7X1BACiPgY7VtztVBM8/JZh4CiQU5?=
 =?us-ascii?Q?1HkdmCQbxwRJGBLYjuszuhqIRDojw4LEOPyUIRwHxqrZJcBF06LsWsGOqHwL?=
 =?us-ascii?Q?dbr0zVtguiOecwy/F4wxJKLGPjO4Fg7dZIPGlF1Q4NFXMj1eb+sooIPHhUKt?=
 =?us-ascii?Q?niAnto+Ti1Vbp0c8F8Dn8SqYuSX/SsRLN+O40MARVE6JFGFsiEdvNkMtFKeY?=
 =?us-ascii?Q?6VdvyqPad9sLQfEshG0FqQAtbWyZ9axYTjyDVncTOvav78emZktgNlNLJ00k?=
 =?us-ascii?Q?F0x8C4av7ZUVbFD+aT9xuQaFsy/lM6B0oIGUPA2s30BnGOMn28Ybbd5MZP3/?=
 =?us-ascii?Q?m5CdTWttmECiLgmywJnZZZq+J4XgeW1yLHfi34eHiSWga85rEl8BwVgbVYZS?=
 =?us-ascii?Q?1q2p2NdURuxc+XzDXtnp7sCnUHWsxQFjzcmzkW7o0iAknqc+lOe7Eq3Af8Ij?=
 =?us-ascii?Q?VC2ZFOXAn99cIsv/e7OfF+dsYcRC/XUXUYCaiLebgdFPBs7k3D3CaFmoc88H?=
 =?us-ascii?Q?EBxSVIhFmewvAml0R5OMAP7KzJCrbvyuII2H6H0sWCUtd2cfKvTLQu2kF88A?=
 =?us-ascii?Q?d3W3eEu3egppgZRvXa+jCCwTJTqTODj5AykwuueX0dV8FCIIbbnL/4BJMi3N?=
 =?us-ascii?Q?6dnh2Fu+B67Qr5tFhIeVxFKfiWLLHvd3+qHO61ovmkrx0AOOsEfaoJzLe/gY?=
 =?us-ascii?Q?kbB5rz70vUhFd+Ja6Vk4Viy61dLmVYp5YNiv+8osTitfmwE8PqQmfV9DOcBR?=
 =?us-ascii?Q?3oHhIen29y5I3ClrrgoZXGFDyGFdK3GG4GZWYYBV7SQ7QelxBA6vW/0/rB2O?=
 =?us-ascii?Q?E0MsibfE1Ff8Q0w54d6p63ZbF59hXqXEyOe9AK7ISa3AeRBiA7RWFVkWzAtk?=
 =?us-ascii?Q?iYcsSs76E8i3KjkvMXn3d7YFSO5oU3kAgtJgfQGrmVx/oc3OSxR5yzNwCXlL?=
 =?us-ascii?Q?Pf7ytiL+edvHaE6d0L0xHMOoO3KbZQFw0+3MCytnPN5uYYTy96hh0jrY3Ogg?=
 =?us-ascii?Q?P6LcsESGKY3pzAZdrEqRKgeU/X4+K6ExXDmOmwUKccuu6yHGEOzE1RVKxIv+?=
 =?us-ascii?Q?0ePxnCaeHM6ygIhJsEph1Kro+LTKtsXIF589RsUA7TeEs1PiA+w4YuWkbwMy?=
 =?us-ascii?Q?3M4vAHl7pcxuA8JHnoDInJxGvBCWc7WesV/2PyG+ZfFw1Mh+kq5RrDWfPS4n?=
 =?us-ascii?Q?EYWOwbcSjo0myZxEUJx5SnFhpupME3tkfPMj5j0sULc6GSWIhCknhHihKzn8?=
 =?us-ascii?Q?/3mWrfpahBrxZTpBgzP1VHTNXYjgs0q0+bZ+V401yzQ9QfV9hUTLBCaT+ys8?=
 =?us-ascii?Q?hNIidVwlbqxYwYpwa0MtBSH3Wzjm+dDWdd7BEZ5IT9joYzN9Myu7SMNmrrAc?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DwbxKIj8WeGMgjiWLZm6/hl4L3POq/rg6YefTgorphcvCxlt03SwLsc2+16cGO6YLxXsG9acaOwUYD9VN0MNDR2TJAroWOuFTkv0QgQ+1Bo+mpvPPQbQ1JvE9Jk3KknPdhq6SuqkkkvzYstdFc9ASiGUNKglIBTndjZsUt3wwA8WhSuRmkUVwV+mgLg5W/dOzTv+ff2wYvQr91lm9TQyOhg1Nh36wwodmBK3lL6CV+v3+h1rodzmBRw98z6B+ZeAKqE68P/q8SlcG984pzMTJpRKNKjRhWK4TrKItOJuZeJlxztjUnGz4O5lhvHzaq3IWXfuOJtNoHl6iKSJYF0BdDlvwGD3WGwch0BrZJ4XwvICpo0U6dElOOLr//P2uao+yrvGxpSaJhs/jz8HOdeOj6GPwUUmUQWVDk11Mtn/vBE6W4NZuCFgLNZDrGvGAFcpbK25N1Bn3ywCf6j9py5MTC0LFwSp4lJm4vM0P4pLeYGzDG9nXtPpOE96hGgqa8qDBITF65sRSJk5c9a3cWm7PEqpaQkfHmwnErXyZ9xfHt8Ff8DQ67ckxro6K6l49Y0VxhoSHuZGGKlOEUefYQ5zSXZBdLueSLHAl9t30uSWI+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db67789-8da1-449d-3e1b-08dd51e01c7f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:55:15.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ02cbnkBu6GJ1vCvwBEyeWl0VrO+pGr0ubdz30cl5K08IHcxixRic4QCzFXBcjx8RuHblCmD2oXhOjmSPVIjSMfUJ2YsTr9169xY6uySBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200130
X-Proofpoint-ORIG-GUID: XE_s3zHz_ZFjrGdR90N4S5DNZkHW9Z1i
X-Proofpoint-GUID: XE_s3zHz_ZFjrGdR90N4S5DNZkHW9Z1i

Hello all,

This series adds the ability to read symbols from the ".gnu_debugdata" section,
an LZMA-compressed embedded ELF file which is supposed to contain additional ELF
symbols. This is something that Fedora implemented (as "MiniDebuginfo" [1]).
There are more details in v1. I've tested it with binaries that have
.gnu_debugdata, and I've also ensured that the build & runtime work when LZMA is
disabled.

[1]: https://fedoraproject.org/wiki/Features/MiniDebugInfo

Changes since v1:
* Reuses the existing LZMA decompression helpers, rather than implementing a
  new LZMA decompression loop. This does involve creating a temporary file, but
  I think that actually makes things cleaner, since now the symsrc has a file
  descriptor to close, rather than adding a new pointer that needs freeing.
* I did also remove the pr_debug() for the case where there is no
  ".gnu_debugdata" section. That's not really an error worth logging, that's
  just normal operation.
* I added a pr_debug() for the case where we successfully load .gnu_debugdata
  so that it's easier to determine whether it gets used in tests.

v1: https://lore.kernel.org/linux-perf-users/20250213190542.3249050-1-stephen.s.brennan@oracle.com/

Stephen Brennan (3):
  tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
  tools: perf: add LZMA decompression from FILE
  tools: perf: support .gnu_debugdata for symbols

 tools/perf/util/compress.h   |  20 +++++++
 tools/perf/util/dso.c        |   2 +
 tools/perf/util/dso.h        |   1 +
 tools/perf/util/lzma.c       |  29 ++++++----
 tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.c     |   2 +
 6 files changed, 147 insertions(+), 13 deletions(-)

-- 
2.43.5

