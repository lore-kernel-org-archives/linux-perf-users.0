Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981820FAAB;
	Tue, 18 Mar 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338839; cv=fail; b=SdP3NH9FpsyHBy0uEwNtkmTNs+orK/fMeCZaUXBo+RNtG4kLuHYMHFSESMuSXNXrwW8Chf5ooO5/me8KJAkyatkxwjQFRLoz1zZo1T/OHgHFuHtAXPaQnWOguJi+KPRR3tC2Zy0wzjCXP7Yw3nC2h9BwNUuu81jPMq0XzI+sGYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338839; c=relaxed/simple;
	bh=zRXNcd17Pnm4+cfw15+fEarxIuDaCuyi+S8LtfI9wYI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d0kehCTFNXFJWYPk6mCgObUIU0mR2BuxCxZrKSAX3aR8lY4iK5PW+7/uJNuUe/oi+MmLYLMm+4oHTZJ+NAiUbzFZNF3+/8p+vSrv3RKfKY40XmZt2DgduhEgIx6hHeZZACumLwWAzIv1lUjiCNj+hfw+SU2YU1MWsoi73mr1ktw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SeVPR8Nl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q5IjUHDT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SeVPR8Nl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q5IjUHDT"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ILTvcN014659;
	Tue, 18 Mar 2025 23:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=tg5mLE11rFxCWArU
	f6zddHW1pVyYsWAdjWfY9EgRFCU=; b=SeVPR8Nl5VV+VVeWsjwL8BEpMAhoh5y0
	UTf2IcdW3X4p1Nf1f+i523BNyKxaIj3q7ClkJRqVz38fcCQMPZTwarqZZxHFk2jm
	OBqTlh8kx/bPdxLx+cT21e116DOuKJwLo+j1jE1BN2JiM1NWpB2PECkWUolctkht
	0WYMZ6gCIiXqOw0wrwArktEI/txVxhm2xVSC0nw2oC3E5caTYz+KULaYaxxzChM+
	iBkJkeU+HcwBSHcfr0C4jC5xHZv7GQ/3KQaZ/UPgD8LGK6nBumMocmto3F7NYl1K
	etEwTLM8kTLbiv6CUInh+qVSMMHvDWfs9chUQn0HTAsIQ+Vkex499Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1k9xngm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 23:00:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKv64I023771;
	Tue, 18 Mar 2025 23:00:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeg1899-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 23:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZCNWn/GG5l3wtF+Eu6xk0LHVQu2FwmZs7WeyYkG1/iD08UXFR7ajA9rzdshPwVJn4gJhqpURdgH1E1UKs4ZDy8J8LeTNfCzql5vozza1M9Vj57FllfnTyLjuQFoKZzVYXodrY7sxLvJOZ4nsl45ZpFVxN/tZys/AVV+sb00ADBplWVd7cXWbBz5uy6AK+LkpSMKD3S2b9dhxk8Rz3mk07WOquLpw6yzWJA/q4535oED9+VMuYNGIvxzZahSbsh7AX/SNqvMvJI7H9UVDfT2R12FGhBqDB1VN8CuOS1Xsx1Lnx6P0IMvnFdSxAW6MIg8TOXYInazJJBzA4jJ0KdEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg5mLE11rFxCWArUf6zddHW1pVyYsWAdjWfY9EgRFCU=;
 b=NaOWhz5TlOMW1JNjP6cv2PYLIOGkmEcek6WYd4p80NL93tz4ef6S1n/qnJggFQji+ES7mC7rjYi2R6IW/h5CzqypZm5Jm1vBJiuH2Q0VVz/49yMXzlkCgsbzwNopCc+k4bbbDLVoceRW89EZPKtCEzZ1cQMmcBTtAH2poQ4AJd3lIUXVOunB+8cx7cwOXIDyI6493dqJ5lSX2PTbGfRtIsu02sbRNuksZSfFGY53c2CaiwKr5EeREq4GHOj9dT9tMOoIQA2XFiXc6anVkki1q69C54/RwkF+n64nHFaY8w37WbpRyZ48gj2vBLJURgOYFnQGEUVQ6zusnYXsruhw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg5mLE11rFxCWArUf6zddHW1pVyYsWAdjWfY9EgRFCU=;
 b=Q5IjUHDTUoHW4cGNdg0XsOMIqtoKCst7icAQaDECp5NesSWlfL4e0OAi2l86XhPxmADLUUv+H0STCnMQ6OnnLYHxxrD28HNp5GF+yAdQL98fuK3QTNnLY+9Hk3hHDVppFQPWRtYrOM814JBc1zirVjuTRbMOZeZCtcFXRt79G1o=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH0PR10MB5684.namprd10.prod.outlook.com (2603:10b6:510:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 23:00:15 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 23:00:15 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf dso: fix dso__is_kallsyms() check
Date: Tue, 18 Mar 2025 16:00:11 -0700
Message-ID: <20250318230012.2038790-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:52d::6) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH0PR10MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5aea0d-6d6a-4db1-bee5-08dd6670a50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jttJS1pRTf/KROTI0W+O8saQBH5ZceFykjGFjiwpVq6riEDu40xyruDBvqNN?=
 =?us-ascii?Q?l4L0pmL7AicFVNq3UPX+yM5d6/DgQZRdRJZrRjSXaeL+JvGRX8mASfPscWq2?=
 =?us-ascii?Q?k0fjQBelleUGFZs6F8sb4ccJeRAXlmuZjXeeLscduvG/NUPD//ZeHK11+DIW?=
 =?us-ascii?Q?ehM22kIUc+X12pmrFlSlGIy0EixMEe+D3hJhD+HGw1lVvuHLBL01okY6Tgo1?=
 =?us-ascii?Q?oO502Dh/rvnHK6KndTIUIE5R0uZ+F2N0yP0HN563GmF6llXLtjlnxAq1/UNr?=
 =?us-ascii?Q?UkYFEIVhPzAWoj3STsuZrm5AMg3BSxbJ8Vhc0gELLcWlj5mUa8XWyfz19TBz?=
 =?us-ascii?Q?MTYRNaDxmmgp4HTv8M4QCjXEjiFR0EShElGtAH38SNYSBoIJzh4zLzVMd7o0?=
 =?us-ascii?Q?CbPhn4A3XBClZY8zlemU5dzp7vGfE/11iFrdhTrILiOfqbHX71hkJbVGhWyn?=
 =?us-ascii?Q?dsLlorosqVC5mBCv4NhISxQkdC7bAj+aJgirCJACCy6oFgBmRSjcB7slhnLu?=
 =?us-ascii?Q?x52hbJ3ZrRjLTIbLEtkm4Rxe7oXsZOJh2NkyNTftgCmOuunsNI6Clr3kDph/?=
 =?us-ascii?Q?DwWEKzvt+GSF/Rgrg0x1i6Ri/SysRmf/E51rK48tf0nF/cZrBIvkzDvrT5o6?=
 =?us-ascii?Q?QfPsIb0FImru5R6jiKfwvvCymxJhgXRLA5suzFau8pvCAB2OUMDY28RrYMDz?=
 =?us-ascii?Q?+jqb1fN0WBeuqSzGDL0RngLnv9YCMJ13Ylwm8mj/VER2pwn3a8Ab1FOaP92C?=
 =?us-ascii?Q?NjMhQxBe6KWSsN36Jff9k9m3vOSPL49bS6bnpazYbIRtr6JQou4Hmljch0RB?=
 =?us-ascii?Q?ZedWTwZANkCU5eJ8jx0aofe5tlDGTENUsftQc48STZnnX+2MKFRsB0HuLDTO?=
 =?us-ascii?Q?XUmPlOwkKb8wTrNzcdkpfC2m5uzw665QjX49ylFLQ3+OxbZHInpLi6yQ10yx?=
 =?us-ascii?Q?35yeZpyRZxxEzpEF0RGBVEAaaZwk7grEj4Bjv65f/hxFBGyIRlXmUsSwv/y2?=
 =?us-ascii?Q?8hrva1HDF7tgHE1uTckNzAbUO6JCyjTv823OFRd8E5RTzX6npZL+Qkinpgzz?=
 =?us-ascii?Q?G32YnVPRvyg6vhLcUQfTO2w0J/ZXMQow8jc0kmFljhuUr3NXB2umcZATmQVR?=
 =?us-ascii?Q?YFoMyTj7G7DTc8J9gm+Fwb5hwWJ4q/N/KRFc/iHAloKDDprz4IzMJMg1m9IN?=
 =?us-ascii?Q?xW2deOOOTd0CKjItYsLdGr4AEhmiT4ZXP7m+1udtTaujCuPSDjNnCGTiibuV?=
 =?us-ascii?Q?qSVHPhMRa+dDJy5e6rrG9eWqvDvzA5vgLCazaxH+Q4+VidWObNRpIAfOnLDU?=
 =?us-ascii?Q?2mW6WZUEqCW4gC4q8zSL2FQkcGSPC1UfVd09yNzNbIhWuJ+BoD2EabsICzYM?=
 =?us-ascii?Q?XrzTWCrrZXDcy3gmJgmMxcRGyJmi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xRkpifzrKtCcFCiY4iG+AMuV9Lg1I9qWzlSdhNqut1J26THCqBMhxXQ5zKpL?=
 =?us-ascii?Q?y1T3arVWCm9sr5UQwYD8YnJZYnVv+LirQTqESH+eHBDU4dJjHclc3Ombu8pZ?=
 =?us-ascii?Q?R0Z1HQ5SP+kW9AYKE9+Pr/b6zFwpI+O6wtOzKrfvWy9lc/W9wtmbQ+0EEgec?=
 =?us-ascii?Q?h8klApXjtMQxQ1l97UJ7t23FydxDP1yz/Bt6e4qoJr3jgJp7pXbtvnrYT8Tr?=
 =?us-ascii?Q?nzroAqbl1f0vhoQ9eU0H4bfekpXIu8HBvll5s1JGuhm1uLrfyhQv3VQY43Xk?=
 =?us-ascii?Q?9KJItIHSbUZ02DJEtoHf4k5O5FWJTDd0Z8bHFA7eIj2gImLWp6yCfwRb2D55?=
 =?us-ascii?Q?POH58HvS/H2tqK7xebS2KvENn98IYsa1lciHkJXlbtbLDXWEUA8bn7ZUkewk?=
 =?us-ascii?Q?duU0JZ8H9sSRSEnRuamVS6AtYMHiz/aAGFKPGYYiSns9HvdrUUVYdA+anJ2c?=
 =?us-ascii?Q?FMDmZWJZ/ZEOBCVe9eUIqiWJy00mSVS855VwWzqJW+2ykRKA5oq/Yx6/MO3u?=
 =?us-ascii?Q?DKpbyoT5gq9CUJIUlMrL3+USVAUJm7YZsEsR0M6OEg0Ub9xCNySpZ/O3jhXv?=
 =?us-ascii?Q?lmfQfDMZUl5NzMYDjlz2cQ7J8U+8YCzCOoqymCqiEIer3GV57/85oRLCqar3?=
 =?us-ascii?Q?Abi19T3hB8z8r8SonKcLjmH4lIWh+vi2xRwqnFiUBrqhO9IeW0Z6KFp4TsyY?=
 =?us-ascii?Q?4GhGWRiQ/3FzU0fYjvJWurG3f/miyQInhohBmWbdptj/WW3+4qZ8YdggD2NF?=
 =?us-ascii?Q?WZONEuWRbcUtAEZsucgJcpmK1+D1jsM5ZHYAKycFI5Zf1WmhCHYIwhgFhE3/?=
 =?us-ascii?Q?+7KfodZOYAOwxBBRmUltue59rPjDQ1wB3f/iUGg5O9t+nhy4E2B+Krg7GF2M?=
 =?us-ascii?Q?KDG70DLHZfEw85wqf9wA9b4WfhR53Qi48mYwGf8aViGzHGFgwawCo1YMHl08?=
 =?us-ascii?Q?3qDN30s29SgJGOlWwyypE9NW18EAbZzrvinDmCxLh6frNfC/JBLmsRQ5oIjy?=
 =?us-ascii?Q?lzjFCbP2/AMt+K1yfzDwE6+JFCGNY09n7sZkJMo013ykvwXl80/ZpPeA4bEV?=
 =?us-ascii?Q?qOx6ITXwC6ksm7EGJ1wYMHCE7S7fsF0EY7vdP1h1kl2wkmQA7lxn6Q+cLaok?=
 =?us-ascii?Q?35/rycrSEr2mTmLAOvoK6CR7Hdam13kaEOKa7qgzSLAU2iiUpFM3Pf4ago9m?=
 =?us-ascii?Q?eBjSqyI5KBpHDGJPx9nPElViHe5Abse8Z8IkenXXFk118Rr2YVovaJsg1J63?=
 =?us-ascii?Q?FBvIIyi1Y/ZhE74J/N9+qeuh8AUM71NJHKkMksry/D+zIsUeATsECvwCJiTn?=
 =?us-ascii?Q?bBQLnvt4BabxUYWGGzwZ3ysj1T/lXQHtcweN8kzx7zVYW+irgyS44wcGel+x?=
 =?us-ascii?Q?4so8OuIOXfRy0IctdTGyoIh5fq47fDodwdxbawo/Mc9yjdN2Lagc6YDy+bX5?=
 =?us-ascii?Q?mryFpHQUUKU5pgUoae1OL9D+AkWq6fIH/h9+ikvyiTOd7vOWIsXx9e6Z2rmu?=
 =?us-ascii?Q?DufLIP/Mo3VdhVQKYHzICKT8Jf2JNjrYdX+UsmhS407iZ5od/p0bYclpFbT4?=
 =?us-ascii?Q?uzdFQWT6uPr60sCCKU+e674ATwOQV2oKLqTbV5TBvlpyi0bCxPFZf3lrWrRg?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4YchL3zB2j+/CzE6eDIdZYgzPtxVabnrpG84iKQsLCcydYE2huD+j7+E+fNxDA19azua88MGnleKvWgrZZJzANG1LZVa8z8mdRIeCDdVDyMjlbUVugAeMELJqOK+jzxq1C3ONmw8h8MZLy163lgC6nlR1l3YOrnGZjlHywfm8TJFlj8e0l5xynYNKW6TnZJo0EChQhQSUMSqEhqS5Qv1R8eZK4gPJj3t+KkRmCUsFJfGdmKKmZKv0R5LarCi7jU2IuzNKG9pfPqSmNgmv/roPJB/mNYSphULOBR+80M74VYCqeK1GUPa/K4A0VECFlkfn8LzO0+eynENdEGV9v9Dj1lq2euN950tt/uAe8z3NwqeH86fOrTc4ktgcsfu03KOIUfOu7I6a/nMmm5zulvF1IYy/a0jdyEWYuy92bD0TwVCN1dt0CzoJzLy37wVHU8MFFhOYZZZ0KKFL5DGJEpU8aKsK6Rb8y0rNFiS1EV3eRNFAhHavQhUlQvPAqw/GclG3rPgZFKugR1g6Vd3SlWWY1r/rAwoWUsb2zIpr1yWeR/EW37NOz+Yn7l8DX2BzRJ0uCD2Vh+6SpBjiay6ceIjB5JDM3mVDH3SvsYmLKinXU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5aea0d-6d6a-4db1-bee5-08dd6670a50d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 23:00:15.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkX8WiMPKhheCt0V8kdz5J84ZpXCwsWEIcr+Okyr9NSju77c3qny3RX5OSK9XG2B/RVioL0foczofqjb+67IcvQcqWrxAjEJnnBYksj11NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180166
X-Proofpoint-GUID: V9FfmKIsYyGC5R68La7ZxOb2THObfpKv
X-Proofpoint-ORIG-GUID: V9FfmKIsYyGC5R68La7ZxOb2THObfpKv

Kernel modules for which we cannot find a file on-disk will have a
dso->long_name that looks like "[module_name]". Prior to the commit
listed in the fixes, the dso->kernel field would be zero (for user
space), so dso__is_kallsyms() would return false. After the commit,
kernel module DSOs are correctly labeled, but the result is that
dso__is_kallsyms() erroneously returns true for those modules without a
filesystem path.

Later, build_id_cache__add() consults this value of is_kallsyms, and
when true, it copies /proc/kallsyms into the cache. Users with many
kernel modules without a filesystem path (e.g. ksplice or possibly
kernel live patch modules) have reported excessive disk space usage in
the build ID cache directory due to this behavior.

To reproduce the issue, it's enough to build a trivial out-of-tree hello
world kernel module, load it using insmod, and then use:

   perf record -ag -- sleep 1

In the build ID directory, there will be a directory for your module
name containing a kallsyms file.

Fix this up by changing dso__is_kallsyms() to consult the
dso_binary_type enumeration, which is also symmetric to the above checks
for dso__is_vmlinux() and dso__is_kcore(). With this change, kallsyms is
not cached in the build-id cache for out-of-tree modules.

Fixes: 02213cec64bbe ("perf maps: Mark module DSOs with kernel type")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/dso.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb8e8f444054d..c0472a41147c3 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -808,7 +808,9 @@ static inline bool dso__is_kcore(const struct dso *dso)
 
 static inline bool dso__is_kallsyms(const struct dso *dso)
 {
-	return RC_CHK_ACCESS(dso)->kernel && RC_CHK_ACCESS(dso)->long_name[0] != '/';
+	enum dso_binary_type bt = dso__binary_type(dso);
+
+	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
 }
 
 bool dso__is_object_file(const struct dso *dso);
-- 
2.43.5

