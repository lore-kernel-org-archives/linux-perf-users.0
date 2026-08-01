Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4239D6DD;
	Sat,  1 Aug 2026 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785550624; cv=fail; b=NyCx15b6YHsIdwCv/Ms4ZcEkppgyW3eru6RTwKrTO/WEZ8c+u+dcyz/F2i8fSvMeM/XGCUVZsQmRs049leZ/8O2ovRzhTFdt/So5KRXhWpKnFW+lUaiXu8wtVFQo2vxQHZT69go1FhqFvkMX1jkAGJvNm+g/C/qeH7R4aQVQs/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785550624; c=relaxed/simple;
	bh=0ff9yF5cYWzUiW5ZvvNnCTGvlaWXoJH/pUSwRiFwRbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jyzeszoHilCCC6SustBkO7l90xECqX4noLH8duCL0STx9vnzOqrUbJ3QOGdwVGygZKWYSc3JVSo2PwYwd5HjP61h+GSivJ1Nx8QXY5kd1ji5YIhUnWkDpeMg9xlwugeX8YWK4fpirT6qt1SW0cJ1mOy0BqhrdQgzTBHBc0lnzOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqIZkPbv; arc=fail smtp.client-ip=52.101.57.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqIZkPbv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoN9ZFOghwNIELN8EgoLrgE+k/0C/9TFR+eTPBCVctciuZxGrSEjTm/DhSsa9h5Q53zDBVEkS8WVHlpY04tX034+JyeVJskLQO8c+GdTvOGlcZjNImAmY2sXh/Ym+vrVM7XqSpEPw6FG5EiWR4M5iEKG/6HuTjey+9Bn5qt6zi+8SauR5V7u4XZP4nIk/bKFXjNUt32fVtBSBnV4zpHLZvyD8vRN6xuQ7kZuW6qBC6jWxWDJmJf/uFGuVDRg8pnYR9nB/M5qtPiukfG4ePM0+Oszj5o3Errnpo4XNGSsPrEq1oPiTMA0uLIdpseFKK6zNx3Pr2JzxcNEEpmCp5ww6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voi7sKIo11kENHtkZqMxE+k2eKCumvna/s1k1axqSoU=;
 b=qgsofVZ3XNP5RGnuGIIQiDs1RUb4O55ncaVDdNFvbmxQnMtffYYiVd4DitNGsB8om2bR0FehNS/GhD/sxoroHDTo9U92crwhSphKvSIaH86nmFK/pqd5NN4y8gPR0E951qxZL4nbv0gmVU+VxpkydTD9qjHJrcaS078DHDS3mW4ZgwmVxfbJBIkvTSFceJCdez6YhXE/3e7nRRA4Z/FCw+cm9UFJQHYik7mTVw3UFuIZUzFlstTu0rVrYZCw2y8jybbZzIw635wlu32IahdN/qN9Z17FEeFVVFmAVwHiRXr0uPzFLCQ6mz6fXLyH4qAB9bMCKDwQlvpUoSOAyfzi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voi7sKIo11kENHtkZqMxE+k2eKCumvna/s1k1axqSoU=;
 b=eqIZkPbvFTedDNgEDzZz0drhjKhKsXCJ1+E7hxVDL4kFJadHbN+9DhpaI3CDGL3/Oi36GN/VDj+qK4Ihl+EgIKP9y2RdmU/YkPve2VY+fOQVxr4hl09s7xmcAfwQZMAC1TjM+l+BEzry+B5yHt+u3YRmJKOzXlAtK0RtvP9m+yOUk6b4rszz2gGIK9lGtxpCfvpOpYh4eaBZe1Cjd7VKbSiz8hJo3gKE7iZgeKjEfCM8GGt2bZvBS9cQoJ6xESTcNTByKFTcvjvxXM85Q3VMGGhjvC+N99w8Yzua21uJcgWF2OSgJm1L5wWsu5ef8Zy971nH/Kx7YuiazzyxtbSS5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 02:16:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 02:16:56 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 31 Jul 2026 22:13:25 -0400
Subject: [PATCH RFC 02/14] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-remove-pg_private-v1-2-142c97ba3562@nvidia.com>
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
In-Reply-To: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-perf-users@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: IA4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b43322-1e82-45e2-1366-08deef72f5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	u5AcEjQXoqybhCUBd4RiVhmX6OnmHQIG0l661tbSmlK/gQB/JA/iZoPQKpDbkWWYFDj4GFY7TL0xbPja2Cq29Yayp2hpO8sBPk95b8C0f6gJBcwKohJriVEePjNyZ/3hQRUASMbdiEqMCm17xxVeKgLT1VqBeSubk4nn8v+eIQKW9+k9yzb+BJtvZ8lq6RqzDtX5WyTf5EP34EllNR41cnpuGzkAU/X3h1xPjDX5EPjNauwYh24IvZ3FqIHU8kf7WiuYsC+VPpkfG5KGseYoNxOmFpQY4jnX/HKArH1SPQf5tUgZQ9eSHKWNBaaNbqvvC2kwuEArWCv6XfiK8Uv50DFnnuSPPa3r4szP8VM0fVM51TuaQ7ndj5FWXumOLCIeosH4EivbBS3HzqFhZw7zogewafiKgy0F/AigGdYi6bodsU7fTBMP1aPmvCjNVOPMV3Fh7EfGtz1VGqoU2LsH6AtvL40Mt+eP2QLCKvfVP6UcObrzhqwNEUDj19juWVW1fNSHfMu/P03BCbwtzWmajUX5Ad58bE7cyn2jtG6BPzr7EXtDJKHblNWLo7Sdtg7XTeFtOuyUeHsTBdBCYzuFsWP37awbH6eLTyfjzrvo70WTX45Bl4Bm0xyKGfdKSVgSCD7WO7f+rkpI/+Yv4v1KtrwKPB2dxvsJOT9F2rzlbgzIDA9m9n6WjLXji9ZdOJmw5AqmneEEih0+KQthRPzlEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTI2ckp1V3ZCU3ZhV09EWkxaL25lZVYxdFZ2Vk5rOUlZVzdVSGIrdWU0TlYr?=
 =?utf-8?B?S3RZM2dLWGEwYTZ4Z1lIeUFiWmhVNFk3dGI0bnNCOGkydnFSbzZ1M0tnQ05X?=
 =?utf-8?B?VmcxQytnUlhLWU05TjN4Q0VyWHA2L1Q1dmRHZVhBQXU0QWovVE9GNExscXhm?=
 =?utf-8?B?S3RURWNhMUFHZnlGNGtNSStzTHJHSXAya1BpdzhYRURFOFpBcDJhc1F2ZzNF?=
 =?utf-8?B?TmFhVFVWRGNBNk9ZTzBvUU1hL3h6L0pKSHBIWE5SR0F4Sjl4Wld4ZStVTmRG?=
 =?utf-8?B?MGtIWXhac2xySzZNL21wRzJwa2Uzbk5DUEMxbGdnaFJEZmNkaUl5Vy9BYXpI?=
 =?utf-8?B?UmRCTGNxR0ZlZGlmcDRUV3FPcWpyTEJINmRONEZWMndROFNNU3JWdEljbGlM?=
 =?utf-8?B?RXpmSlRDR2l6cHRJUjVwbk5JZHNWTk05bG9zMGZFa2RxM2l3ZVp6ZVVYVE93?=
 =?utf-8?B?WU0rK0NVRHhKZUJTbDl4SWs0S0JEdmc2cy9RREtWcWN2dUlPMzVPb3JxQW9j?=
 =?utf-8?B?aGtWNmVmYSs0dUsvdUJobE9nK09PM0JDVWV6Z2lFRkhJY3FYejF4ZEk4UFI3?=
 =?utf-8?B?NmxJTjRybGxOaCs0Q1hJQjBQbEFxOG5FQ2tvdGttanR6TU9ZZ3NTeHF4cVp2?=
 =?utf-8?B?T1ZMQU9IWWpYWDQzbWhpaWkxazl3Q1BUQUJxSTVxLy9rY1FES0UwS1NXd0lN?=
 =?utf-8?B?TjYyaDI5V0tSM1ZRbm5pRWk3WWZZWGZkcnZYK1JYQ2dqUjMzNGxsNlVYdE54?=
 =?utf-8?B?RnhuckR5WWlHYkk5ODdaS055UDJnV1lrYis2Q2h4T3o0aXRGWkl1M3QyQ296?=
 =?utf-8?B?Z0RhYmdtNTNxSXlFNXh2bVllNlNOMVNsemRUL1JPZDk4dEJ2Z09LSENob01o?=
 =?utf-8?B?bjhUQjU5d2FITkZPcDRwTWt6L1RzUW13K1g0OU9oVW16aDYvR21XRmZ5RUpl?=
 =?utf-8?B?Wjd5YjdLZ0lNdW9EY2tOSWt1ZUNTU3M3L1NZMmFhYi8vZTlJZnlIQ2lGRHB5?=
 =?utf-8?B?MTJka1RhVVZ2UXhNckhoSHRYaW5ud1JIa1lNOXAwckpqSkNnUHhFS2FhTGho?=
 =?utf-8?B?dmZPdGVpdFlVb1JqSFhpV2wzTlBEV2dnK1RqditoSW5DY1JReEUrVGhVZHk1?=
 =?utf-8?B?R3lnbU0wM1E3Z2dkdTFSbU4wTUFnclJIdDNqVzlKN1pxc3ExTktPWU9RbVhQ?=
 =?utf-8?B?bFkraERWR0gweWRqb3BKVVlqWm5MVVM4ckluZFRXMHQ4d0dvSWhvNVhBQVdP?=
 =?utf-8?B?V21pZzdNeUNrMklPSnpQcnllT1RBbHp4b2xkTml6dVJ6dWwrYVdFVFkrSzNs?=
 =?utf-8?B?dWhUTm50dndOUXlzakpZRUlTMDZ2czRoWlYycGEyaFZvVVV4d1kwMU5qd1do?=
 =?utf-8?B?akN5RXZrZjg3VnZmVlV0YVBiUkJrMTg2R3d3bXJzS0tySmJWTDUwRzhXdm1w?=
 =?utf-8?B?NmkvTmt4QlpBcTJjM0hnUkNJMUlzb3lyLzVma2dpcG4yYjhaQ0gydFBrbHdv?=
 =?utf-8?B?YzRDdDhjcUxyS0dqSU1UMmVWQW1kNmluVElRRUJPUmtGNnVUWUhRL0FsTE1m?=
 =?utf-8?B?ZVJKK3Y1ZnNvSHBDNUU1MlpkcHVCK29jdGpTcE1ZS0QyTG1ROHE2aTM0N1ZO?=
 =?utf-8?B?eGpWcXRjcjg4bmEwNWJ5NXdTbnJ6Z01DdUwvTXdQa2xrZHJreFFLajFuRkVy?=
 =?utf-8?B?RUF3QXUyMEVGOWxsano4SGp0aHg3WGlsc1NlaXFCVUtYR0ZIa1drVHJSRWp6?=
 =?utf-8?B?NlpOZEprK3VNVm9PR2hGUnBPRVAwRGhkczFLK2dQWFJYbTRXNnFrZWtuTEZx?=
 =?utf-8?B?TnZjak9rL0JITmNwcFZnWXdBejZUZThJcFlveHF2VXI5NmhJdFFWYmpsNFhL?=
 =?utf-8?B?MGUvSi83UkVaTUJLQ0hJZmRONUJqcTNNK1VPbzEwOTlnYVZIZ1BuTGFSRHlB?=
 =?utf-8?B?bFcyQlZyOTNRb3pqdENkSWJUN3I1ZXlZVXkrUTAzUFVpUjd6ZHV3clhPcVVY?=
 =?utf-8?B?UlJmTUNxa3h5R1RhaDZWOW4xYnRtSm9CRlV3YUFkZ2FLTjc5NVdNVUp0RXU4?=
 =?utf-8?B?Y1lzN0MxQTU5MFRKNUhwVTBkcUtuajFlTGFZWVlFZWNiSE9yTzVwdlFLUEk2?=
 =?utf-8?B?VDhud1UxY3pZRlBVMktTeDlxbjRlUnpvYVIyL0lGQ25KZnlCN3BCZklTWmRJ?=
 =?utf-8?B?UzludUp2aW03R2JRMGVTblZlanMzamd3RnQrMitYZHhqZVZWUW96S0packhi?=
 =?utf-8?B?cnNJekFveWx0UTlTejR4bk9Gd3FVejN6WG41M2FvODBrZytrRVZVZk56Y3Ny?=
 =?utf-8?Q?haraJ71h/gC12+U7Ku?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b43322-1e82-45e2-1366-08deef72f5f1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 02:16:56.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhEc+UP1lNmROnNWpeRSfRNRrYg/PtjsV2tXV2R8mqUs7/koN1o5wgAhM5pXSa41
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

A high-order AUX page sets PG_private on its first page and stores the
order in first_page->private. Stop using PG_private and check
first_page->private for AUX page order only ring buffer and its users.

It prepares for a future commit that remove PG_private.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/intel/bts.c | 3 ---
 arch/x86/events/intel/pt.c  | 6 ++----
 kernel/events/ring_buffer.c | 7 +++----
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index cbac54cb3a9ec..5849392cf26d5 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -66,9 +66,6 @@ static struct pmu bts_pmu;
 
 static int buf_nr_pages(struct page *page)
 {
-	if (!PagePrivate(page))
-		return 1;
-
 	return 1 << page_private(page);
 }
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b5726b50e77db..29d8b4a3560cd 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -774,8 +774,7 @@ static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
 	struct page *p;
 
 	p = virt_to_page(buf->data_pages[buf->nr_pages]);
-	if (PagePrivate(p))
-		order = page_private(p);
+	order = page_private(p);
 
 	if (topa_table_full(topa)) {
 		topa = topa_alloc(cpu, gfp);
@@ -1289,8 +1288,7 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
 	if (!intel_pt_validate_hw_cap(PT_CAP_single_range_output))
 		goto out;
 
-	if (PagePrivate(p))
-		order = page_private(p);
+	order = page_private(p);
 
 	if (1 << order != nr_pages)
 		goto out;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 9fe92161715e0..061b5cb222266 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -630,11 +630,10 @@ static struct page *rb_alloc_aux_page(int node, int order)
 		/*
 		 * Communicate the allocation size to the driver:
 		 * if we managed to secure a high-order allocation,
-		 * set its first page's private to this order;
-		 * !PagePrivate(page) means it's just a normal page.
+		 * set its first page's private to this order, otherwise page's
+		 * private remains zero.
 		 */
 		split_page(page, order);
-		SetPagePrivate(page);
 		set_page_private(page, order);
 	}
 
@@ -645,7 +644,7 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 {
 	struct page *page = virt_to_page(rb->aux_pages[idx]);
 
-	ClearPagePrivate(page);
+	set_page_private(page, 0);
 	__free_page(page);
 }
 

-- 
2.53.0

