Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022098.outbound.protection.outlook.com [52.101.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7B259C9F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303597; cv=fail; b=qqWed9/5R7U8isHfRVyfQrRJlBxk3P+jpJtx7pWhvlnwKpnyRYeDVxBG6sFcjlbMpQooiY9Z7uUVLR0vlzeLEg/hpypXA2bfxG9CxVSOvHozVZ9hgyjj5xUClb+ch8jm3JTorDPBcxFlR4mRv1t7gJBofZi0/zk8V26/xSwexug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303597; c=relaxed/simple;
	bh=Qz6K7qPAzGokxatdiNgGwAzKHmzO00LsRt4OgsqtoD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=sy/+FBRJSdJl9i/E5wC9w+i+oDjMvpihkbcotPRhf//QkZrAZmZYbQSB/W3a1SfcJiYcHT1jcqb01z0Bl2KybJ7aL+e97H1JH/T29pYHlZfi21H/l4Ne6YLVjko3upR6OgONNbv74l8S9nOGr2Z/cDydy+NHCmZaYFH1uANw/JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ILbFZ/Gl; arc=fail smtp.client-ip=52.101.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ILbFZ/Gl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy+CTt+AfppvZrnF6s3ZWdgiIN0bork9ksYXnBjQtWXtrcEtvYVaPHuYsNwWpqnGaJXBugDzW++940t89+ARIvR/+qbGlEv+vIF8aTd1NT4ENp1yrLjyXz17THSG80/NLI2yYp8a36Sh9XD+vEOsUG2/SB0MJy6kPSVjkdW9QVYTMTQLUQXiu16/SZkCngk2987+u3pE1g6zYD0l7Ufp+4AYVJiK2DIo+qulA7IB43XdP+yj2BjBHNDaKC7r2jS79o+AzZu9cC0EVZZhOgQ1uYYgmmjbnkWvA58VdvFzOTENi4O+HwKLyc9HJ9jMv7MfsDMtXRGcV8J+4xy+rGoe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/afuT174l6CZ5ozvFsvux603r8YGgMIn7LOpdtwlaM=;
 b=WL6pu2hpTM7BFrI0LQqdeyY+ppw497Q6uZpmi4UFrP5dtXQJ/kaupusf2qk89B2VMn2Ylk5OmsyHQuze0i+Zg4VQ0Obz9a6U1Z3x9SYSiJLzX79gjYcw5Oo+O9d353YmoBbSqS0YAYYJ3z2r193H2BFnBU/jKEpecvJZH9ssBU+SUiG66x8hR3rC++Ksg3VA1XiRLL1VAeajvesNBrEarF4jC2RVnB5mvleeQvHE6gIMWwTKAaWByzjO/O2bBmWOTKAlFtAc9z9nAuEfrURsV1mcyRx82xYy+cumgkuWHbMhyRAnz0wwT6BB9GTrcF7EbfuLp67jai1Tm0+H7fEcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/afuT174l6CZ5ozvFsvux603r8YGgMIn7LOpdtwlaM=;
 b=ILbFZ/GlIXU5q9eHrnW3I304RMhDoYTHEyUTTGVyoJqIyyfVmjx9a5vWEgsy4+sowXK9T7cZt+ziF/pbXsItF0XAcVnf5xl1kixgcRDxh+eUNDIhz0aeF05bhzEGUrSSBDEiYj4mi+/rwYzxJ1NEFFETgDqHjUrLw9WqnoB+oTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 BN0PR01MB6864.prod.exchangelabs.com (2603:10b6:408:165::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Thu, 6 Mar 2025 23:26:33 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 23:26:33 +0000
Date: Thu, 6 Mar 2025 15:26:11 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, bwicaksono@nvidia.com, 
    ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/arm_cspmu: Add PMEVFILT2R support
In-Reply-To: <cover.1741190362.git.robin.murphy@arm.com>
Message-ID: <d3388738-15f5-8b97-a793-867b8d537654@os.amperecomputing.com>
References: <cover.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH5PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::9) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|BN0PR01MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 875dd6d2-eab5-4774-8f2b-08dd5d0654a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSy84BQpfQqbVBkml/AM9YQt7Lw+rt7PL2BoAU7qybFwvSBd9ULXMtkXWoSC?=
 =?us-ascii?Q?8zsHfl0CII68HkQRDJ3p/6b3T5tGHo5BmdXSwoCJLz7+6JQUQ956O0UgTmQ6?=
 =?us-ascii?Q?zUw8E1jhD21W50JfnMFd+1dqpCRlPS6tt5Mi4/GC1G2SrVsgoLcadfBWVDos?=
 =?us-ascii?Q?i4BdBZg2y6th3Q9Gnd8MDLxOP3bnKZIPB2WEWlZ1RjbEbCOXLIJAmqr91MuQ?=
 =?us-ascii?Q?J1whaSztI1wkwS36FGtGbak52yjDFQKBhU8s/cco2C0JMPcOFE89gFaIjze8?=
 =?us-ascii?Q?wDiWmbWgBb22s+kQb34Obg/0vDBYhGoMHfKTBi0bbs7nF/4guxmhiOO++R03?=
 =?us-ascii?Q?r0KEj2iPnHhHkPHR1my/dPcp6tpXl2voCzSPu1BW9Fo0s/NxBXJTxbKNPYcL?=
 =?us-ascii?Q?2zgQ1yBENmVtz2YiFICSsfoKWD3iBTy9f9fl0mjX8meU/uKnscwgmIE+dKNJ?=
 =?us-ascii?Q?vCkZgWbQqtpbSXxSqkBNYPTuDghoeHb6G+78oEA7J7gjQobrtkK5ocvh1KQ/?=
 =?us-ascii?Q?+NhT8dqplXPvAoWd65Zg1nPWGUN9ksoCAj2V4OC638hfkrW+16WW1pxJUW1B?=
 =?us-ascii?Q?hVtKjcfhr22BfXhW9qUF/F1yJYCJa/VJp+T7XayShPXXco48tidguyw8coXi?=
 =?us-ascii?Q?oTgjHw9S3YsoMRdij8+kjEAk01rc7NcRHlolNSVLaL9/B39+CYqxZ+D39XVn?=
 =?us-ascii?Q?anUeoGpSFSvQziSwddbjnnFq+ME02E7iQjh2s1mIIA2Aeu3lTUlqIOdtlJ2z?=
 =?us-ascii?Q?Yvej+abV1jBNymO7pcPGHddHmsmI4ohr/771mATZ1iLvafV1syxIzZ7kDL+C?=
 =?us-ascii?Q?qonkWNEDq6qg25lFK3nD+u+VyPsr2atKX0hvAw4HkzVbD9rNKYSCa898TZGB?=
 =?us-ascii?Q?ly10hxABl5DojkEcxx5PknhsyR9c/fbIE2xB3mFVcrzMMpDq2lGfU/ZSpW32?=
 =?us-ascii?Q?kQKLd10n/Sfsb14ouJZeTZRo1gNqUNAmGyJf358E38tkh3qrBqaqg31CP2X0?=
 =?us-ascii?Q?9HK52Scp1lR1djNaypp63qtCTmyFn1LcDn9hVLJRUjc4C0e99tYbXFtT1fet?=
 =?us-ascii?Q?OvYr7LAVxMEiRDgpTjH480ccfgucN/bGJneiNjGdO9c5VTTKGyL2nsAxFvq9?=
 =?us-ascii?Q?M36Z6kBmwBvBNYQziBpw2pSYrt7Ms2ZPc9fW9wtfKkZtRmXDkaEfer7Kpsi+?=
 =?us-ascii?Q?P9OAWoqOrnvLzHrSogcdOXfW04lSkm3tiiOwmA9UyrOMNAEq9DQEZkeisQMm?=
 =?us-ascii?Q?Cf/yXev7WF00jG2nwS+Rpmh4TbJOIlqgMi2U01XWCr7sYXgzpZ22iwofVgBp?=
 =?us-ascii?Q?4sTAe2pWfNBlsiBpf7ujcoR7+jum9MUbpihEn+NM1+MZGBQEGNIbvPnqiLpT?=
 =?us-ascii?Q?xTSkpEg0W+bXKT3uRXVCixwTOc1KvhX+sK1POyt+nS0HEnO0fKMQWxYsemjN?=
 =?us-ascii?Q?zJfGkj1mEAFv0uDyBLGUbgQw8kWf+OuY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+SObt4h7LJ5nf/OC1RAIZRFmO8rpAdaTK7lbqK2a/bpXjOuDYVkNEFr2ZXy?=
 =?us-ascii?Q?0kBwRAroileop3D6urLH2nv/7nck0s/bfC0ZZdNLDMPHth95n/mqm5Nm0NQp?=
 =?us-ascii?Q?OeUhUYC7XB/8Sr5UVjEC3yW549PcC2c/7oCXvcnO47/uT+HQSOnxMKQOTcID?=
 =?us-ascii?Q?rkFIxuad3AwPJiurRiyuVskLwDgptzjXsSXKNBodsCNOct9cx4nGqTyMNYd4?=
 =?us-ascii?Q?U4RQkS0bIxX2W1y33Nu2fWwYDcYs16lciXx7ffVucjJnQAqVw61HFcvqHb07?=
 =?us-ascii?Q?pp8tSe+a62lw9OWTKYZiAjFL77UsB7y6624Dduu/4gdJREyi0ps8/hQa1VGd?=
 =?us-ascii?Q?Jd+8bDTkDJkdtNxFGCY7SJa223xZK1kQnNBk060vd00rAAUwqglvQgQPl8nZ?=
 =?us-ascii?Q?t1MRpaycPI0dC5kLw4h/g4mfJK+DlXE4bWR4Uap+BYo2SoN+hYG9cG3kikeq?=
 =?us-ascii?Q?tCp1yamKaY+DXciKM2Bi7pXgT+b104bM0sK+GbJ+iXnBQQXDpd5IDoMTqs/X?=
 =?us-ascii?Q?QZQjtqNSUG40/C39sQHCW4kMNozERjFSWbauR5e1sxLwcWdTFLsEedV7w64j?=
 =?us-ascii?Q?uy6IJu2PtXrBOwVGRCeQSP1yM/s4zGc1DvH/Yb9MAV5CY5HWbghwU6uvwEOx?=
 =?us-ascii?Q?CzCxrcQvtAijNO7Wd/ghsW+d/ZddVEvvd187TWzi9bvHFB0F3ebhIGybxKoA?=
 =?us-ascii?Q?jYRTt8lW/119ujkCJZE9fXxwIidrfThV7VZck56jmi/jRBs7J7TVmjcw03sj?=
 =?us-ascii?Q?3CALosIC1vHgeALkzZx1suElMnWUn1IHmJ9cyhDdNb6bQv96wrkIn3Yi30VT?=
 =?us-ascii?Q?dfm33uH36AdzUEiB8M7x49ztEIclR5Euj8sdc5TrctzncMmefZtrFNmU2yeA?=
 =?us-ascii?Q?CllzowBXHrblaLpLP4hVUQq+cOFYuWNvi6ZggCIiKaiQC9jxHGMxcgQcnzoO?=
 =?us-ascii?Q?1TL24dHyMpMnDqipaWeoFDfpX/ExgEGJYkuTCBdfjFmuY0rGi8bNRsqLvCBs?=
 =?us-ascii?Q?Ua0e1f6K1ydzwhRT0QbaZDcLSvq3YMpADTkuBMkZh5yb7fJF9MmogMHVMfJk?=
 =?us-ascii?Q?WPeDiamuIHA+ODRloHuekzx7l3vjQ859yA7S4ejR5sn6XPM7XCZ6G2K568cJ?=
 =?us-ascii?Q?1YTjo/C554+HCWVJJHsj20RXHen/IGITahWAkxhqGjNJArKlovhekyUdfpDs?=
 =?us-ascii?Q?97tAJm+8+3l9/jSSVez6+vht/z4iPj7Alm0UAUwph16rPMuo6z2hv8G825tX?=
 =?us-ascii?Q?1i8zQ5K5db2vJg2uwvNRdEgt1etjvEVG1HmfoNqt5YhKk4IqLtsGwj6lhpnd?=
 =?us-ascii?Q?jHase8bdubwcx23EnHYWnbK7xzwWoM1Luj+LYs77kPF/eqRyK/qRywCaNfyY?=
 =?us-ascii?Q?wXxu6jca9wxHpYygRaNHPJM0XobCaNB2OwCLrbDlKzMBU39LlVx7Y32Y6XBN?=
 =?us-ascii?Q?1BdSOYPGhViCwX0fKQuMQsh2so8IJgMEltvHV7kc8W+v4g4qM5HDBZ1csuW6?=
 =?us-ascii?Q?tnH1Zk3Z48PlHLen/xxn5PXWyYxFDp6DtWx9a6CLNChMzg1jfcpKJ/o0wnwA?=
 =?us-ascii?Q?wLiMb+308AqinoemJCFg3j0CLhuaoGWew+tWljUmkb45I5Ixx5O3padyAxx2?=
 =?us-ascii?Q?Ildjtx2Y0ZY+wh4rlFfafKM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875dd6d2-eab5-4774-8f2b-08dd5d0654a8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:26:33.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE4y7PtqqRjrgM6OZjJuDwCr9Ie7mMoFPcvoW6wQkGXs2kuiC5Djkf/lT4dLj/iStcd2hCXLZ0NMDD2++4PqNtdK67XAesXz6fcj/nzT/OIMsj6Ip6IbfJmEQT9Fc0mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6864



On Wed, 5 Mar 2025, Robin Murphy wrote:

> Hi all,
>
> This is part of something I'm working towards, but I figure it stands
> up on its own enough to be worth getting out early. Compile-tested
> only, but it's straightforward enough that I'm confident.
>
> Cheers,
> Robin.

I ran a very quick test on Ampere AmpereOne and everything seemed to work
as expected.

Cheers, Ilkka

> Robin Murphy (3):
>  perf/arm_cspmu: Move register definitons to header
>  perf/arm_cspmu: Generalise event filtering
>  perf/arm_cspmu: Add PMEVFILT2R support
>
> drivers/perf/arm_cspmu/ampere_cspmu.c | 32 ++++-------
> drivers/perf/arm_cspmu/arm_cspmu.c    | 81 ++++++---------------------
> drivers/perf/arm_cspmu/arm_cspmu.h    | 57 +++++++++++++++++--
> drivers/perf/arm_cspmu/nvidia_cspmu.c | 21 ++++++-
> 4 files changed, 100 insertions(+), 91 deletions(-)
>
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
>
