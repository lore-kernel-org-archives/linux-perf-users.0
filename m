Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DA26388C;
	Thu, 20 Feb 2025 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077764; cv=fail; b=AauHHVD+nD72lF0VCN10Ov5P/wrM9ti5DZRdOEXe/Yim2cpt/trNo5O3Pdwd9KkLxpXvKvm3xzpq5X6WvT5p2R2/M6IsjYwoWctY92FIIbu1PlyneqYQ5R+iXTTVPqCgak+L5+v7pwcs679w5v24c7HNd2LKT+SshAAdW1cRysw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077764; c=relaxed/simple;
	bh=pAhwEsFnhfbSkOTTH6X/elljhdoRR2fu8Qo82iLWth8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ANXH4RVEomlt3uZ28tWUsAHLhydlwiAhZB4jUYZQHQ+OijBsgsPBS+3uO6lpaqHCvSjac17FLXj6WZyLr91a4iVdXBbf1/zrr8UbHjlHNHlRrmVLCCfpbz5mf13zitqR2S2iIZ6Z1kLoQ//YrIaR9nV9Ls7hGgaA2MZKNOJ9c0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eT6BdXKC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VgZ/46uV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eT6BdXKC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VgZ/46uV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMb8p027057;
	Thu, 20 Feb 2025 18:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xFTb3wdqEqDA/iGP8UXuzKrI9oszXMASQZbsEksZi00=; b=
	eT6BdXKCEl94INxvKqIiU7vtxaiqpUBa/qPh3YkZFGBFppIu6NMfGPrtX+P+bn/7
	hZpUzF4CWy91p21ipJvJvKPnzlONfeHxcehDEzeDwOVh/STleM79T0W5aXC7lBUM
	s0xadMa6nTel6AtJ4dbMG6+6gxDTFysLRbh1orVJ1+uJpWfzoSeido2O3kw9BYps
	MDXGqM0KJmswdU2NSju5OVGh328qACwVXJZoyKQ9de6yNMOi0XT0FpY5fAEnWnbo
	yiabQgkl9p5tTq3jNqhasT5ZIpwcUpofJnvkzLHp5n4qSojBWCOAY8bOQAKRguI0
	S0uM7VIygOLdnQhXw8HIzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pvt8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIOTva009656;
	Thu, 20 Feb 2025 18:55:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09ebav4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dnk1QpGu/NpGCCwpWMyMuhvU++ADM/S2K4u5kCbKpbnxT5z01RWjHwVTB86qyvmx2d2XCD3LpEXSTrIj+cp4O9lEKqETZpX0d4RrbfH/kJWIJHPy9p9vCpdesTG5ZlEb5EAwpQKtkvF2UO4y2v6uo3OKY+m1Tgkl74K+z8cpQThcYBFLF/PjtkZSgqzi9vlFGigQAGjuNcEUhPWFEmwv7ol/j2/XRjQa4kbSlOXBQtc+5JeKtH35AhZymnaEGYgfIstLWj2cA28yhSHs5kBJcOMxGtkz80u3Hm9/ah3Hw5EZ8f7qrSHPTQXbiCzul6lqDM8FzwALh8zruh7hjHQvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFTb3wdqEqDA/iGP8UXuzKrI9oszXMASQZbsEksZi00=;
 b=SrbXqSfUU+40igx3hGyQIliLa6V36PG7N9mELn1i64QqTLd6MB/y99Q9g2R+l4pLSYbzNz5JPlXyvfvXKS5uADHXlANoD52QXr9gTMqzu6O0dtuA+UP7Vm1dZ6BlSPew1g/4MZOeT5aLRyGcQUCzDHJEcG+u7qfzikTGwetDvEUYOVnVb2nOzXaQmNYyd3NFGyk0ulP3sCmtrNe45OosI5V0RZ+zVsrOESOUyBbi9q5BQS++leq1j9hpOb/Zh2ONm/AAJKUaTiITlB24Ebtkbn1HI4A8FxgraFyWWVFq8N88+MImMaPG5JCUFBfyQsvWQ6kUkLEarCbcrYs0YaozdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFTb3wdqEqDA/iGP8UXuzKrI9oszXMASQZbsEksZi00=;
 b=VgZ/46uVIN5huS+Fsid/MaetIoM+rsa3+6givGlX7uIw1t2deHoHrxT5lHLLPDNNRomOfNSyBVHdpihBEO8srXLO/3BiAFk7AtENxtKw5GyvDOvTmxSREfMVqXkqVzc709BZkdfLYZcjRIIuG7keIhBt0XV4fR/XLOCwy1Hpboo=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:55:37 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:55:37 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v2 3/3] tools: perf: support .gnu_debugdata for symbols
Date: Thu, 20 Feb 2025 10:55:11 -0800
Message-ID: <20250220185512.3357820-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:408:ed::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: cd947c9c-f61f-4b20-14b2-08dd51e029ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?roeYw4HqbQb6j0HO2z29FhgtLw2y+GZVuyoop6tpItQ0ZC95DntB3xHz11Y+?=
 =?us-ascii?Q?2eDOIZqsKF1O6UZie85guNf+k5IqwqujorC95etEsrMwhjnjAhIijMm2/doi?=
 =?us-ascii?Q?drw/8G0u6O2pUXKCukmi270LAM9NFj3rvK9zSPSwgWqOn7gfHkaOx2dlB3uf?=
 =?us-ascii?Q?qLf3SRCSAJxRKEcv1dadFnc/IkpatmYHeHQeIvklMYRBBKBKw/3nfzXSqj13?=
 =?us-ascii?Q?GM4K3ZlTxoJJXsUXVVE6+8BsJFsvnYf4CAX2lWCZxz2IYLrZWQV6mElDnbpe?=
 =?us-ascii?Q?lOHanqjXfRIYfzOplTMMvAQU5ywb6yepUo1rCv3SmeiOsBkv1CQ/4a8YKw4x?=
 =?us-ascii?Q?rildG4h8dtynAcIs2Lpm7m1xkJa8H3w0CokKtxgjcapZud/U2/uPfjFz5xsq?=
 =?us-ascii?Q?J7vJEOiqmauQxJeXuXyFlt9fGWajjCVXgzDgUTVTxUCbaSGK51twWM/jmwmM?=
 =?us-ascii?Q?o+lrYZ4jffIpw2DuwYz2hxSnj3bWkTwhTUNoYOjRsavZPyWEyUbKsP1q8MIn?=
 =?us-ascii?Q?51kIxHgXvukbqcDLvZfPImpQd8QNoiLJPL6rH6Yk27hOctFK1HyrANxP1wPT?=
 =?us-ascii?Q?t0DkIm00xvahva/eq7F3QOSf9kc8giBTYDV37jOUdo1EPo/UAU+DXcHJPVo4?=
 =?us-ascii?Q?xsuslKsgP6jctpP2EwEfNllRBg+NOu/QPwZnnehJL99GHNKPv+vjtNGCagTO?=
 =?us-ascii?Q?sfJESwJE3RbVYags3BQ+qLYShSgQCT0d7CnNxLXqwpXlISjWF27gA7velFiS?=
 =?us-ascii?Q?bSNSZbJGZZzyqX9pWuSCuV34PfPjhfzFdwOmIfG8AV2R/q3EQbCBF03HtiW/?=
 =?us-ascii?Q?kxjKxpCr3RtPMD+sY2URhHGm0CK+BmwFyYVOsX/7OdLNfUWy15b7oyYIvi0b?=
 =?us-ascii?Q?CutOdV29tsThx1vc6ONd/t0azugZVi87E/4qRkP3dYsP2BQKiLCWcxrybfQp?=
 =?us-ascii?Q?08kuu77ShoOfWtWB9RTdOkVjO6NMajqCozKdnXG+1Su4utcv8gJq480yDT/X?=
 =?us-ascii?Q?AcR9cizxkWj7Cq1rmFHMctrgsPNrDeU9A1T/DFPAxH7Cw5N/ypiiOoerCwFL?=
 =?us-ascii?Q?d9NHYL0xIxCNBHoibd8NpaTWfzsA9j8oeCNQe+mS4J2T18FG8xeZM6RshYPj?=
 =?us-ascii?Q?K8LAhIZiQTVCQp9bhbYRQXphAKV9e4szGWKoHvCtezL+KhJepWJlt7WLWtch?=
 =?us-ascii?Q?M4n2jDNISvc3/3xBGl3WZFKREkqYCPdHDcyZTttL8Bh3xDxsNNp6Re9FWxdJ?=
 =?us-ascii?Q?+3MKVcB2+FQNlhaC4DXQaCTlCcMlOO23J8QcVNU1IR+0Gt9hokVmBz1CdXQL?=
 =?us-ascii?Q?3OOhyitBhbKiJKlWbnA6S5CqVOKOQdP6cIdrvfx/Mf+ZLAZMVBgIwLwudbAN?=
 =?us-ascii?Q?dCuC3LK+eyeQYyhi0k9YrQ8Frha+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tOvIsxYhj6DnBM2W0ztjyf9kPjPTqoVUnW/jryGGrX8TV03LMzg8UV9/P2lB?=
 =?us-ascii?Q?OPZGaJr4GOCk8Av+8LDxeJspAsOj0qHjTIfNnWEy6Yjfn1H2uAW8sSxeleBZ?=
 =?us-ascii?Q?XWREC+RmQ3I23Fh3i3GFdvJCX51d06XfDcvrBySN0z+LIFo1zj/RT1ESs+FI?=
 =?us-ascii?Q?OQf2pA5Oo556kvFlNjsPLunsUV/FxtAfT+yTjm1cCTC/J+UJOdr/hSsOoH0N?=
 =?us-ascii?Q?1B1haMS1N3Jy5sdiTYZDEO+ZvLCD9Udd0dAGxMwDE9VViPn58Uds3BU1124Z?=
 =?us-ascii?Q?kUL7udcMMpeVQBZp3VCEFCzN71qk/nIRfpwIKmiLC933GeHo+SzIphe+Rd9e?=
 =?us-ascii?Q?dq1UKXfYU+Ee9FrDValdKTERdXhH7szeziuo7m72w40h/+xPhSIj3Msbv3qg?=
 =?us-ascii?Q?aMGIheyjN1rLpk2PHuqnxgVWclpQub/wZxtNXnk6/csNPuIEZCBRRkk2s7JF?=
 =?us-ascii?Q?WYrQvxWI2nZoXeyZpCoS4I1ANDCSePsBc+cNuLWLk7FBheWlOvDOhwnpMEnC?=
 =?us-ascii?Q?LTjakHXe8+km98WqvMj0oD1s+8nVCxEumP93dOoTyAl1zbUKb+gQeukeNJfZ?=
 =?us-ascii?Q?t/AvKMoNL3WCGdUfFdPGRR7+tFLxHLYyEUeGI+x+Va4aIAGva/AgYcUit/fB?=
 =?us-ascii?Q?JSkq7jSk2Z2L4rKVC6IAUDO0/wCu//UnM0vSAx/ZTVBYhwd6NMONHZ5SkTqX?=
 =?us-ascii?Q?2Apg/DOShSDSB7ty0aIHd/Eg4Fm6MOwiSgj9omF/iak8gXETv3/oRBFVkEXQ?=
 =?us-ascii?Q?rWUiQIf2uF0SH7TQRQ2/w1c5RTfxYJKvl7Aqn9mVtLFoB2b2vPhqUVsh2OeE?=
 =?us-ascii?Q?8vvvAAC5zN+mbCYkRzYgAhTbxe0xv8Xe2buXIeurEKMWNn4RVny3ZmOGp8N/?=
 =?us-ascii?Q?Iv2ehTyECy5vyt+Z4WGUL1/BQbv0dX7Tho6IpjUOIQvvqhD6vqU+ks6sVdJq?=
 =?us-ascii?Q?ex8JO01yKPQhR3Z8mQPX/cyOJw23DrfC6JC/ljoAvQcH9V9pmQxCCFUV58V4?=
 =?us-ascii?Q?0lP4C5s2DrFxx0TQQDIBpsFUpA97Vxs4xCeHyvCTPr4iyv2FbVSmBvoLreeJ?=
 =?us-ascii?Q?1mPxTVp3BxGcNEtOLNB7AHA3fxri1WZ/i6Hn1x09/WpqSerXm/E0dHehK0UI?=
 =?us-ascii?Q?PuSyA1fAztip1W+MDs++mK0UQlYym8M3SGl8YnLczS+SWpL63qmyCdNfj7q/?=
 =?us-ascii?Q?ylskS+DwRRAcRQKz5jM4ho1jRmmLhwOnk7cjV0yLO6cu7hH7xi9lVUjy5WKo?=
 =?us-ascii?Q?wODK34AsjdPLcbUfNGTOB/icqVUSmgsfNqvUTvwFN8+HM2q8bTMZGzj+Z6XI?=
 =?us-ascii?Q?wckUixjWPzTvdE6mrDiazpm02ucbj1XY90aCuQIbOqiJiQ8FV/XdSaBXQ+sL?=
 =?us-ascii?Q?zJYkHtoZHJEP+TqFBsBB/e12NOXhjHFtSL3H+eh6BM/AkdqkA9aecUolubnv?=
 =?us-ascii?Q?l5eiGYGdsIkIOjvDuvH/+r2StGHHCEXwMh/s7SqyCHlv5d91REqI6BV74+GZ?=
 =?us-ascii?Q?Ycm6ZbbAHlTdHj/9udWpg94ka/z9eUiYHnslztXNdj2MFMMyEjZEE0SvTS7a?=
 =?us-ascii?Q?Fqov8kN9ssgtPIbFyJqIwQqUrOrCWLzW25Kzd2AUpfv2kDcREantjx+3Xia5?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NFiTrY0a+yxN7I3V5LGYUGajL8lAqECKtCWoYId8l++NCifgo0tFxWG2aBfSJbK3uslQ2yXNfexR/Hs4p49wROa9F3pAQu6v4U76ErbAkTRktroqdNo4sBVe9wd1ycTySpojnrhU1GIvpGQwgYBe47bhBpUykuVctOAtdG+1s9EJjg7BwQSJsPoKXxmbXNubg6navn8WyMuLSY6sPDC8n7MNPE6OnvsfuypJjGE00ESxzcU7FEvlFXZrQna5YBh2KQ7cIbmjdz0BwkgDox05KqQlR4da0sk8Cq231/Cvow3UzideeYQxAvyRq39GjJfN0SEVE5SlKW5C8VPU2WTc5HTU8JMAlKo80hcZ85+3Qq7JEnXBASQB6eyIhQWoDaiv6v/qU/tm2bS1utfeEmgJSnRgk//4QNy7g83jqkk009hZNxaHJjZpdCWWfF8ogTUyidnQJcfgyLlwY+pLo8oo26v2PelaNqBs+cVQKhha5/YUeiLcBqfFaFGEKT1PC8QJmA3noWUNSKDdFd63CtbfI3ndKXetEgrCKBTtRVF2HFa23pwoSY/FgapU17LlpCytaz27gWI93zqBhpkA4XLxO8B2jRbTVDASr7uF54oAZJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd947c9c-f61f-4b20-14b2-08dd51e029ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:55:37.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKBJ/jVTKdoZTzXKhH9rqXSfC+d7icRDyL8nsq7EbFMlsQ2bIEmZbRKNdSitGFrfl5KoCKBdDnQ107eyjFwujviGFyCxOBo5i/Sm9efaufY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200130
X-Proofpoint-ORIG-GUID: NVHa-OIFLT6oYr2wD1fsFqHzu_esdJ-L
X-Proofpoint-GUID: NVHa-OIFLT6oYr2wD1fsFqHzu_esdJ-L

Fedora introduced a "MiniDebuginfo" feature, in which an LZMA-compressed
ELF file is placed inside a section named ".gnu_debugdata". This file
contains nothing but a symbol table, which can be used to supplement the
.dynsym section which only contains required symbols for runtime.

It is supported by GDB for stack traces, but it should be useful for
tracing as well. Implement support for loading symbols from
.gnu_debugdata.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/dso.c        |   2 +
 tools/perf/util/dso.h        |   1 +
 tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.c     |   2 +
 4 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5c6e85fdae0de..67c21999628d4 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -93,6 +93,7 @@ bool dso__is_object_file(const struct dso *dso)
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
 	case DSO_BINARY_TYPE__GUEST_KMODULE:
 	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
@@ -224,6 +225,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
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

